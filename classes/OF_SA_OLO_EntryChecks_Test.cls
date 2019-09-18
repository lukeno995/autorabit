@isTest
public class OF_SA_OLO_EntryChecks_Test {
    
    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
		
		for(RecordType rt: rtypes)
    		RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
    
    // base
    public static testMethod void Metodo1(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();       
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
        
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        Test.stopTest(); 
        
    }
    
    // test codice operatore & codice ordine OLO
    public static testMethod void Metodo2(){
       
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		
        StatReq.CODICE_ORDINE_OF = 'Test';
		
        StatReq.CODICE_OPERATORE = 'TOT';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_OPERATORE = '';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_OPERATORE = 'TISS';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_OPERATORE = 'TI�';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_OPERATORE = 'TIS';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.CODICE_ORDINE_OLO = '';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_ORDINE_OLO = '�';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_ORDINE_OLO = 'TTTTTTTTTTTTTTTTTTT';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_ORDINE_OLO = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
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
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OLO_Response.Esito_element respTemp= stub.NotifyAggiornaStato(eoflst);
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
      
    }
    
    // test data notifica & id notifica
    public static testMethod void Metodo3(){
       
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		
        StatReq.DATA_NOTIFICA = '';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:0';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.DATA_NOTIFICA = '2017-06�01T18:30:15+01:00';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.ID_NOTIFICA = '';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.ID_NOTIFICA = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.ID_NOTIFICA = 'Test�';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.ID_NOTIFICA = 'Test';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
		
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
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OLO_Response.Esito_element respTemp= stub.NotifyAggiornaStato(eoflst);
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
            
    }
    
    // test azione 
    public static testMethod void Metodo4(){
       
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		
        StatReq.AZIONE = '';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.AZIONE = '1T';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.AZIONE = '�';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.AZIONE = 'T';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
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
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
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
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = StatReq.CODICE_OPERATORE;
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = StatReq.COGNOME_CLIENTE;
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = StatReq.codice_ordine_olo;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	//c.EOF_Contact__c = con.id;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();               
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OLO_Response.Esito_element respTemp= stub.NotifyAggiornaStato(eoflst);
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }

    // test azione = 1 & codice motivazione
    public static testMethod void Metodo6(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        
        StatReq.CODICE_MOTIVAZIONE = '';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_MOTIVAZIONE = 'TTTT';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_MOTIVAZIONE = '�';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_MOTIVAZIONE = 'T';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
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
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
        
    }

    // test azione = 1 & motivazione
    public static testMethod void Metodo7(){
       
        Map<String,String> RecordTypeMap = RecordType();

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = 'T';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        
        StatReq.MOTIVAZIONE = '';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.MOTIVAZIONE = '�';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.MOTIVAZIONE = 'T';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);

        StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
        
    }

    // test case non a sistema
    public static testMethod void Metodo8(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	//insert c;
        /**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        Test.stopTest(); 
        
    }

    // test azione = 0 & nome + cognome cliente
    public static testMethod void Metodo9(){
       
        Map<String,String> RecordTypeMap = RecordType();

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
		
        StatReq.NOME_CLIENTE = '';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.NOME_CLIENTE = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.NOME_CLIENTE = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.NOME_CLIENTE = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.COGNOME_CLIENTE = '';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.COGNOME_CLIENTE = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.COGNOME_CLIENTE = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.COGNOME_CLIENTE = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
        
    }
     
    // test azione = 1 & stato != Acquisito,Accettato,Sospeso
    public static testMethod void Metodo10(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Desospeso';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
    
    // test codice motivazione = � & azione = 0
    public static testMethod void Metodo11(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
    
    // test motivazione = � & azione = 0
    public static testMethod void Metodo12(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
        
    // test azione = 0 & recapito telefonico cliente 1/2
    public static testMethod void Metodo13(){
       
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
		
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'TestTestTestTestTestTest';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
		
        StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();        
    }
        
    // test azione = 0 & orario appuntamento & data prevista attivazione
    public static testMethod void Metodo14(){
       
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15z';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.ORARIO_APPUNTAMENTO = '';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.ORARIO_APPUNTAMENTO = '10:00:00z';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        
        StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();
    }
    
    // test nome cliente = � & azione = 1
    public static testMethod void Metodo15(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();        
    }
    
    // test cognome cliente = � & azione = 1
    public static testMethod void Metodo16(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();        
        
    }
   
	// test recapito telefonico cliente 1 = � & azione = 1
    public static testMethod void Metodo17(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();
        
    }
	 
	// test recapito telefonico cliente 2 = � & azione = 1
    public static testMethod void Metodo18(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();
        
    }
	 
	//test data prevista attivazione = � & azione = 1
    public static testMethod void Metodo19(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
        OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
        
    }
    
    // test orario appuntamento = � & azione = 1
    public static testMethod void Metodo20(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
    
    // test note = � & azione = 1
    public static testMethod void Metodo21(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
		OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }

    public static testMethod void Metodo22(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
        
        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
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
        
        OF_SA_OLO_EntryChecks.PORTAL_SyncChecksStatusUpdate(StatReq, TestDataFactory.ESLog[0]);
        //OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        Test.stopTest();
    }        
    /************************ START SyncChecksReschedule *********************************/
    
    // Test base per il metodo SyncChecksReschedule
    public static testMethod void MetodoR0(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
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
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }

    // test response from OM =0
    public static testMethod void MetodoR1(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        //OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        OF_SA_OLO_EntryChecks.PORTAL_SyncChecksReschedule(RR, TestDataFactory.ESLog[0]);
        Test.stopTest(); 
        
    }
    
    // test codice operatore
    public static testMethod void MetodoR2(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		 
        RR.CODICE_OPERATORE = '';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_OPERATORE = 'TISS';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_OPERATORE = 'TI�';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
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
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test codice ordine olo
    public static testMethod void MetodoR3(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		
        RR.CODICE_ORDINE_OLO = '';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_ORDINE_OLO = 'TestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_ORDINE_OLO = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
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
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test data notifica
    public static testMethod void MetodoR4(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		
        RR.DATA_NOTIFICA = '';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00z';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01�00';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
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
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
   
    // test id notifica
    public static testMethod void MetodoR5(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		
        RR.ID_NOTIFICA = '';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.ID_NOTIFICA = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestT';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.ID_NOTIFICA = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
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
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test nome cliente
    public static testMethod void MetodoR6(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		
        RR.NOME_CLIENTE = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.NOME_CLIENTE = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test Stato != Acquisito,Accettato,Sospeso
    public static testMethod void MetodoR7(){
    	
    	Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Bho';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test cognome cliente
    public static testMethod void MetodoR8(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		
        RR.COGNOME_CLIENTE = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.COGNOME_CLIENTE = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
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
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test recapito telefonico cliente 1
    public static testMethod void MetodoR9(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		
        RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
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
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test recapito telefonico cliente 2
    public static testMethod void MetodoR10(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
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
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
                
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test data prevista attivazione
    public static testMethod void MetodoR11(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
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
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15z';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11�15';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        
        RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    //test orario appuntamento
    public static testMethod void MetodoR12(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
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
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.ORARIO_APPUNTAMENTO = '10:00�00';
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.ORARIO_APPUNTAMENTO = '10:00:00';
                
        RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test codice motivazione
    public static testMethod void MetodoR13(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
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
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_MOTIVAZIONE = 'MMMM';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_MOTIVAZIONE = 'M�';
		OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_MOTIVAZIONE = 'M';
        
        RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test motivazione
    public static testMethod void MetodoR14(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
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
    	OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.MOTIVAZIONE = 'M�';
    	OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.MOTIVAZIONE = 'M';
        
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test note
    public static testMethod void MetodoR15(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/        
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }

    
    /************************ START SyncChecksActivation *********************************/
    
    //Testa il metodo SyncChecksActivation
    public static testMethod void MetodoA1(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest(); 
    }
    
    // test codice operatore & codice ordine olo
    public static testMethod void MetodoA2(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

        /**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_OPERATORE = '�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_OPERATORE = 'WNNN';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_OPERATORE = 'WN';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.CODICE_ORDINE_OLO = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_ORDINE_OLO = '�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_ORDINE_OLO = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest(); 
    }
    
    // test data notifica & id notifica
    public static testMethod void MetodoA3(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30�15+01:00';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:0';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.ID_NOTIFICA = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_NOTIFICA = '�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_NOTIFICA = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_NOTIFICA = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test nome referente & cognome referente
    public static testMethod void MetodoA4(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = '�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = '�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest(); 

    }
    
    // test telefono referente & email referente
    public static testMethod void MetodoA5(){
        
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789999999999999999999999999999999999999999999999999999999999';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test�.com';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
		OF_SA_GE_Utils.tmpl.Tempi_Parziali__c = string.valueof(datetime.now());        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest(); 
    }
    
    // test telefono referente on field & nome cliente & cognome cliente
    public static testMethod void MetodoA6(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.NOME_CLIENTE = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_CLIENTE = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_CLIENTE = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.COGNOME_CLIENTE = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_CLIENTE = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_CLIENTE = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_CLIENTE = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test recapito telefonico cliente 1 & 2
    public static testMethod void MetodoA7(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test data prevista attivazione & orario appuntamento
    public static testMethod void MetodoA8(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15z';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11�15';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.ORARIO_APPUNTAMENTO = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00z';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ORARIO_APPUNTAMENTO = '10:00�00';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test codice progetto speciale & promozione
    public static testMethod void MetodoA9(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.PROMOZIONE = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.PROMOZIONE = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.PROMOZIONE = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test cluster promozione & note
    public static testMethod void MetodoA10(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		
        ActivationReq.CLUSTER_PROMOZIONE = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CLUSTER_PROMOZIONE = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CLUSTER_PROMOZIONE = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.NOTE = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOTE = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test id building & scala palazzina
    public static testMethod void MetodoA11(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		
        
        ActivationReq.ID_BUILDING = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_BUILDING = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_BUILDING = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_BUILDING = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.SCALA_PALAZZINA = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.SCALA_PALAZZINA = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.SCALA_PALAZZINA = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test numero telefonico principale linea & recapito test linea
    public static testMethod void MetodoA12(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		
        
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.RECAPITO_TEST_LINEA = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test identificativo del pop & profilo
    public static testMethod void MetodoA13(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		
        ActivationReq.IDENTIFICATIVO_DEL_POP = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'TestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.PROFILO = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.PROFILO = 'TestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.PROFILO = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.PROFILO = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest(); 
    }
    
    //test informazioni logistica apparati
    public static testMethod void MetodoA14(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = '';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test tipologia apparato vuoto
    public static testMethod void MetodoA15(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test tipologia apparato > 100
    public static testMethod void MetodoA16(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    //Stato != Acquisito,Accettato,Sospeso
    public static testMethod void MetodoA17(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
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
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = ActivationReq.CODICE_OPERATORE;
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       
        /**Account Business**/       
        Account acc = new Account();
        acc.name = ActivationReq.COGNOME_CLIENTE;
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
        /**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Codice_Ordine_OLO__c = 'aaa';//ActivationReq.codice_ordine_olo;
    	//c.EOF_Contact__c = con.id;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        /**End Case**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest(); 
    }
    
    // test tipologia apparato = �
    public static testMethod void MetodoA18(){
       
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }
    
    // test password apparato vuoto
    public static testMethod void MetodoA19(){
       
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
        OLO_APPARATO.PASSWORD_APPARATO = '';
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }
    
    // test password apparato > 50
    public static testMethod void MetodoA20(){
       
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test password apparato = �
    public static testMethod void MetodoA21(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test azione apparato vuoto
    public static testMethod void MetodoA22(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test azione apparato > 1
    public static testMethod void MetodoA23(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test azione apparato = �
    public static testMethod void MetodoA24(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test kit consegna vlan vuoto
    public static testMethod void MetodoA25(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = '';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test kit consegna vlan > 10
    public static testMethod void MetodoA26(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'TTTTTTTTTTT';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test kit consegna vlan = �
    public static testMethod void MetodoA27(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T�';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test user vlan vuoto
    public static testMethod void MetodoA28(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = '';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test user vlan > 4
    public static testMethod void MetodoA29(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'TTTTT';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test user vlan = �
    public static testMethod void MetodoA30(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T�';
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
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test service vlan vuoto
    public static testMethod void MetodoA31(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = '';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

    // test service vlan > 4
    public static testMethod void MetodoA32(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'TTTTT';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

    // test service vlan = �
    public static testMethod void MetodoA33(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T�';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test profilo vlan vuoto
    public static testMethod void MetodoA34(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = '';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test profilo vlan > 4
    public static testMethod void MetodoA35(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'TTTTT';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test profilo vlan = �
    public static testMethod void MetodoA36(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T�';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test customer vlan > 4
    public static testMethod void MetodoA37(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'TTTTT';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test customer vlan = �
    public static testMethod void MetodoA38(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T�';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();       
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test modello di servizio vlan > 20
    public static testMethod void MetodoA39(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'TTTTTTTTTTTTTTTTTTTTTT';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test modello di servizio vlan = �
    public static testMethod void MetodoA40(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T�';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test informazioni vlan = �
    public static testMethod void MetodoA41(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T�';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test nome servizio vuoto
    public static testMethod void MetodoA42(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test nome servizio > 50
    public static testMethod void MetodoA43(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test nome servizio = �
    public static testMethod void MetodoA44(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test informazioni servizio vuoto
    public static testMethod void MetodoA45(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test informazioni servizio > 2
    public static testMethod void MetodoA46(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test informazioni servizio = �
    public static testMethod void MetodoA47(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

    public static testMethod void MetodoA48(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','PO - SA - FiberRequest',null);
    	
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/
       	
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/

        
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
		ActivationReq.CODICE_ORDINE_OLO = '02112016_37xy';
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //OF_SA_OLO_EntryChecks.PORTAL_SyncChecksActivation(ActivationReq, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
   
    /************************ START SyncChecksDeactivation *********************************/
	
    // base
	public static testMethod void MetodoD1(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
              
    }
    
    // test codice operatore & codice ordine olo
    public static testMethod void MetodoD2(){
       
        Map<String,String> RecordTypeMap = RecordType();

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = '';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.CODICE_OPERATORE = 'WNWN';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.CODICE_OPERATORE = 'WN�';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.CODICE_OPERATORE = 'WN';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        
        Deactiv.CODICE_ORDINE_OLO = '';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.CODICE_ORDINE_OLO = 'TestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.CODICE_ORDINE_OLO = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.CODICE_ORDINE_OLO = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        
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
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();       
    }
    
    // test data notifica & id notifica
    public static testMethod void MetodoD3(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		
        Deactiv.DATA_NOTIFICA = '';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00z';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.DATA_NOTIFICA = '2017-06-01T18�30:15+01:00';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        
        Deactiv.ID_NOTIFICA = '';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.ID_NOTIFICA = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.ID_NOTIFICA = 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.ID_NOTIFICA = 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        
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
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
        
    }
    
    // test id risorsa
    public static testMethod void MetodoD4(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
        Deactiv.NOME_CLIENTE = 'Test';
        Deactiv.COGNOME_CLIENTE=  'Test';        
        Deactiv.ID_RISORSA= '';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.ID_RISORSA= 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.ID_RISORSA= 'Test�';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.ID_RISORSA= 'Test';
		OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        

		//OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        
        
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
        
    }
    
    // test note = �
    public static testMethod void MetodoD5(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
        
    }
    
    // test apparato != null & tipologia apparato vuoto
    public static testMethod void MetodoD6(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
        
    }
    
    // test apparato != null & tipologia apparato > 100
    public static testMethod void MetodoD7(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
        
    }
    
    // test apparato != null & id apparato vuoto
    public static testMethod void MetodoD8(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
        
    }
    
    // test apparato != null & id apparato > 50
    public static testMethod void MetodoD9(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
        
    }

    // test tipologia apparato != null & cognome cliente > 70
	public static testMethod void MetodoD10(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }
    
    // test tipologia apparato != null & cognome cliente = �
	public static testMethod void MetodoD11(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    

    // test tipologia apparato != null & recapito telefonico cliente 1 vuoto
	public static testMethod void MetodoD12(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    
    
    // test tipologia apparato != null & recapito telefonico cliente 1 > 20
	public static testMethod void MetodoD13(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    
    
    // test tipologia apparato != null & recapito telefonico cliente 1 = �
	public static testMethod void MetodoD14(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    
    
    // test tipologia apparato != null & recapito telefonico cliente 2 > 20
	public static testMethod void MetodoD15(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    
    
    // test tipologia apparato != null & recapito telefonico cliente 2 = �
	public static testMethod void MetodoD16(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    

    // test nome cliente
    public static testMethod void MetodoD17(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

    	/**Account**/
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        /**End Account**/       

        /**Account Business**/    
        Account acc = new Account();
        acc.name = 'test';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        /**End Account Business**/
        
       	/**Case**/
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	/**End Case**/
        
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
		//OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        //Deactiv.NOME_CLIENTE = 'Test�';
		//OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.NOME_CLIENTE = 'Test';
		//OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        
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
        OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
        
    }

    public static testMethod void MetodoD18(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Cessazione_OPENSTREAM','PO - SA - FiberRequest',null);
        Map<String,String> RecordTypeMap = RecordType();
        
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
        
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_OLO_EntryChecks.PORTAL_SyncChecksDeactivation(Deactiv, testDataFactory.ESlog[1]);
        test.stopTest();
        
    }
    
}
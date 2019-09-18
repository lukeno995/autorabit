@isTest
public with sharing class OF_TT_EntryChecks_TEST {

	public static Account accOlo;
	public static Account acc;
	public static Case c;
	public static OF_TT_WS_TroubleTicketRequest.TroubleTicket tt;
	public static User testUser;
	public static Group bo;
	public static Profile p;
	public static Asset a;
	public static Asset a1;
	public static Asset a2;
	public static Asset a3;
	public static Asset a4;
	public static EOF_Notify__c nGPON;
	public static EOF_Notify__c n;
	public static OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse rttr;
	public static String s;
	public static String y ='Y'; //EC
	public static String no ='N';//EC
	public static EOF_EAI_Service_Log__c eaiLog;
	// public Id rtId;


	public static OF_TT_WS_TroubleTicketRequest.TroubleTicket preTestCheckSync(String assetStatus) {
		OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
		tibco.OF_Tibco_ID__c=userinfo.getuserId();
		tibco.name='Tibco UserID';
		insert tibco;
		p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];

		testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing',
							LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');

		insert testUser;

		bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];

		String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
		accOLO = new Account();
		accOLO.Name = 'WIND';
		accOLO.EOF_Codice_Operatore__c = 'WN';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTYpeId = oloAccountRecordTypeId;

		insert accOLO;

		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
		acc = new Account();
		acc.Name = 'Test Account';
		acc.Phone = '0000';
		acc.EOF_Phone_2__c = '0000';
		acc.EOF_Provincia__c = 'Milano';
		acc.EOF_Comune__c = 'Milano';
		acc.EOF_Indirizzo__c = 'Piazzale Gorini';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Particella_Toponomastica__c = '123';
		acc.EOF_Numero_Civico__c = '7';

		insert acc;

		// Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo'];
		a = new Asset();
		a.Name= 'Test Asset';
		a.Status = assetStatus;
		a.EOF_ID_Risorsa__c = 'test';
		a.AccountId = accOLO.Id;
		a.EOF_Sla_Premium_Assurance__c = 'Y';
		insert a;

		//-------Case Creation-------------
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
		c = new Case();
		c.EOF_Account_OLO__c = accOLO.Id;
		c.Subject = 'Richiesta Risoluzione Guasto';
		c.EOF_ID_Risorsa__c = 'test';
		c.EOF_Codice_Ordine_OLO__c = '02112016_37';
		c.EOF_Data_Prevista_Attivazione__c = system.today();
		c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c.Status = null;
		c.EOF_Fase__c = null;
		c.Type = '1';
		c.EOF_Tipologia_Servizio__c = 'test';
		c.EOF_Codice_Operatore_WS__c = 'WN';
		c.EOF_SLA_Premium_Assurance__c ='N';
		c.Account = acc;
		c.EOF_Identificativo_del_POP__c = 'PG_01';
		c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c.EOF_Numero_Civico_WS__c = '7';
		c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
		c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
		c.EOF_Recapito_Test_Linea__c = '111';
		c.EOF_Tipologia_Apparato__c = 'test';
		c.OwnerId = testUser.Id;
		c.RecordTypeId = CaseRecordTypeId;
		c.EOF_Id_Notifica__c = 'test_01';
		c.Origin = 'Web';
		c.Priority = 'Medium';
		c.EOF_GPON_Vincolante__c = 'Y';
		c.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c.EOF_Codice_comunicazione_olo__c='testalo';
		c.EOF_Categoria_Guasto__C='Disservizio';
		c.EOF_Data_Max_Risoluzione_Ticket__c = System.now().addDays(1);
		c.EOF_Rischedulazione_Appuntamento__c = System.now().addDays(1);
		insert c;

		//-------------Trouble Ticket Creation----------------
		tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
		//tt.TIPO_COMUNICAZIONE = '2';
		//tt.CODICE_OPERATORE = 'WN';
		//tt.ID_NOTIFICA = 'test';
		tt.ID_RISORSA = 'test';
		tt.NOME_CLIENTE = 'Franco';
		tt.COGNOME_CLIENTE = 'Daje';
		tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
		tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
		tt.NOTE = 'xyz';
		tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
		tt.REFERENTE_DESOSPENSIONE = 'xyz';
		// tt.VERIFICA_APPARATO_CLIENTE = 'xyz';
		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
		tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
		tt.CAUSALE_DESOSPENSIONE='3';
		tt.CATEGORIA_GUASTO='0';
		tt.CAUSALE_APERTURA='4';

		//-------------Trouble Ticket Ends-----------------------

		String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
		nGPON = new EOF_Notify__c();
		nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
		nGPON.EOF_ID_Notifica__c = 'Test Id';
		nGPON.EOF_Stato_Richiesta__c = 'OK';
		nGPON.EOF_Codice_Operatore__c = 'VF';
		nGPON.EOF_Codice_comunicazione_olo__c='testalo';
		nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
		nGPON.EOF_Data_Notifica__c = system.now();
		nGPON.EOF_Note__c = 'Test Note';
		nGPON.EOF_Inviata__c = false;
		nGPON.Caso__c = c.id;
		nGPON.RecordTYpeId = NotifyRecordTypeId;

		insert nGPON;
		//-----insert EAI Service Log------

		String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
		eaiLog = new EOF_EAI_Service_Log__c();
		eaiLog.Caso__c  = c.Id;
		eaiLog.EOF_ID_Notifica__c = 'test_01';
		eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
		eaiLog.recordTypeId = eaiRecordType;
		insert eaiLog;
		return tt;
	}

	public static testmethod void testCheckSync_1() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Cessato');

		//Start test23
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		tt.tipo_comunicazione='';
		tt.note='';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CODICE_OPERATORE='';
		tt.TIPO_COMUNICAZIONE='Test';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CODICE_OPERATORE='Test';
		tt.CODICE_COMUNICAZIONE_OLO='';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CODICE_COMUNICAZIONE_OLO='test';
		tt.CATEGORIA_GUASTO='';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CATEGORIA_GUASTO='Test';
		tt.ID_NOTIFICA='';
		OF_TT_EntryChecks.checkSync(tt);

		tt.ID_NOTIFICA='Test';
		tt.ID_RISORSA='';
		OF_TT_EntryChecks.checkSync(tt);

		tt.ID_RISORSA='Test';
		tt.CATEGORIA_GUASTO='1';
		tt.TIPO_COMUNICAZIONE='9';
		tt.CAUSALE_RICHIESTA_ANNULLAMENTO='';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CAUSALE_RICHIESTA_ANNULLAMENTO='test';
		tt.TIPO_COMUNICAZIONE='6';
		tt.CAUSALE_DESOSPENSIONE='';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CAUSALE_DESOSPENSIONE='test';
		tt.TIPO_COMUNICAZIONE='1';
		tt.CAUSALE_APERTURA='';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CAUSALE_APERTURA='test';
		tt.TIPO_COMUNICAZIONE='3';
		OF_TT_EntryChecks.checkSync(tt);

		tt.TIPO_COMUNICAZIONE='1';
		tt.CODICE_COMUNICAZIONE_OLO='ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CODICE_COMUNICAZIONE_OLO='Test';
		tt.CATEGORIA_GUASTO='3';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CATEGORIA_GUASTO='1';
		tt.ID_NOTIFICA='ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
		OF_TT_EntryChecks.checkSync(tt);

		tt.ID_NOTIFICA='test';
		tt.ID_RISORSA='Testttttttttttttttttttttttttttttttttttttttttttttttt';
		OF_TT_EntryChecks.checkSync(tt);


		test.stopTest();
	}

	public static testmethod void testCheckSync_2() {

		addCustomSettings();
		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Cessato');

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		tt.note='';
		tt.CODICE_OPERATORE='Test';
		tt.CODICE_COMUNICAZIONE_OLO='test';
		tt.CATEGORIA_GUASTO='Test';
		tt.ID_NOTIFICA='Test';
		tt.ID_RISORSA='Test';
		tt.CATEGORIA_GUASTO='1';
		tt.CAUSALE_RICHIESTA_ANNULLAMENTO='test';
		tt.CAUSALE_DESOSPENSIONE='test';
		tt.TIPO_COMUNICAZIONE='1';
		tt.CAUSALE_APERTURA='test';

		tt.CODICE_OPERATORE = 'xyzqwe';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CODICE_OPERATORE = 'WN';
		//OF_TT_EntryChecks.portale = true;
		OF_TT_EntryChecks.checkSync(tt); // resp.esito = 0

		tt.TIPO_COMUNICAZIONE='6';
		tt.CODICE_COMUNICAZIONE_OLO = 'xyz';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
		tt.CODICE_OPERATORE = 'xyz';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CODICE_OPERATORE = 'WN';
		tt.CATEGORIA_GUASTO = '1';
		OF_TT_EntryChecks.checkSync(tt);

		tt.CATEGORIA_GUASTO = '0';
		tt.ID_RISORSA='xyz';
		OF_TT_EntryChecks.checkSync(tt);

		test.stopTest();
	}

	public static testmethod void testCheckSync_3() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Cessato');
		addCustomSettings();

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		tt.note='';
		tt.TIPO_COMUNICAZIONE='Test';
		tt.CODICE_OPERATORE='WN';
		tt.CODICE_COMUNICAZIONE_OLO='testalo';
		tt.CATEGORIA_GUASTO='Test';
		tt.ID_NOTIFICA='Test';
		tt.ID_RISORSA='test';
		tt.CATEGORIA_GUASTO='0';
		tt.CAUSALE_RICHIESTA_ANNULLAMENTO='test';
		tt.CAUSALE_DESOSPENSIONE='test';
		tt.TIPO_COMUNICAZIONE='6';
		tt.CAUSALE_APERTURA='test';

		OF_TT_EntryChecks.checkSync(tt);

		tt.TIPO_COMUNICAZIONE='9';
		OF_TT_EntryChecks.checkSync(tt);

		tt.TIPO_COMUNICAZIONE='8';
		OF_TT_EntryChecks.checkSync(tt);

		tt.TIPO_COMUNICAZIONE='11';
		OF_TT_EntryChecks.checkSync(tt);

		test.stopTest();
	}

	public static testmethod void testCheckSync_4() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Cessato');
		addCustomSettings();

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		tt.note='';
		tt.TIPO_COMUNICAZIONE='Test';
		tt.CODICE_OPERATORE='WN';
		tt.CODICE_COMUNICAZIONE_OLO='testalo';
		tt.CATEGORIA_GUASTO='Test';
		tt.ID_NOTIFICA='Test';
		tt.ID_RISORSA='test';
		tt.CATEGORIA_GUASTO='0';
		tt.CAUSALE_RICHIESTA_ANNULLAMENTO='test';
		tt.CAUSALE_DESOSPENSIONE='test';
		tt.TIPO_COMUNICAZIONE='12';
		tt.CAUSALE_APERTURA='test';

		OF_TT_EntryChecks.checkSync(tt);

		tt.TIPO_COMUNICAZIONE='20';
		OF_TT_EntryChecks.checkSync(tt);


		/*c.status='Richiesta Chiusura';
		   c.canModify__c=true;
		   c.EOF_collaudi_negativi__c=0;
		   c.EOF_Data_max_risoluzione_ticket__c=OF_TT_Utils.now().addDays(1);
		   //EC il test method test23 potrebbe fallire su questo update
		   try{
		   update c;
		   }
		   catch(Exception e){
		     System.debug('The following exception has occurred: ' + e.getMessage());
		   }
		   OF_TT_EntryChecks.checkSync(tt);*/

		test.stopTest();
	}

	public static testmethod void testCheckASync_1() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Cessato');
		addCustomSettings();

		test.startTest(); // TIPO_COMUNICAZIONE = 1 - Check sui campi
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		tt.TIPO_COMUNICAZIONE='1';

		tt.NOME_REFERENTE_TECNICO_OLO='';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		tt.TELEFONO_REFERENTE_TECNICO_OLO='';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
		tt.EMAIL_REFERENTE_TECNICO_OLO='';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
		tt.NOME_REFERENTE_TECNICO_OLO='01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		tt.TELEFONO_REFERENTE_TECNICO_OLO='01234567890123456789012345678901234567890123456789012345678901234567890123456789';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
		tt.EMAIL_REFERENTE_TECNICO_OLO='01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789';
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static testmethod void testCheckASync_2() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Cessato');
		addCustomSettings();

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		tt.TIPO_COMUNICAZIONE='1';
		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
		tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';

		OF_TT_EntryChecks.checkAsync(c, tt); // if (tech.isEmpty())

		tt.NOME_REFERENTE_TECNICO_OLO='012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		String techRt = Schema.SObjectType.contact.getRecordTypeInfosByName().get('Referente Tecnico OLO').getRecordTypeId();
		Contact ct = new Contact();
		ct.recordtypeid = techrt;
		ct.Phone = tt.TELEFONO_REFERENTE_TECNICO_OLO;
		ct.Email = tt.EMAIL_REFERENTE_TECNICO_OLO;
		ct.firstname = 'test';
		ct.LastName = tt.NOME_REFERENTE_TECNICO_OLO;
		insert ct;

		OF_TT_EntryChecks.checkAsync(c, tt);

		//OF_TT_EntryChecks.c.CA_Azienda__c = '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789';
		//OF_TT_EntryChecks.checkAsync(c, tt);

		tt.ID_RISORSA = 'qwerty';
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static testmethod void testCheckASync_3() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		tt.TIPO_COMUNICAZIONE='1';
		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
		tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';

		String techRt = Schema.SObjectType.contact.getRecordTypeInfosByName().get('Referente Tecnico OLO').getRecordTypeId();
		Contact ct = new Contact();
		ct.recordtypeid = techrt;
		ct.Phone = tt.TELEFONO_REFERENTE_TECNICO_OLO;
		ct.Email = tt.EMAIL_REFERENTE_TECNICO_OLO;
		ct.firstname = 'test';
		ct.LastName = tt.NOME_REFERENTE_TECNICO_OLO;
		insert ct;

		tt.ID_RISORSA = 'test';
		tt.COGNOME_CLIENTE = '';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.COGNOME_CLIENTE = '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789';
		tt.RECAPITO_TELEFONICO_CLIENTE_1 = '';
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static testmethod void testCheckASync_4() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		String techRt = Schema.SObjectType.contact.getRecordTypeInfosByName().get('Referente Tecnico OLO').getRecordTypeId();
		Contact ct = new Contact();
		ct.recordtypeid = techrt;
		ct.Phone = tt.TELEFONO_REFERENTE_TECNICO_OLO;
		ct.Email = tt.EMAIL_REFERENTE_TECNICO_OLO;
		ct.firstname = 'test';
		ct.LastName = tt.NOME_REFERENTE_TECNICO_OLO;
		insert ct;

		tt.TIPO_COMUNICAZIONE='1';
		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
		tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
		tt.ID_RISORSA = 'test';

		tt.COGNOME_CLIENTE = '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789';

		tt.RECAPITO_TELEFONICO_CLIENTE_1 = '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.COGNOME_CLIENTE = 'Bianchi';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
		OF_TT_EntryChecks.case_tmp_list = new List<Case>();
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static testmethod void testCheckASync_4_1() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		String techRt = Schema.SObjectType.contact.getRecordTypeInfosByName().get('Referente Tecnico OLO').getRecordTypeId();
		Contact ct = new Contact();
		ct.recordtypeid = techrt;
		ct.Phone = tt.TELEFONO_REFERENTE_TECNICO_OLO;
		ct.Email = tt.EMAIL_REFERENTE_TECNICO_OLO;
		ct.firstname = 'test';
		ct.LastName = tt.NOME_REFERENTE_TECNICO_OLO;
		insert ct;

		tt.TIPO_COMUNICAZIONE='1';
		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
		tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
		tt.ID_RISORSA = 'test';

		OF_TT_EntryChecks.case_tmp_list = new List<Case>();

		tt.COGNOME_CLIENTE = 'Bianchi';
		tt.NOME_CLIENTE = '';
		tt.RECAPITO_TELEFONICO_CLIENTE_1 = '123456wetw';
		tt.RECAPITO_TELEFONICO_CLIENTE_2 = '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789';
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static testmethod void testCheckASync_5() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		Test.setCreatedDate(a.Id, System.now().addDays(-11));
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		String techRt = Schema.SObjectType.contact.getRecordTypeInfosByName().get('Referente Tecnico OLO').getRecordTypeId();
		Contact ct = new Contact();
		ct.recordtypeid = techrt;
		ct.Phone = tt.TELEFONO_REFERENTE_TECNICO_OLO;
		ct.Email = tt.EMAIL_REFERENTE_TECNICO_OLO;
		ct.firstname = 'test';
		ct.LastName = tt.NOME_REFERENTE_TECNICO_OLO;
		insert ct;

		tt.TIPO_COMUNICAZIONE='1';
		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
		tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
		tt.ID_RISORSA = 'test';
		tt.COGNOME_CLIENTE = 'Bianchi';
		tt.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';

		OF_TT_EntryChecks.case_tmp_list = new List<Case>();
		tt.CATEGORIA_GUASTO = '2';
		OF_TT_EntryChecks.checkAsync(c, tt);

		OF_TT_EntryChecks.case_tmp_list.add(c);
		OF_TT_EntryChecks.checkAsync(c, tt);

		OF_TT_EntryChecks.case_tmp_list.clear();
		c.assetId = a.Id;
		update c;
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static testmethod void testCheckASync_6() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		tt.TIPO_COMUNICAZIONE='6';

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		tt.NOME_REFERENTE_TECNICO_OLO='';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		tt.TELEFONO_REFERENTE_TECNICO_OLO='';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
		tt.EMAIL_REFERENTE_TECNICO_OLO='';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
		tt.COGNOME_CLIENTE = '';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.COGNOME_CLIENTE = 'Bianchi';
		tt.RECAPITO_TELEFONICO_CLIENTE_1 = '';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
		tt.NOME_CLIENTE = 'Test';
		tt.COGNOME_CLIENTE = 'Account';
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static testmethod void testCheckASync_7() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		tt.TIPO_COMUNICAZIONE='6';
		tt.NOTE = 'abc';

		a.OF_GPON_Attestazione__c = 'test';
		update a;
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.DATA_ORA_DESOSPENSIONE = String.valueOf(System.now().addDays(-1));
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.DATA_ORA_DESOSPENSIONE = String.valueOf(System.now().addDays(1));
		tt.REFERENTE_DESOSPENSIONE = '';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.REFERENTE_DESOSPENSIONE = 'test';
		c.Status = 'Aperto';
		update c;
		OF_TT_EntryChecks.c = c;
		OF_TT_EntryChecks.checkAsync(c, tt);
		try {
			c.Status = 'Sospeso';
			update c;
			OF_TT_EntryChecks.checkAsync(c, tt);
		} catch (Exception e) {
			System.debug('Async7 sospeso');
		}

		test.stopTest();
	}

	public static testmethod void testCheckASync_8() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		tt.TIPO_COMUNICAZIONE='6';
		tt.NOTE = 'abc';
		tt.DATA_ORA_DESOSPENSIONE = String.valueOf(System.now().addDays(1));
		tt.REFERENTE_DESOSPENSIONE = 'test';

		a.OF_GPON_Attestazione__c = 'test';
		update a;

		c.Status = 'Sospeso';
		c.EOF_COmunicazioni_con_OLO__C='test';
		update c;

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
		try {
			OF_TT_EntryChecks.checkAsync(c, tt);

			tt.TIPO_COMUNICAZIONE='8';
			c.Status = 'Aperto';
			OF_TT_EntryChecks.c = c;
			update c;
			OF_TT_EntryChecks.checkAsync(c, tt);
		} catch (Exception e) {
			System.debug('Async8 aperto');
		}

		test.stopTest();
	}

	public static testmethod void testCheckASync_9() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		tt.TIPO_COMUNICAZIONE='8';
		tt.NOTE = 'abc';
		tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = String.valueOf(System.now().addDays(1));
		tt.DATA_ORA_DESOSPENSIONE = String.valueOf(System.now().addDays(1));
		tt.DATA_ORA_AUTORIPRISTINATO = String.valueOf(System.now().addDays(1));
		tt.REFERENTE_DESOSPENSIONE = 'test';
		c.Status = 'Sospeso';
		c.EOF_COmunicazioni_con_OLO__C='test';
		update c;

		//a.OF_GPON_Attestazione__c = 'test';
		//update a;

		c = [select Id,EOF_codice_Operatore_WS__c,EOF_categoria_guasto__c,EOF_ID_Risorsa__c,Status,
			 Eof_fase__c,EOF_Minuti_rimanenti_sospesi__c,EOF_Codice_Comunicazione_OLO__c,
			 EOF_Comunicazioni_con_OLO__c,EOF_Num_min_risoluzione_Ticket__c,EOF_Data_Max_Risoluzione_Ticket__c,
			 EOF_Secondi_Sospesi_allo_SLA__c, EOF_SLA_Premium_Assurance__c, EOF_Collaudi_Negativi__c,
			 EOF_Causale_Sospensione__c,EOF_Rischedulazione_Appuntamento__c,EOF_Account_OLO__c
			 from Case where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO];

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		OF_TT_EntryChecks.checkAsync(c, tt);

		c.EOF_COmunicazioni_con_OLO__C='';
		update c;
		OF_TT_EntryChecks.checkAsync(c, tt);

		c.Status = '';
		update c;
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.TIPO_COMUNICAZIONE='9';
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static testmethod void testCheckASync_10() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		tt.TIPO_COMUNICAZIONE='9';
		tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = String.valueOf(System.now().addDays(1));
		tt.NOTE = 'abc';
		tt.DATA_ORA_DESOSPENSIONE = String.valueOf(System.now().addDays(1));
		tt.REFERENTE_DESOSPENSIONE = 'test';
		c.Status = 'In Lavorazione';
		c.EOF_COmunicazioni_con_OLO__C='test';
		c.EOF_Collaudi_Negativi__c = 12;
		c.EOF_Minuti_rimanenti_sospesi__c = 15;
		update c;
		OF_TT_EntryChecks.c = c;

		//a.OF_GPON_Attestazione__c = 'test';
		//update a;

		c = [select Id,EOF_codice_Operatore_WS__c,EOF_categoria_guasto__c,EOF_ID_Risorsa__c,Status,
			 Eof_fase__c,EOF_Minuti_rimanenti_sospesi__c,EOF_Codice_Comunicazione_OLO__c,
			 EOF_Comunicazioni_con_OLO__c,EOF_Num_min_risoluzione_Ticket__c,EOF_Data_Max_Risoluzione_Ticket__c,
			 EOF_Secondi_Sospesi_allo_SLA__c, EOF_SLA_Premium_Assurance__c, EOF_Collaudi_Negativi__c,
			 EOF_Causale_Sospensione__c,EOF_Rischedulazione_Appuntamento__c,EOF_Account_OLO__c
			 from Case where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO];

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
		try {
			OF_TT_EntryChecks.checkAsync(c, tt);

			tt.NOTE = '';
			c.EOF_Rischedulazione_Appuntamento__c = null;
			c.EOF_COmunicazioni_con_OLO__C='';
			update c;
			OF_TT_EntryChecks.checkAsync(c, tt);
		} catch (DMLException e) {
			System.debug(e.getMessage());
		} catch (Exception e) {
			System.debug(e.getMessage());
		}

		test.stopTest();
	}

	public static testmethod void testCheckASync_11() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		tt.TIPO_COMUNICAZIONE='11';
		tt.NOTE = 'abc';
		tt.DATA_ORA_DESOSPENSIONE = String.valueOf(System.now().addDays(1));
		tt.REFERENTE_DESOSPENSIONE = 'test';
		c.Status = 'In Lavorazione';
		c.EOF_COmunicazioni_con_OLO__C='test';
		c.EOF_Collaudi_Negativi__c = 12;
		update c;
		OF_TT_EntryChecks.c = c;

		//a.OF_GPON_Attestazione__c = 'test';
		//update a;


		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		tt.INTERVENTO_CONGIUNTO = '';
		OF_TT_EntryChecks.checkAsync(c, tt);

		tt.INTERVENTO_CONGIUNTO = 'test';
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static testmethod void testCheckASync_11_1() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		tt.TIPO_COMUNICAZIONE='11';
		tt.NOTE = 'abc';
		tt.DATA_ORA_DESOSPENSIONE = String.valueOf(System.now().addDays(1));
		tt.REFERENTE_DESOSPENSIONE = 'test';
		c.Status = 'Richiesta Chiusura';
		c.EOF_COmunicazioni_con_OLO__C='test';
		c.EOF_Collaudi_Negativi__c = 12;
		tt.INTERVENTO_CONGIUNTO = 'test';
		update c;
		OF_TT_EntryChecks.c = c;

		//a.OF_GPON_Attestazione__c = 'test';
		//update a;


		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		OF_TT_EntryChecks.checkAsync(c, tt);

		c.EOF_Rischedulazione_Appuntamento__c = null;
		c.EOF_COmunicazioni_con_OLO__C='';
		update c;
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static testmethod void testCheckASync_12() {

		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = preTestCheckSync('Attivo');
		addCustomSettings();

		tt.TIPO_COMUNICAZIONE='12';
		tt.NOTE = 'abc';
		tt.DATA_ORA_DESOSPENSIONE = String.valueOf(System.now().addDays(1));
		tt.REFERENTE_DESOSPENSIONE = 'test';
		c.Status = 'Richiesta Chiusura';
		c.EOF_COmunicazioni_con_OLO__C='test';
		c.EOF_Collaudi_Negativi__c = 12;
		update c;
		OF_TT_EntryChecks.c = c;

		//a.OF_GPON_Attestazione__c = 'test';
		//update a;


		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		tt.NOTE = '';
		c.EOF_COmunicazioni_con_OLO__C='';
		update c;
		OF_TT_EntryChecks.checkAsync(c, tt);

		test.stopTest();
	}

	public static void addCustomSettings() {
		OF_Configurazioni__c cs = new OF_Configurazioni__c();
		cs.Name = '001';
		cs.DataSwitchOM__c = DateTime.valueOf('2017-09-05 16:00:00');
		cs.EOF_Attiva_Check_POP_OLO__c = false;
		cs.EOF_Codice_Operatore_OLO__c = 'VF;WN;TIS;GOI;CNN';
		cs.EOF_Pop_OM__c = 'BA_01;BA_02;CA_01;CT_01;CT_02;VE_01;VE_02;NA_02;NA_04;PG_02;PD_01;PD_02;PA_01;PA_03;NA_01;PA_04;PA_02;CA_02;NA_03;GE_01;GE_02;PG_01;MIH_1;MIH_2;MIH_3;MIH_4;MIH_5;TOH_1;TOH_2;BOH_1;BOH_2';
		cs.OF_ServizioExtraName__c = 0;
		cs.OF_checkTrueVaiSuOM__c = false;
		cs.OF_DataSwitchTTM__c = Date.valueOf('2018-06-15 12:00:00');
		cs.OF_TT_TuttoSuTTM__c = false;
		cs.OF_TT_CodOpOLOSuTTM__c = 'TIS';
		insert cs;

		OF_Puntamento_Callout__c pc = new OF_Puntamento_Callout__c();
		pc.Name = 'OGW';
		pc.OF_OGW__c = 'OFS-SVIL-WS';
		pc.OF_TTMRequest__c = 'ofs-svil-ws';
		pc.Tibco_Puntamento_SH__c = 'ofs-test-ws';
		pc.Tibco_Sviluppo__c = 'OFS-SVIL-WS.ENEL.COM:44300';
		pc.Tibco_Collaudo__c = 'OFS-SVIL-WS.ENEL.COM:44300';
		insert pc;

		OF_TT_Parametri__c par = new OF_TT_Parametri__c();
		par.Name = 'a0I58000006mC6x';
		par.EOF_Num_min_ritorno_in_lavorazione__c = 360;
		par.EOF_Giorni_Rip1__c = 15;
		par.EOF_Giorni_Rip2__c = 30;
		insert par;
	}

	public static OF_TT_WS_TroubleTicketRequest.TroubleTicket prePortalCheckSync() {
		OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
		tibco.OF_Tibco_ID__c=userinfo.getuserId();
		tibco.name='Tibco UserID';
		insert tibco;
		//AS Custom settings
		addCustomSettings();

		p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];

		testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing',
							LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');

		insert testUser;

		bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];

		String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
		List<Account> accToInsert = new List<Account>();
		accOLO = new Account();
		accOLO.Name = 'WIND';
		accOLO.EOF_Codice_Operatore__c = 'WN';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTYpeId = oloAccountRecordTypeId;

		accToInsert.add(accOLO);

		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
		acc = new Account();
		acc.Name = 'Test Account';
		acc.Phone = '0000';
		acc.EOF_Phone_2__c = '0000';
		acc.EOF_Provincia__c = 'Milano';
		acc.EOF_Comune__c = 'Milano';
		acc.EOF_Indirizzo__c = 'Piazzale Gorini';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Particella_Toponomastica__c = '123';
		acc.EOF_Numero_Civico__c = '7';

		accToInsert.add(acc);
		insert accToInsert;

		//-------Case Creation-------------
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
		c = new Case();
		c.EOF_Account_OLO__c = accOLO.Id;
		c.Subject = 'Richiesta Risoluzione Guasto';
		c.EOF_ID_Risorsa__c = null;
		c.EOF_Codice_Ordine_OLO__c = '02112016_37';
		c.EOF_Data_Prevista_Attivazione__c = system.today();
		c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c.Status = 'Bozza';
		c.EOF_Fase__c = null;
		c.Type = '1';
		c.EOF_Tipologia_Servizio__c = 'test';
		c.EOF_Codice_Operatore_WS__c = 'WN';
		c.EOF_SLA_Premium_Assurance__c ='N';
		c.Account = acc;
		c.EOF_Identificativo_del_POP__c = 'PG_01';
		c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c.EOF_Numero_Civico_WS__c = '7';
		c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
		c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
		c.EOF_Recapito_Test_Linea__c = '111';
		c.EOF_Tipologia_Apparato__c = 'test';
		c.OwnerId = testUser.Id;
		c.RecordTypeId = CaseRecordTypeId;
		c.EOF_Id_Notifica__c = 'test_01';
		c.Origin = 'Web';
		c.Priority = 'Medium';
		c.EOF_GPON_Vincolante__c = 'Y';
		c.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c.EOF_Codice_comunicazione_olo__c='testalo';
		c.EOF_COmunicazioni_con_OLO__C='test';
		insert c;

		//-------------Trouble Ticket Creation----------------
		tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
		tt.TIPO_COMUNICAZIONE = '1';
		tt.CODICE_OPERATORE = 'VF';
		tt.ID_NOTIFICA = null;
		tt.ID_RISORSA = null;
		tt.NOME_CLIENTE = 'Franco';
		tt.COGNOME_CLIENTE = 'Daje';
		tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
		tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
		tt.NOTE = 'xyz';
		tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
		tt.REFERENTE_DESOSPENSIONE = 'xyz';
		//tt.VERIFICA_APPARATO_CLIENTE = 'xyz';
		tt.NOME_REFERENTE_TECNICO_OLO='xyz';
		tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
		tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
		tt.CAUSALE_DESOSPENSIONE='3';
		tt.CATEGORIA_GUASTO='2';
		tt.CAUSALE_APERTURA='4';

		//-------------Trouble Ticket Ends-----------------------

		String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
		nGPON = new EOF_Notify__c();
		nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
		nGPON.EOF_ID_Notifica__c = 'Test Id';
		nGPON.EOF_Stato_Richiesta__c = 'OK';
		nGPON.EOF_Codice_Operatore__c = 'VF';
		nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
		nGPON.EOF_Data_Notifica__c = system.now();
		nGPON.EOF_Note__c = 'Test Note';
		nGPON.EOF_Inviata__c = false;
		nGPON.Caso__c = c.id;
		nGPON.RecordTYpeId = NotifyRecordTypeId;

		insert nGPON;
		// Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo'];
		a = new Asset();
		a.Name= 'Test Asset';
		a.Status = 'Cessato';
		a.EOF_ID_Risorsa__c = null;
		a.AccountId = accOLO.Id;
		insert a;
		//-----insert EAI Service Log------

		String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
		eaiLog = new EOF_EAI_Service_Log__c();
		eaiLog.Caso__c  = c.Id;
		eaiLog.EOF_ID_Notifica__c = 'test_01';
		eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
		eaiLog.recordTypeId = eaiRecordType;
		insert eaiLog;

		OF_TT_EntryChecks.c=c;
		return tt;
	}

	public static testmethod void testPortalCheckSync() {
		OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = prePortalCheckSync();

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
		OF_TT_EntryChecks.PORTAL_checkSync(tt,eaiLog);

		tt.TIPO_COMUNICAZIONE='6';
		OF_TT_EntryChecks.PORTAL_checkSync(tt,eaiLog);

		tt.TIPO_COMUNICAZIONE='1';
		OF_TT_EntryChecks.c=c;
		OF_TT_EntryChecks.PORTAL_checkSync(tt,eaiLog);

		test.stopTest();
	}


}
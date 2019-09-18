@isTest
public class OF_TTM_AsyncChecksTEST {
	public static boolean Nack=false;
	public static boolean NackTTM=false;
	public static String cId;
	public static String lId;
	public static Case casoToUpdate;


	public static void createCustomSetting() {
		OF_TT_Parametri__c param = new OF_TT_Parametri__c();
		param.Name = 'a0I58000006mC6x';
		param.EOF_Num_min_ritorno_in_lavorazione__c = 360;
		param.EOF_Giorni_Rip1__c = 15;
		param.EOF_Giorni_Rip2__c = 30;
		insert param;
	}

	public static void createPartialDataVoid4() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt : [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
		insert accOLO;

		Asset a2 = new Asset();
		a2.EOF_ID_Risorsa__c='test';
		a2.name='test';
		a2.Status='Attivo';
		a2.EOF_Id_Risorsa__c = 'test';
		a2.AccountId=accOLO.Id;
		insert a2;

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

		Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];

		Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
		List<User> usr = new List<User>();
		User u2 = new User();
		String orgId1 = UserInfo.getOrganizationId();
		String dateString1 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
		Integer randomInt1 = Integer.valueOf(math.rint(math.random() * 1000000));
		String uniqueName1 = orgId1 + dateString1 + randomInt1;
		u2.Alias = 'standt1';
		u2.country = 'United Kingdom';
		u2.email = uniqueName1 + '@test' + orgId1 + '.org';
		u2.EmailEncodingKey='UTF-8';
		u2.LastName='Testing';
		u2.LanguageLocaleKey='en_US';
		u2.LocaleSidKey='en_US';
		u2.ProfileId = p1.Id;
		u2.TimeZoneSidKey='America/Los_Angeles';
		u2.UserName = uniqueName1 + '@test' + orgId1 + '.org';

		insert u2;

		List<Group> analisi = new List<Group>();
		Group g1 = new Group();
		g1.Name='Trouble Ticket - Coda Analisi';
		Group g2 = new Group();
		g2.Name='Queue';

		analisi.add(g1);
		analisi.add(g2);
		insert analisi;


		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();

		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x105';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO';
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
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-16T11:15:00+01:00';

		//OF_TT_WS_TroubleTicketRequest.troubleTIcket(tt);

		EOF_EAI_Service_log__c slPort = OF_TTM_Utils.create_EAI_Log(tt);
		insert slPort;

		List<Case> cList = new List<Case>();
	case  c5 = new case ();
		//  c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'test';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = null;
		c5.EOF_Fase__c = null;
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		// c5.Account = acc;
		c5.EOF_Identificativo_del_POP__c = 'PG_01';
		c5.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c5.EOF_Numero_Civico_WS__c = '7';
		c5.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
		c5.EOF_Numero_Telefonico_Principale_Linea__c = '111';
		c5.EOF_Recapito_Test_Linea__c = '111';
		c5.EOF_Tipologia_Apparato__c = 'test';
		c5.OwnerId = u2.Id;
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Disservizio';
		insert c5;
		cList.add(c5);

		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
		TTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;
		TTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
		TTlog.EOF_Tipo_Comunicazione__c = '1';
		TTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
		TTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;
		TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';
		TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		TTlog.EOF_Categoria_Guasto__c ='';
		TTlog.EOF_ID_Risorsa__c ='';
		TTlog.EOF_Causale_Apertura__c ='';
		TTlog.EOF_Nome_Cliente__c ='';
		TTlog.EOF_COgnome_CLiente__c ='asdgasdasdfg';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='123456789012345678901234567890123456789012345678901234567890';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789012345678901234567890123456789012345678901234567890';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';
		TTlog.EOF_Codice_ordine_eof__c = c5.id;
		insert TTlog;

		OF_TTM_AsyncChecksTEST.cId= (String) c5.id;
		OF_TTM_AsyncChecksTEST.lId= (String) TTlog.id;
		OF_TTM_AsyncChecksTEST.casoToUpdate = c5;
	}

	public static void createPartialDataVoid3() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
		insert accOLO;

		Asset a2 = new Asset();
		a2.EOF_ID_Risorsa__c='test';
		a2.name='test';
		a2.Status='Attivo';
		a2.EOF_Id_Risorsa__c = 'test';
		a2.AccountId=accOLO.Id;
		insert a2;

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

		Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];

		Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
		List<User> usr = new List<User>();
		User u2 = new User();
		String orgId1 = UserInfo.getOrganizationId();
		String dateString1 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
		Integer randomInt1 = Integer.valueOf(math.rint(math.random() * 1000000));
		String uniqueName1 = orgId1 + dateString1 + randomInt1;
		u2.Alias = 'standt1';
		u2.country = 'United Kingdom';
		u2.email = uniqueName1 + '@test' + orgId1 + '.org';
		u2.EmailEncodingKey='UTF-8';
		u2.LastName='Testing';
		u2.LanguageLocaleKey='en_US';
		u2.LocaleSidKey='en_US';
		u2.ProfileId = p1.Id;
		u2.TimeZoneSidKey='America/Los_Angeles';
		u2.UserName = uniqueName1 + '@test' + orgId1 + '.org';

		insert u2;

		List<Group> analisi = new List<Group>();
		Group g1 = new Group();
		g1.Name='Trouble Ticket - Coda Analisi';
		Group g2 = new Group();
		g2.Name='Queue';

		analisi.add(g1);
		analisi.add(g2);
		insert analisi;


		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();

		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x105';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO';
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
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-16T11:15:00+01:00';

		//OF_TT_WS_TroubleTicketRequest.troubleTIcket(tt);

		EOF_EAI_Service_log__c slPort = OF_TTM_Utils.create_EAI_Log(tt);
		insert slPort;

		List<Case> cList = new List<Case>();
	case  c5 = new case ();
		//  c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'test';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = null;
		c5.EOF_Fase__c = null;
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		// c5.Account = acc;
		c5.EOF_Identificativo_del_POP__c = 'PG_01';
		c5.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c5.EOF_Numero_Civico_WS__c = '7';
		c5.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
		c5.EOF_Numero_Telefonico_Principale_Linea__c = '111';
		c5.EOF_Recapito_Test_Linea__c = '111';
		c5.EOF_Tipologia_Apparato__c = 'test';
		c5.OwnerId = u2.Id;
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Disservizio';
		insert c5;
		cList.add(c5);

		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
		TTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;
		TTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
		TTlog.EOF_Tipo_Comunicazione__c = '1';
		TTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
		TTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;
		TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';
		TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		TTlog.EOF_Categoria_Guasto__c ='';
		TTlog.EOF_ID_Risorsa__c ='';
		TTlog.EOF_Causale_Apertura__c ='';
		TTlog.EOF_Nome_Cliente__c ='';
		TTlog.EOF_COgnome_CLiente__c ='asdgasdasdfg';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='123456789012345678901234567890123456789012345678901234567890';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789012345678901234567890123456789012345678901234567890';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;

		OF_TTM_AsyncChecksTEST.cId= (String) c5.id;
		OF_TTM_AsyncChecksTEST.lId= (String) TTlog.id;
	}

	public static void createPartialDataVoid2() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
		insert accOLO;

		Asset a2 = new Asset();
		a2.EOF_ID_Risorsa__c='test';
		a2.name='test';
		a2.Status='Attivo';
		a2.EOF_Id_Risorsa__c = 'test';
		a2.AccountId=accOLO.Id;
		insert a2;

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

		Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];

		Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
		List<User> usr = new List<User>();
		User u2 = new User();
		String orgId1 = UserInfo.getOrganizationId();
		String dateString1 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
		Integer randomInt1 = Integer.valueOf(math.rint(math.random() * 1000000));
		String uniqueName1 = orgId1 + dateString1 + randomInt1;
		u2.Alias = 'standt1';
		u2.country = 'United Kingdom';
		u2.email = uniqueName1 + '@test' + orgId1 + '.org';
		u2.EmailEncodingKey='UTF-8';
		u2.LastName='Testing';
		u2.LanguageLocaleKey='en_US';
		u2.LocaleSidKey='en_US';
		u2.ProfileId = p1.Id;
		u2.TimeZoneSidKey='America/Los_Angeles';
		u2.UserName = uniqueName1 + '@test' + orgId1 + '.org';

		insert u2;

		List<Group> analisi = new List<Group>();
		Group g1 = new Group();
		g1.Name='Trouble Ticket - Coda Analisi';
		Group g2 = new Group();
		g2.Name='Queue';

		analisi.add(g1);
		analisi.add(g2);
		insert analisi;


		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();

		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x105';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO';
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
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-16T11:15:00+01:00';

		//OF_TT_WS_TroubleTicketRequest.troubleTIcket(tt);

		EOF_EAI_Service_log__c slPort = OF_TTM_Utils.create_EAI_Log(tt);
		insert slPort;

		List<Case> cList = new List<Case>();
		Case c5 = new Case();
		// c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'test';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = null;
		c5.EOF_Fase__c = null;
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		// c5.Account = acc;
		c5.EOF_Identificativo_del_POP__c = 'PG_01';
		c5.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c5.EOF_Numero_Civico_WS__c = '7';
		c5.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
		c5.EOF_Numero_Telefonico_Principale_Linea__c = '111';
		c5.EOF_Recapito_Test_Linea__c = '111';
		c5.EOF_Tipologia_Apparato__c = 'test';
		c5.OwnerId = u2.Id;
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Disservizio';
		insert c5;
		cList.add(c5);

		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
		TTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;
		TTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
		TTlog.EOF_Tipo_Comunicazione__c = '1';
		TTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
		TTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;
		TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';
		TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		TTlog.EOF_Categoria_Guasto__c ='';
		TTlog.EOF_ID_Risorsa__c ='';
		TTlog.EOF_Causale_Apertura__c ='';
		TTlog.EOF_Nome_Cliente__c ='';
		TTlog.EOF_COgnome_CLiente__c ='asdas';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;

		OF_TTM_AsyncChecksTEST.cId= (String) c5.id;
		OF_TTM_AsyncChecksTEST.lId= (String) TTlog.id;
	}

	public static void createPartialDataVoid() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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

		Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];

		Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
		List<User> usr = new List<User>();
		User u2 = new User();
		String orgId1 = UserInfo.getOrganizationId();
		String dateString1 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
		Integer randomInt1 = Integer.valueOf(math.rint(math.random() * 1000000));
		String uniqueName1 = orgId1 + dateString1 + randomInt1;
		u2.Alias = 'standt1';
		u2.country = 'United Kingdom';
		u2.email = uniqueName1 + '@test' + orgId1 + '.org';
		u2.EmailEncodingKey='UTF-8';
		u2.LastName='Testing';
		u2.LanguageLocaleKey='en_US';
		u2.LocaleSidKey='en_US';
		u2.ProfileId = p1.Id;
		u2.TimeZoneSidKey='America/Los_Angeles';
		u2.UserName = uniqueName1 + '@test' + orgId1 + '.org';

		insert u2;

		List<Group> analisi = new List<Group>();
		Group g1 = new Group();
		g1.Name='Trouble Ticket - Coda Analisi';
		Group g2 = new Group();
		g2.Name='Queue';

		analisi.add(g1);
		analisi.add(g2);
		insert analisi;


		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();

		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x105';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO';
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
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-16T11:15:00+01:00';

		//OF_TT_WS_TroubleTicketRequest.troubleTIcket(tt);

		EOF_EAI_Service_log__c slPort = OF_TTM_Utils.create_EAI_Log(tt);
		insert slPort;

		List<Case> cList = new List<Case>();
		Case c5 = new Case();
		//  c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'test';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = null;
		c5.EOF_Fase__c = null;
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		// c5.Account = acc;
		c5.EOF_Identificativo_del_POP__c = 'PG_01';
		c5.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c5.EOF_Numero_Civico_WS__c = '7';
		c5.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
		c5.EOF_Numero_Telefonico_Principale_Linea__c = '111';
		c5.EOF_Recapito_Test_Linea__c = '111';
		c5.EOF_Tipologia_Apparato__c = 'test';
		c5.OwnerId = u2.Id;
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Disservizio';
		insert c5;
		cList.add(c5);

		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
		TTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;
		TTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
		TTlog.EOF_Tipo_Comunicazione__c = '1';
		TTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
		TTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;
		TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';
		TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		TTlog.EOF_Categoria_Guasto__c ='';
		TTlog.EOF_ID_Risorsa__c ='';
		TTlog.EOF_Causale_Apertura__c ='';
		TTlog.EOF_Nome_Cliente__c ='';
		TTlog.EOF_COgnome_CLiente__c ='';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;

		OF_TTM_AsyncChecksTEST.cId= (String) c5.id;
		OF_TTM_AsyncChecksTEST.lId= (String) slPort.id;
	}

	public static void createPartialData() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
		insert accOLO;

		Asset a = new Asset();
		a.EOF_ID_Risorsa__c='test';
		a.name='test';
		a.Status='Chiuso';
		a.AccountId=accOLO.Id;
		insert a;

		Asset a2 = new Asset();
		a2.EOF_ID_Risorsa__c='test';
		a2.name='test';
		a2.Status='Attivo';
		a2.EOF_Id_Risorsa__c = 'test';
		a2.AccountId=accOLO.Id;
		insert a2;
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

		Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];

		Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
		List<User> usr = new List<User>();
		User u2 = new User();
		String orgId1 = UserInfo.getOrganizationId();
		String dateString1 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
		Integer randomInt1 = Integer.valueOf(math.rint(math.random() * 1000000));
		String uniqueName1 = orgId1 + dateString1 + randomInt1;
		u2.Alias = 'standt1';
		u2.country = 'United Kingdom';
		u2.email = uniqueName1 + '@test' + orgId1 + '.org';
		u2.EmailEncodingKey='UTF-8';
		u2.LastName='Testing';
		u2.LanguageLocaleKey='en_US';
		u2.LocaleSidKey='en_US';
		u2.ProfileId = p1.Id;
		u2.TimeZoneSidKey='America/Los_Angeles';
		u2.UserName = uniqueName1 + '@test' + orgId1 + '.org';

		insert u2;

		List<Group> analisi = new List<Group>();
		Group g1 = new Group();
		g1.Name='Trouble Ticket - Coda Analisi';
		Group g2 = new Group();
		g2.Name='Queue';

		analisi.add(g1);
		analisi.add(g2);
		insert analisi;


		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();

		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x105';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO';
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
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-16T11:15:00+01:00';

		//OF_TT_WS_TroubleTicketRequest.troubleTIcket(tt);

		EOF_EAI_Service_log__c slPort = OF_TTM_Utils.create_EAI_Log(tt);
		insert slPort;

		List<Case> cList = new List<Case>();
		Case c5 = new Case();
		//  c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'test';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = null;
		c5.EOF_Fase__c = null;
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		// c5.Account = acc;
		c5.EOF_Identificativo_del_POP__c = 'PG_01';
		c5.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c5.EOF_Numero_Civico_WS__c = '7';
		c5.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
		c5.EOF_Numero_Telefonico_Principale_Linea__c = '111';
		c5.EOF_Recapito_Test_Linea__c = '111';
		c5.EOF_Tipologia_Apparato__c = 'test';
		c5.OwnerId = u2.Id;
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Disservizio';
		insert c5;
		cList.add(c5);

		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
		TTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;
		TTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
		TTlog.EOF_Tipo_Comunicazione__c = '1';
		TTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
		TTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;
		TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';
		TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		TTlog.EOF_Categoria_Guasto__c ='';
		TTlog.EOF_ID_Risorsa__c ='';
		TTlog.EOF_Causale_Apertura__c ='';
		TTlog.EOF_Nome_Cliente__c ='';
		TTlog.EOF_COgnome_CLiente__c ='';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;

		OF_TTM_AsyncChecksTEST.cId= (String) c5.id;
		OF_TTM_AsyncChecksTEST.lId= (String) slPort.id;
	}

	public static testMethod void OF_TTM_AsyncChecksMethod() {
		createCustomSetting();
		Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
		Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
		Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
		Id RecordTypeIdcas = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
		Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
		Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
		Account acc = new Account();
		acc.name= 'Test';
		insert acc;

		Asset a = new Asset();
		//a.Status = 'Attivo';
		a.Name = 'Canone';
		a.EOF_ID_Risorsa__c = 'Canone';
		a.AccountID = acc.Id;
		a.OF_DataAttivazione2__c = system.today();
		a.OF_DataCessazione2__c = system.today();
		a.OF_ProfiloOpenStream__c = 'test';
		insert a;

		Case cse = new Case();
		cse.status = 'Espletato';
		cse.OF_Bonifica_Locked_Row__c  = true;
		cse.RecordTypeId = RecordTypeIdcas;
		//cse.status = 'Acquisito';
		cse.EOF_Id_Risorsa__c = a.Name;
		//cse.EOF_Id_Risorsa__c = 'Test';
		cse.AssetId = a.Id;
		cse.OF_SA_ID_Building_OM__c = 'Test';
		insert cse;

		EOF_EAI_Service_Log__c service = new EOF_EAI_Service_Log__c();
		service.OF_SA_ACK__c = True;
		service.EOF_Stato_Richiesta__c='Bozza Portale';
		service.EOF_ID_Risorsa__c = a.name;
		service.RecordTypeId = RecordTypeIdser;
		service.EOF_Note__c = 'abc';
		service.EOF_Tipo_Comunicazione__c = '1';
		insert service;

		EOF_EAI_Service_Log__c service1 = new EOF_EAI_Service_Log__c();
		service1.OF_SA_ACK__c = True;
		service1.EOF_ID_Risorsa__c = a.name;
		service1.RecordTypeId = RecordTypeIdser1;
		service1.OF_SA_VLan_Log__c = service.Id;
		service1.EOF_Stato_Richiesta__c='Bozza Portale';
		service1.EOF_Tipo_Comunicazione__c = '1';
		service1.EOF_Note__c = 'abc';
		insert service1;

		OF_TTM_EntryChecks.sl = service;
		Test.StartTest();



		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock1());
		//OF_TTM_AsyncChecks.executeDML(true,true);
		OF_TTM_AsyncChecks.checkAsync(cse.id,service.id);

		Test.StopTest();
	}




	public static testmethod void Test1() {
		OF_TTM_AsyncChecksTEST.createPartialData();
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecks.checkAsync(OF_TTM_AsyncChecksTEST.cId, OF_TTM_AsyncChecksTEST.lId);
		test.stopTest();

	}

	public static testmethod void Test2() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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

		Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];

		Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
		List<User> usr = new List<User>();
		User u2 = new User();
		String orgId1 = UserInfo.getOrganizationId();
		String dateString1 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
		Integer randomInt1 = Integer.valueOf(math.rint(math.random() * 1000000));
		String uniqueName1 = orgId1 + dateString1 + randomInt1;
		u2.Alias = 'standt1';
		u2.country = 'United Kingdom';
		u2.email = uniqueName1 + '@test' + orgId1 + '.org';
		u2.EmailEncodingKey='UTF-8';
		u2.LastName='Testing';
		u2.LanguageLocaleKey='en_US';
		u2.LocaleSidKey='en_US';
		u2.ProfileId = p1.Id;
		u2.TimeZoneSidKey='America/Los_Angeles';
		u2.UserName = uniqueName1 + '@test' + orgId1 + '.org';


		// usr.add(u2);

		// end user creation
		//insert usr;
		insert u2;

		List<Group> analisi = new List<Group>();
		Group g1 = new Group();
		g1.Name='Trouble Ticket - Coda Analisi';
		Group g2 = new Group();
		g2.Name='Queue';

		analisi.add(g1);
		analisi.add(g2);
		insert analisi;


		List<Case> cList = new List<Case>();
		Case c5 = new Case();
		//  c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'test';

		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = null;
		c5.EOF_Fase__c = null;
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		// c5.Account = acc;
		c5.EOF_Identificativo_del_POP__c = 'PG_01';
		c5.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c5.EOF_Numero_Civico_WS__c = '7';
		c5.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
		c5.EOF_Numero_Telefonico_Principale_Linea__c = '111';
		c5.EOF_Recapito_Test_Linea__c = '111';
		c5.EOF_Tipologia_Apparato__c = 'test';
		c5.OwnerId = u2.Id;
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Disservizio';
		insert c5;
		cList.add(c5);

		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();

		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x105';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= c5.EOF_Id_Risorsa__c;
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO';
		tt.COGNOME_CLIENTE= '';//'LEOPARDI';
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
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-16T11:15:00+01:00';

		//OF_TT_WS_TroubleTicketRequest.troubleTIcket(tt);



		EOF_EAI_Service_log__c slPort = OF_TTM_Utils.create_EAI_Log(tt);
		insert slPort;


		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();
		TTlog.Caso__c=c5.id;
		TTlog.EOF_ID_Notifica__c='01234567';
		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
		TTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;
		TTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
		TTlog.EOF_Tipo_Comunicazione__c = '3';
		TTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
		TTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;
		TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';
		TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		TTlog.EOF_Categoria_Guasto__c ='1';
		TTlog.EOF_ID_Risorsa__c =c5.EOF_Id_Risorsa__c;
		TTlog.EOF_Causale_Apertura__c ='1'; //2 3 4
		TTlog.EOF_Nome_Cliente__c ='test1234567891234567891234567891234567891234567891230';
		TTlog.EOF_COgnome_CLiente__c ='012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='';//'000011112222333344445555666677778889999012345678901234567890';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='';//'00001111222233334444555566667777888999901234567890123456789';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='test';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
		TTlog.EOF_Verifica_apparato_cliente__c ='y';
		TTlog.EOF_Descrizione_Problema__c ='test test test';
		TTlog.EOF_NOTE__c ='solo solo solamente note';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='solo solo solamente note cliente';
		TTlog.EOF_Intervento_Congiunto__c ='y';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;

		update c5;

		list<Asset> ast = new list<Asset>();


		Asset a = new Asset();
		//a.OF_Case__c= c5.Id;
		a.EOF_ID_Risorsa__c= c5.EOF_Id_Risorsa__c;
		a.Name=c5.EOF_Id_Risorsa__c;
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');
		a.status='Attivo';
		//a.EOF_ID_Risorsa__c='risorsa';
		// a.name='Test';
		a.accountId=accOlo.id;
		a.EOF_OLO__c='VF';

		ast.add(a);

		Asset a1 = new Asset();
		//a1.OF_Case__c= c5.Id;
		a1.EOF_ID_Risorsa__c= c5.EOF_Id_Risorsa__c;
		a1.Name=c5.EOF_Id_Risorsa__c;
		a1.RecordTypeId = rtMap.get('OF_OpenStream');
		a1.status='Attivo';
		// a1.EOF_ID_Risorsa__c='risorsa';
		//a1.name='Test';
		a1.accountId=accOlo.id;
		a1.EOF_OLO__c='VF';

		ast.add(a1);

		insert ast;

		a.status='In modifica';
		a1.status='In modifica';
		a.OF_GPON_Attestazione__c='';
		a1.OF_GPON_Attestazione__c='';
		update a;
		update a1;

		String cId= (String) c5.id;
		String lId= (String) slPort.id;
		//String lId= (String) TTlog.id;

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock1());
		//OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

		//Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
		//Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
		//  OF_TTM_AsyncChecks istanza = new OF_TTM_AsyncChecks();
		OF_TTM_AsyncChecks.checkAsync(cId, lId);

		Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
		EOF_EAI_Service_Log__c service = new EOF_EAI_Service_Log__c ();
		service.OF_SA_ACK__c = True;
		service.EOF_Stato_Richiesta__c='Bozza Portale';
		service.EOF_ID_Risorsa__c = a.name;
		service.RecordTypeId = RecordTypeIdser;
		service.EOF_Tipo_Comunicazione__c = '1';
		service.EOF_Note__c = 'abc';
		service.EOF_COgnome_CLiente__c='012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234';
		insert service;
		OF_TTM_EntryChecks.sl = service;
		OF_TTM_AsyncChecks.checkAsync(cId, lId);
		//   istanza.updatePortalSLog(c5);
		//  istanza.executeDML(true,true);
		test.stopTest();

	}

	public static testmethod void Test3() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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

		Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];

		Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
		List<User> usr = new List<User>();
		User u2 = new User();
		String orgId1 = UserInfo.getOrganizationId();
		String dateString1 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
		Integer randomInt1 = Integer.valueOf(math.rint(math.random() * 1000000));
		String uniqueName1 = orgId1 + dateString1 + randomInt1;
		u2.Alias = 'standt1';
		u2.country = 'United Kingdom';
		u2.email = uniqueName1 + '@test' + orgId1 + '.org';
		u2.EmailEncodingKey='UTF-8';
		u2.LastName='Testing';
		u2.LanguageLocaleKey='en_US';
		u2.LocaleSidKey='en_US';
		u2.ProfileId = p1.Id;
		u2.TimeZoneSidKey='America/Los_Angeles';
		u2.UserName = uniqueName1 + '@test' + orgId1 + '.org';


		// usr.add(u2);

		// end user creation
		//insert usr;
		insert u2;

		List<Group> analisi = new List<Group>();
		Group g1 = new Group();
		g1.Name='Trouble Ticket - Coda Analisi';
		Group g2 = new Group();
		g2.Name='Queue';

		analisi.add(g1);
		analisi.add(g2);
		insert analisi;


		List<Case> cList = new List<Case>();
		Case c5 = new Case();
		//  c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'test';

		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = null;
		c5.EOF_Fase__c = null;
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		// c5.Account = acc;
		c5.EOF_Identificativo_del_POP__c = 'PG_01';
		c5.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c5.EOF_Numero_Civico_WS__c = '7';
		c5.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
		c5.EOF_Numero_Telefonico_Principale_Linea__c = '111';
		c5.EOF_Recapito_Test_Linea__c = '111';
		c5.EOF_Tipologia_Apparato__c = 'test';
		c5.OwnerId = u2.Id;
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Disservizio';
		insert c5;
		cList.add(c5);

		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();

		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x105';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= c5.EOF_Id_Risorsa__c;
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO';
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
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-16T11:15:00+01:00';

		//OF_TT_WS_TroubleTicketRequest.troubleTIcket(tt);

		EOF_EAI_Service_log__c slPort = OF_TTM_Utils.create_EAI_Log(tt);
		insert slPort;


		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();
		TTlog.Caso__c=c5.id;
		TTlog.EOF_ID_Notifica__c='0123456789012345678901234567890123456789012301230123456789012345678901234567890123456789012345678901234567890123012301234567890123456789';
		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
		TTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;
		TTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
		TTlog.EOF_Tipo_Comunicazione__c = '3';
		TTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
		TTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;
		TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';
		TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		TTlog.EOF_Categoria_Guasto__c ='1';
		TTlog.EOF_ID_Risorsa__c =c5.EOF_Id_Risorsa__c;
		TTlog.EOF_Causale_Apertura__c ='1'; //2 3 4
		TTlog.EOF_Nome_Cliente__c ='test1234567891234567891234567891234567891234567891230';
		TTlog.EOF_COgnome_CLiente__c ='test123456789123456789123456789123456789123456789123012345678901234567890123';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='';//'000011112222333344445555666677778889999012345678901234567890';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='';//'00001111222233334444555566667777888999901234567890123456789';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='test';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
		TTlog.EOF_Verifica_apparato_cliente__c ='y';
		TTlog.EOF_Descrizione_Problema__c ='test test test';
		TTlog.EOF_NOTE__c ='solo solo solamente note';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='solo solo solamente note cliente';
		TTlog.EOF_Intervento_Congiunto__c ='y';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;
		update c5;

		list<Asset> ast = new list<Asset>();


		Asset a = new Asset();
		//a.OF_Case__c= c5.Id;
		a.EOF_ID_Risorsa__c= c5.EOF_Id_Risorsa__c;
		a.Name=c5.EOF_Id_Risorsa__c;
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');
		a.status='Attivo';
		//a.EOF_ID_Risorsa__c='risorsa';
		// a.name='Test';
		a.accountId=accOlo.id;
		a.EOF_OLO__c='VF';

		ast.add(a);

		Asset a1 = new Asset();
		//a1.OF_Case__c= c5.Id;
		a1.EOF_ID_Risorsa__c= c5.EOF_Id_Risorsa__c;
		a1.Name=c5.EOF_Id_Risorsa__c;
		a1.RecordTypeId = rtMap.get('OF_OpenStream');
		a1.status='Attivo';
		// a1.EOF_ID_Risorsa__c='risorsa';
		//a1.name='Test';
		a1.accountId=accOlo.id;
		a1.EOF_OLO__c='VF';

		ast.add(a1);

		insert ast;

		a.status='In modifica';
		a1.status='In modifica';
		update a;
		update a1;


		String cId= (String) c5.id;
		String lId= (String) slPort.id;
		//String lId= (String) TTlog.id;

		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock1());
		//OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

		//Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
		//Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		OF_TTM_AsyncChecks.checkAsync(cId, lId);

		test.stopTest();

	}

	public static testmethod void test4() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}



		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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


		Case c5 = new Case();

		c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = 'In Lavorazione';
		c5.EOF_Fase__c = 'In lavorazione';
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		//c5.EOF_Data_ora_intervento_congiunto__c=null;
		c5.EOF_Causale_Apertura__c='';
		c5.EOF_Intervento_Congiunto__c='';
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Degrado';
		//c5.EOF_Data_Ora_Chiusura_Ticket__c=null;
		c5.EOF_Note__c='';
		c5.EOF_COmunicazioni_con_OLO__C='';
		c5.Eof_tel_tec_olo__c='';
		c5.EOF_Tec_Olo__c='';
		c5.EOF_Descrizione_Problema__c='';
		//c5.EOF_Rip1__c='';
		//c5.EOF_Rip2__c='';
		c5.EOF_Referente_Desospensione__c='';
		c5.OF_TroubleTicketManager__c= true;

		insert c5;

		asset a = new Asset();
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');
		a.status='Attivo';
		a.EOF_ID_Risorsa__c='Asset20180611_v4';
		a.name='Asset20180611_v4';
		a.accountId=accOlo.id;
		a.EOF_OLO__c='VF';

		insert a;


		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
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
		TTlog.EOF_Nome_Cliente__c ='';
		TTlog.EOF_COgnome_CLiente__c ='Test';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;
		
		OF_TTM_EntryChecks.c = c5;
		
		Case c6 = new Case();

		c6.EOF_Account_OLO__c = accOLO.Id;
		c6.Subject = 'Richiesta Risoluzione Guasto';
		c6.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c6.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c6.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c6.Status = 'Acquisito';
		c6.EOF_Fase__c = 'Da lavorare';
		c6.Type = '1';
		c6.EOF_Tipologia_Servizio__c = 'test';
		c6.EOF_Codice_Operatore_WS__c = 'VF';
		c6.EOF_SLA_Premium_Assurance__c ='N';
		c6.EOF_Causale_Apertura__c='';
		c6.EOF_Intervento_Congiunto__c='';
		c6.RecordTypeId = rtMap.get('Trouble_Ticket');
		c6.EOF_Id_Notifica__c = 'test_01';
		c6.Origin = 'Web';
		c6.Priority = 'Medium';
		c6.EOF_GPON_Vincolante__c = 'Y';
		c6.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c6.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c6.EOF_Categoria_Guasto__C='Degrado';
		//c5.EOF_Data_Ora_Chiusura_Ticket__c=null;
		c6.EOF_Note__c='';
		c6.EOF_COmunicazioni_con_OLO__C='';
		c6.Eof_tel_tec_olo__c='';
		c6.EOF_Tec_Olo__c='';
		c6.EOF_Descrizione_Problema__c='';
		//c5.EOF_Rip1__c='';
		//c5.EOF_Rip2__c='';
		c6.EOF_Referente_Desospensione__c='';
		c6.OF_TroubleTicketManager__c= true;

		insert c6;


		test.starttest();

		//OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock1());
		//Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
		//Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		OF_TTM_AsyncChecks.checkAsync(c5.Id, TTlog.id);
/*
		try {
			TTlog.EOF_Nome_Cliente__c = '';
			update TTlog;
			OF_TTM_AsyncChecks.checkAsync(c5.Id, TTlog.id);
		} catch (DmlException e) {
			System.debug(e.getMessage());
		}*/

		test.stoptest();
	}

	public static testmethod void test5() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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
		Case c5 = new Case();

		c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = 'In Lavorazione';
		c5.EOF_Fase__c = 'In lavorazione';
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		//c5.EOF_Data_ora_intervento_congiunto__c=null;
		c5.EOF_Causale_Apertura__c='';
		c5.EOF_Intervento_Congiunto__c='';
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Degrado';
		//c5.EOF_Data_Ora_Chiusura_Ticket__c=null;
		c5.EOF_Note__c='';
		c5.EOF_COmunicazioni_con_OLO__C='';
		c5.Eof_tel_tec_olo__c='';
		c5.EOF_Tec_Olo__c='';
		c5.EOF_Descrizione_Problema__c='';
		//c5.EOF_Rip1__c='';
		//c5.EOF_Rip2__c='';
		c5.EOF_Referente_Desospensione__c='';
		c5.OF_TroubleTicketManager__c= true;

		insert c5;

		asset a = new Asset();
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');
		a.status='Attivo';
		a.EOF_ID_Risorsa__c='Asset20180611_v4';
		a.name='Asset20180611_v4';
		a.accountId=accOlo.id;
		a.EOF_OLO__c='VF';

		insert a;


		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
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
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;


		test.starttest();

		//OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock1());
		//Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
		//Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		OF_TTM_AsyncChecks.checkAsync(c5.Id, TTlog.id);

		test.stoptest();
	}

	public static testmethod void test6() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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


		Case c5 = new Case();

		c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = 'In Lavorazione';
		c5.EOF_Fase__c = 'In lavorazione';
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		//c5.EOF_Data_ora_intervento_congiunto__c=null;
		c5.EOF_Causale_Apertura__c='';
		c5.EOF_Intervento_Congiunto__c='';
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Degrado';
		//c5.EOF_Data_Ora_Chiusura_Ticket__c=null;
		c5.EOF_Note__c='';
		c5.EOF_COmunicazioni_con_OLO__C='';
		c5.Eof_tel_tec_olo__c='';
		c5.EOF_Tec_Olo__c='';
		c5.EOF_Descrizione_Problema__c='';
		//c5.EOF_Rip1__c='';
		//c5.EOF_Rip2__c='';
		c5.EOF_Referente_Desospensione__c='';
		c5.OF_TroubleTicketManager__c= true;

		insert c5;

		asset a = new Asset();
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');
		a.status='Attivo';
		a.EOF_ID_Risorsa__c='Asset20180611_v4';
		a.name='Asset20180611_v4';
		a.accountId=accOlo.id;
		a.EOF_OLO__c='VF';
		a.OF_GPON_Attestazione__c ='test';

		insert a;


		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
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
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;


		test.starttest();

		//OF_TTM_WS_IN_Notify_CalloutMock.isACK = false;

		//Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock1());

		OF_TTM_AsyncChecks.checkAsync(c5.Id, TTlog.id);

		test.stoptest();
	}

	public static testmethod void Test7() {
		OF_TTM_AsyncChecksTEST.createPartialData();
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecksTEST.Nack=true;
		OF_TTM_AsyncChecks.checkAsync(OF_TTM_AsyncChecksTEST.cId, OF_TTM_AsyncChecksTEST.lId);
		test.stopTest();
	}

	public static testmethod void Test8() {
		OF_TTM_AsyncChecksTEST.createPartialData();
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecksTEST.NackTTM=true;
		OF_TTM_AsyncChecks.checkAsync(OF_TTM_AsyncChecksTEST.cId, OF_TTM_AsyncChecksTEST.lId);
		//OF_TTM_AsyncChecks.codeCoverage();
		test.stopTest();
	}

	public static testmethod void Test9() {
		OF_TTM_AsyncChecksTEST.createPartialData();
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecksTEST.NackTTM=true;
		OF_TTM_AsyncChecks.checkAsync(OF_TTM_AsyncChecksTEST.cId, OF_TTM_AsyncChecksTEST.lId);
		test.stopTest();
	}

	public static testmethod void Test10() {
		OF_TTM_AsyncChecksTEST.createPartialDataVoid();
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecksTEST.NackTTM=true;
		OF_TTM_AsyncChecks.checkAsync(OF_TTM_AsyncChecksTEST.cId, OF_TTM_AsyncChecksTEST.lId);
		test.stopTest();

	}

	public static testmethod void Test11() {
		OF_TTM_AsyncChecksTEST.createPartialDataVoid2();
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecksTEST.NackTTM=true;
		OF_TTM_AsyncChecks.checkAsync(OF_TTM_AsyncChecksTEST.cId, OF_TTM_AsyncChecksTEST.lId);
		test.stopTest();

	}

	public static testmethod void Test12() {
		OF_TTM_AsyncChecksTEST.createPartialDataVoid3();
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecksTEST.NackTTM=true;
		OF_TTM_AsyncChecks.checkAsync(OF_TTM_AsyncChecksTEST.cId, OF_TTM_AsyncChecksTEST.lId);
		test.stopTest();

	}

	public static testmethod void test13() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');


		a.status='Attivo';
		a.EOF_ID_Risorsa__c='Asset20180611_v4';
		a.name='Asset20180611_v4';
		a.accountId=accOlo.id;
		a.EOF_OLO__c='VF';

		insert a;
		Test.setCreatedDate(a.Id, DateTime.newInstance(2018,12,12));
		Case c5 = new Case ();

		c5.EOF_Account_OLO__c = accOLO.Id;
		c5.assetId = a.id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = 'In Lavorazione';
		c5.EOF_Fase__c = 'In lavorazione';
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		//c5.EOF_Data_ora_intervento_congiunto__c=null;
		c5.EOF_Causale_Apertura__c='';
		c5.EOF_Intervento_Congiunto__c='';
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Post Provisioning';
		//c5.EOF_Data_Ora_Chiusura_Ticket__c=null;
		c5.EOF_Note__c='';
		c5.EOF_COmunicazioni_con_OLO__C='';
		c5.Eof_tel_tec_olo__c='';
		c5.EOF_Tec_Olo__c='';
		c5.EOF_Descrizione_Problema__c='';
		//c5.EOF_Rip1__c='';
		//c5.EOF_Rip2__c='';
		c5.EOF_Referente_Desospensione__c='';
		c5.OF_TroubleTicketManager__c= true;

		insert c5;

		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
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
		TTlog.EOF_COgnome_CLiente__c ='Test';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;


		test.starttest();

		//OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock1());
		//Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
		//Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());


		

		OF_TTM_AsyncChecks.checkAsync(c5.Id, TTlog.id);
		/*try {
			OF_TTM_AsyncChecks.checkAsync(c6.Id, TTlog.id);
		} catch (DmlException e) {
			System.debug(e.getMessage());
		}*/

		test.stoptest();
	}

	public static testmethod void testUpdatePortalSLog() {
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
		insert accOLO;

		Case c6 = new Case();

		c6.EOF_Account_OLO__c = accOLO.Id;
		c6.Subject = 'Richiesta Risoluzione Guasto';
		c6.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c6.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c6.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c6.Status = 'Scartato';
		c6.EOF_Fase__c = 'KO';
		c6.EOF_Causale_errore__c = 'test';
		c6.Type = '1';
		c6.EOF_Tipologia_Servizio__c = 'test';
		c6.EOF_Codice_Operatore_WS__c = 'VF';
		c6.EOF_SLA_Premium_Assurance__c ='N';
		c6.EOF_Causale_Apertura__c='';
		c6.EOF_Intervento_Congiunto__c='';
		c6.RecordTypeId = rtMap.get('Trouble_Ticket');
		c6.EOF_Id_Notifica__c = 'test_01';
		c6.Origin = 'Web';
		c6.Priority = 'Medium';
		c6.EOF_GPON_Vincolante__c = 'Y';
		c6.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c6.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c6.EOF_Categoria_Guasto__C='Degrado';
		c6.EOF_Note__c='';
		c6.EOF_COmunicazioni_con_OLO__C='';
		c6.Eof_tel_tec_olo__c='';
		c6.EOF_Tec_Olo__c='';
		c6.EOF_Descrizione_Problema__c='';
		c6.EOF_Referente_Desospensione__c='';
		c6.OF_TroubleTicketManager__c= true;

		insert c6;

		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
		TTlog.EOF_Codice_Comunicazione_OLO__c = c6.EOF_CODICE_COMUNICAZIONE_OLO__c;
		TTlog.EOF_Codice_Operatore__c = c6.EOF_Codice_Operatore_WS__c;
		TTlog.EOF_Tipo_Comunicazione__c = '1';
		TTlog.EOF_Data_Notifica__c = c6.EOF_Data_Notifica__c;
		TTlog.EOF_ID_Notifica__c = c6.EOF_ID_NOTIFICA__c;
		TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';
		TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		TTlog.EOF_Categoria_Guasto__c ='';
		TTlog.EOF_ID_Risorsa__c ='Asset20180611_v4';
		TTlog.EOF_Causale_Apertura__c ='';
		TTlog.EOF_Nome_Cliente__c ='Test';
		TTlog.EOF_COgnome_CLiente__c ='Test';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';
		TTlog.EOF_Stato_Richiesta__c='Inserita Portale';
		TTlog.EOF_Codice_ordine_eof__c = c6.id;

		insert TTlog;

		test.starttest();

		OF_TTM_AsyncChecks.updatePortalSLog(c6);

		test.stoptest();
	}

	public static testmethod void test14() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');
		a.status='Attivo';
		a.EOF_ID_Risorsa__c='Asset20180611_v4';
		a.name='Asset20180611_v4';
		a.accountId=accOlo.id;
		a.EOF_OLO__c='VF';


		insert a;
		Test.setCreatedDate(a.Id, DateTime.newInstance(2018,12,12));
	case  c5 = new case ();

		c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = 'In Lavorazione';
		c5.EOF_Fase__c = 'In lavorazione';
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		//c5.EOF_Data_ora_intervento_congiunto__c=null;
		c5.EOF_Causale_Apertura__c='';
		c5.EOF_Intervento_Congiunto__c='';
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Post Provisioning';
		//c5.EOF_Data_Ora_Chiusura_Ticket__c=null;
		c5.EOF_Note__c='';
		c5.EOF_COmunicazioni_con_OLO__C='';
		c5.Eof_tel_tec_olo__c='';
		c5.EOF_Tec_Olo__c='';
		c5.EOF_Descrizione_Problema__c='';
		//c5.EOF_Rip1__c='';
		//c5.EOF_Rip2__c='';
		c5.EOF_Referente_Desospensione__c='';
		c5.OF_TroubleTicketManager__c= true;

		insert c5;



		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
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
		TTlog.EOF_COgnome_CLiente__c ='Test';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;


		test.starttest();

		//OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock1());
		//Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
		//Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());

		OF_TTM_AsyncChecks.checkAsync(c5.Id, TTlog.id);

		test.stoptest();


	}

	public static testmethod void Test15() {
		OF_TTM_AsyncChecksTEST.createPartialDataVoid3();
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecksTEST.Nack = true;
		OF_TTM_AsyncChecksTEST.NackTTM=true;
		OF_TTM_AsyncChecks.checkAsync(OF_TTM_AsyncChecksTEST.cId, OF_TTM_AsyncChecksTEST.lId);
		test.stopTest();
	}

	public static testmethod void test16() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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
	    case  c5 = new case ();

		c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = 'In Lavorazione';
		c5.EOF_Fase__c = 'In lavorazione';
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		//c5.EOF_Data_ora_intervento_congiunto__c=null;
		c5.EOF_Causale_Apertura__c='';
		c5.EOF_Intervento_Congiunto__c='';
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Degrado';
		//c5.EOF_Data_Ora_Chiusura_Ticket__c=null;
		c5.EOF_Note__c='';
		c5.EOF_COmunicazioni_con_OLO__C='';
		c5.Eof_tel_tec_olo__c='';
		c5.EOF_Tec_Olo__c='';
		c5.EOF_Descrizione_Problema__c='';
		//c5.EOF_Rip1__c='';
		//c5.EOF_Rip2__c='';
		c5.EOF_Referente_Desospensione__c='';
		c5.OF_TroubleTicketManager__c= true;

		insert c5;

		asset a = new Asset();
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');
		a.status='Attivo';
		a.EOF_ID_Risorsa__c='Asset20180611_v4';
		a.name='Asset20180611_v4';
		a.accountId=accOlo.id;

		a.EOF_OLO__c='VF';



		insert a;

		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
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
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';


		insert TTlog;

		test.starttest();

		//OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());

		OF_TTM_AsyncChecksTEST.Nack = true;
		OF_TTM_AsyncChecksTEST.NackTTM=true;
		OF_TTM_AsyncChecks.checkAsync(c5.Id, TTlog.id);

		test.stoptest();

	}


	public static testmethod void Test17() {
		OF_TTM_AsyncChecksTEST.createPartialDataVoid2();
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecksTEST.NackTTM=true;
		OF_TTM_AsyncChecksTEST.Nack=true;
		OF_TTM_AsyncChecks.checkAsync(OF_TTM_AsyncChecksTEST.cId, OF_TTM_AsyncChecksTEST.lId);
		test.stopTest();

	}

	public static testmethod void test18() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');
		a.status='Attivo';
		a.EOF_ID_Risorsa__c='Asset20180611_v4';
		a.name='Asset20180611_v4';
		a.accountId=accOlo.id;
		a.EOF_OLO__c='VF';

		insert a;
		Test.setCreatedDate(a.Id, DateTime.newInstance(2018,12,12));
	case  c5 = new case ();

		c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = 'In Lavorazione';
		c5.EOF_Fase__c = 'In lavorazione';
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		//c5.EOF_Data_ora_intervento_congiunto__c=null;
		c5.EOF_Causale_Apertura__c='';
		c5.EOF_Intervento_Congiunto__c='';
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Post Provisioning';
		//c5.EOF_Data_Ora_Chiusura_Ticket__c=null;
		c5.EOF_Note__c='';
		c5.EOF_COmunicazioni_con_OLO__C='';
		c5.Eof_tel_tec_olo__c='';
		c5.EOF_Tec_Olo__c='';
		c5.EOF_Descrizione_Problema__c='';
		//c5.EOF_Rip1__c='';
		//c5.EOF_Rip2__c='';
		c5.EOF_Referente_Desospensione__c='';
		c5.OF_TroubleTicketManager__c= true;

		insert c5;



		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
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
		TTlog.EOF_COgnome_CLiente__c ='Test';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;


		test.starttest();

		//OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());

		OF_TTM_AsyncChecksTEST.NackTTM=true;
		OF_TTM_AsyncChecksTEST.Nack=true;
		OF_TTM_AsyncChecks.checkAsync(c5.Id, TTlog.id);

		test.stoptest();



	}

	public static testmethod void test19() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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


	case  c5 = new case ();

		c5.EOF_Account_OLO__c = accOLO.Id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = 'In Lavorazione';
		c5.EOF_Fase__c = 'In lavorazione';
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		//c5.EOF_Data_ora_intervento_congiunto__c=null;
		c5.EOF_Causale_Apertura__c='';
		c5.EOF_Intervento_Congiunto__c='';
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Degrado';
		//c5.EOF_Data_Ora_Chiusura_Ticket__c=null;
		c5.EOF_Note__c='';
		c5.EOF_COmunicazioni_con_OLO__C='';
		c5.Eof_tel_tec_olo__c='';
		c5.EOF_Tec_Olo__c='';
		c5.EOF_Descrizione_Problema__c='';
		//c5.EOF_Rip1__c='';
		//c5.EOF_Rip2__c='';
		c5.EOF_Referente_Desospensione__c='';
		c5.OF_TroubleTicketManager__c= true;

		insert c5;

		asset a = new Asset();
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');
		a.status='Attivo';
		a.EOF_ID_Risorsa__c='Asset20180611_v4';
		a.name='Asset20180611_v4';
		a.accountId=accOlo.id;
		a.EOF_OLO__c='VF';
		a.OF_GPON_Attestazione__c ='test';

		insert a;


		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
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
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;


		test.starttest();

		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());

		OF_TTM_AsyncChecksTEST.Nack = true;
		OF_TTM_AsyncChecksTEST.NackTTM=true;

		OF_TTM_AsyncChecks.checkAsync(c5.Id, TTlog.id);

		test.stoptest();


	}

	public static testmethod void Test20() {
		OF_TTM_AsyncChecksTEST.createPartialDataVoid();
		test.startTest();
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecksTEST.Nack = true;
		OF_TTM_AsyncChecksTEST.NackTTM=true;
		OF_TTM_AsyncChecks.checkAsync(OF_TTM_AsyncChecksTEST.cId, OF_TTM_AsyncChecksTEST.lId);
		test.stopTest();

	}

	public static testmethod void test21() {
		createCustomSetting();
		Map<String,Id> rtMap = new Map<String,Id>();
		for (recordtype rt: [select id,developername from recordtype]) {
			rtMap.put(rt.developername,rt.id);
		}

		account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTypeId = rtMap.get('OLO');
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
		a.RecordTypeId = rtMap.get('OF_GPONPassiva');
		a.status='Attivo';
		a.EOF_ID_Risorsa__c='Asset20180611_v4';
		a.name='Asset20180611_v4';
		a.accountId=accOlo.id;
		a.EOF_OLO__c='VF';

		insert a;
		Test.setCreatedDate(a.Id, DateTime.newInstance(2018,12,12));
	    case  c5 = new case ();

		c5.EOF_Account_OLO__c = accOLO.Id;
		c5.assetId = a.id;
		c5.Subject = 'Richiesta Risoluzione Guasto';
		c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';
		c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
		c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c5.Status = 'In Lavorazione';
		c5.EOF_Fase__c = 'In lavorazione';
		c5.Type = '1';
		c5.EOF_Tipologia_Servizio__c = 'test';
		c5.EOF_Codice_Operatore_WS__c = 'VF';
		c5.EOF_SLA_Premium_Assurance__c ='N';
		//c5.EOF_Data_ora_intervento_congiunto__c=null;
		c5.EOF_Causale_Apertura__c='';
		c5.EOF_Intervento_Congiunto__c='';
		c5.RecordTypeId = rtMap.get('Trouble_Ticket');
		c5.EOF_Id_Notifica__c = 'test_01';
		c5.Origin = 'Web';
		c5.Priority = 'Medium';
		c5.EOF_GPON_Vincolante__c = 'Y';
		c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
		c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
		c5.EOF_Categoria_Guasto__C='Post Provisioning';
		//c5.EOF_Data_Ora_Chiusura_Ticket__c=null;
		c5.EOF_Note__c='';
		c5.EOF_COmunicazioni_con_OLO__C='';
		c5.Eof_tel_tec_olo__c='';
		c5.EOF_Tec_Olo__c='';
		c5.EOF_Descrizione_Problema__c='';
		//c5.EOF_Rip1__c='';
		//c5.EOF_Rip2__c='';
		c5.EOF_Referente_Desospensione__c='';
		c5.OF_TroubleTicketManager__c= true;

		insert c5;



		EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();

		TTlog.recordtypeId= rtMap.get('TroubleTicketRequest');
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
		TTlog.EOF_COgnome_CLiente__c ='Test';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
		TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
		TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
		TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
		TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
		TTlog.EOF_Verifica_apparato_cliente__c ='';
		TTlog.EOF_Descrizione_Problema__c ='';
		TTlog.EOF_NOTE__c ='abc';
		TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
		TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
		TTlog.EOF_Causale_Desospensione__c ='';
		TTlog.EOF_Referente_desospensione__c ='';
		TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
		TTlog.EOF_Data_Ora_Desospensione__c = system.today();
		TTlog.EOF_NOTE_CLIENTE__c ='';
		TTlog.EOF_Intervento_Congiunto__c ='';
		TTlog.EOF_Data_Ora_Scarto__c = system.today();
		TTlog.EOF_Data_Ora_Creazione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
		TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
		TTlog.Causale_Scarto__c ='';
		TTlog.EOF_Descrizione_Causale_Scarto__c ='';
		TTlog.Causale_Sospensione__c ='';
		TTlog.Descrizione_Evento_Risoluzione__c ='';
		TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
		TTlog.EOF_Tec_Eof__c ='';
		TTlog.EOF_Tel_Tec_Eof__c ='';
		TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
		TTlog.EOF_STATO_ORDINE__c='';

		insert TTlog;


		test.starttest();

		//OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;
		Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
		OF_TTM_AsyncChecksTEST.Nack = true;
		OF_TTM_AsyncChecksTEST.NackTTM=true;

		OF_TTM_AsyncChecks.checkAsync(c5.Id, TTlog.id);

		test.stoptest();



	}

}
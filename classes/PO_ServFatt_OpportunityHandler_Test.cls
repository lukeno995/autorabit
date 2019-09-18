@isTest
public class PO_ServFatt_OpportunityHandler_Test {
	
	public static testMethod void testOppHandlerP2PBase() {
		PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PBaseData();

		Case origCase = [SELECT Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
						 EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c,
						 PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c,
						 PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c,
						 PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c,
						 PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
						 EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
						 OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
						 OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
						 EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
						 PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, PO_P2P_Attiva__c,
						 isPsm__c,isClosed,EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Costi_aggiuntivi_collegamento__c,
						 PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,PO_KIT_Consegna_VLAN__r.assetId,EOF_Codice_Ordine_OLO__c, AccountId,
						 OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, PO_Tipologia_Offerta_ordine__c, PO_Offerta__c // RDG
						 FROM Case WHERE Id = :data.caseCollegamento.Id LIMIT 1];
						 
		initializeData(origCase);				 

		Test.startTest();
		Opportunity oc = PO_ServFatt_OpportunityHandler.createOppChild(origCase);
		Opportunity op = PO_ServFatt_OpportunityHandler.createOppParent(data.casePadre, new List<Case> {origCase}, oc);
		PO_ServFatt_OpportunityHandler.ricalculateOppParent(new Set<Id> {op.Id});
		System.assertEquals(null, PO_ServFatt_OpportunityHandler.getListinoFromContract(null, null, null));
		PO_ServFatt_OpportunityHandler.setProfileP2PBase(null, null);
		data.caseCollegamento.OF_IDContratto__c = null;
		data.caseCollegamento.PO_Accordo_Quadro__c = null;
		PO_ServFatt_OpportunityHandler.getListinoForCase(data.caseCollegamento);
		PO_ServFatt_OpportunityHandler.getRtIdDevNameMap();
		Test.stopTest();
	}

	public static testMethod void testRemovePBKit() {
		PO_ServFatt_DataFactory.createCustomSettings();
		ServFattList__c cs = ServFattList__c.getAll().get('P2P Attiva');
		Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
		OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
		Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
		OF_Listino__c l = PO_ServFatt_DataFactory.createListino(serv, 'P2PATTIVA_DEF');
		OF_CommercialElement__c ce = PO_ServFatt_DataFactory.createCE(serv, 'KIT di consegna', 'CE-001');
		OF_BillingElement__c beKit = PO_ServFatt_DataFactory.createBE(ce, 'KIT di consegna', 'BE-001');
		Pricebook2 pbKit = PO_ServFatt_DataFactory.createPriceBook(ce, beKit, l);
		Pricebook2 pb = [SELECT Id, PO_Commercial_element__r.Name FROM Pricebook2 WHERE Id = :pbKit.Id LIMIT 1];
		List<Pricebook2> pbList = new List<Pricebook2> {pb};
		Test.startTest();
		System.assertEquals(pb, PO_ServFatt_OpportunityHandler.removePBKit(pbList, cs.Name));
		System.assertEquals(null, PO_ServFatt_OpportunityHandler.removePBKit(pbList, null));
		Test.stopTest();
	}

	public static testMethod void testOppHandlerBTS() {
		PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createBTSData();

		Case origCase = [SELECT Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
						 EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c,
						 PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c,
						 PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c,
						 PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c,
						 PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
						 EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
						 OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
						 OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
						 EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
						 PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, PO_P2P_Attiva__c,
						 isPsm__c,isClosed,EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Costi_aggiuntivi_collegamento__c,
						 PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,PO_KIT_Consegna_VLAN__r.assetId,EOF_Codice_Ordine_OLO__c, AccountId,
						 OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, PO_Tipologia_Offerta_ordine__c, PO_Offerta__c // RDG
						 FROM Case WHERE Id = :data.caseCollegamento.Id LIMIT 1];

        initializeData(origCase);
		Test.startTest();
		Opportunity oc = PO_ServFatt_OpportunityHandler.createOppChild(origCase);
		Opportunity op = PO_ServFatt_OpportunityHandler.createOppParent(data.casePadre, new List<Case> {origCase}, oc);
		PO_ServFatt_OpportunityHandler.ricalculateOppParent(new Set<Id> {op.Id});
		Test.stopTest();
	}

	public static testMethod void testOppHandlerFiberLink() {
		PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createFiberLinkData();

		Case origCase = [SELECT Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
						 EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c,
						 PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c,
						 PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c,
						 PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c,
						 PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
						 EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
						 OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
						 OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,Billing_Competence__c,
						 EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
						 PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, PO_P2P_Attiva__c,
						 isPsm__c,isClosed,EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Costi_aggiuntivi_collegamento__c,
						 PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,PO_KIT_Consegna_VLAN__r.assetId,EOF_Codice_Ordine_OLO__c, AccountId,
						 OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, PO_Tipologia_Offerta_ordine__c, PO_Offerta__c // RDG
						 FROM Case WHERE Id = :data.caseCollegamento.Id LIMIT 1];
        
        initializeData(origCase);
		Test.startTest();
		Opportunity oc = PO_ServFatt_OpportunityHandler.createOppChild(origCase);
		Opportunity op = PO_ServFatt_OpportunityHandler.createOppParent(data.casePadre, new List<Case> {origCase}, oc);
		PO_ServFatt_OpportunityHandler.ricalculateOppParent(new Set<Id> {op.Id});
		Test.stopTest();
	}
    public static testMethod void testCircuitiDirettiList() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createFiberLinkData();
		List<Case> listCase = [SELECT Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
						 EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c,
						 PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c,
						 PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c,
						 PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c,
						 PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
						 EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
						 OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
						 OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
						 EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
						 PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, PO_P2P_Attiva__c,
						 isPsm__c,isClosed,EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Costi_aggiuntivi_collegamento__c,
						 PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,PO_KIT_Consegna_VLAN__r.assetId,EOF_Codice_Ordine_OLO__c, AccountId,
						 OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, PO_Tipologia_Offerta_ordine__c, PO_Offerta__c // RDG
						 FROM Case LIMIT 10];
						 
						 initializeData(listCase);
		Test.startTest();
		Opportunity op = PO_ServFatt_OpportunityHandler.createOppParent(data.casePadre, listCase);
		PO_ServFatt_OpportunityHandler.ricalculateOppParent(new Set<Id> {op.Id});
		Test.stopTest();
		
	}
	public static testMethod void testCircuitiDirettiList2() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createFiberLinkData();
		List<Case> listCase = [SELECT Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
						 EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c,
						 PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c,
						 PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c,
						 PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c,
						 PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
						 EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
						 OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
						 OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
						 EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
						 PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, PO_P2P_Attiva__c,
						 isPsm__c,isClosed,EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Costi_aggiuntivi_collegamento__c,
						 PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,PO_KIT_Consegna_VLAN__r.assetId,EOF_Codice_Ordine_OLO__c, AccountId,
						 OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, PO_Tipologia_Offerta_ordine__c, PO_Offerta__c // RDG
						 FROM Case LIMIT 10];
						 
						 initializeData(listCase);
		Test.startTest();
		List<Opportunity> ocList = PO_ServFatt_OpportunityHandler.createOppChild(listCase);
		Opportunity op = PO_ServFatt_OpportunityHandler.createOppParent(data.casePadre, listCase, ocList[0]);
		PO_ServFatt_OpportunityHandler.ricalculateOppParent(new Set<Id> {op.Id});
		Test.stopTest();
		
	}
    public static void initializeData(case c) {
        /*
        List <RecordType> recordTypeList= [SELECT Id, DeveloperName FROM RecordType];
        System.debug('***recordType: '+recordTypeList);
        */
        EOF_VLAN__c vlan = new EOF_VLAN__c(PO_Opzione__c='Flexible',Caso__c=c.id);
		insert vlan;
        /*
        RecordType recordType=new RecordType(id=c.recordtypeid,DeveloperName='PO_Collegamento_Circuiti_Diretti');
        
        insert recordType;
        */       
	}
    	public static void initializeData(List <Case> c) {
        /*
        List <RecordType> recordTypeList= [SELECT Id, DeveloperName FROM RecordType];
        System.debug('***recordType: '+recordTypeList);
        */
		List <EOF_VLAN__c> listVlan = new List <EOF_VLAN__c>();
		for (Case caso: c){
			EOF_VLAN__c vlan = new EOF_VLAN__c(PO_Opzione__c='Flexible',Caso__c=caso.id);
			listVlan.add(vlan);
		}	        
		insert listVlan;
        /*
        RecordType recordType=new RecordType(id=c.recordtypeid,DeveloperName='PO_Collegamento_Circuiti_Diretti');
        
        insert recordType;
        */        
	}
}
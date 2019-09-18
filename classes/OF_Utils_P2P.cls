public without sharing class OF_Utils_P2P {

	public static final String ESPLETATO_OK = 'Espletato OK';
	public static final String ESPLETATO_KO = 'Espletato KO';

	public static final String NOTIFICA_ORDINE = 'Ordine';
	public static final String NOTIFICA_KIT = 'Kit';
	public static final String SEDE_MASTER = 'Master';
    public static final String SEDE_SATELLITE = 'Satellite';

	private static PO_ServFatt_CRMHandler crmHandler;

    private OF_Utils_P2P() {

    }

	public static Boolean checkIsDOM(Case caseRqst, Datetime dataNotifica) {
		try {
			if(verifyIsDom(caseRqst, dataNotifica)) {
				caseRqst.isDOM__c = true;
				caseRqst.isPSM__c = false;
				update caseRqst;
				System.debug('##### checkIsDOM: case richiesta updated, id : ' + caseRqst.Id);
				return true;
			}
			return false;
		} catch (Exception e) {
			System.debug('##### checkIsDOM - error: ' + e.getMessage());
			return false;
		}
	}

    // return PSM or DOM
    public static String getDestinationSystem(Case caseRqst, Datetime dataNotifica) {
        if(verifyIsDom(caseRqst, dataNotifica)) {
            return 'DOM';
        } else {
            if('P2P Base'.equalsIgnoreCase(caseRqst.PO_Offerta__c)) {
                return 'PSM';
            } 
            if('P2P Attiva'.equalsIgnoreCase(caseRqst.PO_Offerta__c)) {
                return 'PO_NETWORK_CREATION';
            }
            return '';
        }
    }

    public static Boolean verifyIsDom(Case caseRqst, Datetime dataNotifica) {
        if(isSemaforoOn() && isConfigMatching(caseRqst, dataNotifica)) {
            return true;
        } 
		return false;
    }

    // METODI PER VERIFICA SISTEMA DESTINAZIONE

    // Verifica sul valore del campo Semaforo DOM, del record con nome 'Semaforo Proxy Portale Attivazione',
	//  del custom settings Semaforo Proxy Portale
    
	@testVisible
    private static Boolean isSemaforoOn() {       
        Map<String,Semaforo_Proxy_Portale__c> map_cSettings = Semaforo_Proxy_Portale__c.getAll();
		Semaforo_Proxy_Portale__c cSetting = map_cSettings.get('Semaforo Proxy Portale Attivazione');
		if(cSetting != null) {
			 System.debug('#####  Of_Utils_P2P.isSemaforoOn -- Semaforo Dom: ' + cSetting.Semaforo_DOM__c + 
					', name: Semaforo Proxy Portale Attivazione');
                return cSetting.Semaforo_DOM__c;
		} else {
			System.debug('#####  Of_Utils_P2P.isSemaforoOn -- custom setting: ' + cSetting);
			return false;
		}        
    }

    // Confronto fra variabili in input e valore dei campi del custom settings 
    // Configurazione DOM
    public static Boolean isConfigMatching(Case caseRqst, Datetime dataNotifica){
        String codiceOperatore = caseRqst.EOF_Codice_Operatore_WS__c;		
        String tipoServizio = caseRqst.PO_Offerta__c;
		System.debug('##### isConfigMatching: codice op - tipo servizio - data notifica : ' + 
		 	codiceOperatore + ' - ' + tipoServizio + ' - ' + dataNotifica);

        List<Configurazione_DOM__c> cSettings = Configurazione_DOM__c.getAll().values();
		Boolean check = false;

        if(!cSettings.isEmpty()) {			
			for(Configurazione_DOM__c setgs : cSettings) {
				if(setgs.Servizio_DOM__c.equalsIgnoreCase(tipoServizio)) {
					System.debug('##### Account_Dom : ' + setgs.Account_DOM__c + ' #####');
            		System.debug('##### Servizio_Dom : ' + setgs.Servizio_DOM__c + ' #####');
            		System.debug('##### Data_Dom : ' + setgs.Data_DOM__c + ' #####');
            		if(setgs.Account_DOM__c.equalsIgnoreCase(codiceOperatore) &&
                		setgs.Data_DOM__c <= dataNotifica) {
						check = true;
                		break;
            		}
				}
			}
		}		 
		System.debug('#####isConfigMatching -- check is: ' + check);
        return check;
    }

    // END - METODI PER VERIFICA SISTEMA DESTINAZIONE

    public static EOF_EAI_Service_Log__c writeLog(OF_StatusUpdate_P2P.Request rqst, OF_StatusUpdate_P2P.Response response) {
		System.debug('OF_Utils_P2P.writeLog');
	    EOF_EAI_Service_Log__c svcLog = new EOF_EAI_Service_Log__c();
         List<EOF_Notify__c> l_notify = [SELECT Name FROM EOF_Notify__c WHERE Id =: rqst.id_notifica];

        svcLog.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO_FATT_WS_ACK_NACK')
			.getRecordTypeId();
        svcLog.EOF_TIpo_comunicazione_String__c = 'DOM -> SFDC';
        svcLog.EOF_Stato_Richiesta__c = response.esito == '0' ? 'ACK' : 'NACK';
		if(!l_notify.isEmpty()) {
			svcLog.EOF_ID_Notifica__c = l_notify[0].Name;
		}        
		svcLog.Notify__c = rqst.id_notifica;
        svcLog.EOF_Codice_Ordine_OLO__c = rqst.id_fattibilita;
        svcLog.EOF_Richiesta_Notifica__c = String.valueOf(rqst);
		if(response.esito == '1') {
			svcLog.EOF_Codice_Errore__c = response.codice_motivazione;
        	svcLog.EOF_Causale_Errore__c = response.motivazione;
		}

        if(String.isBlank(response.motivazione)){
            svcLog.EOF_Data_Notifica__c = rqst.data_notifica;
        } else{
            if(!response.motivazione.contains('DATA_NOTIFICA')){
                svcLog.EOF_Data_Notifica__c = rqst.data_notifica;
            }
        }

        System.debug('svcLog:' + svcLog);

        List<Case> lCase = new List<Case>();
        lCase = [SELECT Id FROM Case WHERE EOF_Codice_Ordine_OLO__c =: rqst.id_fattibilita];
		if(!lCase.isEmpty()) {
			svcLog.Caso__c = lCase[0].Id;
		}
       

        insert svcLog;
        System.debug('EOF_EAI_ServiceLog__c inserito con id: ' + svcLog.Id);
		System.debug('##### OF_Utils_P2P.writeLog - attachament: ' + rqst.attachment);

        //Allego il file al Log
        if(rqst.attachment != null && rqst.attachment.size() > 0 && !String.isBlank(rqst.attachment_name)){ 
            List<Attachment> attchms = PO_FATT_WS_PSM_Notify_Utils.attachingFile(new List<Blob>{rqst.attachment}, 
                svcLog.id, new List<String>{rqst.attachment_name});
            
            insAttachmentList(attchms);
        }
        return svcLog;
    }

    public static OF_StatusUpdate_P2P.Response handleEspletamentoBase(OF_StatusUpdate_P2P.Request rqst, OF_StatusUpdate_P2P.Response response) {
        System.debug('doEspletamento - START');
        // capire quale campo usare per id della where condition
		try {

			// Controllo id_fattibilità
			Case deCaseFatt = getCaseBase(rqst.id_fattibilita);
			if (deCaseFatt == null) {
				System.debug('##### handleEspletamentoBase -- case not found -- id_fattibilita: ' + rqst.id_ordine);
		        return OF_CheckManager_P2P.buildResponseError(OF_CheckManager_P2P.TYPE_ERROR_CODE, 'id_fattibilita', rqst.id_notifica);
			}

			Case deCase = getCaseBase(rqst.id_ordine);
			if (deCase == null) {
				System.debug('##### handleEspletamentoBase -- case not found -- id_ordine: ' + rqst.id_ordine);
		        return OF_CheckManager_P2P.buildResponseError(OF_CheckManager_P2P.TYPE_ERROR_CODE, 'id_ordine', rqst.id_notifica);
			}

            try {
                if (rqst.stato_ordine.equals(PO_FATT_WS_PSM_Notify_Utils.STATO_ORDINE_2)) {
					System.debug('handleEspletamentoBase: deCase: ' + deCase);
					System.debug('##### OF_Utils_P2P.handleEspletamentoBase - attachament: ' + rqst.attachment);
                    callEspletamentoBaseHandlers(rqst, deCase, true);
					System.debug('##### OF_Utils_P2P.handleEspletamentoBase - attachament: ' + rqst.attachment);
					
                    // Preso da PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyEspletamento
					if(rqst.attachment != null && rqst.attachment.size() > 0 && !String.isBlank(rqst.attachment_name)){
						List<Attachment> listAttach = PO_FATT_WS_PSM_Notify_Utils.attachingFile(new list<Blob> {rqst.attachment},
							deCase.id, new list<String> {rqst.attachment_name});       
					
						listAttach.addAll(PO_FATT_WS_PSM_Notify_Utils.attachingFile(new list<Blob> {rqst.attachment}, 
							deCase.PO_Case_Collegamento__c, new list<String> {rqst.attachment_name}));

                    	insAttachmentList(listAttach);
					}
					
                }

                if (rqst.stato_ordine.equals(PO_FATT_WS_PSM_Notify_Utils.STATO_ORDINE_1)) {
                    callEspletamentoBaseHandlers(rqst, deCase, false);
                }
            } catch (Exception e) {
				System.debug('doEspletamento - Exception: ' + e);
				return OF_CheckManager_P2P.buildResponseError(OF_CheckManager_P2P.TECH_ERROR_CODE, '', rqst.id_notifica);
			}
		} catch (Exception e) {
			System.debug('doEspletamento - Exception: ' + e);
			return OF_CheckManager_P2P.buildResponseError(OF_CheckManager_P2P.TECH_ERROR_CODE, '', rqst.id_notifica);
		}
		return response;
    }

    private static List<Attachment> insAttachmentList(List<Attachment> attchms) {
        // TODO
	    // verificare se content type è corretto
        for(Attachment att : attchms) {
		    if(att.Name.contains('txt')) {			
				att.ContentType = 'text/plain';
			}
		}
        insert attchms;
        return attchms;
    }

    private static Case getCaseBase(String oloCode) {
        List<Case> lCase = new List<Case>();
		lCase = [SELECT Id, recordTypeId, Status, recordType.Name, recordType.DeveloperName, EOF_Fase__c, OF_SA_Profilo__c,
					PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
					EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Promozione__c,
					OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
					OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
					EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
					PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c, PO_KIT_Consegna_VLAN__c, PO_KIT_Consegna_VLAN__r.assetId,
					PO_Case_Collegamento__c, PO_Case_collegamento__r.OF_Order__c, PO_Tipo_percorso__c, PO_Offerta__c, PO_Tipologia_Offerta_ordine__c,
					PO_Nome_Comune__c, PO_Comune2__c, PO_Comune2__r.OF_Provincia__c, PO_Comune2__r.OF_Comune__c, EOF_Istat_Provincia__c, NS_Rif__c,
					EOF_Codice_Ordine_OLO__c, PO_Accordo_Quadro__c, PO_Comune__c, PO_Civico__c, PO_Indirizzo_collegamento__c, 
					Particella_Toponomastica_1__c
					FROM Case
					WHERE  EOF_Codice_Ordine_OLO__c =: oloCode LIMIT 1];

        return (lCase.isEmpty()) ? null : lCase[0];
        
    }

    private static void callEspletamentoBaseHandlers(OF_StatusUpdate_P2P.Request rqst, Case deCase, Boolean esitoOK) {
        PO_FATT_WS_IN_Espletamento obj_esp = new PO_FATT_WS_IN_Espletamento(deCase);
		PO_ServFattInfo cSetting = new PO_ServFattInfo();
		Map<String, ServFattList__c> srvFatt = cSetting.getEspletamentoPSMServiceMap();
        String recordTypeName = [SELECT DeveloperName FROM RecordType WHERE Id =: deCase.recordTypeId][0].DeveloperName;
		System.debug('##### OF_Utils_P2P.callEspletamentoBaseHandlers -- recordTypeName: ' + recordTypeName);
        PO_ServFatt_CRMHandler crmHand = new PO_ServFatt_CRMHandler(recordTypeName);

		if (rqst.stato_ordine.equals(PO_FATT_WS_PSM_Notify_Utils.STATO_ORDINE_2)) {
			deCase.EOF_Id_Risorsa__c = rqst.id_risorsa;
			//presente nel codice originale
			//deCase.PO_Data_Attivazione_Ordine__c = Date.valueOf(act.DATA_ESPLETAMENTO_ORDINE);
			try {
				if(String.isNotBlank(rqst.data_espletamento_ordine)) {
					deCase.PO_Data_Espletamento_Ordine__c = PO_FATT_WS_PSM_Notify_Utils.stringToDateNoTime(rqst.data_espletamento_ordine);
					System.debug('doEspletamento - STATO_ORDINE = 2 - data espletamento ' + deCase.PO_Data_Espletamento_Ordine__c );
				}
			} catch (Exception e) {
				System.debug('OF_Utils_P2P.callEspletamentoBaseHandlers: formato campo data_espletamento_ordine non corretto');
			}	 	
					
            if (srvFatt.containsKey(recordTypeName)) {
				System.debug('@@@ FD chiamata a metodo di espletamento di Ruben');				
				Id assetId = crmHand.espletamento(deCase, esitoOK);
				    
                System.debug('Espletamento <true> per il case [' + deCase.Id + '] - Esito: ' + (assetId != null));
			}
			else {
				obj_esp.espletamento_OK();
			}
		System.debug('UpdateNotifyEspletamento - DOPO espletamento');					
		}
		if (rqst.stato_ordine.equals(PO_FATT_WS_PSM_Notify_Utils.STATO_ORDINE_1)) {
			System.debug('doEspletamento - STATO_ORDINE = 1');
			
            if (srvFatt.containsKey(recordTypeName)) {
				crmHand.espletamento(deCase, esitoOK);
			}
			else{
				obj_esp.espletamento_KO();
			}
		}
    } 

	public static OF_StatusUpdate_P2P.Response handleEspletamentoAttiva(OF_StatusUpdate_P2P.Request rqst, OF_StatusUpdate_P2P.Response response) {
		String codOlo = NOTIFICA_ORDINE.equalsIgnoreCase(rqst.tipo_notifica) ? 
			rqst.id_ordine : rqst.id_ordine_kit;
		System.debug('##### OF_Utils_P2P.handleEspletamentoAttiva - tipo_notifica: ' + rqst.tipo_notifica);
        
        Case originalCase = getCaseAttiva(codOlo);
        if (originalCase == null) {
            if (NOTIFICA_ORDINE.equalsIgnoreCase(rqst.tipo_notifica)) {
                throw new IllegalRequestException(OF_CheckManager_P2P.TYPE_ERROR_CODE, 
                                                  OF_CheckManager_P2P.TYPE_ERROR_MSG.replace('xx', 'id_ordine'));
            } else {
                throw new IllegalRequestException(OF_CheckManager_P2P.TYPE_ERROR_CODE, 
                                                  OF_CheckManager_P2P.TYPE_ERROR_MSG.replace('xx', 'id_ordine_kit'));
            }		        
        }

        List<Case> coll = [SELECT tipologia_sede__c FROM Case WHERE Id =: originalCase.parentId];        
		if(rqst.stato_ordine.equals(PO_FATT_WS_PSM_Notify_Utils.STATO_ORDINE_2)) {
            espletamentoAttivaOK(originalCase, rqst.id_risorsa);
			
			// Aggiorno la vlan su tutti i collegamenti che non sono master. Copro anche i casi 
			// di E-access(non hanno sedi)
            if(NOTIFICA_ORDINE.equalsIgnoreCase(rqst.tipo_notifica) && !SEDE_MASTER.equals(coll[0].tipologia_sede__c)) {
                StatusUpdateP2PHelper helper = new StatusUpdateP2PHelper();
				
				if(!Test.isRunningTest()) {
					helper.updateVlan(rqst.id_ordine, rqst.svlan_id); 
				}
            }
            aggiornaLog(originalCase);
        } 
        // In questa fase dello sviluppo mi occupo solo di gestire stato_ordine = 2 (espl. OK)
        /* if(rqst.stato_ordine.equals(PO_FATT_WS_PSM_Notify_Utils.STATO_ORDINE_1)) {
		espletamentoAttivaKO(originalCase);
		} */ 
               
        return response;
    }

    // Replica di PO_ServiziFattibilita_Controller.espletamento
    private static Id espletamentoAttivaOK(Case originalCase, String idRisorsa) {
        system.debug('@@@@@@@@@@EC chiamiamo il metodo espletamento()');
	
		//gestione nuova P2P Attiva			
		if(originalCase.RecordType.DeveloperName == RTypeServFattibilita.CASE_P2P_ATTIVA_KIT) {
			return espletamentoKitFromDom(originalCase);
		} else {
			PO_ServFatt_CRMHandler crmh = new PO_ServFatt_CRMHandler(RTypeServFattibilita.CASE_P2P_ATTIVA_ORDINE);
			originalCase.EOF_Id_Risorsa__c = idRisorsa;
			return Test.isRunningTest() ? null : crmh.espletamento(originalCase, true);
		}		
    }

    private static Case getCaseAttiva(String oloCode) {
		System.debug('##### OF_Utils_P2P.getCaseAttiva -- OF_Codice_Ordine_OLO__c ' + oloCode);
        List<Case> lCase = new List<Case>();
        lCase = [SELECT Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
					  EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c, 
					  PO_Tipologia_Offerta__c, PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, 
					  PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c, PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, 
					  PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c, PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, 
					  PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c, PO_Lunghezza_m__c, Owner.Id, Owner.Type, 
					  Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
					  EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c,
					  OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, 
					  OF_SA_Codice_Motivazione__c, OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, 
					  EOF_Comune_WS__c, EOF_Provincia_WS__c, EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, 
					  EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c, PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, 
					  OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, PO_P2P_Attiva__c, isPsm__c,isClosed,
					  EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Costi_aggiuntivi_collegamento__c,
					  PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,PO_KIT_Consegna_VLAN__r.assetId,
					  EOF_Codice_Ordine_OLO__c, AccountId, OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, 
					  PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, 
					  PO_Tipologia_Offerta_ordine__c, PO_Offerta__c, PO_Posa_2_nuovo_Drop__c, PO_BB_2_interessato__c,
					  Previous_Status__c, Previous_Fase__c, PO_Comune__c, PO_Nome_Comune__c, PO_Comune2__c, PO_Comune2__r.OF_Provincia__c, 
					  PO_Comune2__r.OF_Comune__c, EOF_Istat_Provincia__c, PO_Indirizzo_collegamento__c, PO_Civico__c, NS_Rif__c, 
					  EOF_Istat_Comune__c, Particella_Toponomastica_1__c
					  FROM Case 
					  WHERE EOF_Codice_Ordine_OLO__c =: oloCode];
        System.debug('##### OF_Utils_P2P.getCaseAttiva -- listcase.size ' + lCase.size());
        return (lCase.isEmpty()) ? null : lCase[0];
    } 

	@testVisible
	private static Id espletamentoKitFromDom(Case caseKit) {
		System.debug('##### espletamentoKitFromDom - CaseId: ' + caseKit.Id);
		crmHandler = new PO_ServFatt_CRMHandler('PO_Ordine_P2P_Attiva');
		caseKit.Status = ESPLETATO_OK;
		caseKit.EOF_Fase__c = ESPLETATO_OK;
		caseKit.OF_AggiornoOrdine__c = true;
		caseKit.PO_Data_Espletamento_Ordine__c  = System.today();
		update caseKit;
		System.debug('##### Aggiornato caseKit: ' + caseKit.Id);
		System.debug('##### Aggiornato caseKit: ' + caseKit);
		System.debug('##### PO_KIT_Consegna_VLAN__c: ' + caseKit.PO_KIT_Consegna_VLAN__c);

		Map<String, Id> rtDevName_IdMap = PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();

		
		Case caseOrdine = getCaseOrdine(caseKit);
		System.debug('##### espletamentoKitFromDom - caseOrdine.OF_Order__c: ' + caseOrdine.OF_Order__c);
		Order orderCaseOrdine = getOrder(caseOrdine.OF_Order__c);
		String name = String.isNotBlank(orderCaseOrdine.OF_IDRisorsa__c) ? 
			orderCaseOrdine.OF_IDRisorsa__c : orderCaseOrdine.OF_IDOrdineEOF__c;

		Order orderKit = createOrderKit(caseKit, orderCaseOrdine, rtDevName_IdMap.get('OF_INORDER'), caseOrdine.OF_SA_Profilo__c);
		Asset assetKit = createAsset(orderKit, rtDevName_IdMap.get('PO_Asset_P2P_Attiva_KIT'), 
			orderKit.OF_IDRisorsa__c, caseKit, orderCaseOrdine.Contract.OF_Rinnovabile__c);


		List<OpportunityLineItem> oppLinItemList = [SELECT Id, PricebookEntryId, Price_Book__c, Price_Book__r.PO_Commercial_element__c, 
				Price_Book__r.PO_Commercial_element__r.Name, Price_Book__r.Billing_element__r.Name, Price_Book__r.Billing_element__c, 
				Quantity, Discount, ListPrice, PO_SalesPrice__c, TotalPrice, UnitPrice
			FROM OpportunityLineItem
			WHERE Opportunity.PO_Collegamento__c = :caseKit.PO_Case_Collegamento__c 
			AND Price_Book__c != null
			AND Price_Book__r.PO_Commercial_element__r.Name = 'KIT E-Access'];

		String ceiRtId = rtDevName_IdMap.get(crmHandler.getSrvData().ceiDevName__c);
		createBEI(assetKit, ceiRtId, oppLinItemList);

		update caseKit;

		System.debug('##### espletamentoKitFromDom - Fine Espletamento P2PAttiva - caseKit id: ' + caseKit.Id);
		return assetKit.Id;
	}

	private static Case getCaseOrdine(Case caseKit) {

		List<Case> l_ordine = [SELECT Id, OF_Order__c, OF_SA_Profilo__c FROM Case WHERE PO_KIT_Consegna_VLAN__c =: caseKit.Id
			AND RecordType.DeveloperName = 'PO_Ordine_P2P_Attiva'];
		System.debug('##### OF_Utils_P2P.getCaseOrdine: ordine associato al kit: ' + l_ordine);
		return (l_ordine.isEmpty()) ? null : l_ordine[0];
		
	}

	@testVisible
	private static Order getOrder(Id oId) {
		System.debug('##### getOrder -  caseOrdine.OF_Order__c: ' + oId);
		List<Order> l_order = [SELECT Id, ContractId, Contract.OF_Rinnovabile__c, Contract.NS_Rif__c, AccountId, RecordTypeId, Status, OF_Esito__c, OF_Apparato__c,
				   OF_Asset__c, OF_DataEsito__c, OF_EsitoConsegnaApparato__c, OF_ScalaPalazzina__c,
				   OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDOrdineEOF__c, OF_IDOrdineOLO__c,
				   OF_IDRisorsa__c, OF_IDSplitterSecondario__c, OF_IdentificativoDelPOP__c,
				   OF_Provincia__c, OF_Comune__c, OF_ParticellaToponomastica__c, OF_Indirizzo__c, OF_Civico__c,
				   OF_PosizioneSplitterSecondario__c, OF_SlaPremiumAssurance__c, OF_ClusterPromozione__c,
				   OF_CodiceProgettoSpeciale__c, OF_IDCaso__c, OF_IDServizio__c, OF_PasswordApparato__c,
				   OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c, OF_ProfiloOpenStream__c,
				   PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_LunghezzaOttica__c, OF_Profilo__c,
				   OF_DescrizioneKO__c, effectiveDate, CreatedDate, OF_IDContratto__c,
				   NS_Rif__c,  // FD 2019-02-27
				   PO_PosizioneRilascioCircuitoOSU__c, OF_CodiceKO__c, (SELECT Accordo_Operativo__c FROM Cases__r)
				   FROM Order WHERE Id =: oId];
		return (l_order.isEmpty()) ? null : l_order[0];
	}

	@testVisible
	private static Order createOrderKit(Case caseKit, Order o, String rtId, String profilo) {
		if (caseKit == null) {
			return null;
		}

		System.debug('createOrderKit for CaseKit: ' + caseKit.Id);

		Order orderKit = new Order();
		orderKit.recordtypeId = rtId;
		orderKit.OF_IdentificativoDelPOP__c = caseKit.EOF_Identificativo_del_POP__c;
		orderKit.OF_Esito__c = 'OK';
		orderKit.status = 'Chiuso';
		orderKit.OF_IDRisorsa__c = 'KIT_' + caseKit.EOF_Codice_Ordine_OLO__c; // caseKit.PO_PP_NomeKit__c; // Billing
		orderKit.OF_DataEsito__c = System.today(); // Billing
		orderKit.OF_IDOrdineOLO__c = caseKit.EOF_Codice_Ordine_OLO__c; // Billing
		orderKit.OF_Comune__c = o.OF_Comune__c; // Billing
		orderKit.OF_Provincia__c = o.OF_Provincia__c; // Billing
		orderKit.OF_Indirizzo__c = o.OF_Indirizzo__c; // Billing
		orderKit.OF_Civico__c = o.OF_Civico__c; // Billing
		orderKit.AccountId = o.AccountId; // Billing
		orderKit.ContractId = o.ContractId; // Billing
		orderKit.OF_ProfiloOpenStream__c = profilo;
		orderKit.effectiveDate = o.effectiveDate;
		orderKit.NS_Rif__c = String.isNotBlank(o.NS_Rif__c) ? o.NS_Rif__c : o.Contract.NS_Rif__c;
		if (o.PO_DataAttivazioneOrdine__c != null) {
			orderKit.PO_DataAttivazioneOrdine__c = o.PO_DataAttivazioneOrdine__c;
		}
		if (String.isNotBlank(o.OF_Profilo__c)) {
			orderKit.OF_Profilo__c = o.OF_Profilo__c;
		}

		insert orderKit;
		caseKit.OF_Order__c = orderKit.Id;

		return orderKit;
	}

	@testVisible
	private static Asset createAsset(Order o, String rtId, String name, Case caseOrig, Boolean rinnovable) {
		if ((caseOrig == null) || (o == null)) {
			return null;
		}

		System.debug('CreateAsset for order: ' + o.Id);
		Asset a = new Asset();
		a.recordTypeId = rtId;
		a.name = name;

		String slaPremium = String.isNotBlank(o.OF_SlaPremiumAssurance__c) ? o.OF_SlaPremiumAssurance__c : 'N';
		System.debug('@@@ FD o.NS_Rif__c ' + o.NS_Rif__c);
		System.debug('@@@ FD o.OF_Civico__c ' + o.OF_Civico__c);
		System.debug('@@@ FD o.OF_Comune__c ' + o.OF_Comune__c);
		System.debug('@@@ FD o.OF_Indirizzo__c ' + o.OF_Indirizzo__c);
		System.debug('@@@ FD o.OF_ParticellaToponomastica__c ' + o.OF_ParticellaToponomastica__c);
		a.OF_OrdineID__c = o.Id; // Billing
		a.EOF_ID_Risorsa__c = name; // Billing
		a.AccountId = o.AccountID; // Billing
		a.OF_Contract__c = o.ContractId; // Billing
		a.OF_ProfiloOpenStream__c = o.OF_ProfiloOpenStream__c; // Billing
		a.Status = 'Attivo'; // Billing
		a.OF_DataAttivazione2__c = System.now(); // Billing
		a.OF_Provincia__c = o.OF_Provincia__c; // Billing
		a.OF_Comune__c = o.OF_Comune__c; // Billing
		a.OF_Particella_Toponomastica__c = o.OF_ParticellaToponomastica__c; // Billing
		a.OF_Indirizzo__c = o.OF_Indirizzo__c; // Billing
		a.OF_Civico__c = o.OF_Civico__c; // Billing
		a.OF_ID_Building__c = o.OF_IDBuilding__c; // Billing
		a.OF_Identificativo_del_POP__c = o.OF_IdentificativoDelPOP__c;
		a.OF_GPON_Attestazione__c = o.OF_GPONAttestazione__c;
		a.OF_Scala_Palazzina__c = o.OF_ScalaPalazzina__c;
		a.OF_ServizioRichiesto__c = crmHandler.getSrvData().Name;
		a.EOF_ID_Splitter_Secondario__c = o.OF_IDSplitterSecondario__c;
		a.EOF_Posizione_Splitter_Secondario__c = o.OF_PosizioneSplitterSecondario__c;
		a.OF_ProgettoSpeciale__c = o.OF_ProgettoSpeciale__c;
		a.OF_IDCaseAttivazione__c = o.OF_IDCaso__c;
		a.OF_Promozione__c = o.OF_Promozione__c;
		a.OF_ClusterPromozione__c = o.OF_ClusterPromozione__c;
		a.OF_TipologiaApparato__c = o.OF_TipologiaApparato__c;
		a.OF_CodiceProgettoSpeciale__c = o.OF_CodiceProgettoSpeciale__c;
		a.OF_IDServizio__c = o.OF_IDServizio__c;
		a.EOF_SLA_Premium_Assurance__c = slaPremium;
		a.OF_Data_Accordo_Operativo__c = o.CreatedDate;
		a.NS_Rif__c = String.isNotBlank(o.NS_Rif__c) ? o.NS_Rif__c : o.Contract.NS_Rif__c; // FD 2019-02-27
		a.OF_DataScadenza__c = System.today().addYears(15);
		a.PO_Attenuazione__c = o.PO_Attenuazione__c;
		a.PO_LunghezzaOttica__c = Integer.valueOf(o.PO_LunghezzaOttica__c);
		a.PO_PosizioneRilascioCircuitoOSU__c = o.PO_PosizioneRilascioCircuitoOSU__c;
		a.OF_Rinnovabile__c = rinnovable;
		if (!o.Cases__r.isEmpty()) {
			a.Accordo_Operativo__c = o.Cases__r[0].Accordo_Operativo__c;
		}

		//Accordo Quadro da fare
		insert a;
		System.debug('Asset ID: ' + a.Id);
		o.OF_Asset__c = a.Id; // Billing
		caseOrig.AssetId = a.Id;

		// String className = String.valueOf(this).split(':')[0];

		try {
			update o;
			System.debug('Aggiornato ordine: ' + o.Id);
		} catch (Exception e) {
			Templog__c t = OF_Utility.logMessageNew2(o.OF_IDOrdineOLO__c,'E','PO_ServFatt_CRMHandler_' + 
				crmHandler.getSrvData().Name,'createAsset', 1, e);
			insert t;
			throw e;
		}

		return a;
	}

	private static List<PricebookEntry> createBEI(Asset a, String rtId, List<OpportunityLineItem> oppLinItemList) {
		Set<Id> ceIds = new Set<Id>();

		for (OpportunityLineItem oppLinItem : oppLinItemList) {
			ceIds.add(oppLinItem.Price_Book__r.PO_Commercial_element__c);
		}

		List<OF_CommercialElementIstanziato__c> ceiList = createCEI(a, rtId, ceIds);
		Map<Id, Id> mapCeIdCeiId = new Map<Id, Id>();
		for (OF_CommercialElementIstanziato__c cei : ceiList) {
			mapCeIdCeiId.put(cei.OF_CommercialElement__c, cei.Id);
		}

		System.debug('Create PBE for Asset: ' + a.Id);
		List<PricebookEntry> listPBE = new List<PricebookEntry>();
		List<Product2> listProd = new List<Product2>();
		Map<Id, PriceBookEntry> mapIdBePBE = new Map<Id, PriceBookEntry>();
		DateTime now = System.now();
		for (OpportunityLineItem oppLinItem : oppLinItemList) {
			PriceBookEntry pbe = new PriceBookEntry();
			pbe.Pricebook2Id = oppLinItem.Price_Book__c;
			pbe.IsActive = true;
			pbe.OF_DataAttivazione2__c = now;
			pbe.OF_Asset__c = a.Id;
			pbe.OF_CommercialElementIstanziato__c = mapCeIdCeiId.get(oppLinItem.Price_Book__r.PO_Commercial_element__c);
			pbe.UnitPrice = oppLinItem.UnitPrice;
			pbe.Quantity__c = oppLinItem.Quantity;
			pbe.UseStandardPrice = false;
			System.debug('@@@@@ PO_ServFatt_CRMHandler.createBEI pricebookentry pbe : ' + pbe);
			listPBE.add(pbe);
			mapIdBePBE.put(oppLinItem.Price_Book__r.Billing_element__c, pbe);

			Product2 p = PO_ServFatt_CRMHandler.createProduct(oppLinItem.Price_Book__r.Billing_element__c, oppLinItem.Price_Book__r.Billing_element__r.Name);
			listProd.add(p);
		}

		if (!listProd.isEmpty()) {
			Id pbsId = !Test.isRunningTest() ? [SELECT Id FROM Pricebook2 WHERE isStandard = true LIMIT 1].Id : Test.getStandardPricebookId();
			insert listProd;
			List<PricebookEntry> listPBES = new List<PricebookEntry>();
			for (Product2 p : listProd) {
				PriceBookEntry pbe = mapIdBePBE.get(p.OF_BillingElement__c);
				pbe.Product2Id = p.Id;
				listPBES.add(PO_ServFatt_CRMHandler.createPBES(p.Id, pbsId));
			}
			insert listPBES;
			insert listPBE;
		}
		return listPBE;
	}

	private static List<OF_CommercialElementIstanziato__c> createCEI(Asset a, String rtId, Set<Id> ceIds) {
		System.debug('Create CEI for Asset: ' + a.Id);

		Datetime now = System.now();
		List<OF_CommercialElementIstanziato__c> ceiList = new List<OF_CommercialElementIstanziato__c>();
		for (Id ce : ceIds) {
			OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
			cei.OF_CommercialElement__c = ce;
			cei.OF_Asset__c = a.Id;
			cei.OF_AssetTratta__c = a.Id;
			cei.RecordTypeId = rtId;
			cei.OF_BillingSyncronized__c = false; // flag per il billing
			cei.UpdateBilling__c = true; // flag per il billing
			cei.OF_Stato__c = 'Attivo';
			cei.OF_IDRisorsa__c = a.EOF_ID_Risorsa__c;
			cei.OF_DataAttivazione__c = now;
			ceiList.add(cei);
		}

		insert ceiList;
		return ceiList;
	}

	private static void aggiornaLog(Case theCase) {
		if (theCase == null) {
			return;
		}

		List<EOF_EAI_Service_Log__c> theLogsOrdini = [SELECT id, EOF_Stato_Richiesta__c, EOF_STATO_ORDINE__c, Caso__c
													  FROM EOF_EAI_Service_Log__c 
													  WHERE Caso__c = :theCase.Id];

		EOF_EAI_Service_Log__c theLogOrdine = null;
		if ((theLogsOrdini != null) && !theLogsOrdini.isEmpty()) {
			theLogOrdine = theLogsOrdini[0];
			theLogOrdine.EOF_STATO_ORDINE__c = theCase.Status;

			update theLogOrdine;
		}
	}
    
}
public without sharing class PO_FATT_WS_IN_PSM_Notify_Services {

	/**
	 * Author:	   Team Napoli
	 * Description:  Servizio INBOUD per cambiare lo stato del Case in Annullato.
	 */
	public static PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse UpdateNotifyAnnullamento (PO_FATT_WS_IN_PSM_Notify.PSM_Notify act) {
		try {
			List<Case> listCase = new List<Case>();
			system.debug('listCase---' + act);
			listCase = [SELECT Id,Status,OwnerId,EOF_Fase__c,CaseNumber,DAC_Prevista_OF__c,EOF_Note_Appuntamento__c,PO_FATT_History_Owner__c,
						EOF_Codice_Ordine_OLO__c, PO_Accordo_Quadro__c //FD 21-11-2018 CR Backhauling
						FROM Case WHERE CaseNumber =:act.CODICE_ORDINE limit 1];
			system.debug('listCase===>' + listCase);
			if (listCase.isEmpty()) {
				return PO_FATT_WS_PSM_Notify_Utils.syncErrorCodiceOrdine(act);
			}
			system.debug('test----' + listCase.get(0).Status);
			listCase.get(0).Status=PO_FATT_WS_PSM_Notify_Utils.CASE_STATUS_ANNULLATO;
			update listCase;
		} catch (Exception e) {
			return PO_FATT_WS_PSM_Notify_Utils.responseException(act,e);
		}
		return PO_FATT_WS_PSM_Notify_Utils.responseACK(act);
	}

	/**
	 * Author:	   Team Napoli
	 * Description:  Servizio INBOUD per ....
	 *
	 */
	public static PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse UpdateNotifyEspletamento (PO_FATT_WS_IN_PSM_Notify.PSM_Notify act) {
		system.debug('UpdateNotifyEspletamento - START');
		try {
			List<Case> listCase = new List<Case>();
			listCase = [SELECT Id, recordTypeId, Status, recordType.Name, recordType.DeveloperName, EOF_Fase__c, OF_SA_Profilo__c,
						PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
						EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Promozione__c,
						OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
						OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
						EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
						PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c, PO_KIT_Consegna_VLAN__c, PO_KIT_Consegna_VLAN__r.assetId,
						PO_Case_Collegamento__c, PO_Case_collegamento__r.OF_Order__c, PO_Tipo_percorso__c, PO_Offerta__c, PO_Tipologia_Offerta_ordine__c,
						PO_Nome_Comune__c, PO_Comune2__c, PO_Comune2__r.OF_Provincia__c, PO_Comune2__r.OF_Comune__c, EOF_Istat_Provincia__c, NS_Rif__c,
						EOF_Codice_Ordine_OLO__c, PO_Accordo_Quadro__c, //FD 21-11-2018 CR Backhauling
						PO_Comune__c, PO_Civico__c, PO_Indirizzo_collegamento__c //FD 2019-02-10 FIX Campi Asset
						FROM Case
						WHERE CaseNumber =:act.CODICE_ORDINE LIMIT 1];

			if (listCase.isEmpty()) {
				return PO_FATT_WS_PSM_Notify_Utils.syncErrorCodiceOrdine(act);
			}

			Case c = listCase.get(0);
			//FIX GB 21.05.2018 ID_CIRCUITO_2  start
			//Dalla call del 21.05.2018 è emersa una modifiche delle specifiche, in breve bisogna rilassere questo controllo e quindi tale ID_CIRCUITO_2 è required solo se TIPO_PERCORSO è Doppia via.
			if (PO_FATT_WS_PSM_Notify_Utils.CODICE_NOTIFICA_0.equals(act.CODICE_NOTIFICA) && String.isBlank(act.ID_CIRCUITO_2) && ( 'Doppia Via Diversificata' == c.PO_Tipo_percorso__c) ) {
				PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse tmp = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
				tmp.ID_NOTIFICA = act.ID_NOTIFICA;
				tmp.ESITO = PO_FATT_WS_PSM_Notify_Utils.ESITO_1;
				tmp.CODICE_MOTIVAZIONE = PO_FATT_WS_PSM_Notify_Utils.CODICE_MOTIVAZIONE_A05;
				tmp.MOTIVAZIONE = (PO_FATT_WS_PSM_Notify_Utils.MOTIVAZIONE_A05).replace('xxxx', 'ID_CIRCUITO_2');
				return tmp;
			}
			//FIX GB 21.05.2018 end

			PO_FATT_WS_IN_Espletamento obj_esp = new PO_FATT_WS_IN_Espletamento(c);
			PO_ServFattInfo cs = new PO_ServFattInfo();
			Map<String, ServFattList__c> srvFatt = cs.getEspletamentoPSMServiceMap();
			Savepoint sp = Database.setSavepoint();
			try {
				String recordTypeName = [SELECT DeveloperName FROM RecordType WHERE Id = :c.recordTypeId][0].DeveloperName;
				if (act.STATO_ORDINE.equals(PO_FATT_WS_PSM_Notify_Utils.STATO_ORDINE_0)) {
					c.EOF_Id_Risorsa__c = act.ID_RISORSA;
					c.PO_Data_Attivazione_Ordine__c = Date.valueOf(act.DATA_ESPLETAMENTO_ORDINE);
					system.debug('UpdateNotifyEspletamento - STATO_ORDINE = 0 - data espletamento ' + c.PO_Data_Attivazione_Ordine__c );
					if (srvFatt.containsKey(recordTypeName)) {
						System.debug('@@@ FD chiamata a metodo di espletamento di Ruben');
						PO_ServFatt_CRMHandler h = new PO_ServFatt_CRMHandler(recordTypeName);
						Id assetId = h.espletamento(c, true);
						System.debug('Espletamento <true> per il case [' + c.Id + '] - Esito: ' + (assetId != null));
						schedBillingJob(assetId, act.CODICE_ORDINE);
					}
					else {
						obj_esp.espletamento_OK();
					}
					system.debug('UpdateNotifyEspletamento - DOPO espletamento');

					//GB 30.05.2018  START
					//insert PO_FATT_WS_PSM_Notify_Utils.attachingFile(new list<Blob>{act.Attachment},c.id, new list<String>{act.ATTACHMENT_NAME}); //fix 23.05.2018
					List<Attachment> listaAttach=PO_FATT_WS_PSM_Notify_Utils.attachingFile(new list<Blob> {act.Attachment},c.id, new list<String> {act.ATTACHMENT_NAME});       //fix 23.05.2018
					listaAttach.addAll(PO_FATT_WS_PSM_Notify_Utils.attachingFile(new list<Blob> {act.Attachment},c.PO_Case_Collegamento__c, new list<String> {act.ATTACHMENT_NAME}));
					insert listaAttach;
					//GB 30.05.2018  END
				}
				if (act.STATO_ORDINE.equals(PO_FATT_WS_PSM_Notify_Utils.STATO_ORDINE_1)) {
					system.debug('UpdateNotifyEspletamento - STATO_ORDINE = 1');
					if (srvFatt.containsKey(recordTypeName)) {
						PO_ServFatt_CRMHandler h = new PO_ServFatt_CRMHandler(recordTypeName);
						h.espletamento(c, false);
					}
					else{
						obj_esp.espletamento_KO();
					}
				}
			}
			catch (Exception e) {
				system.debug('UpdateNotifyEspletamento - Exception:' + e);
				Database.rollback(sp);
				return PO_FATT_WS_PSM_Notify_Utils.responseWrongStatus(act);
			}
		}
		catch (Exception e) {
			return PO_FATT_WS_PSM_Notify_Utils.responseException(act,e);
		}
		return PO_FATT_WS_PSM_Notify_Utils.responseACK(act);

	}

	public static void schedBillingJob(String assetId, String caseNumber) {
		if (String.isBlank(assetId)) {
			return;
		}

		/*DateTime dt = System.now().addSeconds(1);
		   String nextFireTime = dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
		   List<String> idList = new List<String> {assetId};
		   OF_SyncBillingFattibilitaBatch_Sched sched = new OF_SyncBillingFattibilitaBatch_Sched(idList);
		   String schedJobName = 'SyncSrvFattEspl_' + caseNumber;

		   for (CronTrigger ct : [SELECT Id, CronJobDetail.Name, CronJobDetail.JobType
		                       FROM CronTrigger
		                       WHERE CronJobDetail.Name = :schedJobName LIMIT 1]) {

		    System.abortJob(ct.id);
		   }

		   System.schedule(schedJobName, nextFireTime, sched);*/
	}

	/**
	 * Author:	   Team Napoli
	 * Description:  Servizio INBOUD per aggiornare i campi:
	 *			   OwnerId, PO_FATT_History_Owner__c, DAC_Prevista_OF__c, EOF_Note_Appuntamento__c, EOF_Fase__c
	 */
	public static PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse UpdateNotifyRimodDAC (PO_FATT_WS_IN_PSM_Notify.PSM_Notify act) {
		try {
			List<Case> listCase = new List<Case>();
			listCase = [SELECT Id,Status,OwnerId,EOF_Fase__c,CaseNumber,DAC_Prevista_OF__c,EOF_Note_Appuntamento__c,PO_FATT_History_Owner__c, PO_Data_Attivazione_Richiesta__c,
						EOF_Codice_Ordine_OLO__c, PO_Accordo_Quadro__c //FD 21-11-2018 CR Backhauling
						FROM Case WHERE CaseNumber =:act.CODICE_ORDINE limit 1];
			System.debug('@@@listCase' + listCase);
			if (listCase.isEmpty()) {
				return PO_FATT_WS_PSM_Notify_Utils.syncErrorCodiceOrdine(act);

			}

			Case c = listCase.get(0);
			System.debug('Testing1');
			if ((PO_FATT_WS_PSM_Notify_Utils.CASE_STATUS_IN_LAVORAZIONE).equals(c.Status) &&
			    //GB 30.05.2018  (PO_FATT_WS_PSM_Notify_Utils.EOF_FASE_IN_LAVORAZIONE_NETWORK_CREATION).equals(c.EOF_Fase__c) &&
				!String.isblank(c.PO_FATT_History_Owner__c))
			{
				if (Date.valueOf(act.DATA_PREVISTA_ATTIVAZIONE) < Date.valueOf(c.PO_Data_Attivazione_Richiesta__c)) { //da portare in sviluppo
					return PO_FATT_WS_PSM_Notify_Utils.syncErrorDataPrevistaAttivazione(act);
				}else{
					System.debug('entering');
					c.OwnerId = c.PO_FATT_History_Owner__c;
					//c.PO_FATT_History_Owner__c=PO_FATT_WS_PSM_Notify_Utils.VUOTA;
					c.DAC_Prevista_OF__c= Date.valueOf(act.DATA_PREVISTA_ATTIVAZIONE);
					c.EOF_Note_Appuntamento__c=act.MOTIVAZIONE_RIMODULAZIONE_DAC;
					//c.EOF_Fase__c=PO_FATT_WS_PSM_Notify_Utils.EOF_FASE_RIMODULAZIONE_DAC; vedi email con marianna del 19.05.2018
					c.EOF_Fase__c=PO_FATT_WS_PSM_Notify_Utils.EOF_FASE_IN_LAVORAZIONE_SUPPORTO_VENDITE;
					update listCase;
				}
			}else{
				return PO_FATT_WS_PSM_Notify_Utils.responseWrongStatus(act);
			}
		}catch (Exception e) {
			System.debug('@@@e' + e.getmessage());
			return PO_FATT_WS_PSM_Notify_Utils.responseException(act,e);
		}
		return PO_FATT_WS_PSM_Notify_Utils.responseACK(act);
	}


	/**
	 * Author:	   Team Napoli
	 * Description:  Servizio INBOUD per aggiornare: Case,Asset ed CommercialElementIstanziato.
	 *
	 */
	public static PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse UpdateNotifyCessazione (PO_FATT_WS_IN_PSM_Notify.PSM_Notify act) {
		try {
			List<Case> listCase = new List<Case>();
			listCase = [select Id,Status,Asset.Id,ClosedDate,
						EOF_Codice_Ordine_OLO__c, PO_Accordo_Quadro__c //FD 21-11-2018 CR Backhauling
						FROM Case WHERE CaseNumber =:act.CODICE_ORDINE AND Asset.Name =:act.ID_RISORSA limit 1];
			if (listCase.isEmpty()) {
				return PO_FATT_WS_PSM_Notify_Utils.syncErrorCodiceOrdine(act);
			}

			Case c = listCase.get(0);
			if ((PO_FATT_WS_PSM_Notify_Utils.CASE_STATUS_ESPLETATO).equals(c.Status)) {
				c.Status=PO_FATT_WS_PSM_Notify_Utils.CASE_STATUS_CESSATO;
				//c.ClosedDate=DateTime.valueOf(act.DATA_ESPLETAMENTO_ORDINE); TO DO: capire con marianna quale campo aggiornare
			}else{
				return PO_FATT_WS_PSM_Notify_Utils.responseWrongStatus(act);
			}

			List<Asset> listAsset= new List<Asset>();
			listAsset = [select id,Status,OF_DataCessazione__c,OF_DataCessazione2__c from Asset WHERE Id =:c.Asset.Id];
			system.debug('####' + listAsset);
			if ((PO_FATT_WS_PSM_Notify_Utils.ASSET_STATUS_ATTIVO).equals(listAsset.get(0).Status)) {
				listAsset.get(0).OF_DataCessazione__c=Date.valueOf(act.DATA_ESPLETAMENTO_ORDINE);
				Date dTo = Date.valueOf(act.DATA_ESPLETAMENTO_ORDINE);
				listAsset.get(0).OF_DataCessazione2__c=datetime.newInstance(dTo.year(), dTo.month(),dTo.day());
				listAsset.get(0).Status=PO_FATT_WS_PSM_Notify_Utils.ASSET_STATUS_CESSATO;
			}else{
				return PO_FATT_WS_PSM_Notify_Utils.responseWrongStatus(act);
			}

			List<OF_CommercialElementIstanziato__c> listComElemIstan=new List<OF_CommercialElementIstanziato__c>();
			listComElemIstan = [select id,OF_Stato__c,OF_Asset__c, OF_Case__c,OF_DataCessazione__c from OF_CommercialElementIstanziato__c WHERE OF_Case__r.Id =:c.Id AND OF_Asset__r.Id=:listAsset.get(0).Id];
			if ((PO_FATT_WS_PSM_Notify_Utils.COM_ELEM_IST_STATUS_ATTIVO).equals(listComElemIstan.get(0).OF_Stato__c)) {
				Date dTo = Date.valueOf(act.DATA_ESPLETAMENTO_ORDINE);
				listComElemIstan.get(0).OF_DataCessazione__c=datetime.newInstance(dTo.year(), dTo.month(),dTo.day());
				listComElemIstan.get(0).OF_Stato__c=PO_FATT_WS_PSM_Notify_Utils.COM_ELEM_IST_STATUS_CESSATO;
			}else{
				return PO_FATT_WS_PSM_Notify_Utils.responseWrongStatus(act);
			}

			update listComElemIstan;
			update listAsset;
			update listCase;
		}catch (Exception e) {
			return PO_FATT_WS_PSM_Notify_Utils.responseException(act,e);
		}
		return PO_FATT_WS_PSM_Notify_Utils.responseACK(act);
	}

}
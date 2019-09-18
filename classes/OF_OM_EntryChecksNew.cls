public class OF_OM_EntryChecksNew {
	//Status Update Attivi
	public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse SyncChecksNotifyStatusUpdate(OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su){
		
		// Aggiorno il timestamp. SU.1 corrisponde a inizio check Status Update.
		OF_SA_GE_UtilsNew.partialTemplog('SU.1');
		// finisce qui	   
		
		if(string.isblank(su.CODICE_OPERATORE)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','CODICE_OPERATORE');
		  }else if(su.CODICE_OPERATORE.length()>3){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_OPERATORE');
		}	
		
		Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		Boolean olo_found = false;
		for(Schema.PicklistEntry s : ple){
			if(su.CODICE_OPERATORE == s.getLabel()){
				olo_found = true;
			}
		} 
		if(!olo_found){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_OPERATORE');   
		}
		
		if(string.isblank(su.CODICE_ORDINE_OLO)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','CODICE_ORDINE_OLO');
		  }else if(su.CODICE_ORDINE_OLO.length()>18){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_ORDINE_OLO');
		} 
		
		if(string.isblank(su.CODICE_ORDINE_OF)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','CODICE_ORDINE_OF');
		}else if(su.CODICE_ORDINE_OF.length()>18){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_ORDINE_OF');
		} 
		
		if(string.isblank(su.STATO_ORDINE)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','STATO_ORDINE');
		}
		if(su.STATO_ORDINE!='0' && su.STATO_ORDINE!='2'
			&& su.STATO_ORDINE!='3' && su.STATO_ORDINE!='4' 
			&& su.STATO_ORDINE!='5' && su.STATO_ORDINE!='6' 
			&& su.STATO_ORDINE!='7' 
		){			
			return OF_SA_GE_UtilsNew.syncError (su,'A06','STATO_ORDINE');
		}
		
		List<Case> cList;
		if(su.STATO_ORDINE=='6' || su.STATO_ORDINE=='7'){			
			// Aggiorno il timestamp. QSU.1 corrisponde a pre query.
			OF_SA_GE_UtilsNew.partialTemplog('QSU.1');
			// finisce qui			
			// 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni			
			cList = [SELECT id,status,PO_SA_Portale__C,RecordType.DeveloperName,AssetId,OF_Order__c,Previous_Status__c,OF_Blocked_Case__c, EOF_Codice_Ordine_OLO__c,EOF_Id_Risorsa__c,
					EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c,
					OF_Esito_Consegna_Apparato__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, PO_Comune__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
					EOF_Particella_Toponomastica_WS__c, PO_Indirizzo_collegamento__c, EOF_Indirizzo_WS__c, PO_Civico__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c,
					OF_SA_Profilo__c, OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c
					FROM Case 
					WHERE EOF_codice_Ordine_OLO__c = :su.CODICE_ORDINE_OLO 
					AND Codice_Ordine_Eof__C = :su.codice_ordine_of 
					AND EOF_Codice_Operatore_WS__c = :su.CODICE_OPERATORE
					AND RecordType.DeveloperName ='OF_SA_Cessazione'];
		}else{			
			// Aggiorno il timestamp. QSU.1 corrisponde a pre query.
			OF_SA_GE_UtilsNew.partialTemplog('QSU.1');
			// finisce qui
			 
			// 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni			
			cList = [SELECT id,status,PO_SA_Portale__C,RecordType.DeveloperName,OF_Order__c,Previous_Status__c,OF_Blocked_Case__c, EOF_Codice_Ordine_OLO__c,EOF_Id_Risorsa__c,
					EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c,
					OF_Esito_Consegna_Apparato__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, PO_Comune__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
					EOF_Particella_Toponomastica_WS__c, PO_Indirizzo_collegamento__c, EOF_Indirizzo_WS__c, PO_Civico__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c,
					OF_SA_Profilo__c, OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c
					FROM Case 
					WHERE EOF_codice_Ordine_OLO__c = :su.CODICE_ORDINE_OLO 
					AND Codice_Ordine_Eof__C = :su.codice_ordine_of 
					AND EOF_Codice_Operatore_WS__c = :su.CODICE_OPERATORE 
					AND RecordType.DeveloperName ='OF_SA_Attivazione'];
		}		 
		// Aggiorno il timestamp. QSU.2 corrisponde a post query.
		OF_SA_GE_UtilsNew.partialTemplog('QSU.2');
		// finisce qui		
		
		if(cList.isEmpty()){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
		}else{
			OF_SA_GE_UtilsNew.caseOriginale = cList[0];
			OF_SA_GE_UtilsNew.checkCaseOriginale = true;
		}
		//Done AA - 02/10/2018 - Controllare se il campo "OF_Blocked_Case__c" è valorizzato a true
		//TODO AA - 02/10/2018 - Condividere codice errore per blocked case
		if(OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c){//C'è qualche status update dall'olo non notificato all'OM
			return OF_SA_GE_UtilsNew.syncError (su,'A07','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
		} 
		if(string.isblank(su.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','DATA_NOTIFICA');
		}else if(!OF_SA_GE_UtilsNew.checkDateTime(su.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','DATA_NOTIFICA');
		}
		
		if(string.isblank(su.ID_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','ID_NOTIFICA');
		}else if(su.ID_NOTIFICA.length()>100){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','ID_NOTIFICA');
		}
		
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='Espletato' || OF_SA_GE_UtilsNew.caseOriginale.status == 'Espletato KO' || OF_SA_GE_UtilsNew.caseOriginale.status =='Acquisito KO' || OF_SA_GE_UtilsNew.caseOriginale.status =='Cessato KO' || OF_SA_GE_UtilsNew.caseOriginale.status =='Cessato' || OF_SA_GE_UtilsNew.caseOriginale.status =='Annullato' || OF_SA_GE_UtilsNew.caseOriginale.status =='Inviato'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='In Annullamento' && su.STATO_ORDINE!='5'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='Sospeso' && su.STATO_ORDINE!='0' && su.STATO_ORDINE!='2'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='Acquisito' && OF_SA_GE_UtilsNew.caseOriginale.RecordType.DeveloperName=='OF_SA_Attivazione' && su.STATO_ORDINE!='2' && su.STATO_ORDINE!='3' && su.STATO_ORDINE!='4'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='Acquisito' && OF_SA_GE_UtilsNew.caseOriginale.RecordType.DeveloperName=='OF_SA_Cessazione' && su.STATO_ORDINE!='6' && su.STATO_ORDINE!='7'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='Accettato' && su.STATO_ORDINE!='4'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}	  
		
		if(su.STATO_ORDINE!='0' && su.STATO_ORDINE!='2'){
			//casi in cui la motivazione è obbligatoria
			if(string.isblank(su.CODICE_MOTIVAZIONE)){
				return OF_SA_GE_UtilsNew.syncError (su,'A05','CODICE_MOTIVAZIONE');
			}
			if(string.isblank(su.MOTIVAZIONE)){
				return OF_SA_GE_UtilsNew.syncError (su,'A05','MOTIVAZIONE');
			}			
		}
		if(!string.isblank(su.CODICE_MOTIVAZIONE) && su.CODICE_MOTIVAZIONE.length()>3){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_MOTIVAZIONE');
		}		  
		
		if(!string.isblank(su.MOTIVAZIONE) && su.MOTIVAZIONE.length()>255){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','MOTIVAZIONE');
		}		 
		
		if(!string.isblank(su.GPON_DI_ATTESTAZIONE) && su.GPON_DI_ATTESTAZIONE.length()>14){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','GPON_DI_ATTESTAZIONE');
		}		
		
		if(su.STATO_ORDINE=='4'){
		if(!string.isblank(su.NOME_CLIENTE) && su.NOME_CLIENTE.length()>20){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','NOME_CLIENTE');
		}		
		
		if(!string.isblank(su.COGNOME_CLIENTE) && su.COGNOME_CLIENTE.length()>70){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','COGNOME_CLIENTE');
		}		
		
		if(!string.isblank(su.RECAPITO_TELEFONICO_CLIENTE) && su.RECAPITO_TELEFONICO_CLIENTE.length()>20){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','RECAPITO_TELEFONICO_CLIENTE');
		}				
		
		if(!string.isblank(su.DATA_PREVISTA_ATTIVAZIONE) && !OF_SA_GE_UtilsNew.checkDate(su.DATA_PREVISTA_ATTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','DATA_PREVISTA_ATTIVAZIONE');
		}				
		
		if(!string.isblank(su.ORARIO_APPUNTAMENTO) && !OF_SA_GE_UtilsNew.checkTime(su.ORARIO_APPUNTAMENTO)){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','ORARIO_APPUNTAMENTO');
		}
		}
		if(!string.isblank(su.PIN_INTERVENTO_A_VUOTO) && su.PIN_INTERVENTO_A_VUOTO.length()>8){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','PIN_INTERVENTO_A_VUOTO');
		}
		
		if(!string.isblank(su.NOTE) && su.NOTE.length()>255){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','NOTE');
		}
		//Controllo ID_SERVIZIO OBB SOLO PER STATO ORDINE = 2
		if(su.STATO_ORDINE == '2'){
			if(String.isBlank(su.ID_SERVIZIO)){
				return OF_SA_GE_UtilsNew.syncError (su,'A05','ID_SERVIZIO');
			}else if(su.ID_SERVIZIO.length()>50){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','ID_SERVIZIO');
			}
			//Nuovo campo FLAG_DESOSPENSIONE
			/*TODO AA COMMENTATO MOMENTANEAMENTE COME RICHIESTO DA CARLO
				POICHè I RAGAZZI DI TIBCO NON ERANO PRONTI
			if(String.isBlank(su.FLAG_DESOSPENSIONE)){
				return OF_SA_GE_UtilsNew.syncError (su,'A05','FLAG_DESOSPENSIONE');
			}else if(su.FLAG_DESOSPENSIONE.length() > 10 || (su.FLAG_DESOSPENSIONE != 'SI' && su.FLAG_DESOSPENSIONE != 'NO')){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','FLAG_DESOSPENSIONE');
			}*/
		}			
		if(su.STATO_ORDINE == '0'){
			//Nuovo campo FLAG_DESOSPENSIONE
			/*TODO AA COMMENTATO MOMENTANEAMENTE COME RICHIESTO DA CARLO
				POICHè I RAGAZZI DI TIBCO NON ERANO PRONTI
			if(String.isBlank(su.FLAG_DESOSPENSIONE)){
				return OF_SA_GE_UtilsNew.syncError (su,'A05','FLAG_DESOSPENSIONE');
			}else if(su.FLAG_DESOSPENSIONE.length() > 10 || (su.FLAG_DESOSPENSIONE != 'SI' && su.FLAG_DESOSPENSIONE != 'NO')){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','FLAG_DESOSPENSIONE');
			}*/
		}
		if(String.isNotBlank(su.ID_SERVIZIO) && su.ID_SERVIZIO.length()>50){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','ID_SERVIZIO');
		}
		if(String.isNotBlank(su.FLAG_DESOSPENSIONE)){
			if(su.FLAG_DESOSPENSIONE.length() > 10 || (su.FLAG_DESOSPENSIONE != 'SI' && su.FLAG_DESOSPENSIONE != 'NO')){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','FLAG_DESOSPENSIONE');
			}
		}
		if(String.isNotBlank(su.REMOTE_ID) && su.REMOTE_ID.length() > 50){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','REMOTE_ID');
		}
		//CRM Modifica 16_06_2017
		Map<String,List<String>> mapTipologiaEsito = new Map<String,List<String>>();
		//fine
		
		if(su.APPARATO!=null && !su.APPARATO.isempty()){  
			for(OF_WS_IN_OM_StatusUpdateNew.APPARATO ra : su.APPARATO){
				
				
				if(string.isblank(ra.TIPOLOGIA_APPARATO)){
					return OF_SA_GE_UtilsNew.syncError (su,'A05','TIPOLOGIA_APPARATO'); 
				}else if(ra.TIPOLOGIA_APPARATO.length()>100){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','TIPOLOGIA_APPARATO');
				}
				if(string.isblank(ra.ESITO_RITIRO_APPARATO)){
					return OF_SA_GE_UtilsNew.syncError (su,'A05','ESITO_RITIRO_APPARATO');
				}else if(ra.ESITO_RITIRO_APPARATO.length()>1) {
					return OF_SA_GE_UtilsNew.syncError (su,'A06','ESITO_RITIRO_APPARATO'); 
				}
				if(!string.isblank(ra.CODICE_MOTIVAZIONE_RITIRO) && ra.CODICE_MOTIVAZIONE_RITIRO.length()>3){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_MOTIVAZIONE_RITIRO');
				}
				if(!string.isblank(ra.MOTIVAZIONE_RITIRO) && ra.MOTIVAZIONE_RITIRO.length()>255){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','MOTIVAZIONE_RITIRO');
				}
				if(String.isNotBlank(ra.ID_APPARATO) && ra.ID_APPARATO.length()>50){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','ID_APPARATO');
				}
				List<String> cpeEsitoRitiroList = mapTipologiaEsito.get(ra.TIPOLOGIA_APPARATO.toUpperCase());
				if(cpeEsitoRitiroList == null){
					cpeEsitoRitiroList = new List<String>();
				}
				cpeEsitoRitiroList.add(ra.ESITO_RITIRO_APPARATO);
				//CRM Modifica 16_06_2017
				mapTipologiaEsito.put( ra.TIPOLOGIA_APPARATO.toUpperCase() , cpeEsitoRitiroList );
				//fine
			}			
		}		
		
		if(su.VLAN!=null && !su.VLAN.isempty()){
			for(OF_WS_IN_OM_StatusUpdateNew.VLAN vn : su.VLAN){
				
				if(string.isblank(vn.USER_VLAN)){
					return OF_SA_GE_UtilsNew.syncError (su,'A05','USER_VLAN');
				}else if(vn.USER_VLAN.length()>4){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','USER_VLAN');
				}
				if(string.isblank(vn.SERVICE_VLAN)){
					return OF_SA_GE_UtilsNew.syncError (su,'A05','SERVICE_VLAN');
				}else if(vn.SERVICE_VLAN.length()>4){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','SERVICE_VLAN');
				}
				if(string.isblank(vn.CUSTOMER_VLAN)){
					return OF_SA_GE_UtilsNew.syncError (su,'A05','CUSTOMER_VLAN');
				}else if(vn.CUSTOMER_VLAN.length()>4){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','CUSTOMER_VLAN');
				}
			}
		}
		if(string.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c) && (su.stato_ordine=='0' || su.stato_ordine=='2')){
			// 30/01/2018 Marco : Modifica riconoscimento log desospensione
			system.debug('30/01/2018 Marco : il previous status nella OM entrychecks è:'+ OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c);				
			if(string.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c)){
				OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c='';
				OF_SA_GE_UtilsNew.desospendi= true;					
			}
			system.debug('30/01/2018 Marco2 : il previous status nella OM Entrychecks dopo è:'+ OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c);
			system.debug('30/01/2018 Marco2 : desospendi nella OM Entrychecks è:'+ OF_SA_GE_UtilsNew.desospendi);					
			// 30/01/2018 Marco : fine modifica
			
		}
		
		List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>(); 
		//Done AA - Ricreare metodo async
		//Mi vado a salvare il camp flag desospensione
		OF_SA_GE_UtilsNew.caseOriginale.OF_Flag_Desospensione__c = su.FLAG_DESOSPENSIONE;
		OF_SA_GE_UtilsNew.caseOriginale.OF_Remote_ID__c = su.REMOTE_ID;
		Map<String,EOF_EAI_Service_Log__c> responseFromOLO = OF_OM_AsyncChecksNew.OM_AsyncStatusUpdateNew(OF_SA_GE_UtilsNew.caseOriginale, su);
		
		if(responseFromOLO.containsKey('0')) {
			
			
			slList.add(responseFromOLO.get('0'));
			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
				'Codice_operatore' => su.CODICE_OPERATORE,
				'Codice_ordine_OLO' => su.CODICE_ORDINE_OLO,
				'Flusso' => 'OM-SF',
				'Metodo' => 'OF_StatusUpdate',
				'ID_notifica' => su.ID_NOTIFICA,
				'Tipo Comunicazione' => 'OM->SF - ACK - StatusUpdate',
				'Caso' => OF_SA_GE_UtilsNew.caseOriginale.Id,
				'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;
			
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOM = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
			responseToOM.esito='0';
			
			//aggiorno il Case
			//vado in sovrascrittura del campo customer vlan identificandolo dalla coppia user vlan e service vlan
			if(su.VLAN!=null && !su.VLAN.isempty()){
				List<OF_CommercialElementIstanziato__c> vlanASistema= [select Id,OF_CustomerVLAN__c, OF_ServiceVLAN__c,OF_UserVLAN__c 
																	   from OF_CommercialElementIstanziato__c where recordtype.developerName='OF_VLAN'
																	   AND OF_SA_VLAN__c=:OF_SA_GE_UtilsNew.caseOriginale.Id];
				if(!vlanASistema.isEmpty()){
					List<OF_CommercialElementIstanziato__c> vlanToUpdate = new List<OF_CommercialElementIstanziato__c>();
					for(OF_WS_IN_OM_StatusUpdateNew.VLAN vn : su.VLAN){
						for(OF_CommercialElementIstanziato__c vnASistema : vlanASistema){
							if(vnASistema.OF_ServiceVLAN__c.toUpperCase()==vn.SERVICE_VLAN.toUpperCase() && vnASistema.OF_UserVLAN__c.toUpperCase()==vn.USER_VLAN.toUpperCase()){
								vnASistema.OF_CustomerVLAN__c=vn.CUSTOMER_VLAN;
								vlanToUpdate.add(vnASistema);
							}
						}
						
					}
					if(!vlanToUpdate.isEmpty()){
						update vlanToUpdate;
					}
				}
				
			}
			
			if(su.stato_ordine=='0'){
				
				
				OF_SA_GE_UtilsNew.caseOriginale.Status='Acquisito';
				if(!string.isBlank(su.DATA_PREVISTA_ATTIVAZIONE)){
					if(!string.isBlank(su.ORARIO_APPUNTAMENTO)){
						Time t = Time.newInstance(Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(3,5)),
												  Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(6,8)), 0);							
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), t );					
					}
					else{
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));	
					}
				}
			}
			
			if(su.stato_ordine=='1'){
				OF_SA_GE_UtilsNew.caseOriginale.Status='Acquisito KO';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE; 
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
				
			}
			
			if(su.stato_ordine=='2'){
				
				
				OF_SA_GE_UtilsNew.caseOriginale.Status='Accettato';
				if(!string.isBlank(su.DATA_PREVISTA_ATTIVAZIONE)){
					if(!string.isBlank(su.ORARIO_APPUNTAMENTO)){
						Time t = Time.newInstance(Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(3,5)),
												  Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(6,8)), 0);							
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), t );					
					}
					else{
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));	
					}
				}
			}
			
			if(su.stato_ordine=='3'){
				OF_SA_GE_UtilsNew.caseOriginale.Status='Accettato KO';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
			}
			
			if(su.stato_ordine=='4'){
				
				// 30/01/2018 Marco : Modifica salvataggio status su campo apposito
				OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c= OF_SA_GE_UtilsNew.caseOriginale.Status;
				system.debug('30/01/2018 Marco : il previous status nella OM entrychecks per sospensione è:'+ OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c);				
				// 30/01/2018 Marco : fine modifica
				
				OF_SA_GE_UtilsNew.caseOriginale.Status='Sospeso';
				if(!string.isBlank(su.DATA_PREVISTA_ATTIVAZIONE)){
					if(!string.isBlank(su.ORARIO_APPUNTAMENTO)){
						Time t = Time.newInstance(Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(3,5)),
												  Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(6,8)), 0);							
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), t );					
					}
					else{
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));	
					}
				}
				
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
			}
			
			if(su.stato_ordine=='5'){
				OF_SA_GE_UtilsNew.caseOriginale.Status='Annullato';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
				
			}
			
			if(su.stato_ordine=='6'){
				OF_SA_GE_UtilsNew.caseOriginale.Status='Cessato';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
			}
			
			if(su.stato_ordine=='7'){
				OF_SA_GE_UtilsNew.caseOriginale.Status='Cessato KO';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
				
			}
			
			//CRM Modifica 16_06_2017
			if( su.stato_ordine == '6'){   
				system.debug('***AA: STATO ORDINE 6 !! CESSATO!');
				List<OF_CommercialElementIstanziato__c> CEIstToUpdate = new List<OF_CommercialElementIstanziato__c>();
			 
				List<OF_CommercialElementIstanziato__c> listCEIst = [select id,(select id,OF_TipologiaApparato__c,OF_EsitoRitiroApparato__c from Commercial_element_istanziati3__r) from Asset where Id =: OF_SA_GE_UtilsNew.caseOriginale.AssetId ][0].Commercial_element_istanziati3__r;
			 
				for( OF_CommercialElementIstanziato__c ceIst : listCEIst ){
					List<String> cpeEsitoRitiroList = mapTipologiaEsito.get( ceIst.OF_TipologiaApparato__c.toUpperCase());
                    //[GP 27/03/2019] messa assegnazione nell'if
                    System.debug('*** OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate cpeEsitoRitiroList: '+cpeEsitoRitiroList);                   
                    if(cpeEsitoRitiroList != null && !cpeEsitoRitiroList.isEmpty()){
                        ceIst.OF_EsitoRitiroApparato__c = cpeEsitoRitiroList.get(0);
                    }
                    else{
                        ceIst.OF_EsitoRitiroApparato__c = '';
                    }
					CEIstToUpdate.add( ceIst );
                    if(cpeEsitoRitiroList != null && !cpeEsitoRitiroList.isEmpty()){
						cpeEsitoRitiroList.remove(0);
                    }
                    else{
                        System.debug('*** OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate cpeEsitoRitiroList Non rimosso perchè già null ');
                    }
                    //END [GP 27/03/2019]
				}
				system.debug('****AA: LISTA DI CEI DA AGGIORNARE ' + CEIstToUpdate);
				if( CEIstToUpdate.size() > 0 ) 
					update CEIstToUpdate;			 
			}			
			//fine						
			// popolamento campi GPON DI ATTESTAZIONE sul case in update - 23/10/2017
			if(!string.isBlank(su.GPON_DI_ATTESTAZIONE)){
				OF_SA_GE_UtilsNew.caseOriginale.EOF_GPON_Attestazione__c = su.GPON_DI_ATTESTAZIONE;				
			}
            
                OF_ManageOrderFromCase_GPONP mofc = new OF_ManageOrderFromCase_GPONP();
            if(!Test.isRunningTest()){
                mofc.ManageOrder(OF_SA_GE_UtilsNew.caseOriginale);   
            }
			
			/*OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
			mofc.manageOrder(OF_SA_GE_UtilsNew.caseOriginale);*/
			//Vado a salvare il nuovo campo id servizio!!
			OF_SA_GE_UtilsNew.caseOriginale.OF_SA_ID_Servizio__c = su.ID_SERVIZIO;
			
			update OF_SA_GE_UtilsNew.caseOriginale;
			
			// Aggiorno il timestamp. SU.2 corrisponde a fine check Status Update.
			OF_SA_GE_UtilsNew.partialTemplog('SU.2');
			// finisce qui
			
			OF_SA_GE_UtilsNew.EndTemplog();
			
			return  responseToOM;
		}
		else{
			slList.add(responseFromOLO.get('1'));
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOM = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
			responseToOM.esito='1';
			EOF_EAI_Service_Log__c sl= responseFromOLO.get('1');
			responseToOM.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
			responseToOM.motivazione=sl.EOF_MOTIVAZIONE__C;
			responseToOM.id_notifica=sl.EOF_Id_Notifica__c;
			
			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
				'Codice_errore' => responseToOM.codice_motivazione,
				'Causale_errore' => responseToOM.motivazione,
				'Codice_operatore' => su.CODICE_OPERATORE,
				'Codice_ordine_OLO' => su.CODICE_ORDINE_OLO,
				'Flusso' => 'OM-SF',
				'Metodo' => 'OF_StatusUpdate',
				'ID_notifica' => su.ID_NOTIFICA,
				'Tipo Comunicazione' => 'OM->SF - NACK - StatusUpdate',
				'Caso' => OF_SA_GE_UtilsNew.caseOriginale.Id,
				'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;
			
			// Aggiorno il timestamp. SU.2 corrisponde a fine check Status Update.
			OF_SA_GE_UtilsNew.partialTemplog('SU.2');
			// finisce qui
			
			OF_SA_GE_UtilsNew.EndTemplog();
			
			return  responseToOM;
		}
		
	}
	//Status Update Passivi
	public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse SyncChecksNotifyStatusUpdate_GPONP(OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su){

		//('OSCRM OK');
		if(!OF_SA_GE_UtilsNew.checkRTMap){
			//vado a creare la mappa dei recordtype per poi utilizzarla
			OF_SA_GE_UtilsNew.RTMap = new  map<String,String>();
			for(recordtype rt : [select id,developername from recordtype]){
				OF_SA_GE_UtilsNew.RTMap.put(rt.developername,rt.id);
			}
			OF_SA_GE_UtilsNew.checkRTMap=true;
		}  
		// Aggiorno il timestamp. SU.1 corrisponde a inizio check Status Update.
		OF_SA_GE_UtilsNew.partialTemplog('SU.1');
		// finisce qui	   
		
		if(string.isblank(su.CODICE_OPERATORE)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','CODICE_OPERATORE');
		  }else if(su.CODICE_OPERATORE.length()>3){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_OPERATORE');
		} 		
		Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		Boolean olo_found = false;
		for(Schema.PicklistEntry s : ple){
			if(su.CODICE_OPERATORE == s.getLabel()){
				olo_found = true;
			}
		} 
		if(!olo_found){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_OPERATORE');   
		}
		
		if(string.isblank(su.CODICE_ORDINE_OLO)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','CODICE_ORDINE_OLO');
		  }else if(su.CODICE_ORDINE_OLO.length()>18){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_ORDINE_OLO');
		} 
		
		if(string.isblank(su.CODICE_ORDINE_OF)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','CODICE_ORDINE_OF');
		}else if(su.CODICE_ORDINE_OF.length()>18){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_ORDINE_OF');
		} 
		
		if(string.isblank(su.STATO_ORDINE)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','STATO_ORDINE');
		}
		if(su.STATO_ORDINE!='0' && su.STATO_ORDINE!='2'
			&& su.STATO_ORDINE!='3' && su.STATO_ORDINE!='4' 
			&& su.STATO_ORDINE!='5' && su.STATO_ORDINE!='6' 
			&& su.STATO_ORDINE!='7' 
		){			
			return OF_SA_GE_UtilsNew.syncError (su,'A06','STATO_ORDINE');
		}
		
		List<Case> cList;
		if(su.STATO_ORDINE=='6' || su.STATO_ORDINE=='7'){			
			// Aggiorno il timestamp. QSU.1 corrisponde a pre query.
			OF_SA_GE_UtilsNew.partialTemplog('QSU.1');
			// finisce qui			
			// 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni			
			cList = [SELECT id,status,PO_SA_Portale__C,RecordType.DeveloperName,AssetId,OF_Order__c,Previous_Status__c,OF_Blocked_Case__c, EOF_Codice_Ordine_OLO__c,EOF_Id_Risorsa__c,
					EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c,
					OF_Esito_Consegna_Apparato__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, PO_Comune__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
					EOF_Particella_Toponomastica_WS__c, PO_Indirizzo_collegamento__c, EOF_Indirizzo_WS__c, PO_Civico__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c,
					OF_SA_Profilo__c, OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c
					FROM Case 
					WHERE EOF_codice_Ordine_OLO__c = :su.CODICE_ORDINE_OLO 
					AND Codice_Ordine_Eof__C = :su.codice_ordine_of 
					AND EOF_Codice_Operatore_WS__c = :su.CODICE_OPERATORE
					AND RecordType.DeveloperName ='EOF_Caso_Cessazione'];
		}else{			
			// Aggiorno il timestamp. QSU.1 corrisponde a pre query.
			OF_SA_GE_UtilsNew.partialTemplog('QSU.1');
			// finisce qui
			
			// 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni			
			cList = [SELECT id,status,PO_SA_Portale__C,RecordType.DeveloperName,OF_Order__c,Previous_Status__c,OF_Blocked_Case__c, EOF_Codice_Ordine_OLO__c,EOF_Id_Risorsa__c,
					EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c,
					OF_Esito_Consegna_Apparato__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, PO_Comune__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
					EOF_Particella_Toponomastica_WS__c, PO_Indirizzo_collegamento__c, EOF_Indirizzo_WS__c, PO_Civico__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c,
					OF_SA_Profilo__c, OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c
					FROM Case 
					WHERE EOF_codice_Ordine_OLO__c = :su.CODICE_ORDINE_OLO 
					AND Codice_Ordine_Eof__C = :su.codice_ordine_of 
					AND EOF_Codice_Operatore_WS__c = :su.CODICE_OPERATORE 
					AND RecordType.DeveloperName ='EOF_Caso_Attivazione'];
		}		 
		// Aggiorno il timestamp. QSU.2 corrisponde a post query.
		OF_SA_GE_UtilsNew.partialTemplog('QSU.2');
		// finisce qui		
		
		if(cList.isEmpty()){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
		}else{
			OF_SA_GE_UtilsNew.caseOriginale = cList[0];
			OF_SA_GE_UtilsNew.checkCaseOriginale = true;
		}
		//Done AA - 02/10/2018 - Controllare se il campo "OF_Blocked_Case__c" è valorizzato a true
		//TODO AA - 02/10/2018 - Condividere codice errore per blocked case
		if(OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c){//C'è qualche status update dall'olo non notificato all'OM
			return OF_SA_GE_UtilsNew.syncError (su,'A07','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
		} 
        String caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(string.isblank(su.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','DATA_NOTIFICA');
		}else if(!OF_SA_GE_UtilsNew.checkDateTime(su.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','DATA_NOTIFICA');
		}
		
		if(string.isblank(su.ID_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (su,'A05','ID_NOTIFICA');
		}else if(su.ID_NOTIFICA.length()>100){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','ID_NOTIFICA');
		}
		
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='Espletato' || OF_SA_GE_UtilsNew.caseOriginale.status == 'Espletato KO' || OF_SA_GE_UtilsNew.caseOriginale.status =='Acquisito KO' || OF_SA_GE_UtilsNew.caseOriginale.status =='Cessato KO' || OF_SA_GE_UtilsNew.caseOriginale.status =='Cessato' || OF_SA_GE_UtilsNew.caseOriginale.status =='Annullato' || OF_SA_GE_UtilsNew.caseOriginale.status =='Inviato'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='In Annullamento' && su.STATO_ORDINE!='5'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='Sospeso' && su.STATO_ORDINE!='0' && su.STATO_ORDINE!='2'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='Acquisito' && OF_SA_GE_UtilsNew.caseOriginale.RecordType.DeveloperName=='OF_SA_Attivazione' && su.STATO_ORDINE!='2' && su.STATO_ORDINE!='3' && su.STATO_ORDINE!='4'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='Acquisito' && OF_SA_GE_UtilsNew.caseOriginale.RecordType.DeveloperName=='OF_SA_Cessazione' && su.STATO_ORDINE!='6' && su.STATO_ORDINE!='7'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}
		if(OF_SA_GE_UtilsNew.caseOriginale.status =='Accettato' && su.STATO_ORDINE!='4'){
			return OF_SA_GE_UtilsNew.syncError (su,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
		}	  
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(su.STATO_ORDINE!='0' && su.STATO_ORDINE!='2'){
			//casi in cui la motivazione è obbligatoria
			if(string.isblank(su.CODICE_MOTIVAZIONE)){
				return OF_SA_GE_UtilsNew.syncError (su,'A05','CODICE_MOTIVAZIONE');
			}
			if(string.isblank(su.MOTIVAZIONE)){
				return OF_SA_GE_UtilsNew.syncError (su,'A05','MOTIVAZIONE');
			}			
		}
		
		if(!string.isblank(su.CODICE_MOTIVAZIONE) && su.CODICE_MOTIVAZIONE.length()>3){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_MOTIVAZIONE');
		}		  
		
		if(!string.isblank(su.MOTIVAZIONE) && su.MOTIVAZIONE.length()>255){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','MOTIVAZIONE');
		}				   
		if(su.STATO_ORDINE == '2' || su.STATO_ORDINE == '0'){
			//Nuovo campo FLAG_DESOSPENSIONE
			/* AA COMMENTATO MOMENTANEAMENTE COME RICHIESTO DA CARLO
				POICHè I RAGAZZI DI TIBCO NON ERANO PRONTI
			if(String.isBlank(su.FLAG_DESOSPENSIONE)){
				return OF_SA_GE_UtilsNew.syncError (su,'A05','FLAG_DESOSPENSIONE');
			}else if(su.FLAG_DESOSPENSIONE.length() > 10 || (su.FLAG_DESOSPENSIONE != 'SI' && su.FLAG_DESOSPENSIONE != 'NO')){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','FLAG_DESOSPENSIONE');
			}*/
		}
		if (String.isNotBlank(su.FLAG_DESOSPENSIONE)){
			if(su.FLAG_DESOSPENSIONE.length() > 10 || (su.FLAG_DESOSPENSIONE != 'SI' && su.FLAG_DESOSPENSIONE != 'NO')){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','FLAG_DESOSPENSIONE');
			}
		}
		if(String.isNotBlank(su.REMOTE_ID) && su.REMOTE_ID.length() > 50){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','REMOTE_ID');
		}
		if(su.STATO_ORDINE=='4'){
			if(!string.isblank(su.NOME_CLIENTE) && su.NOME_CLIENTE.length()>20){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','NOME_CLIENTE');
			}		
			
			if(!string.isblank(su.COGNOME_CLIENTE) && su.COGNOME_CLIENTE.length()>70){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','COGNOME_CLIENTE');
			}		
			
			if(!string.isblank(su.RECAPITO_TELEFONICO_CLIENTE) && su.RECAPITO_TELEFONICO_CLIENTE.length()>20){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','RECAPITO_TELEFONICO_CLIENTE');
			}				
			
			if(!string.isblank(su.DATA_PREVISTA_ATTIVAZIONE) && !OF_SA_GE_UtilsNew.checkDate(su.DATA_PREVISTA_ATTIVAZIONE)){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','DATA_PREVISTA_ATTIVAZIONE');
			}				
			
			if(!string.isblank(su.ORARIO_APPUNTAMENTO) && !OF_SA_GE_UtilsNew.checkTime(su.ORARIO_APPUNTAMENTO)){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','ORARIO_APPUNTAMENTO');
			}
		}
		if(!string.isblank(su.PIN_INTERVENTO_A_VUOTO) && su.PIN_INTERVENTO_A_VUOTO.length()>8){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','PIN_INTERVENTO_A_VUOTO');
		}
		
		if(!string.isblank(su.NOTE) && su.NOTE.length()>255){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','NOTE');
		}
		if(String.isNotBlank(su.ID_SERVIZIO) && su.ID_SERVIZIO.length()>50){
			return OF_SA_GE_UtilsNew.syncError (su,'A06','ID_SERVIZIO');
		}
		//Controllo ID_SERVIZIO OBB SOLO PER STATO ORDINE = 2
		if(su.STATO_ORDINE == '2'){
			if(string.isblank(su.GPON_DI_ATTESTAZIONE)){
				return OF_SA_GE_UtilsNew.syncError (su,'A05','GPON_DI_ATTESTAZIONE');
			}
			if(su.GPON_DI_ATTESTAZIONE.length()>14){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','GPON_DI_ATTESTAZIONE');
			}  
		}else{
			if(String.isNotBlank(su.GPON_DI_ATTESTAZIONE) && su.GPON_DI_ATTESTAZIONE.length()>14){
				return OF_SA_GE_UtilsNew.syncError (su,'A06','GPON_DI_ATTESTAZIONE');
			}  
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		//CRM Modifica 16_06_2017
		Map<String,List<String>> mapTipologiaEsito = new Map<String,List<String>>();
		//fine
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(su.APPARATO!=null && !su.APPARATO.isempty()){  
			for(OF_WS_IN_OM_StatusUpdateNew.APPARATO ra : su.APPARATO){
				
				
				if(string.isblank(ra.TIPOLOGIA_APPARATO)){
					return OF_SA_GE_UtilsNew.syncError (su,'A05','TIPOLOGIA_APPARATO'); 
				}else if(ra.TIPOLOGIA_APPARATO.length()>100){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','TIPOLOGIA_APPARATO');
				}
				if(string.isblank(ra.ESITO_RITIRO_APPARATO)){
					return OF_SA_GE_UtilsNew.syncError (su,'A05','ESITO_RITIRO_APPARATO');
				}else if(ra.ESITO_RITIRO_APPARATO.length()>1) {
					return OF_SA_GE_UtilsNew.syncError (su,'A06','ESITO_RITIRO_APPARATO'); 
				}
				if(!string.isblank(ra.CODICE_MOTIVAZIONE_RITIRO) && ra.CODICE_MOTIVAZIONE_RITIRO.length()>3){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','CODICE_MOTIVAZIONE_RITIRO');
				}
				if(!string.isblank(ra.MOTIVAZIONE_RITIRO) && ra.MOTIVAZIONE_RITIRO.length()>255){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','MOTIVAZIONE_RITIRO');
				}
				if(String.isNotBlank(ra.ID_APPARATO) && ra.ID_APPARATO.length()>50){
					return OF_SA_GE_UtilsNew.syncError (su,'A06','ID_APPARATO');
				}
				List<String> cpeEsitoRitiroList = mapTipologiaEsito.get(ra.TIPOLOGIA_APPARATO.toUpperCase());
				if(cpeEsitoRitiroList == null){
					cpeEsitoRitiroList = new List<String>();
				}
				cpeEsitoRitiroList.add(ra.ESITO_RITIRO_APPARATO);
				//CRM Modifica 16_06_2017
				mapTipologiaEsito.put( ra.TIPOLOGIA_APPARATO.toUpperCase() , cpeEsitoRitiroList );
				//fine
			}			
		}		
		if(su.STATO_ORDINE == '6'){
			List<EOF_EAI_Service_Log__c> parentLogLst = [SELECT Id 
														 FROM EOF_EAI_Service_Log__c
														 WHERE RecordTypeId = :OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberRequest')
														 AND OF_SA_Metodo__c='OLO_DeactivationOrder'
														 AND Caso__c = :OF_SA_GE_UtilsNew.caseOriginale.Id];
			if(!parentLogLst.isEmpty()){
				List<EOF_EAI_Service_Log__c> appLst = [SELECT Id
														FROM EOF_EAI_Service_Log__c 
														WHERE RecordTypeId = :OF_SA_GE_UtilsNew.RTMap.get('OF_SA_Cpe') 
														AND OF_SA_Cpe_Log__c = :parentLogLst[0].Id ];
				
				if(!appLst.isEmpty() && su.APPARATO.isempty()){
					return OF_SA_GE_UtilsNew.syncError (su,'A05','APPARATO');
				}
			}
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(string.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c) && (su.stato_ordine=='0' || su.stato_ordine=='2')){
			// 30/01/2018 Marco : Modifica riconoscimento log desospensione			  
			if(string.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c)){
				OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c='';
				OF_SA_GE_UtilsNew.desospendi= true;					
			}				  
			// 30/01/2018 Marco : fine modifica
		}
		
		List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>(); 
		//Mi vado a salvare il camp flag desospensione
		OF_SA_GE_UtilsNew.caseOriginale.OF_Flag_Desospensione__c = su.FLAG_DESOSPENSIONE;
		OF_SA_GE_UtilsNew.caseOriginale.OF_Remote_ID__c = su.REMOTE_ID;
		//Done AA - Ricreare metodo async GPONP
		Map<String,EOF_EAI_Service_Log__c> responseFromOLO = OF_OM_AsyncChecksNew.OM_AsyncStatusUpdateNew_GPONP(OF_SA_GE_UtilsNew.caseOriginale, su);
		
		if(responseFromOLO.containsKey('0')) {			
			slList.add(responseFromOLO.get('0'));
			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
				'Codice_operatore' => su.CODICE_OPERATORE,
				'Codice_ordine_OLO' => su.CODICE_ORDINE_OLO,
				'Flusso' => 'OM-SF',
				'Metodo' => 'OF_StatusUpdate',
				'ID_notifica' => su.ID_NOTIFICA,
				'Tipo Comunicazione' => 'OM->SF - ACK - StatusUpdate',
				'Caso' => OF_SA_GE_UtilsNew.caseOriginale.Id,
				'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;
			
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOM = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
			responseToOM.esito='0';
			
			//aggiorno il Case			
			if(su.stato_ordine=='0'){
				
				OF_SA_GE_UtilsNew.caseOriginale.Status='Acquisito';
				if(!string.isBlank(su.DATA_PREVISTA_ATTIVAZIONE)){
					if(!string.isBlank(su.ORARIO_APPUNTAMENTO)){
						Time t = Time.newInstance(Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(3,5)),
												  Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(6,8)), 0);							
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), t );					
					}else{
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));	
					}
				}
			}
			
			if(su.stato_ordine=='1'){
				OF_SA_GE_UtilsNew.caseOriginale.Status='Acquisito KO';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE; 
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;				
			}			
			if(su.stato_ordine=='2'){								
				OF_SA_GE_UtilsNew.caseOriginale.Status='Accettato';
				if(!string.isBlank(su.DATA_PREVISTA_ATTIVAZIONE)){
					if(!string.isBlank(su.ORARIO_APPUNTAMENTO)){
						Time t = Time.newInstance(Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(3,5)),
												  Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(6,8)), 0);							
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), t );					
					}else{
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));	
					}
				}
			}			
			if(su.stato_ordine=='3'){
				OF_SA_GE_UtilsNew.caseOriginale.Status='Accettato KO';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
			}
			
			if(su.stato_ordine=='4'){				
				// 30/01/2018 Marco : Modifica salvataggio status su campo apposito
				OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c= OF_SA_GE_UtilsNew.caseOriginale.Status;
				// 30/01/2018 Marco : fine modifica
				
				OF_SA_GE_UtilsNew.caseOriginale.Status='Sospeso';
				if(!string.isBlank(su.DATA_PREVISTA_ATTIVAZIONE)){
					if(!string.isBlank(su.ORARIO_APPUNTAMENTO)){
						Time t = Time.newInstance(Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(3,5)),
												  Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(6,8)), 0);							
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), t );					
					}else{
						OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));	
					}
				}
				
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
			}			
			if(su.stato_ordine=='5'){
				OF_SA_GE_UtilsNew.caseOriginale.Status='Annullato';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
				
			}			
            caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			if(su.stato_ordine=='6'){
				OF_SA_GE_UtilsNew.caseOriginale.Status='Cessato';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
			}			
			if(su.stato_ordine=='7'){
				OF_SA_GE_UtilsNew.caseOriginale.Status='Cessato KO';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;				
			}			
			//CRM Modifica 16_06_2017
			if( su.stato_ordine == '6'){ 
				List<OF_CommercialElementIstanziato__c> CEIstToUpdate = new List<OF_CommercialElementIstanziato__c>();
			 
				List<OF_CommercialElementIstanziato__c> listCEIst = [select id,(select id,OF_TipologiaApparato__c,OF_EsitoRitiroApparato__c from Commercial_element_istanziati3__r) from Asset where Id =: OF_SA_GE_UtilsNew.caseOriginale.AssetId ][0].Commercial_element_istanziati3__r;
			 
				for( OF_CommercialElementIstanziato__c ceIst : listCEIst ){
					List<String> cpeEsitoRitiroList = mapTipologiaEsito.get( ceIst.OF_TipologiaApparato__c.toUpperCase());
                    //[GP 27/03/2019] messa assegnazione nell'if
                    if(cpeEsitoRitiroList != null && !cpeEsitoRitiroList.isEmpty()){
                        ceIst.OF_EsitoRitiroApparato__c = cpeEsitoRitiroList.get(0);
                    }
                    else{
                        ceIst.OF_EsitoRitiroApparato__c = '';
                    }
					CEIstToUpdate.add( ceIst );
                    if(cpeEsitoRitiroList != null && !cpeEsitoRitiroList.isEmpty()){
						cpeEsitoRitiroList.remove(0);
                    }
                    else{
                        System.debug('*** OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate cpeEsitoRitiroList Non rimosso perchè già null ');
                    }
                    /*
					ceIst.OF_EsitoRitiroApparato__c = cpeEsitoRitiroList.get(0);
					CEIstToUpdate.add( ceIst );
					cpeEsitoRitiroList.remove(0);
				*/
                  //END [GP 27/03/2019]
				}
				system.debug('****AA: LISTA DI CEI DA AGGIORNARE ' + CEIstToUpdate);
				if( CEIstToUpdate.size() > 0 ) 
					update CEIstToUpdate;			 
			}		
            caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			//fine						
			// popolamento campi GPON DI ATTESTAZIONE sul case in update - 23/10/2017
			if(!string.isBlank(su.GPON_DI_ATTESTAZIONE)){
				OF_SA_GE_UtilsNew.caseOriginale.EOF_GPON_Attestazione__c = su.GPON_DI_ATTESTAZIONE;				
			}
			//Done AA - Controllare gestione ordine
            caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
                OF_ManageOrderFromCase_GPONP mofc = new OF_ManageOrderFromCase_GPONP();
            if(!Test.isRunningTest()){
                mofc.ManageOrder(OF_SA_GE_UtilsNew.caseOriginale);  
            }
			
			/*OF_manageOrderFromCase  mofc = new OF_manageOrderFromCase();
			mofc.manageOrder(OF_SA_GE_UtilsNew.caseOriginale);*/
			//Vado a salvare il nuovo campo id servizio!!
			OF_SA_GE_UtilsNew.caseOriginale.OF_SA_ID_Servizio__c = su.ID_SERVIZIO;
			caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			update OF_SA_GE_UtilsNew.caseOriginale;
			
			// Aggiorno il timestamp. SU.2 corrisponde a fine check Status Update.
			OF_SA_GE_UtilsNew.partialTemplog('SU.2');
			// finisce qui
			
			OF_SA_GE_UtilsNew.EndTemplog();
			caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			return  responseToOM;
		}
		else{
			slList.add(responseFromOLO.get('1'));
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOM = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
			responseToOM.esito='1';
			EOF_EAI_Service_Log__c sl= responseFromOLO.get('1');
			responseToOM.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
			responseToOM.motivazione=sl.EOF_MOTIVAZIONE__C;
			responseToOM.id_notifica=sl.EOF_Id_Notifica__c;
			caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
				'Codice_errore' => responseToOM.codice_motivazione,
				'Causale_errore' => responseToOM.motivazione,
				'Codice_operatore' => su.CODICE_OPERATORE,
				'Codice_ordine_OLO' => su.CODICE_ORDINE_OLO,
				'Flusso' => 'OM-SF',
				'Metodo' => 'OF_StatusUpdate',
				'ID_notifica' => su.ID_NOTIFICA,
				'Tipo Comunicazione' => 'OM->SF - NACK - StatusUpdate',
				'Caso' => OF_SA_GE_UtilsNew.caseOriginale.Id,
				'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;
			
			// Aggiorno il timestamp. SU.2 corrisponde a fine check Status Update.
			OF_SA_GE_UtilsNew.partialTemplog('SU.2');
			// finisce qui
			
			OF_SA_GE_UtilsNew.EndTemplog();
			caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			return  responseToOM;
		}
		
	}
	//Reschedule Attivi
	public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse SyncChecksNotifyReschedule(OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r){
		String operation = 'REschedule';
		// Aggiorno il timestamp. R.1 corrisponde a inizio check RDAC.
		OF_SA_GE_UtilsNew.partialTemplog('R.1');
		// finisce qui
		
		if(string.isblank(r.CODICE_OPERATORE)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_OPERATORE');
		}

		Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		Boolean olo_found = false;
		for(Schema.PicklistEntry s : ple){
			if(r.CODICE_OPERATORE == s.getLabel()){
				olo_found = true;
			}
		}		
		if(!olo_found){
			 return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_OPERATORE');
		}

		if(string.isblank(r.CODICE_ORDINE_OLO)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_ORDINE_OLO');
		}else if(r.CODICE_ORDINE_OLO.length()>18){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_ORDINE_OLO');
		} 
		/* AA Rimosso come richiesto da Claudio e Riccardo
		if(string.isblank(r.CODICE_ORDINE_OF)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_ORDINE_OF');
		}else if(r.CODICE_ORDINE_OF.length()>18){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_ORDINE_OF');
		} */

		// Aggiorno il timestamp. QR.1 corrisponde a pre query RDAC.
		OF_SA_GE_UtilsNew.partialTemplog('QR.1');
		// finisce qui
		
		// 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni		
		List<Case> cList = [SELECT Id, Status, PO_SA_Portale__C,OF_Blocked_Case__c, Codice_Ordine_EOF__c
							FROM Case 
							WHERE EOF_Codice_Ordine_Olo__c =:r.Codice_Ordine_Olo 
							AND EOF_Codice_Operatore_WS__c=:r.CODICE_OPERATORE 
							AND RecordType.DeveloperName = 'OF_SA_Attivazione'
							/*AND Codice_Ordine_Eof__C = :r.CODICE_ORDINE_OF*/];
		// 8/01/2018 Marco : fine modifica
		
		// Aggiorno il timestamp. QR.2 corrisponde a post query RDAC.
		OF_SA_GE_UtilsNew.partialTemplog('QR.2');
		// finisce qui
	
		if(cList.isEmpty()){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_ORDINE_OLO');
		}
		else{
			OF_SA_GE_UtilsNew.caseOriginale=cList[0];
			OF_SA_GE_UtilsNew.checkCaseOriginale=true;
		}
       	String caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		//Done AA - 02/10/2018 - Controllare se il campo "OF_Blocked_Case__c" è valorizzato a true
	   	//TODO AA - 02/10/2018 - Condividere codice errore per blocked case
		if(OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c){//C'è qualche status update dall'olo non notificato all'OM
			return OF_SA_GE_UtilsNew.syncError (r,'A07','CODICE_ORDINE_OLO');
		} 
		if(cList[0].status != 'Acquisito' && cList[0].status != 'Accettato' && cList[0].status != 'Sospeso'){
			return OF_SA_GE_UtilsNew.syncError (r,'A07','STATUS: ' + cList[0].status);
		}

		if(string.isblank(r.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','DATA_NOTIFICA');
		}if(!OF_SA_GE_UtilsNew.checkDateTime(r.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','DATA_NOTIFICA');
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(string.isblank(r.ID_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','ID_NOTIFICA');
		}if(r.ID_NOTIFICA.length()>100){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','ID_NOTIFICA');
		}

		if(!string.isblank(r.NOME_CLIENTE) && r.NOME_CLIENTE.length()>20){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','NOME_CLIENTE');
		}
		
		
		if(!string.isblank(r.COGNOME_CLIENTE) && r.COGNOME_CLIENTE.length()>70){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','COGNOME_CLIENTE');
		}
		
		
		if(!string.isblank(r.RECAPITO_TELEFONICO_CLIENTE_1) && r.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		
		if(!string.isblank(r.RECAPITO_TELEFONICO_CLIENTE_2) && r.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
		}

		if(string.isblank(r.DATA_PREVISTA_ATTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','DATA_PREVISTA_ATTIVAZIONE');
		}if(!OF_SA_GE_UtilsNew.checkDate(r.DATA_PREVISTA_ATTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','DATA_PREVISTA_ATTIVAZIONE'); 
		}
		if(!string.isblank(r.ORARIO_APPUNTAMENTO)){
			if(!OF_SA_GE_UtilsNew.checkTime(r.ORARIO_APPUNTAMENTO)){
				return OF_SA_GE_UtilsNew.syncError (r,'A06','ORARIO_APPUNTAMENTO');
			}
			
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(string.isblank(r.CODICE_MOTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_MOTIVAZIONE');
		}else if(r.CODICE_MOTIVAZIONE.length()>3){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_MOTIVAZIONE');
		}
		if(string.isblank(r.MOTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','MOTIVAZIONE');
		}else if(r.MOTIVAZIONE.length()>255){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','MOTIVAZIONE');
		}

		if(!string.isblank(r.NOTE) && r.NOTE.length()>255){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','NOTE');
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
		Map<String,EOF_EAI_Service_Log__c> responseFromOLO = OF_OM_AsyncChecksNew.OM_AsyncReschedule(cList[0],r);  
		
		if(responseFromOLO.containsKey('0')) { 
			
			slList.add(responseFromOLO.get('0'));
			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
											 'Codice_operatore' => r.CODICE_OPERATORE,
											 'Codice_ordine_OLO' => r.CODICE_ORDINE_OLO,
											 'Flusso' => 'OM-SF',
											 'Metodo' => 'OF_Reschedule',
											 'ID_notifica' => r.ID_NOTIFICA,
											 'Tipo Comunicazione' => 'OM->SF - ACK - Reschedule',
											 'Caso' => cList[0].Id,
											 'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;
			
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOM = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
			responseToOM.esito='0';
			
			if (!string.isBlank(r.ORARIO_APPUNTAMENTO)){
					Time t = Time.newInstance(Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(3,5)),
						  	Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(6,8)), 0);							
				cList[0].EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), t );
			}else{
				cList[0].EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
			}
			cList[0].EOF_Orario_Appuntamento__c=r.ORARIO_APPUNTAMENTO;
			cList[0].EOF_Pertinenza_RDAC__c = 'OM';
			cList[0].OF_SA_Codice_Motivazione__c=r.CODICE_MOTIVAZIONE;
			cList[0].OF_SA_Motivazione__c=r.MOTIVAZIONE;
			update cList[0];

			// Aggiorno il timestamp. R.2 corrisponde a fine check RDAC.
			OF_SA_GE_UtilsNew.partialTemplog('R.2');
			// finisce qui
			caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			OF_SA_GE_UtilsNew.EndTemplog();
				
			return  responseToOM;
		}
		else{
		
			slList.add(responseFromOLO.get('1'));
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOM = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
			responseToOM.esito='1';
			EOF_EAI_Service_Log__c sl= responseFromOLO.get('1'); 
			responseToOM.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
			responseToOM.motivazione=sl.EOF_MOTIVAZIONE__C;
			responseToOM.id_notifica=sl.EOF_Id_Notifica__c;

			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
													 'Codice_errore' => responseToOM.codice_motivazione,
													 'Causale_errore' => responseToOM.motivazione,
													 'Codice_operatore' => r.CODICE_OPERATORE,
													 'Flusso' => 'OM-SF',
													'Metodo' => 'OF_Reschedule',
													 'Codice_ordine_OLO' => r.CODICE_ORDINE_OLO,
													 'ID_notifica' => r.ID_NOTIFICA,
													 'Tipo Comunicazione' => 'OM->SF - NACK - Reschedule',
													 'Caso' => cList[0].Id,
													 'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;

			// Aggiorno il timestamp. R.2 corrisponde a fine check RDAC.
			OF_SA_GE_UtilsNew.partialTemplog('R.2');
			// finisce qui
			
			OF_SA_GE_UtilsNew.EndTemplog();

			return  responseToOM;
		}	
	}
	//Reschedule Passivi
	public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse SyncChecksNotifyReschedule_GPONP(OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r){
		String operation = 'Reschedule gponp';
		// Aggiorno il timestamp. R.1 corrisponde a inizio check RDAC.
		OF_SA_GE_UtilsNew.partialTemplog('R.1');
		// finisce qui
		
		if(string.isblank(r.CODICE_OPERATORE)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_OPERATORE');
		}

		Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		Boolean olo_found = false;
		for(Schema.PicklistEntry s : ple){
			if(r.CODICE_OPERATORE == s.getLabel()){
				olo_found = true;
			}
		}		
		if(!olo_found){
			 return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_OPERATORE');
		}

		if(string.isblank(r.CODICE_ORDINE_OLO)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_ORDINE_OLO');
		}else if(r.CODICE_ORDINE_OLO.length()>18){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_ORDINE_OLO');
		} 
		/* AA - Rimosso come richiesto da Claudio e Riccardo
		if(string.isblank(r.CODICE_ORDINE_OF)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_ORDINE_OF');
		}else if(r.CODICE_ORDINE_OF.length()>18){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_ORDINE_OF');
		} */
		// Aggiorno il timestamp. QR.1 corrisponde a pre query RDAC.
		OF_SA_GE_UtilsNew.partialTemplog('QR.1');
		// finisce qui
		
		// 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni		
		List<Case> cList = [SELECT Id, Status, PO_SA_Portale__C,OF_Blocked_Case__c, Codice_Ordine_EOF__c
							FROM Case 
							WHERE EOF_Codice_Ordine_Olo__c =:r.Codice_Ordine_Olo 
							AND EOF_Codice_Operatore_WS__c=:r.CODICE_OPERATORE 
							AND RecordType.DeveloperName = 'EOF_Caso_Attivazione'
						   /* AND Codice_Ordine_Eof__C = :r.CODICE_ORDINE_OF*/];
		// 8/01/2018 Marco : fine modifica
		
		// Aggiorno il timestamp. QR.2 corrisponde a post query RDAC.
		OF_SA_GE_UtilsNew.partialTemplog('QR.2');
		// finisce qui
	
		if(cList.isEmpty()){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_ORDINE_OLO');
		}
		else{
			OF_SA_GE_UtilsNew.caseOriginale=cList[0];
			OF_SA_GE_UtilsNew.checkCaseOriginale=true;
		}
		//Done AA - 02/10/2018 - Controllare se il campo "OF_Blocked_Case__c" è valorizzato a true
	   	//TODO AA - 02/10/2018 - Condividere codice errore per blocked case
		if(OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c){//C'è qualche status update dall'olo non notificato all'OM
			return OF_SA_GE_UtilsNew.syncError (r,'A07','CODICE_ORDINE_OLO');
		} 
        String caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(cList[0].status != 'Acquisito' && cList[0].status != 'Accettato' && cList[0].status != 'Sospeso'){
			return OF_SA_GE_UtilsNew.syncError (r,'A07','STATUS: ' + cList[0].status);
		}

		if(string.isblank(r.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','DATA_NOTIFICA');
		}else if(!OF_SA_GE_UtilsNew.checkDateTime(r.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','DATA_NOTIFICA');
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(string.isblank(r.ID_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','ID_NOTIFICA');
		}else if(r.ID_NOTIFICA.length()>100){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','ID_NOTIFICA');
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(!string.isblank(r.NOME_CLIENTE) && r.NOME_CLIENTE.length()>20){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','NOME_CLIENTE');
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(!string.isblank(r.COGNOME_CLIENTE) && r.COGNOME_CLIENTE.length()>70){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','COGNOME_CLIENTE');
		}
		
		if(!string.isblank(r.RECAPITO_TELEFONICO_CLIENTE_1) && r.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
		}
		
		if(!string.isblank(r.RECAPITO_TELEFONICO_CLIENTE_2) && r.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
		}

		if(string.isblank(r.DATA_PREVISTA_ATTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','DATA_PREVISTA_ATTIVAZIONE');
		}else if(!OF_SA_GE_UtilsNew.checkDate(r.DATA_PREVISTA_ATTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','DATA_PREVISTA_ATTIVAZIONE'); 
		}
		if(!string.isblank(r.ORARIO_APPUNTAMENTO)){
			if(!OF_SA_GE_UtilsNew.checkTime(r.ORARIO_APPUNTAMENTO)){
				return OF_SA_GE_UtilsNew.syncError (r,'A06','ORARIO_APPUNTAMENTO');
			}
			
		}

		if(string.isblank(r.CODICE_MOTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_MOTIVAZIONE');
		}else if(r.CODICE_MOTIVAZIONE.length()>3){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_MOTIVAZIONE');
		}
		if(string.isblank(r.MOTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (r,'A05','MOTIVAZIONE');
		}else if(r.MOTIVAZIONE.length()>255){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','MOTIVAZIONE');
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(!string.isblank(r.NOTE) && r.NOTE.length()>255){
			return OF_SA_GE_UtilsNew.syncError (r,'A06','NOTE');
		}
			caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
		Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_OM_AsyncChecksNew.OM_AsyncReschedule_GPONP(cList[0],r);  
		
		if(responseFromOM.containsKey('0')) { 
			
			slList.add(responseFromOM.get('0'));
			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
											 'Codice_operatore' => r.CODICE_OPERATORE,
											 'Codice_ordine_OLO' => r.CODICE_ORDINE_OLO,
											 'Flusso' => 'OM-SF',
											 'Metodo' => 'OF_Reschedule',
											 'ID_notifica' => r.ID_NOTIFICA,
											 'Tipo Comunicazione' => 'OM->SF - ACK - Reschedule',
											 'Caso' => cList[0].Id,
											 'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;
			
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
			responseToOlo.esito='0';
			
			if (!string.isBlank(r.ORARIO_APPUNTAMENTO)){
					Time t = Time.newInstance(Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(3,5)),
						  	Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(6,8)), 0);							
				cList[0].EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), t );
			}else{
				cList[0].EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
			}
			cList[0].EOF_Orario_Appuntamento__c=r.ORARIO_APPUNTAMENTO;
			cList[0].EOF_Pertinenza_RDAC__c = 'OM';
			cList[0].OF_SA_Codice_Motivazione__c=r.CODICE_MOTIVAZIONE;
			cList[0].OF_SA_Motivazione__c=r.MOTIVAZIONE;
			update cList[0];

			// Aggiorno il timestamp. R.2 corrisponde a fine check RDAC.
			OF_SA_GE_UtilsNew.partialTemplog('R.2');
			// finisce qui
			
			OF_SA_GE_UtilsNew.EndTemplog();
				caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			return  responseToOlo;
		}
		else{
		
			slList.add(responseFromOM.get('1'));
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
			responseToOlo.esito='1';
			EOF_EAI_Service_Log__c sl= responseFromOM.get('1'); 
			responseToOlo.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
			responseToOlo.motivazione=sl.EOF_MOTIVAZIONE__C;
			responseToOlo.id_notifica=sl.EOF_Id_Notifica__c;
			caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
													 'Codice_errore' => responseToOlo.codice_motivazione,
													 'Causale_errore' => responseToOlo.motivazione,
													 'Codice_operatore' => r.CODICE_OPERATORE,
													 'Flusso' => 'OM-SF',
													'Metodo' => 'OF_Reschedule',
													 'Codice_ordine_OLO' => r.CODICE_ORDINE_OLO,
													 'ID_notifica' => r.ID_NOTIFICA,
													 'Tipo Comunicazione' => 'OM->SF - NACK - Reschedule',
													 'Caso' => cList[0].Id,
													 'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;

			// Aggiorno il timestamp. R.2 corrisponde a fine check RDAC.
			OF_SA_GE_UtilsNew.partialTemplog('R.2');
			// finisce qui 
			caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			OF_SA_GE_UtilsNew.EndTemplog();

			return  responseToOlo;
		}	
	}
	//CompletionOrder Attivi
	public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse SyncChecksNotifyCompletionOrder(OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co){
		String operation = 'Completionorder';
	   // Aggiorno il timestamp. E.1 corrisponde a inizio check espletamento.
		OF_SA_GE_UtilsNew.partialTemplog('E.1');
		// finisce qui
		
		if(string.isblank(co.CODICE_OPERATORE)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_OPERATORE'); 
		}else if(co.CODICE_OPERATORE.length()>3){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_OPERATORE');
		}			  
		Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		Boolean olo_found = false;
		for(Schema.PicklistEntry s : ple){
			if(co.CODICE_OPERATORE == s.getLabel()){
				olo_found = true;
			}
		}		
		if(!olo_found){
			 return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_OPERATORE');
		}

	   if(string.isblank(co.CODICE_ORDINE_OLO)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_ORDINE_OLO');
		}else if(co.CODICE_ORDINE_OLO.length()>18){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_ORDINE_OLO');  
		}else if(co.CODICE_ORDINE_OLO.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','CODICE_ORDINE_OLO');
		}  
		if(string.isblank(co.CODICE_ORDINE_OF)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_ORDINE_OF');
		}else if(co.CODICE_ORDINE_OF.length()>18){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_ORDINE_OF');	 
		}else if(co.CODICE_ORDINE_OF.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','CODICE_ORDINE_OF');
		}	
		// Aggiorno il timestamp. QC.1 corrisponde a pre query.
		OF_SA_GE_UtilsNew.partialTemplog('QC.1');
		// finisce qui
		
		//qui verifico che il case sia a sistema
		// 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni
		List<Case> cList = [select Id, status, PO_SA_Portale__C,OF_Order__c, OF_Blocked_Case__c from Case where EOF_Codice_Ordine_Olo__c =:co.Codice_Ordine_Olo AND Codice_Ordine_Eof__c =:co.Codice_Ordine_OF AND EOF_Codice_Operatore_WS__c=:co.CODICE_OPERATORE AND RecordType.DeveloperName = 'OF_SA_Attivazione'];
		
	   // Aggiorno il timestamp. QC.2 corrisponde a post query.
		OF_SA_GE_UtilsNew.partialTemplog('QC.2');
		// finisce qui

		if(cList.isEmpty()){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
		}
		else{
			OF_SA_GE_UtilsNew.caseOriginale=cList[0];
			OF_SA_GE_UtilsNew.checkCaseOriginale=true;
		}
        String caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		// 8/01/2018 Marco : fine modifica
		//verifico che lo status sia congruente
		//Done AA - 02/10/2018 - Controllare se il campo "OF_Blocked_Case__c" è valorizzato a true
	   	//TODO AA - 02/10/2018 - Condividere codice errore per blocked case
		if(OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c){//C'è qualche status update dall'olo non notificato all'OM
			return OF_SA_GE_UtilsNew.syncError (co,'A07','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
		} 
		if(cList[0].status!='Accettato'){
			return OF_SA_GE_UtilsNew.syncError (co,'A03','Messaggio non ammesso');
		}

		
		if(string.isblank(co.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','DATA_NOTIFICA');
		}else if(!OF_SA_GE_UtilsNew.checkDateTime(co.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','DATA_NOTIFICA');
		}
		if(string.isblank(co.ID_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','ID_NOTIFICA');
		}else if(co.ID_NOTIFICA.length()>100){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','ID_NOTIFICA');
		}else if(co.ID_NOTIFICA.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','ID_NOTIFICA');
		}  
        caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(string.isblank(co.STATO_ORDINE)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','STATO_ORDINE');
		}else if(co.STATO_ORDINE.length()>1 && co.STATO_ORDINE!='0' && co.STATO_ORDINE!='1'){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','STATO_ORDINE');
		}else if(co.STATO_ORDINE.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','STATO_ORDINE');
		}  
		

		if(string.isblank(co.CODICE_MOTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_MOTIVAZIONE');
		}else if(co.CODICE_MOTIVAZIONE.length()>3){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE');
		}else if(co.CODICE_MOTIVAZIONE.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','CODICE_MOTIVAZIONE');
		} 

		if(string.isblank(co.MOTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','MOTIVAZIONE');
		}else if (co.MOTIVAZIONE.length()>255){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','MOTIVAZIONE');
		}else if(co.MOTIVAZIONE.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','MOTIVAZIONE');
		} 
		if(co.STATO_ORDINE=='0' && string.isBlank(co.ID_RISORSA)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','ID_RISORSA');
		}
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(!string.isblank(co.ID_RISORSA) && co.ID_RISORSA.length()>50){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','ID_RISORSA');
		}
		/*if(co.STATO_ORDINE=='0' && string.isBlank(co.SCALA_PALAZZINA)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','SCALA_PALAZZINA');
		}*/
		
		if(!string.isblank(co.SCALA_PALAZZINA) && co.SCALA_PALAZZINA.length()>21){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','SCALA_PALAZZINA');
		}
		
		
		if(string.isblank(co.DATA_ESPLETAMENTO_ORDINE)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','DATA_ESPLETAMENTO_ORDINE');
		}else if(!OF_SA_GE_UtilsNew.checkDate(co.DATA_ESPLETAMENTO_ORDINE)){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','DATA_ESPLETAMENTO_ORDINE');
		}

		if(string.isNotblank(co.DDT)){
			if(co.DDT.length()>255){
				return OF_SA_GE_UtilsNew.syncError (co,'A06','DDT');
			}else if(co.DDT.contains('�')){
				return OF_SA_GE_UtilsNew.syncError (co,'B04','DDT');
			}	
		}
        caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(!string.isblank(co.NOTE)){
			if (co.NOTE.length()>255){
				return OF_SA_GE_UtilsNew.syncError (co,'A06','NOTE');
			}else if(co.NOTE.contains('�')){
				return OF_SA_GE_UtilsNew.syncError (co,'B04','NOTE');
			}	
		}
		if(!string.isblank(co.PARAMETRI_TRASMISSIVI_OTTICI)){
			if (co.PARAMETRI_TRASMISSIVI_OTTICI.length()>255){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','PARAMETRI_TRASMISSIVI_OTTICI');
			}else if(co.PARAMETRI_TRASMISSIVI_OTTICI.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','PARAMETRI_TRASMISSIVI_OTTICI');
			}  
		}
		//AA 300119 - Nuovi campi 
		if(!string.isblank(co.GPON_DI_ATTESTAZIONE) && co.GPON_DI_ATTESTAZIONE.length()>14){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','GPON_DI_ATTESTAZIONE');
		}
        caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(String.isNotBlank(co.SERIALE_BORCHIA) && co.SERIALE_BORCHIA.length() > 50){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','SERIALE_BORCHIA');
		}
		if(String.isNotBlank(co.FLAG_PAGAMENTO) && co.FLAG_PAGAMENTO != '0' && co.FLAG_PAGAMENTO != '1'){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','FLAG_PAGAMENTO');
		}
		if(String.isNotBlank(co.NUMERO_OPERATORE) && co.NUMERO_OPERATORE != '1' && co.NUMERO_OPERATORE != '2' && co.NUMERO_OPERATORE != '3' && co.NUMERO_OPERATORE != '4'){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','NUMERO_OPERATORE');
		}
		if(String.isNotBlank(co.BRETELLA_OTTICA) && co.BRETELLA_OTTICA != 'Y' && co.BRETELLA_OTTICA != 'N'){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','BRETELLA_OTTICA'); 
		}
        caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(String.isNotBlank(co.ESTENSIONE_IMPIANTO_EFFETTUATA) && co.ESTENSIONE_IMPIANTO_EFFETTUATA != 'SI' && co.ESTENSIONE_IMPIANTO_EFFETTUATA != 'NO'){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','ESTENSIONE_IMPIANTO_EFFETTUATA'); 
		}
		if(String.isNotBlank(co.ESTENSIONE_IMPIANTO) && co.ESTENSIONE_IMPIANTO.length() > 15){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','ESTENSIONE_IMPIANTO'); 
		}
		if(String.isNotBlank(co.METRI_TOT) && co.METRI_TOT.length() > 5){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','METRI_TOT'); 
		}
        caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		//FINE AA 300119
		Map<String,List<OF_commercialElementIstanziato__c>> ceiMap = new Map<String,List<OF_commercialElementIstanziato__c>>();
		if(co.STATO_ORDINE=='0'){
			List<String> cListCPE = new List<String>(); 
			List<String> cListSA = new List<String>();
			//creo una mappa per poi salvare i dati dell'espletamento sui commercial element instanziati
			
			List<OF_commercialElementIstanziato__c> ceiList = [SELECT ID,RecordType.DeveloperName,OF_Nome_Servizio__C,OF_TipologiaApparato__C,metriTot__c FROM OF_CommercialElementIstanziato__c 
															WHERE (OF_SA_Servizio_Aggiuntivo__c=: co.CODICE_ORDINE_OF AND RecordType.DeveloperName='OF_ServiziAggiuntivi') 
															OR (OF_SA_CPE__c=: co.CODICE_ORDINE_OF AND RecordType.DeveloperName='OF_CPE')];

			for (OF_commercialElementIstanziato__c cei : ceiList){
				if(cei.RecordType.DeveloperName=='OF_CPE'){
					//Vado a verificare se la map contiene già qualche valore
					List<OF_CommercialElementIstanziato__c> cpeTypeList = ceiMap.get(cei.OF_TipologiaApparato__C.toUpperCase());
					//Se non è stato ancora aggiunto nessuna CPE, vado a creare la lista
					if(cpeTypeList == null){
						cpeTypeList = new List<OF_CommercialElementIstanziato__c>();
					}
					cpeTypeList.add(cei);
					cListCPE.add(cei.OF_TipologiaApparato__C.toUpperCase());
					ceiMap.put(cei.OF_TipologiaApparato__C.toUpperCase(), cpeTypeList);
				}
				if(cei.RecordType.DeveloperName=='OF_ServiziAggiuntivi'){
					//Vado a verificare se la map contiene già qualche valore
					List<OF_CommercialElementIstanziato__c> servAggNameList = ceiMap.get(cei.OF_Nome_Servizio__c.toUpperCase());
					//Se non è stato ancora aggiunto nessun ServAgg, vado a creare la lista
					if(servAggNameList == null){
						servAggNameList = new List<OF_CommercialElementIstanziato__c>();
					}
					servAggNameList.add(cei);
					cListSA.add(cei.OF_Nome_Servizio__C.toUpperCase());
					ceiMap.put(cei.OF_Nome_Servizio__c.toUpperCase(), servAggNameList);
				}
			}
			caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			if(co.SERVIZIO_AGGIUNTIVO!=null){
				List<String> cListSAOM = new List<String>();
				for(OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai : co.SERVIZIO_AGGIUNTIVO){
					cListSAOM.add(sai.NOME_SERVIZIO.toUpperCase());
				}
				cListSAOM.sort();
				cListSA.sort();
				if(cListSAOM.equals(cListSA)){
					if(co.SERVIZIO_AGGIUNTIVO.size()>0){
						for(OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai : co.SERVIZIO_AGGIUNTIVO){
								if(string.isblank(sai.NOME_SERVIZIO)){
									return OF_SA_GE_UtilsNew.syncError (co,'A05','NOME_SERVIZIO');
								}else if(sai.NOME_SERVIZIO.length()>50){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','NOME_SERVIZIO');
								}else if(string.isblank(sai.ESITO_SERVIZIO)){
									return OF_SA_GE_UtilsNew.syncError (co,'A05','ESITO_SERVIZIO');
								}
								if(!string.isblank(sai.ESITO_SERVIZIO) && sai.ESITO_SERVIZIO.length()>1){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','ESITO_SERVIZIO');
								}
								if(sai.ESITO_SERVIZIO=='1'){
									if(string.isblank(sai.CODICE_MOTIVAZIONE_SERVIZIO)){
										return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_MOTIVAZIONE_SERVIZIO');
									}else if(sai.CODICE_MOTIVAZIONE_SERVIZIO.length()>3){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE_SERVIZIO');
									}
									if(string.isblank(sai.MOTIVAZIONE_SERVIZIO)){
										return OF_SA_GE_UtilsNew.syncError (co,'A05','MOTIVAZIONE_SERVIZIO');
									}else if(sai.MOTIVAZIONE_SERVIZIO.length()>255){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','MOTIVAZIONE_SERVIZIO');
									}
								}
								else {
									if(!string.isblank(sai.CODICE_MOTIVAZIONE_SERVIZIO) && sai.CODICE_MOTIVAZIONE_SERVIZIO.length()>3){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE_SERVIZIO');
									}
									if(!string.isblank(sai.MOTIVAZIONE_SERVIZIO) && sai.MOTIVAZIONE_SERVIZIO.length()>255){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE_SERVIZIO');
									}
								}
							}
						
					}
				}
				//caso liste non uguali
				else{   
					return OF_SA_GE_UtilsNew.syncError (co,'A06','Servizi Aggiuntivi');
				}
			}
			//caso servizi aggiuntivi = null
			else{
				if(cListSA.size()>0){
					return OF_SA_GE_UtilsNew.syncError (co,'A05','Servizi Aggiuntivi');
				}
			} 
			
			if(co.APPARATO!=null){
				List<String> cListCPEOM = new List<String>();
				for(OF_WS_IN_OM_CompletionOrderNew.APPARATO cap : co.APPARATO){
					cListCPEOM.add(cap.TIPOLOGIA_APPARATO.toUpperCase());
				}
				cListCPEOM.sort();
				cListCPE.sort();
				if(cListCPEOM.equals(cListCPE)){
					if(!co.APPARATO.isempty()){
						for(OF_WS_IN_OM_CompletionOrderNew.APPARATO cap : co.APPARATO){
							
							if(string.isblank(cap.TIPOLOGIA_APPARATO)){
								return OF_SA_GE_UtilsNew.syncError (co,'A05','TIPOLOGIA_APPARATO');
							}else if(cap.TIPOLOGIA_APPARATO.length()>100){
								return OF_SA_GE_UtilsNew.syncError (co,'A06','TIPOLOGIA_APPARATO');
							}
							if(string.isblank(cap.ESITO_CONSEGNA_APPARATO)){
								return OF_SA_GE_UtilsNew.syncError (co,'A05','ESITO_CONSEGNA_APPARATO');
							}else if(cap.ESITO_CONSEGNA_APPARATO.length()>1){
								return OF_SA_GE_UtilsNew.syncError (co,'A06','ESITO_CONSEGNA_APPARATO');
							}
							// campo ID_APPARATO_CONSEGNATO obbligatorio solo se ESITO_CONSEGNA_APPARATO è 1,2,3
							if(cap.ESITO_CONSEGNA_APPARATO=='1' || cap.ESITO_CONSEGNA_APPARATO=='2' || cap.ESITO_CONSEGNA_APPARATO=='3'){
	
								if(string.isblank(cap.ID_APPARATO_CONSEGNATO)){
									return OF_SA_GE_UtilsNew.syncError (co,'A05','ID_APPARATO_CONSEGNATO');
								}else if(cap.ID_APPARATO_CONSEGNATO.length()>50){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','ID_APPARATO_CONSEGNATO');
								}
							}
							else{
								if(!string.isblank(cap.ID_APPARATO_CONSEGNATO) && cap.ID_APPARATO_CONSEGNATO.length()>50){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','ID_APPARATO_CONSEGNATO');
								}
							}
							// campo CODICE_MOTIVAZIONE_CONSEGNA e campo MOTIVAZIONE_CONSEGNA obbligatori solo se ESITO_CONSEGNA_APPARATO è 0,3,5
							if(cap.ESITO_CONSEGNA_APPARATO=='0' || cap.ESITO_CONSEGNA_APPARATO=='3' || cap.ESITO_CONSEGNA_APPARATO=='5'){
	
								if(string.isblank(cap.CODICE_MOTIVAZIONE_CONSEGNA)){
									return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_MOTIVAZIONE_CONSEGNA');
								}else if(cap.CODICE_MOTIVAZIONE_CONSEGNA.length()>3){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE_CONSEGNA');
								}
								if(string.isblank(cap.MOTIVAZIONE_CONSEGNA)){
									return OF_SA_GE_UtilsNew.syncError (co,'A05','MOTIVAZIONE_CONSEGNA');
								}else if(cap.MOTIVAZIONE_CONSEGNA.length()>255){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','MOTIVAZIONE_CONSEGNA');
								}
							}
							else{
									if(!string.isblank(cap.CODICE_MOTIVAZIONE_CONSEGNA) && cap.CODICE_MOTIVAZIONE_CONSEGNA.length()>3){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE_CONSEGNA');
									}
									if(!string.isblank(cap.MOTIVAZIONE_CONSEGNA) && cap.MOTIVAZIONE_CONSEGNA.length()>255){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','MOTIVAZIONE_CONSEGNA');
								}
							}
						}
					}
				}
				//caso liste non uguali
				else{  
					return OF_SA_GE_UtilsNew.syncError (co,'A06','Apparati');
				}
			}
			//caso apparati = null
			else{
				if(cListCPE.size()>0){
					return OF_SA_GE_UtilsNew.syncError (co,'A05','Apparati');
				}
			}
		}  

		List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
		Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_OM_AsyncChecksNew.OM_AsyncCompletionOrderNew(cList[0], co);
		caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
		if(responseFromOM.containsKey('0')) { 
			
			slList.add(responseFromOM.get('0'));
			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
											 'Codice_operatore' => co.CODICE_OPERATORE,
											 'Codice_ordine_OLO' => co.CODICE_ORDINE_OLO,
											 'ID_notifica' => co.ID_NOTIFICA,
											 'Flusso' => 'OM-SF',
											 'Metodo' => 'OF_CompletionOrder_OpenStream',
											 'Tipo Comunicazione' => 'OM->SF - ACK - CompletionOrder',
											 'Caso' => cList[0].Id,
											 'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;
			caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
			//aggiorno il case,apparati e servizi aggiuntivi
			Case c = cList[0];
			c.OF_Id_Borchia__c = co.SERIALE_BORCHIA;
			c.EOF_GPON_Attestazione__c = co.GPON_DI_ATTESTAZIONE;
			c.EOF_Flag_Pagamento__c = co.FLAG_PAGAMENTO;
			c.EOF_Numero_Operatore__c =  co.NUMERO_OPERATORE;
			c.OF_Bretella_Ottica__c = co.BRETELLA_OTTICA;
			c.OF_Estensione_Impianto_Effettuata__c = co.ESTENSIONE_IMPIANTO_EFFETTUATA;
			c.OF_Estensione_Impianto__c = co.ESTENSIONE_IMPIANTO;
			c.OF_Metri_TOT__c = co.METRI_TOT;
			c.EOF_Scala_Palazzina_WS__c = co.SCALA_PALAZZINA;
			//creo una lista di commercial element instaanziati su cui andare in update
			List<OF_commercialElementIstanziato__c> ceiListToUpdate = new List<OF_commercialElementIstanziato__c>();
			
			if(co.stato_Ordine=='0'){
				c.Status='Espletato';
				c.EOF_Fase__c='Espletato OK';
				c.EOF_ID_Risorsa__c=co.Id_risorsa;
				OF_SA_GE_UtilsNew.aggiornamentoDatiEspletamentoNew(c.Id,OF_SA_GE_UtilsNew.slSFOLO.id,OF_SA_GE_UtilsNew.slSFOLOResp.id);
			   
				if(co.APPARATO!=null && !co.APPARATO.isEmpty()){
					for(OF_WS_IN_OM_CompletionOrderNew.APPARATO cap : co.APPARATO){
						//REcupero la lista di CEI
						List<OF_commercialElementIstanziato__c> cpeList = ceiMap.get(cap.Tipologia_Apparato.toUpperCase());
						OF_commercialElementIstanziato__c ceiToUpdate = cpeList.get(0);
						ceiToUpdate.OF_ESITOCONSEGNAAPPARATO__c=cap.ESITO_CONSEGNA_APPARATO;
						ceiToUpdate.OF_IDAPPARATOCONSEGNATO__c=cap.ID_APPARATO_CONSEGNATO;
						ceiToUpdate.OF_CODICEMOTIVAZIONECONSEGNA__c=cap.CODICE_MOTIVAZIONE_CONSEGNA;
						ceiToUpdate.OF_MOTIVAZIONECONSEGNA__c=cap.MOTIVAZIONE_CONSEGNA;
						ceiListToUpdate.add(ceiToUpdate);
						cpeList.remove(0);
					}
				}
				caseID = OF_SA_GE_UtilsNew.caseOriginale.Id;
				if(co.SERVIZIO_AGGIUNTIVO!=null && !co.SERVIZIO_AGGIUNTIVO.isEmpty()){
					
					for(OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sa : co.SERVIZIO_AGGIUNTIVO){
						//REcupero la lista di CEI
						List<OF_commercialElementIstanziato__c> servAggList = ceiMap.get(sa.Nome_Servizio.toUpperCase());
						OF_commercialElementIstanziato__c ceiToUpdate = servAggList.get(0);
						if (String.isNotBlank(sa.METRI_TOT)) {
							try {
								ceiToUpdate.metriTot__c = Decimal.valueOf(sa.METRI_TOT);
							} catch (Exception e) {
								System.debug('Valore METRI_TOT [' + sa.METRI_TOT + '] errato per il servizio aggiuntivo ' + sa.Nome_Servizio);
							}
						}
						ceiToUpdate.OF_ESITOSERVIZIO__c=sa.ESITO_SERVIZIO;
						ceiToUpdate.OF_CODICEMOTIVAZIONE_SERVIZIO__c=sa.CODICE_MOTIVAZIONE_SERVIZIO;
						ceiToUpdate.OF_MOTIVAZIONESERVIZIO__c=sa.MOTIVAZIONE_SERVIZIO;
						ceiListToUpdate.add(ceiToUpdate);
						servAggList.remove(0);
					}
				}
				update ceiListToUpdate;
			}
			else{
				c.Status='Espletato KO';
				c.EOF_Fase__c='Espletato KO';
				//Salvo le motivazioni di KO
				c.OF_SA_Codice_Motivazione__c = co.CODICE_MOTIVAZIONE;
				c.OF_SA_Motivazione__c = co.MOTIVAZIONE;
				
				OF_SA_GE_UtilsNew.aggiornamentoDatiEspletamentoNew(c.Id,OF_SA_GE_UtilsNew.slSFOLO.id,OF_SA_GE_UtilsNew.slSFOLOResp.id);
			  
			} 
			update c;
			
			/**Start - ADD by PG - 18-10 - Verticali*/
			if(co.stato_Ordine=='0'){
				//classe verticali input [c,co]
			}			
			/**End - ADD by PG - 18-10 - Verticali*/
			
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
				responseToOlo.esito='0';
			
			// Aggiorno il timestamp. E.2 corrisponde a fine check espletamento.
			OF_SA_GE_UtilsNew.partialTemplog('E.2');
			// finisce qui
			
			OF_SA_GE_UtilsNew.EndTemplog();
			
			return  responseToOlo;
		}
		else{
		
			slList.add(responseFromOM.get('1'));
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
			responseToOlo.esito='1';
			EOF_EAI_Service_Log__c sl= responseFromOM.get('1'); 
			responseToOlo.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
			responseToOlo.motivazione=sl.EOF_MOTIVAZIONE__C;
			responseToOlo.id_notifica=sl.EOF_Id_Notifica__c;

			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
													 'Codice_errore' => responseToOlo.codice_motivazione,
													 'Causale_errore' => responseToOlo.motivazione,
													 'Flusso' => 'OM-SF',
													 'Metodo' => 'OF_CompletionOrder_OpenStream',
													 'Codice_operatore' => co.CODICE_OPERATORE,
													 'Codice_ordine_OLO' => co.CODICE_ORDINE_OLO,
													 'ID_notifica' => co.ID_NOTIFICA,
													 'Tipo Comunicazione' => 'OM->SF - NACK - CompletionOrder',
													 'Caso' => cList[0].Id,
													 'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;

			// Aggiorno il timestamp. E.2 corrisponde a fine check espletamento.
			OF_SA_GE_UtilsNew.partialTemplog('E.2');
			// finisce qui
			
			OF_SA_GE_UtilsNew.EndTemplog();
			
			return  responseToOlo;
		}		
	} 
	//CompletionOrder Passivi
	public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse SyncChecksNotifyCompletionOrder_GPONP(OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co){

	   // Aggiorno il timestamp. E.1 corrisponde a inizio check espletamento.
		OF_SA_GE_UtilsNew.partialTemplog('E.1');
		// finisce qui
		
		if(string.isblank(co.CODICE_OPERATORE)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_OPERATORE'); 
		}else if(co.CODICE_OPERATORE.length()>3){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_OPERATORE');
		}			 
		  
		Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		Boolean olo_found = false;
		for(Schema.PicklistEntry s : ple){
			if(co.CODICE_OPERATORE == s.getLabel()){
				olo_found = true;
			}
		}		
		if(!olo_found){
			 return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_OPERATORE');
		}
		if(string.isblank(co.CODICE_ORDINE_OLO)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_ORDINE_OLO');
		}else if (co.CODICE_ORDINE_OLO.length()>18){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_ORDINE_OLO');
		}else if (co.CODICE_ORDINE_OLO.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','CODICE_ORDINE_OLO');
		}
		if(string.isblank(co.CODICE_ORDINE_OF)){
				return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_ORDINE_OF');
		}else if(co.CODICE_ORDINE_OF.length()>18){
				return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_ORDINE_OF');
		}else if (co.CODICE_ORDINE_OF.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','CODICE_ORDINE_OF');
		}
		

		// Aggiorno il timestamp. QC.1 corrisponde a pre query.
		OF_SA_GE_UtilsNew.partialTemplog('QC.1');
		// finisce qui
		
		//qui verifico che il case sia a sistema
		// 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni
		List<Case> cList = [SELECT Id, status, PO_SA_Portale__C,OF_Order__c, OF_Blocked_Case__c 
							FROM Case 
							WHERE EOF_Codice_Ordine_Olo__c =:co.Codice_Ordine_Olo 
							AND Codice_Ordine_Eof__c =:co.Codice_Ordine_OF 
							AND EOF_Codice_Operatore_WS__c=:co.CODICE_OPERATORE 
							AND RecordType.DeveloperName = 'EOF_Caso_Attivazione'];
		
	   // Aggiorno il timestamp. QC.2 corrisponde a post query.
		OF_SA_GE_UtilsNew.partialTemplog('QC.2');
		// finisce qui

		if(cList.isEmpty()){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
		}
		else{
			OF_SA_GE_UtilsNew.caseOriginale=cList[0];
			OF_SA_GE_UtilsNew.checkCaseOriginale=true;
		}
		// 8/01/2018 Marco : fine modifica
		//verifico che lo status sia congruente
		//Done AA - 02/10/2018 - Controllare se il campo "OF_Blocked_Case__c" è valorizzato a true
	   	//TODO AA - 02/10/2018 - Condividere codice errore per blocked case
		if(OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c){//C'è qualche status update dall'olo non notificato all'OM
			return OF_SA_GE_UtilsNew.syncError (co,'A07','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
		} 
		if(cList[0].status!='Accettato'){
			return OF_SA_GE_UtilsNew.syncError (co,'A03','Messaggio non ammesso');
		}

		
		if(string.isblank(co.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','DATA_NOTIFICA');
		}else if(!OF_SA_GE_UtilsNew.checkDateTime(co.DATA_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','DATA_NOTIFICA');
		}
		if(string.isblank(co.ID_NOTIFICA)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','ID_NOTIFICA');
		}else if(co.ID_NOTIFICA.length()>100){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','ID_NOTIFICA');
		}else if (co.ID_NOTIFICA.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','ID_NOTIFICA');
		}
		if(string.isblank(co.STATO_ORDINE) || co.STATO_ORDINE.length()>1){
			if(string.isblank(co.STATO_ORDINE)){
				return OF_SA_GE_UtilsNew.syncError (co,'A05','STATO_ORDINE');
			}
			if(co.STATO_ORDINE!='0' && co.STATO_ORDINE!='1'){
				return OF_SA_GE_UtilsNew.syncError (co,'A06','STATO_ORDINE');
			}
		}

		if(string.isblank(co.CODICE_MOTIVAZIONE)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_MOTIVAZIONE');
		}else if(co.CODICE_MOTIVAZIONE.length()>3){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE');
		}else if (co.CODICE_MOTIVAZIONE.contains('�')){
			return OF_SA_GE_UtilsNew.syncError (co,'B04','CODICE_MOTIVAZIONE');
		}
		if(string.isblank(co.MOTIVAZIONE) || co.MOTIVAZIONE.length()>255){
			if(string.isblank(co.MOTIVAZIONE)){
				return OF_SA_GE_UtilsNew.syncError (co,'A05','MOTIVAZIONE');
			}
			else{
				return OF_SA_GE_UtilsNew.syncError (co,'A06','MOTIVAZIONE');
			}
		}
		
		if(co.STATO_ORDINE=='0' && string.isBlank(co.ID_RISORSA)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','ID_RISORSA');
		}else if(!string.isblank(co.ID_RISORSA) && co.ID_RISORSA.length()>50){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','ID_RISORSA');
		}
		/*if(co.STATO_ORDINE=='0' && string.isBlank(co.SCALA_PALAZZINA)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','SCALA_PALAZZINA');
		}*/
		
		if(!string.isblank(co.SCALA_PALAZZINA) && co.SCALA_PALAZZINA.length()>21){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','SCALA_PALAZZINA');
		}
		if(string.isblank(co.DATA_ESPLETAMENTO_ORDINE)){
			return OF_SA_GE_UtilsNew.syncError (co,'A05','DATA_ESPLETAMENTO_ORDINE');
		}else if(!OF_SA_GE_UtilsNew.checkDate(co.DATA_ESPLETAMENTO_ORDINE)){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','DATA_ESPLETAMENTO_ORDINE');
		}

		if(!string.isblank(co.DDT) && co.DDT.length()>255){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','DDT');
		}
		if(!string.isblank(co.NOTE) && co.NOTE.length()>255){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','NOTE');
		}		 
		//AA 300119 - Nuovi campi 
		if(!string.isblank(co.GPON_DI_ATTESTAZIONE) && co.GPON_DI_ATTESTAZIONE.length()>14){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','GPON_DI_ATTESTAZIONE');
		}
		if(String.isNotBlank(co.SERIALE_BORCHIA) && co.SERIALE_BORCHIA.length() > 50){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','SERIALE_BORCHIA');
		}
		if(String.isNotBlank(co.FLAG_PAGAMENTO) && co.FLAG_PAGAMENTO != '0' && co.FLAG_PAGAMENTO != '1'){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','FLAG_PAGAMENTO');
		}
		if(String.isNotBlank(co.NUMERO_OPERATORE) && co.NUMERO_OPERATORE != '1' && co.NUMERO_OPERATORE != '2' && co.NUMERO_OPERATORE != '3' && co.NUMERO_OPERATORE != '4'){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','NUMERO_OPERATORE');
		}
		if(String.isNotBlank(co.BRETELLA_OTTICA) && co.BRETELLA_OTTICA != 'Y' && co.BRETELLA_OTTICA != 'N'){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','BRETELLA_OTTICA'); 
		}
		if(String.isNotBlank(co.ESTENSIONE_IMPIANTO_EFFETTUATA) && co.ESTENSIONE_IMPIANTO_EFFETTUATA != 'SI' && co.ESTENSIONE_IMPIANTO_EFFETTUATA != 'NO'){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','ESTENSIONE_IMPIANTO_EFFETTUATA'); 
		}
		if(String.isNotBlank(co.ESTENSIONE_IMPIANTO) && co.ESTENSIONE_IMPIANTO.length() > 15){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','ESTENSIONE_IMPIANTO'); 
		}
		if(String.isNotBlank(co.METRI_TOT) && co.METRI_TOT.length() > 5){
			return OF_SA_GE_UtilsNew.syncError (co,'A06','METRI_TOT'); 
		}
		//FINE AA 300119
		Map<String, List<OF_commercialElementIstanziato__c>> ceiMap = new Map<String, List<OF_commercialElementIstanziato__c>>();
		
		if(co.STATO_ORDINE=='0'){
			// CONTROLLI OBB PER STATO ORDINE = 0 e TIPOLOGIA PASSIVI
			if(string.isblank(co.ID_SPLITTER_SECONDARIO)){
				return OF_SA_GE_UtilsNew.syncError (co,'A05','ID_SPLITTER_SECONDARIO');
			}else if(co.ID_SPLITTER_SECONDARIO.length()>50){
				return OF_SA_GE_UtilsNew.syncError (co,'A06','ID_SPLITTER_SECONDARIO');
			}
			
			if(string.isblank(co.POSIZIONE_SPLITTER_SECONDARIO)){
				return OF_SA_GE_UtilsNew.syncError (co,'A05','POSIZIONE_SPLITTER_SECONDARIO');
			}else if(co.POSIZIONE_SPLITTER_SECONDARIO.length()>50){
				return OF_SA_GE_UtilsNew.syncError (co,'A06','POSIZIONE_SPLITTER_SECONDARIO');
			}
			
			if(string.isblank(co.PARAMETRI_TRASMISSIVI_OTTICI)){
				return OF_SA_GE_UtilsNew.syncError (co,'A05','PARAMETRI_TRASMISSIVI_OTTICI');
			}else if(co.PARAMETRI_TRASMISSIVI_OTTICI.length()>50){
				return OF_SA_GE_UtilsNew.syncError (co,'A06','PARAMETRI_TRASMISSIVI_OTTICI');
			}
			//FINE CONTROLLI 
			List<String> cListCPE = new List<String>(); 
			List<String> cListSA = new List<String>();
			//creo una mappa per poi salvare i dati dell'espletamento sui commercial element instanziati
			
			List<OF_commercialElementIstanziato__c> ceiList = [SELECT ID,RecordType.DeveloperName,OF_Nome_Servizio__C,OF_TipologiaApparato__C,metriTot__c FROM OF_CommercialElementIstanziato__c 
															WHERE (OF_SA_Servizio_Aggiuntivo__c=: co.CODICE_ORDINE_OF AND RecordType.DeveloperName='OF_ServiziAggiuntivi') 
															OR (OF_SA_CPE__c=: co.CODICE_ORDINE_OF AND RecordType.DeveloperName='OF_CPE')];
			for (OF_commercialElementIstanziato__c cei : ceiList){
				if(cei.RecordType.DeveloperName=='OF_CPE'){
					//Vado a verificare se la map contiene già qualche valore
					List<OF_CommercialElementIstanziato__c> cpeTypeList = ceiMap.get(cei.OF_TipologiaApparato__C.toUpperCase());
					//Se non è stato ancora aggiunto nessuna CPE, vado a creare la lista
					if(cpeTypeList == null){
						cpeTypeList = new List<OF_CommercialElementIstanziato__c>();
					}
					cpeTypeList.add(cei);
					cListCPE.add(cei.OF_TipologiaApparato__C.toUpperCase());
					ceiMap.put(cei.OF_TipologiaApparato__C.toUpperCase(), cpeTypeList);
				}
				if(cei.RecordType.DeveloperName=='OF_ServiziAggiuntivi'){
					//Vado a verificare se la map contiene già qualche valore
					List<OF_CommercialElementIstanziato__c> servAggNameList = ceiMap.get(cei.OF_Nome_Servizio__c.toUpperCase());
					//Se non è stato ancora aggiunto nessun ServAgg, vado a creare la lista
					if(servAggNameList == null){
						servAggNameList = new List<OF_CommercialElementIstanziato__c>();
					}
					servAggNameList.add(cei);
					cListSA.add(cei.OF_Nome_Servizio__C.toUpperCase());
					ceiMap.put(cei.OF_Nome_Servizio__c.toUpperCase(), servAggNameList);
				}
			}
			
			if(co.SERVIZIO_AGGIUNTIVO!=null){
				List<String> cListSAOM = new List<String>();
				for(OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai : co.SERVIZIO_AGGIUNTIVO){
					cListSAOM.add(sai.NOME_SERVIZIO.toUpperCase());
				}
				cListSAOM.sort();
				cListSA.sort();
				if(cListSAOM.equals(cListSA)){
					if(co.SERVIZIO_AGGIUNTIVO.size()>0){
						for(OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai : co.SERVIZIO_AGGIUNTIVO){
								if(string.isblank(sai.NOME_SERVIZIO)){
									return OF_SA_GE_UtilsNew.syncError (co,'A05','NOME_SERVIZIO');
								}else if(sai.NOME_SERVIZIO.length()>50){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','NOME_SERVIZIO');
								}
								if(string.isblank(sai.ESITO_SERVIZIO)){
									return OF_SA_GE_UtilsNew.syncError (co,'A05','ESITO_SERVIZIO');
								}else if(sai.ESITO_SERVIZIO.length()>1){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','ESITO_SERVIZIO');
								}
								if(sai.ESITO_SERVIZIO=='1'){
									if(string.isblank(sai.CODICE_MOTIVAZIONE_SERVIZIO)){
										return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_MOTIVAZIONE_SERVIZIO');
									}else if(sai.CODICE_MOTIVAZIONE_SERVIZIO.length()>3){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE_SERVIZIO');
									}
									if(string.isblank(sai.MOTIVAZIONE_SERVIZIO)){
										return OF_SA_GE_UtilsNew.syncError (co,'A05','MOTIVAZIONE_SERVIZIO');
									}else if(sai.MOTIVAZIONE_SERVIZIO.length()>255){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','MOTIVAZIONE_SERVIZIO');
									}
								}
								else {
									if(!string.isblank(sai.CODICE_MOTIVAZIONE_SERVIZIO) && sai.CODICE_MOTIVAZIONE_SERVIZIO.length()>3){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE_SERVIZIO');
									}
									if(!string.isblank(sai.MOTIVAZIONE_SERVIZIO) && sai.MOTIVAZIONE_SERVIZIO.length()>255){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE_SERVIZIO');
									}
								}
							}
						
					}
				}
				//caso liste non uguali
				else{   
					return OF_SA_GE_UtilsNew.syncError (co,'A06','Servizi Aggiuntivi');
				}
			}
			//caso servizi aggiuntivi = null
			else{
				if(cListSA.size()>0){
					return OF_SA_GE_UtilsNew.syncError (co,'A05','Servizi Aggiuntivi');
				}
			} 
			
			if(co.APPARATO!=null){
				List<String> cListCPEOM = new List<String>();
				for(OF_WS_IN_OM_CompletionOrderNew.APPARATO cap : co.APPARATO){
					cListCPEOM.add(cap.TIPOLOGIA_APPARATO.toUpperCase());
				}
				cListCPEOM.sort();
				cListCPE.sort();
				if(cListCPEOM.equals(cListCPE)){
					if(!co.APPARATO.isempty()){
						for(OF_WS_IN_OM_CompletionOrderNew.APPARATO cap : co.APPARATO){
							
							if(string.isblank(cap.TIPOLOGIA_APPARATO)){
								return OF_SA_GE_UtilsNew.syncError (co,'A05','TIPOLOGIA_APPARATO');
							}else if(cap.TIPOLOGIA_APPARATO.length()>100){
								return OF_SA_GE_UtilsNew.syncError (co,'A06','TIPOLOGIA_APPARATO');
							}
							if(string.isblank(cap.ESITO_CONSEGNA_APPARATO)){
								return OF_SA_GE_UtilsNew.syncError (co,'A05','ESITO_CONSEGNA_APPARATO');
							}else if(cap.ESITO_CONSEGNA_APPARATO.length()>1){
								return OF_SA_GE_UtilsNew.syncError (co,'A06','ESITO_CONSEGNA_APPARATO');
							}
							// campo ID_APPARATO_CONSEGNATO obbligatorio solo se ESITO_CONSEGNA_APPARATO è 1,2,3
							if(cap.ESITO_CONSEGNA_APPARATO=='1' || cap.ESITO_CONSEGNA_APPARATO=='2' || cap.ESITO_CONSEGNA_APPARATO=='3'){
	
								if(string.isblank(cap.ID_APPARATO_CONSEGNATO)){
									return OF_SA_GE_UtilsNew.syncError (co,'A05','ID_APPARATO_CONSEGNATO');
								}
								if(cap.ID_APPARATO_CONSEGNATO.length()>50){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','ID_APPARATO_CONSEGNATO');
								}
							}
							else{
								if(!string.isblank(cap.ID_APPARATO_CONSEGNATO) && cap.ID_APPARATO_CONSEGNATO.length()>50){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','ID_APPARATO_CONSEGNATO');
								}
							}
							// campo CODICE_MOTIVAZIONE_CONSEGNA e campo MOTIVAZIONE_CONSEGNA obbligatori solo se ESITO_CONSEGNA_APPARATO è 0,3,5
							if(cap.ESITO_CONSEGNA_APPARATO=='0' || cap.ESITO_CONSEGNA_APPARATO=='3' || cap.ESITO_CONSEGNA_APPARATO=='5'){
	
								if(string.isblank(cap.CODICE_MOTIVAZIONE_CONSEGNA)){
									return OF_SA_GE_UtilsNew.syncError (co,'A05','CODICE_MOTIVAZIONE_CONSEGNA');
								}
								if(cap.CODICE_MOTIVAZIONE_CONSEGNA.length()>3){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE_CONSEGNA');
								}
								if(string.isblank(cap.MOTIVAZIONE_CONSEGNA)){
									return OF_SA_GE_UtilsNew.syncError (co,'A05','MOTIVAZIONE_CONSEGNA');
								}
								if(cap.MOTIVAZIONE_CONSEGNA.length()>255){
									return OF_SA_GE_UtilsNew.syncError (co,'A06','MOTIVAZIONE_CONSEGNA');
								}
							}
							else{
									if(!string.isblank(cap.CODICE_MOTIVAZIONE_CONSEGNA) && cap.CODICE_MOTIVAZIONE_CONSEGNA.length()>3){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','CODICE_MOTIVAZIONE_CONSEGNA');
									}
									if(!string.isblank(cap.MOTIVAZIONE_CONSEGNA) && cap.MOTIVAZIONE_CONSEGNA.length()>255){
										return OF_SA_GE_UtilsNew.syncError (co,'A06','MOTIVAZIONE_CONSEGNA');
								}
							}
						}
					}
				}
				//caso liste non uguali
				else{  
					return OF_SA_GE_UtilsNew.syncError (co,'A06','Apparati');
				}
			}
			//caso apparati = null
			else{
				if(cListCPE.size()>0){
					return OF_SA_GE_UtilsNew.syncError (co,'A05','Apparati');
				}
			}
		}else{//STATO_ORDINE = 1
			if(String.isNotBlank(co.ID_SPLITTER_SECONDARIO) && co.ID_SPLITTER_SECONDARIO.length()>50){
				return OF_SA_GE_UtilsNew.syncError (co,'A06','ID_SPLITTER_SECONDARIO');
			}
			if(String.isNotBlank(co.POSIZIONE_SPLITTER_SECONDARIO) && co.POSIZIONE_SPLITTER_SECONDARIO.length()>50){
				return OF_SA_GE_UtilsNew.syncError (co,'A06','POSIZIONE_SPLITTER_SECONDARIO');
			}
			if(!string.isblank(co.PARAMETRI_TRASMISSIVI_OTTICI) && co.PARAMETRI_TRASMISSIVI_OTTICI.length()>255){
				return OF_SA_GE_UtilsNew.syncError (co,'A06','PARAMETRI_TRASMISSIVI_OTTICI');
			}
		}
		//aggiorno il case,apparati e servizi aggiuntivi
		Case c = cList[0];
		//AA 291118 - Prima di fare l'update, aggiungo i nuovi campi richiesti
		c.OF_Id_Borchia__c = co.SERIALE_BORCHIA;
		c.EOF_GPON_Attestazione__c = co.GPON_DI_ATTESTAZIONE;
		c.EOF_Flag_Pagamento__c = co.FLAG_PAGAMENTO;
		c.EOF_Numero_Operatore__c =  co.NUMERO_OPERATORE;
		c.OF_Bretella_Ottica__c = co.BRETELLA_OTTICA;
		c.OF_Estensione_Impianto_Effettuata__c = co.ESTENSIONE_IMPIANTO_EFFETTUATA;
		c.OF_Estensione_Impianto__c = co.ESTENSIONE_IMPIANTO;
		c.OF_Metri_TOT__c = co.METRI_TOT;
		c.EOF_ID_Splitter_Secondario__c = co.ID_SPLITTER_SECONDARIO;
		c.EOF_Posizione_Splitter_Secondario__c = co.POSIZIONE_SPLITTER_SECONDARIO;
		c.EOF_Scala_Palazzina_WS__c = co.SCALA_PALAZZINA;
		//FINE AA
		List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
		Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_OM_AsyncChecksNew.OM_AsyncCompletionOrderNew_GPONP(c, co);
		
		if(responseFromOM.containsKey('0')) { 
			
			slList.add(responseFromOM.get('0'));
			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
											 'Codice_operatore' => co.CODICE_OPERATORE,
											 'Codice_ordine_OLO' => co.CODICE_ORDINE_OLO,
											 'ID_notifica' => co.ID_NOTIFICA,
											 'Flusso' => 'OM-SF',
											 'Metodo' => 'OF_CompletionOrder_OpenStream',
											 'Tipo Comunicazione' => 'OM->SF - ACK - CompletionOrder',
											 'Caso' => c.Id,
											 'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;
			
			
			//creo una lista di commercial element instaanziati su cui andare in update
			List<OF_commercialElementIstanziato__c> ceiListToUpdate = new List<OF_commercialElementIstanziato__c>();
			
			if(co.stato_Ordine=='0'){
				c.Status='Espletato';
				c.EOF_Fase__c='Espletato OK';
				c.EOF_ID_Risorsa__c=co.Id_risorsa;
				OF_SA_GE_UtilsNew.aggiornamentoDatiEspletamentoNew_GPONP(c.Id,OF_SA_GE_UtilsNew.slSFOLO.id,OF_SA_GE_UtilsNew.slSFOLOResp.id);
			   
				if(co.APPARATO!=null && !co.APPARATO.isEmpty()){
					for(OF_WS_IN_OM_CompletionOrderNew.APPARATO cap : co.APPARATO){
						//REcupero la lista di CEI
						List<OF_commercialElementIstanziato__c> cpeList = ceiMap.get(cap.Tipologia_Apparato.toUpperCase());
						OF_commercialElementIstanziato__c ceiToUpdate = new OF_commercialElementIstanziato__c();
						ceiToUpdate = cpeList.get(0);
						ceiToUpdate.OF_ESITOCONSEGNAAPPARATO__c=cap.ESITO_CONSEGNA_APPARATO;
						ceiToUpdate.OF_IDAPPARATOCONSEGNATO__c=cap.ID_APPARATO_CONSEGNATO;
						ceiToUpdate.OF_CODICEMOTIVAZIONECONSEGNA__c=cap.CODICE_MOTIVAZIONE_CONSEGNA;
						ceiToUpdate.OF_MOTIVAZIONECONSEGNA__c=cap.MOTIVAZIONE_CONSEGNA;
						ceiListToUpdate.add(ceiToUpdate);
						cpeList.remove(0);
					}
				}
				
				if(co.SERVIZIO_AGGIUNTIVO!=null && !co.SERVIZIO_AGGIUNTIVO.isEmpty()){
					
					for(OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sa : co.SERVIZIO_AGGIUNTIVO){
						/*Vado a controllare se il ServAgg è Expedite e in caso di Esito 0, setto il campo Sla premium assurance = 'Y',
						* in modo da creare il BEI "Canone Premium" nella fase di espletamento */
						if('EXPEDITE'.equalsIgnoreCase(sa.Nome_Servizio.toUpperCase()) || 'EXPEDITE PROCESS'.equalsIgnoreCase(sa.Nome_Servizio.toUpperCase()) ){
							if('0'.equalsIgnoreCase(sa.ESITO_SERVIZIO)){
								c.EOF_SLA_Premium_Assurance__c = 'Y';
							}else{
								c.EOF_SLA_Premium_Assurance__c = 'N';
							}
						}
						//REcupero la lista di CEI
						List<OF_commercialElementIstanziato__c> servAggList = ceiMap.get(sa.Nome_Servizio.toUpperCase());
						OF_commercialElementIstanziato__c ceiToUpdate = servAggList.get(0);
						ceiToUpdate.OF_ESITOSERVIZIO__c=sa.ESITO_SERVIZIO;
						ceiToUpdate.OF_CODICEMOTIVAZIONE_SERVIZIO__c=sa.CODICE_MOTIVAZIONE_SERVIZIO;
						ceiToUpdate.OF_MOTIVAZIONESERVIZIO__c=sa.MOTIVAZIONE_SERVIZIO;
						if (String.isNotBlank(sa.METRI_TOT)) {
							try {
								ceiToUpdate.metriTot__c = Decimal.valueOf(sa.METRI_TOT);
							} catch (Exception e) {
								System.debug('Valore METRI_TOT [' + sa.METRI_TOT + '] errato per il servizio aggiuntivo ' + sa.Nome_Servizio);
							}
						}
						ceiListToUpdate.add(ceiToUpdate);
						servAggList.remove(0);
					}
				}
				update ceiListToUpdate;
			}
			else{
				c.Status='Espletato KO';
				c.EOF_Fase__c='Espletato KO';
				//Salvo le motivazioni di KO
				c.OF_SA_Codice_Motivazione__c = co.CODICE_MOTIVAZIONE;
				c.OF_SA_Motivazione__c = co.MOTIVAZIONE;
				
				OF_SA_GE_UtilsNew.aggiornamentoDatiEspletamentoNew_GPONP(c.Id,OF_SA_GE_UtilsNew.slSFOLO.id,OF_SA_GE_UtilsNew.slSFOLOResp.id);
				
			} 
			update c;
			
			/**Start - ADD by PG - 18-10 - Verticali*/
			if(co.stato_Ordine=='0'){
				//classe verticali input [c,co]
			}			
			/**End - ADD by PG - 18-10 - Verticali*/
			
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
				responseToOlo.esito='0';
			
			// Aggiorno il timestamp. E.2 corrisponde a fine check espletamento.
			OF_SA_GE_UtilsNew.partialTemplog('E.2');
			// finisce qui
			
			OF_SA_GE_UtilsNew.EndTemplog();
			
			return  responseToOlo;
		}
		else{
		
			slList.add(responseFromOM.get('1'));
			OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
			responseToOlo.esito='1';
			EOF_EAI_Service_Log__c sl= responseFromOM.get('1'); 
			responseToOlo.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
			responseToOlo.motivazione=sl.EOF_MOTIVAZIONE__C;
			responseToOlo.id_notifica=sl.EOF_Id_Notifica__c;

			slList.add(OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
													 'Codice_errore' => responseToOlo.codice_motivazione,
													 'Causale_errore' => responseToOlo.motivazione,
													 'Flusso' => 'OM-SF',
													 'Metodo' => 'OF_CompletionOrder_OpenStream',
													 'Codice_operatore' => co.CODICE_OPERATORE,
													 'Codice_ordine_OLO' => co.CODICE_ORDINE_OLO,
													 'ID_notifica' => co.ID_NOTIFICA,
													 'Tipo Comunicazione' => 'OM->SF - NACK - CompletionOrder',
													 'Caso' => cList[0].Id,
													 'SL Riferimento' => OF_SA_GE_UtilsNew.slOMSF.Id}));
			Insert slList;

			// Aggiorno il timestamp. E.2 corrisponde a fine check espletamento.
			OF_SA_GE_UtilsNew.partialTemplog('E.2');
			// finisce qui
			
			OF_SA_GE_UtilsNew.EndTemplog();
			
			return  responseToOlo;
		}		
	} 
}
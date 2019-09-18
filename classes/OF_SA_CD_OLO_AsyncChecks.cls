public class OF_SA_CD_OLO_AsyncChecks {	
	
	@future(callout=true)    
	//ATTIVAZIONE
    public static void OLO_AsyncActivation(String caseId, String SLOloSfId){
    	
    	System.debug('*****Sono dentro OLO_AsyncActivation - ASYNC_CHECKS*****');
    	
    	String tipo_servizio = '';
    	
        OF_SA_CD_GE_Utils.caseOriginale = Database.query(OF_SA_CD_GE_Utils.getQuery('case','AsyncActivation')+
        										' where id=:caseId'); 
        										system.debug('Alessandro: query: '+OF_SA_CD_GE_Utils.getQuery('sl','AsyncActivation')+
    											' where id =:SLOloSfId' 
		        								+' OR OF_SA_VLan_Log__c =:SLOloSfId'
		        								+' OR OF_SA_Cpe_Log__c =:SLOloSfId'
		        								+' OR OF_SA_servizi_Aggiuntivi_Log__c =:SLOloSfId'
		        								+' order by EOF_Ordine_Invio_OLO__c');
		
		System.debug('*****OF_SA_CD_GE_Utils.caseOriginale*****: '+OF_SA_CD_GE_Utils.caseOriginale);
        
        OF_SA_CD_GE_Utils.ListSlActivationOLOSF = Database.query(OF_SA_CD_GE_Utils.getQuery('sl','AsyncActivation')+
    											' where id =:SLOloSfId' 
		        								+' OR OF_SA_VLan_Log__c =:SLOloSfId'
		        								+' OR OF_SA_Cpe_Log__c =:SLOloSfId'
		        								+' OR OF_SA_servizi_Aggiuntivi_Log__c =:SLOloSfId'
		        								+' order by EOF_Ordine_Invio_OLO__c');
		
		System.debug('*****ListSlActivationOLOSF*****: '+OF_SA_CD_GE_Utils.ListSlActivationOLOSF);
		        								
		OF_SA_CD_GE_Utils.ListVLan = new List<EOF_EAI_Service_Log__c>();        								
		OF_SA_CD_GE_Utils.ListApp = new List<EOF_EAI_Service_Log__c>();        								
		OF_SA_CD_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>(); 
		
		for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListSlActivationOLOSF)
		{
		    //System.debug('#####sl.recordtype.developername #### :'+sl.recordtype.developername);
		    
			if(sl.recordtype.developername=='OF_SA_CeD_FiberRequest'){
				System.debug(']]]]]]] LOG REQUEST ]]]]]]]');
				OF_SA_CD_GE_Utils.slOLOSF=sl;	
			}
			if(sl.recordtype.developername=='OF_SA_Vlan'){
				OF_SA_CD_GE_Utils.checkVLan=true;
				OF_SA_CD_GE_Utils.ListVLan.add(sl);
			}
			if(sl.recordtype.developername=='OF_SA_Cpe'){
				OF_SA_CD_GE_Utils.checkApp=true;
				OF_SA_CD_GE_Utils.ListApp.add(sl);
			}
			if(sl.recordtype.developername=='OF_SA_Servizi_Aggiuntivi'){
				OF_SA_CD_GE_Utils.checkServAgg=true;
				OF_SA_CD_GE_Utils.ListServAgg.add(sl);
			}
		}
        
        //Account Olo = [select id from Account where Type = 'OLO' AND EOF_Codice_Operatore__c =:OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c];
   		if(OF_SA_CD_GE_Utils.caseOriginale.recordtype.developername=='EOF_Caso_Attivazione_OPENSTREAM_CeD'){
   			OF_SA_CD_GE_Utils.processo = 'attivo';
   			tipo_servizio = 'Open Stream CD'; //Add by PG - 05-12 - Setto il tipo di servizio che utilizzo nella query per check contract B05 (vedi sotto)
   		}
   		else if(OF_SA_CD_GE_Utils.caseOriginale.recordtype.developername=='EOF_SP_Caso_Attivazione_CeD'){
   			OF_SA_CD_GE_Utils.processo = 'passivo';
   		    tipo_servizio = 'GPON Passiva CD'; //Add by PG - 05-12 - Setto il tipo di servizio che utilizzo nella query per check contract B05 (vedi sotto)
   		}	
        OLO_ID__c oloId=OLO_ID__c.getInstance(OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c);
        System.debug('******OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c***** : '+OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c);
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c=oloId.OF_Olo_Id__c;
        //controllo cliente, si presuppone che siano gia stati fatti i controlli su cognome_cliente
        OF_SA_CD_GE_Utils.checkCliente=true;
        
        System.debug('******OF_SA_CD_GE_Utils.slOLOSF******: '+OF_SA_CD_GE_Utils.slOLOSF);
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c;
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_PROGETTO_SPECIALE__c = OF_SA_CD_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c;
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_Promozione__c = OF_SA_CD_GE_Utils.slOLOSF.EOF_Promozione__c;
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_Cluster_Promozione__c = OF_SA_CD_GE_Utils.slOLOSF.EOF_Cluster_Promozione__c;
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_Profilo__c = OF_SA_CD_GE_Utils.slOLOSF.EOF_Profilo__c;
        
        if(String.isBlank(OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C)){                        
            
            OF_SA_CD_GE_Utils.cliente = new Account(Name = OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c,
                                                    RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('Cliente_Business'),
                                                    Phone = OF_SA_CD_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                                    EOF_Phone_2__c = OF_SA_CD_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );                       
        }else{
            
            OF_SA_CD_GE_Utils.cliente = new Account(FirstName = OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c,
                                                    LastName = OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c,
                                                    RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('PersonAccount'),
                                                    Phone = OF_SA_CD_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                                    EOF_Phone_2__c = OF_SA_CD_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
        }
        //Using Technician required information in the request to retrieve the Account in the system
        List<Contact> tech = [SELECT Id, FirstName, LastName, Phone, Email 
                              FROM Contact 
                              WHERE FirstName =: OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c 
                              AND LastName =: OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c 
                              AND Phone =: OF_SA_CD_GE_Utils.slOLOSF.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c 
                              AND Email =: OF_SA_CD_GE_Utils.slOLOSF.EOF_EMAIL_REFERENTE_TECNICO_OLO__c];  
                              
        if(!tech.isEmpty()){
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Contact__c = tech.get(0).Id;                   
        }
        else{ 
            OF_SA_CD_GE_Utils.refTec = new COntact();
            OF_SA_CD_GE_Utils.refTec.RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('Referente_Tecnico_OLO');
            OF_SA_CD_GE_Utils.refTec.AccountId = oloId.OF_Olo_Id__c;
            OF_SA_CD_GE_Utils.refTec.FirstName = OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c;
            OF_SA_CD_GE_Utils.refTec.LastName = OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c;
            OF_SA_CD_GE_Utils.refTec.Phone = OF_SA_CD_GE_Utils.slOLOSF.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;
            OF_SA_CD_GE_Utils.refTec.Email = OF_SA_CD_GE_Utils.slOLOSF.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
            OF_SA_CD_GE_Utils.checkRefTec = true;
        }     
        
        OF_SA_CD_GE_Utils.ceiList = new List<OF_CommercialElementIstanziato__c>();
        List<OF_CommercialElement__c> listaCommercialElement;
        System.debug('*****OF_SA_CD_GE_Utils.processo**** : '+OF_SA_CD_GE_Utils.processo);
        
        //Check su tipologia servizio
        if(OF_SA_CD_GE_Utils.processo == 'attivo')
        {
           listaCommercialElement = [SELECT Id, Name 
                                     FROM OF_CommercialElement__c 
                                     where OF_Servizio__r.Name = 'Open Stream CD']; 
                                     
           System.debug('****Commercial Element ATTIVO******');
        }
        else if(OF_SA_CD_GE_Utils.processo == 'passivo')
        {
            listaCommercialElement = [SELECT Id, Name 
                                      FROM OF_CommercialElement__c 
                                      where OF_Servizio__r.Name = 'GPON Passiva CD']; 
                                      
            System.debug('****Commercial Element PASSIVO******');
        }
        //AA 070219 - Modifica CE
        String servAggCEId;
        //FINE AA 070219 - Modifica CE
        Map<String,Id> ceNameId = new Map<String,Id>();
        for(OF_CommercialElement__c ce : listaCommercialElement){
            //AA 070219 - Modifica CE
            if(ce.Name.equalsIgnoreCase('SERVIZI AGGIUNTIVI')){
                servAggCEId = ce.Id;
            }
            //FINE AA 070219 - Modifica CE
            ceNameId.put(ce.Name.ToUpperCase(), ce.Id);
        }
        //AA 070219 - Modifica CE
        ceNameId.put('RIBALTAMENTO IMPIANTO', servAggCEId);
        ceNameId.put('ESTENSIONE IMPIANTO CLIENTE', servAggCEId);
        //FINE AA 070219 - Modifica CE
        
        if(OF_SA_CD_GE_Utils.checkServAgg)
        { 
            Integer n = 1;  
            
            for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListServAgg){ 
                if(!ceNameId.containsKey(sl.OF_SA_NOME_SERVIZIO__c.toUpperCase())){
                    OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Servizio aggiuntivo \''+sl.OF_SA_NOME_SERVIZIO__c+'\' inesistente';
                    OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B09';
                    OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Servizio aggiuntivo \''+sl.OF_SA_NOME_SERVIZIO__c+'\' inesistente';
                    OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO'; 
                    OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA'; 
                    //update c;
                    
                    //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                    OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
                    //chiamo il metodo che gestisce le callout e aggiorna il DB
            		OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);
                    return;
                }
                OF_SA_CD_GE_Utils.checkCEIList=true;
                OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
                cei.recordtypeid = OF_Utility.getRT_DevNameId_Map().get('OF_ServiziAggiuntivi');
                cei.OF_NOME_SERVIZIO__c = sl.OF_SA_NOME_SERVIZIO__c; 
                cei.OF_INFORMAZIONI_SERVIZIO__c = sl.OF_SA_INFORMAZIONI_SERVIZIO__c;
                cei.OF_Case__c = OF_SA_CD_GE_Utils.caseOriginale.Id;
                cei.OF_SA_Servizio_Aggiuntivo__c = OF_SA_CD_GE_Utils.caseOriginale.Id;
                cei.OF_CommercialElement__c = ceNameId.get(sl.OF_SA_NOME_SERVIZIO__c.toUpperCase());
                OF_SA_CD_GE_Utils.ceiList.add(cei); 
            }  
        } 
         
        if(OF_SA_CD_GE_Utils.checkApp)
        {
            Integer n = 1; 
            
            for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListApp){
                
                OF_SA_CD_GE_Utils.checkCEIList=true;
                OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
                cei.recordtypeid = OF_Utility.getRT_DevNameId_Map().get('OF_CPE');
                cei.OF_TIPOLOGIAAPPARATO__c = sl.EOF_TIPOLOGIA_APPARATO__c;
                cei.OF_PASSWORD_APPARATO__c = sl.OF_SA_PASSWORD_APPARATO__c;
                cei.OF_AZIONEAPPARATO__C = sl.OF_SA_AZIONE_APPARATO__c;
                //Add by PG - 01-03 - Valorizzo il campo Esito Consegna Apparato sul CEI
                cei.OF_EsitoConsegnaApparato__c = OF_SA_CD_GE_Utils.valorizzaEsitoConsApparato(sl.OF_SA_AZIONE_APPARATO__c);
                //cei.OF_EsitoConsegnaApparato__c = sl.EOF_Esito_Consegna_Apparato__c;
                //End
                cei.OF_Case__c = OF_SA_CD_GE_Utils.caseOriginale.Id;
                cei.OF_SA_CPE__c = OF_SA_CD_GE_Utils.caseOriginale.Id;
                cei.OF_CommercialElement__c = ceNameId.get('CPE');
                OF_SA_CD_GE_Utils.ceiList.add(cei);
            }
        }
        if(OF_SA_CD_GE_Utils.checkVLan)
        {  
            Integer n = 1;
            for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListVLan){
            	OF_SA_CD_GE_Utils.checkCEIList = true;
                OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
                cei.recordtypeid = OF_Utility.getRT_DevNameId_Map().get('OF_VLAN');
                cei.OF_KITCONSEGNAVLAN__C = sl.OF_SA_KIT_CONSEGNA_VLAN__c;
                cei.OF_USERVLAN__C = sl.OF_SA_USER_VLAN__c;
                cei.OF_SERVICEVLAN__C = sl.OF_SA_SERVICE_VLAN__c;
                cei.OF_PROFILOVLAN__C = sl.OF_SA_PROFILO_VLAN__c;
                cei.OF_INFORMAZIONIVLAN__C = sl.OF_SA_INFORMAZIONI_VLAN__c;
                cei.OF_CUSTOMERVLAN__C = sl.OF_SA_CUSTOMER_VLAN__c;
                cei.OF_MODELLODISERVIZIOVLAN__C = sl.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c;
                cei.OF_Case__c = OF_SA_CD_GE_Utils.caseOriginale.Id;
                cei.OF_SA_VLAN__c = OF_SA_CD_GE_Utils.caseOriginale.Id;
                cei.OF_CommercialElement__c = ceNameId.get('VLAN');
                OF_SA_CD_GE_Utils.ceiList.add(cei);
            }
        }
        //giovanni ernetti 15-10-2018 inizio
        
        /*
        List<OF_SA_Network_Inventory_Attivi__c> ni = [SELECT Id,OF_SA_Civico__c,OF_SA_Comune__c,OF_SA_GPON_ID__c,OF_SA_ID_Building__c,OF_SA_Pop__c,
                                                      OF_SA_Indirizzo__c, OF_SA_Particella_Top__c,OF_SA_Provincia__c,OF_SA_Scala_Palazzina__c,OF_SA_Stato_Building__c,
                                                      OF_SA_ID_Building_OM__c
                                                      FROM OF_SA_Network_Inventory_Attivi__c 
                                                      WHERE OF_SA_ID_Building__c =:OF_SA_CD_GE_Utils.caseOriginale.EOF_ID_Building_WS__c];  
        */
        
        //List<OF_SA_Network_Inventory_Attivi__c> ni = OF_SA_CD_GE_Utils.controlloVendibilita(OF_SA_CD_GE_Utils.caseOriginale.EOF_codice_operatore_WS__c, OF_SA_CD_GE_Utils.caseOriginale.EOF_ID_Building_WS__c);                 
        
        List<OF_SA_Network_Inventory_Attivi__c> ni = OF_SA_CD_GE_Utils.controlloVendibilita('EOF', OF_SA_CD_GE_Utils.caseOriginale.EOF_ID_Building_WS__c);                 
	 	
        //giovanni ernetti 15-10-2018 fine
        
        //implementare la logica di acquisizione KO       
        if(ni.isEMpty())
        {
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Identificativo Building Errato';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B00';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Identificativo Building Errato';
            OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO'; 
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA'; 
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);
            return;
        } 
        
        //creo la lista ordinata degli stati building positivi
       	/*List<Integer> positivi = new List<Integer>();
		positivi.add(110);
		positivi.add(104);
		positivi.add(105);
		positivi.add(107);
		positivi.add(109);
		
		//creo la lista ordinata degli stati building negativi
		List<Integer> negativi = new List<Integer>();
		negativi.add(101);
		negativi.add(102);
		negativi.add(103);
		negativi.add(106);		
		negativi.add(108);
		*/
        //AA - I valori delle liste positive e negative verranno recuperati tramite custom setting
		List<Integer> positivi = new List<Integer>();
		for(Stato_Building_positivi__c pos : Stato_Building_positivi__c.getAll().values()){
            try{
                positivi.add(Integer.valueOf(pos.Name));
            }catch(Exception e)    {
                System.debug('***** Valore [' + pos.Name + '] non ammesso all\'interno del Custom Setting Stato_Building_positivi__c');
            }
        }
		List<Integer> negativi = new List<Integer>();
		for(Stato_Building_negativi__c pos : Stato_Building_negativi__c.getAll().values()){
            try{
                negativi.add(Integer.valueOf(pos.Name));
            }catch(Exception e)    {
                System.debug('***** Valore [' + pos.Name + '] non ammesso all\'interno del Custom Setting Stato_Building_negativi__c');
            }
        }		
		boolean found=false;
		OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
		//ciclo per il controllo ordinato sugli stati building positivi
		for(Integer num : positivi){
			if(!found){
				for(OF_SA_Network_Inventory_Attivi__c n : ni){
					if(n.OF_SA_Stato_Building__c == num){
						corretto = n;
						found=true;
						break;
					}
				}
			}
			else{
				break;
			}
		}
		if(!found){
			//ciclo per il controllo ordinato sugli stati building negativi
			for(Integer num : negativi){
				if(!found){
					for(OF_SA_Network_Inventory_Attivi__c n : ni){
						if(n.OF_SA_Stato_Building__c == num){
							corretto = n;
							found=true;
							break;
						}
					}
				}
				else{
					break;
				}
			}
			if(!found){
				//caso in cui lo stato building non è stato trovato in nessuna delle due liste
				corretto=ni[0];
			}
			
			List<OF_ElencoComuniItaliani__c> cList = [select OF_Comune__c, OF_Provincia__c 
			                                          from OF_ElencoComuniItaliani__c 
			                                          where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
	        if (!cList.isEmpty()){
	            if(String.isNotBlank(cList[0].OF_Comune__c)){
	                OF_SA_CD_GE_Utils.caseOriginale.EOF_Comune_WS__c = cList[0].OF_Comune__c;
	            }
	            if(String.isNotBlank(cList[0].OF_Provincia__c)){
	                OF_SA_CD_GE_Utils.caseOriginale.EOF_Provincia_WS__c = cList[0].OF_Provincia__c;
	            }
	        }
			OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Building non RFC/RFA';
			OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B01';
			OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Building non RFC/RFA';
			OF_SA_CD_GE_Utils.caseOriginale.EOF_Identificativo_del_POP__c = corretto.OF_SA_Pop__c;                        
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Istat_Provincia__c = corretto.OF_SA_Provincia__c;
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Istat_Comune__c = corretto.OF_SA_Comune__c;
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Particella_Toponomastica_WS__c = corretto.OF_SA_Particella_Top__c;
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Indirizzo_WS__c = corretto.OF_SA_Indirizzo__c;
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Numero_Civico_WS__c = corretto.OF_SA_Civico__c;
	        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_ID_Building_OM__c = corretto.OF_SA_ID_Building_OM__c; 
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_ID_Building_WS__c = corretto.OF_SA_ID_Building__c;  
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Stato_Building__c = corretto.OF_SA_Stato_Building__c;
			OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO';
			OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
			//creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);
            return;
		}
        else{
        	//caso in cui è stato trovato nella lista degli stati building positivi
        	List<OF_ElencoComuniItaliani__c> cList = [select OF_Comune__c, OF_Provincia__c 
        	                                          from OF_ElencoComuniItaliani__c 
        	                                          where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
	        if (!cList.isEmpty()){
	            if(String.isNotBlank(cList[0].OF_Comune__c)){
	                OF_SA_CD_GE_Utils.caseOriginale.EOF_Comune_WS__c = cList[0].OF_Comune__c;
	            }
	            if(String.isNotBlank(cList[0].OF_Provincia__c)){
	                OF_SA_CD_GE_Utils.caseOriginale.EOF_Provincia_WS__c = cList[0].OF_Provincia__c;
	            }
	        }
        	OF_SA_CD_GE_Utils.caseOriginale.EOF_Identificativo_del_POP__c = corretto.OF_SA_Pop__c;                        
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Istat_Provincia__c = corretto.OF_SA_Provincia__c;
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Istat_Comune__c = corretto.OF_SA_Comune__c;
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Particella_Toponomastica_WS__c = corretto.OF_SA_Particella_Top__c;
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Indirizzo_WS__c = corretto.OF_SA_Indirizzo__c;
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Numero_Civico_WS__c = corretto.OF_SA_Civico__c;
	        //OF_SA_CD_GE_Utils.caseOriginale.OF_SA_ID_Building_OM__c = corretto.OF_SA_ID_Building_OM__c; 
	        //OF_SA_CD_GE_Utils.caseOriginale.EOF_ID_Building_WS__c = corretto.OF_SA_ID_Building__c;  
	        OF_SA_CD_GE_Utils.caseOriginale.EOF_Stato_Building__c = corretto.OF_SA_Stato_Building__c;
        	
        	//Async control DATA_PREVISTA_ATTIVAZIONE
            Date DPA = OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c;
            Integer year = DPA.year();
            Integer month = DPA.month();
            Integer day = DPA.day();
            Datetime targetTime = Datetime.newInstance(year, month, day, 0, 0, 0);
            
            BusinessHours bh = [SELECT Id 
                                FROM BusinessHours 
                                WHERE IsDefault=true];
            
            Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);  
           
            if(isWithin == false && OF_SA_CD_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c!='TIS_20170403_000000001'){ 
            	
                OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
				OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'A10';
				OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
				OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO';
				OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
				//creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
	            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
	            //chiamo il metodo che gestisce le callout e aggiorna il DB
            	OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);
	            return;
            }     
        	BusinessHours bh_dac = [SELECT Id 
        	                        FROM BusinessHours 
        	                        WHERE Name = 'DAC'];
        	                        
	        Integer num_giorni_rfa = 0;
	        Integer num_giorni_rfc = 0;
	        Datetime RFA = Datetime.newInstance(system.now().year(), system.now().month(), system.now().day(), 0, 0, 0);
	        Datetime RFC = Datetime.newInstance(system.now().year(), system.now().month(), system.now().day(), 0, 0, 0);
	
	        //per RFA devo sommare 5 giorni escluse le festività perchè sia conforme agli sla
	       //    while(num_giorni_rfa < 5){  
	      while(num_giorni_rfa < 11){  
	            if(BusinessHours.isWithin(bh_dac.Id, RFA) == true ){                
	                RFA = Datetime.newInstance(RFA.year(), RFA.month(), RFA.day()+1,0,0,0);
	                num_giorni_rfa++;                         
	                continue;
	            }       
	            RFA = Datetime.newInstance(RFA.year(), RFA.month(), RFA.day()+1,0,0,0);      
	        }                    
	      //   while(num_giorni_rfc < 10){ 
	     while(num_giorni_rfc < 11){ 
	            if(BusinessHours.isWithin(bh_dac.Id, RFC) == true ){                 
	                RFC = Datetime.newInstance(RFC.year(), RFC.month(), RFC.day()+1,0,0,0);
	                num_giorni_rfc++;                           
	                continue;
	            }       
	            RFC = Datetime.newInstance(RFC.year(), RFc.month() , RFc.day()+1,0,0,0);    
	        } 
	        if(!OF_SA_CD_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
	           if(((corretto.OF_SA_Stato_Building__c == 110 && OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c < RFA.date()) || (corretto.OF_SA_Stato_Building__c != 110 && OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c < RFC.date())) && OF_SA_CD_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c!='TIS_20170403_000000001'){
	                OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Data Attesa Consegna non conforme agli SLA';
					OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'A09';
					OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Data Attesa Consegna non conforme agli SLA';
					OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO';
					OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
					//creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
		            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
		            //chiamo il metodo che gestisce le callout e aggiorna il DB
	            	OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);
		            return;
	            }
	        } 
        }
        system.debug('test1:'+corretto.OF_SA_Pop__c);
        system.debug('test2:'+OF_SA_CD_GE_Utils.slOLOSF.EOF_ID_POP__c);
        if(corretto.OF_SA_Pop__c != OF_SA_CD_GE_Utils.slOLOSF.EOF_ID_POP__c){ 
            List<OF_ElencoComuniItaliani__c> cList = new List<OF_ElencoComuniItaliani__c>();
	        cList=[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
	        if (!cList.isEmpty()){
	            if(String.isNotBlank(cList[0].OF_Comune__c)){
	                OF_SA_CD_GE_Utils.caseOriginale.EOF_Comune_WS__c = cList[0].OF_Comune__c;
	            }
	            if(String.isNotBlank(cList[0].OF_Provincia__c)){
	                OF_SA_CD_GE_Utils.caseOriginale.EOF_Provincia_WS__c = cList[0].OF_Provincia__c;
	            }
	        }
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Associazione ID Building-POP errata';
			OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B03';
			OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Associazione ID Building-POP errata';  
			OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO';
			OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
			//creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);
            return;
        }
        OF_SA_CD_GE_Utils.caseOriginale.status = 'Acquisito';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__C = 'Da Lavorare';
        
        List<OF_ElencoComuniItaliani__c> cList = new List<OF_ElencoComuniItaliani__c>();
        cList = [select OF_Comune__c, OF_Provincia__c 
                 from OF_ElencoComuniItaliani__c 
                 where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
        
        if(!cList.isEmpty()){
            if(String.isNotBlank(cList[0].OF_Comune__c)){
                OF_SA_CD_GE_Utils.caseOriginale.EOF_Comune_WS__c=cList[0].OF_Comune__c;
            }
            if(String.isNotBlank(cList[0].OF_Provincia__c)){
                OF_SA_CD_GE_Utils.caseOriginale.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
            }
        }
        
        //Start - Add - PG - check contract B05 - Copiata da OF_SA_OLO_AsyncChecksNew
        //PG: Il campo servizio identifica il tipo di servizio (Open Stream CD, GPON Passiva CD) e viene popolato in cima alla classe
        List<OF_ContrattoServizio__c> listcheckCDContract = [select id,name,OF_Contract__c 
                                                             from OF_ContrattoServizio__c 
            											     where OF_Servizio__r.name =: tipo_servizio 
            											     and OF_Contract__r.Status = 'Attivo'
            											     AND OF_Contract__r.AccountId =: OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c
            											     AND OF_Contract__r.StartDate <: OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c
            											     AND OF_Contract__r.EndDate >: OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c];
		
		System.debug('@@@@@@ listcheckCDContract @@@ B05 @@@ : '+listcheckCDContract+ 'Size: '+listcheckCDContract.size());
		
		if(listcheckCDContract.isEmpty())
		{
			OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B05';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);

            return;
		}
		
		OF_SA_CD_GE_Utils.caseOriginale.OF_IDContratto__c = listcheckCDContract[0].OF_Contract__c;
		System.debug('*****OF_SA_CD_GE_Utils.caseOriginale.OF_IDContratto__c***B_04***:'+OF_SA_CD_GE_Utils.caseOriginale.OF_IDContratto__c);
		//check città B_04
		List<OF_AreaGeograficaJunction__c> listAreaGeograficaCityContractCD = [select id 
                		                                                       from OF_AreaGeograficaJunction__c 
                															   where OF_Contratto__c =:listcheckCDContract[0].OF_Contract__c
                															   AND OF_AreaGeografica__r.OF_Istat__c=:OF_SA_CD_GE_Utils.caseOriginale.EOF_Istat_Comune__c];
	    
	    System.debug('@@@@@@ listAreaGeograficaCityContractCD @@@ B_04 @@@ : '+listAreaGeograficaCityContractCD+ 'Size: '+listAreaGeograficaCityContractCD.size());
	
		if(listAreaGeograficaCityContractCD.isEmpty())
		{
			OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B04';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            
            //creo il servicelog che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);
            return;
		}
        //End - Add - PG - check contract B05 - Copiata da OF_SA_OLO_AsyncChecksNew
        
        /*
        String check = null;
        OF_UtilitiesManageOrderFromCase obj = new OF_UtilitiesManageOrderFromCase();
        check = obj.VerificheCommContratt1(OF_SA_CD_GE_Utils.caseOriginale);
        //PG - 4-12 
        System.debug(']]]]]]] OF_SA_CD_GE_Utils.caseOriginale.OF_IDContratto__c: ]]]]]]]]'+OF_SA_CD_GE_Utils.caseOriginale.OF_IDContratto__c);
        OF_SA_CD_GE_Utils.caseOriginale.OF_IDContratto__c = obj.getIDContratto();
        
        if(check == 'B_05'){
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B05';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);
            return;
            
        }
        if(check == 'B_04'){
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B04';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);
            return;
        }
		*/
		
		//genero l'id servizio andando a inserire un record dell'oggetto OF_Generatore_ID_Servizio__c
		OF_SA_CD_GE_Utils.gen = [select OF_ID_Servizio__c 
		                         from OF_Generatore_ID_Servizio__c
		                         where OF_Case_Id__c=:OF_SA_CD_GE_Utils.caseOriginale.Id];
		                         
		OF_SA_CD_GE_Utils.caseOriginale.OF_SA_ID_Servizio__c = OF_SA_CD_GE_Utils.gen.OF_ID_Servizio__c;
        
        //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
        OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
        //chiamo il metodo che gestisce le callout e aggiorna il DB
        OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);
        return;
    }
    
    public static Map<String,List<EOF_EAI_Service_Log__c>> OLO_AsyncStatusUpdate(Case c, OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur){
        
        Map<String,List<EOF_EAI_Service_Log__c>> responseToOlo = new Map<String,List<EOF_EAI_Service_Log__c>>();
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
       
        EOF_EAI_Service_Log__c slToOM = OF_SA_CD_GE_Utils.OLO_CreateStatusUpdate_Log(c, sur);
        system.debug('OSCRM OF_SA_CD_OLO_AsyncChecks.OLO_AsyncStatus slToOM:'+slToOM);
        
        Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate(slToOM);
        system.debug('OSCRM OF_SA_CD_OLO_AsyncChecks.OLO_AsyncStatus responseFromOM:'+responseFromOM );
        
        //aggiungo il log originario
        slList.add(OF_SA_CD_GE_Utils.Create_EAI_Log(sur));
        
        //aggiungo il log dell'invio ad OM
        slList.add(slToOM);
        
        if(responseFromOM.containsKey('0')) {
            slList.add(responseFromOM.get('0'));
            responseToOlo.put('0',slList);
            return  responseToOlo;
        }
        else{
            slList.add(responseFromOM.get('1'));
            responseToOlo.put('1',slList);
            return  responseToOlo;
        }
    }
    
    public static Map<String,List<EOF_EAI_Service_Log__c>> OLO_AsyncReschedule(Case c, OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest r){
        
        Map<String,List<EOF_EAI_Service_Log__c>> responseToOlo = new Map<String,List<EOF_EAI_Service_Log__c>>();
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slToOM = OF_SA_CD_GE_Utils.OLO_CreateReschedule_Log(c, r);
        Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestReschedule(slToOM);
        //inserisco il sl originario dell'OLO
        slList.add(OF_SA_CD_GE_Utils.Create_EAI_Log(r));
        
        slList.add(slToOM);
        if(responseFromOM.containsKey('0')) {
            slList.add(responseFromOM.get('0'));
            responseToOlo.put('0',slList);
            return  responseToOlo;
        }
        else{
            slList.add(responseFromOM.get('1'));
            responseToOlo.put('1',slList);
            return  responseToOlo;
        }
    } 
    
    //CESSAZIONE
    @future(callout=true)  
    public static void OLO_AsyncDeactivation(String caseId, String SLOloSfId){
        
        System.debug('*****Sono dentro OLO_AsyncDeactivation - ASYNC_CHECKS*****');
        String assetRtype = '';
        String tipo_servizio = '';
    	   
        OF_SA_CD_GE_Utils.caseOriginale = Database.query(OF_SA_CD_GE_Utils.getQuery('case','AsyncDeactivation')+
        										' where id=:caseId');
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF=Database.query(OF_SA_CD_GE_Utils.getQuery('sl','AsyncDeactivation')+ 
        										' where id =:SLOloSfId' 
		        								+' OR OF_SA_Cpe_Log__c =:SLOloSfId'
		        								+' order by EOF_Ordine_Invio_OLO__c'); 
		        								
		OF_SA_CD_GE_Utils.ListApp = new List<EOF_EAI_Service_Log__c>();        								     								
		
		for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF){
		    
		    System.debug('@@@@@ sl @@@@ : '+sl);
		    
		    if(sl.recordtype.developername=='OF_SA_CeD_FiberRequest'){
				System.debug(']]]]]]] LOG REQUEST ]]]]]]]');
				OF_SA_CD_GE_Utils.slOLOSF=sl;	
			}
			if(sl.recordtype.developername=='OF_SA_Cpe'){
				OF_SA_CD_GE_Utils.checkApp=true;
				OF_SA_CD_GE_Utils.ListApp.add(sl);
			}
		}
        
        OLO_ID__c oloId = OLO_ID__c.getInstance(OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c);
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c=oloId.OF_Olo_Id__c;
        
        if(OF_SA_CD_GE_Utils.caseOriginale.recordtype.developername=='EOF_Caso_Cessazione_OPENSTREAM_CD'){
            System.debug('11111 - EOF_Caso_Cessazione_OPENSTREAM_CD');
   			OF_SA_CD_GE_Utils.processo = 'attivo';
   			assetRtype = 'OF_CD_Asset_OpenStream';
   			tipo_servizio = 'Open Stream CD';
   		}
   		else if(OF_SA_CD_GE_Utils.caseOriginale.recordtype.developername=='EOF_SP_Caso_Cessazione_CeD'){
   		    System.debug('11111 - EOF_SP_Caso_Cessazione_CeD');
   			OF_SA_CD_GE_Utils.processo = 'passivo';
   			assetRtype = 'OF_CD_Asset_GPON_Passiva';
   			tipo_servizio = 'GPON Passiva CD';
   		}	
        System.debug('@@@@@ assetRtype @@@@ '+assetRtype);
        
        if(!String.isBlank(OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C) && !String.isBlank(OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c)){
        	
        	OF_SA_CD_GE_Utils.cliente = new Account(FirstName = OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c,
                                                    LastName = OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c,
                                                    RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('PersonAccount'),
                                                    Phone = OF_SA_CD_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                                    EOF_Phone_2__c = OF_SA_CD_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
            OF_SA_CD_GE_Utils.checkCliente=true;                       

        }else if(!String.isBlank(OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c)){
            OF_SA_CD_GE_Utils.cliente = new Account(Name = OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c,
                                                    RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('Cliente_Business'),
                                                    Phone = OF_SA_CD_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                                    EOF_Phone_2__c = OF_SA_CD_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
            OF_SA_CD_GE_Utils.checkCliente=true; 
        }
        // 10/01/2018 Marco : fine modifica
        
        //Start - Add - PG - check contract B05 - Copiata da OF_SA_OLO_AsyncChecksNew
        //PG: Il campo servizio identifica il tipo di servizio (Open Stream CD, GPON Passiva CD) e viene popolato in cima alla classe
        List<OF_ContrattoServizio__c> listcheckCDContract = [select id,name,OF_Contract__c 
                                                             from OF_ContrattoServizio__c 
            											     where OF_Servizio__r.name =: tipo_servizio 
            											     and OF_Contract__r.Status = 'Attivo'
            											     AND OF_Contract__r.AccountId =: OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c
            											     AND OF_Contract__r.StartDate <: OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c
            											     AND OF_Contract__r.EndDate >: OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c];
		
		System.debug('@@@@@@ listcheckCDContract @@@ B05 @@@ : '+listcheckCDContract+ 'Size: '+listcheckCDContract.size());
		
		if(listcheckCDContract.isEmpty())
		{
			OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B05';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_CD_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO);

            return;
		}
		
		OF_SA_CD_GE_Utils.caseOriginale.OF_IDContratto__c = listcheckCDContract[0].OF_Contract__c;
        
        //Da verificare quale sarà l'oggetto Asset
        String IdRisorsa = OF_SA_CD_GE_Utils.caseOriginale.EOF_ID_Risorsa__c;
        String codiceOperatore = OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c;
        
        //TODO: Gestire RecordType Asset per servizi attivi e passivi
        System.debug('##### assetRtype ##### '+assetRtype);
        
        List<Asset> aList = Database.query(OF_SA_CD_GE_Utils.getQuery('Asset','AsyncDeactivation')+ 
        					' where recordtype.developername=:assetRtype and Status=\'Attivo\' and EOF_Id_Risorsa__c=:IdRisorsa'
                            +' and Account.EOF_Codice_Operatore__c=:codiceOperatore');
                            
        //caso di errore asincrono
        system.debug('LISTA DI ASSET RECUPERATI DOPO IL PROCESSO DI CESSAZIONE ' + aList);
        
        if(aList.isEmpty()){
            OF_SA_CD_GE_Utils.caseOriginale.status = 'Cessato KO';
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'ID Risorsa da cessare inesistente/errato';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B07';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'ID Risorsa da cessare inesistente/errato';
            //Update c;
                                          
            OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.CreateAcquisition_Log(OF_SA_CD_GE_Utils.caseOriginale);
			
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(OF_SA_CD_GE_Utils.slSFOLO); 
            return;     
        }
        
        List<OF_CommercialElementIstanziato__c> ceiList = [SELECT Id,OF_TipologiaApparato__C 
                                                           FROM OF_CommercialElementIstanziato__c 
                                                           where OF_CPE__c=:aList[0].id];
                                                            
        system.debug('COMMERCIAL ELEMENT ISTANZ PROCESSO CESSAZIONE ' + ceiList);
        
        /*controllo sugli apparati da cessare al momento in attesa requisito inizia qui
        List<String> cListCPE = new List<String>();
        Map<String,OF_commercialElementIstanziato__c> ceiMap = new Map<String,OF_commercialElementIstanziato__c>();
        List<OF_CommercialElementIstanziato__c> ceiListToUpdate = new List<OF_CommercialElementIstanziato__c>();
        for (OF_commercialElementIstanziato__c cei : ceiList){
            cListCPE.add(cei.OF_TipologiaApparato__C);
            ceiMap.put(cei.OF_TipologiaApparato__C, cei);
        }
        if(Deact.APPARATO!=null){
            List<String> cListCPEOLO= new List<String>();
            for(OF_SA_WS_IN_OLO_Deactivation.APPARATO ap : Deact.APPARATO){
                cListCPEOLO.add(ap.TIPOLOGIA_APPARATO);
            }
            cListCPEOLO.sort();
            cListCPE.sort();
            if(cListCPEOLO.equals(cListCPE)){
                if(!Deact.APPARATO.isempty()){
                    for(OF_SA_WS_IN_OLO_Deactivation.APPARATO ap : Deact.APPARATO){
                        OF_commercialElementIstanziato__c cei = ceiMap.get(ap.TIPOLOGIA_APPARATO);
                        cei.OF_Stato__c='Cessato';
                        cei.OF_SA_VLAN__c=c.Id;
                        ceiListToUpdate.add(cei);
                    }
                    if(!ceiListToUpdate.isEMpty()){
                        system.debug('La lista di cei è : '+ceiListToUpdate);
                        update ceiListToUpdate;
                    }
                }
            }
            //caso liste non uguali
            else{   
                OF_SA_CD_GE_Utils.caseOriginale.status='Cessato KO';
                OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Apparato non presente nella richiesta di attivazione';
                OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'E07';
                OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Apparato non presente nella richiesta di attivazione';
                OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                OF_SA_CD_GE_Utils.caseOriginale.AssetId=aList[0].id;
                update c;
                //creo ed inserisco l'ack ad OLO (OLO->SF - ACK - DeactivationRequest)                                     
                List<EOF_EAI_Service_Log__c> sListPreSF = OF_SA_CD_GE_Utils.OM_CreateStatusUpdate_Log(c,Deact);
                EOF_EAI_Service_Log__c sl1=sListPreSF[0];
                //creo il sl che invierò ad om senza legarlo al case in quanto andrà legato dopo ll'ack sull'acquisizione da OLO (SF->OM - ActivationRequest)
                List<EOF_EAI_Service_Log__c> sListPostSF = OF_SA_CD_GE_Utils.OLO_CreateDeactivation_Log(c,Deact); 
                EOF_EAI_Service_Log__c sl2=sListPostSF[0];
                OF_SA_CD_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(sl1.Id, sl2.Id);
                return; 
            }
        }
        //caso apparati = null
        if(!ceiList.isEmpty()){
            OF_SA_CD_GE_Utils.caseOriginale.status='Cessato KO';
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Apparato non presente nella richiesta di attivazione';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'E07';
            OF_SA_CD_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Apparato non presente nella richiesta di attivazione';
            OF_SA_CD_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            OF_SA_CD_GE_Utils.caseOriginale.AssetId=aList[0].id;
            update c;
            //creo ed inserisco l'ack ad OLO (OLO->SF - ACK - DeactivationRequest)                                     
            List<EOF_EAI_Service_Log__c> sListPreSF = OF_SA_CD_GE_Utils.OM_CreateStatusUpdate_Log(c,Deact);
            EOF_EAI_Service_Log__c sl1=sListPreSF[0];
            //creo il sl che invierò ad om senza legarlo al case in quanto andrà legato dopo ll'ack sull'acquisizione da OLO (SF->OM - ActivationRequest)
            List<EOF_EAI_Service_Log__c> sListPostSF = OF_SA_CD_GE_Utils.OLO_CreateDeactivation_Log(c,Deact); 
            EOF_EAI_Service_Log__c sl2=sListPostSF[0];
            OF_SA_CD_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(sl1.Id, sl2.Id);
            return; 
        }
        --------------------- finisce qui
        */
        
        /*CRM Modifica 10_06_2017 Gestione Cessazione CPE Lato CRM
        //alternativa temporanea: cesso sempre tutti i cei ------inizia qui
        List<OF_CommercialElementIstanziato__c> ceiListToUpdate = new List<OF_CommercialElementIstanziato__c>();
        for(OF_CommercialElementIstanziato__c cei : ceiList){
            cei.OF_Stato__C='Cessato';
            ceiListToUpdate.add(cei);
        }
        if(!ceiListToUpdate.isEmpty()){
            update ceiListToUpdate;
        }*/
        //finisce qui
        //valorizzo l'asset statico
        OF_SA_CD_GE_Utils.a = aList[0];
        
        //caso in cui la cessazione ha superato i controlli asincroni   
        OF_SA_CD_GE_Utils.caseOriginale.status = 'Acquisito';
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_ID_Servizio__c = aList[0].OF_IDServizio__c;
        OF_SA_CD_GE_Utils.caseOriginale.AssetId = aList[0].id;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Provincia_WS__c = aList[0].OF_Provincia__c;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Comune_WS__c = aList[0].OF_Comune__c;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Particella_Toponomastica_WS__c = aList[0].OF_Particella_Toponomastica__c;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Indirizzo_WS__c = aList[0].OF_Indirizzo__c;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Numero_Civico_WS__c = aList[0].OF_Civico__c;
        
        OF_SA_CD_GE_Utils.makeCalloutOM(OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF); 
        return;
    }
    
    //ADD - PG - Add by PG - 21-12 - Controlli asincroni Change Order
    @future(callout=true)  
    public static void OLO_AsyncChangeOrder(String caseId, String idserviceLog)
    {   
        EOF_EAI_Service_Log__C sl_log;
        // added on 19012019 causing problem suggested by Capasso
        if(!Test.isRunningTest())
        {OF_SA_CD_GE_Utils.slSFOLO = sl_log;}
        
        System.debug('START - CHECK ASINCRONI');
        
        Case c = [Select Id, PO_SA_Portale__c, CaseNumber, Status, EOF_ID_Risorsa__c,Codice_ordine_Eof__c, EOF_Account_OLO__c,
                  EOF_Codice_Ordine_Olo__c,EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,
                  EOF_Data_Notifica__c, EOF_Id_Notifica__c,recordtype.developername, 
                  EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,EOF_FASE__c,
                  EOF_GPON_Vincolante__c,OF_SA_Motivazione__c,OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Promozione__c, 
                  OF_SA_Cluster_Promozione__c, EOF_Note__c, OF_SA_Profilo__c ,OF_Bonifica_Locked_Row__c
                  from Case 
                  where id=:caseId];
        
        System.debug('***cinasy***'+c);
        OF_SA_CD_GE_Utils.caseOriginale = c;
        OLO_ID__c oloId = OLO_ID__c.getInstance(OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c);
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c = oloId.OF_Olo_Id__c;              
        System.debug('***Eccomi***');
        //Verificare l'asset
        List<Asset> assetList = [select Id, name, status, Account.EOF_Codice_Operatore__c, 
                                 OF_ProfiloOpenStream__c,EOF_Id_Risorsa__c
                                 from Asset                               
                                 where recordtype.developername in (/*'OF_OpenStream',*/'OF_CD_Asset_OpenStream')
                                 and Account.EOF_Codice_Operatore__c=:c.EOF_Codice_Operatore_WS__c
                                 and Name=:c.EOF_ID_Risorsa__c];
                                 
        System.debug('çççç__Vediamo__çççç');
        //Verificare se sia presente una richiesta di cessazione in corso
        /*List<Case> listCaseCessazione = [Select id, recordtypeId, recordtype.name, status, asset.name
                                         from Case
                                         where recordtype.name = 'EOF_Caso_Cessazione_OPENSTREAM'
                                         and asset.name =:c.EOF_Id_Risorsa__c];
        */

        List<Case> listCase = [Select id, recordtypeId, recordtype.name, recordtype.developerName, status, asset.name, OF_SA_ID_Servizio__c
                               from Case
                               where ( (recordtype.developerName = 'EOF_Caso_Cessazione_OPENSTREAM_CD' and status = 'Acquisito') 
                               OR (recordtype.developerName = 'EOF_Caso_Attivazione_OPENSTREAM_CeD' and status = 'Espletato'))
                               and asset.name =:c.EOF_Id_Risorsa__c];

        //AA: Recupero la lista di sLog rappresentativi delle VLAN
        System.debug('---Prima di sLogList---');
        List<EOF_EAI_Service_Log__c> sLogList = [SELECT OF_SA_KIT_CONSEGNA_VLAN__c, OF_SA_USER_VLAN__C, OF_SA_SERVICE_VLAN__C, 
                                                 OF_SA_PROFILO_VLAN__c, OF_SA_CUSTOMER_VLAN__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c, 
                                                 OF_SA_INFORMAZIONI_VLAN__c
                                                 FROM EOF_EAI_Service_Log__c
                                                 WHERE OF_SA_VLan_Log__c = :idserviceLog];
                                                 
        System.debug('°°°Prima della chiamata di generateVLAN°°°: '+slogList.size());
        //Done AA: POPOLARE LISTA VLAN con il metodo creato
        
        List<OF_CommercialElementIstanziato__c> listVLAN = OF_SA_CD_OLO_AsyncChecks.generateVLANbysLog(sLogList, caseId);
        
        System.debug('°°°Dopo la chiamata di generateVLAN°°°');
        List<EOF_EAI_Service_Log__c> list_serviceLogs = [Select id, EOF_PROFILO__c, EOF_ID_Notifica__c
                                                         from EOF_EAI_Service_Log__c
                                                         where id =: idserviceLog];

        System.debug(']]]]list_serviceLogs: '+list_serviceLogs.size());

        // CONTROLLI ASINCRONI CON ESITO KO
        //se la lista è vuota (asset non presente)
        if(assetList.isEmpty())
        {
            c.OF_SA_Motivazione__c = 'ID Risorsa da modificare inesistente/errato';
            c.EOF_Causale_Errore__c = 'ID Risorsa da modificare inesistente/errato';
            c.OF_SA_Codice_Motivazione__c = 'D13';
            c.EOF_Codice_Errore__c = 'D13'; 
            System.debug(c.OF_SA_Motivazione__c);
            c.status = 'Modificato KO';
            System.debug('ASSET_LIST VUOTA');
            sl_log = OF_SA_CD_GE_Utils.CreateAcquisition_Log(c);
            System.debug('**** AA Service log ASSET LIST VUOTA!! ' + sl_log);
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(sl_log); //effettua la callOut  
            System.debug('**** RESPONSE DA OLO!! ' + c.OF_Response_Da_OLO__c + '\n*****OGGETTO CASE ' + c);
        }
        else
        { 
        	c.AssetId = assetList.get(0).Id;
        	if(assetList.get(0).status.equalsIgnoreCase('In Modifica')){ //verifico se sia presente una richiesta   
	            c.OF_SA_Motivazione__c = 'Richiesta di modifica già aperta';    
	            c.EOF_Causale_Errore__c = 'Richiesta di modifica già aperta';
	            c.OF_SA_Codice_Motivazione__c = 'D16';
	            c.EOF_Codice_Errore__c = 'D16'; 
	            c.status = 'Modificato KO';                       
	            System.debug('--IN MODIFICA--');                              
	            sl_log = OF_SA_CD_GE_Utils.CreateAcquisition_Log(c);
	            OF_SA_CD_GE_Utils.makeCalloutOLOOM(sl_log); //effettua la callOut  
	        }
	        else if(assetList.get(0).status.equalsIgnoreCase('Cessato')){//verifico se sia un asset cessato
	            c.OF_SA_Motivazione__c = 'Servizio cessato';   
	            c.EOF_Causale_Errore__c = 'Servizio cessato';
	            c.OF_SA_Codice_Motivazione__c = 'D15';
	            c.EOF_Codice_Errore__c = 'D15'; 
	            c.status = 'Modificato KO';                       
	            System.debug('--IN MODIFICA--');                              
	            sl_log = OF_SA_CD_GE_Utils.CreateAcquisition_Log(c);
	            OF_SA_CD_GE_Utils.makeCalloutOLOOM(sl_log); //effettua la callOut  
	        }
	    }
        if (!c.status.equalsIgnoreCase('Modificato KO')){
            //Popolo la lista di cessazioni
            System.debug('@@@Test');
            List<Case> listCaseCessazione = new List<Case>();
            for (Case cas : [Select id, recordtypeId, recordtype.name, recordtype.developerName, status, asset.name, OF_SA_ID_Servizio__c
                             from Case
                             where ( (recordtype.developerName = 'EOF_Caso_Cessazione_OPENSTREAM_CD' and status = 'Acquisito') 
                             OR (recordtype.developerName = 'EOF_Caso_Attivazione_OPENSTREAM_CeD' and status = 'Espletato'))
                             and asset.name =:c.EOF_Id_Risorsa__c] ){
            
                System.debug('@@@cas'+cas.recordtype.name);
                System.debug('@@@cas'+asset.name);
                
                if (cas.recordtype.developerName.equalsIgnoreCase('EOF_Caso_Cessazione_OPENSTREAM_CD')){
                    listCaseCessazione.add(cas);
                }else if(cas.recordtype.developerName.equalsIgnoreCase('EOF_Caso_Attivazione_OPENSTREAM_CeD')) {
                    OF_SA_CD_GE_Utils.caseOriginale.OF_SA_ID_Servizio__c = cas.OF_SA_ID_Servizio__c;
                }
            }
            // si verifica se è presente un case di Cessazione
            if( !listCaseCessazione.isEmpty() )
            {
                c.OF_SA_Motivazione__c = 'Presenza di una richiesta di Cessazione';
                c.EOF_Causale_Errore__c = 'Presenza di una richiesta di Cessazione';
                c.OF_SA_Codice_Motivazione__c = 'D16';
                c.EOF_Codice_Errore__c = 'D16';
                c.status = 'Modificato KO';
                System.debug('####Presenza di una richiesta di Cessazione###');
                sl_log = OF_SA_CD_GE_Utils.CreateAcquisition_Log(c);
                OF_SA_CD_GE_Utils.makeCalloutOLOOM(sl_log); //effettua la callOut 
            }
        }
        System.debug('--------Prima dell\'if della chiamata ad OM----');
        //Controlli asincroni superati
        
        if (!c.status.equalsIgnoreCase('Modificato KO'))
        {
            //Se i controlli Asincroni vengono superati viene richiamato OM
            System.debug('--------Prima della chiamata ad OM----');
            
            c.status = 'Acquisito'; 
            
            //chiamare webService SF->OM e dopo procedere alla creazione dell'ordine
            String OM_Resp = OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivation_ChOrd(c, listVLAN);
            
            update c;
            assetList.get(0).status = 'In Modifica'; 
            update assetList.get(0);
            //Done AA : INSERT LISTA VLAN
            insert listVLAN;
        }
        else
        {
            //Se è stato trovato un errore vengono inseriti i log di statusupdate verso OLO e viene aggiornato lo stato del case
            //Done AA : SPOSTARE TUTTE LE INSERT/UPDATE DI MODIFICATO KO E INSERIRE LISTA VLAN
            insert sl_log; //Log che viene inviato da SF-->OLO
            System.debug('**** ASYNC CHECKS REQUEST LOG ' + sl_log);
            OF_SA_CD_GE_Utils.slSFOLOResp.EOF_SL_Riferimento__c = sl_log.Id;
            // added on 19012019 causing problem suggested by Capasso
            if(!Test.isRunningTest())
            {
                insert OF_SA_CD_GE_Utils.slSFOLOResp;
            }
            System.debug('**** ASYNC CHECKS RESPONSE LOG ' + OF_SA_CD_GE_Utils.slSFOLOResp);
            
            update c;
            //Done AA : INSERT LISTA VLAN
            insert listVLAN;
        }
    }
    
    //Done AA : Creare un metodo che dati i sLog, creino la lista di vlan 
    public static List<OF_CommercialElementIstanziato__c> generateVLANbysLog(List<EOF_EAI_Service_Log__c> sLogList, String caseId){
        
        //Lista di VLAN da restituire 
        List<OF_CommercialElementIstanziato__c> ceiList = new List<OF_CommercialElementIstanziato__c>();
        //RECUPERO L'Id del Commercial Element relativo alle VLAN
        Id vlanCEId = [SELECT Id 
                       FROM OF_CommercialElement__c 
                       WHERE OF_Servizio__r.Name = 'Open Stream CD' 
                       AND Name='VLAN' 
                       LIMIT 1].Id;
                        
        System.debug('Sono qui:'+vlanCEid);
        //('OSCRM OK');
        if(!OF_SA_CD_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_SA_CD_GE_Utils.RTMap = new  map<String,String>();

            for(recordtype rt : [select id,developername from recordtype]){
                OF_SA_CD_GE_Utils.RTMap.put(rt.developername, rt.id);
            }
            OF_SA_CD_GE_Utils.checkRTMap=true;
        } 
        System.debug('***Size sLogList***:' +sLogList);
        for (EOF_EAI_Service_Log__C sLog : sLogList){
            //CEI che aggiungerò alla lista da restituire
            OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();   
                cei.recordtypeid = OF_SA_CD_GE_Utils.rtMap.get('OF_VLAN');
                cei.OF_KITCONSEGNAVLAN__C = sLog.OF_SA_KIT_CONSEGNA_VLAN__c;
                cei.OF_USERVLAN__C = sLog.OF_SA_USER_VLAN__C;
                cei.OF_SERVICEVLAN__C = sLog.OF_SA_SERVICE_VLAN__C;
                cei.OF_PROFILOVLAN__C = sLog.OF_SA_PROFILO_VLAN__c;
                cei.OF_CUSTOMERVLAN__C = sLog.OF_SA_CUSTOMER_VLAN__c;
                cei.OF_MODELLODISERVIZIOVLAN__C = sLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c;
                cei.OF_INFORMAZIONIVLAN__C = sLog.OF_SA_INFORMAZIONI_VLAN__c;
                //Lego le VLAN al Case
                cei.OF_Case__c = caseId;
                cei.OF_SA_VLAN__c = caseId;
                //Imposto il CEI di tipologia VLAN
                cei.OF_CommercialElement__c = vlanCEId;
            
            ceiList.add(cei);
        }
        return ceiList;
    }
    //END - PG - Add by PG - 21-12 - Controlli asincroni Change Order
}
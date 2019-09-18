public class OF_SA_OLO_AsyncChecksNew {
    //Activation new
    @future(callout=true)    
    public static void OLO_AsyncActivationNew(String caseId, String SLOloSfId){
    	
        OF_SA_GE_UtilsNew.caseOriginale = Database.query(OF_SA_GE_UtilsNew.getQueryNew('case','AsyncActivation')+
        										' where id=:caseId'); 

        OF_SA_GE_UtilsNew.ListSlActivationOLOSF=Database.query(OF_SA_GE_UtilsNew.getQueryNew('sl','AsyncActivation')+
    											' where id =:SLOloSfId' 
		        								+' OR OF_SA_VLan_Log__c =:SLOloSfId'
		        								+' OR OF_SA_Cpe_Log__c =:SLOloSfId'
		        								+' OR OF_SA_servizi_Aggiuntivi_Log__c =:SLOloSfId'
		        								+' order by EOF_Ordine_Invio_OLO__c');
		OF_SA_GE_UtilsNew.ListVLan = new List<EOF_EAI_Service_Log__c>();        								
		OF_SA_GE_UtilsNew.ListApp = new List<EOF_EAI_Service_Log__c>();        								
		OF_SA_GE_UtilsNew.ListServAgg = new List<EOF_EAI_Service_Log__c>();        								
		for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListSlActivationOLOSF){
			if(sl.recordtype.developername=='OF_SA_FiberRequest'){
				OF_SA_GE_UtilsNew.slOLOSF=sl;	
			}
			if(sl.recordtype.developername=='OF_SA_Vlan'){
				OF_SA_GE_UtilsNew.checkVLan=true;
				OF_SA_GE_UtilsNew.ListVLan.add(sl);
			}
			if(sl.recordtype.developername=='OF_SA_Cpe'){
				OF_SA_GE_UtilsNew.checkApp=true;
				OF_SA_GE_UtilsNew.ListApp.add(sl);
			}
			if(sl.recordtype.developername=='OF_SA_Servizi_Aggiuntivi'){
				OF_SA_GE_UtilsNew.checkServAgg=true;
				OF_SA_GE_UtilsNew.ListServAgg.add(sl);
			}
		}
        
        //Account Olo = [select id from Account where Type = 'OLO' AND EOF_Codice_Operatore__c =:OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Operatore_WS__c];
        
        
        
        List<recordtype> rtList=[select Id,developerName from recordtype];
        OF_SA_GE_UtilsNew.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_SA_GE_UtilsNew.rtMap.put(rt.DeveloperName, rt.Id); 
        }               
        OF_SA_GE_UtilsNew.checkrtMap=true;
        
        OLO_ID__c oloId=OLO_ID__c.getInstance(OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Operatore_WS__c);
        OF_SA_GE_UtilsNew.caseOriginale.EOF_Account_OLO__c=oloId.OF_Olo_Id__c;
		//Vado a settare il campo Accordo_Operativo__C necessario per il billing -> Corrisponde al CaseNumber
        OF_SA_GE_UtilsNew.caseOriginale.Accordo_Operativo__c = OF_SA_GE_UtilsNew.caseOriginale.CaseNumber;
        //AA Controllo async per verificare se la data di SH corrisponde con la data presente nella request
        if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
            if(OF_SA_GE_UtilsNew.caseOriginale.EOF_DATA_PREVISTA_ATTIVAZIONE__C != OF_SA_GE_UtilsNew.caseOriginale.EOF_Data_Appuntamento__c){
                OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'Data Appuntamento diversa da Data Prevista Attivazione';
                OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'A11';
                OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Data Appuntamento diversa da Data Prevista Attivazione';
                OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO'; 
                OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA'; 
                //update c;

                //Richiamo SH per annullare l'appuntamento, se il TokenId è stato valorizzato
                if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
                    OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c);            
                }
                //sLogOFSHReqANDRes.EOF_Codice_Errore__c controllare se è uguale a C02 (NACK TECNICO)
                //TODO AA - NEL CASO IN CUI SH CI RESTITUISCE UN NACK TECNICO FERMIAMO LE CHIAMATE E CREIAMO SOLO I LOG DI OLO E OM
                if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){//Abbiamo ricevuto un NACK TECNICO DA SH
                    //In caso di NACK TECNICO da SH creiamo solo i log di OLO e OM, senza effettuare la callout
                    //Creo il log di della chiamata verso OLO
                    OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                    //Aggiorno i dati di acquisizione
                    if(!Test.isRunningTest()){
                        OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
                    }
                }else{
                    //Abbiamo ricevuto un ACK da SH
                    //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                    OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                    if(!Test.isRunningTest()){
                        //chiamo il metodo che gestisce le callout e aggiorna il DB
                        OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
                    }
                }

                //Inserisco il log della request e della response di SH
                if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                    if(OF_SA_GE_UtilsNew.caseOriginale != null && String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Id)){
                        OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                    }
                    insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
                }
                return;
            }
        }
        //FINE CONTROLLO SH
        
        //controllo cliente, si presuppone che siano gia stati fatti i controlli su cognome_cliente
        OF_SA_GE_UtilsNew.checkCliente=true;
        
        OF_SA_GE_UtilsNew.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c=OF_SA_GE_UtilsNew.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c;
        OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_PROGETTO_SPECIALE__c=OF_SA_GE_UtilsNew.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c;
        OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Promozione__c=OF_SA_GE_UtilsNew.slOLOSF.EOF_Promozione__c;
        OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Cluster_Promozione__c=OF_SA_GE_UtilsNew.slOLOSF.EOF_Cluster_Promozione__c;
        OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Profilo__c=OF_SA_GE_UtilsNew.slOLOSF.EOF_Profilo__c;
        if(String.isBlank(OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__C)){                        
            
            OF_SA_GE_UtilsNew.cliente = new Account(Name = OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c,
                                    RecordTypeId = OF_SA_GE_UtilsNew.rtMap.get('Cliente_Business'),
                                    Phone = OF_SA_GE_UtilsNew.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                    EOF_Phone_2__c = OF_SA_GE_UtilsNew.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );                       
        }else{
            
            OF_SA_GE_UtilsNew.cliente = new Account(FirstName = OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c,
                                    LastName = OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c,
                                    RecordTypeId = OF_SA_GE_UtilsNew.rtMap.get('PersonAccount'),
                                    Phone = OF_SA_GE_UtilsNew.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                    EOF_Phone_2__c = OF_SA_GE_UtilsNew.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
        }
        //Using Technician required information in the request to retrieve the Account in the system
        List<Contact> tech = [SELECT Id, FirstName, LastName, Phone, Email FROM Contact WHERE 
                                  FirstName =: OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c AND LastName =: OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c 
                                  AND Phone =: OF_SA_GE_UtilsNew.slOLOSF.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c AND Email =: OF_SA_GE_UtilsNew.slOLOSF.EOF_EMAIL_REFERENTE_TECNICO_OLO__c];  
        if(!tech.isEmpty()){
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Contact__c = tech.get(0).Id;                   
        }
        else{ 
            OF_SA_GE_UtilsNew.refTec = new COntact();
            OF_SA_GE_UtilsNew.refTec.RecordTypeId = OF_SA_GE_UtilsNew.rtMap.get('Referente_Tecnico_OLO');
            OF_SA_GE_UtilsNew.refTec.AccountId=oloId.OF_Olo_Id__c;
            OF_SA_GE_UtilsNew.refTec.FirstName =OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c;
            OF_SA_GE_UtilsNew.refTec.LastName = OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c;
            OF_SA_GE_UtilsNew.refTec.Phone = OF_SA_GE_UtilsNew.slOLOSF.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;
            OF_SA_GE_UtilsNew.refTec.Email = OF_SA_GE_UtilsNew.slOLOSF.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
            OF_SA_GE_UtilsNew.checkRefTec=true;
        }      
        
        OF_SA_GE_UtilsNew.ceiList = new List<OF_CommercialElementIstanziato__c>();

        List<OF_CommercialElement__c> listaCommercialElement = [SELECT Id,Name, OF_Alias__c FROM OF_CommercialElement__c WHERE OF_Servizio__r.Name='Open Stream' AND OF_Attivo__c = true
																	AND Name NOT IN ('RIBALTAMENTO IMPIANTO', 'ESTENSIONE IMPIANTO CLIENTE')];


 /* MERGE
       Map<String,Id> ceNameId = new Map<String,Id>();
        //AA 060219 - Modifica CE
        String servAggCEId;
        //FINE AA 060219 - Modifica CE
        for(OF_CommercialElement__c ce : listaCommercialElement){






            //AA 060219 - Modifica CE
            if(ce.Name.equalsIgnoreCase('SERVIZI AGGIUNTIVI')){
                servAggCEId = ce.Id;
            }
            //FINE AA 060219 - Modifica CE
            ceNameId.put(ce.Name.ToUpperCase(), ce.Id);
        }
        //AA 060219 - Modifica CE
        ceNameId.put('RIBALTAMENTO IMPIANTO', servAggCEId);
        ceNameId.put('ESTENSIONE IMPIANTO CLIENTE', servAggCEId);
        //FINE AA 060219 - Modifica CE
	FINE MERGE */	
	
	        Map<String,Id> ceNameId = new Map<String,Id>();
        //AA 060219 - Modifica CE


        for(OF_CommercialElement__c ce : listaCommercialElement){
            //Vado a controllare se per il CE corrente esistono altri nomi accettabili
            if(String.isNotBlank(ce.OF_Alias__c)){
                //Per ogni alias lo lego al CE
                for(String alias : ce.OF_Alias__c.split(';')){
                    ceNameId.put(alias.ToUpperCase(), ce.Id);
                }
            }
            ceNameId.put(ce.Name.ToUpperCase(), ce.Id);
        }


        //FINE AA 060219 - Modifica CE
		
        if(OF_SA_GE_UtilsNew.checkServAgg){ 
            Integer n = 1;  
            
            for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListServAgg){ 
                if(!ceNameId.containsKey(sl.OF_SA_NOME_SERVIZIO__c.toUpperCase())){
                    OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'Servizio aggiuntivo \''+sl.OF_SA_NOME_SERVIZIO__c+'\' inesistente';
                    OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B09';
                    OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Servizio aggiuntivo \''+sl.OF_SA_NOME_SERVIZIO__c+'\' inesistente';
                    OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO'; 
                    OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA'; 
                    //update c;
                    //Richiamo SH per annullare l'appuntamento, se il TokenId è stato valorizzato
                    if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
                        OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c);            
                    }
                    //sLogOFSHReqANDRes.EOF_Codice_Errore__c controllare se è uguale a C02 (NACK TECNICO)
                    //TODO AA - NEL CASO IN CUI SH CI RESTITUISCE UN NACK TECNICO FERMIAMO LE CHIAMATE E CREIAMO SOLO I LOG DI OLO E OM
                    if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){//Abbiamo ricevuto un NACK TECNICO DA SH
                        //In caso di NACK TECNICO da SH creiamo solo i log di OLO e OM, senza effettuare la callout
                        //Creo il log di della chiamata verso OLO
                        OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                        //Aggiorno i dati di acquisizione
                        OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
                    }else{
                        //Abbiamo ricevuto un ACK da SH
                        //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                        OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                        if(!Test.isRunningTest()){
                            //chiamo il metodo che gestisce le callout e aggiorna il DB
                            OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
                        }
                    }

                    //Inserisco il log della request e della response di SH
                    if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                        if(OF_SA_GE_UtilsNew.caseOriginale != null && String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Id)){
                            OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                        }
                        insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
                    }
                    return;
                }
                OF_SA_GE_UtilsNew.checkCEIList=true;
                OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
                cei.recordtypeid=OF_SA_GE_UtilsNew.rtMap.get('OF_ServiziAggiuntivi');
                cei.OF_NOME_SERVIZIO__c=sl.OF_SA_NOME_SERVIZIO__c; 
                cei.OF_INFORMAZIONI_SERVIZIO__c=sl.OF_SA_INFORMAZIONI_SERVIZIO__c;
                cei.OF_Case__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
                cei.OF_SA_Servizio_Aggiuntivo__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
                cei.OF_CommercialElement__c=ceNameId.get(sl.OF_SA_NOME_SERVIZIO__c.toUpperCase());
                OF_SA_GE_UtilsNew.ceiList.add(cei); 
            }  
        } 

        if(OF_SA_GE_UtilsNew.checkApp){
            Integer n = 1; 
            
            for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListApp){
            	OF_SA_GE_UtilsNew.checkCEIList=true;
                OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
                cei.recordtypeid=OF_SA_GE_UtilsNew.rtMap.get('OF_CPE');
                cei.OF_TIPOLOGIAAPPARATO__C=sl.EOF_TIPOLOGIA_APPARATO__c;
                cei.OF_PASSWORD_APPARATO__C=sl.OF_SA_PASSWORD_APPARATO__c;
                cei.OF_AZIONEAPPARATO__C=sl.OF_SA_AZIONE_APPARATO__c;
                cei.CAUSALE_APPARATO__c = sl.EOF_CAUSALE_APPARATO__c;
                cei.OF_Case__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
                cei.OF_SA_CPE__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
                cei.OF_CommercialElement__c=ceNameId.get('CPE');
                OF_SA_GE_UtilsNew.ceiList.add(cei);
            }
        } 
        
        
        if(OF_SA_GE_UtilsNew.checkVLan){  
            Integer n = 1;
            for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListVLan){
            	OF_SA_GE_UtilsNew.checkCEIList=true;
                OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
                cei.recordtypeid=OF_SA_GE_UtilsNew.rtMap.get('OF_VLAN');
                cei.OF_KITCONSEGNAVLAN__C=sl.OF_SA_KIT_CONSEGNA_VLAN__c;
                cei.OF_USERVLAN__C=sl.OF_SA_USER_VLAN__c;
                cei.OF_SERVICEVLAN__C=sl.OF_SA_SERVICE_VLAN__c;
                cei.OF_PROFILOVLAN__C=sl.OF_SA_PROFILO_VLAN__c;
                cei.OF_INFORMAZIONIVLAN__C=sl.OF_SA_INFORMAZIONI_VLAN__c;
                cei.OF_CUSTOMERVLAN__C=sl.OF_SA_CUSTOMER_VLAN__c;
                cei.OF_MODELLODISERVIZIOVLAN__C=sl.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c;
                cei.OF_Case__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
                cei.OF_SA_VLAN__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
                cei.OF_CommercialElement__c=ceNameId.get('VLAN');
                OF_SA_GE_UtilsNew.ceiList.add(cei);
            }
        }
        
        
    	/*
        List<OF_SA_Network_Inventory_Attivi__c> ni = [SELECT Id,OF_SA_Civico__c,OF_SA_Comune__c,OF_SA_GPON_ID__c,OF_SA_ID_Building__c,OF_SA_Pop__c,
                                            OF_SA_Indirizzo__c, OF_SA_Particella_Top__c,OF_SA_Provincia__c,OF_SA_Scala_Palazzina__c,OF_SA_Stato_Building__c,
                                             OF_SA_ID_Building_OM__c
                                             FROM OF_SA_Network_Inventory_Attivi__c WHERE OF_SA_ID_Building__c =:OF_SA_GE_UtilsNew.caseOriginale.EOF_ID_Building_WS__c];  
        */
        List<OF_SA_Network_Inventory_Attivi__c> ni;
        if(!Test.isRunningTest()){
       		ni = OF_SA_GE_UtilsNew.controlloVendibilita(OF_SA_GE_UtilsNew.caseOriginale.EOF_codice_operatore_WS__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_ID_Building_WS__c);    
        }else{
            ni = [SELECT Id,OF_SA_Civico__c,OF_SA_Comune__c,OF_SA_GPON_ID__c,OF_SA_ID_Building__c,OF_SA_Pop__c,
                                            OF_SA_Indirizzo__c, OF_SA_Particella_Top__c,OF_SA_Provincia__c,OF_SA_Scala_Palazzina__c,OF_SA_Stato_Building__c,
                                             OF_SA_ID_Building_OM__c
                                             FROM OF_SA_Network_Inventory_Attivi__c WHERE OF_SA_ID_Building__c =:OF_SA_GE_UtilsNew.caseOriginale.EOF_ID_Building_WS__c];  
        }
        
        
        //implementare la logica di      acquisizione KO       
        if(ni.isEMpty()){
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'Identificativo Building Errato';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B00';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Identificativo Building Errato';
            OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO'; 
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA'; 
            //Richiamo SH per annullare l'appuntamento, se il TokenId è stato valorizzato
            if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
                OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c);            
            }
            //sLogOFSHReqANDRes.EOF_Codice_Errore__c controllare se è uguale a C02 (NACK TECNICO)
            //TODO AA - NEL CASO IN CUI SH CI RESTITUISCE UN NACK TECNICO FERMIAMO LE CHIAMATE E CREIAMO SOLO I LOG DI OLO E OM
            if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){//Abbiamo ricevuto un NACK TECNICO DA SH
                //In caso di NACK TECNICO da SH creiamo solo i log di OLO e OM, senza effettuare la callout
                //Creo il log di della chiamata verso OLO
                OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                //Aggiorno i dati di acquisizione
                OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
            }else{
                //Abbiamo ricevuto un ACK da SH
                //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                if(!Test.isRunningTest()){
                    //chiamo il metodo che gestisce le callout e aggiorna il DB
                    OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
                }
            }

            //Inserisco il log della request e della response di SH
            if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                if(OF_SA_GE_UtilsNew.caseOriginale != null && String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Id)){
                    OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                }
                insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
            }
            return;
            
        } 
        
        //creo la lista ordinata degli stati building positivi
        List<Integer> positivi = new List<Integer>();
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
		//AA Nuovo controllo richiesto da PT e CC su Stato scala palazzina
        /*Vado a controllare se in fase di richiesta di attivazione è stato popolato il campo SCALA_PALAZZINA;
            Se è stato popolato, vado a verificare se è presente nella lista di risposta dal controllo vendibilità;
            Se trovo il match, controllo che lo stato della scala sia contenuto nella lista positivi;
            Se non è contenuto nella lista positivi, restituisco un NACK 'Scala non RFC/RFA'
        */
        if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.EOF_Scala_Palazzina_WS__c)){
            Boolean scalaHasBadStatus = false;
            //Ciclo la lista di response dalla vendibilità
            for(OF_SA_Network_Inventory_Attivi__c n : ni){
                //Vedo se coincide la scala palazzina con quella inserita dall'OLO
                if(OF_SA_GE_UtilsNew.caseOriginale.EOF_Scala_Palazzina_WS__c.equalsIgnoreCase(n.OF_SA_Scala_Palazzina__c)){
                    //Se coincide, controllo che lo stato sia corretto
                    if(!positivi.contains(Integer.valueOf(n.OF_SA_Stato_Scala_Palazzina__c))){//Se lo stato non è contenuto nella lista positivi, restituisco un KO
                        scalaHasBadStatus = true;
                        break;
                    }else{//Se lo stato è contenuto nella lista positivi, vado ai controlli successivi
                        break;
                    }
                }
            }
            //Se lo stato scala non è uno dei numeri positivi, restituiamo l'errore B02
            if(scalaHasBadStatus){
                OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'Scala non RFC/RFA';
                OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B02';
                OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Scala non RFC/RFA';
                OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO';
                OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA';
                //Richiamo SH per annullare l'appuntamento, se il TokenId è stato valorizzato
                if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
                    OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c);            
                }
                //sLogOFSHReqANDRes.EOF_Codice_Errore__c controllare se è uguale a C02 (NACK TECNICO)
                //TODO AA - NEL CASO IN CUI SH CI RESTITUISCE UN NACK TECNICO FERMIAMO LE CHIAMATE E CREIAMO SOLO I LOG DI OLO E OM
                if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){//Abbiamo ricevuto un NACK TECNICO DA SH
                    //In caso di NACK TECNICO da SH creiamo solo i log di OLO e OM, senza effettuare la callout
                    //Creo il log di della chiamata verso OLO
                    OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                    //Aggiorno i dati di acquisizione
                    OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
                }else{
                    //Abbiamo ricevuto un ACK da SH
                    //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                    OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                    if(!Test.isRunningTest()){
                        //chiamo il metodo che gestisce le callout e aggiorna il DB
                        OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
                    }
                }

                //Inserisco il log della request e della response di SH
                if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                    if(OF_SA_GE_UtilsNew.caseOriginale != null && String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Id)){
                        OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                    }
                    insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
                }
                return;
            }
        }
        //AA FINE NUOVO CONTROLLO STATO SCALA PALAZZINA
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
			
			List<OF_ElencoComuniItaliani__c> cList =[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
	        if (!cList.isEmpty()){
	            if(String.isNotBlank(cList[0].OF_Comune__c)){
	                OF_SA_GE_UtilsNew.caseOriginale.EOF_Comune_WS__c=cList[0].OF_Comune__c;
	            }
	            if(String.isNotBlank(cList[0].OF_Provincia__c)){
	                OF_SA_GE_UtilsNew.caseOriginale.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
	            }
	        }
			OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'Building non RFC/RFA';
			OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B01';
			OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Building non RFC/RFA';
			OF_SA_GE_UtilsNew.caseOriginale.EOF_Identificativo_del_POP__c = corretto.OF_SA_Pop__c;                        
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Istat_Provincia__c = corretto.OF_SA_Provincia__c;
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Istat_Comune__c= corretto.OF_SA_Comune__c;
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Particella_Toponomastica_WS__c = corretto.OF_SA_Particella_Top__c;
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Indirizzo_WS__c = corretto.OF_SA_Indirizzo__c;
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Numero_Civico_WS__c = corretto.OF_SA_Civico__c;
	        OF_SA_GE_UtilsNew.caseOriginale.OF_SA_ID_Building_OM__c = corretto.OF_SA_ID_Building_OM__c; 
	        //OF_SA_GE_UtilsNew.caseOriginale.EOF_ID_Building_WS__c = corretto.OF_SA_ID_Building__c;  
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Stato_Building__c=corretto.OF_SA_Stato_Building__c;
			OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO';
			OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA';

            //Richiamo SH per annullare l'appuntamento, se il TokenId è stato valorizzato
            if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
                OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c);            
            }
            //sLogOFSHReqANDRes.EOF_Codice_Errore__c controllare se è uguale a C02 (NACK TECNICO)
            //TODO AA - NEL CASO IN CUI SH CI RESTITUISCE UN NACK TECNICO FERMIAMO LE CHIAMATE E CREIAMO SOLO I LOG DI OLO E OM
            if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){//Abbiamo ricevuto un NACK TECNICO DA SH
                //In caso di NACK TECNICO da SH creiamo solo i log di OLO e OM, senza effettuare la callout
                //Creo il log di della chiamata verso OLO
                OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                //Aggiorno i dati di acquisizione
                OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
            }else{
                //Abbiamo ricevuto un ACK da SH
                //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                if(!Test.isRunningTest()){
                    //chiamo il metodo che gestisce le callout e aggiorna il DB
                    OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
                }
            }

            //Inserisco il log della request e della response di SH
            if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                if(OF_SA_GE_UtilsNew.caseOriginale != null && String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Id)){
                    OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                }
                insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
            }
            return;
		}
        else{
        	//caso in cui è stato trovato nella lista degli stati building positivi
        	List<OF_ElencoComuniItaliani__c> cList =[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
	        if (!cList.isEmpty()){
	            if(String.isNotBlank(cList[0].OF_Comune__c)){
	                OF_SA_GE_UtilsNew.caseOriginale.EOF_Comune_WS__c=cList[0].OF_Comune__c;
	            }
	            if(String.isNotBlank(cList[0].OF_Provincia__c)){
	                OF_SA_GE_UtilsNew.caseOriginale.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
	            }
	        }
        	OF_SA_GE_UtilsNew.caseOriginale.EOF_Identificativo_del_POP__c = corretto.OF_SA_Pop__c;                        
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Istat_Provincia__c = corretto.OF_SA_Provincia__c;
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Istat_Comune__c= corretto.OF_SA_Comune__c;
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Particella_Toponomastica_WS__c = corretto.OF_SA_Particella_Top__c;
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Indirizzo_WS__c = corretto.OF_SA_Indirizzo__c;
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Numero_Civico_WS__c = corretto.OF_SA_Civico__c;
	        OF_SA_GE_UtilsNew.caseOriginale.OF_SA_ID_Building_OM__c = corretto.OF_SA_ID_Building_OM__c; 
	        //OF_SA_GE_UtilsNew.caseOriginale.EOF_ID_Building_WS__c = corretto.OF_SA_ID_Building__c;  
	        OF_SA_GE_UtilsNew.caseOriginale.EOF_Stato_Building__c=corretto.OF_SA_Stato_Building__c;
        	
        	//Async control DATA_PREVISTA_ATTIVAZIONE
            Date DPA = OF_SA_GE_UtilsNew.caseOriginale.EOF_Data_Prevista_Attivazione__c;
            Integer year = DPA.year();
            Integer month = DPA.month();
            Integer day = DPA.day();
            Datetime targetTime = Datetime.newInstance(year, month, day, 0, 0, 0);
            BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
            BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
            Boolean isWithin;
            //Se l'OLO è SKY, isWithin deve comprendere anche il sabato come giornata lavorativa, quindi controllo su bh_dac
            if(OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Operatore_WS__c == 'SKY'){
                isWithin = BusinessHours.isWithin (bh_dac.Id, targetTime);
            }else{//Per tutti gli OLO che non sono SKY, il sabato è festivo!
                isWithin = BusinessHours.isWithin (bh.Id, targetTime);  
            }
            
            if(isWithin == false && OF_SA_GE_UtilsNew.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c!='TIS_20170403_000000001'){ 
            	
                OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'A10';
				OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
				OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO';
				OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA';
                //Richiamo SH per annullare l'appuntamento, se il TokenId è stato valorizzato
                if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
                    OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c);            
                }
                //sLogOFSHReqANDRes.EOF_Codice_Errore__c controllare se è uguale a C02 (NACK TECNICO)
                //TODO AA - NEL CASO IN CUI SH CI RESTITUISCE UN NACK TECNICO FERMIAMO LE CHIAMATE E CREIAMO SOLO I LOG DI OLO E OM
                if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){//Abbiamo ricevuto un NACK TECNICO DA SH
                    //In caso di NACK TECNICO da SH creiamo solo i log di OLO e OM, senza effettuare la callout
                    //Creo il log di della chiamata verso OLO
                    OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                    //Aggiorno i dati di acquisizione
                    OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
                }else{
                    //Abbiamo ricevuto un ACK da SH
                    //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                    OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                    if(!Test.isRunningTest()){
                        //chiamo il metodo che gestisce le callout e aggiorna il DB
                        OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
                    }
                }

                //Inserisco il log della request e della response di SH
                if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                    if(OF_SA_GE_UtilsNew.caseOriginale != null && String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Id)){
                        OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                    }
                    insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
                }
                return;
            }     
        	
	        Integer num_giorni_rfa = 0;
	        Integer num_giorni_rfc = 0;
	        Datetime RFA = Datetime.newInstance(system.now().year(), system.now().month(), system.now().day(), 0, 0, 0);
	        Datetime RFC = Datetime.newInstance(system.now().year(), system.now().month(), system.now().day(), 0, 0, 0);
	
	        //per RFA devo sommare 5 giorni escluse le festività perchè sia conforme agli sla
	        while(num_giorni_rfa < 5){  
	            if(BusinessHours.isWithin(bh_dac.Id, RFA) == true ){                
	                RFA = Datetime.newInstance(RFA.year(), RFA.month() , RFA.day()+1,0,0,0);
	                num_giorni_rfa++;                         
	                continue;
	            }       
	            RFA = Datetime.newInstance(RFA.year(), RFA.month() , RFA.day()+1,0,0,0);      
	        }                    
	        while(num_giorni_rfc < 10){ 
	            if(BusinessHours.isWithin(bh_dac.Id, RFC) == true ){                 
	                RFC = Datetime.newInstance(RFC.year(), RFC.month() , RFC.day()+1,0,0,0);
	                num_giorni_rfc++;                           
	                continue;
	            }       
	            RFC = Datetime.newInstance(RFC.year(), RFc.month() , RFc.day()+1,0,0,0);    
	        } 
	        if(!OF_SA_GE_UtilsNew.caseOriginale.OF_Bonifica_Locked_Row__c){
	           if(((corretto.OF_SA_Stato_Building__c == 110 && OF_SA_GE_UtilsNew.caseOriginale.EOF_Data_Prevista_Attivazione__c < RFA.date()) || (corretto.OF_SA_Stato_Building__c != 110 && OF_SA_GE_UtilsNew.caseOriginale.EOF_Data_Prevista_Attivazione__c < RFC.date())) && OF_SA_GE_UtilsNew.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c!='TIS_20170403_000000001'){
	                OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'Data Attesa Consegna non conforme agli SLA';
					OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'A09';
					OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Data Attesa Consegna non conforme agli SLA';
					OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO';
					OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA';
                    //Richiamo SH per annullare l'appuntamento, se il TokenId è stato valorizzato
                    if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
                        OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c);            
                    }
                    //sLogOFSHReqANDRes.EOF_Codice_Errore__c controllare se è uguale a C02 (NACK TECNICO)
                    //TODO AA - NEL CASO IN CUI SH CI RESTITUISCE UN NACK TECNICO FERMIAMO LE CHIAMATE E CREIAMO SOLO I LOG DI OLO E OM
                    if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){//Abbiamo ricevuto un NACK TECNICO DA SH
                        //In caso di NACK TECNICO da SH creiamo solo i log di OLO e OM, senza effettuare la callout
                        //Creo il log di della chiamata verso OLO
                        OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                        //Aggiorno i dati di acquisizione
                        OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
                    }else{
                        //Abbiamo ricevuto un ACK da SH
                        //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                        OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                        if(!Test.isRunningTest()){
                            //chiamo il metodo che gestisce le callout e aggiorna il DB
                            OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
                        }
                    }

                    //Inserisco il log della request e della response di SH
                    if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                        if(OF_SA_GE_UtilsNew.caseOriginale != null && String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Id)){
                            OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                        }
                        insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
                    }
                    return;
	            }
	        } 
        }
        if(corretto.OF_SA_Pop__c != OF_SA_GE_UtilsNew.slOLOSF.EOF_ID_POP__c){ 
            List<OF_ElencoComuniItaliani__c> cList = new List<OF_ElencoComuniItaliani__c>();
	        cList=[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
	        if (!cList.isEmpty()){
	            if(String.isNotBlank(cList[0].OF_Comune__c)){
	                OF_SA_GE_UtilsNew.caseOriginale.EOF_Comune_WS__c=cList[0].OF_Comune__c;
	            }
	            if(String.isNotBlank(cList[0].OF_Provincia__c)){
	                OF_SA_GE_UtilsNew.caseOriginale.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
	            }
	        }
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'Associazione ID Building-POP errata';
			OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B03';
			OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Associazione ID Building-POP errata';  
			OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO';
			OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA';
            //Richiamo SH per annullare l'appuntamento, se il TokenId è stato valorizzato
            if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
                OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c);            
            }
            //sLogOFSHReqANDRes.EOF_Codice_Errore__c controllare se è uguale a C02 (NACK TECNICO)
            //TODO AA - NEL CASO IN CUI SH CI RESTITUISCE UN NACK TECNICO FERMIAMO LE CHIAMATE E CREIAMO SOLO I LOG DI OLO E OM
            if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){//Abbiamo ricevuto un NACK TECNICO DA SH
                //In caso di NACK TECNICO da SH creiamo solo i log di OLO e OM, senza effettuare la callout
                //Creo il log di della chiamata verso OLO
                OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                //Aggiorno i dati di acquisizione
                OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
            }else{
                //Abbiamo ricevuto un ACK da SH
                //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                if(!Test.isRunningTest()){
                    //chiamo il metodo che gestisce le callout e aggiorna il DB
                    OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
                }
            }

            //Inserisco il log della request e della response di SH
            if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                if(OF_SA_GE_UtilsNew.caseOriginale != null && String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Id)){
                    OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                }
                insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
            }
            return;
        } 

                 
        OF_SA_GE_UtilsNew.caseOriginale.status='Acquisito';
        OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__C='Da Lavorare';
        
        List<OF_ElencoComuniItaliani__c> cList = new List<OF_ElencoComuniItaliani__c>();
        cList=[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
        if (!cList.isEmpty()){
            if(String.isNotBlank(cList[0].OF_Comune__c)){
                OF_SA_GE_UtilsNew.caseOriginale.EOF_Comune_WS__c=cList[0].OF_Comune__c;
            }
            if(String.isNotBlank(cList[0].OF_Provincia__c)){
                OF_SA_GE_UtilsNew.caseOriginale.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
            }
        }

		
		//check contract B05
        List<OF_ContrattoServizio__c> checkOpenStreamContract = [select id,name,OF_Contract__c from OF_ContrattoServizio__c 














        											where OF_Servizio__r.name='Open Stream' 
        											and OF_Contract__r.Status='Attivo'
        											AND OF_Contract__r.AccountId =: OF_SA_GE_UtilsNew.caseOriginale.EOF_Account_OLO__c
        											AND OF_Contract__r.StartDate <: OF_SA_GE_UtilsNew.caseOriginale.EOF_Data_Prevista_Attivazione__c
        											AND OF_Contract__r.EndDate >: OF_SA_GE_UtilsNew.caseOriginale.EOF_Data_Prevista_Attivazione__c];


		if(checkOpenStreamContract.isEMpty()){
			OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B05';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO';
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA';
            //Richiamo SH per annullare l'appuntamento, se il TokenId è stato valorizzato
            if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
                OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c);            
            }
            //sLogOFSHReqANDRes.EOF_Codice_Errore__c controllare se è uguale a C02 (NACK TECNICO)
            //TODO AA - NEL CASO IN CUI SH CI RESTITUISCE UN NACK TECNICO FERMIAMO LE CHIAMATE E CREIAMO SOLO I LOG DI OLO E OM
            if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){//Abbiamo ricevuto un NACK TECNICO DA SH
                //In caso di NACK TECNICO da SH creiamo solo i log di OLO e OM, senza effettuare la callout
                //Creo il log di della chiamata verso OLO
                OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                //Aggiorno i dati di acquisizione
                OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
            }else{
                //Abbiamo ricevuto un ACK da SH
                //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                if(!Test.isRunningTest()){
                    //chiamo il metodo che gestisce le callout e aggiorna il DB
                    OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
                }
            }

            //Inserisco il log della request e della response di SH
            if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                if(OF_SA_GE_UtilsNew.caseOriginale != null && String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Id)){
                    OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                }
                insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
            }
            return;
		}
		OF_SA_GE_UtilsNew.caseOriginale.OF_IDContratto__c = checkOpenStreamContract[0].OF_Contract__c;
		//check città B_04
		List<OF_AreaGeograficaJunction__c> checkCityCOntract =[select id from OF_AreaGeograficaJunction__c 
															where OF_Contratto__c =:checkOpenStreamContract[0].OF_Contract__c
															AND OF_AreaGeografica__r.OF_Istat__c=:OF_SA_GE_UtilsNew.caseOriginale.EOF_Istat_Comune__c];
		if(checkCityCOntract.isEMpty()){
			OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B04';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO';
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA';
            //Richiamo SH per annullare l'appuntamento, se il TokenId è stato valorizzato
            if(String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c)){
                OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c);            
            }
            //sLogOFSHReqANDRes.EOF_Codice_Errore__c controllare se è uguale a C02 (NACK TECNICO)
            //TODO AA - NEL CASO IN CUI SH CI RESTITUISCE UN NACK TECNICO FERMIAMO LE CHIAMATE E CREIAMO SOLO I LOG DI OLO E OM
            if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){//Abbiamo ricevuto un NACK TECNICO DA SH
                //In caso di NACK TECNICO da SH creiamo solo i log di OLO e OM, senza effettuare la callout
                //Creo il log di della chiamata verso OLO
                OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                //Aggiorno i dati di acquisizione
                OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
            }else{
                //Abbiamo ricevuto un ACK da SH
                //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
                if(!Test.isRunningTest()){
                    //chiamo il metodo che gestisce le callout e aggiorna il DB
                    OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
                }
            }

            //Inserisco il log della request e della response di SH
            if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                if(OF_SA_GE_UtilsNew.caseOriginale != null && String.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Id)){
                    OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                }
                insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
            }
            return;
		}
		/*					
        String check = null;
        OF_UtilitiesManageOrderFromCase obj = new OF_UtilitiesManageOrderFromCase();
        check = obj.VerificheCommContratt1(OF_SA_GE_UtilsNew.caseOriginale);
        OF_SA_GE_UtilsNew.caseOriginale.OF_IDContratto__c = obj.getIDContratto();
        
        if(check == 'B_05'){
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B05';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO';
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA';
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
            return;
            
        }
        if(check ==  'B_04'){
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B04';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_GE_UtilsNew.caseOriginale.Status = 'Acquisito KO';
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Fase__c = 'NA';
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
            return;
        }
		*/
		//genero l'id servizio andando a inserire un record dell'oggetto OF_Generatore_ID_Servizio__c
		OF_SA_GE_UtilsNew.gen =[select OF_ID_Servizio__c from OF_Generatore_ID_Servizio__c where OF_Case_Id__c=:OF_SA_GE_UtilsNew.caseOriginale.Id];
		OF_SA_GE_UtilsNew.caseOriginale.OF_SA_ID_Servizio__c=OF_SA_GE_UtilsNew.gen.OF_ID_Servizio__c;
        
        //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
        OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
        if(!Test.isRunningTest()){
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO);
        }
        return;
    } 
    //Deactivation sky
    @future(callout=true)  
    public static void OLO_AsyncDeactivationNew(String caseId, String SLOloSfId){
    	
    	   
        OF_SA_GE_UtilsNew.caseOriginale = Database.query(OF_SA_GE_UtilsNew.getQueryNew('case','AsyncDeactivation')+
        										' where id=:caseId');
        OF_SA_GE_UtilsNew.ListSlDeactivationOLOSF=Database.query(OF_SA_GE_UtilsNew.getQueryNew('sl','AsyncDeactivation')+ 
        										' where id =:SLOloSfId' 
		        								+' OR OF_SA_Cpe_Log__c =:SLOloSfId'
		        								+' order by EOF_Ordine_Invio_OLO__c');       								
		OF_SA_GE_UtilsNew.ListApp = new List<EOF_EAI_Service_Log__c>();        								     								
		for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListSlDeactivationOLOSF){
			if(sl.recordtype.developername=='OF_SA_FiberRequest'){
				OF_SA_GE_UtilsNew.slOLOSF=sl;	
			}
			if(sl.recordtype.developername=='OF_SA_Cpe'){
				OF_SA_GE_UtilsNew.checkApp=true;
				OF_SA_GE_UtilsNew.ListApp.add(sl);
			}
		}
		
		List<recordtype> rtList=[select Id,developerName from recordtype];
        OF_SA_GE_UtilsNew.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_SA_GE_UtilsNew.rtMap.put(rt.DeveloperName, rt.Id); 
        }               
        OF_SA_GE_UtilsNew.checkrtMap=true;
        
        OLO_ID__c oloId=OLO_ID__c.getInstance(OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Operatore_WS__c);
        OF_SA_GE_UtilsNew.caseOriginale.EOF_Account_OLO__c=oloId.OF_Olo_Id__c;
        // 10/01/2018 Marco : aggiunta creazione cliente per la richiesta di cessazione


        if(String.isNotBlank(OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c)){
            OF_SA_GE_UtilsNew.checkCliente = true;
        
            if(String.isBlank(OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__C)){
                OF_SA_GE_UtilsNew.cliente = new Account(Name = OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c,
                                                    RecordTypeId = OF_SA_GE_UtilsNew.rtMap.get('Cliente_Business'),
                                                    Phone = OF_SA_GE_UtilsNew.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                                    EOF_Phone_2__c = OF_SA_GE_UtilsNew.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );                       

            }else{
                
                OF_SA_GE_UtilsNew.cliente = new Account(FirstName = OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c,
                                        LastName = OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c,
                                        RecordTypeId = OF_SA_GE_UtilsNew.rtMap.get('PersonAccount'),
                                        Phone = OF_SA_GE_UtilsNew.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                        EOF_Phone_2__c = OF_SA_GE_UtilsNew.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
            }
        }

        // 10/01/2018 Marco : fine modifica
        
        //Da verificare quale sarà l'oggetto Asset
        String IdRisorsa=OF_SA_GE_UtilsNew.caseOriginale.EOF_ID_Risorsa__c;
        String codiceOperatore=OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Operatore_WS__c;


        List<Asset> aList= Database.query(OF_SA_GE_UtilsNew.getQueryNew('Asset','AsyncDeactivation')+ 
        					' where recordtype.developername=\'OF_OpenStream\' and Status=\'Attivo\' and EOF_Id_Risorsa__c=:IdRisorsa'

                            +' and Account.EOF_Codice_Operatore__c=:codiceOperatore');

        //caso di errore asincrono
        system.debug('LISTA DI ASSET RECUPERATI DOPO IL PROCESSO DI CESSAZIONE ' + aList);
        if(aList.isEmpty()){
            OF_SA_GE_UtilsNew.caseOriginale.status='Cessato KO';
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Causale_Errore__c = 'ID Risorsa da cessare inesistente/errato';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B07';
            OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c = 'ID Risorsa da cessare inesistente/errato';
            //Update c;
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(OF_SA_GE_UtilsNew.caseOriginale);
			//chiamo il metodo che gestisce le callout e aggiorna il DB
            if(!Test.isRunningTest()){
                OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(OF_SA_GE_UtilsNew.slSFOLO); 
            }
            return;     
        }
        
        List<OF_CommercialElementIstanziato__c> ceiList=[SELECT Id,OF_TipologiaApparato__C FROM OF_CommercialElementIstanziato__c where 
                                                            OF_CPE__c=:aList[0].id];
        
        //valorizzo l'asset statico
        OF_SA_GE_UtilsNew.a=aList[0];
        
        //caso in cui la cessazione ha superato i controlli asincroni   
        OF_SA_GE_UtilsNew.caseOriginale.status='Acquisito';
        OF_SA_GE_UtilsNew.caseOriginale.OF_IDContratto__c = OF_SA_GE_UtilsNew.a.OF_Contract__c;
        OF_SA_GE_UtilsNew.caseOriginale.OF_SA_ID_Servizio__c=aList[0].OF_IDServizio__c;
        OF_SA_GE_UtilsNew.caseOriginale.AssetId=aList[0].id;
        OF_SA_GE_UtilsNew.caseOriginale.EOF_Provincia_WS__c=aList[0].OF_Provincia__c;
        OF_SA_GE_UtilsNew.caseOriginale.EOF_Comune_WS__c=aList[0].OF_Comune__c;
        OF_SA_GE_UtilsNew.caseOriginale.EOF_Particella_Toponomastica_WS__c=aList[0].OF_Particella_Toponomastica__c;
        OF_SA_GE_UtilsNew.caseOriginale.EOF_Indirizzo_WS__c=aList[0].OF_Indirizzo__c;
        OF_SA_GE_UtilsNew.caseOriginale.EOF_Numero_Civico_WS__c=aList[0].OF_Civico__c; 
        if(!Test.isRunningTest()){     
            OF_SA_GE_UtilsNew.makeCalloutOMNew(OF_SA_GE_UtilsNew.ListSlDeactivationOLOSF); 
        }
        return;
    }
    //Status update sky3
    @future(callout=true)
    public static void OLO_AsyncStatusUpdateNew(String caseId, String sLogId){
        //Recupero il log della request da parte di OLO
        EOF_EAI_Service_Log__c slogOLOSF = [SELECT Id, EOF_CODICE_OPERATORE__C, EOF_CODICE_ORDINE_OLO__C, EOF_ID_NOTIFICA__C, EOF_DATA_NOTIFICA__C,
                                            OF_SA_AZIONE__C, EOF_CODICE_MOTIVAZIONE__C, EOF_MOTIVAZIONE__C,
                                            EOF_DATA_PREVISTA_ATTIVAZIONE__c, EOF_ORARIO_APPUNTAMENTO__C, EOF_NOME_CLIENTE__C,
                                            EOF_COGNOME_CLIENTE__C, EOF_RECAPITO_TELEFONICO_CLIENTE_1__C, 
                                            EOF_RECAPITO_TELEFONICO_CLIENTE_2__C, EOF_Note__c											   
                                            FROM EOF_EAI_Service_Log__c
                                            WHERE Id = :sLogId];
        OF_SA_GE_UtilsNew.caseOriginale = [SELECT Id, OF_Blocked_Case__c, OF_OM_Nuovo_Flusso__c, Description
                                        FROM Case
                                        WHERE Id = :caseId];
        //Ricreo una fake req così da sfruttare i vecchi metodi	  
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest req = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
            req.CODICE_OPERATORE = slogOLOSF.EOF_CODICE_OPERATORE__C; 
            req.CODICE_ORDINE_OLO = slogOLOSF.EOF_CODICE_ORDINE_OLO__C;
            req.DATA_NOTIFICA = String.valueOf(slogOLOSF.EOF_DATA_NOTIFICA__C);
            req.ID_NOTIFICA = slogOLOSF.EOF_ID_NOTIFICA__C;
            req.AZIONE = slogOLOSF.OF_SA_AZIONE__C;
            req.CODICE_MOTIVAZIONE = slogOLOSF.EOF_CODICE_MOTIVAZIONE__C;
            req.MOTIVAZIONE = slogOLOSF.EOF_MOTIVAZIONE__C;
            req.DATA_PREVISTA_ATTIVAZIONE = String.valueOf(slogOLOSF.EOF_DATA_PREVISTA_ATTIVAZIONE__c);
            req.ORARIO_APPUNTAMENTO = slogOLOSF.EOF_ORARIO_APPUNTAMENTO__C;
            req.NOME_CLIENTE = slogOLOSF.EOF_NOME_CLIENTE__C;
            req.COGNOME_CLIENTE = slogOLOSF.EOF_COGNOME_CLIENTE__C; 
            req.RECAPITO_TELEFONICO_CLIENTE_1 = slogOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__C;
            req.RECAPITO_TELEFONICO_CLIENTE_2 = slogOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__C;
            req.NOTE = slogOLOSF.EOF_Note__c;
        
        //Creo il log della request per girarmi verso OM
        //METODO GIà DUPLICATO MEDIANTE ISTANCE OF PER SKY FASE 3
        OF_SA_GE_UtilsNew.slSFOM = OF_SA_GE_UtilsNew.OLO_CreateStatusUpdate_Log(OF_SA_GE_UtilsNew.caseOriginale, req);
        //Richiamo OM
        //TODO AA - BISOGNERà RICHIAMARE IL NUOVO WS DI OM
        Map<String,EOF_EAI_Service_Log__c> responseFromOM;
        if(!Test.isRunningTest()){
        	responseFromOM = OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestStatusUpdateNew(OF_SA_GE_UtilsNew.slSFOM);  
        }else{
            responseFromOM = new Map<String,EOF_EAI_Service_Log__c>();
            EOF_EAI_Service_Log__c slog = new EOF_EAI_Service_Log__c();
            responseFromOM.put('0', slog);
        }
        
        
        //Inserisco il log della request così da poterlo collegare al log della response
        insert OF_SA_GE_UtilsNew.slSFOM;
        //Lista che aggiornerò/inserirò
        List<EOF_EAI_Service_Log__c> listToUpsert = new List<EOF_EAI_Service_Log__c>();
        
        if(responseFromOM.containsKey('0')) {//Caso di ACK
            OF_SA_GE_UtilsNew.slSFOMResp = responseFromOM.get('0');
            OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'ACK';
            //Done AA - Aggiornare il campo blockedCase così da poter ricevere altre info
            //OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c = false;
        }else{
            OF_SA_GE_UtilsNew.slSFOMResp = responseFromOM.get('1');
            if(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c == 'NACK TECNICO'){
                OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'NACK TECNICO';
            }else{
                OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'NACK';
                //OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c = false;
            }
        }
        OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c = false;
        update OF_SA_GE_UtilsNew.caseOriginale;
        OF_SA_GE_UtilsNew.slSFOMResp.EOF_SL_Riferimento__c = OF_SA_GE_UtilsNew.slSFOM.Id;
        
        listToUpsert.add(OF_SA_GE_UtilsNew.slSFOM);
        listToUpsert.add(OF_SA_GE_UtilsNew.slSFOMResp);
        upsert listToUpsert;
    }
    //FINE AA
    @future(callout=true)
    public static void OLO_AsyncRescheduleNew(String caseId, String sLogId){
        EOF_EAI_Service_Log__c slogOLOSF = [SELECT EOF_CODICE_OPERATORE__C, EOF_CODICE_ORDINE_OLO__C, EOF_DATA_NOTIFICA__C, EOF_ID_NOTIFICA__C,
                                            EOF_NOME_CLIENTE__C, EOF_COGNOME_CLIENTE__C, EOF_RECAPITO_TELEFONICO_CLIENTE_1__C, EOF_RECAPITO_TELEFONICO_CLIENTE_2__C,
                                            EOF_DATA_PREVISTA_ATTIVAZIONE__C, EOF_ORARIO_APPUNTAMENTO__C, EOF_Note__c, EOF_CODICE_MOTIVAZIONE__C,
                                            EOF_MOTIVAZIONE__C
                                            FROM EOF_EAI_Service_Log__c
                                            WHERE Id = :sLogId]; 
        OF_SA_GE_UtilsNew.caseOriginale = [SELECT Id, OF_Blocked_Case__c, Codice_Ordine_EOF__c, OF_SA_ID_SERVIZIO__c, OF_OM_Nuovo_Flusso__c, Description, OF_SH_Token_id__c,
                                           OF_SA_Profilo__c,OF_SH_ID_WO__c,EOF_Orario_Appuntamento__c,OF_SH_DeliveryCompany__c,EOF_Data_Appuntamento__c
                                           FROM Case
                                           WHERE Id = :caseId];
        
        OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest req = new OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest();
            req.CODICE_ORDINE_OF = OF_SA_GE_UtilsNew.caseOriginale.Codice_Ordine_EOF__c;
            req.CODICE_OPERATORE = slogOLOSF.EOF_CODICE_OPERATORE__C;
            req.CODICE_ORDINE_OLO = slogOLOSF.EOF_CODICE_ORDINE_OLO__C;
            req.DATA_NOTIFICA = String.valueOf(slogOLOSF.EOF_DATA_NOTIFICA__C);
            req.ID_NOTIFICA = slogOLOSF.EOF_ID_NOTIFICA__C;
            req.NOME_CLIENTE = slogOLOSF.EOF_NOME_CLIENTE__C;
            req.COGNOME_CLIENTE = slogOLOSF.EOF_COGNOME_CLIENTE__C;
            req.RECAPITO_TELEFONICO_CLIENTE_1 = slogOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__C;
            req.RECAPITO_TELEFONICO_CLIENTE_2 = slogOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__C;
            req.DATA_PREVISTA_ATTIVAZIONE = String.valueOf(slogOLOSF.EOF_DATA_PREVISTA_ATTIVAZIONE__C);
            req.ORARIO_APPUNTAMENTO = slogOLOSF.EOF_ORARIO_APPUNTAMENTO__C;
            req.NOTE = slogOLOSF.EOF_Note__c;
            req.CODICE_MOTIVAZIONE = slogOLOSF.EOF_CODICE_MOTIVAZIONE__C;
            req.MOTIVAZIONE = slogOLOSF.EOF_MOTIVAZIONE__C;

        //Creo il log della request per girarmi verso OM
        //DUPLICATO PER SKY FASE 3 TRAMITE ISTANCE OF
        OF_SA_GE_UtilsNew.slSFOM = OF_SA_GE_UtilsNew.OLO_CreateReschedule_Log(OF_SA_GE_UtilsNew.caseOriginale, req);
        //Richiamo OM
        //TODO AA - RICHIAMARE IL NUOVO WS DI OM
        Map<String,EOF_EAI_Service_Log__c> responseFromOM;
        if(!Test.isRunningTest()){
        	responseFromOM = OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestRescheduleNew(OF_SA_GE_UtilsNew.slSFOM);    
        }else{
         	responseFromOM = new Map<String,EOF_EAI_Service_Log__c>();
            responseFromOM.put('0', new EOF_EAI_Service_Log__c());
        }
        
        //Inserisco il log della request così da poterlo collegare al log della response
        insert OF_SA_GE_UtilsNew.slSFOM;
        //Lista che aggiornerò/inserirò
        List<EOF_EAI_Service_Log__c> listToUpsert = new List<EOF_EAI_Service_Log__c>();
        
        if(responseFromOM.containsKey('0')) {
            OF_SA_GE_UtilsNew.slSFOMResp = responseFromOM.get('0');
            OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'ACK';
            //Done AA - Aggiornare il campo blockedCase così da poter ricevere altre info
            //OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c = false;
        }else{
            OF_SA_GE_UtilsNew.slSFOMResp = responseFromOM.get('1');
            if(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c == 'NACK TECNICO'){
                OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'NACK TECNICO';
            }else{
                OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'NACK';
                //OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c = false;
            }
        }
        OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c = false;
        update OF_SA_GE_UtilsNew.caseOriginale;
        OF_SA_GE_UtilsNew.slSFOMResp.EOF_Sl_Riferimento__c = OF_SA_GE_UtilsNew.slSFOM.Id;
        listToUpsert.add(OF_SA_GE_UtilsNew.slSFOM);
        listToUpsert.add(OF_SA_GE_UtilsNew.slSFOMResp);
        upsert listToUpsert;
    }
}
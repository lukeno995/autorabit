public class EOF_GW_GE_Utils{
    
    public static String IDReferenceSl;
    public static EOF_GW_WS_Request.returnFiberResponse res_temp;
    
    //Filling result with status, errorCode and errorDesc and generating NACK Service Logs 
    public static EOF_GW_WS_Request.returnFiberResponse syncError(Object o, String errorCode, String fieldName){
        
        List<String> result = new List<String>();
        res_temp = new EOF_GW_WS_Request.returnFiberResponse();
        res_temp.Esito = '';
        res_temp.CodiceErrore = '';
        res_temp.CausaleErrore = '';
        String errorDesc = '';
        
        if(errorCode == 'A_K5' || errorCode == 'A_K9')
            errorDesc = 'Campo \''+ fieldName +'\' obbligatorio non valorizzato';
        
        if(errorCode == 'A_K6' || errorCode == 'A_K10')
            errorDesc = 'Valore campo \''+ fieldName + '\' non ammesso';
         
        if(errorCode == 'A_K7')
            errorDesc = 'Codice Ordine OLO già presente';
        
        if(o instanceof EOF_GW_WS_Request.FiberRequest){           
                res_temp.Esito = '1';
                res_temp.CodiceErrore = errorCode;
                res_temp.CausaleErrore = errorDesc;
                List<EOF_EAI_Service_Log__C> slListToUpsert = new List<EOF_EAI_Service_Log__C>();
                Map<String,String> slMap = new Map<String,String>();
                slMap.put('Type' , 'NACK');
                slMap.put('Codice_errore' , errorCode);
                slMap.put('Causale_errore' , errorDesc);
                slMap.put('Codice_operatore' , ((EOF_GW_WS_Request.FiberRequest) o).CODICE_OPERATORE);
                slMap.put('Codice_ordine_OLO' , ((EOF_GW_WS_Request.FiberRequest) o).CODICE_ORDINE_OLO);
                slMap.put('ID_notifica' , ((EOF_GW_WS_Request.FiberRequest) o).ID_NOTIFICA);
                slMap.put('Tipo Comunicazione' , 'SF->OLO - NACK - FiberRequest - '+EOF_GW_GE_Utils.retCodOp((EOF_GW_WS_Request.FiberRequest) o));
                if(EOF_GW_GE_Utils.IDReferenceSl!=null){
                	slMap.put('SL Riferimento' , EOF_GW_GE_Utils.IDReferenceSl);
                	EOF_EAI_Service_Log__C slRiferimento = new EOF_EAI_Service_Log__C();
                	slRiferimento.Id=EOF_GW_GE_Utils.IDReferenceSl;
                	slRiferimento.EOF_Response__c='NACK';
                	slListToUpsert.add(slRiferimento);
                }
                EOF_EAI_Service_Log__C slNack = create_EAI_Log(slMap);
                
                //verifico se trovo il case a sistema lo lego agli ack
            	List<Case> cList = [SELECT Id FROM Case Where  EOF_Codice_Ordine_OLO__c =: ((EOF_GW_WS_Request.FiberRequest) o).CODICE_ORDINE_OLO];
            	boolean checkCase;
            	Case c;
	            if(!cList.isEmpty()){
	            	checkCase=true;
	            	c=cList[0];  
	            }
	            //case non a sistema
	            else{
	            	checkCase=false;
	            }
              	if(checkCase){
          			slNack.caso__c=c.Id;
              		slNack.EOF_COdice_ordine_EOF__C=c.Id;
              	}
              	slListToUpsert.add(slNack);
                upsert slListToUpsert;
        }
        
                
        // 23/05/2018 MM : aggiorno il timestamp. END corrisponde alla fine dei check generali.
        OM_GW_GE_Utils.tpl.Timestamp__c= OM_GW_GE_Utils.tpl.Timestamp__c + ', END : '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
		OM_GW_GE_Utils.tpl.Attraversamento__c = datetime.now().getTime() - OM_GW_GE_Utils.AttrTime;        	         	
        
        // finisce qui

        // 25/05/2018 MM : inserisco il templog.
        try{
        	insert OM_GW_GE_Utils.tpl;
        }
        catch(Exception e){
	    	OM_GW_GE_Utils.tpl.Type__c='E';
	    	OM_GW_GE_Utils.tpl.desc__c='Errore :' +e;
			OM_GW_GE_Utils.tpl.Attraversamento__c = datetime.now().getTime() - OM_GW_GE_Utils.AttrTime;        	 
	    	
	    	insert OM_GW_GE_Utils.tpl;        	
        }
		// fine
		
		          
        return res_temp;
    }

    //Creating a different Service Log depending on object passed to the constructor
    public static EOF_EAI_Service_Log__c create_EAI_Log(Object o,String id){         
    if(o instanceof EOF_Notify__c){
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = id,
                    Notify__c = ((EOF_Notify__c) o).Id,
                    EOF_TIpo_comunicazione_String__c='SF->OLO - FiberNotify - '+retSpec(((EOF_Notify__c) o).EOF_Tipo_Comunicazione_ctrl__c),
	                EOF_Tipo_Comunicazione__c = ((EOF_Notify__c) o).EOF_Tipo_Comunicazione_ctrl__c,
                    EOF_Stato_Richiesta__c = 'OK',
                    EOF_Codice_Ordine_OLO__c = ((EOF_Notify__c) o).EOF_Codice_Ordine_OLO__c,
                    EOF_ID_Notifica__c = ((EOF_Notify__c) o).EOF_ID_Notifica__c,
                    EOF_Data_Notifica__c = ((EOF_Notify__c) o).EOF_Data_Notifica__c,
                    EOF_Richiesta_Notifica__c = copy_notify(((EOF_Notify__c) o))
            );
            return sl;
            
        }
        return null;}
   
    public static EOF_EAI_Service_Log__c create_EAI_Log(Object o){
      
      if(o instanceof EOF_GW_WS_Request.FiberRequest){
                  EOF_GW_WS_Request.FiberRequest fr = (EOF_GW_WS_Request.FiberRequest) o; 
                           
                  EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                      RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId(),
                      EOF_TIpo_comunicazione_String__c='OLO->SF - FiberRequest - '+retCodOp(fr),                      
                      EOF_Tipo_Comunicazione__c = fr.TIPO_COMUNICAZIONE,
                      EOF_Codice_Operatore__c = fr.CODICE_OPERATORE,
                      EOF_Codice_Ordine_OLO__c = fr.CODICE_ORDINE_OLO,                    
                      EOF_Data_Notifica__c = StringTODate(fr.DATA_NOTIFICA),
                      EOF_ID_Notifica__c = fr.ID_NOTIFICA,
                      EOF_ID_Pop__c=fr.IDENTIFICATIVO_DEL_POP,            
                      EOF_GPON_Attestazione__c=fr.GPON_ATTESTAZIONE,
                      EOF_GPON_Vincolante__c=fr.GPON_VINCOLANTE,
                      EOF_ID_Risorsa__c=fr.ID_RISORSA,
                      EOF_Nome_Cliente__c=fr.NOME_CLIENTE,
                      EOF_COgnome_CLiente__c=fr.COGNOME_CLIENTE,
                      EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=fr.RECAPITO_TELEFONICO_CLIENTE_1,
                      EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=fr.RECAPITO_TELEFONICO_CLIENTE_2,
                      EOF_PRovincia__c=fr.provincia,
                      EOF_COMUNE__c=fr.COMUNE,
                      EOF_PARTICELLA_TOPONOMASTICA__c=fr.PARTICELLA_TOPONOMASTICA,
                      EOF_INDIRIZZO__C=fr.INDIRIZZO,
                      EOF_NUMERO_CIVICO__c=fr.NUMERO_CIVICO,
                      EOF_ID_BUILDING__c=fr.ID_BUILDING,
                      EOF_SCALA_PALAZZINA__c=fr.SCALA_PALAZZINA,
                      EOF_NOME_REFERENTE_TECNICO_OLO__c=fr.NOME_REFERENTE_TECNICO_OLO,
                      EOF_COGNOME_REFERENTE_TECNICO_OLO__c=fr.COGNOME_REFERENTE_TECNICO_OLO,
                      EOF_TELEFONO_REFERENTE_TECNICO_OLO__c=fr.TELEFONO_REFERENTE_TECNICO_OLO,
                      EOF_EMAIL_REFERENTE_TECNICO_OLO__c=fr.EMAIL_REFERENTE_TECNICO_OLO,
                      EOF_RECAPITO_TEST_LINEA__c=fr.RECAPITO_TEST_LINEA,
                      EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c=fr.NUMERO_TELEFONICO_PRINCIPALE_LINEA,
                      EOF_PASSWORD_APPARATO__c=fr.PASSWORD_APPARATO,
                      EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c=fr.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH,
                      EOF_OPZIONE_SYSTEM_UNICO__c=fr.OPZIONE_SYSTEM_UNICO,
                      EOF_DATA_PREVISTA_ATTIVAZIONE__c=StringTODateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE),
                      EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__C=fr.CAUSALE_RICHIESTA_ANNULLAMENTO,
                      EOF_CODICE_RICHIESTA_ANNULLAMENTO__c=fr.CODICE_RICHIESTA_ANNULLAMENTO,
                      EOF_APPARATO__c=fr.APPARATO,
                      EOF_TIPOLOGIA_APPARATO__c=fr.TIPOLOGIA_APPARATO,
                      EOF_PROGETTO_SPECIALE__c=fr.PROGETTO_SPECIALE,
                      EOF_COLLEGAMENTO_P2P__c=fr.COLLEGAMENTO_P2P,
                      EOF_NOTE__c=fr.NOTE,
                      EOF_TIPOLOGIA_SERVIZIO__c=fr.TIPOLOGIA_SERVIZIO,
                      EOF_SLA_PREMIUM_ASSURANCE__c=fr.SLA_PREMIUM_ASSURANCE,
                      EOF_ORARIO_APPUNTAMENTO__c=fr.ORARIO_APPUNTAMENTO,
                      EOF_Richiesta_Notifica__c = copy_request(fr)                                
              );   
              //lego il case se esiste
              if(fr.TIPO_COMUNICAZIONE!='1' && fr.TIPO_COMUNICAZIONE!='11'){
                List<Case> cList = [SELECT Id FROM Case Where  EOF_Codice_Ordine_OLO__c =: fr.CODICE_ORDINE_OLO and RecordType.DeveloperName ='EOF_Caso_Attivazione'];
                if(!cList.isEmpty()){
                  sl.caso__c=cList[0].Id;
                  sl.EOF_COdice_ordine_EOF__C=cList[0].Id;
                }
              }
              return sl;
      }
      
      
      //*********old system
        /*
        if(o instanceof EOF_GW_WS_Request.FiberRequest){
                EOF_GW_WS_Request.FiberRequest fr = (EOF_GW_WS_Request.FiberRequest) o;
                RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'FiberRequest'];
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = rt.id,
                    EOF_Codice_Ordine_OLO__c = fr.CODICE_ORDINE_OLO,                    
                    EOF_Codice_Operatore__c = fr.CODICE_OPERATORE,
                    EOF_Tipo_Comunicazione__c = fr.TIPO_COMUNICAZIONE,                
                    EOF_ID_Notifica__c = fr.ID_NOTIFICA,
                    EOF_Data_Notifica__c = OM_GW_GE_Utils.StringToDate(fr.DATA_NOTIFICA),
                    EOF_Richiesta_Notifica__c = copy_request(fr)          
            );  
            return sl;
        }
        */
        if(o instanceof Map<String, String>){
            
            if(((Map<String, String>) o).get('Type') == 'ACK'){
                    RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'ACK' LIMIT 1];
                    EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                        RecordTypeId = rt.id,
                        Caso__c = ((Map<String, String>) o).get('Caso'),
                        EOF_Stato_Richiesta__c = 'OK',
                        EOF_Codice_Ordine_OLO__c = ((Map<String, String>) o).get('Codice_ordine_OLO'),
                        EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
                        EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                        EOF_Richiesta_Notifica__c = 'Esito: OK',
                        EOF_Tipo_Comunicazione_String__c = ((Map<String, String>) o).get('Tipo Comunicazione'),
                        //aggiungo sl di riferimento
                        EOF_SL_Riferimento__c= ((Map<String, String>) o).get('SL Riferimento'),
                        EOF_Data_Notifica__c = system.now()       
                );
                return sl;
            }
            if(((Map<String, String>) o).get('Type') == 'NACK'){
                    RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'NACK' LIMIT 1];
                    EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                        RecordTypeId = rt.id,
                        EOF_Stato_Richiesta__c = 'KO',
                        EOF_Codice_Errore__c = ((Map<String, String>) o).get('Codice_errore'),
                        EOF_Causale_Errore__c = ((Map<String, String>) o).get('Causale_errore'),
                        EOF_Codice_Ordine_OLO__c = ((Map<String, String>) o).get('Codice_ordine_OLO'),
                        EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
                        EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                        EOF_Richiesta_Notifica__c = 'Esito: KO' + '\n' + 'Codice errore: ' +  ((Map<String, String>) o).get('Codice_errore') + '\n' +
                                                    'Causale errore: ' + ((Map<String, String>) o).get('Causale_errore'),                 
                        EOF_Tipo_Comunicazione_String__c = ((Map<String, String>) o).get('Tipo Comunicazione'),
                        //aggiungo sl di riferimento
                        EOF_SL_Riferimento__c= ((Map<String, String>) o).get('SL Riferimento'),
                        EOF_Data_Notifica__c = system.now()       
                );
                return sl;
            }
                      
        }
        
        if(o instanceof EOF_Notify__C){
	        	EOF_Notify__c n = (EOF_Notify__c)o;
	        	String esito='';
	        	if((n.EOF_Tipo_Comunicazione_ctrl__c=='5' || n.EOF_Tipo_Comunicazione_ctrl__c=='6' || n.EOF_Tipo_Comunicazione_ctrl__c=='7' || n.EOF_Tipo_Comunicazione_ctrl__c=='12') && n.EOF_Stato_Richiesta__c=='KO'){
	        		esito=' KO';
	        	}
	        	
		        	EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
	                    RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberNotify').getRecordTypeId(),
	                    EOF_Codice_Operatore__c = n.EOF_Codice_Operatore__c,
						EOF_TIpo_comunicazione_String__c='SF->OLO - FiberNotify - '+retSpec(n.EOF_Tipo_Comunicazione_ctrl__c)+esito,
	                    EOF_Tipo_Comunicazione__c = n.EOF_Tipo_Comunicazione_ctrl__c,
	                    EOF_COdice_Ordine_olo__c=n.EOF_Codice_Ordine_olo__c,
	                    EOF_Codice_Ordine_EOF__c = n.EOF_Codice_Ordine_EOF__c,     
	                    EOF_ID_Notifica__c = n.EOF_Id_Notifica__c,
	                    EOF_Stato_Richiesta__c=n.EOF_Stato_Richiesta__c,
	                    EOF_GPON_Attestazione__c=n.EOF_GPON_Attestazione__c,
	                    EOF_Cod_Rifiuto_Sospensione_Annullamento__c=n.Codice_Rifiuto_Sospensione_Annullamento__c,
                        EOF_Mot_Rifiuto_Sospensione_Annullamento__c=n.Motivo_Rifiuto_Sospensione_Annullamento__c,
                        EOF_Data_Espletamento_Ordine__c=n.EOF_Data_Espletamento_Ordine__c,
                        EOF_ID_Risorsa__c=n.EOF_ID_Risorsa__c, 
	                    EOF_Data_Notifica__c = n.EOF_Data_Notifica__c,
	                    EOF_Apparato__c=n.EOF_ID_Apparato_Consegnato__c,
	                    EOF_Esito_Consegna_Apparato__c=n.EOF_Esito_Consegna_Apparato__c,
	                    EOF_Parametri_Trasmissivi_Ottici__c=n.EOF_Parametri_Trasmissivi_Ottici__c,
	                    EOF_Posizione_Splitter_Secondario__c=n.EOF_Posizione_Splitter_Secondario__c,
	                    EOF_Nuova_DAC__c=n.EOF_Nuova_Dac__c,
	                    EOF_Codice_Motivazione_Rimodulazione__c=n.EOF_CODICE_MOTIVAZIONE_RIMODULAZIONE__c,
	                    EOF_Motivazione_Rimodulazione__c=n.EOF_Reason_RImodulazione_DAC__c,
	                    EOF_Note__c=n.EOF_Note__c,
	                    EOF_FLag_Pagamento__c=n.Flag_Pagamento__c,
	                    EOF_Numero_Operatore__c=n.Numero_Operatore__c,                        
                        Notify__c=n.Id,
                                                
                        EOF_Richiesta_Notifica__c=copy_Notify(n)
		            ); 
		        if(String.isNotBlank(n.Caso__c)){
		        	sl.Caso__c=n.Caso__c;
		        } 
		        return sl;
		        
	           
	        }  
                
        if(o instanceof Case){
            
                Case c = (Case) o;
                RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'FiberRequest'];
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordType = rt,
                    EOF_Tipo_Comunicazione__c = c.type,     
                    EOF_ID_Notifica__c = c.EOF_Id_Notifica__c,
                    EOF_Data_Notifica__c = c.EOF_Data_Notifica__c
            );
            return sl;
        }
     
        return null;
    }
    
     
    //Auxiliar method to copy FR into the FR Service Log
    public static String copy_request(EOF_GW_WS_Request.FiberRequest fr){
        String s;
        String data_prevista_attivazione=''; 
        if(String.isNotBlank(fr.DATA_PREVISTA_ATTIVAZIONE)){
        	
        	data_prevista_attivazione=fr.DATA_PREVISTA_ATTIVAZIONE.left(10);
        }
        
        s =   'TIPO_COMUNICAZIONE: ' + fr.TIPO_COMUNICAZIONE + '\n' +
              'CODICE_OPERATORE: '+ fr.CODICE_OPERATORE + '\n' +
              'CODICE_ORDINE_OLO: '+ fr.CODICE_ORDINE_OLO + '\n' +
              'DATA_NOTIFICA: '+ fr.DATA_NOTIFICA + '\n' +
              'ID_NOTIFICA: '+ fr.ID_NOTIFICA + '\n' +
              'IDENTIFICATIVO_DEL_POP: '+ fr.IDENTIFICATIVO_DEL_POP + '\n' +
              'GPON_ATTESTAZIONE: '+ fr.GPON_ATTESTAZIONE + '\n' +
              'GPON_VINCOLANTE: '+ fr.GPON_VINCOLANTE + '\n' +
              'ID_RISORSA: '+ fr.ID_RISORSA + '\n' +
              'NOME_CLIENTE: '+ fr.NOME_CLIENTE + '\n' +
              'COGNOME_CLIENTE: '+ fr.COGNOME_CLIENTE + '\n' +
              'RECAPITO_TELEFONICO_CLIENTE_1: '+ fr.RECAPITO_TELEFONICO_CLIENTE_1 + '\n' +
              'RECAPITO_TELEFONICO_CLIENTE_2: '+ fr.RECAPITO_TELEFONICO_CLIENTE_2 + '\n' +
              'PROVINCIA: '+ fr.PROVINCIA + '\n' +
              'COMUNE: '+ fr.COMUNE + '\n' +
              'PARTICELLA_TOPONOMASTICA: '+ fr.PARTICELLA_TOPONOMASTICA + '\n' +
              'INDIRIZZO: '+ fr.INDIRIZZO + '\n' +
              'NUMERO_CIVICO: '+ fr.NUMERO_CIVICO + '\n' +
              'ID_BUILDING: '+ fr.ID_BUILDING + '\n' +
              'SCALA_PALAZZINA: '+ fr.SCALA_PALAZZINA + '\n' +
              'NOME_REFERENTE_TECNICO_OLO: '+ fr.NOME_REFERENTE_TECNICO_OLO + '\n' +
              'COGNOME_REFERENTE_TECNICO_OLO: '+ fr.COGNOME_REFERENTE_TECNICO_OLO + '\n' +
              'TELEFONO_REFERENTE_TECNICO_OLO: '+ fr.TELEFONO_REFERENTE_TECNICO_OLO + '\n' +
              'EMAIL_REFERENTE_TECNICO_OLO: '+ fr.EMAIL_REFERENTE_TECNICO_OLO + '\n' +
              'RECAPITO_TEST_LINEA: '+ fr.RECAPITO_TEST_LINEA + '\n' +
              'NUMERO_TELEFONICO_PRINCIPALE_LINEA: '+ fr.NUMERO_TELEFONICO_PRINCIPALE_LINEA + '\n' +
              'PASSWORD_APPARATO: '+ fr.PASSWORD_APPARATO + '\n' +
              'TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH: '+ fr.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH + '\n' +
              'OPZIONE_SYSTEM_UNICO: '+ fr.OPZIONE_SYSTEM_UNICO + '\n' +
              'DATA_PREVISTA_ATTIVAZIONE: '+ data_prevista_attivazione + '\n' +
              'ORARIO_APPUNTAMENTO: '+ fr.ORARIO_APPUNTAMENTO + '\n' +
              'CAUSALE_RICHIESTA_ANNULLAMENTO: '+ fr.CAUSALE_RICHIESTA_ANNULLAMENTO + '\n' +
              'CODICE_RICHIESTA_ANNULLAMENTO: '+ fr.CODICE_RICHIESTA_ANNULLAMENTO + '\n' +
              'APPARATO: '+ fr.APPARATO + '\n' +
              'TIPOLOGIA_APPARATO: '+ fr.TIPOLOGIA_APPARATO + '\n' +
              'PROGETTO_SPECIALE: '+ fr.PROGETTO_SPECIALE + '\n' +
              'COLLEGAMENTO_P2P: '+ fr.COLLEGAMENTO_P2P + '\n' +
              'NOTE: '+ fr.NOTE + '\n' +
              'TIPOLOGIA_SERVIZIO: '+ fr.TIPOLOGIA_SERVIZIO + '\n' +
              'SLA_PREMIUM_ASSURANCE: '+ fr.SLA_PREMIUM_ASSURANCE + '\n' ;
        
        system.debug('La richiesta Notifica è: '+s);
        return s;
    }
    
    //Auxiliar method to copy Notify into the Notify Service Log
    public static String copy_notify(EOF_Notify__c n){
        String s;
        
          Integer offset = UserInfo.getTimeZone().getOffset(system.now())/3600000;
      String prefix = (offset >= 0) ? '+'  : '-';
      String a = prefix + ((Math.abs(offset) < 10) ? ('0'+ Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));  
        
          String nuova_DAC = '';
          String orario_DAC = '';
            if(n.RecordType.Name == 'Notifica di rimodulazione DAC'){                
                if(!String.isBlank(n.EOF_Orario_DAC__c) && n.EOF_Orario_DAC__c.contains('-'))
                    orario_DAC = n.EOF_Orario_DAC__c.substring(0,5);
                else if(!String.isBlank(n.EOF_Orario_DAC__c))
                    orario_DAC = n.EOF_Orario_DAC__c;
                else
                    orario_DAC = '00:00';
                if(!String.isBlank(String.valueOf(n.EOF_Nuova_DAC__c)))
                    nuova_DAC = String.valueOf(n.EOF_Nuova_DAC__c).substring(0,10);
            }
          String orario_nuova_DAC;
          if(nuova_DAC == '')
                orario_nuova_DAC = null;
          else
                orario_nuova_DAC = nuova_DAC + ' ' + orario_DAC;
                 
        s = 'CODICE_OPERATORE :' + n.EOF_Codice_Operatore__c + '\n' +            
            'TIPO_COMUNICAZIONE :' + n.EOF_Tipo_Comunicazione_ctrl__c + '\n' + 
            'CODICE_ORDINE_OLO :' + n.EOF_Codice_Ordine_OLO__c + '\n' +
            'CODICE_ORDINE_EOF :' + n.EOF_Codice_Ordine_EOF__c + '\n' +
            'ID_NOTIFICA :' + n.EOF_ID_Notifica__c + '\n' +
            'STATO_RICHIESTA :' + n.EOF_Stato_Richiesta_ctrl__c + '\n' +
            'GPON_DI_ATTESTAZIONE :' + n.EOF_GPON_Attestazione__c + '\n' +
            'CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO :' + n.Codice_Rifiuto_Sospensione_Annullamento__c + '\n' + 
            'MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO :' + n.Motivo_Rifiuto_Sospensione_Annullamento__c + '\n' +
            'DATA_ESPLETAMENTO_ORDINE :' + n.EOF_Data_Espletamento_Ordine__c + '\n' +
            'ID_RISORSA :' + n.EOF_ID_Risorsa__c + '\n' +           
            'DATA_NOTIFICA :' + n.EOF_Data_Notifica__c.format('yyyy-MM-dd\'T\'HH:mm:ss\''+a+'\'') + '\n' +
            'ID_APPARATO_CONSEGNATO :' + n.EOF_ID_Apparato_Consegnato__c + '\n' +
            'ESITO_CONSEGNA_APPARATO :' + n.EOF_Esito_Consegna_Apparato_ctrl__c+ '\n' +
            'PARAMETRI_TRASMISSIVI_OTTICI :'  + n.EOF_Parametri_Trasmissivi_Ottici__c + '\n' +
            'ID_SPLITTER_SECONDARIO :' + n.EOF_ID_Splitter_Secondario__c + '\n' +
            'POSIZIONE_SPLITTER_SECONDARIO :' + n.EOF_Posizione_Splitter_Secondario__c + '\n' +
            'NUOVA DAC :' + orario_nuova_DAC + '\n' +
            'CODICE_MOTIVAZIONE_RIMODULAZIONE :' + n.EOF_Codice_Motivazione_Rimodulazione__c + '\n' +
            'REASON_RIMODULAZIONE :' + n.EOF_Reason_Rimodulazione_DAC__c + '\n' +
            'NOTE :' + n.EOF_Note__c  + '\n' +
            'FLAG_PAGAMENTO :' + n.Flag_Pagamento__c  + '\n' +
            'NUMERO OPERATORE :' + n.Numero_Operatore__c + '\n';
        
        return s;
    }
    
    public static void updateFiberNotify(EOF_Notify__c notifyRec){
      
      String recTypeName = EOF_Notify__c.SObjectType.getDescribe().getRecordTypeInfosById().get(notifyRec.RecordTypeId).getName();
      
      if(recTypeName ==  'Notifica di accettazione' || recTypeName == 'Notifica di accettazione KO'){        
        notifyRec.EOF_Data_Espletamento_Ordine__c = null;
        notifyRec.EOF_ID_Risorsa__c = '';
        notifyRec.EOF_ID_Apparato_Consegnato__c = '';
        notifyRec.EOF_Esito_Consegna_Apparato__c = '';  
        notifyRec.EOF_Parametri_Trasmissivi_Ottici__c = '';
        notifyRec.EOF_ID_Splitter_Secondario__c = '';
        notifyRec.EOF_Posizione_Splitter_Secondario__c = '';
        notifyRec.EOF_Nuova_DAC__c = null;
        notifyRec.EOF_Reason_Rimodulazione_DAC__c = '';
        notifyRec.Flag_Pagamento__c = '';
        notifyRec.Numero_Operatore__c = '';
        if(notifyRec.EOF_Stato_Richiesta_ctrl__c!= '1') {
            notifyRec.Motivo_Rifiuto_Sospensione_Annullamento__c = '';
          }       
        }
      
      if(recTypeName ==  'Notifica di acquisizione'){       
        notifyRec.EOF_Data_Espletamento_Ordine__c = null;
        notifyRec.EOF_ID_Risorsa__c = '';
        notifyRec.EOF_ID_Apparato_Consegnato__c = '';
        notifyRec.EOF_Esito_Consegna_Apparato__c = '';  
        notifyRec.EOF_Parametri_Trasmissivi_Ottici__c = '';
        notifyRec.EOF_ID_Splitter_Secondario__c = '';
        notifyRec.EOF_Posizione_Splitter_Secondario__c = '';
        notifyRec.EOF_Nuova_DAC__c = null;
        notifyRec.EOF_Reason_Rimodulazione_DAC__c = '';
        notifyRec.Flag_Pagamento__c = '';
        notifyRec.Numero_Operatore__c = '';
          
        if(notifyRec.EOF_Stato_Richiesta_ctrl__c!= '1') {
            notifyRec.Motivo_Rifiuto_Sospensione_Annullamento__c = '';
          }
      }
      
       if(recTypeName ==  'Notifica di espletamento' || recTypeName ==  'Notifica di espletamento KO'){       
        notifyRec.EOF_Nuova_DAC__c = null;
        notifyRec.EOF_Reason_Rimodulazione_DAC__c = '';
        
        if(notifyRec.EOF_Stato_Richiesta_ctrl__c!= '1') {
            notifyRec.Motivo_Rifiuto_Sospensione_Annullamento__c = '';
        }
           
        if(notifyRec.EOF_Stato_Richiesta_ctrl__c!= '0'){
            notifyRec.EOF_ID_Risorsa__c = '';
            notifyRec.EOF_Parametri_Trasmissivi_Ottici__c = '';
            notifyRec.EOF_ID_Splitter_Secondario__c = '';
            notifyRec.EOF_Posizione_Splitter_Secondario__c = '';
            notifyRec.EOF_Esito_Consegna_Apparato__c = ''; 
          }
       } 
      
       if(recTypeName == 'Notifica di rimodulazione DAC'){
         notifyRec.EOF_Stato_Richiesta__c = '';
         notifyRec.EOF_GPON_Attestazione__c = '';
         notifyRec.Motivo_Rifiuto_Sospensione_Annullamento__c = '';
         notifyRec.EOF_Data_Espletamento_Ordine__c = null;
         notifyRec.EOF_ID_Risorsa__c = '';
         notifyRec.EOF_ID_Apparato_Consegnato__c = '';
         notifyRec.EOF_Esito_Consegna_Apparato__c = '';
         notifyRec.EOF_Parametri_Trasmissivi_Ottici__c = '';
         notifyRec.EOF_ID_Splitter_Secondario__c = '';
         notifyRec.EOF_Posizione_Splitter_Secondario__c = '';
         notifyRec.Flag_Pagamento__c = '';
         notifyRec.Numero_Operatore__c = '';
     }   
     
       if(recTypeName == 'Notifica di sospensione'){
         notifyRec.EOF_Stato_Richiesta__c = '';
         notifyRec.EOF_GPON_Attestazione__c = '';
         notifyRec.EOF_Data_Espletamento_Ordine__c = null;
         notifyRec.EOF_ID_Risorsa__c = '';
         notifyRec.EOF_ID_Apparato_Consegnato__c = '';
         notifyRec.EOF_Esito_Consegna_Apparato__c = '';
         notifyRec.EOF_Parametri_Trasmissivi_Ottici__c = '';
         notifyRec.EOF_ID_Splitter_Secondario__c = '';
         notifyRec.EOF_Posizione_Splitter_Secondario__c = '';
         notifyRec.EOF_Nuova_DAC__c = null;
         notifyRec.EOF_Reason_Rimodulazione_DAC__c = '';
         notifyRec.Flag_Pagamento__c = '';
         notifyRec.Numero_Operatore__c = '';
     }
     
       if(recTypeName == 'Notifica di desospensione'){
         notifyRec.EOF_Stato_Richiesta__c = '';
         notifyRec.EOF_GPON_Attestazione__c = '';
         notifyRec.Motivo_Rifiuto_Sospensione_Annullamento__c = '';
         notifyRec.EOF_Data_Espletamento_Ordine__c = null;
         notifyRec.EOF_ID_Risorsa__c = '';
         notifyRec.EOF_ID_Apparato_Consegnato__c = '';
         notifyRec.EOF_Esito_Consegna_Apparato__c = '';
         notifyRec.EOF_Parametri_Trasmissivi_Ottici__c = '';
         notifyRec.EOF_ID_Splitter_Secondario__c = '';
         notifyRec.EOF_Posizione_Splitter_Secondario__c = '';
         notifyRec.EOF_Nuova_DAC__c = null;
         notifyRec.EOF_Reason_Rimodulazione_DAC__c = '';
         notifyRec.Flag_Pagamento__c = '';
         notifyRec.Numero_Operatore__c = '';
         system.debug('sospen--'+ notifyRec.EOF_Stato_Richiesta__c );
     }   
     
       if(recTypeName ==  'Notifica di cessazione' || recTypeName ==  'Notifica di cessazione KO'){
            system.debug('inside notifica---');
            notifyRec.EOF_GPON_Attestazione__c = '';
            notifyRec.EOF_Data_Espletamento_Ordine__c = null;
            notifyRec.EOF_ID_Risorsa__c = '';
            notifyRec.EOF_ID_Apparato_Consegnato__c = '';
            notifyRec.EOF_Esito_Consegna_Apparato__c = '';  
            notifyRec.EOF_Parametri_Trasmissivi_Ottici__c = '';
            notifyRec.EOF_ID_Splitter_Secondario__c = '';
            notifyRec.EOF_Posizione_Splitter_Secondario__c = '';
            notifyRec.EOF_Nuova_DAC__c = null;
            notifyRec.EOF_Reason_Rimodulazione_DAC__c = '';
            notifyRec.Flag_Pagamento__c = '';
            notifyRec.Numero_Operatore__c = '';
            if(notifyRec.EOF_Stato_Richiesta_ctrl__c!= '1') {
                notifyRec.Motivo_Rifiuto_Sospensione_Annullamento__c = '';
            }       
        }  
      
       if(recTypeName == 'Notifica di annullamento'){
         notifyRec.EOF_Stato_Richiesta__c = '';
         notifyRec.EOF_GPON_Attestazione__c = '';
         notifyRec.EOF_Data_Espletamento_Ordine__c = null;
         notifyRec.EOF_ID_Risorsa__c = '';
         notifyRec.EOF_ID_Apparato_Consegnato__c = '';
         notifyRec.EOF_Esito_Consegna_Apparato__c = '';
         notifyRec.EOF_Parametri_Trasmissivi_Ottici__c = '';
         notifyRec.EOF_ID_Splitter_Secondario__c = '';
         notifyRec.EOF_Posizione_Splitter_Secondario__c = '';
         notifyRec.EOF_Nuova_DAC__c = null;
         notifyRec.EOF_Reason_Rimodulazione_DAC__c = '';
         notifyRec.Flag_Pagamento__c = '';
         notifyRec.Numero_Operatore__c = '';
       }      
  }  
  public static String dateToString(datetime dt){
        if(String.isBlank(String.valueOf(dt))){
            return null;
        }
        Integer offset = UserInfo.getTimeZone().getOffset(System.now())/3600000;
        String prefix = (offset >= 0) ? '+'  : '-';
        String a = prefix + ((Math.abs(offset) < 10) ? ('0'+ Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));
        String s = dt.format('yyyy-MM-dd\'T\'HH:mm:ss\''+a+'\'');
        return s;
    }
    public static String dateToStringNoTime(date dt){
        String s='';
        if(!String.isBlank(String.valueOf(dt))){
          s=String.valueOf(dt).left(10);
        }
        return s;
    }

    public static Datetime stringToDate(String s){
        if(String.isBlank(s)){
            return null;
        }
        Datetime dt = Datetime.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)),integer.valueOf(s.left(13).right(2)),integer.valueOf(s.left(16).right(2)),integer.valueOf(s.left(19).right(2)));
        return dt;
    }
    public static Date stringToDateNoTime(String s){
        if(String.isBlank(s)){
            return null;
        }
        Date dt = Date.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)));
        return dt;
    }   
    public static String retCodOp (EOF_GW_WS_Request.fiberRequest fr){
    	String s='';
	                if (fr.tipo_comunicazione=='1'){
	                	s='Attivazione';
	                } 
	                if (fr.tipo_comunicazione=='11'){
	                	s='Cessazione';
	                }
	                if (fr.tipo_comunicazione=='99'){
	                	s='Attivazione KO';
	                } 
	                if (fr.tipo_comunicazione=='98'){
	                	s='Cessazione KO';
	                }  
	                if (fr.tipo_comunicazione=='2'){
	                	s='Rimodulazione DAC';
	                } 
	                if (fr.tipo_comunicazione=='3'){
	                	s='Desospensione';
	                }     
	                if (fr.tipo_comunicazione=='4'){
	                	s='Annullamento';
	                }   
	                return s;
    } 
    public static String retSpec (string fn){
    	String s='';
    	if (fn=='5'){
	    	s='Acquisizione';
	    }
	    if (fn=='6'){
	    	s='Accettazione';
	    } 
	    if (fn=='7'){
	    	s='Espletamento';
	    } 
	    if (fn=='8'){
	    	s='Rimodulazione DAC';
	    } 
	    if (fn=='9'){
	    	s='Sospensione';
	    }     
	    if (fn=='10'){
	    	s='Desospensione';
	    }   
	    if (fn=='12'){
	    	s='Cessazione';
	    } 
	    if (fn=='13'){
	    	s='Annullamento';
	    }
	    return s;
    }
}
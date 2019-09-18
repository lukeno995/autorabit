public class OM_GW_GE_Utils {	
    
    public static Case caseOriginale;
    public static boolean checkCaseOriginale=false;
    public static EOF_EAI_Service_Log__c slOrig;
    public static boolean checkslOrig=false;
    public static Account cliente;
    public static boolean checkCliente=false;
    public static Contact RefTec;    
    public static boolean checkRefTec=false;
    public static EOF_Notify__c notifica;
    public static EOF_EAI_Service_Log__c slSFOLO;
    public static EOF_EAI_Service_Log__c slSFOM;
    public static EOF_EAI_Service_Log__c slSFOLOResp;
    public static EOF_EAI_Service_Log__c slSFOMResp;
    public static String IDReferenceSl;  
    public static EOF_GW_WS_Request.returnFiberResponse res_temp; 
    public static OM_GW_WS_Notify.returnNotifyResponse res_temp_n;
    public static boolean checkRTMap = false;
    public static String assetComune;
    public static map<String,String> RTMap;
    public static List<Case> ListCaseAmmToUpdate;
    public static boolean checkCaseAmm=false;
    public static boolean retry=false;
    public static boolean retryToOLO=false;
    public static boolean retryToOM=false;
    public static boolean testNackTecnicoOLO=false;
    public static boolean testNackTecnicoOM=false;
    // 13/02/2018 MM : aggiunto timestamp da catturare
	public static TEMPLOG__c tpl;
	public static string OpName;
	public static double AttrTime;
	// 13/02/2018 MM : fine aggiunta    
	//AA - 28-01-2019 - Nuova gestione vendibilità richiesta da GB e CC
    public static List<OF_Vendibilita_Logger__c> vendLogLst;
	public static Boolean vendHasException = false;
	public static String vendException;
    //FINE AA 28-01-2019
     
    //Filling result with status, errorCode and errorDesc and generating NACK Service Logs 
    public static EOF_GW_WS_Request.returnFiberResponse syncError(Object o, String errorCode, String fieldName){
        
        List<String> result = new List<String>();
        res_temp = new EOF_GW_WS_Request.returnFiberResponse();
        res_temp.Esito = '';
        res_temp.CodiceErrore = '';
        res_temp.CausaleErrore = '';
        String errorDesc = '';
        
        if(errorCode == 'A_K5' || errorCode == 'A_K9'){
            errorDesc = 'Campo \''+ fieldName +'\' obbligatorio non valorizzato';
        }
        if(errorCode == 'A_K6' || errorCode == 'A_K10'){
            errorDesc = 'Valore campo \''+ fieldName + '\' non ammesso';
        } 
        if(errorCode == 'A_K7'){
            errorDesc = 'Codice Ordine OLO già presente';
        }
        if(errorCode == 'A_K3'){
        	errorDesc = 'Data Attesa Consegna non conforme agli SLA';
        }
        if(errorCode == 'A_K14'){
        	errorDesc = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
        }
        
        if(o instanceof EOF_GW_WS_Request.FiberRequest){
        	
            res_temp.Esito = '1';
            res_temp.CodiceErrore = errorCode;
            res_temp.CausaleErrore = errorDesc;
            Map<String,String> slMap = new Map<String,String>();
                slMap.put('Type' , 'NACK');
                slMap.put('Codice_errore' , errorCode);
                slMap.put('Causale_errore' , errorDesc);
                slMap.put('Codice_operatore' , ((EOF_GW_WS_Request.FiberRequest) o).CODICE_OPERATORE);
                slMap.put('Codice_ordine_OLO' , ((EOF_GW_WS_Request.FiberRequest) o).CODICE_ORDINE_OLO);
                slMap.put('ID_notifica' , ((EOF_GW_WS_Request.FiberRequest) o).ID_NOTIFICA);
                slMap.put('Tipo Comunicazione' , 'OLO->SF - NACK - FiberRequest - '+EOF_GW_GE_Utils.retCodOp((EOF_GW_WS_Request.FiberRequest) o));
                
            if(OM_GW_GE_Utils.checkslOrig){
            	//aggiungo il nack sull'originale
            	OM_GW_GE_Utils.slOrig.EOF_Response__c='NACK';
            
            	//inserisco il sl
            	OM_GW_GE_Utils.slOrig.EOF_Codice_Errore__c=res_temp.CodiceErrore;
            	OM_GW_GE_Utils.slOrig.EOF_Causale_Errore__c=res_temp.CausaleErrore;
            	insert OM_GW_GE_Utils.slOrig;
            	//aggiungo il riferimento sul nack
            	slMap.put('SL Riferimento' , OM_GW_GE_Utils.slOrig.Id);
            }
            //verifico se trovo il case a sistema lo lego al nack
        	if(OM_GW_GE_Utils.checkCaseOriginale){
        		slMap.put('Caso' , OM_GW_GE_Utils.caseOriginale.Id);
        	}    
            
            EOF_EAI_Service_Log__c slNACK = create_EAI_Log(slMap);
            insert slNACK;
        	}
                       
        return res_temp;
    }
    
    //metodo aggiunto 2017_09_23 per aggiungere la response sul sl di riferimento e creare il riferimento al record sull'ACK
    public static List<EOF_EAI_Service_Log__c> createACK(map<String,String> mapACK){
    	List<EOF_EAI_Service_Log__c> slListToUpsert = new List<EOF_EAI_Service_Log__c>();
        //verifico che l'id del sl originale sia popolato
        if(OM_GW_GE_Utils.checkslOrig){
        	OM_GW_GE_Utils.slOrig.EOF_Response__c='ACK';
        	slListToUpsert.add(OM_GW_GE_Utils.slOrig);
        }
        EOF_EAI_Service_Log__c slNACK = create_EAI_Log(mapACK);
        slListToUpsert.add(slNACK);
        return slListToUpsert;
    }

    //metodo per inserimento sl di riferimento e NACK in caso di notifica da OM
    public static OM_GW_WS_Notify.returnNotifyResponse syncErrorNotify(Object o, String errorCode, String fieldName){
        
        List<String> result = new List<String>();
        res_temp_n = new OM_GW_WS_Notify.returnNotifyResponse();
        res_temp_n.Esito = '';
        res_temp_n.CodiceErrore = '';
        res_temp_n.CausaleErrore = '';
        String errorDesc = '';
        
        if(errorCode == 'A_K5' || errorCode == 'A_K9')
            errorDesc = 'Campo \''+ fieldName +'\' obbligatorio non valorizzato';
        
        if(errorCode == 'A_K6' || errorCode == 'A_K10')
            errorDesc = 'Valore campo \''+ fieldName + '\' non ammesso';
         
        if(errorCode == 'A_K7')
            errorDesc = 'Codice Ordine OLO già presente';
        
        if(o instanceof OM_GW_WS_Notify.FiberNotify){

            //Generating FiberRequest Service Log 
            EOF_EAI_SErvice_Log__C slRiferimento = OM_GW_GE_Utils.create_EAI_Log((OM_GW_WS_Notify.FiberNotify) o);
            slRiferimento.EOF_REsponse__c='NACK';
            insert slRiferimento;
        
            res_temp_n.Esito = '1';
            res_temp_n.CodiceErrore = errorCode;
            res_temp_n.CausaleErrore = errorDesc;
            
            
            //aggiungere il tipo di comunicazione sul rela tivo campo
            EOF_EAI_SErvice_Log__C sl=
             OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'NACK',
            											 'Codice_errore' => errorCode,
                                                         'Causale_errore' => errorDesc,
                                                         'Codice_operatore' => ((OM_GW_WS_notify.fiberNotify) o).CODICE_OPERATORE,
                                                         'Codice_ordine_OLO' => ((OM_GW_WS_notify.fiberNotify) o).CODICE_ORDINE_OLO,
                                                         'ID_notifica' => ((OM_GW_WS_notify.fiberNotify) o).ID_NOTIFICA,
                                                         'Richiesta Notifica' => Copy_notify_om((OM_GW_WS_notify.fiberNotify) o),
                                                         'Tipo Comunicazione' => 'OM->SF - NACK - FiberNotify'+OM_GW_GE_Utils.retSpec((OM_GW_WS_Notify.FiberNotify) o),
                                                         'SL Riferimento' => slRiferimento.Id});
                                                         
         	OM_GW_WS_Notify.fibernotify fn=(OM_GW_WS_Notify.FiberNotify) o;
             //faccio la query per estrarre il case eventuale da aggiungere
            List<case> cList = [select Id,EOF_Codice_Operatore_WS__c from Case where EOF_Codice_Ordine_OLO__C=:fn.CODICE_ORDINE_OLO and Codice_Ordine_EOF__C=:fn.CODICE_ORDINE_EOF];
            if(!cList.isEmpty()){
            	sl.Caso__c=cList[0].Id;
            }
            insert sl;
        }         
        return res_temp_n;
    }
    
    public static EOF_Notify__c create_Notify(OM_GW_WS_Notify.FiberNotify fn, string caseId, string codiceOperatore){
    	EOF_Notify__c n = New EOF_Notify__c();
    	if(fn.TIPO_COMUNICAZIONE == '7'){
    		if(fn.STATO_RICHIESTA == '0'){
                n.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId();
            }
    		else{
                n.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento KO').getRecordTypeId();
            }
    	}
    	if(fn.TIPO_COMUNICAZIONE == '8'){
    		n.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di rimodulazione DAC').getRecordTypeId();
    	}
    	if(fn.TIPO_COMUNICAZIONE == '9'){
    		n.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di sospensione').getRecordTypeId();
    	}
    	if(fn.TIPO_COMUNICAZIONE == '10'){
    		n.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di desospensione').getRecordTypeId();
    	}
    	if(fn.TIPO_COMUNICAZIONE == '12'){
    		if(fn.STATO_RICHIESTA == '0'){
                n.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();
            }
    		else{
                n.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione KO').getRecordTypeId();
            }
    	}
    	if(fn.TIPO_COMUNICAZIONE == '13'){
    		n.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di annullamento').getRecordTypeId();
    	}

    	n.EOF_Codice_Operatore__c=codiceOperatore;
    	n.EOF_Codice_Ordine_EOF__c=fn.Codice_Ordine_EOF;
    	n.EOF_Id_Notifica__c=fn.ID_NOTIFICA;
    	n.EOF_Stato_Richiesta__c=fn.STATO_RICHIESTA;
    	n.EOF_GPON_Attestazione__c=fn.GPON_ATTESTAZIONE;
    	n.Motivo_Rifiuto_Sospensione_Annullamento__c=fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO;
    	n.EOF_Data_Espletamento_Ordine__c=StringToDateNoTime(fn.DATA_ESPLETAMENTO_Ordine);
    	n.EOF_ID_Risorsa__c=fn.ID_Risorsa;
    	n.EOF_Data_Notifica__c = StringToDate(fn.Data_Notifica);
    	n.EOF_ID_Apparato_Consegnato__c=fn.ID_APPARATO_CONSEGNATO;
    	n.EOF_Esito_Consegna_Apparato__c=fn.ESITO_CONSEGNA_APPARATO;
    	n.EOF_Parametri_Trasmissivi_Ottici__c=fn.PARAMETRI_TRASMISSIVI_OTTICI;
       	n.EOF_ID_Splitter_Secondario__c=fn.ID_SPLITTER_SECONDARIO;
        n.EOF_Posizione_Splitter_Secondario__c=fn.POSIZIONE_SPLITTER_SECONDARIO;
        n.EOF_Nuova_Dac__c=StringToDateNoTime(fn.NUOVA_DAC);
        n.EOF_Reason_Rimodulazione_DAC__c=fn.REASON_RIMODULAZIONE_CONFERMA_DAC;
        n.EOF_Note__c=fn.NOTE;
        n.Flag_Pagamento__c=fn.FLAG_PAGAMENTO;
        n.Numero_Operatore__c=fn.NUMERO_OPERATORE; 
        n.caso__c=caseId;   
    	 
 		return n;
    }
	
    //metodo usato per le notifiche da OM che hanno superato i controlli sincroni (non fanno inserimenti in quanto prima di callout sicnrona)
    public static EOF_EAI_Service_Log__c create_EAI_Log(Object o,String id,String CodiceOperatore){

		if(o instanceof OM_GW_WS_Notify.FiberNotify){
					OM_GW_WS_Notify.FiberNotify fn = (OM_GW_WS_Notify.FiberNotify) o;         
	                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
	                    RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberNotify').getRecordTypeId(),
	                    EOF_Tipo_Comunicazione__c = fn.TIPO_COMUNICAZIONE,
	                    EOF_Tipo_COmunicazione_String__c='SF->OLO - Fibernotify - '+OM_GW_GE_Utils.retSpec(fn),
	                    EOF_Codice_Operatore__c = CodiceOperatore,
	                    EOF_Codice_Ordine_OLO__c = fn.CODICE_ORDINE_OLO,
	                    EOF_Codice_Ordine_EOF__c=fn.CODICE_ORDINE_EOF,                    
	                    EOF_Data_Notifica__c = StringToDate(fn.DATA_NOTIFICA),
	                    EOF_ID_Notifica__c = fn.ID_NOTIFICA,
	                    EOF_Stato_Richiesta__c=fn.Stato_Richiesta,          
	                    EOF_GPON_Attestazione__c=fn.GPON_ATTESTAZIONE,
	                    EOF_Cod_Rifiuto_Sospensione_Annullamento__c=fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO,
	                    EOF_Mot_Rifiuto_Sospensione_Annullamento__c=fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO,
	                    EOF_Data_Espletamento_Ordine__c=StringToDateNoTime(fn.DATA_ESPLETAMENTO_ORDINE),
	                    EOF_ID_Risorsa__c=fn.ID_RISORSA,
	                    EOF_Apparato__c=fn.ID_APPARATO_CONSEGNATO,
	                    EOF_Esito_Consegna_Apparato__c=fn.ESITO_CONSEGNA_APPARATO,
	                    EOF_Parametri_Trasmissivi_Ottici__c=fn.PARAMETRI_TRASMISSIVI_OTTICI,
	                    // 03/10/2018 MM : aggiunta salvataggio campi id splitter secondario e posizione splitter secondario
	                    EOF_Posizione_Splitter_Secondario__c=fn.Posizione_Splitter_Secondario,
	                    EOF_ID_Splitter_Secondario__c = fn.ID_Splitter_Secondario,
	                    // 03/10/2018 MM : fine aggiunta
	                    //EOF_Nuova_DAC__c=StringToDateNoTime(fn.NUOVA_DAC),
	                    EOF_Codice_Motivazione_Rimodulazione__c=fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC,
	                    EOF_Motivazione_Rimodulazione__c=fn.REASON_RIMODULAZIONE_CONFERMA_DAC,
	                    EOF_FLag_Pagamento__c=fn.FLAG_PAGAMENTO,
	                    EOF_NUMERO_OPERATORE__c=fn.NUMERO_OPERATORE,
	                    Caso__c=id,
	                    EOF_Richiesta_Notifica__c = copy_notify_om(fn)

	            );
	            
	            // 20/02/2018 MM : limito la lunghezza del campo note se > 255 caratteri
	            if(string.isnotblank(fn.NOTE) && fn.NOTE !=null){
	            	sl.EOF_NOTE__c= fn.NOTE.abbreviate(255);
	            }
	            else{
	            	sl.EOF_NOTE__c = fn.NOTE;
	            }
	            // finisce qui
				
				try{
	                //2018-09-13 MM : modifica salvataggio NUOVA DAC; Adesso la splittiamo in EOF_Nuova_DAC__c e EOF_ORARIO_APPUNTAMENTO__c
	                if(string.isnotblank(fn.NUOVA_DAC) && fn.NUOVA_DAC != null){
	            		sl.EOF_Nuova_DAC__c=StringToDateNoTime(fn.NUOVA_DAC);
	            		sl.EOF_ORARIO_APPUNTAMENTO__c =StringToTimeNoDate (fn.NUOVA_DAC);
	            	}
				}catch(exception e){
					
        			OF_Utility.logMessageNew2('AggiornamentoLogPerData','E','OM_GW_GE_Utils','create_EAI_Log',0,e);
				
				}	            
	            // 2018-09-13 MM : fine modifica.
	            	            
	            return sl;         
			}
			if(o instanceof EOF_GW_WS_Request.FiberRequest){
	                EOF_GW_WS_Request.FiberRequest fr = (EOF_GW_WS_Request.FiberRequest) o;	
	                
	                Case c = [select id, CaseNumber, AccountId,EOF_Id_Risorsa__c, AssetId,EOF_GPON_Attestazione__c,EOF_Codice_Operatore_WS__c,EOF_Impresa__c,
                						EOF_Provincia_WS__c,EOF_Numero_Civico_WS__c,EOF_Comune_WS__c,EOF_Identificativo_del_POP__c, EOF_ID_Building_WS__c,EOF_Indirizzo_WS__c,
                						EOF_Particella_Toponomastica_WS__c, EOF_Scala_Palazzina_WS__c from Case where id =: id];
	                         
	                fr.PROVINCIA=c.EOF_Provincia_WS__c;
	                fr.COMUNE=c.EOF_Comune_WS__c;
	                fr.PARTICELLA_TOPONOMASTICA=c.EOF_Particella_Toponomastica_WS__c;
	                fr.INDIRIZZO=c.EOF_Indirizzo_WS__c;
	                fr.NUMERO_CIVICO=c.EOF_Numero_Civico_WS__c;


	                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
	                    RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId(),
	                    EOF_TIpo_comunicazione_String__c='OLO->SF - FiberRequest - '+retCodOp(fr),                      
	                    EOF_Tipo_Comunicazione__c = fr.TIPO_COMUNICAZIONE,
	                    EOF_Codice_Operatore__c = fr.CODICE_OPERATORE,
	                    EOF_Codice_Ordine_OLO__c = fr.CODICE_ORDINE_OLO,                    
	                    EOF_Data_Notifica__c = StringTODate(fr.DATA_NOTIFICA),
	                    EOF_Data_Notifica_String__c=fr.DATA_NOTIFICA,
	                    EOF_ID_Notifica__c = fr.ID_NOTIFICA,
	                    EOF_ID_Pop__c=c.EOF_Identificativo_del_POP__c,            
	                    EOF_GPON_Attestazione__c=fr.GPON_ATTESTAZIONE,
	                    EOF_GPON_Vincolante__c=fr.GPON_VINCOLANTE,
	                    EOF_ID_Risorsa__c=fr.ID_RISORSA,
	                    EOF_Nome_Cliente__c=fr.NOME_CLIENTE,
	                    EOF_COgnome_CLiente__c=fr.COGNOME_CLIENTE,
	                    EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=fr.RECAPITO_TELEFONICO_CLIENTE_1,
	                    EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=fr.RECAPITO_TELEFONICO_CLIENTE_2,
	                    EOF_PRovincia__c=c.EOF_Provincia_WS__c,
	                    EOF_COMUNE__c=c.EOF_Comune_WS__c,
	                    EOF_PARTICELLA_TOPONOMASTICA__c=c.EOF_Particella_Toponomastica_WS__c,
	                    EOF_INDIRIZZO__C=c.EOF_Indirizzo_WS__c,
	                    EOF_NUMERO_CIVICO__c=c.EOF_Numero_Civico_WS__c,
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
	                    EOF_TIPOLOGIA_SERVIZIO__c=fr.TIPOLOGIA_SERVIZIO,
	                    EOF_SLA_PREMIUM_ASSURANCE__c=fr.SLA_PREMIUM_ASSURANCE,
	                    EOF_ORARIO_APPUNTAMENTO__c=fr.ORARIO_APPUNTAMENTO,
	                    caso__c=c.Id,
	                    EOF_COdice_ordine_EOF__C=c.Id,
	                    EOF_Richiesta_Notifica__c = copy_request(fr)	                              
	            );  
	            
	            // 20/02/2018 MM : limito lunghezza campo note se > di 255 caratteri
	            if(string.isnotblank(fr.NOTE) && fr.NOTE!=null){
	            	sl.EOF_NOTE__c=fr.NOTE.abbreviate(255);
	            }
	            else{
	            	sl.EOF_NOTE__c = fr.NOTE;
	            }
	            // finisce qui
	            
	        return sl;
			}
			
			return null;
	  }
	  
	  //metodo di creazione del log di inoltro ad OM delle attivazioni OK/KO e cessazioni OK/KO
	public static EOF_EAI_Service_Log__c create_Log_Attivazione_cessazione_To_OM(EOF_EAI_Service_Log__c sl,Case c,string tipoCom, String tipoCOmString){
		OM_GW_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c(
	                    RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId(),
	                    eof_codice_operatore__c=sl.eof_codice_operatore__c,
	                    EOF_Tipo_Comunicazione__c = tipoCom,
	                    EOF_Tipo_COmunicazione_String__c=tipoCOmString,                      
	                    EOF_Codice_Ordine_OLO__c = sl.EOF_Codice_Ordine_OLO__c,                    
	                    EOF_Data_Notifica__c = system.now(),
	                    EOF_ID_Notifica__c = String.valueOf(system.now().gettime()),
	                    EOF_ID_Pop__c=sl.EOF_ID_Pop__c,            
	                    EOF_GPON_Attestazione__c=sl.EOF_GPON_Attestazione__c,
	                    EOF_GPON_Vincolante__c=sl.EOF_GPON_Vincolante__c,
	                    EOF_ID_Risorsa__c=sl.EOF_ID_Risorsa__c,
	                    EOF_Nome_Cliente__c=sl.EOF_Nome_Cliente__c,
	                    EOF_COgnome_CLiente__c=sl.EOF_COgnome_CLiente__c,
	                    EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
	                    EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
	                    EOF_PRovincia__c=c.EOF_Provincia_WS__c,
	                    EOF_COMUNE__c=c.EOF_Comune_WS__c,
	                    EOF_PARTICELLA_TOPONOMASTICA__c=c.EOF_Particella_Toponomastica_WS__c,
	                    EOF_INDIRIZZO__C=c.EOF_Indirizzo_WS__c,
	                    EOF_NUMERO_CIVICO__c=c.EOF_Numero_Civico_WS__c, 
	                    EOF_ID_BUILDING__c=sl.EOF_ID_BUILDING__c,
	                    EOF_SCALA_PALAZZINA__c=sl.EOF_SCALA_PALAZZINA__c,
	                    EOF_NOME_REFERENTE_TECNICO_OLO__c=sl.EOF_NOME_REFERENTE_TECNICO_OLO__c,
	                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c=sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
	                    EOF_TELEFONO_REFERENTE_TECNICO_OLO__c=sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
	                    EOF_EMAIL_REFERENTE_TECNICO_OLO__c=sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__c,
	                    EOF_RECAPITO_TEST_LINEA__c=sl.EOF_RECAPITO_TEST_LINEA__c,
	                    EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c=sl.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
	                    EOF_PASSWORD_APPARATO__c=sl.EOF_PASSWORD_APPARATO__c,
	                    EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c=sl.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
	                    EOF_OPZIONE_SYSTEM_UNICO__c=sl.EOF_OPZIONE_SYSTEM_UNICO__c,
	                    EOF_DATA_PREVISTA_ATTIVAZIONE__c=sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c,
	                    EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__C=sl.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__C,
	                    EOF_CODICE_RICHIESTA_ANNULLAMENTO__c=sl.EOF_CODICE_RICHIESTA_ANNULLAMENTO__c,
	                    EOF_APPARATO__c=sl.EOF_APPARATO__c,
	                    EOF_TIPOLOGIA_APPARATO__c=sl.EOF_TIPOLOGIA_APPARATO__c,
	                    EOF_PROGETTO_SPECIALE__c=sl.EOF_PROGETTO_SPECIALE__c,
	                    EOF_COLLEGAMENTO_P2P__c=sl.EOF_COLLEGAMENTO_P2P__c,
	                    EOF_NOTE__c=sl.EOF_NOTE__c,
	                    EOF_TIPOLOGIA_SERVIZIO__c=sl.EOF_TIPOLOGIA_SERVIZIO__c,
	                    EOF_SLA_PREMIUM_ASSURANCE__c=sl.EOF_SLA_PREMIUM_ASSURANCE__c,
	                    EOF_ORARIO_APPUNTAMENTO__c=sl.EOF_ORARIO_APPUNTAMENTO__c,
	                    caso__c=c.Id,
	                    EOF_COdice_ordine_EOF__C=c.COdice_ordine_EOF__C	 
	            );
	            //metto il comune in cessazione
	            if((tipoCom=='11' || tipoCom=='98') && !String.isblank(OM_GW_GE_Utils.assetComune)){
	            	OM_GW_GE_Utils.slSFOM.EOF_COMUNE__c=OM_GW_GE_Utils.assetComune;
	            }
	            OM_GW_GE_Utils.slSFOM.EOF_Richiesta_Notifica__c = copy_request(OM_GW_GE_Utils.slSFOM); 
	            return OM_GW_GE_Utils.slSFOM;
	}

    //Creating a different Service Log depending on object passed to the constructor -- General Purpose service Log
	  public static EOF_EAI_Service_Log__c create_EAI_Log(Object o){

			if(o instanceof OM_GW_WS_Notify.FiberNotify){
					OM_GW_WS_Notify.FiberNotify fn = (OM_GW_WS_Notify.FiberNotify) o;         
	                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
	                    RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OMNotify').getRecordTypeId(),
	                    EOF_Tipo_Comunicazione__c = fn.TIPO_COMUNICAZIONE,
	                    EOF_Tipo_COmunicazione_String__c='OM->SF - Fibernotify - '+OM_GW_GE_Utils.retSpec(fn),
	                    EOF_Codice_Operatore__c = fn.CODICE_OPERATORE,
	                    EOF_Codice_Ordine_OLO__c = fn.CODICE_ORDINE_OLO, 
	                    EOF_Codice_Ordine_EOF__c=fn.CODICE_ORDINE_EOF,                   
	                    EOF_Data_Notifica__c = StringToDate(fn.DATA_NOTIFICA),
	                    EOF_ID_Notifica__c = fn.ID_NOTIFICA,
	                    EOF_Stato_Richiesta__c=fn.Stato_Richiesta,          
	                    EOF_GPON_Attestazione__c=fn.GPON_ATTESTAZIONE,
	                    EOF_Cod_Rifiuto_Sospensione_Annullamento__c=fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO,
	                    EOF_Mot_Rifiuto_Sospensione_Annullamento__c=fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO,
	                    EOF_Data_Espletamento_Ordine__c=StringToDateNoTime(fn.DATA_ESPLETAMENTO_ORDINE),
	                    EOF_ID_Risorsa__c=fn.ID_RISORSA,
	                    EOF_Apparato__c=fn.ID_APPARATO_CONSEGNATO,
	                    EOF_Esito_Consegna_Apparato__c=fn.ESITO_CONSEGNA_APPARATO,
	                    EOF_Parametri_Trasmissivi_Ottici__c=fn.PARAMETRI_TRASMISSIVI_OTTICI,
	                   	// 03/10/2018 MM : aggiunta salvataggio campi id splitter secondario e posizione splitter secondario
	                    EOF_Posizione_Splitter_Secondario__c=fn.Posizione_Splitter_Secondario,
	                    EOF_ID_Splitter_Secondario__c = fn.ID_Splitter_Secondario,
	                    // 03/10/2018 MM : fine aggiunta
	                    //EOF_Nuova_DAC__c=StringToDateNoTime(fn.NUOVA_DAC),
	                    EOF_Codice_Motivazione_Rimodulazione__c=fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC,
	                    EOF_Motivazione_Rimodulazione__c=fn.REASON_RIMODULAZIONE_CONFERMA_DAC,
	                    EOF_FLag_Pagamento__c=fn.FLAG_PAGAMENTO,
	                    EOF_NUMERO_OPERATORE__c=fn.NUMERO_OPERATORE,
	                    EOF_Richiesta_Notifica__c = copy_notify_om(fn)
	            );
	            
	            List<Case> cList = [SELECT Id FROM Case Where  EOF_Codice_Ordine_OLO__c =: fn.CODICE_ORDINE_OLO and 
	            					Codice_Ordine_EOF__c =: fn.CODICE_ORDINE_EOF];
	            if(!cList.isEmpty()){
        			sl.caso__c=cList[0].Id;
        		}
        		
        		// 20/02/2018 MM : limito lunghezza campo note se > 255
        		if(string.isnotblank(fn.NOTE) && fn.NOTE!=null){
        			sl.EOF_NOTE__c=fn.NOTE.abbreviate(255);
        		}
        		else{
        			sl.EOF_NOTE__c = fn.NOTE;
        		}
        		// finisce qui
        		
        		// 2018-09-13 MM : aggiunta scrittura del campo EOF_ORARIO_APPUNTAMENTO__c ottenuto splittando il campo EOF_Nuova_DAC__c
        		try{
		    		if(string.isnotblank(fn.NUOVA_DAC) && fn.NUOVA_DAC!= null){
		    		
		    			sl.EOF_Nuova_DAC__c = StringToDateNoTime(fn.NUOVA_DAC);
		    			sl.EOF_ORARIO_APPUNTAMENTO__c = StringToTimeNoDate(fn.NUOVA_DAC);
		    		
		    		}
        		}catch(exception e){
        		
        			OF_Utility.logMessageNew2('AggiornamentoLogPerData','E','OM_GW_GE_Utils','create_EAI_Log',1,e);
        		
        		}
	            return sl;        
			}
	        if(o instanceof EOF_GW_WS_Request.FiberRequest){
	                EOF_GW_WS_Request.FiberRequest fr = (EOF_GW_WS_Request.FiberRequest) o;	
	                         
	                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
	                    RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId(),
	                    EOF_TIpo_comunicazione_String__c='OLO->SF - FiberRequest - '+retCodOp(fr),                      
	                    EOF_Tipo_Comunicazione__c = fr.TIPO_COMUNICAZIONE,
	                    EOF_Codice_Operatore__c = fr.CODICE_OPERATORE,
	                    EOF_Codice_Ordine_OLO__c = fr.CODICE_ORDINE_OLO,                    
	                    EOF_Data_Notifica_String__c=fr.DATA_NOTIFICA,
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
	            if(OM_GW_GE_Utils.checkDateTime(fr.DATA_NOTIFICA)){
	            	sl.EOF_Data_Notifica__c = StringTODate(fr.DATA_NOTIFICA);
	            }
	            if(OM_GW_GE_Utils.checkDate(fr.DATA_PREVISTA_ATTIVAZIONE)){
	            	sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c=StringTODateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE);
	            }
	            
	            //lego il case se esiste
	            List<Case> cList = [SELECT Id,EOF_Id_Notifica__c,status, EOF_Codice_Operatore_WS__c, EOF_GPON_Attestazione__c, PO_Comune__c, RecordTypeId,
	            					EOF_Id_Risorsa__c, EOF_Data_Notifica__c, EOF_Data_Prevista_Attivazione__c, EOF_Nuova_DAC__c,OF_SA_Codice_Motivazione__c, OF_SA_Motivazione__c,
	            					RecordType.DeveloperName,OF_Bonifica_Locked_Row__c,EOF_Pertinenza_RDAC__c, canModify__c, EOF_Codice_Ordine_OM__c,OF_SA_Promozione__c,
	            					EOF_Order_Manager__c, EOF_Codice_Ordine_OLO__c, EOF_Posizione_Splitter_Secondario__c, EOF_ID_Splitter_Secondario__c, OF_SA_CODICE_PROGETTO_SPECIALE__c,
									EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Cluster_Promozione__c,
									OF_Esito_Consegna_Apparato__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Istat_Comune__c, OF_SA_Profilo__c,
									EOF_Provincia_WS__c, EOF_Istat_Provincia__c, EOF_Indirizzo_WS__c, PO_Indirizzo_collegamento__c, PO_Civico__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c 
	            					FROM Case 
	            					Where  EOF_Codice_Ordine_OLO__c =: fr.CODICE_ORDINE_OLO 
	            					and RecordType.DeveloperName in('EOF_Caso_Attivazione','EOF_Caso_Cessazione')];
	            if(!cList.isEmpty()){
        			sl.caso__c=cList[0].Id;
        			sl.EOF_COdice_ordine_EOF__C=cList[0].Id;
        			OM_GW_GE_Utils.caseOriginale=cList[0];
        			OM_GW_GE_Utils.checkCaseOriginale=true;
        		}
        		
        		// 20/02/2018 MM : limito lunghezza campo note se > 255
        		if(string.isnotblank(fr.NOTE) && fr.NOTE!=null){
        			sl.EOF_NOTE__c= fr.NOTE.abbreviate(255);
        		}
        		else{
        			sl.EOF_NOTE__c = fr.NOTE;
        		}
        		// finisce qui 
	            return sl;
	        }        
	        
	        
	        if(o instanceof Map<String, String>){
	            if(((Map<String, String>) o).get('Type') == 'ACK'){	                    
	                    EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
	                        RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('ACK').getRecordTypeId(),
	                        Caso__c = ((Map<String, String>) o).get('Caso'),
	                        EOF_Stato_Richiesta__c = 'OK',
	                        EOF_Codice_Ordine_OLO__c = ((Map<String, String>) o).get('Codice_ordine_OLO'),
	                        EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
	                        EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
	                        EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('Richiesta Notifica'),  
	                        EOF_Tipo_Comunicazione_String__c = ((Map<String, String>) o).get('Tipo Comunicazione'),
	                        //aggiungo sl di riferimento
                        	EOF_SL_Riferimento__c= ((Map<String, String>) o).get('SL Riferimento'),
	                        EOF_Data_Notifica__c = system.now()       
	            	);
	            	return sl;
	        	}

	        	if(((Map<String, String>) o).get('Type') == 'NACK'){
	        		String s='';                    
	                    EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
	                        RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('NACK').getRecordTypeId(),
	                        EOF_Stato_Richiesta__c = 'KO',
	                        EOF_Codice_Errore__c = ((Map<String, String>) o).get('Codice_errore'),
	                        EOF_Causale_Errore__c = ((Map<String, String>) o).get('Causale_errore'),
	                        EOF_Codice_Ordine_OLO__c = ((Map<String, String>) o).get('Codice_ordine_OLO'),
	                        EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
	                        EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
	                        EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('Richiesta Notifica'),  
	                        EOF_Tipo_Comunicazione_String__c = ((Map<String, String>) o).get('Tipo Comunicazione'), 
	                        //aggiungo sl di riferimento
                        	EOF_SL_Riferimento__c= ((Map<String, String>) o).get('SL Riferimento'),                
	                        EOF_Data_Notifica__c = system.now()       
	            	);
	            	if(String.isNotBlank(((Map<String, String>) o).get('Caso'))){
	            		sl.Caso__c=((Map<String, String>) o).get('Caso');
	            	}
	            	return sl;
	        	}
	        }
	        
	        if(o instanceof EOF_Notify__C){
	        	EOF_Notify__c notify = (EOF_Notify__c)o;
	        	EOF_Notify__c n = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id, EOF_Orario_DAC__c,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
	        	
	        	EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberNotify').getRecordTypeId(),
                    EOF_TIpo_comunicazione_String__c='SF->OLO - FiberNotify - '+retSpec(notify.EOF_Tipo_Comunicazione_ctrl__c),
                    EOF_Codice_Operatore__c = n.EOF_Codice_Operatore__c,
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
	                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
	                    RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId(),
	                    EOF_Tipo_Comunicazione__c = c.type,     
	                    EOF_ID_Notifica__c = c.EOF_Id_Notifica__c,
	                    EOF_Data_Notifica__c = c.EOF_Data_Notifica__c
	            );
	            return sl;
	        }	     
	    	return null;
    } 
    
    //metodo di creazione del log di Acquisizione OK/KO e cessazione OK/KO
    public static EOF_EAI_Service_Log__c create_Log_Acquisizione_Cessazione_To_OLO(Case c,string statoReq){
    	EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
		sl.RecordTypeId = OM_GW_GE_Utils.RTMap.get('FiberNotify');
		sl.caso__c=c.Id;
		if(c.recordtype.developername=='EOF_Caso_Attivazione'){
			sl.EOF_Tipo_Comunicazione__c = '5';
		}
		else{
			sl.EOF_Tipo_Comunicazione__c = '12';
		}
		sl.EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c;
		sl.EOF_Codice_Ordine_OLO__c = c.EOF_CODICE_ORDINE_OLO__c; 
		sl.EOF_Codice_Ordine_EOF__c=c.Codice_Ordine_EOF__c;                   
		sl.EOF_Data_Notifica__c = system.now();
		sl.EOF_ID_Notifica__c = String.valueOf(system.now().gettime());
		if(statoReq=='OK'){
			sl.EOF_Stato_Richiesta__c='0';
			sl.EOF_Cod_Rifiuto_Sospensione_Annullamento__c='';
			sl.EOF_Mot_Rifiuto_Sospensione_Annullamento__c='';
		}
		else{
			sl.EOF_Stato_Richiesta__c='1';
			sl.EOF_Cod_Rifiuto_Sospensione_Annullamento__c=c.EOF_CODICE_Errore__c;
			sl.EOF_Mot_Rifiuto_Sospensione_Annullamento__c=c.EOF_causale_Errore__c;
		}          
		sl.EOF_Richiesta_Notifica__c = copy_notify_AcqCess(sl);	
		return sl; 
    }   
    
    
    public static String copy_notify_AcqCess(EOF_EAI_Service_Log__c sl){
    	String s =  'CODICE_OPERATORE: ' + sl.EOF_Codice_Operatore__c + '\n' +            
		            'TIPO_COMUNICAZIONE: ' + sl.EOF_Tipo_Comunicazione__c + '\n' + 
		            'CODICE_ORDINE_OLO: ' + sl.EOF_Codice_Ordine_OLO__c + '\n' +
		            'CODICE_ORDINE_EOF: ' + sl.EOF_Codice_Ordine_EOF__c + '\n' +
		            'ID_NOTIFICA: ' + sl.EOF_ID_Notifica__c + '\n' +
		            'STATO_RICHIESTA: ' + sl.EOF_Stato_Richiesta__c + '\n' +
		            'CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO: ' + sl.EOF_Cod_Rifiuto_Sospensione_Annullamento__c + '\n' + 
		            'MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO: ' + sl.EOF_Mot_Rifiuto_Sospensione_Annullamento__c + '\n' +         
		            'DATA_NOTIFICA: ' + OM_GW_GE_Utils.DateToString(sl.EOF_Data_Notifica__c) + '\n';
        return s;
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
              'DATA_PREVISTA_ATTIVAZIONE: '+ DATA_PREVISTA_ATTIVAZIONE + '\n' +
              'ORARIO_APPUNTAMENTO: '+ fr.ORARIO_APPUNTAMENTO + '\n'+
              'CAUSALE_RICHIESTA_ANNULLAMENTO: '+ fr.CAUSALE_RICHIESTA_ANNULLAMENTO + '\n' +
              'CODICE_RICHIESTA_ANNULLAMENTO: '+ fr.CODICE_RICHIESTA_ANNULLAMENTO + '\n' +
              'APPARATO: '+ fr.APPARATO + '\n' +
              'TIPOLOGIA_APPARATO: '+ fr.TIPOLOGIA_APPARATO + '\n' +
              'PROGETTO_SPECIALE: '+ fr.PROGETTO_SPECIALE + '\n' +
              'COLLEGAMENTO_P2P: '+ fr.COLLEGAMENTO_P2P + '\n' +
              'NOTE: '+ fr.NOTE + '\n' +
              'TIPOLOGIA_SERVIZIO: '+ fr.TIPOLOGIA_SERVIZIO + '\n' +
              'SLA_PREMIUM_ASSURANCE: '+ fr.SLA_PREMIUM_ASSURANCE + '\n' ; 
        
        return s;
    }
    
    //metodo per copiare la request di inoltro attivazione/cessazione da SF verso OM
    public static String copy_request(EOF_EAI_Service_Log__c sl){
	String s;
	
	s =   'TIPO_COMUNICAZIONE: ' + sl.EOF_TIPO_COMUNICAZIONE__C  + '\n' +
		  'CODICE_OPERATORE: '+ sl.EOF_CODICE_OPERATORE__C  + '\n' +
		  'CODICE_ORDINE_OLO: '+ sl.EOF_CODICE_ORDINE_OLO__C  + '\n' +
		  'DATA_NOTIFICA: '+ sl.EOF_DATA_NOTIFICA__C  + '\n' +
		  'ID_NOTIFICA: '+ sl.EOF_ID_NOTIFICA__C  + '\n' +
		  'IDENTIFICATIVO_DEL_POP: '+ sl.EOF_ID_POP__C  + '\n' +
		  'GPON_ATTESTAZIONE: '+ sl.EOF_GPON_ATTESTAZIONE__C  + '\n' +
		  'GPON_VINCOLANTE: '+ sl.EOF_GPON_VINCOLANTE__C  + '\n' +
		  'ID_RISORSA: '+ sl.EOF_ID_RISORSA__C  + '\n' +
		  'NOME_CLIENTE: '+ sl.EOF_NOME_CLIENTE__C  + '\n' +
		  'COGNOME_CLIENTE: '+ sl.EOF_COGNOME_CLIENTE__C  + '\n' +
		  'RECAPITO_TELEFONICO_CLIENTE_1: '+ sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__C  + '\n' +
		  'RECAPITO_TELEFONICO_CLIENTE_2: '+ sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__C  + '\n' +
		  'PROVINCIA: '+ sl.EOF_PROVINCIA__C  + '\n' +
		  'COMUNE: '+ sl.EOF_COMUNE__C  + '\n' +
		  'PARTICELLA_TOPONOMASTICA: '+ sl.EOF_PARTICELLA_TOPONOMASTICA__C  + '\n' +
		  'INDIRIZZO: '+ sl.EOF_INDIRIZZO__C  + '\n' +
		  'NUMERO_CIVICO: '+ sl.EOF_NUMERO_CIVICO__C  + '\n' +
		  'ID_BUILDING: '+ sl.EOF_ID_BUILDING__C  + '\n' +
		  'SCALA_PALAZZINA: '+ sl.EOF_SCALA_PALAZZINA__C  + '\n' +
		  'NOME_REFERENTE_TECNICO_OLO: '+ sl.EOF_NOME_REFERENTE_TECNICO_OLO__C  + '\n' +
		  'COGNOME_REFERENTE_TECNICO_OLO: '+ sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__C  + '\n' +
		  'TELEFONO_REFERENTE_TECNICO_OLO: '+ sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__C  + '\n' +
		  'EMAIL_REFERENTE_TECNICO_OLO: '+ sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__C  + '\n' +
		  'RECAPITO_TEST_LINEA: '+ sl.EOF_RECAPITO_TEST_LINEA__C  + '\n' + 
		  'NUMERO_TELEFONICO_PRINCIPALE_LINEA: '+ sl.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C  + '\n' +
		  'PASSWORD_APPARATO: '+ sl.EOF_PASSWORD_APPARATO__C  + '\n' +
		  'TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH: '+ sl.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c  + '\n' +
		  'OPZIONE_SYSTEM_UNICO: '+ sl.EOF_OPZIONE_SYSTEM_UNICO__C  + '\n' +
		  'DATA_PREVISTA_ATTIVAZIONE: '+ OM_GW_GE_Utils.DateToStringNotIme(sl.EOF_DATA_PREVISTA_ATTIVAZIONE__C)  + '\n' +
		  'ORARIO_APPUNTAMENTO: '+ sl.EOF_ORARIO_APPUNTAMENTO__C  + '\n'+
		  'CAUSALE_RICHIESTA_ANNULLAMENTO: '+ sl.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__C  + '\n' +
		  'CODICE_RICHIESTA_ANNULLAMENTO: '+ sl.EOF_CODICE_RICHIESTA_ANNULLAMENTO__C  + '\n' +
		  'APPARATO: '+ sl.EOF_APPARATO__C  + '\n' +
		  'TIPOLOGIA_APPARATO: '+ sl.EOF_TIPOLOGIA_APPARATO__C  + '\n' +
		  'PROGETTO_SPECIALE: '+ sl.EOF_PROGETTO_SPECIALE__C  + '\n' +
		  'COLLEGAMENTO_P2P: '+ sl.EOF_COLLEGAMENTO_P2P__C  + '\n' +
		  'NOTE: '+ sl.EOF_NOTE__C  + '\n' +
		  'TIPOLOGIA_SERVIZIO: '+ sl.EOF_TIPOLOGIA_SERVIZIO__C  + '\n' +
		  'SLA_PREMIUM_ASSURANCE: '+ sl.EOF_SLA_PREMIUM_ASSURANCE__C  + '\n' ;
	
		return s;
	}
    
    //Auxiliar method to copy Notify into the Notify Service Log
    public static String copy_notify(EOF_Notify__c n){
        String s;
        
        	//Setting the prefix for UTC time representation
        	Integer offset = UserInfo.getTimeZone().getOffset(system.now())/3600000;
			    String prefix = (offset >= 0) ? '+'  : '-';
			    String a = prefix + ((Math.abs(offset) < 10) ? ('0'+ Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));  
        
        	//Setting default DAC Time
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

    //Auxiliar method to copy FN into the FN Service Log
    public static String copy_notify_om(OM_GW_WS_Notify.FiberNotify fn){

        Map<String, Object > field_map = new Map<String, Object >{
            'TIPO_COMUNICAZIONE: ' => fn.TIPO_COMUNICAZIONE,
            'CODICE_OPERATORE: ' => fn.CODICE_OPERATORE,
            'CODICE_ORDINE_OLO: ' => fn.CODICE_ORDINE_OLO,
            'CODICE_ORDINE_EOF: ' => fn.CODICE_ORDINE_EOF,
            'CODICE_ORDINE_OM: ' => fn.CODICE_ORDINE_OM,
            'ID_NOTIFICA: ' => fn.ID_NOTIFICA,
            'STATO_RICHIESTA :' => fn.STATO_RICHIESTA,
            'GPON_DI_ATTESTAZIONE :' => fn.GPON_ATTESTAZIONE,
            'CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO :' => fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO,
            'MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO :' => fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO,
            'DATA_ESPLETAMENTO_ORDINE :' => fn.DATA_ESPLETAMENTO_ORDINE,
            'ID_RISORSA :' => fn.ID_RISORSA,
            'DATA_NOTIFICA :' => fn.DATA_NOTIFICA,
            'ID_APPARATO_CONSEGNATO :' => fn.ID_APPARATO_CONSEGNATO,
            'ESITO_CONSEGNA_APPARATO :' => fn.ESITO_CONSEGNA_APPARATO,
            'PARAMETRI_TRASMISSIVI_OTTICI :' => fn.PARAMETRI_TRASMISSIVI_OTTICI,
            'ID_SPLITTER_SECONDARIO :' => fn.ID_SPLITTER_SECONDARIO,
            'POSIZIONE_SPLITTER_SECONDARIO :' => fn.POSIZIONE_SPLITTER_SECONDARIO,
            'NUOVA DAC :' => fn.NUOVA_DAC,
            'CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC :' => fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC,
            'REASON_RIMODULAZIONE_CONFERMA_DAC :' => fn.REASON_RIMODULAZIONE_CONFERMA_DAC,
            'NOTE :' => fn.NOTE,
            'FLAG_PAGAMENTO :' => fn.FLAG_PAGAMENTO,
            'NUMERO OPERATORE :' => fn.NUMERO_OPERATORE,
            'SCALA :' => fn.SCALA,
            'PALAZZINA :' => fn.PALAZZINA,    
			'SCALA PALAZZINA :' => fn.ID_GIS_SCALA_PALAZZINA};
            return nullOrBlank(field_map);
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
    public static boolean checkDate(String S){
    	if(String.isBlank(s)){
    		return false;
    	}
    	try{
    		Date.valueOf(s);
    		if(s.split('-').get(0).isNumeric() && Integer.valueOf(s.split('-').get(0))<2016){
	          return false;
	        }
    	}
    	catch(Exception e){
    		return false;
    	}
        return true;
    }
    public static boolean checkTime(String tmp){
    	if(String.isBlank(tmp)){
    		return false;
    	}
    	try{
	        if(!tmp.split(':').get(0).isNumeric() || !tmp.split(':').get(1).isNumeric() || !tmp.split(':').get(2).isNumeric() ){
	          return false;
	        } 
	        if(tmp.split(':').get(0).length() != 2 || tmp.split(':').get(1).length() != 2 || tmp.split(':').get(2).length() != 2 ){
	          return false;
	        }                       
	        if(Integer.valueOf(tmp.split(':').get(0)) > 23 || Integer.valueOf(tmp.split(':').get(1)) > 59 || Integer.valueOf(tmp.split(':').get(2)) > 59 ){	
	          return false;
	        } 
	    }catch(Exception e){
	         return false;
	    }
	    return true;
    }
    public static boolean checkDateTime(String S){
    	if(String.isBlank(s)){    		
    		return false;
    	}
    	if(!OM_GW_GE_Utils.checkDate(s.left(10))){    	
    		return false;    		
    	}
    	if(!OM_GW_GE_Utils.checkTime(s.left(19).right(8))){    		
    		return false;    		
    	}
    	if(s.left(11).right(1)!='T'){    		
    		return false;    		
    	}
    	if(s.right(6)!='+01:00' && s.right(6)!='+02:00'){
    		return false;		
    	}
    	return true;
    }
    
    public static boolean checkEmail(String email){
    	if(String.isBlank(email)){
    		return false;
    	}
    	Boolean res = true;
		String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; // source: <a href="http://www.regular-expressions.info/email.html" target="_blank" rel="nofollow">http://www.regular-expressions.info/email.html</a>
		Pattern MyPattern = Pattern.compile(emailRegex);
		Matcher MyMatcher = MyPattern.matcher(email);
		if (!MyMatcher.matches()){ 
		    res = false;
		}
		return res;	
    }
    public static Date stringToDateNoTime(String s){
        if(String.isBlank(s)){
            return null;
        }
        Date dt = Date.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)));
        return dt;
    }
    
    // 2018-09-13 MM : aggiunto metodo per cattura dell'orario da una stringa formattata come un datetime
    public static String StringToTimeNoDate(String s){
        if(String.isBlank(s)){
            return null;
        }
		
		string st = s.left(13).right(2)+':'+s.left(16).right(2)+':'+s.left(19).right(2);
		
		return st;    
    }
    // 2018-09-13 MM : fine aggiunta.

    public static String nullOrBlank(Map<String, Object> field_map){
      String r = '';
      for(String s : field_map.keySet())
          r+= String.isBlank(String.valueOf(field_map.get(s))) ? '' : s + String.valueOf(field_map.get(s)) + '\n';
      return r;
    }
    
    //metodo che gestisce l'aggiornamento dei dati in caso di NACK da OLO su Acquisito OK/KO e Cessato KO
    public static void aggiornamentoDatiAcquisizione(String processo, String stato_Req, String esito){
    	list<Case> caseToUpdate = new list<Case>();
    	//valido sia per cessazione che attivazione
    	if(OM_GW_GE_Utils.checkCliente){
    		//Inserisco il cliente
	    	insert OM_GW_GE_Utils.cliente;
	    	//Aggiungo il cliente al case
	        OM_GW_GE_Utils.caseOriginale.AccountId = OM_GW_GE_Utils.cliente.Id;
    	}
    	
    	//inserisco la notifica
        insert OM_GW_GE_Utils.notifica;
        
        //metto la reference alla notifica e inserisco il slPrincipale
        OM_GW_GE_Utils.slSFOLO.notify__C=OM_GW_GE_Utils.notifica.Id;
        Insert OM_GW_GE_Utils.slSFOLO;
        
        //metto la reference alla notifica, la reference al slPrincipale e inserisco la response
        OM_GW_GE_Utils.slSFOLOresp.notify__C=OM_GW_GE_Utils.notifica.Id;
        OM_GW_GE_Utils.slSFOLOresp.EOF_SL_Riferimento__c=OM_GW_GE_Utils.slSFOLO.Id;
        Insert slSFOLOresp;
        
    	if(processo=='Attivazione'){

	        if(OM_GW_GE_Utils.checkRefTec){
	        	//inserisco il referente tecnico e metto il riferimento sul case
	        	insert OM_GW_GE_Utils.refTec;
	        	OM_GW_GE_Utils.caseOriginale.EOF_Contact__c = OM_GW_GE_Utils.refTec.Id;
	        }
 
	        //aggiungo gli eventuali case di amministratori da aggiornare
	    	if(OM_GW_GE_Utils.checkCaseAmm){
		        caseToUpdate.addAll(OM_GW_GE_Utils.ListCaseAmmToUpdate);	
	        }  
    	}
    	OF_manageOrderFromCase mofc = new OF_manageOrderFromCase();
    	String s=mofc.ManageOrder(OM_GW_GE_Utils.caseOriginale);
    	if(!String.isBlank(s)){
    		OM_GW_GE_Utils.caseOriginale.OF_Order__c=s;
    	}
    	
    	//in caso di cessazione KO è  sufficiente la seguente
    	caseToUpdate.add(OM_GW_GE_Utils.caseOriginale);
    	update caseToUpdate;
    }
    
    //metodo per gestire l'aggiornamento dei dati dopo l'invio dell'Acquisizione OK/KO e cessazione KO all'OLO e l'inoltro dell'attivazione/cessazione ad OM
    public static void aggiornamentoDatiAttivazioneCessazioneToOM(String processo, String tipo_comunicazione, String esito){
    	list<Case> caseToUpdate = new list<Case>();
    	list<EOF_EAI_Service_Log__c> slListPrincipaliToInsert = new list<EOF_EAI_Service_Log__c>();
    	list<EOF_EAI_Service_Log__c> slListResponseToInsert = new list<EOF_EAI_Service_Log__c>();
    	//valido sia per cessazione che attivazione
    	if(OM_GW_GE_Utils.checkCliente){
    		//Inserisco il cliente
	    	insert OM_GW_GE_Utils.cliente;
	    	//Aggiungo il cliente al case
	        OM_GW_GE_Utils.caseOriginale.AccountId = OM_GW_GE_Utils.cliente.Id;
    	}
    	//casi di attivazione OK/KO e cessazione KO
    	if(processo=='Create' || (processo=='Delete' && tipo_comunicazione=='98')){
	    	//inserisco la notifica
	        insert OM_GW_GE_Utils.notifica;
	        
	        //metto la reference alla notifica e inserisco gli slPrincipali
	        OM_GW_GE_Utils.slSFOLO.notify__C=OM_GW_GE_Utils.notifica.Id;
	        slListPrincipaliToInsert.add(OM_GW_GE_Utils.slSFOLO);
	        slListPrincipaliToInsert.add(OM_GW_GE_Utils.slSFOM);
	        Insert slListPrincipaliToInsert;
	        
	        //metto la reference alla notifica, la reference al slPrincipale e inserisco la response
	        OM_GW_GE_Utils.slSFOLOresp.notify__C=OM_GW_GE_Utils.notifica.Id;
	        OM_GW_GE_Utils.slSFOLOresp.EOF_SL_Riferimento__c=OM_GW_GE_Utils.slSFOLO.Id;
	        OM_GW_GE_Utils.slSFOMResp.EOF_SL_Riferimento__c=OM_GW_GE_Utils.slSFOM.Id;
	        slListResponseToInsert.add(OM_GW_GE_Utils.slSFOMResp);
	        slListResponseToInsert.add(OM_GW_GE_Utils.slSFOLOresp);
	        Insert slListResponseToInsert;
    	}
        
    	if(processo=='Create'){

	        if(OM_GW_GE_Utils.checkRefTec){
	        	//inserisco il referente tecnico e metto il riferimento sul case
	        	insert OM_GW_GE_Utils.refTec;
	        	OM_GW_GE_Utils.caseOriginale.EOF_Contact__c = OM_GW_GE_Utils.refTec.Id;
	        }
 
	        //aggiungo gli eventuali case di amministratori da aggiornare
	    	if(OM_GW_GE_Utils.checkCaseAmm){
		        caseToUpdate.addAll(OM_GW_GE_Utils.ListCaseAmmToUpdate);	
	        }
    	}
    	if(processo=='Delete' && tipo_comunicazione=='11'){
    		
    		if(OM_GW_GE_Utils.checkCliente){
	    		//Inserisco il cliente
		    	insert OM_GW_GE_Utils.cliente;
		    	//Aggiungo il cliente al case
		        OM_GW_GE_Utils.caseOriginale.AccountId = OM_GW_GE_Utils.cliente.Id;
	    	}
	    	//inserisco il log principale
	    	insert OM_GW_GE_Utils.slSFOM;
	    	//inserisco il riferimento sul log di response e poi la response
	    	OM_GW_GE_Utils.slSFOMResp.EOF_SL_Riferimento__c=OM_GW_GE_Utils.slSFOM.Id;
	    	Insert OM_GW_GE_Utils.slSFOMResp;
	    	
    	}
    	OF_manageOrderFromCase mofc = new OF_manageOrderFromCase();
    	String s=mofc.ManageOrder(OM_GW_GE_Utils.caseOriginale);
    	if(!String.isBlank(s)){
    		OM_GW_GE_Utils.caseOriginale.OF_Order__c=s;
    	} 
    	//in caso di cessazione KO è  sufficiente la seguente
    	caseToUpdate.add(OM_GW_GE_Utils.caseOriginale);
    	update caseToUpdate;
    }
    public static object simulateNACK(String origine){
    	if(origine=='OLO'){
    		xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType resp = new xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();
	        resp.ESITO='1';
	        resp.CodiceErrore='200';
	        resp.CausaleErrore='Errore nella Request: il messaggio non è conforme al WSDL';
	        return resp;
    	}
    	if(origine=='OM'){
    		xmlnsEnelItOloGatwaySincronizzazionCOM.ResponseHeader resp = new xmlnsEnelItOloGatwaySincronizzazionCOM.ResponseHeader();
	        resp.Status='1';
	        resp.StatusMessageId='200';
	        resp.StatusMessage='Errore nella Request: il messaggio non è conforme al WSDL';
	        return resp;
    	}
    	return null;
    }
    public static String getQuery(String oggetto,String Processo ){
    	string s=null;
    	if(oggetto=='case'){
    		if(processo=='Attivazione'){
    			s='select Id,status,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore_WS__c,casenumber,'
					+'EOF_CODICE_Errore__c,EOF_causale_Errore__c,EOF_Id_Notifica__c,EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c,'
					+'EOF_GPON_Vincolante__c, Account.Firstname, Account.Lastname, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Recapito_Telefonico_Cliente_2__c,'
					+'EOF_Provincia_WS__c, EOF_Comune_WS__c, EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c,EOF_ID_Building_WS__c,'
					+'EOF_Scala_Palazzina_WS__c, EOF_Contact__r.FirstName, EOF_Contact__r.LastName, EOF_Telefono_Referente_Tecnico_OLO__c, EOF_Email_Referente_Tecnico_OLO__c,'
					+'EOF_Recapito_Test_Linea__c, EOF_Numero_Telefonico_Principale_Linea__c, EOF_Password_Apparato__c, EOF_Telefono_Referente_OLO_Onfield_Notec__c,'
					+'EOF_Opzione_System_Unico__c, EOF_Apparato__c, EOF_Tipologia_Apparato__c, EOF_Progetto_Speciale__c, EOF_Collegamento_P2P__c, EOF_Note__c,'
					+'EOF_Tipologia_Servizio__c, EOF_SLA_Premium_Assurance__c, EOF_Orario_Appuntamento__c, EOF_Data_Notifica__c, EOF_Data_Prevista_Attivazione__c, EOF_Id_Risorsa__c,'
	  				+'Codice_Ordine_EOF__c,recordtype.developername,OF_Bonifica_Locked_Row__c,OF_Response_Da_OM__c,OF_Response_Da_OLO__c,OF_bypassa_SLA__c' 
					+' from Case';
    		}
    		if(processo=='Cessazione'){
    			s='Select Id, Codice_ordine_Eof__C, EOF_Codice_Ordine_Olo__c,EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,'
					+'EOF_Data_Notifica__c,EOF_Id_Notifica__c,PO_SA_Portale__c,recordtype.developername,'
					+'EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,status,EOF_FASE__C,EOF_Id_Risorsa__c,CaseNumber,OF_Response_Da_OLO__c,'
					+' OF_Response_Da_OM__c,OF_Bonifica_Locked_Row__c from Case'; 
    		}
    	} 
    	if(oggetto=='sl'){ 
    		if(processo=='Attivazione'){
    			s='select EOF_TIpo_comunicazione_String__c,EOF_Tipo_Comunicazione__c ,EOF_Codice_Operatore__c ,EOF_Codice_Ordine_OLO__c ,'
					+'EOF_Data_Notifica__c ,EOF_Data_Notifica_String__c,EOF_ID_Notifica__c ,EOF_ID_Pop__c,EOF_GPON_Attestazione__c,EOF_GPON_Vincolante__c,'
					+'EOF_ID_Risorsa__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,'
					+'EOF_PRovincia__c,EOF_COMUNE__c,EOF_PARTICELLA_TOPONOMASTICA__c,EOF_INDIRIZZO__C,EOF_NUMERO_CIVICO__c,EOF_ID_BUILDING__c,'
					+'EOF_SCALA_PALAZZINA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,'
					+'EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_RECAPITO_TEST_LINEA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,EOF_PASSWORD_APPARATO__c,'
					+'EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,EOF_OPZIONE_SYSTEM_UNICO__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,'
					+'EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__C,EOF_CODICE_RICHIESTA_ANNULLAMENTO__c,EOF_APPARATO__c,EOF_TIPOLOGIA_APPARATO__c,'
					+'EOF_PROGETTO_SPECIALE__c,EOF_COLLEGAMENTO_P2P__c,EOF_NOTE__c,EOF_TIPOLOGIA_SERVIZIO__c,EOF_SLA_PREMIUM_ASSURANCE__c,'
					+'EOF_ORARIO_APPUNTAMENTO__c,EOF_Richiesta_Notifica__c from EOF_EAI_Service_Log__c';
    		}
    		if(processo=='Cessazione'){
    			s='select EOF_Tipo_COmunicazione_String__c,OF_SA_Direzione_Flusso__c,'
					+'OF_SA_Metodo__c,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_DATA_NOTIFICA__c,'
					+'EOF_ID_NOTIFICA__c,EOF_ID_RISORSA__c ,EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,'
					+'EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,EOF_NOTE__c,'
					+'recordtype.developername,recordtype.name,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ID_APPARATO__C,'
					+'recordtypeId'
					+' from EOF_EAI_Service_Log__c';
    		}
    	}
    	if(oggetto=='asset'){
    		if(processo=='AsyncDeactivation'){
    			s='select Id,OF_IDServizio__c,OF_Civico__c,OF_Comune__c, OF_ID_Building__c,OF_Identificativo_del_POP__c,'
					+'OF_Indirizzo__c,OF_Scala_Palazzina__c,OF_Provincia__c,OF_Particella_Toponomastica__c,OF_GPON_Attestazione__c'
					+' from Asset';
    		}
    	}
    	 
    	return s; 
    }
    @future
     public static void aggiornamentoDatiCRM(Id caseId,Id slSFOLOId,Id slSFOLORespId){ 
     	system.debug('nel metodo');
		OM_GW_GE_Utils.caseOriginale=[select id,AccountId,AssetId,CaseNumber,Codice_Ordine_EOF__c,CreatedDate,RecordType.DeveloperName,
										RecordtypeId,Status,OF_Order__c,EOF_Codice_Ordine_OLO__c,EOF_Account_OLO__c,OF_SA_Codice_Motivazione__c,OF_SA_Motivazione__c,
										EOF_Codice_Errore__c,EOF_Causale_Errore__c,EOF_Order_Manager__c,EOF_Id_Risorsa__c,EOF_GPON_Attestazione__c,
										EOF_SLA_Premium_Assurance__c,EOF_Apparato__c,OF_Esito_Consegna_Apparato__c,EOF_Progetto_Speciale__c,EOF_Tipologia_Apparato__c,
										EOF_Password_Apparato__c,OF_IDContratto__c,OF_SA_ID_Servizio__c,OF_SA_Profilo__c, PO_Comune__c,EOF_Istat_Comune__c,
										OF_SA_CODICE_PROGETTO_SPECIALE__c,OF_SA_Cluster_Promozione__c,OF_Servizio__c,OF_SA_Promozione__c,EOF_ID_Building_WS__c,
										EOF_Identificativo_del_POP__c,EOF_Comune_WS__c,EOF_Provincia_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_ID_Splitter_Secondario__c, EOF_Posizione_Splitter_Secondario__c,
										EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c,EOF_Scala_Palazzina_WS__c, EOF_Istat_Provincia__c, PO_Indirizzo_collegamento__c, PO_Civico__c from Case where Id=:caseId];
										        
     	OM_GW_GE_Utils.slSFOLO=[select Id,EOF_Tipo_comunicazione__c,EOF_Data_espletamento_ordine__c,EOF_Data_Notifica__c from EOF_EAI_Service_Log__c where Id=:slSFOLOId];
     	OM_GW_GE_Utils.slSFOLOResp=[select Id, lastModifiedDate from EOF_EAI_Service_Log__c where Id=:slSFOLORespId];
     	OF_ManageOrderFromCase mofc = new OF_ManageOrderFromCase();
     	String s=mofc.ManageOrder(OM_GW_GE_Utils.CaseOriginale);
        if(!String.isBlank(s)){
            OM_GW_GE_Utils.CaseOriginale.AssetId=s;
            update OM_GW_GE_Utils.CaseOriginale;
        } 
 		
     }
    public static void checkAmministratori(Case c){
    	//faccio il check per amministratori
    	//aggiungo  il controllo se id building è vuoto
		if(String.isBlank(c.EOF_Id_Building_WS__c)){
			return;
		}
        list<Case> caseAmm = [select Id,CA_Numero_Ordini_in_Corso__c from Case where recordtype.developername='CA_Amministratori' 
	        												and CA_ID_Building__c=: c.EOF_Id_Building_WS__c
	        												AND status!='Realizzazione Impianto Completata'
	    													AND status!='Negoziazione OF Richiesta Permesso Lavori KO' 
	    													AND status!='Negoziazione OF Accesso Censimento Interno KO'];
		
    	try{
    		OM_GW_GE_Utils.checkCaseAmm=true;
    		OM_GW_GE_Utils.ListCaseAmmToUpdate = new List<Case>();
        	for(case cAmm : caseAmm){
        		cAmm.CA_Codice_Ordine_in_Corso__c= OM_GW_GE_Utils.caseOriginale.EOF_Codice_Ordine_OLO__c;
    			cAmm.CA_Stato_Ordine_in_Corso__c= OM_GW_GE_Utils.caseOriginale.status;
        		cAmm.CA_Numero_Ordini_in_Corso__c=cAmm.CA_Numero_Ordini_in_Corso__c+1;
        		OM_GW_GE_Utils.ListCaseAmmToUpdate.add(cAmm);
        	}
        	return;
    	}
    	catch(exception e){
    		system.debug('L exception è: '+e);
    	}
        return;
    }
    public static String retSpec (OM_GW_WS_Notify.fiberNotify fn){
    	String s='';
    	String s1='';
    	if(fn.STATO_RICHIESTA=='1'){
    		s1=' KO';
    	}
	                if (fn.tipo_comunicazione=='6'){
	                	s='Accettazione'+s1;
	                } 
	                if (fn.tipo_comunicazione=='7'){
	                	s='Espletamento'+s1;
	                } 
	                if (fn.tipo_comunicazione=='8'){
	                	s='Rimodulazione DAC';
	                } 
	                if (fn.tipo_comunicazione=='9'){
	                	s='Sospensione';
	                }     
	                if (fn.tipo_comunicazione=='10'){
	                	s='Desospensione';
	                }   
	                if (fn.tipo_comunicazione=='12'){
	                	s='Cessazione'+s1;
	                } 
	                if (fn.tipo_comunicazione=='13'){
	                	s='Annullamento';
	                }
	                return s;
    }
    public static String retCodOp (OM_GW_WS_Notify.fiberNotify fn){
    	String s='';
	                if (fn.codice_operatore.toUpperCase()=='WIND'){
	                	s='WN';
	                } 
	                if (fn.codice_operatore.toUpperCase()=='VODAFONE'){
	                	s='VF';
	                } 
	                return s;
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
    public static String retCodOp (String fr){
    	String s='';
	                if (fr=='1'){
	                	s='Attivazione';
	                } 
	                if (fr=='11'){
	                	s='Cessazione';
	                }
	                if (fr=='99'){
	                	s='Attivazione KO';
	                } 
	                if (fr=='98'){
	                	s='Cessazione KO';
	                }  
	                if (fr=='2'){
	                	s='Rimodulazione DAC';
	                } 
	                if (fr=='3'){
	                	s='Desospensione';
	                }     
	                if (fr=='4'){
	                	s='Annullamento';
	                }   
	                return s;
    }
    public static String retSpec (string fn){
    	String s='';
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
    public static string retNotRecType(OM_GW_WS_Notify.fiberNotify fn){
    	String x = fn.tipo_comunicazione;
    	String esito='';
    	String rectype='';
    	if (fn.stato_richiesta=='1'){
    		esito=' KO';
    	}
    	
    	if(x=='5'){
    		rectype='Notifica di accettazione' + esito;
    	}
    	if(x=='6'){
    		rectype='Notifica di acquisizione' + esito;
    	}
    	if(x=='7'){ 
    		rectype='Notifica di espletamento' + esito;
    	}
    	if(x=='8'){
    		rectype='Notifica di rimodulazione DAC';
    	}
    	if(x=='9'){
    		rectype='Notifica di sospensione';
    	}
    	if(x=='10'){
    		rectype='Notifica di desospensione';
    	}
    	if(x=='12'){
    		rectype='Notifica di cessazione' + esito;
    	}
    	if(x=='13'){
    		rectype='Notifica di annullamento';
    	}
    	return rectype;
    }

	// 10/06/2018 MM : aggiunta metodo per conversione tipo comunicazione in stringa di tipo OLO_ o OM_
    public static String retCodOp2 (EOF_GW_WS_Request.fiberRequest fr){
    	String s='';
	                if (fr.tipo_comunicazione=='1'){
	                	s='OLO_Attivazione';
	                } 
	                if (fr.tipo_comunicazione=='11'){
	                	s='OLO_Cessazione';
	                }
	                if (fr.tipo_comunicazione=='99'){
	                	s='OLO_Attivazione_KO';
	                } 
	                if (fr.tipo_comunicazione=='98'){
	                	s='OLO_Cessazione_KO';
	                }  
	                if (fr.tipo_comunicazione=='2'){
	                	s='OLO_Rimodulazione_DAC';
	                } 
	                if (fr.tipo_comunicazione=='3'){
	                	s='OLO_Desospensione';
	                }     
	                if (fr.tipo_comunicazione=='4'){
	                	s='OLO_Annullamento';
	                }   
	                return s;
    }
    
    public static String retSpec2 (OM_GW_WS_Notify.fiberNotify fn){
    	String s='';
    	String s1='';
    	if(fn.STATO_RICHIESTA=='1'){
    		s1='_KO';
    	}
	                if (fn.tipo_comunicazione=='6'){
	                	s='OM_Accettazione'+s1;
	                } 
	                if (fn.tipo_comunicazione=='7'){
	                	s='OM_Espletamento'+s1;
	                } 
	                if (fn.tipo_comunicazione=='8'){
	                	s='OM_Rimodulazione_DAC';
	                } 
	                if (fn.tipo_comunicazione=='9'){
	                	s='OM_Sospensione';
	                }     
	                if (fn.tipo_comunicazione=='10'){
	                	s='OM_Desospensione';
	                }   
	                if (fn.tipo_comunicazione=='12'){
	                	s='OM_Cessazione'+s1;
	                } 
	                if (fn.tipo_comunicazione=='13'){
	                	s='OM_Annullamento';
	                }
	                return s;
    }
    
    // 10/06/2018 MM : fine aggiunta.
    
    // 17/06/2018 MM : creazione metodo di istanziazione per oggetto Templog flussi da OLO
    public static void CreateTemplogOLO(EOF_GW_WS_Request.FiberRequest fr){
 		try{
        // 11/06/2018 MM : aggiunti campi TL_codice_ordine_olo__c, Tipo_Comunicazione__c, Tipo_Comunicazione_String__c
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.tpl.Name= fr.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(fr) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
        OM_GW_GE_Utils.tpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
        OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ fr.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';
        OM_GW_GE_Utils.tpl.TL_codice_ordine_olo__c = fr.CODICE_ORDINE_OLO;
        OM_GW_GE_Utils.tpl.Tipo_Comunicazione__c = fr.TIPO_COMUNICAZIONE;
        OM_GW_GE_Utils.tpl.Tipo_Comunicazione_String__c = OM_GW_GE_Utils.retCodOp2(fr);
        OM_GW_GE_Utils.tpl.Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss');
 		}
 		catch(exception e){
 			system.debug(e);
 		}
    }
    
    public static void partialTemplog(String s){
    	try{
    		if(OM_GW_GE_Utils.tpl!=null){
                OM_GW_GE_Utils.tpl.Tempi_Parziali__c= OM_GW_GE_Utils.tpl.Tempi_Parziali__c + ', '+s+' : '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    		}
    	}
    	catch(exception e){ 
 			system.debug(e);
 		}
    }
    
    public static void CreateTemplogOM(OM_GW_WS_Notify.FiberNotify fn){
		
		try{
            if(fn.TIPO_COMUNICAZIONE =='6'){
            OM_GW_GE_Utils.OPName ='Accettazione da OM';
            }
            if(fn.TIPO_COMUNICAZIONE =='7'){
            OM_GW_GE_Utils.OPName ='Espletamento';
            }
            if(fn.TIPO_COMUNICAZIONE =='8'){
            OM_GW_GE_Utils.OPName='RDAC da OM';
            }
            if(fn.TIPO_COMUNICAZIONE =='9'){
            OM_GW_GE_Utils.OPName='Sospensione da OM';
            }
            if(fn.TIPO_COMUNICAZIONE =='10'){
            OM_GW_GE_Utils.OPName='Desospensione da OM';
            }
            if(fn.TIPO_COMUNICAZIONE =='12'){
            OM_GW_GE_Utils.OPName ='Cessazione da OM';
            }
            if(fn.TIPO_COMUNICAZIONE =='13'){
            OM_GW_GE_Utils.OPName ='Annullamento da OM';
            }    
            
            OM_GW_GE_Utils.tpl = new TEMPLOG__c();
            OM_GW_GE_Utils.tpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
            OM_GW_GE_Utils.tpl.desc__c ='TEMPLOG relativo alla FiberNotify del case: ' +fn.CODICE_ORDINE_OLO;
            OM_GW_GE_Utils.tpl.Name = fn.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.OPName+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
            OM_GW_GE_Utils.tpl.Type__c ='T';
            OM_GW_GE_Utils.tpl.TL_codice_ordine_olo__c = fn.CODICE_ORDINE_OLO;
            OM_GW_GE_Utils.tpl.Tipo_Comunicazione__c = fn.TIPO_COMUNICAZIONE;
            OM_GW_GE_Utils.tpl.Tipo_Comunicazione_String__c = OM_GW_GE_Utils.retSpec2(fn);
            OM_GW_GE_Utils.tpl.Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss');
		}
		catch(exception e){
			system.debug(e);
		}

    }
    
    public static void EndTemplog(){
        
        try{
            // 8/06/2018 MM :update del timestamp. END corrisponde a uscita processo
            OM_GW_GE_Utils.tpl.Tempi_Parziali__c= OM_GW_GE_Utils.tpl.Tempi_Parziali__c + ', END : '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
            OM_GW_GE_Utils.tpl.Attraversamento__c = datetime.now().getTime() - OM_GW_GE_Utils.AttrTime;
            OM_GW_GE_Utils.tpl.OF_CPU_Time__c = string.valueof(Limits.getCpuTime());
            OM_GW_GE_Utils.tpl.OF_CPU_Time_Limit__c = string.valueof(Limits.getLimitCpuTime());
            
            insert OM_GW_GE_Utils.tpl;
        }
        catch(Exception e){
            system.debug(e);
        }
        //finisce qui
        
    }    
    //giovanni ernetti 16-10-2018 inizio
    public static List<EOF_Network_Inventory__c> controlloVendibilita(String theOlo, String theBuildingId){
        List<EOF_Network_Inventory__c> result = new List<EOF_Network_Inventory__c>();
        
        if(theOlo=='VF'){
        	theOlo = 'VOD';
        }else if(theOlo=='WN'){
        	theOlo = 'WIN';
        }
        theOlo=theOlo.toLowerCase();
        
        WS_OF_ControlloVendibilita.ControlloVendibilitaRequestType requestControlloVendibilita = new WS_OF_ControlloVendibilita.ControlloVendibilitaRequestType();
        	requestControlloVendibilita.ID_REQUEST = 'request ' + DateTime.now();
        	requestControlloVendibilita.OLO = theOlo;         
        	//requestControlloVendibilita.SERVIZIO = 'ATTIVO';        
        	requestControlloVendibilita.SERVIZIO = 'passivo';         
        	requestControlloVendibilita.ID_BUILDING = theBuildingId; 
        				
        WS_OF_ControlloVendibilita.ControlloVendibilitaPortTypeEndpoint stubControlloVendibilita = new WS_OF_ControlloVendibilita.ControlloVendibilitaPortTypeEndpoint();  
        	stubControlloVendibilita.timeout_x = 30000;
        
        WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType responseControlloVendibilita;
		try{
        	responseControlloVendibilita = stubControlloVendibilita.ControlloVendibilita(requestControlloVendibilita.ID_REQUEST, requestControlloVendibilita.OLO, requestControlloVendibilita.SERVIZIO, requestControlloVendibilita.ID_BUILDING);        
		}catch(Exception e){
            OM_GW_GE_Utils.vendHasException = true;
            OM_GW_GE_Utils.vendException = 'Exception: ' + e.getTypeName() + ': ' + e.getMessage();
            OM_GW_GE_Utils.createVendibilitaRequestResponseLog(result, 'webService', requestControlloVendibilita.ID_REQUEST, requestControlloVendibilita.OLO, requestControlloVendibilita.ID_BUILDING, requestControlloVendibilita.SERVIZIO );
            //Resetto le variabili
            OM_GW_GE_Utils.vendHasException = false;
            OM_GW_GE_Utils.vendException = '';
            return result;  
        }
        if(responseControlloVendibilita != null && responseControlloVendibilita.LISTA_SCALE != null){
            for(WS_OF_ControlloVendibilita.SCALAType scala : responseControlloVendibilita.LISTA_SCALE.SCALA){
                EOF_Network_Inventory__c networkInventory = new EOF_Network_Inventory__c();                
					//networkAttivo.Id = scala.ID_SCALA;
					networkInventory.EOF_Civico__c = scala.CIVICO;            
					networkInventory.EOF_Comune__c = scala.COMUNE;
					//networkAttivo.OF_SA_GPON_ID__c
					//networkInventory.EOF_ID_Building__c = scala.ID_BUILDING_OM;
					networkInventory.EOF_Pop__c = scala.POP;
					networkInventory.EOF_Indirizzo__c = scala.INDIRIZZO;
					networkInventory.EOF_Particella_Top__c = scala.PARTICELLA_TOP;
					networkInventory.EOF_Provincia__c = scala.PROVINCIA;
					networkInventory.EOF_Scala_Palazzina__c = scala.SCALA_PALAZZINA;
					//networkAttivo.OF_SA_Stato_Building__c = scala.STATO_BUILDING;                
					try{
						networkInventory.EOF_Stato_Building__c = Decimal.valueOf(scala.STATO_BUILDING);
					}catch (TypeException e){
						networkInventory.EOF_Stato_Building__c = null;
					}                            
                result.add(networkInventory);            
            }
        }
		//Vado a loggare la response
        OM_GW_GE_Utils.createVendibilitaRequestResponseLog(result, 'webService', requestControlloVendibilita.ID_REQUEST, requestControlloVendibilita.OLO, requestControlloVendibilita.ID_BUILDING, requestControlloVendibilita.SERVIZIO );
        return result;      
    }
    //giovanni ernetti 16-10-2018 fine  
	//AA - 28-01-2019 - Nuova gestione vendibilità richiesta da GB e CC
    /*public static void createVendibilitaRequestLog(String IdRequest, String OLO, String IdBuildingOLO, String TipologiaServizio){
        //Istanzio la lista che popolerò con il log di Req e Res, per poter effettuare l'insert successivamente
        OM_GW_GE_Utils.vendLogLst = new List<OF_Vendibilita_Logger__c>();
        //Vado a creare il log di request
        OF_Vendibilita_Logger__c sVenLogRequest = new OF_Vendibilita_Logger__c();
            sVenLogRequest.OF_IdRequest__c = IdRequest;
            sVenLogRequest.OF_OLO__c = OLO;
            sVenLogRequest.OF_Servizio__c = TipologiaServizio;
            sVenLogRequest.OF_IdBuilding_OLO__c = IdBuildingOLO;
            //Per evitare nullpointer mi controllo se esiste il case e lo aggiungo al log di request
            if(OM_GW_GE_Utils.caseOriginale != null){
                sVenLogRequest.OF_Caso__c = OM_GW_GE_Utils.caseOriginale.Id;
            }
            sVenLogRequest.Request_Response__c = 'ID_REQUEST: ' + sVenLogRequest.OF_IdRequest__c + '\n' +
                                                 'OLO: ' + sVenLogRequest.OF_OLO__c + '\n' + 
                                                 'SERVIZIO: ' + sVenLogRequest.OF_Servizio__c + '\n' + 
                                                 'ID_BUILDING_OLO: ' + sVenLogRequest.OF_IdBuilding_OLO__c + '\n';
        //Aggiungo la request alla lista
        OM_GW_GE_Utils.vendLogLst.add(sVenLogRequest);
    }
    //AA - Aggiunta stringa provenienzaServizio per utilizzare lo stesso metodo sia per la response del webService sia per la response della query
    public static void createVendibilitaResponseLog(List<EOF_Network_Inventory__c> results, String provenienzaServizio){
        //Istanzio l'oggetto che aggiungerò alla lista dei log di vendibilita
        OF_Vendibilita_Logger__c sVenLogResponse = new OF_Vendibilita_Logger__c();
        //Creo una variabile globale per gestire il campo Request/Response
        String req_res = '';

        //Vado a recuperare il log di request così da poter legare request e response
        if(!OM_GW_GE_Utils.vendLogLst.isEmpty()){
            OF_Vendibilita_Logger__c sVenLogRequest = OM_GW_GE_Utils.vendLogLst.get(0);
            //Vado a salvare i campi IdRequest, OLO, Servizio, BuildingOLO e il Case
            sVenLogResponse.OF_IdRequest__c = sVenLogRequest.OF_IdRequest__c;
            sVenLogResponse.OF_OLO__c = sVenLogRequest.OF_OLO__c; 
            sVenLogResponse.OF_Servizio__c = sVenLogRequest.OF_Servizio__c;
            sVenLogResponse.OF_IdBuilding_OLO__c = sVenLogRequest.OF_IdBuilding_OLO__c;
            sVenLogResponse.OF_Caso__c = sVenLogRequest.OF_Caso__c;
            //Popolo le prime info della response
            req_res +=  'RESPONSE da '+ provenienzaServizio.toUpperCase() +' in riferimento alla REQUEST: \n' +
                        'ID_REQUEST: ' + sVenLogResponse.OF_IdRequest__c + '\n' +
                        'OLO: ' + sVenLogResponse.OF_OLO__c + '\n' + 
                        'SERVIZIO: ' + sVenLogResponse.OF_Servizio__c + '\n' + 
                        'ID_BUILDING_OLO: ' + sVenLogResponse.OF_IdBuilding_OLO__c + '\n\n\n';
            //Quando farò la insert legherò la response alla request, ancora non posso fare la insert perchè eseguirò delle callout
            //sVenLogResponse.OF_Riferimento_Logger__c = sVenLogRequest.Id;
        }
        //Se non sono stati restitui NetworkInventory, lo scrivo in modo che potranno configurarli
        if(results.isEmpty()){
            if(OM_GW_GE_Utils.vendHasException){
                req_res += 'Webservice exception error';
            }else{
                req_res += 'Nessun NetworkInventory restituito da ' + provenienzaServizio;
            }
        }else{
            //Vado a ciclare la lista di network inventory restituiti e salvo la response
            Integer i = 1;
            for(EOF_Network_Inventory__c ni : results){
                req_res += 'NetworkInventory ' + i + '\n' +
                           'CIVICO: ' + ni.EOF_Civico__c + '\n' +
                           'COMUNE: ' + ni.EOF_Comune__c + '\n' +
                           'POP: ' + ni.EOF_Pop__c + '\n' +
                           'INDIRIZZO: ' + ni.EOF_Indirizzo__c + '\n' +
                           'PARTICELLA_TOPONOMASTICA: ' + ni.EOF_Particella_Top__c + '\n' +
                           'PROVINCIA: ' + ni.EOF_Provincia__c + '\n' +
                           'SCALA_PALAZZINA: ' + ni.EOF_Scala_Palazzina__c + '\n' + 
                           'STATO_BUILDING: ' + ni.EOF_Stato_Building__c + '\n\n';
            }
        } 
        //Una volta popolato il campo request/response lo salvo sul record e aggiungo alla lista
        sVenLogResponse.Request_Response__c = req_res;
        OM_GW_GE_Utils.vendLogLst.add(sVenLogResponse);
	}*/
	public static void createVendibilitaRequestResponseLog(List<EOF_Network_Inventory__c> results, String provenienzaServizio,String IdRequest, String OLO, String IdBuildingOLO, String TipologiaServizio){
        //Creo una variabile globale per gestire il campo Request/Response
        String req = '';           
        String res = '';
        //Istanzio l'oggetto che aggiungerò alla lista dei log di vendibilita
        OF_Vendibilita_Logger__c sVenLogResponse = new OF_Vendibilita_Logger__c();        
        //Vado a salvare i campi IdRequest, OLO, Servizio, BuildingOLO e il Case
        sVenLogResponse.OF_IdRequest__c = IdRequest;
        sVenLogResponse.OF_OLO__c = OLO; 
        sVenLogResponse.OF_Servizio__c = TipologiaServizio;
        sVenLogResponse.OF_IdBuilding_OLO__c = IdBuildingOLO;
        //Per evitare nullpointer mi controllo se esiste il case e lo aggiungo al log di request
        if(OM_GW_GE_Utils.caseOriginale != null){
            sVenLogResponse.OF_Caso__c = OM_GW_GE_Utils.caseOriginale.Id;
        }
        //AA - Nuovo campo per gestione reportistica
        sVenLogResponse.OF_Data__c = System.now();
        //Popolo le prime info della response
        req +=  'REQUEST VENDIBILITA\' : \n'+
                    'ID_REQUEST: ' + sVenLogResponse.OF_IdRequest__c + '\n' +
                    'OLO: ' + sVenLogResponse.OF_OLO__c + '\n' + 
                    'SERVIZIO: ' + sVenLogResponse.OF_Servizio__c + '\n' + 
                    'ID_BUILDING_OLO: ' + sVenLogResponse.OF_IdBuilding_OLO__c;
        res += 'RESPONSE da '+ provenienzaServizio.toUpperCase() +' : \n';
        //Se non sono stati restitui NetworkInventory, lo scrivo in modo che potranno configurarli
        if(results.isEmpty()){
            //Vado a salvare le info relative al caso in cui la query o il ws non restituisce valori
            sVenLogResponse.OF_Source__c = (provenienzaServizio == 'webService') ? 'Non da web service' : 'Non da NI';
            if(OM_GW_GE_Utils.vendHasException){
                //Caso di exception, salvo il messaggio dell'exception
                sVenLogResponse.OF_Motivo__c = OM_GW_GE_Utils.vendException;
                res += provenienzaServizio + ' exception error';
            }else{
                //Caso building non trovato, salvo con motivazione "Building non trovato"
                sVenLogResponse.OF_Motivo__c = 'Building non trovato';
                res += 'Nessun NetworkInventory restituito da ' + provenienzaServizio;
            }
        }else{
            sVenLogResponse.OF_Source__c = (provenienzaServizio == 'webService') ? 'Da web service' : 'Da NI';
            //Vado a ciclare la lista di network inventory restituiti e salvo la response
            Integer i = 1;
            for(EOF_Network_Inventory__c ni : results){
                res += 'NetworkInventory ' + i + '\n' +
						'CIVICO: ' + ni.EOF_Civico__c + '\n' +
						'COMUNE: ' + ni.EOF_Comune__c + '\n' +
						'POP: ' + ni.EOF_Pop__c + '\n' +
						'INDIRIZZO: ' + ni.EOF_Indirizzo__c + '\n' +
						'PARTICELLA_TOPONOMASTICA: ' + ni.EOF_Particella_Top__c + '\n' +
						'PROVINCIA: ' + ni.EOF_Provincia__c + '\n' +
						'SCALA_PALAZZINA: ' + ni.EOF_Scala_Palazzina__c + '\n' + 
						'STATO_BUILDING: ' + ni.EOF_Stato_Building__c + '\n\n';
            }
        } 
        //Una volta popolato il campo request/response lo salvo sul record e aggiungo alla lista
        sVenLogResponse.OF_Request__c = req;
        sVenLogResponse.OF_Response__c = res;
        if(OM_GW_GE_Utils.vendLogLst == null){
            OM_GW_GE_Utils.vendLogLst = new List<OF_Vendibilita_Logger__c>();
        }
        OM_GW_GE_Utils.vendLogLst.add(sVenLogResponse);
    }
    //Fine AA - 28-01-2019
    
}
public without sharing class OF_SA_GE_UtilsNew {
    // 14/02/2018 aggiunta TEMPLOG per cattura timestamp
    public static TEMPLOG__c tmpl;
    public static String OpName;
    public static Double AttrTime; 
    public static EOF_EAI_Service_Log__c slOLOSF; 
    public static EOF_EAI_Service_Log__c slOLOSFResp;
    public static EOF_EAI_Service_Log__c slSFOLO;
    public static EOF_EAI_Service_Log__c slSFOLOResp;
    public static EOF_EAI_Service_Log__c slSFOM;
    public static EOF_EAI_Service_Log__c slSFOMResp;
    public static EOF_EAI_Service_Log__c slOMSF;
    public static Case caseOriginale;
    public static boolean checkCaseOriginale=false;
    public static boolean checkRTMap = false;
    public static map<String,Id> RTMap;
    public static boolean PORTAL=false;
    public static string Response; 
    public static List<EOF_EAI_Service_LOg__c> ListApp;
    public static boolean checkApp=false;
    public static List<EOF_EAI_Service_Log__c> ListSlActivationOLOSF;
    public static List<EOF_EAI_Service_LOg__c> ListVLan;
    public static boolean checkVLan=false;
    public static List<EOF_EAI_Service_LOg__c> ListServAgg;
    public static boolean checkServAgg=false;
    public static Account cliente;
    public static boolean checkCliente=false;
    public static Contact RefTec;    
    public static boolean checkRefTec=false;
    public static List<OF_CommercialElementIstanziato__c> ceiList;
    public static boolean checkCEIList=false;
    public static OF_Generatore_ID_Servizio__c gen;
    public static List<EOF_EAI_Service_Log__c> ListSlDeactivationOLOSF;
    public static asset a;
    public static List<EOF_EAI_Service_Log__c> ListSlActivationSFOM;
    public static List<EOF_EAI_Service_Log__c> ListSlDeactivationSFOM;
    public static List<Case> ListCaseAmmToUpdate;
    public static boolean checkCaseAmm=false;
    public static List<EOF_EAI_Service_LOg__c> ListVLanToOM;
    public static boolean checkVLanToOM=false;
    public static List<EOF_EAI_Service_LOg__c> ListAppToOM;
    public static boolean checkAppToOM=false;
    public static List<EOF_EAI_Service_LOg__c> ListServAggToOM;
    public static boolean checkServAggToOM=false;
    public static List<EOF_EAI_Service_Log__c> ListSlStatusUpdateSFOLO;
    public static boolean retry=false;
    public static boolean desospendi=false;
    public static List<EOF_EAI_Service_Log__c> ListSlCompletionOrderSFOLO;
    public static EOF_EAI_Service_Log__c sLogOFSHReqANDRes;
    public static SH_Response_For_Confirmation responseFromSH;
     
    //SyncError
    public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse syncError(Object o, String errorCode, String fieldName){
         
        OF_SA_GE_UtilsNew.Response='NACK';
        List<String> result = new List<String>();
        //aggiungo SL di riferimento
        EOF_EAI_Service_Log__c slRiferimento;
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse res_temp = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
        res_temp.Esito = '';
        res_temp.CODICE_MOTIVAZIONE = '';
        res_temp.MOTIVAZIONE = '';
        String errorDesc = '';
        String tipo_comunicazione='';
        String COdice_operatore='';
        String CODICE_ORDINE_OLO='';
        String ID_NOTIFICA='';
        String RICHIESTA_NOTIFICA=''; 
        String metodo='';
        String flusso='';
         
        if(errorCode == 'A03')
            errorDesc = fieldName;

        if(errorCode == 'A04')
            errorDesc = 'Errore tecnico di interfaccia';
        
        if(errorCode == 'A05' || errorCode == 'A_K9')
            errorDesc = 'Campo \''+ fieldName +'\' obbligatorio non valorizzato';
        
        if(errorCode == 'A06' || errorCode == 'A_K10')
            errorDesc = 'Valore campo \''+ fieldName + '\' non ammesso';
        
        if(errorCode == 'A08')
            errorDesc = 'Codice Ordine OLO già presente';
        
        if(errorCode == 'A07')
            errorDesc = 'Status non congruente con '+fieldName;

        if(errorCode == 'A12')
            errorDesc = 'IDENTIFICATIVO_PRENOTAZIONE non esistente';
        if(errorCode == 'A13')
            errorDesc = 'IDENTIFICATIVO_PRENOTAZIONE expired';
        if(errorCode == 'A14')
            errorDesc = 'IDENTIFICATIVO_PRENOTAZIONE associato ad un ordine differente';            
        if(errorCode == '*KO_SH*'){
            errorCode = OF_SA_GE_UtilsNew.responseFromSH.Code;
            errorDesc = OF_SA_GE_UtilsNew.responseFromSH.Description;
        }
        
        if(errorCode == 'B04'){
            errorDesc = 'Carattere non ammesso nel campo \''+fieldName+'\'';
        }
        if(errorCode == 'A09'){
            errorDesc = 'Data Attesa Consegna non conforme agli SLA';
        } 
        if(errorCode == 'A10'){
            errorDesc = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
        }
        
        if(o instanceof OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest){            
            OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest x = (OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest) o;
            
            slRiferimento = OF_SA_GE_UtilsNew.slOLOSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            tipo_comunicazione='OLO->SF - NACK - ActivationRequest';
            flusso='OLO-SF';
            Metodo='OLO_ActivationSetup_OpenStream';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
        }         
        if(o instanceof OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest){
            OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest x = (OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest) o;
            
            slRiferimento = OF_SA_GE_UtilsNew.slOLOSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            tipo_comunicazione='OLO->SF - NACK - DeactivationRequest';                                                                                     
            flusso='OLO-SF';
            Metodo='OLO_DeactivationOrder';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);  
        }        
        if(o instanceof OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest){
            OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest x = (OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest) o;
            
            //in caso di reschedule sincrono creo il service Log
            slRiferimento = OF_SA_GE_UtilsNew.create_EAI_Log(x);
            slRiferimento.EOF_Response__c='NACK';
            insert slRiferimento;
            
            flusso='OLO-SF';
            Metodo='OLO_Reschedule';
            tipo_comunicazione='OLO->SF - NACK - RescheduleRequest';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA; 
            RICHIESTA_NOTIFICA=Copy_request(x);
        }        
        if(o instanceof OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest){
            OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest x = (OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest) o;
            //in caso di statusUpdate sincrono creo il service Log
            slRiferimento = slOLOSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            flusso='OLO-SF';
            Metodo='OLO_StatusUpdate';
            tipo_comunicazione='OLO->SF - NACK - StatusUpdateRequest';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
            
        }
        //Chiamate OM 
        /*if(o instanceof OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder){
            OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder x = (OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder) o;
            //in caso di statusUpdate sincrono creo il service Log
            OF_SA_GE_UtilsNew.create_EAI_Log(x);
            
            flusso='OM-SF';
            Metodo='OF_CompletionOrder_OpenStream';
            tipo_comunicazione='OLO->SF - NACK - CompletionOrderNotify';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
        }*/ 
        //AA - LOG DA OM
        if(o instanceof OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate){
			OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate x = (OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate) o;
			//in caso di statusUpdate sincrono creo il service Log
			OF_SA_GE_UtilsNew.create_EAI_Log(x);
			
			flusso='OM-SF';
			Metodo='OF_StatusUpdateNew';
			tipo_comunicazione='OLO->SF - NACK - StatusUpdateNotify';
			COdice_operatore=x.COdice_operatore;
			CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
			ID_NOTIFICA=x.ID_NOTIFICA;
			RICHIESTA_NOTIFICA=Copy_request(x);
		}
        if(o instanceof OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule){
            OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule x = (OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule) o;
            //in caso di statusUpdate sincrono creo il service Log
            OF_SA_GE_UtilsNew.create_EAI_Log(x);
            
            flusso='OM-SF';
            Metodo='OF_Reschedule';
            tipo_comunicazione='OLO->SF - NACK - RescheduleNotify';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
        }
        if(o instanceof OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder){
			OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder x = (OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder) o;
			//in caso di statusUpdate sincrono creo il service Log
			OF_SA_GE_UtilsNew.create_EAI_Log(x);
			
			flusso='OM-SF';
			Metodo='OF_CompletionOrder_OpenStream';
			tipo_comunicazione='OLO->SF - NACK - CompletionOrderNotify';
			COdice_operatore=x.COdice_operatore;
			CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
			ID_NOTIFICA=x.ID_NOTIFICA;
			RICHIESTA_NOTIFICA=Copy_request(x);
		}
        res_temp.Esito = '1';
        res_temp.CODICE_MOTIVAZIONE = errorCode;
        res_temp.MOTIVAZIONE = errorDesc;
        res_temp.ID_NOTIFICA = ID_NOTIFICA;
        //faccio il check se il service log  di riferimento è stato correttamente popolato
        String slReferenceId;
        if(slRiferimento!=null){
            slReferenceId=slRiferimento.Id;
        }
        EOF_EAI_Service_Log__c slNACK = create_EAI_Log(new Map<String,String>{'Type' => 'NACK',
            'Codice_errore' => errorCode,
            'Causale_errore' => errorDesc,
            'Flusso' => flusso,
            'Metodo' => metodo,
            'Codice_operatore' => CODICE_OPERATORE,
            'Codice_ordine_OLO' => CODICE_ORDINE_OLO,
            'ID_notifica' => ID_NOTIFICA,
            'Richiesta Notifica' => RICHIESTA_NOTIFICA,
            'Tipo Comunicazione' => tipo_comunicazione,
            'SL Riferimento' => slReferenceId});
        insert slNACK;
        
        return res_temp;
    }
    //Create eai slog
    public static EOF_EAI_Service_Log__c create_EAI_Log(Object o){
        
        //('OSCRM OK');
        if(!OF_SA_GE_UtilsNew.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_SA_GE_UtilsNew.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_SA_GE_UtilsNew.RTMap.put(rt.developername,rt.id);
            }
            OF_SA_GE_UtilsNew.checkRTMap=true;
        }            
        //Activation new
        if(o instanceof OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest){
            
            OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest a = (OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
            // EC Commento DIA 2019 04 05       RecordTypeId = String.isBlank(a.TIPOLOGIA_SERVIZIO) ? OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberRequest')
                       // EC Commento DIA 2019 04 05                                                : OF_SA_GE_UtilsNew.RTMap.get('OF_DIA_FiberRequest'),
                RecordTypeId = OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberRequest'),
                OF_SA_Direzione_Flusso__c='OLO-SF',
                OF_SA_Metodo__c='OLO_ActivationSetup_OpenStream',
                EOF_Tipo_COmunicazione_String__c='OLO->SF - ActivationRequest',
                EOF_CODICE_OPERATORE__C=a.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__C=a.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__C=StringTODate(a.DATA_NOTIFICA), 
                EOF_ID_NOTIFICA__C=a.ID_NOTIFICA,
                EOF_NOME_REFERENTE_TECNICO_OLO__C=a.NOME_REFERENTE_TECNICO_OLO,
                EOF_COGNOME_REFERENTE_TECNICO_OLO__C=a.COGNOME_REFERENTE_TECNICO_OLO,
                EOF_TELEFONO_REFERENTE_TECNICO_OLO__C=a.TELEFONO_REFERENTE_TECNICO_OLO,
                EOF_EMAIL_REFERENTE_TECNICO_OLO__C=a.EMAIL_REFERENTE_TECNICO_OLO,
                EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C=a.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH,
                EOF_NOME_CLIENTE__C=a.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__C=a.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__C=a.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__C=a.RECAPITO_TELEFONICO_CLIENTE_2,
                EOF_INFORMAZIONI_LOGISTICA_APPARATI__C=a.INFORMAZIONI_LOGISTICA_APPARATI,
                EOF_ORARIO_APPUNTAMENTO__C=a.ORARIO_APPUNTAMENTO,
                EOF_CODICE_PROGETTO_SPECIALE__c=a.CODICE_PROGETTO_SPECIALE,
                EOF_PROMOZIONE__C=a.PROMOZIONE,
                EOF_CLUSTER_PROMOZIONE__C=a.CLUSTER_PROMOZIONE,
                EOF_ID_BUILDING__C=a.ID_BUILDING, 
                EOF_SCALA_PALAZZINA__C=a.SCALA_PALAZZINA,
                EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C=a.NUMERO_TELEFONICO_PRINCIPALE_LINEA,
                EOF_RECAPITO_TEST_LINEA__C=a.RECAPITO_TEST_LINEA,
                EOF_ID_Pop__c=a.IDENTIFICATIVO_DEL_POP,
                EOF_PROFILO__C=a.PROFILO,
                //aa aggiunto campo 29/11/2018
                TRACCIATO_TRASCODIFICATO__c=a.TRACCIATO_TRASCODIFICATO,
                OF_Codice_Operatore_Secondario__c = a.CODICE_OPERATORE_SECONDARIO,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c, Status FROM Case Where  EOF_Codice_Ordine_OLO__c =: a.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                OF_SA_GE_UtilsNew.caseOriginale=cList[0];
                OF_SA_GE_UtilsNew.checkCaseOriginale=true;
                sl.caso__c=OF_SA_GE_UtilsNew.caseOriginale.Id; 
            }
            if(string.isnotblank(a.IDENTIFICATIVO_PRENOTAZIONE) && a.IDENTIFICATIVO_PRENOTAZIONE!=null){
                sl.OF_SH_Token_id__c= a.IDENTIFICATIVO_PRENOTAZIONE.abbreviate(50);
            }else{
                sl.OF_SH_Token_id__c = a.IDENTIFICATIVO_PRENOTAZIONE;
            }
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                sl.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                sl.EOF_Note__c = a.NOTE;
            }
            
            try{
                sl.EOF_DATA_PREVISTA_ATTIVAZIONE__C=StringTODateNoTime(a.DATA_PREVISTA_ATTIVAZIONE);
            }
            catch(exception e){
                system.debug('Errore - La data è in formato:'+ a.DATA_PREVISTA_ATTIVAZIONE);
            }
            // finisce qui
            //('OSCRM Clist:'+ cList);
            insert sl;
            Integer n = 1;
            
            
            List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
            if(a.VLAN!=null && !a.VLAN.isEmpty()){ 
                for(OF_SA_WS_IN_OLO_ActivationNew.VLan v : a.VLan){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_SA_GE_UtilsNew.RTMap.get('OF_SA_Vlan');
                    sLog.OF_SA_KIT_CONSEGNA_VLAN__C=v.KIT_CONSEGNA_VLAN;
                    sLog.OF_SA_USER_VLAN__C=v.USER_VLAN;
                    sLog.OF_SA_SERVICE_VLAN__C=v.SERVICE_VLAN;
                    sLog.OF_SA_PROFILO_VLAN__C=v.PROFILO_VLAN;
                    sLog.OF_SA_INFORMAZIONI_VLAN__C= (v.INFORMAZIONI_VLAN != null && v.INFORMAZIONI_VLAN.length() > 255) ? v.INFORMAZIONI_VLAN.abbreviate(255) : v.INFORMAZIONI_VLAN;
                    sLog.OF_SA_CUSTOMER_VLAN__C=v.CUSTOMER_VLAN;
                    sLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C=v.MODELLO_DI_SERVIZIO_VLAN;
                    sLog.OF_SA_VLan_Log__c=sl.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    n++;
                }
            }
            if(a.apparato!=null && !a.apparato.isEmpty()){ 
                for(OF_SA_WS_IN_OLO_ActivationNew.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                        sLog.recordtypeid=OF_SA_GE_UtilsNew.RTMap.get('OF_SA_Cpe');
                        sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                        sLog.OF_SA_PASSWORD_APPARATO__C=app.PASSWORD_APPARATO;
                        sLog.OF_SA_AZIONE_APPARATO__C=app.AZIONE_APPARATO;
                        sLog.EOF_CAUSALE_APPARATO__c = (app.CAUSALE != null && app.CAUSALE.length() > 255) ? app.CAUSALE.abbreviate(255) : app.CAUSALE;
                        sLog.OF_SA_Cpe_Log__c=sl.id;
                        sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    n++;
                }
            }
            if(a.servizio_Aggiuntivo!=null && !a.servizio_Aggiuntivo.isEmpty()){
                for(OF_SA_WS_IN_OLO_ActivationNew.servizio_aggiuntivo sa : a.servizio_Aggiuntivo){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_SA_GE_UtilsNew.RTMap.get('OF_SA_Servizi_Aggiuntivi');
                    sLog.OF_SA_NOME_SERVIZIO__c=sa.NOME_SERVIZIO; 
                    sLog.OF_SA_INFORMAZIONI_SERVIZIO__c=sa.INFORMAZIONI_SERVIZIO;
                    sLog.OF_SA_servizi_Aggiuntivi_Log__c=sl.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    n++;
                } 
            }  
            if(!sLogList.isEmpty()){
                insert sLogList;
            }  
            return sl;       
        }      
        //OM Status UpdateNew
        if(o instanceof OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate){
            OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate a = (OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate) o;         
           
            OF_SA_GE_UtilsNew.slOMSF = new EOF_EAI_Service_Log__c(
              // EC Commento DIA 2019 04 05   RecordTypeId = (String.isBlank(a.TIPOLOGIA_SERVIZIO)) ? OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberNotify') : OF_SA_GE_UtilsNew.RTMap.get('OF_DIA_FiberNotify'),
                RecordTypeId =OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberNotify'),
                EOF_Tipo_COmunicazione_String__c='OM->SF - StatusUpdate',
                OF_SA_Direzione_Flusso__c='OM-SF',
                OF_SA_Metodo__c='OF_StatusUpdate',
                EOF_CODICE_OPERATORE__c=a.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c=a.CODICE_ORDINE_OLO,
                EOF_CODICE_ORDINE_EOF__c=a.CODICE_ORDINE_OF,
                EOF_DATA_NOTIFICA__c=StringToDate(a.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c=a.ID_NOTIFICA,
                EOF_STATO_ORDINE__c=a.STATO_ORDINE,
                EOF_CODICE_MOTIVAZIONE__c=a.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__c=a.MOTIVAZIONE,
                EOF_GPON_Attestazione__c=a.GPON_DI_ATTESTAZIONE,
                EOF_NOME_CLIENTE__c=a.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__c=a.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE__c=a.RECAPITO_TELEFONICO_CLIENTE,
                EOF_DATA_PREVISTA_ATTIVAZIONE__c=StringToDateNoTime(a.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__c=a.ORARIO_APPUNTAMENTO,
                EOF_PIN_INTERVENTO_A_VUOTO__c=a.PIN_INTERVENTO_A_VUOTO,
                EOF_ID_SERVIZIO__c = a.ID_SERVIZIO,
                OF_Flag_Desospensione__c = a.FLAG_DESOSPENSIONE,
                OF_Remote_ID__c = a.REMOTE_ID,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            OF_SA_GE_UtilsNew.slOMSF.EOF_Response__c=OF_SA_GE_UtilsNew.Response;
            if(OF_SA_GE_UtilsNew.checkCaseOriginale){
                OF_SA_GE_UtilsNew.slOMSF.caso__c=OF_SA_GE_UtilsNew.CaseOriginale.Id;                
            
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
            	OF_SA_GE_UtilsNew.slOMSF.EOF_Note__c= a.NOTE.abbreviate(255);
            }else{
            	OF_SA_GE_UtilsNew.slOMSF.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            
                                                         
            insert OF_SA_GE_UtilsNew.slOMSF;
            
            List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
            Integer n = 1;
            if(a.VLAN!=null && !a.VLAN.isEmpty()){ 
                for(OF_WS_IN_OM_StatusUpdateNew.VLan v : a.VLan){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_SA_GE_UtilsNew.RTMap.get('OF_SA_Vlan');
                    sLog.OF_SA_USER_VLAN__C=v.USER_VLAN;
                    sLog.OF_SA_SERVICE_VLAN__C=v.SERVICE_VLAN;
                    sLog.OF_SA_CUSTOMER_VLAN__C=v.CUSTOMER_VLAN;
                    sLog.OF_SA_VLan_Log__c=OF_SA_GE_UtilsNew.slOMSF.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
	                sLogList.add(sLog);
	                n++;
                }
            }
            if(a.apparato!=null && !a.apparato.isEmpty()){
                for(OF_WS_IN_OM_StatusUpdateNew.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_SA_GE_UtilsNew.RTMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.OF_SA_ESITO_RITIRO_APPARATO__C=app.ESITO_RITIRO_APPARATO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_RITIRO__C=app.CODICE_MOTIVAZIONE_RITIRO;
                    sLog.OF_SA_MOTIVAZIONE_RITIRO__C=app.MOTIVAZIONE_RITIRO;
                    sLog.OF_SA_ID_APPARATO__c = app.ID_APPARATO;
                    sLog.OF_SA_Cpe_Log__c=OF_SA_GE_UtilsNew.slOMSF.id; 
                    sLog.EOF_Ordine_Invio_OLO__c=n;
	                sLogList.add(sLog);
	                n++;
                }
            }
            if(!sLogList.isEmpty()){
                insert sLogList;
            } 
            
        }      
        //OM Reschedule
        if(o instanceof OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule){
            OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule a = (OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule) o;         
            OF_SA_GE_UtilsNew.slOMSF = new EOF_EAI_Service_Log__c(
             // EC Commento DIA 2019 04 05      RecordTypeId = (String.isBlank(a.TIPOLOGIA_SERVIZIO)) ? OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberNotify') : OF_SA_GE_UtilsNew.RTMap.get('OF_DIA_FiberNotify'),
                RecordTypeId = OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberNotify'),
                EOF_Tipo_COmunicazione_String__c='OM->SF - Reschedule',
                OF_SA_Direzione_Flusso__c='OM-SF',
                OF_SA_Metodo__c='OF_Reschedule',
                EOF_CODICE_OPERATORE__c=a.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c=a.CODICE_ORDINE_OLO,
                /*EOF_CODICE_ORDINE_EOF__c=a.CODICE_ORDINE_OF,*/
                EOF_DATA_NOTIFICA__c=StringToDate(a.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c=a.ID_NOTIFICA,
                EOF_NOME_CLIENTE__c=a.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__c=a.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=a.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=a.RECAPITO_TELEFONICO_CLIENTE_2,
                EOF_DATA_PREVISTA_ATTIVAZIONE__c=StringToDateNoTime(a.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__c=a.ORARIO_APPUNTAMENTO,
                EOF_CODICE_MOTIVAZIONE__c=a.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__c=a.MOTIVAZIONE,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            OF_SA_GE_UtilsNew.slOMSF.EOF_Response__c=OF_SA_GE_UtilsNew.Response;
            if(OF_SA_GE_UtilsNew.checkCaseOriginale){
                OF_SA_GE_UtilsNew.slOMSF.caso__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_SA_GE_UtilsNew.slOMSF.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_SA_GE_UtilsNew.slOMSF.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            
            
            insert OF_SA_GE_UtilsNew.slOMSF;
            
        } 
        //OM Completion order
        if(o instanceof OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder){
            
            OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder a = (OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder) o;         
             OF_SA_GE_UtilsNew.slOMSF= new EOF_EAI_Service_Log__c(
              // EC Commento DIA 2019 04 05     RecordTypeId = String.isBlank(a.TIPOLOGIA_SERVIZIO) ? OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberNotify') 
                                // EC Commento DIA 2019 04 05                                       : OF_SA_GE_UtilsNew.RTMap.get('OF_DIA_FiberNotify'),
                RecordTypeId = OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberNotify'),
                OF_SA_Direzione_Flusso__c='OM-SF',
                OF_SA_Metodo__c='OF_CompletionOrder_OpenStream',
                EOF_Tipo_COmunicazione_String__c='OM->SF - CompletionOrder',
                EOF_CODICE_OPERATORE__C=a.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__C=a.CODICE_ORDINE_OLO,
                EOF_CODICE_ORDINE_EOF__C=a.CODICE_ORDINE_OF,
                EOF_DATA_NOTIFICA__C=StringTODate(a.DATA_NOTIFICA), 
                EOF_ID_NOTIFICA__C=a.ID_NOTIFICA,
                EOF_STATO_ORDINE__c=a.STATO_ORDINE,
                EOF_CODICE_MOTIVAZIONE__c=a.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__c=a.MOTIVAZIONE,
                EOF_ID_RISORSA__C=a.ID_RISORSA,
                EOF_DATA_ESPLETAMENTO_ORDINE__C=StringTODateNoTime(a.DATA_ESPLETAMENTO_ORDINE),
                EOF_SCALA_PALAZZINA__c=a.SCALA_PALAZZINA,
                EOF_Parametri_Trasmissivi_Ottici__c = a.PARAMETRI_TRASMISSIVI_OTTICI,
                OF_SA_DDT__c=a.DDT, 
                //AA 291118 - Aggiunti nuovi campi richiesti
                OF_Id_Borchia__c = a.SERIALE_BORCHIA,
                EOF_GPON_Attestazione__c = a.GPON_DI_ATTESTAZIONE,
                EOF_Flag_Pagamento__c = a.FLAG_PAGAMENTO,
                EOF_Numero_Operatore__c = a.NUMERO_OPERATORE,
                OF_Bretella_Ottica__c = a.BRETELLA_OTTICA,
                OF_Estensione_Impianto_Effettuata__c = a.ESTENSIONE_IMPIANTO_EFFETTUATA,
                OF_Estensione_Impianto__c = a.ESTENSIONE_IMPIANTO,
                OF_Metri_TOT__c = a.METRI_TOT,
                EOF_ID_Splitter_Secondario__c = a.ID_SPLITTER_SECONDARIO,
                EOF_Posizione_Splitter_Secondario__c = a.POSIZIONE_SPLITTER_SECONDARIO,
                //FINE AA
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            OF_SA_GE_UtilsNew.slOMSF.EOF_Response__c=OF_SA_GE_UtilsNew.Response; 
            if(OF_SA_GE_UtilsNew.checkCaseOriginale){
                OF_SA_GE_UtilsNew.slOMSF.caso__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
            	OF_SA_GE_UtilsNew.slOMSF.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
            	OF_SA_GE_UtilsNew.slOMSF.EOF_Note__c = a.NOTE;
            }
            // finisce qui
                        
            insert OF_SA_GE_UtilsNew.slOMSF;
            Integer n = 1;

            List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
            if(a.apparato!=null && !a.apparato.isEmpty()){ 
                for(OF_WS_IN_OM_CompletionOrderNew.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_SA_GE_UtilsNew.RTMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.EOF_ESITO_CONSEGNA_APPARATO__c=app.ESITO_CONSEGNA_APPARATO;
                    sLog.OF_SA_ID_APPARATO_CONSEGNATO__c=app.ID_APPARATO_CONSEGNATO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_CONSEGNA__c=app.CODICE_MOTIVAZIONE_CONSEGNA;
                    sLog.OF_SA_MOTIVAZIONE_CONSEGNA__c=app.MOTIVAZIONE_CONSEGNA;
                    sLog.OF_SA_Cpe_Log__c=OF_SA_GE_UtilsNew.slOMSF.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
	                sLogList.add(sLog);
	                n++;
                }
            }
            if(a.servizio_Aggiuntivo!=null && !a.servizio_Aggiuntivo.isEmpty()){

                for(OF_WS_IN_OM_CompletionOrderNew.servizio_aggiuntivo sa : a.servizio_Aggiuntivo){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_SA_GE_UtilsNew.RTMap.get('OF_SA_Servizi_Aggiuntivi');
                    sLog.OF_SA_NOME_SERVIZIO__c=sa.NOME_SERVIZIO; 
                    sLog.OF_SA_ESITO_SERVIZIO__c=sa.ESITO_SERVIZIO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_SERVIZIO__c=sa.CODICE_MOTIVAZIONE_SERVIZIO;
                    sLog.OF_SA_MOTIVAZIONE_SERVIZIO__c=sa.MOTIVAZIONE_SERVIZIO;
                    sLog.OF_SA_servizi_Aggiuntivi_Log__c=OF_SA_GE_UtilsNew.slOMSF.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
	                sLogList.add(sLog);
	                n++;
                } 
            } 
            if(!sLogList.isEmpty()){
                insert sLogList;
            }        
        }       
        //Nuova deactivation
        if(o instanceof OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest){
            OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest a = (OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest) o;         
            OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c(
            // EC Commento DIA 2019 04 05       RecordTypeId = (String.isBlank(a.TIPOLOGIA_SERVIZIO)) ? OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberRequest') : OF_SA_GE_UtilsNew.RTMap.get('OF_DIA_FiberRequest'),
                RecordTypeId = OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberRequest'),
                EOF_Tipo_COmunicazione_String__c='OLO->SF - DeactivationRequest',
                OF_SA_Direzione_Flusso__c='OLO-SF',
                OF_SA_Metodo__c='OLO_DeactivationOrder',
                EOF_CODICE_OPERATORE__c=a.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c=a.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__c=StringToDate(a.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c=a.ID_NOTIFICA,
                EOF_ID_RISORSA__c = a.ID_RISORSA,
                EOF_NOME_CLIENTE__c=a.NOME_CLIENTE, 
                EOF_COGNOME_CLIENTE__c=a.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=a.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=a.RECAPITO_TELEFONICO_CLIENTE_2,
                //aa aggiunto campo 29/11/2018
                TRACCIATO_TRASCODIFICATO__c=a.TRACCIATO_TRASCODIFICATO,
                OF_Codice_Operatore_Secondario__c = a.CODICE_OPERATORE_SECONDARIO,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: a.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                OF_SA_GE_UtilsNew.caseOriginale=cList[0];
                OF_SA_GE_UtilsNew.checkCaseOriginale=true;
                OF_SA_GE_UtilsNew.slOLOSF.caso__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_SA_GE_UtilsNew.slOLOSF.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_SA_GE_UtilsNew.slOLOSF.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            insert OF_SA_GE_UtilsNew.slOLOSF;
            
            if(a.apparato!=null && !a.apparato.isEmpty()){
                Integer n = 1;
                OF_SA_GE_UtilsNew.checkApp=true;
                OF_SA_GE_UtilsNew.listApp=new list<EOF_EAI_Service_Log__C>();
                for(OF_SA_WS_IN_OLO_DeactivationNew.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.EOF_Tipo_COmunicazione_String__c='CPE';
                    sLog.recordtypeid=OF_SA_GE_UtilsNew.RTMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLog.OF_SA_Cpe_Log__c=OF_SA_GE_UtilsNew.slOLOSF.id;
                    OF_SA_GE_UtilsNew.listApp.add(sLog);
                    n++;
                }
                insert OF_SA_GE_UtilsNew.listApp;
            }
            return OF_SA_GE_UtilsNew.slOLOSF;
        }      
        //AA - Nuovo Status Update
        if(o instanceof OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest){
            OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur = (OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberRequest'),
                EOF_Tipo_COmunicazione_String__c='OLO->SF - StatusUpdateRequest',
                OF_SA_Direzione_Flusso__c='OLO-SF',
                OF_SA_Metodo__c='OLO_StatusUpdate',
                EOF_CODICE_OPERATORE__C=sur.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__C=sur.CODICE_ORDINE_OLO,
                EOF_ID_NOTIFICA__C=sur.ID_NOTIFICA,
                OF_SA_AZIONE__C=sur.AZIONE,
                EOF_CODICE_MOTIVAZIONE__C=sur.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__C=(sur.MOTIVAZIONE != null && sur.MOTIVAZIONE.length() > 255) ? sur.MOTIVAZIONE.abbreviate(255) : sur.MOTIVAZIONE,
                EOF_ORARIO_APPUNTAMENTO__C=sur.ORARIO_APPUNTAMENTO,
                EOF_NOME_CLIENTE__C=sur.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__C=sur.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__C=sur.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = sur.RECAPITO_TELEFONICO_CLIENTE_2,
                EOF_Richiesta_Notifica__c = copy_request(sur)
            );
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: sur.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                sl.caso__c=cList[0].Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(sur.NOTE) && sur.NOTE!=null){
                sl.EOF_Note__c= sur.NOTE.abbreviate(255);
            }
            else{
                sl.EOF_Note__c = sur.NOTE;
            }
            
            try{
                if(checkDate(sur.DATA_PREVISTA_ATTIVAZIONE)){
                    sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c = StringTODateNoTime(sur.DATA_PREVISTA_ATTIVAZIONE);
                }
                if(checkDateTime(sur.DATA_NOTIFICA)){
                    sl.EOF_DATA_NOTIFICA__C=StringTODate(sur.DATA_NOTIFICA);
                }
            }catch(exception e){
                system.debug('Errore - La data è in formato:'+ sur.DATA_PREVISTA_ATTIVAZIONE);
            }            
            // finisce qui
            
            //CRM Fix Tibco result=null 26_06_2017
            
            //insert sl;
            //('OSCRM test_sl:'+sl);
            return sl;        
        }
        //AA - Nuovo Reschedule 
        if(o instanceof OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest){
            OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest r = (OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberRequest'),
                EOF_Tipo_COmunicazione_String__c='OLO->SF - RescheduleRequest',
                OF_SA_Direzione_Flusso__c='OLO-SF',
                OF_SA_Metodo__c='OLO_Reschedule',
                EOF_CODICE_OPERATORE__C=r.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__C=r.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__C=StringTODate(r.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__C=r.ID_NOTIFICA,
                EOF_NOME_CLIENTE__C=r.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__C=r.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__C=r.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__C=r.RECAPITO_TELEFONICO_CLIENTE_2, 
                //EOF_DATA_PREVISTA_ATTIVAZIONE__C=StringTODateNoTime(r.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__C=r.ORARIO_APPUNTAMENTO,
                EOF_NOTE__C=r.NOTE,
                EOF_CODICE_MOTIVAZIONE__C=r.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__C=r.MOTIVAZIONE,
                EOF_Richiesta_Notifica__c = copy_request(r)
            );
            sl.OF_SH_Token_id__c = (r.IDENTIFICATIVO_PRENOTAZIONE != null && r.IDENTIFICATIVO_PRENOTAZIONE.length() > 50) ? r.IDENTIFICATIVO_PRENOTAZIONE.abbreviate(50) : r.IDENTIFICATIVO_PRENOTAZIONE;
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: r.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                sl.caso__c=cList[0].Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(r.NOTE) && r.NOTE!= null){
                sl.EOF_Note__c= r.NOTE.abbreviate(255);
            }else{
                sl.EOF_Note__c = r.NOTE;
            }
            // finisce qui
            try{
                sl.EOF_DATA_PREVISTA_ATTIVAZIONE__C=StringTODateNoTime(r.DATA_PREVISTA_ATTIVAZIONE);
            }catch(exception e){
                system.debug('Errore - La data è in formato:'+ r.DATA_PREVISTA_ATTIVAZIONE);
            }                                    
            return sl;   
        }
        //FINE AA        
        if(o instanceof Map<String, String>){
            
            if(((Map<String, String>) o).get('Type') == 'ACK'){ 
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_SA_GE_UtilsNew.RTMap.get('OF_SA_ACK'),
                    Caso__c = ((Map<String, String>) o).get('Caso'),
                    OF_SA_Direzione_Flusso__c=((Map<String, String>) o).get('Flusso'),
                    OF_SA_Metodo__c=((Map<String, String>) o).get('Metodo'),
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
                
                if(OF_SA_GE_UtilsNew.checkCaseOriginale){
                    sl.Caso__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
                }
                return sl;
            }
            
            if(((Map<String, String>) o).get('Type') == 'NACK'){
                OF_Utility.logMessage( true, 'L','OF_SA_GE_UtilsNew','syncError','Map<String, String>) o).get(\'Type\'):'+((Map<String, String>) o).get('Type'));
                String s=''; 
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_SA_GE_UtilsNew.RTMap.get('OF_SA_NACK'),
                    OF_SA_Direzione_Flusso__c=((Map<String, String>) o).get('Flusso'),
                    OF_SA_Metodo__c=((Map<String, String>) o).get('Metodo'),
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
                if(OF_SA_GE_UtilsNew.checkCaseOriginale){
                    sl.Caso__c=OF_SA_GE_UtilsNew.caseOriginale.Id;
                }
                return sl;
            }
        }         
        
        return null;
    }     
    //Copy_Request
    public static String copy_request(object o){
        String s;
        String data_prevista_attivazione='';
        //attivazione nuova pre SF
        if(o instanceOf OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest){
            OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest a = (OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest) o;
            
            s=  'CODICE_OPERATORE: '+ a.CODICE_OPERATORE + '\n' +
                'CODICE_ORDINE_OLO: '+ a.CODICE_ORDINE_OLO + '\n' +
                'DATA_NOTIFICA: '+ a.DATA_NOTIFICA + '\n' +
                'ID_NOTIFICA: '+ a.DATA_NOTIFICA + '\n' +
                'NOME_REFERENTE_TECNICO_OLO: '+ a.NOME_REFERENTE_TECNICO_OLO + '\n' +
                'COGNOME_REFERENTE_TECNICO_OLO: '+ a.COGNOME_REFERENTE_TECNICO_OLO + '\n' +
                'TELEFONO_REFERENTE_TECNICO_OLO: '+ a.TELEFONO_REFERENTE_TECNICO_OLO + '\n' +
                'EMAIL_REFERENTE_TECNICO_OLO: '+ a.EMAIL_REFERENTE_TECNICO_OLO + '\n' +
                'TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH: '+ a.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH + '\n' +
                'NOME_CLIENTE: '+ a.NOME_CLIENTE + '\n' +
                'COGNOME_CLIENTE: '+ a.COGNOME_CLIENTE + '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: '+ a.RECAPITO_TELEFONICO_CLIENTE_1 + '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: '+ a.RECAPITO_TELEFONICO_CLIENTE_2 + '\n' +
                'INFORMAZIONI_LOGISTICA_APPARATI: '+ a.INFORMAZIONI_LOGISTICA_APPARATI + '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: '+ a.DATA_PREVISTA_ATTIVAZIONE + '\n' +
                'ORARIO_APPUNTAMENTO: '+ a.ORARIO_APPUNTAMENTO + '\n' +
                'CODICE_PROGETTO_SPECIALE: '+ a.CODICE_PROGETTO_SPECIALE + '\n' +
                'PROMOZIONE: '+ a.PROMOZIONE + '\n' +
                'CLUSTER_PROMOZIONE: '+ a.CLUSTER_PROMOZIONE + '\n' +
                'NOTE: '+ a.NOTE + '\n' +
                'ID_BUILDING: '+ a.ID_BUILDING + '\n' +
                'SCALA_PALAZZINA: '+ a.SCALA_PALAZZINA + '\n' +
                'NUMERO_TELEFONICO_PRINCIPALE_LINEA: '+ a.NUMERO_TELEFONICO_PRINCIPALE_LINEA + '\n' +
                'RECAPITO_TEST_LINEA: '+ a.RECAPITO_TEST_LINEA + '\n' +
                'IDENTIFICATIVO_DEL_POP: '+ a.IDENTIFICATIVO_DEL_POP + '\n' +
                'PROFILO: '+ a.PROFILO + '\n' +
                'IDENTIFICATIVO_PRENOTAZIONE: ' + a.IDENTIFICATIVO_PRENOTAZIONE + '\n';
            if(a.servizio_Aggiuntivo!=null && !a.servizio_Aggiuntivo.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OLO_ActivationNew.servizio_aggiuntivo sa : a.servizio_Aggiuntivo){
                    s=                                                                                           s+ '\n' + 'SERVIZIO AGGIUNTIVO '+n+': \n' +
                        'NOME_SERVIZIO: '+sa.NOME_SERVIZIO+'\n' +
                        'INFORMAZIONI_SERVIZIO: '+sa.INFORMAZIONI_SERVIZIO+'\n' ;
                    n++;
                } 
            }  
            if(a.apparato!=null && !a.apparato.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OLO_ActivationNew.apparato app : a.apparato){
                    s=                                                                                           s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'PASSWORD_APPARATO: '+app.PASSWORD_APPARATO+'\n' +
                        'AZIONE_APPARATO: '+app.AZIONE_APPARATO+'\n' +
                        'CAUSALE: ' + app.CAUSALE + '\n';
                    n++;
                }
            }
            if(a.VLAN!=null && !a.VLAN.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OLO_ActivationNew.VLAN v : a.VLAN){
                    s=                                                                                           s+ '\n' + 'VLAN '+n+': \n' +
                        'KIT_CONSEGNA_VLAN: '+ v.KIT_CONSEGNA_VLAN + '\n' +
                        'USER_VLAN: '+ v.USER_VLAN + '\n' +
                        'SERVICE_VLAN: '+ v.SERVICE_VLAN + '\n' +
                        'PROFILO_VLAN: '+ v.PROFILO_VLAN + '\n' +
                        'INFORMAZIONI_VLAN: '+ v.INFORMAZIONI_VLAN + '\n' +
                        'CUSTOMER_VLAN: '+ v.CUSTOMER_VLAN + '\n' +
                        'MODELLO_DI_SERVIZIO_VLAN: '+ v.MODELLO_DI_SERVIZIO_VLAN + '\n';
                    n++;
                }
            }     
        }
        //Nuova disattivazione sky
        if(o instanceOf OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest){
            OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest Deact = (OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest) o;
            
            s=  'CODICE_OPERATORE: '+ Deact.CODICE_OPERATORE + '\n' +
                'CODICE_ORDINE_OLO: '+ Deact.CODICE_ORDINE_OLO + '\n' +
                'DATA_NOTIFICA: '+ Deact.DATA_NOTIFICA + '\n' +
                'ID_NOTIFICA: '+ Deact.ID_NOTIFICA + '\n' +
                'ID_RISORSA: '+ Deact.ID_RISORSA + '\n' +
                'NOME_CLIENTE: '+ Deact.NOME_CLIENTE + '\n' +
                'COGNOME_CLIENTE: '+ Deact.COGNOME_CLIENTE + '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: '+ Deact.RECAPITO_TELEFONICO_CLIENTE_1 + '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: '+ Deact.RECAPITO_TELEFONICO_CLIENTE_2 + '\n' +
                'NOTE: '+ Deact.NOTE + '\n' ; 
            
            if(Deact.apparato!=null && !Deact.apparato.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OLO_DeactivationNew.apparato app : Deact.apparato){
                    s = s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n';
                    n++;
                }
            }
        }
        //RescheduleNew da OLO pre SF
        if(o instanceOf OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest){
            OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest r = (OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest) o;
            
            s=  'CODICE_OPERATORE: '+ r.CODICE_OPERATORE  + '\n' +
                'CODICE_ORDINE_OLO: '+ r.CODICE_ORDINE_OLO  + '\n' +
                'DATA_NOTIFICA: '+ r.DATA_NOTIFICA  + '\n' +
                'ID_NOTIFICA: '+ r.ID_NOTIFICA  + '\n' +
                'CODICE_MOTIVAZIONE: '+ r.CODICE_MOTIVAZIONE  + '\n' + 
                'MOTIVAZIONE: '+ r.MOTIVAZIONE  + '\n' +
                'NOME_CLIENTE: '+ r.NOME_CLIENTE  + '\n' +
                'COGNOME_CLIENTE: '+ r.COGNOME_CLIENTE  + '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: '+ r.RECAPITO_TELEFONICO_CLIENTE_1  + '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: '+ r.RECAPITO_TELEFONICO_CLIENTE_2  + '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: '+ r.DATA_PREVISTA_ATTIVAZIONE  + '\n' +
                'ORARIO_APPUNTAMENTO: '+ r.ORARIO_APPUNTAMENTO  + '\n' +
                'NOTE: '+ r.NOTE  + '\n' +
                'IDENTIFICATIVO_PRENOTAZIONE: ' + r.IDENTIFICATIVO_PRENOTAZIONE + '\n' ;
            
        }
        if(o instanceOf OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest){
            OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest su = (OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest) o;
            
            s=  'CODICE_OPERATORE: '+ su.CODICE_OPERATORE  + '\n' + 
                'CODICE_ORDINE_OLO: '+ su.CODICE_ORDINE_OLO  + '\n' +
                'DATA_NOTIFICA: '+ su.DATA_NOTIFICA  + '\n' +
                'ID_NOTIFICA: '+ su.ID_NOTIFICA  + '\n' +
                'AZIONE: '+ su.AZIONE  + '\n' +
                'CODICE_MOTIVAZIONE: '+ su.CODICE_MOTIVAZIONE  + '\n' +
                'MOTIVAZIONE: '+ su.MOTIVAZIONE  + '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: '+ su.DATA_PREVISTA_ATTIVAZIONE  + '\n' +
                'ORARIO_APPUNTAMENTO: '+ su.ORARIO_APPUNTAMENTO  + '\n' +
                'NOME_CLIENTE: '+ su.NOME_CLIENTE  + '\n' +
                'COGNOME_CLIENTE: '+ su.COGNOME_CLIENTE  + '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: '+ su.RECAPITO_TELEFONICO_CLIENTE_1  + '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: '+ su.RECAPITO_TELEFONICO_CLIENTE_2  + '\n' +
                'NOTE: '+ su.NOTE  + '\n' ;
            
        }
        //Completion Order pre SF
        if(o instanceOf OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder){
            OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = (OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder) o;
            
            s = 'CODICE_OPERATORE: ' +co.CODICE_OPERATORE+ '\n' +
                'CODICE_ORDINE_OLO: ' +co.CODICE_ORDINE_OLO+ '\n' +
                'CODICE_ORDINE_EOF: ' +co.CODICE_ORDINE_OF+ '\n' + 
                'DATA_NOTIFICA: ' +co.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +co.ID_NOTIFICA+ '\n' +
                'STATO_ORDINE: ' +co.STATO_ORDINE+ '\n' +
                'CODICE_MOTIVAZIONE: ' +co.CODICE_MOTIVAZIONE+ '\n' +
                'MOTIVAZIONE: ' +co.MOTIVAZIONE+ '\n' +
                'ID_RISORSA: ' +co.ID_RISORSA+ '\n' +
                'DATA_ESPLETAMENTO_ORDINE : ' +co.DATA_ESPLETAMENTO_ORDINE + '\n' +
                'SCALA_PALAZZINA: ' +co.SCALA_PALAZZINA+ '\n' +
                'PARAMETRI_TRASMISSIVI_OTTICI: ' + co.PARAMETRI_TRASMISSIVI_OTTICI + '\n' +
                'DDT: '+co.DDT+ '\n' +
                'NOTE: ' +co.NOTE+ '\n' ; 
            
            if(co.servizio_Aggiuntivo!=null && !co.servizio_Aggiuntivo.isEmpty()){
                Integer n = 1;
                for(OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sa : co.servizio_Aggiuntivo){
                    s = s + '\n' + 'SERVIZIO AGGIUNTIVO '+n+': \n' +
                        'NOME_SERVIZIO: '+sa.NOME_SERVIZIO+'\n' +
                        'ESITO_SERVIZIO: '+sa.ESITO_SERVIZIO+'\n' +
                        'CODICE_MOTIVAZIONE_SERVIZIO: '+sa.CODICE_MOTIVAZIONE_SERVIZIO+'\n' +
                        'MOTIVAZIONE_SERVIZIO: '+sa.MOTIVAZIONE_SERVIZIO+'\n';
                    n++;
                } 
            }
            if(co.apparato!=null && !co.apparato.isEmpty()){
                Integer n = 1;
                for(OF_WS_IN_OM_CompletionOrderNew.APPARATO app : co.apparato){
                    s = s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'ESITO_CONSEGNA_APPARATO: '+app.ESITO_CONSEGNA_APPARATO+'\n' +
                        'ID_APPARATO_CONSEGNATO: '+app.ID_APPARATO_CONSEGNATO+'\n' +
                        'CODICE_MOTIVAZIONE_CONSEGNA: '+app.CODICE_MOTIVAZIONE_CONSEGNA+'\n' +
                        'MOTIVAZIONE_CONSEGNA: '+app.MOTIVAZIONE_CONSEGNA+'\n' ;
                    n++;
                }
            } 
        }
        //Reschedule da OM pre SF
        if(o instanceOf OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule){
            OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = (OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule) o;
            
            s = 'CODICE_OPERATORE: ' +r.CODICE_OPERATORE+ '\n' +
                'CODICE_ORDINE_OLO: ' +r.CODICE_ORDINE_OLO+ '\n' +
                /*'CODICE_ORDINE_OF: '+r.CODICE_ORDINE_OF+'\n'+*/
                'DATA_NOTIFICA: ' +r.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +r.ID_NOTIFICA+ '\n' +
                'NOME_CLIENTE: ' +r.NOME_CLIENTE+ '\n' +
                'COGNOME_CLIENTE: ' +r.COGNOME_CLIENTE+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: ' +r.RECAPITO_TELEFONICO_CLIENTE_1+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: ' +r.RECAPITO_TELEFONICO_CLIENTE_2+ '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: ' +r.DATA_PREVISTA_ATTIVAZIONE+ '\n' +
                'ORARIO_APPUNTAMENTO: ' +r.ORARIO_APPUNTAMENTO+ '\n' +
                'CODICE_MOTIVAZIONE: ' +r.CODICE_MOTIVAZIONE+ '\n' +
                'MOTIVAZIONE: ' +r.MOTIVAZIONE+ '\n' +
                'NOTE: ' +r.NOTE+ '\n' ;
        } 
        //status Update da OM pre SF
        if(o instanceOf OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate){
            OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = (OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate) o;
            
            s=  'CODICE_OPERATORE: ' +su.CODICE_OPERATORE+ '\n' +
                'CODICE_ORDINE_OLO: ' +su.CODICE_ORDINE_OLO+ '\n' +
                'CODICE_ORDINE_OF: ' +su.CODICE_ORDINE_OF+ '\n' +
                'DATA_NOTIFICA: ' +su.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +su.ID_NOTIFICA+ '\n' +
                'STATO_ORDINE: ' +su.STATO_ORDINE+ '\n' +  
                'CODICE_MOTIVAZIONE: ' +su.CODICE_MOTIVAZIONE+ '\n' +
                'MOTIVAZIONE: ' +su.MOTIVAZIONE+ '\n' +
                'GPON_DI_ATTESTAZIONE: ' +su.GPON_DI_Attestazione+ '\n' +
                'ID_SERVIZIO: ' + su.ID_SERVIZIO + '\n' +
                'NOME_CLIENTE: ' +su.NOME_CLIENTE+ '\n' +
                'COGNOME_CLIENTE: ' +su.COGNOME_CLIENTE+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE: ' +su.RECAPITO_TELEFONICO_CLIENTE+ '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: ' +su.DATA_PREVISTA_ATTIVAZIONE+ '\n' +
                'ORARIO_APPUNTAMENTO: ' +su.ORARIO_APPUNTAMENTO+ '\n' +
                'PIN_INTERVENTO_A_VUOTO: ' +su.PIN_INTERVENTO_A_VUOTO+ '\n' + 
                'NOTE: ' +su.NOTE+ '\n' ; 
            if(su.apparato!=null && !su.apparato.isEmpty()){
                Integer n = 1;
                for(OF_WS_IN_OM_StatusUpdateNew.APPARATO app : su.apparato){
                    s = s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'ESITO_RITIRO_APPARATO: '+app.ESITO_RITIRO_APPARATO+'\n' +
                        'CODICE_MOTIVAZIONE_RITIRO: '+app.CODICE_MOTIVAZIONE_RITIRO+'\n' +
                        'MOTIVAZIONE_RITIRO: '+app.MOTIVAZIONE_RITIRO+'\n' +
                        'ID_APPARATO: ' + app.ID_APPARATO +'\n';
                    n++;
                }
            } 
            if(su.VLan!=null && !su.VLan.isEmpty()){
                Integer n = 1;
                for(OF_WS_IN_OM_StatusUpdateNew.VLAN v : su.VLan){
                    s = s + '\n' + 'VLAN '+n+': \n' +
                        'USER_VLAN: '+v.USER_VLAN+'\n' +
                        'SERVICE_VLAN: '+v.SERVICE_VLAN+'\n' +
                        'CUSTOMER_VLAN: '+v.CUSTOMER_VLAN+'\n' ;
                    n++;
                }
            }
        }
        //Completion Order post SF
        if(o instanceOf OF_SA_WS_OLO_classi.NotificaOrdineGpona_element){
            OF_SA_WS_OLO_classi.NotificaOrdineGpona_element request_x = (OF_SA_WS_OLO_classi.NotificaOrdineGpona_element) o;
            
            s=                                                                                           'CODICE_OPERATORE: ' +request_x.CODICE_OPERATORE+ '\n' +
                'CODICE_ORDINE_OLO: ' +request_x.CODICE_ORDINE_OLO+ '\n' +
                'CODICE_ORDINE_EOF: ' +request_x.CODICE_ORDINE_EOF+ '\n' + 
                'DATA_NOTIFICA: ' +request_x.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +request_x.ID_NOTIFICA+ '\n' +
                'STATO_ORDINE: ' +request_x.STATO_ORDINE+ '\n' +
                'CODICE_MOTIVAZIONE: ' +request_x.CODICE_MOTIVAZIONE+ '\n' +
                'MOTIVAZIONE: ' +request_x.MOTIVAZIONE+ '\n' +
                'ID_RISORSA: ' +request_x.ID_RISORSA+ '\n' +
                'DATA_ESPLETAMENTO_ORDINE : ' +request_x.DATA_ESPLETAMENTO_ORDINE + '\n' +
                'SCALA_PALAZZINA: ' +request_x.SCALA_PALAZZINA+ '\n' +
                'DDT: '+request_x.DDT+ '\n' +
                'NOTE: ' +request_x.NOTE+ '\n' ; 
            if(request_x.servizio_Aggiuntivo!=null && !request_x.servizio_Aggiuntivo.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_OLO_classi.SERVIZIO_AGGIUNTIVO_element sa : request_x.servizio_Aggiuntivo){
                    s=          s+ '\n' + 'SERVIZIO AGGIUNTIVO '+n+': \n' +
                        'NOME_SERVIZIO: '+sa.NOME_SERVIZIO+'\n' +
                        'ESITO_SERVIZIO: '+sa.ESITO_SERVIZIO+'\n' +
                        'CODICE_MOTIVAZIONE_SERVIZIO: '+sa.CODICE_MOTIVAZIONE_SERVIZIO+'\n' +
                        'MOTIVAZIONE_SERVIZIO: '+sa.MOTIVAZIONE_SERVIZIO+'\n';
                    n++;
                } 
            }
            if(request_x.apparato!=null && !request_x.apparato.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_OLO_Classi.CONSEGNA_APPARATO_element app : request_x.apparato){
                    s=          s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'ESITO_CONSEGNA_APPARATO: '+app.ESITO_CONSEGNA_APPARATO+'\n' +
                        'ID_APPARATO_CONSEGNATO: '+app.ID_APPARATO_CONSEGNATO+'\n' +
                        'CODICE_MOTIVAZIONE_CONSEGNA: '+app.CODICE_MOTIVAZIONE_CONSEGNA+'\n' +
                        'MOTIVAZIONE_CONSEGNA: '+app.MOTIVAZIONE_CONSEGNA+'\n' ;
                    n++;
                }
            }  
        }
        //Reschedule da OM post SF
        if(o instanceOf OF_SA_WS_OLO_Classi.NotificaRischedulazione_element){
            OF_SA_WS_OLO_Classi.NotificaRischedulazione_element request_x = (OF_SA_WS_OLO_Classi.NotificaRischedulazione_element) o;
            
            s=                                                                                           'CODICE_OPERATORE: ' +request_x.CODICE_OPERATORE+ '\n' +
                'CODICE_ORDINE_OLO: ' +request_x.CODICE_ORDINE_OLO+ '\n' +
                //'CODICE_ORDINE_OF: ' +request_x.CODICE_ORDINE_OF+ '\n' +
                'DATA_NOTIFICA: ' +request_x.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +request_x.ID_NOTIFICA+ '\n' +
                'NOME_CLIENTE: ' +request_x.NOME_CLIENTE+ '\n' +
                'COGNOME_CLIENTE: ' +request_x.COGNOME_CLIENTE+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: ' +request_x.RECAPITO_TELEFONICO_CLIENTE_1+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: ' +request_x.RECAPITO_TELEFONICO_CLIENTE_2+ '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: ' +request_x.DATA_PREVISTA_ATTIVAZIONE+ '\n' +
                'ORARIO_APPUNTAMENTO: ' +request_x.ORARIO_APPUNTAMENTO+ '\n' +
                'CODICE_MOTIVAZIONE: ' +request_x.CODICE_MOTIVAZIONE+ '\n' +
                'MOTIVAZIONE: ' +request_x.MOTIVAZIONE+ '\n' +
                'NOTE: ' +request_x.NOTE+ '\n' ;
        }
        //status Update da OM post SF
        if(o instanceOf OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element){
            OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element request_x = (OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element) o;
            
            s=                                                                                           'CODICE_OPERATORE: ' +request_x.CODICE_OPERATORE+ '\n' +
                'CODICE_ORDINE_OLO: ' +request_x.CODICE_ORDINE_OLO+ '\n' +
                'CODICE_ORDINE_OF: ' +request_x.CODICE_ORDINE_OF+ '\n' +
                'DATA_NOTIFICA: ' +request_x.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +request_x.ID_NOTIFICA+ '\n' +
                'STATO_ORDINE: ' +request_x.STATO_ORDINE+ '\n' +  
                'CODICE_MOTIVAZIONE: ' +request_x.CODICE_MOTIVAZIONE+ '\n' +
                'MOTIVAZIONE: ' +request_x.MOTIVAZIONE+ '\n' +
                'GPON_DI_ATTESTAZIONE: ' +request_x.GPON_DI_Attestazione+ '\n' +
                'NOME_CLIENTE: ' +request_x.NOME_CLIENTE+ '\n' +
                'COGNOME_CLIENTE: ' +request_x.COGNOME_CLIENTE+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE: ' +request_x.RECAPITO_TELEFONICO_CLIENTE+ '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: ' +request_x.DATA_PREVISTA_ATTIVAZIONE+ '\n' +
                'ORARIO_APPUNTAMENTO: ' +request_x.ORARIO_APPUNTAMENTO+ '\n' +
                'PIN_INTERVENTO_A_VUOTO: ' +request_x.PIN_INTERVENTO_A_VUOTO+ '\n' + 
                'NOTE: ' +request_x.NOTE+ '\n' ; 
            if(request_x.apparato!=null && !request_x.apparato.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_OLO_Classi.RITIRO_APPARATO_element app : request_x.apparato){
                    s=          s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'ESITO_RITIRO_APPARATO: '+app.ESITO_RITIRO_APPARATO+'\n' +
                        'CODICE_MOTIVAZIONE_RITIRO: '+app.CODICE_MOTIVAZIONE_RITIRO+'\n' +
                        'MOTIVAZIONE_RITIRO: '+app.MOTIVAZIONE_RITIRO+'\n' ;
                    n++;
                }
            } 
            if(request_x.VLan!=null && !request_x.VLan.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_OLO_Classi.VLAN_element v : request_x.VLan){
                    s=          s+ '\n' + 'VLAN '+n+': \n' +
                        'USER_VLAN: '+v.USER_VLAN+'\n' +
                        'SERVICE_VLAN: '+v.SERVICE_VLAN+'\n' +
                        'CUSTOMER_VLAN: '+v.CUSTOMER_VLAN+'\n' ;
                    n++;
                }
            }
        }
        
        //Attivazione da OLO
        if(o instanceOf OF_SA_WS_OM_Classi.AttivazioneGpona_element){
            OF_SA_WS_OM_Classi.AttivazioneGpona_element request_x = (OF_SA_WS_OM_Classi.AttivazioneGpona_element) o;
            
            s=                                                                                           'CODICE_OPERATORE: ' +request_x.CODICE_OPERATORE+ '\n' + 
                'CODICE_ORDINE_OLO: ' +request_x.CODICE_ORDINE_OLO+ '\n' +
                'DATA_NOTIFICA: ' +request_x.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +request_x.ID_NOTIFICA+ '\n' +
                'NOME_REFERENTE_TECNICO_OLO: ' +request_x.NOME_REFERENTE_TECNICO_OLO+ '\n' +
                'COGNOME_REFERENTE_TECNICO_OLO: ' +request_x.COGNOME_REFERENTE_TECNICO_OLO+ '\n' +
                'TELEFONO_REFERENTE_TECNICO_OLO: ' +request_x.TELEFONO_REFERENTE_TECNICO_OLO+ '\n' +
                'EMAIL_REFERENTE_TECNICO_OLO: ' +request_x.EMAIL_REFERENTE_TECNICO_OLO+ '\n' +
                'TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH: ' +request_x.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH+ '\n' +
                'NOME_CLIENTE: ' +request_x.NOME_CLIENTE+ '\n' +
                'COGNOME_CLIENTE: ' +request_x.COGNOME_CLIENTE+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: ' +request_x.RECAPITO_TELEFONICO_CLIENTE_1+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: ' +request_x.RECAPITO_TELEFONICO_CLIENTE_2+ '\n' +
                'INFORMAZIONI_LOGISTICA_APPARATI: ' +request_x.INFORMAZIONI_LOGISTICA_APPARATI+ '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: ' +request_x.DATA_PREVISTA_ATTIVAZIONE+ '\n' +
                'ORARIO_APPUNTAMENTO: ' +request_x.ORARIO_APPUNTAMENTO+ '\n' +
                'CODICE_PROGETTO_SPECIALE: ' +request_x.CODICE_PROGETTO_SPECIALE+ '\n' +
                'PROMOZIONE: ' +request_x.PROMOZIONE+ '\n' +
                'CLUSTER_PROMOZIONE: ' +request_x.CLUSTER_PROMOZIONE+ '\n' +
                'NOTE: ' +request_x.NOTE+ '\n' + 
                'ID_BUILDING: ' +request_x.ID_BUILDING+ '\n' +
                'SCALA_PALAZZINA: ' +request_x.SCALA_PALAZZINA+ '\n' +
                'NUMERO_TELEFONICO_PRINCIPALE_LINEA: ' +request_x.NUMERO_TELEFONICO_PRINCIPALE_LINEA+ '\n' +
                'RECAPITO_TEST_LINEA: ' +request_x.RECAPITO_TEST_LINEA+ '\n' +
                'IDENTIFICATIVO_DEL_POP: ' +request_x.IDENTIFICATIVO_DEL_POP+ '\n' +            
                'SORGENTE: ' +request_x.SORGENTE+ '\n' +
                'CODICE_ORDINE_OF: ' +request_x.CODICE_ORDINE_OF+ '\n' +
                'SLA_DATE: ' +request_x.SLA_DATE+ '\n' +
                'GPON_ATTESTAZIONE: ' +request_x.GPON_ATTESTAZIONE+ '\n' +
                'GPON_VINCOLANTE: ' +request_x.GPON_VINCOLANTE+ '\n' +
                'ID_RISORSA: ' +request_x.ID_RISORSA+ '\n' +
                'OPZIONE_SYSTEM_UNICO: ' +request_x.OPZIONE_SYSTEM_UNICO+ '\n' +
                'CODICE_MOTIVAZIONE: ' +request_x.CODICE_MOTIVAZIONE+ '\n' +
                'MOTIVAZIONE: ' +request_x.MOTIVAZIONE+ '\n' +
                'COLLEGAMENTO_P2P: ' +request_x.COLLEGAMENTO_P2P+ '\n' +
                'TRACCIATO: ' +request_x.TRACCIATO+ '\n' +
                'ID_SERVIZIO: ' +request_x.ID_SERVIZIO+ '\n' +
                'PROFILO: ' +request_x.PROFILO+ '\n' +
                'PROVINCIA: ' +request_x.PROVINCIA+ '\n' +
                'COMUNE: ' +request_x.COMUNE+ '\n' +
                'INDIRIZZO: ' +request_x.INDIRIZZO+ '\n' + 
                'NUMERO_CIVICO: ' +request_x.NUMERO_CIVICO+ '\n' +
                'NUMERO_CIVICO: ' +request_x.NUMERO_CIVICO+ '\n' +
                'PARTICELLA_TOPONOMASTICA: ' +request_x.PARTICELLA_TOPONOMASTICA+ '\n' +
                'SLA_PREMIUM_ASSURANCE: ' +request_x.SLA_PREMIUM_ASSURANCE+ '\n' ;
            if(request_x.SERVIZIO_AGGIUNTIVO!=null && !request_x.SERVIZIO_AGGIUNTIVO.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element sa : request_x.SERVIZIO_AGGIUNTIVO){
                    s=          s+ '\n' + 'SERVIZIO_AGGIUNTIVO '+n+': \n' +
                        'NOME_SERVIZIO: '+sa.NOME_SERVIZIO+'\n' +
                        'INFORMAZIONI_SERVIZIO: '+sa.INFORMAZIONI_SERVIZIO+'\n';
                    n++;
                }
            } 
            if(request_x.apparato!=null && !request_x.apparato.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element app : request_x.apparato){
                    s=          s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'PASSWORD_APPARATO: '+app.PASSWORD_APPARATO+'\n' +
                        'AZIONE_APPARATO: '+app.AZIONE_APPARATO+'\n';
                    n++;
                }
            } 
            if(request_x.VLAN!=null && !request_x.VLAN.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_OM_Classi.VLAN_element v : request_x.VLAN){
                    s=          s+ '\n' + 'VLAN '+n+': \n' +
                        'KIT_CONSEGNA_VLAN: '+ v.KIT_CONSEGNA_VLAN + '\n' +
                        'USER_VLAN: '+ v.USER_VLAN + '\n' +
                        'SERVICE_VLAN: '+ v.SERVICE_VLAN + '\n' +
                        'PROFILO_VLAN: '+ v.PROFILO_VLAN + '\n' +
                        'INFORMAZIONI_VLAN: '+ v.INFORMAZIONI_VLAN + '\n' +
                        'CUSTOMER_VLAN: '+ v.CUSTOMER_VLAN + '\n' +
                        'MODELLO_DI_SERVIZIO_VLAN: '+ v.MODELLO_DI_SERVIZIO_VLAN + '\n';
                    n++;
                }
            } 
        }
        //Cessazione da OLO
        if(o instanceOf OF_SA_WS_OM_Classi.Disattivazione_element){
            OF_SA_WS_OM_Classi.Disattivazione_element request_x = (OF_SA_WS_OM_Classi.Disattivazione_element) o;
            
            s=                                                                                           'CODICE_OPERATORE: ' +request_x.CODICE_OPERATORE+ '\n' +
                'CODICE_ORDINE_OLO: ' +request_x.CODICE_ORDINE_OLO+ '\n' +
                'CODICE_ORDINE_OF: ' +request_x.CODICE_ORDINE_OF+ '\n' +
                'DATA_NOTIFICA: ' +request_x.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +request_x.ID_NOTIFICA+ '\n' +
                'CODICE_MOTIVAZIONE: ' +request_x.CODICE_MOTIVAZIONE+ '\n' +
                'MOTIVAZIONE: ' +request_x.MOTIVAZIONE+ '\n' +
                'GPON_ATTESTAZIONE: ' +request_x.GPON_Attestazione+ '\n' +
                'NOME_CLIENTE: ' +request_x.NOME_CLIENTE+ '\n' +
                'COGNOME_CLIENTE: ' +request_x.COGNOME_CLIENTE+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: ' +request_x.RECAPITO_TELEFONICO_CLIENTE_1+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: ' +request_x.RECAPITO_TELEFONICO_CLIENTE_2+ '\n' +
                'NOTE: ' +request_x.NOTE+ '\n' +
                'ID_RISORSA: ' +request_x.ID_RISORSA+ '\n' +
                'TIPO_COMUNICAZIONE: ' +request_x.TIPO_COMUNICAZIONE+ '\n' + 
                'SORGENTE: ' +request_x.SORGENTE+ '\n' + 
                'SLA_DATE__c: ' +request_x.SLA_DATE+ '\n' + 
                'GPON_Vincolante: ' +request_x.GPON_VINCOLANTE+ '\n' +
                'Opzione_System_Unico: ' +request_x.OPZIONE_SYSTEM_UNICO+ '\n' +
                'Collegamento_P2P: ' +request_x.COLLEGAMENTO_P2P+ '\n' +
                'TRACCIATO: ' +request_x.TRACCIATO+ '\n' +
                'ID_SERVIZIO: ' +request_x.ID_SERVIZIO+ '\n' +
                'PROFILO: ' +request_x.PROFILO+ '\n' +
                'Provincia: ' +request_x.Provincia+ '\n' +
                'Comune: ' +request_x.Comune+ '\n' +
                //'Particella_Toponomastica: ' +request_x.Particella_Toponomastica+ '\n' +
                'Indirizzo: ' +request_x.Indirizzo+ '\n' + 
                'Numero_Civico: ' +request_x.Numero_Civico+ '\n'; 
            if(request_x.apparato!=null && !request_x.apparato.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element app : request_x.apparato){
                    s=          s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'ID_APPARATO: '+app.ID_APPARATO+'\n';
                    n++;
                }
            } 
        }
        //Reschedule da OLO
        if(o instanceOf OF_SA_WS_OM_Classi.Rischedulazione_element){
            OF_SA_WS_OM_Classi.Rischedulazione_element request_x = (OF_SA_WS_OM_Classi.Rischedulazione_element) o;
            
            s=                                                                                           'CODICE_OPERATORE: ' +request_x.CODICE_OPERATORE+ '\n' +
                'CODICE_ORDINE_OLO: ' +request_x.CODICE_ORDINE_OLO+ '\n' +
                'DATA_NOTIFICA: ' +request_x.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +request_x.ID_NOTIFICA+ '\n' +
                'NOME_CLIENTE: ' +request_x.NOME_CLIENTE+ '\n' +
                'COGNOME_CLIENTE: ' +request_x.COGNOME_CLIENTE+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: ' +request_x.RECAPITO_TELEFONICO_CLIENTE_1+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: ' +request_x.RECAPITO_TELEFONICO_CLIENTE_2+ '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: ' +request_x.DATA_PREVISTA_ATTIVAZIONE+ '\n' +
                'ORARIO_APPUNTAMENTO: ' +request_x.ORARIO_APPUNTAMENTO+ '\n' +
                'NOTE: ' +request_x.NOTE+ '\n' +
                'CODICE_MOTIVAZIONE: ' +request_x.CODICE_MOTIVAZIONE+ '\n' + 
                'MOTIVAZIONE: ' +request_x.MOTIVAZIONE+ '\n';
        }
        
        //StatusUpdate da OLO
        if(o instanceOf OF_SA_WS_OM_Classi.AggiornamentoStato_element){
            OF_SA_WS_OM_Classi.AggiornamentoStato_element request_x = (OF_SA_WS_OM_Classi.AggiornamentoStato_element) o;
            
            s=                                                                                           'CODICE_OPERATORE: ' +request_x.CODICE_OPERATORE+ '\n' + 
                'CODICE_ORDINE_OLO: ' +request_x.CODICE_ORDINE_OLO+ '\n' +
                'DATA_NOTIFICA: ' +request_x.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +request_x.ID_NOTIFICA+ '\n' +
                'AZION: ' +request_x.AZIONE+ '\n' +
                'CODICE_MOTIVAZIONE: ' +request_x.CODICE_MOTIVAZIONE+ '\n' +
                'MOTIVAZIONE: ' +request_x.MOTIVAZIONE+ '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: ' +request_x.DATA_PREVISTA_ATTIVAZIONE+ '\n' +
                'ORARIO_APPUNTAMENTO: ' +request_x.ORARIO_APPUNTAMENTO+ '\n' +
                'SORGENTE: ' +request_x.SORGENTE+ '\n' +
                'NOME_CLIENTE: ' +request_x.NOME_CLIENTE+ '\n' +
                'COGNOME_CLIENTE: ' +request_x.COGNOME_CLIENTE+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: ' +request_x.RECAPITO_TELEFONICO_CLIENTE_1+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: ' +request_x.RECAPITO_TELEFONICO_CLIENTE_2+ '\n' +
                'NOTE: ' +request_x.NOTE+ '\n';
        }
        return s; 
        
    }
    public static String dateToStringNoTime(date dt){
        String s='';
        if(!String.isBlank(String.valueOf(dt))){
            s=String.valueOf(dt).left(10);
        }
        return s;
    }
    //Nuovi metodi activation
    public static String getQueryNew(String oggetto,String Processo ){
    	string s=null;
    	if(oggetto=='case'){//EOF_Account_OLO__c
    		if(processo=='AsyncActivation'){ 
    			s='Select Id, Codice_ordine_Eof__C, EOF_Codice_Ordine_Olo__c, OF_SH_Token_id__c, OF_SH_ID_WO__c, EOF_Data_Appuntamento__c, EOF_Orario_Appuntamento__c, OF_SH_DeliveryCompany__c, '
    			+'EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c, OF_OM_Nuovo_Flusso__c, TRACCIATO_TRASCODIFICATO__c,'
    			+'EOF_Data_Notifica__c,EOF_Id_Notifica__c,PO_SA_Portale__c,recordtype.developername, OF_Order__c, EOF_Codice_Errore__c, OF_IDContratto__c,'
    			+'EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,status,EOF_FASE__C,CaseNumber,OF_Response_Da_OM__c,' 
    			+'OF_SA_ID_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,OF_SA_MOTIVAZIONE__c,EOF_Provincia_WS__c,EOF_Comune_WS__c,'
    			+'EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c,OF_SA_ID_Building_OM__c, OF_Flusso_Retry__c, OF_Response_da_SH__c, '
    			+'OF_Response_Da_OLO__c,OF_Bonifica_Locked_Row__c,OF_Codice_Operatore_Secondario__c, EOF_GPON_Attestazione__c,EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, '
                +'OF_Esito_Consegna_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c, '
                +'OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, Accordo_Operativo__c, EOF_Scala_Palazzina_WS__c, AssetId,'
                +'OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c, EOF_Account_OLO__c '
                +'from Case';
    		}
    		if(processo=='AsyncDeactivation'){
    			s='Select Id, Codice_ordine_Eof__C, EOF_Codice_Ordine_Olo__c,EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,AssetId, OF_Order__c,'
					+'EOF_Data_Notifica__c,EOF_Id_Notifica__c,PO_SA_Portale__c,recordtype.developername, OF_OM_Nuovo_Flusso__c, TRACCIATO_TRASCODIFICATO__c,'
					+'EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,status,EOF_FASE__C,EOF_Id_Risorsa__c,CaseNumber,OF_Bonifica_Locked_Row__c, OF_IDContratto__c,'
					+'OF_SA_CODICE_MOTIVAZIONE__c,OF_SA_MOTIVAZIONE__c,EOF_GPON_Vincolante__c,EOF_Opzione_System_Unico__c,EOF_Collegamento_P2P__c, EOF_Codice_Errore__c,'
					+'OF_Response_Da_OLO__c,OF_Response_Da_OM__c,OF_Codice_Operatore_Secondario__c,EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, '
                    +'OF_Esito_Consegna_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c, '
                    +'OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, Accordo_Operativo__c, OF_SA_ID_Servizio__c, EOF_Scala_Palazzina_WS__c,'
                    +'OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c, EOF_Account_OLO__c  '
                    +'from Case'; 
    		} 
    	}
    	if(oggetto=='sl'){
    		if(processo=='AsyncActivation'){
    			s='select OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,EOF_Tipo_COmunicazione_String__c,EOF_CODICE_OPERATORE__C, EOF_CAUSALE_APPARATO__c, OF_SH_Token_id__c, '
				+'EOF_CODICE_ORDINE_OLO__C,EOF_DATA_NOTIFICA__C, EOF_ID_NOTIFICA__C,EOF_NOME_REFERENTE_TECNICO_OLO__C,OF_OM_Nuovo_Flusso__c,'
				+'EOF_COGNOME_REFERENTE_TECNICO_OLO__C,EOF_TELEFONO_REFERENTE_TECNICO_OLO__C,EOF_EMAIL_REFERENTE_TECNICO_OLO__C,'
				+'EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C,EOF_NOME_CLIENTE__C,EOF_COGNOME_CLIENTE__C,EOF_RECAPITO_TELEFONICO_CLIENTE_1__C,'
				+'EOF_RECAPITO_TELEFONICO_CLIENTE_2__C,EOF_INFORMAZIONI_LOGISTICA_APPARATI__C,EOF_DATA_PREVISTA_ATTIVAZIONE__C,'
				+'EOF_ORARIO_APPUNTAMENTO__C,EOF_CODICE_PROGETTO_SPECIALE__c,EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,'
				+'EOF_NOTE__C,EOF_ID_BUILDING__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,'
				+'EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C,recordtype.developername,recordtype.name,OF_SA_NOME_SERVIZIO__c,'
				+'OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_PASSWORD_APPARATO__C,OF_SA_AZIONE_APPARATO__C,OF_SA_KIT_CONSEGNA_VLAN__C, '
				+'OF_SA_USER_VLAN__C,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__C,OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,'
				+'recordtypeId,EOF_Ordine_Invio_OLO__c, TRACCIATO_TRASCODIFICATO__c,OF_Codice_Operatore_Secondario__c'
				+' from EOF_EAI_Service_Log__c';
    		}
    		if(processo=='AsyncDeactivation'){
    			s='select EOF_Tipo_COmunicazione_String__c,OF_SA_Direzione_Flusso__c, EOF_CAUSALE_APPARATO__c, '
					+'OF_SA_Metodo__c,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_DATA_NOTIFICA__c,OF_OM_Nuovo_Flusso__c,'
					+'EOF_ID_NOTIFICA__c,EOF_ID_RISORSA__c ,EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,'
					+'EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,EOF_NOTE__c,'
					+'recordtype.developername,recordtype.name,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ID_APPARATO__C,'
					+'recordtypeId,EOF_Ordine_Invio_OLO__c, TRACCIATO_TRASCODIFICATO__c,OF_Codice_Operatore_Secondario__c'
					+' from EOF_EAI_Service_Log__c';
    		}
    	}
    	if(oggetto=='asset'){
    		if(processo=='AsyncDeactivation'){
    			s='select Id,OF_IDServizio__c,OF_Civico__c,OF_Comune__c, OF_ID_Building__c,OF_Identificativo_del_POP__c,'
					+'OF_Indirizzo__c,OF_Scala_Palazzina__c,OF_Provincia__c,OF_Particella_Toponomastica__c,OF_GPON_Attestazione__c, OF_ProfiloOpenStream__c, OF_Contract__c'
					+' from Asset';
    		}
    	}    	 
    	return s; 
    }
    //nuovo metodo per sky
    public static EOF_EAI_Service_Log__C CreateAcquisition_LogNew(case c){
        if(!OF_SA_GE_UtilsNew.checkrtMap){
            List<recordtype> rtList=[select Id,developerName from recordtype];
            OF_SA_GE_UtilsNew.rtMap = new Map<String,Id>(); 
            for(recordtype rt :rtList){
                OF_SA_GE_UtilsNew.rtMap.put(rt.DeveloperName, rt.Id); 
            }               
            OF_SA_GE_UtilsNew.checkrtMap=true;
        }    
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
          //EC COmmento DIA  RecordTypeId = (String.isNotBlank(c.recordtype.developername) && c.recordtype.developername.startsWithIgnoreCase('OF_SA_')) ? OF_SA_GE_UtilsNew.rtMap.get('OF_SA_FiberNotify') : OF_SA_GE_UtilsNew.rtMap.get('OF_DIA_FiberNotify'),
            RecordTypeId = OF_SA_GE_UtilsNew.rtMap.get('OF_SA_FiberNotify'),
            EOF_Tipo_COmunicazione_String__c='SF->OLO - StatusUpdate',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate',
            EOF_CODICE_OPERATORE__c=c.EOF_Codice_Operatore_WS__c, 
            EOF_CODICE_ORDINE_OLO__c=c.EOF_CODICE_ORDINE_OLO__c,
            EOF_CODICE_ORDINE_EOF__c=c.Id,
            EOF_DATA_NOTIFICA__c=system.now(),
            EOF_ID_NOTIFICA__c=String.valueOf(system.now().getTime()),
            OF_OM_Nuovo_Flusso__c = c.OF_OM_Nuovo_Flusso__c,
            EOF_ID_SERVIZIO__c = c.OF_SA_ID_Servizio__c
        );
        //Aggiunto per il servizio DIA
        if(c.recordtype.developername=='OF_SA_Attivazione'){ //EC commento DIA || c.recordtype.developername=='OF_DIA_Attivazione'){
            sl.EOF_Tipo_Comunicazione__c = '5';
        }
        else{
            sl.EOF_Tipo_Comunicazione__c = '12';
        }   
        if(c.Status=='Acquisito'){
            sl.EOF_STATO_ORDINE__c='0';
        }
        else{
            if(c.Status=='Acquisito KO'){ 
                sl.EOF_STATO_ORDINE__c='1';
            }
            if(c.Status=='Cessato KO'){
                sl.EOF_STATO_ORDINE__c='7';
            }
            sl.EOF_CODICE_MOTIVAZIONE__c=c.OF_SA_CODICE_MOTIVAZIONE__c;
            sl.EOF_MOTIVAZIONE__c=c.OF_SA_MOTIVAZIONE__c;
        }
        sl.caso__c=c.Id;
        sl.EOF_Richiesta_Notifica__c = copy_notify_AcqCessNew(sl);
        return sl;
    }
    //Nuovo metodo callout per sky
    public static void makeCalloutOLOOMNew(EOF_EAI_Service_Log__C slTOOLO){
        Boolean newFlusso = slTOOLO.OF_OM_Nuovo_Flusso__c;
        //prima di chiamare la callout faccio il check amministratori solo per attivazione
        if(slTOOLO.EOF_Tipo_comunicazione__c=='5'){
            OF_SA_GE_UtilsNew.checkAmministratori(OF_SA_GE_UtilsNew.caseOriginale);
        }
        //poi chiamo l'OLO
        String esitoOLO;

        //AA - Se è OF_SA_FiberNotify, dobbiamo andare sull'OF_StatusUpdateNew di OpenStream
        if(OF_SA_GE_UtilsNew.slSFOLO.RecordTypeId == OF_SA_GE_UtilsNew.rtMap.get('OF_SA_FiberNotify')){
            OF_Schema_StatusUpdateNew.StatusUpdateResponseType resp = OF_OM_SendToOLONew.OM_CreateAckNackNotifyStatusUpdateNew(OF_SA_GE_UtilsNew.slSFOLO);
            esitoOLO = resp.ESITO;
        } /* EC Commento DIA 2019 04 05  else{//Vado verso il nuov servizio DIA
            OF_DIA_Schema_StatusUpdate.OF_StatusUpdate_DIA_Response_element resp = OF_OM_SendToOLONew.OM_CreateAckNackNotifyStatusUpdateNew_DIA(OF_SA_GE_UtilsNew.slSFOLO);
            esitoOLO = resp.ESITO;
        }
        */ // EC Commento DIA 2019 04 05  
        
        if('0'.equalsIgnoreCase(esitoOLO)){//Caso di ACK
            //chiamo OM
            if(slTOOLO.EOF_Tipo_comunicazione__c=='5'){            	
                //Creo la lista di log che invierò per l'ACTIVATION verso OM
                OF_SA_GE_UtilsNew.ListSlActivationSFOM=OF_SA_GE_UtilsNew.create_ActivationToOM_Log(OF_SA_GE_UtilsNew.caseOriginale,OF_SA_GE_UtilsNew.ListSlActivationOLOSF);                
                //Effettuo la callout verso OM con la lista di log appena creata
                OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestActivationNew(OF_SA_GE_UtilsNew.ListSlActivationSFOM);
                //Vado a fare l'aggiornamento dei dati (Case, Ordine) Ps. Questa classe chiama la manageOrder
                OF_SA_GE_UtilsNew.aggiornamentoDatiAttivazioneCessazioneToOM('Create',null,null);               
            }
            else{
                //Creo la lista di log che invierò per la DEACTIVATION verso OM
                OF_SA_GE_UtilsNew.ListSlDeactivationSFOM = OF_SA_GE_UtilsNew.create_DeactivationToOM_Log(OF_SA_GE_UtilsNew.caseOriginale,OF_SA_GE_UtilsNew.ListSlDeactivationOLOSF,OF_SA_GE_UtilsNew.a);
                //Effettuo la callout verso OM con la lista di log appena creata
                OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestDeactivationNew(OF_SA_GE_UtilsNew.ListSlDeactivationSFOM);
                //Vado a fare l'aggiornamento dei dati (Case, Ordine) Ps. Questa classe chiama la manageOrder
                OF_SA_GE_UtilsNew.aggiornamentoDatiAttivazioneCessazioneToOM('Delete',OF_SA_GE_UtilsNew.slSFOM.EOF_Tipo_Comunicazione__c,null);                
            }
        }else{
            //aggiorno tutto
            OF_SA_GE_UtilsNew.aggiornamentoDatiAcquisizione(OF_SA_GE_UtilsNew.caseOriginale);
        }
        
    }
    //Nuovo metodo per sky
    public static String copy_notify_AcqCessNew(EOF_EAI_Service_Log__c sl){
        String s =  'CODICE_OPERATORE: ' + sl.EOF_Codice_Operatore__c + '\n' +            
            'TIPO_COMUNICAZIONE: ' + sl.EOF_Tipo_Comunicazione__c + '\n' + 
            'CODICE_ORDINE_OLO: ' + sl.EOF_Codice_Ordine_OLO__c + '\n' +
            'CODICE_ORDINE_EOF: ' + sl.EOF_Codice_Ordine_EOF__c + '\n' +
            'ID_NOTIFICA: ' + sl.EOF_ID_Notifica__c + '\n' +
            'STATO_RICHIESTA: ' + sl.EOF_Stato_Richiesta__c + '\n' +
            'CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO: ' + sl.EOF_Cod_Rifiuto_Sospensione_Annullamento__c + '\n' + 
            'MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO: ' + sl.EOF_Mot_Rifiuto_Sospensione_Annullamento__c + '\n' +         
            'DATA_NOTIFICA: ' + OF_SA_GE_UtilsNew.DateToString(sl.EOF_Data_Notifica__c) + '\n' +            
            'ID_SERVIZIO: ' + sl.EOF_ID_SERVIZIO__c +'\n' + 
            'NUOVO_FLUSSO_OM: ' + sl.OF_OM_Nuovo_Flusso__c +'\n';
        return s;
    }
    //METODO GIà DUPLICATO MEDIANTE ISTANCE OF PER SKY FASE 3 
    public static EOF_EAI_Service_Log__C OLO_CreateStatusUpdate_Log(Case c, object o){
        List<recordtype> rtList=[select Id,developerName from recordtype where developerName='OF_SA_Attivazione' or developerName = 'Cliente_Business'
                                 or developerName = 'PersonAccount' or developerName='Referente_Tecnico_OLO' or developerName='Servizi_Aggiuntivi' 
                                 or developerName='OF_CPE' or developerName='OF_VLAN' or developerName='OLO' or developerName='OF_SA_FiberRequest'or developerName='OF_SA_Servizi_Aggiuntivi'
                                 or developerName='OF_SA_FiberNotify'/*EC commento DIA or developerName='OF_DIA_FiberNotify'*/ or developerName='OF_SA_Cpe'or developerName='OF_SA_Vlan' or developerName='OF_SA_ACK' or developerName='OF_SA_NACK'];
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }
       
        if(o instanceof OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest){
            //('OSCRM logMancante:--start--');
            OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur = (OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
             // EC Commento DIA 2019 04 05      RecordTypeId = String.isBlank(sur.TIPOLOGIA_SERVIZIO) ? rtMap.get('OF_SA_FiberRequest') : rtMap.get('OF_DIA_FiberRequest'),
                RecordTypeId = rtMap.get('OF_SA_FiberRequest'),
                EOF_Tipo_COmunicazione_String__c='SF->OM - StatusUpdateRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_StatusUpdate',
                EOF_Sorgente__c='OGW',
                EOF_CODICE_OPERATORE__C=sur.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__C=sur.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__C=StringTODate(sur.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__C=sur.ID_NOTIFICA,
                OF_SA_AZIONE__C=sur.AZIONE,
                EOF_CODICE_MOTIVAZIONE__C=sur.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__C=sur.MOTIVAZIONE,
                EOF_DATA_PREVISTA_ATTIVAZIONE__C=StringTODateNoTime(sur.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__C=sur.ORARIO_APPUNTAMENTO,
                EOF_NOME_CLIENTE__C=sur.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__C=sur.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__C=sur.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = sur.RECAPITO_TELEFONICO_CLIENTE_2, 
                EOF_TRACCIATO__c='3',
                EOF_Tipo_Comunicazione_Int__c = (sur.AZIONE == '0') ? '3' : '4',
                EOF_Richiesta_Notifica__c = copy_request(sur)
            );
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c, OF_OM_Nuovo_Flusso__c, OF_SH_Token_id__c FROM Case Where OF_OM_Nuovo_Flusso__c = true AND EOF_Codice_Ordine_OLO__c =: sur.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){ 
                Case activationCase = cList[0];
                sl.caso__c = activationCase.Id;
            }

            // 20/02/2018 MM : abbreviazione campo note qualora sia più lungo di 255 caratteri
            if(string.isnotblank(sur.NOTE)){
                sl.EOF_Note__c= sur.NOTE.abbreviate(255);
            }
            else{
                sl.EOF_Note__c = sur.NOTE;
            }
            // finisce qui            
            //('OSCRM OF_SA_GE_UtilsNew.OLO_CreateStatusUpdate_Log serviceLog sl:'+sl);
            return sl;        
        }
        return null;
    }
    public static EOF_EAI_Service_Log__C OLO_CreateReschedule_Log(Case c, object o){
        List<recordtype> rtList=[select Id,developerName from recordtype where developerName='OF_SA_Attivazione' or developerName = 'Cliente_Business'
                                 or developerName = 'PersonAccount' or developerName='Referente_Tecnico_OLO' or developerName='Servizi_Aggiuntivi' 
                                 or developerName='OF_CPE' or developerName='OF_VLAN' or developerName='OLO' or developerName='OF_SA_FiberRequest'or developerName='OF_SA_Servizi_Aggiuntivi'
                                 or developerName='OF_SA_FiberNotify'/*EC commento DIA or developerName='OF_DIA_FiberNotify' */or developerName='OF_SA_Cpe'or developerName='OF_SA_Vlan' or developerName='OF_SA_ACK' or developerName='OF_SA_NACK'];
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }
        //AA SKY FASE 3
        //DUPLICATO PER SKY FASE 3
        if(o instanceof OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest){
            OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest r = (OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                // EC Commento DIA 2019 04 05   RecordTypeId = String.isBlank(r.TIPOLOGIA_SERVIZIO) ? rtMap.get('OF_SA_FiberRequest') : rtMap.get('OF_DIA_FiberRequest'),
                RecordTypeId = rtMap.get('OF_SA_FiberRequest'),
                EOF_Tipo_COmunicazione_String__c='SF->OM - RescheduleRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_Reschedule',
                EOF_CODICE_OPERATORE__c=r.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__c=r.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__c=OF_SA_GE_UtilsNew.StringToDate(r.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c=r.ID_NOTIFICA,
                EOF_DATA_PREVISTA_ATTIVAZIONE__c=OF_SA_GE_UtilsNew.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__c=c.EOF_Orario_Appuntamento__c,
                EOF_NOME_CLIENTE__c=r.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__c=r.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=r.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=r.RECAPITO_TELEFONICO_CLIENTE_2,
                EOF_CODICE_MOTIVAZIONE__c=r.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__c=r.MOTIVAZIONE,
                EOF_SORGENTE__c='OGW',
                EOF_codice_Ordine_EOF__c=r.CODICE_ORDINE_OF,
                OF_SH_Token_id__c = c.OF_SH_Token_id__c,
                //EOF_SLA_DATE__c=r.SLA_DATE,
                //EOF_GPON_ATTESTAZIONE__c=r.GPON_ATTESTAZIONE,
                //EOF_GPON_VINCOLANTE__c=r.GPON_VINCOLANTE,
                EOF_ID_SERVIZIO__c=c.OF_SA_ID_SERVIZIO__c,
                EOF_Profilo__c = c.OF_SA_Profilo__c,
                OF_SH_ID_WO__c = c.OF_SH_ID_WO__c,
                OF_SH_DeliveryCompany__c = c.OF_SH_DeliveryCompany__c,
                OF_SH_AppointmentDate__c = OF_SA_GE_UtilsNew.DateToStringNoTime(c.EOF_Data_Appuntamento__c),
                //Viene popolato momentaneamente con l'orario appuntamento
                OF_SH_Fascia_App__c = c.EOF_Orario_Appuntamento__c,
                EOF_Tracciato__c = '3',
                EOF_Tipo_Comunicazione_Int__c = '2'/*,
                EOF_Richiesta_Notifica__c = copy_request(r)*/
            );
            sl.Caso__c=c.Id;
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(r.NOTE) && r.NOTE!=null){
                sl.EOF_Note__c= r.NOTE.abbreviate(255);
            }
            else{
                sl.EOF_Note__c = r.NOTE;
            }
            // finisce qui            
            sl.EOF_Richiesta_Notifica__c = copy_request_OLOOM_Reschedule(sl);
            return sl;        
        }
        //FINE AA
        return null;
    }
    public static String copy_request_OLOOM_Reschedule(EOF_EAI_service_Log__c slog){
        String s = '';
        s=  'CODICE_OPERATORE: '+ slog.EOF_CODICE_OPERATORE__c  + '\n' +
            'CODICE_ORDINE_OLO: '+ slog.EOF_CODICE_ORDINE_OLO__c  + '\n' +
            'DATA_NOTIFICA: '+ slog.EOF_DATA_NOTIFICA__c   + '\n' +
            'ID_NOTIFICA: '+ slog.EOF_ID_NOTIFICA__c  + '\n' +
            'DATA_PREVISTA_ATTIVAZIONE: '+ slog.EOF_DATA_PREVISTA_ATTIVAZIONE__c  + '\n' +
            'ORARIO_APPUNTAMENTO: '+ slog.EOF_ORARIO_APPUNTAMENTO__c  + '\n' +
            'NOME_CLIENTE: '+ slog.EOF_NOME_CLIENTE__c  + '\n' +
            'COGNOME_CLIENTE: '+ slog.EOF_COGNOME_CLIENTE__c  + '\n' +
            'RECAPITO_TELEFONICO_CLIENTE_1: '+ slog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c  + '\n' +
            'RECAPITO_TELEFONICO_CLIENTE_2: '+ slog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c  + '\n' +
            'NOTE: '+ slog.EOF_NOTE__c  + '\n' +
            'CODICE_MOTIVAZIONE: '+ slog.EOF_CODICE_MOTIVAZIONE__c  + '\n' + 
            'MOTIVAZIONE: '+ slog.EOF_MOTIVAZIONE__c  + '\n' +
            'SORGENTE: ' + slog.EOF_SORGENTE__c + '\n' +
            'CODICE_ORDINE_OF: ' + slog.EOF_codice_Ordine_EOF__c + '\n' +
            'SLA_DATE: ' + slog.EOF_SLA_DATE__c + '\n' +
            'GPON_ATTESTAZIONE: ' + slog.EOF_GPON_ATTESTAZIONE__c + '\n' +
            'GPON_VINCOLANTE: ' + slog.EOF_GPON_VINCOLANTE__c + '\n' +
            'ID_SERVIZIO: ' + slog.EOF_ID_SERVIZIO__c + '\n' +
            'TIPO_COMUNICAZIONE: ' + slog.EOF_Tipo_Comunicazione__c + '\n' +
            'PROVINCIA: ' + slog.EOF_PROVINCIA__c + '\n' +
            'COMUNE: ' + slog.EOF_COMUNE__c + '\n' +
            'INDIRIZZO: ' + slog.EOF_INDIRIZZO__c + '\n' +
            'NUMERO_CIVICO: ' + slog.EOF_NUMERO_CIVICO__c + '\n' +
            'PARTICELLA_TOPONOMASTICA: ' + slog.EOF_PARTICELLA_TOPONOMASTICA__c + '\n' +
            'COLLEGAMENTO_P2P: ' + slog.EOF_COLLEGAMENTO_P2P__c + '\n' +
            'IDENTIFICATIVO_PRENOTAZIONE: ' + slog.OF_SH_Token_id__c + '\n' +
            'TRACCIATO: ' + slog.EOF_Tracciato__c + '\n' +
            'ID_SERVIZIO: ' + slog.EOF_ID_SERVIZIO__c + '\n' +
            'PROFILO: ' + slog.EOF_Profilo__c + '\n' +
            'ID_WO: ' + slog.OF_SH_ID_WO__c + '\n' +
            'IMPRESA: ' + slog.OF_SH_DeliveryCompany__c + '\n' +
            'DATA_APP: ' + slog.OF_SH_AppointmentDate__c + '\n' +
            'FASCIA_APP: ' + slog.OF_SH_Fascia_App__c + '\n';
        return s;
    }
    public static EOF_EAI_Service_Log__C OM_CreateReschedule_LogNew(case c, object o){
        
        //faccio il check per vedere se la mappa dei recordtype è popolata
        if(!OF_SA_GE_UtilsNew.checkRTMap){
	        //vado a creare la mappa dei recordtype per poi utilizzarla
	    	OF_SA_GE_UtilsNew.RTMap = new  map<String,String>();
	    	for(recordtype rt : [select id,developername from recordtype]){
	    		OF_SA_GE_UtilsNew.RTMap.put(rt.developername,rt.id);
	    	}
	    	OF_SA_GE_UtilsNew.checkRTMap=true;
       }
        //OM Reschedule
        if(o instanceof OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule){
            OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule a = (OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
           // EC Commento DIA 2019 04 05        RecordTypeId =String.isBlank(a.TIPOLOGIA_SERVIZIO) ? OF_SA_GE_UtilsNew.rtMap.get('OF_SA_FiberNotify') 
                   // EC Commento DIA 2019 04 05                                                   : OF_SA_GE_UtilsNew.rtMap.get('OF_DIA_FiberNotify'),
                RecordTypeId = OF_SA_GE_UtilsNew.rtMap.get('OF_SA_FiberNotify'),
                EOF_Tipo_COmunicazione_String__c='SF->OLO - Reschedule',
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_Reschedule',
                EOF_CODICE_OPERATORE__c=a.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c=a.CODICE_ORDINE_OLO,
                EOF_CODICE_ORDINE_EOF__c= c.Codice_Ordine_EOF__c,
                EOF_DATA_NOTIFICA__c=StringToDate(a.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c=a.ID_NOTIFICA,
                EOF_NOME_CLIENTE__c=a.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__c=a.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=a.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=a.RECAPITO_TELEFONICO_CLIENTE_2,
                EOF_DATA_PREVISTA_ATTIVAZIONE__c=StringToDateNoTime(a.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__c=a.ORARIO_APPUNTAMENTO,
                EOF_CODICE_MOTIVAZIONE__c=a.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__c=a.MOTIVAZIONE,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            if(OF_SA_GE_UtilsNew.checkCaseOriginale){
                sl.caso__c=OF_SA_GE_UtilsNew.CaseOriginale.Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
            	sl.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
            	sl.EOF_Note__c = a.NOTE;
            }
            // finisce qui            
            
            
            return sl;
            
        } 
        return null;
    }   
    //cessazione OK NEW
    public static void makeCalloutOMNew(List<EOF_EAI_Service_Log__C> ListSlTOOM){
        //TODO AA - ESEGUO IL NUOVO FLUSSO DI OM!!!
        OF_SA_GE_UtilsNew.ListSlDeactivationSFOM=OF_SA_GE_UtilsNew.create_DeactivationToOM_Log(OF_SA_GE_UtilsNew.caseOriginale,OF_SA_GE_UtilsNew.ListSlDeactivationOLOSF,OF_SA_GE_UtilsNew.a);
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestDeactivationNew(OF_SA_GE_UtilsNew.ListSlDeactivationSFOM);
        OF_SA_GE_UtilsNew.aggiornamentoDatiAttivazioneCessazioneToOM('Delete',OF_SA_GE_UtilsNew.slSFOM.EOF_Tipo_Comunicazione__c,null);
        //OF_SA_GE_UtilsNew.caseOriginale.Description = 'Antonio è molto bravo cessatelo ok!!!';
        //update OF_SA_GE_UtilsNew.caseOriginale;
    }
    //metodo che gestisce l'aggiornamento dei dati in caso di NACK da OLO su Acquisito OK/KO e Cessato KO
    public static void aggiornamentoDatiAcquisizione(Case c){
        list<Case> caseToUpdate = new list<Case>();
        //valido sia per cessazione che attivazione
        if( OF_SA_GE_UtilsNew.checkCliente){
            //Inserisco il cliente
            insert  OF_SA_GE_UtilsNew.cliente;
            //Aggiungo il cliente al case
            OF_SA_GE_UtilsNew.caseOriginale.AccountId =  OF_SA_GE_UtilsNew.cliente.Id;
        }
        system.debug('Marco - il cliente inserito è :'+ OF_SA_GE_UtilsNew.cliente);
        system.debug('Marco - Il cliente aggiunto al case è:' +OF_SA_GE_UtilsNew.caseOriginale);
        if(OF_SA_GE_UtilsNew.checkCEIList){
            insert OF_SA_GE_UtilsNew.CEIList;
        }
        
        Insert  OF_SA_GE_UtilsNew.slSFOLO;
        
        //metto la reference alla notifica, la reference al slPrincipale e inserisco la response
        if(OF_SA_GE_UtilsNew.slSFOLOresp != null){
            OF_SA_GE_UtilsNew.slSFOLOresp.EOF_SL_Riferimento__c= OF_SA_GE_UtilsNew.slSFOLO.Id;
            insert slSFOLOresp;
        }
                
        if( OF_SA_GE_UtilsNew.checkRefTec){
            //inserisco il referente tecnico e metto il riferimento sul case
            insert  OF_SA_GE_UtilsNew.refTec;
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Contact__c =  OF_SA_GE_UtilsNew.refTec.Id;
        }
        
       /* OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
        String s=mofc.ManageOrder( OF_SA_GE_UtilsNew.caseOriginale);*/
        //AA - Nuovo espletamento
        OF_ManageOrderFromCase_GPONP mofc = new OF_ManageOrderFromCase_GPONP();
        String s = mofc.ManageOrder(OF_SA_GE_UtilsNew.caseOriginale);

        if(!String.isBlank(s)){
            OF_SA_GE_UtilsNew.caseOriginale.OF_Order__c=s;
        }
        //aggiungo gli eventuali case di amministratori da aggiornare
        if(OF_SA_GE_UtilsNew.checkCaseAmm){
            caseToUpdate.addAll(OF_SA_GE_UtilsNew.ListCaseAmmToUpdate);	
        }
        
        if(OF_SA_GE_UtilsNew.gen!=null){
            try{
                delete OF_SA_GE_UtilsNew.gen;
            }
            catch(exception e){
                insert OF_Utility.logMessageNew2(OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_OLO__c,'E','OF_SA_GE_UtilsNew','aggiornamentoDatiAcquisizione',null, e);
            }
        }
        
        //in caso di cessazione KO è  sufficiente la seguente
        caseToUpdate.add( OF_SA_GE_UtilsNew.caseOriginale);
        update caseToUpdate;
    }
    public static void aggiornamentoDatiAttivazioneCessazioneToOM(String processo, String tipo_comunicazione, String esito){
        list<Case> caseToUpdate = new list<Case>();
        list<EOF_EAI_Service_Log__c> slListPrincipaliToInsert = new list<EOF_EAI_Service_Log__c>();
        list<EOF_EAI_Service_Log__c> slListResponseAndElementToInsert = new list<EOF_EAI_Service_Log__c>();
        //valido sia per cessazione che attivazione
        if(OF_SA_GE_UtilsNew.checkCliente){
            //Inserisco il cliente
            insert OF_SA_GE_UtilsNew.cliente;
            //Aggiungo il cliente al case
            OF_SA_GE_UtilsNew.caseOriginale.AccountId = OF_SA_GE_UtilsNew.cliente.Id;
        }
        system.debug('Marco - il cliente inserito è :'+ OF_SA_GE_UtilsNew.cliente);
        system.debug('Marco - Il cliente aggiunto al case è:' +OF_SA_GE_UtilsNew.caseOriginale.AccountId);
        
        if(OF_SA_GE_UtilsNew.checkRefTec){
            //inserisco il referente tecnico e metto il riferimento sul case
            insert OF_SA_GE_UtilsNew.refTec;
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Contact__c = OF_SA_GE_UtilsNew.refTec.Id;
        }
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@ il check CEI è: '+OF_SA_GE_UtilsNew.checkCEIList);
        if(OF_SA_GE_UtilsNew.checkCEIList){ 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@ la lista di CEI è: '+OF_SA_GE_UtilsNew.CEIList);
            insert OF_SA_GE_UtilsNew.CEIList;
        }
        //casi di attivazione OK/KO e cessazione KO
        if(processo=='Create' || (processo=='Delete' && 'Cessato KO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.Status))){
            
            slListPrincipaliToInsert.add(OF_SA_GE_UtilsNew.slSFOLO);
            slListPrincipaliToInsert.add(OF_SA_GE_UtilsNew.slSFOM);
            Insert slListPrincipaliToInsert;
            
            OF_SA_GE_UtilsNew.slSFOLOresp.EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
            OF_SA_GE_UtilsNew.slSFOMResp.EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOM.Id;
            slListResponseAndElementToInsert.add(OF_SA_GE_UtilsNew.slSFOMResp);
            slListResponseAndElementToInsert.add(OF_SA_GE_UtilsNew.slSFOLOresp);
            if(OF_SA_GE_UtilsNew.checkVLan){
                for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.listVlanToOM){
                    sl.OF_SA_VLan_Log__c=OF_SA_GE_UtilsNew.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            if(OF_SA_GE_UtilsNew.checkApp){
                for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.listAppToOM){
                    sl.OF_SA_Cpe_Log__c=OF_SA_GE_UtilsNew.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            if(OF_SA_GE_UtilsNew.checkServAgg){
                for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.listServAggToOM){
                    sl.OF_SA_servizi_Aggiuntivi_Log__c=OF_SA_GE_UtilsNew.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            Insert slListResponseAndElementToInsert;
        }
        
        if(processo=='Delete' && 'Acquisito'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.Status)){
            //inserisco il log principale
            insert OF_SA_GE_UtilsNew.slSFOM;
            //inserisco il riferimento sul log di response e poi la response
            OF_SA_GE_UtilsNew.slSFOMResp.EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOM.Id;
            Insert OF_SA_GE_UtilsNew.slSFOMResp;
            
        }
        
        /*OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
        String s=mofc.ManageOrder(OF_SA_GE_UtilsNew.caseOriginale);*/
        //AA - Nuovo espletamento
        OF_ManageOrderFromCase_GPONP mofc = new OF_ManageOrderFromCase_GPONP();
        String s = mofc.ManageOrder(OF_SA_GE_UtilsNew.caseOriginale);
        if(!String.isBlank(s)){
            OF_SA_GE_UtilsNew.caseOriginale.OF_Order__c=s;
        } 
        //aggiungo gli eventuali case di amministratori da aggiornare
        if(OF_SA_GE_UtilsNew.checkCaseAmm){
            caseToUpdate.addAll(OF_SA_GE_UtilsNew.ListCaseAmmToUpdate);	
        }
        if(OF_SA_GE_UtilsNew.caseOriginale.PO_SA_Portale__c){
            system.debug('@@@@ processo: '+processo+'; tipo_comunicazione: '+tipo_comunicazione);
            system.debug('@@@@ OF_SA_GE_UtilsNew.slSFOLO: '+OF_SA_GE_UtilsNew.slSFOLO+'; OF_SA_GE_UtilsNew.slSFOM: '+OF_SA_GE_UtilsNew.slSFOM);
            OF_SA_GE_UtilsNew.ListSlStatusUpdateSFOLO=new List<EOF_EAI_Service_Log__c>();
            if(processo=='Delete' && ((tipo_comunicazione=='2') || (tipo_comunicazione=='11') ) ){
                //se la cessazione è ok non produco il log SF-->OLO ma uso il log SF-->OM per aggiornare 
                //il log del portale
                OF_SA_GE_UtilsNew.ListSlStatusUpdateSFOLO.add(OF_SA_GE_UtilsNew.slSFOM);
                OF_SA_GE_UtilsNew.aggiornaSLPortale(OF_SA_GE_UtilsNew.ListSlStatusUpdateSFOLO, 'OM_StatusUpdate');
            }
            else{
                OF_SA_GE_UtilsNew.ListSlStatusUpdateSFOLO.add(OF_SA_GE_UtilsNew.slSFOLO);
                OF_SA_GE_UtilsNew.aggiornaSLPortale(OF_SA_GE_UtilsNew.ListSlStatusUpdateSFOLO, 'OM_StatusUpdate');
            }
        }
        
        //cancello il record di generatore id servizio dal db
        if(OF_SA_GE_UtilsNew.gen!=null){
            try{
                delete OF_SA_GE_UtilsNew.gen;
            }
            catch(exception e){
                insert OF_Utility.logMessageNew2(OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_OLO__c,'E','OF_SA_GE_UtilsNew','aggiornamentoDatiAttivazioneCessazioneToOM',null, e);
            }
        }
        //in caso di cessazione KO è  sufficiente la seguente
        caseToUpdate.add(OF_SA_GE_UtilsNew.caseOriginale);
        update caseToUpdate;
    } 
    public static List<EOF_EAI_Service_Log__c> create_DeactivationToOM_Log(Case c2, List<EOF_EAI_Service_Log__c> ListSlOrig,Asset a){
        List<EOF_EAI_Service_Log__c> listToOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListAppToOM=new List<EOF_EAI_Service_Log__c>();
        system.debug('Alessandro: la list è: '+ListSlOrig);
        for(EOF_EAI_Service_Log__c sl : ListSlOrig){
            if(sl.recordtype.developername=='OF_SA_FiberRequest'){//EC COMMENTO DIA || sl.recordtype.developername=='OF_DIA_FiberRequest' ){
                
                OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c(
                    RecordTypeId = sl.recordtypeId,
                    EOF_Tipo_COmunicazione_String__c='SF->OM - DeactivationRequest',
                    EOF_Tipo_COmunicazione_Int__c='2',
                    OF_SA_Direzione_Flusso__c='SF-OM',
                    OF_SA_Metodo__c='OLO_DeactivationOrder',
                    EOF_CODICE_OPERATORE__C=sl.EOF_CODICE_OPERATORE__c,
                    EOF_CODICE_ORDINE_OLO__C=sl.EOF_CODICE_ORDINE_OLO__c,
                    EOF_CODICE_ORDINE_EOF__C=c2.Codice_ordine_Eof__C,
                    EOF_DATA_NOTIFICA__C=sl.EOF_data_NOTIFICA__c, 
                    EOF_ID_NOTIFICA__C=sl.EOF_ID_NOTIFICA__c,
                    EOF_CODICE_MOTIVAZIONE__c=c2.OF_SA_CODICE_MOTIVAZIONE__c,
                    EOF_MOTIVAZIONE__c=c2.OF_SA_MOTIVAZIONE__c,
                    EOF_NOME_CLIENTE__c=sl.EOF_NOME_CLIENTE__c, 
                    EOF_COGNOME_CLIENTE__c=sl.EOF_COGNOME_CLIENTE__c,
                    EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                    EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                    EOF_NOTE__c=sl.EOF_NOTE__c,
                    EOF_ID_RISORSA__c = sl.EOF_ID_RISORSA__c,
                    //sEOF_TIPO_COMUNICAZIONE__c = a.TIPO_COMUNICAZIONE,
                    EOF_SORGENTE__c = 'OGW',
                    //EOF_SLA_DATE__c = c.EOF_SLA_DATE__c,
                    EOF_GPON_VINCOLANTE__c = c2.EOF_GPON_Vincolante__c,
                    EOF_OPZIONE_SYSTEM_UNICO__c = c2.EOF_Opzione_System_Unico__c,
                    EOF_COLLEGAMENTO_P2P__c = c2.EOF_Collegamento_P2P__c,
                    EOF_TRACCIATO__c = '3',
                    //aa aggiunto campo 29/11/2018
                    TRACCIATO_TRASCODIFICATO__c=sl.TRACCIATO_TRASCODIFICATO__c,
                    OF_Codice_Operatore_Secondario__c = sl.OF_Codice_Operatore_Secondario__c,
                    EOF_TIPOLOGIA_SERVIZIO__c= '1',
                    EOF_Tipo_COmunicazione__c = '11',
                    caso__c=c2.id
                );
                
                if(c2.status=='Acquisito'){
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Stato_Ordine__c= '0';
                    OF_SA_GE_UtilsNew.slSFOM.EOF_GPON_Attestazione__c=a.OF_GPON_Attestazione__c;
                    OF_SA_GE_UtilsNew.slSFOM.EOF_ID_SERVIZIO__c = a.OF_IDServizio__c;
                    OF_SA_GE_UtilsNew.slSFOM.EOF_PROFILO__c = a.OF_ProfiloOpenStream__c;
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Provincia__c = a.OF_Provincia__c;
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Comune__c= a.OF_Comune__c;
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Particella_Toponomastica__c = a.OF_Particella_Toponomastica__c;
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Indirizzo__c = a.OF_Indirizzo__c;
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Numero_Civico__c = a.OF_Civico__c;
                }
                else{
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Stato_Ordine__c= '1';
                } 
                listToOM.add(OF_SA_GE_UtilsNew.slSFOM);
            }
            Integer n = 1;
            if(sl.recordtype.developername=='OF_SA_Cpe'){ 
                OF_SA_GE_UtilsNew.checkAppToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.EOF_TIPOLOGIA_APPARATO__C=sl.EOF_TIPOLOGIA_APPARATO__C;
                sLog.OF_SA_ID_APPARATO__C=sl.OF_SA_ID_APPARATO__C;
                //sLog.OF_SA_Cpe_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n;
                OF_SA_GE_UtilsNew.ListappToOM.add(sLog);
                listToOM.add(sLog);
                n++;
            }       	
        }
        return listToOM;
    } 
    public static void checkAmministratori(Case c){
        //faccio il check per amministratori
        //aggiungo  il controllo se id building è vuoto
        if(String.isBlank(c.EOF_Id_Building_WS__c)){
            return;
        }
        list<Case> caseAmm = [select Id,CA_Numero_Ordini_in_Corso__c,OF_Bonifica_Locked_Row__c from Case where recordtype.developername='CA_Amministratori' 
                              and CA_ID_Building__c=: c.EOF_Id_Building_WS__c
                              AND status!='Realizzazione Impianto Completata'
                              AND status!='Negoziazione OF Richiesta Permesso Lavori KO' 
                              AND status!='Negoziazione OF Accesso Censimento Interno KO'];
        
        try{
            OF_SA_GE_UtilsNew.checkCaseAmm=true;
            OF_SA_GE_UtilsNew.ListCaseAmmToUpdate = new List<Case>();
            for(case cAmm : caseAmm){
                cAmm.CA_Codice_Ordine_in_Corso__c= OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_OLO__c;
                cAmm.CA_Stato_Ordine_in_Corso__c= OF_SA_GE_UtilsNew.caseOriginale.status;
                cAmm.CA_Numero_Ordini_in_Corso__c=cAmm.CA_Numero_Ordini_in_Corso__c+1;
                OF_SA_GE_UtilsNew.ListCaseAmmToUpdate.add(cAmm);
            }
            return;
        }
        catch(exception e){
            system.debug('L exception è: '+e);
        }
        return;
    }
    
    public static List<EOF_EAI_Service_Log__c> create_ActivationToOM_Log(Case c2, List<EOF_EAI_Service_Log__c> ListSlOrig){
        List<EOF_EAI_Service_Log__c> listToOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListVLanToOM=new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListAppToOM=new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListServAggToOM=new List<EOF_EAI_Service_Log__c>();
        for(EOF_EAI_Service_Log__c sl : ListSlOrig){
        	if(sl.recordtype.developername=='OF_SA_FiberRequest'){//EC COMMENTO DIA || sl.recordtype.developername=='OF_DIA_FiberRequest'){
	        	OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c(
	            RecordTypeId = sl.recordtypeId,
	            EOF_Tipo_COmunicazione_String__c='SF->OM - ActivationRequest',
	            OF_SA_Direzione_Flusso__c='SF-OM',
	            OF_SA_Metodo__c= 'OLO_ActivationSetup_OpenStream',
	  /*EC COMMENTO DIA          OF_SA_Metodo__c= (sl.recordtype.developername=='OF_SA_FiberRequest') ? 'OLO_ActivationSetup_OpenStream' 
                                                                                   : 'OLO_ActivationSetup_DIA',*/
	            EOF_Sorgente__c='OGW',
	            EOF_Tracciato__c = '3',
	            EOF_CODICE_OPERATORE__C=sl.EOF_CODICE_OPERATORE__c,
	            EOF_CODICE_ORDINE_OLO__C=sl.EOF_CODICE_ORDINE_OLO__c,
	            EOF_CODICE_ORDINE_EOF__C=c2.Codice_ordine_Eof__C,
	            EOF_DATA_NOTIFICA__C=sl.EOF_data_NOTIFICA__c, 
	            EOF_ID_NOTIFICA__C=sl.EOF_ID_NOTIFICA__c,
	            EOF_Id_servizio__c=c2.OF_SA_ID_Servizio__c,
	            EOF_NOME_REFERENTE_TECNICO_OLO__C=sl.EOF_NOME_REFERENTE_TECNICO_OLO__c,
	            EOF_COGNOME_REFERENTE_TECNICO_OLO__C=sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
	            EOF_TELEFONO_REFERENTE_TECNICO_OLO__C=sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
	            EOF_EMAIL_REFERENTE_TECNICO_OLO__C=sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__c,
	            EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C=sl.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
	            EOF_NOME_CLIENTE__C=sl.EOF_NOME_CLIENTE__c,
	            EOF_COGNOME_CLIENTE__C=sl.EOF_COGNOME_CLIENTE__c,
	            EOF_RECAPITO_TELEFONICO_CLIENTE_1__C=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
	            EOF_RECAPITO_TELEFONICO_CLIENTE_2__C=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
	            EOF_INFORMAZIONI_LOGISTICA_APPARATI__C=sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,
	            EOF_DATA_PREVISTA_ATTIVAZIONE__C=sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c,
	            EOF_ORARIO_APPUNTAMENTO__C=sl.EOF_ORARIO_APPUNTAMENTO__c,
	            EOF_CODICE_PROGETTO_SPECIALE__c=sl.EOF_CODICE_PROGETTO_SPECIALE__c,
	            EOF_PROMOZIONE__C=sl.EOF_PROMOZIONE__C,
	            EOF_CLUSTER_PROMOZIONE__C=sl.EOF_CLUSTER_PROMOZIONE__C,
	            EOF_NOTE__C=sl.EOF_NOTE__C,
	            EOF_SCALA_PALAZZINA__C=sl.EOF_SCALA_PALAZZINA__C,
	            EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C=sl.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
	            EOF_RECAPITO_TEST_LINEA__C=sl.EOF_RECAPITO_TEST_LINEA__C,
	            EOF_ID_Pop__c=sl.EOF_ID_Pop__c,
	            EOF_PROFILO__C=sl.EOF_PROFILO__C,
	            EOF_CODICE_MOTIVAZIONE__c=c2.OF_SA_CODICE_MOTIVAZIONE__c,
	            EOF_MOTIVAZIONE__c=c2.OF_SA_MOTIVAZIONE__c,
	            EOF_Provincia__c = c2.EOF_Provincia_WS__c,
	            EOF_Comune__c= c2.EOF_Comune_WS__c,
	            EOF_Particella_Toponomastica__c = c2.EOF_Particella_Toponomastica_WS__c,
	            EOF_Indirizzo__c = c2.EOF_Indirizzo_WS__c,
	            EOF_Numero_Civico__c = c2.EOF_Numero_Civico_WS__c,
	            EOF_ID_Building__c = c2.OF_SA_ID_Building_OM__c, 
                OF_SH_Token_id__c = c2.OF_SH_Token_id__c,
	            Caso__c=c2.Id,
                OF_SH_DeliveryCompany__c = c2.OF_SH_DeliveryCompany__c,
                OF_SH_AppointmentDate__c = OF_SA_GE_UtilsNew.DateToStringNoTime(c2.EOF_Data_Appuntamento__c),
                //OF_SA_FiberRequest = '1' => OpenStream ; OF_DIA_FiberRequest = '2' => DIA ;
                EOF_TIPOLOGIA_SERVIZIO__c ='1' ,//EC commento DIA (sl.recordtype.developername=='OF_SA_FiberRequest') ? '1' : '2',
                OF_SH_ID_WO__c = c2.OF_SH_ID_WO__c,
                //aa aggiunto campo 29/11/2018
                TRACCIATO_TRASCODIFICATO__c=sl.TRACCIATO_TRASCODIFICATO__c,
                OF_Codice_Operatore_Secondario__c = sl.OF_Codice_Operatore_Secondario__c,
                //Viene popolato momentaneamente con l'orario appuntamento
                OF_SH_Fascia_App__c = c2.EOF_Orario_Appuntamento__c
		        );
                OF_SA_GE_UtilsNew.slSFOM.EOF_Tipo_Comunicazione_Int__c = '1';
                OF_SA_GE_UtilsNew.slSFOM.OF_SH_Appuntamento_OLO__c = (OF_SA_GE_UtilsNew.slSFOM.EOF_Tracciato__c == '3') ? 'Y' : 'N';
		        if(c2.status=='Acquisito'){
		            OF_SA_GE_UtilsNew.slSFOM.EOF_Tipo_COmunicazione__c='1';
		            OF_SA_GE_UtilsNew.slSFOM.EOF_Stato_Ordine__c= '0';
		        }
		        else{
		            OF_SA_GE_UtilsNew.slSFOM.EOF_Tipo_COmunicazione__c='99';
		            OF_SA_GE_UtilsNew.slSFOM.EOF_Stato_Ordine__c= '1';
		        } 

		        listToOM.add(OF_SA_GE_UtilsNew.slSFOM);
                
        	}
	        Integer n = 1;
	        if(sl.recordtype.developername=='OF_SA_Vlan'){ 
	        	OF_SA_GE_UtilsNew.checkVLanToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.OF_SA_KIT_CONSEGNA_VLAN__C=sl.OF_SA_KIT_CONSEGNA_VLAN__C;
                sLog.OF_SA_USER_VLAN__C=sl.OF_SA_USER_VLAN__C;
                sLog.OF_SA_SERVICE_VLAN__C=sl.OF_SA_SERVICE_VLAN__C;
                sLog.OF_SA_PROFILO_VLAN__C=sl.OF_SA_PROFILO_VLAN__C;
                sLog.OF_SA_INFORMAZIONI_VLAN__C=sl.OF_SA_INFORMAZIONI_VLAN__C;
                sLog.OF_SA_CUSTOMER_VLAN__C=sl.OF_SA_CUSTOMER_VLAN__C;
                sLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C=sl.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C;
                //sLog.OF_SA_VLan_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n;
                OF_SA_GE_UtilsNew.ListVLanToOM.add(sLog); 
                listToOM.add(sLog);
                n++;
	        }
	        if(sl.recordtype.developername=='OF_SA_Cpe'){ 
	        	OF_SA_GE_UtilsNew.checkAppToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.EOF_TIPOLOGIA_APPARATO__C=sl.EOF_TIPOLOGIA_APPARATO__C;
                sLog.OF_SA_PASSWORD_APPARATO__C=sl.OF_SA_PASSWORD_APPARATO__C;
                sLog.OF_SA_AZIONE_APPARATO__C=sl.OF_SA_AZIONE_APPARATO__C;
                sLog.EOF_CAUSALE_APPARATO__c = sl.EOF_CAUSALE_APPARATO__c;
                //sLog.OF_SA_Cpe_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n;
                OF_SA_GE_UtilsNew.ListappToOM.add(sLog);
				listToOM.add(sLog);
                n++;
	        }
	        if(sl.recordtype.developername=='OF_SA_Servizi_Aggiuntivi'){ 
	        	OF_SA_GE_UtilsNew.checkServAggToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.OF_SA_NOME_SERVIZIO__c=sl.OF_SA_NOME_SERVIZIO__c; 
                sLog.OF_SA_INFORMAZIONI_SERVIZIO__c=sl.OF_SA_INFORMAZIONI_SERVIZIO__c;
                //sLog.OF_SA_servizi_Aggiuntivi_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n; 
                OF_SA_GE_UtilsNew.ListServAggToOM.add(sLog); 
                listToOM.add(sLog);
                n++;
	        } 
	             	
        }
        for(EOF_EAI_service_Log__c log : listToOM){
            if(OF_SA_GE_UTilsNew.rtMap.get('OF_SA_FiberRequest') == log.recordtypeid){//EC COMMENTO DIA || OF_SA_GE_UTilsNew.rtMap.get('OF_DIA_FiberRequest') == log.recordtypeid){
                log.EOF_Richiesta_Notifica__c = OF_SA_GE_UtilsNew.copy_request_OM_Activation(listToOM);
                break;
            }
        }
        return listToOM;
    } 
    public static String copy_request_OM_Activation(List<EOF_EAI_Service_Log__c> slSFOM_Act){
        String s = '';
        for(EOF_EAI_Service_Log__c sl : slSFOM_Act){
        	if(OF_SA_GE_UTilsNew.rtMap.get('OF_SA_FiberRequest') == sl.recordtypeid){//EC COMMENTO DIA || OF_SA_GE_UTilsNew.rtMap.get('OF_DIA_FiberRequest') == sl.recordtypeid){
                s +='SORGENTE: ' + sl.EOF_Sorgente__c + '\n' + 
                    'TRACCIATO: ' + sl.EOF_Tracciato__c + '\n' +
                    'CODICE_OPERATORE: ' + sl.EOF_CODICE_OPERATORE__C + '\n' +
                    'CODICE_ORDINE_OLO: ' + sl.EOF_CODICE_ORDINE_OLO__C + '\n' +
                    'CODICE_ORDINE_OF: ' + sl.EOF_CODICE_ORDINE_EOF__C + '\n' +
                    'DATA_NOTIFICA: ' + sl.EOF_DATA_NOTIFICA__C + '\n' +
                    'ID_NOTIFICA: ' + sl.EOF_ID_NOTIFICA__C + '\n' +
                    'ID_SERVIZIO: ' + sl.EOF_Id_servizio__c + '\n' +
                    'NOME_REFERENTE_TECNICO_OLO: ' + sl.EOF_NOME_REFERENTE_TECNICO_OLO__C + '\n' +
                    'COGNOME_REFERENTE_TECNICO_OLO: ' + sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__C + '\n' +
                    'TELEFONO_REFERENTE_TECNICO_OLO: ' + sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__C + '\n' +
                    'EMAIL_REFERENTE_TECNICO_OLO: ' + sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__C + '\n' +
                    'TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH: ' + sl.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C+ '\n' +
                    'NOME_CLIENTE: ' + sl.EOF_NOME_CLIENTE__C + '\n' +
                    'COGNOME_CLIENTE: ' + sl.EOF_COGNOME_CLIENTE__C + '\n' +
                    'RECAPITO_TELEFONICO_CLIENTE_1: ' + sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__C + '\n' +
                    'RECAPITO_TELEFONICO_CLIENTE_2: ' + sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__C + '\n' +
                    'INFORMAZIONI_LOGISTICA_APPARATI: ' + sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__C + '\n' +
                    'DATA_PREVISTA_ATTIVAZIONE: ' + sl.EOF_DATA_PREVISTA_ATTIVAZIONE__C + '\n' +
                    'ORARIO_APPUNTAMENTO: ' + sl.EOF_ORARIO_APPUNTAMENTO__C+ '\n' +
                    'CODICE_PROGETTO_SPECIALE: ' + sl.EOF_CODICE_PROGETTO_SPECIALE__c + '\n' +
                    'PROMOZIONE: ' + sl.EOF_PROMOZIONE__C + '\n' +
                    'CLUSTER_PROMOZIONE: ' + sl.EOF_CLUSTER_PROMOZIONE__C + '\n' +
                    'NOTE: ' + sl.EOF_NOTE__C + '\n' + 
                    'ID_BUILDING: ' + sl.EOF_ID_Building__c + '\n' +
                    'SCALA_PALAZZINA: ' + sl.EOF_SCALA_PALAZZINA__C + '\n' +
                    'NUMERO_TELEFONICO_PRINCIPALE_LINEA: ' + sl.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C + '\n' +
                    'RECAPITO_TEST_LINEA: ' + sl.EOF_RECAPITO_TEST_LINEA__C + '\n' +
                    'IDENTIFICATIVO_DEL_POP: ' + sl.EOF_ID_Pop__c + '\n' +           
                    'PROFILO: ' + sl.EOF_PROFILO__C + '\n' +
                    'CODICE_MOTIVAZIONE: ' + sl.EOF_CODICE_MOTIVAZIONE__c + '\n' +
                    'MOTIVAZIONE: ' + sl.EOF_MOTIVAZIONE__c + '\n' +
                    'PROVINCIA: ' + sl.EOF_Provincia__c + '\n' +
                    'COMUNE: ' + sl.EOF_Comune__c + '\n' +
                    'PARTICELLA_TOPONOMASTICA: ' + sl.EOF_Particella_Toponomastica__c+ '\n' +
                    'INDIRIZZO: ' + sl.EOF_Indirizzo__c + '\n' + 
                    'NUMERO_CIVICO: ' + sl.EOF_Numero_Civico__c + '\n' +
                    'IDENTIFICATIVO_PRENOTAZIONE: ' + sl.OF_SH_Token_id__c + '\n' +
                    'DELIVERY_COMPANY: ' + sl.OF_SH_DeliveryCompany__c + '\n' +
                    'DATA_APPUNTAMENTO: ' + sl.OF_SH_AppointmentDate__c + '\n' + 
                    'TIPOLOGIA_SERVIZIO: ' + sl.EOF_TIPOLOGIA_SERVIZIO__c + '\n' +
                    'ID_WO: ' + sl.OF_SH_ID_WO__c + '\n' +
                    'TRACCIATO_TRASCODIFICATO: ' + sl.TRACCIATO_TRASCODIFICATO__c + '\n' +
                    'FASCIA_APP: ' + sl.OF_SH_Fascia_App__c + '\n' +
                    'TIPO_COMUNICAZIONE: ' + sl.EOF_Tipo_COmunicazione__c + '\n' +
                    'APPUNTAMENTO_OLO: ' + sl.OF_SH_Appuntamento_OLO__c + '\n' + 
                    'STATO_ORDINE: ' + sl.EOF_Stato_Ordine__c + '\n' ;
            }
	        Integer n = 1;
            if(OF_SA_GE_UTilsNew.rtMap.get('OF_SA_Vlan') == sl.recordtypeid){ 
                s +='\n' + 'VLAN '+n+': \n' +
                    'KIT_CONSEGNA_VLAN: ' + sl.OF_SA_KIT_CONSEGNA_VLAN__C + '\n' +
                    'USER_VLAN: ' + sl.OF_SA_USER_VLAN__C + '\n' +
                    'SERVICE_VLAN: ' + sl.OF_SA_SERVICE_VLAN__C + '\n' +
                    'PROFILO_VLAN: ' + sl.OF_SA_PROFILO_VLAN__C + '\n' +
                    'INFORMAZIONI_VLAN: ' + sl.OF_SA_INFORMAZIONI_VLAN__C + '\n' +
                    'CUSTOMER_VLAN: ' + sl.OF_SA_CUSTOMER_VLAN__C + '\n' +
                    'MODELLO_DI_SERVIZIO_VLAN: ' + sl.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C + '\n';
                n++;
	        }
            if(OF_SA_GE_UTilsNew.rtMap.get('OF_SA_Cpe') == sl.recordtypeid){ 
                s +='\n' + 'APPARATO '+n+': \n' +
                    'TIPOLOGIA_APPARATO: ' + sl.EOF_TIPOLOGIA_APPARATO__C + '\n' +
                    'PASSWORD_APPARATO: ' + sl.OF_SA_PASSWORD_APPARATO__C + '\n' +
                    'AZIONE_APPARATO: ' + sl.OF_SA_AZIONE_APPARATO__C + '\n' +
                    'CAUSALE_APPARATO: ' + sl.EOF_CAUSALE_APPARATO__c + '\n' ;
                n++;
	        }
            if(OF_SA_GE_UTilsNew.rtMap.get('OF_SA_Servizi_Aggiuntivi') == sl.recordtypeid){ 
                s +='\n' + 'SERVIZIO AGGIUNTIVO '+n+': \n' +
                    'NOME_SERVIZIO: ' + sl.OF_SA_NOME_SERVIZIO__c + '\n' +
	        	    'INFORMAZIONI_SERVIZIO: ' + sl.OF_SA_INFORMAZIONI_SERVIZIO__c + '\n';               
                n++;
	        } 	
        }
        return s;
    }
    //Status Update solo ritorno senza inserirli a sistema (per callout sincrone)
    public static List<EOF_EAI_Service_Log__C> OM_CreateStatusUpdate_LogNew(case c, object o){
        
        //CRM 05/06/2017 modificata la query. Ora viene usato il DeveloperName al posto del Name
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        if(!OF_SA_GE_UtilsNew.checkrtMap){
    		List<recordtype> rtList=[select Id,developerName from recordtype];
	        OF_SA_GE_UtilsNew.rtMap = new Map<String,Id>(); 
	        for(recordtype rt :rtList){
	            OF_SA_GE_UtilsNew.rtMap.put(rt.DeveloperName, rt.Id); 
	        }               
	        OF_SA_GE_UtilsNew.checkrtMap=true;
    	}    

        //END CRM 05/06/2017
        //caso in cui mi arriva effettivamente da OM
        if(o instanceof OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate){
            OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate a = (OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate) o; 

            OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c(
           //EC COMMENTO DIA     RecordTypeId = (String.isNotBlank(c.RecordType.DeveloperName) && c.RecordType.DeveloperName.startsWithIgnoreCase('OF_SA_')) ? OF_SA_GE_UtilsNew.rtMap.get('OF_SA_FiberNotify') : OF_SA_GE_UtilsNew.rtMap.get('OF_DIA_FiberNotify'),
                RecordTypeId = OF_SA_GE_UtilsNew.rtMap.get('OF_SA_FiberNotify'),
                EOF_Tipo_COmunicazione_String__c='SF->OLO - StatusUpdate',
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_StatusUpdate',
                EOF_CODICE_OPERATORE__c=a.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c=a.CODICE_ORDINE_OLO,
                EOF_CODICE_ORDINE_EOF__c=a.CODICE_ORDINE_OF,
                EOF_DATA_NOTIFICA__c=StringToDate(a.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c=a.ID_NOTIFICA,
                EOF_STATO_ORDINE__c=a.STATO_ORDINE,
                EOF_CODICE_MOTIVAZIONE__c=a.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__c=a.MOTIVAZIONE,
                EOF_GPON_Attestazione__c=a.GPON_DI_ATTESTAZIONE,
                EOF_ID_SERVIZIO__c = a.ID_SERVIZIO,
                EOF_NOME_CLIENTE__c=a.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__c=a.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE__c=a.RECAPITO_TELEFONICO_CLIENTE,
                EOF_DATA_PREVISTA_ATTIVAZIONE__c=StringToDateNoTime(a.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__c=a.ORARIO_APPUNTAMENTO,
                EOF_PIN_INTERVENTO_A_VUOTO__c=a.PIN_INTERVENTO_A_VUOTO,
                OF_Flag_Desospensione__c = a.FLAG_DESOSPENSIONE,
                OF_Remote_ID__c = a.REMOTE_ID,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            OF_SA_GE_UtilsNew.slSFOLO.caso__c=c.Id;
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
            	OF_SA_GE_UtilsNew.slSFOLO.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
            	OF_SA_GE_UtilsNew.slSFOLO.EOF_Note__c = a.NOTE;
            }
            // finisce qui
                                    
            sLogList.add(OF_SA_GE_UtilsNew.slSFOLO);
            Integer n = 1;
            if(a.VLAN!=null && !a.VLAN.isEmpty()){ 
            	OF_SA_GE_UtilsNew.checkVlan=true;
            	OF_SA_GE_UtilsNew.ListVlan= new List<EOF_EAI_Service_Log__C>();
                for(OF_WS_IN_OM_StatusUpdateNew.VLan v : a.VLan){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.EOF_Tipo_COmunicazione_String__c='VLAN';
                    sLog.recordtypeid=OF_SA_GE_UtilsNew.rtMap.get('OF_SA_Vlan');
                    sLog.OF_SA_USER_VLAN__C=v.USER_VLAN;
                    sLog.OF_SA_SERVICE_VLAN__C=v.SERVICE_VLAN;
                    sLog.OF_SA_CUSTOMER_VLAN__C=v.CUSTOMER_VLAN;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
	                sLogList.add(sLog);
	                OF_SA_GE_UtilsNew.ListVlan.add(sLog);
	                n++;
                }
            }
            if(a.apparato!=null && !a.apparato.isEmpty()){
            	OF_SA_GE_UtilsNew.checkApp=true;
            	OF_SA_GE_UtilsNew.ListApp= new List<EOF_EAI_Service_Log__C>();
                for(OF_WS_IN_OM_StatusUpdateNew.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.EOF_Tipo_COmunicazione_String__c='CPE';
                    sLog.recordtypeid=OF_SA_GE_UtilsNew.rtMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.OF_SA_ESITO_RITIRO_APPARATO__C=app.ESITO_RITIRO_APPARATO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_RITIRO__C=app.CODICE_MOTIVAZIONE_RITIRO;
                    sLog.OF_SA_MOTIVAZIONE_RITIRO__C=app.MOTIVAZIONE_RITIRO;
                    sLog.OF_SA_ID_APPARATO__c = app.ID_APPARATO;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
	                sLogList.add(sLog);
	                OF_SA_GE_UtilsNew.ListApp.add(sLog);
	                n++;
                }
            }
            return sLogList;   
        }         
        return null;
    } 
    //Aggiorna dati per OM_CompletionOrder
    @future
    public static void aggiornamentoDatiEspletamentoNew(String caseId, String slSFOLOId, String slSFOLORespId){
     	Case c = [SELECT EOF_Codice_Ordine_OLO__c, EOF_Id_Risorsa__c, OF_Bonifica_Locked_Row__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c,
     				     EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
     				     OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
     				     OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
     				     EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c,
     				     PO_Attenuazione__c, PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, RecordTypeId, RecordType.DeveloperName,
     				     Status, OF_Order__c, EOF_ID_Splitter_Secondario__c, EOF_Posizione_Splitter_Secondario__c, PO_Comune__c, EOF_Istat_Comune__c,
                         EOF_Istat_Provincia__c, PO_Indirizzo_collegamento__c, PO_Civico__c, OF_IDContratto__c, OF_CPE_Quantity__c, NS_Rif__c
     	 		 FROM Case 
                 WHERE Id = :caseId];

 	 	OF_SA_GE_UtilsNew.slSFOLO = [SELECT Id, EOF_Tipo_comunicazione__c, EOF_Data_espletamento_ordine__c, EOF_Data_Notifica__c 
                                     FROM EOF_EAI_Service_Log__c 
                                     WHERE Id = :slSFOLOId];
     	OF_SA_GE_UtilsNew.slSFOLOResp = [SELECT Id, EOF_Tipo_comunicazione__c, EOF_Data_espletamento_ordine__c, EOF_Data_Notifica__c, lastModifiedDate 
                                         FROM EOF_EAI_Service_Log__c 
                                         WHERE Id = :slSFOLORespId];
        
        //AA Nuova logica di espletamento rivista con Ruben
        
        /*
     	OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
		c.AssetId = mofc.ManageOrder(c);*/
        OF_ManageOrderFromCase_GPONP mofc = new OF_ManageOrderFromCase_GPONP();
		c.AssetId = mofc.ManageOrder(c);
		//update c;
    } 
    //Aggiorna dati per OM_CompletionOrder_GPONP  
    @future
    public static void aggiornamentoDatiEspletamentoNew_GPONP(String caseId, String slSFOLOId, String slSFOLORespId){
     	Case c = [SELECT EOF_Codice_Ordine_OLO__c, EOF_Id_Risorsa__c, OF_Bonifica_Locked_Row__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c,
     				     EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
     				     OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
     				     OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
     				     EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c,
     				     PO_Attenuazione__c, PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, RecordTypeId, RecordType.DeveloperName,
     				     Status, OF_Order__c, EOF_ID_Splitter_Secondario__c, EOF_Posizione_Splitter_Secondario__c, PO_Comune__c, EOF_Istat_Comune__c,
                         EOF_Istat_Provincia__c, PO_Indirizzo_collegamento__c, PO_Civico__c, OF_IDContratto__c, OF_CPE_Quantity__c, NS_Rif__c
     	 		 FROM Case 
                 WHERE Id = :caseId];

 	 	OF_SA_GE_UtilsNew.slSFOLO = [SELECT Id, EOF_Tipo_comunicazione__c, EOF_Data_espletamento_ordine__c, EOF_Data_Notifica__c 
                                     FROM EOF_EAI_Service_Log__c 
                                     WHERE Id = :slSFOLOId];
     	OF_SA_GE_UtilsNew.slSFOLOResp = [SELECT Id, EOF_Tipo_comunicazione__c, EOF_Data_espletamento_ordine__c, EOF_Data_Notifica__c, lastModifiedDate 
                                         FROM EOF_EAI_Service_Log__c 
                                         WHERE Id = :slSFOLORespId];

        //AA Nuova logica di espletamento rivista con Ruben
        OF_ManageOrderFromCase_GPONP mofc = new OF_ManageOrderFromCase_GPONP();
		c.AssetId = mofc.ManageOrder(c);
     	/*OF_manageOrderFromCase mofc = new OF_manageOrderFromCase();
		c.AssetId = mofc.ManageOrder(c);*/

		//update c;
    } 
    //Completion Order solo ritorno senza inserirli a sistema (per callout sincrone)
    public static List<EOF_EAI_Service_Log__C> OM_CreateCompletionOrder_Log(case c,object o){          
        
        //CRM 05/06/2017 modificata la query. Ora viene usato il DeveloperName al posto del Name
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        List<recordtype> rtList=[select Id,developerName from recordtype];
        OF_SA_GE_UtilsNew.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_SA_GE_UtilsNew.rtMap.put(rt.developerName, rt.Id); 
        }
        OF_SA_GE_UtilsNew.checkrtMap=true;
        //END CRM 05/06/2017
        if(o instanceof OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder){
            
            OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder a = (OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder) o;         
            OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c(
            // EC Commento DIA 2019 04 05       RecordTypeId = (String.isBlank(a.TIPOLOGIA_SERVIZIO)) ? rtMap.get('OF_SA_FiberNotify') : rtMap.get('OF_DIA_FiberNotify'),
                RecordTypeId = rtMap.get('OF_SA_FiberNotify'),
                EOF_Tipo_COmunicazione_String__c='SF-OLO - CompletionOrder',
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_CompletionOrder_OpenStream',
                EOF_CODICE_OPERATORE__C=a.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__C=a.CODICE_ORDINE_OLO,
                EOF_CODICE_ORDINE_EOF__C=a.CODICE_ORDINE_OF,
                EOF_DATA_NOTIFICA__C=StringTODate(a.DATA_NOTIFICA), 
                EOF_ID_NOTIFICA__C=a.ID_NOTIFICA,
                EOF_STATO_ORDINE__c=a.STATO_ORDINE,
                EOF_CODICE_MOTIVAZIONE__c=a.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__c=a.MOTIVAZIONE,
                EOF_ID_RISORSA__C=a.ID_RISORSA,
                EOF_DATA_ESPLETAMENTO_ORDINE__C=StringTODateNoTime(a.DATA_ESPLETAMENTO_ORDINE),
                EOF_SCALA_PALAZZINA__c=a.SCALA_PALAZZINA,
                EOF_Parametri_Trasmissivi_Ottici__c = a.PARAMETRI_TRASMISSIVI_OTTICI,
                OF_SA_DDT__c=a.DDT,
                //AA 291118 - Aggiunti nuovi campi richiesti
                OF_Id_Borchia__c = a.SERIALE_BORCHIA,
                EOF_GPON_Attestazione__c = a.GPON_DI_ATTESTAZIONE,
                EOF_Flag_Pagamento__c = a.FLAG_PAGAMENTO,
                EOF_Numero_Operatore__c = a.NUMERO_OPERATORE, 
                OF_Bretella_Ottica__c = a.BRETELLA_OTTICA,
                OF_Estensione_Impianto_Effettuata__c = a.ESTENSIONE_IMPIANTO_EFFETTUATA,
                OF_Estensione_Impianto__c = a.ESTENSIONE_IMPIANTO,
                OF_Metri_TOT__c = a.METRI_TOT,
                EOF_ID_Splitter_Secondario__c = a.ID_SPLITTER_SECONDARIO,
                EOF_Posizione_Splitter_Secondario__c = a.POSIZIONE_SPLITTER_SECONDARIO,
                //FINE AA
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            if(OF_SA_GE_UtilsNew.checkCaseOriginale){
                OF_SA_GE_UtilsNew.slSFOLO.caso__c=OF_SA_GE_UtilsNew.CaseOriginale.Id;
            }

            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
            	OF_SA_GE_UtilsNew.slSFOLO.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
            	OF_SA_GE_UtilsNew.slSFOLO.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            
            sLogList.add(OF_SA_GE_UtilsNew.slSFOLO);
            Integer n = 1;
            if(a.apparato!=null && !a.apparato.isEmpty()){
            	OF_SA_GE_UtilsNew.checkApp=true;
            	OF_SA_GE_UtilsNew.ListApp= new List<EOF_EAI_Service_Log__C>();
                for(OF_WS_IN_OM_CompletionOrderNew.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=rtMap.get('OF_SA_Cpe');
                    sLog.EOF_Tipo_COmunicazione_String__c='CPE';
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.EOF_ESITO_CONSEGNA_APPARATO__c=app.ESITO_CONSEGNA_APPARATO;
                    sLog.OF_SA_ID_APPARATO_CONSEGNATO__c=app.ID_APPARATO_CONSEGNATO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_CONSEGNA__c=app.CODICE_MOTIVAZIONE_CONSEGNA;
                    sLog.OF_SA_MOTIVAZIONE_CONSEGNA__c=app.MOTIVAZIONE_CONSEGNA;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
	                sLogList.add(sLog);
	                OF_SA_GE_UtilsNew.ListApp.add(sLog);
	                n++;
                }
            }
            if(a.servizio_Aggiuntivo!=null && !a.servizio_Aggiuntivo.isEmpty()){
            	OF_SA_GE_UtilsNew.checkServAgg=true;
            	OF_SA_GE_UtilsNew.ListServAgg= new List<EOF_EAI_Service_Log__C>();
                for(OF_WS_IN_OM_CompletionOrderNew.servizio_aggiuntivo sa : a.servizio_Aggiuntivo){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=rtMap.get('OF_SA_Servizi_Aggiuntivi');
                    sLog.EOF_Tipo_COmunicazione_String__c='SERVIZIO AGGIUNTIVO';
                    sLog.OF_SA_NOME_SERVIZIO__c=sa.NOME_SERVIZIO; 
                    sLog.OF_SA_ESITO_SERVIZIO__c=sa.ESITO_SERVIZIO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_SERVIZIO__c=sa.CODICE_MOTIVAZIONE_SERVIZIO;
                    sLog.OF_SA_MOTIVAZIONE_SERVIZIO__c=sa.MOTIVAZIONE_SERVIZIO;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
	                sLogList.add(sLog);
	                OF_SA_GE_UtilsNew.ListServAgg.add(sLog);
	                n++;
                } 
            } 
            return sLogList;       
        }
        return null;
    }
    //String to date
    public static Datetime stringToDate(String s){
        if(String.isBlank(s)){
            return null;
        }
        Datetime dt = Datetime.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)),integer.valueOf(s.left(13).right(2)),integer.valueOf(s.left(16).right(2)),integer.valueOf(s.left(19).right(2)));
        return dt;
    }
    //String to date no time
    public static Date stringToDateNoTime(String s){
        if(String.isBlank(s)){
            return null;
        }
        Date dt = Date.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)));
        return dt;
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
        if(!OF_SA_GE_UtilsNew.checkDate(s.left(10))){    	
            return false;    		
        }
        if(!OF_SA_GE_UtilsNew.checkTime(s.left(19).right(8))){    		
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
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{1,255}$'; // source: <a href="http://www.regular-expressions.info/email.html" target="_blank" rel="nofollow">http://www.regular-expressions.info/email.html</a>
        Pattern MyPattern = Pattern.compile(emailRegex);
        Matcher MyMatcher = MyPattern.matcher(email);
        if (!MyMatcher.matches()){ 
            res = false;
        }
        return res;	
    }
    // 15/06/2018 MM : aggiunto metodo per creazione templog
    public static void CreateTemplogOLO(Object o){
        try{
            if(o instanceof OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest){                
                OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest act = (OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest) o;
                
                // 8/06/2018 MM : Aggiunta creazione Templog per cattura timestamp attivazione
                OF_SA_GE_UtilsNew.tmpl = new TEMPLOG__c();
                OF_SA_GE_UtilsNew.tmpl.Name= act.CODICE_ORDINE_OLO +' - '+'Attivazione da OLO'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_SA_GE_UtilsNew.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ act.codice_ordine_olo;
                OF_SA_GE_UtilsNew.tmpl.Type__c ='T';
                OF_SA_GE_UtilsNew.tmpl.TL_codice_ordine_olo__c = act.CODICE_ORDINE_OLO;
                //OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione__c = '';
                OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OLO_Attivazione';
                OF_SA_GE_UtilsNew.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                
            }
            if(o instanceof OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest){                
                OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest Deact = (OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest) o;
                
                OF_SA_GE_UtilsNew.tmpl = new TEMPLOG__c();
                OF_SA_GE_UtilsNew.tmpl.Name= Deact.CODICE_ORDINE_OLO +' - '+'Cessazione da OLO'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_SA_GE_UtilsNew.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ Deact.codice_ordine_olo;
                OF_SA_GE_UtilsNew.tmpl.Type__c ='T';
                OF_SA_GE_UtilsNew.tmpl.TL_codice_ordine_olo__c = Deact.CODICE_ORDINE_OLO;
                //OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione__c = '';
                OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OLO_Cessazione';
                OF_SA_GE_UtilsNew.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                
            }
            if(o instanceof OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest){
                OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest rr = (OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest) o;
                
                // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp rimodulazione
                OF_SA_GE_UtilsNew.tmpl = new TEMPLOG__c();
                OF_SA_GE_UtilsNew.tmpl.Name= rr.CODICE_ORDINE_OLO +' - '+'RDAC da OLO'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_SA_GE_UtilsNew.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ rr.codice_ordine_olo;
                OF_SA_GE_UtilsNew.tmpl.Type__c ='T';
                OF_SA_GE_UtilsNew.tmpl.TL_codice_ordine_olo__c = rr.CODICE_ORDINE_OLO;
                //OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione__c = '';
                OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OLO_Rimodulazione_DAC';
                OF_SA_GE_UtilsNew.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                
            }
            if(o instanceof OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest){
                OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur = (OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest) o;
                
                // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp annullamento/desospensione
                OF_SA_GE_UtilsNew.tmpl = new TEMPLOG__c();
                OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_SA_GE_UtilsNew.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ sur.codice_ordine_olo;
                OF_SA_GE_UtilsNew.tmpl.Type__c ='T';
                OF_SA_GE_UtilsNew.tmpl.TL_codice_ordine_olo__c = sur.CODICE_ORDINE_OLO;
                OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione__c = sur.AZIONE;
                if('0'.equals(sur.AZIONE)){
                    OF_SA_GE_UtilsNew.OPName ='Desospensione da OLO';                 
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OLO_Desospensione';
                }
                if('1'.equals(sur.AZIONE)){
                    OF_SA_GE_UtilsNew.OPName ='Annullamento da OLO';                    
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OLO_Annullamento';
                }
                OF_SA_GE_UtilsNew.tmpl.Name= sur.CODICE_ORDINE_OLO +' - '+ OF_SA_GE_UtilsNew.OPName +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');                
                OF_SA_GE_UtilsNew.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                
            }               
        }
        catch(exception e){
            system.debug('@@@ - Exception:' +e);
        }
    }
    public static void partialTemplog(String s){
        try{
            if(OF_SA_GE_UtilsNew.tmpl!=null){
                OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c= OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c + ', '+s+' : '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
            }
        }
        catch(exception e){ 
            system.debug('@@@ - Exception:' +e);
            system.debug('@@@ - line exc ' + e.getLineNumber());
            system.debug('@@@ - exc in method partialTempLog');
        }
    }
    // 8/06/2018 MM : aggiunta metodo per inserimento TEMPLOG
    public static void EndTemplog(){        
        try{        
            // 8/06/2018 MM: Aggiorno il timestamp. END corrisponde all'uscita dal servizio.
            OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c = OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c + ', END: '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
            OF_SA_GE_UtilsNew.tmpl.Attraversamento__c = datetime.now().getTime() - OF_SA_GE_UtilsNew.AttrTime;        
            OF_SA_GE_UtilsNew.tmpl.OF_CPU_Time__c = string.valueof(Limits.getCpuTime());
            OF_SA_GE_UtilsNew.tmpl.OF_CPU_Time_Limit__c = string.valueof(Limits.getLimitCpuTime());            
            // 8/06/2018 MM : Inserisco il templog            
            insert OF_SA_GE_UtilsNew.tmpl;
        }catch(Exception e){
            system.debug('@@@ - Exception:' +e);
            system.debug('@@@ - line exc ' + e.getLineNumber());
            system.debug('@@@ - exc in method endtemplog');
        }
    } 
    public static void CreateTemlogOM(Object o){
        
        try{
            //OM_StatusUpdate
            if(o instanceof OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate){
                OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = (OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate) o;         
                                
                // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp status update
                OF_SA_GE_UtilsNew.tmpl = new TEMPLOG__c();
                OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_SA_GE_UtilsNew.tmpl.desc__c='TEMPLOG relativo alla Notify del case:'+ su.codice_ordine_olo;
                OF_SA_GE_UtilsNew.tmpl.Type__c ='T';
                OF_SA_GE_UtilsNew.tmpl.TL_codice_ordine_olo__c = su.CODICE_ORDINE_OLO;

                if('0'.equals(su.STATO_ORDINE)){
                    OF_SA_GE_UtilsNew.OPName='Acquisizione da OM';                    
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Acquisizione';		
                }
                if('1'.equals(su.STATO_ORDINE)){
                    OF_SA_GE_UtilsNew.OPName ='Acquisizione KO da OM';                    
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Acquisizione_KO';		
                }
                if('2'.equals(su.STATO_ORDINE)){
                    OF_SA_GE_UtilsNew.OPName ='Accettazione da OM';                    
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Accettazione';		
                }
                if('3'.equals(su.STATO_ORDINE)){
                    OF_SA_GE_UtilsNew.OPName ='Accettazione KO da OM';                    
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Accettazione_KO';		
                }
                if('4'.equals(su.STATO_ORDINE)){
                    OF_SA_GE_UtilsNew.OPName ='Sospensione da OM';                    
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Sospensione';		
                }
                if('5'.equals(su.STATO_ORDINE)){
                    OF_SA_GE_UtilsNew.OPName ='Annullamento da OM';                   
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Annullamento';		
                }
                if('6'.equals(su.STATO_ORDINE)){
                    OF_SA_GE_UtilsNew.OPName ='Cessazione da OM';                    
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Cessazione';		
                }
                if('7'.equals(su.STATO_ORDINE)){
                    OF_SA_GE_UtilsNew.OPName ='Cessazione KO da OM';
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Cessazione_KO';		
                }
                
                OF_SA_GE_UtilsNew.tmpl.Name= su.CODICE_ORDINE_OLO +' - '+ OF_SA_GE_UtilsNew.OPName +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');                
                OF_SA_GE_UtilsNew.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                
            }
            //OM_Reschedule
            if(o instanceof OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule){

                OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = (OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule) o;         

                OF_SA_GE_UtilsNew.tmpl = new TEMPLOG__c();
                OF_SA_GE_UtilsNew.tmpl.Name= r.CODICE_ORDINE_OLO +' - '+'RDAC da OM'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_SA_GE_UtilsNew.tmpl.desc__c='TEMPLOG relativo alla Notify del case:'+ r.codice_ordine_olo;
                OF_SA_GE_UtilsNew.tmpl.Type__c ='T';
                OF_SA_GE_UtilsNew.tmpl.TL_codice_ordine_olo__c = r.CODICE_ORDINE_OLO;
                //OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione__c = '';
                OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Rimodulazione_DAC';		
                OF_SA_GE_UtilsNew.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                                
            }
            //OM_CompletionOrder
            if(o instanceof OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder){

                OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = (OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder) o;         

                OF_SA_GE_UtilsNew.tmpl = new TEMPLOG__c();
                OF_SA_GE_UtilsNew.tmpl.Name = co.CODICE_ORDINE_OLO +' - '+'Espletamento'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_SA_GE_UtilsNew.tmpl.Tempi_Parziali__c = 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_SA_GE_UtilsNew.tmpl.desc__c = 'TEMPLOG relativo alla Notify del case:' + co.codice_ordine_olo;
                OF_SA_GE_UtilsNew.tmpl.Type__c ='T';
                OF_SA_GE_UtilsNew.tmpl.TL_codice_ordine_olo__c = co.CODICE_ORDINE_OLO;
                OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione__c = '7';
                if('0'.equals(co.STATO_ORDINE)){
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Espletamento_OK';		
                }
                if('1'.equals(co.STATO_ORDINE)){
                    OF_SA_GE_UtilsNew.tmpl.Tipo_Comunicazione_String__c = 'OM_Espletamento_KO';		
                }                
                OF_SA_GE_UtilsNew.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                
            }
        }catch(exception e){
            system.debug('@@@ - Exception:' +e);
        }
    }
    public static void aggiornaSLPortale(List<EOF_EAI_Service_Log__c> slList, String metodo){
        List<EOF_EAI_Service_Log__c> slPortaleToUpsert= new List<EOF_EAI_Service_Log__c>();
        Set<EOF_EAI_Service_Log__c> listApparatiDaOM= new Set<EOF_EAI_Service_Log__c>();
        Set<EOF_EAI_Service_Log__c> listVLANDaOM= new Set<EOF_EAI_Service_Log__c>();
        List<EOF_EAI_Service_Log__c> listApparatiDaPortale= new List<EOF_EAI_Service_Log__c>();
        List<EOF_EAI_Service_Log__c> listVLANDaPortale= new List<EOF_EAI_Service_Log__c>();
        List<EOF_EAI_Service_Log__c> listServiziAggiuntiviDaPortale= new List<EOF_EAI_Service_Log__c>();
        Set<EOF_EAI_Service_Log__c> listServiziAggiuntiviDaOM= new Set<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__C slPrincipaleToOLO = new EOF_EAI_Service_Log__C();
        EOF_EAI_Service_Log__C slPrincipalePortale = new EOF_EAI_Service_Log__C();
        boolean apparatiDaOM=false;
        boolean VLANDaOM=false;
        boolean apparatiDaPortale=false;
        boolean VLANDaPortale=false;
        boolean ServiziAggiuntiviDaPortale=false;
        boolean ServiziAggiuntiviDaOM=false;
        //system.debug('Alessandro: la lista completa da OM è: '+slList);
        //---------------------------------- metodo Update -------------------------------------
        if(metodo=='OM_StatusUpdate'){
            if(slList.size()>1){
                slPrincipaleToOLO=slList[0];
                List<EOF_EAI_service_Log__c> slListPortale =[Select Id,EOF_Codice_Ordine_OLO__C,recordType.developerName,EOF_TIPOLOGIA_APPARATO__C,OF_SA_User_Vlan__c,OF_SA_Service_Vlan__c
                                                             from EOF_EAI_service_Log__c where EOF_Stato_Richiesta__c='Inserita Portale'
                                                             AND EOF_COdice_Ordine_OLO__c=:slPrincipaleToOLO.EOF_COdice_Ordine_OLO__c
                                                             order by createdDate ASC];
                system.debug('Alessandro: la lista da Portale è: '+slListPortale); 
                for(EOF_EAI_Service_Log__C slTemp : slList){
                    if(slTemp.EOF_Tipo_Comunicazione_String__c=='CPE'){
                        apparatiDaOM=true;
                        listApparatiDaOM.add(slTemp);
                    }
                    if(slTemp.EOF_Tipo_Comunicazione_String__c=='VLAN'){
                        VLANDaOM=true;
                        listVLANDaOM.add(slTemp);
                    }
                }
                
                //verifico se la lista da portale è maggiore di 1
                if(slListPortale.size()>1){
                    
                    //aggiorno la principale del portale e la aggiungo alla lista e creo le altre liste da portale
                    for(EOF_EAI_Service_Log__c slTempPortale : slListPortale){
                        if(slTempPortale.recordType.developerName=='PO_SA_FiberRequest'){
                            slPrincipalePortale=slTempPortale;
                            slPrincipalePortale.EOF_DATA_Notifica__c=slPrincipaleToOLO.EOF_DATA_Notifica__c;
                            slPrincipalePortale.EOF_ID_Notifica__c=slPrincipaleToOLO.EOF_ID_Notifica__c;
                            slPrincipalePortale.EOF_Stato_Ordine__c=OF_SA_GE_UtilsNew.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
                            if(!String.isBlank(slPrincipaleToOLO.EOF_Codice_Motivazione__c)){
                                slPrincipalePortale.EOF_Motivazione__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c+' - '+slPrincipaleToOLO.EOF_Motivazione__c;
                            }
                            if(!String.isBlank(slPrincipaleToOLO.EOF_GPON_Attestazione__c)){
                                slPrincipalePortale.EOF_GPON_Attestazione__c=slPrincipaleToOLO.EOF_GPON_Attestazione__c;
                            }
                            if(!String.isBlank(slPrincipaleToOLO.EOF_Nome_Cliente__c)){
                                slPrincipalePortale.EOF_Nome_Cliente__c=slPrincipaleToOLO.EOF_Nome_Cliente__c;
                            }
                            if(!String.isBlank(slPrincipaleToOLO.EOF_COgnome_CLiente__c)){
                                slPrincipalePortale.EOF_COgnome_CLiente__c=slPrincipaleToOLO.EOF_COgnome_CLiente__c;
                            }
                            if(!String.isBlank(slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c)){
                                slPrincipalePortale.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
                            }
                            if(!String.isBlank(slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c)){
                                slPrincipalePortale.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
                            }
                            if(slPrincipaleToOLO.EOF_DATA_PREVISTA_ATTIVAZIONE__c!=null){
                                slPrincipalePortale.EOF_DATA_PREVISTA_ATTIVAZIONE__c=slPrincipaleToOLO.EOF_DATA_PREVISTA_ATTIVAZIONE__c;
                            }
                            if(!String.isBlank(slPrincipaleToOLO.EOF_ORARIO_APPUNTAMENTO__c)){
                                slPrincipalePortale.EOF_ORARIO_APPUNTAMENTO__c=slPrincipaleToOLO.EOF_ORARIO_APPUNTAMENTO__c;
                            }
                            if(!String.isBlank(slPrincipaleToOLO.EOF_PIN_INTERVENTO_A_VUOTO__c)){
                                slPrincipalePortale.EOF_PIN_INTERVENTO_A_VUOTO__c=slPrincipaleToOLO.EOF_PIN_INTERVENTO_A_VUOTO__c;
                            }
                            
                            slPrincipalePortale.EOF_Note__C=slPrincipaleToOLO.EOF_Note__C;
                            slPortaleToUpsert.add(slPrincipalePortale);
                            
                        }
                        if(slTempPortale.recordType.developerName=='OF_SA_Vlan'){
                            VLANDaPortale=true;
                            listVLANDaPortale.add(slTempPortale);
                            
                        }
                        if(slTempPortale.recordType.developerName=='OF_SA_Cpe'){
                            apparatiDaPortale=true;
                            listApparatiDaPortale.add(slTempPortale);
                        }
                    }
                    //system.debug('Alessandro: apparati OM: '+apparatiDaOM+', apparati portale: '+apparatiDaPortale);
                    //comparo le liste 
                    //prima apparati
                    if(apparatiDaOM){
                        if(apparatiDaPortale){
                            for(EOF_EAI_Service_Log__c slTempDaOM : listapparatiDaOM){
                                for(EOF_EAI_Service_Log__c slTempPortale : listapparatiDaPortale){
                                    
                                    if(slTempPortale.EOF_TIPOLOGIA_APPARATO__C==slTempDaOM.EOF_TIPOLOGIA_APPARATO__C){
                                        slTempPortale.OF_SA_ESITO_RITIRO_APPARATO__c=slTempDaOM.OF_SA_ESITO_RITIRO_APPARATO__c;
                                        slTempPortale.OF_SA_CODICE_MOTIVAZIONE_RITIRO__c=slTempDaOM.OF_SA_CODICE_MOTIVAZIONE_RITIRO__c;
                                        slTempPortale.OF_SA_MOTIVAZIONE_RITIRO__c=slTempDaOM.OF_SA_MOTIVAZIONE_RITIRO__c;
                                        
                                        slPortaleToUpsert.add(slTempPortale);
                                        listapparatiDaOM.remove(slTempDaOM);
                                        break;
                                    }
                                }
                            } 
                        } 
                        //faccio il check se ci sono ancora elementi nella lista da OM
                        if(listapparatiDaOM.size()>0){
                            
                            for(EOF_EAI_Service_Log__c slTempDaOM : listapparatiDaOM){
                                EOF_EAI_Service_Log__c slTempPortale= new EOF_EAI_Service_Log__c();
                                slTempPortale=slTempDaOM;
                                slTempPortale.Id=null;
                                slTempPortale.EOF_Stato_Richiesta__c='Inserita Portale';
                                slTempPortale.EOF_COdice_Ordine_OLO__c=slPrincipalePortale.EOF_COdice_Ordine_OLO__c;
                                slTempPortale.OF_SA_Cpe_Log__c=slPrincipalePortale.Id;
                                slPortaleToUpsert.add(slTempPortale);
                            }
                        }
                    }
                    //poi VLAN
                    if(VLANDaOM){
                        if(VLANDaPortale){
                            for(EOF_EAI_Service_Log__c slTempDaOM : listVLANDaOM){
                                for(EOF_EAI_Service_Log__c slTempPortale : listVLANDaPortale){
                                    if(slTempPortale.OF_SA_USER_VLAN__c==slTempDaOM.OF_SA_USER_VLAN__c
                                       && slTempPortale.OF_SA_SERVICE_VLAN__c==slTempDaOM.OF_SA_SERVICE_VLAN__c){
                                           slTempPortale.OF_SA_Customer_vlan__c=slTempDaOM.OF_SA_Customer_vlan__c;
                                           slPortaleToUpsert.add(slTempPortale);
                                           listVLANDaOM.remove(slTempDaOM);
                                           break;
                                       }
                                }
                            }
                        } 
                        //faccio il check se ci sono ancora elementi nella lista da OM
                        if(listVLANDaOM.size()>0){
                            for(EOF_EAI_Service_Log__c slTempDaOM : listVLANDaOM){
                                EOF_EAI_Service_Log__c slTempPortale= new EOF_EAI_Service_Log__c();
                                slTempPortale=slTempDaOM;
                                slTempPortale.Id=null;
                                slTempPortale.OF_SA_VLan_Log__c=slPrincipalePortale.Id;
                                slTempPortale.EOF_Stato_Richiesta__c='Inserita Portale';
                                slTempPortale.EOF_COdice_Ordine_OLO__c=slPrincipalePortale.EOF_COdice_Ordine_OLO__c;
                                slPortaleToUpsert.add(slTempPortale);
                            }
                        }
                    }
                    //system.debug('Alessandro: La lista da aggiornare è: '+slPortaleToUpsert);
                    upsert slPortaleToUpsert;
                } 
                //la lista da portale non è maggiore di 1 quindi aggiorno il SL principale e creo i vari apparati/VLAN
                else{
                    slPrincipalePortale=slListPortale[0];
                    slPrincipalePortale.EOF_DATA_Notifica__c=slPrincipaleToOLO.EOF_DATA_Notifica__c;
                    slPrincipalePortale.EOF_ID_Notifica__c=slPrincipaleToOLO.EOF_ID_Notifica__c;
                    slPrincipalePortale.EOF_Stato_Ordine__c=OF_SA_GE_UtilsNew.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
                    if(!String.isBlank(slPrincipaleToOLO.EOF_Codice_Motivazione__c)){
                        slPrincipalePortale.EOF_Motivazione__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c+' - '+slPrincipaleToOLO.EOF_Motivazione__c;
                    }
                    if(!String.isBlank(slPrincipaleToOLO.EOF_GPON_Attestazione__c)){
                        slPrincipalePortale.EOF_GPON_Attestazione__c=slPrincipaleToOLO.EOF_GPON_Attestazione__c;
                    }
                    if(!String.isBlank(slPrincipaleToOLO.EOF_Nome_Cliente__c)){
                        slPrincipalePortale.EOF_Nome_Cliente__c=slPrincipaleToOLO.EOF_Nome_Cliente__c;
                    }
                    if(!String.isBlank(slPrincipaleToOLO.EOF_COgnome_CLiente__c)){
                        slPrincipalePortale.EOF_COgnome_CLiente__c=slPrincipaleToOLO.EOF_COgnome_CLiente__c;
                    }
                    if(!String.isBlank(slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c)){
                        slPrincipalePortale.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
                    }
                    if(!String.isBlank(slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c)){
                        slPrincipalePortale.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
                    }
                    if(slPrincipaleToOLO.EOF_DATA_PREVISTA_ATTIVAZIONE__c!=null){
                        slPrincipalePortale.EOF_DATA_PREVISTA_ATTIVAZIONE__c=slPrincipaleToOLO.EOF_DATA_PREVISTA_ATTIVAZIONE__c;
                    }
                    if(!String.isBlank(slPrincipaleToOLO.EOF_ORARIO_APPUNTAMENTO__c)){
                        slPrincipalePortale.EOF_ORARIO_APPUNTAMENTO__c=slPrincipaleToOLO.EOF_ORARIO_APPUNTAMENTO__c;
                    }
                    if(!String.isBlank(slPrincipaleToOLO.EOF_PIN_INTERVENTO_A_VUOTO__c)){
                        slPrincipalePortale.EOF_PIN_INTERVENTO_A_VUOTO__c=slPrincipaleToOLO.EOF_PIN_INTERVENTO_A_VUOTO__c;
                    }
                    slPrincipalePortale.EOF_Note__C=slPrincipaleToOLO.EOF_Note__C;
                    slPortaleToUpsert.add(slPrincipalePortale);
                    if(apparatiDaOM){
                        for(EOF_EAI_Service_Log__c slTempDaOM : listApparatiDaOM){
                            EOF_EAI_Service_Log__c slTempPortale= new EOF_EAI_Service_Log__c();
                            slTempPortale=slTempDaOM;
                            slTempPortale.Id=null;
                            slTempPortale.OF_SA_Cpe_Log__c=slPrincipalePortale.Id;
                            slTempPortale.EOF_Stato_Richiesta__c='Inserita Portale';
                            slTempPortale.EOF_COdice_Ordine_OLO__c=slPrincipalePortale.EOF_COdice_Ordine_OLO__c;
                            slPortaleToUpsert.add(slTempPortale);
                        }
                    } 
                    if(ServiziAggiuntiviDaOM){
                        for(EOF_EAI_Service_Log__c slTempDaOM : listServiziAggiuntiviDaOM){
                            EOF_EAI_Service_Log__c slTempPortale= new EOF_EAI_Service_Log__c();
                            slTempPortale=slTempDaOM;
                            slTempPortale.Id=null;
                            slTempPortale.OF_SA_VLan_Log__c=slPrincipalePortale.Id;
                            slTempPortale.EOF_Stato_Richiesta__c='Inserita Portale';
                            slTempPortale.EOF_COdice_Ordine_OLO__c=slPrincipalePortale.EOF_COdice_Ordine_OLO__c;
                            slPortaleToUpsert.add(slTempPortale);
                        }
                    } 
                    upsert slPortaleToUpsert;
                }
            }
            //caso in cui vi è solo la principale da OM
            else{
                slPrincipaleToOLO=slList[0];
                system.debug('Alessandro: la slPrincipaleToOLO da OM è: '+slPrincipaleToOLO);
                slPrincipalePortale =[Select Id,recordType.developerName,EOF_TIPOLOGIA_APPARATO__C,OF_SA_User_Vlan__c,OF_SA_Service_Vlan__c
                                      from EOF_EAI_service_Log__c where EOF_Stato_Richiesta__c='Inserita Portale'
                                      AND EOF_COdice_Ordine_OLO__c=:slPrincipaleToOLO.EOF_COdice_Ordine_OLO__c
                                      AND recordType.developerName='PO_SA_FiberRequest'];
                
                slPrincipalePortale.EOF_DATA_Notifica__c=slPrincipaleToOLO.EOF_DATA_Notifica__c;
                slPrincipalePortale.EOF_ID_Notifica__c=slPrincipaleToOLO.EOF_ID_Notifica__c;
                slPrincipalePortale.EOF_Stato_Ordine__c=OF_SA_GE_UtilsNew.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
                if(!String.isBlank(slPrincipaleToOLO.EOF_Codice_Motivazione__c)){
                    slPrincipalePortale.EOF_Motivazione__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c+' - '+slPrincipaleToOLO.EOF_Motivazione__c;
                }
                if(!String.isBlank(slPrincipaleToOLO.EOF_GPON_Attestazione__c)){
                    slPrincipalePortale.EOF_GPON_Attestazione__c=slPrincipaleToOLO.EOF_GPON_Attestazione__c;
                }
                if(!String.isBlank(slPrincipaleToOLO.EOF_Nome_Cliente__c)){
                    slPrincipalePortale.EOF_Nome_Cliente__c=slPrincipaleToOLO.EOF_Nome_Cliente__c;
                }
                if(!String.isBlank(slPrincipaleToOLO.EOF_COgnome_CLiente__c)){
                    slPrincipalePortale.EOF_COgnome_CLiente__c=slPrincipaleToOLO.EOF_COgnome_CLiente__c;
                }
                if(!String.isBlank(slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c)){
                    slPrincipalePortale.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
                }
                if(!String.isBlank(slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c)){
                    slPrincipalePortale.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
                }
                if(slPrincipaleToOLO.EOF_DATA_PREVISTA_ATTIVAZIONE__c!=null){
                    slPrincipalePortale.EOF_DATA_PREVISTA_ATTIVAZIONE__c=slPrincipaleToOLO.EOF_DATA_PREVISTA_ATTIVAZIONE__c;
                }
                if(!String.isBlank(slPrincipaleToOLO.EOF_ORARIO_APPUNTAMENTO__c)){
                    slPrincipalePortale.EOF_ORARIO_APPUNTAMENTO__c=slPrincipaleToOLO.EOF_ORARIO_APPUNTAMENTO__c;
                }
                if(!String.isBlank(slPrincipaleToOLO.EOF_PIN_INTERVENTO_A_VUOTO__c)){
                    slPrincipalePortale.EOF_PIN_INTERVENTO_A_VUOTO__c=slPrincipaleToOLO.EOF_PIN_INTERVENTO_A_VUOTO__c;
                }
                slPrincipalePortale.EOF_Note__C=slPrincipaleToOLO.EOF_Note__C;
                update slPrincipalePortale;
            }
        }
        
        //--------------------------- completion Order ------------------------------------------
        if(metodo=='OM_CompletionOrder'){
            
            if(slList.size()>1){
                slPrincipaleToOLO=slList[0];
                List<EOF_EAI_service_Log__c> slListPortale =[Select Id,EOF_COdice_Ordine_OLO__c,recordType.developerName,EOF_TIPOLOGIA_APPARATO__C,
                                                             OF_SA_NOME_Servizio__c
                                                             from EOF_EAI_service_Log__c where EOF_Stato_Richiesta__c='Inserita Portale'
                                                             AND EOF_COdice_Ordine_OLO__c=:slPrincipaleToOLO.EOF_COdice_Ordine_OLO__c
                                                             order by createdDate ASC];
                //system.debug('Alessandro: la lista tirata fuori da portale è: '+slListPortale);
                for(EOF_EAI_Service_Log__C slTemp : slList){
                    if(slTemp.EOF_Tipo_Comunicazione_String__c=='CPE'){
                        apparatiDaOM=true;
                        listApparatiDaOM.add(slTemp);
                    }
                    if(slTemp.EOF_Tipo_Comunicazione_String__c=='SERVIZIO AGGIUNTIVO'){
                        ServiziAggiuntiviDaOM=true;
                        listServiziAggiuntiviDaOM.add(slTemp);
                    }
                }
                //verifico se la lista da portale è maggiore di 1
                if(slListPortale.size()>1){
                    system.debug('Alessandro: la lista da Portale è maggiore di uno');
                    //aggiorno la principale del portale e la aggiungo alla lista e creo le altre liste da portale
                    for(EOF_EAI_Service_Log__c slTempPortale : slListPortale){
                        if(slTempPortale.recordType.developerName=='PO_SA_FiberRequest'){
                            slPrincipalePortale=slTempPortale;
                            slPrincipalePortale.EOF_DATA_Notifica__c=slPrincipaleToOLO.EOF_DATA_Notifica__c;
                            slPrincipalePortale.EOF_ID_Notifica__c=slPrincipaleToOLO.EOF_ID_Notifica__c;
                            slPrincipalePortale.EOF_Stato_Ordine__c=OF_SA_GE_UtilsNew.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
                            if(!String.isBlank(slPrincipaleToOLO.EOF_Codice_Motivazione__c)){
                                slPrincipalePortale.EOF_Motivazione__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c+' - '+slPrincipaleToOLO.EOF_Motivazione__c;
                            }
                            
                            if(!String.isBlank(slPrincipaleToOLO.EOF_ID_RISORSA__c)){
                                slPrincipalePortale.EOF_ID_RISORSA__c=slPrincipaleToOLO.EOF_ID_RISORSA__c;
                            }
                            
                            if(slPrincipaleToOLO.EOF_Data_Espletamento_Ordine__c!=null){
                                slPrincipalePortale.EOF_Data_Espletamento_Ordine__c=slPrincipaleToOLO.EOF_Data_Espletamento_Ordine__c;
                            }
                            if(!String.isBlank(slPrincipaleToOLO.EOF_SCALA_PALAZZINA__c)){
                                slPrincipalePortale.EOF_SCALA_PALAZZINA__c=slPrincipaleToOLO.EOF_SCALA_PALAZZINA__c;
                            }
                            if(!String.isBlank(slPrincipaleToOLO.OF_SA_DDT__c)){
                                slPrincipalePortale.OF_SA_DDT__c=slPrincipaleToOLO.OF_SA_DDT__c;
                            }
                            
                            
                            slPrincipalePortale.EOF_Note__C=slPrincipaleToOLO.EOF_Note__C;
                            slPortaleToUpsert.add(slPrincipalePortale);
                        }
                        if(slTempPortale.recordType.developerName=='OF_SA_Servizi_Aggiuntivi'){
                            ServiziAggiuntiviDaPortale=true;
                            listServiziAggiuntiviDaPortale.add(slTempPortale);
                        }
                        if(slTempPortale.recordType.developerName=='OF_SA_Cpe'){
                            apparatiDaPortale=true;
                            listApparatiDaPortale.add(slTempPortale);
                        }
                    }
                    
                    //comparo le liste 
                    //prima apparati 
                    if(apparatiDaOM){
                        if(apparatiDaPortale){
                            system.debug('Alessandro: Prima del for con entrambe le liste per Apparati');
                            for(EOF_EAI_Service_Log__c slTempDaOM : listapparatiDaOM){
                                for(EOF_EAI_Service_Log__c slTempPortale : listapparatiDaPortale){
                                    system.debug('Alessandro: Dentro il for portale: '+slTempPortale.EOF_TIPOLOGIA_APPARATO__C+', OM: '+slTempDaOM.EOF_TIPOLOGIA_APPARATO__C);
                                    if(slTempPortale.EOF_TIPOLOGIA_APPARATO__C==slTempDaOM.EOF_TIPOLOGIA_APPARATO__C){
                                        slTempPortale.EOF_Esito_Consegna_Apparato__c=slTempDaOM.EOF_Esito_Consegna_Apparato__c;
                                        slTempPortale.OF_SA_ID_APPARATO_CONSEGNATO__c=slTempDaOM.OF_SA_ID_APPARATO_CONSEGNATO__c;
                                        slTempPortale.OF_SA_CODICE_MOTIVAZIONE_CONSEGNA__c=slTempDaOM.OF_SA_CODICE_MOTIVAZIONE_CONSEGNA__c;
                                        slTempPortale.OF_SA_MOTIVAZIONE_CONSEGNA__c=slTempDaOM.OF_SA_MOTIVAZIONE_CONSEGNA__c;
                                        system.debug('Alessandro: l apparato da aggiornare a portale è: '+slTempPortale);
                                        slPortaleToUpsert.add(slTempPortale);
                                        listapparatiDaOM.remove(slTempDaOM);
                                        break;
                                    }
                                }
                            } 
                        } 
                        //faccio il check se ci sono ancora elementi nella lista da OM
                        if(listapparatiDaOM.size()>0){
                            for(EOF_EAI_Service_Log__c slTempDaOM : listapparatiDaOM){
                                EOF_EAI_Service_Log__c slTempPortale= new EOF_EAI_Service_Log__c();
                                slTempPortale=slTempDaOM;
                                slTempPortale.Id=null;
                                slTempPortale.OF_SA_Cpe_Log__c=slPrincipalePortale.Id;
                                slTempPortale.EOF_Stato_Richiesta__c='Inserita Portale';
                                slTempPortale.EOF_COdice_Ordine_OLO__c=slPrincipalePortale.EOF_COdice_Ordine_OLO__c;
                                slPortaleToUpsert.add(slTempPortale);
                            }
                        }
                    }
                    //poi serviziAggiuntivi
                    if(serviziAggiuntiviDaOM){
                        if(serviziAggiuntiviDaPortale){
                            for(EOF_EAI_Service_Log__c slTempDaOM : listserviziAggiuntiviDaOM){
                                for(EOF_EAI_Service_Log__c slTempPortale : listserviziAggiuntiviDaPortale){
                                    if(slTempPortale.OF_SA_NOME_Servizio__c==slTempDaOM.OF_SA_NOME_Servizio__c){
                                        slTempPortale.OF_SA_ESITO_SERVIZIO__c=slTempDaOM.OF_SA_ESITO_SERVIZIO__c;
                                        slTempPortale.OF_SA_CODICE_MOTIVAZIONE_SERVIZIO__c=slTempDaOM.OF_SA_CODICE_MOTIVAZIONE_SERVIZIO__c;
                                        slTempPortale.OF_SA_MOTIVAZIONE_SERVIZIO__c=slTempDaOM.OF_SA_MOTIVAZIONE_SERVIZIO__c;
                                        slPortaleToUpsert.add(slTempPortale);
                                        listserviziAggiuntiviDaOM.remove(slTempDaOM);
                                        break;
                                    }
                                }
                            }
                        } 
                        //faccio il check se ci sono ancora elementi nella lista da OM
                        if(listserviziAggiuntiviDaOM.size()>0){
                            for(EOF_EAI_Service_Log__c slTempDaOM : listserviziAggiuntiviDaOM){
                                EOF_EAI_Service_Log__c slTempPortale= new EOF_EAI_Service_Log__c();
                                slTempPortale=slTempDaOM;
                                slTempPortale.Id=null;
                                slTempPortale.OF_SA_Cpe_Log__c=slPrincipalePortale.Id;
                                slTempPortale.EOF_Stato_Richiesta__c='Inserita Portale';
                                slTempPortale.EOF_COdice_Ordine_OLO__c=slPrincipalePortale.EOF_COdice_Ordine_OLO__c;
                                slPortaleToUpsert.add(slTempPortale);
                            }
                        }
                    }
                    upsert slPortaleToUpsert;
                } 
                //la lista da portale non è maggiore di 1 quindi aggiorno il SL principale e creo i vari apparati/VLAN
                else{
                    slPrincipalePortale=slListPortale[0];
                    slPrincipalePortale.EOF_DATA_Notifica__c=slPrincipaleToOLO.EOF_DATA_Notifica__c;
                    slPrincipalePortale.EOF_ID_Notifica__c=slPrincipaleToOLO.EOF_ID_Notifica__c;
                    slPrincipalePortale.EOF_Stato_Ordine__c=OF_SA_GE_UtilsNew.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
                    if(!String.isBlank(slPrincipaleToOLO.EOF_Codice_Motivazione__c)){
                        slPrincipalePortale.EOF_Motivazione__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c+' - '+slPrincipaleToOLO.EOF_Motivazione__c;
                    }
                    if(!String.isBlank(slPrincipaleToOLO.EOF_ID_RISORSA__c)){
                        slPrincipalePortale.EOF_ID_RISORSA__c=slPrincipaleToOLO.EOF_ID_RISORSA__c;
                    }
                    
                    if(slPrincipaleToOLO.EOF_Data_Espletamento_Ordine__c!=null){
                        slPrincipalePortale.EOF_Data_Espletamento_Ordine__c=slPrincipaleToOLO.EOF_Data_Espletamento_Ordine__c;
                    }
                    if(!String.isBlank(slPrincipaleToOLO.EOF_SCALA_PALAZZINA__c)){
                        slPrincipalePortale.EOF_SCALA_PALAZZINA__c=slPrincipaleToOLO.EOF_SCALA_PALAZZINA__c;
                    }
                    if(!String.isBlank(slPrincipaleToOLO.OF_SA_DDT__c)){
                        slPrincipalePortale.OF_SA_DDT__c=slPrincipaleToOLO.OF_SA_DDT__c;
                    }
                    slPrincipalePortale.EOF_Note__C=slPrincipaleToOLO.EOF_Note__C;
                    slPortaleToUpsert.add(slPrincipalePortale);
                    if(apparatiDaOM){
                        for(EOF_EAI_Service_Log__c slTempDaOM : listApparatiDaOM){
                            EOF_EAI_Service_Log__c slTempPortale= new EOF_EAI_Service_Log__c();
                            slTempPortale=slTempDaOM;
                            slTempPortale.Id=null;
                            slTempPortale.OF_SA_Cpe_Log__c=slPrincipalePortale.Id;
                            slTempPortale.EOF_Stato_Richiesta__c='Inserita Portale';
                            slTempPortale.EOF_COdice_Ordine_OLO__c=slPrincipalePortale.EOF_COdice_Ordine_OLO__c;
                            slPortaleToUpsert.add(slTempPortale);
                        }
                    } 
                    if(ServiziAggiuntiviDaOM){
                        for(EOF_EAI_Service_Log__c slTempDaOM : listserviziAggiuntiviDaOM){
                            EOF_EAI_Service_Log__c slTempPortale= new EOF_EAI_Service_Log__c();
                            slTempPortale=slTempDaOM;
                            slTempPortale.Id=null;
                            slTempPortale.OF_SA_VLan_Log__c=slPrincipalePortale.Id;
                            slTempPortale.EOF_Stato_Richiesta__c='Inserita Portale';
                            slTempPortale.EOF_COdice_Ordine_OLO__c=slPrincipalePortale.EOF_COdice_Ordine_OLO__c;
                            slPortaleToUpsert.add(slTempPortale);
                        }
                    } 
                    upsert slPortaleToUpsert;
                }
            }
            //caso in cui vi è solo la principale da OM
            else{
                slPrincipaleToOLO=slList[0];
                slPrincipalePortale =[Select Id,recordType.developerName,EOF_TIPOLOGIA_APPARATO__C,OF_SA_User_Vlan__c,OF_SA_Service_Vlan__c
                                      from EOF_EAI_service_Log__c where EOF_Stato_Richiesta__c='Inserita Portale'
                                      AND EOF_COdice_Ordine_OLO__c=:slPrincipaleToOLO.EOF_COdice_Ordine_OLO__c
                                      AND recordType.developerName='PO_SA_FiberRequest'];
                
                slPrincipalePortale.EOF_DATA_Notifica__c=slPrincipaleToOLO.EOF_DATA_Notifica__c;
                slPrincipalePortale.EOF_ID_Notifica__c=slPrincipaleToOLO.EOF_ID_Notifica__c;
                slPrincipalePortale.EOF_Stato_Ordine__c=OF_SA_GE_UtilsNew.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
                if(!String.isBlank(slPrincipaleToOLO.EOF_Codice_Motivazione__c)){
                    slPrincipalePortale.EOF_Motivazione__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c+' - '+slPrincipaleToOLO.EOF_Motivazione__c;
                }
                if(!String.isBlank(slPrincipaleToOLO.EOF_ID_RISORSA__c)){
                    slPrincipalePortale.EOF_ID_RISORSA__c=slPrincipaleToOLO.EOF_ID_RISORSA__c;
                }
                
                if(slPrincipaleToOLO.EOF_Data_Espletamento_Ordine__c!=null){
                    slPrincipalePortale.EOF_Data_Espletamento_Ordine__c=slPrincipaleToOLO.EOF_Data_Espletamento_Ordine__c;
                }
                if(!String.isBlank(slPrincipaleToOLO.EOF_SCALA_PALAZZINA__c)){
                    slPrincipalePortale.EOF_SCALA_PALAZZINA__c=slPrincipaleToOLO.EOF_SCALA_PALAZZINA__c;
                }
                if(!String.isBlank(slPrincipaleToOLO.OF_SA_DDT__c)){
                    slPrincipalePortale.OF_SA_DDT__c=slPrincipaleToOLO.OF_SA_DDT__c;
                }
                slPrincipalePortale.EOF_Note__C=slPrincipaleToOLO.EOF_Note__C;
                update slPrincipalePortale;
            }
        }
        
        //-------------------------------- OM Reschedule -------------------------------------------
        if(metodo=='OM_Reschedule'){
            
            slPrincipaleToOLO=slList[0];
            slPrincipalePortale =[Select Id,recordType.developerName,EOF_TIPOLOGIA_APPARATO__C,OF_SA_User_Vlan__c,OF_SA_Service_Vlan__c
                                  from EOF_EAI_service_Log__c where EOF_Stato_Richiesta__c='Inserita Portale'
                                  AND EOF_COdice_Ordine_OLO__c=:slPrincipaleToOLO.EOF_COdice_Ordine_OLO__c
                                  AND recordType.developerName='PO_SA_FiberRequest'];
            
            slPrincipalePortale.EOF_DATA_Notifica__c=slPrincipaleToOLO.EOF_DATA_Notifica__c;
            slPrincipalePortale.EOF_ID_Notifica__c=slPrincipaleToOLO.EOF_ID_Notifica__c;
            if(!String.isBlank(slPrincipaleToOLO.EOF_Codice_Motivazione__c)){
                slPrincipalePortale.EOF_Motivazione__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c+' - '+slPrincipaleToOLO.EOF_Motivazione__c;
            }
            if(!String.isBlank(slPrincipaleToOLO.EOF_Nome_Cliente__c)){
                slPrincipalePortale.EOF_Nome_Cliente__c=slPrincipaleToOLO.EOF_Nome_Cliente__c;
            }
            if(!String.isBlank(slPrincipaleToOLO.EOF_COgnome_CLiente__c)){
                slPrincipalePortale.EOF_COgnome_CLiente__c=slPrincipaleToOLO.EOF_COgnome_CLiente__c;
            }
            if(!String.isBlank(slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c)){
                slPrincipalePortale.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
            }
            if(!String.isBlank(slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c)){
                slPrincipalePortale.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=slPrincipaleToOLO.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
            }
            if(slPrincipaleToOLO.EOF_DATA_PREVISTA_ATTIVAZIONE__c!=null){
                slPrincipalePortale.EOF_DATA_PREVISTA_ATTIVAZIONE__c=slPrincipaleToOLO.EOF_DATA_PREVISTA_ATTIVAZIONE__c;
            }
            if(!String.isBlank(slPrincipaleToOLO.EOF_ORARIO_APPUNTAMENTO__c)){
                slPrincipalePortale.EOF_ORARIO_APPUNTAMENTO__c=slPrincipaleToOLO.EOF_ORARIO_APPUNTAMENTO__c;
            }
            slPrincipalePortale.EOF_Note__C=slPrincipaleToOLO.EOF_Note__C;
            update slPrincipalePortale;
            
        }
    } 
    public static String returnStatusFromInt (string stato_ordine, String metodo){
		if(metodo=='OM_StatusUpdate'){
			if(stato_ordine=='0'){
	            return 'Acquisito';
	        }
	        if(stato_ordine=='1'){
	            return 'Acquisito KO';
	        }
	        if(stato_ordine=='2'){
	            return 'Accettato';
	        }
	        if(stato_ordine=='3'){
	            return 'Accettato KO';
	        }
	        if(stato_ordine=='4'){
	            return 'Sospeso';
	        }
	        if(stato_ordine=='5'){
	            return 'Annullato';
	        }
	        if(stato_ordine=='6'){
	            return 'Cessato';
	        }
	        if(stato_ordine=='7'){
	            return 'Cessato KO';
	        }
        }
        if(metodo=='OM_CompletionOrder'){
			if(stato_ordine=='0'){
	            return 'Espletato';
	        }
	        if(stato_ordine=='1'){
	            return 'Espletato KO';
	        }
        }
        return null;
    }
    //Metodo per confirm appointment OLO->SH
    public static SH_Response_For_Confirmation makeCalloutOLOSHConfirmation(String tokenId, String codice_ordine_olo, String codice_operatore, String data_prevista_attivazione){
        //String codiceAzienda = 'OpenFiber'; 
        try{
            List<OF_Puntamento_Callout__c> listCustomSett =  OF_Puntamento_Callout__c.getAll().values();
            String puntamento = listCustomSett[0].Tibco_Collaudo__c;
            String endpoint = 'https://'+puntamento+'/AppointmentConfirmation?OrdId='+codice_ordine_olo+'&TokenId='+tokenId;
            //String endpoint = 'https://OFS-TEST-WS.ENEL.COM:44300/AppointmentConfirmation?OrdId='+codice_ordine_olo+'&TokenId='+tokenId;
            HttpRequest req = new HttpRequest();
                req.setEndpoint(endpoint);
                req.setMethod('GET');
                req.setTimeout(30000);

            Http http = new Http(); 
            HTTPResponse response = http.send(req); 
                                                                        
            SH_Response_For_Confirmation parsedResponse = (SH_Response_For_Confirmation)JSON.deserialize(response.getBody(), SH_Response_For_Confirmation.class);

            if(parsedResponse.Result == 'KO'){
                OF_SA_GE_UtilsNew.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                    sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                    sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_AppointmentConfirmation';
                    sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - AppointmentConfirmation';
                    sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                    sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                    sLogOFSHReqANDRes.OF_SA_Esito__c = parsedResponse.Result;
                    sLogOFSHReqANDRes.EOF_CODICE_MOTIVAZIONE__C = parsedResponse.Code;
                    sLogOFSHReqANDRes.EOF_MOTIVAZIONE__C = parsedResponse.Description;
                    sLogOFSHReqANDRes.EOF_Richiesta_Notifica__c = OLOSHConfirm_copy_request(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes);
            }else if(parsedResponse.Result == 'OK'){
                //Vado a controllare se la data appuntamento coincide con la data prevista attivazione
                OF_SA_GE_UtilsNew.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                    sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                    sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_AppointmentConfirmation';
                    sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - AppointmentConfirmation';
                    sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                    sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                    sLogOFSHReqANDRes.OF_SH_AppointmentDate__c = parsedResponse.Confirmation[0].AppointmentDate;
                    sLogOFSHReqANDRes.OF_SH_DeliveryCompany__c = parsedResponse.Confirmation[0].DeliveryCompany;
                    sLogOFSHReqANDRes.OF_SA_Esito__c = parsedResponse.Result;
                    sLogOFSHReqANDRes.OF_SH_ID_WO__c = parsedResponse.Confirmation[0].CodOdl; 
                    sLogOFSHReqANDRes.EOF_Richiesta_Notifica__c = OLOSHConfirm_copy_request(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes);
            }
            return parsedResponse; 
        }catch(Exception e){
            OF_Utility.logMessage(true,'E','OF_SA_GE_UtilsNew','makeCalloutOLOSHConfirmation','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
            
            OF_SA_GE_UtilsNew.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_AppointmentConfirmation';
                sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - AppointmentConfirmation';
                sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                sLogOFSHReqANDRes.OF_SA_Esito__c = 'KO';
            
            SH_Response_For_Confirmation parsedResponse = new SH_Response_For_Confirmation();
                parsedResponse.Result = 'KO';
                parsedResponse.Code = 'A04';
                parsedResponse.Description = 'Errore tecnico di interfaccia';

            return parsedResponse;
            /*TRY CATCH PER TEST!!! 
            OF_SA_GE_UtilsNew.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                    sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                    sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_AppointmentConfirmation';
                    sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - AppointmentConfirmation';
                    sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                    sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                    sLogOFSHReqANDRes.OF_SH_AppointmentDate__c = '2019-02-04T10:50:00+01:00';
                    sLogOFSHReqANDRes.OF_SH_DeliveryCompany__c = 'OF';
                    sLogOFSHReqANDRes.OF_SA_Esito__c = 'OK';
                    sLogOFSHReqANDRes.OF_SH_ID_WO__c = '123';

            SH_Response_For_Confirmation parsedResponse = new SH_Response_For_Confirmation();
                parsedResponse.Result = 'OK';
            return parsedResponse;
            FINE TRY CATCH PER TEST*/
        }
    }
    public static String OLOSHConfirm_copy_request(EOF_EAI_Service_Log__c sl){
        String s = '';
        s+= 'TIPO_COMUNICAZIONE: ' + sl.OF_SA_Metodo__c + '\n' +
            'CODICE_ORDINE_OLO: ' + sl.EOF_Codice_Ordine_OLO__c + '\n' +
            'IDENTIFICATIVO_PRENOTAZIONE: ' + sl.OF_SH_Token_id__c + '\n' +
            'ESITO_CHIAMATA: ' + sl.OF_SA_Esito__c + '\n';
        if(sl.OF_SA_Esito__c == 'OK'){
            s+= 'APPOINTMENT_DATE: ' + sl.OF_SH_AppointmentDate__c + '\n' +
                'DELIVERY_COMPANY: ' + sl.OF_SH_DeliveryCompany__c + '\n' +
                'ID_WO: ' + sl.OF_SH_ID_WO__c + '\n';
        }else{
            s+= 'CODICE_MOTIVAZIONE: ' + sl.EOF_CODICE_MOTIVAZIONE__C + '\n' +
                'MOTIVAZIONE: ' + sl.EOF_MOTIVAZIONE__C + '\n';
        }
        return s;
    }
    public class SH_Response_For_Confirmation {
        public String Result;
        public String NumRecord;
        public String Code;
        public String Description;
        public Confirmation[] Confirmation;
    }
    public class Confirmation {
        public String OrdId;
        public String TokenId;
        public String CodOdl;
        public String AppointmentDate;
        public String DeliveryCompany;
    }
    //AA - Callout cancel reserve SH
    public static CancelReserveResponse makeCalloutOLOSHCancelReserve(String tokenId, String codice_ordine_olo){
        try{
            //Done AA - Temporaneamente commentato poichè va in errore 
            List<OF_Puntamento_Callout__c> listCustomSett =  OF_Puntamento_Callout__c.getAll().values();
            String puntamento = listCustomSett[0].Tibco_Collaudo__c;
            String endpoint = 'https://'+puntamento+'/CancReserve?OrdId='+codice_ordine_olo+'&TokenId='+tokenId;
            
            HttpRequest req = new HttpRequest();
                req.setEndpoint(endpoint);
                req.setMethod('DELETE');
                req.setTimeout(30000);
                    
            Http http = new Http(); 
            HTTPResponse response = http.send(req);
            
            CancelReserveResponse parsedResponse = (CancelReserveResponse) JSON.deserialize(response.getBody(), CancelReserveResponse.class);
            
            if(parsedResponse != null){
                if(parsedResponse.Result == 'OK'){
                    OF_SA_GE_UtilsNew.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                        sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                        sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_CancelReserve';
                        sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - CancelReserve';
                        sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                        sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                        sLogOFSHReqANDRes.OF_SA_Esito__c = parsedResponse.Result;
                    OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c = 'ACK';
                }else if(parsedResponse.Result == 'KO'){
                    if('C02'.equalsIgnoreCase(parsedResponse.Code)){
                        OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c = 'NACK TECNICO';
                        //Done AA - Aggiungerò qui il flusso su cui fare la retry
                        OF_SA_GE_UtilsNew.caseOriginale.OF_Flusso_Retry__c = 'OLO_Activation';
                    }else{
                        OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c = 'NACK';
                    }
                    OF_SA_GE_UtilsNew.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                        sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                        sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_CancelReserve';
                        sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - CancelReserve';
                        sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                        sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                        sLogOFSHReqANDRes.OF_SA_Esito__c = parsedResponse.Result;
                        sLogOFSHReqANDRes.EOF_Codice_Errore__c = parsedResponse.Code;
                        sLogOFSHReqANDRes.EOF_CODICE_MOTIVAZIONE__c = parsedResponse.Description;
                }   
            } 
            /*CancelReserveResponse parsedResponse = new CancelReserveResponse(); 
                parsedResponse.Result = 'OK';

            OF_SA_GE_UtilsNew.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->OLO';
                sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_CancelReserve';
                sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->OLO - CancelReserve';
                sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                sLogOFSHReqANDRes.OF_SA_Esito__c = parsedResponse.Result;*/

            return parsedResponse;
        }catch(Exception e){
            OF_Utility.logMessage(true,'E','OF_SA_GE_UtilsNew','makeCalloutOLOSHCancelReserve','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
            
            OF_SA_GE_UtilsNew.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_CancelReserve';
                sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - CancelReserve';
                sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                sLogOFSHReqANDRes.OF_SA_Esito__c = 'KO';
            
            CancelReserveResponse parsedResponse = new CancelReserveResponse();
                parsedResponse.Result = 'KO';
                parsedResponse.Code = 'A04';
                parsedResponse.Description = 'Errore tecnico di interfaccia';

            OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c = 'NACK TECNICO';
            //Done AA - Aggiungerò qui il flusso su cui fare la retry
            OF_SA_GE_UtilsNew.caseOriginale.OF_Flusso_Retry__c = 'OLO_Activation';

            return parsedResponse;
            /*OF_SA_GE_UtilsNew.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_CancelReserve';
                sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - CancelReserve';
                sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                sLogOFSHReqANDRes.OF_SA_Esito__c = 'OK';
            
            CancelReserveResponse parsedResponse = new CancelReserveResponse();
                parsedResponse.Result = 'OK';
                
            OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c = 'ACK';
            return parsedResponse;*/
            /* COMMENTATO TRY CATCH!*/
        }
    }

    public class CancelReserveResponse{
        public String Result;
        public String Code;
        public String Description;
        public String NumRecord;
        public CancReserve[] CancReserve;
    }
    public class CancReserve{
        public String Status;
        public String OrdId;
        public String TokenId;
    }
    
	public static List<OF_SA_Network_Inventory_Attivi__c> controlloVendibilita(String theOlo, String theBuildingId){
        List<OF_SA_Network_Inventory_Attivi__c> result = new List<OF_SA_Network_Inventory_Attivi__c>();
        
        if(theOlo=='VF'){
        	theOlo = 'VOD';
        }else if(theOlo=='WN'){
        	theOlo = 'WIN';
        }
        theOlo=theOlo.toLowerCase();
        
        WS_OF_ControlloVendibilita.ControlloVendibilitaRequestType requestControlloVendibilita = new WS_OF_ControlloVendibilita.ControlloVendibilitaRequestType();
        requestControlloVendibilita.ID_REQUEST = 'request ' + DateTime.now();
        requestControlloVendibilita.OLO = theOlo;         
        requestControlloVendibilita.SERVIZIO = 'attivo';  

        //requestControlloVendibilita.SERVIZIO = 'PASSIVO';         
        requestControlloVendibilita.ID_BUILDING = theBuildingId;         
        WS_OF_ControlloVendibilita.ControlloVendibilitaPortTypeEndpoint stubControlloVendibilita = new WS_OF_ControlloVendibilita.ControlloVendibilitaPortTypeEndpoint(); 
        stubControlloVendibilita.timeout_x = 30000;         
        WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType responseControlloVendibilita;
        responseControlloVendibilita = stubControlloVendibilita.ControlloVendibilita(requestControlloVendibilita.ID_REQUEST, requestControlloVendibilita.OLO, requestControlloVendibilita.SERVIZIO, requestControlloVendibilita.ID_BUILDING);

        if(responseControlloVendibilita != null && responseControlloVendibilita.LISTA_SCALE != null){
            for(WS_OF_ControlloVendibilita.SCALAType scala : responseControlloVendibilita.LISTA_SCALE.SCALA){
                System.debug('**** AA STATO SCALA PALAZZINA => ' + scala.STATO_SCALA_PALAZZINA);
                OF_SA_Network_Inventory_Attivi__c networkAttivo = new OF_SA_Network_Inventory_Attivi__c();
                
                //networkAttivo.Id = scala.ID_SCALA;
                networkAttivo.OF_SA_Civico__c = scala.CIVICO;            
                networkAttivo.OF_SA_Comune__c = scala.COMUNE;
                //networkAttivo.OF_SA_GPON_ID__c
                networkAttivo.OF_SA_ID_Building_OM__c = scala.ID_BUILDING_OM;
                networkAttivo.OF_SA_Pop__c = scala.POP;
                networkAttivo.OF_SA_Indirizzo__c = scala.INDIRIZZO;
                networkAttivo.OF_SA_Particella_Top__c = scala.PARTICELLA_TOP;
                networkAttivo.OF_SA_Provincia__c = scala.PROVINCIA;
                networkAttivo.OF_SA_Scala_Palazzina__c = scala.SCALA_PALAZZINA;
                //networkAttivo.OF_SA_Stato_Building__c = scala.STATO_BUILDING;
                
                try{
                    networkAttivo.OF_SA_Stato_Building__c = Decimal.valueOf(scala.STATO_BUILDING);
                }catch(TypeException e){
                    networkAttivo.OF_SA_Stato_Building__c = null;
                }        
                try{
                    networkAttivo.OF_SA_Stato_Scala_Palazzina__c = Decimal.valueOf(scala.STATO_SCALA_PALAZZINA);
                }catch(Exception e){
                    networkAttivo.OF_SA_Stato_Scala_Palazzina__c = null;
                }                      
                result.add(networkAttivo);            
            }
        }
        return result;      
    }
}
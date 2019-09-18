public without sharing class OF_GPONP_GE_Utils {
    //LOG Req e Res OLO->SF
	public static EOF_EAI_Service_Log__c slOLOSF; 
    public static EOF_EAI_Service_Log__c slOLOSFResp;
    public static EOF_EAI_Service_Log__c slSFOLO;
    public static EOF_EAI_Service_Log__c slSFOLOResp;
    public static EOF_EAI_Service_Log__c slSFOM;
    public static EOF_EAI_Service_Log__c slSFOMResp;
    public static List<EOF_EAI_Service_Log__c> ListSlActivationSFOM;
    public static Case caseOriginale;
    public static boolean checkCaseOriginale = false;
    public static List<EOF_EAI_Service_Log__c> ListSlActivationOLOSF;
    public static List<EOF_EAI_Service_LOg__c> ListApp;
    public static boolean checkApp = false;
    public static List<EOF_EAI_Service_LOg__c> ListServAgg;
    public static boolean checkServAgg = false;
    public static Account cliente;
    public static boolean checkCliente = false;
    public static Contact RefTec;    
    public static boolean checkRefTec = false;
    public static List<OF_CommercialElementIstanziato__c> ceiList;
    public static boolean checkCEIList = false;
    public static List<Case> ListCaseAmmToUpdate;
    public static boolean checkCaseAmm = false;
	public static List<EOF_EAI_Service_LOg__c> ListAppToOM;
    public static boolean checkAppToOM = false;
    public static List<EOF_EAI_Service_LOg__c> ListServAggToOM;
    public static boolean checkServAggToOM = false;    
    public static OF_Generatore_ID_Servizio__c gen;
    // 14/02/2018 aggiunta TEMPLOG per cattura timestamp
    public static TEMPLOG__c tmpl;
    public static Double AttrTime;
    public static String OpName;
    public static Boolean checkRTMap = false;
    public static Map<String,Id> RTMap;
    public static String Response;
    public static boolean PORTAL = false;
    public static boolean retry = false;
    public static List<EOF_EAI_Service_Log__c> ListSlDeactivationOLOSF;
    public static asset a;
    public static List<EOF_EAI_Service_Log__c> ListSlDeactivationSFOM;
    public static EOF_EAI_Service_Log__c sLogOFSHReqANDRes;
    public static SH_Response_For_Confirmation responseFromSH;
    
    //AA - Metodo SyncError
    public static OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse syncError(Object o, String errorCode, String fieldName){
        
        OF_GPONP_GE_Utils.Response='NACK';
        List<String> result = new List<String>();
        //aggiungo SL di riferimento
        EOF_EAI_Service_Log__c slRiferimento;
        //Response che restituirò alla entrycheck
        OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse res_temp = new OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse();
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
            errorCode = OF_GPONP_GE_Utils.responseFromSH.Code;
            errorDesc = OF_GPONP_GE_Utils.responseFromSH.Description;
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
        //Attivazione GPONP
        if(o instanceof OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP){
            
            OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP x = (OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP) o;
            
            slRiferimento = OF_GPONP_GE_Utils.slOLOSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            tipo_comunicazione = 'OLO->SF - NACK - ActivationRequest';
            flusso = 'OLO-SF';
            Metodo = 'OLO_ActivationSetup';
            COdice_operatore = x.COdice_operatore;
            CODICE_ORDINE_OLO = x.CODICE_ORDINE_OLO;
            ID_NOTIFICA = x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA = Copy_request(x);
        } 
		//StatusUpdate GPONP
        if(o instanceof OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP){
            OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP x = (OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP) o;
            //in caso di statusUpdate sincrono creo il service Log
            slRiferimento = slOLOSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            flusso = 'OLO-SF';
            Metodo = 'OLO_StatusUpdate';
            tipo_comunicazione = 'OLO->SF - NACK - StatusUpdateRequest_GPONP';
            COdice_operatore = x.COdice_operatore;
            CODICE_ORDINE_OLO = x.CODICE_ORDINE_OLO;
            ID_NOTIFICA = x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA = Copy_request(x);            
        }
        //Reschedule GPONP
        if(o instanceof OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP){
            OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP x = (OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP) o;
            
            //in caso di reschedule sincrono creo il service Log
            slRiferimento = OF_GPONP_GE_Utils.create_EAI_Log(x);
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
        //Deactivation GPONP
        if(o instanceof OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest){
            OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest x = (OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest) o;
            
            slRiferimento = OF_GPONP_GE_Utils.slOLOSF;
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
        res_temp.Esito = '1';
        res_temp.CODICE_MOTIVAZIONE = errorCode;
        res_temp.MOTIVAZIONE = errorDesc;
        //faccio il check se il service log  di riferimento è stato correttamente popolato
        String slReferenceId;
        if(slRiferimento != null){
            slReferenceId = slRiferimento.Id;
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
    //AA - Metodo creazione service log!!
    public static EOF_EAI_Service_Log__c create_EAI_Log(Object o){        
        //Check se la map è già valorizzata
        if(!OF_GPONP_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_GE_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_GE_Utils.checkRTMap=true;
        }    
        //Activation new
        if(o instanceof OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP){            
            OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP a = (OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP) o;         
            
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_GPONP_GE_Utils.RTMap.get('OF_SA_FiberRequest'),
                OF_SA_Direzione_Flusso__c = 'OLO-SF',
                OF_SA_Metodo__c = 'OLO_ActivationSetup',
                EOF_Tipo_COmunicazione_String__c = 'OLO->SF - ActivationRequest',
                EOF_CODICE_OPERATORE__C = a.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__C = a.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__C = OF_GPONP_GE_Utils.StringToDate(a.DATA_NOTIFICA), 
                EOF_ID_NOTIFICA__C = a.ID_NOTIFICA,
                EOF_NOME_REFERENTE_TECNICO_OLO__C = a.NOME_REFERENTE_TECNICO_OLO,
                EOF_COGNOME_REFERENTE_TECNICO_OLO__C = a.COGNOME_REFERENTE_TECNICO_OLO,
                EOF_TELEFONO_REFERENTE_TECNICO_OLO__C = a.TELEFONO_REFERENTE_TECNICO_OLO,
                EOF_EMAIL_REFERENTE_TECNICO_OLO__C = a.EMAIL_REFERENTE_TECNICO_OLO,
                EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C = a.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH,
                EOF_NOME_CLIENTE__C = a.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__C = a.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__C = a.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = a.RECAPITO_TELEFONICO_CLIENTE_2,
                EOF_INFORMAZIONI_LOGISTICA_APPARATI__C = a.INFORMAZIONI_LOGISTICA_APPARATI,
                EOF_ORARIO_APPUNTAMENTO__C = a.ORARIO_APPUNTAMENTO, 
                EOF_CODICE_PROGETTO_SPECIALE__c = a.CODICE_PROGETTO_SPECIALE,
                EOF_PROMOZIONE__C = a.PROMOZIONE,
                EOF_CLUSTER_PROMOZIONE__C = a.CLUSTER_PROMOZIONE,
                EOF_ID_BUILDING__C = a.ID_BUILDING,
                EOF_SCALA_PALAZZINA__C = a.SCALA_PALAZZINA,
                EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C = a.NUMERO_TELEFONICO_PRINCIPALE_LINEA,
                EOF_RECAPITO_TEST_LINEA__C = a.RECAPITO_TEST_LINEA,
                EOF_ID_Pop__c = a.IDENTIFICATIVO_DEL_POP,
                EOF_GPON_Attestazione__c = a.GPON_RICHIESTA,
                //aa aggiunto campo 29/11/2018
                TRACCIATO_TRASCODIFICATO__c=a.TRACCIATO_TRASCODIFICATO,
                OF_Codice_Operatore_Secondario__c = a.CODICE_OPERATORE_SECONDARIO,
                EOF_Richiesta_Notifica__c = OF_GPONP_GE_Utils.copy_request(a)
            );
            List<Case> cList = [SELECT Id, OF_Bonifica_Locked_Row__c 
                                FROM Case 
                                WHERE EOF_Codice_Ordine_OLO__c = :a.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                OF_GPONP_GE_Utils.caseOriginale = cList[0];
                OF_GPONP_GE_Utils.checkCaseOriginale = true;
                sl.Caso__c = OF_GPONP_GE_Utils.caseOriginale.Id;
            }
            if(string.isnotblank(a.IDENTIFICATIVO_PRENOTAZIONE) && a.IDENTIFICATIVO_PRENOTAZIONE != null){
                sl.OF_SH_Token_id__c = a.IDENTIFICATIVO_PRENOTAZIONE.abbreviate(50);
            }else{
                sl.OF_SH_Token_id__c = a.IDENTIFICATIVO_PRENOTAZIONE;
            }
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE != null){
                sl.EOF_Note__c = a.NOTE.abbreviate(255);
            }else{
                sl.EOF_Note__c = a.NOTE;
            }
            
            try{
                sl.EOF_DATA_PREVISTA_ATTIVAZIONE__C = OF_GPONP_GE_Utils.StringToDateNoTime(a.DATA_PREVISTA_ATTIVAZIONE);
            }catch(exception e){
                system.debug('Errore - La data è in formato:'+ a.DATA_PREVISTA_ATTIVAZIONE);
            }
            // finisce qui
            
            insert sl;
            Integer n = 1;
            
            List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();            
            
            if(a.APPARATO != null && !a.APPARATO.isEmpty()){ 
                for(OF_GPONP_WS_IN_OLO_Activation.APPARATO app : a.APPARATO){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                        sLog.RecordTypeId = OF_GPONP_GE_Utils.RTMap.get('OF_SA_Cpe');
                        sLog.EOF_TIPOLOGIA_APPARATO__C = app.TIPOLOGIA_APPARATO;
                        sLog.OF_SA_PASSWORD_APPARATO__C = app.PASSWORD_APPARATO;
                        sLog.OF_SA_AZIONE_APPARATO__C = app.AZIONE_APPARATO;
                        sLog.EOF_CAUSALE_APPARATO__c = app.CAUSALE;
                        sLog.OF_SA_Cpe_Log__c = sl.Id;
                        sLog.EOF_Ordine_Invio_OLO__c = n;
                    sLogList.add(sLog);
                    n++;
                }
            }
            if(a.SERVIZIO_AGGIUNTIVO != null && !a.SERVIZIO_AGGIUNTIVO.isEmpty()){
                for(OF_GPONP_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO sa : a.SERVIZIO_AGGIUNTIVO){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                        sLog.recordtypeid = OF_GPONP_GE_Utils.RTMap.get('OF_SA_Servizi_Aggiuntivi');
                        sLog.OF_SA_NOME_SERVIZIO__c = sa.NOME_SERVIZIO; 
                        sLog.OF_SA_INFORMAZIONI_SERVIZIO__c = sa.INFORMAZIONI_SERVIZIO;
                        sLog.OF_SA_servizi_Aggiuntivi_Log__c = sl.Id;
                        sLog.EOF_Ordine_Invio_OLO__c = n;
                    sLogList.add(sLog);
                    n++;
                } 
            }  
            if(!sLogList.isEmpty()){
                insert sLogList;
            }  
            return sl;       
        }
        //Status update new
        if(o instanceof OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP){
            OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP sur = (OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_GPONP_GE_Utils.RTMap.get('OF_SA_FiberRequest'),
                EOF_Tipo_COmunicazione_String__c='OLO->SF - StatusUpdateRequest_GPONP',
                OF_SA_Direzione_Flusso__c='OLO-SF',
                OF_SA_Metodo__c='OLO_StatusUpdate',
                EOF_CODICE_OPERATORE__C=sur.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__C=sur.CODICE_ORDINE_OLO,
                EOF_ID_NOTIFICA__C=sur.ID_NOTIFICA,
                OF_SA_AZIONE__C=sur.AZIONE,
                EOF_CODICE_MOTIVAZIONE__C=sur.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__C=sur.MOTIVAZIONE,
                EOF_ORARIO_APPUNTAMENTO__C=sur.ORARIO_APPUNTAMENTO,
                EOF_NOME_CLIENTE__C=sur.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__C=sur.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__C=sur.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = sur.RECAPITO_TELEFONICO_CLIENTE_2,
                EOF_Richiesta_Notifica__c = copy_request(sur)
            );
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c 
                                FROM Case 
                                WHERE EOF_Codice_Ordine_OLO__c = :sur.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                sl.caso__c = cList[0].Id;
            }            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(sur.NOTE) && sur.NOTE!=null){
                sl.EOF_Note__c= sur.NOTE.abbreviate(255);
            }else{
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
            return sl;        
        }
        //Reschedule new
        if(o instanceof OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP){
            OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP r = (OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_GPONP_GE_Utils.RTMap.get('OF_SA_FiberRequest'),
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
                EOF_ORARIO_APPUNTAMENTO__C=r.ORARIO_APPUNTAMENTO,
                EOF_NOTE__C=r.NOTE,
                EOF_CODICE_MOTIVAZIONE__C=r.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__C=r.MOTIVAZIONE,
                EOF_Richiesta_Notifica__c = copy_request(r)
            );
            sl.OF_SH_Token_id__c = (r.IDENTIFICATIVO_PRENOTAZIONE != null && r.IDENTIFICATIVO_PRENOTAZIONE.length() > 50) ? r.IDENTIFICATIVO_PRENOTAZIONE.abbreviate(50) : r.IDENTIFICATIVO_PRENOTAZIONE;
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c 
                                FROM Case 
                                WHERE EOF_Codice_Ordine_OLO__c = :r.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                sl.caso__c = cList[0].Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(String.isNotBlank(r.NOTE) && r.NOTE!= null){
                sl.EOF_Note__c = r.NOTE.abbreviate(255);
            }else{
                sl.EOF_Note__c = r.NOTE;
            }
            // finisce qui
            try{
                sl.EOF_DATA_PREVISTA_ATTIVAZIONE__C = StringTODateNoTime(r.DATA_PREVISTA_ATTIVAZIONE);
            }catch(exception e){
                system.debug('Errore - La data è in formato:'+ r.DATA_PREVISTA_ATTIVAZIONE);
            }                                    
            return sl;   
        }
        //Deactivation new
        if(o instanceof OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest){
            OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest a = (OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest) o;         
            OF_GPONP_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_GPONP_GE_Utils.RTMap.get('OF_SA_FiberRequest'),
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
                OF_GPONP_GE_Utils.caseOriginale=cList[0];
                OF_GPONP_GE_Utils.checkCaseOriginale=true;
                OF_GPONP_GE_Utils.slOLOSF.caso__c=OF_GPONP_GE_Utils.caseOriginale.Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_GPONP_GE_Utils.slOLOSF.EOF_Note__c= a.NOTE.abbreviate(255);
            }else{
                OF_GPONP_GE_Utils.slOLOSF.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            insert OF_GPONP_GE_Utils.slOLOSF;
            
            if(a.apparato!=null && !a.apparato.isEmpty()){
                Integer n = 1; 
                OF_GPONP_GE_Utils.checkApp=true;
                OF_GPONP_GE_Utils.listApp=new list<EOF_EAI_Service_Log__C>();
                for(OF_GPONP_WS_IN_OLO_Deactivation.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.EOF_Tipo_COmunicazione_String__c='CPE';
                    sLog.recordtypeid=OF_GPONP_GE_Utils.RTMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLog.OF_SA_Cpe_Log__c=OF_GPONP_GE_Utils.slOLOSF.id;
                    OF_GPONP_GE_Utils.listApp.add(sLog);
                    n++;
                }
                insert OF_GPONP_GE_Utils.listApp;
            }
            return OF_GPONP_GE_Utils.slOLOSF;
        }
        if(o instanceof Map<String, String>){
            
            if(((Map<String, String>) o).get('Type') == 'ACK'){ 
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_GPONP_GE_Utils.RTMap.get('OF_SA_ACK'),
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
                
                if(OF_GPONP_GE_Utils.checkCaseOriginale){
                    sl.Caso__c = OF_GPONP_GE_Utils.caseOriginale.Id;
                }
                return sl;
            }
            
            if(((Map<String, String>) o).get('Type') == 'NACK'){
                OF_Utility.logMessage( true, 'L','OF_GPONP_GE_Utils','syncError','Map<String, String>) o).get(\'Type\'):'+((Map<String, String>) o).get('Type'));
                String s=''; 
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_GPONP_GE_Utils.RTMap.get('OF_SA_NACK'),
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
                if(OF_GPONP_GE_Utils.checkCaseOriginale){
                    sl.Caso__c=OF_GPONP_GE_Utils.caseOriginale.Id;
                }
                return sl;
            }
        }     
        return null;
    }
    //AA - Fine metodo creazione sLog 
    //AA - Creazione campo Richiesta/Notifica del sLog
    public static String copy_request(object o){
        String s;
        String data_prevista_attivazione='';
        //attivazione pre SF
        if(o instanceOf OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP){
            OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP a = (OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP) o;
            
            s = 'CODICE_OPERATORE: '+ a.CODICE_OPERATORE + '\n' +
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
                'GPON_RICHIESTA: '+ a.GPON_RICHIESTA + '\n';
            
            if(a.SERVIZIO_AGGIUNTIVO != null && !a.SERVIZIO_AGGIUNTIVO.isEmpty()){
                Integer n = 1;
                for(OF_GPONP_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO sa : a.SERVIZIO_AGGIUNTIVO){
                    s = s + '\n' + 'SERVIZIO AGGIUNTIVO ' + n + ': \n' +
                        'NOME_SERVIZIO: '+sa.NOME_SERVIZIO+'\n' +
                        'INFORMAZIONI_SERVIZIO: '+sa.INFORMAZIONI_SERVIZIO+'\n' ;
                    n++;
                } 
            }  
            if(a.APPARATO!=null && !a.APPARATO.isEmpty()){
                Integer n = 1;
                for(OF_GPONP_WS_IN_OLO_Activation.APPARATO app : a.APPARATO){
                    s = s + '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'PASSWORD_APPARATO: '+app.PASSWORD_APPARATO+'\n' +
                        'AZIONE_APPARATO: '+app.AZIONE_APPARATO+'\n' ;
                    n++;
                }
            } 
        }
        //StatusUpdate
        if(o instanceOf OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP){
            OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP su = (OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP) o;
            
            s = 'CODICE_OPERATORE: '+ su.CODICE_OPERATORE  + '\n' + 
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
        //Reschedule
        if(o instanceOf OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP){
            OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP r = (OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP) o;
            
            s = 'CODICE_OPERATORE: '+ r.CODICE_OPERATORE  + '\n' +
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
        //Deactivation
        if(o instanceOf OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest){
            OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deact = (OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest) o;
            
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
                for(OF_GPONP_WS_IN_OLO_Deactivation.apparato app : Deact.apparato){
                    s = s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n';
                    n++;
                }
            }
        }
        return s;
    }
    //AA - Creazione LOG per invio status update ad OM proveniente da OLO
    //METODO GIà DUPLICATO MEDIANTE ISTANCE OF PER SKY FASE 3 
    public static EOF_EAI_Service_Log__C OLO_CreateStatusUpdate_Log(Case c, object o){
        List<recordtype> rtList = [SELECT Id, DeveloperName 
                                   FROM RecordType 
                                   WHERE DeveloperName='OF_SA_Attivazione' OR DeveloperName = 'Cliente_Business'
                                   OR DeveloperName = 'PersonAccount' OR DeveloperName='Referente_Tecnico_OLO' OR DeveloperName='Servizi_Aggiuntivi' 
                                   OR DeveloperName='OF_CPE' OR DeveloperName='OF_VLAN' OR DeveloperName='OLO' 
                                   OR DeveloperName='OF_SA_FiberRequest' OR DeveloperName='OF_SA_Servizi_Aggiuntivi'
                                   OR DeveloperName='OF_SA_FiberNotify' OR DeveloperName='OF_SA_Cpe' OR DeveloperName='OF_SA_Vlan' 
                                   OR DeveloperName='OF_SA_ACK' OR DeveloperName='OF_SA_NACK'];
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }
        
        if(o instanceof OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP){
            //('OSCRM logMancante:--start--');
            OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP sur = (OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
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
                EOF_Tracciato__c = '3',
                EOF_Tipo_Comunicazione_Int__c = (sur.AZIONE == '0') ? '3' : '4',
                EOF_Richiesta_Notifica__c = copy_request(sur)
            );
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c, OF_SH_Token_id__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: sur.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                Case activationCase = cList[0];
                sl.caso__c = activationCase.Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note qualora sia più lungo di 255 caratteri
            if(string.isnotblank(sur.NOTE)){
            	sl.EOF_Note__c= sur.NOTE.abbreviate(255);
            }else{
            	sl.EOF_Note__c = sur.NOTE;
            }
            return sl;        
        }
        return null;
    }
    //AA - Creazione log di Attivazione/Cessazione per callout verso OLO
    public static EOF_EAI_Service_Log__C CreateAcquisition_LogNew(case c){
        if(!OF_GPONP_GE_Utils.checkrtMap){
            List<recordtype> rtList=[select Id,developerName from recordtype];
            OF_GPONP_GE_Utils.rtMap = new Map<String,Id>(); 
            for(recordtype rt :rtList){
                OF_GPONP_GE_Utils.rtMap.put(rt.DeveloperName, rt.Id); 
            }               
            OF_GPONP_GE_Utils.checkrtMap=true;
        }    
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
            RecordTypeId = OF_GPONP_GE_Utils.rtMap.get('OF_SA_FiberNotify'),
            EOF_Tipo_COmunicazione_String__c='SF->OLO - StatusUpdate',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate',
            EOF_CODICE_OPERATORE__c=c.EOF_Codice_Operatore_WS__c, 
            EOF_CODICE_ORDINE_OLO__c=c.EOF_CODICE_ORDINE_OLO__c,
            EOF_CODICE_ORDINE_EOF__c=c.Id,
            EOF_DATA_NOTIFICA__c=system.now(),
            EOF_ID_NOTIFICA__c=String.valueOf(system.now().getTime()),
            OF_OM_Nuovo_Flusso__c = c.OF_OM_Nuovo_Flusso__c/*,
            EOF_ID_SERVIZIO__c = c.OF_SA_ID_Servizio__c*/
        );
        //Done AA - Modificare recordtype del case
        if(c.recordtype.developername=='EOF_Caso_Attivazione'){
            sl.EOF_Tipo_Comunicazione__c = '5';
        }else{
            sl.EOF_Tipo_Comunicazione__c = '12';
        }   
        if(c.Status=='Acquisito'){
            sl.EOF_STATO_ORDINE__c='0';
        }else{
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
    //AA - Creazione string richiesta/notify per log chiamata a OLO
    public static String copy_notify_AcqCessNew(EOF_EAI_Service_Log__c sl){
        String s =  'CODICE_OPERATORE: ' + sl.EOF_Codice_Operatore__c + '\n' +            
                    'TIPO_COMUNICAZIONE: ' + sl.EOF_Tipo_Comunicazione__c + '\n' + 
                    'CODICE_ORDINE_OLO: ' + sl.EOF_Codice_Ordine_OLO__c + '\n' +
                    'CODICE_ORDINE_EOF: ' + sl.EOF_Codice_Ordine_EOF__c + '\n' +
                    'ID_NOTIFICA: ' + sl.EOF_ID_Notifica__c + '\n' +
                    'STATO_RICHIESTA: ' + sl.EOF_Stato_Richiesta__c + '\n' +
                    'CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO: ' + sl.EOF_Cod_Rifiuto_Sospensione_Annullamento__c + '\n' + 
                    'MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO: ' + sl.EOF_Mot_Rifiuto_Sospensione_Annullamento__c + '\n' +         
                    'DATA_NOTIFICA: ' + OF_GPONP_GE_Utils.DateToString(sl.EOF_Data_Notifica__c) + '\n' +
                    'NUOVO_FLUSSO_OM: ' + sl.OF_OM_Nuovo_Flusso__c +'\n';
        return s;
    }
    //AA - Callout di status update verso OLO e poi ci giriamo verso OM
    //AA - Creo il log per la callout verso OM
    public static List<EOF_EAI_Service_Log__c> create_ActivationToOM_Log(Case c2, List<EOF_EAI_Service_Log__c> ListSlOrig){
        List<EOF_EAI_Service_Log__c> listToOM = new List<EOF_EAI_Service_Log__c>();
        OF_GPONP_GE_Utils.ListAppToOM = new List<EOF_EAI_Service_Log__c>();
        OF_GPONP_GE_Utils.ListServAggToOM = new List<EOF_EAI_Service_Log__c>();
        for(EOF_EAI_Service_Log__c sl : ListSlOrig){
            if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                OF_GPONP_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c(
                    RecordTypeId = sl.recordtypeId,
                    EOF_Tipo_COmunicazione_String__c = 'SF->OM - ActivationRequest',
                    OF_SA_Direzione_Flusso__c = 'SF-OM',
                    OF_SA_Metodo__c = 'OLO_ActivationSetup',
                    EOF_Sorgente__c = 'OGW',
                    EOF_Tracciato__c = '3',
                    EOF_CODICE_OPERATORE__C = sl.EOF_CODICE_OPERATORE__c,
                    EOF_CODICE_ORDINE_OLO__C = sl.EOF_CODICE_ORDINE_OLO__c,
                    EOF_CODICE_ORDINE_EOF__C = c2.Codice_ordine_Eof__C,
                    EOF_DATA_NOTIFICA__C = sl.EOF_data_NOTIFICA__c, 
                    EOF_ID_NOTIFICA__C = sl.EOF_ID_NOTIFICA__c,
                    EOF_Id_servizio__c = c2.OF_SA_ID_Servizio__c,
                    EOF_NOME_REFERENTE_TECNICO_OLO__C = sl.EOF_NOME_REFERENTE_TECNICO_OLO__c,
                    EOF_COGNOME_REFERENTE_TECNICO_OLO__C = sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                    EOF_TELEFONO_REFERENTE_TECNICO_OLO__C = sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                    EOF_EMAIL_REFERENTE_TECNICO_OLO__C = sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__c,
                    EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C = sl.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                    EOF_NOME_CLIENTE__C = sl.EOF_NOME_CLIENTE__c,
                    EOF_COGNOME_CLIENTE__C = sl.EOF_COGNOME_CLIENTE__c,
                    EOF_RECAPITO_TELEFONICO_CLIENTE_1__C = sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                    EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__C = sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,
                    EOF_DATA_PREVISTA_ATTIVAZIONE__C = sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c,
                    EOF_ORARIO_APPUNTAMENTO__C = sl.EOF_ORARIO_APPUNTAMENTO__c,
                    EOF_CODICE_PROGETTO_SPECIALE__c = sl.EOF_CODICE_PROGETTO_SPECIALE__c,
                    EOF_PROMOZIONE__C = sl.EOF_PROMOZIONE__C,
                    EOF_CLUSTER_PROMOZIONE__C = sl.EOF_CLUSTER_PROMOZIONE__C,
                    EOF_NOTE__C = sl.EOF_NOTE__C,
                    EOF_SCALA_PALAZZINA__C = sl.EOF_SCALA_PALAZZINA__C,
                    EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C = sl.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                    EOF_RECAPITO_TEST_LINEA__C = sl.EOF_RECAPITO_TEST_LINEA__C,
                    EOF_ID_Pop__c = sl.EOF_ID_Pop__c,
                    EOF_PROFILO__C = sl.EOF_PROFILO__C,
                    EOF_CODICE_MOTIVAZIONE__c = c2.OF_SA_CODICE_MOTIVAZIONE__c,
                    EOF_MOTIVAZIONE__c = c2.OF_SA_MOTIVAZIONE__c,
                    EOF_Provincia__c = c2.EOF_Provincia_WS__c,
                    EOF_Comune__c = c2.EOF_Comune_WS__c,
                    EOF_Particella_Toponomastica__c = c2.EOF_Particella_Toponomastica_WS__c,
                    EOF_Indirizzo__c = c2.EOF_Indirizzo_WS__c,
                    EOF_Numero_Civico__c = c2.EOF_Numero_Civico_WS__c,
                    EOF_ID_Building__c = c2.EOF_ID_Building_WS__c, 
                    OF_SH_Token_id__c = c2.OF_SH_Token_id__c,							
                    Caso__c = c2.Id,
                    OF_SH_DeliveryCompany__c = c2.OF_SH_DeliveryCompany__c,
                    OF_SH_AppointmentDate__c = OF_GPONP_GE_Utils.DateToStringNoTime(c2.EOF_Data_Appuntamento__c),
                    EOF_TIPOLOGIA_SERVIZIO__c = '0',
                    OF_SH_ID_WO__c = c2.OF_SH_ID_WO__c,
                    //Viene popolato momentaneamente con l'orario appuntamento
                    OF_SH_Fascia_App__c = c2.EOF_Orario_Appuntamento__c,
                    //aa aggiunto campo 29/11/2018
                    TRACCIATO_TRASCODIFICATO__c=sl.TRACCIATO_TRASCODIFICATO__c,
                    EOF_GPON_Attestazione__c = sl.EOF_GPON_Attestazione__c,
                    OF_Codice_Operatore_Secondario__c = sl.OF_Codice_Operatore_Secondario__c
                );
                OF_GPONP_GE_Utils.slSFOM.EOF_Tipo_Comunicazione_Int__c ='1';
                OF_GPONP_GE_Utils.slSFOM.OF_SH_Appuntamento_OLO__c = (String.isnotBlank(OF_GPONP_GE_Utils.slSFOM.OF_SH_Token_id__c)) ? 'Y' : 'N';

                if(c2.Status == 'Acquisito'){
                    OF_GPONP_GE_Utils.slSFOM.EOF_Tipo_COmunicazione__c = '1';
                    OF_GPONP_GE_Utils.slSFOM.EOF_Stato_Ordine__c = '0';
                }else{
                    OF_GPONP_GE_Utils.slSFOM.EOF_Tipo_COmunicazione__c = '99';
                    OF_GPONP_GE_Utils.slSFOM.EOF_Stato_Ordine__c = '1';
                } 
  

                listToOM.add(OF_GPONP_GE_Utils.slSFOM);
            }
            Integer n = 1;
            if(sl.recordtype.developername == 'OF_SA_Cpe'){ 
                OF_GPONP_GE_Utils.checkAppToOM = true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid = sl.recordtypeId;
                sLog.EOF_TIPOLOGIA_APPARATO__C = sl.EOF_TIPOLOGIA_APPARATO__C;
                sLog.OF_SA_PASSWORD_APPARATO__C = sl.OF_SA_PASSWORD_APPARATO__C;
                sLog.OF_SA_AZIONE_APPARATO__C = sl.OF_SA_AZIONE_APPARATO__C;
                sLog.EOF_CAUSALE_APPARATO__c=sl.EOF_CAUSALE_APPARATO__c;
                //sLog.OF_SA_Cpe_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c = n;
                OF_GPONP_GE_Utils.ListappToOM.add(sLog);
                listToOM.add(sLog);
                n++;
            }
            if(sl.recordtype.developername == 'OF_SA_Servizi_Aggiuntivi'){ 
                OF_GPONP_GE_Utils.checkServAggToOM = true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid = sl.recordtypeId;
                sLog.OF_SA_NOME_SERVIZIO__c = sl.OF_SA_NOME_SERVIZIO__c; 
                sLog.OF_SA_INFORMAZIONI_SERVIZIO__c = sl.OF_SA_INFORMAZIONI_SERVIZIO__c;
                //sLog.OF_SA_servizi_Aggiuntivi_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c = n; 
                OF_GPONP_GE_Utils.ListServAggToOM.add(sLog); 
                listToOM.add(sLog);
                n++;
            } 
        }
        return listToOM;
    }
    public static void makeCalloutOLOOMNew(EOF_EAI_Service_Log__C slTOOLO){
        Boolean newFlusso = slTOOLO.OF_OM_Nuovo_Flusso__c;
        //prima di chiamare la callout faccio il check amministratori solo per attivazione
        if(slTOOLO.EOF_Tipo_comunicazione__c == '5'){
            OF_GPONP_GE_Utils.checkAmministratori(OF_GPONP_GE_Utils.caseOriginale);
        }
        //poi chiamo l'OLO        
        OF_GPONP_Schema_Res_StatusUpdateNew.Response_element resp = OF_OM_SendToOLONew.OM_CreateAckNackNotifyStatusUpdateNew_GPONP(OF_GPONP_GE_Utils.slSFOLO);
        
        if(resp.esito=='0'){            
            //chiamo OM
            if(slTOOLO.EOF_Tipo_comunicazione__c=='5'){
                //Done AA - ESEGUO IL NUOVO FLUSSO DI OM!!!
                OF_GPONP_GE_Utils.ListSlActivationSFOM = OF_GPONP_GE_Utils.create_ActivationToOM_Log(OF_GPONP_GE_Utils.caseOriginale,OF_GPONP_GE_Utils.ListSlActivationOLOSF);
                // AA Commentato ci invieranno un nuovo ws, per ora fingo un ACK
                OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestActivationNew_GPONP(OF_GPONP_GE_Utils.ListSlActivationSFOM);
                if(!Test.isRunningTest())
                	OF_GPONP_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Create',null,null);
            }
            //AA - Commentata, per ora gestiamo solo l'attivazione
            else{
                //Done AA - ESEGUO IL NUOVO FLUSSO DI OM!!!
                OF_GPONP_GE_Utils.ListSlDeactivationSFOM=OF_GPONP_GE_Utils.create_DeactivationToOM_Log(OF_GPONP_GE_Utils.caseOriginale,OF_GPONP_GE_Utils.ListSlDeactivationOLOSF,OF_GPONP_GE_Utils.a);
                // AA Commentato ci invieranno un nuovo ws, per ora fingo un ACK
                OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestDeactivationNew_GPONP(OF_GPONP_GE_Utils.ListSlDeactivationSFOM);        
                if(!Test.isRunningTest())
                	OF_GPONP_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Delete',OF_GPONP_GE_Utils.slSFOM.EOF_Tipo_Comunicazione__c,null);
            }
        }else{
            //aggiorno tutto
            OF_GPONP_GE_Utils.aggiornamentoDatiAcquisizione(OF_GPONP_GE_Utils.caseOriginale);
        }
        
    }
    //AA - Callout di deactivation
    public static List<EOF_EAI_Service_Log__c> create_DeactivationToOM_Log(Case c2, List<EOF_EAI_Service_Log__c> ListSlOrig,Asset a){
        List<EOF_EAI_Service_Log__c> listToOM = new List<EOF_EAI_Service_Log__c>();
        OF_GPONP_GE_Utils.ListAppToOM=new List<EOF_EAI_Service_Log__c>();
        system.debug('Alessandro: la list è: '+ListSlOrig);
        for(EOF_EAI_Service_Log__c sl : ListSlOrig){
            if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                
                OF_GPONP_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c(
                    RecordTypeId = sl.recordtypeId,
                    EOF_Tipo_COmunicazione_String__c='SF->OM - DeactivationRequest',
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
                    EOF_Tipo_COmunicazione_Int__c='2',
                    EOF_TIPOLOGIA_SERVIZIO__c= '0',
                    //aa aggiunto campo 29/11/2018
                    TRACCIATO_TRASCODIFICATO__c=sl.TRACCIATO_TRASCODIFICATO__c,
                    OF_Codice_Operatore_Secondario__c = sl.OF_Codice_Operatore_Secondario__c,
                    caso__c=c2.id,
                    EOF_Tipo_COmunicazione__c = '11'
                );
                
                if(c2.status=='Acquisito'){
                    OF_GPONP_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '0';
                    OF_GPONP_GE_Utils.slSFOM.EOF_GPON_Attestazione__c=a.OF_GPON_Attestazione__c;
                    OF_GPONP_GE_Utils.slSFOM.EOF_ID_SERVIZIO__c = a.OF_IDServizio__c;
                    //OF_GPONP_GE_Utils.slSFOM.EOF_PROFILO__c = a.PROFILO;
                    OF_GPONP_GE_Utils.slSFOM.EOF_Provincia__c = a.OF_Provincia__c;
                    OF_GPONP_GE_Utils.slSFOM.EOF_Comune__c= a.OF_Comune__c;
                    OF_GPONP_GE_Utils.slSFOM.EOF_Particella_Toponomastica__c = a.OF_Particella_Toponomastica__c;
                    OF_GPONP_GE_Utils.slSFOM.EOF_Indirizzo__c = a.OF_Indirizzo__c;
                    OF_GPONP_GE_Utils.slSFOM.EOF_Numero_Civico__c = a.OF_Civico__c;
                }
                else{
                    OF_GPONP_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '1';
                } 
                listToOM.add(OF_GPONP_GE_Utils.slSFOM);
            }
            Integer n = 1;
            if(sl.recordtype.developername=='OF_SA_Cpe'){ 
                OF_GPONP_GE_Utils.checkAppToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.EOF_TIPOLOGIA_APPARATO__C=sl.EOF_TIPOLOGIA_APPARATO__C;
                sLog.OF_SA_ID_APPARATO__C=sl.OF_SA_ID_APPARATO__C;
                //sLog.OF_SA_Cpe_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n;
                OF_GPONP_GE_Utils.ListappToOM.add(sLog);
                listToOM.add(sLog);
                n++;
            }       	
        }
        return listToOM;
    } 
    //cessazione OK NEW
    public static void makeCalloutOMNew(List<EOF_EAI_Service_Log__C> ListSlTOOM){
        //Done AA - ESEGUO IL NUOVO FLUSSO DI OM!!!
        OF_GPONP_GE_Utils.ListSlDeactivationSFOM=OF_GPONP_GE_Utils.create_DeactivationToOM_Log(OF_GPONP_GE_Utils.caseOriginale,OF_GPONP_GE_Utils.ListSlDeactivationOLOSF,OF_GPONP_GE_Utils.a);
        //AA Commentato ci invieranno un nuovo ws, per ora fingo un ACK
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestDeactivationNew_GPONP(OF_GPONP_GE_Utils.ListSlDeactivationSFOM);        
        OF_GPONP_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Delete',OF_GPONP_GE_Utils.slSFOM.EOF_Tipo_Comunicazione__c,null);
    }
    //AA - Metodo che viene richiamato dopo attivazione o cessazione
    public static void aggiornamentoDatiAttivazioneCessazioneToOM(String processo, String tipo_comunicazione, String esito){
        List<Case> caseToUpdate = new List<Case>();
        List<EOF_EAI_Service_Log__c> slListPrincipaliToInsert = new List<EOF_EAI_Service_Log__c>();
        List<EOF_EAI_Service_Log__c> slListResponseAndElementToInsert = new List<EOF_EAI_Service_Log__c>();
        //valido sia per cessazione che attivazione
        if(OF_GPONP_GE_Utils.checkCliente){
            //Inserisco il cliente
            insert OF_GPONP_GE_Utils.cliente;
            //Aggiungo il cliente al case
            OF_GPONP_GE_Utils.caseOriginale.AccountId = OF_GPONP_GE_Utils.cliente.Id;
        }
        
        if(OF_GPONP_GE_Utils.checkRefTec){
            //inserisco il referente tecnico e metto il riferimento sul case
            insert OF_GPONP_GE_Utils.refTec;
            OF_GPONP_GE_Utils.caseOriginale.EOF_Contact__c = OF_GPONP_GE_Utils.refTec.Id;
        }
        
        if(OF_GPONP_GE_Utils.checkCEIList){ 
            insert OF_GPONP_GE_Utils.CEIList;
        }
        //casi di attivazione OK/KO e cessazione KO
        if(processo == 'Create' || (processo == 'Delete' && 'Cessato KO'.equalsIgnoreCase(OF_GPONP_GE_Utils.caseOriginale.Status))){
            
            slListPrincipaliToInsert.add(OF_GPONP_GE_Utils.slSFOLO);
            slListPrincipaliToInsert.add(OF_GPONP_GE_Utils.slSFOM);
            Insert slListPrincipaliToInsert;
            
            OF_GPONP_GE_Utils.slSFOLOresp.EOF_SL_Riferimento__c = OF_GPONP_GE_Utils.slSFOLO.Id;
            OF_GPONP_GE_Utils.slSFOMResp.EOF_SL_Riferimento__c = OF_GPONP_GE_Utils.slSFOM.Id;
            slListResponseAndElementToInsert.add(OF_GPONP_GE_Utils.slSFOMResp);
            slListResponseAndElementToInsert.add(OF_GPONP_GE_Utils.slSFOLOresp);
            
            if(OF_GPONP_GE_Utils.checkApp){
                for(EOF_EAI_Service_Log__c sl : OF_GPONP_GE_Utils.listAppToOM){
                    sl.OF_SA_Cpe_Log__c = OF_GPONP_GE_Utils.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            if(OF_GPONP_GE_Utils.checkServAgg){
                for(EOF_EAI_Service_Log__c sl : OF_GPONP_GE_Utils.listServAggToOM){
                    sl.OF_SA_servizi_Aggiuntivi_Log__c = OF_GPONP_GE_Utils.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            Insert slListResponseAndElementToInsert;
        }
        
        if(processo=='Delete' && 'Acquisito'.equalsIgnoreCase(OF_GPONP_GE_Utils.caseOriginale.Status)){
            //inserisco il log principale
            insert OF_GPONP_GE_Utils.slSFOM;
            //inserisco il riferimento sul log di response e poi la response
            OF_GPONP_GE_Utils.slSFOMResp.EOF_SL_Riferimento__c = OF_GPONP_GE_Utils.slSFOM.Id;
            insert OF_GPONP_GE_Utils.slSFOMResp;
        }
        
        /*OF_manageOrderFromCase mofc = new OF_manageOrderFromCase();
        String s = mofc.ManageOrder(OF_GPONP_GE_Utils.caseOriginale);*/
        OF_ManageOrderFromCase_GPONP mofc = new OF_ManageOrderFromCase_GPONP();
        String s = mofc.ManageOrder(OF_GPONP_GE_Utils.caseOriginale);
        if(!String.isBlank(s)){
            OF_GPONP_GE_Utils.caseOriginale.OF_Order__c=s;
        } 
        //aggiungo gli eventuali case di amministratori da aggiornare
        if(OF_GPONP_GE_Utils.checkCaseAmm){
            caseToUpdate.addAll(OF_GPONP_GE_Utils.ListCaseAmmToUpdate);	
        }
        
        //cancello il record di generatore id servizio dal db
        if(OF_GPONP_GE_Utils.gen != null){
            try{
                delete OF_GPONP_GE_Utils.gen;
            }catch(exception e){
                insert OF_Utility.logMessageNew2(OF_GPONP_GE_Utils.caseOriginale.EOF_Codice_Ordine_OLO__c,'E','OF_GPONP_GE_Utils','aggiornamentoDatiAttivazioneCessazioneToOM',null, e);
            }
        }
        //in caso di cessazione KO è  sufficiente la seguente
        caseToUpdate.add(OF_GPONP_GE_Utils.caseOriginale);
        update caseToUpdate;
    } 
    //metodo che gestisce l'aggiornamento dei dati in caso di NACK da OLO su Acquisito OK/KO e Cessato KO
    public static void aggiornamentoDatiAcquisizione(Case c){
        List<Case> caseToUpdate = new List<Case>();
        //valido sia per cessazione che attivazione
        if( OF_GPONP_GE_Utils.checkCliente){
            //Inserisco il cliente
            insert  OF_GPONP_GE_Utils.cliente;
            //Aggiungo il cliente al case
            OF_GPONP_GE_Utils.caseOriginale.AccountId =  OF_GPONP_GE_Utils.cliente.Id;
        }
        
        if(OF_GPONP_GE_Utils.checkCEIList){
            insert OF_GPONP_GE_Utils.CEIList;
        }
        
        insert OF_GPONP_GE_Utils.slSFOLO;
        
        //metto la reference alla notifica, la reference al slPrincipale e inserisco la response
        if(OF_GPONP_GE_Utils.slSFOLOresp != null){
            OF_GPONP_GE_Utils.slSFOLOresp.EOF_SL_Riferimento__c = OF_GPONP_GE_Utils.slSFOLO.Id;
            insert slSFOLOresp;
        }
        
        if( OF_GPONP_GE_Utils.checkRefTec){
            //inserisco il referente tecnico e metto il riferimento sul case
            insert  OF_GPONP_GE_Utils.refTec;
            OF_GPONP_GE_Utils.caseOriginale.EOF_Contact__c =  OF_GPONP_GE_Utils.refTec.Id;
        }
        
        /*OF_manageOrderFromCase mofc = new OF_manageOrderFromCase();
        String s=mofc.ManageOrder( OF_GPONP_GE_Utils.caseOriginale);*/
        OF_ManageOrderFromCase_GPONP mofc = new OF_ManageOrderFromCase_GPONP();
        String s = mofc.ManageOrder(OF_GPONP_GE_Utils.caseOriginale);
        if(!String.isBlank(s)){
            OF_GPONP_GE_Utils.caseOriginale.OF_Order__c=s;
        }
        //aggiungo gli eventuali case di amministratori da aggiornare
        if(OF_GPONP_GE_Utils.checkCaseAmm){
            caseToUpdate.addAll(OF_GPONP_GE_Utils.ListCaseAmmToUpdate);	
        }
        
        if(OF_GPONP_GE_Utils.gen != null){
            try{
                delete OF_GPONP_GE_Utils.gen;
            }catch(exception e){
                insert OF_Utility.logMessageNew2(OF_GPONP_GE_Utils.caseOriginale.EOF_Codice_Ordine_OLO__c,'E','OF_GPONP_GE_Utils','aggiornamentoDatiAcquisizione',null, e);
            }
        }        
        //in caso di cessazione KO è  sufficiente la seguente
        caseToUpdate.add( OF_GPONP_GE_Utils.caseOriginale);
        update caseToUpdate;
    }
    public static EOF_EAI_Service_Log__C OLO_CreateReschedule_Log(Case c, object o){
        List<recordtype> rtList=[select Id,developerName from recordtype where developerName='OF_SA_Attivazione' or developerName='EOF_Caso_Attivazione' or developerName = 'Cliente_Business'
                                 or developerName = 'PersonAccount' or developerName='Referente_Tecnico_OLO' or developerName='Servizi_Aggiuntivi' 
                                 or developerName='OF_CPE' or developerName='OF_VLAN' or developerName='OLO' or developerName='OF_SA_FiberRequest'or developerName='OF_SA_Servizi_Aggiuntivi'
                                 or developerName='OF_SA_FiberNotify' or developerName='OF_SA_Cpe'or developerName='OF_SA_Vlan' or developerName='OF_SA_ACK' or developerName='OF_SA_NACK'];
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }
        //AA SKY FASE 3
        //DUPLICATO PER SKY FASE 3
        if(o instanceof OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP){
            OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP r = (OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = rtMap.get('OF_SA_FiberRequest'),
                EOF_Tipo_COmunicazione_String__c='SF->OM - RescheduleRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_Reschedule',
                EOF_CODICE_OPERATORE__c=r.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__c=r.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__c=OF_GPONP_GE_Utils.StringToDate(r.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c=r.ID_NOTIFICA,
                EOF_DATA_PREVISTA_ATTIVAZIONE__c=OF_GPONP_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE),
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
                //EOF_Profilo__c = c.OF_SA_Profilo__c,
                OF_SH_ID_WO__c = c.OF_SH_ID_WO__c,
                OF_SH_DeliveryCompany__c = c.OF_SH_DeliveryCompany__c,
                OF_SH_AppointmentDate__c = OF_GPONP_GE_Utils.DateToStringNoTime(c.EOF_Data_Appuntamento__c),
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
    public static SH_Response_For_Confirmation makeCalloutOLOSHConfirmation(String tokenId, String codice_ordine_olo){
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
            OF_GPONP_GE_Utils.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->OLO';
                sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_AppointmentConfirmation';
                sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->OLO - AppointmentConfirmation';
                sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                sLogOFSHReqANDRes.OF_SA_Esito__c = parsedResponse.Result;
                sLogOFSHReqANDRes.EOF_CODICE_MOTIVAZIONE__C = parsedResponse.Code;
                sLogOFSHReqANDRes.EOF_MOTIVAZIONE__C = parsedResponse.Description;
                sLogOFSHReqANDRes.EOF_Richiesta_Notifica__c = OLOSHConfirm_copy_request(OF_GPONP_GE_Utils.sLogOFSHReqANDRes);
        }else if(parsedResponse.Result == 'OK'){
            //Vado a controllare se la data appuntamento coincide con la data prevista attivazione
            OF_GPONP_GE_Utils.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->OLO';
                sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_AppointmentConfirmation';
                sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->OLO - AppointmentConfirmation';
                sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                sLogOFSHReqANDRes.OF_SH_AppointmentDate__c = parsedResponse.Confirmation[0].AppointmentDate;
                sLogOFSHReqANDRes.OF_SH_DeliveryCompany__c = parsedResponse.Confirmation[0].DeliveryCompany;
                sLogOFSHReqANDRes.OF_SA_Esito__c = parsedResponse.Result;
                sLogOFSHReqANDRes.OF_SH_ID_WO__c = parsedResponse.Confirmation[0].CodOdl;
                sLogOFSHReqANDRes.EOF_Richiesta_Notifica__c = OLOSHConfirm_copy_request(OF_GPONP_GE_Utils.sLogOFSHReqANDRes); 
        }                
        return parsedResponse;
        }catch(Exception e){
            /*AA AGGIUNTO MOCK PER TEST
            OF_GPONP_GE_Utils.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
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
            AA FINE MOCK PER TEST*/

            /*AA NICE FLOW*/
            OF_Utility.logMessage(true,'E','OF_GPONP_GE_Utils','makeCalloutOLOSHConfirmation','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
            
            OF_GPONP_GE_Utils.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
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
            /*AA END NICE FLOW*/
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
                    OF_GPONP_GE_Utils.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                        sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                        sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_CancelReserve';
                        sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - CancelReserve';
                        sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                        sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                        sLogOFSHReqANDRes.OF_SA_Esito__c = parsedResponse.Result;
                    OF_GPONP_GE_Utils.caseOriginale.OF_Response_da_SH__c = 'ACK';
                }else if(parsedResponse.Result == 'KO'){
                    if('C02'.equalsIgnoreCase(parsedResponse.Code)){
                        OF_GPONP_GE_Utils.caseOriginale.OF_Response_da_SH__c = 'NACK TECNICO';
                        //Done AA - Aggiungerò qui il flusso su cui fare la retry
                        OF_GPONP_GE_Utils.caseOriginale.OF_Flusso_Retry__c = 'OLO_Activation';
                    }else{
                        OF_GPONP_GE_Utils.caseOriginale.OF_Response_da_SH__c = 'NACK';
                    }
                    OF_GPONP_GE_Utils.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
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
            return parsedResponse;
        }catch(Exception e){
            /*FAKE FLOW KO 
            OF_GPONP_GE_Utils.caseOriginale.OF_Response_da_SH__c = 'NACK TECNICO';
            //Done AA - Aggiungerò qui il flusso su cui fare la retry
            OF_GPONP_GE_Utils.caseOriginale.OF_Flusso_Retry__c = 'OLO_Activation';

            OF_GPONP_GE_Utils.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_CancelReserve';
                sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - CancelReserve';
                sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                sLogOFSHReqANDRes.OF_SA_Esito__c = 'KO';
                sLogOFSHReqANDRes.EOF_Codice_Errore__c = 'C02';
                sLogOFSHReqANDRes.EOF_CODICE_MOTIVAZIONE__c = 'MOCKED NACK TECNICO';
            CancelReserveResponse parsedResponse = new CancelReserveResponse();
                parsedResponse.Result = 'KO';
            return parsedResponse;
            END FAKE FLOW KO*/            
            /*FAKE FLOW OK
            OF_GPONP_GE_Utils.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
                sLogOFSHReqANDRes.OF_SA_Direzione_Flusso__c = 'SF->SH';
                sLogOFSHReqANDRes.OF_SA_Metodo__c = 'OLO_CancelReserve';
                sLogOFSHReqANDRes.EOF_Tipo_COmunicazione_String__c = 'SF->SH - CancelReserve';
                sLogOFSHReqANDRes.EOF_Codice_Ordine_OLO__c = codice_ordine_olo;
                sLogOFSHReqANDRes.OF_SH_Token_id__c = tokenId;
                sLogOFSHReqANDRes.OF_SA_Esito__c = 'OK';
            
            CancelReserveResponse parsedResponse = new CancelReserveResponse();
                parsedResponse.Result = 'OK';
                
            OF_GPONP_GE_Utils.caseOriginale.OF_Response_da_SH__c = 'ACK';
            return parsedResponse;
            END FAKE FLOW OK*/

            /*AA NICE FLOW TRY CATCH*/
            OF_Utility.logMessage(true,'E','OF_GPONP_GE_Utils','makeCalloutOLOSHCancelReserve','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
            
            OF_GPONP_GE_Utils.sLogOFSHReqANDRes = new EOF_EAI_service_Log__c();
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

            OF_GPONP_GE_Utils.caseOriginale.OF_Response_da_SH__c = 'NACK TECNICO';
            //Done AA - Aggiungerò qui il flusso su cui fare la retry
            OF_GPONP_GE_Utils.caseOriginale.OF_Flusso_Retry__c = 'OLO_Activation';

            return parsedResponse;
            /*END NICE FLOW TRY CATCH*/
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
    //AA - Metodo per trasformare una data in String
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
    //AA - Metodo per controllare se una stringa è un datetime
    public static boolean checkDateTime(String S){
    	if(String.isBlank(s)){    		
    		return false;
    	}
    	if(!OF_GPONP_GE_Utils.checkDate(s.left(10))){    	
    		return false;    		
    	}
    	if(!OF_GPONP_GE_Utils.checkTime(s.left(19).right(8))){    		
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
    //AA - Metodo per controllare se una stringa è una date
    public static boolean checkDate(String S){
    	if(String.isBlank(s)){
            return false;
        }
        try{
            Date.valueOf(s);
            if(s.split('-').get(0).isNumeric() && Integer.valueOf(s.split('-').get(0))<2016){
                return false;
            }
        }catch(Exception e){
            return false;
        }
        return true;
    }
    //AA - Metodo per controllare il time data una stringa
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
    public static String dateToStringNoTime(date dt){
        String s='';
        if(!String.isBlank(String.valueOf(dt))){
            s=String.valueOf(dt).left(10);
        }
        return s;
    }
    //AA - Metodo che data una stringa, restituisce il datetime
    public static Datetime stringToDate(String s){
        if(String.isBlank(s)){
            return null;
        }
        Datetime dt = Datetime.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)),integer.valueOf(s.left(13).right(2)),integer.valueOf(s.left(16).right(2)),integer.valueOf(s.left(19).right(2)));
        return dt;
    }
    //AA - Metodo che data una stringa, restituisce il DATE (senza time)
    public static Date stringToDateNoTime(String s){
        if(String.isBlank(s)){
            return null;
        }
        Date dt = Date.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)));
        return dt;
    }
    //AA - Metodo checkemail
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
    //AA - Metodo get query per case e sLog
    //Nuovi metodi activation
    public static String getQueryNew(String oggetto,String Processo ){
        string s=null;
        if(oggetto=='case'){
            if(processo=='AsyncActivation'){
                s = 'Select Id, Codice_ordine_Eof__C, EOF_Codice_Ordine_Olo__c, EOF_GPON_Attestazione__c,OF_SH_Token_id__c, OF_SH_ID_WO__c, EOF_Data_Appuntamento__c, EOF_Orario_Appuntamento__c, OF_SH_DeliveryCompany__c, '
                +'EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c, OF_OM_Nuovo_Flusso__c,'
                +'EOF_Data_Notifica__c,EOF_Id_Notifica__c,PO_SA_Portale__c,recordtype.developername, AssetId, EOF_Scala_Palazzina_WS__c, '
                +'EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,status,EOF_FASE__C,CaseNumber,OF_Response_Da_OM__c,' 
                +'OF_SA_ID_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,OF_SA_MOTIVAZIONE__c,EOF_Provincia_WS__c,EOF_Comune_WS__c,'
                +'EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c,OF_SA_ID_Building_OM__c,TRACCIATO_TRASCODIFICATO__c, '
                +'OF_Response_Da_OLO__c,OF_Bonifica_Locked_Row__c, OF_Order__c, OF_SA_Profilo__c,EOF_Codice_Errore__c, EOF_Order_Manager__c,OF_IDContratto__c, '
                +'OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Flusso_Retry__c, OF_Response_da_SH__c,OF_Codice_Operatore_Secondario__c, Accordo_Operativo__c from Case';
            }
            if(processo=='AsyncDeactivation'){
                s='Select Id, Codice_ordine_Eof__C, EOF_Codice_Ordine_Olo__c,EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,EOF_GPON_Attestazione__c,'
                    +'EOF_Data_Notifica__c,EOF_Id_Notifica__c,PO_SA_Portale__c,recordtype.developername, OF_OM_Nuovo_Flusso__c,AssetId, EOF_Scala_Palazzina_WS__c, '
                    +'EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,status,EOF_FASE__C,EOF_Id_Risorsa__c,CaseNumber,OF_Bonifica_Locked_Row__c,'
                    +'OF_SA_CODICE_MOTIVAZIONE__c,OF_SA_MOTIVAZIONE__c,EOF_GPON_Vincolante__c,EOF_Opzione_System_Unico__c,EOF_Collegamento_P2P__c,TRACCIATO_TRASCODIFICATO__c, '
                    +'OF_Response_Da_OLO__c,OF_Response_Da_OM__c, OF_Order__c, OF_SA_Profilo__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, OF_Esito_Consegna_Apparato__c, '
                    +'EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c,EOF_Password_Apparato__c, OF_IDContratto__c,OF_SA_Promozione__c, OF_SA_ID_Servizio__c, '
                    +'OF_SA_CODICE_PROGETTO_SPECIALE__c,OF_SA_Cluster_Promozione__c,EOF_Codice_Errore__c,EOF_Order_Manager__c, OF_Flusso_Retry__c, OF_Response_da_SH__c,OF_Codice_Operatore_Secondario__c, Accordo_Operativo__c from Case'; 
            } 
        }
        if(oggetto=='sl'){
            if(processo=='AsyncActivation'){
                s='select OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,EOF_Tipo_COmunicazione_String__c,EOF_CODICE_OPERATORE__C, EOF_CAUSALE_APPARATO__c, EOF_GPON_Attestazione__c, OF_SH_Token_id__c, '
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
                s='select EOF_Tipo_COmunicazione_String__c,OF_SA_Direzione_Flusso__c, EOF_CAUSALE_APPARATO__c, EOF_GPON_Attestazione__c,'
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
                    +'OF_Indirizzo__c,OF_Scala_Palazzina__c,OF_Provincia__c,OF_Particella_Toponomastica__c,OF_GPON_Attestazione__c, OF_Contract__c'
                    +' from Asset';
            }
        }		
        
        return s; 
    }
    public static void checkAmministratori(Case c){
    	//faccio il check per amministratori
		//aggiungo  il controllo se id building è vuoto
		if(String.isBlank(c.EOF_Id_Building_WS__c)){
			return;
		}
        List<Case> caseAmm = [SELECT Id, CA_Numero_Ordini_in_Corso__c, OF_Bonifica_Locked_Row__c 
                              FROM Case 
                              WHERE RecordType.DeveloperName = 'CA_Amministratori' 
                              AND CA_ID_Building__c= :c.EOF_Id_Building_WS__c
                              AND Status != 'Realizzazione Impianto Completata'
                              AND Status != 'Negoziazione OF Richiesta Permesso Lavori KO' 
                              AND Status != 'Negoziazione OF Accesso Censimento Interno KO'];
    	try{
    		OF_GPONP_GE_Utils.checkCaseAmm = true;
    		OF_GPONP_GE_Utils.ListCaseAmmToUpdate = new List<Case>();
        	for(Case cAmm : caseAmm){
        		cAmm.CA_Codice_Ordine_in_Corso__c = OF_GPONP_GE_Utils.caseOriginale.EOF_Codice_Ordine_OLO__c;
    			cAmm.CA_Stato_Ordine_in_Corso__c = OF_GPONP_GE_Utils.caseOriginale.Status;
        		cAmm.CA_Numero_Ordini_in_Corso__c = cAmm.CA_Numero_Ordini_in_Corso__c + 1;
                
        		OF_GPONP_GE_Utils.ListCaseAmmToUpdate.add(cAmm);
        	}
        	return;
    	}catch(exception e){
    		system.debug('L exception è: '+e);
    	}
        return;
    }
    // 15/06/2018 MM : aggiunto metodo per creazione templog
    public static void CreateTemplogOLO(Object o){
        try{
            //Attivazione GPONP
            if(o instanceof OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP){

                OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP act = (OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP) o;
 
                // 8/06/2018 MM : Aggiunta creazione Templog per cattura timestamp attivazione
                OF_GPONP_GE_Utils.tmpl = new TEMPLOG__c();
                OF_GPONP_GE_Utils.tmpl.Name = act.CODICE_ORDINE_OLO +' - '+'Attivazione da OLO'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_GPONP_GE_Utils.tmpl.Tempi_Parziali__c = 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_GPONP_GE_Utils.tmpl.desc__c = 'TEMPLOG relativo alla Request del case:'+ act.codice_ordine_olo;
                OF_GPONP_GE_Utils.tmpl.Type__c = 'T';
                OF_GPONP_GE_Utils.tmpl.TL_codice_ordine_olo__c = act.CODICE_ORDINE_OLO;
                OF_GPONP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OLO_Attivazione';
                OF_GPONP_GE_Utils.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');
            }
            //StatusUpdate GPONP
            if(o instanceof OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP){
                OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP sur = (OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP) o;
                
                // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp annullamento/desospensione
                OF_GPONP_GE_Utils.tmpl = new TEMPLOG__c();
                OF_GPONP_GE_Utils.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_GPONP_GE_Utils.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ sur.codice_ordine_olo;
                OF_GPONP_GE_Utils.tmpl.Type__c ='T';
                OF_GPONP_GE_Utils.tmpl.TL_codice_ordine_olo__c = sur.CODICE_ORDINE_OLO;
                OF_GPONP_GE_Utils.tmpl.Tipo_Comunicazione__c = sur.AZIONE;
                if('0'.equals(sur.AZIONE)){
                    OF_GPONP_GE_Utils.OPName ='Desospensione da OLO';                 
                    OF_GPONP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OLO_Desospensione';
                }
                if('1'.equals(sur.AZIONE)){
                    OF_GPONP_GE_Utils.OPName ='Annullamento da OLO';                    
                    OF_GPONP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OLO_Annullamento';
                }
                OF_GPONP_GE_Utils.tmpl.Name= sur.CODICE_ORDINE_OLO +' - '+ OF_GPONP_GE_Utils.OPName +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');                
                OF_GPONP_GE_Utils.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                
            } 
            //Reschedule GPONP
            if(o instanceof OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP){
                OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP rr = (OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP) o;
                
                // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp rimodulazione
                OF_GPONP_GE_Utils.tmpl = new TEMPLOG__c();
                OF_GPONP_GE_Utils.tmpl.Name= rr.CODICE_ORDINE_OLO +' - '+'RDAC da OLO'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_GPONP_GE_Utils.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_GPONP_GE_Utils.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ rr.codice_ordine_olo;
                OF_GPONP_GE_Utils.tmpl.Type__c ='T';
                OF_GPONP_GE_Utils.tmpl.TL_codice_ordine_olo__c = rr.CODICE_ORDINE_OLO;
                OF_GPONP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OLO_Rimodulazione_DAC_GPONP';
                OF_GPONP_GE_Utils.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                
            }
            //Deactivation GPONP
            if(o instanceof OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest){                
                OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deact = (OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest) o;
                
                OF_GPONP_GE_Utils.tmpl = new TEMPLOG__c();
                OF_GPONP_GE_Utils.tmpl.Name= Deact.CODICE_ORDINE_OLO +' - '+'Cessazione da OLO'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_GPONP_GE_Utils.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_GPONP_GE_Utils.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ Deact.codice_ordine_olo;
                OF_GPONP_GE_Utils.tmpl.Type__c ='T';
                OF_GPONP_GE_Utils.tmpl.TL_codice_ordine_olo__c = Deact.CODICE_ORDINE_OLO;
                //OF_GPONP_GE_Utils.tmpl.Tipo_Comunicazione__c = '';
                OF_GPONP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OLO_Cessazione';
                OF_GPONP_GE_Utils.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                
            }
        }catch(Exception e){
            system.debug('@@@ - Exception:' +e);
        }
    }
    //Partial templog
   	public static void partialTemplog(String s){
    	try{
    		if(OF_GPONP_GE_Utils.tmpl!=null){
                OF_GPONP_GE_Utils.tmpl.Tempi_Parziali__c= OF_GPONP_GE_Utils.tmpl.Tempi_Parziali__c + ', '+s+' : '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    		}
    	}catch(exception e){ 
            system.debug('@@@ - Exception:' +e);
            system.debug('@@@ - line exc ' + e.getLineNumber());
            system.debug('@@@ - exc in method partialTempLog');
 		}
    }
    // 8/06/2018 MM : aggiunta metodo per inserimento TEMPLOG
    public static void EndTemplog(){
	    try{        
            // 8/06/2018 MM: Aggiorno il timestamp. END corrisponde all'uscita dal servizio.
            OF_GPONP_GE_Utils.tmpl.Tempi_Parziali__c = OF_GPONP_GE_Utils.tmpl.Tempi_Parziali__c + ', END: '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
            OF_GPONP_GE_Utils.tmpl.Attraversamento__c = datetime.now().getTime() - OF_GPONP_GE_Utils.AttrTime;        
            OF_GPONP_GE_Utils.tmpl.OF_CPU_Time__c = string.valueof(Limits.getCpuTime());
            OF_GPONP_GE_Utils.tmpl.OF_CPU_Time_Limit__c = string.valueof(Limits.getLimitCpuTime());
	    	// 8/06/2018 MM : Inserisco il templog
			insert OF_GPONP_GE_Utils.tmpl;
	    }catch(Exception e){
            system.debug('@@@ - Exception:' +e);
            system.debug('@@@ - line exc ' + e.getLineNumber());
            system.debug('@@@ - exc in method endtemplog');
	    }
	    // finisce qui        
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
        //requestControlloVendibilita.SERVIZIO = 'attivo';    
        requestControlloVendibilita.SERVIZIO = 'passivo';         
        requestControlloVendibilita.ID_BUILDING = theBuildingId; 
        
        WS_OF_ControlloVendibilita.ControlloVendibilitaPortTypeEndpoint stubControlloVendibilita = new WS_OF_ControlloVendibilita.ControlloVendibilitaPortTypeEndpoint();  
        WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType responseControlloVendibilita;
        stubControlloVendibilita.timeout_x = 30000;
        responseControlloVendibilita = stubControlloVendibilita.ControlloVendibilita(requestControlloVendibilita.ID_REQUEST, requestControlloVendibilita.OLO, requestControlloVendibilita.SERVIZIO, requestControlloVendibilita.ID_BUILDING);
        
        if(responseControlloVendibilita != null && responseControlloVendibilita.LISTA_SCALE != null){
            for(WS_OF_ControlloVendibilita.SCALAType scala : responseControlloVendibilita.LISTA_SCALE.SCALA){
                EOF_Network_Inventory__c networkInventory = new EOF_Network_Inventory__c();                
                    //networkAttivo.Id = scala.ID_SCALA;
                    networkInventory.EOF_Civico__c = scala.CIVICO;            
                    networkInventory.EOF_Comune__c = scala.COMUNE;
                    //networkAttivo.OF_SA_GPON_ID__c
                    networkInventory.EOF_ID_Building__c = scala.ID_BUILDING_OM;
                    networkInventory.EOF_Pop__c = scala.POP;
                    networkInventory.EOF_Indirizzo__c = scala.INDIRIZZO;
                    networkInventory.EOF_Particella_Top__c = scala.PARTICELLA_TOP; 
                    networkInventory.EOF_Provincia__c = scala.PROVINCIA;
                    networkInventory.EOF_Scala_Palazzina__c = scala.SCALA_PALAZZINA;
                    //networkAttivo.OF_SA_Stato_Building__c = scala.STATO_BUILDING;    
                try{
                    networkInventory.EOF_Stato_Scala_Palazzina__c = Decimal.valueOf(scala.STATO_SCALA_PALAZZINA);
                }catch(Exception e){
                    networkInventory.EOF_Stato_Scala_Palazzina__c = null;
                }                  
                try{
                    networkInventory.EOF_Stato_Building__c = Decimal.valueOf(scala.STATO_BUILDING);
                }catch(TypeException e){
                    networkInventory.EOF_Stato_Building__c = null;
                }                            
                result.add(networkInventory);            
            }
        }
        return result;      
    }
    //giovanni ernetti 16-10-2018 fine
}
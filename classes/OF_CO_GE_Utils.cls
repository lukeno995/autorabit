public without sharing class OF_CO_GE_Utils {
    
    public static EOF_EAI_Service_Log__c slOLOSF; 
    public static EOF_EAI_Service_Log__c slSFOLO;
    public static EOF_EAI_Service_Log__c sLLogOLO_SFChangeOrder; //add by PG 25-05
    public static EOF_EAI_Service_Log__c slSFOLOResp; 
    public static EOF_EAI_Service_Log__c slSFOM;
    public static EOF_EAI_Service_Log__c slSFOMResp;
    public static EOF_EAI_Service_Log__c slOMSF;
    public static EOF_EAI_Service_Log__c slOMSFResp;
    public static List<EOF_EAI_Service_Log__c> ListSlActivationOLOSF;
    public static List<EOF_EAI_Service_Log__c> ListSlDeactivationOLOSF;
    public static List<EOF_EAI_Service_Log__c> ListSlActivationSFOM;
    public static List<EOF_EAI_Service_Log__c> ListSlDeactivationSFOM;
    public static List<EOF_EAI_Service_Log__c> ListSlCompletionOrderOMSF;
    public static List<EOF_EAI_Service_Log__c> ListSlCompletionOrderSFOLO;
    public static List<EOF_EAI_Service_Log__c> ListSlStatusUpdateOMSF;
    public static List<EOF_EAI_Service_Log__c> ListSlStatusUpdateSFOLO;
    public static string Response;
    public static string RespCompletionOrder;
    public static Case caseOriginale;
    public static boolean checkCaseOriginale=false;
    // 30/01/2018 Marco : modifica per riconoscimento log desospensione
    public static boolean desospendi=false;
    // 30/01/2018 Marco : fine modifica
    public static boolean checkRTMap = false;
    public static map<String,Id> RTMap;
    public static boolean PORTAL=false;
    public static Account cliente;
    public static boolean checkCliente=false;
    public static Contact RefTec;    
    public static boolean checkRefTec=false;
    public static List<EOF_EAI_Service_LOg__c> ListVLan;
    public static boolean checkVLan=false;
    public static List<EOF_EAI_Service_LOg__c> ListApp;
    public static boolean checkApp=false;
    public static List<EOF_EAI_Service_LOg__c> ListServAgg;
    public static boolean checkServAgg=false;
    public static List<EOF_EAI_Service_LOg__c> ListVLanToOM;
    public static boolean checkVLanToOM=false;
    public static List<EOF_EAI_Service_LOg__c> ListAppToOM;
    public static boolean checkAppToOM=false;
    public static List<EOF_EAI_Service_LOg__c> ListServAggToOM;
    public static boolean checkServAggToOM=false;
    public static List<OF_CommercialElementIstanziato__c> ceiList;
    public static boolean checkCEIList=false;
    public static asset a;
    public static List<Case> ListCaseAmmToUpdate;
    public static boolean checkCaseAmm=false;
    public static boolean retry=false;
    public static boolean testNackTecnicoOLO=false;
    public static boolean testNackTecnicoOM=false;
    public static boolean restituisciACK=false;
    public static OF_Generatore_ID_Servizio__c gen;
    // 14/02/2018 aggiunta TEMPLOG per cattura timestamp
    public static TEMPLOG__c tmpl;
    public static string OpName;
    // finisce qui

    public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse syncError(Object o, String errorCode, String fieldName){
        
        OF_CO_GE_Utils.Response='NACK';
        List<String> result = new List<String>();
        //aggiungo SL di riferimento
        EOF_EAI_Service_Log__c slRiferimento;
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse res_temp = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
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

        if (errorCode == 'A04')
            errorDesc = 'Errore Tecnico di Interfaccia';

        if(errorCode == 'A05' || errorCode == 'A_K9')
            errorDesc = 'Campo \''+ fieldName +'\' obbligatorio non valorizzato';
        
        if(errorCode == 'A06' || errorCode == 'A_K10')
            errorDesc = 'Valore campo \''+ fieldName + '\' non ammesso';
        
        if(errorCode == 'A08')
            errorDesc = 'Codice Ordine OLO già presente';
        
        if(errorCode == 'A07')
            errorDesc = 'Status non congruente con '+fieldName;
        
        if(errorCode == 'B04'){
            errorDesc = 'Carattere non ammesso nel campo \''+fieldName+'\'';
        }
        if(errorCode == 'A09'){
            errorDesc = 'Data Attesa Consegna non conforme agli SLA';
        }
        if(errorCode == 'A10'){
            errorDesc = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
        }
        //Instance of CHANGE ORDER
        if(o instanceof OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request){
            
            OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request x = (OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request) o;
            
            slRiferimento = OF_CO_GE_Utils.slOLOSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            System.debug('SYNC ERROR!!! LOG REQUEST ' + slRiferimento);
            tipo_comunicazione='OLO->SF - NACK - ChangeOrderRequest';
            flusso='OLO-SF';
            Metodo='OLO_ChangeOrder';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
        } 

        //Add by PG - 24-05
        //Instance of OM_Notify_StatusUpdate
        //LOG NACK da SF
        if(o instanceof OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate){
            
            OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate x = (OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate) o;
            
            slRiferimento = OF_CO_GE_Utils.slOMSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            tipo_comunicazione='OM->SF - NACK - OF_StatusUpdate';
            flusso='OM-SF';
            Metodo='OF_StatusUpdate';
            COdice_operatore=x.Codice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
        }  

        if(o instanceof OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest){
            
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest x = (OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest) o;
            
            slRiferimento = OF_CO_GE_Utils.slOLOSF;
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
        if(o instanceof OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest){
            OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest x = (OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest) o;
            
            slRiferimento = OF_CO_GE_Utils.slOLOSF;
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
        if(o instanceof OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest){
            OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest x = (OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest) o;
            
            //in caso di reschedule sincrono creo il service Log
            slRiferimento = OF_CO_GE_Utils.create_EAI_Log(x);
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
        if(o instanceof OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest){
            OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest x = (OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest) o;
            //in caso di statusUpdate sincrono creo il service Log
            slRiferimento = OF_CO_GE_Utils.create_EAI_Log(x);
            slRiferimento.EOF_Response__c='NACK';
            insert slRiferimento;
            
            flusso='OLO-SF';
            Metodo='OLO_StatusUpdate';
            tipo_comunicazione='OLO->SF - NACK - StatusUpdateRequest';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
        } 
        
        if(o instanceof OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate){
            OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate x = (OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate) o;
            //in caso di statusUpdate sincrono creo il service Log
            OF_CO_GE_Utils.create_EAI_Log(x);
            
            flusso='OM-SF';
            Metodo='OF_StatusUpdate';
            tipo_comunicazione='OLO->SF - NACK - StatusUpdateNotify';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
        } 
        if(o instanceof OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule){
            OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule x = (OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule) o;
            //in caso di statusUpdate sincrono creo il service Log
            OF_CO_GE_Utils.create_EAI_Log(x);
            
            flusso='OM-SF';
            Metodo='OF_Reschedule';
            tipo_comunicazione='OLO->SF - NACK - RescheduleNotify';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
        } 
        if(o instanceof OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder){
            OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder x = (OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder) o;
            //in caso di statusUpdate sincrono creo il service Log
            OF_CO_GE_Utils.create_EAI_Log(x);
            
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
        //faccio il check se il service log  di riferimento è stato correttamente popolato
        String slReferenceId;
        if(slRiferimento!=null){
            slReferenceId=slRiferimento.Id;
        }
        System.debug('**** STILL SYNC ERROR slReferenceId ' + slReferenceId);
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
        System.debug('**** SYNC ERROR AFTE INSER ' + slNACK.Id);
        return res_temp;
    }
    public static EOF_EAI_Service_Log__c create_EAI_Log(Object o){
        
        //('OSCRM OK');
        if(!OF_CO_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_CO_GE_Utils.RTMap = new  map<String,String>();

            for(recordtype rt : [select id,developername from recordtype]){
                OF_CO_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_CO_GE_Utils.checkRTMap=true;
       }   
       //ChangeOrderRequest to OM                                                                                               
        if(o instanceof GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element){
            system.debug('****** sono all\'interno del create eai log per request verso OM ');
            GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element a = (GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element) o;    
			
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                //Done AA : Cambiare record type con uno creato ex novo
                RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_CO_ChangeOrderRequest'),
                EOF_Tipo_COmunicazione_String__c = 'SF->OM - ChangeOrderRequest',
                OF_SA_Direzione_Flusso__c = 'SF-OM',
                OF_SA_Metodo__c = 'OLO_ChangeOrder',
				EOF_Tipo_Comunicazione__c = a.TIPO_COMUNICAZIONE,
                EOF_CODICE_OPERATORE__c=a.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c=a.CODICE_ORDINE_OLO,
                Caso__c = a.CODICE_ORDINE_OF,
				//Done AA: Chiedere se è il codice ordine of
				EOF_Codice_Ordine_EOF__c = a.CODICE_ORDINE_OF,
                EOF_DATA_NOTIFICA__c=a.DATA_NOTIFICA,
                EOF_ID_NOTIFICA__c=a.ID_NOTIFICA,
                EOF_ID_RISORSA__c = a.ID_RISORSA,
				EOF_CODICE_PROGETTO_SPECIALE__c = a.CODICE_PROGETTO_SPECIALE,
				EOF_PROMOZIONE__c = a.PROMOZIONE,
                EOF_CLUSTER_PROMOZIONE__c = a.CLUSTER_PROMOZIONE,
                EOF_ID_SERVIZIO__c = a.ID_SERVIZIO,
                EOF_PROFILO__c = a.PROFILO,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                sl.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                sl.EOF_Note__c = a.NOTE;
            }
            system.debug('test1========='+OF_CO_GE_Utils.slSFOMResp);
             if (OF_CO_GE_Utils.slSFOMResp.OF_SA_ACK__c){
                sl.EOF_Response__c = 'ACK';
            }else{
                sl.EOF_Response__c = 'NACK';
            }
            // finisce qui
            
            insert sl;
			system.debug('**** HO INSERITO IL LOG REQUEST ID= ' + sl.Id);
            //Inserisco i service log per la lista di VLAN
            List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
            Integer n = 1;
            if(a.VLAN!=null && !a.VLAN.isEmpty()){ 
                for(GW_ChangeSetupOpenStream_Input.VLAN_element v : a.VLAN){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_CO_GE_Utils.RTMap.get('OF_SA_Vlan');
                    sLog.OF_SA_KIT_CONSEGNA_VLAN__c = v.KIT_CONSEGNA_VLAN;
                    sLog.OF_SA_USER_VLAN__C=v.USER_VLAN;
                    sLog.OF_SA_SERVICE_VLAN__C = v.SERVICE_VLAN;
                    sLog.OF_SA_PROFILO_VLAN__c = v.PROFILO_VLAN;
                    sLog.OF_SA_CUSTOMER_VLAN__c = v.CUSTOMER_VLAN;
                    sLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c = v.MODELLO_DI_SERVIZIO_VLAN;

                    //Add by PG - Check su lunghezza campo ed eventuale troncamento
                    if(string.isnotblank(v.INFORMAZIONI_VLAN) && v.INFORMAZIONI_VLAN!=null){
                        sLog.OF_SA_INFORMAZIONI_VLAN__c = v.INFORMAZIONI_VLAN.abbreviate(255);
                    }
                    else{
                        sLog.OF_SA_INFORMAZIONI_VLAN__c = v.INFORMAZIONI_VLAN;
                    } 
                    sLog.OF_SA_VLan_Log__c = sl.id;
                    sLog.EOF_Ordine_Invio_OLO__c = n;
                    sLogList.add(sLog);
                    n++;
                }
                insert sLogList;
            system.debug('**** dopo l\'inserimento della lista di vlan ');
            }
        }         
        //START - Add by PG - 24-05-2018
        //OF_SA_WS_IN_OM_StatusUpdate request
        if(o instanceof OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate)
        {
            OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate r = (OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate) o;         
            //Creo il service log relativo alla richiesta
            OF_CO_GE_Utils.slOMSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_CO_ChangeOrderNotify'),
                EOF_Tipo_Comunicazione_String__c= 'OM->SF - OF_StatusUpdate',
                OF_SA_Direzione_Flusso__c = 'OM-SF',
                OF_SA_Metodo__c= 'OF_StatusUpdate',
                EOF_CODICE_OPERATORE__c = r.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c = r.CODICE_ORDINE_OLO,
                EOF_CODICE_ORDINE_EOF__C = r.CODICE_ORDINE_OF,
                EOF_DATA_NOTIFICA__c= StringToDate(r.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c = r.ID_NOTIFICA,         
                EOF_STATO_ORDINE__c= r.STATO_ORDINE,
                EOF_CODICE_MOTIVAZIONE__c=r.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__c= r.MOTIVAZIONE,
                EOF_GPON_Attestazione__c = r.GPON_DI_ATTESTAZIONE,
                EOF_NOME_CLIENTE__c = r.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__c = r.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE__c = r.RECAPITO_TELEFONICO_CLIENTE,
                EOF_DATA_PREVISTA_ATTIVAZIONE__c = StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__c = r.ORARIO_APPUNTAMENTO,
                EOF_PIN_INTERVENTO_A_VUOTO__c = r.PIN_INTERVENTO_A_VUOTO,
                Caso__c = r.CODICE_ORDINE_OF,
                EOF_Richiesta_Notifica__c = copy_request(r)

            );            
            if(string.isnotblank(r.NOTE) && r.NOTE!=null){
                OF_CO_GE_Utils.slOMSF.EOF_Note__c= r.NOTE.abbreviate(255);
            }
            else{
                OF_CO_GE_Utils.slOMSF.EOF_Note__c = r.NOTE;
            }           
            //insert OF_CO_GE_Utils.slOMSF;
            //END - Add by PG - 24-05-2018
        }
        //ChangeOrder request
        if(o instanceof OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request){
            OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request a = (OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request) o;         
            //Inserisco il service log relativo alla richiesta
            OF_CO_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c(
                //Done AA : Cambiare record type con uno creato ex novo
                RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_CO_ChangeOrderRequest'),
                //Modificato CO Request
                EOF_Tipo_COmunicazione_String__c='OLO->SF - ChangeOrderRequest',
                OF_SA_Direzione_Flusso__c='OLO-SF',
                OF_SA_Metodo__c='OLO_ChangeOrder',
                EOF_CODICE_OPERATORE__c=a.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c=a.CODICE_ORDINE_OLO,
                
                EOF_ID_NOTIFICA__c=a.ID_NOTIFICA,
                EOF_ID_RISORSA__c = a.ID_RISORSA,
                EOF_CLUSTER_PROMOZIONE__c = a.CLUSTER_PROMOZIONE,
                EOF_CODICE_PROGETTO_SPECIALE__c = a.CODICE_PROGETTO_SPECIALE,
                EOF_PROFILO__c = a.PROFILO,
                EOF_PROMOZIONE__c = a.PROMOZIONE,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            try{
                OF_CO_GE_Utils.slOLOSF.EOF_DATA_NOTIFICA__c=StringToDate(a.DATA_NOTIFICA);
            }catch(Exception e){
                System.debug('*** Date has error');
                //OF_CO_GE_Utils.dateHasError = true;
            }
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: a.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                OF_CO_GE_Utils.caseOriginale=cList[0];
                OF_CO_GE_Utils.checkCaseOriginale=true;
                OF_CO_GE_Utils.slOLOSF.caso__c=OF_CO_GE_Utils.caseOriginale.Id;
            }
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_CO_GE_Utils.slOLOSF.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_CO_GE_Utils.slOLOSF.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            
            insert OF_CO_GE_Utils.slOLOSF;

            //Inserisco i service log per la lista di VLAN
            List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
            Integer n = 1;
            if(a.VLAN!=null && !a.VLAN.isEmpty()){ 
                for(OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN v : a.VLAN){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_CO_GE_Utils.RTMap.get('OF_SA_Vlan');
                    sLog.OF_SA_KIT_CONSEGNA_VLAN__c = v.KIT_CONSEGNA_VLAN;
                    sLog.OF_SA_USER_VLAN__C=v.USER_VLAN;
                    sLog.OF_SA_SERVICE_VLAN__C = v.SERVICE_VLAN;
                    sLog.OF_SA_PROFILO_VLAN__c = v.PROFILO_VLAN;
                    sLog.OF_SA_CUSTOMER_VLAN__c = v.CUSTOMER_VLAN;
                    sLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c = v.MODELLO_DI_SERVIZIO_VLAN;
                    //Add by PG - Check su lunghezza campo ed eventuale troncamento
                    if(v.INFORMAZIONI_VLAN != null && v.INFORMAZIONI_VLAN.length()>255){
                        sLog.OF_SA_INFORMAZIONI_VLAN__c = v.INFORMAZIONI_VLAN.abbreviate(255);
                    }
                    else{
                        sLog.OF_SA_INFORMAZIONI_VLAN__c = v.INFORMAZIONI_VLAN;
                    } 
                    
                    sLog.OF_SA_VLan_Log__c=OF_CO_GE_Utils.slOLOSF.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    n++;
                }
                insert sLogList;
            }
            return OF_CO_GE_Utils.slOLOSF;
        }

        //Activation                                                                                                  
        if(o instanceof OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest){
            
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest a = (OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_SA_FiberRequest'),
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
                EOF_DATA_PREVISTA_ATTIVAZIONE__C=StringTODateNoTime(a.DATA_PREVISTA_ATTIVAZIONE),
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
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: a.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                OF_CO_GE_Utils.caseOriginale=cList[0];
                OF_CO_GE_Utils.checkCaseOriginale=true;
                sl.caso__c=OF_CO_GE_Utils.caseOriginale.Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                sl.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                sl.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            //('OSCRM Clist:'+ cList);
            insert sl;
            Integer n = 1;


            List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
            if(a.VLAN!=null && !a.VLAN.isEmpty()){ 
                for(OF_SA_WS_IN_OLO_Activation.VLan v : a.VLan){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_CO_GE_Utils.RTMap.get('OF_SA_Vlan');
                    sLog.OF_SA_KIT_CONSEGNA_VLAN__C=v.KIT_CONSEGNA_VLAN;
                    sLog.OF_SA_USER_VLAN__C=v.USER_VLAN;
                    sLog.OF_SA_SERVICE_VLAN__C=v.SERVICE_VLAN;
                    sLog.OF_SA_PROFILO_VLAN__C=v.PROFILO_VLAN;
                    
                    //Add by PG - Check su lunghezza campo ed eventuale troncamento
                    if(string.isnotblank(v.INFORMAZIONI_VLAN) && v.INFORMAZIONI_VLAN!=null){
                        sLog.OF_SA_INFORMAZIONI_VLAN__c = v.INFORMAZIONI_VLAN.abbreviate(255);
                    }
                    else{
                        sLog.OF_SA_INFORMAZIONI_VLAN__c = v.INFORMAZIONI_VLAN;
                    } 
                    sLog.OF_SA_CUSTOMER_VLAN__C=v.CUSTOMER_VLAN;
                    sLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C=v.MODELLO_DI_SERVIZIO_VLAN;
                    sLog.OF_SA_VLan_Log__c=sl.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    n++;
                }
            }
            if(a.apparato!=null && !a.apparato.isEmpty()){ 
                for(OF_SA_WS_IN_OLO_Activation.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_CO_GE_Utils.RTMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.OF_SA_PASSWORD_APPARATO__C=app.PASSWORD_APPARATO;
                    sLog.OF_SA_AZIONE_APPARATO__C=app.AZIONE_APPARATO;
                    sLog.OF_SA_Cpe_Log__c=sl.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    n++;
                }
            }
            if(a.servizio_Aggiuntivo!=null && !a.servizio_Aggiuntivo.isEmpty()){
                for(OF_SA_WS_IN_OLO_Activation.servizio_aggiuntivo sa : a.servizio_Aggiuntivo){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_CO_GE_Utils.RTMap.get('OF_SA_Servizi_Aggiuntivi');
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
        
        //Completion Order                                                                                                     
        if(o instanceof OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder){
            
            OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder a = (OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder) o;         
             OF_CO_GE_Utils.slOMSF= new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_SA_FiberNotify'),
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
                OF_SA_DDT__c=a.DDT, 
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            OF_CO_GE_Utils.slOMSF.EOF_Response__c=OF_CO_GE_Utils.Response; 
            if(OF_CO_GE_Utils.checkCaseOriginale){
                OF_CO_GE_Utils.slOMSF.caso__c=OF_CO_GE_Utils.caseOriginale.Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_CO_GE_Utils.slOMSF.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_CO_GE_Utils.slOMSF.EOF_Note__c = a.NOTE;
            }
            // finisce qui
                        
            insert OF_CO_GE_Utils.slOMSF;
            Integer n = 1;

            List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
            if(a.apparato!=null && !a.apparato.isEmpty()){ 
                for(OF_SA_WS_IN_OM_CompletionOrder.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_CO_GE_Utils.RTMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.EOF_ESITO_CONSEGNA_APPARATO__c=app.ESITO_CONSEGNA_APPARATO;
                    sLog.OF_SA_ID_APPARATO_CONSEGNATO__c=app.ID_APPARATO_CONSEGNATO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_CONSEGNA__c=app.CODICE_MOTIVAZIONE_CONSEGNA;
                    sLog.OF_SA_MOTIVAZIONE_CONSEGNA__c=app.MOTIVAZIONE_CONSEGNA;
                    sLog.OF_SA_Cpe_Log__c=OF_CO_GE_Utils.slOMSF.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    n++;
                }
            }
            if(a.servizio_Aggiuntivo!=null && !a.servizio_Aggiuntivo.isEmpty()){

                for(OF_SA_WS_IN_OM_CompletionOrder.servizio_aggiuntivo sa : a.servizio_Aggiuntivo){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_CO_GE_Utils.RTMap.get('OF_SA_Servizi_Aggiuntivi');
                    sLog.OF_SA_NOME_SERVIZIO__c=sa.NOME_SERVIZIO; 
                    sLog.OF_SA_ESITO_SERVIZIO__c=sa.ESITO_SERVIZIO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_SERVIZIO__c=sa.CODICE_MOTIVAZIONE_SERVIZIO;
                    sLog.OF_SA_MOTIVAZIONE_SERVIZIO__c=sa.MOTIVAZIONE_SERVIZIO;
                    sLog.OF_SA_servizi_Aggiuntivi_Log__c=OF_CO_GE_Utils.slOMSF.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    n++;
                } 
            } 
            if(!sLogList.isEmpty()){
                insert sLogList;
            }        
        }
        
        //OM Status Update
        /*if(o instanceof OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate){
            OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate a = (OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate) o;         
            OF_CO_GE_Utils.slOMSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_SA_FiberNotify'),
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
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            OF_CO_GE_Utils.slOMSF.EOF_Response__c=OF_CO_GE_Utils.Response;
            if(OF_CO_GE_Utils.checkCaseOriginale){
                OF_CO_GE_Utils.slOMSF.caso__c=OF_CO_GE_Utils.CaseOriginale.Id;                
            
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_CO_GE_Utils.slOMSF.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_CO_GE_Utils.slOMSF.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            
                                                         
            insert OF_CO_GE_Utils.slOMSF;
            
            List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
            Integer n = 1;
            if(a.VLAN!=null && !a.VLAN.isEmpty()){ 
                for(OF_SA_WS_IN_OM_StatusUpdate.VLan v : a.VLan){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_CO_GE_Utils.RTMap.get('OF_SA_Vlan');
                    sLog.OF_SA_USER_VLAN__C=v.USER_VLAN;
                    sLog.OF_SA_SERVICE_VLAN__C=v.SERVICE_VLAN;
                    sLog.OF_SA_CUSTOMER_VLAN__C=v.CUSTOMER_VLAN;
                    sLog.OF_SA_VLan_Log__c=OF_CO_GE_Utils.slOMSF.id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    n++;
                }
            }
            if(a.apparato!=null && !a.apparato.isEmpty()){
                for(OF_SA_WS_IN_OM_StatusUpdate.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=OF_CO_GE_Utils.RTMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.OF_SA_ESITO_RITIRO_APPARATO__C=app.ESITO_RITIRO_APPARATO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_RITIRO__C=app.CODICE_MOTIVAZIONE_RITIRO;
                    sLog.OF_SA_MOTIVAZIONE_RITIRO__C=app.MOTIVAZIONE_RITIRO;
                    sLog.OF_SA_Cpe_Log__c=OF_CO_GE_Utils.slOMSF.id; 
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    n++;
                }
            }
            if(!sLogList.isEmpty()){
                insert sLogList;
            } 
            
        }*/
        
        //OM Reschedule
        if(o instanceof OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule){
            OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule a = (OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule) o;         
            OF_CO_GE_Utils.slOMSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_SA_FiberNotify'),
                EOF_Tipo_COmunicazione_String__c='OM->SF - Reschedule',
                OF_SA_Direzione_Flusso__c='OM-SF',
                OF_SA_Metodo__c='OF_Reschedule',
                EOF_CODICE_OPERATORE__c=a.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c=a.CODICE_ORDINE_OLO,
                EOF_CODICE_ORDINE_EOF__c=a.CODICE_ORDINE_OF,
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
            OF_CO_GE_Utils.slOMSF.EOF_Response__c=OF_CO_GE_Utils.Response;
            if(OF_CO_GE_Utils.checkCaseOriginale){
                OF_CO_GE_Utils.slOMSF.caso__c=OF_CO_GE_Utils.caseOriginale.Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_CO_GE_Utils.slOMSF.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_CO_GE_Utils.slOMSF.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            
            
            insert OF_CO_GE_Utils.slOMSF;
            
        }
        
        //Deactivation
        if(o instanceof OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest){
            OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest a = (OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest) o;         
            OF_CO_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_SA_FiberRequest'),
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
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: a.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                OF_CO_GE_Utils.caseOriginale=cList[0];
                OF_CO_GE_Utils.checkCaseOriginale=true;
                OF_CO_GE_Utils.slOLOSF.caso__c=OF_CO_GE_Utils.caseOriginale.Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_CO_GE_Utils.slOLOSF.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_CO_GE_Utils.slOLOSF.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            
            
            
            insert OF_CO_GE_Utils.slOLOSF;

            if(a.apparato!=null && !a.apparato.isEmpty()){
                Integer n = 1;
                OF_CO_GE_Utils.checkApp=true;
                OF_CO_GE_Utils.listApp=new list<EOF_EAI_Service_Log__C>();
                for(OF_SA_WS_IN_OLO_Deactivation.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.EOF_Tipo_COmunicazione_String__c='CPE';
                    sLog.recordtypeid=OF_CO_GE_Utils.RTMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.OF_SA_ID_APPARATO__C=app.ID_APPARATO;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLog.OF_SA_Cpe_Log__c=OF_CO_GE_Utils.slOLOSF.id;
                    OF_CO_GE_Utils.listApp.add(sLog);
                    n++;
                }
                insert OF_CO_GE_Utils.listApp;
            }
            
            return OF_CO_GE_Utils.slOLOSF;
            
        }
        
        
        if(o instanceof OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest){
            OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur = (OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_SA_FiberRequest'),
                EOF_Tipo_COmunicazione_String__c='OLO->SF - StatusUpdateRequest',
                OF_SA_Direzione_Flusso__c='OLO-SF',
                OF_SA_Metodo__c='OLO_StatusUpdate',
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
            // finisce qui
                                  
            //CRM Fix Tibco result=null 26_06_2017
            
            //insert sl;
            //('OSCRM test_sl:'+sl);
            return sl;        
        }        
        
        if(o instanceof OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest){
            OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest r = (OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_SA_FiberRequest'),
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
                EOF_DATA_PREVISTA_ATTIVAZIONE__C=StringTODateNoTime(r.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__C=r.ORARIO_APPUNTAMENTO,
                EOF_NOTE__C=r.NOTE,
                EOF_CODICE_MOTIVAZIONE__C=r.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__C=r.MOTIVAZIONE,
                EOF_Richiesta_Notifica__c = copy_request(r)
            );
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: r.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                sl.caso__c=cList[0].Id;
            }

            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(r.NOTE) && r.NOTE!= null){
                sl.EOF_Note__c= r.NOTE.abbreviate(255);
            }
            else{
                sl.EOF_Note__c = r.NOTE;
            }
            // finisce qui
                                    
            return sl;        

        }
        
        
        if(o instanceof Map<String, String>){

            if(((Map<String, String>) o).get('Type') == 'ACK'){ 
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_CO_ACK'),
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
                
                 if(OF_CO_GE_Utils.checkCaseOriginale){
                    sl.Caso__c=OF_CO_GE_Utils.caseOriginale.Id;
                 }
                return sl;
            }
            
            if(((Map<String, String>) o).get('Type') == 'NACK'){
                OF_Utility.logMessage( true, 'L','OF_CO_GE_Utils','syncError','Map<String, String>) o).get(\'Type\'):'+((Map<String, String>) o).get('Type'));
                String s=''; 
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_CO_NACK'),
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
                if(OF_CO_GE_Utils.checkCaseOriginale){
                    sl.Caso__c=OF_CO_GE_Utils.caseOriginale.Id;
                 }
                return sl;
            }
        }         
        
        return null;
    } 
    
    
    //Completion Order solo ritorno senza inserirli a sistema (per callout sincrone)
    public static List<EOF_EAI_Service_Log__C> OM_CreateCompletionOrder_Log(case c,object o){          
        
        //CRM 05/06/2017 modificata la query. Ora viene usato il DeveloperName al posto del Name
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        List<recordtype> rtList=[select Id,developerName from recordtype];
        OF_CO_GE_Utils.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_CO_GE_Utils.rtMap.put(rt.developerName, rt.Id); 
        }
        OF_CO_GE_Utils.checkrtMap=true;
        //END CRM 05/06/2017
        if(o instanceof OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder){
            
            OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder a = (OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder) o;         
            OF_CO_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c(
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
                OF_SA_DDT__c=a.DDT,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            if(OF_CO_GE_Utils.checkCaseOriginale){
                OF_CO_GE_Utils.slSFOLO.caso__c=OF_CO_GE_Utils.CaseOriginale.Id;
            }

            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_CO_GE_Utils.slSFOLO.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_CO_GE_Utils.slSFOLO.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            
            sLogList.add(OF_CO_GE_Utils.slSFOLO);
            Integer n = 1;
            if(a.apparato!=null && !a.apparato.isEmpty()){
                OF_CO_GE_Utils.checkApp=true;
                OF_CO_GE_Utils.ListApp= new List<EOF_EAI_Service_Log__C>();
                for(OF_SA_WS_IN_OM_CompletionOrder.apparato app : a.apparato){
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
                    OF_CO_GE_Utils.ListApp.add(sLog);
                    n++;
                }
            }
            if(a.servizio_Aggiuntivo!=null && !a.servizio_Aggiuntivo.isEmpty()){
                OF_CO_GE_Utils.checkServAgg=true;
                OF_CO_GE_Utils.ListServAgg= new List<EOF_EAI_Service_Log__C>();
                for(OF_SA_WS_IN_OM_CompletionOrder.servizio_aggiuntivo sa : a.servizio_Aggiuntivo){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid=rtMap.get('OF_SA_Servizi_Aggiuntivi');
                    sLog.EOF_Tipo_COmunicazione_String__c='SERVIZIO AGGIUNTIVO';
                    sLog.OF_SA_NOME_SERVIZIO__c=sa.NOME_SERVIZIO; 
                    sLog.OF_SA_ESITO_SERVIZIO__c=sa.ESITO_SERVIZIO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_SERVIZIO__c=sa.CODICE_MOTIVAZIONE_SERVIZIO;
                    sLog.OF_SA_MOTIVAZIONE_SERVIZIO__c=sa.MOTIVAZIONE_SERVIZIO;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    OF_CO_GE_Utils.ListServAgg.add(sLog);
                    n++;
                } 
            } 
            return sLogList;       
        }
        return null;
    }
    
    //notifica di acquisizione ChangeOrder
    //PG 25-05
    public static EOF_EAI_Service_Log__C CreateAcquisition_Log(case c){

        if(!OF_CO_GE_Utils.checkrtMap){
            List<recordtype> rtList=[select Id,developerName from recordtype];
            OF_CO_GE_Utils.rtMap = new Map<String,Id>(); 
            for(recordtype rt :rtList){
                OF_CO_GE_Utils.rtMap.put(rt.DeveloperName, rt.Id); 
            }               
            OF_CO_GE_Utils.checkrtMap=true;
        }    
        OF_CO_GE_Utils.sLLogOLO_SFChangeOrder = new EOF_EAI_Service_Log__c(
            RecordTypeId = OF_CO_GE_Utils.RTMap.get('OF_CO_ChangeOrderNotify'),
            EOF_Tipo_Comunicazione_String__c='SF -> OLO - StatusUpdate',
            OF_SA_Direzione_Flusso__c='SF - OLO',
            OF_SA_Metodo__c='OF_StatusUpdate',
            EOF_CODICE_OPERATORE__c=c.EOF_Codice_Operatore_WS__c, 
            EOF_CODICE_ORDINE_OLO__c=c.EOF_CODICE_ORDINE_OLO__c,
            EOF_CODICE_ORDINE_EOF__c=c.Id,
            EOF_DATA_NOTIFICA__c=system.now(),
            EOF_ID_NOTIFICA__c=String.valueOf(system.now().getTime())
        );          
        OF_CO_GE_Utils.sLLogOLO_SFChangeOrder.EOF_CODICE_MOTIVAZIONE__c = c.OF_SA_Codice_Motivazione__c;
        OF_CO_GE_Utils.sLLogOLO_SFChangeOrder.EOF_MOTIVAZIONE__c = c.OF_SA_MOTIVAZIONE__c;
        OF_CO_GE_Utils.sLLogOLO_SFChangeOrder.EOF_STATO_ORDINE__c = '9';
        OF_CO_GE_Utils.sLLogOLO_SFChangeOrder.caso__c=c.Id;
        OF_CO_GE_Utils.sLLogOLO_SFChangeOrder.EOF_Richiesta_Notifica__c = copy_notify_Acquisition(OF_CO_GE_Utils.sLLogOLO_SFChangeOrder);
        
        //mappo il log creato con quello usato nel metodo NotifyAggiornaStato(OF_CO_GE_Utils.slSFOLO)
        //della classe OF_CO_OM_SendToOLO 
        OF_CO_GE_Utils.slSFOLO = OF_CO_GE_Utils.sLLogOLO_SFChangeOrder;

        //insert OF_CO_GE_Utils.sLLogOLO_SFChangeOrder;
        return OF_CO_GE_Utils.sLLogOLO_SFChangeOrder;
    }
    
    //Status Update solo ritorno senza inserirli a sistema (per callout sincrone)
    public static List<EOF_EAI_Service_Log__C> OM_CreateStatusUpdate_Log(case c, object o){
        
        //CRM 05/06/2017 modificata la query. Ora viene usato il DeveloperName al posto del Name
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        if(!OF_CO_GE_Utils.checkrtMap){
            List<recordtype> rtList=[select Id,developerName from recordtype];
            OF_CO_GE_Utils.rtMap = new Map<String,Id>(); 
            for(recordtype rt :rtList){
                OF_CO_GE_Utils.rtMap.put(rt.DeveloperName, rt.Id); 
            }               
            OF_CO_GE_Utils.checkrtMap=true;
        }    

        //END CRM 05/06/2017
        //caso in cui mi arriva effettivamente da OM
        if(o instanceof OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate){
            OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate a = (OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate) o;         
            OF_CO_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.rtMap.get('OF_CO_ChangeOrderNotify'),
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
                EOF_NOME_CLIENTE__c=a.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__c=a.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE__c=a.RECAPITO_TELEFONICO_CLIENTE,
                EOF_DATA_PREVISTA_ATTIVAZIONE__c=StringToDateNoTime(a.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__c=a.ORARIO_APPUNTAMENTO,
                EOF_PIN_INTERVENTO_A_VUOTO__c=a.PIN_INTERVENTO_A_VUOTO,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            OF_CO_GE_Utils.slSFOLO.caso__c=c.Id;
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_CO_GE_Utils.slSFOLO.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_CO_GE_Utils.slSFOLO.EOF_Note__c = a.NOTE;
            }
            // finisce qui
                                    
            sLogList.add(OF_CO_GE_Utils.slSFOLO);
            Integer n = 1;
            if(a.VLAN!=null && !a.VLAN.isEmpty()){ 
                OF_CO_GE_Utils.checkVlan=true;
                OF_CO_GE_Utils.ListVlan= new List<EOF_EAI_Service_Log__C>();
                for(OF_SA_WS_IN_OM_StatusUpdate.VLan v : a.VLan){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.EOF_Tipo_COmunicazione_String__c='VLAN';
                    sLog.recordtypeid=OF_CO_GE_Utils.rtMap.get('OF_SA_Vlan');
                    sLog.OF_SA_USER_VLAN__C=v.USER_VLAN;
                    sLog.OF_SA_SERVICE_VLAN__C=v.SERVICE_VLAN;
                    sLog.OF_SA_CUSTOMER_VLAN__C=v.CUSTOMER_VLAN;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    OF_CO_GE_Utils.ListVlan.add(sLog);
                    n++;
                }
            }
            if(a.apparato!=null && !a.apparato.isEmpty()){
                OF_CO_GE_Utils.checkApp=true;
                OF_CO_GE_Utils.ListApp= new List<EOF_EAI_Service_Log__C>();
                for(OF_SA_WS_IN_OM_StatusUpdate.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.EOF_Tipo_COmunicazione_String__c='CPE';
                    sLog.recordtypeid=OF_CO_GE_Utils.rtMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.OF_SA_ESITO_RITIRO_APPARATO__C=app.ESITO_RITIRO_APPARATO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_RITIRO__C=app.CODICE_MOTIVAZIONE_RITIRO;
                    sLog.OF_SA_MOTIVAZIONE_RITIRO__C=app.MOTIVAZIONE_RITIRO;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    OF_CO_GE_Utils.ListApp.add(sLog);
                    n++;
                }
            }
            return sLogList;   
        } 
        
        
        return null;
    }    
    
    
    public static List<EOF_EAI_Service_Log__C> OLO_CreateDeactivation_Log(case c, object o){
        
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        
        //faccio il check per vedere se la mappa dei recordtype è popolata
        if(!OF_CO_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_CO_GE_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_CO_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_CO_GE_Utils.checkRTMap=true;
       }
        if(o instanceof OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest){
            OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest a = (OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.rtMap.get('OF_SA_FiberNotify'),
                EOF_Tipo_COmunicazione_String__c='SF->OM - DeactivationRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_DeactivationOrder',
                EOF_CODICE_OPERATORE__c=a.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c=a.CODICE_ORDINE_OLO,
                EOF_CODICE_ORDINE_EOF__c=c.Id,
                EOF_DATA_NOTIFICA__c=StringToDate(a.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c=a.ID_NOTIFICA,
                EOF_CODICE_MOTIVAZIONE__c=a.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__c=a.MOTIVAZIONE,
                EOF_GPON_Attestazione__c=c.EOF_GPON_ATTESTAZIONE__c,
                EOF_NOME_CLIENTE__c=a.NOME_CLIENTE, 
                EOF_COGNOME_CLIENTE__c=a.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=a.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=a.RECAPITO_TELEFONICO_CLIENTE_2,
                EOF_ID_RISORSA__c = a.ID_RISORSA,
                //sEOF_TIPO_COMUNICAZIONE__c = a.TIPO_COMUNICAZIONE,
                EOF_SORGENTE__c = 'OGW',
                //EOF_SLA_DATE__c = c.EOF_SLA_DATE__c,
                EOF_GPON_VINCOLANTE__c = c.EOF_GPON_Vincolante__c,
                EOF_OPZIONE_SYSTEM_UNICO__c = c.EOF_Opzione_System_Unico__c,
                EOF_COLLEGAMENTO_P2P__c = c.EOF_Collegamento_P2P__c,
                EOF_TRACCIATO__c = '2',
                EOF_ID_SERVIZIO__c = c.OF_SA_Id_Servizio__c,
                //EOF_PROFILO__c = a.PROFILO,
                EOF_Provincia__c = c.EOF_Provincia_WS__c,
                EOF_Comune__c= c.EOF_Comune_WS__c,
                EOF_Particella_Toponomastica__c = c.EOF_Particella_Toponomastica_WS__c,
                EOF_Indirizzo__c = c.EOF_Indirizzo_WS__c,
                EOF_Numero_Civico__c = c.EOF_Numero_Civico_WS__c,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                sl.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                sl.EOF_Note__c = a.NOTE;
            }
            // finisce qui            
            
            //caso in cui creo il log per la notifica ddi cessazione KO
            if(c.Status=='Cessato KO'){
                sl.EOF_Tipo_Comunicazione__c='98';
                sl.EOF_stato_ordine__c='7';
                sl.EOF_CODICE_MOTIVAZIONE__c=c.OF_SA_CODICE_MOTIVAZIONE__c;
                sl.EOF_MOTIVAZIONE__c=c.OF_SA_MOTIVAZIONE__c;
                sl.EOF_ID_Case_Temp__c=c.Id;
                sLogList.add(sl);
                insert sl;
                return sLogList;
            }
            sl.caso__c=c.Id;
            insert sl;
            sLogList.add(sl);
            
            if(a.apparato!=null && !a.apparato.isEmpty()){
                Integer n = 1;
                List<EOF_EAI_Service_Log__C> sLogAggiuntivi = new List<EOF_EAI_Service_Log__C>(); 
                for(OF_SA_WS_IN_OLO_Deactivation.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.EOF_Tipo_COmunicazione_String__c='CPE';
                    sLog.recordtypeid=OF_CO_GE_Utils.rtMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.OF_SA_ID_APPARATO__C=app.ID_APPARATO;
                    sLog.OF_SA_Cpe_Log__c=sl.Id;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    sLogAggiuntivi.add(sLog);
                    n++;
                }
                insert sLogAggiuntivi;
            }
            return sLogList;
            
        } 
        return null;
    }    
    public static EOF_EAI_Service_Log__C OM_CreateReschedule_Log(case c, object o){
        
        //faccio il check per vedere se la mappa dei recordtype è popolata
        if(!OF_CO_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_CO_GE_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_CO_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_CO_GE_Utils.checkRTMap=true;
       }
        //OM Reschedule
        if(o instanceof OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule){
            OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule a = (OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_CO_GE_Utils.rtMap.get('OF_SA_FiberNotify'),
                EOF_Tipo_COmunicazione_String__c='SF->OLO - Reschedule',
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_Reschedule',
                EOF_CODICE_OPERATORE__c=a.CODICE_OPERATORE, 
                EOF_CODICE_ORDINE_OLO__c=a.CODICE_ORDINE_OLO,
                EOF_CODICE_ORDINE_EOF__c=a.CODICE_ORDINE_OF,
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
            if(OF_CO_GE_Utils.checkCaseOriginale){
                sl.caso__c=OF_CO_GE_Utils.CaseOriginale.Id;
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
    
    public static List<EOF_EAI_Service_Log__c> create_ActivationToOM_Log(Case c2, List<EOF_EAI_Service_Log__c> ListSlOrig){
        List<EOF_EAI_Service_Log__c> listToOM = new List<EOF_EAI_Service_Log__c>();
        OF_CO_GE_Utils.ListVLanToOM=new List<EOF_EAI_Service_Log__c>();
        OF_CO_GE_Utils.ListAppToOM=new List<EOF_EAI_Service_Log__c>();
        OF_CO_GE_Utils.ListServAggToOM=new List<EOF_EAI_Service_Log__c>();
        for(EOF_EAI_Service_Log__c sl : ListSlOrig){
            if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                OF_CO_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c(
                RecordTypeId = sl.recordtypeId,
                EOF_Tipo_COmunicazione_String__c='SF->OM - ActivationRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_ActivationSetup_OpenStream',
                EOF_Sorgente__c='OGW',
                EOF_Tracciato__c='2',
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
                Caso__c=c2.Id
                );
                if(c2.status=='Acquisito'){
                    OF_CO_GE_Utils.slSFOM.EOF_Tipo_COmunicazione__c='1';
                    OF_CO_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '0';
                }
                else{
                    OF_CO_GE_Utils.slSFOM.EOF_Tipo_COmunicazione__c='99';
                    OF_CO_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '1';
                } 
                listToOM.add(OF_CO_GE_Utils.slSFOM);
            }
            Integer n = 1;
            if(sl.recordtype.developername=='OF_SA_Vlan'){ 
                OF_CO_GE_Utils.checkVLanToOM=true;
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
                OF_CO_GE_Utils.ListVLanToOM.add(sLog); 
                listToOM.add(sLog);
                n++;
            }
            if(sl.recordtype.developername=='OF_SA_Cpe'){ 
                OF_CO_GE_Utils.checkAppToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.EOF_TIPOLOGIA_APPARATO__C=sl.EOF_TIPOLOGIA_APPARATO__C;
                sLog.OF_SA_PASSWORD_APPARATO__C=sl.OF_SA_PASSWORD_APPARATO__C;
                sLog.OF_SA_AZIONE_APPARATO__C=sl.OF_SA_AZIONE_APPARATO__C;
                //sLog.OF_SA_Cpe_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n;
                OF_CO_GE_Utils.ListappToOM.add(sLog);
                listToOM.add(sLog);
                n++;
            }
            if(sl.recordtype.developername=='OF_SA_Servizi_Aggiuntivi'){ 
                OF_CO_GE_Utils.checkServAggToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.OF_SA_NOME_SERVIZIO__c=sl.OF_SA_NOME_SERVIZIO__c; 
                sLog.OF_SA_INFORMAZIONI_SERVIZIO__c=sl.OF_SA_INFORMAZIONI_SERVIZIO__c;
                //sLog.OF_SA_servizi_Aggiuntivi_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n; 
                OF_CO_GE_Utils.ListServAggToOM.add(sLog); 
                listToOM.add(sLog);
                n++;
            } 
                    
        }
        return listToOM;
    } 
      public static List<EOF_EAI_Service_Log__c> create_ChangeOrderToOM_Log(Case c2, List<EOF_EAI_Service_Log__c> ListSlOrig){
        List<EOF_EAI_Service_Log__c> listToOM = new List<EOF_EAI_Service_Log__c>();
        OF_CO_GE_Utils.ListVLanToOM=new List<EOF_EAI_Service_Log__c>();
        OF_CO_GE_Utils.ListAppToOM=new List<EOF_EAI_Service_Log__c>();
        OF_CO_GE_Utils.ListServAggToOM=new List<EOF_EAI_Service_Log__c>();
        for(EOF_EAI_Service_Log__c sl : ListSlOrig){
            if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                OF_CO_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c(
                RecordTypeId = sl.recordtypeId,
                EOF_Tipo_COmunicazione_String__c='SF->OM - ActivationRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_ActivationSetup_OpenStream',
                EOF_Sorgente__c='OGW',
                EOF_Tracciato__c='2',
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
                Caso__c=c2.Id
                );
                if(c2.status=='Acquisito'){
                    OF_CO_GE_Utils.slSFOM.EOF_Tipo_COmunicazione__c='1';
                    OF_CO_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '0';
                }
                else{
                    OF_CO_GE_Utils.slSFOM.EOF_Tipo_COmunicazione__c='99';
                    OF_CO_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '1';
                } 
                listToOM.add(OF_CO_GE_Utils.slSFOM);
            }
            Integer n = 1;
            if(sl.recordtype.developername=='OF_SA_Vlan'){ 
                OF_CO_GE_Utils.checkVLanToOM=true;
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
                OF_CO_GE_Utils.ListVLanToOM.add(sLog); 
                listToOM.add(sLog);
                n++;
            }
            if(sl.recordtype.developername=='OF_SA_Cpe'){ 
                OF_CO_GE_Utils.checkAppToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.EOF_TIPOLOGIA_APPARATO__C=sl.EOF_TIPOLOGIA_APPARATO__C;
                sLog.OF_SA_PASSWORD_APPARATO__C=sl.OF_SA_PASSWORD_APPARATO__C;
                sLog.OF_SA_AZIONE_APPARATO__C=sl.OF_SA_AZIONE_APPARATO__C;
                //sLog.OF_SA_Cpe_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n;
                OF_CO_GE_Utils.ListappToOM.add(sLog);
                listToOM.add(sLog);
                n++;
            }
            if(sl.recordtype.developername=='OF_SA_Servizi_Aggiuntivi'){ 
                OF_CO_GE_Utils.checkServAggToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.OF_SA_NOME_SERVIZIO__c=sl.OF_SA_NOME_SERVIZIO__c; 
                sLog.OF_SA_INFORMAZIONI_SERVIZIO__c=sl.OF_SA_INFORMAZIONI_SERVIZIO__c;
                //sLog.OF_SA_servizi_Aggiuntivi_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n; 
                OF_CO_GE_Utils.ListServAggToOM.add(sLog); 
                listToOM.add(sLog);
                n++;
            } 
                    
        }
        return listToOM;
    } 
    public static List<EOF_EAI_Service_Log__c> create_DeactivationToOM_Log(Case c2, List<EOF_EAI_Service_Log__c> ListSlOrig,Asset a){
        List<EOF_EAI_Service_Log__c> listToOM = new List<EOF_EAI_Service_Log__c>();
        OF_CO_GE_Utils.ListAppToOM=new List<EOF_EAI_Service_Log__c>();
        system.debug('Alessandro: la list è: '+ListSlOrig);
        for(EOF_EAI_Service_Log__c sl : ListSlOrig){
            if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                
                OF_CO_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c(
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
                EOF_TRACCIATO__c = '2',
                caso__c=c2.id
             );
 
            if(c2.status=='Acquisito'){
                OF_CO_GE_Utils.slSFOM.EOF_Tipo_COmunicazione__c='2';
                OF_CO_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '0';
                OF_CO_GE_Utils.slSFOM.EOF_GPON_Attestazione__c=a.OF_GPON_Attestazione__c;
                OF_CO_GE_Utils.slSFOM.EOF_ID_SERVIZIO__c = a.OF_IDServizio__c;
                //OF_CO_GE_Utils.slSFOM.EOF_PROFILO__c = a.PROFILO;
                OF_CO_GE_Utils.slSFOM.EOF_Provincia__c = a.OF_Provincia__c;
                OF_CO_GE_Utils.slSFOM.EOF_Comune__c= a.OF_Comune__c;
                OF_CO_GE_Utils.slSFOM.EOF_Particella_Toponomastica__c = a.OF_Particella_Toponomastica__c;
                OF_CO_GE_Utils.slSFOM.EOF_Indirizzo__c = a.OF_Indirizzo__c;
                OF_CO_GE_Utils.slSFOM.EOF_Numero_Civico__c = a.OF_Civico__c;
            }
            else{
                OF_CO_GE_Utils.slSFOM.EOF_Tipo_COmunicazione__c='98';
                OF_CO_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '1';
            } 
            listToOM.add(OF_CO_GE_Utils.slSFOM);
            }
            Integer n = 1;
            if(sl.recordtype.developername=='OF_SA_Cpe'){ 
                OF_CO_GE_Utils.checkAppToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.EOF_TIPOLOGIA_APPARATO__C=sl.EOF_TIPOLOGIA_APPARATO__C;
                sLog.OF_SA_ID_APPARATO__C=sl.OF_SA_ID_APPARATO__C;
                //sLog.OF_SA_Cpe_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n;
                OF_CO_GE_Utils.ListappToOM.add(sLog);
                listToOM.add(sLog);
                n++;
            }           
        }
        return listToOM;
    } 
    
    public static EOF_EAI_Service_Log__C OLO_CreateStatusUpdate_Log(Case c, object o){
        List<recordtype> rtList=[select Id,developerName from recordtype where developerName='OF_SA_Attivazione' or developerName = 'Cliente_Business'
                                 or developerName = 'PersonAccount' or developerName='Referente_Tecnico_OLO' or developerName='Servizi_Aggiuntivi' 
                                 or developerName='OF_CPE' or developerName='OF_VLAN' or developerName='OLO' or developerName='OF_SA_FiberRequest'or developerName='OF_SA_Servizi_Aggiuntivi'
                                 or developerName='OF_SA_FiberNotify' or developerName='OF_SA_Cpe'or developerName='OF_SA_Vlan' or developerName='OF_SA_ACK' or developerName='OF_SA_NACK'];
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }
        
        if(o instanceof OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest){
            //('OSCRM logMancante:--start--');
            OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur = (OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = rtMap.get('OF_SA_FiberRequest'),
                EOF_Tipo_COmunicazione_String__c='SF->OM - StatusUpdateRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_StatusUpdate',
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
                EOF_Richiesta_Notifica__c = copy_request(sur)
            );
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: sur.CODICE_ORDINE_OLO];
            if(!cList.isEmpty()){
                sl.caso__c=cList[0].Id;
            }
            
            // 20/02/2018 MM : abbreviazione campo note qualora sia più lungo di 255 caratteri
            if(string.isnotblank(sur.NOTE)){
                sl.EOF_Note__c= sur.NOTE.abbreviate(255);
            }
            else{
                sl.EOF_Note__c = sur.NOTE;
            }
            // finisce qui            
            //('OSCRM OF_CO_GE_Utils.OLO_CreateStatusUpdate_Log serviceLog sl:'+sl);
            return sl;        
        }
        return null;
    }
    
    public static EOF_EAI_Service_Log__C OLO_CreateReschedule_Log(Case c, object o){
        List<recordtype> rtList=[select Id,developerName from recordtype where developerName='OF_SA_Attivazione' or developerName = 'Cliente_Business'
                                 or developerName = 'PersonAccount' or developerName='Referente_Tecnico_OLO' or developerName='Servizi_Aggiuntivi' 
                                 or developerName='OF_CPE' or developerName='OF_VLAN' or developerName='OLO' or developerName='OF_SA_FiberRequest'or developerName='OF_SA_Servizi_Aggiuntivi'
                                 or developerName='OF_SA_FiberNotify' or developerName='OF_SA_Cpe'or developerName='OF_SA_Vlan' or developerName='OF_SA_ACK' or developerName='OF_SA_NACK'];
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }
        if(o instanceof OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest){
            OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest r = (OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = rtMap.get('OF_SA_FiberRequest'),
                EOF_Tipo_COmunicazione_String__c='SF->OM - RescheduleRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_Reschedule',
                EOF_CODICE_OPERATORE__c=r.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__c=r.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__c=OF_CO_GE_Utils.StringToDate(r.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c=r.ID_NOTIFICA,
                EOF_DATA_PREVISTA_ATTIVAZIONE__c=OF_CO_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__c=r.ORARIO_APPUNTAMENTO,
                EOF_NOME_CLIENTE__c=r.NOME_CLIENTE,
                EOF_COGNOME_CLIENTE__c=r.COGNOME_CLIENTE,
                EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=r.RECAPITO_TELEFONICO_CLIENTE_1,
                EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=r.RECAPITO_TELEFONICO_CLIENTE_2,
                EOF_CODICE_MOTIVAZIONE__c=r.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__c=r.MOTIVAZIONE,
                EOF_SORGENTE__c='OGW',
                EOF_codice_Ordine_EOF__c=r.CODICE_ORDINE_OF,
                //EOF_SLA_DATE__c=r.SLA_DATE,
                //EOF_GPON_ATTESTAZIONE__c=r.GPON_ATTESTAZIONE,
                //EOF_GPON_VINCOLANTE__c=r.GPON_VINCOLANTE,
                EOF_ID_SERVIZIO__c=c.OF_SA_ID_SERVIZIO__c,
                EOF_Richiesta_Notifica__c = copy_request(r)
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
            
            return sl;        
        }
        return null;
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
    public static String copy_notify_AcqCess(EOF_EAI_Service_Log__c sl){
        String s =  'CODICE_OPERATORE: ' + sl.EOF_Codice_Operatore__c + '\n' +            
                    'TIPO_COMUNICAZIONE: ' + sl.EOF_Tipo_Comunicazione__c + '\n' + 
                    'CODICE_ORDINE_OLO: ' + sl.EOF_Codice_Ordine_OLO__c + '\n' +
                    'CODICE_ORDINE_EOF: ' + sl.EOF_Codice_Ordine_EOF__c + '\n' +
                    'ID_NOTIFICA: ' + sl.EOF_ID_Notifica__c + '\n' +
                    'STATO_RICHIESTA: ' + sl.EOF_Stato_Richiesta__c + '\n' +
                    'CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO: ' + sl.EOF_Cod_Rifiuto_Sospensione_Annullamento__c + '\n' + 
                    'MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO: ' + sl.EOF_Mot_Rifiuto_Sospensione_Annullamento__c + '\n' +         
                    'DATA_NOTIFICA: ' + OF_CO_GE_Utils.DateToString(sl.EOF_Data_Notifica__c) + '\n';
        return s;
    }

    //Add by PG 25-05
    public static String copy_notify_Acquisition(EOF_EAI_Service_Log__c sl){
        String s =  'CODICE_OPERATORE: ' + sl.EOF_Codice_Operatore__c + '\n' +            
                    'TIPO_COMUNICAZIONE: ' + sl.EOF_Tipo_Comunicazione__c + '\n' + 
                    'CODICE_ORDINE_OLO: ' + sl.EOF_Codice_Ordine_OLO__c + '\n' +
                    'CODICE_ORDINE_EOF: ' + sl.EOF_Codice_Ordine_EOF__c + '\n' +
                    'ID_NOTIFICA: ' + sl.EOF_ID_Notifica__c + '\n' +                        
                    'DATA_NOTIFICA: ' + OF_CO_GE_Utils.DateToString(sl.EOF_Data_Notifica__c) + '\n'+
                    'STATO ORDINE: '+sl.EOF_stato_ordine__c + '\n'+
                    'CODICE MOTIVAZIONE: '+sl.EOF_CODICE_MOTIVAZIONE__c + '\n'+
                    'MOTIVAZIONE: '+sl.EOF_MOTIVAZIONE__c+ '\n';
        return s;
    }

    public static String copy_request(object o){
        String s;
        String data_prevista_attivazione='';
        //CHANGE ORDER SF->OM
        if(o instanceof GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element){
            GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element a = (GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element) o;
            s=  'TIPO_COMUNICAZIONE: '+ a.TIPO_COMUNICAZIONE + '\n' +
                'CODICE_OPERATORE: '+ a.CODICE_OPERATORE + '\n' +
                'CODICE_ORDINE_OLO: '+ a.CODICE_ORDINE_OLO + '\n' +
                'CODICE_ORDINE_OF: '+ a.CODICE_ORDINE_OF + '\n' +
                'DATA_NOTIFICA: '+ a.DATA_NOTIFICA + '\n' +
                'ID_NOTIFICA: '+ a.ID_NOTIFICA + '\n' +
                'ID_RISORSA: '+a.ID_RISORSA + '\n'+
                'CODICE_PROGETTO_SPECIALE: '+ a.CODICE_PROGETTO_SPECIALE + '\n' +
                'PROMOZIONE: '+ a.PROMOZIONE + '\n' +
                'CLUSTER_PROMOZIONE: '+ a.CLUSTER_PROMOZIONE + '\n' +
                'NOTE: '+ a.NOTE + '\n' +
                'PROFILO: '+ a.PROFILO + '\n' ;
            
            if(a.VLAN!=null && !a.VLAN.isEmpty()){
                Integer n = 1;
                for(GW_ChangeSetupOpenStream_Input.VLAN_element v : a.VLAN){
                    s=  s+ '\n' + 'VLAN '+n+': \n' +
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
        //CHANGE ORDER
        if(o instanceOf OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request){
            OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request a = (OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request) o;
            
            s=  'CODICE_OPERATORE: '+ a.CODICE_OPERATORE + '\n' +
                'CODICE_ORDINE_OLO: '+ a.CODICE_ORDINE_OLO + '\n' +
                'DATA_NOTIFICA: '+ a.DATA_NOTIFICA + '\n' +
                'ID_NOTIFICA: '+ a.ID_NOTIFICA + '\n' +
                'ID_RISORSA: '+a.ID_RISORSA + '\n'+
                'CODICE_PROGETTO_SPECIALE: '+ a.CODICE_PROGETTO_SPECIALE + '\n' +
                'PROMOZIONE: '+ a.PROMOZIONE + '\n' +
                'CLUSTER_PROMOZIONE: '+ a.CLUSTER_PROMOZIONE + '\n' +
                'NOTE: '+ a.NOTE + '\n' +
                'PROFILO: '+ a.PROFILO + '\n' ;
            
            if(a.VLAN!=null && !a.VLAN.isEmpty()){
                Integer n = 1;
                for(OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN v : a.VLAN){
                    s=  s+ '\n' + 'VLAN '+n+': \n' +
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


        //attivazione pre SF
        if(o instanceOf OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest){
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest a = (OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest) o;
            
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
                'PROFILO: '+ a.PROFILO + '\n' ;
            if(a.servizio_Aggiuntivo!=null && !a.servizio_Aggiuntivo.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OLO_Activation.servizio_aggiuntivo sa : a.servizio_Aggiuntivo){
                    s=                                                                                           s+ '\n' + 'SERVIZIO AGGIUNTIVO '+n+': \n' +
                        'NOME_SERVIZIO: '+sa.NOME_SERVIZIO+'\n' +
                        'INFORMAZIONI_SERVIZIO: '+sa.INFORMAZIONI_SERVIZIO+'\n' ;
                    n++;
                } 
            }  
            if(a.apparato!=null && !a.apparato.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OLO_Activation.apparato app : a.apparato){
                    s=                                                                                           s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'PASSWORD_APPARATO: '+app.PASSWORD_APPARATO+'\n' +
                        'AZIONE_APPARATO: '+app.AZIONE_APPARATO+'\n' ;
                    n++;
                }
            }
            if(a.VLAN!=null && !a.VLAN.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OLO_Activation.VLAN v : a.VLAN){
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
        //Disattivazione pre SF
        if(o instanceOf OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest){
            OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deact = (OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest) o;
            
            s=                                                                                           'CODICE_OPERATORE: '+ Deact.CODICE_OPERATORE + '\n' +
                'CODICE_ORDINE_OLO: '+ Deact.CODICE_ORDINE_OLO + '\n' +
                'DATA_NOTIFICA: '+ Deact.DATA_NOTIFICA + '\n' +
                'ID_NOTIFICA: '+ Deact.ID_NOTIFICA + '\n' +
                'ID_RISORSA: '+ Deact.ID_RISORSA + '\n' +
                'NOME_CLIENTE: '+ Deact.NOME_CLIENTE + '\n' +
                'COGNOME_CLIENTE: '+ Deact.COGNOME_CLIENTE + '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_1: '+ Deact.RECAPITO_TELEFONICO_CLIENTE_1 + '\n' +
                'RECAPITO_TELEFONICO_CLIENTE_2: '+ Deact.RECAPITO_TELEFONICO_CLIENTE_2 + '\n' +
                'CODICE_MOTIVAZIONE: '+ Deact.CODICE_MOTIVAZIONE + '\n' +
                'MOTIVAZIONE: '+ Deact.MOTIVAZIONE + '\n' +
                'NOTE: '+ Deact.NOTE + '\n' ; 
            
            if(Deact.apparato!=null && !Deact.apparato.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OLO_Deactivation.apparato app : Deact.apparato){
                    s=          s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'ID_APPARATO: '+app.ID_APPARATO+'\n' ;
                    n++;
                }
            }
        }
        //Rischedule da OLO pre SF
        if(o instanceOf OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest){
            OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest r = (OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest) o;
            
            s=                                                                                           'CODICE_ORDINE_OF: '+ r.CODICE_ORDINE_OF  + '\n' +
                'CODICE_OPERATORE: '+ r.CODICE_OPERATORE  + '\n' +
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
                'NOTE: '+ r.NOTE  + '\n' ;
            
        }
        
        //Status Update da OLO pre SF
        if(o instanceOf OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest){
            OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest su = (OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest) o;
            
            s=                                                                                           'CODICE_ORDINE_OF: '+ su.CODICE_ORDINE_OF  + '\n' +
                'CODICE_OPERATORE: '+ su.CODICE_OPERATORE  + '\n' + 
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
        if(o instanceOf OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder){
            OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = (OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder) o;
            
            s=                                                                                           'CODICE_OPERATORE: ' +co.CODICE_OPERATORE+ '\n' +
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
                'DDT: '+co.DDT+ '\n' +
                'NOTE: ' +co.NOTE+ '\n' ; 
            
            if(co.servizio_Aggiuntivo!=null && !co.servizio_Aggiuntivo.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO sa : co.servizio_Aggiuntivo){
                    s=          s+ '\n' + 'SERVIZIO AGGIUNTIVO '+n+': \n' +
                        'NOME_SERVIZIO: '+sa.NOME_SERVIZIO+'\n' +
                        'ESITO_SERVIZIO: '+sa.ESITO_SERVIZIO+'\n' +
                        'CODICE_MOTIVAZIONE_SERVIZIO: '+sa.CODICE_MOTIVAZIONE_SERVIZIO+'\n' +
                        'MOTIVAZIONE_SERVIZIO: '+sa.MOTIVAZIONE_SERVIZIO+'\n';
                    n++;
                } 
            }
            if(co.apparato!=null && !co.apparato.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OM_CompletionOrder.APPARATO app : co.apparato){
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
        //Reschedule da OM pre SF
        if(o instanceOf OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule){
            OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = (OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule) o;
            
            s=                                                                                           'CODICE_OPERATORE: ' +r.CODICE_OPERATORE+ '\n' +
                'CODICE_ORDINE_OLO: ' +r.CODICE_ORDINE_OLO+ '\n' +
                'CODICE_ORDINE_OF: ' +r.CODICE_ORDINE_OF+ '\n' +
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
        if(o instanceOf OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate){
            OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = (OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate) o;
            
            s=  'CODICE_OPERATORE: ' +su.CODICE_OPERATORE+ '\n' +
                'CODICE_ORDINE_OLO: ' +su.CODICE_ORDINE_OLO+ '\n' +
                'CODICE_ORDINE_OF: ' +su.CODICE_ORDINE_OF+ '\n' +
                'DATA_NOTIFICA: ' +su.DATA_NOTIFICA+ '\n' +
                'ID_NOTIFICA: ' +su.ID_NOTIFICA+ '\n' +
                'STATO_ORDINE: ' +su.STATO_ORDINE+ '\n' +  
                'CODICE_MOTIVAZIONE: ' +su.CODICE_MOTIVAZIONE+ '\n' +
                'MOTIVAZIONE: ' +su.MOTIVAZIONE+ '\n' +
                'GPON_DI_ATTESTAZIONE: ' +su.GPON_DI_Attestazione+ '\n' +
                'NOME_CLIENTE: ' +su.NOME_CLIENTE+ '\n' +
                'COGNOME_CLIENTE: ' +su.COGNOME_CLIENTE+ '\n' +
                'RECAPITO_TELEFONICO_CLIENTE: ' +su.RECAPITO_TELEFONICO_CLIENTE+ '\n' +
                'DATA_PREVISTA_ATTIVAZIONE: ' +su.DATA_PREVISTA_ATTIVAZIONE+ '\n' +
                'ORARIO_APPUNTAMENTO: ' +su.ORARIO_APPUNTAMENTO+ '\n' +
                'PIN_INTERVENTO_A_VUOTO: ' +su.PIN_INTERVENTO_A_VUOTO+ '\n' + 
                'NOTE: ' +su.NOTE+ '\n' ; 
            if(su.apparato!=null && !su.apparato.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OM_StatusUpdate.APPARATO app : su.apparato){
                    s=          s+ '\n' + 'APPARATO '+n+': \n' +
                        'TIPOLOGIA_APPARATO: '+app.TIPOLOGIA_APPARATO+'\n' +
                        'ESITO_RITIRO_APPARATO: '+app.ESITO_RITIRO_APPARATO+'\n' +
                        'CODICE_MOTIVAZIONE_RITIRO: '+app.CODICE_MOTIVAZIONE_RITIRO+'\n' +
                        'MOTIVAZIONE_RITIRO: '+app.MOTIVAZIONE_RITIRO+'\n' ;
                    n++;
                }
            } 
            if(su.VLan!=null && !su.VLan.isEmpty()){
                Integer n = 1;
                for(OF_SA_WS_IN_OM_StatusUpdate.VLAN v : su.VLan){
                    s=          s+ '\n' + 'VLAN '+n+': \n' +
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
    
    //metodo che gestisce l'aggiornamento dei dati in caso di NACK da OLO su Acquisito OK/KO e Cessato KO
    public static void aggiornamentoDatiAcquisizione(Case c){
        list<Case> caseToUpdate = new list<Case>();
        //valido sia per cessazione che attivazione
        if( OF_CO_GE_Utils.checkCliente){
            //Inserisco il cliente
            insert  OF_CO_GE_Utils.cliente;
            //Aggiungo il cliente al case
             OF_CO_GE_Utils.caseOriginale.AccountId =  OF_CO_GE_Utils.cliente.Id;
        }
        system.debug('Marco - il cliente inserito è :'+ OF_CO_GE_Utils.cliente);
        system.debug('Marco - Il cliente aggiunto al case è:' +OF_CO_GE_Utils.caseOriginale);
        if(OF_CO_GE_Utils.checkCEIList){
            insert OF_CO_GE_Utils.CEIList;
        }
        
          Insert  OF_CO_GE_Utils.slSFOLO;  
       
        
        //metto la reference alla notifica, la reference al slPrincipale e inserisco la response
        OF_CO_GE_Utils.slSFOLOresp.EOF_SL_Riferimento__c= OF_CO_GE_Utils.slSFOLO.Id;
        Insert slSFOLOresp;

        if( OF_CO_GE_Utils.checkRefTec){
            //inserisco il referente tecnico e metto il riferimento sul case
            insert  OF_CO_GE_Utils.refTec;
             OF_CO_GE_Utils.caseOriginale.EOF_Contact__c =  OF_CO_GE_Utils.refTec.Id;
        }
    
        OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
        String s=mofc.ManageOrder( OF_CO_GE_Utils.caseOriginale);
        if(!String.isBlank(s)){
             OF_CO_GE_Utils.caseOriginale.OF_Order__c=s;
        }
        //aggiungo gli eventuali case di amministratori da aggiornare
        if(OF_CO_GE_Utils.checkCaseAmm){
            caseToUpdate.addAll(OF_CO_GE_Utils.ListCaseAmmToUpdate);    
        }
        
        if(OF_CO_GE_Utils.gen!=null){
            try{
                delete OF_CO_GE_Utils.gen;
            }
            catch(exception e){
                insert OF_Utility.logMessageNew2(OF_CO_GE_Utils.caseOriginale.EOF_Codice_Ordine_OLO__c,'E','OF_CO_GE_Utils','aggiornamentoDatiAcquisizione',null, e);
            }
        }
        
        //in caso di cessazione KO è  sufficiente la seguente
        caseToUpdate.add( OF_CO_GE_Utils.caseOriginale);
        update caseToUpdate;
    }
    
    public static void aggiornamentoDatiAttivazioneCessazioneToOM(String processo, String tipo_comunicazione, String esito){
        list<Case> caseToUpdate = new list<Case>();
        list<EOF_EAI_Service_Log__c> slListPrincipaliToInsert = new list<EOF_EAI_Service_Log__c>();
        list<EOF_EAI_Service_Log__c> slListResponseAndElementToInsert = new list<EOF_EAI_Service_Log__c>();
        //valido sia per cessazione che attivazione
        if(OF_CO_GE_Utils.checkCliente){
            //Inserisco il cliente
            insert OF_CO_GE_Utils.cliente;
            //Aggiungo il cliente al case
            OF_CO_GE_Utils.caseOriginale.AccountId = OF_CO_GE_Utils.cliente.Id;
        }
        //system.debug('Marco - il cliente inserito è :'+ OF_CO_GE_Utils.cliente);
       // system.debug('Marco - Il cliente aggiunto al case è:' +OF_CO_GE_Utils.caseOriginale.AccountId);

        if(OF_CO_GE_Utils.checkRefTec){
            //inserisco il referente tecnico e metto il riferimento sul case
            insert OF_CO_GE_Utils.refTec;
            OF_CO_GE_Utils.caseOriginale.EOF_Contact__c = OF_CO_GE_Utils.refTec.Id;
        }
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@ il check CEI è: '+OF_CO_GE_Utils.checkCEIList);
        if(OF_CO_GE_Utils.checkCEIList){ 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@ la lista di CEI è: '+OF_CO_GE_Utils.CEIList);
            insert OF_CO_GE_Utils.CEIList;
        }
        //casi di attivazione OK/KO e cessazione KO
        try
        {
        if(processo=='Create' || (processo=='Delete' && tipo_comunicazione=='98')){

            slListPrincipaliToInsert.add(OF_CO_GE_Utils.slSFOLO);
            slListPrincipaliToInsert.add(OF_CO_GE_Utils.slSFOM);
              Insert slListPrincipaliToInsert;
             
            OF_CO_GE_Utils.slSFOLOresp.EOF_SL_Riferimento__c=OF_CO_GE_Utils.slSFOLO.Id;
            OF_CO_GE_Utils.slSFOMResp.EOF_SL_Riferimento__c=OF_CO_GE_Utils.slSFOM.Id;
            slListResponseAndElementToInsert.add(OF_CO_GE_Utils.slSFOMResp);
            slListResponseAndElementToInsert.add(OF_CO_GE_Utils.slSFOLOresp);
            if(OF_CO_GE_Utils.checkVLan){
                for(EOF_EAI_Service_Log__c sl : OF_CO_GE_Utils.listVlanToOM){
                    sl.OF_SA_VLan_Log__c=OF_CO_GE_Utils.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            if(OF_CO_GE_Utils.checkApp){
                for(EOF_EAI_Service_Log__c sl : OF_CO_GE_Utils.listAppToOM){
                    sl.OF_SA_Cpe_Log__c=OF_CO_GE_Utils.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            if(OF_CO_GE_Utils.checkServAgg){
                for(EOF_EAI_Service_Log__c sl : OF_CO_GE_Utils.listServAggToOM){
                    sl.OF_SA_servizi_Aggiuntivi_Log__c=OF_CO_GE_Utils.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            Insert slListResponseAndElementToInsert;
        }
       
        if(processo=='Delete' && tipo_comunicazione=='2'){
            //inserisco il log principale
            insert OF_CO_GE_Utils.slSFOM;
            //inserisco il riferimento sul log di response e poi la response
            OF_CO_GE_Utils.slSFOMResp.EOF_SL_Riferimento__c=OF_CO_GE_Utils.slSFOM.Id;
            Insert OF_CO_GE_Utils.slSFOMResp;
            
        }
        
        OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
        String s=mofc.ManageOrder(OF_CO_GE_Utils.caseOriginale);
        if(!String.isBlank(s)){
            OF_CO_GE_Utils.caseOriginale.OF_Order__c=s;
        } 
        //aggiungo gli eventuali case di amministratori da aggiornare
        if(OF_CO_GE_Utils.checkCaseAmm){
            caseToUpdate.addAll(OF_CO_GE_Utils.ListCaseAmmToUpdate);    
        }
        if(OF_CO_GE_Utils.caseOriginale.PO_SA_Portale__c){
            OF_CO_GE_Utils.ListSlStatusUpdateSFOLO=new List<EOF_EAI_Service_Log__c>();
            OF_CO_GE_Utils.ListSlStatusUpdateSFOLO.add(OF_CO_GE_Utils.slSFOLO);
            OF_CO_GE_Utils.aggiornaSLPortale(OF_CO_GE_Utils.ListSlStatusUpdateSFOLO, 'OM_StatusUpdate');
        }
         }
        catch(exception e){}
        //cancello il record di generatore id servizio dal db
        if(OF_CO_GE_Utils.gen!=null){
            try{
                delete OF_CO_GE_Utils.gen;
            }
            catch(exception e){
            	insert OF_Utility.logMessageNew2(OF_CO_GE_Utils.caseOriginale.EOF_Codice_Ordine_OLO__c,'E','OF_CO_GE_Utils','aggiornamentoDatiAttivazioneCessazioneToOM',null, e);
            }
        }
        //in caso di cessazione KO è  sufficiente la seguente
        caseToUpdate.add(OF_CO_GE_Utils.caseOriginale);
        try{
        update caseToUpdate;
        }catch(exception e){}
    } 
    
    @future
     public static void aggiornamentoDatiEspletamento(String caseId, String slSFOLOId, String slSFOLORespId){
        Case c = [select EOF_Id_Risorsa__c,OF_Bonifica_Locked_Row__c,EOF_GPON_Attestazione__c,EOF_SLA_Premium_Assurance__c,EOF_Apparato__c,
                    EOF_Progetto_Speciale__c,EOF_Tipologia_Apparato__c,EOF_Password_Apparato__c,OF_SA_Profilo__c,OF_SA_Promozione__c ,
                    OF_SA_CODICE_PROGETTO_SPECIALE__c ,OF_SA_Cluster_Promozione__c,OF_Esito_Consegna_Apparato__c,OF_SA_Codice_Motivazione__c,
                    OF_SA_Motivazione__c,EOF_ID_Building_WS__c,EOF_Identificativo_del_POP__c,EOF_Comune_WS__c,EOF_Provincia_WS__c,
                    EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c,EOF_Scala_Palazzina_WS__c,
                    PO_Attenuazione__c ,PO_Lunghezza_Ottica__c,PO_Posizione_Rilascio_Circuito_OSU__c,recordtypeId,recordtype.developername,
                    status,OF_Order__c
                    from Case where id=:caseId];
        OF_CO_GE_Utils.slSFOLO=[select Id,EOF_Tipo_comunicazione__c,EOF_Data_espletamento_ordine__c,EOF_Data_Notifica__c from EOF_EAI_Service_Log__c where id=:slSFOLOId];
        OF_CO_GE_Utils.slSFOLOResp=[select Id,EOF_Tipo_comunicazione__c,EOF_Data_espletamento_ordine__c,EOF_Data_Notifica__c,lastModifiedDate from EOF_EAI_Service_Log__c where id=:slSFOLORespId];
        OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
        c.AssetId=mofc.ManageOrder(c);
        update c;
    }

    //PG 25-05 - Creazione LOG di ACK e NACK
    public static void makeCalloutOLOOM(EOF_EAI_Service_Log__C slTOOLO){

        //chiamata a OLO -->NotifyStatusUpdate
        OF_SA_WS_OLO_Response.Esito_element resp = OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(slTOOLO);
    }
    
    //cessazione OK
    public static void makeCalloutOM(List<EOF_EAI_Service_Log__C> ListSlTOOM){
        OF_CO_GE_Utils.ListSlDeactivationSFOM=OF_CO_GE_Utils.create_DeactivationToOM_Log(OF_CO_GE_Utils.caseOriginale,OF_CO_GE_Utils.ListSlDeactivationOLOSF,OF_CO_GE_Utils.a);
        OF_SA_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(OF_CO_GE_Utils.ListSlDeactivationSFOM);
        OF_CO_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Delete',OF_CO_GE_Utils.slSFOM.EOF_Tipo_Comunicazione__c,null);
    }
    public static string IdservizioIntToString (integer i){
        if(i==1){
            return 'A';
        }
        if(i==2){
            return 'B';
        }
        if(i==3){
            return 'C';
        }
        if(i==4){
            return 'D';
        }
        if(i==5){
            return 'E';
        }
        if(i==6){
            return 'F';
        }
        if(i==7){
            return 'G';
        }
        if(i==8){
            return 'H';
        }
        if(i==9){
            return 'I';
        }
        if(i==10){
            return 'J';
        }
        if(i==11){
            return 'K';
        }
        if(i==12){
            return 'L';
        }
        if(i==13){
            return 'M';
        }
        if(i==14){
            return 'N';
        }
        if(i==15){
            return 'O';
        }
        if(i==16){
            return 'P';
        }
        if(i==17){
            return 'Q';
        }
        if(i==18){
            return 'R';
        }
        if(i==19){
            return 'S';
        }
        if(i==20){
            return 'T';
        }
        if(i==21){
            return 'U';
        }
        if(i==22){
            return 'V';
        }
        if(i==23){
            return 'W';
        }
        if(i==24){
            return 'X';
        }
        if(i==25){
            return 'Y';
        }
        if(i==26){
            return 'Z';
        }
        return null;
    }
     
    public static integer IdservizioStringToInt (string q){
        if(q=='A'){
            return 1;
        }
        if(q=='B'){
            return 2;
        }
        if(q=='C'){
            return 3;
        }
        if(q=='D'){
            return 4;
        }
        if(q=='E'){
            return 5;
        }
        if(q=='F'){
            return 6;
        }
        if(q=='G'){
            return 7;
        }
        if(q=='H'){
            return 8;
        }
        if(q=='I'){
            return 9;
        }
        if(q=='J'){
            return 10;
        }
        if(q=='K'){
            return 11;
        }
        if(q=='L'){
            return 12;
        }
        if(q=='M'){
            return 13;
        }
        if(q=='N'){
            return 14;
        }
        if(q=='O'){
            return 15;
        }
        if(q=='P'){
            return 16;
        }
        if(q=='Q'){
            return 17;
        }
        if(q=='R'){
            return 18;
        }
        if(q=='S'){
            return 19;
        }
        if(q=='T'){
            return 20;
        }
        if(q=='U'){
            return 21;
        }
        if(q=='V'){
            return 22;
        }
        if(q=='W'){
            return 23;
        }
        if(q=='X'){
            return 24;
        }
        if(q=='Y'){
            return 25;
        }
        if(q=='Z'){
            return 26;
        }
        return null;
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
            if (stato_ordine == '8'){
                return 'Modificato OK';
            }
            if (stato_ordine == '9'){
                return 'Modificato KO';
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
        if(!OF_CO_GE_Utils.checkDate(s.left(10))){      
            return false;           
        }
        if(!OF_CO_GE_Utils.checkTime(s.left(19).right(8))){         
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
            OF_CO_GE_Utils.checkCaseAmm=true;
            OF_CO_GE_Utils.ListCaseAmmToUpdate = new List<Case>();
            for(case cAmm : caseAmm){
                cAmm.CA_Codice_Ordine_in_Corso__c= OF_CO_GE_Utils.caseOriginale.EOF_Codice_Ordine_OLO__c;
                cAmm.CA_Stato_Ordine_in_Corso__c= OF_CO_GE_Utils.caseOriginale.status;
                cAmm.CA_Numero_Ordini_in_Corso__c=cAmm.CA_Numero_Ordini_in_Corso__c+1;
                OF_CO_GE_Utils.ListCaseAmmToUpdate.add(cAmm);
            }
            return;
        }
        catch(exception e){
            system.debug('L exception è: '+e);
        }
        return;
    }
     
    public static String getQuery(String oggetto,String Processo ){
        string s=null;
        if(oggetto=='case'){
            if(processo=='AsyncActivation'){
                s='Select Id, Codice_ordine_Eof__C, EOF_Codice_Ordine_Olo__c,'
                +'EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,'
                +'EOF_Data_Notifica__c,EOF_Id_Notifica__c,PO_SA_Portale__c,recordtype.developername,'
                +'EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,status,EOF_FASE__C,CaseNumber,OF_Response_Da_OM__c,' 
                +'OF_SA_ID_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,OF_SA_MOTIVAZIONE__c,EOF_Provincia_WS__c,EOF_Comune_WS__c,'
                +'EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c,OF_SA_ID_Building_OM__c,'
                +'OF_Response_Da_OLO__c,OF_Bonifica_Locked_Row__c from Case';
            }
            if(processo=='AsyncDeactivation'){
                s='Select Id, Codice_ordine_Eof__C, EOF_Codice_Ordine_Olo__c,EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,'
                    +'EOF_Data_Notifica__c,EOF_Id_Notifica__c,PO_SA_Portale__c,recordtype.developername,'
                    +'EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,status,EOF_FASE__C,EOF_Id_Risorsa__c,CaseNumber,OF_Bonifica_Locked_Row__c,'
                    +'OF_SA_CODICE_MOTIVAZIONE__c,OF_SA_MOTIVAZIONE__c,EOF_GPON_Vincolante__c,EOF_Opzione_System_Unico__c,EOF_Collegamento_P2P__c,'
                    +'OF_Response_Da_OLO__c,OF_Response_Da_OM__c from Case'; 
            } 
        }
        if(oggetto=='sl'){
            if(processo=='AsyncActivation'){
                s='select OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,EOF_Tipo_COmunicazione_String__c,EOF_CODICE_OPERATORE__C,'
                +'EOF_CODICE_ORDINE_OLO__C,EOF_DATA_NOTIFICA__C, EOF_ID_NOTIFICA__C,EOF_NOME_REFERENTE_TECNICO_OLO__C,'
                +'EOF_COGNOME_REFERENTE_TECNICO_OLO__C,EOF_TELEFONO_REFERENTE_TECNICO_OLO__C,EOF_EMAIL_REFERENTE_TECNICO_OLO__C,'
                +'EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C,EOF_NOME_CLIENTE__C,EOF_COGNOME_CLIENTE__C,EOF_RECAPITO_TELEFONICO_CLIENTE_1__C,'
                +'EOF_RECAPITO_TELEFONICO_CLIENTE_2__C,EOF_INFORMAZIONI_LOGISTICA_APPARATI__C,EOF_DATA_PREVISTA_ATTIVAZIONE__C,'
                +'EOF_ORARIO_APPUNTAMENTO__C,EOF_CODICE_PROGETTO_SPECIALE__c,EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,'
                +'EOF_NOTE__C,EOF_ID_BUILDING__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,'
                +'EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C,recordtype.developername,recordtype.name,OF_SA_NOME_SERVIZIO__c,'
                +'OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_PASSWORD_APPARATO__C,OF_SA_AZIONE_APPARATO__C,OF_SA_KIT_CONSEGNA_VLAN__C, '
                +'OF_SA_USER_VLAN__C,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__C,OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,'
                +'recordtypeId,EOF_Ordine_Invio_OLO__c'
                +' from EOF_EAI_Service_Log__c';
            }
            if(processo=='AsyncDeactivation'){
                s='select EOF_Tipo_COmunicazione_String__c,OF_SA_Direzione_Flusso__c,'
                    +'OF_SA_Metodo__c,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_DATA_NOTIFICA__c,'
                    +'EOF_ID_NOTIFICA__c,EOF_ID_RISORSA__c ,EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,'
                    +'EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,EOF_NOTE__c,'
                    +'recordtype.developername,recordtype.name,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ID_APPARATO__C,'
                    +'recordtypeId,EOF_Ordine_Invio_OLO__c'
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
    public static object simulateNACK(String origine){
        if(origine=='OLO'){
            OF_SA_WS_OM_Response.Esito_element resp = new OF_SA_WS_OM_Response.Esito_element();
            resp.ID_NOTIFICA=String.valueOf(system.now().gettime()); 
            resp.ESITO='1';
            resp.CODICE_MOTIVAZIONE='200';
            resp.MOTIVAZIONE='Errore nella Request: il messaggio non è conforme al WSDL';
            return resp;
        }
        if(origine=='OM'){
            OF_SA_WS_OLO_Response.Esito_element resp = new OF_SA_WS_OLO_Response.Esito_element();
            resp.ID_NOTIFICA=String.valueOf(system.now().gettime());
            resp.ESITO='1';
            resp.CODICE_MOTIVAZIONE='200';
            resp.MOTIVAZIONE='Errore nella Request: il messaggio non è conforme al WSDL';
            return resp;
        }
        return null;
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
        System.debug('**** AGGIORNASLPORTALE metodo = ' + metodo);
        System.debug('**** LISTA AGGIORNASLPORTALE sList = ' + slList);
        System.debug('**** CASE!!!! ' + OF_CO_GE_Utils.caseOriginale);
        if(metodo.equalsIgnoreCase('OLO_ActivationTO_OM')) {
            //Done AA: Aggioranre sLog del portale
            if(slList.size()>=1){
                slPrincipaleToOLO=slList[0];
                List<EOF_EAI_service_Log__c> slListPortale =[Select Id,EOF_Codice_Ordine_OLO__C,recordType.developerName,EOF_TIPOLOGIA_APPARATO__C,OF_SA_User_Vlan__c,OF_SA_Service_Vlan__c
                                                                from EOF_EAI_service_Log__c where EOF_Stato_Richiesta__c='Inserita Portale'
                                                                AND EOF_COdice_Ordine_OLO__c=:slPrincipaleToOLO.EOF_COdice_Ordine_OLO__c 
                                                                AND RecordType.DeveloperName = 'PO_CO_FiberRequest'
                                                                order by createdDate ASC];
                system.debug('Alessandro: la lista da Portale è: '+slListPortale); 
                slListPortale[0].EOF_Stato_Ordine__c = OF_CO_GE_Utils.caseOriginale.status;
                update slListPortale[0];
            }
        }
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
                        /*if(slTempPortale.recordType.developerName=='PO_SA_FiberRequest'){
                            slPrincipalePortale=slTempPortale;
                            slPrincipalePortale.EOF_DATA_Notifica__c=slPrincipaleToOLO.EOF_DATA_Notifica__c;
                            slPrincipalePortale.EOF_ID_Notifica__c=slPrincipaleToOLO.EOF_ID_Notifica__c;
                            slPrincipalePortale.EOF_Stato_Ordine__c=OF_CO_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
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
                            
                        }*/
                        if(slTempPortale.recordType.developerName=='PO_CO_FiberRequest'){
                            slPrincipalePortale=slTempPortale;
                            slPrincipalePortale.EOF_DATA_Notifica__c=slPrincipaleToOLO.EOF_DATA_Notifica__c;
                            slPrincipalePortale.EOF_ID_Notifica__c=slPrincipaleToOLO.EOF_ID_Notifica__c;
                            slPrincipalePortale.EOF_Stato_Ordine__c=OF_CO_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
                            if(!String.isBlank(slPrincipaleToOLO.EOF_Codice_Motivazione__c)){
                                slPrincipalePortale.EOF_Codice_Motivazione__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c;
                        slPrincipalePortale.EOF_Motivazione__c=slPrincipaleToOLO.EOF_Motivazione__c;
                        slPrincipalePortale.EOF_Causale_Errore__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c+' - '+slPrincipaleToOLO.EOF_Motivazione__c;
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
                    slPrincipalePortale.EOF_Stato_Ordine__c=OF_CO_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
                    if(!String.isBlank(slPrincipaleToOLO.EOF_Codice_Motivazione__c)){
                        slPrincipalePortale.EOF_Codice_Motivazione__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c;
                        slPrincipalePortale.EOF_Motivazione__c=slPrincipaleToOLO.EOF_Motivazione__c;
                        slPrincipalePortale.EOF_Causale_Errore__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c+' - '+slPrincipaleToOLO.EOF_Motivazione__c;
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
                                                                AND recordType.developerName='PO_CO_FiberRequest'];

                slPrincipalePortale.EOF_DATA_Notifica__c=slPrincipaleToOLO.EOF_DATA_Notifica__c;
                slPrincipalePortale.EOF_ID_Notifica__c=slPrincipaleToOLO.EOF_ID_Notifica__c;
                slPrincipalePortale.EOF_Stato_Ordine__c=OF_CO_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
                if(!String.isBlank(slPrincipaleToOLO.EOF_Codice_Motivazione__c)){
                    slPrincipalePortale.EOF_Codice_Motivazione__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c;
                        slPrincipalePortale.EOF_Motivazione__c=slPrincipaleToOLO.EOF_Motivazione__c;
                        slPrincipalePortale.EOF_Causale_Errore__c=slPrincipaleToOLO.EOF_Codice_Motivazione__c+' - '+slPrincipaleToOLO.EOF_Motivazione__c;
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
                            slPrincipalePortale.EOF_Stato_Ordine__c=OF_CO_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
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
                /*  system.debug('Alessandro: la lista da Portale servizi aggiuntivi è: '+listServiziAggiuntiviDaPortale);
                    system.debug('Alessandro: la lista da Portale APPARATI è: '+listApparatiDaPortale);
                    system.debug('Alessandro: la lista da OM APPARATI è: '+listApparatiDaOM);
                    system.debug('Alessandro: la lista da OM servizi aggiuntivi è: '+listServiziAggiuntiviDaOM);*/
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
                    slPrincipalePortale.EOF_Stato_Ordine__c=OF_CO_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
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
                slPrincipalePortale.EOF_Stato_Ordine__c=OF_CO_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
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


   
}
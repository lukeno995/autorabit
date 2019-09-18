public without sharing class OF_PP_GE_Utils {
    
    public static EOF_EAI_Service_Log__c slOLOSF; 
    public static EOF_EAI_Service_Log__c slSFOLO;
    public static EOF_EAI_Service_Log__c slSFOLOResp;
    public static EOF_EAI_Service_Log__c slSFOM;
    public static EOF_EAI_Service_Log__c slSFOMResp;
    public static EOF_EAI_Service_Log__c slOMSF;
    public static List<EOF_EAI_Service_Log__c> ListSlActivationOLOSF;
    public static List<EOF_EAI_Service_Log__c> ListSlActivationCosOLOSF;
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
    public static List<EOF_EAI_Service_Log__c> ListCOSToOM; // Add by PG
    public static boolean checkCosToOM=false; // Add by PG
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
    public static double AttrTime;    
    // finisce qui

    public static OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse syncError(Object o, String errorCode, String fieldName){
        
        OF_PP_GE_Utils.Response='NACK';
        List<String> result = new List<String>();
        //aggiungo SL di riferimento
        EOF_EAI_Service_Log__c slRiferimento;
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse res_temp = new OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse();
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
        
        if(errorCode == 'B04'){
            errorDesc = 'Carattere non ammesso nel campo \''+fieldName+'\'';
        }
        if(errorCode == 'A09'){
            errorDesc = 'Data Attesa Consegna non conforme agli SLA';
        }
        if(errorCode == 'A10'){
            errorDesc = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
        }

        //codice inserito per la gestione dei kit
        if(o instanceof OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest){
            
            system.debug('########### KIT_ActivationRequest 1');
            OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest x = (OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest) o;
            
            slRiferimento = OF_PP_GE_Utils.slOLOSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            system.debug('########### KIT_ActivationRequest 2');
            tipo_comunicazione='OLO->SF - NACK - ActivationRequest';
            flusso='OLO-SF';
            Metodo='OLO_ActivationSetup_ConsegnaKIT';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            
            RICHIESTA_NOTIFICA=Copy_request(x);
            system.debug('########### KIT_ActivationRequest 3');
        } 
        //codice inserito per la gestione dei kit - FINE
        
        //PG - codice inserito per la gestione delle VLAN PP
        if(o instanceof OF_PP_WS_IN_OLO_Activation.VLAN_PP){
            
            system.debug('########### VLAN_PP 1');
            OF_PP_WS_IN_OLO_Activation.VLAN_PP x = (OF_PP_WS_IN_OLO_Activation.VLAN_PP) o;
            
            slRiferimento = OF_PP_GE_Utils.slOLOSF;
            slRiferimento.EOF_Response__c = 'NACK';
            update slRiferimento;
            
            system.debug('########### VLAN_PP 2');
            tipo_comunicazione='OLO->SF - NACK - VLAN_ActivationRequest';
            flusso = 'OLO-SF';
            Metodo = 'OLO_ActivationSetup_ConsegnaVLAN';
            Codice_operatore = x.Codice_operatore;
            CODICE_ORDINE_OLO = x.CODICE_ORDINE_OLO;
            ID_NOTIFICA = x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA = Copy_request(x);
            system.debug('########### VLAN_PP 3');
        } 
        //codice inserito per la gestione delle VLAN PP - FINE
        
        //Commento PG - 31-08
        /*
        if(o instanceof OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest){
            OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest x = (OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest) o;
            
            slRiferimento = OF_PP_GE_Utils.slOLOSF;
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
            slRiferimento = OF_PP_GE_Utils.create_EAI_Log(x);
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
            slRiferimento = OF_PP_GE_Utils.create_EAI_Log(x);
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
            OF_PP_GE_Utils.create_EAI_Log(x);
            
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
            OF_PP_GE_Utils.create_EAI_Log(x);
            
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
            OF_PP_GE_Utils.create_EAI_Log(x);
            
            flusso='OM-SF';
            Metodo='OF_CompletionOrder_OpenStream';
            tipo_comunicazione='OLO->SF - NACK - CompletionOrderNotify';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
        } 
        */
        
        res_temp.Esito = '1';
        res_temp.CODICE_MOTIVAZIONE = errorCode;
        res_temp.MOTIVAZIONE = errorDesc;
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
   
    public static OF_PP_WS_IN_OLO_Activation.VLAN_PP syncErrorVLAN(Object o, String errorCode, String fieldName){
        system.debug('SSSSSSSSSSS DENTRO syncErrorVLAN');
        OF_PP_GE_Utils.Response='NACK VLAN';
        List<String> result = new List<String>();
        //aggiungo SL di riferimento
        EOF_EAI_Service_Log__c slRiferimento;
        OF_PP_WS_IN_OLO_Activation.VLAN_PP res_temp = new OF_PP_WS_IN_OLO_Activation.VLAN_PP();
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
        String codice_ordine_Sfdc = '';
        String codice_ordine_so = '';
        
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
        
        if(errorCode == 'B04'){
            errorDesc = 'Carattere non ammesso nel campo \''+fieldName+'\'';
        }
        if(errorCode == 'A09'){
            errorDesc = 'Data Attesa Consegna non conforme agli SLA';
        }
        if(errorCode == 'A10'){
            errorDesc = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
        }
        if(errorCode == 'A_K8'){
            errorDesc = 'Errore Tecnico di Interfaccia ';
        }

        //codice inserito per la gestione dei kit
        if(o instanceof OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest){
            
            system.debug('SSSSSSSSSSS KIT_ActivationRequest 1');
            OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest x = (OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest) o;
            
            slRiferimento = OF_PP_GE_Utils.slOLOSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            system.debug('########### KIT_ActivationRequest 2');
            tipo_comunicazione='OLO->SF - NACK - ActivationRequest';
            flusso='OLO-SF';
            Metodo='OLO_ActivationSetup_ConsegnaKIT';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            
            RICHIESTA_NOTIFICA=Copy_request(x);
            system.debug('########### KIT_ActivationRequest 3');
        } 
        //codice inserito per la gestione dei kit - FINE
        
        //PG - codice inserito per la gestione delle VLAN PP
        if(o instanceof OF_PP_WS_IN_OLO_Activation.VLAN_PP){
            
            system.debug('########### VLAN_PP 1');
            OF_PP_WS_IN_OLO_Activation.VLAN_PP x = (OF_PP_WS_IN_OLO_Activation.VLAN_PP) o;
            
            slRiferimento = OF_PP_GE_Utils.slOLOSF;
            slRiferimento.EOF_Response__c = 'NACK';
            update slRiferimento;
            
            system.debug('########### VLAN_PP 2');
            tipo_comunicazione='OLO->SF - NACK - VLAN_ActivationRequest';
            flusso = 'OLO-SF';
            Metodo = 'OLO_ActivationSetup_ConsegnaVLAN';
            Codice_operatore = x.Codice_operatore;
            CODICE_ORDINE_OLO = x.CODICE_ORDINE_OLO;
            ID_NOTIFICA = x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA = Copy_request(x);
            system.debug('########### VLAN_PP 3');
        } 
        //codice inserito per la gestione delle VLAN PP - FINE
        
        //Commento PG - 31-08
        /*
        if(o instanceof OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest){
            OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest x = (OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest) o;
            
            slRiferimento = OF_PP_GE_Utils.slOLOSF;
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
            slRiferimento = OF_PP_GE_Utils.create_EAI_Log(x);
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
            slRiferimento = OF_PP_GE_Utils.create_EAI_Log(x);
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
            OF_PP_GE_Utils.create_EAI_Log(x);
            
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
            OF_PP_GE_Utils.create_EAI_Log(x);
            
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
            OF_PP_GE_Utils.create_EAI_Log(x);
            
            flusso='OM-SF';
            Metodo='OF_CompletionOrder_OpenStream';
            tipo_comunicazione='OLO->SF - NACK - CompletionOrderNotify';
            COdice_operatore=x.COdice_operatore;
            CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA=Copy_request(x);
        }  */
        if(o instanceof OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN){
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN x = (OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN) o;
            //in caso di statusUpdate sincrono creo il service Log
            OF_PP_GE_Utils.create_EAI_Log(x);
            
            flusso='OM-SF';
            Metodo='OM_SyncChecksStatusUpdateVLAN';
            //tipo_comunicazione='OM->SF - NACK - StatusUpdateVlan';
            tipo_comunicazione='SF->OM - NACK - StatusUpdateVlan';
            Codice_operatore=x.Codice_operatore;
            //CODICE_ORDINE_OLO=x.CODICE_ORDINE_OLO;
            codice_ordine_sfdc = x.CODICE_ORDINE_SFDC;
            codice_ordine_so = x.CODICE_ORDINE_SO;
            ID_NOTIFICA=x.ID_NOTIFICA;
            RICHIESTA_NOTIFICA = Copy_request(x);
        }
        
        res_temp.Esito = '1';
        res_temp.CODICE_MOTIVAZIONE = errorCode;
        res_temp.MOTIVAZIONE = errorDesc;
        //faccio il check se il service log  di riferimento è stato correttamente popolato
        String slReferenceId;
        if(slRiferimento!=null){
            slReferenceId=slRiferimento.Id;
        }
        EOF_EAI_Service_Log__c slNACK = create_EAI_Log(new Map<String,String>{'Type' => 'NACK VLAN',
                                                        'Codice_errore' => errorCode,
                                                        'Causale_errore' => errorDesc,
                                                        'Flusso' => flusso,
                                                        'Metodo' => metodo,
                                                        'CODICE_ORDINE_SFDC' => codice_ordine_sfdc,
                                                        'CODICE_ORDINE_SO' => codice_ordine_so,
                                                        'Codice_operatore' => CODICE_OPERATORE,
                                                        //'Codice_ordine_OLO' => CODICE_ORDINE_OLO,
                                                        'ID_notifica' => ID_NOTIFICA,
                                                        'Richiesta Notifica' => RICHIESTA_NOTIFICA,
                                                        'Tipo Comunicazione' => tipo_comunicazione,
                                                        'SL Riferimento' => slReferenceId});
        System.debug('****** AA VALORE SLNACK = ' + slNACK);
        insert slNACK;
        
        return res_temp;
    }
    
    //OK - Metodo create_EAI_Log
    public static EOF_EAI_Service_Log__c create_EAI_Log(Object o){
        
        //('OSCRM OK');
        if(!OF_PP_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_PP_GE_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_PP_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_PP_GE_Utils.checkRTMap=true;
        }
                                                                                        
        if(o instanceof OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest){
            
            OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest a = (OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_PP_GE_Utils.RTMap.get('OF_PP_KIT_ActivationRequest'),
                OF_SA_Direzione_Flusso__c='OLO-SF',
                OF_SA_Metodo__c='OLO_ActivationSetup_KitConsegna',
                EOF_Tipo_Comunicazione_String__c='KIT Consegna',
                EOF_STATO_ORDINE__c = 'Accettato',
                EOF_Stato_Richiesta__c='Inserita Portale',
                EOF_CODICE_OPERATORE__C=a.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__C=a.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__C=StringTODate(a.DATA_NOTIFICA), 
                EOF_ID_NOTIFICA__C=a.ID_NOTIFICA,
                Nome_del_KIT__c             = a.NOME_KIT ,             
                Modello_di_Servizio__c          = a.MODELLO_SERVIZIO ,     
                POP__c                          = a.IDENTIFICATIVO_DEL_POP,
                Banda_Interfaccia__c            = a.BANDA,       
                PO_PP_Interfaccia__c            = a.INTERFACCIA,
                Posizione_ODF__c              =  a.ODF   ,                
                Traffico__c                  =   a.TRAFFICO  ,           
                Servizi_per_utenti_finali__c=    a.SERVIZIFINALI  ,  
                EOF_Note__c = a.NOTE,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            if (a.CODICE_ORDINE_OLO!=null){
                List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: a.CODICE_ORDINE_OLO];
                if(!cList.isEmpty()){
                    OF_PP_GE_Utils.caseOriginale=cList[0];
                    OF_PP_GE_Utils.checkCaseOriginale=true;
                    sl.caso__c=OF_PP_GE_Utils.caseOriginale.Id;
                }
            }
            insert sl;
            Integer n = 1;
            return sl;       
        }
    
        //VLAN_ActivationRequest e COS
        if(o instanceof OF_PP_WS_IN_OLO_Activation.VLAN_PP){
            
            OF_PP_WS_IN_OLO_Activation.VLAN_PP a = (OF_PP_WS_IN_OLO_Activation.VLAN_PP) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_PP_GE_Utils.RTMap.get('OF_PP_VLAN_ActivationRequest'),
                OF_SA_Direzione_Flusso__c = 'OLO-SF',
                OF_SA_Metodo__c = 'OLO_ActivationSetup_RequestVLAN',
                EOF_Tipo_Comunicazione_String__c='VLAN',
                Codice_Ordine_SO__c = a.CODICE_ORDINE_SO,
                Codice_Ordine_SFDC__c = a.CODICE_ORDINE_SFDC,
                EOF_CODICE_OPERATORE__C=a.CODICE_OPERATORE,
                EOF_STATO_ORDINE__c = 'Accettato',
                EOF_Stato_Richiesta__c='Inserita Portale',
                EOF_DATA_NOTIFICA__C = StringToDateTime(a.DATA_NOTIFICA), 
                EOF_ID_NOTIFICA__C = a.ID_NOTIFICA,
                POP__c = a.POP_KIT,
                PO_PP_POP_raccolta__c = a.POP,
                SVLAN__c = a.SVLAN,
                Nome_del_KIT__c = a.NOME_KIT,
                PO_PP_Interfaccia__c = a.INTERFACCIA,
                Banda_Interfaccia__c = a.BANDA_INTERFACCIA,     
                PO_PP_cos_class__c = a.COS_CLASS,
                PO_PP_cos_type__c = a.COS_TYPE,            
                PO_PP_dhcp_Option82__c = a.DHCP_OPTION82,                
                PO_PP_cos_remarking__c = a.COS_REMARKING,    
                EOF_Note__c = a.NOTE,
                PO_PP_Progressivo_Ordine__c = a.PROGRESSIVO_ORDINE,
                PO_PP_User_VLAN__c = a.USER_VLAN,
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            System.debug('#####_(OF_PP_GE_Utils__EOF_DATA_NOTIFICA__c__stringToDateTime###: '+sl.EOF_DATA_NOTIFICA__C);
            System.debug('#####_(OF_PP_GE_Utils__a.DATA_NOTIFICA ###: '+a.DATA_NOTIFICA);
            insert sl;
            
            List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        
            if(a.listaCOS!=null && !a.listaCOS.isEmpty())
            { 
                for(OF_PP_WS_IN_OLO_Activation.COS cos : a.listaCOS)
                {
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.recordtypeid = OF_PP_GE_Utils.RTMap.get('OF_PP_COS');
                    sLog.PO_PP_Cos_Type__c = cos.TIPO;
                    sLog.PO_PP_Cos_Class__c = cos.CLASSE;
                    sLog.PO_PP_ID_Vlan__c = sl.id;
                    sLogList.add(sLog);
                }
            }
            insert sLogList;
            
            /*
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c 
                                FROM Case 
                                Where EOF_Codice_Ordine_OLO__c =: a.CODICE_ORDINE_OLO];
            
            if(!cList.isEmpty())
            {
                OF_PP_GE_Utils.caseOriginale=cList[0];
                OF_PP_GE_Utils.checkCaseOriginale=true;
                sl.caso__c=OF_PP_GE_Utils.caseOriginale.Id;
            }
            Integer n = 1;
            */
            return sl;       
        }

        if(o instanceof Map<String, String>)
        {
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@> MAPPA: DENTRO MAPPA');
            //ACK KIT
            if(((Map<String, String>) o).get('Type') == 'ACK')
            { 
                system.debug('@@@@@@@@@@@@@@@@@@@@@@@> MAPPA: DENTRO MAPPA ACK');
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_PP_GE_Utils.RTMap.get('OF_PP_KIT_ACK'),
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
                
                 if(OF_PP_GE_Utils.checkCaseOriginale){
                     system.debug('@@@@@@@@@@@@@@@@@@@@@@@> MAPPA: DENTRO MAPPA checkCaseOriginale');
                    sl.Caso__c=OF_PP_GE_Utils.caseOriginale.Id;
                 }
                return sl;
            }
            
            //NACK KIT
            if(((Map<String, String>) o).get('Type') == 'NACK'){
                OF_Utility.logMessage( true, 'L','OF_PP_GE_Utils','syncError','Map<String, String>) o).get(\'Type\'):'+((Map<String, String>) o).get('Type'));
                String s=''; 
                system.debug('<<<<<<<<<<<<<<<<< ATTENZIONE!!!! CREO IL NACK - KIT');
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_PP_GE_Utils.RTMap.get('OF_PP_KIT_NACK'),
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
                if(OF_PP_GE_Utils.checkCaseOriginale){
                    system.debug('<<<<<<<<<<<<<<<<< ATTENZIONE!!!! CREO IL NACK ASSOCIO CASE');
                    sl.Caso__c=OF_PP_GE_Utils.caseOriginale.Id;
                 }
                return sl;
            }
            
            //ACK VLAN
            if(((Map<String, String>) o).get('Type') == 'ACK VLAN')
            { 
                system.debug('@@@@@@@@@@@@@@@@@@@@@@@> MAPPA: DENTRO MAPPA ACK VLAN');
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_PP_GE_Utils.RTMap.get('OF_PP_VLAN_ACK'),
                    Caso__c = ((Map<String, String>) o).get('Caso'),
                    OF_SA_Direzione_Flusso__c=((Map<String, String>) o).get('Flusso'),
                    OF_SA_Metodo__c=((Map<String, String>) o).get('Metodo'),
                    EOF_Stato_Richiesta__c = 'OK',
                    Codice_Ordine_SO__c = ((Map<String, String>) o).get('CODICE_ORDINE_SO'),
                    Codice_Ordine_SFDC__c = ((Map<String, String>) o).get('CODICE_ORDINE_SFDC'),
                    //EOF_Codice_Ordine_OLO__c = ((Map<String, String>) o).get('Codice_ordine_OLO'),
                    EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
                    EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                    EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('Richiesta Notifica'),  
                    EOF_Tipo_Comunicazione_String__c = ((Map<String, String>) o).get('Tipo Comunicazione'),
                    EOF_CODICE_MOTIVAZIONE__c = ((Map<String, String>) o).get('Codice_motivazione'),
                    EOF_MOTIVAZIONE__c = ((Map<String, String>) o).get('Motivazione'),
                    //aggiungo sl di riferimento
                    EOF_SL_Riferimento__c= ((Map<String, String>) o).get('SL Riferimento'),
                    EOF_Data_Notifica__c = system.now()       
                );
                
                 if(OF_PP_GE_Utils.checkCaseOriginale){
                     system.debug('@@@@@@@@@@@@@@@@@@@@@@@> MAPPA: DENTRO MAPPA checkCaseOriginale VLAN');
                     sl.Caso__c=OF_PP_GE_Utils.caseOriginale.Id;
                 }
                return sl;
            }
            //VLAN NACK
            if(((Map<String, String>) o).get('Type') == 'NACK VLAN'){
                OF_Utility.logMessage( true, 'L','OF_PP_GE_Utils','syncError','Map<String, String>) o).get(\'Type\'):'+((Map<String, String>) o).get('Type'));
                String s=''; 
                system.debug('<<<<<<<<<<<<<<<<< ATTENZIONE!!!! CREO IL NACK VLAN');
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_PP_GE_Utils.RTMap.get('OF_PP_VLAN_NACK'),
                    OF_SA_Direzione_Flusso__c=((Map<String, String>) o).get('Flusso'),
                    OF_SA_Metodo__c=((Map<String, String>) o).get('Metodo'),
                    EOF_Stato_Richiesta__c = 'KO',
                    EOF_Codice_Errore__c = ((Map<String, String>) o).get('Codice_errore'),
                    EOF_Causale_Errore__c = ((Map<String, String>) o).get('Causale_errore'),
                    Codice_Ordine_SO__c = ((Map<String, String>) o).get('CODICE_ORDINE_SO'),
                    Codice_Ordine_SFDC__c = ((Map<String, String>) o).get('CODICE_ORDINE_SFDC'),
                    //EOF_Codice_Ordine_OLO__c = ((Map<String, String>) o).get('Codice_ordine_OLO'),
                    EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
                    EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                    EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('Richiesta Notifica'),  
                    EOF_Tipo_Comunicazione_String__c = ((Map<String, String>) o).get('Tipo Comunicazione'),  
                    //aggiungo sl di riferimento
                    EOF_SL_Riferimento__c= ((Map<String, String>) o).get('SL Riferimento'),               
                    EOF_Data_Notifica__c = system.now()       
                );
                if(OF_PP_GE_Utils.checkCaseOriginale){
                    system.debug('<<<<<<<<<<<<<<<<< ATTENZIONE!!!! CREO IL NACK VLAN ASSOCIO CASE');
                    sl.Caso__c=OF_PP_GE_Utils.caseOriginale.Id;
                 }
                return sl;
            }
        }       
        return null;
    } 
    
    //Completion Order solo ritorno senza inserirli a sistema (per callout sincrone)
    //Commento PG 31-08
    /*
    public static List<EOF_EAI_Service_Log__C> OM_CreateCompletionOrder_Log(case c,object o){          
        
        //CRM 05/06/2017 modificata la query. Ora viene usato il DeveloperName al posto del Name
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        List<recordtype> rtList=[select Id,developerName from recordtype];
        OF_PP_GE_Utils.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_PP_GE_Utils.rtMap.put(rt.developerName, rt.Id); 
        }
        OF_PP_GE_Utils.checkrtMap=true;
        //END CRM 05/06/2017
        if(o instanceof OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder){
            
            OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder a = (OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder) o;         
            OF_PP_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c(
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
            if(OF_PP_GE_Utils.checkCaseOriginale){
                OF_PP_GE_Utils.slSFOLO.caso__c=OF_PP_GE_Utils.CaseOriginale.Id;
            }

            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_PP_GE_Utils.slSFOLO.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_PP_GE_Utils.slSFOLO.EOF_Note__c = a.NOTE;
            }
            // finisce qui
            
            sLogList.add(OF_PP_GE_Utils.slSFOLO);
            Integer n = 1;
            if(a.apparato!=null && !a.apparato.isEmpty()){
                OF_PP_GE_Utils.checkApp=true;
                OF_PP_GE_Utils.ListApp= new List<EOF_EAI_Service_Log__C>();
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
                    OF_PP_GE_Utils.ListApp.add(sLog);
                    n++;
                }
            }
            if(a.servizio_Aggiuntivo!=null && !a.servizio_Aggiuntivo.isEmpty()){
                OF_PP_GE_Utils.checkServAgg=true;
                OF_PP_GE_Utils.ListServAgg= new List<EOF_EAI_Service_Log__C>();
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
                    OF_PP_GE_Utils.ListServAgg.add(sLog);
                    n++;
                } 
            } 
            return sLogList;       
        }
        return null;
    }
    */
    
    //notifiche di acquisizione OK/KO e cessazione KO
    //Commento PG 31-08
    /*
    public static EOF_EAI_Service_Log__C CreateAcquisition_Log(case c){
        if(!OF_PP_GE_Utils.checkrtMap){
            List<recordtype> rtList=[select Id,developerName from recordtype];
            OF_PP_GE_Utils.rtMap = new Map<String,Id>(); 
            for(recordtype rt :rtList){
                OF_PP_GE_Utils.rtMap.put(rt.DeveloperName, rt.Id); 
            }               
            OF_PP_GE_Utils.checkrtMap=true;
        }    
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
            RecordTypeId = OF_PP_GE_Utils.rtMap.get('OF_SA_FiberNotify'),
            EOF_Tipo_COmunicazione_String__c='SF->OLO - StatusUpdate',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate',
            EOF_CODICE_OPERATORE__c=c.EOF_Codice_Operatore_WS__c, 
            EOF_CODICE_ORDINE_OLO__c=c.EOF_CODICE_ORDINE_OLO__c,
            EOF_CODICE_ORDINE_EOF__c=c.Id,
            EOF_DATA_NOTIFICA__c=system.now(),
            EOF_ID_NOTIFICA__c=String.valueOf(system.now().getTime())
        );
        if(c.recordtype.developername=='OF_SA_Attivazione'){
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
        sl.EOF_Tipo_Comunicazione__c = '5';
        sl.caso__c=c.Id;
        sl.EOF_Richiesta_Notifica__c = copy_notify_AcqCess(sl);
        return sl;
    }
    */
    
    //Commento PG - 31-08
    /*
    //Status Update solo ritorno senza inserirli a sistema (per callout sincrone)
    public static List<EOF_EAI_Service_Log__C> OM_CreateStatusUpdate_Log(case c, object o){
        
        //CRM 05/06/2017 modificata la query. Ora viene usato il DeveloperName al posto del Name
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        if(!OF_PP_GE_Utils.checkrtMap){
            List<recordtype> rtList=[select Id,developerName from recordtype];
            OF_PP_GE_Utils.rtMap = new Map<String,Id>(); 
            for(recordtype rt :rtList){
                OF_PP_GE_Utils.rtMap.put(rt.DeveloperName, rt.Id); 
            }               
            OF_PP_GE_Utils.checkrtMap=true;
        }    

        //END CRM 05/06/2017
        //caso in cui mi arriva effettivamente da OM
        if(o instanceof OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate){
            OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate a = (OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate) o;         
            OF_PP_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_PP_GE_Utils.rtMap.get('OF_SA_FiberNotify'),
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
            OF_PP_GE_Utils.slSFOLO.caso__c=c.Id;
            
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                OF_PP_GE_Utils.slSFOLO.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                OF_PP_GE_Utils.slSFOLO.EOF_Note__c = a.NOTE;
            }
            // finisce qui
                                    
            sLogList.add(OF_PP_GE_Utils.slSFOLO);
            Integer n = 1;
            if(a.VLAN!=null && !a.VLAN.isEmpty()){ 
                OF_PP_GE_Utils.checkVlan=true;
                OF_PP_GE_Utils.ListVlan= new List<EOF_EAI_Service_Log__C>();
                for(OF_SA_WS_IN_OM_StatusUpdate.VLan v : a.VLan){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.EOF_Tipo_COmunicazione_String__c='VLAN';
                    sLog.recordtypeid=OF_PP_GE_Utils.rtMap.get('OF_SA_Vlan');
                    sLog.OF_SA_USER_VLAN__C=v.USER_VLAN;
                    sLog.OF_SA_SERVICE_VLAN__C=v.SERVICE_VLAN;
                    sLog.OF_SA_CUSTOMER_VLAN__C=v.CUSTOMER_VLAN;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    OF_PP_GE_Utils.ListVlan.add(sLog);
                    n++;
                }
            }
            if(a.apparato!=null && !a.apparato.isEmpty()){
                OF_PP_GE_Utils.checkApp=true;
                OF_PP_GE_Utils.ListApp= new List<EOF_EAI_Service_Log__C>();
                for(OF_SA_WS_IN_OM_StatusUpdate.apparato app : a.apparato){
                    EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                    sLog.EOF_Tipo_COmunicazione_String__c='CPE';
                    sLog.recordtypeid=OF_PP_GE_Utils.rtMap.get('OF_SA_Cpe');
                    sLog.EOF_TIPOLOGIA_APPARATO__C=app.TIPOLOGIA_APPARATO;
                    sLog.OF_SA_ESITO_RITIRO_APPARATO__C=app.ESITO_RITIRO_APPARATO;
                    sLog.OF_SA_CODICE_MOTIVAZIONE_RITIRO__C=app.CODICE_MOTIVAZIONE_RITIRO;
                    sLog.OF_SA_MOTIVAZIONE_RITIRO__C=app.MOTIVAZIONE_RITIRO;
                    sLog.EOF_Ordine_Invio_OLO__c=n;
                    sLogList.add(sLog);
                    OF_PP_GE_Utils.ListApp.add(sLog);
                    n++;
                }
            }
            return sLogList;   
        } 
        return null;
    }    
    */
    
    //Commento PG 31-08
    /*
    public static EOF_EAI_Service_Log__C OM_CreateReschedule_Log(case c, object o){
        
        //faccio il check per vedere se la mappa dei recordtype è popolata
        if(!OF_PP_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_PP_GE_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_PP_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_PP_GE_Utils.checkRTMap=true;
       }
        //OM Reschedule
        if(o instanceof OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule){
            OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule a = (OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_PP_GE_Utils.rtMap.get('OF_SA_FiberNotify'),
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
            if(OF_PP_GE_Utils.checkCaseOriginale){
                sl.caso__c=OF_PP_GE_Utils.CaseOriginale.Id;
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
    */
    
    //OK
    //PG - DEV - Richiamato nel metodo SVLAN_AsyncActivation della classe OF_PP_OLO_AsyncChecks
    public static List<EOF_EAI_Service_Log__c> create_ActivationToOM_Log(Case c2, List<EOF_EAI_Service_Log__c> ListSlOrig){
        
        String id_log_vlan = '';
        List<EOF_EAI_Service_Log__c> listToOM = new List<EOF_EAI_Service_Log__c>();
        
        //OF_PP_GE_Utils.ListVLanToOM = new List<EOF_EAI_Service_Log__c>();
        OF_PP_GE_Utils.ListCOSToOM = new List<EOF_EAI_Service_Log__c>();
        
        for(EOF_EAI_Service_Log__c sl : ListSlOrig)
        {
            System.debug('WWW****sl****(OF_PP_GE_Utils) :WWW'+sl);
            
            if(sl.recordtype.developername=='OF_PP_VLAN_ActivationRequest')
            {
                OF_PP_GE_Utils.checkVLanToOM = true;
                OF_PP_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c(
                    RecordTypeId = sl.recordtypeId,
                    EOF_Tipo_COmunicazione_String__c='SF->OM - VLAN_ActivationRequest',
                    OF_SA_Direzione_Flusso__c='SF-OM',
                    OF_SA_Metodo__c = 'OLO_ActivationSetup_VLAN',
                    EOF_Sorgente__c = 'OGW',
                    //EOF_Tracciato__c = '2',
                    EOF_CODICE_OPERATORE__C = sl.EOF_CODICE_OPERATORE__c,
                    POP__c = sl.POP__c, //Pop di consegna (KIT)
                    PO_PP_POP_raccolta__c = sl.PO_PP_POP_raccolta__c,
                    Banda_Interfaccia__c = sl.Banda_Interfaccia__c,
                    PO_PP_Interfaccia__c = sl.PO_PP_Interfaccia__c,
                    SVLAN__c = sl.SVLAN__c,
                    PO_PP_cos_remarking__c = sl.PO_PP_cos_remarking__c,
                    PO_PP_dhcp_Option82__c = sl.PO_PP_dhcp_Option82__c,
                    PO_PP_cos_type__c = sl.PO_PP_cos_type__c,
                    PO_PP_cos_class__c = sl.PO_PP_cos_class__c,
                    Nome_del_KIT__c  = sl.Nome_del_KIT__c,
                    PO_PP_Progressivo_Ordine__c = sl.PO_PP_Progressivo_Ordine__c,
                    PO_PP_User_VLAN__c = sl.PO_PP_User_VLAN__c,
                    PO_PP_ID_Richiesta_testo__c = sl.Caso__r.PO_PP_ID_Richiesta__c,
                    //EOF_CODICE_ORDINE_OLO__C = sl.EOF_CODICE_ORDINE_OLO__c,
                    EOF_DATA_NOTIFICA__C = sl.EOF_data_NOTIFICA__c, 
                    EOF_ID_NOTIFICA__C = sl.EOF_ID_NOTIFICA__c,
                    EOF_Id_servizio__c = c2.OF_SA_ID_Servizio__c,
                    EOF_NOTE__C = sl.EOF_NOTE__C,
                    EOF_PROFILO__C = sl.EOF_PROFILO__C,
                    EOF_CODICE_MOTIVAZIONE__c = c2.OF_SA_CODICE_MOTIVAZIONE__c,
                    EOF_MOTIVAZIONE__c = c2.OF_SA_MOTIVAZIONE__c,
                    Caso__c = c2.Id
                );
                System.debug('ççççç__slSFOM__çççç: '+slSFOM);
                
                //Da verificare
                if(c2.status=='Accettato')
                {
                    OF_PP_GE_Utils.slSFOM.EOF_Tipo_Comunicazione__c='1';
                    OF_PP_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '0';
                }
                else
                {
                    OF_PP_GE_Utils.slSFOM.EOF_Tipo_Comunicazione__c='99';
                    OF_PP_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '1';
                } 
                listToOM.add(OF_PP_GE_Utils.slSFOM);
            }
            Integer n = 1;
            id_log_vlan = OF_PP_GE_Utils.slSFOM.id;
            
            if(sl.recordtype.developername=='OF_PP_COS')
            { 
                OF_PP_GE_Utils.checkCosToOM = true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid = sl.recordtypeId;
                sLog.PO_PP_cos_type__c = sl.PO_PP_cos_type__c;
                sLog.PO_PP_cos_class__c = sl.PO_PP_cos_class__c;
                sLog.PO_PP_ID_Vlan__c = id_log_vlan; //??? da verificare
                //sLog.OF_SA_VLan_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c = n;
                OF_PP_GE_Utils.ListCOSToOM.add(sLog); 
                listToOM.add(sLog);
                n++;
            }

        }//chiudo il for
        System.debug('****listToOM****:'+listToOM);
        System.debug('****listToOM.size****:'+listToOM.size());
        return listToOM;
    } 
    
    //Commento 31-08
    /*
    public static List<EOF_EAI_Service_Log__c> create_DeactivationToOM_Log(Case c2, List<EOF_EAI_Service_Log__c> ListSlOrig,Asset a){
        List<EOF_EAI_Service_Log__c> listToOM = new List<EOF_EAI_Service_Log__c>();
        OF_PP_GE_Utils.ListAppToOM=new List<EOF_EAI_Service_Log__c>();
        system.debug('Alessandro: la list è: '+ListSlOrig);
        for(EOF_EAI_Service_Log__c sl : ListSlOrig){
            if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                
                OF_PP_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c(
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
                OF_PP_GE_Utils.slSFOM.EOF_Tipo_COmunicazione__c='2';
                OF_PP_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '0';
                OF_PP_GE_Utils.slSFOM.EOF_GPON_Attestazione__c=a.OF_GPON_Attestazione__c;
                OF_PP_GE_Utils.slSFOM.EOF_ID_SERVIZIO__c = a.OF_IDServizio__c;
                //OF_PP_GE_Utils.slSFOM.EOF_PROFILO__c = a.PROFILO;
                OF_PP_GE_Utils.slSFOM.EOF_Provincia__c = a.OF_Provincia__c;
                OF_PP_GE_Utils.slSFOM.EOF_Comune__c= a.OF_Comune__c;
                OF_PP_GE_Utils.slSFOM.EOF_Particella_Toponomastica__c = a.OF_Particella_Toponomastica__c;
                OF_PP_GE_Utils.slSFOM.EOF_Indirizzo__c = a.OF_Indirizzo__c;
                OF_PP_GE_Utils.slSFOM.EOF_Numero_Civico__c = a.OF_Civico__c;
            }
            else{
                OF_PP_GE_Utils.slSFOM.EOF_Tipo_COmunicazione__c='98';
                OF_PP_GE_Utils.slSFOM.EOF_Stato_Ordine__c= '1';
            } 
            listToOM.add(OF_PP_GE_Utils.slSFOM);
            }
            Integer n = 1;
            if(sl.recordtype.developername=='OF_SA_Cpe'){ 
                OF_PP_GE_Utils.checkAppToOM=true;
                EOF_EAI_Service_Log__C sLog = new EOF_EAI_Service_Log__C();
                sLog.recordtypeid=sl.recordtypeId;
                sLog.EOF_TIPOLOGIA_APPARATO__C=sl.EOF_TIPOLOGIA_APPARATO__C;
                sLog.OF_SA_ID_APPARATO__C=sl.OF_SA_ID_APPARATO__C;
                //sLog.OF_SA_Cpe_Log__c=sl.id;
                sLog.EOF_Ordine_Invio_OLO__c=n;
                OF_PP_GE_Utils.ListappToOM.add(sLog);
                listToOM.add(sLog);
                n++;
            }           
        }
        return listToOM;
    } 
    */ 
     
    public static EOF_EAI_Service_Log__C OLO_CreateStatusUpdate_LogVLAN(Case c, object o){
         
        system.debug('@@@@@@@@@@@@@@@@@ >>>>>> OLO_CreateStatusUpdate_LogVLAN : ENTRATO');
        List<recordtype> rtList=[select Id,developerName from recordtype where developerName='OF_SA_Attivazione' or developerName = 'Cliente_Business'
                                 or developerName = 'PersonAccount' or developerName='Referente_Tecnico_OLO' or developerName='Servizi_Aggiuntivi' 
                                 or developerName='OF_CPE' or developerName='OF_VLAN' or developerName='OLO' or developerName='OF_SA_FiberRequest'or developerName='OF_SA_Servizi_Aggiuntivi'
                                 or developerName='OF_PP_NACK' or developerName='OF_PP_ACK' or developerName='OF_PP_VLAN_ActivationRequest'
                                 or developerName='OF_SA_FiberNotify' or developerName='OF_SA_Cpe'or developerName='OF_SA_Vlan' or developerName='OF_SA_ACK' or developerName='OF_SA_NACK'];
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }
        System.debug('*****Object O:****:'+o);
        System.debug('@@@@@@@@@@@@@@@@@ >>>>>> OLO_CreateStatusUpdate_LogVLAN : instanceof idRecordtype: ' + rtMap.get('OF_PP_VLAN_ActivationRequest'));
        if(o instanceof OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN){
           
           System.debug('#****Dentro o instanceof OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN*****#');
           
           OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN sur = (OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = rtMap.get('OF_PP_VLAN_ActivationRequest'),
                EOF_Tipo_Comunicazione_String__c='OM->SF - StatusUpdateRequestVlan',
                OF_SA_Direzione_Flusso__c='OM-SF',
                OF_SA_Metodo__c='StatusUpdateRequestVlan',
                EOF_CODICE_OPERATORE__C=sur.CODICE_OPERATORE,   
                SVLAN__c = sur.SERVICE_VLAN_ID,
                PO_PP_User_VLAN__c = sur.USER_VLAN,
                EOF_NOTE__c = sur.NOTE,
                Codice_Ordine_so__c = sur.CODICE_ORDINE_SO,
                Codice_Ordine_sfdc__c = sur.CODICE_ORDINE_SFDC,
                //EOF_CODICE_ORDINE_OLO__C=sur.CODICE_ORDINE_OLO,
                //EOF_Codice_Ordine_EOF__c=sur.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__C=StringTODate(sur.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__C=sur.ID_NOTIFICA,
                //OF_SA_AZIONE__C=sur.AZIONE,
                EOF_CODICE_MOTIVAZIONE__C=sur.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__C=sur.MOTIVAZIONE,
                EOF_Richiesta_Notifica__c = copy_request(sur)
            );
            //SYSTEM.debug('@@@@@@@@ sur.CODICE_ORDINE_OLO: ' + sur.CODICE_ORDINE_OLO);
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c 
                                FROM Case 
                                Where Codice_Ordine_so__c =: sur.CODICE_ORDINE_SO];
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
            //('OSCRM OF_PP_GE_Utils.OLO_CreateStatusUpdate_Log serviceLog sl:'+sl);
            return sl;        
        }
        return null;
    }   
    
    //OK
    public static EOF_EAI_Service_Log__C OLO_CreateStatusUpdate_Log(Case c, object o){
        List<recordtype> rtList=[select Id,developerName from recordtype where developerName='OF_SA_Attivazione' or developerName = 'Cliente_Business'
                                 or developerName = 'PersonAccount' or developerName='Referente_Tecnico_OLO' or developerName='Servizi_Aggiuntivi' 
                                 or developerName='OF_CPE' or developerName='OF_VLAN' or developerName='OLO' or developerName='OF_SA_FiberRequest'or developerName='OF_SA_Servizi_Aggiuntivi'
                                 or developerName='OF_PP_NACK' or developerName='OF_PP_ACK' or developerName='OF_PP_KIT_ActivationRequest'
                                 or developerName='OF_SA_FiberNotify' or developerName='OF_SA_Cpe'or developerName='OF_SA_Vlan' or developerName='OF_SA_ACK' or developerName='OF_SA_NACK'];
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }
        
        if(o instanceof OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest){
            //('OSCRM logMancante:--start--');
            OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur = (OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest) o;         
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = rtMap.get('OF_PP_KIT_ActivationRequest'),
                EOF_Tipo_COmunicazione_String__c='SF->OM - StatusUpdateRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_StatusUpdate',
                EOF_CODICE_OPERATORE__C=sur.CODICE_OPERATORE,
                EOF_CODICE_ORDINE_OLO__C=sur.CODICE_ORDINE_OLO,
                EOF_Codice_Ordine_EOF__c=sur.CODICE_ORDINE_OLO,
                EOF_DATA_NOTIFICA__C=StringTODate(sur.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__C=sur.ID_NOTIFICA,
                OF_SA_AZIONE__C=sur.AZIONE,
                EOF_CODICE_MOTIVAZIONE__C=sur.CODICE_MOTIVAZIONE,
                EOF_MOTIVAZIONE__C=sur.MOTIVAZIONE,
                EOF_DATA_PREVISTA_ATTIVAZIONE__C=StringTODateNoTime(sur.DATA_PREVISTA_ATTIVAZIONE),
                EOF_ORARIO_APPUNTAMENTO__C=sur.ORARIO_APPUNTAMENTO,
                EOF_Richiesta_Notifica__c = copy_request(sur)
            );
            SYSTEM.debug('@@@@@@@@ sur.CODICE_ORDINE_OLO: ' + sur.CODICE_ORDINE_OLO);
            List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  Codice_Ordine_EOF__c =: sur.CODICE_ORDINE_OLO];
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
            //('OSCRM OF_PP_GE_Utils.OLO_CreateStatusUpdate_Log serviceLog sl:'+sl);
            return sl;        
        }
        return null;
    }
    
    //Commento PG 31-08
    /*
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
                EOF_DATA_NOTIFICA__c=OF_PP_GE_Utils.StringToDate(r.DATA_NOTIFICA),
                EOF_ID_NOTIFICA__c=r.ID_NOTIFICA,
                EOF_DATA_PREVISTA_ATTIVAZIONE__c=OF_PP_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE),
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
    */
    
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
    
    public static Datetime stringToDateTime(String s){
        if(String.isBlank(s)){
            return null;
        }
        Datetime dt = Datetime.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)),integer.valueOf(s.left(13).right(2)),integer.valueOf(s.left(16).right(2)),integer.valueOf(s.left(25).right(2)));
        return dt;
    } 
    
    public static String DateTimeToString(Datetime dt){
        if(String.isBlank(String.valueOf(dt))){
            return null;
        }
        Integer offset = UserInfo.getTimeZone().getOffset(now())/3600000;
        String prefix = (offset >= 0) ? '+'  : '-';
        String a = prefix + ((Math.abs(offset) < 10) ? ('0'+ Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));
        String s = dt.format('yyyy-MM-dd\'T\'HH:mm:ss\''+a+'\'');
        return s;
    } 
    
    public static Datetime now(){
        Datetime dt=Datetime.newInstance(system.today(), system.now().Time());
        return dt;
    }
    
    /*
    public static String copy_notify_AcqCess(EOF_EAI_Service_Log__c sl){
        String s =  'CODICE_OPERATORE: ' + sl.EOF_Codice_Operatore__c + '\n' +            
                    'TIPO_COMUNICAZIONE: ' + sl.EOF_Tipo_Comunicazione__c + '\n' + 
                    'CODICE_ORDINE_OLO: ' + sl.EOF_Codice_Ordine_OLO__c + '\n' +
                    'CODICE_ORDINE_EOF: ' + sl.EOF_Codice_Ordine_EOF__c + '\n' +
                    'ID_NOTIFICA: ' + sl.EOF_ID_Notifica__c + '\n' +
                    'STATO_RICHIESTA: ' + sl.EOF_Stato_Richiesta__c + '\n' +
                    'CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO: ' + sl.EOF_Cod_Rifiuto_Sospensione_Annullamento__c + '\n' + 
                    'MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO: ' + sl.EOF_Mot_Rifiuto_Sospensione_Annullamento__c + '\n' +         
                    'DATA_NOTIFICA: ' + OF_PP_GE_Utils.DateToString(sl.EOF_Data_Notifica__c) + '\n';
        return s;
    }
    */
    //OK
    public static String copy_request(object o){
        String s;
        String data_prevista_attivazione='';
        //attivazione pre SF
        
        if (o instanceOf OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateRequestVLAN_PP){
            OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateRequestVLAN_PP a = (OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateRequestVLAN_PP) o;
             
            system.debug('@@@@@@@@@@@@@@@ ##################>>>>>>>>>>>> Dentro CopyRequest OLO_StatusUpdateRequestVLAN_PP');
            s = 'CODICE_OPERATORE: '+ a.CODICE_OPERATORE + '\n' +
                'DATA_NOTIFICA: '+ a.DATA_NOTIFICA + '\n' +
                'ID_NOTIFICA: '+ a.ID_NOTIFICA;
        }
        
        if(o instanceOf OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest){
            OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest a = (OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest) o;
            
            s=  'CODICE_OPERATORE: '+ a.CODICE_OPERATORE + '\n' +
                 //'CODICE_ORDINE_OLO: '+ a.CODICE_ORDINE_OLO + '\n' +
                'DATA_NOTIFICA: '+ a.DATA_NOTIFICA + '\n' +
                'ID_NOTIFICA: '+ a.DATA_NOTIFICA + '\n' +
                'PROFILO: '+ a.PROFILO + '\n' +
                'CODICE_OPERATORE: '+ a.CODICE_OPERATORE + '\n' +
                'CODICE_ORDINE_SO: '+ a.CODICE_ORDINE_SO + '\n' +
                'IDENTIFICATIVO_DEL_POP: '+ a.IDENTIFICATIVO_DEL_POP + '\n' +
                'BANDA: '+ a.BANDA + '\n' +
                'TRAFFICO: '+ a.TRAFFICO + '\n' +
                'INTERFACCIA: '+ a.INTERFACCIA + '\n' +
                'STATO_ORDINE: '+ a.STATO_ORDINE + '\n' +
                'NOTE : '+a.NOTE+ '\n';
        }
        
        //PG - copy_request VLAN_PP
        if(o instanceOf OF_PP_WS_IN_OLO_Activation.VLAN_PP)
        {
            OF_PP_WS_IN_OLO_Activation.VLAN_PP a = (OF_PP_WS_IN_OLO_Activation.VLAN_PP) o;
            system.debug('@@@@@@@@@@@@@@@ ##################>>>>>>>>>>>> Dentro CopyRequest OF_PP_WS_IN_OLO_Activation.VLAN_PP');
            
            s = 'CODICE_OPERATORE: '+ a.CODICE_OPERATORE + '\n' +
                'DATA_NOTIFICA: '+ a.DATA_NOTIFICA + '\n' +
                'ID_NOTIFICA: '+ a.ID_NOTIFICA + '\n' +
                'ID_RICHIESTA: '+ a.ID_RICHIESTA + '\n' +
                'CODICE_ORDINE_SO: '+ a.CODICE_ORDINE_SO + '\n' +
                'CODICE_ORDINE_SFDC: '+ a.CODICE_ORDINE_SFDC + '\n' +
                'POP DI RACCOLTA: '+ a.POP + '\n' +
                'BANDA: '+ a.BANDA_INTERFACCIA + '\n' +
                'INTERFACCIA: '+ a.INTERFACCIA + '\n' +
                'POP DI CONSEGNA: '+ a.POP_KIT + '\n' +
                'COS_REMARKING: '+ a.COS_REMARKING + '\n' +
                'DHCP_OPTION82: '+ a.DHCP_OPTION82 + '\n' +
                'COS_TYPE: '+ a.COS_TYPE + '\n' +
                'COS_CLASS: '+ a.COS_CLASS + '\n' +
                'PROGRESSIVO_ORDINE: '+ a.PROGRESSIVO_ORDINE + '\n' +
                'STATO_ORDINE: '+ a.STATO_ORDINE + '\n' +
                'NOTE : '+a.NOTE+ '\n';
        }
        
        if (o instanceOf OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN)
        {
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN a = (OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN) o;
             
            system.debug('@@@@@@@@@@@@@@@ ##################>>>>>>>>>>>> Dentro CopyRequest OM_StatusUpdateRequestVLAN');
            s = 'CODICE_OPERATORE: '+ a.CODICE_OPERATORE + '\n' +
                'DATA_NOTIFICA: '+ a.DATA_NOTIFICA + '\n' +
                'ID_NOTIFICA: '+ a.ID_NOTIFICA + '\n' +
                'CODICE_ORDINE_SFDC: '+ a.CODICE_ORDINE_SFDC + '\n' +
                'CODICE_ORDINE_SO: '+ a.CODICE_ORDINE_SO + '\n' +
                'STATO_ORDINE: '+a.STATO_ORDINE + '\n' +
                'CODICE_MOTIVAZIONE: '+a.CODICE_MOTIVAZIONE + '\n' +
                'MOTIVAZIONE: '+a.MOTIVAZIONE + '\n' +
                'SERVICE_VLAN_ID: '+a.SERVICE_VLAN_ID + '\n' +
                'USER_VLAN : '+a.USER_VLAN + '\n' +
                'SERVIZI_UTENTE : '+a.SERVIZI_UTENTE + '\n' +
                'NOTE : '+a.NOTE+ '\n';
        }
        return s; 
    }
    
    //Commento PG 31-08
    /*
    //metodo che gestisce l'aggiornamento dei dati in caso di NACK da OLO su Acquisito OK/KO e Cessato KO
    public static void aggiornamentoDatiAcquisizione(Case c){
        list<Case> caseToUpdate = new list<Case>();
        //valido sia per cessazione che attivazione
        if( OF_PP_GE_Utils.checkCliente){
            //Inserisco il cliente
            insert  OF_PP_GE_Utils.cliente;
            //Aggiungo il cliente al case
             OF_PP_GE_Utils.caseOriginale.AccountId =  OF_PP_GE_Utils.cliente.Id;
        }
        system.debug('Marco - il cliente inserito è :'+ OF_PP_GE_Utils.cliente);
        system.debug('Marco - Il cliente aggiunto al case è:' +OF_PP_GE_Utils.caseOriginale);
        if(OF_PP_GE_Utils.checkCEIList){
            insert OF_PP_GE_Utils.CEIList;
        }

        Insert  OF_PP_GE_Utils.slSFOLO;
        
        //metto la reference alla notifica, la reference al slPrincipale e inserisco la response
        OF_PP_GE_Utils.slSFOLOresp.EOF_SL_Riferimento__c= OF_PP_GE_Utils.slSFOLO.Id;
        Insert slSFOLOresp;

        if( OF_PP_GE_Utils.checkRefTec){
            //inserisco il referente tecnico e metto il riferimento sul case
            insert  OF_PP_GE_Utils.refTec;
             OF_PP_GE_Utils.caseOriginale.EOF_Contact__c =  OF_PP_GE_Utils.refTec.Id;
        }
    
        OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
        String s=mofc.ManageOrder( OF_PP_GE_Utils.caseOriginale);
        if(!String.isBlank(s)){
             OF_PP_GE_Utils.caseOriginale.OF_Order__c=s;
        }
        //aggiungo gli eventuali case di amministratori da aggiornare
        if(OF_PP_GE_Utils.checkCaseAmm){
            caseToUpdate.addAll(OF_PP_GE_Utils.ListCaseAmmToUpdate);    
        }
        
        if(OF_PP_GE_Utils.gen!=null){
            try{
                delete OF_PP_GE_Utils.gen;
            }
            catch(exception e){
                system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ exception è: '+e); 
                TEMPLOG__c t = new TEMPLOG__c();
                t.Name=OF_PP_GE_Utils.caseOriginale.EOF_Codice_Ordine_OLO__c;
                t.DataInserimento__c=string.valueof(system.now().format('YYYY-MM-dd HH:mm:ss'));
                t.Desc__c=String.valueOf(e);
                t.Class__c='OF_PP_GE_Utils';
                insert t;
            }
        }
        
        //in caso di cessazione KO è  sufficiente la seguente
        caseToUpdate.add( OF_PP_GE_Utils.caseOriginale);
        update caseToUpdate;
    }
    */
    
    //Commento PG - 31-08 
    /*
    public static void aggiornamentoDatiAttivazioneCessazioneToOM(String processo, String tipo_comunicazione, String esito){
        list<Case> caseToUpdate = new list<Case>();
        list<EOF_EAI_Service_Log__c> slListPrincipaliToInsert = new list<EOF_EAI_Service_Log__c>();
        list<EOF_EAI_Service_Log__c> slListResponseAndElementToInsert = new list<EOF_EAI_Service_Log__c>();
        //valido sia per cessazione che attivazione
        if(OF_PP_GE_Utils.checkCliente){
            //Inserisco il cliente
            insert OF_PP_GE_Utils.cliente;
            //Aggiungo il cliente al case
            OF_PP_GE_Utils.caseOriginale.AccountId = OF_PP_GE_Utils.cliente.Id;
        }
        system.debug('Marco - il cliente inserito è :'+ OF_PP_GE_Utils.cliente);
        system.debug('Marco - Il cliente aggiunto al case è:' +OF_PP_GE_Utils.caseOriginale.AccountId);

        if(OF_PP_GE_Utils.checkRefTec){
            //inserisco il referente tecnico e metto il riferimento sul case
            insert OF_PP_GE_Utils.refTec;
            OF_PP_GE_Utils.caseOriginale.EOF_Contact__c = OF_PP_GE_Utils.refTec.Id;
        }
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@ il check CEI è: '+OF_PP_GE_Utils.checkCEIList);
        if(OF_PP_GE_Utils.checkCEIList){ 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@ la lista di CEI è: '+OF_PP_GE_Utils.CEIList);
            insert OF_PP_GE_Utils.CEIList;
        }
        //casi di attivazione OK/KO e cessazione KO
        if(processo=='Create' || (processo=='Delete' && tipo_comunicazione=='98')){

            slListPrincipaliToInsert.add(OF_PP_GE_Utils.slSFOLO);
            slListPrincipaliToInsert.add(OF_PP_GE_Utils.slSFOM);
            Insert slListPrincipaliToInsert;
            
            OF_PP_GE_Utils.slSFOLOresp.EOF_SL_Riferimento__c=OF_PP_GE_Utils.slSFOLO.Id;
            OF_PP_GE_Utils.slSFOMResp.EOF_SL_Riferimento__c=OF_PP_GE_Utils.slSFOM.Id;
            slListResponseAndElementToInsert.add(OF_PP_GE_Utils.slSFOMResp);
            slListResponseAndElementToInsert.add(OF_PP_GE_Utils.slSFOLOresp);
            if(OF_PP_GE_Utils.checkVLan){
                for(EOF_EAI_Service_Log__c sl : OF_PP_GE_Utils.listVlanToOM){
                    sl.OF_SA_VLan_Log__c=OF_PP_GE_Utils.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            if(OF_PP_GE_Utils.checkApp){
                for(EOF_EAI_Service_Log__c sl : OF_PP_GE_Utils.listAppToOM){
                    sl.OF_SA_Cpe_Log__c=OF_PP_GE_Utils.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            if(OF_PP_GE_Utils.checkServAgg){
                for(EOF_EAI_Service_Log__c sl : OF_PP_GE_Utils.listServAggToOM){
                    sl.OF_SA_servizi_Aggiuntivi_Log__c=OF_PP_GE_Utils.slSFOM.Id;
                    slListResponseAndElementToInsert.add(sl);
                }
            }
            Insert slListResponseAndElementToInsert;
        }

        if(processo=='Delete' && tipo_comunicazione=='2'){
            //inserisco il log principale
            insert OF_PP_GE_Utils.slSFOM;
            //inserisco il riferimento sul log di response e poi la response
            OF_PP_GE_Utils.slSFOMResp.EOF_SL_Riferimento__c=OF_PP_GE_Utils.slSFOM.Id;
            Insert OF_PP_GE_Utils.slSFOMResp;
            
        }
        
        OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
        String s=mofc.ManageOrder(OF_PP_GE_Utils.caseOriginale);
        if(!String.isBlank(s)){
            OF_PP_GE_Utils.caseOriginale.OF_Order__c=s;
        } 
        //aggiungo gli eventuali case di amministratori da aggiornare
        if(OF_PP_GE_Utils.checkCaseAmm){
            caseToUpdate.addAll(OF_PP_GE_Utils.ListCaseAmmToUpdate);    
        }
        if(OF_PP_GE_Utils.caseOriginale.PO_SA_Portale__c){
            OF_PP_GE_Utils.ListSlStatusUpdateSFOLO=new List<EOF_EAI_Service_Log__c>();
            OF_PP_GE_Utils.ListSlStatusUpdateSFOLO.add(OF_PP_GE_Utils.slSFOLO);
            //OF_PP_GE_Utils.aggiornaSLPortale(OF_PP_GE_Utils.ListSlStatusUpdateSFOLO, 'OM_StatusUpdate');
        }
        
        //cancello il record di generatore id servizio dal db
        if(OF_PP_GE_Utils.gen!=null){
            try{
                delete OF_PP_GE_Utils.gen;
            }
            catch(exception e){
                system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ exception è: '+e); 
                TEMPLOG__c t = new TEMPLOG__c();
                t.Name=OF_PP_GE_Utils.caseOriginale.EOF_Codice_Ordine_OLO__c;
                t.DataInserimento__c=string.valueof(system.now().format('YYYY-MM-dd HH:mm:ss'));
                t.Desc__c=String.valueOf(e);
                t.Class__c='OF_PP_GE_Utils';
                insert t;
            }
        }
        //in caso di cessazione KO è  sufficiente la seguente
        caseToUpdate.add(OF_PP_GE_Utils.caseOriginale);
        update caseToUpdate;
    } 
    */
    
    /*Commento PG - 31-08
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
        OF_PP_GE_Utils.slSFOLO=[select Id,EOF_Tipo_comunicazione__c,EOF_Data_espletamento_ordine__c,EOF_Data_Notifica__c from EOF_EAI_Service_Log__c where id=:slSFOLOId];
        OF_PP_GE_Utils.slSFOLOResp=[select Id,EOF_Tipo_comunicazione__c,EOF_Data_espletamento_ordine__c,EOF_Data_Notifica__c,lastModifiedDate from EOF_EAI_Service_Log__c where id=:slSFOLORespId];
        OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
        c.AssetId=mofc.ManageOrder(c);
        update c;
    }
    */
    public static void makeCalloutOLOOM(EOF_EAI_Service_Log__C slTOOLO){
        
        system.debug('%%%%%%%%%%%%%%%%%%%%%%% makeCalloutOLOOM: DENTRO'  );
        //prima di chiamare la callout faccio il check amministratori solo per attivazione
        if(slTOOLO.EOF_Tipo_comunicazione__c=='5'){
            //OF_PP_GE_Utils.checkAmministratori(OF_PP_GE_Utils.caseOriginale);
        }
        //poi chiamo l'OLO
        system.debug('%%%%%%%%%%%%%%%%%%%%%%% makeCalloutOLOOM: chiamo OLO'  );
        
        /*Commento PG - 31-08
        OF_SA_WS_OLO_Response.Esito_element resp = OF_PP_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(OF_PP_GE_Utils.slSFOLO);
        system.debug('%%%%%%%%%%%%%%%%%%%%%%% makeCalloutOLOOM: resp.esito :'+resp.esito);
        system.debug('@@@@@_slTOOLO.EOF_Tipo_comunicazione__c: '+slTOOLO.EOF_Tipo_comunicazione__c);
        if(resp.esito=='0'){
            //chiamo OM
            if(slTOOLO.EOF_Tipo_comunicazione__c=='5'){
                system.debug(']]]__Ramo IF - Prima di create_ActivationToOM_Log__]]]');
                OF_PP_GE_Utils.ListSlActivationSFOM=OF_PP_GE_Utils.create_ActivationToOM_Log(OF_PP_GE_Utils.caseOriginale,OF_PP_GE_Utils.ListSlActivationOLOSF);
                system.debug(']]]__Ramo IF - Prima di OM_CreateAckNackRequestActivation__]]]');
                OF_PP_OLO_SendToOM.OM_CreateAckNackRequestActivation(OF_PP_GE_Utils.ListSlActivationSFOM);
                system.debug(']]]__Ramo IF - Prima di OM_CreateAckNackRequestActivation__]]]');
                OF_PP_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Create',null,null);
            }
            else{
                system.debug('%%%%%%%%%%%%%%%%%%%%%%% makeCalloutOLOOM - Sono nel ramo else');
                OF_PP_GE_Utils.ListSlDeactivationSFOM=OF_PP_GE_Utils.create_DeactivationToOM_Log(OF_PP_GE_Utils.caseOriginale,OF_PP_GE_Utils.ListSlDeactivationOLOSF,OF_PP_GE_Utils.a);
                OF_PP_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(OF_PP_GE_Utils.ListSlDeactivationSFOM);
                OF_PP_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Delete',OF_PP_GE_Utils.slSFOM.EOF_Tipo_Comunicazione__c,null);
            }
        }
        else{
            //aggiorno tutto
            OF_PP_GE_Utils.aggiornamentoDatiAcquisizione(OF_PP_GE_Utils.caseOriginale);
        }
        */
    }
    
    //cessazione OK
    //Commento PG - 31-08
    /*
    public static void makeCalloutOM(List<EOF_EAI_Service_Log__C> ListSlTOOM){
        OF_PP_GE_Utils.ListSlDeactivationSFOM=OF_PP_GE_Utils.create_DeactivationToOM_Log(OF_PP_GE_Utils.caseOriginale,OF_PP_GE_Utils.ListSlDeactivationOLOSF,OF_PP_GE_Utils.a);
        OF_PP_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(OF_PP_GE_Utils.ListSlDeactivationSFOM);
        OF_PP_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Delete',OF_PP_GE_Utils.slSFOM.EOF_Tipo_Comunicazione__c,null);
    }
    */
    
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
        if(!OF_PP_GE_Utils.checkDate(s.left(10))){      
            return false;           
        }
        if(!OF_PP_GE_Utils.checkTime(s.left(19).right(8))){         
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
    
    //Commento PG 31-08
    /*
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
    */
    
    //Commento PG 31-08
    /*
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
            OF_PP_GE_Utils.checkCaseAmm=true;
            OF_PP_GE_Utils.ListCaseAmmToUpdate = new List<Case>();
            for(case cAmm : caseAmm){
                cAmm.CA_Codice_Ordine_in_Corso__c= OF_PP_GE_Utils.caseOriginale.EOF_Codice_Ordine_OLO__c;
                cAmm.CA_Stato_Ordine_in_Corso__c= OF_PP_GE_Utils.caseOriginale.status;
                cAmm.CA_Numero_Ordini_in_Corso__c=cAmm.CA_Numero_Ordini_in_Corso__c+1;
                OF_PP_GE_Utils.ListCaseAmmToUpdate.add(cAmm);
            }
            return;
        }
        catch(exception e){
            system.debug('L exception è: '+e);
        }
        return;
    }
    */
    
    // 15/06/2018 MM : aggiunto metodo per creazione templog
    public static void CreateTemplogOLO(Object o){
        try{
            
            if(o instanceof OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest){

                OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest act = (OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest) o;
 
                // 8/06/2018 MM : Aggiunta creazione Templog per cattura timestamp attivazione
                OF_PP_GE_Utils.tmpl = new TEMPLOG__c();
                OF_PP_GE_Utils.tmpl.Name= act.CODICE_ORDINE_OLO +' - '+'Attivazione da OLO'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_PP_GE_Utils.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_PP_GE_Utils.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ act.codice_ordine_olo;
                OF_PP_GE_Utils.tmpl.Type__c ='T';
                OF_PP_GE_Utils.tmpl.TL_codice_ordine_olo__c = act.CODICE_ORDINE_OLO;
                //OF_PP_GE_Utils.tmpl.Tipo_Comunicazione__c = '';
                OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OLO_Attivazione';
                OF_PP_GE_Utils.tmpl.Timestamp__c = string.valueof(system.now().format('YYYY-MM-dd HH:mm:ss'));

            } 
            //TempLog VLAN_PP 
            
            if(o instanceof OF_PP_WS_IN_OLO_Activation.VLAN_PP){

                OF_PP_WS_IN_OLO_Activation.VLAN_PP act = (OF_PP_WS_IN_OLO_Activation.VLAN_PP) o;
 
                // 8/06/2018 MM : Aggiunta creazione Templog per cattura timestamp attivazione
                OF_PP_GE_Utils.tmpl = new TEMPLOG__c();
                OF_PP_GE_Utils.tmpl.Name = 'Attivazione SVLAN da OLO'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_PP_GE_Utils.tmpl.Tempi_Parziali__c = 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_PP_GE_Utils.tmpl.desc__c ='TEMPLOG relativo alla Request del case:'+ act.codice_ordine_olo;
                OF_PP_GE_Utils.tmpl.Type__c ='T';
                //OF_PP_GE_Utils.tmpl.TL_codice_ordine_olo__c = act.CODICE_ORDINE_OLO;
                //OF_PP_GE_Utils.tmpl.Tipo_Comunicazione__c = '';
                OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OLO_AttivazioneSVLAN';
                OF_PP_GE_Utils.tmpl.Timestamp__c = string.valueof(system.now().format('YYYY-MM-dd HH:mm:ss'));
            }
            

        }
        catch(exception e){
            system.debug('@@@ - Exception:' +e);
        }
    }
    
    public static void CreateTemlogOM(Object o){
        
        try{
            if(o instanceof OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule){

                OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = (OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule) o;         

                OF_PP_GE_Utils.tmpl = new TEMPLOG__c();
                OF_PP_GE_Utils.tmpl.Name= r.CODICE_ORDINE_OLO +' - '+'RDAC da OM'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_PP_GE_Utils.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_PP_GE_Utils.tmpl.desc__c='TEMPLOG relativo alla Notify del case:'+ r.codice_ordine_olo;
                OF_PP_GE_Utils.tmpl.Type__c ='T';
                OF_PP_GE_Utils.tmpl.TL_codice_ordine_olo__c = r.CODICE_ORDINE_OLO;
                //OF_PP_GE_Utils.tmpl.Tipo_Comunicazione__c = '';
                OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Rimodulazione_DAC';      
                OF_PP_GE_Utils.tmpl.Timestamp__c = string.valueof(system.now().format('YYYY-MM-dd HH:mm:ss'));
                                
            }
            
            if(o instanceof OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate){

                OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = (OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate) o;         
                                
                // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp status update
                OF_PP_GE_Utils.tmpl = new TEMPLOG__c();
                OF_PP_GE_Utils.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_PP_GE_Utils.tmpl.desc__c='TEMPLOG relativo alla Notify del case:'+ su.codice_ordine_olo;
                OF_PP_GE_Utils.tmpl.Type__c ='T';
                OF_PP_GE_Utils.tmpl.TL_codice_ordine_olo__c = su.CODICE_ORDINE_OLO;
                //OF_PP_GE_Utils.tmpl.Tipo_Comunicazione__c = '';
                if('0'.equals(su.STATO_ORDINE)){
                    OF_PP_GE_Utils.OPName='Acquisizione da OM';                    
                    OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Acquisizione';       
                }
                if('1'.equals(su.STATO_ORDINE)){
                    OF_PP_GE_Utils.OPName ='Acquisizione KO da OM';                    
                    OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Acquisizione_KO';        
                }
                if('2'.equals(su.STATO_ORDINE)){
                    OF_PP_GE_Utils.OPName ='Accettazione da OM';                    
                    OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Accettazione';       
                }
                if('3'.equals(su.STATO_ORDINE)){
                    OF_PP_GE_Utils.OPName ='Accettazione KO da OM';                    
                    OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Accettazione_KO';        
                }
                if('4'.equals(su.STATO_ORDINE)){
                    OF_PP_GE_Utils.OPName ='Sospensione da OM';                    
                    OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Sospensione';        
                }
                if('5'.equals(su.STATO_ORDINE)){
                    OF_PP_GE_Utils.OPName ='Annullamento da OM';                   
                    OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Annullamento';       
                }
                if('6'.equals(su.STATO_ORDINE)){
                    OF_PP_GE_Utils.OPName ='Cessazione da OM';                    
                    OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Cessazione';     
                }
                if('7'.equals(su.STATO_ORDINE)){
                    OF_PP_GE_Utils.OPName ='Cessazione KO da OM';
                    OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Cessazione_KO';      
                }
                
                OF_PP_GE_Utils.tmpl.Name= su.CODICE_ORDINE_OLO +' - '+ OF_PP_GE_Utils.OPName +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');                
                OF_PP_GE_Utils.tmpl.Timestamp__c = string.valueof(system.now().format('YYYY-MM-dd HH:mm:ss'));                
            }
            
            if(o instanceof OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder){

                OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = (OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder) o;         

                OF_PP_GE_Utils.tmpl = new TEMPLOG__c();
                OF_PP_GE_Utils.tmpl.Name= co.CODICE_ORDINE_OLO +' - '+'Espletamento'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_PP_GE_Utils.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_PP_GE_Utils.tmpl.desc__c='TEMPLOG relativo alla Notify del case:'+ co.codice_ordine_olo;
                OF_PP_GE_Utils.tmpl.Type__c ='T';
                OF_PP_GE_Utils.tmpl.TL_codice_ordine_olo__c = co.CODICE_ORDINE_OLO;
                OF_PP_GE_Utils.tmpl.Tipo_Comunicazione__c = '7';
                if('0'.equals(co.STATO_ORDINE)){
                    OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Espletamento_OK';        
                }
                if('1'.equals(co.STATO_ORDINE)){
                    OF_PP_GE_Utils.tmpl.Tipo_Comunicazione_String__c = 'OM_Espletamento_KO';        
                }
                OF_PP_GE_Utils.tmpl.Timestamp__c = string.valueof(system.now().format('YYYY-MM-dd HH:mm:ss'));
            }
        }
        catch(exception e){
            system.debug('@@@ - Exception:' +e);
        }
    }
    
    public static void partialTemplog(String s){
        try{
            if(OF_PP_GE_Utils.tmpl!=null){
                OF_PP_GE_Utils.tmpl.Tempi_Parziali__c= OF_PP_GE_Utils.tmpl.Tempi_Parziali__c + ', '+s+' : '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
            }
        }
        catch(exception e){ 
            system.debug('@@@ - Exception:' +e);
        }
    }

    // 8/06/2018 MM : aggiunta metodo per inserimento TEMPLOG
    public static void EndTemplog(){

        try{        
        // 8/06/2018 MM: Aggiorno il timestamp. END corrisponde all'uscita dal servizio.
        OF_PP_GE_Utils.tmpl.Tempi_Parziali__c = OF_PP_GE_Utils.tmpl.Tempi_Parziali__c + ', END: '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
        OF_PP_GE_Utils.tmpl.Attraversamento__c = datetime.now().getTime() - OF_PP_GE_Utils.AttrTime;        
        OF_PP_GE_Utils.tmpl.OF_CPU_Time__c = string.valueof(Limits.getCpuTime());
        OF_PP_GE_Utils.tmpl.OF_CPU_Time_Limit__c = string.valueof(Limits.getLimitCpuTime());
        
        // 8/06/2018 MM : Inserisco il templog

            insert OF_PP_GE_Utils.tmpl;
        }
        catch(Exception e){
            system.debug('@@@ - Exception:' +e);
        }
        // finisce qui
        
    }    
    // 8/06/2018 MM : fine aggiunta 

    //PG - Utilizzato nella classe OF_PP_OLO_AsyncChecks
    public static String getQuery(String oggetto,String Processo){
        string s=null;
        if(oggetto=='case'){
            
            if(processo=='VLAN_Activation'){
                s='Select id, casenumber, EOF_Codice_Operatore_WS__c, PO_PP_ID_Richiesta__c, PO_PP_NomeKit__c, PO_PP_Cos_Class__c, PO_PP_Cos_Type__c,' 
                   +'PO_PP_POP_SVLAN__c, PO_PP_SVLAN__c, PO_PP_Cos_remarking__c, OF_SA_CODICE_MOTIVAZIONE__c, OF_SA_MOTIVAZIONE__c '
                   +'from Case';
            }
            System.debug('***oggetto----processo----s***:'+oggetto+' '+' '+processo+' '+s);
        }
        if(oggetto=='sl')
        {
            if(processo=='VLAN_Activation'){
                
                s = 'select id, OF_PP_KIT_Log__c, recordtype.developername, Nome_del_KIT__c,EOF_Codice_Operatore__c,'
                     +'PO_PP_POP_raccolta__c, POP__c, PO_PP_Interfaccia__c, Banda_Interfaccia__c, PO_PP_cos_type__c, SVLAN__c, EOF_Note__c, CreatedDate,'
                     +'PO_PP_cos_class__c, PO_PP_MultiCos_Class__c, PO_PP_cos_remarking__c, PO_PP_dhcp_Option82__c, Caso__c, Caso__r.casenumber, Caso__r.PO_PP_ID_Richiesta__c, PO_PP_ID_Richiesta_testo__c,'
                     +'PO_PP_Progressivo_Ordine__c, PO_PP_User_VLAN__c, EOF_Stato_Richiesta__c, EOF_STATO_Ordine__c, EOF_Data_Notifica__c, EOF_ID_NOTIFICA__c, EOF_PROFILO__C '
                     +'from EOF_EAI_Service_Log__c'; 
            }
            if(processo=='COS_Activation')
            {
                s = 'select id, PO_PP_ID_Vlan__c, recordtype.developername, Nome_del_KIT__c,EOF_Codice_Operatore__c,'
                     +'PO_PP_POP_raccolta__c, POP__c, PO_PP_cos_type__c, SVLAN__c, EOF_Note__c, CreatedDate,'
                     +'PO_PP_cos_class__c, PO_PP_MultiCos_Class__c, PO_PP_cos_remarking__c, PO_PP_dhcp_Option82__c, '
                     +'EOF_Stato_Richiesta__c, EOF_STATO_Ordine__c, EOF_Data_Notifica__c, EOF_ID_NOTIFICA__c, EOF_PROFILO__C '
                     +'from EOF_EAI_Service_Log__c'; 
            }
            System.debug('***oggetto----processo----s***:'+oggetto+' '+' '+processo+' '+s);
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
    
    
    //Commento PG - 31-08
    /*
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
                            slPrincipalePortale.EOF_Stato_Ordine__c=OF_PP_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
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
                    slPrincipalePortale.EOF_Stato_Ordine__c=OF_PP_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
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
                slPrincipalePortale.EOF_Stato_Ordine__c=OF_PP_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
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
                            slPrincipalePortale.EOF_Stato_Ordine__c=OF_PP_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
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
                    //Commento PG 31-08
                    /*
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
                    slPrincipalePortale.EOF_Stato_Ordine__c=OF_PP_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
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
                slPrincipalePortale.EOF_Stato_Ordine__c=OF_PP_GE_Utils.returnStatusFromInt(slPrincipaleToOLO.EOF_Stato_Ordine__c,metodo);
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
    */
}
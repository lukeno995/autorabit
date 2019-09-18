public class OF_SA_SendRetryAttivi_MethodsNew {
    private static Boolean hasSHLog = false;

    @future(callout=true)
    public static void routeRetry(String caseId,String rtypeDevName, string codiceOrdineOLO){
        
        system.debug('Alessandro: '+caseId+', '+rtypeDevName+', '+codiceOrdineOLO);
        //vado a creare la mappa dei recordtype per poi utilizzarla
        OF_SA_GE_UtilsNew.RTMap = new  map<String,String>();
        for(recordtype rt : [select id,developername from recordtype where sobjectType='EOF_EAI_Service_Log__c']){
            OF_SA_GE_UtilsNew.RTMap.put(rt.developername,rt.id);
        }
        OF_SA_GE_UtilsNew.checkRTMap=true;   
        
        //setto la variabile retry che andrò a mettere sui sl
        OF_SA_GE_UtilsNew.retry=true;
        
        //faccio il check sul processo in quanto sono diversi i campi da estrarre
        if(rtypeDevName=='OF_SA_Attivazione'){
            OF_SA_GE_UtilsNew.caseOriginale = Database.query(OF_SA_GE_UtilsNew.getQueryNew('case','AsyncActivation')+
                                                                                            ' where id=:caseId');
            OF_SA_GE_UtilsNew.caseOriginale.OF_Retry_Automatico__c=false;
            /*In un caso di attivazione bisogna capire quale dei flussi è andato in errore tra "OLO_Activation, OLO_StatusUpdate e OLO_Reschedule*/
            if('OLO_Activation'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Flusso_Retry__c)){
                //Il NACK TECNICO è sull'OLO_Activation
                //Una volta individuato che è sull'activation, bisogna verificare se è un NACK TECNICO DA SH oppure dall'OLO o OM
                if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){
                    //Il NACK TECNICO è da SH, quindi vado a richiamare il metodo di callout verso SH
                    OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c); 
                    //Vado a controllare se c'è stato un altro NACK TECNICO DA SH
                    if('NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c)){
                        //Se c'è stato un altro NACK TECNICO mi fermo, inserisco il log e aggiorno il case
                        if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                            //Lego il log di SH al case, inserisco il log e aggiorno il case
                            OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                            insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
                            //Setto a false la variabile retry
                            OF_SA_GE_UtilsNew.caseOriginale.OF_Retry_Automatico__c=false;
                            update OF_SA_GE_UtilsNew.caseOriginale;
                        }
                    }else{
                        //Se abbiamo ricevuto un ACK da SH leghiamo il log al case e richiamiamo il metodo per effettuare la callout verso OLO e OM
                        OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
                        //Salvo un booleano per inserire successivamente il log di SH
                        hasSHLog = true;
                        //Vado a richiamare il metodo di callout verso OLO e OM
                        OF_SA_SendRetryAttivi_MethodsNew.retryCalloutOLOOM(caseId, rtypeDevName, codiceOrdineOLO);
                    }
                    
                }else{
                    //Il NACK TECNICO è da OLO o OM, in questo caso richiamo il vecchio metodo
                    OF_SA_SendRetryAttivi_MethodsNew.retryCalloutOLOOM(caseId, rtypeDevName, codiceOrdineOLO);
                }
            }else if('OLO_StatusUpdate'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Flusso_Retry__c)){
                //Il NACK TECNICO è sull'OLO_StatusUpdate
                OF_SA_SendRetryAttivi_MethodsNew.retryCalloutOM_StatusUpdate(caseId, rtypeDevName, codiceOrdineOLO);
            }else if('OLO_Reschedule'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Flusso_Retry__c)){
                //Il NACK TECNICO è sull'OLO_Reschedule
                OF_SA_SendRetryAttivi_MethodsNew.retryCalloutOM_Reschedule(caseId, rtypeDevName, codiceOrdineOLO);
            }
        } 
        else{//Caso in cui è una cessazione
            OF_SA_GE_UtilsNew.caseOriginale = Database.query(OF_SA_GE_UtilsNew.getQueryNew('case','AsyncDeactivation')+
                                                                                            ' where id=:caseId');
            OF_SA_GE_UtilsNew.caseOriginale.OF_Retry_Automatico__c=false;
            //Chiamo il metodo per effettuare la callout
            OF_SA_SendRetryAttivi_MethodsNew.retryCalloutOLOOM(caseId, rtypeDevName, codiceOrdineOLO);
        }
    }

    //metodo per il retry della notifica di acquisizione all'olo
    //@future(callout=true)
    public static void retryCalloutOLOOM(String caseId,String rtypeDevName, string codiceOrdineOLO){
        
        //caso in cui il nack è sull'acquisizione verso OLO
        if(String.isBlank(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c)){
            OF_SA_GE_UtilsNew.slSFOLO = [select Id,EOF_Tipo_COmunicazione_String__c,OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,
                                        EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_CODICE_ORDINE_EOF__c,EOF_DATA_NOTIFICA__c,
                                        EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione__c ,EOF_STATO_ORDINE__c,EOF_CODICE_MOTIVAZIONE__c,
                                        EOF_MOTIVAZIONE__c,caso__c,EOF_Richiesta_Notifica__c,EOF_GPON_Attestazione__c, EOF_NOME_CLIENTE__c,
                                        EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,
                                        EOF_ORARIO_APPUNTAMENTO__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_NOTE__c 
                                        from EOF_EAI_Service_Log__c 
                                        where EOF_Codice_Ordine_Olo__c=:OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c
                                        AND Caso__c=:OF_SA_GE_UtilsNew.caseOriginale.Id
                                        AND recordtypeId=:OF_SA_GE_UtilsNew.RTMap.get('OF_SA_FiberNotify')
                                        order by createdDate ASC limit 1];  
         
            OF_Schema_StatusUpdateNew.StatusUpdateResponseType resp = OF_OM_SendToOLONew.OM_CreateAckNackNotifyStatusUpdateNew(OF_SA_GE_UtilsNew.slSFOLO);
            if(resp.esito=='0'){
                //call OM
                //tiro fuori l'id del sl OLO->SF (tanto c'è solo questo in quel flusso per il momento, l'altro deve ancora essere creato)
                EOF_EAI_Service_Log__c slOM = [select Id from EOF_EAI_Service_Log__c where EOF_CODICE_ORDINE_OLO__c=:codiceOrdineOLO 
                								and caso__c=:OF_SA_GE_UtilsNew.caseOriginale.Id
                								and recordtype.developername='OF_SA_FIberRequest'
                								order by createdDate ASC limit 1];
                String slOMId = slOM.Id;
                if(OF_SA_GE_UtilsNew.caseOriginale.recordtype.developername=='OF_SA_Attivazione'){
                    //inoltro attivazione
                    
                    OF_SA_GE_UtilsNew.ListSlActivationOLOSF=Database.query(OF_SA_GE_UtilsNew.getQueryNew('sl','AsyncActivation')+
                                                                                                ' where id =:slOMId' 
                                                                                                +' OR OF_SA_VLan_Log__c =:slOMId'
                                                                                                +' OR OF_SA_Cpe_Log__c =:slOMId'
                                                                                                +' OR OF_SA_servizi_Aggiuntivi_Log__c =:slOMId' 
                                                                                                +' order by EOF_Ordine_Invio_OLO__c');
                    OF_SA_GE_UtilsNew.ListSlActivationSFOM=OF_SA_GE_UtilsNew.create_ActivationToOM_Log(OF_SA_GE_UtilsNew.caseOriginale,OF_SA_GE_UtilsNew.ListSlActivationOLOSF);
                    OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestActivationNew(OF_SA_GE_UtilsNew.ListSlActivationSFOM);
                    //indipendentemente dall'ACK o NACK da OM glli aggiornamenti sono sempre gli stessi
                    //aggiungo la  richiesta originale
                    //mantengo inserimenti/aggiornamenti singoli per la facilità di comprensione della dinamica da layout
                    if(hasSHLog){
                        insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
                    }
                    update OF_SA_GE_UtilsNew.slSFOLO;
                    OF_SA_GE_UtilsNew.slSFOLOResp.EOF_sl_riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
                    insert OF_SA_GE_UtilsNew.slSFOLOResp;
                    insert OF_SA_GE_UtilsNew.slSFOM;                    
                    OF_SA_GE_UtilsNew.slSFOMResp.EOF_sl_riferimento__c=OF_SA_GE_UtilsNew.slSFOM.Id;
                    insert OF_SA_GE_UtilsNew.slSFOMResp;
                    update OF_SA_GE_UtilsNew.caseOriginale;
                }
                else{
                    //inoltro cessazione
                    
                    OF_SA_GE_UtilsNew.ListSlDeactivationOLOSF=Database.query(OF_SA_GE_UtilsNew.getQueryNew('sl','AsyncDeactivation')+ 
                                                ' where id =:slOMId' 
                                                +' OR OF_SA_Cpe_Log__c =:slOMId'
                                                +' order by EOF_Ordine_Invio_OLO__c'); 
                    if(!String.isBlank(OF_SA_GE_UtilsNew.caseOriginale.AssetId)){
                        OF_SA_GE_UtilsNew.a=Database.query(OF_SA_GE_UtilsNew.getQueryNew('Asset','AsyncDeactivation')+
                                            'where Id=:OF_SA_GE_UtilsNew.caseOriginale.AssetId');
                    }
                    OF_SA_GE_UtilsNew.ListApp=new List<EOF_EAI_service_Log__c>();
                    for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListSlDeactivationOLOSF){
                        if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                            OF_SA_GE_UtilsNew.slOLOSF=sl;  
                        }
                        if(sl.recordtype.developername=='OF_SA_Cpe'){
                            OF_SA_GE_UtilsNew.checkApp=true;
                            OF_SA_GE_UtilsNew.ListApp.add(sl);
                        }
                    }
                    OF_SA_GE_UtilsNew.ListSlDeactivationSFOM=OF_SA_GE_UtilsNew.create_DeactivationToOM_Log(OF_SA_GE_UtilsNew.caseOriginale,OF_SA_GE_UtilsNew.ListSlDeactivationOLOSF,OF_SA_GE_UtilsNew.a);
                    Map<String,EOF_EAI_Service_Log__c> respMap = OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestDeactivationNew(OF_SA_GE_UtilsNew.ListSlDeactivationSFOM);
                    //indipendentemente dall'ACK o NACK da OM glli aggiornamenti sono sempre gli stessi
                    update OF_SA_GE_UtilsNew.slSFOLO;
                    OF_SA_GE_UtilsNew.slSFOLOResp.EOF_sl_riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
                    insert OF_SA_GE_UtilsNew.slSFOLOResp;
                    insert OF_SA_GE_UtilsNew.slSFOM;                    
                    OF_SA_GE_UtilsNew.slSFOMResp.EOF_sl_riferimento__c=OF_SA_GE_UtilsNew.slSFOM.Id;
                    insert OF_SA_GE_UtilsNew.slSFOMResp;
                    update OF_SA_GE_UtilsNew.caseOriginale;
                }
            }
            else{
                //l'acquisizione verso OLO è di nuovo andata KO
                //aggiorna dati retry
                List<EOF_EAI_Service_Log__c> slListToUpsert = new List<EOF_EAI_Service_Log__c>();
                slListToUpsert.add(OF_SA_GE_UtilsNew.slSFOLO);
                if(hasSHLog){
                    slListToUpsert.add(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes);
                }
                OF_SA_GE_UtilsNew.slSFOLOResp.EOF_sl_riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
                slListToUpsert.add(OF_SA_GE_UtilsNew.slSFOLOResp);
                upsert slListToUpsert;
                update OF_SA_GE_UtilsNew.caseOriginale;
            }
        }
        
        //caso in cui il nack è sull'inoltro della notifica di arttivazione ad OM
        else{
            //call OM Attivazione
            //tiro fuori l'id dell'attivazione di cui si è tentato l'inoltro verso OM
                EOF_EAI_Service_Log__c slOM = [select Id from EOF_EAI_Service_Log__c where EOF_CODICE_ORDINE_OLO__c=:codiceOrdineOLO and recordtype.developername='OF_SA_FIberRequest'
                                                and OF_SA_Direzione_Flusso__c='SF-OM' order by createdDate ASC limit 1]; 
            if(OF_SA_GE_UtilsNew.caseOriginale.recordtype.developername=='OF_SA_Attivazione'){
                
                OF_SA_GE_UtilsNew.ListSlActivationSFOM=[select Id,RecordTypeId ,EOF_Tipo_COmunicazione_String__c,OF_SA_Direzione_Flusso__c,
                                                    OF_SA_Metodo__c,EOF_Sorgente__c,EOF_CODICE_OPERATORE__C,EOF_CODICE_ORDINE_OLO__C,
                                                    EOF_CODICE_ORDINE_EOF__C,EOF_DATA_NOTIFICA__C,EOF_ID_NOTIFICA__C,EOF_Id_servizio__c,
                                                    EOF_NOME_REFERENTE_TECNICO_OLO__C,EOF_COGNOME_REFERENTE_TECNICO_OLO__C,
                                                    EOF_TELEFONO_REFERENTE_TECNICO_OLO__C,EOF_EMAIL_REFERENTE_TECNICO_OLO__C,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C,
                                                    EOF_NOME_CLIENTE__C,EOF_COGNOME_CLIENTE__C,EOF_RECAPITO_TELEFONICO_CLIENTE_1__C,EOF_RECAPITO_TELEFONICO_CLIENTE_2__C,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__C,EOF_DATA_PREVISTA_ATTIVAZIONE__C,EOF_ORARIO_APPUNTAMENTO__C,
                                                    EOF_CODICE_PROGETTO_SPECIALE__c,EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,
                                                    EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C,EOF_CODICE_MOTIVAZIONE__c,
                                                    EOF_MOTIVAZIONE__c,EOF_Provincia__c ,EOF_Comune__c,EOF_Particella_Toponomastica__c ,EOF_Indirizzo__c ,EOF_Numero_Civico__c ,
                                                    EOF_ID_Building__c ,Caso__c,EOF_Tipo_COmunicazione__c,EOF_Stato_Ordine__c,EOF_SLA_DATE__c,EOF_GPON_Attestazione__c,
                                                    EOF_GPON_VINCOLANTE__c,OF_SA_KIT_CONSEGNA_VLAN__C,OF_SA_USER_VLAN__C,EOF_OPZIONE_SYSTEM_UNICO__c,EOF_ID_RISORSA__c,
                                                    EOF_COLLEGAMENTO_P2P__c,EOF_TRACCIATO__c,EOF_SLA_PREMIUM_ASSURANCE__c,
                                                    OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__C,OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,
                                                    OF_SA_VLan_Log__c,EOF_Ordine_Invio_OLO__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_PASSWORD_APPARATO__C,OF_SA_AZIONE_APPARATO__C,
                                                    OF_SA_Cpe_Log__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,OF_SA_servizi_Aggiuntivi_Log__c,recordtype.developername
                                                    from EOF_EAI_Service_Log__c where id =:slOM.Id 
                                                    OR OF_SA_VLan_Log__c =:slOM.Id
                                                    OR OF_SA_Cpe_Log__c =:slOM.Id
                                                    OR OF_SA_servizi_Aggiuntivi_Log__c =:slOM.Id
                                                    order by EOF_Ordine_Invio_OLO__c];
                                                    
                OF_SA_GE_UtilsNew.ListVLan=new List<EOF_EAI_Service_LOg__c>();
                OF_SA_GE_UtilsNew.ListApp=new List<EOF_EAI_Service_LOg__c>();
                OF_SA_GE_UtilsNew.ListServAgg=new List<EOF_EAI_Service_LOg__c>();                                    
                for(EOF_EAI_service_Log__c sl : OF_SA_GE_UtilsNew.ListSlActivationSFOM){
                    if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                        OF_SA_GE_UtilsNew.slSFOM=sl;   
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
                OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestActivationNew(OF_SA_GE_UtilsNew.ListSlActivationSFOM);
                //indipendentemente dall'ACK o NACK da OM glli aggiornamenti sono sempre gli stessi
                List<EOF_EAI_service_Log__c> slListToUpsert =  new List<EOF_EAI_service_Log__c>();
                slListToUpsert.add(OF_SA_GE_UtilsNew.slSFOM);
                OF_SA_GE_UtilsNew.slSFOMResp.EOF_sl_riferimento__c=OF_SA_GE_UtilsNew.slSFOM.Id;
                slListToUpsert.add(OF_SA_GE_UtilsNew.slSFOMResp);
                upsert slListToUpsert;
                update OF_SA_GE_UtilsNew.caseOriginale;
            }
            else{
                //call OM Cessazione
                OF_SA_GE_UtilsNew.ListSlDeactivationSFOM=[select Id,EOF_Tipo_COmunicazione_String__c,OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,
                                                        EOF_CODICE_OPERATORE__C,EOF_CODICE_ORDINE_OLO__C,EOF_CODICE_ORDINE_EOF__C,EOF_DATA_NOTIFICA__C,
                                                        EOF_ID_NOTIFICA__C,EOF_CODICE_MOTIVAZIONE__c,EOF_MOTIVAZIONE__c,EOF_NOME_CLIENTE__c,
                                                        EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                        EOF_NOTE__c,EOF_ID_RISORSA__c ,EOF_SORGENTE__c ,EOF_SLA_DATE__c ,EOF_GPON_VINCOLANTE__c ,
                                                        EOF_OPZIONE_SYSTEM_UNICO__c ,EOF_COLLEGAMENTO_P2P__c ,EOF_TRACCIATO__c ,caso__c,
                                                        EOF_Tipo_COmunicazione__c,EOF_Stato_Ordine__c,EOF_GPON_Attestazione__c,EOF_ID_SERVIZIO__c ,
                                                        EOF_PROFILO__c ,EOF_Provincia__c ,EOF_Comune__c,EOF_Particella_Toponomastica__c ,EOF_Indirizzo__c ,
                                                        EOF_Numero_Civico__c ,recordtypeId,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ID_APPARATO__C,OF_SA_Cpe_Log__c,
                                                        EOF_Ordine_Invio_OLO__c,recordtype.developername,EOF_TIPOLOGIA_SERVIZIO__c,TRACCIATO_TRASCODIFICATO__c,OF_Codice_Operatore_Secondario__c
                                                        from EOF_EAI_Service_Log__c where id =:slOM.Id 
                                                        OR OF_SA_Cpe_Log__c =:slOM.Id
                                                        order by EOF_Ordine_Invio_OLO__c];
                OF_SA_GE_UtilsNew.ListApp=new List<EOF_EAI_Service_LOg__c>();
                for(EOF_EAI_service_Log__c sl : OF_SA_GE_UtilsNew.ListSlDeactivationSFOM){
                    if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                        OF_SA_GE_UtilsNew.slSFOM=sl;    
                    }
                    if(sl.recordtype.developername=='OF_SA_Cpe'){
                        OF_SA_GE_UtilsNew.checkApp=true;
                        OF_SA_GE_UtilsNew.ListApp.add(sl);
                    } 
                }
                OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestDeactivationNew(OF_SA_GE_UtilsNew.ListSlDeactivationSFOM);
                //indipendentemente dall'ACK o NACK da OM glli aggiornamenti sono sempre gli stessi
                List<EOF_EAI_service_Log__c> slListToUpsert =  new List<EOF_EAI_service_Log__c>();
                slListToUpsert.add(OF_SA_GE_UtilsNew.slSFOM);
                OF_SA_GE_UtilsNew.slSFOMResp.EOF_sl_riferimento__c=OF_SA_GE_UtilsNew.slSFOM.Id;
                slListToUpsert.add(OF_SA_GE_UtilsNew.slSFOMResp);
                upsert slListToUpsert;
                update OF_SA_GE_UtilsNew.caseOriginale; 
            }
        }
    }

    public static void retryCalloutOM_Reschedule(String caseId, String rtypeDevName, String codiceOrdineOLO){
        //Bisogna recuperare il log che è andato in errore e riprovare la retry
        List<EOF_EAI_service_Log__c> sLogLst = [SELECT Id, RecordTypeId, EOF_Tipo_COmunicazione_String__c, OF_SA_Direzione_Flusso__c, OF_SA_Metodo__c, EOF_CODICE_OPERATORE__c,
                                                EOF_CODICE_ORDINE_OLO__c, EOF_DATA_NOTIFICA__c, EOF_ID_NOTIFICA__c, EOF_DATA_PREVISTA_ATTIVAZIONE__c, EOF_ORARIO_APPUNTAMENTO__c,
                                                EOF_NOME_CLIENTE__c, EOF_COGNOME_CLIENTE__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c, EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                EOF_CODICE_MOTIVAZIONE__c, EOF_MOTIVAZIONE__c, EOF_SORGENTE__c, EOF_codice_Ordine_EOF__c, OF_SH_Token_id__c, EOF_ID_SERVIZIO__c,
                                                EOF_Profilo__c, OF_SH_ID_WO__c, OF_SH_DeliveryCompany__c, OF_SH_AppointmentDate__c, OF_SH_Fascia_App__c, EOF_Tracciato__c,
                                                EOF_Tipo_Comunicazione_Int__c, EOF_Richiesta_Notifica__c, Caso__c, EOF_Note__c, EOF_Response__c, EOF_SLA_DATE__c, EOF_GPON_ATTESTAZIONE__c,
                                                EOF_COMUNE__c, EOF_INDIRIZZO__c, EOF_NUMERO_CIVICO__c, EOF_PARTICELLA_TOPONOMASTICA__c,EOF_COLLEGAMENTO_P2P__c,EOF_GPON_VINCOLANTE__c,
                                                EOF_Provincia__c
                                                FROM EOF_EAI_Service_Log__c
                                                WHERE EOF_Tipo_COmunicazione_String__c = 'SF->OM - RescheduleRequest' AND OF_SA_Direzione_Flusso__c='SF-OM'
                                                AND OF_SA_Metodo__c='OLO_Reschedule' AND Caso__c = :OF_SA_GE_UtilsNew.caseOriginale.Id
                                                AND EOF_CODICE_ORDINE_OLO__c = :OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c
                                                AND EOF_Response__c = 'NACK TECNICO' AND EOF_CODICE_OPERATORE__c = :OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Operatore_WS__c
                                                ORDER BY createdDate DESC];
        //Se trovo il log, rifaccio la chiamata
        if(!sLogLst.isEmpty()){
            //Recupero il log esatto
            OF_SA_GE_UtilsNew.slSFOM = sLogLst[0];
            //Riprovo la callout
            Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestRescheduleNew(OF_SA_GE_UtilsNew.slSFOM);
            //Lista che aggiornerò/inserirò
            List<EOF_EAI_Service_Log__c> listToUpsert = new List<EOF_EAI_Service_Log__c>();
            
            if(responseFromOM.containsKey('0')) {
                OF_SA_GE_UtilsNew.slSFOMResp = responseFromOM.get('0');
                OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'ACK';
                //Done AA - Aggiornare il campo blockedCase così da poter ricevere altre info
                OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c = false;
                update OF_SA_GE_UtilsNew.caseOriginale;
            }else{
                OF_SA_GE_UtilsNew.slSFOMResp = responseFromOM.get('1');
                if(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c == 'NACK TECNICO'){
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'NACK TECNICO';
                }else{
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'NACK';
                }
            }
            OF_SA_GE_UtilsNew.slSFOMResp.EOF_Sl_Riferimento__c = OF_SA_GE_UtilsNew.slSFOM.Id;
            listToUpsert.add(OF_SA_GE_UtilsNew.slSFOM);
            listToUpsert.add(OF_SA_GE_UtilsNew.slSFOMResp);
            upsert listToUpsert;
        }                                             

    }    
    public static void retryCalloutOM_StatusUpdate(String caseId, String rtypeDevName, String codiceOrdineOLO){
        //Bisogna recuperare il log che è andato in errore e riprovare la retry
        List<EOF_EAI_service_Log__c> sLogLst = [SELECT Id, RecordTypeId, EOF_Tipo_COmunicazione_String__c, OF_SA_Direzione_Flusso__c, OF_SA_Metodo__c, EOF_CODICE_OPERATORE__c,
                                                EOF_CODICE_ORDINE_OLO__c, EOF_DATA_NOTIFICA__c, EOF_ID_NOTIFICA__c, EOF_DATA_PREVISTA_ATTIVAZIONE__c, EOF_ORARIO_APPUNTAMENTO__c,
                                                EOF_NOME_CLIENTE__c, EOF_COGNOME_CLIENTE__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c, EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                EOF_CODICE_MOTIVAZIONE__c, EOF_MOTIVAZIONE__c, EOF_SORGENTE__c, EOF_codice_Ordine_EOF__c, OF_SH_Token_id__c, EOF_ID_SERVIZIO__c,
                                                EOF_Profilo__c, OF_SH_ID_WO__c, OF_SH_DeliveryCompany__c, OF_SH_AppointmentDate__c, OF_SH_Fascia_App__c, EOF_Tracciato__c,
                                                EOF_Tipo_Comunicazione_Int__c, EOF_Richiesta_Notifica__c, Caso__c, EOF_Note__c, EOF_Response__c, OF_SA_AZIONE__C,
                                                EOF_SLA_DATE__c,EOF_GPON_Attestazione__c, EOF_GPON_VINCOLANTE__c, EOF_COLLEGAMENTO_P2P__c, EOF_PARTICELLA_TOPONOMASTICA__c, EOF_PROVINCIA__c,
                                                EOF_COMUNE__c, EOF_INDIRIZZO__c, EOF_NUMERO_CIVICO__c
                                                FROM EOF_EAI_Service_Log__c
                                                WHERE EOF_Tipo_COmunicazione_String__c = 'SF->OM - StatusUpdateRequest' AND OF_SA_Direzione_Flusso__c='SF-OM'
                                                AND OF_SA_Metodo__c='OLO_StatusUpdate' AND Caso__c = :OF_SA_GE_UtilsNew.caseOriginale.Id
                                                AND EOF_CODICE_ORDINE_OLO__c = :OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Ordine_Olo__c
                                                AND EOF_Response__c = 'NACK TECNICO' AND EOF_CODICE_OPERATORE__c = :OF_SA_GE_UtilsNew.caseOriginale.EOF_Codice_Operatore_WS__c
                                                ORDER BY createdDate DESC];
        //Se trovo il log, rifaccio la chiamata
        if(!sLogLst.isEmpty()){
            //Recupero il log esatto
            OF_SA_GE_UtilsNew.slSFOM = sLogLst[0];
            //Riprovo la callout
            Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestStatusUpdateNew(OF_SA_GE_UtilsNew.slSFOM);
            //Lista che aggiornerò/inserirò
            List<EOF_EAI_Service_Log__c> listToUpsert = new List<EOF_EAI_Service_Log__c>();
            
            if(responseFromOM.containsKey('0')) {
                OF_SA_GE_UtilsNew.slSFOMResp = responseFromOM.get('0');
                OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'ACK';
                //Done AA - Aggiornare il campo blockedCase così da poter ricevere altre info
                OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c = false;
            }else{
                OF_SA_GE_UtilsNew.slSFOMResp = responseFromOM.get('1');
                if(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c == 'NACK TECNICO'){
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'NACK TECNICO';
                }else{
                    OF_SA_GE_UtilsNew.slSFOM.EOF_Response__c = 'NACK';
                }
            }
            update OF_SA_GE_UtilsNew.caseOriginale;
            OF_SA_GE_UtilsNew.slSFOMResp.EOF_Sl_Riferimento__c = OF_SA_GE_UtilsNew.slSFOM.Id;
            listToUpsert.add(OF_SA_GE_UtilsNew.slSFOM);
            listToUpsert.add(OF_SA_GE_UtilsNew.slSFOMResp);
            upsert listToUpsert;
        }                                             

    }    
}
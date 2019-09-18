public class OF_SA_SendRetryAttivi_Methods {
    
    //metodo per il retry della notifica di acquisizione all'olo
    @future(callout=true)
    public static void retryCalloutOLOOM(String caseId,String rtypeDevName, string codiceOrdineOLO){
        system.debug('Alessandro: '+caseId+', '+rtypeDevName+', '+codiceOrdineOLO);
        //vado a creare la mappa dei recordtype per poi utilizzarla
        OF_SA_GE_Utils.RTMap = new  map<String,String>();
        for(recordtype rt : [select id,developername from recordtype where sobjectType='EOF_EAI_Service_Log__c']){
            OF_SA_GE_Utils.RTMap.put(rt.developername,rt.id);
        }
        OF_SA_GE_Utils.checkRTMap=true;   
        
        //setto la variabile retry che andrò a mettere sui sl
        OF_SA_GE_Utils.retry=true;
        
        //faccio il check sul processo in quanto sono diversi i campi da estrarre
        if(rtypeDevName=='OF_SA_Attivazione'){
            OF_SA_GE_Utils.caseOriginale = Database.query(OF_SA_GE_Utils.getQuery('case','AsyncActivation')+
                                                                                            ' where id=:caseId');
        } 
        else{
            OF_SA_GE_Utils.caseOriginale = Database.query(OF_SA_GE_Utils.getQuery('case','AsyncDeactivation')+
                                                                                            ' where id=:caseId');
        }
        OF_SA_GE_Utils.caseOriginale.OF_Retry_Automatico__c=false;
        
        //caso in cui il nack è sull'acquisizione verso OLO
        if(String.isBlank(OF_SA_GE_Utils.caseOriginale.OF_Response_Da_OM__c)){
            OF_SA_GE_Utils.slSFOLO = [select Id,EOF_Tipo_COmunicazione_String__c,OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,
                                        EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_CODICE_ORDINE_EOF__c,EOF_DATA_NOTIFICA__c,
                                        EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione__c ,EOF_STATO_ORDINE__c,EOF_CODICE_MOTIVAZIONE__c,
                                        EOF_MOTIVAZIONE__c,caso__c,EOF_Richiesta_Notifica__c,EOF_GPON_Attestazione__c, EOF_NOME_CLIENTE__c,
                                        EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,
                                        EOF_ORARIO_APPUNTAMENTO__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_NOTE__c 
                                        from EOF_EAI_Service_Log__c 
                                        where EOF_Codice_Ordine_Olo__c=:OF_SA_GE_Utils.caseOriginale.EOF_Codice_Ordine_Olo__c
                                        AND Caso__c=:OF_SA_GE_Utils.caseOriginale.Id
                                        AND recordtypeId=:OF_SA_GE_Utils.RTMap.get('OF_SA_FiberNotify')
                                        order by createdDate ASC limit 1];  
         
            OF_SA_WS_OLO_Response.Esito_element resp =OF_SA_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(OF_SA_GE_Utils.slSFOLO);
            if(resp.esito=='0'){
                //call OM
                //tiro fuori l'id del sl OLO->SF (tanto c'è solo questo in quel flusso per il momento, l'altro deve ancora essere creato)
                EOF_EAI_Service_Log__c slOM = [select Id from EOF_EAI_Service_Log__c where EOF_CODICE_ORDINE_OLO__c=:codiceOrdineOLO 
                								and caso__c=:OF_SA_GE_Utils.caseOriginale.Id
                								and recordtype.developername='OF_SA_FIberRequest'
                								order by createdDate ASC limit 1];
                String slOMId=slOM.Id;
                if(OF_SA_GE_Utils.caseOriginale.recordtype.developername=='OF_SA_Attivazione'){
                    //inoltro attivazione
                    
                    OF_SA_GE_Utils.ListSlActivationOLOSF=Database.query(OF_SA_GE_Utils.getQuery('sl','AsyncActivation')+
                                                                                                ' where id =:slOMId' 
                                                                                                +' OR OF_SA_VLan_Log__c =:slOMId'
                                                                                                +' OR OF_SA_Cpe_Log__c =:slOMId'
                                                                                                +' OR OF_SA_servizi_Aggiuntivi_Log__c =:slOMId' 
                                                                                                +' order by EOF_Ordine_Invio_OLO__c');
                    OF_SA_GE_Utils.ListSlActivationSFOM=OF_SA_GE_Utils.create_ActivationToOM_Log(OF_SA_GE_Utils.caseOriginale,OF_SA_GE_Utils.ListSlActivationOLOSF);
                    OF_SA_OLO_SendToOM.OM_CreateAckNackRequestActivation(OF_SA_GE_Utils.ListSlActivationSFOM);
                    //indipendentemente dall'ACK o NACK da OM glli aggiornamenti sono sempre gli stessi
                    //aggiungo la  richiesta originale
                    //mantengo inserimenti/aggiornamenti singoli per la facilità di comprensione della dinamica da layout
                    update OF_SA_GE_Utils.slSFOLO;
                    OF_SA_GE_Utils.slSFOLOResp.EOF_sl_riferimento__c=OF_SA_GE_Utils.slSFOLO.Id;
                    insert OF_SA_GE_Utils.slSFOLOResp;
                    insert OF_SA_GE_Utils.slSFOM;                    
                    OF_SA_GE_Utils.slSFOMResp.EOF_sl_riferimento__c=OF_SA_GE_Utils.slSFOM.Id;
                    insert OF_SA_GE_Utils.slSFOMResp;
                    update OF_SA_GE_Utils.caseOriginale;
                }
                else{
                    //inoltro cessazione
                    
                    OF_SA_GE_Utils.ListSlDeactivationOLOSF=Database.query(OF_SA_GE_Utils.getQuery('sl','AsyncDeactivation')+ 
                                                ' where id =:slOMId' 
                                                +' OR OF_SA_Cpe_Log__c =:slOMId'
                                                +' order by EOF_Ordine_Invio_OLO__c'); 
                    if(!String.isBlank(OF_SA_GE_Utils.caseOriginale.AssetId)){
                        OF_SA_GE_Utils.a=Database.query(OF_SA_GE_Utils.getQuery('Asset','AsyncDeactivation')+
                                            'where Id=:OF_SA_GE_Utils.caseOriginale.AssetId');
                    }
                    OF_SA_GE_Utils.ListApp=new List<EOF_EAI_service_Log__c>();
                    for(EOF_EAI_Service_Log__c sl : OF_SA_GE_Utils.ListSlDeactivationOLOSF){
                        if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                            OF_SA_GE_Utils.slOLOSF=sl;  
                        }
                        if(sl.recordtype.developername=='OF_SA_Cpe'){
                            OF_SA_GE_Utils.checkApp=true;
                            OF_SA_GE_Utils.ListApp.add(sl);
                        }
                    }
                    OF_SA_GE_Utils.ListSlDeactivationSFOM=OF_SA_GE_Utils.create_DeactivationToOM_Log(OF_SA_GE_Utils.caseOriginale,OF_SA_GE_Utils.ListSlDeactivationOLOSF,OF_SA_GE_Utils.a);
                    Map<String,EOF_EAI_Service_Log__c> respMap = OF_SA_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(OF_SA_GE_Utils.ListSlDeactivationSFOM);
                    //indipendentemente dall'ACK o NACK da OM glli aggiornamenti sono sempre gli stessi
                    update OF_SA_GE_Utils.slSFOLO;
                    OF_SA_GE_Utils.slSFOLOResp.EOF_sl_riferimento__c=OF_SA_GE_Utils.slSFOLO.Id;
                    insert OF_SA_GE_Utils.slSFOLOResp;
                    insert OF_SA_GE_Utils.slSFOM;                    
                    OF_SA_GE_Utils.slSFOMResp.EOF_sl_riferimento__c=OF_SA_GE_Utils.slSFOM.Id;
                    insert OF_SA_GE_Utils.slSFOMResp;
                    update OF_SA_GE_Utils.caseOriginale;
                }
            }
            else{
                //l'acquisizione verso OLO è di nuovo andata KO
                //aggiorna dati retry
                List<EOF_EAI_Service_Log__c> slListToUpsert = new List<EOF_EAI_Service_Log__c>();
                slListToUpsert.add(OF_SA_GE_Utils.slSFOLO);
                OF_SA_GE_Utils.slSFOLOResp.EOF_sl_riferimento__c=OF_SA_GE_Utils.slSFOLO.Id;
                slListToUpsert.add(OF_SA_GE_Utils.slSFOLOResp);
                upsert slListToUpsert;
                update OF_SA_GE_Utils.caseOriginale;
            }
        }
        
        //caso in cui il nack è sull'inoltro della notifica di arttivazione ad OM
        else{
            //call OM Attivazione
            //tiro fuori l'id dell'attivazione di cui si è tentato l'inoltro verso OM
                EOF_EAI_Service_Log__c slOM = [select Id from EOF_EAI_Service_Log__c where EOF_CODICE_ORDINE_OLO__c=:codiceOrdineOLO and recordtype.developername='OF_SA_FIberRequest'
                                                and OF_SA_Direzione_Flusso__c='SF-OM' order by createdDate ASC limit 1]; 
            if(OF_SA_GE_Utils.caseOriginale.recordtype.developername=='OF_SA_Attivazione'){
                
                OF_SA_GE_Utils.ListSlActivationSFOM=[select Id,RecordTypeId ,EOF_Tipo_COmunicazione_String__c,OF_SA_Direzione_Flusso__c,
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
                                                    
                OF_SA_GE_Utils.ListVLan=new List<EOF_EAI_Service_LOg__c>();
                OF_SA_GE_Utils.ListApp=new List<EOF_EAI_Service_LOg__c>();
                OF_SA_GE_Utils.ListServAgg=new List<EOF_EAI_Service_LOg__c>();                                    
                for(EOF_EAI_service_Log__c sl : OF_SA_GE_Utils.ListSlActivationSFOM){
                    if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                        OF_SA_GE_Utils.slSFOM=sl;   
                    }
                    if(sl.recordtype.developername=='OF_SA_Vlan'){
                        OF_SA_GE_Utils.checkVLan=true;
                        OF_SA_GE_Utils.ListVLan.add(sl);
                    }
                    if(sl.recordtype.developername=='OF_SA_Cpe'){
                        OF_SA_GE_Utils.checkApp=true;
                        OF_SA_GE_Utils.ListApp.add(sl);
                    }
                    if(sl.recordtype.developername=='OF_SA_Servizi_Aggiuntivi'){
                        OF_SA_GE_Utils.checkServAgg=true;
                        OF_SA_GE_Utils.ListServAgg.add(sl);
                    }
                }
                OF_SA_OLO_SendToOM.OM_CreateAckNackRequestActivation(OF_SA_GE_Utils.ListSlActivationSFOM);
                //indipendentemente dall'ACK o NACK da OM glli aggiornamenti sono sempre gli stessi
                List<EOF_EAI_service_Log__c> slListToUpsert =  new List<EOF_EAI_service_Log__c>();
                slListToUpsert.add(OF_SA_GE_Utils.slSFOM);
                OF_SA_GE_Utils.slSFOMResp.EOF_sl_riferimento__c=OF_SA_GE_Utils.slSFOM.Id;
                slListToUpsert.add(OF_SA_GE_Utils.slSFOMResp);
                upsert slListToUpsert;
                update OF_SA_GE_Utils.caseOriginale;
            }
            else{
                //call OM Cessazione
                OF_SA_GE_Utils.ListSlDeactivationSFOM=[select Id,EOF_Tipo_COmunicazione_String__c,OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,
                                                        EOF_CODICE_OPERATORE__C,EOF_CODICE_ORDINE_OLO__C,EOF_CODICE_ORDINE_EOF__C,EOF_DATA_NOTIFICA__C,
                                                        EOF_ID_NOTIFICA__C,EOF_CODICE_MOTIVAZIONE__c,EOF_MOTIVAZIONE__c,EOF_NOME_CLIENTE__c,
                                                        EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                        EOF_NOTE__c,EOF_ID_RISORSA__c ,EOF_SORGENTE__c ,EOF_SLA_DATE__c ,EOF_GPON_VINCOLANTE__c ,
                                                        EOF_OPZIONE_SYSTEM_UNICO__c ,EOF_COLLEGAMENTO_P2P__c ,EOF_TRACCIATO__c ,caso__c,
                                                        EOF_Tipo_COmunicazione__c,EOF_Stato_Ordine__c,EOF_GPON_Attestazione__c,EOF_ID_SERVIZIO__c ,
                                                        EOF_PROFILO__c ,EOF_Provincia__c ,EOF_Comune__c,EOF_Particella_Toponomastica__c ,EOF_Indirizzo__c ,
                                                        EOF_Numero_Civico__c ,recordtypeId,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ID_APPARATO__C,OF_SA_Cpe_Log__c,
                                                        EOF_Ordine_Invio_OLO__c,recordtype.developername
                                                        from EOF_EAI_Service_Log__c where id =:slOM.Id 
                                                        OR OF_SA_Cpe_Log__c =:slOM.Id
                                                        order by EOF_Ordine_Invio_OLO__c];
                OF_SA_GE_Utils.ListApp=new List<EOF_EAI_Service_LOg__c>();
                for(EOF_EAI_service_Log__c sl : OF_SA_GE_Utils.ListSlDeactivationSFOM){
                    if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                        OF_SA_GE_Utils.slSFOM=sl;    
                    }
                    if(sl.recordtype.developername=='OF_SA_Cpe'){
                        OF_SA_GE_Utils.checkApp=true;
                        OF_SA_GE_Utils.ListApp.add(sl);
                    } 
                }
                OF_SA_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(OF_SA_GE_Utils.ListSlDeactivationSFOM);
                //indipendentemente dall'ACK o NACK da OM glli aggiornamenti sono sempre gli stessi
                List<EOF_EAI_service_Log__c> slListToUpsert =  new List<EOF_EAI_service_Log__c>();
                slListToUpsert.add(OF_SA_GE_Utils.slSFOM);
                OF_SA_GE_Utils.slSFOMResp.EOF_sl_riferimento__c=OF_SA_GE_Utils.slSFOM.Id;
                slListToUpsert.add(OF_SA_GE_Utils.slSFOMResp);
                upsert slListToUpsert;
                update OF_SA_GE_Utils.caseOriginale; 
            }
        }
    }
    
    
}
public without sharing class OF_TTM_SendRetryTTM_Methods {
    //Liste per upsert
    public static List<EOF_EAI_Service_Log__c> successList = new List<EOF_EAI_Service_Log__c>();
    public static List<EOF_EAI_Service_Log__c> nackList = new List<EOF_EAI_Service_Log__c>();
    //Variabile per contare quante request sono state inviate correttamente
    public static Integer stagingCountToRemove = 0;
    public static Boolean retryHasNackTecnicoTTM = false;
    public static Boolean retryHasNackTecnicoOLO = false;
    public static Boolean boolSkipSomeTTM = false;
    public static Integer nackCountOLOTTM = 0;

    @future(callout=true)
    public static void retryCalloutToTTM(String caseId){
        
        //AA Aggiunto recupero rt utilizzando 1 sola query
        if(!OF_TTM_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_TTM_Utils.RTMap = new  map<String,String>();

            for(recordtype rt : [select id,developername from recordtype]){
                OF_TTM_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_TTM_Utils.checkRTMap=true;
        }  
        //setto la variabile retry che andrò a mettere sui sl
        OF_TTM_Utils.retry=true; 

        //Recupero il case di riferimento
        OF_TTM_Utils.caseOriginale = [SELECT Id, OF_Response_Da_OLO__c, OF_Response_da_TTM__c, Codice_Ordine_EOF__c, EOF_Codice_Comunicazione_OLO__c, Staging_retry__c
                                      FROM Case
                                      WHERE Id = :caseId
                                      LIMIT 1];

        OF_TTM_Utils.caseOriginale.OF_Retry_Automatico__c=false;
        //Controllo se la retry deve essere fatta verso OLO
        if ( OF_TTM_Utils.caseOriginale.OF_Response_Da_OLO__c=='NACK TECNICO' ){
            boolSkipSomeTTM = true;
            //Recupero la lista di sLog per riprovare la chiamata a OLO
            List<EOF_EAI_Service_Log__c> listasLogOLO = [SELECT Id, RecordTypeId, OF_SA_Direzione_Flusso__c, EOF_Codice_Ordine_EOF__c, EOF_Tipo_Comunicazione__c, EOF_Tipo_Comunicazione_String__c,
                                                                EOF_Codice_Operatore__c, EOF_Codice_Comunicazione_OLO__c, EOF_Categoria_Guasto__c, EOF_ID_Notifica__c, EOF_ID_Risorsa__c,
                                                                EOF_Data_Ora_Inizio_Guasto__c, EOF_Data_Ora_Richiesta_Annullamento__c, EOF_Data_Ora_Desospensione__c, EOF_Data_Ora_Autoripristinato__c,
                                                                EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c, EOF_Causale_Desospensione__c, EOF_SLA_DATE__c, EOF_Data_Notifica__c, EOF_Data_Provisioning_Servizio__c,
                                                                EOF_Nome_Cliente__c, EOF_COgnome_CLiente__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c, EOF_RECAPITO_TELEFONICO_CLIENTE_2__c, EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                                EOF_TELEFONO_REFERENTE_TECNICO_OLO__c, EOF_EMAIL_REFERENTE_TECNICO_OLO__c, EOF_Verifica_apparato_cliente__c, EOF_Descrizione_Problema__c, EOF_Causale_Apertura__c,
                                                                EOF_Intervento_Congiunto__c, EOF_Tec_OLO__c, EOF_Tel_Tec_OLO__c, EOF_Data_Ora_Intervento_Congiunto__c, EOF_TIPOLOGIA_SERVIZIO__c, 
                                                                EOF_SLA_PREMIUM_ASSURANCE__c, EOF_Richiesta_Notifica__c, EOF_Note__c, EOF_NOTE_CLIENTE__c, Caso__c, Ordine_retry__c, EOF_Response__c,
                                                                EOF_Stato_Ticket__c, EOF_Data_Ora_Scarto__c, EOF_Data_Ora_Creazione__c, EOF_Data_Ora_Notifica_Sospensione__c, EOF_Data_Ora_Notifica_Desospensione__c,
                                                                EOF_Data_Ora_Notifica_Annullamento__c, EOF_Data_Ora_Notifica_Chiusura__c, Causale_Scarto__c, EOF_Descrizione_Causale_Scarto__c,
                                                                Causale_Sospensione__c, EOF_Referente_desospensione__c, Descrizione_Evento_Risoluzione__c, EOF_Rischedulazione_Appuntamento__c,
                                                                EOF_Tec_Eof__c, EOF_Tel_Tec_Eof__c,OF_TT_Data_Ora_Inizio_SLA__c,EOF_ID_SERVIZIO__c
                                                        FROM EOF_EAI_Service_Log__c
                                                        WHERE Caso__c = :OF_TTM_Utils.caseOriginale.Id
                                                        AND EOF_Response__c = 'NACK TECNICO'
                                                        AND EOF_Tipo_Comunicazione_String__c LIKE '%OLO%'];
            for (EOF_EAI_Service_Log__c reqsLog : listasLogOLO){
                if(!retryHasNackTecnicoOLO){
                    makeRetryCalloutOLO(reqsLog);
                }else{//Se c'è stato un NACK TECNICO, aggiungo tutti i log alla lista dei nack e gli andrò ad aggiornare l'ordine retry
                    nackList.add(reqsLog);
                } 
            }
        }
        //Controllo se la retry è verso TTM 
        if ( OF_TTM_Utils.caseOriginale.OF_Response_da_TTM__c=='NACK TECNICO' ){
            boolSkipSomeTTM = false;
            //nackCountOLOTTM = 0;
            //Booleano per vedere se ci sono stati nack tecnici, se si, blocco tutto e riprovo
            retryHasNackTecnicoTTM = false;
            //Recupero la lista di sLog per riprovare la chiamata a TTM
            List<EOF_EAI_Service_Log__c> listasLogTTM = [SELECT Id, RecordTypeId, OF_SA_Direzione_Flusso__c, EOF_Codice_Ordine_EOF__c, EOF_Tipo_Comunicazione__c, EOF_Tipo_Comunicazione_String__c,
                                                                EOF_Codice_Operatore__c, EOF_Codice_Comunicazione_OLO__c, EOF_Categoria_Guasto__c, EOF_ID_Notifica__c, EOF_ID_Risorsa__c,
                                                                EOF_Data_Ora_Inizio_Guasto__c, EOF_Data_Ora_Richiesta_Annullamento__c, EOF_Data_Ora_Desospensione__c, EOF_Data_Ora_Autoripristinato__c,
                                                                EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c, EOF_Causale_Desospensione__c, EOF_SLA_DATE__c, EOF_Data_Notifica__c, EOF_Data_Provisioning_Servizio__c,
                                                                EOF_Nome_Cliente__c, EOF_COgnome_CLiente__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c, EOF_RECAPITO_TELEFONICO_CLIENTE_2__c, EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                                EOF_TELEFONO_REFERENTE_TECNICO_OLO__c, EOF_EMAIL_REFERENTE_TECNICO_OLO__c, EOF_Verifica_apparato_cliente__c, EOF_Descrizione_Problema__c, EOF_Causale_Apertura__c,
                                                                EOF_Intervento_Congiunto__c, EOF_Tec_OLO__c, EOF_Tel_Tec_OLO__c, EOF_Data_Ora_Intervento_Congiunto__c, EOF_TIPOLOGIA_SERVIZIO__c, 
                                                                EOF_SLA_PREMIUM_ASSURANCE__c, EOF_Richiesta_Notifica__c, EOF_Note__c, EOF_NOTE_CLIENTE__c, Caso__c, Ordine_retry__c, EOF_Response__c,
                                                                OF_TT_Data_Ora_Inizio_SLA__c,EOF_ID_SERVIZIO__c
                                                        FROM EOF_EAI_Service_Log__c
                                                        WHERE Caso__c = :OF_TTM_Utils.caseOriginale.Id
                                                        AND Ordine_retry__c > 0
                                                        AND EOF_Response__c = 'NACK TECNICO'
                                                        AND EOF_Tipo_Comunicazione_String__c LIKE '%TTM%'
                                                        ORDER BY Ordine_retry__c];
            
            for (EOF_EAI_Service_Log__c reqsLog : listasLogTTM){
                if(!retryHasNackTecnicoTTM){
                    makeRetryCalloutTTM(reqsLog);
                }else{//Se c'è stato un NACK TECNICO, aggiungo tutti i log alla lista dei nack e gli andrò ad aggiornare l'ordine retry
                    nackList.add(reqsLog);
                } 
            }
        }
        //ALLA FINE DEI DUE IF
        if(nackList.isEmpty()){//Se non ci sono stati nack tecnici
            upsert successList;
        }else{//Caso in cui ci sono stati nack tecnici
            Integer stagingretry = 0;
            for(EOF_EAI_Service_Log__c nackLog : nackList){
                stagingretry += 1;
                nackLog.Ordine_retry__c = stagingretry;
            }
            if(!successList.isEmpty()){
                upsert successList;
            }
            upsert nackList;
        }
        OF_TTM_Utils.caseOriginale.Staging_retry__c = (OF_TTM_Utils.caseOriginale.Staging_retry__c - stagingCountToRemove) + nackCountOLOTTM;
        update OF_TTM_Utils.caseOriginale; 
    }
    
    //Metodo callout verso TTM, in modo da non dover scrivere due volte lo stesso codice
    public static void makeRetryCalloutTTM(EOF_EAI_Service_Log__c reqsLog){
        OF_TTM_ForwardRequest.SyncPortTypeEndpoint1 stub = new OF_TTM_ForwardRequest.SyncPortTypeEndpoint1();          
        stub.timeout_x=30000; 
        //Istanzio l'oggetto per contenere la response
        OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element response = new OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element();
        //Invoking the callout with corresponding parameters
        response = stub.ForwardTroubleTicket_TTM(reqsLog);

        if(Integer.valueOf(response.Esito) == 0){//ACK DA TTM
            //Setto il campo del case ad ACK (Verrà fatto un solo update, se becca altri nack tecnici, mantiene l'ultimo valore)
            OF_TTM_Utils.caseOriginale.OF_Response_da_TTM__c = 'ACK';
            //Azzero il campo ordine retry e setto il campo response ad "ACK"
            reqsLog.Ordine_retry__c = 0;
            reqsLog.EOF_Response__c = 'ACK';
            //Aggiungo alla lista delle richieste andate in ACK e successivamente faccio l'upsert
            if(!boolSkipSomeTTM){
                stagingCountToRemove += 1;
            }
            successList.add(reqsLog);
            //Creo il sLog della response e lo aggiungo alla lista su cui andrò a fare l'upsert
            successList.add(new EOF_EAI_Service_Log__c(
                                Caso__c = reqsLog.Caso__c,
                                RecordTypeId = OF_TTM_Utils.RTMap.get('TT_ACK'),
                                EOF_Richiesta_Notifica__c =  'Esito:'+ response.Esito,     
                                EOF_ID_Notifica__c = reqsLog.EOF_ID_Notifica__c,
                                EOF_Codice_Operatore__c = reqsLog.EOF_Codice_Operatore__c,
                                EOF_Data_Notifica__c = reqsLog.EOF_Data_Notifica__c,
                                EOF_Tipo_Comunicazione__c = reqsLog.EOF_Tipo_Comunicazione__c,
                                EOF_Tipo_Comunicazione_String__c = 'SF -> TTM - TT ACK ' + OF_TTM_Utils.getStringTipoComunicazione(reqsLog.EOF_Tipo_Comunicazione__c),
                                EOF_Codice_Comunicazione_OLO__c=reqsLog.EOF_Codice_Comunicazione_OLO__c,
                                EOF_SL_Riferimento__c = reqsLog.Id   
                            ));
        }else{//NACK DA TTM
            if (response.codice_motivazione=='A_K8' ){//Caso di nack tecnico, blocco tutto
                if(boolSkipSomeTTM){//Se provengo da olo e TTM mi dà nack tecnico, lo aggiungo dopo nella stagin retry
                    nackCountOLOTTM = 1;
                    reqsLog.EOF_Response__c = 'NACK TECNICO';
                    insert reqsLog;
                }
                //Setto il campo del case ad ACK (Verrà fatto un solo update, se becca altri nack tecnici, mantiene l'ultimo valore)
                OF_TTM_Utils.caseOriginale.OF_Response_da_TTM__c = 'NACK TECNICO';
                retryHasNackTecnicoTTM = true;
                nackList.add(reqsLog);
            }else{//In caso di nack, setto semplicemente il campo response a NACK
                //Setto il campo del case ad ACK (Verrà fatto un solo update, se becca altri nack tecnici, mantiene l'ultimo valore)
                OF_TTM_Utils.caseOriginale.OF_Response_da_TTM__c = 'NACK';
                if(!boolSkipSomeTTM){
                    stagingCountToRemove += 1;
                }
                reqsLog.Ordine_retry__c = 0;
                reqsLog.EOF_Response__c = 'NACK';
                successList.add(reqsLog);
            }
            //Vado a creare il log di NACK 
            successList.add(new EOF_EAI_Service_Log__c(
                                Caso__c = reqsLog.Caso__c,
                                RecordTypeId = OF_TTM_Utils.RTMap.get('TT_NACK'),
                                EOF_Richiesta_Notifica__c = 'Esito:'+ response.Esito + '\n' + 'Codice errore: ' + 
                                                            response.codice_motivazione + '\n' + 'Causale errore: ' +
                                                            response.motivazione,
                                EOF_Codice_errore__c=response.codice_motivazione,
                                EOF_Causale_Errore__c=response.motivazione,     
                                EOF_ID_Notifica__c = reqsLog.EOF_ID_Notifica__c,
                                EOF_Codice_Operatore__c = reqsLog.EOF_Codice_Operatore__c,
                                EOF_Data_Notifica__c = reqsLog.EOF_Data_Notifica__c,
                                EOF_Tipo_Comunicazione__c = reqsLog.EOF_Tipo_Comunicazione__c,
                                EOF_Tipo_Comunicazione_String__c = 'SF -> TTM - TT NACK ' + OF_TTM_Utils.getStringTipoComunicazione(reqsLog.EOF_Tipo_Comunicazione__c),
                                EOF_Codice_Comunicazione_OLO__c=reqsLog.EOF_Codice_Comunicazione_OLO__c,
                                EOF_SL_Riferimento__c = reqsLog.Id       
                            ));
        }
    }
    //Metodo callout verso OLO
    public static void makeRetryCalloutOLO(EOF_EAI_Service_Log__c reqsLog){
        OF_TT_WS_Notifica.TroubleTicketNotifyResp_element response = new OF_TT_WS_Notifica.TroubleTicketNotifyResp_element();
        OF_TT_WS_Sincronizzazione.SyncPortTypeEndpoint1 stub = new OF_TT_WS_Sincronizzazione.SyncPortTypeEndpoint1();          
        stub.timeout_x=30000; 
        //Invoking the callout with corresponding parameters
        response = stub.NotifyTroubleTicket(reqsLog.EOF_Codice_Operatore__c,
                                            reqsLog.EOF_Tipo_Comunicazione__c, 
                                            reqsLog.EOF_Codice_Comunicazione_OLO__c,                                                                        
                                            reqsLog.EOF_ID_Notifica__c,
                                            reqsLog.EOF_ID_Risorsa__c,
                                            reqsLog.EOF_Stato_Ticket__c,
                                            OF_TTM_Utils.dateToString(reqsLog.EOF_Data_Ora_Scarto__c),
                                            OF_TTM_Utils.dateToString(reqsLog.EOF_Data_Ora_Creazione__c),
                                            OF_TTM_Utils.dateToString(reqsLog.EOF_Data_Ora_Notifica_Sospensione__c),
                                            OF_TTM_Utils.dateToString(reqsLog.EOF_Data_Ora_Notifica_Desospensione__c),
                                            OF_TTM_Utils.dateToString(reqsLog.EOF_Data_Ora_Notifica_Annullamento__c),
                                            OF_TTM_Utils.dateToString(reqsLog.EOF_Data_Ora_Notifica_Chiusura__c),
                                            reqsLog.Causale_Scarto__c,
                                            reqsLog.EOF_Descrizione_Causale_Scarto__c,
                                            OF_TTM_Utils.getValueCausaleSospensione(reqsLog.Causale_Sospensione__c),
                                            reqsLog.EOF_Referente_desospensione__c,
                                            OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(reqsLog.Descrizione_Evento_Risoluzione__c),
                                            reqsLog.EOF_Note__c,
                                            OF_TTM_Utils.dateToString(reqsLog.EOF_Rischedulazione_Appuntamento__c),
                                            reqsLog.EOF_Intervento_Congiunto__c,
                                            reqsLog.EOF_Tec_Eof__c,
                                            reqsLog.EOF_Tel_Tec_Eof__c,
                                            OF_TTM_Utils.dateToString(reqsLog.EOF_Data_Ora_Intervento_Congiunto__c)
                                        );

        if(Integer.valueOf(response.Esito) == 0){//OLO CI RISPONDE ACK
            //Setto il campo del case ad ACK (Verrà fatto un solo update, se becca altri nack tecnici, mantiene l'ultimo valore)
            OF_TTM_Utils.caseOriginale.OF_Response_Da_OLO__c = 'ACK';
            //Azzero il campo ordine retry e setto il campo response ad "ACK"
            reqsLog.Ordine_retry__c = 0;
            reqsLog.EOF_Response__c = 'ACK';
            //Aggiungo alla lista delle richieste andate in ACK e successivamente faccio l'upsert
            stagingCountToRemove += 1;
            //Aggiungo il log alla lisa dei success
            successList.add(reqsLog);
            //Aggiungo la response ai log
            successList.add(new EOF_EAI_Service_Log__c(
                                Caso__c = reqsLog.Caso__c,
                                RecordTypeId = OF_TTM_Utils.RTMap.get('TT_ACK'),
                                EOF_Richiesta_Notifica__c =  'Esito:'+ response.Esito,     
                                EOF_ID_Notifica__c = reqsLog.EOF_ID_Notifica__c,
                                EOF_Codice_Operatore__c = reqsLog.EOF_Codice_Operatore__c,
                                EOF_Data_Notifica__c = reqsLog.EOF_Data_Notifica__c,
                                EOF_Tipo_Comunicazione__c = reqsLog.EOF_Tipo_Comunicazione__c,
                                EOF_Tipo_Comunicazione_String__c = 'SF -> OLO - TT ACK ' + OF_TTM_Utils.getStringTipoComunicazione(reqsLog.EOF_Tipo_Comunicazione__c),
                                EOF_Codice_Comunicazione_OLO__c=reqsLog.EOF_Codice_Comunicazione_OLO__c,
                                EOF_SL_Riferimento__c = reqsLog.Id
                            )    
            );
            //Se OLO ci risponde ACK, ci giriamo verso TTM
            EOF_EAI_Service_Log__c sLog = prepareLogForTTM(reqsLog, reqsLog.EOF_Tipo_Comunicazione__c);
            makeRetryCalloutTTM(sLog);
        }else{//OLO CI RISPONDE NACK
            if (response.CodiceErrore=='A_K8' ){//Caso di nack tecnico, blocco tutto
                //Setto il campo del case ad ACK (Verrà fatto un solo update, se becca altri nack tecnici, mantiene l'ultimo valore)
                OF_TTM_Utils.caseOriginale.OF_Response_Da_OLO__c = 'NACK TECNICO';
                retryHasNackTecnicoOLO = true;
                nackList.add(reqsLog);
            }else{//In caso di nack, setto semplicemente il campo response a NACK
                //Setto il campo del case ad ACK (Verrà fatto un solo update, se becca altri nack tecnici, mantiene l'ultimo valore)
                OF_TTM_Utils.caseOriginale.OF_Response_Da_OLO__c = 'NACK';
                stagingCountToRemove += 1;
                reqsLog.Ordine_retry__c = 0;
                reqsLog.EOF_Response__c = 'NACK';
                successList.add(reqsLog);
            }
            //Aggiungo il log di NACK
            successList.add(new EOF_EAI_Service_Log__c(
                                Caso__c = reqsLog.Caso__c,
                                RecordTypeId = OF_TTM_Utils.RTMap.get('TT_NACK'),
                                EOF_Richiesta_Notifica__c = 'Esito:'+ response.Esito + '\n' + 'Codice errore: ' + 
                                response.CodiceErrore + '\n' + 'Causale errore: ' +
                                response.CausaleErrore,
                                EOF_Codice_errore__c=response.CodiceErrore,
                                EOF_Causale_Errore__c=response.CausaleErrore,     
                                EOF_ID_Notifica__c = reqsLog.EOF_ID_Notifica__c,
                                EOF_Codice_Operatore__c = reqsLog.EOF_Codice_Operatore__c,
                                EOF_Data_Notifica__c = reqsLog.EOF_Data_Notifica__c,
                                EOF_Tipo_Comunicazione__c = reqsLog.EOF_Tipo_Comunicazione__c,
                                EOF_Tipo_Comunicazione_String__c = 'SF -> OLO - TT NACK ' + OF_TTM_Utils.getStringTipoComunicazione(reqsLog.EOF_Tipo_Comunicazione__c),
                                EOF_Codice_Comunicazione_OLO__c=reqsLog.EOF_Codice_Comunicazione_OLO__c,
                                EOF_SL_Riferimento__c = reqsLog.Id     
                            )
            ); 
        }
    }
    //Metodo per preparare il log da inviare a TTM
    private static EOF_EAI_Service_Log__c prepareLogForTTM(EOF_EAI_Service_Log__c req, String tipo_comunicazione){
        //AA Aggiunto recupero rt utilizzando 1 sola query
        if(!OF_TTM_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_TTM_Utils.RTMap = new  map<String,String>();

            for(recordtype rt : [select id,developername from recordtype]){
                OF_TTM_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_TTM_Utils.checkRTMap=true;
        }   
        OF_TTM_Utils.checkAsset = false;
        //OF_TTM_Utils.checkCase = false;
        List<Asset> asset;
        //List<Case> caseAttivazione;
        if(req.EOF_Id_Risorsa__c != null && String.isNotBlank(req.EOF_Id_Risorsa__c) ){
            asset = [SELECT Id,Name,EOF_ID_Risorsa__c, CreatedDate, RecordType.DeveloperName, EOF_SLA_Premium_Assurance__c
                     FROM Asset
                     WHERE Name =: req.EOF_Id_Risorsa__c 
                    ];
            if(asset.size() > 0){
                /*caseAttivazione = [SELECT Id, EOF_SLA_Premium_Assurance__c, OF_SA_ID_Servizio__c
                                   FROM Case 
                                   WHERE (RecordType.DeveloperName = 'OF_SA_Attivazione' OR RecordType.DeveloperName = 'EOF_Caso_Attivazione') 
                                   AND AssetId = :asset[0].Id
                                        ];
                if (caseAttivazione.size() > 0 ){
                    OF_TTM_Utils.checkCase = true;
                }*/
                OF_TTM_Utils.checkAsset = true;
            }
        }
        
        Case caseToUpdate = [SELECT Id, Codice_Ordine_EOF__c, OF_Response_da_TTM__c, EOF_Codice_Comunicazione_OLO__c, Staging_retry__c,
        					OF_SA_ID_Servizio__c,createddate
                             FROM Case
                             WHERE EOF_Codice_Comunicazione_OLO__c = :req.EOF_Codice_Comunicazione_OLO__c
                             LIMIT 1];
        EOF_EAI_Service_Log__c sLogSFTTM = OF_TTM_Utils.createTTRequestLogSFTTM(req,asset,/*caseAttivazione,*/caseToUpdate,tipo_comunicazione);
        sLogSFTTM.Caso__c = req.Caso__c;
        return sLogSFTTM;
        //Istanzio i campi per popolare la request
        /*String ID_REQ_FORWARD2TTM = caseToUpdate.Codice_Ordine_EOF__c;

        OF_TTM_ForwardRequest_Element.REQ_FORWARD2TTM_element request = new OF_TTM_ForwardRequest_Element.REQ_FORWARD2TTM_element();
        request.tipo_comunicazione = tipo_comunicazione;
        request.codice_operatore = req.EOF_Codice_Operatore__c;
        request.codice_comunicazione_olo = req.EOF_Codice_Comunicazione_OLO__c;
        request.categoria_guasto = req.EOF_Categoria_Guasto__c;
        request.id_notifica = req.EOF_ID_Notifica__c;
        request.id_risorsa = req.EOF_ID_Risorsa__c;
        request.data_ora_inizio_guasto = OF_TTM_Utils.DateToString(req.EOF_Data_Ora_Inizio_Guasto__c);
        request.data_ora_richiesta_annullamento = OF_TTM_Utils.DateToString(req.EOF_Data_Ora_Richiesta_Annullamento__c);
        request.data_ora_desospensione = OF_TTM_Utils.DateToString(req.EOF_Data_Ora_Desospensione__c);
        request.data_ora_autoripristinato = OF_TTM_Utils.DateToString(req.EOF_Data_Ora_Autoripristinato__c);
        request.causale_richiesta_annullamento = req.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c;
        request.causale_desospensione = req.EOF_Causale_Desospensione__c;
        request.data_ora_inizio_sla = OF_TTM_Utils.DateToString(req.EOF_Data_Notifica__c);
        if (tipo_comunicazione=='12'){
            request.data_ora_notifica_olo = OF_TTM_Utils.DateToString(req.EOF_Data_Notifica__c);
        }else{
            request.data_ora_notifica_olo = '';
        }
        request.data_provisioning_servizio = (checkAsset) ? OF_TTM_Utils.DateToString(asset[0].CreatedDate) : '';
        request.nome_cliente = req.EOF_Nome_Cliente__c;
        request.cognome_cliente = req.EOF_COgnome_CLiente__c;
        request.recapito_telefonico_cliente_1 = req.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
        request.recapito_telefonico_cliente_2 = req.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
        request.nome_referente_tecnico_olo = req.EOF_NOME_REFERENTE_TECNICO_OLO__c;
        request.telefono_referente_tecnico_olo = req.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;
        request.email_referente_tecnico_olo = req.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
        request.note_cliente = req.EOF_NOTE_CLIENTE__c;
        request.note = req.EOF_Note__c;
        request.verifica_apparato = req.EOF_Verifica_apparato_cliente__c;
        request.descrizione_problema = req.EOF_Descrizione_Problema__c;
        request.causale_apertura = req.EOF_Causale_Apertura__c;
        request.intervento_congiunto = req.EOF_Intervento_Congiunto__c;
        request.tec_olo = req.EOF_Tec_OLO__c;
        request.tel_tec_olo = req.EOF_Tel_Tec_OLO__c;
        request.data_ora_intervento_congiunto = OF_TTM_Utils.DateToString(req.EOF_Data_Ora_Intervento_Congiunto__c);
        request.service_type = (checkAsset) ? OF_TTM_Utils.getServiceTypeFromRTDevName(asset[0].RecordType.DeveloperName) : '';
        request.sla_type = (checkCase) ? OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(caseAttivazione[0].EOF_SLA_Premium_Assurance__c) : '';
        request.orderid = null;
        
        //Creo il log della request
        EOF_EAI_Service_Log__c sLogSFTTM = OF_TTM_Utils.createTTRequestLogSFTTM(req,asset[0],caseAttivazione[0],caseToUpdate,tipo_comunicazione);
        sLogSFTTM.Caso__c = req.Caso__c;

        return sLogSFTTM;*/
    }
}
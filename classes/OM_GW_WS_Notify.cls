global class OM_GW_WS_Notify{
    
global class FiberNotify{
        webservice String CODICE_OPERATORE;
        webservice String TIPO_COMUNICAZIONE;        
        webservice String CODICE_ORDINE_OLO;
        webservice String CODICE_ORDINE_EOF;
        webservice String CODICE_ORDINE_OM;
        webservice String ID_NOTIFICA;
        webservice String STATO_RICHIESTA;
        webservice String GPON_ATTESTAZIONE;
        webservice String CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO;
        webservice String MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO;
        webservice String DATA_ESPLETAMENTO_ORDINE;
        webservice String ID_RISORSA;
        webservice String DATA_NOTIFICA;
        webservice String ID_APPARATO_CONSEGNATO;
        webservice String ESITO_CONSEGNA_APPARATO;
        webservice String PARAMETRI_TRASMISSIVI_OTTICI;
        webservice String ID_SPLITTER_SECONDARIO;
        webservice String POSIZIONE_SPLITTER_SECONDARIO;
        webservice String NUOVA_DAC;
        webservice String CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC;
        webservice String REASON_RIMODULAZIONE_CONFERMA_DAC;
        webservice String NOTE;
        webservice String FLAG_PAGAMENTO;
        webservice String NUMERO_OPERATORE;
        webservice String IMPRESA;
        webservice String TIPO_INTERVENTO;    
         //2018/08/24 MM : aggiunti nuovi campi per verticali
        webservice String ID_GIS_SCALA_PALAZZINA;
        webservice String SCALA;
        webservice String PALAZZINA;
        webservice String ESTENSIONE_IMPIANTO;
        webservice String METRI_TOT;
        webservice String ESTENSIONE_IMPIANTO_EFFETTUATA;
        //2018//08/24 MM : fine aggiunta.            
        }

global class returnNotifyResponse{
        webservice String Esito;
        webservice String CodiceErrore;
        webservice String CausaleErrore;
        }

webservice static returnNotifyResponse FiberNotify(FiberNotify fn){

    OM_GW_GE_Utils.CreateTemplogOM(fn);
    OM_GW_GE_Utils.AttrTime= datetime.now().getTime();     
    // 22/05/2018 MM : fine
    
    OM_GW_WS_Notify.returnNotifyResponse res_temp = new OM_GW_WS_Notify.returnNotifyResponse();
    res_temp.Esito = '';
    res_temp.CodiceErrore = '';
    res_temp.CausaleErrore = '';
    
    String caseId;
    String codiceOperatore;

    List<EOF_EAI_Service_Log__C> slList = new List<EOF_EAI_Service_Log__C>();
    EOF_EAI_Service_Log__C slInsOmNot;
    EOF_EAI_Service_Log__C slACKOmNot;
    
    //Generating FiberNotify Service Log da OM in qualsiasi caso ---------- primo LOG
    slInsOmNot = OM_GW_GE_Utils.create_EAI_Log(fn);
    
    // --------------------- controlli da togliere dopo adeguamento OM inizia qui
    if(String.isNotBlank(fn.Codice_Operatore)){
        if(fn.Codice_Operatore.length() >3){
             if(fn.Codice_Operatore.toUpperCase()=='WIND'){
                fn.Codice_Operatore='WN';
             }
             else if(fn.Codice_Operatore.toUpperCase()=='VODAFONE') {
                fn.Codice_Operatore='VF';
             }
             else if(fn.Codice_Operatore.toUpperCase()=='TISCALI') {
                fn.Codice_Operatore='TIS';
             }
             else{
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Codice Operatore');
             }
        }
        
    }
    else{
        //valorizzo io il campo codice operatore nel caso non sia popolato da OM
        if(String.isBlank(fn.codice_ordine_olo)){
            return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'Codice Ordine OLO');
        }
        else{
            List<Case> cList=[select ID,EOF_codice_Operatore_ws__c from Case where EOF_Codice_ordine_olo__C =:fn.codice_ordine_olo];
            if (cList.isEmpty()){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Codice Ordine OLO');
            }
            else{
                fn.codice_operatore=cList[0].EOF_codice_Operatore_ws__c;
            }
        }
        
    }
    // --------------------- finisce qui
    
    //faccio i controlli sincroni
    res_temp = OM_GW_Notify_Utils.checkSync(fn);   
    
    //se i controlli sincroni sono superati chiamo l'OLO, se esito 1 non ho superato i controlli sincroni dovrò creare il OM->SF NACK
    if(res_temp.Esito == '0'){
    
        try{
            //Calling OLO Upon sync check positive result 
            //creo l'ACk per verificare cosa gli hho inviato, 
            //uso i campi del res_temp per inviare id del case e codice operatore recuperato dal case(come da CR)
            caseId=res_temp.CausaleErrore;
            codiceOperatore = res_temp.COdiceErrore;
            
            //DA CANCELLARE APPENA POSSIBILE
            fn.Codice_Operatore=codiceOperatore;
            //reinizializzo i campi utilizzati
            res_temp.CausaleErrore='';
            res_temp.COdiceErrore='';
            OM_GW_GE_Utils.slSFOLO= OM_GW_GE_Utils.create_EAI_Log(fn, caseId, codiceOperatore); 
            res_temp = OM_GW_Notify_Utils.call_OLO(fn);
            
        }
        catch(Exception e ){
            //A callout exception occurred
            res_temp.Esito = '1';
            res_temp.CodiceErrore = 'A_K4';
            res_temp.CausaleErrore = 'Errore tecnico di interfaccia';
            //return res_temp;
        }
        //faccio il controllo sulla nuova response inviata 
        if(res_temp.Esito == '0'){
        
            //significa che ho ricevuto un ACK da OLO allora creo la notify 
            EOF_Notify__c n = OM_GW_Notify_Utils.create_notify_update_case(fn);
            OM_GW_GE_Utils.slSFOLO.notify__c=n.Id;
            
            //inserisco gli ACK nei due sl di riferimento
            slInsOmNot.EOF_Response__c='ACK';
            OM_GW_GE_Utils.slSFOLO.EOF_Response__c='ACK';
        
            //creo l'ack ricevuto da OLO    
            OM_GW_GE_Utils.slSFOLOResp = OM_GW_Notify_Utils.create_ack_nack(n, res_temp.Esito, res_temp.CodiceErrore, res_temp.CausaleErrore);
            OM_GW_GE_Utils.slSFOLOResp.EOF_Tipo_COmunicazione_String__c='SF->OLO - ACK - Fibernotify - '+OM_GW_GE_Utils.retSpec(fn);
            OM_GW_GE_Utils.slSFOLOResp.EOF_COdice_Ordine_OLO__C=fn.COdice_ordine_olo;
            
            
            
            //creo l'ack inviato ad OM
            slACKOmNot = OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                                     'Codice_operatore' => codiceOperatore,
                                                     'Codice_ordine_OLO' => fn.CODICE_ORDINE_OLO,
                                                     'ID_notifica' => fn.ID_NOTIFICA,
                                                     'Richiesta Notifica' => OM_GW_GE_Utils.Copy_notify_om(fn),
                                                     'Caso' => caseId,
                                                     'Tipo Comunicazione' => 'OM->SF - ACK - FiberNotify - '+OM_GW_GE_Utils.retSpec(fn)});
            
            
            //inserisco i service logs
            slList.add(slInsOmNot);
            slList.add(slACKOmNot);
            slList.add(OM_GW_GE_Utils.slSFOLO);
            slList.add(OM_GW_GE_Utils.slSFOLOResp);
            insert slList;
            
            //aggiorno gli ack con il riferimento ai relativi sl di riferimento
            List<EOF_EAI_Service_Log__C> slListToUpdate = new List<EOF_EAI_Service_Log__C>();
            slACKOmNot.EOF_SL_Riferimento__c=slInsOmNot.Id;
            OM_GW_GE_Utils.slSFOLOResp.EOF_SL_Riferimento__c=OM_GW_GE_Utils.slSFOLO.Id;
            slListToUpdate.add(slACKOmNot);
            slListToUpdate.add(OM_GW_GE_Utils.slSFOLOResp);
            update slListToUpdate;
            
            //aggiorno il CRM in asincrono
            if(OM_GW_GE_Utils.caseOriginale.status=='Accettato KO' || OM_GW_GE_Utils.caseOriginale.status=='Annullato' 
                || OM_GW_GE_Utils.caseOriginale.status=='Espletato KO' || OM_GW_GE_Utils.caseOriginale.status=='Espletato' 
                || OM_GW_GE_Utils.caseOriginale.status=='Cessato OK'){
                OM_GW_GE_Utils.aggiornamentoDatiCRM(OM_GW_GE_Utils.caseOriginale.Id,OM_GW_GE_Utils.slSFOLO.Id,OM_GW_GE_Utils.slSFOLOResp.Id);   
                      /* Add PG - 23-10 - Chiamata per Creazione Asset Verticale Servizi Passivi */
            
                Case caseVert=[select id,AccountId,AssetId,CaseNumber,OF_SCALA__C ,OF_PALAZZINA__c ,ID_GIS_SCALA_PALAZZINA__C from Case where Id=:OM_GW_GE_Utils.caseOriginale.Id];
                caseVert.OF_SCALA__C = fn.SCALA;
                caseVert.OF_PALAZZINA__c = fn.PALAZZINA;
                caseVert.ID_GIS_SCALA_PALAZZINA__C = fn.ID_GIS_SCALA_PALAZZINA;
                update caseVert;
                //Database.executeBatch(new OF_Verticali_Utils_Servizi_batch(caseVert.id));
                  // OF_Verticali_Utils_ServiziPassivi.createAssetVerticaleServPassivi(c, fn);
            
            
            }
            
            OM_GW_GE_Utils.EndTemplog();
            
            //reinvio l'ack a OM
            return res_temp;
        
        }
        else{
            //significa che ho ricevuto un NACK da OLO, quindi creo la notify e i due NACK
            EOF_Notify__c n=OM_GW_GE_Utils.create_Notify(fn, caseId, codiceOperatore);
            
            insert n;
            OM_GW_GE_Utils.slSFOLO.notify__c=n.Id;
            
            //inserisco i NACK nei due sl di riferimento
            slInsOmNot.EOF_Response__c='NACK';
            OM_GW_GE_Utils.slSFOLO.EOF_Response__c='NACK';
            
            
            OM_GW_GE_Utils.slSFOLOResp = OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'NACK',
                                                     'Codice_errore'=> res_temp.COdiceErrore,
                                                    'Causale_errore' => res_temp.CausaleErrore,
                                                     'Codice_operatore' => codiceOperatore,
                                                     'Codice_ordine_OLO' => fn.CODICE_ORDINE_OLO,
                                                     'ID_notifica' => fn.ID_NOTIFICA,
                                                     'Richiesta Notifica' => OM_GW_GE_Utils.Copy_notify_om(fn),
                                                     'Caso' => caseId,
                                                     'Tipo Comunicazione' => 'SF->OLO - NACK - FiberNotify - '+OM_GW_GE_Utils.retSpec(fn)});
            
            OM_GW_GE_Utils.slSFOLOResp.notify__c=n.Id;
            slACKOmNot = OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'NACK',
                                                    'Codice_errore'=> res_temp.COdiceErrore,
                                                    'Causale_errore' => res_temp.CausaleErrore,
                                                     'Codice_operatore' => codiceOperatore,
                                                     'Codice_ordine_OLO' => fn.CODICE_ORDINE_OLO,
                                                     'ID_notifica' => fn.ID_NOTIFICA,
                                                     'Richiesta Notifica' => OM_GW_GE_Utils.Copy_notify_om(fn),
                                                     'Tipo Comunicazione' => 'OM->SF - NACK - FiberNotify - '+OM_GW_GE_Utils.retSpec(fn)});
            slACKOmNot.caso__c=CaseId;
            
            slList.add(slInsOmNot);
            slList.add(OM_GW_GE_Utils.slSFOLO);
            slList.add(OM_GW_GE_Utils.slSFOLOResp);
            slList.add(slACKOmNot);
            insert slList;
            
            //aggiorno gli ack con il riferimento ai relativi sl di riferimento
            List<EOF_EAI_Service_Log__C> slListToUpdate = new List<EOF_EAI_Service_Log__C>();
            slACKOmNot.EOF_SL_Riferimento__c=slInsOmNot.Id;
            OM_GW_GE_Utils.slSFOLOResp.EOF_SL_Riferimento__c=OM_GW_GE_Utils.slSFOLO.Id;
            slListToUpdate.add(slACKOmNot);
            slListToUpdate.add(OM_GW_GE_Utils.slSFOLOResp);
            update slListToUpdate;
            
            OM_GW_GE_Utils.EndTemplog();            
            return res_temp;
            
        }
 
    }
    else{
        
        OM_GW_GE_Utils.EndTemplog();        
        return res_temp;
    }
    
 }

}
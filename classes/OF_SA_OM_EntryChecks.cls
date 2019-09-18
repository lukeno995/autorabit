public class OF_SA_OM_EntryChecks { 
    public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksNotifyCompletionOrder(OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co){

       // Aggiorno il timestamp. E.1 corrisponde a inizio check espletamento.
        OF_SA_GE_Utils.partialTemplog('E.1');
        // finisce qui
        
        if(string.isblank(co.CODICE_OPERATORE)){
            return OF_SA_GE_Utils.syncError (co,'A05','CODICE_OPERATORE'); 
        }      
          
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple){
            if(co.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        }        
        if(!olo_found){
             return OF_SA_GE_Utils.syncError (co,'A06','CODICE_OPERATORE');
        }
        
        if(string.isblank(co.CODICE_ORDINE_OLO) || co.CODICE_ORDINE_OLO.length()>18){
            if(string.isblank(co.CODICE_ORDINE_OLO)){
                return OF_SA_GE_Utils.syncError (co,'A05','CODICE_ORDINE_OLO');
            }
        } 

        if(string.isblank(co.CODICE_ORDINE_OF) || co.CODICE_ORDINE_OF.length()>18){
            if(string.isblank(co.CODICE_ORDINE_OF)){
                return OF_SA_GE_Utils.syncError (co,'A05','CODICE_ORDINE_OF');
            }
        }

        // Aggiorno il timestamp. QC.1 corrisponde a pre query.
        OF_SA_GE_Utils.partialTemplog('QC.1');
        // finisce qui
        
        //qui verifico che il case sia a sistema
        // 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni
        List<Case> cList = [select Id, status, PO_SA_Portale__C,OF_Order__c, OF_Blocked_Case__c, OF_SCALA__c, OF_PALAZZINA__c, ID_GIS_SCALA_PALAZZINA__c

                            from Case 
                            where EOF_Codice_Ordine_Olo__c =:co.Codice_Ordine_Olo 
                            AND Codice_Ordine_Eof__c =:co.Codice_Ordine_OF 
                            AND EOF_Codice_Operatore_WS__c=:co.CODICE_OPERATORE 
                            AND RecordType.DeveloperName = 'OF_SA_Attivazione'];
        
       // Aggiorno il timestamp. QC.2 corrisponde a post query.
        OF_SA_GE_Utils.partialTemplog('QC.2');
        // finisce qui

        if(cList.isEmpty()){
            return OF_SA_GE_Utils.syncError (co,'A06','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
        }
        else{
            OF_SA_GE_Utils.caseOriginale=cList[0];
            OF_SA_GE_Utils.checkCaseOriginale=true;
        }
        // 8/01/2018 Marco : fine modifica
        //verifico che lo status sia congruente
        //Done AA - 02/10/2018 - Controllare se il campo "OF_Blocked_Case__c" è valorizzato a true
        //TODO AA - 02/10/2018 - Condividere codice errore per blocked case
        if(OF_SA_GE_Utils.caseOriginale.OF_Blocked_Case__c){//C'è qualche status update dall'olo non notificato all'OM
            return OF_SA_GE_Utils.syncError (co,'A07','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
        } 
        if(cList[0].status!='Accettato'){
            return OF_SA_GE_Utils.syncError (co,'A03','Messaggio non ammesso');
        }

        
        if(string.isblank(co.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (co,'A05','DATA_NOTIFICA');
        } 
        if(!OF_SA_GE_Utils.checkDateTime(co.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (co,'A06','DATA_NOTIFICA');
        }
        
        
        
        if(string.isblank(co.ID_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (co,'A05','ID_NOTIFICA');
        }
        if(co.ID_NOTIFICA.length()>100){
            return OF_SA_GE_Utils.syncError (co,'A06','ID_NOTIFICA');
        }
            
        
        if(string.isblank(co.STATO_ORDINE) || co.STATO_ORDINE.length()>1){
            if(string.isblank(co.STATO_ORDINE)){
                return OF_SA_GE_Utils.syncError (co,'A05','STATO_ORDINE');
            }
            if(co.STATO_ORDINE!='0' && co.STATO_ORDINE!='1'){
                return OF_SA_GE_Utils.syncError (co,'A06','STATO_ORDINE');
            }
        }

        if(string.isblank(co.CODICE_MOTIVAZIONE)){
            return OF_SA_GE_Utils.syncError (co,'A05','CODICE_MOTIVAZIONE');
        }
        if(co.CODICE_MOTIVAZIONE.length()>3){
            return OF_SA_GE_Utils.syncError (co,'A06','CODICE_MOTIVAZIONE');
        }

        if(string.isblank(co.MOTIVAZIONE) || co.MOTIVAZIONE.length()>255){
            if(string.isblank(co.MOTIVAZIONE)){
                return OF_SA_GE_Utils.syncError (co,'A05','MOTIVAZIONE');
            }
            else{
                return OF_SA_GE_Utils.syncError (co,'A06','MOTIVAZIONE');
            }
        }
        
        if(co.STATO_ORDINE=='0' && string.isBlank(co.ID_RISORSA)){
            return OF_SA_GE_Utils.syncError (co,'A05','ID_RISORSA');
        }
        
        if(!string.isblank(co.ID_RISORSA) && co.ID_RISORSA.length()>50){
            return OF_SA_GE_Utils.syncError (co,'A06','ID_RISORSA');
        }
        
        
        if(string.isblank(co.DATA_ESPLETAMENTO_ORDINE)){
            return OF_SA_GE_Utils.syncError (co,'A05','DATA_ESPLETAMENTO_ORDINE');
        }
        if(!OF_SA_GE_Utils.checkDate(co.DATA_ESPLETAMENTO_ORDINE)){
            return OF_SA_GE_Utils.syncError (co,'A06','DATA_ESPLETAMENTO_ORDINE');
        }

        if(!string.isblank(co.DDT) && co.DDT.length()>255){
            return OF_SA_GE_Utils.syncError (co,'A06','DDT');
        }
        
        if(!string.isblank(co.NOTE) && co.NOTE.length()>255){
            return OF_SA_GE_Utils.syncError (co,'A06','NOTE');
        }
        
        Map<String,List<OF_commercialElementIstanziato__c>> ceiMap = new Map<String,List<OF_commercialElementIstanziato__c>>();
        
        if(co.STATO_ORDINE=='0'){
            List<String> cListCPE = new List<String>(); 
            List<String> cListSA = new List<String>();
            //creo una mappa per poi salvare i dati dell'espletamento sui commercial element instanziati
            
            List<OF_commercialElementIstanziato__c> ceiList =  [select ID,RecordType.DeveloperName,OF_Nome_Servizio__C,OF_TipologiaApparato__C from OF_CommercialElementIstanziato__c 
                                                            where (OF_SA_Servizio_Aggiuntivo__c=: co.CODICE_ORDINE_OF AND RecordType.DeveloperName='OF_ServiziAggiuntivi') 
                                                            or (OF_SA_CPE__c=: co.CODICE_ORDINE_OF AND RecordType.DeveloperName='OF_CPE')];
            for (OF_commercialElementIstanziato__c cei : ceiList){
                if(cei.RecordType.DeveloperName=='OF_CPE'){
                    //Vado a verificare se la map contiene già qualche valore
                    List<OF_CommercialElementIstanziato__c> cpeTypeList = ceiMap.get(cei.OF_TipologiaApparato__C.toUpperCase());
                    //Se non è stato ancora aggiunto nessuna CPE, vado a creare la lista
                    if(cpeTypeList == null){
                        cpeTypeList = new List<OF_CommercialElementIstanziato__c>();
                    }
                    cpeTypeList.add(cei);
                    cListCPE.add(cei.OF_TipologiaApparato__C.toUpperCase());
                    ceiMap.put(cei.OF_TipologiaApparato__C.toUpperCase(), cpeTypeList);
                }
                if(cei.RecordType.DeveloperName=='OF_ServiziAggiuntivi'){
                    //Vado a verificare se la map contiene già qualche valore
                    List<OF_CommercialElementIstanziato__c> servAggNameList = ceiMap.get(cei.OF_Nome_Servizio__c.toUpperCase());
                    //Se non è stato ancora aggiunto nessun ServAgg, vado a creare la lista
                    if(servAggNameList == null){
                        servAggNameList = new List<OF_CommercialElementIstanziato__c>();
                    }
                    servAggNameList.add(cei);
                    cListSA.add(cei.OF_Nome_Servizio__C.toUpperCase());
                    ceiMap.put(cei.OF_Nome_Servizio__c.toUpperCase(), servAggNameList);
                }
            }
            
            if(co.SERVIZIO_AGGIUNTIVO!=null){
                List<String> cListSAOM = new List<String>();
                for(OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO sai : co.SERVIZIO_AGGIUNTIVO){
                    cListSAOM.add(sai.NOME_SERVIZIO.toUpperCase());
                }
                cListSAOM.sort();
                cListSA.sort();
                if(cListSAOM.equals(cListSA)){
                    if(co.SERVIZIO_AGGIUNTIVO.size()>0){
                        for(OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO sai : co.SERVIZIO_AGGIUNTIVO){
                                if(string.isblank(sai.NOME_SERVIZIO)){
                                    return OF_SA_GE_Utils.syncError (co,'A05','NOME_SERVIZIO');
                                }
                                if(sai.NOME_SERVIZIO.length()>50){
                                    return OF_SA_GE_Utils.syncError (co,'A06','NOME_SERVIZIO');
                                }
                                if(string.isblank(sai.ESITO_SERVIZIO)){
                                    return OF_SA_GE_Utils.syncError (co,'A05','ESITO_SERVIZIO');
                                }
                                if(sai.ESITO_SERVIZIO.length()>1){
                                    return OF_SA_GE_Utils.syncError (co,'A06','ESITO_SERVIZIO');
                                }
                                if(sai.ESITO_SERVIZIO=='1'){
                                    if(string.isblank(sai.CODICE_MOTIVAZIONE_SERVIZIO)){
                                        return OF_SA_GE_Utils.syncError (co,'A05','CODICE_MOTIVAZIONE_SERVIZIO');
                                    }
                                    if(sai.CODICE_MOTIVAZIONE_SERVIZIO.length()>3){
                                        return OF_SA_GE_Utils.syncError (co,'A06','CODICE_MOTIVAZIONE_SERVIZIO');
                                    }
                                }
                                else {
                                    if(!string.isblank(sai.CODICE_MOTIVAZIONE_SERVIZIO) && sai.CODICE_MOTIVAZIONE_SERVIZIO.length()>3){
                                        return OF_SA_GE_Utils.syncError (co,'A06','CODICE_MOTIVAZIONE_SERVIZIO');
                                    }
                                }
                                if(sai.ESITO_SERVIZIO=='1'){
                                    if(string.isblank(sai.MOTIVAZIONE_SERVIZIO)){
                                        return OF_SA_GE_Utils.syncError (co,'A05','MOTIVAZIONE_SERVIZIO');
                                    }
                                    if(sai.MOTIVAZIONE_SERVIZIO.length()>255){
                                        return OF_SA_GE_Utils.syncError (co,'A06','MOTIVAZIONE_SERVIZIO');
                                    }
                                }
                                else {
                                    if(!string.isblank(sai.MOTIVAZIONE_SERVIZIO) && sai.MOTIVAZIONE_SERVIZIO.length()>255){
                                        return OF_SA_GE_Utils.syncError (co,'A06','CODICE_MOTIVAZIONE_SERVIZIO');
                                    }
                                }
                            }
                        
                    }
                }
                //caso liste non uguali
                else{   
                    return OF_SA_GE_Utils.syncError (co,'A06','Servizi Aggiuntivi');
                }
            }
            //caso servizi aggiuntivi = null
            else{
                if(cListSA.size()>0){
                    return OF_SA_GE_Utils.syncError (co,'A05','Servizi Aggiuntivi');
                }
            } 
            
            if(co.APPARATO!=null){
                List<String> cListCPEOM = new List<String>();
                for(OF_SA_WS_IN_OM_CompletionOrder.APPARATO cap : co.APPARATO){
                    cListCPEOM.add(cap.TIPOLOGIA_APPARATO.toUpperCase());
                }
                cListCPEOM.sort();
                cListCPE.sort();
                if(cListCPEOM.equals(cListCPE)){
                    if(!co.APPARATO.isempty()){
                        for(OF_SA_WS_IN_OM_CompletionOrder.APPARATO cap : co.APPARATO){
                            
                            if(string.isblank(cap.TIPOLOGIA_APPARATO)){
                                return OF_SA_GE_Utils.syncError (co,'A05','TIPOLOGIA_APPARATO');
                            }
                            if(cap.TIPOLOGIA_APPARATO.length()>100){
                                return OF_SA_GE_Utils.syncError (co,'A06','TIPOLOGIA_APPARATO');
                            }
                            if(string.isblank(cap.ESITO_CONSEGNA_APPARATO)){
                                return OF_SA_GE_Utils.syncError (co,'A05','ESITO_CONSEGNA_APPARATO');
                            }
                            if(cap.ESITO_CONSEGNA_APPARATO.length()>1){
                                return OF_SA_GE_Utils.syncError (co,'A06','ESITO_CONSEGNA_APPARATO');
                            }
                            // campo ID_APPARATO_CONSEGNATO obbligatorio solo se ESITO_CONSEGNA_APPARATO è 1,2,3
                            if(cap.ESITO_CONSEGNA_APPARATO=='1' || cap.ESITO_CONSEGNA_APPARATO=='2' || cap.ESITO_CONSEGNA_APPARATO=='3'){
    
                                if(string.isblank(cap.ID_APPARATO_CONSEGNATO)){
                                    return OF_SA_GE_Utils.syncError (co,'A05','ID_APPARATO_CONSEGNATO');
                                }
                                if(cap.ID_APPARATO_CONSEGNATO.length()>50){
                                    return OF_SA_GE_Utils.syncError (co,'A06','ID_APPARATO_CONSEGNATO');
                                }
                            }
                            else{
                                if(!string.isblank(cap.ID_APPARATO_CONSEGNATO) && cap.ID_APPARATO_CONSEGNATO.length()>50){
                                    return OF_SA_GE_Utils.syncError (co,'A06','ID_APPARATO_CONSEGNATO');
                                }
                            }
                            // campo CODICE_MOTIVAZIONE_CONSEGNA e campo MOTIVAZIONE_CONSEGNA obbligatori solo se ESITO_CONSEGNA_APPARATO è 0,3,5
                            if(cap.ESITO_CONSEGNA_APPARATO=='0' || cap.ESITO_CONSEGNA_APPARATO=='3' || cap.ESITO_CONSEGNA_APPARATO=='5'){
    
                                if(string.isblank(cap.CODICE_MOTIVAZIONE_CONSEGNA)){
                                    return OF_SA_GE_Utils.syncError (co,'A05','CODICE_MOTIVAZIONE_CONSEGNA');
                                }
                                if(cap.CODICE_MOTIVAZIONE_CONSEGNA.length()>3){
                                    return OF_SA_GE_Utils.syncError (co,'A06','CODICE_MOTIVAZIONE_CONSEGNA');
                                }
                                if(string.isblank(cap.MOTIVAZIONE_CONSEGNA)){
                                    return OF_SA_GE_Utils.syncError (co,'A05','MOTIVAZIONE_CONSEGNA');
                                }
                                if(cap.MOTIVAZIONE_CONSEGNA.length()>255){
                                    return OF_SA_GE_Utils.syncError (co,'A06','MOTIVAZIONE_CONSEGNA');
                                }
                            }
                            else{
                                    if(!string.isblank(cap.CODICE_MOTIVAZIONE_CONSEGNA) && cap.CODICE_MOTIVAZIONE_CONSEGNA.length()>3){
                                        return OF_SA_GE_Utils.syncError (co,'A06','CODICE_MOTIVAZIONE_CONSEGNA');
                                    }
                                    if(!string.isblank(cap.MOTIVAZIONE_CONSEGNA) && cap.MOTIVAZIONE_CONSEGNA.length()>255){
                                        return OF_SA_GE_Utils.syncError (co,'A06','MOTIVAZIONE_CONSEGNA');
                                }
                            }
                        }
                    }
                }
                //caso liste non uguali
                else{  
                    return OF_SA_GE_Utils.syncError (co,'A06','Apparati');
                }
            }
            //caso apparati = null
            else{
                if(cListCPE.size()>0){
                    return OF_SA_GE_Utils.syncError (co,'A05','Apparati');
                }
            }
        }  

        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_SA_OM_AsyncChecks.OM_AsyncCompletionOrder(cList[0], co);
        
        if(responseFromOM.containsKey('0')) { 
            
            slList.add(responseFromOM.get('0'));
            slList.add(OF_SA_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
                                             'Codice_operatore' => co.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => co.CODICE_ORDINE_OLO,
                                             'ID_notifica' => co.ID_NOTIFICA,
                                             'Flusso' => 'OM-SF',
                                             'Metodo' => 'OF_CompletionOrder_OpenStream',
                                             'Tipo Comunicazione' => 'OM->SF - ACK - CompletionOrder',
                                             'Caso' => cList[0].Id,
                                             'SL Riferimento' => OF_SA_GE_Utils.slOMSF.Id}));
            Insert slList;
            
            //aggiorno il case,apparati e servizi aggiuntivi
            Case c = cList[0];
            //creo una lista di commercial element instaanziati su cui andare in update
            List<OF_commercialElementIstanziato__c> ceiListToUpdate = new List<OF_commercialElementIstanziato__c>();
            
            if(co.stato_Ordine=='0'){
                c.Status='Espletato';
                c.EOF_Fase__c='Espletato OK';
                c.EOF_ID_Risorsa__c=co.Id_risorsa;
                OF_SA_GE_Utils.aggiornamentoDatiEspletamento(c.Id,OF_SA_GE_Utils.slSFOLO.id,OF_SA_GE_Utils.slSFOLOResp.id);
               
                if(co.APPARATO!=null && !co.APPARATO.isEmpty()){
               
                    for(OF_SA_WS_IN_OM_CompletionOrder.APPARATO cap : co.APPARATO){
                        //REcupero la lista di CEI
                        List<OF_commercialElementIstanziato__c> cpeList = ceiMap.get(cap.Tipologia_Apparato.toUpperCase());

                        System.debug('***AA cpeList => ' + cpeList);
                        System.debug('***AA ceiMap => ' + ceiMap);
                        System.debug('***AA cap.Tipologia_Apparato => ' + cap.Tipologia_Apparato);
                        
                        OF_commercialElementIstanziato__c ceiToUpdate =new OF_commercialElementIstanziato__c();
                        ceiToUpdate = cpeList.get(0);
                        ceiToUpdate.OF_ESITOCONSEGNAAPPARATO__c=cap.ESITO_CONSEGNA_APPARATO;
                        ceiToUpdate.OF_IDAPPARATOCONSEGNATO__c=cap.ID_APPARATO_CONSEGNATO;
                        ceiToUpdate.OF_CODICEMOTIVAZIONECONSEGNA__c=cap.CODICE_MOTIVAZIONE_CONSEGNA;
                        ceiToUpdate.OF_MOTIVAZIONECONSEGNA__c=cap.MOTIVAZIONE_CONSEGNA;
                        ceiListToUpdate.add(ceiToUpdate);
                        cpeList.remove(0);
                    }
                }
                
                if(co.SERVIZIO_AGGIUNTIVO!=null && !co.SERVIZIO_AGGIUNTIVO.isEmpty()){
                    
                    for(OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO sa : co.SERVIZIO_AGGIUNTIVO){
                        //REcupero la lista di CEI
                        List<OF_commercialElementIstanziato__c> servAggList = ceiMap.get(sa.Nome_Servizio.toUpperCase());

                        OF_commercialElementIstanziato__c ceiToUpdate =new OF_commercialElementIstanziato__c();
                        ceiToUpdate = servAggList.get(0);
                        ceiToUpdate.OF_ESITOSERVIZIO__c=sa.ESITO_SERVIZIO;
                        ceiToUpdate.OF_CODICEMOTIVAZIONE_SERVIZIO__c=sa.CODICE_MOTIVAZIONE_SERVIZIO;
                        ceiToUpdate.OF_MOTIVAZIONESERVIZIO__c=sa.MOTIVAZIONE_SERVIZIO;
                        ceiListToUpdate.add(ceiToUpdate);
                        servAggList.remove(0);
                    }
                }
                update ceiListToUpdate;
            }
            else{
                c.Status='Espletato KO';
                c.EOF_Fase__c='Espletato KO';
                
                OF_SA_GE_Utils.aggiornamentoDatiEspletamento(c.Id,OF_SA_GE_Utils.slSFOLO.id,OF_SA_GE_Utils.slSFOLOResp.id);
                
            } 
            
            c.OF_SCALA__c = co.SCALA  ;
            c.OF_PALAZZINA__c = co.PALAZZINA ;
            c.ID_GIS_SCALA_PALAZZINA__c =co.ID_GIS_SCALA_PALAZZINA;
            
            update c;

            //MODFICA FF per la chiamata al servizio di billing
           /* IF(c.status=='Espletato'){
                string cronExp = SyncBillingAccountUtils.GetCRONExpression(DateTime.now().addSeconds(10));
                OF_SyncBillingFattibilitaBatch_Sched schedulable = new OF_SyncBillingFattibilitaBatch_Sched(new List<string> {c.AssetId});
                system.schedule('SyncGPonEspl_'+c.CaseNumber, cronExp, schedulable); 
            }*/

            /**Start - ADD by PG - 18-10 - Verticali*/
            
           // if(co.stato_Ordine=='0'){
                //OF_Verticali_Utils_ServiziAttivi.createAssetVerticaleServAttivi(c, co);
             //   Database.executeBatch(new OF_Verticali_Utils_Servizi_batch(c.id));
        //    }
            
            /**End - ADD by PG - 18-10 - Verticali*/
            
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
            responseToOlo.esito='0';
            
            // Aggiorno il timestamp. E.2 corrisponde a fine check espletamento.
            OF_SA_GE_Utils.partialTemplog('E.2');
            // finisce qui
            
            OF_SA_GE_Utils.EndTemplog();
            
            return  responseToOlo;
        }
        else{
        
            slList.add(responseFromOM.get('1'));
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
            responseToOlo.esito='1';
            EOF_EAI_Service_Log__c sl= responseFromOM.get('1'); 
            responseToOlo.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
            responseToOlo.motivazione=sl.EOF_MOTIVAZIONE__C;
            responseToOlo.id_notifica=sl.EOF_Id_Notifica__c;

            slList.add(OF_SA_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
                                                     'Codice_errore' => responseToOlo.codice_motivazione,
                                                     'Causale_errore' => responseToOlo.motivazione,
                                                     'Flusso' => 'OM-SF',
                                                     'Metodo' => 'OF_CompletionOrder_OpenStream',
                                                     'Codice_operatore' => co.CODICE_OPERATORE,
                                                     'Codice_ordine_OLO' => co.CODICE_ORDINE_OLO,
                                                     'ID_notifica' => co.ID_NOTIFICA,
                                                     'Tipo Comunicazione' => 'OM->SF - NACK - CompletionOrder',
                                                     'Caso' => cList[0].Id,
                                                     'SL Riferimento' => OF_SA_GE_Utils.slOMSF.Id}));
            Insert slList;

            // Aggiorno il timestamp. E.2 corrisponde a fine check espletamento.
            OF_SA_GE_Utils.partialTemplog('E.2');
            // finisce qui
            
            OF_SA_GE_Utils.EndTemplog();
            
            return  responseToOlo;
        }
        

        
        return null;
        
    } 
    
    public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksNotifyReschedule(OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r){

        // Aggiorno il timestamp. R.1 corrisponde a inizio check RDAC.
        OF_SA_GE_Utils.partialTemplog('R.1');
        // finisce qui
        
        if(string.isblank(r.CODICE_OPERATORE)){
            return OF_SA_GE_Utils.syncError (r,'A05','CODICE_OPERATORE');
        }

        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple){
            if(r.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        }        
        if(!olo_found){
             return OF_SA_GE_Utils.syncError (r,'A06','CODICE_OPERATORE');
        }

        if(string.isblank(r.CODICE_ORDINE_OLO)){
            return OF_SA_GE_Utils.syncError (r,'A05','CODICE_ORDINE_OLO');
        }

        // Aggiorno il timestamp. QR.1 corrisponde a pre query RDAC.
        OF_SA_GE_Utils.partialTemplog('QR.1');
        // finisce qui
        
        // 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni        
        List<Case> cList = [select Id, status, PO_SA_Portale__C,OF_Blocked_Case__c from Case where EOF_Codice_Ordine_Olo__c =:r.Codice_Ordine_Olo AND Codice_Ordine_Eof__c =:r.Codice_Ordine_OF AND EOF_Codice_Operatore_WS__c=:r.CODICE_OPERATORE AND RecordType.DeveloperName = 'OF_SA_Attivazione'];
        // 8/01/2018 Marco : fine modifica
        
        // Aggiorno il timestamp. QR.2 corrisponde a post query RDAC.
        OF_SA_GE_Utils.partialTemplog('QR.2');
        // finisce qui
    
        if(cList.isEmpty()){
            return OF_SA_GE_Utils.syncError (r,'A06','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
        }
        else{
            OF_SA_GE_Utils.caseOriginale=cList[0];
            OF_SA_GE_Utils.checkCaseOriginale=true;
        }
        //Done AA - 02/10/2018 - Controllare se il campo "OF_Blocked_Case__c" è valorizzato a true
        //TODO AA - 02/10/2018 - Condividere codice errore per blocked case
        if(OF_SA_GE_Utils.caseOriginale.OF_Blocked_Case__c){//C'è qualche status update dall'olo non notificato all'OM
            return OF_SA_GE_Utils.syncError (r,'A07','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
        } 
        if(cList[0].status != 'Acquisito' && cList[0].status != 'Accettato' && cList[0].status != 'Sospeso'){
            return OF_SA_GE_Utils.syncError (r,'A07','STATUS: ' + cList[0].status);
        }

        if(string.isblank(r.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (r,'A05','DATA_NOTIFICA');
        }
        if(!OF_SA_GE_Utils.checkDateTime(r.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (r,'A06','DATA_NOTIFICA');
        }

        if(string.isblank(r.ID_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (r,'A05','ID_NOTIFICA');
        }
        if(r.ID_NOTIFICA.length()>100){
            return OF_SA_GE_Utils.syncError (r,'A06','ID_NOTIFICA');
        }

        if(!string.isblank(r.NOME_CLIENTE) && r.NOME_CLIENTE.length()>20){
            return OF_SA_GE_Utils.syncError (r,'A06','NOME_CLIENTE');
        }
        
        
        if(!string.isblank(r.COGNOME_CLIENTE) && r.COGNOME_CLIENTE.length()>70){
            return OF_SA_GE_Utils.syncError (r,'A06','COGNOME_CLIENTE');
        }
        
        
        if(!string.isblank(r.RECAPITO_TELEFONICO_CLIENTE_1) && r.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
            return OF_SA_GE_Utils.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
        }
        
        
        if(!string.isblank(r.RECAPITO_TELEFONICO_CLIENTE_2) && r.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
            return OF_SA_GE_Utils.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
        }

        if(string.isblank(r.DATA_PREVISTA_ATTIVAZIONE)){
            return OF_SA_GE_Utils.syncError (r,'A05','DATA_PREVISTA_ATTIVAZIONE');
        }
        if(!OF_SA_GE_Utils.checkDate(r.DATA_PREVISTA_ATTIVAZIONE)){
            return OF_SA_GE_Utils.syncError (r,'A06','DATA_PREVISTA_ATTIVAZIONE'); 
        }
        if(!string.isblank(r.ORARIO_APPUNTAMENTO)){
            if(!OF_SA_GE_Utils.checkTime(r.ORARIO_APPUNTAMENTO)){
                return OF_SA_GE_Utils.syncError (r,'A06','ORARIO_APPUNTAMENTO');
            }
            
        }

        if(string.isblank(r.CODICE_MOTIVAZIONE)){
            return OF_SA_GE_Utils.syncError (r,'A05','CODICE_MOTIVAZIONE');
        }
        if(r.CODICE_MOTIVAZIONE.length()>3){
            return OF_SA_GE_Utils.syncError (r,'A06','CODICE_MOTIVAZIONE');
        }


        if(string.isblank(r.MOTIVAZIONE)){
            return OF_SA_GE_Utils.syncError (r,'A05','MOTIVAZIONE');
        }
        if(r.MOTIVAZIONE.length()>255){
            return OF_SA_GE_Utils.syncError (r,'A06','MOTIVAZIONE');
        }

        if(!string.isblank(r.NOTE) && r.NOTE.length()>255){
            return OF_SA_GE_Utils.syncError (r,'A06','NOTE');
        }
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_SA_OM_AsyncChecks.OM_AsyncReschedule(cList[0],r);  
        
        if(responseFromOM.containsKey('0')) { 
            
            slList.add(responseFromOM.get('0'));
            slList.add(OF_SA_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
                                             'Codice_operatore' => r.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => r.CODICE_ORDINE_OLO,
                                             'Flusso' => 'OM-SF',
                                             'Metodo' => 'OF_Reschedule',
                                             'ID_notifica' => r.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'OM->SF - ACK - Reschedule',
                                             'Caso' => cList[0].Id,
                                             'SL Riferimento' => OF_SA_GE_Utils.slOMSF.Id}));
            Insert slList;
            
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
            responseToOlo.esito='0';
            
            if (!string.isBlank(r.ORARIO_APPUNTAMENTO)){
                    Time t = Time.newInstance(Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(3,5)),
                            Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
                cList[0].EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), t );
            }else{
                cList[0].EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
            }
            cList[0].EOF_Orario_Appuntamento__c=r.ORARIO_APPUNTAMENTO;
            cList[0].EOF_Pertinenza_RDAC__c = 'OM';
            cList[0].OF_SA_Codice_Motivazione__c=r.CODICE_MOTIVAZIONE;
            cList[0].OF_SA_Motivazione__c=r.MOTIVAZIONE;
            update cList[0];

            // Aggiorno il timestamp. R.2 corrisponde a fine check RDAC.
            OF_SA_GE_Utils.partialTemplog('R.2');
            // finisce qui
            
            OF_SA_GE_Utils.EndTemplog();
                
            return  responseToOlo;
        }
        else{
        
            slList.add(responseFromOM.get('1'));
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
            responseToOlo.esito='1';
            EOF_EAI_Service_Log__c sl= responseFromOM.get('1'); 
            responseToOlo.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
            responseToOlo.motivazione=sl.EOF_MOTIVAZIONE__C;
            responseToOlo.id_notifica=sl.EOF_Id_Notifica__c;

            slList.add(OF_SA_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
                                                     'Codice_errore' => responseToOlo.codice_motivazione,
                                                     'Causale_errore' => responseToOlo.motivazione,
                                                     'Codice_operatore' => r.CODICE_OPERATORE,
                                                     'Flusso' => 'OM-SF',
                                                    'Metodo' => 'OF_Reschedule',
                                                     'Codice_ordine_OLO' => r.CODICE_ORDINE_OLO,
                                                     'ID_notifica' => r.ID_NOTIFICA,
                                                     'Tipo Comunicazione' => 'OM->SF - NACK - Reschedule',
                                                     'Caso' => cList[0].Id,
                                                     'SL Riferimento' => OF_SA_GE_Utils.slOMSF.Id}));
            Insert slList;

            // Aggiorno il timestamp. R.2 corrisponde a fine check RDAC.
            OF_SA_GE_Utils.partialTemplog('R.2');
            // finisce qui
            
            OF_SA_GE_Utils.EndTemplog();

            return  responseToOlo;
        } 
       
        return null;   
    }
    
    public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksNotifyStatusUpdate(OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su){

        // Aggiorno il timestamp. SU.1 corrisponde a inizio check Status Update.
        OF_SA_GE_Utils.partialTemplog('SU.1');
        // finisce qui

        if(su.STATO_ORDINE =='8'||su.STATO_ORDINE =='9'){
        return OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        }   
        
        
        if(string.isblank(su.CODICE_OPERATORE)){
            return OF_SA_GE_Utils.syncError (su,'A05','CODICE_OPERATORE');
        }
            
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple){
            if(su.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
				break;
            }
        } 
        if(!olo_found){
             return OF_SA_GE_Utils.syncError (su,'A06','CODICE_OPERATORE');
             
        }
       
        
        if(string.isblank(su.CODICE_ORDINE_OLO)){
            return OF_SA_GE_Utils.syncError (su,'A05','CODICE_ORDINE_OLO');
        }
            
        if(string.isblank(su.CODICE_ORDINE_OF)){
            return OF_SA_GE_Utils.syncError (su,'A05','CODICE_ORDINE_OF');
        }

        if(string.isblank(su.STATO_ORDINE)){
            return OF_SA_GE_Utils.syncError (su,'A05','STATO_ORDINE');
        }
        if(su.STATO_ORDINE!='0' && su.STATO_ORDINE!='2' && su.STATO_ORDINE!='3' && su.STATO_ORDINE!='4' && su.STATO_ORDINE!='5' && su.STATO_ORDINE!='6' && su.STATO_ORDINE!='7'&& su.STATO_ORDINE!='8'&& su.STATO_ORDINE!='9'){
            return OF_SA_GE_Utils.syncError (su,'A06','STATO_ORDINE');
        }

        List<Case> cList;
        if(su.STATO_ORDINE=='6' || su.STATO_ORDINE=='7'){

            // Aggiorno il timestamp. QSU.1 corrisponde a pre query.
            OF_SA_GE_Utils.partialTemplog('QSU.1');














            // finisce qui
           
            // 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni            
            cList = [SELECT id,status,PO_SA_Portale__C,RecordType.DeveloperName,AssetId,OF_Order__c,Previous_Status__c,OF_Blocked_Case__c, EOF_Codice_Ordine_OLO__c,EOF_Id_Risorsa__c,
                    EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c,
                    OF_Esito_Consegna_Apparato__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, PO_Comune__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
                    EOF_Particella_Toponomastica_WS__c, PO_Indirizzo_collegamento__c, EOF_Indirizzo_WS__c, PO_Civico__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c,
                    OF_SA_Profilo__c, OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c
                    FROM Case 
                    WHERE EOF_codice_Ordine_OLO__c=:su.CODICE_ORDINE_OLO 
                    AND Codice_Ordine_Eof__C=:su.codice_ordine_of 
                    AND EOF_Codice_Operatore_WS__c=:su.CODICE_OPERATORE 
                    AND RecordType.DeveloperName ='OF_SA_Cessazione'];
        }
        // Marco : fine modifica
        else{
            
            // Aggiorno il timestamp. QSU.1 corrisponde a pre query.
            OF_SA_GE_Utils.partialTemplog('QSU.1');
            // finisce qui
            
            // 8/01/2018 Marco : modifica query per includere codice operatore nelle condizioni            
            cList = [SELECT id,status,PO_SA_Portale__C,RecordType.DeveloperName,OF_Order__c,Previous_Status__c,OF_Blocked_Case__c, EOF_Codice_Ordine_OLO__c,EOF_Id_Risorsa__c,
                    EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c,
                    OF_Esito_Consegna_Apparato__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, PO_Comune__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
                    EOF_Particella_Toponomastica_WS__c, PO_Indirizzo_collegamento__c, EOF_Indirizzo_WS__c, PO_Civico__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c,
                    OF_SA_Profilo__c, OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c
                    FROM Case 
                    WHERE EOF_codice_Ordine_OLO__c=:su.CODICE_ORDINE_OLO 
                    AND Codice_Ordine_Eof__C=:su.codice_ordine_of 
                    AND EOF_Codice_Operatore_WS__c=:su.CODICE_OPERATORE 
                    AND RecordType.DeveloperName ='OF_SA_Attivazione'];
        } 
        // Marco : fine modifica

        // Aggiorno il timestamp. QSU.2 corrisponde a post query.
        OF_SA_GE_Utils.partialTemplog('QSU.2');
        // finisce qui
        
                 
        if(cList.isEmpty()){
            return OF_SA_GE_Utils.syncError (su,'A06','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');

        }
        else{
            OF_SA_GE_Utils.caseOriginale=cList[0];
            OF_SA_GE_Utils.checkCaseOriginale=true;
        }
        //Done AA - 02/10/2018 - Controllare se il campo "OF_Blocked_Case__c" è valorizzato a true
        //TODO AA - 02/10/2018 - Condividere codice errore per blocked case
        if(OF_SA_GE_Utils.caseOriginale.OF_Blocked_Case__c){//C'è qualche status update dall'olo non notificato all'OM
            return OF_SA_GE_Utils.syncError (su,'A07','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
        } 
        if(string.isblank(su.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (su,'A05','DATA_NOTIFICA');
        }
        if(!OF_SA_GE_Utils.checkDateTime(su.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (su,'A06','DATA_NOTIFICA');
        }

        if(string.isblank(su.ID_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (su,'A05','ID_NOTIFICA');
        }
        if(su.ID_NOTIFICA.length()>100){
            return OF_SA_GE_Utils.syncError (su,'A06','ID_NOTIFICA');
        }
        
        if(OF_SA_GE_Utils.caseOriginale.status =='Espletato' || OF_SA_GE_Utils.caseOriginale.status == 'Espletato KO' || OF_SA_GE_Utils.caseOriginale.status =='Acquisito KO' || OF_SA_GE_Utils.caseOriginale.status =='Cessato KO' || OF_SA_GE_Utils.caseOriginale.status =='Cessato' || OF_SA_GE_Utils.caseOriginale.status =='Annullato' || OF_SA_GE_Utils.caseOriginale.status =='Inviato'){
            return OF_SA_GE_Utils.syncError (su,'A07','STATUS: ' + OF_SA_GE_Utils.caseOriginale.status);
        }
        if(OF_SA_GE_Utils.caseOriginale.status =='In Annullamento' && su.STATO_ORDINE!='5'){
            return OF_SA_GE_Utils.syncError (su,'A07','STATUS: ' + OF_SA_GE_Utils.caseOriginale.status);
        }
        if(OF_SA_GE_Utils.caseOriginale.status =='Sospeso' && su.STATO_ORDINE!='0' && su.STATO_ORDINE!='2'){
            return OF_SA_GE_Utils.syncError (su,'A07','STATUS: ' + OF_SA_GE_Utils.caseOriginale.status);
        }
        if(OF_SA_GE_Utils.caseOriginale.status =='Acquisito' && OF_SA_GE_Utils.caseOriginale.RecordType.DeveloperName=='OF_SA_Attivazione' && su.STATO_ORDINE!='2' && su.STATO_ORDINE!='3' && su.STATO_ORDINE!='4'){
            return OF_SA_GE_Utils.syncError (su,'A07','STATUS: ' + OF_SA_GE_Utils.caseOriginale.status);
        }
        if(OF_SA_GE_Utils.caseOriginale.status =='Acquisito' && OF_SA_GE_Utils.caseOriginale.RecordType.DeveloperName=='OF_SA_Cessazione' && su.STATO_ORDINE!='6' && su.STATO_ORDINE!='7'){
            return OF_SA_GE_Utils.syncError (su,'A07','STATUS: ' + OF_SA_GE_Utils.caseOriginale.status);
        }
        if(OF_SA_GE_Utils.caseOriginale.status =='Accettato' && su.STATO_ORDINE!='4'){
            return OF_SA_GE_Utils.syncError (su,'A07','STATUS: ' + OF_SA_GE_Utils.caseOriginale.status);
        }      
 
        if(su.STATO_ORDINE!='0' && su.STATO_ORDINE!='2'){
            //casi in cui la motivazione è obbligatoria
            if(string.isblank(su.CODICE_MOTIVAZIONE)){
                return OF_SA_GE_Utils.syncError (su,'A05','CODICE_MOTIVAZIONE');
            }
            if(string.isblank(su.MOTIVAZIONE)){
                return OF_SA_GE_Utils.syncError (su,'A05','MOTIVAZIONE');
            }
                        
        }
        
        if(!string.isblank(su.CODICE_MOTIVAZIONE) && su.CODICE_MOTIVAZIONE.length()>3){
            return OF_SA_GE_Utils.syncError (su,'A06','CODICE_MOTIVAZIONE');
        }
          
         
        if(!string.isblank(su.MOTIVAZIONE) && su.MOTIVAZIONE.length()>255){
            return OF_SA_GE_Utils.syncError (su,'A06','MOTIVAZIONE');
        } 
        
        
        if(!string.isblank(su.GPON_DI_ATTESTAZIONE) && su.GPON_DI_ATTESTAZIONE.length()>14){
            return OF_SA_GE_Utils.syncError (su,'A06','GPON_DI_ATTESTAZIONE');
        }
        
        
        if(!string.isblank(su.NOME_CLIENTE) && su.NOME_CLIENTE.length()>20){
            return OF_SA_GE_Utils.syncError (su,'A06','NOME_CLIENTE');
        }
        
        
        if(!string.isblank(su.COGNOME_CLIENTE) && su.COGNOME_CLIENTE.length()>70){
            return OF_SA_GE_Utils.syncError (su,'A06','COGNOME_CLIENTE');
        }
        
        
        if(!string.isblank(su.RECAPITO_TELEFONICO_CLIENTE) && su.RECAPITO_TELEFONICO_CLIENTE.length()>20){
            return OF_SA_GE_Utils.syncError (su,'A06','RECAPITO_TELEFONICO_CLIENTE');
        }
        
        
        
        if(!string.isblank(su.DATA_PREVISTA_ATTIVAZIONE) && !OF_SA_GE_Utils.checkDate(su.DATA_PREVISTA_ATTIVAZIONE)){
            return OF_SA_GE_Utils.syncError (su,'A06','DATA_PREVISTA_ATTIVAZIONE');
        }
        
        
        
        if(!string.isblank(su.ORARIO_APPUNTAMENTO) && !OF_SA_GE_Utils.checkTime(su.ORARIO_APPUNTAMENTO)){
            return OF_SA_GE_Utils.syncError (su,'A06','ORARIO_APPUNTAMENTO');
        }
        

        if(!string.isblank(su.PIN_INTERVENTO_A_VUOTO) && su.PIN_INTERVENTO_A_VUOTO.length()>8){
            return OF_SA_GE_Utils.syncError (su,'A06','PIN_INTERVENTO_A_VUOTO');
        }
        
        
        if(!string.isblank(su.NOTE) && su.NOTE.length()>255){
            return OF_SA_GE_Utils.syncError (su,'A06','NOTE');
        }
        
        
        //CRM Modifica 16_06_2017
        Map<String,String> mapTipologiaEsito = new Map<String,String>();
        //fine
        
        if(su.APPARATO!=null && !su.APPARATO.isempty()){  
            for(OF_SA_WS_IN_OM_StatusUpdate.APPARATO ra : su.APPARATO){
                
                    
                    if(string.isblank(ra.TIPOLOGIA_APPARATO)){
                        return OF_SA_GE_Utils.syncError (su,'A05','TIPOLOGIA_APPARATO'); 
                    }
                    if(ra.TIPOLOGIA_APPARATO.length()>100){
                        return OF_SA_GE_Utils.syncError (su,'A06','TIPOLOGIA_APPARATO');
                    }
                    if(string.isblank(ra.ESITO_RITIRO_APPARATO)){
                        return OF_SA_GE_Utils.syncError (su,'A05','ESITO_RITIRO_APPARATO');
                    }
                    if(ra.ESITO_RITIRO_APPARATO.length()>1) {
                        return OF_SA_GE_Utils.syncError (su,'A06','ESITO_RITIRO_APPARATO'); 
                    }
                    if(!string.isblank(ra.CODICE_MOTIVAZIONE_RITIRO) && ra.CODICE_MOTIVAZIONE_RITIRO.length()>3){
                        return OF_SA_GE_Utils.syncError (su,'A06','CODICE_MOTIVAZIONE_RITIRO');
                    }
                    if(!string.isblank(ra.MOTIVAZIONE_RITIRO) && ra.MOTIVAZIONE_RITIRO.length()>255){
                        return OF_SA_GE_Utils.syncError (su,'A06','MOTIVAZIONE_RITIRO');
                    }
                //CRM Modifica 16_06_2017
                mapTipologiaEsito.put( ra.TIPOLOGIA_APPARATO.toUpperCase() , ra.ESITO_RITIRO_APPARATO );
                //fine
                }
            
        }
        
        
        if(su.VLAN!=null && !su.VLAN.isempty()){
            for(OF_SA_WS_IN_OM_StatusUpdate.VLAN vn : su.VLAN){
                
                    if(string.isblank(vn.USER_VLAN)){
                        return OF_SA_GE_Utils.syncError (su,'A05','USER_VLAN');
                    }
                    if(vn.USER_VLAN.length()>4){
                        return OF_SA_GE_Utils.syncError (su,'A06','USER_VLAN');
                    }
                    if(string.isblank(vn.SERVICE_VLAN)){
                        return OF_SA_GE_Utils.syncError (su,'A05','SERVICE_VLAN');
                    }
                    if(vn.SERVICE_VLAN.length()>4){
                        return OF_SA_GE_Utils.syncError (su,'A06','SERVICE_VLAN');
                    }
                    if(string.isblank(vn.CUSTOMER_VLAN)){
                        return OF_SA_GE_Utils.syncError (su,'A05','CUSTOMER_VLAN');
                    }
                    if(vn.CUSTOMER_VLAN.length()>4){
                        return OF_SA_GE_Utils.syncError (su,'A06','CUSTOMER_VLAN');
                    }
                }
        }
        if(string.isNotBlank(OF_SA_GE_Utils.caseOriginale.Previous_Status__c) && (su.stato_ordine=='0' || su.stato_ordine=='2')){
            // 30/01/2018 Marco : Modifica riconoscimento log desospensione
            system.debug('30/01/2018 Marco : il previous status nella OM entrychecks è:'+ OF_SA_GE_Utils.caseOriginale.Previous_Status__c);                
            if(string.isNotBlank(OF_SA_GE_Utils.caseOriginale.Previous_Status__c)){
                OF_SA_GE_Utils.caseOriginale.Previous_Status__c='';
                OF_SA_GE_Utils.desospendi= true;                    
            }
            system.debug('30/01/2018 Marco2 : il previous status nella OM Entrychecks dopo è:'+ OF_SA_GE_Utils.caseOriginale.Previous_Status__c);
            system.debug('30/01/2018 Marco2 : desospendi nella OM Entrychecks è:'+ OF_SA_GE_Utils.desospendi);                    
            // 30/01/2018 Marco : fine modifica
            
        }
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>(); 
        Map<String,EOF_EAI_Service_Log__c> responseFromOLO = OF_SA_OM_AsyncChecks.OM_AsyncStatusUpdate(OF_SA_GE_Utils.caseOriginale, su);
        
        if(responseFromOLO.containsKey('0')) {
            
            
            slList.add(responseFromOLO.get('0'));
            slList.add(OF_SA_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
                                             'Codice_operatore' => su.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => su.CODICE_ORDINE_OLO,
                                             'Flusso' => 'OM-SF',
                                             'Metodo' => 'OF_StatusUpdate',
                                             'ID_notifica' => su.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'OM->SF - ACK - StatusUpdate',
                                             'Caso' => OF_SA_GE_Utils.caseOriginale.Id,
                                             'SL Riferimento' => OF_SA_GE_Utils.slOMSF.Id}));
            Insert slList;
            
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOM = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
            responseToOM.esito='0';
             
            //aggiorno il Case
            //vado in sovrascrittura del campo customer vlan identificandolo dalla coppia user vlan e service vlan
            if(su.VLAN!=null && !su.VLAN.isempty()){
                List<OF_CommercialElementIstanziato__c> vlanASistema= [select Id,OF_CustomerVLAN__c, OF_ServiceVLAN__c,OF_UserVLAN__c 
                                                                        from OF_CommercialElementIstanziato__c where recordtype.developerName='OF_VLAN'
                                                                        AND OF_SA_VLAN__c=:OF_SA_GE_Utils.caseOriginale.Id];
                if(!vlanASistema.isEmpty()){
                    List<OF_CommercialElementIstanziato__c> vlanToUpdate = new List<OF_CommercialElementIstanziato__c>();
                    for(OF_SA_WS_IN_OM_StatusUpdate.VLAN vn : su.VLAN){
                        for(OF_CommercialElementIstanziato__c vnASistema : vlanASistema){
                            if(vnASistema.OF_ServiceVLAN__c.toUpperCase()==vn.SERVICE_VLAN.toUpperCase() && vnASistema.OF_UserVLAN__c.toUpperCase()==vn.USER_VLAN.toUpperCase()){
                                vnASistema.OF_CustomerVLAN__c=vn.CUSTOMER_VLAN;
                                vlanToUpdate.add(vnASistema);
                            }
                        }
                        
                    }
                    if(!vlanToUpdate.isEmpty()){
                        update vlanToUpdate;
                    }
                }
                                
            }
            
            if(su.stato_ordine=='0'){
                
                
                OF_SA_GE_Utils.caseOriginale.Status='Acquisito';
                if(!string.isBlank(su.DATA_PREVISTA_ATTIVAZIONE)){
                    if(!string.isBlank(su.ORARIO_APPUNTAMENTO)){
                        Time t = Time.newInstance(Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(3,5)),
                                                  Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
                        OF_SA_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), t );                    
                    }
                    else{
                        OF_SA_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));    
                    }
                }
            }
            
            if(su.stato_ordine=='1'){
                OF_SA_GE_Utils.caseOriginale.Status='Acquisito KO';
                OF_SA_GE_Utils.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE; 
                OF_SA_GE_Utils.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;

            }
            
            if(su.stato_ordine=='2'){
                
                
                OF_SA_GE_Utils.caseOriginale.Status='Accettato';
                if(!string.isBlank(su.DATA_PREVISTA_ATTIVAZIONE)){
                    if(!string.isBlank(su.ORARIO_APPUNTAMENTO)){
                        Time t = Time.newInstance(Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(3,5)),
                                                  Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
                        OF_SA_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), t );                    
                    }
                    else{
                        OF_SA_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));    
                    }
                }
            }
            
            if(su.stato_ordine=='3'){
                OF_SA_GE_Utils.caseOriginale.Status='Accettato KO';
                OF_SA_GE_Utils.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
                OF_SA_GE_Utils.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
            }
            
            if(su.stato_ordine=='4'){
                
                // 30/01/2018 Marco : Modifica salvataggio status su campo apposito
                OF_SA_GE_Utils.caseOriginale.Previous_Status__c= OF_SA_GE_Utils.caseOriginale.Status;
                system.debug('30/01/2018 Marco : il previous status nella OM entrychecks per sospensione è:'+ OF_SA_GE_Utils.caseOriginale.Previous_Status__c);                
                // 30/01/2018 Marco : fine modifica
                
                OF_SA_GE_Utils.caseOriginale.Status='Sospeso';
                if(!string.isBlank(su.DATA_PREVISTA_ATTIVAZIONE)){
                    if(!string.isBlank(su.ORARIO_APPUNTAMENTO)){
                        Time t = Time.newInstance(Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(3,5)),
                                                  Integer.valueOf(su.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
                        OF_SA_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), t );                    
                    }
                    else{
                        OF_SA_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(su.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));    
                    }
                }
                
                OF_SA_GE_Utils.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
                OF_SA_GE_Utils.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
            }
            
            if(su.stato_ordine=='5'){
                OF_SA_GE_Utils.caseOriginale.Status='Annullato';
                OF_SA_GE_Utils.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
                OF_SA_GE_Utils.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;

            }
            
            if(su.stato_ordine=='6'){
                OF_SA_GE_Utils.caseOriginale.Status='Cessato';
                OF_SA_GE_Utils.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
                OF_SA_GE_Utils.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;
            }
            
            if(su.stato_ordine=='7'){
                OF_SA_GE_Utils.caseOriginale.Status='Cessato KO';
                OF_SA_GE_Utils.caseOriginale.OF_SA_Codice_Motivazione__c = su.CODICE_MOTIVAZIONE;
                OF_SA_GE_Utils.caseOriginale.OF_SA_Motivazione__c = su.MOTIVAZIONE;

            }
            
            //CRM Modifica 16_06_2017
            if( su.stato_ordine == '6')
            { system.debug('***AA: STATO ORDINE 6 !! CESSATO!');
                List<OF_CommercialElementIstanziato__c> CEIstToUpdate = new List<OF_CommercialElementIstanziato__c>();
                
                List<OF_CommercialElementIstanziato__c> listCEIst = [select id,(select id,OF_TipologiaApparato__c,OF_EsitoRitiroApparato__c from Commercial_element_istanziati3__r) from Asset where Id =: OF_SA_GE_Utils.caseOriginale.AssetId ][0].Commercial_element_istanziati3__r;
                

                for( OF_CommercialElementIstanziato__c ceIst : listCEIst )
                {
                   if(!string.isBlank(ceIst.OF_TipologiaApparato__c)){
                        ceIst.OF_EsitoRitiroApparato__c = mapTipologiaEsito.get( ceIst.OF_TipologiaApparato__c.toUpperCase());
                        CEIstToUpdate.add( ceIst );
                    }
                }
                system.debug('****AA: LISTA DI CEI DA AGGIORNARE ' + CEIstToUpdate);
                if( CEIstToUpdate.size() > 0 ) update CEIstToUpdate;

                
            }
            
            //fine
            






            // popolamento campi GPON DI ATTESTAZIONE sul case in update - 23/10/2017
            if(!string.isBlank(su.GPON_DI_ATTESTAZIONE)){
                OF_SA_GE_Utils.caseOriginale.EOF_GPON_Attestazione__c = su.GPON_DI_ATTESTAZIONE;                
            }
            
            /*OF_manageOrderFromCase_ServiziAttivi mofc = new OF_manageOrderFromCase_ServiziAttivi();
            mofc.manageOrder(OF_SA_GE_Utils.caseOriginale);*/
            OF_ManageOrderFromCase_GPONP mofc = new OF_ManageOrderFromCase_GPONP();
            mofc.ManageOrder(OF_SA_GE_Utils.caseOriginale);

            update OF_SA_GE_Utils.caseOriginale;
            
            // Aggiorno il timestamp. SU.2 corrisponde a fine check Status Update.
            OF_SA_GE_Utils.partialTemplog('SU.2');
            // finisce qui
            
            OF_SA_GE_Utils.EndTemplog();
            
            return  responseToOM;

        }
        else{
            slList.add(responseFromOLO.get('1'));
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOM = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
            responseToOM.esito='1';
            EOF_EAI_Service_Log__c sl= responseFromOLO.get('1');
            responseToOM.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
            responseToOM.motivazione=sl.EOF_MOTIVAZIONE__C;
            responseToOM.id_notifica=sl.EOF_Id_Notifica__c;
            
            slList.add(OF_SA_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
                                                     'Codice_errore' => responseToOM.codice_motivazione,
                                                     'Causale_errore' => responseToOM.motivazione,
                                                     'Codice_operatore' => su.CODICE_OPERATORE,
                                                     'Codice_ordine_OLO' => su.CODICE_ORDINE_OLO,
                                                     'Flusso' => 'OM-SF',
                                                    'Metodo' => 'OF_StatusUpdate',
                                                     'ID_notifica' => su.ID_NOTIFICA,
                                                     'Tipo Comunicazione' => 'OM->SF - NACK - StatusUpdate',
                                                     'Caso' => OF_SA_GE_Utils.caseOriginale.Id,
                                                     'SL Riferimento' => OF_SA_GE_Utils.slOMSF.Id}));
            Insert slList;

            // Aggiorno il timestamp. SU.2 corrisponde a fine check Status Update.
            OF_SA_GE_Utils.partialTemplog('SU.2');
            // finisce qui
            
            OF_SA_GE_Utils.EndTemplog();
                
            return  responseToOM;
        }
           
    }

        
}
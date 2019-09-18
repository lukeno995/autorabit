public class OM_GW_Notify_Utils {
    
    public static OM_GW_WS_Notify.returnNotifyResponse res_temp = new OM_GW_WS_Notify.returnNotifyResponse();

    //Perform all Sync Checks on the arrived notify
    public static OM_GW_WS_Notify.returnNotifyResponse checkSync(OM_GW_WS_Notify.FiberNotify fn){
    	               
        res_temp.Esito = '0';
        res_temp.CodiceErrore = '';
        res_temp.CausaleErrore = '';        

        //Common required field check
        if(String.isBlank(fn.TIPO_COMUNICAZIONE)){
            return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'Tipo Comunicazione');
        }    
        if(String.isBlank(fn.CODICE_ORDINE_OLO)){
            return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'Codice Ordine OLO');
        }    
        if(String.isBlank(fn.CODICE_ORDINE_EOF)){
            return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'Codice Ordine EOF');
        }    
        if(String.isBlank(fn.ID_NOTIFICA)){
            return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'ID Notifica');
        }    
        if(String.isBlank(fn.Codice_Operatore)){
            return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'Codice Operatore');
        }
        if(string.isblank(fn.DATA_NOTIFICA)){
            return OM_GW_GE_Utils.syncErrorNotify (fn,'A_K5','Data Notifica');
        }
        if(!string.isblank(fn.NOTE) && fn.NOTE.length () > 255){
            return OM_GW_GE_Utils.syncErrorNotify (fn,'A_K6','Note');
        }
        
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple){
            if(fn.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        }       
        if(!olo_found){
             return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Codice Operatore');
        }
 
        //Common required field format check 
        if(fn.TIPO_COMUNICAZIONE != '6' && fn.TIPO_COMUNICAZIONE != '7' && fn.TIPO_COMUNICAZIONE != '8' && fn.TIPO_COMUNICAZIONE != '9' &&
           fn.TIPO_COMUNICAZIONE != '10' && fn.TIPO_COMUNICAZIONE != '12' && fn.TIPO_COMUNICAZIONE != '13'){
            return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Tipo Comunicazione');
        }       
        if(fn.ID_NOTIFICA.length() > 15){
            return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'ID Notifica');
        }
        
        // 18/05/2018 MM : timestamp della query sul case. Q1 indica inizio query.
        OM_GW_GE_Utils.partialTemplog('Q.1');
        // finisce qui
                
        List<case> cList = [select Id, status, EOF_Codice_Operatore_WS__c,recordtype.developerNAme, EOF_Apparato__c from Case where EOF_Codice_Ordine_OLO__C=:fn.CODICE_ORDINE_OLO and Codice_Ordine_EOF__C=:fn.CODICE_ORDINE_EOF
                            AND (recordtype.developerNAme='EOF_Caso_Attivazione' OR recordtype.developerNAme='EOF_Caso_Cessazione')];

        // 18/05/2018 MM : timestamp della query sul case. Q1.2 indica fine query.
        OM_GW_GE_Utils.partialTemplog('Q1.2');
        // finisce qui
        
                            
        if(cList.isEmpty()){
            cList=[select Id,EOF_Codice_Operatore_WS__c from Case where EOF_Codice_Ordine_OLO__C=:fn.CODICE_ORDINE_OLO];
            
	        // 13/02/2018 MM : timestamp della query sul case. Q1.3 indica la query.
	        OM_GW_GE_Utils.partialTemplog('Q1.3');
	        // finisce qui
	        
            if (cList.isEmpty()){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Codice Ordine OLO');
            }
            cList = [select Id from Case where Codice_Ordine_EOF__C=:fn.CODICE_ORDINE_EOF];
            
	        // 13/02/2018 MM : timestamp della query sul case. Q1.4 indica la query.
	        OM_GW_GE_Utils.partialTemplog('Q1.4');
	        // finisce qui
	            
            if (cList.isEmpty()){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Codice Ordine EOF');
            }
            return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Codice Ordine OLO e Codice Ordine EOF');
        }
        else{
            //verifico che la  notifica sia coerente con il processo (se cessazione solo 12)
            if(fn.TIPO_COMUNICAZIONE=='12' && cList[0].recordtype.developerNAme=='EOF_Caso_Attivazione'){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Codice Ordine OLO');
            }

            if(fn.TIPO_COMUNICAZIONE!='12' && cList[0].recordtype.developerNAme=='EOF_Caso_Cessazione'){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Codice Ordine OLO');
            }

        }

        //Other type specific required check
        if(fn.TIPO_COMUNICAZIONE=='6'){
            if(cList[0].status != 'Acquisito'){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','STATUS:' + cList[0].status);
            }

			// 13/02/2018 MM : aggiorno il timestamp. ACC.1 corrisponde a fine check status per Accettazione.
	        OM_GW_GE_Utils.partialTemplog('ACC.1');
	 		// finisce qui

        }
        
        if(fn.TIPO_COMUNICAZIONE == '6' || fn.TIPO_COMUNICAZIONE == '7' || fn.TIPO_COMUNICAZIONE == '12'){
            if(string.isBlank(fn.STATO_RICHIESTA)){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'Stato Richiesta');
            }
            if(!string.isBlank(fn.STATO_RICHIESTA)){
                if(fn.STATO_RICHIESTA !='0' && fn.STATO_RICHIESTA !='1'){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Stato Richiesta');
                }

            }
            if(fn.STATO_RICHIESTA.length() > 2){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6','Stato Richiesta');
            }

			// 13/02/2018 MM : aggiorno il timestamp. ACC.2 corrisponde a fine check Accettazione per stato richiesta.
            OM_GW_GE_Utils.partialTemplog('ACC.2');
	 		// finisce qui

        }
        
        if((fn.TIPO_COMUNICAZIONE == '6' || fn.TIPO_COMUNICAZIONE == '7' || fn.TIPO_COMUNICAZIONE == '12') && fn.STATO_RICHIESTA =='1'){
            if(string.isblank(fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO)){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5','Codice Rifiuto Sospensione Annullamento');
            }
            if(fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO.length () >10){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6','Codice Rifiuto Sospensione Annullamento');
            }
            if(string.isBlank(fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO)){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5','Motivo Rifiuto Sospensione Annullamento');
            }
            if(fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO.length() >255){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6','Motivo Rifiuto Sospensione Annullamento');
            }

			// 13/02/2018 MM : aggiorno il timestamp. ACC.3 corrisponde a fine check Accettazione per stato richiesta =1.
            OM_GW_GE_Utils.partialTemplog('ACC.3');
	 		// finisce qui

        }
                
        if(fn.TIPO_COMUNICAZIONE =='7'){
            if(cList[0].status !='Accettato'){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','STATUS:' + cList[0].status);
            }
            if(string.isBlank(fn.DATA_ESPLETAMENTO_ORDINE)){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K5','Data Espletamento Ordine');
            }

			// 13/02/2018 MM : aggiorno il timestamp. E.1 corrisponde a fine check status per Espletamento.
            OM_GW_GE_Utils.partialTemplog('E.1');
	 		// finisce qui

        }           
        
        if(fn.TIPO_COMUNICAZIONE == '7' && fn.STATO_RICHIESTA == '0'){
            if(String.isBlank(fn.ID_RISORSA)){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'ID Risorsa');
            }
            if(!string.isblank(fn.ID_RISORSA) && fn.ID_RISORSA.length() > 50){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','ID Risorsa');
            }
            if(string.isblank(fn.NUMERO_OPERATORE)){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K5','Numero Operatore');
            }
            if(fn.NUMERO_OPERATORE !='1' && fn.NUMERO_OPERATORE !='2' && fn.NUMERO_OPERATORE !='3' && fn.NUMERO_OPERATORE !='4'){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','Numero Operatore');
            }   
            if(string.isblank(fn.FLAG_PAGAMENTO)){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K5','Flag Pagamento');
            }
            if(fn.FLAG_PAGAMENTO !='0' && fn.FLAG_PAGAMENTO !='1'){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','Flag Pagamento');
            }         
            if(String.isBlank(fn.PARAMETRI_TRASMISSIVI_OTTICI)){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'Parametri Trasmissivi Ottici');
            }

            if(!string.isBlank(fn.PARAMETRI_TRASMISSIVI_OTTICI) && fn.PARAMETRI_TRASMISSIVI_OTTICI.length() > 255){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','Parametri Trasmissivi Ottici');
            }
            if(String.isBlank(fn.POSIZIONE_SPLITTER_SECONDARIO)){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'Posizione Splitter Secondario');
            }
            if(!string.isblank(fn.POSIZIONE_SPLITTER_SECONDARIO) && fn.POSIZIONE_SPLITTER_SECONDARIO.length() > 50){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','Posizione Splitter Secondario');
            }
            // 03/10/2018 MM : aggiunta controllo sul campo id splitter secondario
            /*if(String.isBlank(fn.ID_SPLITTER_SECONDARIO)){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'ID Splitter Secondario');
            }*/
            if(!string.isblank(fn.ID_SPLITTER_SECONDARIO) && fn.ID_SPLITTER_SECONDARIO.length() > 50){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','ID Splitter Secondario');
            }
            // 03/10/2018 MM : fine aggiunta
                        
            // Marco : modifiche ai controlli
            if(string.isBlank(fn.ESITO_CONSEGNA_APPARATO) && cList[0].EOF_Apparato__c=='Y'){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'Esito Consegna Apparato');
            }
            if(!string.isBlank(fn.ESITO_CONSEGNA_APPARATO) && cList[0].EOF_Apparato__c=='Y'){
                if(fn.ESITO_CONSEGNA_APPARATO != '0' && fn.ESITO_CONSEGNA_APPARATO !='1' && fn.ESITO_CONSEGNA_APPARATO!='2'){
                    return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6', 'Esito Consegna Apparato');
                    
                }
            // Marco : fine modifiche controlli    
            }
            

			// 13/02/2018 MM : aggiorno il timestamp. E.2 corrisponde a fine check per Espletamento.
            OM_GW_GE_Utils.partialTemplog('E.2');
	 		// finisce qui


        }
        
        if(fn.TIPO_COMUNICAZIONE == '8'){
            

            if(cList[0].status != 'Acquisito' && cList[0].status !='Accettato' && cList[0].status != 'Sospeso'){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','STATUS:' + cList[0].status);
            }
            


            if(String.isBlank(String.valueOf(fn.NUOVA_DAC))){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5', 'Nuova DAC');
            }
            if(string.isBlank(fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC)){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K5','Codice Motivazione Rimodulazione Conferma DAC');
            }
            if(fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC.length() > 50){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','Codice Motivazione Rimodulazione Conferma DAC');
            }
            if(string.isblank(fn.REASON_RIMODULAZIONE_CONFERMA_DAC)){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5','Motivazione Rimodulazione Conferma DAC');
            }
            if(fn.REASON_RIMODULAZIONE_CONFERMA_DAC.length() > 255){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6','Motivazione Rimodulazione Conferma DAC');
            }

			// 13/02/2018 MM : aggiorno il timestamp. R corrisponde a fine check per RDAC da OM.
            OM_GW_GE_Utils.partialTemplog('R');
	 		// finisce qui


        }
        
        
        if(fn.TIPO_COMUNICAZIONE =='9'){
            if(cList[0].status != 'Acquisito' && cList[0].status != 'Accettato'){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','STATUS:' + cList[0].status);
            }

			// 13/02/2018 MM : aggiorno il timestamp. S corrisponde a fine check Sospensione da OM.
            OM_GW_GE_Utils.partialTemplog('S');
	 		// finisce qui


        }
        
        if(fn.TIPO_COMUNICAZIONE =='10'){
            if(cList[0].status != 'Sospeso'){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','STATUS:' + cList[0].status);
            }

				// 13/02/2018 MM : aggiorno il timestamp. D corrisponde a fine check Desospensione da OM.
                OM_GW_GE_Utils.partialTemplog('D');
		 		// finisce qui
        }
        
        if(fn.TIPO_COMUNICAZIONE =='12'){
            if(cList[0].status !='Acquisito'){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','STATUS:' + cList[0].status);
            }
			// 13/02/2018 MM : aggiorno il timestamp. C corrisponde a fine check Cessazione da OM.
            OM_GW_GE_Utils.partialTemplog('C');
	 		// finisce qui

        }
        
        if(fn.TIPO_COMUNICAZIONE =='13'){
            if(cList[0].status != 'In Annullamento'){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','STATUS:' + cList[0].status);
            }

			// 13/02/2018 MM : aggiorno il timestamp. AN corrisponde a fine check Annullamento da OM.
            OM_GW_GE_Utils.partialTemplog('AN');
	 		// finisce qui

        }
        
        if(fn.TIPO_COMUNICAZIONE =='9' || fn.TIPO_COMUNICAZIONE =='13'){
            if(string.isBlank(fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO)){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K5','Codice Rifiuto Sospensione Annullamento');
            }
            if(fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO.length () >10){
                return OM_GW_GE_Utils.syncErrorNotify(fn,'A_K6','Codice Rifiuto Sospensione Annullamento');
            }
            if(string.isBlank(fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO)){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K5','Motivo Rifiuto Sospensione Annullamento');
            }
            if(fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO.length() >255){
                return OM_GW_GE_Utils.syncErrorNotify(fn, 'A_K6','Motivo Rifiuto Sospensione Annullamento');
            }
			// 13/02/2018 MM : aggiorno il timestamp. S/AN corrisponde a fine check addizionali su Sospensione/Annullamento da OM.
            OM_GW_GE_Utils.partialTemplog('S/AN');
	 		// finisce qui

        }
        
        //commento l'inserimento per callout sincrona
        /*
        insert OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                                         'Codice_operatore' => fn.CODICE_OPERATORE,
                                                         'Codice_ordine_OLO' => fn.CODICE_ORDINE_OLO,
                                                         'ID_notifica' => fn.ID_NOTIFICA,
                                                         'Richiesta Notifica' => OM_GW_GE_Utils.Copy_notify_om(fn),
                                                         'Caso' => cList[0].Id,
                                                         'Tipo Comunicazione' => 'OM->SF - ACK - FiberNotify'});
        */
        res_temp.COdiceErrore=  cList[0].EOF_Codice_Operatore_WS__c;
        res_temp.CausaleErrore = cList[0].Id;
        return res_temp;
    }

    //Creates a notify based on the received notify and updates the case
    public static EOF_Notify__c create_notify_update_case(OM_GW_WS_Notify.FiberNotify fn){

        // 18/05/2018 MM : timestamp della query sul case. Q4.1 indica inizio query.
        OM_GW_GE_Utils.partialTemplog('Q4.1');
        // finisce qui

        
        Id OMNotifyId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OMNotify').getRecordTypeId();
        Case c = [SELECT Id, Status,EOF_Fase__c, EOF_Tipo_di_intervento__c,EOF_Tipo_di_intervento_aggiuntivo__c,
                        EOF_Nuova_DAC__c, EOF_Pertinenza_RDAC__c,EOF_Causale_Richiesta_Annullamento__c,EOF_Codice_Richiesta_Annullamento__c, EOF_COdice_Ordine_olo__c,
                        CaseNumber, EOF_Id_Risorsa__c, AssetId,EOF_GPON_Attestazione__c,EOF_Codice_Operatore_WS__c,EOF_Impresa__c,
                        EOF_Provincia_WS__c,EOF_Numero_Civico_WS__c,EOF_Comune_WS__c,EOF_Identificativo_del_POP__c, EOF_ID_Building_WS__c,EOF_Indirizzo_WS__c,
                        EOF_Particella_Toponomastica_WS__c, EOF_Scala_Palazzina_WS__c,EOF_SLA_Premium_Assurance__c,accountId,recordtypeId,
                        OF_Order__c
                  FROM Case 
                  WHERE Id = :fn.CODICE_ORDINE_EOF];
        
        // 18/05/2018 MM : timestamp della query sul case. Q4.2 indica fine query.
        OM_GW_GE_Utils.partialTemplog('Q4.2');
        // finisce qui
                  
        system.debug('CRM 19/10/2017 c:'+c);
        EOF_Notify__c notify; 
        
        String statoReq='';
        if(fn.STATO_RICHIESTA=='0'){
            statoReq='OK';
        }
        if(fn.STATO_RICHIESTA=='1'){
            statoReq='KO';
        }
        //Acceptance notify        
        if(fn.TIPO_COMUNICAZIONE == '6'){
                 
            //Creating Notify
            notify = new EOF_Notify__c(
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = fn.CODICE_OPERATORE,
                        EOF_Codice_Ordine_EOF__c = fn.CODICE_ORDINE_EOF,
                        EOF_Stato_Richiesta__c = statoReq,
                        EOF_ID_Notifica__c = fn.ID_NOTIFICA,           
                        EOF_Data_Notifica__c = OM_GW_GE_Utils.StringToDate(fn.DATA_NOTIFICA),
                        EOF_Impresa__c=fn.impresa,                       
                        //EOF_Inviata__c = false,
                            Updated__c = true
                    );
                if(fn.STATO_RICHIESTA == '0'){
                    notify.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
                    notify.EOF_GPON_Attestazione__c = fn.GPON_ATTESTAZIONE;
                }else
                    notify.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione KO').getRecordTypeId();
            
            //Creating Service Log
            try{ 
                        insert notify;
                        

                        //Updating Case Properly
                        if(fn.STATO_RICHIESTA == '0'){
                                c.Status = 'Accettato';
                                c.EOF_Fase__c = 'Da contattare';
                                c.EOF_Impresa__c = fn.impresa;
                                c.EOF_GPON_Attestazione__c = notify.EOF_GPON_Attestazione__c;
                                update c;
                                OM_GW_GE_Utils.CaseOriginale=c;
                        }else{
                                c.Status = 'Accettato KO';
                                c.EOF_Fase__c = 'Accettato KO';                     
                                
                                update c;
                                OM_GW_GE_Utils.CaseOriginale=c;
                        }

                }catch(Exception e){res_temp.CausaleErrore = e.getmessage();}                              
             } 
        
        //Completion notify        
        if(fn.TIPO_COMUNICAZIONE == '7'){
            
                //Creating Notify
                notify = new EOF_Notify__c(                        
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = fn.CODICE_OPERATORE,
                        EOF_Codice_Ordine_EOF__c = fn.CODICE_ORDINE_EOF,
                        EOF_ID_Notifica__c = fn.ID_NOTIFICA,                            
                        EOF_Stato_Richiesta__c = statoReq,
                        EOF_Data_Notifica__c = OM_GW_GE_Utils.StringToDate(fn.DATA_NOTIFICA),
                        EOF_Tipo_di_intervento__c=fn.tipo_intervento,                        
                        //EOF_Inviata__c = false,
                            Updated__c = true
                    ); 
                    
                    //metto la logica di popolamento di tipo intervento e tipo intervento aggiuntivo
                    if(String.isBlank(fn.ESITO_CONSEGNA_APPARATO) || fn.ESITO_CONSEGNA_APPARATO=='0' ){
                        notify.EOF_TIpo_di_intervento_aggiuntivo__c='Nessuno';
                        c.EOF_Tipo_di_intervento_aggiuntivo__c='Nessuno';
                    } 
                    if (fn.ESITO_CONSEGNA_APPARATO=='1'){
                        notify.EOF_TIpo_di_intervento_aggiuntivo__c='Installazione CPE';
                        c.EOF_Tipo_di_intervento_aggiuntivo__c='Installazione CPE';
                    }
                    if(fn.ESITO_CONSEGNA_APPARATO=='2') {
                        notify.EOF_TIpo_di_intervento_aggiuntivo__c='Installazione CPE e ribaltamento';
                        c.EOF_Tipo_di_intervento_aggiuntivo__c='Installazione CPE e ribaltamento';
                    } 
                    //aggiungo il campo su Case
                    c.OF_Esito_Consegna_Apparato__c=fn.ESITO_CONSEGNA_APPARATO;
                                                             
                    if(fn.STATO_RICHIESTA == '0'){
                        system.debug('DG29 - siamo dentro espletamento e stato richiesta = 0');
                        notify.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId();
                        notify.EOF_GPON_Attestazione__c = fn.GPON_ATTESTAZIONE;
                        notify.EOF_ID_Risorsa__c = fn.ID_RISORSA;
                        notify.EOF_ID_Splitter_Secondario__c=fn.ID_SPLITTER_SECONDARIO;
                        notify.EOF_Posizione_Splitter_Secondario__c=fn.Posizione_Splitter_Secondario;
                    }
                    else{
                        notify.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento KO').getRecordTypeId();
                        Notify.Motivo_Rifiuto_Sospensione_Annullamento__c=fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO;

                    }
                    
                    //Creating Service Log
                    try{
                        insert notify;
                                              
                        
                        //Updating case properly and creating asset
                        if(fn.STATO_RICHIESTA == '0'){
                            /*DG 29/03/2017 commentato per nuova gestione asset
                            Asset a = new Asset();
                            //parte nuova ---------------------------------
                            if(c.AccountId!=null){
                                a.AccountId = c.AccountId;
                            } 
                            a.Status = 'Attivo';
                            a.name=c.Id; 
                            a.EOF_ID_Risorsa__c = FN.id_risorsa;
                            //a.Network_Inventory__c = ni[0].Id;
                            a.EOF_OLO__c = c.EOF_Codice_Operatore_WS__c;
                            a.EOF_Impresa__c = c.EOF_Impresa__c;
                            a.OF_Civico__c=c.EOF_Numero_Civico_WS__c;
                            a.OF_Comune__c=c.EOF_Comune_WS__c;
                            a.OF_GPON_Attestazione__c= fn.GPON_Attestazione;
                            a.OF_ID_Building__c=c.EOF_ID_Building_WS__c;
                            a.OF_Identificativo_del_POP__c=c.EOF_Identificativo_del_POP__c;
                            a.OF_Indirizzo__c=c.EOF_Indirizzo_WS__c;
                            a.OF_Particella_Toponomastica__c=c.EOF_Particella_Toponomastica_WS__c;
                            a.OF_Provincia__c=c.EOF_Provincia_WS__c;
                            a.OF_Scala_Palazzina__c=c.EOF_Scala_Palazzina_WS__c;                            
                            a.EOF_SLA_Premium_Assurance__c=c.EOF_SLA_Premium_Assurance__c;
                            a.EOF_ID_Splitter_Secondario__c=fn.ID_Splitter_Secondario;
                            a.EOF_Posizione_Splitter_Secondario__c=fn.Posizione_Splitter_Secondario;
                            //--------------------------------------                  
                            insert a;

                            c.AssetId = a.id;
                            END DG*/

                            c.EOF_GPON_Attestazione__c=fn.GPON_ATTESTAZIONE;
                            c.EOF_Tipo_di_intervento__c = fn.tipo_intervento;
                            c.EOF_ID_Apparato_COnsegnato__c=fn.ID_APPARATO_CONSEGNATO;
                            c.Status = 'Espletato';
                            c.EOF_Fase__c = 'Espletato OK'; 
                            c.EOF_ID_RISORSA__c=fn.id_Risorsa;
                            
                            // 03/10/2018 MM : aggiunta salvataggio del campo ID_SPLITTER SECONDARIO e POSIZIONE_SPLITTER_SECONDARIO sul case
                            c.EOF_ID_Splitter_Secondario__c = fn.ID_Splitter_Secondario;
                            c.EOF_Posizione_Splitter_Secondario__c = fn.Posizione_Splitter_Secondario;
                            // 03/10/2018 MM : fine aggiunta
                            
                            // 11/01/2018 Marco : salvataggio del campo data espletamento ordine sul campo data prevista attivazione
                            //c.EOF_Data_Prevista_Attivazione__c = OM_GW_GE_Utils.stringToDateNoTime(fn.DATA_ESPLETAMENTO_ORDINE);
                            // Marco : fine modifica
                            update c;
                            OM_GW_GE_Utils.CaseOriginale=c;
                             
                        }else{
                            c.Status = 'Espletato KO';
                            c.EOF_Fase__c = 'Espletato KO';
                            c.EOF_Causale_Errore__c=fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO+' - '+fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO;
                            update c; 
                            OM_GW_GE_Utils.CaseOriginale=c;
                        }
                            
                }catch(Exception e){res_temp.CausaleErrore = e.getmessage();}          
             }        
        
        //DAC Remodulation notify         
        if(fn.TIPO_COMUNICAZIONE == '8'){
            
            //Creating notify
            notify = new EOF_Notify__c(
                        RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di rimodulazione DAC').getRecordTypeId(),
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = fn.CODICE_OPERATORE,
                        EOF_Codice_Ordine_EOF__c = fn.CODICE_ORDINE_EOF,
                        EOF_ID_Notifica__c = fn.ID_NOTIFICA,                        
                        EOF_Stato_Richiesta__c = statoReq,
                        EOF_Data_Notifica__c = OM_GW_GE_Utils.StringToDate(fn.DATA_NOTIFICA),
                        EOF_Nuova_DAC__c = OM_GW_GE_Utils.StringToDateNoTime(fn.NUOVA_DAC),                     
                        EOF_Reason_Rimodulazione_DAC__c = 'Ripianificazione appuntamento causa OM',                        
                        //EOF_Inviata__c = false,
                            Updated__c = true
                    );
        
            //Creating Service Log
            try{
                        insert notify;                       
                        
                        //Updating Case properly
                        if(c.Status == 'Accettato')
                            c.EOF_Fase__c='Appuntamento Fissato';
                        else if(c.Status == 'Acquisito')
                            c.EOF_Fase__c='In verifica BO';
                        c.EOF_Nuova_DAC__c = OM_GW_GE_Utils.StringToDate(fn.NUOVA_DAC);
                        c.EOF_Pertinenza_RDAC__c = 'OM';
                        update c;
                        OM_GW_GE_Utils.CaseOriginale=c;
            }catch(Exception e){res_temp.CausaleErrore = e.getmessage();}            
         }        
        
        //Suspension notify         
        if(fn.TIPO_COMUNICAZIONE == '9'){
            
            //Creating notify           
            notify = new EOF_Notify__c(
                        RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di sospensione').getRecordTypeId(),
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = fn.CODICE_OPERATORE,
                        EOF_Codice_Ordine_EOF__c = fn.CODICE_ORDINE_EOF,
                        EOF_ID_Notifica__c = fn.ID_NOTIFICA,                       
                        EOF_Stato_Richiesta__c = statoReq,
                        Motivo_Rifiuto_Sospensione_Annullamento__c = fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO,
                        EOF_Data_Notifica__c = OM_GW_GE_Utils.StringToDate(fn.DATA_NOTIFICA),                     
                        //EOF_Inviata__c = false,
                            Updated__c = true
                    );
                    //Creating Service Log
                    try{
                        insert notify;
                        
                        //Updating Case Properly
                        c.EOF_Causale_Richiesta_Sospensione__c = fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO;
                        c.EOF_Codice_Richiesta_Sospensione__c = fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO;  
                        c.Status = 'Sospeso';
                        c.EOF_Fase__c = 'Sospeso OM';
                        update c;              
                        OM_GW_GE_Utils.CaseOriginale=c;     
                    }catch(Exception e){res_temp.CausaleErrore = e.getmessage();}
            } 
        
        //De-suspension notify         
        if(fn.TIPO_COMUNICAZIONE == '10'){
            
            //Creating Notify
            notify = new EOF_Notify__c(
                        RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di desospensione').getRecordTypeId(),
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = fn.CODICE_OPERATORE,
                        EOF_Codice_Ordine_EOF__c = fn.CODICE_ORDINE_EOF,
                        EOF_ID_Notifica__c = fn.ID_NOTIFICA, 
                        EOF_Stato_Richiesta__c = statoReq,
                        EOF_Data_Notifica__c = OM_GW_GE_Utils.StringToDate(fn.DATA_NOTIFICA),                        
                        //EOF_Inviata__c = false,
                            Updated__c = true
                    );
                    //Creating Service Log
                    try{
                        insert notify;
                        
                        //Updating Case Properly
                        CaseHistory ch = [select oldValue from CaseHistory where CaseId=:c.Id and Field='Status' order by createdDate desc limit 1];
                        c.Status= String.valueof(ch.oldValue);
                        c.EOF_Fase__c = 'Desospeso';
                        update c;
                        OM_GW_GE_Utils.CaseOriginale=c;

                    }catch(Exception e){res_temp.CausaleErrore = e.getmessage();}
            } 
        
        //Cessation notify 
        if(fn.TIPO_COMUNICAZIONE == '12'){
                //Creating Notify          
                notify = new EOF_Notify__c(
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = fn.CODICE_OPERATORE,
                        EOF_Codice_Ordine_EOF__c = fn.CODICE_ORDINE_EOF,
                        EOF_ID_Notifica__c = fn.ID_NOTIFICA,                                                 
                        EOF_Stato_Richiesta__c = statoReq,
                        EOF_Data_Notifica__c = OM_GW_GE_Utils.StringToDate(fn.DATA_NOTIFICA),            
                        //EOF_Inviata__c = false,
                            Updated__c = true
                    );
                    if(fn.STATO_RICHIESTA == '1'){
                        notify.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione KO').getRecordTypeId();
                        notify.Motivo_Rifiuto_Sospensione_Annullamento__c = fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO;
                    }else
                        notify.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();

                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                        insert notify;

                        //Updating Case Properly
                        if(fn.STATO_RICHIESTA == '0'){
                            /*DG 29/03/2017 commentato per nuova gestione asset
                            Asset a =new Asset();
                            a.id=c.assetId;
                            a.status='Cessato';
                            update a;
                            END DG */
                            c.Status = 'Cessato OK';
                            c.EOF_Fase__c = 'Cessato OK';                       

                            update c;
                            OM_GW_GE_Utils.CaseOriginale=c;
                            
                            
                        }else{
                            c.Status = 'Cessato KO';
                            c.EOF_Fase__c = 'Cessato KO';                                     
                            update c; 
                            OM_GW_GE_Utils.CaseOriginale=c;
                        }      
                        
                    }catch(Exception e){
                        res_temp.CausaleErrore = e.getmessage();
                        
                    }  
                } 

        //Cancellation notify        
        if(fn.TIPO_COMUNICAZIONE == '13'){
            
            //Creating Notify         
            notify = new EOF_Notify__c(
                        RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di annullamento').getRecordTypeId(),
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = fn.CODICE_OPERATORE,
                        EOF_Codice_Ordine_EOF__c = fn.CODICE_ORDINE_EOF,
                        EOF_ID_Notifica__c = fn.ID_NOTIFICA,                                     
                        Motivo_Rifiuto_Sospensione_Annullamento__c = fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO,
                        EOF_Data_Notifica__c = OM_GW_GE_Utils.StringToDate(fn.DATA_NOTIFICA),
                        EOF_Esito_Consegna_Apparato__c = fn.ESITO_CONSEGNA_APPARATO,
                        //EOF_Inviata__c = false,
                            Updated__c = true
                    );
                    //Creating Service Log
                    try{
                        insert notify;
                                               
                        
                        //Updating Case Properly
                        c.Status = 'Annullato';
                        c.EOF_Causale_Richiesta_Annullamento__c = fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO;
                        c.EOF_Codice_Richiesta_Annullamento__c = fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO;               
                        update c;
                        OM_GW_GE_Utils.CaseOriginale=c;

                    }catch(Exception e){res_temp.CausaleErrore = e.getmessage();}
            }
        return notify;
     }

    public static EOF_EAI_Service_Log__c create_ack_nack(EOF_Notify__c notify, String s, String cod, String cas){
        if(s == '0'){
            EOF_EAI_Service_Log__c ackLog = new EOF_EAI_Service_Log__c(
                    Caso__c = notify.Caso__c,
                    RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('ACK').getRecordTypeId(),
                    //Notify__c = notify.Id,
                    EOF_Richiesta_Notifica__c =  'ESITO:'+ s,     
                    EOF_ID_Notifica__c = notify.EOF_ID_Notifica__c,
                    EOF_Codice_Ordine_OLO__c = notify.EOF_Codice_Ordine_OLO__c,
                    EOF_Codice_Operatore__c = notify.EOF_Codice_Operatore__c,
                    EOF_Data_Notifica__c = notify.EOF_Data_Notifica__c       
                ); 
                return ackLog;
         }
        else{
            EOF_EAI_Service_Log__c nackLog = new EOF_EAI_Service_Log__c(
                    Caso__c = notify.Caso__c,
                    RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('NACK').getRecordTypeId(),
                    //Notify__c = notify.id,
                    EOF_Richiesta_Notifica__c = 'ESITO:'+ s + '\n' + 'CODICE ERRORE: ' + cod + '\n' + 'CAUSALE ERRORE: ' + cas,     
                    EOF_ID_Notifica__c = notify.EOF_ID_Notifica__c,
                    EOF_Codice_Ordine_OLO__c = notify.EOF_Codice_Ordine_OLO__c,
                    EOF_Codice_Operatore__c = notify.EOF_Codice_Operatore__c,
                    EOF_Data_Notifica__c = notify.EOF_Data_Notifica__c       
               ); 
               return nackLog;                
            }
     }


    //perform a Sync callout to the OLO 
    public static OM_GW_WS_Notify.returnNotifyResponse call_OLO(OM_GW_WS_Notify.FiberNotify fn){
        
        // 18/05/2018 MM : timestamp della callout. CALLOLO.1 indica inizio.
        OM_GW_GE_Utils.partialTemplog('CALLOLO.1');
        // finisce qui
        
        
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 stub = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();          
              
        xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType response = new xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();
        
        //set timeout
            stub.timeout_x = 30000;
        
        //Invoking the callout with corresponding parameters
        response = stub.Notify(fn.CODICE_OPERATORE,                
                                        fn.TIPO_COMUNICAZIONE, 
                                        fn.CODICE_ORDINE_OLO,
                                        fn.CODICE_ORDINE_EOF,                                                                        
                                        fn.ID_NOTIFICA,
                                        fn.STATO_RICHIESTA,
                                        fn.GPON_ATTESTAZIONE,
                                        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO,
                                        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO,
                                        String.valueOf(fn.DATA_ESPLETAMENTO_ORDINE),
                                        fn.ID_RISORSA,
                                        String.valueOf(fn.DATA_NOTIFICA),
                                        fn.ID_APPARATO_CONSEGNATO,
                                        fn.ESITO_CONSEGNA_APPARATO,
                                        fn.PARAMETRI_TRASMISSIVI_OTTICI,
                                        fn.ID_SPLITTER_SECONDARIO,
                                        fn.POSIZIONE_SPLITTER_SECONDARIO,
                                        String.valueOf(fn.NUOVA_DAC),
                                        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC,
                                        fn.REASON_RIMODULAZIONE_CONFERMA_DAC,
                                        fn.NOTE,
                                        fn.FLAG_PAGAMENTO,
                                       fn.NUMERO_OPERATORE); 
        
        res_temp.esito=response.esito;
        res_temp.CodiceErrore=response.CodiceErrore;
        res_temp.CausaleErrore=response.CausaleErrore;
       
        // 18/05/2018 MM : timestamp della callout. CALLOLO.2 indica fine.
        OM_GW_GE_Utils.partialTemplog('CALLOLO.2');
        // finisce qui

        
        return res_temp; 
     }
}
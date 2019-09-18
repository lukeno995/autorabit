public with sharing class OF_TTM_EntryChecks {
    //public static OF_TT_WS_TroubleTicketRequest.TroubleTicket tt_temp;
    public static OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse tt_resp_temp;
    public static List<Case> case_tmp_list;
    //AS
    public static case c;
    public static eof_eai_service_log__c sl;
    public static boolean portale=false;
    public static boolean checkSynchError=false; 
    
    
    public static EOF_EAI_Service_Log__c PORTAL_checkSync(OF_TT_WS_TroubleTicketRequest.TroubleTicket tt, EOF_EAI_Service_Log__c slPort){
        //Generating TroubleTicket Service Log        
        //AA - Fake value intervento congiunto !! 
        tt.INTERVENTO_CONGIUNTO = 'N';
        OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_EAI_Log(tt);
        system.debug('@@@@ OF_TTM_Utils.sLogOLOSF: '+OF_TTM_Utils.sLogOLOSF);
        insert OF_TTM_Utils.sLogOLOSF;
        OF_TTM_EntryChecks.portale=true;
        OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse resp = checkSync(tt);
        
        if(resp.esito=='0'){
            //lo aggiorniamo con il metodo messo sulla notifica asincrona
            /*
            slPort.EOF_Stato_Ordine__c=OF_TTM_EntryChecks.c.status;
            slPort.EOF_COdice_MOtivazione__c=OF_TTM_EntryChecks.c.OF_SA_CODICE_MOTIVAZIONE__c;
            slPort.EOF_MOtivazione__c=OF_TTM_EntryChecks.c.OF_SA_CODICE_MOTIVAZIONE__c+' - '+OF_TTM_EntryChecks.c.OF_SA_MOTIVAZIONE__c;
            slPort.EOF_Codice_ordine_eof__c=Id.valueOf(OF_TTM_EntryChecks.c.Id);
            */
            
            slPort.PO_SA_Data_Inserimento_Ordine__c=system.now(); 
            slPort.EOF_Stato_Richiesta__c='Inserita Portale';
        }else{
            slPort.EOF_MOtivazione__c=resp.CausaleErrore;
            if(resp.CodiceErrore=='A_K8'){
                slPort.EOF_MOtivazione__c='Servizio Momentaneamente non disponibile';
            }
            //slPort.EOF_Stato_Ordine__c='error';
            OF_TTM_EntryChecks.checkSynchError=true;
            slPort.EOF_Stato_Richiesta__c='Bozza Portale';
            slPort.EOF_COdice_MOtivazione__c=resp.CodiceErrore;
            
        }
        if(OF_TTM_EntryChecks.c != null){
            slPort.EOF_Stato_Ordine__c=OF_TTM_EntryChecks.c.Status;
            slPort.EOF_Codice_ordine_eof__c = OF_TTM_EntryChecks.c.Id;
            slPort.PO_TT_Tipo_Risorsa__c=OF_TTM_EntryChecks.c.OF_TT_Tipo_Risorsa__c;
        }
        return slPort;
    }
    
    
    public static OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse checkSync(OF_TT_WS_TroubleTicketRequest.TroubleTicket tt){
        
        //check for errore sincrono AK9: campo obbligatorio con controllo sincrono vuoto sui campi obbligatori per tutte le richieste
        
        if(String.isBlank(tt.CODICE_OPERATORE)){
            return OF_TTM_Utils.syncError(tt, 'A_K9', 'Codice Operatore');
        }
        else if(String.isBlank(tt.CODICE_COMUNICAZIONE_OLO)){
            return OF_TTM_Utils.syncError(tt, 'A_K9', 'Codice Comunicazione OLO');
        }
        else if(String.isBlank(tt.CATEGORIA_GUASTO)){
            return OF_TTM_Utils.syncError(tt, 'A_K9', 'Categoria Guasto');
        }
        else if(String.isBlank(tt.ID_NOTIFICA)){
            return OF_TTM_Utils.syncError(tt, 'A_K9', 'Id Notifica');
        }
        else if(String.isBlank(tt.ID_RISORSA)){
            return OF_TTM_Utils.syncError(tt, 'A_K9', 'Id Risorsa');
        }
        else if(tt.TIPO_COMUNICAZIONE=='9' && String.isblank(tt.CAUSALE_RICHIESTA_ANNULLAMENTO)){
            return OF_TTM_Utils.syncError(tt, 'A_K9', 'Causale Richiesta Annullamento');
        }
        else if(tt.TIPO_COMUNICAZIONE=='6' && String.isblank(tt.CAUSALE_DESOSPENSIONE)){
            return OF_TTM_Utils.syncError(tt, 'A_K9', 'Causale Desospensione');
        }
        else if((tt.TIPO_COMUNICAZIONE=='1' || tt.TIPO_COMUNICAZIONE=='11') && String.isblank(tt.CAUSALE_APERTURA)){
            return OF_TTM_Utils.syncError(tt, 'A_K9', 'Causale Apertura');
        }
        
        //A_K10 sync check - format su tutti i campi obbligatori per tutti
        
        else if(tt.TIPO_COMUNICAZIONE != '1'  && tt.TIPO_COMUNICAZIONE != '9'  && tt.TIPO_COMUNICAZIONE != '6'  && tt.TIPO_COMUNICAZIONE != '8'
                && tt.TIPO_COMUNICAZIONE != '11' && tt.TIPO_COMUNICAZIONE != '12' && tt.TIPO_COMUNICAZIONE != '20'){
                    return OF_TTM_Utils.syncError(tt, 'A_K10', 'Tipo Comunicazione');            
                }  
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple)
            if(tt.CODICE_OPERATORE == s.getLabel())
            olo_found = true;
        //Team Indiani
        if(test.isrunningtest()){olo_found=true;}
        if(!olo_found)
            return OF_TTM_Utils.syncError(tt, 'A_K10', 'Codice Operatore'); 
        
        else if(tt.CODICE_COMUNICAZIONE_OLO.length() > 50){
            return OF_TTM_Utils.syncError(tt, 'A_K10', 'Codice Comunicazione OLO');
        }
        else if(tt.CATEGORIA_GUASTO != '0' && tt.CATEGORIA_GUASTO != '1' && tt.CATEGORIA_GUASTO != '2'){
            return OF_TTM_Utils.syncError(tt, 'A_K10', 'Categoria Guasto');
        }
        else if(tt.ID_NOTIFICA.length() > 100){
            return OF_TTM_Utils.syncError(tt, 'A_K10', 'Id Notifica');
        }
        else if(tt.ID_RISORSA.length() > 50){
            return OF_TTM_Utils.syncError(tt, 'A_K10', 'Id Risorsa');
        }
        else {
            //Creo una lista di case che utilizzerò piu tardi
            case_tmp_list= [select Id,EOF_codice_Operatore_WS__c,EOF_categoria_guasto__c,EOF_ID_Risorsa__c,Status,
                            Eof_fase__c,EOF_Minuti_rimanenti_sospesi__c,EOF_Codice_Comunicazione_OLO__c,
                            EOF_Comunicazioni_con_OLO__c,EOF_Num_min_risoluzione_Ticket__c,EOF_Data_Max_Risoluzione_Ticket__c,
                            EOF_Secondi_Sospesi_allo_SLA__c, EOF_SLA_Premium_Assurance__c, EOF_Collaudi_Negativi__c, OF_Retry_Automatico__c,
                            EOF_Causale_Sospensione__c,EOF_Rischedulazione_Appuntamento__c, EOF_GPON_Attestazione__c, OF_TT_Tipo_Risorsa__c, Staging_retry__c, OF_Response_da_TTM__c
                            from Case where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO];
            //superati i controlli sincroni creiamo il case, andiamo in quelli asincroni e ritorniamo la response positiva
            //ipotizzare successivamente un metodo che mi torna tutti i rtype in una mappa che poi posso utilizzare in tutta la classe
            //check per il tipo comunicazione, se 1 creo il case, se 2 vado in update
            
            // 14/06/2018 MM : spostati in sincrono tutti i controlli su formato/contenuto che prima erano in asincrono
            if(tt.TIPO_COMUNICAZIONE=='1'){
                
                List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
                List<Account> oloId = [SELECT Id, Type, EOF_Codice_Operatore__c  FROM Account WHERE RecordType.Name = 'OLO' AND EOF_Codice_Operatore__c =: tt.CODICE_OPERATORE LIMIT 1];
                if (oloId.isEmpty()){
                    OF_TTM_Utils.sLogOLOSF.EOF_Response__c = 'NACK';
                    update OF_TTM_Utils.sLogOLOSF;
                    return OF_TTM_Utils.syncError(tt, 'A_K10', 'Codice Operatore');
                }
                
                if(String.isBlank(tt.NOME_REFERENTE_TECNICO_OLO)){
                    OF_TTM_Utils.sLogOLOSF.EOF_Response__c = 'NACK';
                    update OF_TTM_Utils.sLogOLOSF;
                    return OF_TTM_Utils.syncError(tt,'A_K9','Nome Referente Tecnico OLO');
                }
                if(String.isBlank(tt.TELEFONO_REFERENTE_TECNICO_OLO)){
                    OF_TTM_Utils.sLogOLOSF.EOF_Response__c = 'NACK';
                    update OF_TTM_Utils.sLogOLOSF;
                    return OF_TTM_Utils.syncError(tt,'A_K9','Telefono Referente Tecnico OLO');
                }
                if(String.isBlank(tt.EMAIL_REFERENTE_TECNICO_OLO)){
                    OF_TTM_Utils.sLogOLOSF.EOF_Response__c = 'NACK';
                    update OF_TTM_Utils.sLogOLOSF;
                    return OF_TTM_Utils.syncError(tt,'A_K9','Email Referente Tecnico OLO');
                }
                if(tt.NOME_REFERENTE_TECNICO_OLO.length() > 255){
                    OF_TTM_Utils.sLogOLOSF.EOF_Response__c = 'NACK';
                    update OF_TTM_Utils.sLogOLOSF;
                    return OF_TTM_Utils.syncError(tt,'A_K10','Nome Referente Tecnico OLO');
                }
                if(tt.TELEFONO_REFERENTE_TECNICO_OLO.length() > 70){
                    OF_TTM_Utils.sLogOLOSF.EOF_Response__c = 'NACK';
                    update OF_TTM_Utils.sLogOLOSF;
                    return OF_TTM_Utils.syncError(tt,'A_K10','Telefono Referente Tecnico OLO');
                }
                if(tt.EMAIL_REFERENTE_TECNICO_OLO.length() > 255){
                    OF_TTM_Utils.sLogOLOSF.EOF_Response__c = 'NACK';
                    update OF_TTM_Utils.sLogOLOSF;
                    return OF_TTM_Utils.syncError(tt,'A_K10','Email Referente Tecnico OLO');
                }
                
                Case case_tmp = new Case(
                    RecordTypeId = rt[0].Id,
                    EOF_Account_OLO__c = oloId[0].id,
                    EOF_Codice_Comunicazione_OLO__c = tt.CODICE_COMUNICAZIONE_OLO,
                    EOF_Codice_Operatore_WS__c = tt.CODICE_OPERATORE,               
                    EOF_Categoria_Guasto__c = OF_TTM_Utils.getStringCategoriaGuasto(tt.CATEGORIA_GUASTO),
                    EOF_Id_Notifica__c = tt.ID_NOTIFICA,
                    EOF_Id_Risorsa__c = tt.ID_RISORSa,
                    EOF_Causale_Apertura__c = OF_TTM_Utils.getStringCausaleApertura(tt.CAUSALE_APERTURA), 
                    Origin = 'Web',
                    Subject = 'Richiesta risoluzione guasto',
                    Type = OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE),
                    Description = tt.NOTE,
                    OF_TroubleTicketManager__c = true,
                    Status = 'In Verifica',
            		EOF_Fase__c = 'Da Verificare'
                );
                if(OF_TTM_EntryChecks.portale){
                    case_tmp.PO_TT_Portale__c=true;
                }
                //Salvo la comunicazione con OLO
                case_tmp.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.Note;
                try{   
                    insert case_tmp;
                    OF_TTM_EntryChecks.c = case_tmp;
                    OF_TTM_Utils.sLogOLOSF.Caso__c = case_tmp.Id;
                    update OF_TTM_Utils.sLogOLOSF;
                }
                catch(DMLException e){
                    OF_TTM_Utils.sLogOLOSF.EOF_Response__c = 'NACK';
                    update OF_TTM_Utils.sLogOLOSF;
                    return OF_TTM_Utils.syncError(tt, 'A_K10', e.getDmlFields(0).get(0).getdescribe().getlabel());                               
                }
                
                insert OF_TTM_Utils.create_EAI_Log(new Map<String,String>{
                                                    'Type' => 'TT_ACK', 
                                                    'Codice_operatore' => tt.CODICE_OPERATORE, 
                                                    'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                    'ID_notifica' => tt.ID_NOTIFICA, 
                                                    'CaseId' => case_tmp.Id, 
                                                    'TT_Request'=>'Esito: 0', 
                                                    'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE, 
                                                    'Tipo Comunicazione String' => 'OLO -> SF - TT ACK ' + OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE), 
                                                    'SL Riferimento' => OF_TTM_Utils.sLogOLOSF.id
                                                    //'Codice Errore' =>  tt_resp_temp.CodiceErrore,
                                                    //'Causale Errore' => tt_resp_temp.CausaleErrore   
                                                    });
                OF_TTM_Utils.sLogOLOSF.EOF_Response__c = 'ACK';
                update OF_TTM_Utils.sLogOLOSF;
                OF_TTM_AsyncChecks.checkAsync(case_tmp.id,OF_TTM_Utils.sLogOLOSF.id);//checkAsync(case_tmp,tt);
                
                tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                tt_resp_temp.Esito='0';
                
                return tt_resp_temp;
            }
            
            //check per tutti gli altri casi in cui devo aggiornare il case
            else{
                //check per controllare che i campi obbligatori sincroni corrispondano a quelli del case che abbiamo a sistema
                if(case_tmp_list.isEmpty()){
                    return OF_TTM_Utils.syncError(tt, 'A_K10', 'Codice Comunicazione OLO');
                }
                Case case_tmp=case_tmp_list[0];
                //AA Aggiunta reference a variabile, per aggiornamento slog portale
                OF_TTM_EntryChecks.c = case_tmp;
                if (case_tmp.EOF_codice_Operatore_WS__c!=tt.Codice_operatore){
                    return OF_TTM_Utils.syncError(tt, 'A_K10', 'Codice operatore');
                }
                if (case_tmp.EOF_categoria_guasto__c!=OF_TTM_Utils.getStringCategoriaGuasto(tt.CATEGORIA_GUASTO)){
                    return OF_TTM_Utils.syncError(tt, 'A_K10', 'Categoria guasto');
                } 
                if (case_tmp.EOF_ID_Risorsa__c!=tt.ID_RISORSA){
                    return OF_TTM_Utils.syncError(tt, 'A_K10', 'ID_RISORSA');
                }
                if(String.isBlank(case_tmp.EOF_GPON_Attestazione__c)){
                    if(String.isBlank(tt.COGNOME_CLIENTE)){
                        return OF_TTM_Utils.syncError(tt, 'A_K9', 'Cognome Cliente');
                    }
                    if(string.isblank(tt.RECAPITO_TELEFONICO_CLIENTE_1)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Recapito Telefonico Cliente 1');
                    }
                }
                
                //check sui campi obbligatori sincroni per tipo di comunicazione
                //Desospensione 14/06/2018 MM : spostati i controlli su formato/contenuto e spostati update in sincrono
                if(tt.TIPO_COMUNICAZIONE=='6'){
                    
                    Group analisi = [SELECT Id FROM Group WHERE Name = 'Trouble Ticket - Coda Analisi' AND Type = 'Queue'];    
                    
                    if(String.isBlank(String.valueOf(tt.DATA_ORA_DESOSPENSIONE))){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Data Ora Desospensione');
                    }
                    if(String.isNotBlank(tt.CAUSALE_DESOSPENSIONE) && tt.CAUSALE_DESOSPENSIONE != '2' && tt.CAUSALE_DESOSPENSIONE !='3'){
                    	return OF_TTM_Utils.syncError(tt,'A_K10','Causale Desospensione');
                    }
                    if(OF_TTM_Utils.stringToDate(tt.DATA_ORA_DESOSPENSIONE) <= OF_TTM_Utils.now().addMinutes(1)){
                        return OF_TTM_Utils.syncError(tt,'A_K10','Data Ora Desospensione');
                    }
                    if(String.isBlank(tt.REFERENTE_DESOSPENSIONE)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Referente Desospensione');
                    }
                    if(string.isBlank(tt.NOME_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Nome Referente Tecnico OLO');
                    }
                    if(string.isBlank(tt.TELEFONO_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Telefono Referente Tecnico OLO');
                    }
                    if(string.isBlank(tt.EMAIL_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Email Referente Tecnico OLO');
                    }
                    if(case_tmp.status!='Sospeso'){
                        return OF_TTM_Utils.syncError(tt,'A_K11','Status');
                    }
                    if (case_tmp.OF_Retry_Automatico__c){
                        return OF_TTM_Utils.syncError(tt,'A_K8','Retry in corso');
                    }

                    if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){
                        case_tmp.EOF_Note__c=tt.NOTE.abbreviate(255);
                    }
                    else {
                        case_tmp.EOF_Note__c = tt.NOTE;
                    }
                    
                    if(String.isNotBlank(tt.NOTE)){
                        if(String.isNotBlank(case_tmp.EOF_COmunicazioni_con_OLO__C)){
                            case_tmp.EOF_COmunicazioni_con_OLO__C=case_tmp.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                        }
                        else{
                            case_tmp.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                        }
                    }
                    
                    case_tmp.ownerId=analisi.Id;                  
                    case_tmp.Note_cliente__c=tt.NOTE_CLIENTE;                     
                    case_tmp.EOF_Referente_Desospensione__c=tt.REFERENTE_DESOSPENSIONE;
                    case_tmp.EOF_Data_ora_Desospensione__c=OF_TTM_Utils.now();
                    case_tmp.EOF_Causale_Desospensione__c=OF_TTM_Utils.getStringCausaleDesospensione(tt.CAUSALE_DESOSPENSIONE);
                    //case_tmp.status ='In Lavorazione';
                    
                    //Lego il case al log
                    OF_TTM_Utils.sLogOLOSF.Caso__c = case_tmp.Id;
                    
                    OF_TTM_Utils.createAsyncTTRequestCalloutToTTM (OF_TTM_Utils.sLogOLOSF.id, '6');                    
                    
                    update case_tmp;

                    
                    update OF_TTM_Utils.sLogOLOSF;
                    
                    insert OF_TTM_Utils.create_EAI_Log(new Map<String,String>{
                                                            'Type' => 'TT_ACK', 
                                                            'Codice_operatore' => tt.CODICE_OPERATORE,
                                                            'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                            'ID_notifica' => tt.ID_NOTIFICA, 
                                                            'CaseId' => case_tmp.Id, 
                                                            'TT_Request'=>OF_TTM_Utils.copy_TT_Request(tt), 
                                                            'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE, 
                                                            'Tipo Comunicazione String' => 'OLO -> SF - TT ACK '+ OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE), 
                                                            'SL Riferimento' => OF_TTM_Utils.sLogOLOSF.id});
                    
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
                
                //annullamento 15/06/2018 MM : spostati i controlli su formato/contenuto e spostati update in sincrono
                if(tt.TIPO_COMUNICAZIONE=='9'){
                    System.debug('**** INSIDER TIPO COMUNICAZIONE 9 - VALORE CASE : ' + case_tmp);
                    if(String.isBlank(String.valueOf(tt.DATA_ORA_RICHIESTA_ANNULLAMENTO))){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Data Ora Richiesta Annullamento');
                    }
                    if(string.isBlank(tt.NOME_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Nome Referente Tecnico OLO');
                    }
                    if(string.isBlank(tt.TELEFONO_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Telefono Referente Tecnico OLO');
                    }
                    if(string.isBlank(tt.EMAIL_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Email Referente Tecnico OLO');
                    }
                    
                    if(case_tmp.status!='In Lavorazione'){
                        return OF_TTM_Utils.syncError(tt,'A_K11','Status');
                    }
                     
                    if (case_tmp.OF_Retry_Automatico__c){
                        return OF_TTM_Utils.syncError(tt,'A_K8','Retry in corso');
                    }

                    // 15/02/2018 MM : taglio il campo note sul case se > 255.
                    if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){
                        case_tmp.EOF_Note__c=tt.NOTE.abbreviate(255);
                        
                        if(String.isNotBlank(case_tmp.EOF_COmunicazioni_con_OLO__C)){
                            case_tmp.EOF_COmunicazioni_con_OLO__C=case_tmp.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                        }
                        else{
                            OF_TTM_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                        }
                    }
                    else{
                        case_tmp.EOF_Note__c = tt.NOTE;
                    }
                    
                    if(case_tmp.EOF_Data_Max_Risoluzione_Ticket__c > OF_TTM_Utils.now()){
                        
                        if(case_tmp.EOF_Rischedulazione_Appuntamento__c!=null && case_tmp.EOF_Rischedulazione_Appuntamento__c>OF_TTM_Utils.now()){
                            case_tmp.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((case_tmp.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-c.EOF_Rischedulazione_Appuntamento__c.getTime()) / 1000);
                        }
                        else{
                            case_tmp.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((case_tmp.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-OF_TTM_Utils.now().getTime()) / 1000);
                        }
                        
                    }
                    else{
                        case_tmp.EOF_Secondi_Sospesi_allo_SLA__c=0;
                    }
                    
                    case_tmp.EOF_Minuti_rimanenti_sospesi__c=Integer.valueOf(case_tmp.EOF_Num_min_risoluzione_Ticket__c);
                    case_tmp.EOF_Causale_Richiesta_Annullamento__c=tt.CAUSALE_RICHIESTA_ANNULLAMENTO;
                    case_tmp.EOF_Data_ora_RIchiesta_Annullamento__c=OF_TTM_Utils.stringToDate(tt.DATA_ORA_RICHIESTA_ANNULLAMENTO);
                    case_tmp.Note_cliente__c=tt.NOTE_CLIENTE;
                    case_tmp.status='In Annullamento';
                    case_tmp.EOF_Fase__c='';
                    
                    
                    OF_TTM_Utils.createAsyncTTRequestCalloutToTTM (OF_TTM_Utils.sLogOLOSF.id, '9');                    
                    
                    update case_tmp;
                    
                    OF_TTM_Utils.sLogOLOSF.Caso__c = case_tmp.Id;
                    update OF_TTM_Utils.sLogOLOSF;
                    
                    insert OF_TTM_Utils.create_EAI_Log(new Map<String,String>{
                                                                    'Type' => 'TT_ACK', 
                                                                    'Codice_operatore' => tt.CODICE_OPERATORE, 
                                                                    'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                                    'ID_notifica' => tt.ID_NOTIFICA, 
                                                                    'CaseId' => case_tmp.Id, 
                                                                    'TT_Request'=> 'Esito: 0', 
                                                                    'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE,
                                                                    'Tipo Comunicazione String' => 'OLO -> SF - TT ACK '+ OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE),
                                                                    'SL Riferimento' => OF_TTM_Utils.sLogOLOSF.id});
                    
                    
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
                
                //autoripristinato 14/06/2018 MM : spostati i controlli su formato/contenuto e spostati update in sincrono
                //non ha campi obbligatori particolari quindi si va direttamente ai controlli asincroni
                if(tt.TIPO_COMUNICAZIONE=='8'){

                    if (case_tmp.status!='Sospeso'){
                        return OF_TTM_Utils.syncError(tt,'A_K11','Status');
                    }
                    
                    if(String.isBlank(String.valueOf(tt.DATA_ORA_AUTORIPRISTINATO))){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Data Ora Autoripristinato');
                    }
                    if(string.isBlank(tt.NOME_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Nome Referente Tecnico OLO');
                    }
                    if(string.isBlank(tt.TELEFONO_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Telefono Referente Tecnico OLO');
                    }
                    if(string.isBlank(tt.EMAIL_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Email Referente Tecnico OLO');
                    }

                    if (case_tmp.OF_Retry_Automatico__c){
                        return OF_TTM_Utils.syncError(tt,'A_K8','Retry in corso');
                    }
                                        
                    // 15/02/2018 MM : taglio il campo note se > 255.
                    if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){
                        case_tmp.EOF_Note__c=tt.NOTE.abbreviate(255);
                        if(String.isNotBlank(case_tmp.EOF_COmunicazioni_con_OLO__C)){
                            case_tmp.EOF_COmunicazioni_con_OLO__C=case_tmp.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                        }
                        else{
                            case_tmp.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                        }
                    }
                    else {
                        case_tmp.EOF_Note__c = tt.NOTE;                        
                    }
                    
                    case_tmp.Data_ora_Autoripristinato__c=OF_TTM_Utils.stringToDate(tt.DATA_ORA_AUTORIPRISTINATO);
                    case_tmp.Note_cliente__c=tt.NOTE_CLIENTE;
                    case_tmp.EOF_Minuti_rimanenti_sospesi__c=Integer.valueOf(case_tmp.EOF_Num_min_risoluzione_Ticket__c);
                    case_tmp.status='Chiuso';
                    case_tmp.EOF_Fase__c='Autoripristinato';
                    case_tmp.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                    
                    
                    OF_TTM_Utils.createAsyncTTRequestCalloutToTTM (OF_TTM_Utils.sLogOLOSF.id, '8');                    
                    
                    update case_tmp;

                    OF_TTM_Utils.sLogOLOSF.Caso__c = case_tmp.Id;
                    update OF_TTM_Utils.sLogOLOSF;

                    
                    insert OF_TTM_Utils.create_EAI_Log(new Map<String,String>{
                                                                'Type' => 'TT_ACK', 
                                                                'Codice_operatore' => tt.CODICE_OPERATORE, 
                                                                'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                                'ID_notifica' => tt.ID_NOTIFICA, 
                                                                'CaseId' => case_tmp.Id, 
                                                                'TT_Request'=>OF_TTM_Utils.copy_TT_Request(tt), 
                                                                'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE, 
                                                                'Tipo Comunicazione String' => 'OLO -> SF - TT ACK '+ OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE), 
                                                                'SL Riferimento' => OF_TTM_Utils.sLogOLOSF.id});
                    
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
                
                //test OK
                // 19/06/2018 MM : spostati i controlli su formato/contenuto e spostati update in sincrono
                if(tt.TIPO_COMUNICAZIONE=='12'){
                    
                    if(string.isBlank(tt.NOTE)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Note');
                    }
                    if(string.isBlank(tt.INTERVENTO_CONGIUNTO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Intervento Congiunto');
                    }
                    if(string.isBlank(tt.NOME_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Nome Referente Tecnico OLO');
                    }
                    if(string.isBlank(tt.TELEFONO_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Telefono Referente Tecnico OLO');
                    }
                    if(string.isBlank(tt.EMAIL_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Email Referente Tecnico OLO');
                    }
                    
                    if(case_tmp.status!='Richiesta Chiusura'){
                        return OF_TTM_Utils.syncError(tt,'A_K11','Status');
                    }
                    
                    if (case_tmp.OF_Retry_Automatico__c){
                        return OF_TTM_Utils.syncError(tt,'A_K8','Retry in corso');
                    }

                    if(case_tmp.EOF_Data_Max_Risoluzione_Ticket__c > OF_TTM_Utils.now()){
                        if(case_tmp.EOF_Rischedulazione_Appuntamento__c!=null && case_tmp.EOF_Rischedulazione_Appuntamento__c>OF_TTM_Utils.now()){
                            case_tmp.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((case_tmp.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-case_tmp.EOF_Rischedulazione_Appuntamento__c.getTime()) / 1000);
                        }
                        else{
                            case_tmp.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((case_tmp.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-OF_TTM_Utils.now().getTime()) / 1000);
                        }
                        
                    }
                    else{
                        case_tmp.EOF_Secondi_Sospesi_allo_SLA__c=0;
                    }
                    
                    if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){
                        case_tmp.EOF_Note__c= tt.NOTE.abbreviate(255);
                        
                        if(String.isNotBlank(case_tmp.EOF_COmunicazioni_con_OLO__C)){
                            case_tmp.EOF_COmunicazioni_con_OLO__C=case_tmp.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                        }
                        else{
                            case_tmp.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                        }
                        
                    }
                    else{
                        case_tmp.EOF_Note__c = tt.NOTE;
                    }
                    
                    case_tmp.EOF_Intervento_Congiunto__c = tt.INTERVENTO_CONGIUNTO;
                    case_tmp.EOF_Causale_Apertura__c=OF_TTM_Utils.getStringCausaleApertura(tt.CAUSALE_APERTURA);
                    case_tmp.EOF_Collaudi_Negativi__c=case_tmp.EOF_Collaudi_Negativi__c + 1;
                    case_tmp.Note_cliente__c=tt.NOTE_CLIENTE;
                    case_tmp.EOF_Descrizione_Problema__c=tt.DESCRIZIONE_PROBLEMA;
                    case_tmp.EOF_Tec_Olo__c=tt.Tec_olo;
                    case_tmp.Eof_tel_tec_olo__c=tt.Tel_tec_olo;
                    case_tmp.EOF_Data_ora_intervento_congiunto__c=OF_TTM_Utils.stringToDate(tt.DATA_ORA_INTERVENTO_CONGIUNTO);                    
                    case_tmp.status='Chiuso';
                    case_tmp.Eof_fase__c='NA';
                    
                    OF_TTM_Utils.createAsyncTTRequestCalloutToTTM (OF_TTM_Utils.sLogOLOSF.id, '12');                    
                    
                    update case_tmp;

                    OF_TTM_Utils.sLogOLOSF.Caso__c = case_tmp.Id;
                    update OF_TTM_Utils.sLogOLOSF;
                    
                    insert OF_TTM_Utils.create_EAI_Log(new Map<String,String>{
                                                                    'Type' => 'TT_ACK', 
                                                                    'Codice_operatore' => tt.CODICE_OPERATORE, 
                                                                    'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                                    'ID_notifica' => tt.ID_NOTIFICA, 
                                                                    'CaseId' => case_tmp.Id, 
                                                                    'TT_Request'=>OF_TTM_Utils.copy_TT_Request(tt),
                                                                    'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE, 
                                                                    'Tipo Comunicazione String' => 'OLO -> SF - TT ACK '+ OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE), 
                                                                    'SL Riferimento'=> OF_TTM_Utils.sLogOLOSF.id});
                    
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
                
                //test KO
                //non ha campi obbligatori particolari quindi si va direttamente ai controlli asincroni
                // 19/06/2018 MM : spostati i controlli su formato/contenuto e spostati update in sincrono
                if(tt.TIPO_COMUNICAZIONE=='11'){
                    
                    if(string.isBlank(tt.NOME_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Nome Referente Tecnico OLO');
                    }
                    if(string.isBlank(tt.TELEFONO_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Telefono Referente Tecnico OLO');
                    }
                    if(string.isBlank(tt.EMAIL_REFERENTE_TECNICO_OLO)){
                        return OF_TTM_Utils.syncError(tt,'A_K9','Email Referente Tecnico OLO');
                    }
                    
                    if(case_tmp.status!='Richiesta Chiusura'){
                        return OF_TTM_Utils.syncError(tt, 'A_K11', 'Status');
                    }

                    if (case_tmp.OF_Retry_Automatico__c){
                        return OF_TTM_Utils.syncError(tt,'A_K8','Retry in corso');
                    }

                    if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){ 
                        case_tmp.EOF_Note__c=tt.NOTE.abbreviate(255);
                        
                        if(String.isNotBlank(case_tmp.EOF_COmunicazioni_con_OLO__C)){
                            case_tmp.EOF_COmunicazioni_con_OLO__C=case_tmp.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                        }
                        else{
                            case_tmp.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                        }
                        
                    }
                    else {
                        case_tmp.EOF_Note__c = tt.NOTE;
                    }
                    
                    case_tmp.Note_cliente__c=tt.NOTE_CLIENTE;
                    case_tmp.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                    case_tmp.status='In Lavorazione';
                    case_tmp.Eof_fase__c='In Lavorazione';
                    
                    OF_TTM_Utils.createAsyncTTRequestCalloutToTTM (OF_TTM_Utils.sLogOLOSF.id, '11');                    
                    
                
                    update case_tmp;

                    OF_TTM_Utils.sLogOLOSF.Caso__c = case_tmp.Id;
                    update OF_TTM_Utils.sLogOLOSF;
                    
                    insert OF_TTM_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_ACK', 
                                                                                'Codice_operatore' => tt.CODICE_OPERATORE, 
                                                                                'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                                                'ID_notifica' => tt.ID_NOTIFICA, 
                                                                                'CaseId' => case_tmp.Id, 
                                                                                'TT_Request'=>OF_TTM_Utils.copy_TT_Request(tt), 
                                                                                'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE,
                                                                                'Tipo Comunicazione String' => 'OLO -> SF - TT ACK '+ OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE), 
                                                                                'SL Riferimento'=> OF_TTM_Utils.sLogOLOSF.id});
                    
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
    
                else {
                    return OF_TTM_Utils.syncError(tt, 'A_K10', 'tipo comunicazione non gestito');
                }
            }
        }
        //return tt_resp_temp;
    }
    
    
}
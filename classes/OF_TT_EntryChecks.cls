public with sharing class OF_TT_EntryChecks {
    //public static OF_TT_WS_TroubleTicketRequest.TroubleTicket tt_temp;
    public static OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse tt_resp_temp;
    public static List<Case> case_tmp_list;
    //AS
    public static case c;
    public static boolean portale=false;
    public static boolean checkSynchError=false; 
    
    
    public static EOF_EAI_Service_Log__c PORTAL_checkSync(OF_TT_WS_TroubleTicketRequest.TroubleTicket tt, EOF_EAI_Service_Log__c slPort){
    	//OF_SA_OLO_AsyncChecks.PORTAL=true;
    	insert OF_TT_Utils.create_EAI_Log(tt);
    	OF_TT_EntryChecks.portale=true;
        OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse resp = checkSync(tt);
        if(resp.esito=='0'){
        	//lo aggiorniamo con il metodo messo sulla notifica asincrona
        	/*
            slPort.EOF_Stato_Ordine__c=OF_TT_EntryChecks.c.status;
            slPort.EOF_COdice_MOtivazione__c=OF_TT_EntryChecks.c.OF_SA_CODICE_MOTIVAZIONE__c;
            slPort.EOF_MOtivazione__c=OF_TT_EntryChecks.c.OF_SA_CODICE_MOTIVAZIONE__c+' - '+OF_TT_EntryChecks.c.OF_SA_MOTIVAZIONE__c;
            slPort.EOF_Codice_ordine_eof__c=Id.valueOf(OF_TT_EntryChecks.c.Id);
            */
            slPort.PO_SA_Data_Inserimento_Ordine__c=system.now(); 
            slPort.PO_TT_Tipo_Risorsa__c=OF_TT_EntryChecks.c.OF_TT_Tipo_Risorsa__c;
            slPort.EOF_Stato_Richiesta__c='Inserita Portale';
           
        }
        else{
        	slPort.EOF_MOtivazione__c=resp.CausaleErrore;
        	if(resp.CodiceErrore=='A_K8'){
        		slPort.EOF_MOtivazione__c='Servizio Momentaneamente non disponibile';
        	}
            //slPort.EOF_Stato_Ordine__c='error';
            OF_TT_EntryChecks.checkSynchError=true;
            slPort.EOF_Stato_Richiesta__c='Bozza Portale';
            slPort.EOF_COdice_MOtivazione__c=resp.CodiceErrore;
            
        }
        slPort.EOF_Stato_Ordine__c=OF_TT_EntryChecks.c.Status;
    	return slPort;
    }
    
    	
    public static OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse checkSync(OF_TT_WS_TroubleTicketRequest.TroubleTicket tt){
        
        //check for errore sincrono AK9: campo obbligatorio con controllo sincrono vuoto sui campi obbligatori per tutte le richieste
        if (String.isBlank(tt.TIPO_COMUNICAZIONE)){
            return OF_TT_Utils.syncError(tt, 'A_K9', 'Tipo Comunicazione');         
        }
        else if(String.isBlank(tt.CODICE_OPERATORE)){
                return OF_TT_Utils.syncError(tt, 'A_K9', 'Codice Operatore');
        }
        else if(String.isBlank(tt.CODICE_COMUNICAZIONE_OLO)){
            return OF_TT_Utils.syncError(tt, 'A_K9', 'Codice Comunicazione OLO');
        }
        else if(String.isBlank(tt.CATEGORIA_GUASTO)){
            return OF_TT_Utils.syncError(tt, 'A_K9', 'Categoria Guasto');
        }
        else if(String.isBlank(tt.ID_NOTIFICA)){
            return OF_TT_Utils.syncError(tt, 'A_K9', 'Id Notifica');
        }
        else if(String.isBlank(tt.ID_RISORSA)){
            return OF_TT_Utils.syncError(tt, 'A_K9', 'Id Risorsa');
        }
        else if(tt.TIPO_COMUNICAZIONE=='9' && String.isblank(tt.CAUSALE_RICHIESTA_ANNULLAMENTO)){
            return OF_TT_Utils.syncError(tt, 'A_K9', 'Causale Richiesta Annullamento');
        }
        else if(tt.TIPO_COMUNICAZIONE=='6' && String.isblank(tt.CAUSALE_DESOSPENSIONE)){
            return OF_TT_Utils.syncError(tt, 'A_K9', 'Causale Desospensione');
        }
        else if((tt.TIPO_COMUNICAZIONE=='1' || tt.TIPO_COMUNICAZIONE=='11') && String.isblank(tt.CAUSALE_APERTURA)){
            return OF_TT_Utils.syncError(tt, 'A_K9', 'Causale Apertura');
        }

        //A_K10 sync check - format su tutti i campi obbligatori per tutti
        
        else if(tt.TIPO_COMUNICAZIONE != '1'  && tt.TIPO_COMUNICAZIONE != '9'  && tt.TIPO_COMUNICAZIONE != '6'  && tt.TIPO_COMUNICAZIONE != '8'
                 && tt.TIPO_COMUNICAZIONE != '11' && tt.TIPO_COMUNICAZIONE != '12' && tt.TIPO_COMUNICAZIONE != '20'){
            return OF_TT_Utils.syncError(tt, 'A_K10', 'Tipo Comunicazione');            
        }  
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple)
            if(tt.CODICE_OPERATORE == s.getLabel())
                olo_found = true;

        if(!olo_found)
                 return OF_TT_Utils.syncError(tt, 'A_K10', 'Codice Operatore'); 
        
        else if(tt.CODICE_COMUNICAZIONE_OLO.length() > 50){
             return OF_TT_Utils.syncError(tt, 'A_K10', 'Codice Comunicazione OLO');
        }
        else if(tt.CATEGORIA_GUASTO != '0' && tt.CATEGORIA_GUASTO != '1' && tt.CATEGORIA_GUASTO != '2'){
             return OF_TT_Utils.syncError(tt, 'A_K10', 'Categoria Guasto');
        }
        else if(tt.ID_NOTIFICA.length() > 100){
             return OF_TT_Utils.syncError(tt, 'A_K10', 'Id Notifica');
        }
        else if(tt.ID_RISORSA.length() > 50){
             return OF_TT_Utils.syncError(tt, 'A_K10', 'Id Risorsa');
        }
        else {
            //Creo una lista di case che utilizzerò piu tardi
            case_tmp_list= [select Id,EOF_codice_Operatore_WS__c,EOF_categoria_guasto__c,EOF_ID_Risorsa__c,Status,
                			Eof_fase__c,EOF_Minuti_rimanenti_sospesi__c,EOF_Codice_Comunicazione_OLO__c,
                			EOF_Comunicazioni_con_OLO__c,EOF_Num_min_risoluzione_Ticket__c,EOF_Data_Max_Risoluzione_Ticket__c,
                			EOF_Secondi_Sospesi_allo_SLA__c, EOF_SLA_Premium_Assurance__c, EOF_Collaudi_Negativi__c,
                			EOF_Causale_Sospensione__c,EOF_Rischedulazione_Appuntamento__c 
                			from Case where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO];
            //superati i controlli sincroni creiamo il case, andiamo in quelli asincroni e ritorniamo la response positiva
            //ipotizzare successivamente un metodo che mi torna tutti i rtype in una mappa che poi posso utilizzare in tutta la classe
            //check per il tipo comunicazione, se 1 creo il case, se 2 vado in update
            if(tt.TIPO_COMUNICAZIONE=='1'){
                
                List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
                List<Account> oloId = [SELECT Id, Type, EOF_Codice_Operatore__c  FROM Account WHERE RecordType.Name = 'OLO' AND EOF_Codice_Operatore__c =: tt.CODICE_OPERATORE LIMIT 1];
                if (oloId.isEmpty()){
                	return OF_TT_Utils.syncError(tt, 'A_K10', 'Codice Operatore');
                }
                Case case_tmp = new Case(
                                            RecordTypeId = rt[0].Id,
                                            EOF_Account_OLO__c = oloId[0].id,
                                            EOF_Codice_Comunicazione_OLO__c = tt.CODICE_COMUNICAZIONE_OLO,
                                            EOF_Codice_Operatore_WS__c = tt.CODICE_OPERATORE,               
                                            EOF_Categoria_Guasto__c = OF_TT_Utils.getStringCategoriaGuasto(tt.CATEGORIA_GUASTO),
                                            EOF_Id_Notifica__c = tt.ID_NOTIFICA,
                                            EOF_Id_Risorsa__c = tt.ID_RISORSa,
                                            EOF_Causale_Apertura__c = OF_TT_Utils.getStringCausaleApertura(tt.CAUSALE_APERTURA), 
                                            Origin = 'Web',
                                            Subject = 'Richiesta risoluzione guasto',
                                            Type = OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE),
                                            Description = tt.NOTE
                                         );
                 if(OF_TT_EntryChecks.portale){
                 	case_tmp.PO_TT_Portale__c=true;
                 }
                try{   
                    insert case_tmp;    
                }
                catch(DMLException e){
                    return OF_TT_Utils.syncError(tt, 'A_K10', e.getDmlFields(0).get(0).getdescribe().getlabel());                               
                }

                insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_ACK', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                    'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' => case_tmp.Id, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                checkAsync(case_tmp,tt);
                tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                tt_resp_temp.Esito='0';
                
                return tt_resp_temp;
            }

            //check per tutti gli altri casi in cui devo aggiornare il case
            else{
                
                //check per controllare che i campi obbligatori sincroni corrispondano a quelli del case che abbiamo a sistema
                if(case_tmp_list.isEmpty()){
                    return OF_TT_Utils.syncError(tt, 'A_K10', 'Codice Comunicazione OLO');
                }
                Case case_tmp=case_tmp_list[0];
                if (case_tmp.EOF_codice_Operatore_WS__c!=tt.Codice_operatore){
                    return OF_TT_Utils.syncError(tt, 'A_K10', 'Codice operatore');
                }
                if (case_tmp.EOF_categoria_guasto__c!=OF_TT_Utils.getStringCategoriaGuasto(tt.CATEGORIA_GUASTO)){
                    return OF_TT_Utils.syncError(tt, 'A_K10', 'Categoria guasto');
                }
                if (case_tmp.EOF_ID_Risorsa__c!=tt.ID_RISORSA){
                    return OF_TT_Utils.syncError(tt, 'A_K10', 'ID_RISORSA');
                }
                //check sui campi obbligatori sincroni per tipo di comunicazione
                //Desospensione
                if(tt.TIPO_COMUNICAZIONE=='6'){
                    case_tmp.EOF_Causale_Desospensione__c=OF_TT_Utils.getStringCausaleDesospensione(tt.CAUSALE_DESOSPENSIONE);
                    try{
                        update case_tmp;
                    }
                    catch(DMLException e){             
                        return OF_TT_Utils.syncError(tt, 'A_K10', 'CAUSALE_DESOSPENSIONE');        
                    }
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_ACK', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' => case_tmp.Id, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    checkAsync(case_tmp,tt);
                    
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
                //annullamento
                if(tt.TIPO_COMUNICAZIONE=='9'){
                    case_tmp.EOF_Causale_Richiesta_Annullamento__c=tt.CAUSALE_RICHIESTA_ANNULLAMENTO;
                    try{
                        update case_tmp;
                    }
                    catch(DMLException e){             
                        return OF_TT_Utils.syncError(tt, 'A_K10', 'CAUSALE_RICHIESTA_ANNULLAMENTO');        
                    }
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_ACK', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' => case_tmp.Id, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    checkAsync(case_tmp,tt);
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
                //autoripristinato
                //non ha campi obbligatori particolari quindi si va direttamente ai controlli asincroni
                if(tt.TIPO_COMUNICAZIONE=='8'){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_ACK', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' => case_tmp.Id, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    checkAsync(case_tmp,tt);
                    
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
                //test OK
                if(tt.TIPO_COMUNICAZIONE=='11'){
                    case_tmp.EOF_Causale_Apertura__c=OF_TT_Utils.getStringCausaleApertura(tt.CAUSALE_APERTURA);
                    try{
                        update case_tmp;
                    }
                    catch(DMLException e){             
                        return OF_TT_Utils.syncError(tt, 'A_K10', 'CAUSALE_APERTURA');        
                    }
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_ACK', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' => case_tmp.Id, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    checkAsync(case_tmp,tt);
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
                //test KO
                //non ha campi obbligatori particolari quindi si va direttamente ai controlli asincroni
                if(tt.TIPO_COMUNICAZIONE=='12'){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_ACK', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' => case_tmp.Id, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    checkAsync(case_tmp,tt);
                    
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
                //aggiornamento dati
                //non ha campi obbligatori particolari quindi si va direttamente ai controlli asincroni
                if(tt.TIPO_COMUNICAZIONE=='20'){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_ACK', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' => case_tmp.Id, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    checkAsync(case_tmp,tt);
                    
                    tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
                    tt_resp_temp.Esito='0';
                    return tt_resp_temp;
                }
                else {
                    return OF_TT_Utils.syncError(tt, 'A_K10', 'tipo comunicazione non gestito');
                }
            }
        }

        
        return tt_resp_temp;
    }


    public static void checkAsync(Case cs, OF_TT_WS_TroubleTicketRequest.TroubleTicket tt){
    	
    	OF_TT_EntryChecks.c=cs;
    	
    	Group analisi = [SELECT Id FROM Group WHERE Name = 'Trouble Ticket - Coda Analisi' AND Type = 'Queue'];    
        //check per causale scarto 1 (formato dati errato o incompleto)
        //il check sarà fatto in base al tipo comunicazione, in quanto se 1 allora il case sarà scartato, altrimenti non verrà effettuata alcuna
        //modifica sui case esistenti
        List<Asset> a = [select Id,OF_GPON_Attestazione__c,createdDate,Status,recordtype.name,
        				EOF_ID_Splitter_Secondario__c,EOF_Posizione_Splitter_Secondario__c,
        				EOF_SLA_Premium_Assurance__c from Asset where EOF_Id_Risorsa__c=:tt.ID_RISORSA LIMIT 1];
        system.debug('@@@@@@@@@@@@ asset è: '+a);
        if(tt.TIPO_COMUNICAZIONE=='1'){
            if(String.isBlank(tt.NOME_REFERENTE_TECNICO_OLO)){
                String s = 'Campo \'' + 'Nome Referente Tecnico OLO' + '\' obbligatorio non valorizzato';
                OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
                OF_TT_EntryChecks.c.Status = 'Scartato';
                OF_TT_EntryChecks.c.OF_TT_Tipo_Risorsa__c=a[0].recordtype.name;
                OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s);
                return;
            }
            if(String.isBlank(tt.TELEFONO_REFERENTE_TECNICO_OLO)){
                String s = 'Campo \'' + 'Telefono Referente Tecnico OLO' + '\' obbligatorio non valorizzato';
               OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
               OF_TT_EntryChecks.c.Status = 'Scartato';
               OF_TT_EntryChecks.c.OF_TT_Tipo_Risorsa__c=a[0].recordtype.name;
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s);
                return;
            }
            if(String.isBlank(tt.EMAIL_REFERENTE_TECNICO_OLO)){
                String s = 'Campo \'' + 'Email Referente Tecnico OLO' + '\' obbligatorio non valorizzato';
               OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
               OF_TT_EntryChecks.c.Status = 'Scartato';
               OF_TT_EntryChecks.c.OF_TT_Tipo_Risorsa__c=a[0].recordtype.name;
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s);
                return;
            }
            if(tt.NOME_REFERENTE_TECNICO_OLO.length() > 255){
                String s = 'Valore campo \'' + 'Nome referente tecnico OLO' + '\' non ammesso';
               OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
               OF_TT_EntryChecks.c.Status = 'Scartato';
               OF_TT_EntryChecks.c.OF_TT_Tipo_Risorsa__c=a[0].recordtype.name;
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s); 
                return; 
            }        
            if(tt.TELEFONO_REFERENTE_TECNICO_OLO.length() > 70){
                String s = 'Valore campo \'' + 'Telefono referente tecnico OLO' + '\' non ammesso';
               OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
               OF_TT_EntryChecks.c.Status = 'Scartato';
               OF_TT_EntryChecks.c.OF_TT_Tipo_Risorsa__c=a[0].recordtype.name;
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s); 
                return; 
            }       
            if(tt.EMAIL_REFERENTE_TECNICO_OLO.length() > 255){
                String s = 'Valore campo \'' + 'Email referente tecnico OLO' + '\' non ammesso';
               OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
               OF_TT_EntryChecks.c.Status = 'Scartato';
               OF_TT_EntryChecks.c.OF_TT_Tipo_Risorsa__c=a[0].recordtype.name;
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s); 
                return; 
            }
            //Controllo sul referente tecnico obbligatorio 
            List<Contact> tech = [SELECT Id, Name, Phone, Email,Account.Name FROM Contact WHERE 
                                LastName =: tt.NOME_REFERENTE_TECNICO_OLO AND Phone =: tt.TELEFONO_REFERENTE_TECNICO_OLO AND Email =: tt.EMAIL_REFERENTE_TECNICO_OLO 
                                and recordtype.Name='Referente Tecnico OLO' LIMIT 1];  
            if(tech.isEmpty()){
            	recordtype techRt=[select Id from RecordType where Name='Referente Tecnico OLO'];
                Contact newTech = new Contact(LastName=tt.NOME_REFERENTE_TECNICO_OLO,
                                    Phone=tt.TELEFONO_REFERENTE_TECNICO_OLO,
                                    Email=tt.EMAIL_REFERENTE_TECNICO_OLO,
                                    AccountId=OF_TT_EntryChecks.c.EOF_Account_OLO__c,
                                    RecordTypeId=techRt.id
                                    );
                try{
                    insert newTech;
                   OF_TT_EntryChecks.c.EOF_Contact__c = newTech.Id;
                }
                catch(DMLException e){
                    String s = 'Valore campo \'' + e.getDmlFields(0).get(0).getdescribe().getlabel() + ' referente tecnico\' non ammesso'; 
                   OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
                   OF_TT_EntryChecks.c.Status = 'Scartato';
                   OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                    update OF_TT_EntryChecks.c;
                    OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s); 
                    return;
                }
            }
            else{
               OF_TT_EntryChecks.c.EOF_Contact__c = tech[0].Id;
                try{
                    update OF_TT_EntryChecks.c;
                }
                catch(DMLException e ){
                    IF(e.getDmlType(0)==statuscode.FIELD_FILTER_VALIDATION_EXCEPTION){
                        String s = 'Il referente tecnico appartiene ad un OLO differente da quello del Case'; 
                       OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
                       OF_TT_EntryChecks.c.Status = 'Scartato';
                       OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                       OF_TT_EntryChecks.c.EOF_Contact__c = null;
                        update OF_TT_EntryChecks.c;
                        OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s); 
                        return;
                    }
                }
            }
            //check per ID risorsa inesistente per tipo comunicazione 1
            system.debug('@@@@@@@@@@@@@@@@@@@@@ il contact è: '+c.EOF_Contact__C);
            if (a.isEmpty()){
                //approfitto della lista per fare il check della causale 3: ID RISORSA inesistente
               OF_TT_EntryChecks.c.EOF_Causale_errore__c = 'ID Risorsa inesistente';
               OF_TT_EntryChecks.c.Status = 'Scartato';
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'ID Risorsa Inesistente', 'ID Risorsa inesistente');
                return;            
            }
            else{
            	//check se la risorsa è attiva
            	if (a[0].status!='Attivo'){
            		String s = 'La risorsa risulta non attiva';
                       OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
                       OF_TT_EntryChecks.c.Status = 'Scartato';
                       OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                        update OF_TT_EntryChecks.c;
                        OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'ID Risorsa inesistente', s);
                        return;
            	}
                //ckeck se la risorsa non è GPON
                
                if(String.isBlank(a[0].OF_GPON_Attestazione__c)){

                    if(String.isBlank(tt.COGNOME_CLIENTE)){
                        String s = 'Campo \'' + 'Cognome Cliente' + '\' non valorizzato obbligatorio per ID_RISORSA non GPON';
                       OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
                       OF_TT_EntryChecks.c.Status = 'Scartato';
                       OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                        update OF_TT_EntryChecks.c;
                        OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s);
                        return;
                    }
                    if(String.isBlank(tt.RECAPITO_TELEFONICO_CLIENTE_1)){
                        String s = 'Campo \'' + 'RECAPITO_TELEFONICO_CLIENTE_1' + '\' non valorizzato obbligatorio per ID_RISORSA non GPON';
                       OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
                       OF_TT_EntryChecks.c.Status = 'Scartato';
                       OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                        update OF_TT_EntryChecks.c;
                        OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s);
                        return;
                    }
                    
                    if(tt.COGNOME_CLIENTE.length()>255){
                        String s = 'Campo \'' + 'Cognome Cliente' + '\' non ammesso per ID_RISORSA non GPON';
                       OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
                       OF_TT_EntryChecks.c.Status = 'Scartato';
                       OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                        update OF_TT_EntryChecks.c;
                        OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s);
                        return;
                    }
                    if(tt.RECAPITO_TELEFONICO_CLIENTE_1.length()>50){
                        String s = 'Campo \'' + 'RECAPITO_TELEFONICO_CLIENTE_1' + '\' non ammesso per ID_RISORSA non GPON';
                       OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
                       OF_TT_EntryChecks.c.Status = 'Scartato';
                       OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                        update OF_TT_EntryChecks.c;
                        OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s);
                        return;
                    }
                }

                if(String.isNotBlank(tt.COGNOME_CLIENTE) && String.isNotBlank(tt.RECAPITO_TELEFONICO_CLIENTE_1)){
                    List<Account> listAcc;	
                	if(String.isBlank(tt.NOME_CLIENTE)){
                        listAcc = [select Id from Account where Name=:tt.COGNOME_CLIENTE
                                                and Phone=:tt.RECAPITO_TELEFONICO_CLIENTE_1];
                	}
                    else{
                    	listAcc = [select Id from Account where LastName=:tt.COGNOME_CLIENTE
                                                and Phone=:tt.RECAPITO_TELEFONICO_CLIENTE_1];
                    }
                    if(listAcc.isEmpty()){
                    	Account newAcc; 
                		if(String.isBlank(tt.NOME_CLIENTE)){                        
                            Recordtype rt = [SELECT Id FROM RecordType WHERE Name = 'Cliente Business'];
                            newAcc = new Account(Name = tt.COGNOME_CLIENTE,
                                                    RecordTypeId = rt.id,
                                                    Phone = tt.RECAPITO_TELEFONICO_CLIENTE_1,
                                                    EOF_Phone_2__c = tt.RECAPITO_TELEFONICO_CLIENTE_2,
                                                    EOF_Codice_Operatore__c=tt.CODICE_OPERATORE );
                		}
                		else{
                			Recordtype rt = [SELECT Id FROM RecordType WHERE Name = 'Person Account'];
                                newAcc = new Account(FirstName = tt.NOME_CLIENTE,
                                                        LastName = tt.COGNOME_CLIENTE,
                                                        RecordTypeId = rt.id,
                                                        Phone = tt.RECAPITO_TELEFONICO_CLIENTE_1,                                                           
                                                        EOF_Phone_2__c = tt.RECAPITO_TELEFONICO_CLIENTE_2,
                                                    	EOF_Codice_Operatore__c=tt.CODICE_OPERATORE );
                		}
                    
                        try{
                            insert newAcc;
                           OF_TT_EntryChecks.c.AccountId=newAcc.id;
                        }
                        catch(DMLException e){
                        	system.debug('############## account: '+newAcc);
                            String s = 'Valore campo \'' + e.getDmlFields(0).get(0).getdescribe().getlabel() + ' cliente\' non ammesso';
                           OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
                           OF_TT_EntryChecks.c.Status = 'Scartato';
                           OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                            update OF_TT_EntryChecks.c;
                            OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s); 
                            return;
                        }
                    }
	                else{
	                   OF_TT_EntryChecks.c.AccountId=listAcc[0].Id;
	                }
                    
                }
                
            }

            //check per causale scarto 2 (ticket aperto per stesso ID risorsa) da rivedere (commentiamo)
            
			List<Case> checkIfOpen =[select Id from Case where assetId=:a[0].Id AND RecordType.Name='Trouble Ticket'
									AND Status!='Annullato' AND Status!='Scartato' AND Status!='Chiuso'];
			if (!checkIfOpen.isEmpty()){
				OF_TT_EntryChecks.c.EOF_Causale_errore__c = 'Ticket aperto per stesso ID risorsa';
               OF_TT_EntryChecks.c.Status = 'Scartato';
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Ticket aperto per stesso ID risorsa', 'Ticket aperto per stesso ID risorsa');
                return;
			}
			
            //check per causale scarto 4
            if (!case_tmp_list.isEmpty()){
               OF_TT_EntryChecks.c.EOF_Causale_errore__c = 'Codice Comunicazione OLO già presente';
               OF_TT_EntryChecks.c.Status = 'Scartato';
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Codice Comunicazione OLO già presente', 'Codice Comunicazione OLO già presente');
                return;
            }
            

            //check per causale scarto 5 (da rivedere) Guasto Aperto come Post-Provisioning oltre i termini previsti
            if(tt.CATEGORIA_GUASTO=='2' && a[0].createdDate< Date.today().addDays(-10)){
               OF_TT_EntryChecks.c.EOF_Causale_errore__c = 'Guasto Aperto come Post-Provisioning oltre i termini previsti';
               OF_TT_EntryChecks.c.Status = 'Scartato';
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Guasto Aperto come Post-Provisioning oltre i termini previsti', 'Guasto Aperto come Post-Provisioning oltre i termini previsti');
                return;
            }
            
            //tiriamo fuori i giorni per il calcolo di Rip1 e Rip2
            //EOF_RIp__c r =[select EOF_Giorni_Rip1__c, EOF_Giorni_Rip2__C from EOF_Rip__C limit 1];
            
            
            //2017_04_18 nuova logica 
            Integer numCaseRip1=0;
            Integer numCaseRip2=0;
            if(OF_TT_Parametri__c.getInstance().EOF_Giorni_Rip2__c != null){
            	Date Rip2 = Date.Today().addDays(Integer.valueOf((OF_TT_Parametri__c.getInstance().EOF_Giorni_Rip2__c) * (-1)) );
            	numCaseRip2 = [select count() from Case where ClosedDate >= :Rip2 AND assetId=:a[0].Id];
            }
           	if(OF_TT_Parametri__c.getInstance().EOF_Giorni_Rip1__c != null){
            	Date Rip1 = Date.Today().addDays(Integer.valueOf((OF_TT_Parametri__c.getInstance().EOF_Giorni_Rip1__c) * (-1) ));
            	numCaseRip1 = [select count() from Case where ClosedDate >= :Rip1 AND assetId=:a[0].Id];
            }
            //implementiamo la logica di calcolo Ticket sulla stessa risorsa 
           OF_TT_EntryChecks.c.EOF_Rip1__c=numCaseRip1;
           OF_TT_EntryChecks.c.EOF_Rip2__c=numCaseRip2;
           OF_TT_EntryChecks.c.EOF_Gpon_attestazione__c=a[0].OF_GPON_Attestazione__c;
           OF_TT_EntryChecks.c.EOF_ID_Splitter_Secondario__c=a[0].EOF_ID_Splitter_Secondario__c;
           OF_TT_EntryChecks.c.EOF_Posizione_Splitter_Secondario__c=a[0].EOF_Posizione_Splitter_Secondario__c;
           OF_TT_EntryChecks.c.EOF_SLA_Premium_Assurance__c=a[0].EOF_SLA_Premium_Assurance__c;
            //qui andrà la logica di popolamento della due date e del tempo rimanente, da vedere dove estrarre se SLA o meno
            boolean premium = false;
            if(a[0].EOF_Sla_Premium_Assurance__c=='Y'){
            	premium=true;
            }
           OF_TT_EntryChecks.c.EOF_Data_Max_Risoluzione_Ticket__c=OF_TT_Utils.calcoloSLA(premium);      
            //controlli asincroni per tipo comunicazione 1 OK, check su quelli opzionali
           OF_TT_EntryChecks.c.EOF_Data_Ora_Inizio_Guasto__c = OF_TT_Utils.stringToDate(tt.DATA_ORA_INIZIO_GUASTO);
           OF_TT_EntryChecks.c.EOF_Verifica_apparato_cliente__c = tt.VERIFICA_APPARATO_CLIENTE;
           OF_TT_EntryChecks.c.EOF_Descrizione_Problema__c = tt.DESCRIZIONE_PROBLEMA;
           OF_TT_EntryChecks.c.Note_Cliente__c = tt.NOTE_CLIENTE;
           // 15/02/2018 MM : taglio campo note se > 255
           if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){
           		OF_TT_EntryChecks.c.EOF_Note__c = tt.NOTE.abbreviate(255);
           }
           else{
           		OF_TT_EntryChecks.c.EOF_Note__c = tt.NOTE;
           }
           // finisce qui 
           OF_TT_EntryChecks.c.status='In Lavorazione';
           OF_TT_EntryChecks.c.eof_fase__c='Da Lavorare';
           OF_TT_EntryChecks.c.assetId=a[0].id;
            if(String.isNotBlank(tt.NOte)){
				OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
            }
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule = true;
           OF_TT_EntryChecks.c.setOptions(dmo);
                                
            try{           	
                update OF_TT_EntryChecks.c; 
                              
            }catch(DMLException e){                 
                String s = 'Valore campo \'' + e.getDmlFields(0).get(0).getdescribe().getlabel() + '\' non ammesso';
               OF_TT_EntryChecks.c.EOF_Verifica_apparato_cliente__c = '';
               OF_TT_EntryChecks.c.EOF_Descrizione_Problema__c = '';
               OF_TT_EntryChecks.c.Note_Cliente__c = '';
               OF_TT_EntryChecks.c.EOF_Note__c = ''; 
               OF_TT_EntryChecks.c.EOF_Causale_errore__c = s;
               OF_TT_EntryChecks.c.Status = 'Scartato';
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
               OF_TT_EntryChecks.c.eof_fase__c='';
                update OF_TT_EntryChecks.c;
                OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 2, 'Formato dati errato o incompleto', s); 
                return;            
            }
            OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c, 3, '0', '');
            return;
        }

        //check per tutti gli altri casi in cui il case è gia a sistema
        else{
            if(String.isBlank(tt.NOME_REFERENTE_TECNICO_OLO)){
                insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'NOME_REFERENTE_TECNICO_OLO non valorizzato', 'Causale_errore' => 'Controllo Asincrono KO', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                return;
            }
            if(String.isBlank(tt.TELEFONO_REFERENTE_TECNICO_OLO)){
                insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'TELEFONO_REFERENTE_TECNICO_OLO non valorizzato', 'Causale_errore' => 'Controllo Asincrono KO', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                return;
            }
            if(String.isBlank(tt.EMAIL_REFERENTE_TECNICO_OLO)){
                insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'EMAIL_REFERENTE_TECNICO_OLO non valorizzato', 'Causale_errore' => 'Controllo Asincrono KO', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                return;
            }
            
            if(String.isBlank(a[0].OF_GPON_Attestazione__c)){
                if(String.isBlank(tt.COGNOME_CLIENTE)){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'COGNOME_CLIENTE per risorsa non GPON non valorizzato', 'Causale_errore' => 'Controllo Asincrono KO', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    return;
                }
                if(String.isBlank(tt.RECAPITO_TELEFONICO_CLIENTE_1)){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'RECAPITO_TELEFONICO_CLIENTE_1 per risorsa non GPON non valorizzato', 'Causale_errore' => 'Controllo Asincrono KO', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt)
                                            , 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    return;
                }               
                List<Account> listAcc = [select Id from Account where Name=:tt.NOME_CLIENTE+' ' +tt.COGNOME_CLIENTE
                                                and Phone=:tt.RECAPITO_TELEFONICO_CLIENTE_1];
                if(listAcc.isEmpty()){
                    Recordtype accRec  = [select Id from RecordType
                                                 where Name='Cliente Business'];
                    Account newAcc = new Account(Name=tt.NOME_CLIENTE+' ' +tt.COGNOME_CLIENTE,
                                                Phone=tt.RECAPITO_TELEFONICO_CLIENTE_1,
                                                EOF_Phone_2__c=tt.RECAPITO_TELEFONICO_CLIENTE_2,
                                                EOF_Codice_Operatore__c=tt.CODICE_OPERATORE,
                                                RecordTypeId=accRec.Id
                                                );
                    try{
                        insert newAcc;
                       OF_TT_EntryChecks.c.AccountId=newAcc.id;
                    }
                    catch(DMLException e){
                        String s = 'Valore campo \'' + e.getDmlFields(0).get(0).getdescribe().getlabel() + ' cliente\' non ammesso';
                        system.debug('l errore è: '+s);
                        insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                        'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => s +' obbligatorio per risorsa non GPON', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                        return;
                    }
                }
                else{
                   OF_TT_EntryChecks.c.AccountId=listAcc[0].Id;
                }
                

            }
            
            List<Contact> tech = [SELECT Id, Name, Phone, Email,Account.Name FROM Contact WHERE 
                                LastName =: tt.NOME_REFERENTE_TECNICO_OLO AND Phone =: tt.TELEFONO_REFERENTE_TECNICO_OLO AND Email =: tt.EMAIL_REFERENTE_TECNICO_OLO 
                                and recordtype.Name='Referente Tecnico OLO' LIMIT 1];  
            if(tech.isEmpty()){
            	recordtype techRt=[select Id from RecordType where Name='Referente Tecnico OLO'];
                Contact newTech = new Contact(LastName=tt.NOME_REFERENTE_TECNICO_OLO,
                                    Phone=tt.TELEFONO_REFERENTE_TECNICO_OLO,
                                    Email=tt.EMAIL_REFERENTE_TECNICO_OLO,
                                    AccountId=OF_TT_EntryChecks.c.EOF_Account_OLO__c,
                                    RecordTypeId=techRt.id
                                    );
                try{
                    insert newTech;
                   OF_TT_EntryChecks.c.EOF_Contact__c = newTech.Id;
                }
                catch(DMLException e){
                    String s = 'Valore campo \'' + e.getDmlFields(0).get(0).getdescribe().getlabel() + ' referente tecnico\' non ammesso'; 
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => s , 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    return;
                }
            }
            else{
               OF_TT_EntryChecks.c.EOF_Contact__c = tech[0].Id;
                try{
                    update OF_TT_EntryChecks.c;
                }
                catch(DMLException e ){
                    IF(e.getDmlType(0)==statuscode.FIELD_FILTER_VALIDATION_EXCEPTION){
                        String s = 'Il referente tecnico appartiene ad un OLO differente da quello del Case'; 
                        insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => s , 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                        return;
                    }
                }
            }
            //check per tipo comunicazione
            //desospensione
            if(tt.TIPO_COMUNICAZIONE=='6'){
                if(String.isBlank(String.valueOf(tt.DATA_ORA_DESOSPENSIONE))){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'DATA_ORA_DESOSPENSIONE non valorizzato', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE });
                    return;
                }
                if(OF_TT_Utils.stringToDate(tt.DATA_ORA_DESOSPENSIONE) <= OF_TT_Utils.now().addMinutes(1)){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'DATA_ORA_DESOSPENSIONE non può essere retroattiva', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE });
                    return;
                }
                if(String.isBlank(tt.REFERENTE_DESOSPENSIONE)){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'REFERENTE_DESOSPENSIONE non valorizzato', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE });
                    return;
                }
                
                if (OF_TT_EntryChecks.c.status!='Sospeso'){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'Status non congruente con richiesta desospensione', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE });
                    return;
                }
               
               OF_TT_EntryChecks.c.EOF_Referente_Desospensione__c=tt.REFERENTE_DESOSPENSIONE;
               OF_TT_EntryChecks.c.EOF_Data_ora_Desospensione__c=OF_TT_Utils.now();
               // 15/02/2018 MM : taglio il campo note se > 255.
               if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){
               		OF_TT_EntryChecks.c.EOF_Note__c=tt.NOTE.abbreviate(255);
               }
               else {
               		OF_TT_EntryChecks.c.EOF_Note__c = tt.NOTE;
               }
               // finisce qui.
               OF_TT_EntryChecks.c.Note_cliente__c=tt.NOTE_CLIENTE;
                //c.status='In Lavorazione';
                //c.eof_fase__c='Da Lavorare';
                
                
                
              
                if(String.isNotBlank(tt.NOTE)){
                	if(String.isNotBlank(OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C)){
                		OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                	}
                	else{
                		OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                	}
                }
               OF_TT_EntryChecks.c.ownerId=analisi.Id;
                try{
                    update OF_TT_EntryChecks.c;
                    //lego il log TroubleTicketRequest al case
                    List<EOF_EAI_Service_Log__c> logs =[select Id from EOF_EAI_Service_Log__c where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO
                                                and RecordType.Name ='TroubleTicketRequest' order by  CreatedDate DESC LIMIT 1];
                    
                    if (!logs.isEmpty()){
                        logs[0].Caso__c=OF_TT_EntryChecks.c.Id;
                        update logs[0];
                    }
                    OF_TT_Utils.create_notify(OF_TT_EntryChecks.c, 4,tt.DATA_ORA_DESOSPENSIONE, 'Invia');
                }
                catch(DMLException e){
                    String s = 'Valore campo \'' + e.getDmlFields(0).get(0).getdescribe().getlabel() + ' non ammesso';
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                    'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => s, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE });
                    return;
                }
                return;

            }
            //autoripristinato
            if(tt.TIPO_COMUNICAZIONE=='8'){
                if(String.isBlank(String.valueOf(tt.DATA_ORA_AUTORIPRISTINATO))){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'DATA_ORA_AUTORIPRISTINATO non valorizzato', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE });
                    return;
                }
                if (OF_TT_EntryChecks.c.status!='Sospeso'){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'Status non congruente con richiesta autoripristino', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE });
                    return;
                }
               OF_TT_EntryChecks.c.Data_ora_Autoripristinato__c=OF_TT_Utils.stringToDate(tt.DATA_ORA_AUTORIPRISTINATO);
               // 15/02/2018 MM : taglio il campo note se > 255.
               if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){
               		OF_TT_EntryChecks.c.EOF_Note__c=tt.NOTE.abbreviate(255);
               }
               else {
               		OF_TT_EntryChecks.c.EOF_Note__c = tt.NOTE;
               }
               //finisce qui
                if(String.isNotBlank(tt.NOTE)){
                	if(String.isNotBlank(OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C)){
                		OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                	}
                	else{
                		OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                	}
                }
               OF_TT_EntryChecks.c.Note_cliente__c=tt.NOTE_CLIENTE;
               OF_TT_EntryChecks.c.EOF_Minuti_rimanenti_sospesi__c=Integer.valueOf(OF_TT_EntryChecks.c.EOF_Num_min_risoluzione_Ticket__c);
               OF_TT_EntryChecks.c.status='Chiuso';
               OF_TT_EntryChecks.c.EOF_Fase__c='Autoripristinato';
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                try{
                    update OF_TT_EntryChecks.c;
                    List<EOF_EAI_Service_Log__c> logs =[select Id from EOF_EAI_Service_Log__c where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO
                                                and RecordType.Name ='TroubleTicketRequest' order by  CreatedDate DESC LIMIT 1];
                    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ la lista dei log è: '+logs);
                    if (!logs.isEmpty()){
                        logs[0].Caso__c=OF_TT_EntryChecks.c.Id;
                        update logs[0];
                    }
                }
                catch(DMLException e){
                    String s = 'Valore campo \'' + e.getDmlFields(0).get(0).getdescribe().getlabel() + ' non ammesso';
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                    'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => s , 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    return;
                }
                return;
            }
            //annullamento
            if(tt.TIPO_COMUNICAZIONE=='9'){
                if(String.isBlank(String.valueOf(tt.DATA_ORA_RICHIESTA_ANNULLAMENTO))){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'DATA_ORA_RICHIESTA_ANNULLAMENTO non valorizzato' , 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    return;
                }
                if (OF_TT_EntryChecks.c.status!='In Lavorazione'){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'status non congruente con annullamento', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE });
                    return;
                }
               OF_TT_EntryChecks.c.EOF_Data_ora_RIchiesta_Annullamento__c=OF_TT_Utils.stringToDate(tt.DATA_ORA_RICHIESTA_ANNULLAMENTO);
               // 15/02/2018 MM : taglio il campo note sul case se > 255.
               if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){
               		OF_TT_EntryChecks.c.EOF_Note__c=tt.NOTE.abbreviate(255);
               }
               else{
               		OF_TT_EntryChecks.c.EOF_Note__c = tt.NOTE;
               }
               // finisce qui
               OF_TT_EntryChecks.c.EOF_Minuti_rimanenti_sospesi__c=Integer.valueOf(OF_TT_EntryChecks.c.EOF_Num_min_risoluzione_Ticket__c);
                //c.EOF_Data_Max_Risoluzione_Ticket__c=null;
                if(OF_TT_EntryChecks.c.EOF_Data_Max_Risoluzione_Ticket__c > OF_TT_Utils.now()){
                	if(OF_TT_EntryChecks.c.EOF_Rischedulazione_Appuntamento__c!=null &&OF_TT_EntryChecks.c.EOF_Rischedulazione_Appuntamento__c>OF_TT_Utils.now()){
                		OF_TT_EntryChecks.c.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((OF_TT_EntryChecks.c.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-c.EOF_Rischedulazione_Appuntamento__c.getTime()) / 1000);
                	}
                	else{
                		OF_TT_EntryChecks.c.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((OF_TT_EntryChecks.c.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-OF_TT_Utils.now().getTime()) / 1000);
                	}
                	
                }
                else{
                	OF_TT_EntryChecks.c.EOF_Secondi_Sospesi_allo_SLA__c=0;
                }
                if(String.isNotBlank(tt.NOTE)){
                	if(String.isNotBlank(OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C)){
                		OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                	}
                	else{
                		OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                	}
                }
               OF_TT_EntryChecks.c.Note_cliente__c=tt.NOTE_CLIENTE;
               OF_TT_EntryChecks.c.status='In Annullamento';
               OF_TT_EntryChecks.c.EOF_Fase__c='';
                Database.DMLOptions dmo = new Database.DMLOptions();
            	dmo.assignmentRuleHeader.useDefaultRule = true;
            	OF_TT_EntryChecks.c.setOptions(dmo);
                try{
                    update OF_TT_EntryChecks.c;
                    List<EOF_EAI_Service_Log__c> logs =[select Id from EOF_EAI_Service_Log__c where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO
                                                and RecordType.Name ='TroubleTicketRequest' order by  CreatedDate DESC LIMIT 1];
                    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ la lista dei log è: '+logs);
                    if (!logs.isEmpty()){
                        logs[0].Caso__c=OF_TT_EntryChecks.c.Id;
                        update logs[0];
                    }
                }
                catch(DMLException e){
                    String s = 'Valore campo \'' + e.getDmlFields(0).get(0).getdescribe().getlabel() + ' non ammesso';
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                    'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => s , 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    return;
                }
                //OF_TT_Utils.Create_Notify(OF_TT_EntryChecks.c,10,'','');
                return;
            }
			//test KO
            if(tt.TIPO_COMUNICAZIONE=='11'){
                if(String.isBlank(tt.NOTE)){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'Campo NOTE non valorizzato', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE });
                    return;
                }
                if(String.isBlank(tt.INTERVENTO_CONGIUNTO)){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'INTERVENTO_CONGIUNTO non valorizzato', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    return;
                }
                if (OF_TT_EntryChecks.c.status!='Richiesta Chiusura'){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'Status non congruente con test KO', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    return;
                }
               OF_TT_EntryChecks.c.EOF_Intervento_COngiunto__c=tt.INTERVENTO_CONGIUNTO;
                
                if(OF_TT_EntryChecks.c.EOF_Data_Max_Risoluzione_Ticket__c > OF_TT_Utils.now()){
                	if(OF_TT_EntryChecks.c.EOF_Rischedulazione_Appuntamento__c!=null &&OF_TT_EntryChecks.c.EOF_Rischedulazione_Appuntamento__c>OF_TT_Utils.now()){
                		OF_TT_EntryChecks.c.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((OF_TT_EntryChecks.c.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-c.EOF_Rischedulazione_Appuntamento__c.getTime()) / 1000);
                	}
                	else{
                		OF_TT_EntryChecks.c.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((OF_TT_EntryChecks.c.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-OF_TT_Utils.now().getTime()) / 1000);
                	}
                	
                }
                else{
                	OF_TT_EntryChecks.c.EOF_Secondi_Sospesi_allo_SLA__c=0;
                }
               
               OF_TT_EntryChecks.c.EOF_Collaudi_Negativi__c=OF_TT_EntryChecks.c.EOF_Collaudi_Negativi__c + 1;
               // 15/02/2018 MM : Taglio il campo note sul case se > 255.
               if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){
               		OF_TT_EntryChecks.c.EOF_Note__c=tt.NOTE.abbreviate(255);
               }
               else{
               		OF_TT_EntryChecks.c.EOF_Note__c = tt.NOTE;
               }
               // finisce qui
               OF_TT_EntryChecks.c.Note_cliente__c=tt.NOTE_CLIENTE;
               OF_TT_EntryChecks.c.EOF_Descrizione_Problema__c=tt.DESCRIZIONE_PROBLEMA;
               OF_TT_EntryChecks.c.EOF_Tec_Olo__c=tt.Tec_olo;
               OF_TT_EntryChecks.c.Eof_tel_tec_olo__c=tt.Tel_tec_olo;
               OF_TT_EntryChecks.c.EOF_Data_ora_intervento_congiunto__c=OF_TT_Utils.stringToDate(tt.DATA_ORA_INTERVENTO_CONGIUNTO);
                if(String.isNotBlank(tt.NOTE)){
                	if(String.isNotBlank(OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C)){
                		OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                	}
                	else{
                		OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                	}
                }
               OF_TT_EntryChecks.c.status='In Lavorazione';
               OF_TT_EntryChecks.c.Eof_fase__c='Da Lavorare';
                Database.DMLOptions dmo = new Database.DMLOptions();
                dmo.assignmentRuleHeader.useDefaultRule = true;
               OF_TT_EntryChecks.c.setOptions(dmo);
                try{
                    update OF_TT_EntryChecks.c;
                    List<EOF_EAI_Service_Log__c> logs =[select Id from EOF_EAI_Service_Log__c where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO 
                                                and RecordType.Name ='TroubleTicketRequest' order by  CreatedDate DESC LIMIT 1];
                    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ la lista dei log è: '+logs);
                    if (!logs.isEmpty()){
                        logs[0].Caso__c=OF_TT_EntryChecks.c.Id;
                        update logs[0];
                    }
                }
                catch(DMLException e){
                    String s = 'Valore campo \'' + e.getDmlFields(0).get(0).getdescribe().getlabel() + ' non ammesso';
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                    'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => s, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt) , 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    return;
                }
                return;

            }
            //test OK
            if(tt.TIPO_COMUNICAZIONE=='12'){
                if (OF_TT_EntryChecks.c.status!='Richiesta Chiusura'){
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                            'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => 'Status non congruente con test KO', 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE });
                    return;
                }
               OF_TT_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                //c.EOF_Minuti_rimanenti_sospesi__c=Integer.valueOf(OF_TT_EntryChecks.c.EOF_Num_min_risoluzione_Ticket__c);
                //c.EOF_Data_Max_Risoluzione_Ticket__c=datetime.now().addMinutes(Integer.valueOf(OF_TT_EntryChecks.c.EOF_Num_min_risoluzione_Ticket__c));
                // 15/02/2018 MM : taglio il campo note sul case se > 255
               if(string.isnotblank(tt.NOTE) && tt.NOTE!=null){ 
               		OF_TT_EntryChecks.c.EOF_Note__c=tt.NOTE.abbreviate(255);
               }
               else {
               		OF_TT_EntryChecks.c.EOF_Note__c = tt.NOTE;
               }
               // finisce qui
               OF_TT_EntryChecks.c.Note_cliente__c=tt.NOTE_CLIENTE;
                if(String.isNotBlank(tt.NOTE)){
                	if(String.isNotBlank(OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C)){
                		OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                	}
                	else{
                		OF_TT_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE)+' - '+userinfo.getName()+':\n'+tt.NOte;
                	}
                }
               OF_TT_EntryChecks.c.status='Chiuso';
               OF_TT_EntryChecks.c.Eof_fase__c='Chiusura';
                
                try{
                    update OF_TT_EntryChecks.c;
                    List<EOF_EAI_Service_Log__c> logs =[select Id from EOF_EAI_Service_Log__c where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO 
                                                and RecordType.Name ='TroubleTicketRequest' order by  CreatedDate DESC LIMIT 1];
                    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ la lista dei log è: '+logs);
                    if (!logs.isEmpty()){
                        logs[0].Caso__c=OF_TT_EntryChecks.c.Id;
                        update logs[0];
                    }
                }
                catch(DMLException e){
                    String s = 'Valore campo \'' + e.getDmlFields(0).get(0).getdescribe().getlabel() + ' non ammesso';
                    insert OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                    'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' =>OF_TT_EntryChecks.c.Id, 'Causale_errore' => s, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt) , 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
                    return;
                }
                return;

            }

              

        }
    }
    
  
}
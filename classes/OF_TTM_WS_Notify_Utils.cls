/**
* Author:       Team Napoli
* Description:  Integrazione SFDC to TTM/Salesforce/OLO
* SI:           
*/ 
public without sharing class OF_TTM_WS_Notify_Utils {
    //DEBUG MODE
    public static Boolean DEBUG_MODE =true; 
    
    public static String CODICE_MOTIVAZIONE_A_K8 = 'A_K8'; //KO di interfaccia
    public static String CODICE_MOTIVAZIONE_A_K9 = 'A_K9'; //KO campo obbligatorio
    public static String CODICE_MOTIVAZIONE_A_K10 = 'A_K10'; //KO valore campo non ammesso
    public static String CODICE_MOTIVAZIONE_A_K11 = 'A_K11';
    
    public static String MOTIVAZIONE_A_K8 = 'Errore Tecnico di Interfaccia';
    public static String MOTIVAZIONE_A_K9 = 'Campo obbligatorio xxxx non valorizzato';
    public static String MOTIVAZIONE_A_K10 = 'Valore campo xxxx non ammesso';
    public static String MOTIVAZIONE_A_K11 = 'Messaggio non ammesso';
    
    public static String TIPO_COMUNICAZIONE_4='4';
    public static String TIPO_COMUNICAZIONE_5='5';
    public static String TIPO_COMUNICAZIONE_7='7';
    public static String TIPO_COMUNICAZIONE_10='10';
    public static String TIPO_COMUNICAZIONE_13='13';
    public static String TIPO_COMUNICAZIONE_3='3';
    
    public static String INTERVENTO_CONGIUNTO_Y='Y';
    public static String INTERVENTO_CONGIUNTO_N='N';
    public static String CAUSALE_SOSPENSIONE_1='1';
    public static String CAUSALE_SOSPENSIONE_2='2';
    public static String CAUSALE_SOSPENSIONE_3='3';
    
    public static String ESITO_1 = '1';
    public static String ESITO_0 = '0';
    
    public static String VUOTA = '';
    //AA 27/06/18
    public static boolean checkRTMap = false;
    public static map<String,Id> RTMap;
    public static EOF_EAI_Service_Log__c sLogTTMSF;
    // MM 28/06/2018
    public static EOF_EAI_Service_log__c sLogTTMSFResp;
    public static EOF_EAI_Service_log__c sLogSFOLO;
	public static EOF_EAI_Service_log__c sLogSFOLOResp;
    public static Case caseTTM;
    public static Case requestedCase;
    
    public static OF_TTM_WS_WRAP_Utility obj= new OF_TTM_WS_WRAP_Utility();
    //AA 27/06/18 - Metodo per creazione sLog
    public static EOF_EAI_Service_Log__c create_EAI_Log(Object o){
        //Istanzio l'oggetto sLog
        EOF_EAI_Service_Log__c sLog;
        //Check se la lista di rtype è popolata, altirmenti la popolo
        if(!OF_TTM_WS_Notify_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_TTM_WS_Notify_Utils.RTMap = new  map<String,String>();

            for(recordtype rt : [select id,developername from recordtype]){
                OF_TTM_WS_Notify_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_TTM_WS_Notify_Utils.checkRTMap=true;
        }
        //Instance of per capire se si tratta di una notify da TTM
        if(o instanceof OF_TTM_WS_IN_Notify.TTM_Notify){
            OF_TTM_WS_IN_Notify.TTM_Notify a = (OF_TTM_WS_IN_Notify.TTM_Notify) o;    
			
            sLog = new EOF_EAI_Service_Log__c(
                //Done AA : Cambiare record type con uno creato ex novo
                RecordTypeId = OF_TTM_WS_Notify_Utils.RTMap.get('TroubleTicketNotify'),
                OF_SA_Direzione_Flusso__c = 'TTM -> SF',
                OF_SA_Metodo__c = getMethodValue(a.TIPO_COMUNICAZIONE),
                EOF_Tipo_Comunicazione__c = a.TIPO_COMUNICAZIONE,
                EOF_Tipo_Comunicazione_String__c = getValueLogTipoCom(a.TIPO_COMUNICAZIONE, 'TTM Notify'),
                EOF_ID_Risorsa__c = a.ID_RISORSA,
                EOF_Codice_Operatore__c = a.CODICE_OPERATORE,
                EOF_Codice_Comunicazione_OLO__c = a.CODICE_COMUNICAZIONE_OLO,
                EOF_ID_Notifica__c = a.ID_NOTIFICA,
                TTM_TICKETID__c = a.ID_TT,
                DATA_ORA_CREAZIONE_TTM__c = stringToDateTime(a.DATA_ORA_CREAZIONE_TT),
                EOF_Data_Ora_Notifica_Sospensione__c = stringToDateTime(a.DATA_ORA_NOTIFICA_SOSPENSIONE),
                EOF_Data_Ora_Notifica_Desospensione__c = stringToDateTime(a.DATA_ORA_NOTIFICA_DESOSPENSIONE),
                EOF_Data_Ora_Notifica_Annullamento__c = stringToDateTime(a.DATA_ORA_NOTIFICA_ANNULLAMENTO),
                EOF_Data_Ora_Notifica_Chiusura__c = stringToDateTime(a.DATA_ORA_NOTIFICA_CHIUSURA),
                Causale_Sospensione__c = a.CAUSALE_SOSPENSIONE,
                EOF_Referente_desospensione__c = a.REFERENTE_DESOSPENSIONE,
                Descrizione_Evento_Risoluzione__c = a.DESCRIZIONE_INTERVENTO_RISOLUZIONE,
                EOF_Rischedulazione_Appuntamento__c = stringToDateTime(a.RISCHEDULAZIONE_APPUNTAMENTO),
                EOF_Intervento_Congiunto__c = a.INTERVENTO_CONGIUNTO,
                EOF_Tec_OLO__c = a.TEC_OLO,
                EOF_Tel_Tec_OLO__c = a.TEL_TEC_OLO,
                EOF_Data_Ora_Intervento_Congiunto__c = stringToDateTime(a.DATA_ORA_INTERVENTO_CONGIUNTO),
                EOF_Richiesta_Notifica__c = copy_request(a)
            );
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(string.isnotblank(a.NOTE) && a.NOTE!=null){
                sLog.EOF_Note__c= a.NOTE.abbreviate(255);
            }
            else{
                sLog.EOF_Note__c = a.NOTE;
            }
            //AA 14/06/18 : Modifica per recupero case originale Trouble_Ticket
            List<Case> cList = [SELECT Id,EOF_Id_Notifica__c,status, EOF_Codice_Operatore_WS__c, EOF_GPON_Attestazione__c, 
                                EOF_Id_Risorsa__c, EOF_Data_Notifica__c, EOF_Data_Prevista_Attivazione__c, EOF_Nuova_DAC__c,
                                RecordType.DeveloperName,OF_Bonifica_Locked_Row__c,EOF_Pertinenza_RDAC__c, canModify__c, EOF_Codice_Ordine_OM__c,
                                EOF_Order_Manager__c, OF_TroubleTicketManager__c, OF_Response_da_TTM__c
                                FROM Case 
                                Where EOF_Codice_Comunicazione_OLO__c =: a.CODICE_COMUNICAZIONE_OLO 
                                and RecordType.DeveloperName = 'Trouble_Ticket'];
            
            if(!cList.isEmpty()){ 
                requestedCase = cList[0];
                sLog.Caso__c=cList[0].Id;
                sLog.EOF_COdice_ordine_EOF__C=cList[0].Id;
            } 
        }
         
        if(o instanceof Map<String, String>){
            
            if(((Map<String, String>) o).get('Type') == 'TT_ACK'){
                RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'TT - ACK' LIMIT 1];
                sLog = new EOF_EAI_Service_Log__c(
                    RecordTypeId = rt.id,
                    Caso__c=((Map<String, String>) o).get('CaseId'),
                    EOF_Stato_Richiesta__c = 'OK',
                    EOF_Codice_Comunicazione_OLO__c = ((Map<String, String>) o).get('Codice_comunicazione_OLO'),
                    EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
                    EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                    EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('TT_Request'),                 
                    EOF_Data_Notifica__c = OF_TTM_Utils.now(),
                    EOF_Tipo_Comunicazione__c=((Map<String, String>) o).get('Tipo Comunicazione'),
                    EOF_Tipo_Comunicazione_String__c = ((Map<String, String>) o).get('Tipo Comunicazione String'),
                    //aggiungo sl di riferimento
                    EOF_SL_Riferimento__c= ((Map<String, String>) o).get('SL Riferimento')
                );
                
            }
            if(((Map<String, String>) o).get('Type') == 'TT_NACK'){
                RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'TT - NACK' LIMIT 1];
                sLog = new EOF_EAI_Service_Log__c(
                    RecordTypeId = rt.id,
                    Caso__c=((Map<String, String>) o).get('CaseId'),
                    EOF_Stato_Richiesta__c = 'KO',
                    EOF_Codice_Errore__c = ((Map<String, String>) o).get('Codice_errore'),
                    EOF_Causale_Errore__c = ((Map<String, String>) o).get('Causale_errore'),
                    EOF_Codice_Comunicazione_OLO__c = ((Map<String, String>) o).get('Codice_comunicazione_OLO'),
                    EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
                    EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                    EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('TT_Request'),                 
                    EOF_Data_Notifica__c = OF_TTM_Utils.now(),
                    EOF_Tipo_Comunicazione__c=((Map<String, String>) o).get('Tipo Comunicazione'),
                    EOF_Tipo_Comunicazione_String__c = ((Map<String, String>) o).get('Tipo Comunicazione String'),
                    //aggiungo sl di riferimento
                    EOF_SL_Riferimento__c= ((Map<String, String>) o).get('SL Riferimento')    
                );
                
            }
            if(((Map<String, String>) o).get('Type') == 'Trouble Ticket - Richiesta Scartata'){
                RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Trouble Ticket - Richiesta Scartata' LIMIT 1];
                //lego il log di request al case
                List<EOF_EAI_Service_Log__c> logs =[select Id from EOF_EAI_Service_Log__c where EOF_Codice_Comunicazione_OLO__c=:((Map<String, String>) o).get('Codice_comunicazione_OLO') 
                                                    and RecordType.Name ='TroubleTicketRequest' order by  CreatedDate DESC LIMIT 1];
                if (!logs.isEmpty()){
                    logs[0].Caso__c=((Map<String, String>) o).get('CaseId');
                    update logs[0];
                }
                sLog = new EOF_EAI_Service_Log__c(
                    RecordTypeId = rt.id,
                    Caso__c=((Map<String, String>) o).get('CaseId'),
                    EOF_Stato_Richiesta__c = 'KO',
                    EOF_Codice_Errore__c = ((Map<String, String>) o).get('Codice_errore'),
                    EOF_Causale_Errore__c = ((Map<String, String>) o).get('Causale_errore'),
                    EOF_Codice_Comunicazione_OLO__c = ((Map<String, String>) o).get('Codice_comunicazione_OLO'),
                    EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
                    EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                    EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('TT_Request'),                
                    EOF_Data_Notifica__c = OF_TTM_Utils.now(),
                    EOF_Tipo_Comunicazione__c='TT - SCARTO - '+OF_TTM_Utils.getStringTipoComunicazione(((Map<String, String>) o).get('Tipo Comunicazione'))    
                );
                
            }
        }
            
        //Restituisco il sLog
        return sLog;
    }
    //AA 27/06/18 Metodo per creare una stringa dato l'oggetto della chiamata
    public static String copy_request(object o){
        String s;
        if(o instanceof OF_TTM_WS_IN_Notify.TTM_Notify){
            OF_TTM_WS_IN_Notify.TTM_Notify a = (OF_TTM_WS_IN_Notify.TTM_Notify) o;   
            s = 'TIPO_COMUNICAZIONE: '+ a.TIPO_COMUNICAZIONE + '\n' +
                'ID_RISORSA: '+ a.ID_RISORSA + '\n' +
                'CODICE_OPERATORE: '+ a.CODICE_OPERATORE + '\n' +
                'CODICE_COMUNICAZIONE_OLO: '+ a.CODICE_COMUNICAZIONE_OLO + '\n' +
                'ID_NOTIFICA: '+ a.ID_NOTIFICA + '\n' +
                'ID_TT: '+ a.ID_TT + '\n' +
                'DATA_ORA_CREAZIONE_TT: '+ a.DATA_ORA_CREAZIONE_TT + '\n' +
                'DATA_ORA_NOTIFICA_SOSPENSIONE: '+ a.DATA_ORA_NOTIFICA_SOSPENSIONE + '\n' +
                'DATA_ORA_NOTIFICA_DESOSPENSIONE: '+ a.DATA_ORA_NOTIFICA_DESOSPENSIONE + '\n' +
                'DATA_ORA_NOTIFICA_ANNULLAMENTO: '+ a.DATA_ORA_NOTIFICA_ANNULLAMENTO + '\n' +
                'DATA_ORA_NOTIFICA_CHIUSURA: '+ a.DATA_ORA_NOTIFICA_CHIUSURA + '\n' +
                'CAUSALE_SOSPENSIONE: '+ a.CAUSALE_SOSPENSIONE + '\n' +
                'REFERENTE_DESOSPENSIONE: '+ a.REFERENTE_DESOSPENSIONE + '\n' +
                'DESCRIZIONE_INTERVENTO_RISOLUZIONE: '+ a.DESCRIZIONE_INTERVENTO_RISOLUZIONE + '\n' +
                'RISCHEDULAZIONE_APPUNTAMENTO: '+ a.RISCHEDULAZIONE_APPUNTAMENTO + '\n' +
                'INTERVENTO_CONGIUNTO: '+ a.INTERVENTO_CONGIUNTO + '\n' +
                'TEC_OLO: '+ a.TEC_OLO + '\n' +
                'TEL_TEC_OLO: '+ a.TEL_TEC_OLO + '\n' +
                'DATA_ORA_INTERVENTO_CONGIUNTO: '+ a.DATA_ORA_INTERVENTO_CONGIUNTO + '\n' +
                'NOTE: '+ a.NOTE + '\n';
        }
        return s;
    }
    //AA 16/07/2018 Metodo per restituire NACK per stato case non valido
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse syncErrorCaseStatus(OF_TTM_WS_IN_Notify.TTM_Notify o){
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse tmp = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        tmp.ID_NOTIFICA = o.ID_NOTIFICA;
        tmp.ESITO = ESITO_1;   
        tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K11; 
        tmp.MOTIVAZIONE = MOTIVAZIONE_A_K11;
        
        /*if(DEBUG_MODE){
            tmp.MOTIVAZIONE=tmp.MOTIVAZIONE+' Class::OF_TTM_WS_Notify_Utils Method:: syncErrorStatus';
        }*/
        return tmp;
    }
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse responseACK(OF_TTM_WS_IN_Notify.TTM_Notify o){
        
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse tmp = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        tmp.ID_NOTIFICA = o.ID_NOTIFICA;
        tmp.ESITO = ESITO_0;   
        //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
        return tmp; 
    }
    //AA: Giro la response di OLO a TTM
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse responseToTTMByOLOResp(OF_TTM_WS_IN_Notify.TTM_Notify o){
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse tmp = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        if(OF_TTM_Utils.responseDaOLO == 'ACK'){
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_0;  
        }else{//Caso di NACK
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = OF_TTM_Utils.sLogSFOLOResp.EOF_Codice_errore__c; 
            tmp.MOTIVAZIONE = OF_TTM_Utils.sLogSFOLOResp.EOF_Causale_Errore__c;
        }
        return tmp; 
    }
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse responseException(OF_TTM_WS_IN_Notify.TTM_Notify o,Exception e){
        
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse tmp = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        tmp.ID_NOTIFICA = o.ID_NOTIFICA;
        tmp.ESITO = ESITO_1;   
        tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K8; 
        tmp.MOTIVAZIONE = MOTIVAZIONE_A_K8;
        //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
        
        if(DEBUG_MODE){
            tmp.MOTIVAZIONE=tmp.MOTIVAZIONE+' Class::OT_TTM_WS_Notify_Utils Method:: responseException'+e.getMessage();
            System.debug('Exception line number ' + e.getLineNumber());
            System.debug('Exception StackTrace ' + e.getStackTraceString());
        }
        
        return tmp;
    }
    
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse syncErrorCodiceComunicazioneOLO(OF_TTM_WS_IN_Notify.TTM_Notify o){
        
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse tmp = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        tmp.ID_NOTIFICA = o.ID_NOTIFICA;
        tmp.ESITO = ESITO_1;   
        tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
        tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'CODICE_COMUNICAZIONE_OLO');
        //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
        
        if(DEBUG_MODE){
            tmp.MOTIVAZIONE=tmp.MOTIVAZIONE+' Class::OF_TTM_WS_Notify_Utils Method:: syncErrorCodiceOrdine';
        }
        return tmp;
    }
    
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse syncErrorCodiceComunicazioneOLO_TICKETID_TTM(OF_TTM_WS_IN_Notify.TTM_Notify o){
        
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse tmp = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        tmp.ID_NOTIFICA = o.ID_NOTIFICA;
        tmp.ESITO = ESITO_1;   
        tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
        tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'ID_TT/CODICE_COMUNICAZIONE_OLO');
        //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
        
        if(DEBUG_MODE){
            tmp.MOTIVAZIONE=tmp.MOTIVAZIONE+' Class::OF_TTM_WS_Notify_Utils Method:: syncErrorCodiceComunicazioneOLO_TICKETID_TTM';
        }
        return tmp;
    }
    
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse syncErrorStatus(OF_TTM_WS_IN_Notify.TTM_Notify o){
        
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse tmp = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        tmp.ID_NOTIFICA = o.ID_NOTIFICA;
        tmp.ESITO = ESITO_1;   
        tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K8; 
        tmp.MOTIVAZIONE = MOTIVAZIONE_A_K8;
        //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
        
        if(DEBUG_MODE){
            tmp.MOTIVAZIONE=tmp.MOTIVAZIONE+' Class::OF_TTM_WS_Notify_Utils Method:: syncErrorStatus';
        }
        return tmp;
    }
    
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse CheckTipoCom(OF_TTM_WS_IN_Notify.TTM_Notify o){
        
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse tmp = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        tmp.ID_NOTIFICA = o.ID_NOTIFICA;
        tmp.ESITO = ESITO_1;   
        tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
        tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'TIPO COMUNICAZIONE');
        //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
        
        if(DEBUG_MODE){
            tmp.MOTIVAZIONE=tmp.MOTIVAZIONE+' Class::OF_TTM_WS_Notify_Utils Method:: syncErrorStatus';
        }
        return tmp;        
    }
    
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse syncError(OF_TTM_WS_IN_Notify.TTM_Notify o){
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse tmp = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        
        //Controllo i campi required.
        if(String.isBlank(o.ID_RISORSA)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'ID_RISORSA');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(String.isBlank(o.CODICE_OPERATORE)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'CODICE_OPERATORE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(String.isBlank(o.ID_NOTIFICA)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'ID_NOTIFICA');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(String.isBlank(o.TIPO_COMUNICAZIONE)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'TIPO_COMUNICAZIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(String.isBlank(o.CODICE_COMUNICAZIONE_OLO)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'CODICE_COMUNICAZIONE_OLO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_3.equals(o.TIPO_COMUNICAZIONE) && String.isBlank(o.DATA_ORA_CREAZIONE_TT)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'DATA_ORA_CREAZIONE_TT');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_3.equals(o.TIPO_COMUNICAZIONE) && String.isBlank(o.ID_TT)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'ID_TT');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4.equals(o.TIPO_COMUNICAZIONE) && String.isBlank(o.DATA_ORA_NOTIFICA_SOSPENSIONE)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'DATA_ORA_NOTIFICA_SOSPENSIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7.equals(o.TIPO_COMUNICAZIONE) && String.isBlank(o.DATA_ORA_NOTIFICA_DESOSPENSIONE)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'DATA_ORA_NOTIFICA_DESOSPENSIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        } 
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_10.equals(o.TIPO_COMUNICAZIONE) && String.isBlank(o.DATA_ORA_NOTIFICA_ANNULLAMENTO)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'DATA_ORA_NOTIFICA_ANNULLAMENTO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        } 
        if((OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_5.equals(o.TIPO_COMUNICAZIONE) || OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13.equals(o.TIPO_COMUNICAZIONE)) && String.isBlank(o.DATA_ORA_NOTIFICA_CHIUSURA)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'DATA_ORA_NOTIFICA_CHIUSURA');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if((OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4.equals(o.TIPO_COMUNICAZIONE) || OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7.equals(o.TIPO_COMUNICAZIONE)) && String.isBlank(o.CAUSALE_SOSPENSIONE)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'CAUSALE_SOSPENSIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7.equals(o.TIPO_COMUNICAZIONE) && String.isBlank(o.REFERENTE_DESOSPENSIONE)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'REFERENTE_DESOSPENSIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if((OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_5.equals(o.TIPO_COMUNICAZIONE) || OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13.equals(o.TIPO_COMUNICAZIONE))&& String.isBlank(o.DESCRIZIONE_INTERVENTO_RISOLUZIONE)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'DESCRIZIONE_INTERVENTO_RISOLUZIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(OF_TTM_WS_Notify_Utils.INTERVENTO_CONGIUNTO_Y.equals(o.INTERVENTO_CONGIUNTO) && String.isBlank(o.TEC_OLO)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'TEC_OLO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(OF_TTM_WS_Notify_Utils.INTERVENTO_CONGIUNTO_Y.equals(o.INTERVENTO_CONGIUNTO) && String.isBlank(o.TEL_TEC_OLO)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'TEL_TEC_OLO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4.equals(o.TIPO_COMUNICAZIONE) && String.isBlank(o.INTERVENTO_CONGIUNTO)) {
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K9; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K9.replace('xxxx', 'INTERVENTO_CONGIUNTO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        
        
        
        //Controllo la Lunghezza Massima
        if(!String.isBlank(o.ID_NOTIFICA) && o.ID_NOTIFICA.length()>50) { //lunghezza deve essere massima 50
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'ID_NOTIFICA');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isBlank(o.ID_TT) && o.ID_TT.length()>50) { //lunghezza deve essere massima 50
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'ID_TT');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isBlank(o.CODICE_OPERATORE) && o.CODICE_OPERATORE.length()>3) {   //lunghezza max 3
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'CODICE_OPERATORE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }         
        if(!String.isBlank(o.ID_RISORSA) && o.ID_RISORSA.length()>50) {   //lunghezza max 50
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'ID_RISORSA');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(o.TIPO_COMUNICAZIONE.length()>2) { //lunghezza deve essere 2
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'TIPO_COMUNICAZIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());                    
            return tmp;
        }
        if(o.CODICE_COMUNICAZIONE_OLO.length()>50) { //lunghezza deve essere massima 50
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'CODICE_COMUNICAZIONE_OLO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_NOTIFICA_SOSPENSIONE) && o.DATA_ORA_NOTIFICA_SOSPENSIONE.length()!=25) { //lunghezza deve essere 25
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_NOTIFICA_SOSPENSIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_CREAZIONE_TT) && o.DATA_ORA_CREAZIONE_TT.length()!=25) { //lunghezza deve essere 25
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_CREAZIONE_TT');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_NOTIFICA_DESOSPENSIONE) && o.DATA_ORA_NOTIFICA_DESOSPENSIONE.length()!=25) { //lunghezza deve essere 25
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_NOTIFICA_DESOSPENSIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_NOTIFICA_ANNULLAMENTO) && o.DATA_ORA_NOTIFICA_ANNULLAMENTO.length()!=25) { //lunghezza deve essere 25
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_NOTIFICA_ANNULLAMENTO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_NOTIFICA_CHIUSURA) && o.DATA_ORA_NOTIFICA_CHIUSURA.length()!=25) { //lunghezza deve essere 25
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_NOTIFICA_CHIUSURA');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.CAUSALE_SOSPENSIONE) && o.CAUSALE_SOSPENSIONE.length()>2) { //lunghezza deve essere max 2
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'CAUSALE_SOSPENSIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.REFERENTE_DESOSPENSIONE) && o.REFERENTE_DESOSPENSIONE.length()>255) { //lunghezza deve essere max 2
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'REFERENTE_DESOSPENSIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.DESCRIZIONE_INTERVENTO_RISOLUZIONE) && o.DESCRIZIONE_INTERVENTO_RISOLUZIONE.length()>2) { //lunghezza deve essere max 2
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DESCRIZIONE_INTERVENTO_RISOLUZIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.NOTE) && o.NOTE.length()>4000) { //lunghezza deve essere max 4000
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'NOTE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.RISCHEDULAZIONE_APPUNTAMENTO) && o.RISCHEDULAZIONE_APPUNTAMENTO.length()!=25) { //lunghezza deve essere 25
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'RISCHEDULAZIONE_APPUNTAMENTO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.INTERVENTO_CONGIUNTO) && o.INTERVENTO_CONGIUNTO.length()>2) { //lunghezza deve essere max 2
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'INTERVENTO_CONGIUNTO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        
        if(!String.isblank(o.TEC_OLO) && o.TEC_OLO.length()>128) { //lunghezza deve essere max 128
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'TEC_OLO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.TEL_TEC_OLO) && o.TEL_TEC_OLO.length()>16) { //lunghezza deve essere max 16
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'TEL_TEC_OLO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_INTERVENTO_CONGIUNTO) && o.DATA_ORA_INTERVENTO_CONGIUNTO.length()!=25) { //lunghezza deve essere 25
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_INTERVENTO_CONGIUNTO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());        
            return tmp;
        }
        
        
        //Controlli di dominio e di formato
        if(!String.isblank(o.TIPO_COMUNICAZIONE ) && !TIPO_COMUNICAZIONE_4.equals(o.TIPO_COMUNICAZIONE) && !TIPO_COMUNICAZIONE_7.equals(o.TIPO_COMUNICAZIONE) && !TIPO_COMUNICAZIONE_10.equals(o.TIPO_COMUNICAZIONE) && !TIPO_COMUNICAZIONE_5.equals(o.TIPO_COMUNICAZIONE) && !TIPO_COMUNICAZIONE_13.equals(o.TIPO_COMUNICAZIONE) && !TIPO_COMUNICAZIONE_3.equals(o.TIPO_COMUNICAZIONE)) {//Valori ammissibili 4,7,10,13,5,3
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10;  
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'TIPO_COMUNICAZIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        
        /*if(!String.isblank(o.CODICE_COMUNICAZIONE_OLO) && (o.CODICE_COMUNICAZIONE_OLO.split('_ASS_TT_', 2)).size()!=2){
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10;  
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'CODICE_COMUNICAZIONE_OLO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }*/
        if(!String.isblank(o.DATA_ORA_NOTIFICA_SOSPENSIONE) && !verificaDateTime(o.DATA_ORA_NOTIFICA_SOSPENSIONE)) {//formato atteso: YYYY-MM-DDThh:mm:ssTZD)
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_NOTIFICA_SOSPENSIONE'); 
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_NOTIFICA_DESOSPENSIONE) && !verificaDateTime(o.DATA_ORA_NOTIFICA_DESOSPENSIONE)) {//formato atteso: YYYY-MM-DDThh:mm:ssTZD)
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_NOTIFICA_DESOSPENSIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now()); 
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_CREAZIONE_TT) && !verificaDateTime(o.DATA_ORA_CREAZIONE_TT)) {//formato atteso: YYYY-MM-DDThh:mm:ssTZD)
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_CREAZIONE_TT');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now()); 
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_NOTIFICA_ANNULLAMENTO) && !verificaDateTime(o.DATA_ORA_NOTIFICA_ANNULLAMENTO)) {//formato atteso: YYYY-MM-DDThh:mm:ssTZD)
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_NOTIFICA_ANNULLAMENTO'); 
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_NOTIFICA_CHIUSURA) && !verificaDateTime(o.DATA_ORA_NOTIFICA_CHIUSURA)) {//formato atteso: YYYY-MM-DDThh:mm:ssTZD)
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_NOTIFICA_CHIUSURA'); 
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(!String.isblank(o.CAUSALE_SOSPENSIONE ) && !CAUSALE_SOSPENSIONE_1.equals(o.CAUSALE_SOSPENSIONE) && !CAUSALE_SOSPENSIONE_2.equals(o.CAUSALE_SOSPENSIONE) && !CAUSALE_SOSPENSIONE_3.equals(o.CAUSALE_SOSPENSIONE)) {//Valori ammissibili 1,2,3
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10;  
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'CAUSALE_SOSPENSIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(!String.isblank(o.DESCRIZIONE_INTERVENTO_RISOLUZIONE) && (!o.DESCRIZIONE_INTERVENTO_RISOLUZIONE.isNumeric() || Integer.valueof(o.DESCRIZIONE_INTERVENTO_RISOLUZIONE)>20 || 	Integer.valueof(o.DESCRIZIONE_INTERVENTO_RISOLUZIONE)<1)) {//Valori ammissibili 1 A 20
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10;  
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DESCRIZIONE_INTERVENTO_RISOLUZIONE');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(!String.isblank(o.RISCHEDULAZIONE_APPUNTAMENTO) && !verificaDateTime(o.RISCHEDULAZIONE_APPUNTAMENTO)) {//formato atteso: YYYY-MM-DDThh:mm:ssTZD)
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'RISCHEDULAZIONE_APPUNTAMENTO'); 
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(!String.isblank(o.INTERVENTO_CONGIUNTO ) && !INTERVENTO_CONGIUNTO_Y.equals(o.INTERVENTO_CONGIUNTO) && !INTERVENTO_CONGIUNTO_N.equals(o.INTERVENTO_CONGIUNTO)) {//Valori ammissibili Y,N
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10;  
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'INTERVENTO_CONGIUNTO');
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if(!String.isblank(o.DATA_ORA_INTERVENTO_CONGIUNTO) && !verificaDateTime(o.DATA_ORA_INTERVENTO_CONGIUNTO)) {//formato atteso: YYYY-MM-DDThh:mm:ssTZD)
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K10; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K10.replace('xxxx', 'DATA_ORA_INTERVENTO_CONGIUNTO'); 
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        if (requestedCase != null && requestedCase.OF_Response_da_TTM__c != 'ACK'){
            tmp.ID_NOTIFICA = o.ID_NOTIFICA;
            tmp.ESITO = ESITO_1;   
            tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A_K11; 
            tmp.MOTIVAZIONE = MOTIVAZIONE_A_K11;
            //tmp.DATA_NOTIFICA=String.valueofGmt(DateTime.now());
            return tmp;
        }
        //Controlli logici
        
        return null;
    }    
    
    public static void writeLog(OF_TTM_WS_IN_Notify.TTM_Notify request,String statoRichiesta,String CodiceErrore,String CausaleErrore){    
        EOF_EAI_Service_Log__c sol= new EOF_EAI_Service_Log__c();    
        
        if('ACK'.equals(statoRichiesta)){
            List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
            List<Case> listCase = [SELECT Id
                                   FROM Case 
                                   WHERE EOF_Codice_Comunicazione_OLO__c =:request.CODICE_COMUNICAZIONE_OLO
                                   AND RecordTypeId=:rt.get(0).id];
            if(!listCase.isEmpty()){
                sol.Caso__c=listCase.get(0).Id;
            }	            
        }
        
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('DATA_ORA_NOTIFICA_SOSPENSIONE'))){
            sol.EOF_Data_Ora_Notifica_Sospensione__c = stringToDateTime(request.DATA_ORA_NOTIFICA_SOSPENSIONE);
        }
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('DATA_ORA_NOTIFICA_DESOSPENSIONE'))){
            sol.EOF_Data_Ora_Notifica_Desospensione__c = stringToDateTime(request.DATA_ORA_NOTIFICA_DESOSPENSIONE);
        }
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('DATA_ORA_NOTIFICA_ANNULLAMENTO'))){
            sol.EOF_Data_Ora_Notifica_Annullamento__c = stringToDateTime(request.DATA_ORA_NOTIFICA_ANNULLAMENTO);
        }
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('DATA_ORA_NOTIFICA_CHIUSURA'))){
            sol.EOF_Data_Ora_Notifica_Chiusura__c = stringToDateTime(request.DATA_ORA_NOTIFICA_CHIUSURA);
        }
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('DATA_ORA_INTERVENTO_CONGIUNTO'))){
            sol.EOF_Data_Ora_Intervento_Congiunto__c = stringToDateTime(request.DATA_ORA_INTERVENTO_CONGIUNTO);
        }               
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('RISCHEDULAZIONE_APPUNTAMENTO'))){
            sol.EOF_Rischedulazione_Appuntamento__c = stringToDateTime(request.RISCHEDULAZIONE_APPUNTAMENTO);
        } 
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('DATA_ORA_CREAZIONE_TT'))){
            sol.DATA_ORA_CREAZIONE_TTM__c=stringToDateTime(request.DATA_ORA_CREAZIONE_TT);
        }
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('REFERENTE_DESOSPENSIONE'))){
            sol.EOF_Referente_desospensione__c=request.REFERENTE_DESOSPENSIONE; 
        } 
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('INTERVENTO_CONGIUNTO'))){
            sol.EOF_Intervento_Congiunto__c=request.INTERVENTO_CONGIUNTO;
        }
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('ID_TT'))){
            sol.TTM_TICKETID__c=request.ID_TT;
        }
        if(!('NACK'.equals(statoRichiesta) && !String.isblank(CausaleErrore) && CausaleErrore.contains('ID_RISORSA'))){
            sol.EOF_ID_Risorsa__c=request.ID_RISORSA;
        }
        sol.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('TT - NACK').getRecordTypeId();
        sol.EOF_Stato_Richiesta__c = statoRichiesta;
        sol.EOF_ID_Notifica__c = request.ID_NOTIFICA;  
        String s = 'ID_NOTIFICA: ' + request.ID_NOTIFICA;
                s += '\nESITO: 1';
                s += '\nCODICE_MOTIVAZIONE: ' + CodiceErrore;
                s += '\nMOTIVAZIONE: ' + CausaleErrore;
        sol.EOF_Richiesta_Notifica__c = s;
        sol.EOF_Codice_Errore__c = CodiceErrore;
        sol.EOF_Causale_Errore__c = CausaleErrore;
        sol.EOF_Codice_Comunicazione_OLO__c = request.CODICE_COMUNICAZIONE_OLO;
        sol.EOF_Tipo_Comunicazione__c = request.TIPO_COMUNICAZIONE;
        sol.EOF_Tipo_Comunicazione_String__c = getValueLogTipoCom(request.TIPO_COMUNICAZIONE, statoRichiesta);
        sol.EOF_Codice_Operatore__c = request.CODICE_OPERATORE;
        sol.Causale_Sospensione__c = obj.getValueByKey_CausaleSosp(request.CAUSALE_SOSPENSIONE);
        sol.Descrizione_Evento_Risoluzione__c = obj.getValueByKey_DescrEvRis(String.valueOf(request.DESCRIZIONE_INTERVENTO_RISOLUZIONE));
        sol.EOF_Tec_Eof__c = request.TEC_OLO;
        sol.EOF_Tel_Tec_Eof__c = request.TEL_TEC_OLO;
        sol.EOF_SL_Riferimento__c = OF_TTM_WS_Notify_Utils.sLogTTMSF.Id;
        sol.Caso__c = OF_TTM_WS_Notify_Utils.sLogTTMSF.Caso__c;
        
        sol.TTM_NOTE__c=request.NOTE;
        
        insert sol;    
    }
    
    public static EOF_Notify__c writeNotify(OF_TTM_WS_IN_Notify.TTM_Notify act, Case c, String NameRT, String statoTKT){
        RecordType rt = [SELECT Id, Name FROM RecordType WHERE Name =: NameRT limit 1];
        EOF_Notify__c notify = new EOF_Notify__c(
            OF_TT_Tipo_Comunicazione__c=obj.getValueByKey_TipoComunicazione(String.valueOf(act.TIPO_COMUNICAZIONE)),
            EOF_Codice_Operatore__c=act.CODICE_OPERATORE,
            RecordTypeId = rt.id,
            Caso__c = c.id, 
            EOF_Note__c=act.NOTE,
            Descrizione_Evento_Risoluzione__c=obj.getValueByKey_DescrEvRis(String.valueOf(act.DESCRIZIONE_INTERVENTO_RISOLUZIONE)),            
            EOF_Codice_comunicazione_olo__c = act.CODICE_COMUNICAZIONE_OLO,   
            EOF_Id_Risorsa__c = act.ID_RISORSA,                            
            Stato_ticket__c = statoTKT,                          
            EOF_Data_Ora_Notifica_Chiusura__c = stringToDateTime(act.DATA_ORA_NOTIFICA_CHIUSURA),
            EOF_Data_Ora_Notifica_Sospensione__c = stringToDateTime(act.DATA_ORA_NOTIFICA_SOSPENSIONE),
            EOF_Data_Ora_Notifica_Desospensione__c = stringToDateTime(act.DATA_ORA_NOTIFICA_DESOSPENSIONE),
            EOF_referente_desospensione__c = act.REFERENTE_DESOSPENSIONE,
            EOF_Rischedulazione_Appuntamento__c = stringToDateTime(act.RISCHEDULAZIONE_APPUNTAMENTO),
            EOF_Data_Ora_Notifica_Annullamento__c = stringToDateTime(act.DATA_ORA_NOTIFICA_ANNULLAMENTO),
            Causale_Sospensione__c= obj.getValueByKey_CausaleSosp(String.valueOf(act.CAUSALE_SOSPENSIONE)),
            EOF_Data_Ora_Intervento_congiunto__c = stringToDateTime(act.DATA_ORA_INTERVENTO_CONGIUNTO),
            EOF_Intervento_Congiunto__c = act.INTERVENTO_CONGIUNTO,
            EOF_tec_eof__c = act.TEC_OLO,
            EOF_Tel_Tec_EOF__c = act.TEL_TEC_OLO,
            EOF_Inviata__c = true
        );           
        insert notify;
        
        EOF_Notify__c complete_notify = [Select id, Tipo_Comunicazione__c, OF_TT_Tipo_Comunicazione__c, EOF_Codice_Operatore__c,
                                         RecordTypeId, Caso__c, EOF_Note__c, Descrizione_Evento_Risoluzione__c,
                                         EOF_Codice_comunicazione_olo__c, EOF_Id_Risorsa__c, Stato_ticket__c,
                                         EOF_Data_Ora_Notifica_Chiusura__c, EOF_Data_Ora_Notifica_Sospensione__c,
                                         EOF_Data_Ora_Notifica_Desospensione__c, EOF_referente_desospensione__c,
                                         EOF_Rischedulazione_Appuntamento__c, EOF_Data_Ora_Notifica_Annullamento__c,
                                         Causale_Sospensione__c, EOF_Data_Ora_Intervento_congiunto__c, EOF_Intervento_Congiunto__c,
                                         EOF_tec_eof__c, EOF_Tel_Tec_EOF__c, EOF_Inviata__c
                                         from EOF_Notify__c 
                                         Where id=:notify.Id];
        
        return complete_notify; 
    }
    
    //AA public static void createAckNackByNotify(Id idSlog, Case c){
    public static void createAckNackByNotify(EOF_EAI_Service_Log__c slog, Case c){  
        //check se il case è da portale
        if(c.PO_TT_Portale__c){
            //AA OF_TTM_Utils.updateSlPortale(EOF_EAI_Service_Log__c SlogReq));
            System.debug('***** CREATE ACK NACK BY NOTIFY INSIDE IS PORTAL!');
            OF_TTM_EntryChecks.c = c;
            System.debug('******* CREATE ACK NACK BY NOTIFY CASE = ' +  c);
            OF_TTM_Utils.updateSlPortale(slog, c);
        }//else{
            //AA Recupero il slog
            /*AA eof_eai_service_log__c log =[SELECT Id, Caso__c, RecordTypeId,RecordType.developername,EOF_Codice_Comunicazione_OLO__c,EOF_Codice_Operatore__c,
                                EOF_Tipo_Comunicazione__c, EOF_Data_Notifica__c, EOF_ID_Notifica__c, EOF_Richiesta_Notifica__c, EOF_ID_Risorsa__c, EOF_Data_Ora_Inizio_Guasto__c, EOF_Data_Ora_Richiesta_Annullamento__c, 
                                EOF_Data_Ora_Desospensione__c, EOF_Data_Ora_Autoripristinato__c, EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c, EOF_Causale_Desospensione__c, EOF_Nome_Cliente__c, EOF_COgnome_CLiente__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                EOF_RECAPITO_TELEFONICO_CLIENTE_2__c, EOF_NOME_REFERENTE_TECNICO_OLO__c, EOF_TELEFONO_REFERENTE_TECNICO_OLO__c, EOF_EMAIL_REFERENTE_TECNICO_OLO__c, EOF_Referente_desospensione__c, EOF_Verifica_apparato_cliente__c,
                                EOF_Descrizione_Problema__c, EOF_NOTE_CLIENTE__c, EOF_Causale_Apertura__c, EOF_Intervento_Congiunto__c, EOF_Tec_OLO__c, EOF_Tel_Tec_OLO__c, EOF_ID_SERVIZIO__c, EOF_Data_Ora_Intervento_Congiunto__c,
                                EOF_Note__c, createddate, 
                                //AA Campi aggiunti per callout ad OLO
                                EOF_Stato_Ticket__c, EOF_Data_Ora_Scarto__c, EOF_Data_Ora_Creazione__c, Causale_Scarto__c, EOF_Descrizione_Causale_Scarto__c,
                                EOF_Data_Ora_Notifica_Sospensione__c, EOF_Data_Ora_Notifica_Desospensione__c, EOF_Data_Ora_Notifica_Annullamento__c,
                                EOF_Data_Ora_Notifica_Chiusura__c, Causale_Sospensione__c, Descrizione_Evento_Risoluzione__c,
                                EOF_Rischedulazione_Appuntamento__c, EOF_Tec_Eof__c, EOF_Tel_Tec_Eof__c
                                FROM eof_eai_service_log__c 
                                WHERE id=:idSlog];*/
            OF_TTM_Utils.createNotifyCalloutToOLO(slog, slog.EOF_Tipo_Comunicazione__c);
        //}  
    }
    
    public static Datetime stringToDateTime(String s){
        if(String.isBlank(s)){
            return null;
        }
        Datetime dt = Datetime.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)),integer.valueOf(s.left(13).right(2)),integer.valueOf(s.left(16).right(2)),integer.valueOf(s.left(19).right(2)));
        return dt;
    } 
    
    public static String DateTimeToString(Datetime dt){
        if(String.isBlank(String.valueOf(dt))){
            return null;
        }
        Integer offset = UserInfo.getTimeZone().getOffset(OF_TTM_Utils.now())/3600000;
        String prefix = (offset >= 0) ? '+'  : '-';
        String a = prefix + ((Math.abs(offset) < 10) ? ('0'+ Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));
        String s = dt.format('yyyy-MM-dd\'T\'HH:mm:ss\''+a+'\'');
        return s;
    }   
    
    public static boolean verificaDateTime(String dataTime){
        String dateTimeRegex = '(^\\d{4}(-\\d{2}){0,2})?((^|T)\\d{2}(:\\d{2}(:\\d{2}(\\.\\d+)?)?)?(Z|[\\+|-]\\d{2}:\\d{2})?)?$';
        Pattern p = Pattern.compile(dateTimeRegex);
        Matcher m = p.matcher(dataTime);
        Boolean result = m.matches();
        if(result)
            return true;
        else
            return false;
    }
    
    public static String getMethodValue(String tipoC){
        
        if(tipoC=='3')
            return 'Notifica UpdateTicketID';
        if(tipoC=='4')
            return 'Notifica Sospensione';
        if(tipoC=='5')
            return 'Notifica Richiesta Chiusura';
        if(tipoC=='7')
            return 'Notifica Desospensione';
        if(tipoC=='10')
            return 'Notifica Annullamento';
        if(tipoC=='13')
            return 'Notifica Timeout OK';
        
        return '';
    }

    public static String getValueLogTipoCom(String tipoC, String statoRichiesta){
        
        if(tipoC=='3')
            return 'TTM -> SF - '+statoRichiesta+' - Notifica UpdateTicketID';
        if(tipoC=='4')
            return 'TTM -> SF - '+statoRichiesta+' - Notifica Sospensione';
        if(tipoC=='5')
            return 'TTM -> SF - '+statoRichiesta+' - Notifica Richiesta Chiusura';
        if(tipoC=='7')
            return 'TTM -> SF - '+statoRichiesta+' - Notifica Desospensione';
        if(tipoC=='10')
            return 'TTM -> SF - '+statoRichiesta+' - Notifica Annullamento';
        if(tipoC=='13')
            return 'TTM -> SF - '+statoRichiesta+' - Notifica Timeout OK';
        
        return '';
    }
    
    public static Datetime now(){
        Datetime dt=Datetime.newInstance(system.today(), system.now().Time());
        return dt;
        
    }
    
    public static string getDescRisoluzione(string s){

        string a ='';
        
        if (string.isBlank(s)){
            return null;
        }
               
        if(s =='1'){
            a ='RISOLTO: TRATTA VERTICALE';           
        }
        if(s =='2'){
            a ='RISOLTO TRATTA ORIZZONTALE: CENTRALE';
        }
        if(s =='3'){
            a ='RISOLTO TRATTA ORIZZONTALE: RETE PRIMARIA';
        }
        if(s =='4'){
            a ='RISOLTO TRATTA ORIZZONTALE: RETE SECONDARIA';
        }
        if(s =='5'){
            a ='NON RISCONTRATO: SENZA USCITA';
        }
        if(s =='6'){
            a= 'NON RISCONTRATO: CON USCITA';
        }
        if(s =='7'){
            a ='RISOLTO: SBRACCIO';
        }
        if(s =='8'){
            a='RISOLTO: BORCHIA OTTICA';
        }
        if(s =='9'){
            a ='NON RISOLVIBILE: CAUSA IMPIANTO CLIENTE';
        }
        if(s =='10'){
            a ='NON RISOLVIBILE: CAUSA CPE CLIENTE';
        }
        if(s =='11'){
            a ='RISOLTO OLO/CLIENTE: CONFIGURAZIONE CPE/ONT CLIENTE';
        }
        if(s =='12'){
            a ='RISOLTO OLO/CLIENTE: SOSTITUZIONE CPE CLIENTE';
        }
        if(s =='13'){
            a ='RISOLTO OLO/CLIENTE: SOSTITUZIONE ONT CLIENTE';
        }
        if(s =='14'){
            a ='RISOLTO OLO/CLIENTE: RESET CPE/ONT CLIENTE';
        }
        if(s =='15'){
            a ='RISOLTO OLO/CLIENTE: SOSTITUZIONE BRETELLA OTTICA';
        }
        if(s =='16'){
            a ='RIBALTAMENTO EFFETTUATO';
        }
        if(s =='17'){
            a ='NON RISOLVIBILE: PROBLEMI RETE OLO (ES. PROBLEMA DI SCHEDA IN CENTRALE OLO, PROBLEMA DI CONFIGURAZIONE OLO)';
        }
        if(s =='18'){
            a ='NON RISOLVIBILE: PROBLEMI RETE CLIENTE (ES. WI-FI POCO PERFORMANTE CAUSA DISPOSIZIONE CASA CLIENTE, CONFIGURAZIONE PC)';
        }
        if(s =='19'){
            a ='RISOLTO MEDIANTE INTERVENTO CONGIUNTO';
        }
        if(s =='20'){
            a ='CHIUSO PER TIMEOUT_OK';
        }
        
        return a;
    }
}
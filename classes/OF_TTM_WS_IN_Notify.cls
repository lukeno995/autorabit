/**
* Author:       Team Napoli
* Description:  Integrazione SFDC to TTM/Salesforce/OLO
* SI:           
*/ 
global class OF_TTM_WS_IN_Notify {
    
    global class TTM_Notify{      
        webservice String TIPO_COMUNICAZIONE;        //3,4,5,7,10,13
        webservice String ID_RISORSA;
        webservice String CODICE_OPERATORE;
        webservice String CODICE_COMUNICAZIONE_OLO;
        webservice String ID_NOTIFICA;               //3,4,5,7,10,13
        webservice String ID_TT;
        webservice String DATA_ORA_CREAZIONE_TT;
        webservice String DATA_ORA_NOTIFICA_SOSPENSIONE;
        webservice String DATA_ORA_NOTIFICA_DESOSPENSIONE;
        webservice String DATA_ORA_NOTIFICA_ANNULLAMENTO;
        webservice String DATA_ORA_NOTIFICA_CHIUSURA;
        webservice String CAUSALE_SOSPENSIONE;
        webservice String REFERENTE_DESOSPENSIONE;
        webservice String DESCRIZIONE_INTERVENTO_RISOLUZIONE;
        webservice String NOTE;
        webservice String RISCHEDULAZIONE_APPUNTAMENTO;
        webservice String INTERVENTO_CONGIUNTO;
        webservice String TEC_OLO;
        webservice String TEL_TEC_OLO;
        webservice String DATA_ORA_INTERVENTO_CONGIUNTO;
    }
    
    global class TTM_NotifyResponse{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
        //webservice String DATA_NOTIFICA;
    }
    
    webservice static TTM_NotifyResponse TTM_Notify (TTM_Notify no){
        
        //AA 27/07/18 - Creazione sLog per mappare la request proveniente da TTM
        OF_TTM_WS_Notify_Utils.sLogTTMSF = OF_TTM_WS_Notify_Utils.create_EAI_Log(no);
        
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse out= OF_TTM_WS_Notify_Utils.syncError (no); 
        if(out!=null){
            //Inserisco il log della request
            insert OF_TTM_WS_Notify_Utils.sLogTTMSF;
            OF_TTM_WS_Notify_Utils.writeLog(no,'NACK',out.CODICE_MOTIVAZIONE,out.MOTIVAZIONE);
            return out;
        }
        
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse resp=new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
		resp.ID_NOTIFICA ='';
        resp.ESITO ='';
        resp.CODICE_MOTIVAZIONE ='';
        resp.MOTIVAZIONE ='';
		//resp.DATA_NOTIFICA =''; 
        
        // 26/06/2018 MM : aggiunto controllo per tipo comunicazione non ammesso
        if(no.TIPO_COMUNICAZIONE!='4' && no.TIPO_COMUNICAZIONE!='7' && no.TIPO_COMUNICAZIONE!='10' && no.TIPO_COMUNICAZIONE!='5'
           && no.TIPO_COMUNICAZIONE!='3' && no.TIPO_COMUNICAZIONE!='13'){
               resp = OF_TTM_WS_Notify_Utils.CheckTipoCom(no);
           } 
        
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4.equals(no.TIPO_COMUNICAZIONE)){
            resp= OF_TTM_WS_IN_Notify_Services.Sospensione(no);
        }
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7.equals(no.TIPO_COMUNICAZIONE)){
            resp= OF_TTM_WS_IN_Notify_Services.Desospensione(no);
        }
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_10.equals(no.TIPO_COMUNICAZIONE)){
            resp= OF_TTM_WS_IN_Notify_Services.Annullato(no);
        }
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_5.equals(no.TIPO_COMUNICAZIONE)){
            resp= OF_TTM_WS_IN_Notify_Services.Chiusura(no);
        }
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_3.equals(no.TIPO_COMUNICAZIONE)){
            resp= OF_TTM_WS_IN_Notify_Services.updateTICKETID(no);
        }       
        if(OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13.equals(no.TIPO_COMUNICAZIONE)){
            resp= OF_TTM_WS_IN_Notify_Services.TimeOut(no);
        }   
        //METODO PER MAPPARE LA RESPONSE
        //1 Insert - Request TTM
        OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Response__c = (resp.Esito =='0') ? 'ACK' : (resp.CODICE_MOTIVAZIONE =='A_K8') ? 'NACK TECNICO' : 'NACK';
        insert OF_TTM_WS_Notify_Utils.sLogTTMSF;
         
        //2 Insert - Response TTM
        if(resp.Esito =='0'){
            OF_TTM_WS_Notify_Utils.sLogTTMSFResp = OF_TTM_WS_Notify_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_ACK',
                																		'Codice_comunicazione_OLO' => OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Codice_comunicazione_olo__c,
                																		'CaseId' => OF_TTM_WS_Notify_Utils.sLogTTMSF.Caso__c,
                																		'Codice_operatore' => OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Codice_Operatore__c,
                																		'Tipo Comunicazione' => OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Tipo_comunicazione__c,
                                                                                        'Tipo Comunicazione String' => 'TTM -> SF - ACK TTM Notify',
                                                                                        'ID_notifica' => OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_ID_Notifica__c,
                                                                                        'SL Riferimento' => OF_TTM_WS_Notify_Utils.sLogTTMSF.Id,
                                                                                        'TT_Request' => 'Esito: ' + resp.Esito
                																		});
        }
        if(resp.Esito=='1'){
            OF_TTM_WS_Notify_Utils.sLogTTMSFResp = OF_TTM_WS_Notify_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_NACK',
                																		'Codice_comunicazione_OLO' => OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Codice_comunicazione_olo__c,
                																		'CaseId' => OF_TTM_WS_Notify_Utils.sLogTTMSF.Caso__c,
                																		'Codice_operatore' => OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Codice_Operatore__c,
                																		'Tipo Comunicazione' => OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Tipo_comunicazione__c,
                																		'Codice_errore' => resp.CODICE_MOTIVAZIONE,
                																		'Causale_errore' => resp.MOTIVAZIONE,
                                                                                        'Tipo Comunicazione String' => 'TTM -> SF - NACK TTM Notify',
                                                                                        'ID_notifica' => OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_ID_Notifica__c,
                                                                                        'SL Riferimento' => OF_TTM_WS_Notify_Utils.sLogTTMSF.Id,
                                                                                        'TT_Request' => 'Esito: ' + resp.Esito + 
                                                                                                        '\nCodice_errore: ' + resp.CODICE_MOTIVAZIONE +
                                                                                                        '\nCausale_errore: ' + resp.MOTIVAZIONE
                																		});           
        }
        //Insert del log rappresentativo della response data a TTM
        insert OF_TTM_WS_Notify_Utils.sLogTTMSFResp;
        //3 Insert - Request OLO
        if(OF_TTM_Utils.sLogSFOLO != null){
            insert OF_TTM_Utils.sLogSFOLO;
        }
        //4 Insert - Response OLO
        if(OF_TTM_Utils.sLogSFOLOResp != null){
            OF_TTM_Utils.sLogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.Id;
            insert OF_TTM_Utils.sLogSFOLOResp;
        } 
        //update + varie ed eventuali
        if(OF_TTM_WS_Notify_Utils.caseTTM != null){
            update OF_TTM_WS_Notify_Utils.caseTTM;
        }
        
        return resp;
    }
}
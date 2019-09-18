/**
* Author:       Team Napoli
* Description:  Integrazione SFDC to TTM/Salesforce/OLO 
*               
*/

public without sharing class OF_TTM_WS_IN_Notify_Services { 
    
    /**
* Author:       Team Napoli
* Description:  
*               notifyType == 4; Tale metodo NON richiama il trigger SendNotify.  
*/
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse Sospensione (OF_TTM_WS_IN_Notify.TTM_Notify act){
        
        try{
            List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
            List<Case> listCase = [SELECT Id, Status, CaseNumber, EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                                   PO_TT_Portale__c,EOF_Fase__c,OwnerId, canModify__c, EOF_Data_Prevista_Attivazione__c,
                                   EOF_Impresa__c, EOF_Tipo_di_intervento__c, EOF_Tipo_di_intervento_aggiuntivo__c,
                                   EOF_Minuti_rimanenti_sospesi__c,EOF_Data_Max_Risoluzione_Ticket__c, EOF_Timeout_OK__c,
                                   EOF_Num_min_risoluzione_Ticket__c,EOF_Comunicazioni_con_OLO__C,
                                   EOF_Num_sec_risoluzione_Ticket__c,EOF_Secondi_Sospesi_allo_SLA__c, OF_TroubleTicketManager__c, TTM_TICKETID__c,
                                   EOF_ID_Notifica__c,	EOF_Data_Ora_Intervento_Congiunto__c,EOF_Id_Risorsa__c,EOF_Rischedulazione_Appuntamento__c,EOF_Data_Ora_Sospensione__c,
                                   EOF_Causale_Sospensione__c,EOF_Descrizione_Intervento_Risoluzione__c,EOF_Intervento_Congiunto__c, EOF_Referente_desospensione__c,
                                   EOF_Note__c,EOF_Tel_Tec_EOF__c,EOF_Tec_EOF__c,EOF_Nuova_DAC__c,EOF_Pertinenza_RDAC__c
                                   FROM Case 
                                   WHERE EOF_Codice_Comunicazione_OLO__c =:act.CODICE_COMUNICAZIONE_OLO 
                                   AND OF_TroubleTicketManager__c=TRUE
                                   AND status!='Chiuso' AND status!='Annullato'
                                   AND RecordTypeId=:rt.get(0).id]; //Vengono aggiunti altri campi nel trigger SendNotify
            if(listCase.isEmpty()){
                return OF_TTM_WS_Notify_Utils.syncErrorCodiceComunicazioneOLO(act);
            } 
			OF_TTM_WS_Notify_Utils.caseTTM = listCase.get(0);
            //Check per stato non valido
            if(!OF_TTM_WS_Notify_Utils.caseTTM.status.equalsIgnoreCase('In Lavorazione')){
                return OF_TTM_WS_Notify_Utils.syncErrorCaseStatus(act);
            }

            if(OF_TTM_WS_Notify_Utils.caseTTM.PO_TT_Portale__c){//Forzo l'aggiornamento dello status
                OF_TTM_WS_Notify_Utils.caseTTM.status='Sospeso';
                OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Stato_Ticket__c =OF_TTM_Utils.getValueStatoTicket(OF_TTM_WS_Notify_Utils.caseTTM.status); 
            }
            //Richiamo il servizio OLO oppure mostro a video
            
            // 2018-12-21 MM : aggiungo logica per il popolamento dello stato ticket verso OLO
             OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Stato_Ticket__c='3';
            
            OF_TTM_WS_Notify_Utils.createAckNackByNotify(OF_TTM_WS_Notify_Utils.sLogTTMSF, OF_TTM_WS_Notify_Utils.caseTTM);
            
            if (OF_TTM_Utils.responseDaOLO == 'ACK'){// Se becchiamo un NACK, riporto lo stato del case in lavorazione!
                coreSospensione(OF_TTM_WS_Notify_Utils.caseTTM, OF_TTM_WS_Notify_Utils.sLogTTMSF);
                return OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(act);
            }else{
                return OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(act);
            }
        }catch(Exception e){
            return OF_TTM_WS_Notify_Utils.responseException(act,e);
        }
        
        //return OF_TTM_WS_Notify_Utils.responseACK(act);        
    } 

    /**
* Author:       Team Napoli
* Description:  
*               notifyType == 7; Tale metodo NON richiama il trigger SendNotify. 
*/
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse Desospensione (OF_TTM_WS_IN_Notify.TTM_Notify act){
        
        try{
            List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
            List<Case> listCase = [SELECT Id, Status, CaseNumber, EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                                   PO_TT_Portale__c,EOF_Fase__c,OwnerId, canModify__c, EOF_Data_Prevista_Attivazione__c,
                                   EOF_Impresa__c, EOF_Tipo_di_intervento__c, EOF_Tipo_di_intervento_aggiuntivo__c,
                                   EOF_Minuti_rimanenti_sospesi__c,EOF_Data_Max_Risoluzione_Ticket__c, EOF_Timeout_OK__c,
                                   EOF_Num_min_risoluzione_Ticket__c,EOF_Comunicazioni_con_OLO__C,
                                   EOF_Num_sec_risoluzione_Ticket__c,EOF_Secondi_Sospesi_allo_SLA__c, OF_TroubleTicketManager__c, TTM_TICKETID__c,
                                   EOF_ID_Notifica__c,	EOF_Data_Ora_Intervento_Congiunto__c,EOF_Id_Risorsa__c,EOF_Rischedulazione_Appuntamento__c,EOF_Data_Ora_Sospensione__c,
                                   EOF_Causale_Sospensione__c,EOF_Descrizione_Intervento_Risoluzione__c,EOF_Intervento_Congiunto__c, EOF_Referente_desospensione__c,
                                   EOF_Note__c,EOF_Tel_Tec_EOF__c,EOF_Tec_EOF__c,EOF_Nuova_DAC__c,EOF_Pertinenza_RDAC__c
                                   FROM Case 
                                   WHERE EOF_Codice_Comunicazione_OLO__c =:act.CODICE_COMUNICAZIONE_OLO 
                                   AND OF_TroubleTicketManager__c=TRUE
                                   AND status!='Chiuso' AND status!='Annullato'
                                   AND RecordTypeId=:rt.get(0).id]; //Vengono aggiunti altri campi nel trigger SendNotify
            
            if(listCase.isEmpty()){
                return OF_TTM_WS_Notify_Utils.syncErrorCodiceComunicazioneOLO(act);
            }  
            if(listCase.get(0).status!='Sospeso'){
                return OF_TTM_WS_Notify_Utils.syncErrorCaseStatus(act);
            }
            
            OF_TTM_WS_Notify_Utils.caseTTM = listCase.get(0);

            if(OF_TTM_WS_Notify_Utils.caseTTM.PO_TT_Portale__c){//Forzo l'aggiornamento dello status
                OF_TTM_WS_Notify_Utils.caseTTM.status='In Lavorazione'; 
                OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Stato_Ticket__c =OF_TTM_Utils.getValueStatoTicket(OF_TTM_WS_Notify_Utils.caseTTM.status); 
                
            }
            
            
            // 2018-12-21 MM : aggiungo logica per il popolamento dello stato ticket verso OLO
            OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Stato_Ticket__c='2';
            
            //Richiamo il servizio OLO oppure mostro a video
            OF_TTM_WS_Notify_Utils.createAckNackByNotify(OF_TTM_WS_Notify_Utils.sLogTTMSF, OF_TTM_WS_Notify_Utils.caseTTM);
            
            if (OF_TTM_Utils.responseDaOLO == 'ACK'){// Se becchiamo un NACK, riporto lo stato del case in lavorazione!
                coreDesospensione(OF_TTM_WS_Notify_Utils.caseTTM, OF_TTM_WS_Notify_Utils.sLogTTMSF);
        
                OF_TTM_WS_Notify_Utils.caseTTM.EOF_Rischedulazione_Appuntamento__c = OF_TTM_WS_Notify_Utils.stringToDateTime(act.RISCHEDULAZIONE_APPUNTAMENTO);
                OF_TTM_WS_Notify_Utils.caseTTM.status='In Lavorazione';
                OF_TTM_WS_Notify_Utils.caseTTM.EOF_Fase__C='Da Lavorare';
                OF_TTM_WS_Notify_Utils.caseTTM.EOF_Desospendi__c=false;

                return OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(act);
            }else{
                return OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(act);
            }
        }catch(Exception e){
            return OF_TTM_WS_Notify_Utils.responseException(act,e);
        }
        //return OF_TTM_WS_Notify_Utils.responseACK(act);        
    } 
    
    /**
* Author:       Team Napoli
* Description:  
*               notifyType == 10; Tale metodo NON richiama il trigger SendNotify.
*/
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse Annullato (OF_TTM_WS_IN_Notify.TTM_Notify act){
        
        try{
            List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
            List<Case> listCase = [SELECT Id, Status, CaseNumber, EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                                   PO_TT_Portale__c,EOF_Fase__c,OwnerId, canModify__c, EOF_Data_Prevista_Attivazione__c,
                                   EOF_Impresa__c, EOF_Tipo_di_intervento__c, EOF_Tipo_di_intervento_aggiuntivo__c,
                                   EOF_Minuti_rimanenti_sospesi__c,EOF_Data_Max_Risoluzione_Ticket__c, EOF_Timeout_OK__c,
                                   EOF_Num_min_risoluzione_Ticket__c,EOF_Comunicazioni_con_OLO__C,
                                   EOF_Num_sec_risoluzione_Ticket__c,EOF_Secondi_Sospesi_allo_SLA__c, OF_TroubleTicketManager__c, TTM_TICKETID__c,
                                   EOF_ID_Notifica__c,	EOF_Data_Ora_Intervento_Congiunto__c,EOF_Id_Risorsa__c,EOF_Rischedulazione_Appuntamento__c,EOF_Data_Ora_Sospensione__c,
                                   EOF_Causale_Sospensione__c,EOF_Descrizione_Intervento_Risoluzione__c,EOF_Intervento_Congiunto__c, EOF_Referente_desospensione__c,
                                   EOF_Note__c,EOF_Tel_Tec_EOF__c,EOF_Tec_EOF__c,EOF_Nuova_DAC__c,EOF_Pertinenza_RDAC__c
                                   FROM Case 
                                   WHERE EOF_Codice_Comunicazione_OLO__c =:act.CODICE_COMUNICAZIONE_OLO 
                                   AND OF_TroubleTicketManager__c=TRUE
                                   AND status!='Chiuso' AND status!='Annullato'
                                   AND RecordTypeId=:rt.get(0).id]; //Vengono aggiunti altri campi nel trigger SendNotify
            
            if(listCase.isEmpty()){
                return OF_TTM_WS_Notify_Utils.syncErrorCodiceComunicazioneOLO(act);
            }   
            if(listCase.get(0).status!='In Annullamento'){
                return OF_TTM_WS_Notify_Utils.syncErrorCaseStatus(act);
            }
            
            OF_TTM_WS_Notify_Utils.caseTTM = listCase.get(0);

            if(OF_TTM_WS_Notify_Utils.caseTTM.PO_TT_Portale__c){//Forzo l'aggiornamento dello status
                OF_TTM_WS_Notify_Utils.caseTTM.status='Annullato';
                OF_TTM_WS_Notify_Utils.caseTTM.eof_fase__c='Annullato';
                OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Stato_Ticket__c =OF_TTM_Utils.getValueStatoTicket(OF_TTM_WS_Notify_Utils.caseTTM.status); 
                
            }
            
            // 2018-12-21 MM : aggiungo logica per il popolamento dello stato ticket verso OLO
            OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Stato_Ticket__c='5';
            
        
            //Richiamo il servizio OLO oppure mostro a video
            OF_TTM_WS_Notify_Utils.createAckNackByNotify(OF_TTM_WS_Notify_Utils.sLogTTMSF, OF_TTM_WS_Notify_Utils.caseTTM);

            if (OF_TTM_Utils.responseDaOLO == 'ACK'){// Se becchiamo un NACK, riporto lo stato del case in lavorazione!
                coreAnnullato(OF_TTM_WS_Notify_Utils.caseTTM, OF_TTM_WS_Notify_Utils.sLogTTMSF);
                return OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(act);
            }else{
                return OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(act);
            }
        }catch(Exception e){
            return OF_TTM_WS_Notify_Utils.responseException(act,e);
        }
    } 
    
    /**
* Author:       Team Napoli
* Description:  
*               notifyType == 5; Tale metodo NON richiama il trigger SendNotify.
*/
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse Chiusura (OF_TTM_WS_IN_Notify.TTM_Notify act){
        
        try{
            List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
            List<Case> listCase = [SELECT Id, Status, CaseNumber, EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                                   PO_TT_Portale__c,EOF_Fase__c,OwnerId, canModify__c, EOF_Data_Prevista_Attivazione__c,
                                   EOF_Impresa__c, EOF_Tipo_di_intervento__c, EOF_Tipo_di_intervento_aggiuntivo__c,
                                   EOF_Minuti_rimanenti_sospesi__c,EOF_Data_Max_Risoluzione_Ticket__c, EOF_Timeout_OK__c,
                                   EOF_Num_min_risoluzione_Ticket__c,EOF_Comunicazioni_con_OLO__C,
                                   EOF_Num_sec_risoluzione_Ticket__c,EOF_Secondi_Sospesi_allo_SLA__c, OF_TroubleTicketManager__c, TTM_TICKETID__c,
                                   EOF_ID_Notifica__c,	EOF_Data_Ora_Intervento_Congiunto__c,EOF_Id_Risorsa__c,EOF_Rischedulazione_Appuntamento__c,EOF_Data_Ora_Sospensione__c,
                                   EOF_Causale_Sospensione__c,EOF_Descrizione_Intervento_Risoluzione__c,EOF_Intervento_Congiunto__c, EOF_Referente_desospensione__c,
                                   EOF_Note__c,EOF_Tel_Tec_EOF__c,EOF_Tec_EOF__c,EOF_Nuova_DAC__c,EOF_Pertinenza_RDAC__c
                                   FROM Case 
                                   WHERE EOF_Codice_Comunicazione_OLO__c =:act.CODICE_COMUNICAZIONE_OLO 
                                   AND OF_TroubleTicketManager__c=TRUE
                                   AND status!='Chiuso' AND status!='Annullato'
                                   AND RecordTypeId=:rt.get(0).id]; //Vengono aggiunti altri campi nel trigger SendNotify
            
            if(listCase.isEmpty()){
                return OF_TTM_WS_Notify_Utils.syncErrorCodiceComunicazioneOLO(act);
            }

            if(listCase.get(0).status!='In Lavorazione'){
                return OF_TTM_WS_Notify_Utils.syncErrorCaseStatus(act);
            }
            
            OF_TTM_WS_Notify_Utils.caseTTM = listCase.get(0);

            if(OF_TTM_WS_Notify_Utils.caseTTM.PO_TT_Portale__c){//Forzo l'aggiornamento dello status
                OF_TTM_WS_Notify_Utils.caseTTM.status='Richiesta Chiusura';
                OF_TTM_WS_Notify_Utils.caseTTM.eof_fase__c='Attesa Chiusura'; 
                OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Stato_Ticket__c =OF_TTM_Utils.getValueStatoTicket(OF_TTM_WS_Notify_Utils.caseTTM.status); 
                
            }
            
            
            // 2018-12-21 MM : aggiungo logica per il popolamento dello stato ticket verso OLO
            OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Stato_Ticket__c='6';
            
            //Richiamo il servizio OLO oppure mostro a video
            OF_TTM_WS_Notify_Utils.createAckNackByNotify(OF_TTM_WS_Notify_Utils.sLogTTMSF, OF_TTM_WS_Notify_Utils.caseTTM); 

            if (OF_TTM_Utils.responseDaOLO == 'ACK'){// Se becchiamo un NACK, riporto lo stato del case in lavorazione!
                coreChiusura(OF_TTM_WS_Notify_Utils.caseTTM,OF_TTM_WS_Notify_Utils.sLogTTMSF);
                return OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(act);
            }else{
                return OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(act);
            }        			
        }catch(Exception e){
            return OF_TTM_WS_Notify_Utils.responseException(act,e);
        } 
    } 
    
    /**
* Author:       Team Napoli
* Description:  
*               notifyType == 13
*               Aggiornato il trigger sul Case, sono stati esclusi i casi TTM. Tale metodo NON richiama il trigger SendNotify.
*/
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse TimeOut (OF_TTM_WS_IN_Notify.TTM_Notify act){
        
        try{
            List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
            List<Case> listCase = [SELECT Id, Status, CaseNumber, EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                                   PO_TT_Portale__c,EOF_Fase__c,OwnerId, canModify__c, EOF_Data_Prevista_Attivazione__c,
                                   EOF_Impresa__c, EOF_Tipo_di_intervento__c, EOF_Tipo_di_intervento_aggiuntivo__c,
                                   EOF_Minuti_rimanenti_sospesi__c,EOF_Data_Max_Risoluzione_Ticket__c, EOF_Timeout_OK__c,
                                   EOF_Num_min_risoluzione_Ticket__c,EOF_Comunicazioni_con_OLO__C,
                                   EOF_Num_sec_risoluzione_Ticket__c,EOF_Secondi_Sospesi_allo_SLA__c, OF_TroubleTicketManager__c, TTM_TICKETID__c,
                                   EOF_ID_Notifica__c,	EOF_Data_Ora_Intervento_Congiunto__c,EOF_Id_Risorsa__c,EOF_Rischedulazione_Appuntamento__c,EOF_Data_Ora_Sospensione__c,
                                   EOF_Causale_Sospensione__c,EOF_Descrizione_Intervento_Risoluzione__c,EOF_Intervento_Congiunto__c, EOF_Referente_desospensione__c,
                                   EOF_Note__c,EOF_Tel_Tec_EOF__c,EOF_Tec_EOF__c,EOF_Nuova_DAC__c,EOF_Pertinenza_RDAC__c
                                   FROM Case 
                                   WHERE EOF_Codice_Comunicazione_OLO__c =:act.CODICE_COMUNICAZIONE_OLO 
                                   AND OF_TroubleTicketManager__c=TRUE
                                   AND status!='Chiuso' AND status!='Annullato'
                                   AND RecordTypeId=:rt.get(0).id]; //Vengono aggiunti altri campi nel trigger SendNotify
            
            if(listCase.isEmpty()){
                return OF_TTM_WS_Notify_Utils.syncErrorCodiceComunicazioneOLO(act);
            }
            if(listCase.get(0).status!='Richiesta Chiusura'){
                return OF_TTM_WS_Notify_Utils.syncErrorCaseStatus(act);
            }
            
            OF_TTM_WS_Notify_Utils.caseTTM = listCase.get(0);
            
            if(OF_TTM_WS_Notify_Utils.caseTTM.PO_TT_Portale__c){//Forzo l'aggiornamento dello status
                OF_TTM_WS_Notify_Utils.caseTTM.status='Chiuso';
                OF_TTM_WS_Notify_Utils.caseTTM.eof_fase__c='Chiusura'; 
                OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Stato_Ticket__c =OF_TTM_Utils.getValueStatoTicket(OF_TTM_WS_Notify_Utils.caseTTM.status); 
                
            }
            
            // 2018-12-21 MM : aggiungo logica per il popolamento dello stato ticket verso OLO
            OF_TTM_WS_Notify_Utils.sLogTTMSF.EOF_Stato_Ticket__c='4';
            
            //Richiamo il servizio OLO oppure mostro a video
            OF_TTM_WS_Notify_Utils.createAckNackByNotify(OF_TTM_WS_Notify_Utils.sLogTTMSF, OF_TTM_WS_Notify_Utils.caseTTM);   

            if (OF_TTM_Utils.responseDaOLO == 'ACK'){// Se becchiamo un NACK, riporto lo stato del case in lavorazione!
                //Aggiorno lo stato del Case
                OF_TTM_WS_Notify_Utils.caseTTM.status='Chiuso';
                OF_TTM_WS_Notify_Utils.caseTTM.EOF_Fase__c='Chiusura'; 
                return OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(act);
            }else{
                return OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(act);
            }                    
        }catch(Exception e){
            return OF_TTM_WS_Notify_Utils.responseException(act,e);
        }      
    } 
    
    /**
* Author:       Team Napoli
* Description:  
*               notifyType == 3; Tale metodo NON richiama il trigger SendNotify.
*/
    public static OF_TTM_WS_IN_Notify.TTM_NotifyResponse updateTICKETID (OF_TTM_WS_IN_Notify.TTM_Notify act){
        try{
            List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
            List<Case> listCase = [SELECT Id, Status, TTM_TICKETID__c, OF_TroubleTicketManager__c, DATA_ORA_CREAZIONE_TT__c
                                   FROM Case 
                                   WHERE EOF_Codice_Comunicazione_OLO__c =:act.CODICE_COMUNICAZIONE_OLO 
                                   AND OF_TroubleTicketManager__c=TRUE
                                   AND RecordTypeId=:rt.get(0).id
                                   AND status!='Chiuso' 
                                   AND TTM_TICKETID__c =null ];
            
            if(listCase.isEmpty()){
                return OF_TTM_WS_Notify_Utils.syncErrorCodiceComunicazioneOLO_TICKETID_TTM(act);
            }
            
            OF_TTM_WS_Notify_Utils.caseTTM = listCase.get(0);
            
            OF_TTM_WS_Notify_Utils.caseTTM.TTM_TICKETID__c=act.ID_TT;
            OF_TTM_WS_Notify_Utils.caseTTM.DATA_ORA_CREAZIONE_TT__c=OF_TTM_WS_Notify_Utils.stringToDateTime(act.DATA_ORA_CREAZIONE_TT);
            //update listCase;
        }catch(Exception e){
            return OF_TTM_WS_Notify_Utils.responseException(act,e);
        }
        return OF_TTM_WS_Notify_Utils.responseACK(act); 
    }
    
    
    /* Il metodo coreChiusura (Case originalcase, EOF_Notify__c notify) effettua le seguenti azioni:
- Aggiorna i campi Descrizione_Intervento_Risoluzione, status e fase del Case.
- Se è valorizzato il campo Note sulla Notify verifica se il campo "Comunicazioni_con_OLO" è valorizzato, in caso
contrario lo popola eseguendo una concatenazione tra la data di sistema attuale, il rType e il name dello user corrente
- * Si verifica se il campo del case Data_Max_Risoluzione_Ticket sia > della data corrente di sistema ed in caso 
affermativo si controlla che il campo Rischedulazione_Appuntamento non sia vuoto e sia > della data corrente 
di sistema.
- Soddisfatta questa condizione si calcola il valore da memorizzare nel campo Secondi_Sospesi_allo_SLA__c.
IF--> Il valore di Secondi_Sospesi_allo_SLA__c sarà uguale alla sottrazione tra i millisecondi della 
Data_Max_Risoluzione_Ticket ed i millisecondi della Rischedulazione_Appuntamento__c (totale diviso per 1000).
ELSE --> Il valore di Secondi_Sospesi_allo_SLA__c sarà uguale alla sottrazione tra i millisecondi della 
Data_Max_Risoluzione_Ticket ed i millisecondi della data corrente di sistema (totale diviso per 1000).
- * Se il campo Data_Max_Risoluzione_Ticket non è > della data corrente di sistema, al campo 
Secondi_Sospesi_allo_SLA__c viene assegnato 0.
- Si aggiorna il Case.
*/
    @TestVisible
    private static void coreChiusura (Case originalCase, EOF_EAI_Service_log__c Slog){
        
        originalCase.EOF_Descrizione_Intervento_Risoluzione__c= OF_TTM_WS_Notify_Utils.getDescRisoluzione(Slog.Descrizione_Evento_Risoluzione__c);
        originalcase.status='Richiesta Chiusura';
        originalcase.eof_fase__c='Attesa Chiusura';  
        
        if(String.isNotBlank(Slog.EOF_NOte__c)){
            if(String.isNotBlank(originalCase.EOF_COmunicazioni_con_OLO__C)){
                originalCase.EOF_COmunicazioni_con_OLO__C=originalCase.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TTM_Utils.DateToString(OF_TTM_WS_Notify_Utils.now()).left(19)+' - '+Slog.EOF_Tipo_comunicazione_string__c.right(Slog.EOF_Tipo_comunicazione_string__c.length()-16)+' - '+userInfo.getName()+':\n'+Slog.EOF_NOte__c;
            }
            else{
                originalCase.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_WS_Notify_Utils.now()).left(19)+' - '+Slog.EOF_Tipo_comunicazione_string__c.right(Slog.EOF_Tipo_comunicazione_string__c.length()-16)+' - '+userInfo.getName()+':\n'+Slog.EOF_NOte__c;
            }
        } 
        if(originalCase.EOF_Data_Max_Risoluzione_Ticket__c > OF_TTM_WS_Notify_Utils.now()){
            if(originalCase.EOF_Rischedulazione_Appuntamento__c!=null && originalCase.EOF_Rischedulazione_Appuntamento__c>OF_TTM_WS_Notify_Utils.now()){                    		
                originalCase.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((originalCase.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-originalCase.EOF_Rischedulazione_Appuntamento__c.getTime()) / 1000);                    		   
            }
            else{
                originalCase.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((originalCase.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-OF_TTM_WS_Notify_Utils.now().getTime()) / 1000);
            }            	
        }
        else{
            originalCase.EOF_Secondi_Sospesi_allo_SLA__c=0;
        }
        
        //OF_TTM_WS_Notify_Utils.caseTTM = originalCase;
        
        //update originalcase;
        //insert OF_TT_Utils.create_EAI_Log(notify);
    }
    
    /* Il metodo coreAnnullato (Case originalcase, EOF_Notify__c notify) effettua le seguenti azioni:
- Aggiorna lo status in 'Annullato' e la fase in 'Annullato'.
- Se è valorizzato il campo Note sulla Notify si controlla se il campo "Comunicazioni_con_OLO" è valorizzato, 
in caso contrario lo popola eseguendo una concatenazione tra la data di sistema attuale, il rType e il 
name dello user corrente.
- Memorizza come Data_Ora_Chiusura_Ticket la data corrente di sistema.
- Si aggiorna il Case.
*/    
    @TestVisible
    private static void coreAnnullato(Case originalcase, EOF_EAI_Service_log__c sLog){
        
        originalcase.status='Annullato';
        originalCase.eof_fase__c='Annullato';
        
        if(String.isNotBlank(sLog.EOF_NOte__c)){
            if(String.isNotBlank(originalCase.EOF_COmunicazioni_con_OLO__C)){
                originalCase.EOF_COmunicazioni_con_OLO__C=originalCase.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TTM_Utils.DateToString(OF_TTM_WS_Notify_Utils.now()).left(19)+' - '+sLog.EOF_Tipo_comunicazione_string__c.right(sLog.EOF_Tipo_comunicazione_string__c.length()-16)+' - '+userInfo.getName()+':\n'+sLog.EOF_NOte__c;
            }
            else{
                originalCase.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_WS_Notify_Utils.now()).left(19)+' - '+sLog.EOF_Tipo_comunicazione_string__c.right(sLog.EOF_Tipo_comunicazione_string__c.length()-16)+' - '+userInfo.getName()+':\n'+sLog.EOF_NOte__c;
            }
        }   
        originalCase.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_WS_Notify_Utils.now();
        
        //OF_TTM_WS_Notify_Utils.caseTTM = originalCase;
        
        //update originalCase;
        //insert OF_TT_Utils.create_EAI_Log(notify);
    } 
    
    /* Il metodo coreDesospensione (Case originalcase, EOF_Notify__c notify) effettua le seguenti azioni:
- Se è valorizzato il campo referente_desospensione sulla Notify, al campo Referente_Desospensione del Case
viene assegnato il valore presente sulla Notify.
Altrimenti se il campo Referente_Desospensione del case non è blank al referente_desospensione della notify
viene assegnato quello presente sul case.
Altrimenti, nel caso fossero blank entrambi, viene assegnato sia sulla notify che sul case 'Operatore BO'.
- Si memorizza come EOF_Data_ora_Desospensione del Case quello presente sulla Notify.
- Si aggiorna il campo causale_Desospensione del Case con il valore della causale_sospensione.
- Si assegna come Owner del case la coda 'Trouble Ticket - Coda Analisi'.
- Si aggiorna il Case.
*/
    // copy trigger SendNotify
    @TestVisible
    private static void coreDesospensione(Case originalcase, EOF_EAI_Service_log__c sLog){
        
        if(String.isNotBlank(sLog.eof_referente_desospensione__c)){
            originalCase.EOF_Referente_Desospensione__c=sLog.eof_referente_desospensione__c;
        }                               
        else if(String.isNotBlank(originalCase.EOF_Referente_Desospensione__c)){
            sLog.eof_referente_desospensione__c=originalCase.EOF_Referente_Desospensione__c;
        }
        else{             
            sLog.eof_referente_desospensione__c='Operatore BO';
            originalCase.EOF_Referente_Desospensione__c='Operatore BO';
        }                   
        originalCase.EOF_Data_ora_Desospensione__c=sLog.EOF_Data_Ora_Notifica_Desospensione__c;
        //originalCase.EOF_Causale_Desospensione__c=originalCase.EOF_Causale_sospensione__c;
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        Group analisi = [SELECT Id FROM Group WHERE Name = 'Trouble Ticket - Coda Analisi' AND Type = 'Queue'];
        originalCase.ownerId=analisi.Id;  
        
        if(String.isNotBlank(sLog.EOF_NOte__c)){
            if(String.isNotBlank(originalCase.EOF_COmunicazioni_con_OLO__C)){
                originalCase.EOF_COmunicazioni_con_OLO__C=originalCase.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TTM_Utils.DateToString(OF_TTM_WS_Notify_Utils.now()).left(19)+' - '+sLog.EOF_Tipo_comunicazione_string__c.right(sLog.EOF_Tipo_comunicazione_string__c.length()-16)+' - '+userInfo.getName()+':\n'+sLog.EOF_NOte__c;
            }
            else{
                originalCase.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_WS_Notify_Utils.now()).left(19)+' - '+sLog.EOF_Tipo_comunicazione_string__c.right(sLog.EOF_Tipo_comunicazione_string__c.length()-16)+' - '+userInfo.getName()+':\n'+sLog.EOF_NOte__c;
            }
        }

        //OF_TTM_WS_Notify_Utils.caseTTM = originalCase;
        
        //update originalcase;
    } 
    /* Il metodo coreSospensione (Case originalcase, EOF_Notify__c notify) effettua le seguenti azioni:
- Si setta il campo fase del case in relazione al valore della fase precedente.
* Si verifica se il campo del case Data_Max_Risoluzione_Ticket sia > della data corrente di sistema ed in caso 
affermativo si controlla che il campo Rischedulazione_Appuntamento non sia vuoto e sia > della data corrente 
di sistema.
- Soddisfatta questa condizione si calcola il valore da memorizzare nel campo Secondi_Sospesi_allo_SLA__c.
IF--> Il valore di Secondi_Sospesi_allo_SLA__c sarà uguale alla sottrazione tra i millisecondi della 
Data_Max_Risoluzione_Ticket ed i millisecondi della Rischedulazione_Appuntamento__c (totale diviso per 1000).
ELSE --> Il valore di Secondi_Sospesi_allo_SLA__c sarà uguale alla sottrazione tra i millisecondi della 
Data_Max_Risoluzione_Ticket ed i millisecondi della data corrente di sistema (totale diviso per 1000).
* Se il campo Data_Max_Risoluzione_Ticket non è > della data corrente di sistema, al campo 
Secondi_Sospesi_allo_SLA__c viene assegnato 0.
- Se il campo Rischedulazione_Appuntamento__c è valorizzato si effettua il calcolo della 
Data_Max_Risoluzione_Ticket del Case. Alla data Rischedulazione_Appuntamento (espressa in milliSec) presente 
sulla Notify vengono aggiunti i milliSec del campo Secondi_Sospesi_allo_SLA presente sul Case.      
- Si prende dal custom settings OF_TT_Parametri__c il campo EOF_Num_min_ritorno_in_lavorazione__c che rappresenta il
n° di minuti prima dell'appuntamento in cui il ticket ritorna in lavorazione e viene inviata notifica all'OLO.
Si moltiplica tale valore per (-1). Si memorizza tutto in una variabile denominanata numMin.
- Al campo EOF_Rischedulazione_Appuntamento__c viene aggiunto numMin (con addMinutes).
- Se questo valore è <= della data di sistema attuale si valorizza il campo del case 
EOF_Data_Ritorno_In_Lavorazione con la data attuale aggiungendo 1 minuto. In caso contrario il campo
EOF_Data_Ritorno_In_Lavorazione sarà uguale alla EOF_Rischedulazione_Appuntamento__c della Notify con
l'aggiunta di 1 minuto.
Qualora il campo EOF_Rischedulazione_Appuntamento della Notify fosse NULL verrà valorizzata la
EOF_Data_Max_Risoluzione_Ticket con il valore della data attuale di sistema sommato ai secondi del campo 
EOF_Secondi_Sospesi_allo_SLA.
- Al campo Rischedulazione_Appuntamento del Case viene assegnato il campo Rischedulazione_Appuntamento__c 
della Notify.
- Se il campo Causale_Sospensione__c presente sulla Notify è valorizzato, viene scritto il campo 
causale_Sospensione__c del case con il valore dell'analogo campo della Notify. In caso contrario
sul campo Causale_Sospensione del Case viene scritto 'Cliente Indisponibile'.
- Si valorizzano i campi del Case EOF_Data_Ora_Sospensione__c, EOF_Data_Ora_Intervento_congiunto__c,
EOF_tec_eof__c, EOF_Tel_Tec_EOF__c con i corrispettivi presenti sulla Notify.
Il campo Minuti_rimanenti_sospesi del Case viene valorizzato con il valore del campo  Num_min_risoluzione_Ticket
presente sempre sul Case.
- Se è presente il campo Note sulla Notify si controlla se il campo "Comunicazioni_con_OLO" è valorizzato, 
in caso contrario lo popola eseguendo una concatenazione tra la data di sistema attuale, il rType e il 
name dello user corrente.
- Si aggiorna lo status del Case in 'Sospeso'.
- Si aggiorna il Case.
*/
    // copy trigger SendNotify
    @TestVisible 
    private static void coreSospensione(Case originalcase, EOF_EAI_Service_log__c sLog){
        
        if(originalcase.eof_fase__c.equalsIgnoreCase('in Analisi')){
            originalcase.eof_fase__c='Sospeso Analisi';
        }
        if(originalcase.eof_fase__c.equalsIgnoreCase('On Field')){
            originalcase.eof_fase__c='Sospeso On Field';
        }
        if(originalcase.eof_fase__c.equalsIgnoreCase('in Collaudo')){
            originalcase.eof_fase__c='Sospeso Collaudo';
        } 
        if(originalCase.EOF_Data_Max_Risoluzione_Ticket__c > OF_TTM_WS_Notify_Utils.now()){
            if(originalCase.EOF_Rischedulazione_Appuntamento__c!=null && originalCase.EOF_Rischedulazione_Appuntamento__c>OF_TTM_WS_Notify_Utils.now()){                    		
                originalCase.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((originalCase.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-originalCase.EOF_Rischedulazione_Appuntamento__c.getTime()) / 1000);                    		
            }
            else{
                originalCase.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((originalCase.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-OF_TTM_WS_Notify_Utils.now().getTime()) / 1000);
            }
        }else{
            originalCase.EOF_Secondi_Sospesi_allo_SLA__c=0;
        }
        if(sLog.EOF_Rischedulazione_Appuntamento__c!=null){
            originalCase.EOF_Data_Max_Risoluzione_Ticket__c=sLog.EOF_Rischedulazione_Appuntamento__c.addSeconds(Integer.ValueOF(originalCase.EOF_Secondi_Sospesi_allo_SLA__c));
            Integer numMin = Integer.valueOf(OF_TT_Parametri__c.getInstance().EOF_Num_min_ritorno_in_lavorazione__c) * (-1);
            if(sLog.EOF_Rischedulazione_Appuntamento__c.addMinutes(numMin)<=Datetime.now()){
                originalCase.EOF_Data_Ritorno_In_Lavorazione__c=Datetime.now().addMinutes(1);
            }else{
                originalCase.EOF_Data_Ritorno_In_Lavorazione__c=sLog.EOF_Rischedulazione_Appuntamento__c.addMinutes(numMin); 
            }
        }else{
            originalCase.EOF_Data_Max_Risoluzione_Ticket__c=OF_TTM_WS_Notify_Utils.now().addSeconds(Integer.ValueOF(originalCase.EOF_Secondi_Sospesi_allo_SLA__c));
        }
        originalCase.EOF_Rischedulazione_Appuntamento__c=sLog.EOF_Rischedulazione_Appuntamento__c;     		
        if(String.isNotBlank(sLog.Causale_Sospensione__c)){
            originalCase.EOF_Causale_Sospensione__c= OF_TTM_Utils.getCausaleSospensione(sLog.Causale_Sospensione__c);
        }									  
        else if(String.isNotBlank(originalCase.EOF_Causale_Sospensione__c)){
            sLog.Causale_Sospensione__c=originalCase.EOF_Causale_Sospensione__c;
        }else{             
            originalCase.EOF_Causale_Sospensione__c='Cliente Indisponibile';
        }
        originalCase.EOF_Data_Ora_Sospensione__c=sLog.EOF_Data_Ora_Notifica_Sospensione__c;
        originalcase.EOF_Data_Ora_Intervento_congiunto__c=sLog.EOF_Data_Ora_Intervento_congiunto__c;
        if(!String.isBlank(originalCase.EOF_Num_min_risoluzione_Ticket__c)){
        	originalCase.EOF_Minuti_rimanenti_sospesi__c=Integer.valueOf(originalCase.EOF_Num_min_risoluzione_Ticket__c);
        }
        originalCase.EOF_Intervento_Congiunto__c=sLog.EOF_Intervento_Congiunto__c;
        originalCase.EOF_tec_eof__c=sLog.EOF_tec_eof__c;
        originalCase.EOF_Tel_Tec_EOF__c=sLog.EOF_Tel_Tec_EOF__c;  
        
        if(String.isNotBlank(sLog.EOF_NOte__c)){
            if(String.isNotBlank(originalCase.EOF_COmunicazioni_con_OLO__C)){
                originalCase.EOF_COmunicazioni_con_OLO__C=originalCase.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TTM_Utils.DateToString(OF_TTM_WS_Notify_Utils.now()).left(19)+' - '+sLog.EOF_Tipo_Comunicazione_String__c.right(sLog.EOF_Tipo_Comunicazione_String__c.length()-16)+' - '+userInfo.getName()+':\n'+sLog.EOF_NOte__c;
            }
            else{
                originalCase.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_WS_Notify_Utils.now()).left(19)+' - '+sLog.EOF_Tipo_Comunicazione_String__c.right(sLog.EOF_Tipo_Comunicazione_String__c.length()-16)+' - '+userInfo.getName()+':\n'+sLog.EOF_NOte__c;
            }
        } 
        originalcase.status='Sospeso';                
        
        /* AA COMMENTATO 
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = true;
        originalcase.setOptions(dmo); */
        
        //AA: Commentato, condividono già la stessa reference
        //OF_TTM_WS_Notify_Utils.caseTTM = originalCase;
        
        //update originalcase;
        //insert OF_TT_Utils.create_EAI_Log(notify);
    }
}
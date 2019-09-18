public class OF_TTM_AsyncChecks {
    
    @Future(callout=true)
    public static void checkAsync(string caseid, string sLogId){
        System.debug('***************** case id negli async ' + caseid);
        OF_TTM_EntryChecks.c= [select id,PO_TT_Portale__c,EOF_Codice_Comunicazione_OLO__c,status, Eof_fase__c,EOF_codice_Operatore_WS__c,EOF_Data_Ora_Chiusura_Ticket__c, 
                               EOF_Note__c, EOF_COmunicazioni_con_OLO__C, EOF_Data_ora_intervento_congiunto__c, Eof_tel_tec_olo__c, 
                               EOF_Tec_Olo__c, EOF_Descrizione_Problema__c, Note_cliente__c, EOF_Collaudi_Negativi__c, EOF_Causale_Apertura__c,
                               EOF_Intervento_Congiunto__c, EOF_Secondi_Sospesi_allo_SLA__c, EOF_Rischedulazione_Appuntamento__c, EOF_Data_Max_Risoluzione_Ticket__c,
                               EOF_Minuti_rimanenti_sospesi__c, Data_ora_Autoripristinato__c, EOF_Contact__c, EOF_Causale_errore__c,
                               EOF_Data_ora_RIchiesta_Annullamento__c, EOF_Causale_Richiesta_Annullamento__c,EOF_Causale_Desospensione__c,
                               EOF_Data_ora_Desospensione__c, EOF_Referente_Desospensione__c, ownerId, RecordTypeId, RecordType.developername,
                               EOF_Account_OLO__c,AccountId, EOF_Categoria_Guasto__c, EOF_Id_Risorsa__c, Description, Type, Subject, createddate,
                               EOF_Rip1__c, EOF_Rip2__c, EOF_Gpon_attestazione__c,EOF_ID_Splitter_Secondario__c, EOF_Posizione_Splitter_Secondario__c,
                               EOF_SLA_Premium_Assurance__c, assetId, Staging_retry__c from case where id=: caseid];
        System.debug('************** OF_TTM_EntryChecks.c.id = ' + OF_TTM_EntryChecks.c.id);
        
        OF_TTM_EntryChecks.sl =[SELECT Id, Caso__c, RecordTypeId,RecordType.developername,EOF_Codice_Comunicazione_OLO__c,EOF_Codice_Operatore__c,
                                EOF_Tipo_Comunicazione__c, EOF_Data_Notifica__c, EOF_ID_Notifica__c, EOF_Richiesta_Notifica__c, EOF_ID_Risorsa__c, EOF_Data_Ora_Inizio_Guasto__c, EOF_Data_Ora_Richiesta_Annullamento__c, 
                                EOF_Data_Ora_Desospensione__c, EOF_Data_Ora_Autoripristinato__c, EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c, EOF_Causale_Desospensione__c, EOF_Nome_Cliente__c, EOF_COgnome_CLiente__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                EOF_RECAPITO_TELEFONICO_CLIENTE_2__c, EOF_NOME_REFERENTE_TECNICO_OLO__c, EOF_TELEFONO_REFERENTE_TECNICO_OLO__c, EOF_EMAIL_REFERENTE_TECNICO_OLO__c, EOF_Referente_desospensione__c, EOF_Verifica_apparato_cliente__c,
                                EOF_Descrizione_Problema__c, EOF_NOTE_CLIENTE__c, EOF_Causale_Apertura__c, EOF_Intervento_Congiunto__c, EOF_Tec_OLO__c, EOF_Tel_Tec_OLO__c, EOF_ID_SERVIZIO__c, EOF_Data_Ora_Intervento_Congiunto__c,
                                EOF_Note__c, createddate, EOF_Codice_errore__c, EOF_Causale_errore__c,
                                //AA Campi aggiunti per callout ad OLO e TTM
                                EOF_Stato_Ticket__c, EOF_Data_Ora_Scarto__c, EOF_Data_Ora_Creazione__c, Causale_Scarto__c, EOF_Descrizione_Causale_Scarto__c,
                                EOF_Data_Ora_Notifica_Sospensione__c, EOF_Data_Ora_Notifica_Desospensione__c, EOF_Data_Ora_Notifica_Annullamento__c,
                                EOF_Data_Ora_Notifica_Chiusura__c, Causale_Sospensione__c, Descrizione_Evento_Risoluzione__c,
                                EOF_Rischedulazione_Appuntamento__c, EOF_Tec_Eof__c, EOF_Tel_Tec_Eof__c, EOF_Categoria_Guasto__c
                                FROM eof_eai_service_log__c 
                                WHERE id=:sLogId];
        
        
        
        list<case> case_tmp_list = [select id,EOF_Codice_Comunicazione_OLO__c,status, Eof_fase__c,EOF_codice_Operatore_WS__c,EOF_Data_Ora_Chiusura_Ticket__c, 
                                    EOF_Note__c, EOF_COmunicazioni_con_OLO__C, EOF_Data_ora_intervento_congiunto__c, Eof_tel_tec_olo__c, 
                                    EOF_Tec_Olo__c, EOF_Descrizione_Problema__c, Note_cliente__c, EOF_Collaudi_Negativi__c, EOF_Causale_Apertura__c,
                                    EOF_Intervento_Congiunto__c, EOF_Secondi_Sospesi_allo_SLA__c, EOF_Rischedulazione_Appuntamento__c, EOF_Data_Max_Risoluzione_Ticket__c,
                                    EOF_Minuti_rimanenti_sospesi__c, Data_ora_Autoripristinato__c, EOF_Contact__c, EOF_Causale_errore__c,
                                    EOF_Data_ora_RIchiesta_Annullamento__c, EOF_Causale_Richiesta_Annullamento__c,EOF_Causale_Desospensione__c,
                                    EOF_Data_ora_Desospensione__c, EOF_Referente_Desospensione__c, ownerId, RecordTypeId, RecordType.developername,
                                    EOF_Account_OLO__c,AccountId, EOF_Categoria_Guasto__c, EOF_Id_Risorsa__c, Description, Type, Subject, createddate,
                                    EOF_Rip1__c, EOF_Rip2__c, EOF_Gpon_attestazione__c,EOF_ID_Splitter_Secondario__c, EOF_Posizione_Splitter_Secondario__c,
                                    EOF_SLA_Premium_Assurance__c, assetId from case where EOF_Codice_Comunicazione_OLO__c =: OF_TTM_EntryChecks.c.EOF_Codice_Comunicazione_OLO__c];
        
        
        //check per causale scarto 1 (formato dati errato o incompleto)
        //il check sarà fatto in base al tipo comunicazione, in quanto se 1 allora il case sarà scartato, altrimenti non verrà effettuata alcuna
        //modifica sui case esistenti
        Group analisi = [SELECT Id FROM Group WHERE Name = 'Trouble Ticket - Coda Analisi' AND Type = 'Queue'];    
        
        List<Asset> a = [select Id,OF_GPON_Attestazione__c,createdDate,Status,recordtype.name, Accountid, Account.EOF_Codice_Operatore__c,
                         EOF_ID_Splitter_Secondario__c,EOF_Posizione_Splitter_Secondario__c,
                         EOF_SLA_Premium_Assurance__c from Asset where EOF_Id_Risorsa__c=:OF_TTM_EntryChecks.c.EOF_Id_Risorsa__c AND  Account.EOF_Codice_Operatore__c =: OF_TTM_EntryChecks.c.EOF_Codice_Operatore_WS__c LIMIT 1];
        
        if(OF_TTM_EntryChecks.sl.EOF_Tipo_Comunicazione__c =='1'){
            //Controllo sul referente tecnico obbligatorio 
            List<Contact> tech = [SELECT Id, Name, Phone, Email,Account.Name FROM Contact WHERE 
                                  LastName =: OF_TTM_EntryChecks.sl.EOF_NOME_REFERENTE_TECNICO_OLO__c AND Phone =: OF_TTM_EntryChecks.sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c AND Email =: OF_TTM_EntryChecks.sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__c 
                                  and recordtype.Name='Referente Tecnico OLO' LIMIT 1];  
            if(tech.isEmpty()){
            	system.debug('@@@@ tech is empty');
                recordtype techRt=[select Id from RecordType where Name='Referente Tecnico OLO'];
                OF_TTM_Utils.newTech = new Contact(LastName=OF_TTM_EntryChecks.sl.EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                   Phone=OF_TTM_EntryChecks.sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                   Email=OF_TTM_EntryChecks.sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__c,
                                                   AccountId=OF_TTM_EntryChecks.c.EOF_Account_OLO__c,
                                                   RecordTypeId=techRt.id
                                                  );
            }else{//TECH IS NOT EMPTY
            	system.debug('@@@@ tech is not empty');
                OF_TTM_EntryChecks.c.EOF_Contact__c = tech[0].Id;
            }//FINE ELSE TECH PRESENTE
            
            //Check per ID risorsa inesistente per tipo comunicazione 1
            if (a.isEmpty()){
                //approfitto della lista per fare il check della causale 3: ID RISORSA inesistente
                OF_TTM_EntryChecks.c.EOF_Causale_errore__c = 'ID Risorsa inesistente';
                OF_TTM_EntryChecks.c.Status = 'Scartato';
                OF_TTM_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                
                // Aggiungo la causale scarto, la descrizione, la data di scarto al log
                OF_TTM_EntryChecks.sl.EOF_Data_Ora_Scarto__c = OF_TTM_Utils.now();
                OF_TTM_EntryChecks.sl.EOF_Stato_Ticket__c = OF_TTM_Utils.getValueStatoTicket(OF_TTM_EntryChecks.c.Status);
                OF_TTM_EntryChecks.sl.Causale_Scarto__c ='3';
                OF_TTM_EntryChecks.sl.EOF_Descrizione_Causale_scarto__c = 'ID Risorsa inesistente';
                
                //Invio la notifica di scarto all'OLO
                OF_TTM_Utils.createNotifyCalloutToOLO(OF_TTM_EntryChecks.sl, '2');
                
                
                if (OF_TTM_Utils.responseDaOLO.equalsIgnoreCase('ACK')){
                    //In caso di ACK da parte di OLO, mi giro verso TTM e invio la notifica di richiesta TT scartata
                    OF_TTM_Utils.createTTRequestCalloutToTTM (OF_TTM_EntryChecks.sl, '99');
                    
                    //Inserisco il log della chiamata a olo e il log della response dell'OLO
                    OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                    //Salvo la response sul log
                    OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                    insert OF_TTM_Utils.sLogSFOLO;
                    
                    OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                    OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                    insert OF_TTM_Utils.sLogSFOLOResp;
                    
                    // inserisco il log della chiamata a TTM della response del TTM
                    OF_TTM_Utils.sLogSFTTM.Caso__c = OF_TTM_EntryChecks.c.id;
                    //Mi salvo sul log il valore della response da TTM, lo utilizzerò per il retry 
                    OF_TTM_Utils.sLogSFTTM.EOF_Response__c = OF_TTM_Utils.responseDaTTM;
                    if (OF_TTM_Utils.responseDaTTM.equalsIgnoreCase('NACK TECNICO')){
                        if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                            OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                        }else{
                            OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                        } 
                        //Salvo l'ordine di reinvio verso TTM
                        OF_TTM_Utils.sLogSFTTM.Ordine_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c;
                    }
                    insert OF_TTM_Utils.sLogSFTTM;
                    if (OF_TTM_Utils.sLogSFTTMResp != null){
                        OF_TTM_Utils.sLogSFTTMResp.Caso__c = OF_TTM_EntryChecks.c.id;
                        OF_TTM_Utils.sLogSFTTMResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFTTM.id;
                        insert OF_TTM_Utils.sLogSFTTMResp;
                    }
                    OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                    OF_TTM_EntryChecks.c.OF_Response_da_TTM__c = OF_TTM_Utils.responseDaTTM;
                    /*PRIMO BOOL inserimento acc
                      SECONDO BOOL inserimento contact
                      executeDML(boolean insAcc, boolean insCont)
                    */
                    executeDML(false, true);
                    update OF_TTM_EntryChecks.c;
                    //Se è una richiesta da portale, aggiorno lo stato del slog
                    if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                        updatePortalSLog(OF_TTM_EntryChecks.c);
                    }
                }else{
                    //In caso di NACK non chiamo TTM, ma gestisco la retry
                    //Inserisco il log della chiamata a olo e il log della response dell'OLO
                    OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                    //Salvo la response sul log
                    OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                    insert OF_TTM_Utils.sLogSFOLO;
                    
                    OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                    OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                    insert OF_TTM_Utils.sLogSFOLOResp;
                    
                    OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                    //In caso di NACK Tecnico aggiorno lo staging_retry
                    if(OF_TTM_Utils.responseDaOLO == 'NACK TECNICO'){
                        if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                            OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                        }else{
                            OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                        }
                    }
                    /*PRIMO BOOL inserimento acc
                      SECONDO BOOL inserimento contact
                      executeDML(boolean insAcc, boolean insCont)
                    */
                    executeDML(false, true);
                    update OF_TTM_EntryChecks.c;
                    //Se è una richiesta da portale, aggiorno lo stato del slog
                    if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                        updatePortalSLog(OF_TTM_EntryChecks.c);
                    }
                }
                return;            
            }else{//Caso in cui l'id risorsa è presente, proseguo con i controlli su di esso
                //check se la risorsa è attiva
                if (a[0].status!='Attivo'){
                    
                    String s = 'La risorsa risulta non attiva';
                    OF_TTM_EntryChecks.c.EOF_Causale_errore__c = s;
                    OF_TTM_EntryChecks.c.Status = 'Scartato';
                    OF_TTM_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                    
                    // Aggiungo la causale scarto, la descrizione, la data di scarto al log
                    OF_TTM_EntryChecks.sl.EOF_Data_Ora_Scarto__c = OF_TTM_Utils.now();
                    OF_TTM_EntryChecks.sl.EOF_Stato_Ticket__c = OF_TTM_Utils.getValueStatoTicket(OF_TTM_EntryChecks.c.Status);
                    OF_TTM_EntryChecks.sl.Causale_Scarto__c ='3';
                    OF_TTM_EntryChecks.sl.EOF_Descrizione_Causale_scarto__c = s;
                
                    //Invio la notifica di scarto all'OLO
                    OF_TTM_Utils.createNotifyCalloutToOLO(OF_TTM_EntryChecks.sl, '2');
                    
                    if (OF_TTM_Utils.responseDaOLO.equalsIgnoreCase('ACK')){
                        //In caso di ACK da parte di OLO, mi giro verso TTM e invio la notifica di richiesta TT scartata
                        OF_TTM_Utils.createTTRequestCalloutToTTM (OF_TTM_EntryChecks.sl, '99');
                        
                        //Inserisco il log della chiamata a olo e il log della response dell'OLO
                        OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                        //Salvo la response sul log
                        OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                        insert OF_TTM_Utils.sLogSFOLO;
                        
                        OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                        OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                        insert OF_TTM_Utils.sLogSFOLOResp;
                    
                        // inserisco il log della chiamata a TTM della response del TTM
                        OF_TTM_Utils.sLogSFTTM.Caso__c = OF_TTM_EntryChecks.c.id;    
                        //Mi salvo sul log il valore della response da TTM, lo utilizzerò per il retry 
                        OF_TTM_Utils.sLogSFTTM.EOF_Response__c = OF_TTM_Utils.responseDaTTM;
                        if (OF_TTM_Utils.responseDaTTM.equalsIgnoreCase('NACK TECNICO')){
                            if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                                OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                            }else{
                                OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                            } 
                            //Salvo l'ordine di reinvio verso TTM
                            OF_TTM_Utils.sLogSFTTM.Ordine_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c;
                        }         
                        insert OF_TTM_Utils.sLogSFTTM;
                        if (OF_TTM_Utils.sLogSFTTMResp != null){
                            OF_TTM_Utils.sLogSFTTMResp.Caso__c = OF_TTM_EntryChecks.c.id;
                            OF_TTM_Utils.sLogSFTTMResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFTTM.id;
                            insert OF_TTM_Utils.sLogSFTTMResp;
                        }
                        OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                        OF_TTM_EntryChecks.c.OF_Response_da_TTM__c = OF_TTM_Utils.responseDaTTM;
                        /*PRIMO BOOL inserimento acc
                          SECONDO BOOL inserimento contact
                          executeDML(boolean insAcc, boolean insCont)
                        */
                        executeDML(false, true);
                        update OF_TTM_EntryChecks.c;
                        //Se è una richiesta da portale, aggiorno lo stato del slog
                        if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                            updatePortalSLog(OF_TTM_EntryChecks.c);
                        }
                    }else{
                        //In caso di NACK non chiamo TTM, ma gestisco la retry
                        //Inserisco il log della chiamata a olo e il log della response dell'OLO
                        OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                        //Salvo la response sul log
                        OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                        insert OF_TTM_Utils.sLogSFOLO;
                        
                        OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                        OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                        insert OF_TTM_Utils.sLogSFOLOResp;
                        
                        OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                        //In caso di NACK Tecnico aggiorno lo staging_retry
                        if(OF_TTM_Utils.responseDaOLO == 'NACK TECNICO'){
                            if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                                OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                            }else{
                                OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                            }
                        }
                        /*PRIMO BOOL inserimento acc
                          SECONDO BOOL inserimento contact
                          executeDML(boolean insAcc, boolean insCont)
                        */
                        executeDML(false, true);
                        update OF_TTM_EntryChecks.c;
                        //Se è una richiesta da portale, aggiorno lo stato del slog
                        if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                            updatePortalSLog(OF_TTM_EntryChecks.c);
                        }
                    }
                    return;
                }
                //Check se la risorsa non è GPON
                if(String.isBlank(a[0].OF_GPON_Attestazione__c)){
                    
                    if(String.isBlank(OF_TTM_EntryChecks.sl.EOF_COgnome_CLiente__c)){
                        String s = 'Campo \'' + 'Cognome Cliente' + '\' non valorizzato obbligatorio per ID_RISORSA non GPON';
                        OF_TTM_EntryChecks.c.EOF_Causale_errore__c = s;
                        OF_TTM_EntryChecks.c.Status = 'Scartato';
                        OF_TTM_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                        
                        // Aggiungo la causale scarto, la descrizione, la data di scarto al log
                        OF_TTM_EntryChecks.sl.EOF_Data_Ora_Scarto__c = OF_TTM_Utils.now();
                        OF_TTM_EntryChecks.sl.EOF_Stato_Ticket__c = OF_TTM_Utils.getValueStatoTicket(OF_TTM_EntryChecks.c.Status);
                        OF_TTM_EntryChecks.sl.Causale_Scarto__c ='1';
                        OF_TTM_EntryChecks.sl.EOF_Descrizione_Causale_scarto__c = s;
                        
                        //Invio la notifica di scarto all'OLO
                        OF_TTM_Utils.createNotifyCalloutToOLO(OF_TTM_EntryChecks.sl, '2');
                        
                        if (OF_TTM_Utils.responseDaOLO.equalsIgnoreCase('ACK')){
                            //In caso di ACK da parte di OLO, mi giro verso TTM e invio la notifica di richiesta TT scartata
                            OF_TTM_Utils.createTTRequestCalloutToTTM (OF_TTM_EntryChecks.sl, '99');
                            
                            //Inserisco il log della chiamata a olo e il log della response dell'OLO
                            OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                            //Salvo la response sul log
                            OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                            insert OF_TTM_Utils.sLogSFOLO;
                            
                            OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                            OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                            insert OF_TTM_Utils.sLogSFOLOResp;
                            
                            // inserisco il log della chiamata a TTM della response del TTM
                            OF_TTM_Utils.sLogSFTTM.Caso__c = OF_TTM_EntryChecks.c.id;    
                            //Mi salvo sul log il valore della response da TTM, lo utilizzerò per il retry 
                            OF_TTM_Utils.sLogSFTTM.EOF_Response__c = OF_TTM_Utils.responseDaTTM;
                            if (OF_TTM_Utils.responseDaTTM.equalsIgnoreCase('NACK TECNICO')){
                                if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                                    OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                                }else{
                                    OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                                } 
                                //Salvo l'ordine di reinvio verso TTM
                                OF_TTM_Utils.sLogSFTTM.Ordine_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c;
                            }         
                            insert OF_TTM_Utils.sLogSFTTM;
                            if (OF_TTM_Utils.sLogSFTTMResp != null){
                                OF_TTM_Utils.sLogSFTTMResp.Caso__c = OF_TTM_EntryChecks.c.id;
                                OF_TTM_Utils.sLogSFTTMResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFTTM.id;
                                insert OF_TTM_Utils.sLogSFTTMResp;
                            }
                            OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                            OF_TTM_EntryChecks.c.OF_Response_da_TTM__c = OF_TTM_Utils.responseDaTTM;
                            /*PRIMO BOOL inserimento acc
                              SECONDO BOOL inserimento contact
                              executeDML(boolean insAcc, boolean insCont)
                            */
                            executeDML(false, true);
                            update OF_TTM_EntryChecks.c;
                            //Se è una richiesta da portale, aggiorno lo stato del slog
                            if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                                updatePortalSLog(OF_TTM_EntryChecks.c);
                            }
                        }else{
                            //In caso di NACK non chiamo TTM, ma gestisco la retry
                            //Inserisco il log della chiamata a olo e il log della response dell'OLO
                            OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                            //Salvo la response sul log
                            OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                            insert OF_TTM_Utils.sLogSFOLO;
                            
                            OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                            OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                            insert OF_TTM_Utils.sLogSFOLOResp;
                            
                            OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                            //In caso di NACK Tecnico aggiorno lo staging_retry
                            if(OF_TTM_Utils.responseDaOLO == 'NACK TECNICO'){
                                if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                                    OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                                }else{
                                    OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                                }
                            }
                            /*PRIMO BOOL inserimento acc
                              SECONDO BOOL inserimento contact
                              executeDML(boolean insAcc, boolean insCont)
                            */
                            executeDML(false, true);
                            update OF_TTM_EntryChecks.c;
                            //Se è una richiesta da portale, aggiorno lo stato del slog
                            if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                                updatePortalSLog(OF_TTM_EntryChecks.c);
                            }
                        }
                        return;
                    }
                    if(String.isBlank(OF_TTM_EntryChecks.sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c)){
                        String s = 'Campo \'' + 'RECAPITO_TELEFONICO_CLIENTE_1' + '\' non valorizzato obbligatorio per ID_RISORSA non GPON';
                        OF_TTM_EntryChecks.c.EOF_Causale_errore__c = s;
                        OF_TTM_EntryChecks.c.Status = 'Scartato';
                        OF_TTM_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                        
                        
                        // Aggiungo la causale scarto, la descrizione, la data di scarto al log
                        OF_TTM_EntryChecks.sl.EOF_Data_Ora_Scarto__c = OF_TTM_Utils.now();
                        OF_TTM_EntryChecks.sl.EOF_Stato_Ticket__c = OF_TTM_Utils.getValueStatoTicket(OF_TTM_EntryChecks.c.Status);
                        OF_TTM_EntryChecks.sl.Causale_Scarto__c ='1';
                        OF_TTM_EntryChecks.sl.EOF_Descrizione_Causale_scarto__c = s;
                        
                        //Invio la notifica di scarto all'OLO
                        OF_TTM_Utils.createNotifyCalloutToOLO(OF_TTM_EntryChecks.sl, '2');
                        
                        if (OF_TTM_Utils.responseDaOLO.equalsIgnoreCase('ACK')){
                            //In caso di ACK da parte di OLO, mi giro verso TTM e invio la notifica di richiesta TT scartata
                            OF_TTM_Utils.createTTRequestCalloutToTTM (OF_TTM_EntryChecks.sl, '99');
                            
                            //Inserisco il log della chiamata a olo e il log della response dell'OLO
                            OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                            //Salvo la response sul log
                            OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                            insert OF_TTM_Utils.sLogSFOLO;
                            
                            OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                            OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                            insert OF_TTM_Utils.sLogSFOLOResp;
                            
                            // inserisco il log della chiamata a TTM della response del TTM
                            OF_TTM_Utils.sLogSFTTM.Caso__c = OF_TTM_EntryChecks.c.id;      
                            //Mi salvo sul log il valore della response da TTM, lo utilizzerò per il retry 
                            OF_TTM_Utils.sLogSFTTM.EOF_Response__c = OF_TTM_Utils.responseDaTTM;
                            if (OF_TTM_Utils.responseDaTTM.equalsIgnoreCase('NACK TECNICO')){
                                if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                                    OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                                }else{
                                    OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                                } 
                                //Salvo l'ordine di reinvio verso TTM
                                OF_TTM_Utils.sLogSFTTM.Ordine_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c;
                            }       
                            insert OF_TTM_Utils.sLogSFTTM;
                            if (OF_TTM_Utils.sLogSFTTMResp != null){
                                OF_TTM_Utils.sLogSFTTMResp.Caso__c = OF_TTM_EntryChecks.c.id;
                                OF_TTM_Utils.sLogSFTTMResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFTTM.id;
                                insert OF_TTM_Utils.sLogSFTTMResp;
                            }
                            OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                            OF_TTM_EntryChecks.c.OF_Response_da_TTM__c = OF_TTM_Utils.responseDaTTM;
                            /*PRIMO BOOL inserimento acc
                              SECONDO BOOL inserimento contact
                              executeDML(boolean insAcc, boolean insCont)
                            */
                            executeDML(false, true);
                            update OF_TTM_EntryChecks.c;
                            //Se è una richiesta da portale, aggiorno lo stato del slog
                            if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                                updatePortalSLog(OF_TTM_EntryChecks.c);
                            }
                        }else{
                            //In caso di NACK non chiamo TTM, ma gestisco la retry
                            //Inserisco il log della chiamata a olo e il log della response dell'OLO
                            OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                            //Salvo la response sul log
                            OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                            insert OF_TTM_Utils.sLogSFOLO;
                            
                            OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                            OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                            insert OF_TTM_Utils.sLogSFOLOResp;
                            
                            OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                            //In caso di NACK Tecnico aggiorno lo staging_retry
                            if(OF_TTM_Utils.responseDaOLO == 'NACK TECNICO'){
                                if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                                    OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                                }else{
                                    OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                                }
                            }
                            /*PRIMO BOOL inserimento acc
                              SECONDO BOOL inserimento contact
                              executeDML(boolean insAcc, boolean insCont)
                            */
                            executeDML(false, true);
                            update OF_TTM_EntryChecks.c;
                            //Se è una richiesta da portale, aggiorno lo stato del slog
                            if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                                updatePortalSLog(OF_TTM_EntryChecks.c);
                            }
                        }
                        
                        return;
                    }
                    //Altri check sui campi e sul formato
                    if(OF_TTM_EntryChecks.sl.EOF_COgnome_CLiente__c.length()>255){
                        String s = 'Campo \'' + 'Cognome Cliente' + '\' non ammesso per ID_RISORSA non GPON';
                        OF_TTM_EntryChecks.c.EOF_Causale_errore__c = s;
                        OF_TTM_EntryChecks.c.Status = 'Scartato';
                        OF_TTM_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                        
                        // Aggiungo la causale scarto, la descrizione, la data di scarto al log
                        OF_TTM_EntryChecks.sl.EOF_Data_Ora_Scarto__c = OF_TTM_Utils.now();
                        OF_TTM_EntryChecks.sl.EOF_Stato_Ticket__c = OF_TTM_Utils.getValueStatoTicket(OF_TTM_EntryChecks.c.Status);
                        OF_TTM_EntryChecks.sl.Causale_Scarto__c ='1';
                        OF_TTM_EntryChecks.sl.EOF_Descrizione_Causale_scarto__c = s;
                        
                        //Invio la notifica di scarto all'OLO
                        OF_TTM_Utils.createNotifyCalloutToOLO(OF_TTM_EntryChecks.sl, '2');
                        
                        if (OF_TTM_Utils.responseDaOLO.equalsIgnoreCase('ACK')){
                            //In caso di ACK da parte di OLO, mi giro verso TTM e invio la notifica di richiesta TT scartata
                            OF_TTM_Utils.createTTRequestCalloutToTTM (OF_TTM_EntryChecks.sl, '99');
                            
                            //Inserisco il log della chiamata a olo e il log della response dell'OLO
                            OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                            //Salvo la response sul log
                            OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                            insert OF_TTM_Utils.sLogSFOLO;
                            
                            OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                            OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                            insert OF_TTM_Utils.sLogSFOLOResp;
                            
                            // inserisco il log della chiamata a TTM della response del TTM
                            OF_TTM_Utils.sLogSFTTM.Caso__c = OF_TTM_EntryChecks.c.id;        
                            //Mi salvo sul log il valore della response da TTM, lo utilizzerò per il retry 
                            OF_TTM_Utils.sLogSFTTM.EOF_Response__c = OF_TTM_Utils.responseDaTTM;
                            if (OF_TTM_Utils.responseDaTTM.equalsIgnoreCase('NACK TECNICO')){
                                if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                                    OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                                }else{
                                    OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                                } 
                                //Salvo l'ordine di reinvio verso TTM
                                OF_TTM_Utils.sLogSFTTM.Ordine_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c;
                            }     
                            insert OF_TTM_Utils.sLogSFTTM;
                            if(OF_TTM_Utils.sLogSFTTMResp != null){
                                OF_TTM_Utils.sLogSFTTMResp.Caso__c = OF_TTM_EntryChecks.c.id;
                                OF_TTM_Utils.sLogSFTTMResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFTTM.id;
                                insert OF_TTM_Utils.sLogSFTTMResp;
                            }
                            OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                            OF_TTM_EntryChecks.c.OF_Response_da_TTM__c = OF_TTM_Utils.responseDaTTM;
                            /*PRIMO BOOL inserimento acc
                              SECONDO BOOL inserimento contact
                              executeDML(boolean insAcc, boolean insCont)
                            */
                            executeDML(false, true);
                            update OF_TTM_EntryChecks.c;
                            //Se è una richiesta da portale, aggiorno lo stato del slog
                            if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                                updatePortalSLog(OF_TTM_EntryChecks.c);
                            }
                        }else{
                            //In caso di NACK non chiamo TTM, ma gestisco la retry
                            //Inserisco il log della chiamata a olo e il log della response dell'OLO
                            OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                            //Salvo la response sul log
                            OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                            insert OF_TTM_Utils.sLogSFOLO;
                            
                            OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                            OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                            insert OF_TTM_Utils.sLogSFOLOResp;
                            
                            OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                            //In caso di NACK Tecnico aggiorno lo staging_retry
                            if(OF_TTM_Utils.responseDaOLO == 'NACK TECNICO'){
                                if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                                    OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                                }else{
                                    OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                                }
                            }
                            /*PRIMO BOOL inserimento acc
                              SECONDO BOOL inserimento contact
                              executeDML(boolean insAcc, boolean insCont)
                            */
                            executeDML(false, true);
                            update OF_TTM_EntryChecks.c;
                            //Se è una richiesta da portale, aggiorno lo stato del slog
                            if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                                updatePortalSLog(OF_TTM_EntryChecks.c);
                            }
                        }
                        
                        return;
                    }
                    if(OF_TTM_EntryChecks.sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c.length()>50){
                        String s = 'Campo \'' + 'RECAPITO_TELEFONICO_CLIENTE_1' + '\' non ammesso per ID_RISORSA non GPON';
                        OF_TTM_EntryChecks.c.EOF_Causale_errore__c = s;
                        OF_TTM_EntryChecks.c.Status = 'Scartato';
                        OF_TTM_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                        
                        // Aggiungo la causale scarto, la descrizione, la data di scarto al log
                        OF_TTM_EntryChecks.sl.EOF_Data_Ora_Scarto__c = OF_TTM_Utils.now();
                        OF_TTM_EntryChecks.sl.EOF_Stato_Ticket__c = OF_TTM_Utils.getValueStatoTicket(OF_TTM_EntryChecks.c.Status);
                        OF_TTM_EntryChecks.sl.Causale_Scarto__c ='1';
                        OF_TTM_EntryChecks.sl.EOF_Descrizione_Causale_scarto__c = s;
                        
                        //Invio la notifica di scarto all'OLO
                        OF_TTM_Utils.createNotifyCalloutToOLO(OF_TTM_EntryChecks.sl, '2');
                        
                        if (OF_TTM_Utils.responseDaOLO.equalsIgnoreCase('ACK')){
                            //In caso di ACK da parte di OLO, mi giro verso TTM e invio la notifica di richiesta TT scartata
                            OF_TTM_Utils.createTTRequestCalloutToTTM (OF_TTM_EntryChecks.sl, '99');
                            
                            //Inserisco il log della chiamata a olo e il log della response dell'OLO
                            OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                            //Salvo la response sul log
                            OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                            insert OF_TTM_Utils.sLogSFOLO;
                            
                            OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                            OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                            insert OF_TTM_Utils.sLogSFOLOResp;
                            
                            // inserisco il log della chiamata a TTM della response del TTM
                            OF_TTM_Utils.sLogSFTTM.Caso__c = OF_TTM_EntryChecks.c.id;     
                            //Mi salvo sul log il valore della response da TTM, lo utilizzerò per il retry 
                            OF_TTM_Utils.sLogSFTTM.EOF_Response__c = OF_TTM_Utils.responseDaTTM;
                            if (OF_TTM_Utils.responseDaTTM.equalsIgnoreCase('NACK TECNICO')){
                                if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                                    OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                                }else{
                                    OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                                } 
                                //Salvo l'ordine di reinvio verso TTM
                                OF_TTM_Utils.sLogSFTTM.Ordine_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c;
                            }        
                            insert OF_TTM_Utils.sLogSFTTM;
                            if(OF_TTM_Utils.sLogSFTTMResp != null){
                                OF_TTM_Utils.sLogSFTTMResp.Caso__c = OF_TTM_EntryChecks.c.id;
                                OF_TTM_Utils.sLogSFTTMResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFTTM.id;
                                insert OF_TTM_Utils.sLogSFTTMResp;
                            }
                            OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                            OF_TTM_EntryChecks.c.OF_Response_da_TTM__c = OF_TTM_Utils.responseDaTTM;
                            /*PRIMO BOOL inserimento acc
                              SECONDO BOOL inserimento contact
                              executeDML(boolean insAcc, boolean insCont)
                            */
                            executeDML(false, true);
                            update OF_TTM_EntryChecks.c;
                            //Se è una richiesta da portale, aggiorno lo stato del slog
                            if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                                updatePortalSLog(OF_TTM_EntryChecks.c);
                            }
                        }else{
                            //In caso di NACK non chiamo TTM, ma gestisco la retry
                            //Inserisco il log della chiamata a olo e il log della response dell'OLO
                            OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                            //Salvo la response sul log
                            OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                            insert OF_TTM_Utils.sLogSFOLO;
                            
                            OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                            OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                            insert OF_TTM_Utils.sLogSFOLOResp;
                            
                            OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                            //In caso di NACK Tecnico aggiorno lo staging_retry
                            if(OF_TTM_Utils.responseDaOLO == 'NACK TECNICO'){
                                if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                                    OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                                }else{
                                    OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                                }
                            }
                            /*PRIMO BOOL inserimento acc
                              SECONDO BOOL inserimento contact
                              executeDML(boolean insAcc, boolean insCont)
                            */
                            executeDML(false, true);
                            update OF_TTM_EntryChecks.c;
                            //Se è una richiesta da portale, aggiorno lo stato del slog
                            if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                                updatePortalSLog(OF_TTM_EntryChecks.c);
                            }
                        }
                        
                        return;
                    }
                }
                
                if(String.isNotBlank(OF_TTM_EntryChecks.sl.EOF_COgnome_CLiente__c) && String.isNotBlank(OF_TTM_EntryChecks.sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c)){
                    List<Account> listAcc;  
                    if(String.isBlank(OF_TTM_EntryChecks.sl.eof_nome_cliente__c)){
                        listAcc = [select Id from Account where Name=:OF_TTM_EntryChecks.sl.EOF_COgnome_CLiente__c
                                   and Phone=:OF_TTM_EntryChecks.sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c];
                    }else{
                        listAcc = [select Id from Account where LastName=:OF_TTM_EntryChecks.sl.EOF_COgnome_CLiente__c
                                   and Phone=:OF_TTM_EntryChecks.sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c];
                    }
                    if(listAcc.isEmpty()){
                        if(String.isBlank(OF_TTM_EntryChecks.sl.eof_nome_cliente__c)){                        
                            Recordtype rt = [SELECT Id FROM RecordType WHERE Name = 'Cliente Business'];
                            OF_TTM_Utils.newAcc = new Account(Name = OF_TTM_EntryChecks.sl.EOF_COgnome_CLiente__c,
                                                              RecordTypeId = rt.id,
                                                              Phone = OF_TTM_EntryChecks.sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                                              EOF_Phone_2__c = OF_TTM_EntryChecks.sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                              EOF_Codice_Operatore__c=OF_TTM_EntryChecks.sl.EOF_Codice_Operatore__c);
                        }else{
                            Recordtype rt = [SELECT Id FROM RecordType WHERE Name = 'Person Account'];
                            OF_TTM_Utils.newAcc = new Account(FirstName = OF_TTM_EntryChecks.sl.eof_nome_cliente__c,
                                                              LastName = OF_TTM_EntryChecks.sl.EOF_COgnome_CLiente__c,
                                                              RecordTypeId = rt.id,
                                                              Phone = OF_TTM_EntryChecks.sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,                                                           
                                                              EOF_Phone_2__c = OF_TTM_EntryChecks.sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                              EOF_Codice_Operatore__c=OF_TTM_EntryChecks.sl.EOF_Codice_Operatore__c);
                        }
                    }else{//List acc is not empty
                        OF_TTM_EntryChecks.c.AccountId=listAcc[0].Id;
                    }
                }
            }
            //check per causale scarto 2 (ticket aperto per stesso ID risorsa) da rivedere (commentiamo)
            List<Case> checkIfOpen =[select Id from Case where assetId=:a[0].Id AND RecordType.Name='Trouble Ticket'
                                     AND Status!='Annullato' AND Status!='Scartato' AND Status!='Chiuso'];
            
            if (!checkIfOpen.isEmpty()){
                OF_TTM_EntryChecks.c.EOF_Causale_errore__c = 'Ticket aperto per stesso ID risorsa';
                OF_TTM_EntryChecks.c.Status = 'Scartato';
                OF_TTM_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                
                // Aggiungo la causale scarto, la descrizione, la data di scarto al log
                OF_TTM_EntryChecks.sl.EOF_Data_Ora_Scarto__c = OF_TTM_Utils.now();
                OF_TTM_EntryChecks.sl.EOF_Stato_Ticket__c = OF_TTM_Utils.getValueStatoTicket(OF_TTM_EntryChecks.c.Status);
                OF_TTM_EntryChecks.sl.Causale_Scarto__c ='2';
                OF_TTM_EntryChecks.sl.EOF_Descrizione_Causale_scarto__c = 'Ticket aperto per stesso ID risorsa';
                
                //Invio la notifica di scarto all'OLO
                OF_TTM_Utils.createNotifyCalloutToOLO(OF_TTM_EntryChecks.sl, '2');
                
                if (OF_TTM_Utils.responseDaOLO.equalsIgnoreCase('ACK')){
                    //In caso di ACK da parte di OLO, mi giro verso TTM e invio la notifica di richiesta TT scartata
                    OF_TTM_Utils.createTTRequestCalloutToTTM (OF_TTM_EntryChecks.sl, '99');
                    
                    //Inserisco il log della chiamata a olo e il log della response dell'OLO
                    OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                    //Salvo la response sul log
                    OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                    insert OF_TTM_Utils.sLogSFOLO;
                    
                    OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                    OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                    insert OF_TTM_Utils.sLogSFOLOResp;
                    // inserisco il log della chiamata a TTM della response del TTM
                    OF_TTM_Utils.sLogSFTTM.Caso__c = OF_TTM_EntryChecks.c.id;  
                    //Mi salvo sul log il valore della response da TTM, lo utilizzerò per il retry 
                    OF_TTM_Utils.sLogSFTTM.EOF_Response__c = OF_TTM_Utils.responseDaTTM;
                    if (OF_TTM_Utils.responseDaTTM.equalsIgnoreCase('NACK TECNICO')){
                        if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                            OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                        }else{
                            OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                        } 
                        //Salvo l'ordine di reinvio verso TTM
                        OF_TTM_Utils.sLogSFTTM.Ordine_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c;
                    }           
                    insert OF_TTM_Utils.sLogSFTTM;
                    if(OF_TTM_Utils.sLogSFTTMResp != null){
                        OF_TTM_Utils.sLogSFTTMResp.Caso__c = OF_TTM_EntryChecks.c.id;
                        OF_TTM_Utils.sLogSFTTMResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFTTM.id;
                        insert OF_TTM_Utils.sLogSFTTMResp;
                    }
                    OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                    OF_TTM_EntryChecks.c.OF_Response_da_TTM__c = OF_TTM_Utils.responseDaTTM;
                    /*PRIMO BOOL inserimento acc
                      SECONDO BOOL inserimento contact
                      executeDML(boolean insAcc, boolean insCont)
                    */
                    executeDML(true, true);
                    update OF_TTM_EntryChecks.c;
                    //Se è una richiesta da portale, aggiorno lo stato del slog
                    if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                        updatePortalSLog(OF_TTM_EntryChecks.c);
                    }
                }else{
                    //In caso di NACK non chiamo TTM, ma gestisco la retry
                    //Inserisco il log della chiamata a olo e il log della response dell'OLO
                    OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                    //Salvo la response sul log
                    OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                    insert OF_TTM_Utils.sLogSFOLO;
                    
                    OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                    OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                    insert OF_TTM_Utils.sLogSFOLOResp;
                    
                    OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                    //In caso di NACK Tecnico aggiorno lo staging_retry
                    if(OF_TTM_Utils.responseDaOLO == 'NACK TECNICO'){
                        if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                            OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                        }else{
                            OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                        }
                    }
                    /*PRIMO BOOL inserimento acc
                      SECONDO BOOL inserimento contact
                      executeDML(boolean insAcc, boolean insCont)
                    */
                    executeDML(true, true);
                    update OF_TTM_EntryChecks.c;
                    //Se è una richiesta da portale, aggiorno lo stato del slog
                    if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                        updatePortalSLog(OF_TTM_EntryChecks.c);
                    }
                }
                
                return;
            }
            
            //check per causale scarto 4
            if (!case_tmp_list.isEmpty() && case_tmp_list.size() >1){
                OF_TTM_EntryChecks.c.EOF_Causale_errore__c = 'Codice Comunicazione OLO già presente';
                OF_TTM_EntryChecks.c.Status = 'Scartato';
                OF_TTM_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                
                // Aggiungo la causale scarto, la descrizione, la data di scarto al log
                OF_TTM_EntryChecks.sl.EOF_Data_Ora_Scarto__c = OF_TTM_Utils.now();
                OF_TTM_EntryChecks.sl.EOF_Stato_Ticket__c = OF_TTM_Utils.getValueStatoTicket(OF_TTM_EntryChecks.c.Status);
                OF_TTM_EntryChecks.sl.Causale_Scarto__c ='4';
                OF_TTM_EntryChecks.sl.EOF_Descrizione_Causale_scarto__c = 'Codice Comunicazione OLO già presente';
            
                //Invio la notifica di scarto all'OLO
                OF_TTM_Utils.createNotifyCalloutToOLO(OF_TTM_EntryChecks.sl, '2');
                
                if (OF_TTM_Utils.responseDaOLO.equalsIgnoreCase('ACK')){
                    //In caso di ACK da parte di OLO, mi giro verso TTM e invio la notifica di richiesta TT scartata
                    OF_TTM_Utils.createTTRequestCalloutToTTM (OF_TTM_EntryChecks.sl, '99');
                    
                    //Inserisco il log della chiamata a olo e il log della response dell'OLO
                    OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                    //Salvo la response sul log
                    OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                    insert OF_TTM_Utils.sLogSFOLO;
                    
                    OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                    OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                    insert OF_TTM_Utils.sLogSFOLOResp;
                    
                    // inserisco il log della chiamata a TTM della response del TTM
                    OF_TTM_Utils.sLogSFTTM.Caso__c = OF_TTM_EntryChecks.c.id;     
                    //Mi salvo sul log il valore della response da TTM, lo utilizzerò per il retry 
                    OF_TTM_Utils.sLogSFTTM.EOF_Response__c = OF_TTM_Utils.responseDaTTM;
                    if (OF_TTM_Utils.responseDaTTM.equalsIgnoreCase('NACK TECNICO')){
                        if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                            OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                        }else{
                            OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                        } 
                        //Salvo l'ordine di reinvio verso TTM
                        OF_TTM_Utils.sLogSFTTM.Ordine_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c;
                    }        
                    insert OF_TTM_Utils.sLogSFTTM;
                    if(OF_TTM_Utils.sLogSFTTMResp != null){
                        OF_TTM_Utils.sLogSFTTMResp.Caso__c = OF_TTM_EntryChecks.c.id;
                        OF_TTM_Utils.sLogSFTTMResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFTTM.id;
                        insert OF_TTM_Utils.sLogSFTTMResp;
                    }
                    OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                    OF_TTM_EntryChecks.c.OF_Response_da_TTM__c = OF_TTM_Utils.responseDaTTM;
                    /*PRIMO BOOL inserimento acc
                      SECONDO BOOL inserimento contact
                      executeDML(boolean insAcc, boolean insCont)
                    */
                    executeDML(true, true);
                    update OF_TTM_EntryChecks.c;
                    //Se è una richiesta da portale, aggiorno lo stato del slog
                    if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                        updatePortalSLog(OF_TTM_EntryChecks.c);
                    }
                }else{
                    //In caso di NACK non chiamo TTM, ma gestisco la retry
                    //Inserisco il log della chiamata a olo e il log della response dell'OLO
                    OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                    //Salvo la response sul log
                    OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                    insert OF_TTM_Utils.sLogSFOLO;
                    
                    OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                    OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                    insert OF_TTM_Utils.sLogSFOLOResp;
                    
                    OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                    //In caso di NACK Tecnico aggiorno lo staging_retry
                    if(OF_TTM_Utils.responseDaOLO == 'NACK TECNICO'){
                        if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                            OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                        }else{
                            OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                        }
                    }
                    /*PRIMO BOOL inserimento acc
                      SECONDO BOOL inserimento contact
                      executeDML(boolean insAcc, boolean insCont)
                    */
                    executeDML(true, true);
                    update OF_TTM_EntryChecks.c;
                    //Se è una richiesta da portale, aggiorno lo stato del slog
                    if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                        updatePortalSLog(OF_TTM_EntryChecks.c);
                    }
                }
                
                return;
            }
            
            //check per causale scarto 5 (da rivedere) Guasto Aperto come Post-Provisioning oltre i termini previsti
            if(OF_TTM_EntryChecks.c.eof_categoria_guasto__c=='Post Provisioning' && a[0].createdDate< Date.today().addDays(-10)){
                OF_TTM_EntryChecks.c.EOF_Causale_errore__c = 'Guasto Aperto come Post-Provisioning oltre i termini previsti';
                OF_TTM_EntryChecks.c.Status = 'Scartato';
                OF_TTM_EntryChecks.c.EOF_Data_Ora_Chiusura_Ticket__c=OF_TTM_Utils.now();
                
                // Aggiungo la causale scarto, la descrizione, la data di scarto al log
                OF_TTM_EntryChecks.sl.EOF_Data_Ora_Scarto__c = OF_TTM_Utils.now();
                OF_TTM_EntryChecks.sl.EOF_Stato_Ticket__c = OF_TTM_Utils.getValueStatoTicket(OF_TTM_EntryChecks.c.Status);
                OF_TTM_EntryChecks.sl.Causale_Scarto__c ='5';
                OF_TTM_EntryChecks.sl.EOF_Descrizione_Causale_scarto__c = 'Guasto Aperto come Post-Provisioning oltre i termini previsti';
                
                //Invio la notifica di scarto all'OLO
                OF_TTM_Utils.createNotifyCalloutToOLO(OF_TTM_EntryChecks.sl, '2');
                
                if (OF_TTM_Utils.responseDaOLO.equalsIgnoreCase('ACK')){//Effettuo la callout verso TTM
                    //In caso di ACK da parte di OLO, mi giro verso TTM e invio la notifica di richiesta TT scartata
                    OF_TTM_Utils.createTTRequestCalloutToTTM (OF_TTM_EntryChecks.sl, '99');
                    
                    //Inserisco il log della chiamata a olo e il log della response dell'OLO
                    OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                    //Salvo la response sul log
                    OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                    insert OF_TTM_Utils.sLogSFOLO;
                    
                    OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                    OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                    insert OF_TTM_Utils.sLogSFOLOResp;
                    
                    // inserisco il log della chiamata a TTM della response del TTM
                    OF_TTM_Utils.sLogSFTTM.Caso__c = OF_TTM_EntryChecks.c.id;    
                    //Mi salvo sul log il valore della response da TTM, lo utilizzerò per il retry 
                    OF_TTM_Utils.sLogSFTTM.EOF_Response__c = OF_TTM_Utils.responseDaTTM;
                    if (OF_TTM_Utils.responseDaTTM.equalsIgnoreCase('NACK TECNICO')){
                        if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                            OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                        }else{
                            OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                        } 
                        //Salvo l'ordine di reinvio verso TTM
                        OF_TTM_Utils.sLogSFTTM.Ordine_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c;
                    }         
                    insert OF_TTM_Utils.sLogSFTTM;
                    if (OF_TTM_Utils.sLogSFTTMResp != null){
                        OF_TTM_Utils.sLogSFTTMResp.Caso__c = OF_TTM_EntryChecks.c.id;
                        OF_TTM_Utils.sLogSFTTMResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFTTM.id;
                        insert OF_TTM_Utils.sLogSFTTMResp;
                    }
                    OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                    OF_TTM_EntryChecks.c.OF_Response_da_TTM__c = OF_TTM_Utils.responseDaTTM;
                    /*PRIMO BOOL inserimento acc
                      SECONDO BOOL inserimento contact
                      executeDML(boolean insAcc, boolean insCont)
                    */
                    executeDML(true, true);
                    update OF_TTM_EntryChecks.c;
                    //Se è una richiesta da portale, aggiorno lo stato del slog
                    if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                        updatePortalSLog(OF_TTM_EntryChecks.c);
                    }
                }else{//In caso di NACK non chiamo TTM, ma gestisco la retry
                    //Inserisco il log della chiamata a olo e il log della response dell'OLO
                    OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                    //Salvo la response sul log
                    OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                    insert OF_TTM_Utils.sLogSFOLO;
                    
                    OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                    OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                    insert OF_TTM_Utils.sLogSFOLOResp;
                    
                    OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                    //In caso di NACK Tecnico aggiorno lo staging_retry
                    if(OF_TTM_Utils.responseDaOLO == 'NACK TECNICO'){
                        if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                            OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                        }else{
                            OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                        }
                    }
                    /*PRIMO BOOL inserimento acc
                      SECONDO BOOL inserimento contact
                      executeDML(boolean insAcc, boolean insCont)
                    */
                    executeDML(true, true);
                    update OF_TTM_EntryChecks.c;
                    //Se è una richiesta da portale, aggiorno lo stato del slog
                    if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                        updatePortalSLog(OF_TTM_EntryChecks.c);
                    }
                }
                
                return;
            }
            
            //2017_04_18 nuova logica 
            Integer numCaseRip1=0;
            Integer numCaseRip2=0;
            List<Recordtype> recordtypeTT = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
            
            if(OF_TT_Parametri__c.getInstance().EOF_Giorni_Rip2__c != null && !recordtypeTT.isEmpty()){
                
                Date Rip2 = Date.Today().addDays(Integer.valueOf((OF_TT_Parametri__c.getInstance().EOF_Giorni_Rip2__c) * (-1)) );
                //FIX Team Napoli - 30-03 Aggiunto filtro recordType sulla query - START
                numCaseRip2 = [select count() 
                               from Case 
                               where ClosedDate >= :Rip2 
                               AND recordTypeId =: recordtypeTT.get(0).id
                               AND assetId=:a[0].Id];
                //FIX Team Napoli - 30-03 - END
            }
            
            if(OF_TT_Parametri__c.getInstance().EOF_Giorni_Rip1__c != null && !recordtypeTT.isEmpty()){
                Date Rip1 = Date.Today().addDays(Integer.valueOf((OF_TT_Parametri__c.getInstance().EOF_Giorni_Rip1__c) * (-1) ));
                //FIX Team Napoli - 30-03 Aggiunto filtro recordType sulla query - START
                numCaseRip1 = [select count() 
                               from Case 
                               where ClosedDate >= :Rip1 
                               AND recordTypeId =: recordtypeTT.get(0).id
                               AND assetId=:a[0].Id];
                //FIX Team Napoli - 30-03 - END
            }
            //implementiamo la logica di calcolo Ticket sulla stessa risorsa 
            OF_TTM_EntryChecks.c.EOF_Rip1__c=numCaseRip1;
            OF_TTM_EntryChecks.c.EOF_Rip2__c=numCaseRip2;
            OF_TTM_EntryChecks.c.EOF_Gpon_attestazione__c=a[0].OF_GPON_Attestazione__c;
            OF_TTM_EntryChecks.c.EOF_ID_Splitter_Secondario__c=a[0].EOF_ID_Splitter_Secondario__c;
            OF_TTM_EntryChecks.c.EOF_Posizione_Splitter_Secondario__c=a[0].EOF_Posizione_Splitter_Secondario__c;
            OF_TTM_EntryChecks.c.EOF_SLA_Premium_Assurance__c=a[0].EOF_SLA_Premium_Assurance__c;
            //qui andrà la logica di popolamento della due date e del tempo rimanente, da vedere dove estrarre se SLA o meno
            boolean premium = false;
            if(a[0].EOF_Sla_Premium_Assurance__c=='Y'){
                premium=true;
            }
            OF_TTM_EntryChecks.c.EOF_Data_Max_Risoluzione_Ticket__c=OF_TTM_Utils.calcoloSLA(premium);      
            //controlli asincroni per tipo comunicazione 1 OK, check su quelli opzionali
            OF_TTM_EntryChecks.c.EOF_Data_Ora_Inizio_Guasto__c = OF_TTM_EntryChecks.sl.EOF_Data_Ora_Inizio_Guasto__c;
            OF_TTM_EntryChecks.c.EOF_Verifica_apparato_cliente__c = OF_TTM_EntryChecks.sl.EOF_Verifica_apparato_cliente__c;
            OF_TTM_EntryChecks.c.EOF_Descrizione_Problema__c = OF_TTM_EntryChecks.sl.EOF_Descrizione_Problema__c;
            OF_TTM_EntryChecks.c.Note_Cliente__c = OF_TTM_EntryChecks.sl.EOF_NOTE_CLIENTE__c;
            // 15/02/2018 MM : taglio campo note se > 255
            if(string.isnotblank(OF_TTM_EntryChecks.sl.EOF_Note__c) && OF_TTM_EntryChecks.sl.EOF_Note__c!=null){
                OF_TTM_EntryChecks.c.EOF_Note__c = OF_TTM_EntryChecks.sl.EOF_Note__c.abbreviate(255);
            }
            else{
                OF_TTM_EntryChecks.c.EOF_Note__c = OF_TTM_EntryChecks.sl.EOF_Note__c;
            }
            // finisce qui 
            OF_TTM_EntryChecks.c.status='In Lavorazione';
            OF_TTM_EntryChecks.c.eof_fase__c='Da Lavorare';
            OF_TTM_EntryChecks.c.assetId=a[0].id;
            /*if(String.isNotBlank(OF_TTM_EntryChecks.sl.EOF_Note__c)){
                OF_TTM_EntryChecks.c.EOF_COmunicazioni_con_OLO__C=OF_TTM_Utils.DateToString(OF_TTM_Utils.now()).left(19)+' - '+ OF_TTM_EntryChecks.sl.EOF_Tipo_Comunicazione__c +' - '+userinfo.getName()+':\n'+OF_TTM_EntryChecks.sl.EOF_Note__c;
            }*/
            //CASO IN CUI LA RICHIESTA HA SUPERATO TUTTI I CHECK
            
            // 2018-12-21 MM : in caso di Presa in carico, inserisco sul log di presa in carico  i campi stato ticket e data creazione del ticket OLO
            OF_TTM_EntryChecks.sl.EOF_Stato_Ticket__c = OF_TTM_Utils.getValueStatoTicket(OF_TTM_EntryChecks.c.Status);
            OF_TTM_EntryChecks.sl.EOF_Data_Ora_Creazione__c = OF_TTM_EntryChecks.c.createddate;
            
            //Invio la notifica di presa in carico
            OF_TTM_Utils.createNotifyCalloutToOLO(OF_TTM_EntryChecks.sl, '3');
            
            if (OF_TTM_Utils.responseDaOLO.equalsIgnoreCase('ACK')){
                //In caso di ACK da parte di OLO, mi giro verso TTM e invio la richiesta TT 
                OF_TTM_Utils.createTTRequestCalloutToTTM (OF_TTM_EntryChecks.sl, '1');
                
                //Inserisco il log della chiamata a olo e il log della response dell'OLO
                OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                //Salvo la response sul log
                OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                insert OF_TTM_Utils.sLogSFOLO;
                
                OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                insert OF_TTM_Utils.sLogSFOLOResp;

                // inserisco il log della chiamata a TTM della response del TTM
                OF_TTM_Utils.sLogSFTTM.Caso__c = OF_TTM_EntryChecks.c.id;   
                //Mi salvo sul log il valore della response da TTM, lo utilizzerò per il retry 
                OF_TTM_Utils.sLogSFTTM.EOF_Response__c = OF_TTM_Utils.responseDaTTM;
                if (OF_TTM_Utils.responseDaTTM.equalsIgnoreCase('NACK TECNICO')){
                    if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                        OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                    }else{
                        OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                    } 
                    //Salvo l'ordine di reinvio verso TTM
                    OF_TTM_Utils.sLogSFTTM.Ordine_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c;
                }          
                insert OF_TTM_Utils.sLogSFTTM;
                if(OF_TTM_Utils.sLogSFTTMResp != null){
                    OF_TTM_Utils.sLogSFTTMResp.Caso__c = OF_TTM_EntryChecks.c.id;
                    OF_TTM_Utils.sLogSFTTMResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFTTM.id;
                    insert OF_TTM_Utils.sLogSFTTMResp;
                }
                OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                OF_TTM_EntryChecks.c.OF_Response_da_TTM__c = OF_TTM_Utils.responseDaTTM;
                /*PRIMO BOOL inserimento acc
                  SECONDO BOOL inserimento contact
                  executeDML(boolean insAcc, boolean insCont)
                */
                executeDML(true, true);
                update OF_TTM_EntryChecks.c;
                //Se è una richiesta da portale, aggiorno lo stato del slog
                if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                    updatePortalSLog(OF_TTM_EntryChecks.c);
                }
            }else{
                //In caso di NACK non chiamo TTM, ma gestisco la retry
                //Inserisco il log della chiamata a olo e il log della response dell'OLO
                OF_TTM_Utils.sLOGSFOLO.caso__c = OF_TTM_EntryChecks.c.id;
                //Salvo la response sul log
                OF_TTM_Utils.sLOGSFOLO.EOF_Response__c = OF_TTM_Utils.responseDaOLO;
                insert OF_TTM_Utils.sLogSFOLO;
                
                OF_TTM_Utils.SLogSFOLOResp.Caso__c = OF_TTM_EntryChecks.c.id;
                OF_TTM_Utils.SlogSFOLOResp.EOF_SL_Riferimento__c = OF_TTM_Utils.sLogSFOLO.id;
                insert OF_TTM_Utils.sLogSFOLOResp;
                
                OF_TTM_EntryChecks.c.OF_Response_Da_OLO__c = OF_TTM_Utils.responseDaOLO;
                //In caso di NACK Tecnico aggiorno lo staging_retry
                if(OF_TTM_Utils.responseDaOLO == 'NACK TECNICO'){
                    if (OF_TTM_EntryChecks.c.Staging_retry__c != null && OF_TTM_EntryChecks.c.Staging_retry__c != 0){
                        OF_TTM_EntryChecks.c.Staging_retry__c = OF_TTM_EntryChecks.c.Staging_retry__c + 1;
                    }else{
                        OF_TTM_EntryChecks.c.Staging_retry__c = 1;
                    }
                }
                /*PRIMO BOOL inserimento acc
                  SECONDO BOOL inserimento contact
                  executeDML(boolean insAcc, boolean insCont)
                */
                executeDML(true, true);
                update OF_TTM_EntryChecks.c;
                //Se è una richiesta da portale, aggiorno lo stato del slog
                if (OF_TTM_EntryChecks.c.PO_TT_Portale__c){
                    updatePortalSLog(OF_TTM_EntryChecks.c);
                }
            } 
            return;
        }
    }
    //Metodo per eseguire le insert senza doverle scrivere ogni volta
    private static void executeDML(boolean insAcc, boolean insCont){
        if (insAcc){
            if (OF_TTM_Utils.newAcc != null){
            	system.debug('@@@@@ account: '+OF_TTM_Utils.newAcc);
                insert OF_TTM_Utils.newAcc;
                OF_TTM_EntryChecks.c.AccountId = OF_TTM_Utils.newAcc.Id;
            }
        }
        if (insCont){
            if (OF_TTM_Utils.newTech != null && !String.isBlank(OF_TTM_Utils.newTech.lastName)){
            	system.debug('@@@@@ il contact è: '+OF_TTM_Utils.newTech);
                upsert OF_TTM_Utils.newTech;
                OF_TTM_EntryChecks.c.EOF_Contact__c = OF_TTM_Utils.newTech.Id;
            }
        }
    }
        //Metodo per aggiornare il slog del portale
    @TestVisible
    private static void updatePortalSLog(Case caseTT){
        EOF_EAI_Service_Log__c slogPortale = [SELECT Id, EOF_Stato_Ordine__c
                                              FROM EOF_EAI_Service_Log__c
                                              WHERE EOF_Codice_Comunicazione_OLO__c = :caseTT.EOF_Codice_Comunicazione_OLO__c
                                              AND EOF_Stato_Richiesta__c='Inserita Portale'
                                              AND EOF_Codice_ordine_eof__c = :caseTT.Id
                                              LIMIT 1];
        slogPortale.EOF_Stato_Ordine__c = caseTT.Status;
        if(caseTT.Status.equalsIgnoreCase('Scartato')){
            slogPortale.EOF_Descrizione_Causale_scarto__c = caseTT.EOF_Causale_errore__c;
            slogPortale.EOF_Data_Ora_Scarto__c = OF_TTM_Utils.now();
            slogPortale.Causale_Scarto__c = OF_TTM_Utils.getValueCausaleScarto(caseTT.EOF_Causale_errore__c);
        }
        update slogPortale;
    }
    
   
}
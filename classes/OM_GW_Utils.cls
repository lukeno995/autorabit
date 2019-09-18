public class OM_GW_Utils {  
         //�                                                                         
    public static String idNotify{get;set;}
    public static EOF_GW_WS_Request.returnFiberResponse res_temp;   
    public static List<String> result = new List<String>();
    
    public static EOF_GW_WS_Request.returnFiberResponse checkSync(EOF_GW_WS_Request.FiberRequest fr){
                
        res_temp = new EOF_GW_WS_Request.returnFiberResponse(); 
        res_temp.Esito = '0';
        res_temp.CodiceErrore = '';
        res_temp.CausaleErrore = '';  
        
        //ACK fittizio in caso di reinvio notifica per sbloccare OLO
        if(String.isNotBlank(fr.codice_ordine_olo) && String.isNotBlank(fr.id_notifica) && (fr.tipo_comunicazione=='1' || fr.tipo_comunicazione=='11')){
            //List<Case> cList = [select id from case where EOF_COdice_ordine_olo__c=:fr.codice_ordine_olo and EOF_Id_Notifica__c=:fr.id_notifica];
            if (OM_GW_GE_Utils.checkCaseOriginale){
                if(fr.id_notifica==OM_GW_GE_Utils.caseOriginale.EOF_Id_Notifica__c){
                    res_temp.Esito = '0';
                    return res_temp;
                }
            } 
        }    
        
        //Common sync checks for all request type      
        if(String.isBlank(fr.CODICE_ORDINE_OLO)){
            return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'Codice Ordine OLO'); 
        }
        if(fr.CODICE_ORDINE_OLO.length() > 18 || fr.CODICE_ORDINE_OLO.contains('�')){
             return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'Codice Ordine OLO');
        }              
        if(String.isBlank(fr.CODICE_OPERATORE)){
             return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'Codice Operatore');    
        }              
        if(String.isBlank(fr.ID_NOTIFICA)){
             return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'Id Notifica');   
        } 
        if(fr.ID_NOTIFICA.length() > 15 || fr.ID_NOTIFICA.contains('�')){
            return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'Id Notifica');
        } 
        if(String.isBlank(fr.DATA_NOTIFICA)){
             return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'DATA_NOTIFICA');   
        }
        if(!OM_GW_GE_Utils.checkDateTime(fr.DATA_NOTIFICA)){
            return OM_GW_GE_Utils.syncError(fr,'A_K6','DATA_NOTIFICA'); 
        }        
        
        

        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple){
            if(fr.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        } 
 
        if(!olo_found){
            return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'Codice Operatore');
        }         
        
        //controlli su campi opzionali per tutti i flussi
        if(!string.isblank(fr.NOME_CLIENTE) && (fr.NOME_CLIENTE.contains('�') || fr.NOME_CLIENTE.length() > 20)){
                            return OM_GW_GE_Utils.syncError(fr,'A_K6','NOME_CLIENTE');
        }
        if(!string.isblank(fr.RECAPITO_TELEFONICO_CLIENTE_2) && (fr.RECAPITO_TELEFONICO_CLIENTE_2.contains('�')|| fr.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20)){
                            return OM_GW_GE_Utils.syncError(fr,'A_K6','RECAPITO_TELEFONICO_CLIENTE_2');
        }
        if(!string.isblank(fr.NOTE) && (fr.NOTE.contains('�')|| fr.NOTE.length() > 255)){
                            return OM_GW_GE_Utils.syncError(fr,'A_K6','NOTE');
        }

        // 13/02/2018 MM : aggiorno il timestamp. 00 corrisponde alla fine dei check generali.
        OM_GW_GE_Utils.partialTemplog('00');
        // finisce qui
        
        //DAC Remodulation/De-suspenion/Cancellation both Sync and Async controls -- execution will end here for type 2-3-4
        if(fr.TIPO_COMUNICAZIONE == '2' || fr.TIPO_COMUNICAZIONE == '3' || fr.TIPO_COMUNICAZIONE == '4'){
                          
             res_temp.Esito = '0';
            if(OM_GW_GE_Utils.caseOriginale.recordtype.developername!='EOF_Caso_Attivazione'){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'Codice Ordine OLO');
            }
            
             if(OM_GW_GE_Utils.caseOriginale.status == 'Espletato' || OM_GW_GE_Utils.caseOriginale.status == 'Espletato KO' || OM_GW_GE_Utils.caseOriginale.status == 'Cessato'|| OM_GW_GE_Utils.caseOriginale.status == 'Cessato KO' || OM_GW_GE_Utils.caseOriginale.status == 'Acquisito KO' || OM_GW_GE_Utils.caseOriginale.status == 'Annullato' || OM_GW_GE_Utils.caseOriginale.status == 'In Annullamento'){
                return OM_GW_GE_Utils.syncError(fr,'A_K6','STATUS:' + OM_GW_GE_Utils.caseOriginale.status);
             }
             
             //controlli sui campi obbligatori su tutti i flussi post sales
             if(String.isBlank(fr.COGNOME_CLIENTE)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'COGNOME_CLIENTE'); 
            }
            if(fr.COGNOME_CLIENTE.length() > 70 || fr.COGNOME_CLIENTE.contains('�')){
                 return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'COGNOME_CLIENTE');
            }  
            
            //controlli sui campi opzionali su tutti i flussi post sales
            if(!String.isBlank(fr.NOME_REFERENTE_TECNICO_OLO) && (fr.NOME_REFERENTE_TECNICO_OLO.contains('�') || fr.NOME_REFERENTE_TECNICO_OLO.length() > 50)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'NOME_REFERENTE_TECNICO_OLO');
            }
            if(!String.isBlank(fr.COGNOME_REFERENTE_TECNICO_OLO) && (fr.COGNOME_REFERENTE_TECNICO_OLO.contains('�') || fr.COGNOME_REFERENTE_TECNICO_OLO.length() > 50)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'COGNOME_REFERENTE_TECNICO_OLO');
            }
            if(!String.isBlank(fr.TELEFONO_REFERENTE_TECNICO_OLO) && (fr.TELEFONO_REFERENTE_TECNICO_OLO.contains('�') || fr.TELEFONO_REFERENTE_TECNICO_OLO.length() > 20)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'TELEFONO_REFERENTE_TECNICO_OLO');
            }
            if(!String.isBlank(fr.EMAIL_REFERENTE_TECNICO_OLO) && !OM_GW_GE_Utils.checkEmail(fr.EMAIL_REFERENTE_TECNICO_OLO)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'EMAIL_REFERENTE_TECNICO_OLO');
            }
            if(!String.isBlank(fr.RECAPITO_TEST_LINEA) && (fr.RECAPITO_TEST_LINEA.contains('�') || fr.RECAPITO_TEST_LINEA.length() > 20)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'RECAPITO_TEST_LINEA');
            }
            if(!String.isBlank(fr.NUMERO_TELEFONICO_PRINCIPALE_LINEA) && (fr.NUMERO_TELEFONICO_PRINCIPALE_LINEA.contains('�') || fr.NUMERO_TELEFONICO_PRINCIPALE_LINEA.length() > 20)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'NUMERO_TELEFONICO_PRINCIPALE_LINEA');
            }
            if(!String.isBlank(fr.OPZIONE_SYSTEM_UNICO) && fr.OPZIONE_SYSTEM_UNICO.toUpperCase() !='Y' && fr.OPZIONE_SYSTEM_UNICO.toUpperCase() !='N'){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'OPZIONE_SYSTEM_UNICO');
            }

            // 13/02/2018 MM : secondo update del timestamp. 000 corrisponde al post check iniziale
            OM_GW_GE_Utils.partialTemplog('000');               
            // finisce qui
              
             //DAC Remodulation
             if(fr.TIPO_COMUNICAZIONE == '2'){
                 
                 // 18/05/2018 MM :secondo update del timestamp. DAC.1 corrisponde a inizio check
                 OM_GW_GE_Utils.partialTemplog('DAC.1');
                 // finisce qui
                 
                 if(OM_GW_GE_Utils.caseOriginale.status != 'Acquisito' && OM_GW_GE_Utils.caseOriginale.status != 'Accettato' && OM_GW_GE_Utils.caseOriginale.status != 'Sospeso'){
                     return OM_GW_GE_Utils.syncError(fr,'A_K6','STATUS:' + OM_GW_GE_Utils.caseOriginale.status);
                 }
                 
                 if(fr.DATA_PREVISTA_ATTIVAZIONE==null){
                     return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'Data Prevista Attivazione');
                 }         
                 if(!OM_GW_GE_Utils.checkDate(fr.DATA_PREVISTA_ATTIVAZIONE)){
                     return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'Data Prevista Attivazione');                    
                 }
                 if(String.isBlank(fr.RECAPITO_TELEFONICO_CLIENTE_1)){
                     return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'RECAPITO_TELEFONICO_CLIENTE_1'); 
                 }
                 if(fr.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20 || fr.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
                     return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'RECAPITO_TELEFONICO_CLIENTE_1');
                 }                                
                 
                 //controllo su orario appuntamento        
                 if(!String.isBlank(fr.ORARIO_APPUNTAMENTO) ){
                     if(!OM_GW_GE_Utils.checKtime(fr.ORARIO_APPUNTAMENTO)){
                         return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'ORARIO_APPUNTAMENTO');
                     }
                 }
                 //controllo SLA
                 Datetime targetTime = Datetime.newInstance(OM_GW_GE_Utils.StringToDateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
                 BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
                 Integer num_giorni = 0;
                 Datetime giorno = Datetime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
                 
                 //per lo SLA devo sommare 2 giorni escluse le festività perchè sia conforme agli sla
                 while(num_giorni < 2){  
                     if(BusinessHours.isWithin(bh_dac.Id, giorno) == true ){                
                         giorno = Datetime.newInstance(giorno.year(), giorno.month() , giorno.day()+1,0,0,0);
                         num_giorni++;                         
                         continue;
                     }       
                     giorno = Datetime.newInstance(giorno.year(), giorno.month() , giorno.day()+1,0,0,0);      
                 }  
                 if(targetTime < giorno){
                     return OM_GW_GE_Utils.syncError (fr,'A_K3',null);
                 } 
                 //preparo la lista che dopo la callout andrò ad inserire
                 //l'idea è fare una lista con i service log principali da inserire, un volta inseriti prendo i relativi id, 
                 //li metto sugli ACK/NACK e inserisco anche quelli  
                 List<EOF_EAI_Service_Log__c> ListslPrincipaliToInsert = new List<EOF_EAI_Service_Log__c>();
                 List<EOF_EAI_Service_Log__c> ListSLAckNackToInsert = new List<EOF_EAI_Service_Log__c>();
                 //duplico il sl per inviarlo ad OM
                 EOF_EAI_Service_Log__c slToOM = OM_GW_GE_Utils.slOrig.clone(false,true,false,false);
                 slToOM.EOF_TIpo_comunicazione_String__c='SF->OM - FiberRequest - Rimodulazione DAC';
                 
                 //chiamo OLO con il slToOM
                 map<String,EOF_EAI_Service_Log__C> OMrespMap=createAckNackNotifyServiceLog_CM_OM(slToOM, OM_GW_GE_Utils.caseOriginale.EOF_Codice_Ordine_OM__c, 'test', fr.TIPO_COMUNICAZIONE);
                 if(OMrespMap.containsKey('ACK')){
                     //valorizzo gli ACK sugli SL principali e li inserisco
                     OM_GW_GE_Utils.slOrig.EOF_Response__c='ACK';
                     ListslPrincipaliToInsert.add(OM_GW_GE_Utils.slOrig);
                     slToOM.EOF_Response__c='ACK';
                     ListslPrincipaliToInsert.add(slToOM);
                     system.debug('Alessandro: da OLO: '+OM_GW_GE_Utils.slOrig+', ad OM: '+slToOM);
                     insert ListslPrincipaliToInsert; 
                     
                     //ora valorizzo il riferimento sugli ACK li inserisco
                     EOF_EAI_Service_Log__c slRespFromOM = OMrespMap.get('ACK');
                     slRespFromOM.EOF_SL_Riferimento__c=slToOM.Id;
                     ListSLAckNackToInsert.add(slRespFromOM);
                     
                     
                     ListSLAckNackToInsert.add(OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                         'Codice_operatore' => fr.CODICE_OPERATORE,
                         'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,
                         'ID_notifica' => fr.ID_NOTIFICA,
                         'Richiesta Notifica' => OM_GW_GE_Utils.Copy_request(fr),
                         'Caso' => OM_GW_GE_Utils.caseOriginale.Id,
                         'Tipo Comunicazione' => 'OLO->SF - ACK - FiberRequest - Rimodulazione DAC',
                         'SL Riferimento' => OM_GW_GE_Utils.slOrig.Id})
                                              );
                     Insert ListSLAckNackToInsert;
                     if(!String.isBlank(fr.ORARIO_APPUNTAMENTO)){                                                       
                         Time t = Time.newInstance(Integer.valueOf(fr.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(fr.ORARIO_APPUNTAMENTO.substring(3,5)),
                                                   Integer.valueOf(fr.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
                         OM_GW_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OM_GW_GE_Utils.StringToDateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE), t );
                     }else
                         OM_GW_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OM_GW_GE_Utils.StringToDateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
                     
                     
                     // 18/05/2018 MM :secondo update del timestamp. DAC.2 corrisponde a inizio check
                     OM_GW_GE_Utils.partialTemplog('DAC.2');
                     // finisce qui
                     
                     OM_GW_GE_Utils.caseOriginale.EOF_Note_Appuntamento__c = fr.NOTE;
                     OM_GW_GE_Utils.caseOriginale.EOF_Pertinenza_RDAC__c = 'OLO';                    
                     update OM_GW_GE_Utils.caseOriginale;  
                     
                     
                     return res_temp;
                    }
                    else{
                        //valorizzo gli ACK sugli SL principali e li inserisco
                        OM_GW_GE_Utils.slOrig.EOF_Response__c='NACK';
                        ListslPrincipaliToInsert.add(OM_GW_GE_Utils.slOrig);
                        slToOM.EOF_Response__c='NACK';
                        ListslPrincipaliToInsert.add(slToOM);
                        insert ListslPrincipaliToInsert; 
                        
                        //ora valorizzo il riferimento sugli ACK li inserisco
                        EOF_EAI_Service_Log__c slRespFromOM = OMrespMap.get('NACK');
                        slRespFromOM.EOF_SL_Riferimento__c=slToOM.Id;
                        ListSLAckNackToInsert.add(slRespFromOM);
                        ListSLAckNackToInsert.add(OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'NACK',
                                                             'Codice_operatore' => fr.CODICE_OPERATORE,
                                                             'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,
                                                             'ID_notifica' => fr.ID_NOTIFICA,
                                                             'Richiesta Notifica' => OM_GW_GE_Utils.Copy_request(fr),
                                                             'Codice_errore' => slRespFromOM.EOF_Codice_errore__c,
                                                             'Causale_errore' => slRespFromOM.EOF_Causale_Errore__c,
                                                             'Caso' => OM_GW_GE_Utils.caseOriginale.Id,
                                                             'Tipo Comunicazione' => 'OLO->SF - NACK - FiberRequest - Rimodulazione DAC',
                                                             'SL Riferimento' => OM_GW_GE_Utils.slOrig.Id})
                                                             );
                        Insert ListSLAckNackToInsert;
                         res_temp.esito='1';
                         res_temp.CodiceErrore=slRespFromOM.EOF_Codice_errore__c;
                         res_temp.CausaleErrore=slRespFromOM.EOF_Causale_Errore__c.split('-').get(0);
                         return res_temp;
                    }
                    
             }
                
             //De-sospension
             if(fr.TIPO_COMUNICAZIONE == '3'){
                 
                 // 18/05/2018 MM :update del timestamp. DES.1 corrisponde a inizio check
                 OM_GW_GE_Utils.partialTemplog('DES.1');
                 // finisce qui
                 
                 if(OM_GW_GE_Utils.caseOriginale.status != 'Sospeso'){
                     return OM_GW_GE_Utils.syncError(fr,'A_K6','STATUS:' + OM_GW_GE_Utils.caseOriginale.status);
                 }
                 if(String.isBlank(fr.RECAPITO_TELEFONICO_CLIENTE_1)){
                     return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'RECAPITO_TELEFONICO_CLIENTE_1'); 
                 }
                 if(fr.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20 || fr.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
                     return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'RECAPITO_TELEFONICO_CLIENTE_1');
                 }                                     
                 if(!String.isBlank(fr.DATA_PREVISTA_ATTIVAZIONE) && !OM_GW_GE_Utils.checkDate(fr.DATA_PREVISTA_ATTIVAZIONE)){
                     return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'Data Prevista Attivazione');                    
                 }
                 ///controllo su orario appuntamento        
                 if(!String.isBlank(fr.ORARIO_APPUNTAMENTO) ){
                     if(!OM_GW_GE_Utils.checKtime(fr.ORARIO_APPUNTAMENTO)){
                         return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'ORARIO_APPUNTAMENTO');
                     }
                 }
                 if(!String.isBlank(fr.DATA_PREVISTA_ATTIVAZIONE)){
                     //controllo SLA
                     Datetime targetTime = Datetime.newInstance(OM_GW_GE_Utils.StringToDateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
                     BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
                     Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);
                     if(!BusinessHours.isWithin(bh.Id, targetTime)){
                         return OM_GW_GE_Utils.syncError (fr,'A_K14',null);
                     }
                     
                     
                     BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
                     Integer num_giorni = 0;
                     Datetime giorno = Datetime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
                     
                     //per lo SLA devo sommare 2 giorni escluse le festività perchè sia conforme agli sla
                     while(num_giorni < 2){  
                         if(BusinessHours.isWithin(bh_dac.Id, giorno) == true ){                
                             giorno = Datetime.newInstance(giorno.year(), giorno.month() , giorno.day()+1,0,0,0);
                             num_giorni++;                         
                             continue;
                         }       
                         giorno = Datetime.newInstance(giorno.year(), giorno.month() , giorno.day()+1,0,0,0);      
                     }  
                     if(targetTime < giorno){
                         return OM_GW_GE_Utils.syncError (fr,'A_K3',null);
                     }
                 }
                 //preparo la lista che dopo la callout andrò ad inserire
                 //l'idea è fare una lista con i service log principali da inserire, un volta inseriti prendo i relativi id, 
                 //li metto sugli ACK/NACK e inserisco anche quelli  
                 List<EOF_EAI_Service_Log__c> ListslPrincipaliToInsert = new List<EOF_EAI_Service_Log__c>();
                 List<EOF_EAI_Service_Log__c> ListSLAckNackToInsert = new List<EOF_EAI_Service_Log__c>();
                 //duplico il sl per inviarlo ad OM
                 EOF_EAI_Service_Log__c slToOM = OM_GW_GE_Utils.slOrig.clone(false,true,false,false);
                 slToOM.EOF_TIpo_comunicazione_String__c='SF->OM - FiberRequest - Desospensione';
                 
                 //chiamo OLO con il slToOM
                 map<String,EOF_EAI_Service_Log__C> OMrespMap=createAckNackNotifyServiceLog_CM_OM(slToOM, OM_GW_GE_Utils.caseOriginale.EOF_Codice_Ordine_OM__c, 'test', fr.TIPO_COMUNICAZIONE);
                 if(OMrespMap.containsKey('ACK')){
                     //valorizzo gli ACK sugli SL principali e li inserisco
                     OM_GW_GE_Utils.slOrig.EOF_Response__c='ACK';
                     ListslPrincipaliToInsert.add(OM_GW_GE_Utils.slOrig);
                     slToOM.EOF_Response__c='ACK';
                     ListslPrincipaliToInsert.add(slToOM);
                     insert ListslPrincipaliToInsert; 
                     
                     //ora valorizzo il riferimento sugli ACK li inserisco
                     EOF_EAI_Service_Log__c slRespFromOM = OMrespMap.get('ACK');
                     slRespFromOM.EOF_SL_Riferimento__c=slToOM.Id;
                     ListSLAckNackToInsert.add(slRespFromOM);
                     ListSLAckNackToInsert.add(OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                         'Codice_operatore' => fr.CODICE_OPERATORE,
                         'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,
                         'ID_notifica' => fr.ID_NOTIFICA,
                         'Richiesta Notifica' => OM_GW_GE_Utils.Copy_request(fr),
                         'Caso' => OM_GW_GE_Utils.caseOriginale.Id,
                         'Tipo Comunicazione' => 'OLO->SF - ACK - FiberRequest - Desospensione',
                         'SL Riferimento' => OM_GW_GE_Utils.slOrig.Id})
                                              );
                     Insert ListSLAckNackToInsert;
                     
                     if(!String.isBlank(fr.DATA_PREVISTA_ATTIVAZIONE)){
                         
                         if(!String.isBlank(fr.ORARIO_APPUNTAMENTO)){                                                       
                             Time t = Time.newInstance(Integer.valueOf(fr.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(fr.ORARIO_APPUNTAMENTO.substring(3,5)),
                                                       Integer.valueOf(fr.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
                             OM_GW_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OM_GW_GE_Utils.StringToDateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE), t );
                         }else{
                             OM_GW_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OM_GW_GE_Utils.StringToDateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
                         }
                         OM_GW_GE_Utils.caseOriginale.EOF_Pertinenza_RDAC__c = 'OLO';
                     }                       
                     OM_GW_GE_Utils.caseOriginale.EOF_Note_Appuntamento__c = fr.NOTE;                                           
                     //Updating Case Properly
                     CaseHistory ch;
                     if(Test.isRunningTest()){
                         ch= new CaseHistory(CaseId=OM_GW_GE_Utils.caseOriginale.Id, Field='Status');
                     }
                     else{
                         ch = [select oldValue from CaseHistory where CaseId=:OM_GW_GE_Utils.caseOriginale.Id and Field='Status' order by createdDate desc limit 1];
                     }
                     
                     // 18/05/2018 MM :update del timestamp. DES.2 corrisponde a fine check
                     OM_GW_GE_Utils.partialTemplog('DES.2');
                     // finisce qui
                     
                     
                     OM_GW_GE_Utils.caseOriginale.Status= String.valueof(ch.oldValue);
                     OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'Desospeso';
                     update OM_GW_GE_Utils.caseOriginale;                     
                     
                     return res_temp;
                 }
                    else{
                        //valorizzo gli ACK sugli SL principali e li inserisco
                        OM_GW_GE_Utils.slOrig.EOF_Response__c='NACK';
                        ListslPrincipaliToInsert.add(OM_GW_GE_Utils.slOrig);
                        slToOM.EOF_Response__c='NACK';
                        ListslPrincipaliToInsert.add(slToOM);
                        insert ListslPrincipaliToInsert; 
                        
                        //ora valorizzo il riferimento sugli ACK li inserisco
                        EOF_EAI_Service_Log__c slRespFromOM = OMrespMap.get('NACK');
                        slRespFromOM.EOF_SL_Riferimento__c=slToOM.Id;
                        ListSLAckNackToInsert.add(slRespFromOM);
                        ListSLAckNackToInsert.add(OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'NACK',
                                                             'Codice_operatore' => fr.CODICE_OPERATORE,
                                                             'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,
                                                             'ID_notifica' => fr.ID_NOTIFICA,
                                                             'Richiesta Notifica' => OM_GW_GE_Utils.Copy_request(fr),
                                                             'Codice_errore' => slRespFromOM.EOF_Codice_errore__c,
                                                             'Causale_errore' => slRespFromOM.EOF_Causale_Errore__c,
                                                             'Caso' => OM_GW_GE_Utils.caseOriginale.Id,
                                                             'Tipo Comunicazione' => 'OLO->SF - NACK - FiberRequest - Desospensione',
                                                             'SL Riferimento' => OM_GW_GE_Utils.slOrig.Id})
                                                             );
                        Insert ListSLAckNackToInsert;
                         res_temp.esito='1';
                         res_temp.CodiceErrore=slRespFromOM.EOF_Codice_errore__c;
                         res_temp.CausaleErrore=slRespFromOM.EOF_Causale_Errore__c.split('-').get(0);
                         return res_temp;
                    }
                                                                    
            }
              
             //Cancellation
             if(fr.TIPO_COMUNICAZIONE == '4'){
                 
                 // 18/05/2018 MM :update del timestamp. ANN.1 corrisponde a inizio check
                 OM_GW_GE_Utils.partialTemplog('Ann.1');
                 // finisce qui
                 
                 if(OM_GW_GE_Utils.caseOriginale.status != 'Acquisito' && OM_GW_GE_Utils.caseOriginale.status != 'Accettato' && OM_GW_GE_Utils.caseOriginale.status != 'Sospeso'){
                     return OM_GW_GE_Utils.syncError(fr,'A_K6','STATUS:' + OM_GW_GE_Utils.caseOriginale.status);
                 }
                 //obbligatori
                 if(String.isBlank(fr.CAUSALE_RICHIESTA_ANNULLAMENTO)){
                     return OM_GW_GE_Utils.syncError(fr,'A_K5', 'CAUSALE_RICHIESTA_ANNULLAMENTO');                                                
                 }
                 if(fr.CAUSALE_RICHIESTA_ANNULLAMENTO.toUpperCase()!='ANNULLAMENTO SU RICHIESTA OLO'){
                     return OM_GW_GE_Utils.syncError(fr,'A_K6', 'CAUSALE_RICHIESTA_ANNULLAMENTO');                                                
                 } 
                 if(String.isBlank(fr.CODICE_RICHIESTA_ANNULLAMENTO)){
                     return OM_GW_GE_Utils.syncError(fr,'A_K5', 'CODICE_RICHIESTA_ANNULLAMENTO');                                               
                 }
                 if(fr.CODICE_RICHIESTA_ANNULLAMENTO.toUpperCase()!='D_A1'){
                     return OM_GW_GE_Utils.syncError(fr,'A_K6', 'CODICE_RICHIESTA_ANNULLAMENTO');                                                
                 }
                 //opzionale
                 if(!String.isBlank(fr.RECAPITO_TELEFONICO_CLIENTE_1) && (fr.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20 || fr.RECAPITO_TELEFONICO_CLIENTE_1.contains('�'))){
                     return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'RECAPITO_TELEFONICO_CLIENTE_1');
                 }                        
                 //preparo la lista che dopo la callout andrò ad inserire
                 //l'idea è fare una lista con i service log principali da inserire, un volta inseriti prendo i relativi id, 
                 //li metto sugli ACK/NACK e inserisco anche quelli  
                 List<EOF_EAI_Service_Log__c> ListslPrincipaliToInsert = new List<EOF_EAI_Service_Log__c>();
                 List<EOF_EAI_Service_Log__c> ListSLAckNackToInsert = new List<EOF_EAI_Service_Log__c>();
                 //duplico il sl per inviarlo ad OM
                 EOF_EAI_Service_Log__c slToOM = OM_GW_GE_Utils.slOrig.clone(false,true,false,false);
                 slToOM.EOF_TIpo_comunicazione_String__c='SF->OM - FiberRequest - Annullamento';
                 
                 //chiamo OLO con il slToOM
                 map<String,EOF_EAI_Service_Log__C> OMrespMap=createAckNackNotifyServiceLog_CM_OM(slToOM, OM_GW_GE_Utils.caseOriginale.EOF_Codice_Ordine_OM__c, 'test', fr.TIPO_COMUNICAZIONE);
                 if(OMrespMap.containsKey('ACK')){
                     //valorizzo gli ACK sugli SL principali e li inserisco
                     OM_GW_GE_Utils.slOrig.EOF_Response__c='ACK';
                     ListslPrincipaliToInsert.add(OM_GW_GE_Utils.slOrig);
                     slToOM.EOF_Response__c='ACK';
                     ListslPrincipaliToInsert.add(slToOM);
                     insert ListslPrincipaliToInsert; 
                     
                     //ora valorizzo il riferimento sugli ACK li inserisco
                     EOF_EAI_Service_Log__c slRespFromOM = OMrespMap.get('ACK');
                     slRespFromOM.EOF_SL_Riferimento__c=slToOM.Id;
                     ListSLAckNackToInsert.add(slRespFromOM);
                     ListSLAckNackToInsert.add(OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                         'Codice_operatore' => fr.CODICE_OPERATORE,
                         'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,
                         'ID_notifica' => fr.ID_NOTIFICA,
                         'Richiesta Notifica' => OM_GW_GE_Utils.Copy_request(fr),
                         'Caso' => OM_GW_GE_Utils.caseOriginale.Id,
                         'Tipo Comunicazione' => 'OLO->SF - ACK - FiberRequest - Annullamento',
                         'SL Riferimento' => OM_GW_GE_Utils.slOrig.Id})
                                              );
                     Insert ListSLAckNackToInsert;
                     
                     OM_GW_GE_Utils.caseOriginale.Status = 'In Annullamento';
                     OM_GW_GE_Utils.caseOriginale.EOF_Causale_Richiesta_Annullamento__c = fr.CAUSALE_RICHIESTA_ANNULLAMENTO;
                     OM_GW_GE_Utils.caseOriginale.EOF_Codice_Richiesta_Annullamento__c = fr.CODICE_RICHIESTA_ANNULLAMENTO;               
                     update OM_GW_GE_Utils.caseOriginale;
                     
                     // 18/05/2018 MM :update del timestamp. ANN.2 corrisponde a fine check
                     OM_GW_GE_Utils.partialTemplog('ANN.2');
                     // finisce qui
                     
                     return res_temp;
                    }
                    else{
                        //valorizzo gli ACK sugli SL principali e li inserisco
                        OM_GW_GE_Utils.slOrig.EOF_Response__c='NACK';
                        ListslPrincipaliToInsert.add(OM_GW_GE_Utils.slOrig);
                        slToOM.EOF_Response__c='NACK';
                        ListslPrincipaliToInsert.add(slToOM);
                        insert ListslPrincipaliToInsert; 
                        
                        //ora valorizzo il riferimento sugli ACK li inserisco
                        EOF_EAI_Service_Log__c slRespFromOM = OMrespMap.get('NACK');
                        slRespFromOM.EOF_SL_Riferimento__c=slToOM.Id;
                        ListSLAckNackToInsert.add(slRespFromOM);
                        ListSLAckNackToInsert.add(OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'NACK',
                                                             'Codice_operatore' => fr.CODICE_OPERATORE,
                                                             'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,
                                                             'ID_notifica' => fr.ID_NOTIFICA,
                                                             'Richiesta Notifica' => OM_GW_GE_Utils.Copy_request(fr),
                                                             'Codice_errore' => slRespFromOM.EOF_Codice_errore__c,
                                                             'Causale_errore' => slRespFromOM.EOF_Causale_Errore__c,
                                                             'Caso' => OM_GW_GE_Utils.caseOriginale.Id,
                                                             'Tipo Comunicazione' => 'OLO->SF - NACK - FiberRequest - Annullamento',
                                                             'SL Riferimento' => OM_GW_GE_Utils.slOrig.Id})
                                                             );
                        Insert ListSLAckNackToInsert;
                         res_temp.esito='1';
                         res_temp.CodiceErrore=slRespFromOM.EOF_Codice_errore__c;
                         res_temp.CausaleErrore=slRespFromOM.EOF_Causale_Errore__c.split('-').get(0);
                         return res_temp;
                    }
                                                                                       
             }
             return res_temp;
        }
        //check attivazione e cessazione
        if(OM_GW_GE_Utils.checkCaseOriginale){
            return OM_GW_GE_Utils.syncError(fr, 'A_K7', 'Codice Ordine OLO già presente');
        } 
        String s = '';      
        //Sync Acquisition checks 
        if(fr.TIPO_COMUNICAZIONE == '1'){

            // 18/05/2018 MM :update del timestamp. ATT.1 corrisponde a inizio check
            OM_GW_GE_Utils.partialTemplog('ATT.1');
            // finisce qui

            
            //obbligatori
            if(String.isBlank(fr.COGNOME_CLIENTE)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'COGNOME_CLIENTE'); 
            }
            if(fr.COGNOME_CLIENTE.length() > 70 || fr.COGNOME_CLIENTE.contains('�')){
                 return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'COGNOME_CLIENTE');
            }
            if(String.isBlank(fr.RECAPITO_TELEFONICO_CLIENTE_1)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'RECAPITO_TELEFONICO_CLIENTE_1'); 
            }
            if(fr.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20 || fr.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
                 return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'RECAPITO_TELEFONICO_CLIENTE_1');
            }
            if(string.isBlank(fr.IDENTIFICATIVO_DEL_POP)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'IDENTIFICATIVO_DEL_POP'); 
            }
            if(fr.IDENTIFICATIVO_DEL_POP.length() > 10 || fr.IDENTIFICATIVO_DEL_POP.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'IDENTIFICATIVO_DEL_POP');
            }
            if(!String.isBlank(fr.GPON_ATTESTAZIONE) && (fr.GPON_ATTESTAZIONE.contains('�') || fr.GPON_ATTESTAZIONE.length() > 50)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'GPON_ATTESTAZIONE');
            } 
            if(!String.isBlank(fr.GPON_ATTESTAZIONE)){
                if(String.isBlank(fr.GPON_VINCOLANTE)){
                    return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'GPON_VINCOLANTE');
                }
            }
            if(!String.isBlank(fr.GPON_VINCOLANTE) && fr.GPON_VINCOLANTE.toUpperCase()!='Y' && fr.GPON_VINCOLANTE.toUpperCase()!='N'){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'GPON_VINCOLANTE');
            }
            if(String.isBlank(fr.DATA_PREVISTA_ATTIVAZIONE)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'Data Prevista Attivazione');
            }         
            if(!OM_GW_GE_Utils.checkDate(fr.DATA_PREVISTA_ATTIVAZIONE)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'Data Prevista Attivazione');                    
            }
            if(string.isBlank(fr.PROVINCIA)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'PROVINCIA'); 
            }
            if(fr.PROVINCIA.length() > 30 || fr.PROVINCIA.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'PROVINCIA');
            }
            if(string.isBlank(fr.COMUNE)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'COMUNE'); 
            }
            if(fr.COMUNE.length() > 60 || fr.COMUNE.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'COMUNE');
            }
            if(string.isBlank(fr.PARTICELLA_TOPONOMASTICA)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'PARTICELLA_TOPONOMASTICA'); 
            }
            if(fr.PARTICELLA_TOPONOMASTICA.length() > 28 || fr.PARTICELLA_TOPONOMASTICA.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'PARTICELLA_TOPONOMASTICA');
            }
            if(string.isBlank(fr.INDIRIZZO)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'INDIRIZZO'); 
            }
            if(fr.INDIRIZZO.length() > 70 || fr.INDIRIZZO.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'INDIRIZZO');
            }
            if(string.isBlank(fr.NUMERO_CIVICO)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'NUMERO_CIVICO'); 
            }
            if(fr.NUMERO_CIVICO.length() > 10 || fr.NUMERO_CIVICO.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'NUMERO_CIVICO');
            }
            if(string.isBlank(fr.ID_BUILDING)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'ID_BUILDING'); 
            }
            if(fr.ID_BUILDING.length() > 150 || fr.ID_BUILDING.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'ID_BUILDING');
            }
            if(string.isBlank(fr.NOME_REFERENTE_TECNICO_OLO)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'NOME_REFERENTE_TECNICO_OLO'); 
            }
            if(fr.NOME_REFERENTE_TECNICO_OLO.length() > 50 || fr.NOME_REFERENTE_TECNICO_OLO.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'NOME_REFERENTE_TECNICO_OLO');
            }
            if(string.isBlank(fr.COGNOME_REFERENTE_TECNICO_OLO)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'COGNOME_REFERENTE_TECNICO_OLO'); 
            }
            if(fr.COGNOME_REFERENTE_TECNICO_OLO.length() > 50 || fr.COGNOME_REFERENTE_TECNICO_OLO.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'COGNOME_REFERENTE_TECNICO_OLO');
            }
            if(string.isBlank(fr.TELEFONO_REFERENTE_TECNICO_OLO)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'TELEFONO_REFERENTE_TECNICO_OLO'); 
            }
            if(fr.TELEFONO_REFERENTE_TECNICO_OLO.length() > 20 || fr.TELEFONO_REFERENTE_TECNICO_OLO.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'TELEFONO_REFERENTE_TECNICO_OLO');
            }
            if(string.isBlank(fr.EMAIL_REFERENTE_TECNICO_OLO)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'EMAIL_REFERENTE_TECNICO_OLO'); 
            }
            if(!OM_GW_GE_Utils.checkEmail(fr.EMAIL_REFERENTE_TECNICO_OLO)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'EMAIL_REFERENTE_TECNICO_OLO');
            }
            
            
            //opzionali
            if(!String.isBlank(fr.SCALA_PALAZZINA) && (fr.SCALA_PALAZZINA.contains('�') || fr.SCALA_PALAZZINA.length() > 10)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'SCALA_PALAZZINA');
            }
            if(!String.isBlank(fr.TIPOLOGIA_APPARATO) && (fr.TIPOLOGIA_APPARATO.contains('�') || fr.TIPOLOGIA_APPARATO.length() > 100)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'TIPOLOGIA_APPARATO');
            }
            if(!String.isBlank(fr.PROGETTO_SPECIALE) && (fr.PROGETTO_SPECIALE.contains('�') || fr.PROGETTO_SPECIALE.length() > 50)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'PROGETTO_SPECIALE');
            }
            if(!String.isBlank(fr.COLLEGAMENTO_P2P) && fr.COLLEGAMENTO_P2P != '1'){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'COLLEGAMENTO_P2P');
            }
            if(!String.isBlank(fr.SLA_PREMIUM_ASSURANCE) && fr.SLA_PREMIUM_ASSURANCE != 'Y'){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'SLA_PREMIUM_ASSURANCE');
            }
            if(!String.isBlank(fr.OPZIONE_SYSTEM_UNICO) && fr.OPZIONE_SYSTEM_UNICO.toUpperCase() !='Y' && fr.OPZIONE_SYSTEM_UNICO.toUpperCase() !='N'){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'OPZIONE_SYSTEM_UNICO');
            }
            if(!String.isBlank(fr.TIPOLOGIA_SERVIZIO) && (fr.TIPOLOGIA_SERVIZIO.contains('�') || fr.TIPOLOGIA_SERVIZIO.length() > 1)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'TIPOLOGIA_SERVIZIO');
            }
            if(!String.isBlank(fr.PASSWORD_APPARATO) && (fr.PASSWORD_APPARATO.contains('�') || fr.PASSWORD_APPARATO.length() > 20)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'PASSWORD_APPARATO');
            }
            if(!String.isBlank(fr.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH) && (fr.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH.contains('�') || fr.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH.length() > 20)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH');
            }
            if(!String.isBlank(fr.APPARATO) && fr.APPARATO != 'Y' && fr.APPARATO != 'N'){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'APPARATO');
            }
            
            if(!String.isBlank(fr.ORARIO_APPUNTAMENTO) ){
                 if(!OM_GW_GE_Utils.checKtime(fr.ORARIO_APPUNTAMENTO)){
                    return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'ORARIO_APPUNTAMENTO');
                 }
            }
            s='Attivazione';
            RecordType rt = [SELECT Id FROM RecordType WHERE sObjectType = 'Case' AND DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];
            
            OM_GW_GE_Utils.caseOriginale = new Case( 
            
                //Synchronous control
                Type = fr.TIPO_COMUNICAZIONE,
                RecordTypeId = rt.Id,
                EOF_Codice_Operatore_WS__c = fr.CODICE_OPERATORE,            
                EOF_Codice_Ordine_OLO__c = fr.CODICE_ORDINE_OLO,
                EOF_Data_Notifica__c = OM_GW_GE_Utils.StringToDate(fr.DATA_NOTIFICA),
                EOF_Id_Notifica__c = fr.ID_NOTIFICA,                
                EOF_Data_Prevista_Attivazione__c = OM_GW_GE_Utils.StringToDateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE),
                EOF_Id_Building_WS__c=fr.ID_Building,
                EOF_Order_Manager__c=true,
                Status = 'Inviato', 
                EOF_Fase__c = 'NA',
                EOF_Identificativo_del_POP__c = fr.IDENTIFICATIVO_DEL_POP,
                EOF_Comune_WS__c=fr.COMUNE,
                EOF_GPON_Attestazione__c = fr.GPON_ATTESTAZIONE,
                EOF_GPON_Vincolante__c = fr.GPON_VINCOLANTE,                          
                EOF_Recapito_Test_Linea__c = fr.RECAPITO_TEST_LINEA,
                EOF_Numero_Telefonico_Principale_Linea__c = fr.NUMERO_TELEFONICO_PRINCIPALE_LINEA,
                EOF_Password_Apparato__c = fr.PASSWORD_APPARATO,
                EOF_Telefono_Referente_OLO_Onfield_Notec__c   = fr.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH,
                EOF_Opzione_System_Unico__c = fr.OPZIONE_SYSTEM_UNICO,                   
                EOF_Apparato__c = fr.APPARATO,
                EOF_Tipologia_Apparato__c = fr.TIPOLOGIA_APPARATO,
                EOF_Progetto_Speciale__c = fr.PROGETTO_SPECIALE,            
                EOF_Collegamento_P2P__c = fr.COLLEGAMENTO_P2P,
                Description = fr.NOTE,
                EOF_Tipologia_Servizio__c = fr.TIPOLOGIA_SERVIZIO,
                EOF_SLA_Premium_Assurance__c = fr.SLA_PREMIUM_ASSURANCE,
                EOF_Orario_Appuntamento__c = fr.ORARIO_APPUNTAMENTO,          
                Origin = 'Web',
                subject='Richiesta di Attivazione'                          
            );  

            // 18/05/2018 MM :update del timestamp. ATT.2 corrisponde a fine check
            OM_GW_GE_Utils.partialTemplog('ATT.2');
            // finisce qui
            
        }
        
        //Sync Cessation checks
        if(fr.TIPO_COMUNICAZIONE == '11'){

            // 18/05/2018 MM :update del timestamp. CSS.1 corrisponde a inizio check
            OM_GW_GE_Utils.partialTemplog('CSS.1');
            // finisce qui
                        
            //obbligatori
            if(string.isBlank(fr.ID_RISORSA)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'ID_RISORSA'); 
            }
            
            if(fr.ID_RISORSA.length() > 50 || fr.ID_RISORSA.contains('�')){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'ID_RISORSA');
            }
            if(!String.isBlank(fr.APPARATO) && fr.APPARATO != 'Y' && fr.APPARATO != 'N'){
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'APPARATO');
            }
            if(fr.APPARATO == 'Y'){
                if(String.isBlank(fr.COGNOME_CLIENTE)){
                    return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'COGNOME_CLIENTE'); 
                }
                if(fr.COGNOME_CLIENTE.length() > 70 || fr.COGNOME_CLIENTE.contains('�')){
                     return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'COGNOME_CLIENTE');
                }
                if(String.isBlank(fr.RECAPITO_TELEFONICO_CLIENTE_1)){
                    return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'RECAPITO_TELEFONICO_CLIENTE_1'); 
                }
                if(fr.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20 || fr.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
                     return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'RECAPITO_TELEFONICO_CLIENTE_1');
                }
            }
             s='Cessazione';
             RecordType rt = [SELECT Id FROM RecordType WHERE sObjectType = 'Case' AND developerName = 'EOF_Caso_Cessazione' LIMIT 1];
            
             OM_GW_GE_Utils.caseOriginale = new Case(
                Type = fr.TIPO_COMUNICAZIONE,
                RecordTypeId = rt.Id,
                EOF_Codice_Operatore_WS__c = fr.CODICE_OPERATORE,            
                EOF_Codice_Ordine_OLO__c = fr.CODICE_ORDINE_OLO,
                EOF_Data_Notifica__c = OM_GW_GE_Utils.StringToDate(fr.DATA_NOTIFICA),
                EOF_Id_Notifica__c = fr.ID_NOTIFICA,
                EOF_Id_Risorsa__c = fr.ID_RISORSA,
                EOF_Order_Manager__c=true,              
                //Status = 'Acquisito',  
                Status = 'Inviato', 
                EOF_Fase__c = 'NA',  
                Origin = 'Web',
                Description = fr.NOTE,
                subject='Richiesta di Cessazione'
                );

            // 18/05/2018 MM :update del timestamp. CSS.2 corrisponde a fine check
            OM_GW_GE_Utils.partialTemplog('CSS.2');
            // finisce qui                
                                 
        }     
                    
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = true;
        OM_GW_GE_Utils.caseOriginale.setOptions(dmo);
        insert OM_GW_GE_Utils.caseOriginale;
        OM_GW_GE_Utils.checkCaseOriginale=true;

        
        //lego il slog di fiberrequest al case, poi lo aggiorno col ritorno del metodo OM_GW_GE_Utils.createACK
        if(OM_GW_GE_Utils.checkslOrig){
            OM_GW_GE_Utils.slOrig.caso__c=OM_GW_GE_Utils.caseOriginale.Id;
            OM_GW_GE_Utils.slOrig.EOF_Codice_Ordine_EOF__C=OM_GW_GE_Utils.caseOriginale.Id;
            OM_GW_GE_Utils.slOrig.EOF_Response__c='ACK';
        }              
        
        insert OM_GW_GE_Utils.slOrig;
                         
        insert OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                                         'Codice_operatore' => fr.CODICE_OPERATORE,
                                                         'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,
                                                         'ID_notifica' => fr.ID_NOTIFICA,
                                                         'Richiesta Notifica' => OM_GW_GE_Utils.Copy_request(fr),
                                                         'Caso' => OM_GW_GE_Utils.caseOriginale.Id,
                                                         'Tipo Comunicazione' => 'OLO->SF - ACK - FiberRequest - '+s,
                                                         'SL Riferimento' => OM_GW_GE_Utils.slOrig.Id});
                 
        checkAsync(OM_GW_GE_Utils.caseOriginale.Id,OM_GW_GE_Utils.slOrig.Id);              

        return res_temp;     
             
} 
    
    //Acquisition and Cessation async checks -- 1 and 11 type are the only that have async checks
    @Future(callout=true) 
    public static void checkAsync(String caseId,String slId){
        
        checkAsyncSync(caseId,slId);
        
    }
    
    public static void checkAsyncSync(String caseId,String slId){
        
        //vado a creare la mappa dei recordtype p\ser poi utilizzarla
        OM_GW_GE_Utils.RTMap = new  map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            OM_GW_GE_Utils.RTMap.put(rt.developername,rt.id);
        }
                
        
        OM_GW_GE_Utils.checkRTMap=true;
        //estraggo sl e case e li assegno alle variabili statiche
        OM_GW_GE_Utils.caseOriginale = Database.query(OM_GW_GE_Utils.getQuery('case','Attivazione')+
                                                ' where id=:caseId'); 
        OM_GW_GE_Utils.checkCaseOriginale=true;
        OM_GW_GE_Utils.slOrig = Database.query(OM_GW_GE_Utils.getQuery('sl','Attivazione')+
                                                ' where id=:slId');  
        OM_GW_GE_Utils.checkslOrig=true;   
        
        // 11/06/2018 MM : aggiunta query per estrazione templog legato al processo in corso
        //OM_GW_GE_Utils.tpl =[select id, Name, type__c, desc__c, timestamp__c, attraversamento__c, Tipo_Comunicazione__c, Tipo_Comunicazione_String__c, TL_codice_ordine_olo__c,OF_CPU_Time__c, OF_CPU_Time_Limit__c, Tempi_Parziali__c, createddate from templog__c where TL_codice_ordine_olo__c =: OM_GW_GE_Utils.caseOriginale.eof_codice_ordine_olo__c AND Tipo_Comunicazione__c =:OM_GW_GE_Utils.slOrig.EOF_TIpo_comunicazione__c order by createddate desc limit 1];
        // 11/06/2018 MM : fine aggiunta
        
        //Updating OLO lookup to case        
        OLO_ID__c oloId=OLO_ID__c.getInstance(OM_GW_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c);
        OM_GW_GE_Utils.caseOriginale.EOF_Account_OLO__c = oloId.OF_Olo_Id__c;
        //update OM_GW_GE_Utils.caseOriginale;
        
        //Activation        
        if(OM_GW_GE_Utils.caseOriginale.recordtype.developername == 'EOF_Caso_Attivazione'){
                        
            //Async control DATA_PREVISTA_ATTIVAZIONE
            Date DPA = OM_GW_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c;
            Integer year = DPA.year();
            Integer month = DPA.month();
            Integer day = DPA.day();
            Datetime targetTime = Datetime.newInstance(year, month, day, 0, 0, 0);
            BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
            Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);  
            
            boolean superProgettoSpeciale=false;
            if(OM_GW_GE_Utils.caseOriginale.EOF_Progetto_Speciale__c=='TIS_20170403_000000001'){
                superProgettoSpeciale=true;
            }
            
            if(isWithin == false && !superProgettoSpeciale){ 
                OM_GW_GE_Utils.caseOriginale.EOF_Codice_Errore__c='A_K14';
                OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                //update OM_GW_GE_Utils.caseOriginale;
                create_notify(5, 'KO'); 
                return; 
            }                
            
            BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
            Integer num_giorni_rfa = 0;
            Integer num_giorni_rfc = 0;
            Datetime RFA = Datetime.newInstance(system.now().year(), system.now().month(), system.now().day(), 0, 0, 0);
            Datetime RFC = Datetime.newInstance(system.now().year(), system.now().month(), system.now().day(), 0, 0, 0);
    
            //per RFA devo sommare 5 giorni escluse le festività perchè sia conforme agli sla
            while(num_giorni_rfa < 5){  
                if(BusinessHours.isWithin(bh_dac.Id, RFA) == true ){                
                    RFA = Datetime.newInstance(RFA.year(), RFA.month() , RFA.day()+1,0,0,0);
                    num_giorni_rfa++;                         
                    continue;
                }       
                RFA = Datetime.newInstance(RFA.year(), RFA.month() , RFA.day()+1,0,0,0);      
            }                    
            while(num_giorni_rfc < 10){ 
                if(BusinessHours.isWithin(bh_dac.Id, RFC) == true ){                 
                    RFC = Datetime.newInstance(RFC.year(), RFC.month() , RFC.day()+1,0,0,0);
                    num_giorni_rfc++;                           
                    continue;
                }       
                RFC = Datetime.newInstance(RFC.year(), RFC.month() , RFC.day()+1,0,0,0);    
            } 

            //giovanni ernetti 16-10-2018 INIZIO
            /*
            List<EOF_Network_Inventory__c> ni = [SELECT Id,EOF_Civico__c,EOF_Comune__c,EOF_GPON_ID__c,EOF_ID_Building__c,EOF_Pop__c,
                                    EOF_Indirizzo__c, EOF_Particella_Top__c,EOF_Provincia__c,EOF_Scala_Palazzina__c,EOF_Stato_Building__c
                                     FROM EOF_Network_Inventory__c WHERE EOF_ID_Building__c =: OM_GW_GE_Utils.caseOriginale.EOF_Id_Building_WS__c];  
            */
            List<EOF_Network_Inventory__c> ni = OM_GW_GE_Utils.controlloVendibilita(OM_GW_GE_Utils.caseOriginale.EOF_codice_operatore_WS__c, OM_GW_GE_Utils.caseOriginale.EOF_ID_Building_WS__c);
            //List<EOF_Network_Inventory__c> ni;
            //giovanni ernetti 16-10-2018 FINE
            if(ni.isEmpty()){
                try{
                    ni = [SELECT Id,EOF_Civico__c,EOF_Comune__c,EOF_GPON_ID__c,EOF_ID_Building__c,EOF_Pop__c,
                          EOF_Indirizzo__c, EOF_Particella_Top__c,EOF_Provincia__c,EOF_Scala_Palazzina__c,EOF_Stato_Building__c
                          FROM EOF_Network_Inventory__c WHERE EOF_ID_Building__c =: OM_GW_GE_Utils.caseOriginale.EOF_Id_Building_WS__c];
                }catch(Exception e){
                    //Istanzio una lista vuota così da evitare nullPointer
                    ni = new List<EOF_Network_Inventory__c>();
                    OM_GW_GE_Utils.vendHasException = true;
                    OM_GW_GE_Utils.vendException = 'Exception: ' + e.getTypeName() + ': ' + e.getMessage();
                }
                String idRequestCallout = (OM_GW_GE_Utils.vendLogLst != null && !OM_GW_GE_Utils.vendLogLst.isEmpty()) ? OM_GW_GE_Utils.vendLogLst.get(0).OF_IdRequest__c : 'request ' + DateTime.now();
                OM_GW_GE_Utils.createVendibilitaRequestResponseLog(ni, 'query', idRequestCallout, OM_GW_GE_Utils.caseOriginale.EOF_codice_operatore_WS__c, OM_GW_GE_Utils.caseOriginale.EOF_ID_Building_WS__c, 'attivo' );
            }
            if(ni.isEMpty()){
                OM_GW_GE_Utils.caseOriginale.EOF_Codice_Errore__c='B_K4';
                OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Identificativo Building Errato';
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito KO'; 
                OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                //update OM_GW_GE_Utils.caseOriginale;
                create_notify(5, 'KO'); 
                //AA 28/01/2019 - Nuova gestione vendibilità
                if(!OM_GW_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                    //Inserisco i log di vendibilità
                    insert OM_GW_GE_Utils.vendLogLst;                
                }
                return; 
            }
            
            //creo la lista ordinata degli stati building positivi
            /*List<Integer> positivi = new List<Integer>();
            positivi.add(110);
            positivi.add(104);
            positivi.add(105);
            positivi.add(107);
            positivi.add(109);
            
            //creo la lista ordinata degli stati building negativi
            List<Integer> negativi = new List<Integer>();
            negativi.add(101);
            negativi.add(102);
            negativi.add(103);
            negativi.add(106);          
            negativi.add(108);*/
            //AA - I valori delle liste positive e negative verranno recuperati tramite custom setting
            List<Integer> positivi = new List<Integer>();
            for(Stato_Building_positivi__c pos : Stato_Building_positivi__c.getAll().values()){
                try{
                    positivi.add(Integer.valueOf(pos.Name));
                }catch(Exception e)    {
                    System.debug('***** Valore [' + pos.Name + '] non ammesso all\'interno del Custom Setting Stato_Building_positivi__c');
                }
            }
            List<Integer> negativi = new List<Integer>();
            for(Stato_Building_negativi__c pos : Stato_Building_negativi__c.getAll().values()){
                try{
                    negativi.add(Integer.valueOf(pos.Name));
                }catch(Exception e)    {
                    System.debug('***** Valore [' + pos.Name + '] non ammesso all\'interno del Custom Setting Stato_Building_negativi__c');
                }
            }                   
            boolean found=false;
            EOF_Network_Inventory__c corretto = new EOF_Network_Inventory__c();
            //ciclo per il controllo ordinato sugli stati building positivi
            for(Integer A : positivi){
                if(!found){
                    for(EOF_Network_Inventory__c n : ni){
                        if(n.EOF_Stato_Building__c == A){
                            corretto = n;
                            found=true;
                            break;
                        }
                    }
                }
                else{
                    break;
                }
            }
            if(!found){
                //ciclo per il controllo ordinato sugli stati building negativi
                for(Integer A : negativi){
                    if(!found){
                        for(EOF_Network_Inventory__c n : ni){
                            if(n.EOF_Stato_Building__c == A){
                                corretto = n;
                                found=true;
                                break;
                            }
                        }
                    }
                    else{
                        break;
                    }
                }
                if(!found){
                    //caso in cui lo stato building non è stato trovato in nessuna delle due liste
                    corretto=ni[0];
                } 
                OM_GW_GE_Utils.caseOriginale.EOF_Codice_Errore__c='B_K5';
                OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Building non RFC/RFA';
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                OM_GW_GE_Utils.caseOriginale.EOF_Stato_Building__c = corretto.EOF_Stato_Building__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Identificativo_del_POP__c = corretto.EOF_Pop__c;                          
                OM_GW_GE_Utils.caseOriginale.EOF_Istat_Provincia__c = corretto.EOF_Provincia__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Istat_Comune__c= corretto.EOF_Comune__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Particella_Toponomastica_WS__c = corretto.EOF_Particella_Top__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Indirizzo_WS__c = corretto.EOF_Indirizzo__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Numero_Civico_WS__c = corretto.EOF_Civico__c;
                //OM_GW_GE_Utils.caseOriginale.EOF_ID_Building_WS__c = corretto.EOF_ID_Building__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Scala_Palazzina_WS__c = corretto.EOF_Scala_Palazzina__c; 
                //update OM_GW_GE_Utils.caseOriginale;
                create_notify(5, 'KO');
                //AA 28/01/2019 - Nuova gestione vendibilità
                if(!OM_GW_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                    //Inserisco i log di vendibilità
                    insert OM_GW_GE_Utils.vendLogLst;                
                } 
                return; 
            }
            else{
                //caso in cui è stato trovato nella lista degli stati building positivi
                //aggiungo il check bypassa sla per eventuali bonifiche
                if(!OM_GW_GE_Utils.caseOriginale.OF_bypassa_SLA__c){
                   if(((corretto.EOF_Stato_Building__c == 110 && OM_GW_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c < RFA.date()) || (corretto.EOF_Stato_Building__c != 110 && OM_GW_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c < RFC.date())) && !superProgettoSpeciale){
                        OM_GW_GE_Utils.caseOriginale.EOF_Codice_Errore__c='A_K3';
                        OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Data Attesa Consegna non conforme agli SLA';
                        OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                        OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                        OM_GW_GE_Utils.caseOriginale.EOF_Stato_Building__c = corretto.EOF_Stato_Building__c;
                        OM_GW_GE_Utils.caseOriginale.EOF_Identificativo_del_POP__c = corretto.EOF_Pop__c;                          
                        OM_GW_GE_Utils.caseOriginale.EOF_Istat_Provincia__c = corretto.EOF_Provincia__c;
                        OM_GW_GE_Utils.caseOriginale.EOF_Istat_Comune__c= corretto.EOF_Comune__c;
                        OM_GW_GE_Utils.caseOriginale.EOF_Particella_Toponomastica_WS__c = corretto.EOF_Particella_Top__c;
                        OM_GW_GE_Utils.caseOriginale.EOF_Indirizzo_WS__c = corretto.EOF_Indirizzo__c;
                        OM_GW_GE_Utils.caseOriginale.EOF_Numero_Civico_WS__c = corretto.EOF_Civico__c;
                        //OM_GW_GE_Utils.caseOriginale.EOF_ID_Building_WS__c = corretto.EOF_ID_Building__c;
                        OM_GW_GE_Utils.caseOriginale.EOF_Scala_Palazzina_WS__c = corretto.EOF_Scala_Palazzina__c;
                        //update OM_GW_GE_Utils.caseOriginale;
                        create_notify(5, 'KO'); 
                        //AA 28/01/2019 - Nuova gestione vendibilità
                        if(!OM_GW_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                            //Inserisco i log di vendibilità
                            insert OM_GW_GE_Utils.vendLogLst;                
                        }
                        return; 
                    } 
                }
                else{
                    //rimetto il valore di default
                    OM_GW_GE_Utils.caseOriginale.OF_bypassa_SLA__c=false;
                }
            }
            if(corretto.EOF_Pop__c != OM_GW_GE_Utils.caseOriginale.EOF_Identificativo_del_POP__c){ 
                OM_GW_GE_Utils.caseOriginale.EOF_Codice_Errore__c='B_K6';
                OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Associazione ID Building-POP errata';
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                OM_GW_GE_Utils.caseOriginale.EOF_Identificativo_del_POP__c = corretto.EOF_Pop__c;                          
                OM_GW_GE_Utils.caseOriginale.EOF_Istat_Provincia__c = corretto.EOF_Provincia__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Istat_Comune__c= corretto.EOF_Comune__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Particella_Toponomastica_WS__c = corretto.EOF_Particella_Top__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Indirizzo_WS__c = corretto.EOF_Indirizzo__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Numero_Civico_WS__c = corretto.EOF_Civico__c;
                //OM_GW_GE_Utils.caseOriginale.EOF_ID_Building_WS__c = corretto.EOF_ID_Building__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Scala_Palazzina_WS__c = corretto.EOF_Scala_Palazzina__c;
                OM_GW_GE_Utils.caseOriginale.EOF_Stato_Building__c = corretto.EOF_Stato_Building__c; 
                //update OM_GW_GE_Utils.caseOriginale;
                create_notify(5, 'KO'); 
                //AA 28/01/2019 - Nuova gestione vendibilità
                if(!OM_GW_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                    //Inserisco i log di vendibilità
                    insert OM_GW_GE_Utils.vendLogLst;                
                }
                return; 
            } 
            OM_GW_GE_Utils.caseOriginale.EOF_Identificativo_del_POP__c = corretto.EOF_Pop__c;                          
            OM_GW_GE_Utils.caseOriginale.EOF_Istat_Provincia__c = corretto.EOF_Provincia__c;
            OM_GW_GE_Utils.caseOriginale.EOF_Istat_Comune__c= corretto.EOF_Comune__c;
            OM_GW_GE_Utils.caseOriginale.EOF_Particella_Toponomastica_WS__c = corretto.EOF_Particella_Top__c;
            OM_GW_GE_Utils.caseOriginale.EOF_Indirizzo_WS__c = corretto.EOF_Indirizzo__c;
            OM_GW_GE_Utils.caseOriginale.EOF_Numero_Civico_WS__c = corretto.EOF_Civico__c;
            //OM_GW_GE_Utils.caseOriginale.EOF_ID_Building_WS__c = corretto.EOF_ID_Building__c;
            OM_GW_GE_Utils.caseOriginale.EOF_Scala_Palazzina_WS__c = corretto.EOF_Scala_Palazzina__c;
            OM_GW_GE_Utils.caseOriginale.EOF_Stato_Building__c = corretto.EOF_Stato_Building__c; 
                 
            //CRM 02/05/2017 - aggiunto per la gestione delle notifiche riguradanti i controlli commerciali e contrattuali
            List<OF_ContrattoServizio__c> checkOpenStreamContract = [select id,name,OF_Contract__c from OF_ContrattoServizio__c 
                                                    where OF_Servizio__r.name='GPON Passiva' 
                                                    and OF_Contract__r.Status='Attivo'
                                                    AND OF_Contract__r.AccountId =: OM_GW_GE_Utils.caseOriginale.EOF_Account_OLO__c
                                                    AND OF_Contract__r.StartDate <: OM_GW_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c
                                                    AND OF_Contract__r.EndDate >: OM_GW_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c];
            if(checkOpenStreamContract.isEMpty()){
                OM_GW_GE_Utils.caseOriginale.EOF_Codice_Errore__c='B_K17';
                OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                create_notify(5,'KO');
                //AA 28/01/2019 - Nuova gestione vendibilità
                if(!OM_GW_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                    //Inserisco i log di vendibilità
                    insert OM_GW_GE_Utils.vendLogLst;                
                }
                return;
            }
            OM_GW_GE_Utils.caseOriginale.OF_IDContratto__c = checkOpenStreamContract[0].OF_Contract__c;
            //check città B_04
            List<OF_AreaGeograficaJunction__c> checkCityCOntract =[select id from OF_AreaGeograficaJunction__c 
                                                                where OF_Contratto__c =:checkOpenStreamContract[0].OF_Contract__c
                                                                AND OF_AreaGeografica__r.OF_Istat__c=:OM_GW_GE_Utils.caseOriginale.EOF_Istat_Comune__c];
            if(checkCityCOntract.isEMpty()){
                OM_GW_GE_Utils.caseOriginale.EOF_Codice_Errore__c='B_K16';
                OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Città/POP non vendibile per l\'OLO';
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                create_notify(5,'KO');
                //AA 28/01/2019 - Nuova gestione vendibilità
                if(!OM_GW_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                    //Inserisco i log di vendibilità
                    insert OM_GW_GE_Utils.vendLogLst;                
                }
                return;
            }
            /*
            String check = null;
            OF_UtilitiesManageOrderFromCase obj = new OF_UtilitiesManageOrderFromCase(); 
            check = obj.VerificheCommContratt1(OM_GW_GE_Utils.caseOriginale);
            ////system.debug('DG_OM_GW_Utils dopo le verifiche--- check: ' + check);
            OM_GW_GE_Utils.caseOriginale.OF_IDContratto__c = obj.getIDContratto();
            ////system.debug('DG_OM_GW_Utils - OM_GW_GE_Utils.caseOriginale.OF_IDContratto__c: ' + OM_GW_GE_Utils.caseOriginale.OF_IDContratto__c);
            //se check = true   --> le verifiche sono passate
            //se check = false  --> le verifiche non sono passate
            if(check == 'B_K17'){
                OM_GW_GE_Utils.caseOriginale.EOF_Codice_Errore__c='B_K17';
                OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                create_notify(5,'KO');
                return;
            }
            if(check == 'B_K16'){
                OM_GW_GE_Utils.caseOriginale.EOF_Codice_Errore__c='B_K16';
                OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Città/POP non vendibile per l\'OLO';
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                create_notify(5,'KO');
                return;
            }   
            */
        OM_GW_GE_Utils.checkCliente=true;              
        if(String.isBlank(OM_GW_GE_Utils.slOrig.EOF_Nome_Cliente__c)){                        
            //Recordtype rt = [SELECT Id FROM RecordType WHERE Name = 'Cliente Business'];
            OM_GW_GE_Utils.cliente = new Account(Name = OM_GW_GE_Utils.slOrig.EOF_cognome_Cliente__c,
                                    RecordTypeId = OM_GW_GE_Utils.RTMap.get('Cliente_Business'),
                                    Phone = OM_GW_GE_Utils.slOrig.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                    EOF_Comune__c = OM_GW_GE_Utils.slOrig.EOF_COMUNE__c,
                                    EOF_Particella_Toponomastica__c = OM_GW_GE_Utils.slOrig.EOF_PARTICELLA_TOPONOMASTICA__c,
                                    EOF_Indirizzo__c = OM_GW_GE_Utils.slOrig.EOF_INDIRIZZO__c,
                                    EOF_Numero_Civico__c = OM_GW_GE_Utils.slOrig.EOF_NUMERO_CIVICO__c,
                                    EOF_Provincia__c = OM_GW_GE_Utils.slOrig.EOF_PROVINCIA__c,
                                    EOF_Phone_2__c = OM_GW_GE_Utils.slOrig.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
                                    
        }
        else{
            //Recordtype rt = [SELECT Id FROM RecordType WHERE Name = 'Person Account'];
                OM_GW_GE_Utils.cliente = new Account(FirstName = OM_GW_GE_Utils.slOrig.EOF_NOME_CLIENTE__c,
                                        LastName = OM_GW_GE_Utils.slOrig.EOF_COGNOME_CLIENTE__c,
                                        RecordTypeId = OM_GW_GE_Utils.RTMap.get('PersonAccount'),
                                        Phone = OM_GW_GE_Utils.slOrig.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                        EOF_Comune__c = OM_GW_GE_Utils.slOrig.EOF_COMUNE__c,
                                        EOF_Particella_Toponomastica__c = OM_GW_GE_Utils.slOrig.EOF_PARTICELLA_TOPONOMASTICA__c,
                                        EOF_Indirizzo__c = OM_GW_GE_Utils.slOrig.EOF_INDIRIZZO__c,
                                        EOF_Numero_Civico__c = OM_GW_GE_Utils.slOrig.EOF_NUMERO_CIVICO__c,
                                        EOF_Provincia__c = OM_GW_GE_Utils.slOrig.EOF_PROVINCIA__c,
                                        EOF_Phone_2__c = OM_GW_GE_Utils.slOrig.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
            
        }            
             
            //Using Technician required information in the request to retrieve the Account in the system
            List<Contact> tech = [SELECT Id, FirstName, LastName, Phone, Email FROM Contact WHERE 
                                  FirstName =: OM_GW_GE_Utils.slOrig.EOF_NOME_REFERENTE_TECNICO_OLO__c AND LastName =: OM_GW_GE_Utils.slOrig.EOF_COGNOME_REFERENTE_TECNICO_OLO__c 
                                  AND Phone =: OM_GW_GE_Utils.slOrig.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c AND Email =: OM_GW_GE_Utils.slOrig.EOF_EMAIL_REFERENTE_TECNICO_OLO__c];  
            if(!tech.isEmpty()){
                OM_GW_GE_Utils.caseOriginale.EOF_Contact__c = tech.get(0).Id;                   
            }
            else{ 
                //Recordtype pa = [select Id from recordtype where name='Referente Tecnico OLO'];
                OM_GW_GE_Utils.refTec = new COntact();
                OM_GW_GE_Utils.refTec.RecordTypeId = OM_GW_GE_Utils.RTMap.get('Referente_Tecnico_OLO');
                OM_GW_GE_Utils.refTec.AccountId=oloId.OF_Olo_Id__c;
                OM_GW_GE_Utils.refTec.FirstName =OM_GW_GE_Utils.slOrig.EOF_NOME_REFERENTE_TECNICO_OLO__c;
                OM_GW_GE_Utils.refTec.LastName = OM_GW_GE_Utils.slOrig.EOF_COGNOME_REFERENTE_TECNICO_OLO__c;
                OM_GW_GE_Utils.refTec.Phone = OM_GW_GE_Utils.slOrig.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;
                OM_GW_GE_Utils.refTec.Email = OM_GW_GE_Utils.slOrig.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
                OM_GW_GE_Utils.checkRefTec=true;
            }
                                       
                    
            //Asynchronous check on case field request                                        
            OM_GW_GE_Utils.caseOriginale.EOF_Async_Check_ctrl__c = true;
            OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito'; 
            OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'Da lavorare';                    
            
            //campi nuovi 05/04/2017
            List<OF_ElencoComuniItaliani__c> cList = new List<OF_ElencoComuniItaliani__c>();
            cList=[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.EOF_Comune__c];
            if (!cList.isEmpty()){
                if(String.isNotBlank(cList[0].OF_Comune__c)){
                    OM_GW_GE_Utils.caseOriginale.EOF_Comune_WS__c=cList[0].OF_Comune__c;
                }
                if(String.isNotBlank(cList[0].OF_Provincia__c)){
                    OM_GW_GE_Utils.caseOriginale.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
                }
            }
            //update OM_GW_GE_Utils.caseOriginale;
            create_notify(5, 'OK');
            //AA 28/01/2019 - Nuova gestione vendibilità
            if(!OM_GW_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                //Inserisco i log di vendibilità
                insert OM_GW_GE_Utils.vendLogLst;                
            }
            return;
        } 
                        
        //Cessation
        if(OM_GW_GE_Utils.caseOriginale.recordtype.developername == 'EOF_Caso_Cessazione'){
                        
            if(String.isNotBlank(OM_GW_GE_Utils.slOrig.EOF_COGNOME_CLIENTE__c)) { 
                
                if(String.isBlank(OM_GW_GE_Utils.slOrig.EOF_NOME_CLIENTE__c)){                        
                    //Recordtype rt = [SELECT Id FROM RecordType WHERE Name = 'Cliente Business'];
                    OM_GW_GE_Utils.cliente = new Account(Name = OM_GW_GE_Utils.slOrig.EOF_COGNOME_CLIENTE__c,
                                            RecordTypeId = OM_GW_GE_Utils.RTMap.get('Cliente_Business'),
                                            Phone = OM_GW_GE_Utils.slOrig.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                            EOF_Comune__c = OM_GW_GE_Utils.slOrig.EOF_COMUNE__c,
                                            EOF_Particella_Toponomastica__c = OM_GW_GE_Utils.slOrig.EOF_PARTICELLA_TOPONOMASTICA__c,
                                            EOF_Indirizzo__c = OM_GW_GE_Utils.slOrig.EOF_INDIRIZZO__c,
                                            EOF_Numero_Civico__c = OM_GW_GE_Utils.slOrig.EOF_NUMERO_CIVICO__c,
                                            EOF_Provincia__c = OM_GW_GE_Utils.slOrig.EOF_PROVINCIA__c,
                                            EOF_Phone_2__c = OM_GW_GE_Utils.slOrig.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
                                            
                }
                else{
                    //Recordtype rt = [SELECT Id FROM RecordType WHERE Name = 'Person Account'];
                    OM_GW_GE_Utils.cliente = new Account(FirstName = OM_GW_GE_Utils.slOrig.EOF_NOME_CLIENTE__c,
                                            LastName = OM_GW_GE_Utils.slOrig.EOF_COGNOME_CLIENTE__c,
                                            RecordTypeId = OM_GW_GE_Utils.RTMap.get('PersonAccount'),
                                            Phone = OM_GW_GE_Utils.slOrig.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                            EOF_Comune__c = OM_GW_GE_Utils.slOrig.EOF_COMUNE__c,
                                            EOF_Particella_Toponomastica__c = OM_GW_GE_Utils.slOrig.EOF_PARTICELLA_TOPONOMASTICA__c,
                                            EOF_Indirizzo__c = OM_GW_GE_Utils.slOrig.EOF_INDIRIZZO__c,
                                            EOF_Numero_Civico__c = OM_GW_GE_Utils.slOrig.EOF_NUMERO_CIVICO__c,
                                            EOF_Provincia__c = OM_GW_GE_Utils.slOrig.EOF_PROVINCIA__c,
                                            EOF_Phone_2__c = OM_GW_GE_Utils.slOrig.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
                   
                }            
            } 
           
           List<Asset> a = [SELECT Id, EOF_ID_Risorsa__c, Status, Account.EOF_Codice_Operatore__c, Name, EOF_OLO__C, OF_Comune__c, OF_Contract__c FROM Asset WHERE EOF_ID_Risorsa__c =: OM_GW_GE_Utils.slOrig.EOF_ID_RISORSA__c
                            and (recordtype.developername='OF_GPONPassiva' or recordtype.developername='Risorsa') ];
           system.debug('Alessandro: '+a);  
           system.debug('Alessandro: '+OM_GW_GE_Utils.slOrig.EOF_ID_RISORSA__c);

           if(a.isempty() || a[0].Status=='Cessato' || (OM_GW_GE_Utils.slOrig.EOF_codice_operatore__c!=a[0].Account.EOF_Codice_Operatore__c && OM_GW_GE_Utils.slOrig.EOF_codice_operatore__c!=a[0].EOF_OLO__C)){
                OM_GW_GE_Utils.caseOriginale.EOF_Codice_Errore__c='C_K13';
                OM_GW_GE_Utils.caseOriginale.Status = 'Cessato KO';
                OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';  
                OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'ID Risorsa da cessare inesistente/errato';
                //update OM_GW_GE_Utils.caseOriginale; 
                create_notify(12, 'KO');                       
           } 
            else{ 
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                OM_GW_GE_Utils.caseOriginale.EOF_Fase__c = 'Da lavorare'; 
                OM_GW_GE_Utils.caseOriginale.AssetId=a[0].Id;
                //AA Aggiunto contract id necessario per la cessazione
                OM_GW_GE_Utils.caseOriginale.OF_IDContratto__c = a[0].OF_Contract__c;
                //CRM 29-03-2017 - Aggiunti campi
                OM_GW_GE_Utils.caseOriginale.EOF_Apparato__c = OM_GW_GE_Utils.slOrig.EOF_APPARATO__c;
                //END CRM
                //update OM_GW_GE_Utils.caseOriginale;
                //valorizzo la varibile statica assetComune per poi inviarla ad OM
                OM_GW_GE_Utils.assetComune=a[0].OF_Comune__c;
                
                //richiamo il metodo per l'invio ad OM
                OM_GW_Utils.createAckNackNotifyServiceLog_CM_SOA(OM_GW_GE_Utils.caseOriginale);
                /*
                //inserisco il campo comune preso dall'Asset
                    fr.COMUNE=OM_GW_Utils.assetComune;
                    //inserisco il service log della fiberrequest verso OM
                    EOF_EAI_Service_Log__c sl2 = OM_GW_GE_Utils.create_EAI_Log(fr);
                    sl2.EOF_TIpo_comunicazione_String__c='SF->OM - FiberRequest - Cessazione';
                    sl2.caso__c=c.Id;
                    sl2.EOF_Codice_Ordine_EOF__c=Id.valueOf(OM_GW_GE_Utils.caseOriginale.Id);
                    
                    list<EOF_EAI_Service_Log__c> sl = new list<EOF_EAI_Service_Log__c>();
                    //sl.add(sl1);
                    //sl.add(sl2);
                    insert sl2;
                    //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----                       
                    //if(OM_GW_GE_Utils.caseOriginale.EOF_Fase__c == 'Da lavorare')
                    //createAckNackNotifyServiceLog(notify.Id+'');
                    createAckNackNotifyServiceLog_CM_SOA(sl2.Id, '11', 'Delete', 'test', 'test');
                */
            }
            //Alessandro: parte da bypassare
            //CRM 04/05/2017 aggiunto aggiornamento service log per far scattare il process builder e popolare le date dei BE
            list<EOF_EAI_Service_log__c> slog = [select id, EOF_NOTE__c,EOF_Tipo_Comunicazione__c, caso__c, caso__r.assetid from EOF_EAI_Service_log__c where caso__c =: OM_GW_GE_Utils.caseOriginale.id and EOF_Tipo_Comunicazione__c = '11' limit 1];
            ////system.debug('DG_OM_GW_Utils slog');
            if(!slog.isempty()){
                ////system.debug('DG_OM_GW_Utils dentro if slog: ' + slog);
                update slog;
            }
                    //END CRM
        }   
        
      }
    //sincrona utilizzata per cessazione KO e acquisizione OK/KO dopo i controlli asincroni
    public static void create_notify(Integer notify_type, String objectStatus){     
         
        //Acquisition notify 
        if(notify_type == 5){
            //faccio il check sugli amministratori
            OM_GW_GE_Utils.checkAmministratori(OM_GW_GE_Utils.caseOriginale);
            
            if(objectStatus == 'OK'){              
                OM_GW_GE_Utils.notifica = new EOF_Notify__c(
                    RecordTypeId = OM_GW_GE_Utils.RTMap.get('Notifica_di_acquisizione'),
                    Caso__c = OM_GW_GE_Utils.caseOriginale.id,                    
                    EOF_Codice_Operatore__c = OM_GW_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c,
                    EOF_Codice_Ordine_EOF__c = OM_GW_GE_Utils.caseOriginale.Codice_Ordine_EOF__c,                        
                    EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                      
                    EOF_Stato_Richiesta__c = objectStatus,
                    EOF_Data_Notifica__c = system.now(),
                    //EOF_Inviata__c = false,
                    Updated__c = true
                );                    
                          
                //insert notify;
                //inserisco il service log della notifica all'olo
                OM_GW_GE_Utils.slSFOLO = OM_GW_GE_Utils.create_Log_Acquisizione_Cessazione_To_OLO(OM_GW_GE_Utils.caseOriginale,'OK');
                OM_GW_GE_Utils.slSFOLO.EOF_TIpo_comunicazione_String__c='SF->OLO - FiberNotify - Acquisizione OK';
                //sl1.notify__C=notify.Id;
                
                /*
                //inserisco il service log della fiberrequest verso OM
                EOF_EAI_Service_Log__c sl2 = OM_GW_GE_Utils.create_EAI_Log(fr, OM_GW_GE_Utils.caseOriginale.Id, OM_GW_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c );
                sl2.EOF_TIpo_comunicazione_String__c='SF->OM - FiberRequest - Attivazione';
                //la slego dal case per poi aggiornarla dopo ACK olo
                sl2.caso__c=null;
                list<EOF_EAI_Service_Log__c> sl = new list<EOF_EAI_Service_Log__c>();
                sl.add(sl1);
                sl.add(sl2);
                insert sl;
                */
                               
                //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----                            
                createAckNackNotifyServiceLog(OM_GW_GE_Utils.slSFOLO); 
                
            } 
            else{  
               
                //creo la notifica
                OM_GW_GE_Utils.notifica = new EOF_Notify__c(
                    RecordTypeId = OM_GW_GE_Utils.RTMap.get('Notifica_di_acquisizione_KO'),
                    Caso__c = OM_GW_GE_Utils.caseOriginale.id,
                    EOF_Codice_Operatore__c = OM_GW_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c,
                    EOF_Codice_Ordine_EOF__c = Id.valueOf(OM_GW_GE_Utils.caseOriginale.id),
                    EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                        
                    EOF_Stato_Richiesta__c = objectStatus,    
                    Motivo_Rifiuto_Sospensione_Annullamento__c = OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c,                      
                    //Motivo_Rifiuto_Sospensione_Annullamento__c = 'Identificativo Building Errato',
                    EOF_Data_Notifica__c = system.now(),
                    //EOF_Inviata__c = false,
                    Updated__c = true
                );
                      
                //inserisco il service log della notifica all'olo
                OM_GW_GE_Utils.slSFOLO = OM_GW_GE_Utils.create_Log_Acquisizione_Cessazione_To_OLO(OM_GW_GE_Utils.caseOriginale,'KO');
                OM_GW_GE_Utils.slSFOLO.EOF_TIpo_comunicazione_String__c='SF->OLO - FiberNotify - Acquisizione KO';
                //sl1.notify__C=notify.Id;
                
                /*
                //inserisco il service log della fiberrequest verso OM e aggiungo i campi di errore
                fr.CAUSALE_RICHIESTA_ANNULLAMENTO=notify.Motivo_Rifiuto_Sospensione_Annullamento__c;
                fr.CODICE_RICHIESTA_ANNULLAMENTO=errorCode;
                EOF_EAI_Service_Log__c sl2 = OM_GW_GE_Utils.create_EAI_Log(fr);
                sl2.EOF_TIpo_comunicazione_String__c='SF->OM - FiberRequest - Attivazione';
                sl2.caso__c=null;
                list<EOF_EAI_Service_Log__c> sl = new list<EOF_EAI_Service_Log__c>();
                sl.add(sl1);
                sl.add(sl2);
                insert sl;
                */
                                
                //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                createAckNackNotifyServiceLog(OM_GW_GE_Utils.slSFOLO);

            }
            //END CRM                
                           
        }  
        
        
        //Cessation notify 
        if(notify_type == 12){
            if(objectStatus == 'KO'){
                
                OM_GW_GE_Utils.notifica = new EOF_Notify__c(
                    RecordTypeId = OM_GW_GE_Utils.RTMap.get('Notifica_di_cessazione_KO'),
                    Caso__c = OM_GW_GE_Utils.caseOriginale.id, 
                    EOF_Codice_Operatore__c = OM_GW_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c,
                    EOF_Codice_Ordine_EOF__c = Id.valueOf(OM_GW_GE_Utils.caseOriginale.Id),
                    EOF_ID_Notifica__c = String.valueOf(system.now().getTime()), 
                    Motivo_Rifiuto_Sospensione_Annullamento__c = OM_GW_GE_Utils.caseOriginale.EOF_Causale_Errore__c,
                    EOF_Stato_Richiesta__c = objectStatus,                      
                    EOF_Data_Notifica__c = system.now(),            
                    //EOF_Inviata__c = false,
                    Updated__c = true
                );
                //Debug level only --- In practical cases, notifies will be always correctly generated
           
                //insert notify;
                //inserisco il service log della notifica all'olo
                OM_GW_GE_Utils.slSFOLO = OM_GW_GE_Utils.create_Log_Acquisizione_Cessazione_To_OLO(OM_GW_GE_Utils.caseOriginale,'KO');
                OM_GW_GE_Utils.slSFOLO.EOF_TIpo_comunicazione_String__c='SF->OLO - FiberNotify - Cessazione KO';
                //sl1.notify__C=notify.Id;
                
                /*
                //inserisco il service log della fiberrequest verso OM e aggiungo i campi di errore
                fr.CAUSALE_RICHIESTA_ANNULLAMENTO=notify.Motivo_Rifiuto_Sospensione_Annullamento__c;
                fr.CODICE_RICHIESTA_ANNULLAMENTO=errorCode;
                EOF_EAI_Service_Log__c sl2 = OM_GW_GE_Utils.create_EAI_Log(fr);
                sl2.EOF_TIpo_comunicazione_String__c='SF->OM - FiberRequest - Cessazione KO';
                sl2.caso__c=null;
                sl2.EOF_Codice_Ordine_EOF__c=Id.valueOf(OM_GW_GE_Utils.caseOriginale.Id);
                list<EOF_EAI_Service_Log__c> sl = new list<EOF_EAI_Service_Log__c>();
                sl.add(sl1);
                sl.add(sl2);
                insert sl;
                */
                                                
                //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                createAckNackNotifyServiceLog(OM_GW_GE_Utils.slSFOLO);

            }
            
        }            
    } 
      
    public static Map<String,String> create_map(EOF_EAI_Service_Log__c sl, String Operation, String Tipo_comunicazione){
        
        Map<String,String> field_map = new Map<String,String>();
        
        if(Operation == 'Create'){                            
            field_map.put('TIPO_COMUNICAZIONE', Tipo_comunicazione);                    
            field_map.put('CODICE_OPERATORE', sl.EOF_Codice_Operatore__c);            
            field_map.put('ID_NOTIFICA', sl.EOF_Id_Notifica__c);            
            field_map.put('IDENTIFICATIVO_DEL_POP', sl.EOF_Id_POP__c);            
            field_map.put('GPON_ATTESTAZIONE', sl.EOF_GPON_Attestazione__c);            
            field_map.put('GPON_VINCOLANTE', sl.EOF_GPON_Vincolante__c);            
            field_map.put('NOME_CLIENTE', sl.EOF_Nome_Cliente__c);            
            field_map.put('COGNOME_CLIENTE', sl.EOF_CogNome_Cliente__c);            
            field_map.put('RECAPITO_TELEFONICO_CLIENTE_1', sl.EOF_Recapito_Telefonico_Cliente_1__c);            
            field_map.put('RECAPITO_TELEFONICO_CLIENTE_2', sl.EOF_Recapito_Telefonico_Cliente_2__c);            
            field_map.put('PROVINCIA', sl.EOF_Provincia__c);            
            field_map.put('COMUNE', sl.EOF_Comune__c);            
            field_map.put('PARTICELLA_TOPONOMASTICA', sl.EOF_Particella_Toponomastica__c);
            field_map.put('INDIRIZZO', sl.EOF_Indirizzo__c);
            field_map.put('NUMERO_CIVICO', sl.EOF_Numero_Civico__c);
            field_map.put('ID_BUILDING', sl.EOF_ID_Building__c);
            field_map.put('SCALA_PALAZZINA', sl.EOF_Scala_Palazzina__c);
            field_map.put('NOME_REFERENTE_TECNICO_OLO', sl.EOF_NOME_REFERENTE_TECNICO_OLO__c);
            field_map.put('COGNOME_REFERENTE_TECNICO_OLO', sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c);
            field_map.put('TELEFONO_REFERENTE_TECNICO_OLO', sl.EOF_Telefono_Referente_Tecnico_OLO__c);
            field_map.put('EMAIL_REFERENTE_TECNICO_OLO', sl.EOF_Email_Referente_Tecnico_OLO__c);
            field_map.put('RECAPITO_TEST_LINEA', sl.EOF_Recapito_Test_Linea__c);
            field_map.put('NUMERO_TELEFONICO_PRINCIPALE_LINEA', sl.EOF_Numero_Telefonico_Principale_Linea__c);
            field_map.put('PASSWORD_APPARATO', sl.EOF_Password_Apparato__c);
            field_map.put('TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH', sl.EOF_Telefono_Referente_OLO_Onfield_Notec__c);
            field_map.put('OPZIONE_SYSTEM_UNICO', sl.EOF_Opzione_System_Unico__c);            
            field_map.put('APPARATO', sl.EOF_Apparato__c);
            field_map.put('TIPOLOGIA_APPARATO', sl.EOF_Tipologia_Apparato__c);
            field_map.put('PROGETTO_SPECIALE', sl.EOF_Progetto_Speciale__c);
            field_map.put('COLLEGAMENTO_P2P', sl.EOF_Collegamento_P2P__c);
            field_map.put('NOTE', sl.EOF_Note__c);
            field_map.put('TIPOLOGIA_SERVIZIO', sl.EOF_Tipologia_Servizio__c);
            field_map.put('SLA_PREMIUM_ASSURANCE', sl.EOF_SLA_Premium_Assurance__c);
            field_map.put('ORARIO_APPUNTAMENTO', sl.EOF_Orario_Appuntamento__c);
            field_map.put('SLA_DATE', String.valueOf(System.today())); // Not valid
            field_map.put('CODICE_ORDINE_EOF', sl.caso__c);
            field_map.put('CODICE_ORDINE_OLO', sl.eof_codice_ordine_olo__c);
            field_map.put('DATA_NOTIFICA', OM_GW_GE_Utils.DateToString(sl.eof_data_notifica__c));
            field_map.put('DATA_PREVISTA_ATTIVAZIONE', OM_GW_GE_Utils.dateToStringNoTime(sl.eof_DATA_PREVISTA_ATTIVAZIONE__c));
            field_map.put('CAUSALE_RICHIESTA_ANNULLAMENTO',sl.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c);
            field_map.put('CODICE_RICHIESTA_ANNULLAMENTO', sl.EOF_CODICE_RICHIESTA_ANNULLAMENTO__c);
        }else if(Operation == 'Delete'){
            field_map.put('TIPO_COMUNICAZIONE', Tipo_comunicazione);
            field_map.put('CODICE_OPERATORE', sl.EOF_Codice_Operatore__c);            
            field_map.put('ID_NOTIFICA', sl.EOF_Id_Notifica__c);
            field_map.put('ID_RISORSA', sl.EOF_Id_Risorsa__c);
            field_map.put('NOME_CLIENTE', sl.EOF_Nome_Cliente__c);            
            field_map.put('COGNOME_CLIENTE', sl.EOF_CogNome_Cliente__c);
            field_map.put('RECAPITO_TELEFONICO_CLIENTE_1', sl.EOF_Recapito_Telefonico_Cliente_1__c);
            field_map.put('RECAPITO_TELEFONICO_CLIENTE_2', sl.EOF_Recapito_Telefonico_Cliente_2__c);
            field_map.put('APPARATO', sl.EOF_Apparato__c);
            field_map.put('NOTE', sl.EOF_Note__c);
            field_map.put('CODICE_ORDINE_EOF', sl.caso__c);
            field_map.put('CODICE_ORDINE_OLO', sl.eof_codice_ordine_olo__c);
            field_map.put('CAUSALE_RICHIESTA_ANNULLAMENTO',sl.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c);
            field_map.put('CODICE_RICHIESTA_ANNULLAMENTO', sl.EOF_CODICE_RICHIESTA_ANNULLAMENTO__c);
        }else{
            field_map.put('TIPO_COMUNICAZIONE', Tipo_comunicazione);
            field_map.put('CODICE_OPERATORE', sl.EOF_Codice_Operatore__c);            
            field_map.put('ID_NOTIFICA', sl.EOF_Id_Notifica__c);
            field_map.put('NOME_CLIENTE', sl.EOF_Nome_Cliente__c);            
            field_map.put('COGNOME_CLIENTE', sl.EOF_CogNome_Cliente__c);
            field_map.put('RECAPITO_TELEFONICO_CLIENTE_1', sl.EOF_Recapito_Telefonico_Cliente_1__c);
            field_map.put('RECAPITO_TELEFONICO_CLIENTE_2', sl.EOF_Recapito_Telefonico_Cliente_2__c);
            field_map.put('NOME_REFERENTE_TECNICO_OLO', sl.EOF_NOME_REFERENTE_TECNICO_OLO__c);
            field_map.put('COGNOME_REFERENTE_TECNICO_OLO', sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c);
            field_map.put('TELEFONO_REFERENTE_TECNICO_OLO', sl.EOF_Telefono_Referente_Tecnico_OLO__c);
            field_map.put('EMAIL_REFERENTE_TECNICO_OLO', sl.EOF_Email_Referente_Tecnico_OLO__c);
            field_map.put('RECAPITO_TEST_LINEA', sl.EOF_Recapito_Test_Linea__c);
            field_map.put('NUMERO_TELEFONICO_PRINCIPALE_LINEA', sl.EOF_Numero_Telefonico_Principale_Linea__c);
            field_map.put('OPZIONE_SYSTEM_UNICO', sl.EOF_Opzione_System_Unico__c);        
            field_map.put('NOTE', sl.EOF_Note__c);
            field_map.put('ORARIO_APPUNTAMENTO', sl.EOF_Orario_Appuntamento__c);
            field_map.put('SLA_DATE', String.valueOf(System.today())); // Not valid
            field_map.put('CODICE_ORDINE_EOF', sl.caso__c);
            field_map.put('CODICE_ORDINE_OLO', sl.eof_codice_ordine_olo__c);
            field_map.put('CAUSALE_RICHIESTA_ANNULLAMENTO',sl.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c);
            field_map.put('CODICE_RICHIESTA_ANNULLAMENTO', sl.EOF_CODICE_RICHIESTA_ANNULLAMENTO__c);
            field_map.put('DATA_PREVISTA_ATTIVAZIONE', OM_GW_GE_Utils.dateToStringNoTime(sl.eof_DATA_PREVISTA_ATTIVAZIONE__c));
            
        }
        
        
        return field_map;
     }
     
     public static Map<String,String> create_map_Sync(EOF_EAI_Service_Log__c sl, String Operation, String Tipo_comunicazione,String codice_ordine_eof){
        
        Map<String,String> field_map = new Map<String,String>();
        
        if(Operation == 'Create'){                            
            field_map.put('TIPO_COMUNICAZIONE', Tipo_comunicazione);                    
            field_map.put('CODICE_OPERATORE', sl.EOF_Codice_Operatore__c);            
            field_map.put('ID_NOTIFICA', sl.EOF_Id_Notifica__c);            
            field_map.put('IDENTIFICATIVO_DEL_POP', sl.EOF_Id_POP__c);            
            field_map.put('GPON_ATTESTAZIONE', sl.EOF_GPON_Attestazione__c);            
            field_map.put('GPON_VINCOLANTE', sl.EOF_GPON_Vincolante__c);            
            field_map.put('NOME_CLIENTE', sl.EOF_Nome_Cliente__c);            
            field_map.put('COGNOME_CLIENTE', sl.EOF_CogNome_Cliente__c);            
            field_map.put('RECAPITO_TELEFONICO_CLIENTE_1', sl.EOF_Recapito_Telefonico_Cliente_1__c);            
            field_map.put('RECAPITO_TELEFONICO_CLIENTE_2', sl.EOF_Recapito_Telefonico_Cliente_2__c);            
            field_map.put('PROVINCIA', sl.EOF_Provincia__c);            
            field_map.put('COMUNE', sl.EOF_Comune__c);            
            field_map.put('PARTICELLA_TOPONOMASTICA', sl.EOF_Particella_Toponomastica__c);
            field_map.put('INDIRIZZO', sl.EOF_Indirizzo__c);
            field_map.put('NUMERO_CIVICO', sl.EOF_Numero_Civico__c);
            field_map.put('ID_BUILDING', sl.EOF_ID_Building__c);
            field_map.put('SCALA_PALAZZINA', sl.EOF_Scala_Palazzina__c);
            field_map.put('NOME_REFERENTE_TECNICO_OLO', sl.EOF_NOME_REFERENTE_TECNICO_OLO__c);
            field_map.put('COGNOME_REFERENTE_TECNICO_OLO', sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c);
            field_map.put('TELEFONO_REFERENTE_TECNICO_OLO', sl.EOF_Telefono_Referente_Tecnico_OLO__c);
            field_map.put('EMAIL_REFERENTE_TECNICO_OLO', sl.EOF_Email_Referente_Tecnico_OLO__c);
            field_map.put('RECAPITO_TEST_LINEA', sl.EOF_Recapito_Test_Linea__c);
            field_map.put('NUMERO_TELEFONICO_PRINCIPALE_LINEA', sl.EOF_Numero_Telefonico_Principale_Linea__c);
            field_map.put('PASSWORD_APPARATO', sl.EOF_Password_Apparato__c);
            field_map.put('TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH', sl.EOF_Telefono_Referente_OLO_Onfield_Notec__c);
            field_map.put('OPZIONE_SYSTEM_UNICO', sl.EOF_Opzione_System_Unico__c);            
            field_map.put('APPARATO', sl.EOF_Apparato__c);
            field_map.put('TIPOLOGIA_APPARATO', sl.EOF_Tipologia_Apparato__c);
            field_map.put('PROGETTO_SPECIALE', sl.EOF_Progetto_Speciale__c);
            field_map.put('COLLEGAMENTO_P2P', sl.EOF_Collegamento_P2P__c);
            field_map.put('NOTE', sl.EOF_Note__c);
            field_map.put('TIPOLOGIA_SERVIZIO', sl.EOF_Tipologia_Servizio__c);
            field_map.put('SLA_PREMIUM_ASSURANCE', sl.EOF_SLA_Premium_Assurance__c);
            field_map.put('ORARIO_APPUNTAMENTO', sl.EOF_Orario_Appuntamento__c);
            field_map.put('SLA_DATE', String.valueOf(System.today())); // Not valid
            field_map.put('CODICE_ORDINE_EOF', codice_ordine_eof);
            field_map.put('CODICE_ORDINE_OLO', sl.eof_codice_ordine_olo__c);
            field_map.put('DATA_NOTIFICA', OM_GW_GE_Utils.DateToString(sl.eof_data_notifica__c));
            field_map.put('DATA_PREVISTA_ATTIVAZIONE', OM_GW_GE_Utils.dateToStringNoTime(sl.eof_DATA_PREVISTA_ATTIVAZIONE__c));
            field_map.put('CAUSALE_RICHIESTA_ANNULLAMENTO',sl.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c);
            field_map.put('CODICE_RICHIESTA_ANNULLAMENTO', sl.EOF_CODICE_RICHIESTA_ANNULLAMENTO__c);
        }if(Operation == 'Delete'){
            field_map.put('TIPO_COMUNICAZIONE', Tipo_comunicazione);
            field_map.put('CODICE_OPERATORE', sl.EOF_Codice_Operatore__c);            
            field_map.put('ID_NOTIFICA', sl.EOF_Id_Notifica__c);
            field_map.put('ID_RISORSA', sl.EOF_Id_Risorsa__c);
            field_map.put('NOME_CLIENTE', sl.EOF_Nome_Cliente__c);            
            field_map.put('COGNOME_CLIENTE', sl.EOF_CogNome_Cliente__c);
            field_map.put('RECAPITO_TELEFONICO_CLIENTE_1', sl.EOF_Recapito_Telefonico_Cliente_1__c);
            field_map.put('RECAPITO_TELEFONICO_CLIENTE_2', sl.EOF_Recapito_Telefonico_Cliente_2__c);
            field_map.put('APPARATO', sl.EOF_Apparato__c);
            field_map.put('NOTE', sl.EOF_Note__c);
            field_map.put('CODICE_ORDINE_EOF', codice_ordine_eof);
            field_map.put('CODICE_ORDINE_OLO', sl.eof_codice_ordine_olo__c);
            field_map.put('CAUSALE_RICHIESTA_ANNULLAMENTO',sl.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c);
            field_map.put('CODICE_RICHIESTA_ANNULLAMENTO', sl.EOF_CODICE_RICHIESTA_ANNULLAMENTO__c);
        }
        
        return field_map;
     }
    
    //------------Metodo per l'invio dell'acquisizione OK/KO e cessazione KO (notifiche asincrone gestite automaticamente su SF)---------------------
    public static void createAckNackNotifyServiceLog(EOF_EAI_Service_Log__c sl){
        //Alessandro: vedere quali campi passiamo e in caso come modificarli (in particolare le formule che non si sono perche non li abbiamo inseriti)   
        
        xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType response;

        //metodo per ripristinare in caso di locked row
        if(OM_GW_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
            response = new xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();
            response.Esito='0';
        }
        else{
            xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 stub = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();          
                  
            response = new xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();
            
            //set timeout
            stub.timeout_x = 30000;
            
            //Invoking the callout with corresponding parameters
            response = stub.Notify(sl.EOF_Codice_Operatore__c,                
                                        sl.EOF_Tipo_Comunicazione__c, 
                                        sl.EOF_Codice_Ordine_OLO__c,
                                        sl.EOF_Codice_Ordine_EOF__c,                                                                        
                                        sl.EOF_ID_Notifica__c,
                                        sl.EOF_Stato_Richiesta__c,
                                        null,
                                        sl.EOF_Cod_Rifiuto_Sospensione_Annullamento__c,
                                        sl.EOF_Mot_Rifiuto_Sospensione_Annullamento__c,
                                        null,
                                        null,
                                        OM_GW_GE_Utils.DateToString(sl.EOF_Data_Notifica__c),
                                        null,
                                        null,
                                        null,
                                        null, 
                                        null,
                                        null,
                                        null,
                                        null,
                                        null,
                                        null,
                                        null);
        }

        ////system.debug('The value of response--' + response);
        //Creating EAI_Service_Logs based on the response
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        //aggiungo la stringa che identifica il tipo di comunicazione
        String s = '';
        String processo='';
        if(sl.EOF_Tipo_Comunicazione__c=='5'){
            processo='Attivazione';
            if(sl.EOF_Stato_Richiesta__c=='0'){
                s='Acquisizione OK';
            }
            else{
                s='Acquisizione KO';
            }
        }
        else{ 
            processo='Cessazione';
            s='Cessazione KO';
        }
        if(Integer.valueOf(response.Esito) == 0){
            OM_GW_GE_Utils.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - FiberNotify - '+s,
            EOF_Tipo_comunicazione__c=sl.EOF_Tipo_Comunicazione__c,
            Caso__c = sl.Caso__c,
            RecordTypeId = OM_GW_GE_Utils.rtMap.get('ACK'),
            //Notify__c = notifyRec.id,
            EOF_Richiesta_Notifica__c =  'Esito: '+ response.Esito,     
            EOF_ID_Notifica__c = sl.EOF_ID_Notifica__c,
            EOF_Codice_Ordine_OLO__c = sl.EOF_Codice_Ordine_OLO__c,
            EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
            EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c       
            ); 
            
            //setto l'ACK sul sl originario
            OM_GW_GE_Utils.slSFOLO.EOF_Response__c='ACK';
            
            //setto l'ACK sul case
            OM_GW_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='ACK';
            
            //avendo ricevuto ACK vado a chiamare OM 
            OM_GW_Utils.createAckNackNotifyServiceLog_CM_SOA(OM_GW_GE_Utils.caseOriginale);
        }
        else{
            OM_GW_GE_Utils.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - FiberNotify - '+s,
            EOF_Tipo_comunicazione__c=sl.EOF_Tipo_Comunicazione__c,
            Caso__c = sl.Caso__c,
            RecordTypeId = OM_GW_GE_Utils.rtMap.get('NACK'),
            //Notify__c = notifyRec.id,
            EOF_Richiesta_Notifica__c = 'Esito: '+ response.Esito + '\n' + 'Codice errore: ' + 
                                             response.CodiceErrore + '\n' + 'Causale errore: ' +
                                             response.CausaleErrore,  
            EOF_Codice_errore__c=response.CodiceErrore,
            EOF_Causale_Errore__c=response.CausaleErrore,     
 
            EOF_ID_Notifica__c = sl.EOF_ID_Notifica__c,
            EOF_Codice_Ordine_OLO__c = sl.EOF_Codice_Ordine_OLO__c,
            EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
            EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c       
           ); 
               
           //setto il NACK sul sl originario
           OM_GW_GE_Utils.slSFOLO.EOF_Response__c='NACK';
           OM_GW_GE_Utils.slSFOLO.EOF_Codice_errore__c=response.CodiceErrore;
           
           //setto il NACK sul case
           if(response.CodiceErrore=='A_K4' || response.CodiceErrore=='100' || response.CodiceErrore=='200'){
                OM_GW_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='NACK TECNICO';
           }
           else{
                OM_GW_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='NACK';
           }
           
           //se ricevo NACK committo i dati a sistema e poi riproverò con il retry 
           if(!OM_GW_GE_Utils.retryToOLO){
                OM_GW_GE_Utils.aggiornamentoDatiAcquisizione(processo,sl.EOF_Stato_Richiesta__c,OM_GW_GE_Utils.slSFOLO.EOF_Response__c);
           }
           //se ho ricevuto nuovamente NACK con il retry salvo solo i dati significativi
           else{
                update OM_GW_GE_Utils.caseOriginale;
                update OM_GW_GE_Utils.slSFOLO;
                OM_GW_GE_Utils.slSFOLOResp.EOF_Retry__c=true;
                //metto la reference alla notifica, la reference al slPrincipale e inserisco la response
                OM_GW_GE_Utils.slSFOLOresp.notify__C=OM_GW_GE_Utils.slSFOLO.notify__C;
                OM_GW_GE_Utils.slSFOLOresp.EOF_SL_Riferimento__c=OM_GW_GE_Utils.slSFOLO.Id;
                insert OM_GW_GE_Utils.slSFOLOResp;
           }
        }
                        
    }
    
    //------------Rimodulazione DAC, Desospensione a annullamento verso OM---------------------
    public static map<String,EOF_EAI_Service_Log__C> createAckNackNotifyServiceLog_CM_OM(EOF_EAI_Service_Log__C sl, String orderId, String OrderNo, String Tipo_comunicazione){

                
        Map<String,String> field_map = create_map(sl, 'Amend', Tipo_comunicazione);
        
        xmlnsEnelItOloGatwayWsdlConcreteCOM.InstantLinkSOAEndpoint1 stub = new  xmlnsEnelItOloGatwayWsdlConcreteCOM.InstantLinkSOAEndpoint1();         
              
        xmlnsEnelItOloGatwaySincronizzazionCOM.orderAmendInfo response = new xmlnsEnelItOloGatwaySincronizzazionCOM.orderAmendInfo();

        // 21/05/2018 MM :update del timestamp. CALLOM.1 corrisponde a inizio callout ad OM
        OM_GW_GE_Utils.partialTemplog('CALLOM.1');
        // finisce qui
        
        
        //set timeout
            stub.timeout_x = 30000;
            
            
        //system.debug('@@@@@@@@ ENtrato nel metodo di invio: '+field_map);
        //Invoking the callout with corresponding parameters da sostituire con OrderId
        response = stub.AmendOrder(orderId, sl.EOF_codice_ordine_olo__c, field_map, sl.EOF_Data_Notifica__c, sl.EOF_Data_Prevista_Attivazione__c);        


        // 21/05/2018 MM :update del timestamp. CALLOM.2 corrisponde a fine callout ad OM
        OM_GW_GE_Utils.partialTemplog('CALLOM.2');
        
        // finisce qui

       
        //creo la mappa da restituire
        map<String,EOF_EAI_Service_Log__C> MapAckNack = new map<String,EOF_EAI_Service_Log__C>();
        //Creating EAI_Service_Logs based on the response
        List<EOF_EAI_Service_Log__c> SlListToUpsert = new List<EOF_EAI_Service_Log__c>();
        if(response.amendStatusCode == 0){
            EOF_EAI_Service_Log__c ackLog = new EOF_EAI_Service_Log__c(
            Caso__c = sl.caso__c,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('ACK').getRecordTypeId(),
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - FiberRequest - '+OM_GW_GE_Utils.retCodOp(tipo_comunicazione),                    
            EOF_Richiesta_Notifica__c =  'Esito: '+ response.amendStatusCode + '\n' + 'messaggio: ' +
                                        response.amendMessage,     
            EOF_ID_Notifica__c = field_map.get('ID_NOTIFICA'), 
            EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,                   
            EOF_Codice_Operatore__c = field_map.get('CODICE_OPERATORE'),
            EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c      
            ); 
            MapAckNack.put('ACK',ackLog);
            return MapAckNack;
        }
          
        else{
            EOF_EAI_Service_Log__c nackLog = new EOF_EAI_Service_Log__c(
            Caso__c = sl.caso__c,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('NACK').getRecordTypeId(), 
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - FiberRequest - '+OM_GW_GE_Utils.retCodOp(tipo_comunicazione),                   
            EOF_Richiesta_Notifica__c = 'Esito: '+ 1 + '\n' + 'Codice errore: ' + 
                                        response.amendStatusCode + '\n' + 'Causale errore: ' +
                                        response.amendStatus+' - '+response.amendMessage, 
            EOF_Codice_errore__c=String.valueof(response.amendStatusCode),
            EOF_Causale_Errore__c=response.amendStatus+' - '+response.amendMessage,    
            EOF_ID_Notifica__c = field_map.get('ID_NOTIFICA'),
            EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
            EOF_Codice_Operatore__c = field_map.get('CODICE_OPERATORE'),
            EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c      
            );  
            MapAckNack.put('NACK',nackLog);
            return MapAckNack;                
        }

     }
     
     //metodo sincrono in caso di ACK sull'acquisizione OK/KO e cessazione OK/KO
     public static void createAckNackNotifyServiceLog_CM_SOA(Case c){
        
        //estraggo il log di attivazione dall'OLO
        EOF_EAI_Service_Log__C slAttivazione = [SELECT id,  ownerid,  isdeleted,  name,  recordtypeid,  createddate,  createdbyid,  lastmodifieddate,  lastmodifiedbyid,  systemmodstamp,  lastvieweddate,
                                lastreferenceddate,  eof_tipo_comunicazione__c,  eof_codice_operatore__c,  eof_codice_ordine_olo__c, eof_id_notifica__c,  eof_stato_richiesta__c,  eof_codice_errore__c,  
                                eof_causale_errore__c,  eof_richiesta_notifica__c,  notify__c,  caso__c,  eof_data_notifica__c,  eof_data_notifica_string__c,  eof_id_pop__c,  eof_gpon_attestazione__c,  
                                eof_gpon_vincolante__c,  eof_id_risorsa__c,  eof_nome_cliente__c,  eof_cognome_cliente__c,  eof_recapito_telefonico_cliente_1__c,  eof_recapito_telefonico_cliente_2__c,  
                                eof_provincia__c,  eof_comune__c,  eof_particella_toponomastica__c,  eof_indirizzo__c,  eof_numero_civico__c,  eof_id_building__c,  eof_scala_palazzina__c,  eof_nome_referente_tecnico_olo__c,  
                                eof_cognome_referente_tecnico_olo__c,  eof_telefono_referente_tecnico_olo__c,  eof_email_referente_tecnico_olo__c,  eof_recapito_test_linea__c,  eof_numero_telefonico_principale_linea__c,  
                                eof_password_apparato__c,  eof_telefono_referente_olo_onfield_notec__c,  eof_opzione_system_unico__c,  eof_data_prevista_attivazione__c,  eof_causale_richiesta_annullamento__c,  
                                eof_codice_richiesta_annullamento__c,  eof_apparato__c,  eof_tipologia_apparato__c,  eof_progetto_speciale__c,  eof_collegamento_p2p__c,  eof_note__c,  eof_tipologia_servizio__c,  
                                eof_sla_premium_assurance__c,  eof_orario_appuntamento__c,  eof_codice_ordine_eof__c, EOF_Tipo_Comunicazione_String__c 
                                FROM EOF_EAI_Service_Log__c where caso__c=:c.Id and (EOF_Tipo_Comunicazione__c='1' OR EOF_Tipo_Comunicazione__c='11') order by createddate asc limit 1];

        
       String operation;
       String Tipo_comunicazione;
        if(c.recordtype.developername=='EOF_Caso_Attivazione'){
            operation='Create';
            if(c.status=='Acquisito'){
                Tipo_comunicazione='1';
            }
            else{
                Tipo_comunicazione='99';
            }
        }
        else{
            operation='Delete';
            if(c.status=='Acquisito'){
                Tipo_comunicazione='11';
            }
            else{
                Tipo_comunicazione='98';
            }
        }
        
        //se non sono in retry ad OM
        if(!OM_GW_GE_Utils.retryToOM){
            //creo il log che invio verso OM
            OM_GW_GE_Utils.slSFOM=OM_GW_GE_Utils.create_Log_Attivazione_cessazione_To_OM(slAttivazione,c,Tipo_comunicazione, 'SF->OM - FiberRequest - '+OM_GW_GE_Utils.retCodOp(tipo_comunicazione));
        }
        //altrimenti l'ho gia estratto dal sistema
        Map<String,String> field_map = create_map_sync(OM_GW_GE_Utils.slSFOM, Operation, Tipo_comunicazione,c.codice_ordine_eof__c);
        
        
        //metodo per ripristinare in caso di locked row
        xmlnsEnelItOloGatwaySincronizzazionCOM.ResponseHeader response;
        if(OM_GW_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
            response = new xmlnsEnelItOloGatwaySincronizzazionCOM.ResponseHeader();
            response.Status = '0';
            response.RequestId='Da bonificare';
            //resetto il campo a false per evitare problemi successivi
            OM_GW_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c=false;
        }
        else{
                        
            //suddividere sulla base del tipo di richiesta
            xmlnsEnelItOloGatwayWsdlConcreteCOM.InstantLinkSOAEndpoint1 stub = new  xmlnsEnelItOloGatwayWsdlConcreteCOM.InstantLinkSOAEndpoint1();              
            response = new xmlnsEnelItOloGatwaySincronizzazionCOM.ResponseHeader();
                                    
            
            //set timeout
                stub.timeout_x = 30000;
             
            if(Operation == 'Create'){
                response = stub.Create('ORDER', OM_GW_GE_Utils.slSFOM.EOF_Codice_ordine_olo__c, field_map,OM_GW_GE_Utils.slSFOM.eof_data_notifica__c,OM_GW_GE_Utils.slSFOM.eof_data_prevista_attivazione__c);
                                
            }                        
            else{
                response = stub.Delete_x('test', OM_GW_GE_Utils.slSFOM.EOF_Codice_ordine_olo__c, OM_GW_GE_Utils.slSFOM, tipo_comunicazione);

            }
                              
        }
        
        //Creating EAI_Service_Logs based on the response
        if(response.Status == '0'){
            OM_GW_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - FiberRequest - '+OM_GW_GE_Utils.retCodOp(tipo_comunicazione),
            Caso__c = OM_GW_GE_Utils.slSFOM.caso__c,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('ACK').getRecordTypeId(),                    
            EOF_Richiesta_Notifica__c =  'Esito: '+ 0,    
            EOF_ID_Notifica__c = OM_GW_GE_Utils.slSFOM.EOF_ID_Notifica__c,                    
            EOF_Codice_Operatore__c = OM_GW_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OM_GW_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OM_GW_GE_Utils.slSFOM.EOF_Data_Notifica__c      
            ); 
            
            //leghiamo il request ID al case e aggiorniamo la response sul case
            OM_GW_GE_Utils.caseOriginale.EOF_Codice_Ordine_OM__c=response.RequestId;
            OM_GW_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';
            
            //Aggiorno la response sul log principale
            OM_GW_GE_Utils.slSFOM.EOF_Response__c='ACK';
   
        }
        else{
            OM_GW_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            Caso__c = OM_GW_GE_Utils.slSFOM.caso__c,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('NACK').getRecordTypeId(), 
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - FiberRequest - '+OM_GW_GE_Utils.retCodOp(tipo_comunicazione),                   
            EOF_Richiesta_Notifica__c = 'Esito: '+ 1 + '\n' + 'Codice errore: ' + 
                                        response.StatusMessageId + '\n' + 'Causale errore: ' +
                                        response.StatusMessage,     
            EOF_ID_Notifica__c = OM_GW_GE_Utils.slSFOM.EOF_ID_Notifica__c,
            EOF_Codice_Operatore__c = OM_GW_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OM_GW_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OM_GW_GE_Utils.slSFOM.EOF_Data_Notifica__c       
            ); 
             
            //setto il NACK sul case
           if(response.StatusMessageId=='A_K4' || response.StatusMessageId=='100' || response.StatusMessageId=='200'){
                OM_GW_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
                OM_GW_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
           }
           //Aggiorno la response sul log principale
            OM_GW_GE_Utils.slSFOM.EOF_Response__c='NACK';
                  
        }
        
                 
        //se ricevo NACK committo i dati a sistema e poi riproverò con il retry 
       if(!OM_GW_GE_Utils.retryToOLO && !OM_GW_GE_Utils.retryToOM){
            //caso di flusso normale senza retry
            OM_GW_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM(operation,Tipo_comunicazione,OM_GW_GE_Utils.caseOriginale.OF_Response_Da_OM__c);                }
       //se ho ricevuto nuovamente NACK con il retry salvo solo i dati significativi
       else if(OM_GW_GE_Utils.retryToOLO){
            //caso di flusso in cui ho fatto il retry verso OLO andato bene, per cui devo salvare solamente i dati relativi al nuovo ACK restituito dall'OLO
            //e il nuovo service log verso OM piu l'ack o il nack da OM
            update OM_GW_GE_Utils.caseOriginale;
            update OM_GW_GE_Utils.slSFOLO;
            OM_GW_GE_Utils.slSFOLOresp.notify__C=OM_GW_GE_Utils.slSFOLO.notify__C;
            OM_GW_GE_Utils.slSFOLOresp.EOF_SL_Riferimento__c=OM_GW_GE_Utils.slSFOLO.Id;
            OM_GW_GE_Utils.slSFOLOResp.EOF_Retry__c=true;
            insert OM_GW_GE_Utils.slSFOLOresp;
            Insert OM_GW_GE_Utils.slSFOM;
            
            
            OM_GW_GE_Utils.slSFOMResp.EOF_Retry__c=true;
            OM_GW_GE_Utils.slSFOMResp.EOF_SL_Riferimento__c=OM_GW_GE_Utils.slSFOM.Id;
            //metto la reference alla notifica, la reference al slPrincipale e inserisco la response
            
            insert OM_GW_GE_Utils.slSFOMResp;  
       } 
       else if (OM_GW_GE_Utils.retryToOM){ 
        //caso di flusso in cui ho ricevuto il nack tecnico da OM per cui devo solamente salvare il nuovo ACk/NACK da OM
            update OM_GW_GE_Utils.caseOriginale;
            update OM_GW_GE_Utils.slSFOM;
            OM_GW_GE_Utils.slSFOMResp.EOF_Retry__c=true;
            //metto la reference alla notifica, la reference al slPrincipale e inserisco la response
            OM_GW_GE_Utils.slSFOMResp.notify__C=OM_GW_GE_Utils.slSFOM.notify__C;
            OM_GW_GE_Utils.slSFOMResp.EOF_SL_Riferimento__c=OM_GW_GE_Utils.slSFOM.Id;
            insert OM_GW_GE_Utils.slSFOMResp; 
       }   


   }

}
public class Copia_EOF_GW_Utils{                                            
    public static String idNotify{get;set;}
    public static EOF_GW_WS_Request.FiberRequest fr_tmp; 
    public static EOF_GW_WS_Request.returnFiberResponse res_temp;    
    
    public static EOF_GW_WS_Request.returnFiberResponse checkSync(EOF_GW_WS_Request.FiberRequest fr){                        
           
         //Setting up temporary request copy --- will be neeeded for further validation after insert (Concerning account and contacts)         
         fr_tmp = new EOF_GW_WS_Request.FiberRequest();
         fr_tmp = fr;
         Case case_tmp;
         res_temp = new EOF_GW_WS_Request.returnFiberResponse();
         res_temp.Esito = '';
         res_temp.CodiceErrore = '';
         res_temp.CausaleErrore = '';
               
         if(fr.TIPO_COMUNICAZIONE == '2' || fr.TIPO_COMUNICAZIONE == '3' || fr.TIPO_COMUNICAZIONE == '4'){
             
             if(String.isBlank(fr.CODICE_ORDINE_OLO)){
                 return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Codice Ordine OLO');                 
             }
             
             //Could raise an exception if a case is not found but this scenario is not contemplated
             Case c = [SELECT Id, EOF_Codice_Operatore_WS__c, EOF_GPON_Attestazione__c, EOF_Id_Risorsa__c, EOF_Data_Prevista_Attivazione__c
                       FROM Case WHERE EOF_Codice_ordine_OLO__c =: fr.CODICE_ORDINE_OLO];             
             
             if(String.isBlank(fr.CODICE_OPERATORE)){
                 return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Codice Operatore');                 
             }             
             if(String.isBlank(fr.ID_NOTIFICA)){
                 return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Id Notifica');
             }   
             if(fr.CODICE_ORDINE_OLO.length() > 18){
                 return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Codice Ordine OLO');
             }
             if(fr.CODICE_OPERATORE != 'VF' && fr.CODICE_OPERATORE != 'WN'){
                 return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Codice Operatore'); 
             }             
             if(fr.ID_NOTIFICA.length() > 15){
                 return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Id Notifica');
             }             
             
             res_temp.Esito = 'OK';
             EOF_EAI_Service_Log__c sl = [SELECT Id, Caso__c FROM EOF_EAI_Service_Log__c WHERE EOF_ID_Notifica__c =: fr.ID_NOTIFICA AND
                                          EOF_Codice_Ordine_OLO__c =: fr.CODICE_ORDINE_OLO AND Recordtype.Name != 'ACK' AND Recordtype.Name != 'NACK' ORDER BY CreatedDate Desc LIMIT 1];
             sl.Caso__c = c.id;
             update sl;
             insert EOF_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK', 'Codice_operatore' => fr.CODICE_OPERATORE, 'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,  'ID_notifica' => fr.ID_NOTIFICA});
             
             //DAC Remodulation
             if(fr.TIPO_COMUNICAZIONE == '2'){
                  Boolean error = false;
                 
                  //Checking Account required fields to validate request --- these are here because they cannot be done using validation rules
                    if(String.isBlank(fr_tmp.COGNOME_CLIENTE) && !error){ 
                        error = true;
                        create_notify(c, 8, 'KO', 'AK_1', 'Cognome Cliente');                                 
                    }               
                    if(String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1) && !error){
                        error = true;
                        create_notify(c, 8, 'KO', 'AK_1', 'Recapito Telefonico Cliente');                      
                    }
                    
                    //Asynchronous controls on field request
                    if(fr_tmp.COGNOME_CLIENTE.length() > 70 && !error){
                        error = true;
                        create_notify(c, 8, 'KO', 'AK_2', 'Cognome Cliente');                        
                    }                
                    if(fr_tmp.NOME_CLIENTE.length() > 20 && !error){ 
                        error = true;
                        create_notify(c, 8, 'KO', 'AK_2', 'Nome Cliente');                      
                    }                        
                    if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20 && !error){
                        error = true;
                        create_notify(c, 8, 'KO', 'AK_2', 'Recapito telefonico cliente');                        
                    }                        
                    if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20 && !error){ 
                        error = true;
                        create_notify(c, 8, 'KO', 'AK_2', 'Recapito telefonico cliente 2');                         
                    }
                    
                    //Asynchronous check on field request
                    if(fr_tmp.NOME_REFERENTE_TECNICO_OLO.length() > 50 && !error){ 
                        error = true;
                        create_notify(c, 8, 'KO', 'AK_2', 'Nome referente tecnico OLO');                        
                    }                        
                    if(fr_tmp.COGNOME_REFERENTE_TECNICO_OLO.length() > 50 && !error){
                        error = true;
                        create_notify(c, 8, 'KO', 'AK_2', 'Cognome referente tecnico OLO');                        
                    }                        
                    if(fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO.length() > 20 && !error){
                        error = true;
                        create_notify(c, 8, 'KO', 'AK_2', 'Telefono referente tecnico OLO');                         
                    }                        
                    if(fr_tmp.EMAIL_REFERENTE_TECNICO_OLO.length() > 255 && !error){
                        error = true;
                        create_notify(c, 8, 'KO', 'AK_2', 'Email referente tecnico OLO');                        
                    } 
                                        
                      
                  	if(!error){
                         c.EOF_Data_Prevista_Attivazione__c = EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE);
                         update c;
                         create_notify(c, 8, 'OK', null, null);                   
                }
             }
                
             //De-sospension
             if(fr.TIPO_COMUNICAZIONE == '3'){
                    Boolean error = false;
                 
                    //Checking Account required fields to validate request --- these are here because they cannot be done using validation rules
                    if(String.isBlank(fr_tmp.COGNOME_CLIENTE) && !error){
                        error = true;
                        create_notify(c, 10, 'KO', 'AK_1', 'Cognome Cliente');                                    
                    }          
                    if(String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1) && !error){
                        error = true;
                        create_notify(c, 10, 'KO', 'AK_1', 'Recapito Telefonico Cliente');                       
                    }
                    
                    //Asynchronous controls on field request
                    if(fr_tmp.COGNOME_CLIENTE.length() > 70 && !error){  
                        error = true;
                        create_notify(c, 10, 'KO', 'AK_2', 'Cognome Cliente');                        
                    }              
                    if(fr_tmp.NOME_CLIENTE.length() > 20 && !error){  
                        error = true;
                        create_notify(c, 10, 'KO', 'AK_2', 'Nome Cliente');                         
                    }                        
                    if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20 && !error){
                        error = true;
                        create_notify(c, 10, 'KO', 'AK_2', 'Recapito telefonico cliente');                        
                    }                        
                    if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20 && !error){ 
                        error = true;
                        create_notify(c, 10, 'KO', 'AK_2', 'Recapito telefonico cliente 2');                        
                    }
                    
                    //Asynchronous check on field request
                    if(fr_tmp.NOME_REFERENTE_TECNICO_OLO.length() > 50 && !error){
                        error = true;
                        create_notify(c, 10, 'KO', 'AK_2', 'Nome referente tecnico OLO');                         
                    }                        
                    if(fr_tmp.COGNOME_REFERENTE_TECNICO_OLO.length() > 50 && !error){ 
                        error = true;
                        create_notify(c, 10, 'KO', 'AK_2', 'Cognome referente tecnico OLO');                        
                    }                        
                    if(fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO.length() > 20 && !error){ 
                        error = true;
                        create_notify(c, 10, 'KO', 'AK_2', 'Telefono referente tecnico OLO');                       
                    }                        
                    if(fr_tmp.EMAIL_REFERENTE_TECNICO_OLO.length() > 255 && !error){
                        error = true;
                        create_notify(c, 10, 'KO', 'AK_2', 'Email referente tecnico OLO');                         
                    }                    
                    
                    if(!error){
                        c.Status = 'Accettato';
                        c.EOF_Fase__c = 'Desospeso';                            
                        update c;
                        create_notify(c, 10, 'OK', null, null);
                  }                                
             }
              
             //Cancellation
             if(fr.TIPO_COMUNICAZIONE == '4'){
                 
                  Boolean error = false;
                  //Checking Account required fields to validate request --- these are here because they cannot be done using validation rules
                  if(String.isBlank(fr_tmp.COGNOME_CLIENTE) && !error){                                 
                        create_notify(c, 13, 'KO', 'AK_1', 'Cognome Cliente'); 
            			error = true;                        
                       }
                  if(String.isBlank(fr_tmp.CAUSALE_RICHIESTA_ANNULLAMENTO) && !error){                                 
                        create_notify(c, 13, 'KO', 'AK_1', 'Causale Richiesta Annullamento'); 
            			error = true;                        
                       } 
                  if(String.isBlank(fr_tmp.CODICE_RICHIESTA_ANNULLAMENTO) && !error){                                 
                        create_notify(c, 13, 'KO', 'AK_1', 'Codice Richiesta Annullamento'); 
            			error = true;                        
                       } 
                    
                   //Asynchronous controls on field request
                   if(fr_tmp.COGNOME_CLIENTE.length() > 70 && !error){                           
                         create_notify(c, 13, 'KO', 'AK_2', 'Cognome Cliente'); 
                         error = true; 
                      }                      
                   if(fr_tmp.NOME_CLIENTE.length() > 20 && !error){                          
                          create_notify(c, 13, 'KO', 'AK_2', 'Nome Cliente'); 
                          error = true;
                      }                        
                   if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20 && !error){                           
                          create_notify(c, 13, 'KO', 'AK_2', 'Recapito telefonico cliente'); 
                          error = true;
                      }                        
                   if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20 && !error){                            
                          create_notify(c, 13, 'KO', 'AK_2', 'Recapito telefonico cliente 2'); 
                          error = true; 
                      }
                    
                   //Asynchronous check on field request
                   if(fr_tmp.NOME_REFERENTE_TECNICO_OLO.length() > 50 && !error){                           
                          create_notify(c, 13, 'KO', 'AK_2', 'Nome referente tecnico OLO'); 
                          error = true;
                        }                        
                   if(fr_tmp.COGNOME_REFERENTE_TECNICO_OLO.length() > 50 && !error){                            
                           create_notify(c, 13, 'KO', 'AK_2', 'Cognome referente tecnico OLO'); 
                           error = true;
                        }                        
                   if(fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO.length() > 20 && !error){                           
                            create_notify(c, 13, 'KO', 'AK_2', 'Telefono referente tecnico OLO'); 
                            error = true; 
                        }                        
                   if(fr_tmp.EMAIL_REFERENTE_TECNICO_OLO.length() > 255 && !error){
                            create_notify(c, 13, 'KO', 'AK_2', 'Email referente tecnico OLO'); 
                            error = true; 
                        }                    
          
                   if(!error){
                       c.Status = 'Annullato';
                       c.EOF_Causale_Richiesta_Annullamento__c = fr_tmp.CAUSALE_RICHIESTA_ANNULLAMENTO;
                       c.EOF_Codice_Richiesta_Annullamento__c = fr_tmp.CODICE_RICHIESTA_ANNULLAMENTO;                            
                       update c;
                       create_notify(c, 13, 'OK', null, null);
                   }
             }         
             return res_temp;
         }
              
         if(fr.TIPO_COMUNICAZIONE == '1'){
            
            RecordType rt = [SELECT Id FROM RecordType WHERE sObjectType = 'Case' AND Name = 'EOF Caso - Attivazione' LIMIT 1];
            
            case_tmp = new Case(
              Type = fr.TIPO_COMUNICAZIONE,
              RecordTypeId = rt.Id,
        	  EOF_Codice_Operatore_WS__c = fr.CODICE_OPERATORE,            
              EOF_Codice_Ordine_OLO__c = fr.CODICE_ORDINE_OLO,
              EOF_Data_Notifica__c = EOF_GW_GE_Utils.StringToDate(fr.DATA_NOTIFICA),
              EOF_Id_Notifica__c = fr.ID_NOTIFICA,              
              EOF_Data_Prevista_Attivazione__c = EOF_GW_GE_Utils.StringToDateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE),
              Status = 'Acquisito',                
              Origin = 'Web'                      
          );     
        }
        
         if(fr.TIPO_COMUNICAZIONE == '11'){
            
             RecordType rt = [SELECT Id FROM RecordType WHERE sObjectType = 'Case' AND Name = 'EOF Caso - Cessazione' LIMIT 1];
            
             case_tmp = new Case(
                Type = fr.TIPO_COMUNICAZIONE,
                RecordTypeId = rt.Id,
        		EOF_Codice_Operatore_WS__c = fr.CODICE_OPERATORE,            
              	EOF_Codice_Ordine_OLO__c = fr.CODICE_ORDINE_OLO,
                EOF_Data_Notifica__c = EOF_GW_GE_Utils.StringToDate(fr.DATA_NOTIFICA),
              	EOF_Id_Notifica__c = fr.ID_NOTIFICA,
              	EOF_Id_Risorsa__c = fr.ID_RISORSA,              
              	Status = 'Acquisito', 
              	Origin = 'Web',
                Description = fr.NOTE
              );                 
          } 
        
                 //A_K7 synchronous error checking - prevent insert
                 List<Case> case_list = [SELECT Id, EOF_Codice_Ordine_OLO__c FROM Case WHERE EOF_Codice_Ordine_OLO__c = : fr.CODICE_ORDINE_OLO];
                 if(!case_list.isEmpty())
                       return EOF_GW_GE_Utils.syncError(fr, 'A_K7', null);
                 try{              
                      Database.DMLOptions dmo = new Database.DMLOptions();
                      dmo.assignmentRuleHeader.useDefaultRule = true;
                      case_tmp.setOptions(dmo);
                      insert case_tmp;
                      
                  //A_K5 - A_K6 synchronous error checking - prevent insert         
                  }
        		 catch(DMLException e){              
                        if(e.getDmlType(0) == Statuscode.STRING_TOO_LONG){
                            return EOF_GW_GE_Utils.syncError(fr, 'A_K6', e.getDmlFields(0).get(0).getdescribe().getlabel());                    
                        }
                        if(e.getDmlType(0) == Statuscode.FIELD_CUSTOM_VALIDATION_EXCEPTION){
                            if(e.getDmlMessage(0).startsWith('Compilare')){ 
                                return EOF_GW_GE_Utils.syncError(fr, 'A_K5', e.getDmlFields(0).get(0).getdescribe().getlabel());
                            }
                            if(e.getDmlMessage(0).startsWith('Valore')){                
                                return EOF_GW_GE_Utils.syncError(fr, 'A_K6', e.getDmlFields(0).get(0).getdescribe().getlabel());
                            }
                       }              
                  }          
        
          //Updating previously generated Service Log
          EOF_EAI_Service_Log__c sl = [SELECT Id, Caso__c FROM EOF_EAI_Service_Log__c WHERE EOF_ID_Notifica__c =: fr.ID_NOTIFICA AND
                                       EOF_Codice_Ordine_OLO__c =: fr.CODICE_ORDINE_OLO AND Recordtype.Name != 'ACK' AND Recordtype.Name != 'NACK' ORDER BY CreatedDate Desc LIMIT 1];
          sl.Caso__c = case_tmp.id;
          update sl;
        
          //Inserting ACK Service Log
          insert EOF_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK', 'Codice_operatore' => fr.CODICE_OPERATORE, 'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO, 'ID_notifica' => fr.ID_NOTIFICA});
          res_temp.Esito = 'OK';
                 
          //Checking Asyncronous controls
          EOF_GW_Utils.checkAsync(case_tmp);              
    
          return res_temp;
    } 
    
    public static void checkAsync(Case c){ 
                
        //Updating OLO lookup to case
        Account oloId = [SELECT Id, Type, EOF_Codice_Operatore__c  FROM Account WHERE Type = 'OLO' AND EOF_Codice_Operatore__c =: fr_tmp.CODICE_OPERATORE LIMIT 1];
        c.EOF_Account_OLO__c = oloId.id;
        update c;
        
    	//Activation        
        if(c.Type == '1'){                     
                    
                    //Checking Account required fields to validate request --- these are here because they cannot be done using validation rules
                    if(String.isBlank(fr_tmp.COGNOME_CLIENTE)){
                        c.EOF_Causale_Errore__c = 'Campo \'' + 'Cognome Cliente' + '\' obbligatorio non valorizzato';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 5, 'KO', 'A_K1', 'Cognome Cliente'); 
            			return;                        
                    }            
                    if(String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1)){
                        c.EOF_Causale_Errore__c = 'Campo \'' + 'Recapito Telefonico Cliente' + '\' obbligatorio non valorizzato';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 5, 'KO', 'A_K1', 'Recapito Telefonico Cliente');
                        return;
                    }                                 
                    if(String.isBlank(fr_tmp.PROVINCIA)){
                            c.EOF_Causale_Errore__c = 'Campo \'' + 'Provincia' + '\' obbligatorio non valorizzato';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K1', 'Provincia'); 
                            return;
                        }                        
                    if(String.isBlank(fr_tmp.COMUNE)){
                            c.EOF_Causale_Errore__c = 'Campo \'' + 'Comune' + '\' obbligatorio non valorizzato';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K1', 'Comune'); 
                            return;
                        }                        
                    if(String.isBlank(fr_tmp.INDIRIZZO)){
                            c.EOF_Causale_Errore__c = 'Campo \'' + 'Indirizzo' + '\' obbligatorio non valorizzato';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K1', 'Indirizzo'); 
                            return;
                        }                        
                    if(String.isBlank(fr_tmp.NUMERO_CIVICO)){
                            c.EOF_Causale_Errore__c = 'Campo \'' + 'Numero civico' + '\' obbligatorio non valorizzato';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K1', 'Numero civico'); 
                            return;
                        }                        
                    if(String.isBlank(fr_tmp.PARTICELLA_TOPONOMASTICA)){
                            c.EOF_Causale_Errore__c = 'Campo \'' + 'Particella toponomastica' + '\' obbligatorio non valorizzato';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K1', 'Particella toponomastica'); 
                            return;
                        }
            
                	//Initializing a valid string for both business and person account
                    String search_str = '';
                    if(String.isBlank(fr_tmp.NOME_CLIENTE))
                        search_str = fr_tmp.COGNOME_CLIENTE;
                    else
                        search_str = fr_tmp.NOME_CLIENTE + ' ' + fr_tmp.COGNOME_CLIENTE;             
            
                    //gathering account
                    List<Account> acc = [SELECT Id, Name FROM Account WHERE Name =:fr_tmp.COGNOME_CLIENTE AND Phone =: fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1];  
                    
                    //Account found --- complete case fields using Account retrieved 
                    if(!acc.isEmpty())
                        c.AccountId = acc.get(0).Id;
                    else{                
                        //Asynchronous controls on field request
                        if(fr_tmp.COGNOME_CLIENTE.length() > 70){
                            c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Cognome Cliente' + '\' non ammesso';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K2', 'Cognome Cliente'); 
                            return; 
                      }
                        if(!String.isBlank(fr_tmp.NOME_CLIENTE)){
                            if(fr_tmp.NOME_CLIENTE.length() > 20){
                            c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Nome Cliente' + '\' non ammesso';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K2', 'Nome Cliente'); 
                            return; 
                        	}
                      	} 
                        if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20){
                            c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Recapito telefonico cliente' + '\' non ammesso';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K2', 'Recapito telefonico cliente'); 
                            return; 
                        }
                        if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20){
                            c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Recapito telefonico cliente 2' + '\' non ammesso';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K2', 'Recapito telefonico cliente 2'); 
                            return; 
                        }                       
                        if(fr_tmp.PROVINCIA.length() > 30){
                            c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Provincia' + '\' non ammesso';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K2', 'Provincia'); 
                            return; 
                        } 
                        if(fr_tmp.COMUNE.length() > 60){
                            c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Comune' + '\' non ammesso';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K2', 'Comune'); 
                            return; 
                        } 
                        if(fr_tmp.INDIRIZZO.length() > 70){
                            c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Indirizzo' + '\' non ammesso';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K2', 'Indirizzo'); 
                            return; 
                        } 
                        if(fr_tmp.NUMERO_CIVICO.length() > 10){
                            c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Numero civico' + '\' non ammesso';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K2', 'Numero civico'); 
                            return; 
                        } 
                        if(fr_tmp.PARTICELLA_TOPONOMASTICA.length() > 28){
                            c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Particella toponomastica' + '\' non ammesso';
                            c.Status = 'Acquisito KO';
                            c.EOF_Fase__c = 'NA'; 
                            update c;
                            create_notify(c, 5, 'KO', 'A_K2', 'Particella toponomastica'); 
                            return; 
                        } 
                        if(String.isBlank(fr_tmp.NOME_CLIENTE)){                        
                            Recordtype rt = [SELECT Id FROM RecordType WHERE Name = 'Cliente Business'];
                            Account a = new Account(Name = fr_tmp.COGNOME_CLIENTE,
                                                    RecordTypeId = rt.id,
                                                    Phone = fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1,
                                                    EOF_Comune__c = fr_tmp.COMUNE,
                                                    EOF_Particella_Toponomastica__c = fr_tmp.PARTICELLA_TOPONOMASTICA,
                                                    EOF_Indirizzo__c = fr_tmp.INDIRIZZO,
                                                    EOF_Numero_Civico__c = fr_tmp.NUMERO_CIVICO,
                                                    EOF_Provincia__c = fr_tmp.PROVINCIA,
                                                    EOF_Phone_2__c = fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2 );
                                        insert a;
                              }
                        else{
                                    Recordtype rt = [SELECT Id FROM RecordType WHERE Name = 'Person Account'];
                                    Account a = new Account(FirstName = fr_tmp.NOME_CLIENTE,
                                                          LastName = fr_tmp.COGNOME_CLIENTE,
                                                          RecordTypeId = rt.id,
                                                          Phone = fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1,
                                                          EOF_Comune__c = fr_tmp.COMUNE,
                                                          EOF_Particella_Toponomastica__c = fr_tmp.PARTICELLA_TOPONOMASTICA,
                                                          EOF_Indirizzo__c = fr_tmp.INDIRIZZO,
                                                          EOF_Numero_Civico__c = fr_tmp.NUMERO_CIVICO,
                                                          EOF_Provincia__c = fr_tmp.PROVINCIA,
                                                          EOF_Phone_2__c = fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2 );
                                    insert a;
                                }            
                          }
                    
                    //Checking Technician required fields to validate request
                    if(String.isBlank(fr_tmp.NOME_REFERENTE_TECNICO_OLO)){
                      c.EOF_Causale_Errore__c = 'Campo \'' + 'Nome Referente Tecnico OLO' + '\' obbligatorio non valorizzato';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 5, 'KO', 'A_K1', 'Nome Referente Tecnico OLO');
                        return;
                    }            
                    if(String.isBlank(fr_tmp.COGNOME_REFERENTE_TECNICO_OLO)){
                        c.EOF_Causale_Errore__c = 'Campo \'' + 'Cognome Referente Tecnico OLO' + '\' obbligatorio non valorizzato';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 5, 'KO', 'A_K1', 'Cognome Referente Tecnico OLO');
                        return;
                    }            
                    if(String.isBlank(fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO)){
                      c.EOF_Causale_Errore__c = 'Campo \'' + 'Telefono Referente Tecnico OLO' + '\' obbligatorio non valorizzato';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 5, 'KO', 'A_K1', 'Telefono Referente Tecnico OLO');
                        return;
                    }            
                    if(String.isBlank(fr_tmp.EMAIL_REFERENTE_TECNICO_OLO)){
                        c.EOF_Causale_Errore__c = 'Campo \'' + 'Email Referente Tecnico OLO' + '\' obbligatorio non valorizzato';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 5, 'KO', 'A_K1', 'Email Referente Tecnico OLO');
                        return;
                    }
                    
                    //Asynchronous check on field request
                    if(fr_tmp.NOME_REFERENTE_TECNICO_OLO.length() > 50){
                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Nome referente tecnico OLO' + '\' non ammesso';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 5, 'KO', 'A_K2', 'Nome referente tecnico OLO'); 
            			return; 
                    }                    
                    if(fr_tmp.COGNOME_REFERENTE_TECNICO_OLO.length() > 50){
                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Cognome referente tecnico OLO' + '\' non ammesso';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 5, 'KO', 'A_K2', 'Cognome referente tecnico OLO'); 
            			return; 
                    }                    
                    if(fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO.length() > 20){
                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Telefono referente tecnico OLO' + '\' non ammesso';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 5, 'KO', 'A_K2', 'Telefono referente tecnico OLO'); 
            			return; 
                    }                    
                    if(fr_tmp.EMAIL_REFERENTE_TECNICO_OLO.length() > 255){
                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Email referente tecnico OLO' + '\' non ammesso';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 5, 'KO', 'A_K2', 'Email referente tecnico OLO'); 
            			return; 
                    }                    
                    
                    //Using Technician required information in the request to retrieve the Account in the system
                    List<Contact> tech = [SELECT Id, FirstName, LastName, Phone, Email FROM Contact WHERE 
                                          FirstName =: fr_tmp.NOME_REFERENTE_TECNICO_OLO AND LastName =: fr_tmp.COGNOME_REFERENTE_TECNICO_OLO 
                                          AND Phone =: fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO AND Email =: fr_tmp.EMAIL_REFERENTE_TECNICO_OLO];  
                    if(!tech.isEmpty())
                        c.EOF_Contact__c = tech.get(0).Id;                   
                    
                    //Asynchronous check on case field request                                       
                    c.EOF_Async_Check_ctrl__c = true;
                    c.EOF_Identificativo_del_POP__c = fr_tmp.IDENTIFICATIVO_DEL_POP;
                    c.EOF_GPON_Attestazione__c = fr_tmp.GPON_ATTESTAZIONE;
                    c.EOF_GPON_Vincolante__c = fr_tmp.GPON_VINCOLANTE;                          
                    c.EOF_Provincia_WS__c = fr_tmp.PROVINCIA;
                    c.EOF_Comune_WS__c = fr_tmp.COMUNE;
                    c.EOF_Particella_Toponomastica_WS__c = fr_tmp.PARTICELLA_TOPONOMASTICA;
                    c.EOF_Indirizzo_WS__c = fr_tmp.INDIRIZZO;
                    c.EOF_Numero_Civico_WS__c = fr_tmp.NUMERO_CIVICO;
                    c.EOF_ID_Building_WS__c = fr_tmp.ID_BUILDING;
                    c.EOF_Recapito_Test_Linea__c = fr_tmp.RECAPITO_TEST_LINEA;
                    c.EOF_Numero_Telefonico_Principale_Linea__c = fr_tmp.NUMERO_TELEFONICO_PRINCIPALE_LINEA;
                    c.EOF_Password_Apparato__c = fr_tmp.PASSWORD_APPARATO;
                    c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = fr_tmp.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH;
                    c.EOF_Opzione_System_Unico__c = fr_tmp.OPZIONE_SYSTEM_UNICO;                   
                    c.EOF_Apparato__c = fr_tmp.APPARATO;
                    c.EOF_Tipologia_Apparato__c = fr_tmp.TIPOLOGIA_APPARATO;
                    c.EOF_Progetto_Speciale__c = fr_tmp.PROGETTO_SPECIALE;            
                    c.EOF_Collegamento_P2P__c = fr_tmp.COLLEGAMENTO_P2P;
                    c.Description = fr_tmp.NOTE;
                    c.EOF_Tipologia_Servizio__c = fr_tmp.TIPOLOGIA_SERVIZIO;
                    c.EOF_SLA_Premium_Assurance__c = fr_tmp.SLA_PREMIUM_ASSURANCE;
                    c.Status = 'Acquisito';                    
                    
                    try{
                         update c;
                         create_notify(c, 5, 'OK', null, null);
                    }catch(DMLException e){  
                        if(e.getDmlType(0) == Statuscode.STRING_TOO_LONG){
                            add_result_message(c, e.getDmlFields(0).get(0).getdescribe().getlabel());
                        }                        
                        if(e.getDmlType(0) == Statuscode.FIELD_CUSTOM_VALIDATION_EXCEPTION){                              
                                if(e.getDmlMessage(0).startsWith('Compilare')){
                                c.EOF_Async_Check_ctrl__c = false;                                    
                                    c.EOF_Causale_Errore__c = 'Campo \'' +  e.getDmlFields(0).get(0).getdescribe().getlabel() + '\' obbligatorio non valorizzato';
                                    c.Status = 'Acquisito KO';
                                    c.EOF_Fase__c = 'NA'; 
                                    update c;
                                    create_notify(c, 5, 'KO', 'A_K1', 'Campo \'' +  e.getDmlFields(0).get(0).getdescribe().getlabel() + '\' obbligatorio non valorizzato');
                                }
                                if(e.getDmlMessage(0).startsWith('Valore')){                                    
                                   add_result_message(c, e.getDmlFields(0).get(0).getdescribe().getlabel());                                                              
                                }
                            }
                      }                           
                } 
                    
        //Cessation
        if(c.Type == '11'){
                   List<Asset> a = [SELECT Id FROM Asset WHERE id =: fr_tmp.ID_RISORSA];
                   if(a.isempty()){
                        c.Status = 'Aquisito KO';
                        c.EOF_Fase__c = 'NA'; 
                        update c;
                        create_notify(c, 12, 'KO', 'C_K13', null);                       
                   }
                   else{                       
                      c.Status = 'Acquisito';
                      c.EOF_Fase__c = 'Da lavorare'; 
                      update c;
                      create_notify(c, 12, 'OK', null, null);
                    }
               }        
    }
    
    public static void add_result_message(Case c, String s){         
        
        //Whitening the request and killing all further exceptions --- would prevent further updates                                    
        c.EOF_Identificativo_del_POP__c = '';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_GPON_Vincolante__c = '';                          
        c.EOF_Provincia_WS__c = '';
        c.EOF_Comune_WS__c = '';        
        c.EOF_Particella_Toponomastica_WS__c = '';
        c.EOF_Indirizzo_WS__c = '';
        c.EOF_Numero_Civico_WS__c = '';
        c.EOF_ID_Building_WS__c = '';
        c.EOF_Recapito_Test_Linea__c = '';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '';
        c.EOF_Password_Apparato__c = '';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '';
        c.EOF_Opzione_System_Unico__c = '';        
        c.EOF_Apparato__c = '';
        c.EOF_Tipologia_Apparato__c = '';
        c.EOF_Progetto_Speciale__c = '';            
        c.EOF_Collegamento_P2P__c = '';
        c.Description = '';
        c.EOF_Tipologia_Servizio__c = '';
        c.EOF_SLA_Premium_Assurance__c = '';
            
        c.EOF_Async_Check_ctrl__c = false;
        c.EOF_Causale_Errore__c = 'Valore campo \'' +  s + '\' non ammesso';
        c.Status = 'Acquisito KO';
        c.EOF_Fase__c = 'NA'; 
        update c;        
        create_notify(c, 5, 'KO', 'A_K2', s);
    }
    
    public static Id create_notify(Case c, Integer notify_type, String objectStatus, String errorCode, String field){
        
        RecordType rt, rt_ko;
        EOF_Notify__c notify;
        
        //Acquisition notify 
        if(notify_type == 5){
            
        //Gathering notify record type
        rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di acquisizione' LIMIT 1];
        rt_ko = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di acquisizione KO' LIMIT 1];
            
           if(objectStatus == 'OK'){
            notify = new EOF_Notify__c(
                        RecordTypeId = rt.id,
                        Caso__c = c.id,                     
                        EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                        EOF_Codice_Ordine_EOF__c = c.id,
                        EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                                
                        EOF_Stato_Richiesta__c = objectStatus,
                        EOF_Data_Notifica__c = system.now(),
                        EOF_Inviata__c = false                                                                
                    );                    
                    try{
                      insert notify;
                    }catch(Exception e){                        
                        res_temp.CausaleErrore = e.getmessage();
                    } 
            }
           
            else{
                if(errorCode == 'A_K1'){                               
                    notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                                    
                            EOF_Stato_Richiesta__c = objectStatus,                          
                            Motivo_Rifiuto_Sospensione_Annullamento__c = 'Campo \'' + field + '\' obbligatorio non valorizzato',
                            EOF_Data_Notifica__c = system.now(),
                            EOF_Inviata__c = false                                          
                        );                       
                        try{
                            insert notify;
                        }catch(Exception e){                           
                            res_temp.CausaleErrore = e.getmessage();
                        } 
              }
                
                if(errorCode == 'A_K2'){                               
                    notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                                   
                            EOF_Stato_Richiesta__c = objectStatus,                          
                            Motivo_Rifiuto_Sospensione_Annullamento__c = 'Valore campo \'' + field + '\' non ammesso',
                            EOF_Data_Notifica__c = system.now(),
                            EOF_Inviata__c = false                                          
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                     }  
              }
                
            }
            
        }  
        
        //Acceptance notify 
        if(notify_type == 6){
            
        //Gathering notify record type
        rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di accettazione' LIMIT 1];
        rt_ko = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di accettazione KO' LIMIT 1];

            if(objectStatus == 'OK'){
            
                notify = new EOF_Notify__c(
                            RecordTypeId = rt.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,                            
                            EOF_Stato_Richiesta__c = objectStatus,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                      
                            EOF_Data_Notifica__c = system.now(),                    
                            EOF_Inviata__c = false
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                        }catch(Exception e){                           
                            res_temp.CausaleErrore = e.getmessage();
                      }
              }
            else if(objectStatus == 'KO'){                
                                
                notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_Stato_Richiesta__c = objectStatus,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                        
                            EOF_Data_Notifica__c = system.now(),                    
                            EOF_Inviata__c = false 
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                      }                
               }          
          } 
        
        //Completion notify 
        if(notify_type == 7){
            
        //Gathering notify record type
        rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di espletamento' LIMIT 1];
        rt_ko = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di espletamento KO' LIMIT 1];
            
            if(objectStatus == 'OK'){
                
                notify = new EOF_Notify__c(
                            RecordTypeId = rt.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                            
                            EOF_Stato_Richiesta__c = objectStatus,                        
                            EOF_GPON_Attestazione__c = c.EOF_GPON_Attestazione__c,
                            EOF_ID_Risorsa__c = c.EOF_Id_Risorsa__c,                        
                            EOF_Data_Notifica__c = system.now(),                    
                            EOF_Inviata__c = false
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                      } 
               
              }
            else if(objectStatus == 'KO'){
                
                notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                           
                            EOF_Stato_Richiesta__c = objectStatus,                        
                            EOF_Data_Notifica__c = system.now(),                    
                            EOF_Inviata__c = false
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                      }                
              }          
          } 
        
        //DAC Remodulation notify 
        if(notify_type == 8){
            
        //Gathering notify record type
        rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di rimodulazione DAC' LIMIT 1];
            notify = new EOF_Notify__c(
                        RecordTypeId = rt.id,
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                        EOF_Codice_Ordine_EOF__c = c.id,
                        EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                       
                        EOF_Stato_Richiesta__c = objectStatus,
                        EOF_Data_Notifica__c = system.now(),
                        EOF_Nuova_DAC__c = c.EOF_Data_Prevista_Attivazione__c,                      
                        EOF_Inviata__c = false
                    );
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                      insert notify;
                    }catch(Exception e){                       
                        res_temp.CausaleErrore = e.getmessage();
                  }
          } 
         
        //Suspension notify 
        if(notify_type == 9){
            
        //Gathering notify record type
        rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di sospensione' LIMIT 1];
        Case caseVal = [SELECT EOF_Codice_Ordine_OLO__c,EOF_Id_Notifica__c from Case where id = :c.Id];
            notify = new EOF_Notify__c(
                        RecordTypeId = rt.id,
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                        EOF_Codice_Ordine_EOF__c = c.id,
                        EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                       
                        EOF_Data_Notifica__c = system.now()                    
                    );
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                      insert notify;
                       system.debug('case notifica---'+notify.EOF_ID_Notifica__c);
                    }catch(Exception e){                       
                        res_temp.CausaleErrore = e.getmessage();
                  }
          } 
        
        //De-suspension notify 
        if(notify_type == 10){
            
        //Gathering notify record type
        rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di desospensione' LIMIT 1];
            
            notify = new EOF_Notify__c(
                        RecordTypeId = rt.id,
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                        EOF_Codice_Ordine_EOF__c = c.id,
                        EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                       
                        EOF_Stato_Richiesta__c = objectStatus,
                        EOF_Data_Notifica__c = system.now(),                    
                        EOF_Inviata__c = false
                    );
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                      insert notify;
                    }catch(Exception e){                        
                        res_temp.CausaleErrore = e.getmessage();
                  }
          } 
        
        //Cessation notify 
        if(notify_type == 12){
            
        //Gathering notify record type
          rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di cessazione' LIMIT 1];
          rt_ko = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di cessazione KO' LIMIT 1];
            
            if(objectStatus == 'OK'){                
              notify = new EOF_Notify__c(
                        RecordTypeId = rt.id,
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                        EOF_Codice_Ordine_EOF__c = c.id,
                        EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                                
                        EOF_Stato_Richiesta__c = objectStatus,
                        EOF_Data_Notifica__c = system.now(),            
                        EOF_Inviata__c = false
                    );
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                      insert notify;
                    }catch(Exception e){                       
                        res_temp.CausaleErrore = e.getmessage();
                  }                  
            }
            else if(objectStatus == 'KO'){            
                
                if(errorCode == 'C_K13'){
                    notify = new EOF_Notify__c(
                        RecordTypeId = rt_ko.id,
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                        EOF_Codice_Ordine_EOF__c = c.id,
                        EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                        
                        Motivo_Rifiuto_Sospensione_Annullamento__c = 'ID Risorsa da cessare inesistente/errato',
                        EOF_Stato_Richiesta__c = objectStatus,                      
                        EOF_Data_Notifica__c = system.now(),            
                        EOF_Inviata__c = false
                    );
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                      insert notify;
                    }catch(Exception e){                       
                        res_temp.CausaleErrore = e.getmessage();
                  }
                }else{                
                
                notify = new EOF_Notify__c(
                        RecordTypeId = rt_ko.id,
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                        EOF_Codice_Ordine_EOF__c = c.id,
                        EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                             
                        EOF_Stato_Richiesta__c = objectStatus,                      
                        EOF_Data_Notifica__c = system.now(),            
                        EOF_Inviata__c = false
                    );
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                      insert notify;
                    }catch(Exception e){                       
                        res_temp.CausaleErrore = e.getmessage();
                      }                
                    }                
              }            
          } 

        //Cancellation notify 
        if(notify_type == 13){
            
        //Gathering notify record type
        rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di annullamento' LIMIT 1];            
                      
            notify = new EOF_Notify__c(
                        RecordTypeId = rt.id,
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                        EOF_Codice_Ordine_EOF__c = c.id,
                        EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                       
                        EOF_Stato_Richiesta__c = objectStatus,             
                        Motivo_Rifiuto_Sospensione_Annullamento__c = 'Annullamento su richiesta OLO',
                        EOF_Data_Notifica__c = system.now(),                    
                        EOF_Inviata__c = false
                    );
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                      insert notify;
                    }catch(Exception e){                        
                        res_temp.CausaleErrore = e.getmessage();
                  }
          }
        EOF_Notify__c nf = new EOF_Notify__c();        
        nf = [select id,RecordType.Name from EOF_Notify__c where Caso__c = :c.id AND EOF_Data_Notifica__c= :notify.EOF_Data_Notifica__c limit 1];
        return nf.Id;                                             
      }    
}
public class EOF_GW_Utils{    
                                                                           
    public static String idNotify{get;set;}
    public static EOF_GW_WS_Request.FiberRequest fr_tmp; 
    public static EOF_GW_WS_Request.returnFiberResponse res_temp;   
    public static List<String> result = new List<String>();   
    
    public static EOF_GW_WS_Request.returnFiberResponse checkSync(EOF_GW_WS_Request.FiberRequest fr){                        
          
         //Setting up temporary request copy --- will be neeeded for further validation after insert (Concerning account and contacts)         
         fr_tmp = fr;
         Case case_tmp;
         res_temp = new EOF_GW_WS_Request.returnFiberResponse();
         res_temp.Esito = '';
         res_temp.CodiceErrore = '';
         res_temp.CausaleErrore = ''; 
        
        //ACK fittizio in caso di reinvio notifica per sbloccare OLO Vodafone
        if(String.isNotBlank(fr.codice_ordine_olo) && String.isNotBlank(fr.id_notifica) && (fr.tipo_comunicazione=='1' || fr.tipo_comunicazione=='11')){
        	List<Case> cList = [select id from case where EOF_COdice_ordine_olo__c=:fr.codice_ordine_olo and EOF_Id_Notifica__c=:fr.id_notifica];
      		if(!cList.isEmpty()){
      			res_temp.Esito = '0';
      			return res_temp;
      		}
        }
        
        EOF_EAI_Service_Log__c sl = OM_GW_GE_Utils.slOrig;
        Insert sl;
        
        //Other Common sync checks for all request type
        if(String.isBlank(fr.CODICE_OPERATORE)){
    		EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
             return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Codice Operatore');                 
         }             
        if(String.isBlank(fr.ID_NOTIFICA)){
    		EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
             return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Id Notifica');
         }                       
        if(fr.CODICE_ORDINE_OLO.length() > 18){
		EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
             return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Codice Ordine OLO');
         } 
         if(String.isBlank(fr_tmp.DATA_NOTIFICA)){
        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
            return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Data Notifica');                                                                    
       }
        
        //nuovi controlli 29/03/2017        
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple){
            if(fr.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        }        
        if(!olo_found){
    		EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
             return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Codice Operatore');
        }
        //fine nuovi controlli 
                     
        if(fr.ID_NOTIFICA.length() > 15){
        		EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                 return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Id Notifica');
             } 
             
        //ocntrollo su orario appuntamento diventato sincrono        
         if(!String.isBlank(fr_tmp.ORARIO_APPUNTAMENTO) ){
             String tmp = fr_tmp.ORARIO_APPUNTAMENTO;
            try{
                if(!tmp.split(':').get(0).isNumeric() || !tmp.split(':').get(1).isNumeric() || !tmp.split(':').get(2).isNumeric() ){
                	EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                  return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'ORARIO_APPUNTAMENTO');
                }
                if(tmp.split(':').get(0).length() != 2 || tmp.split(':').get(1).length() != 2 || tmp.split(':').get(2).length() != 2 ){
                	EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                  return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'ORARIO_APPUNTAMENTO');
                }                        
                if(Integer.valueOf(tmp.split(':').get(0)) > 23 || Integer.valueOf(tmp.split(':').get(1)) > 59 || Integer.valueOf(tmp.split(':').get(2)) > 59 ){
                	EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                  return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'ORARIO_APPUNTAMENTO');
                }
                
            }catch(Exception e){
            	EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                 return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'ORARIO_APPUNTAMENTO');
            }
        }
        
         if(fr.TIPO_COMUNICAZIONE == '2' || fr.TIPO_COMUNICAZIONE == '3' || fr.TIPO_COMUNICAZIONE == '4'){
                        
             //Could raise an exception if a case is not found but this scenario is not contemplated
             // 15/01/2018 Marco : Modifica alla query, aggiunta condizione sul codice operatore
             Case c = [SELECT Id, status, EOF_Codice_Operatore_WS__c, EOF_GPON_Attestazione__c, EOF_Id_Risorsa__c, EOF_Data_Notifica__c, EOF_Data_Prevista_Attivazione__c, EOF_Nuova_DAC__c, EOF_Pertinenza_RDAC__c,
                       EOF_Note_Appuntamento__c, EOF_Note_Sospensione__c
                       FROM Case WHERE EOF_Codice_ordine_OLO__c =: fr.CODICE_ORDINE_OLO AND EOF_Codice_Operatore_WS__c=: fr.CODICE_OPERATORE];             
             // 15/01/2018 Marco : fine modifica
             if(c.status == 'Espletato' || c.status == 'Espletato KO' || c.status == 'Cessato'|| c.status == 'Cessato KO' || c.status == 'Acquisito KO' || c.status == 'Annullato' || c.status == 'In Annullamento'){
       			EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
       			return EOF_GW_GE_Utils.syncError(fr,'A_K6','STATUS:' + c.status);
       		}
                     
             res_temp.Esito = '0';
             
             sl.Caso__c = c.id;
             
             //DAC Remodulation
             if(fr.TIPO_COMUNICAZIONE == '2'){
               		if(c.status != 'Acquisito' && c.status != 'Accettato' && c.status != 'Sospeso'){
			   			EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
			   			return EOF_GW_GE_Utils.syncError(fr,'A_K6','STATUS:' + c.status);
			   		}
                    
                    //Required field sync control
                    if(fr_tmp.DATA_PREVISTA_ATTIVAZIONE==null){
                    	EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Data Prevista Attivazione');                    
                    }
                 
                    //Required field async control
                    if(String.isBlank(fr_tmp.COGNOME_CLIENTE)){ 
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Cognome Cliente');                                             
                    }                                 
                    if(String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1)){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Recapito Telefonico Cliente');                      
                    }                               
                    if(fr_tmp.DATA_NOTIFICA==NULL){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Data Notifica');                      
                    }                    
                    
                    //Required fields format control
                    if(fr_tmp.COGNOME_CLIENTE.length() > 70){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Cognome Cliente');                        
                    }                                           
                    if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Recapito telefonico cliente');                        
                    }                        
     
                    //Optional field format control
                    if(!String.isBlank(fr_tmp.NOME_CLIENTE) && fr_tmp.NOME_CLIENTE.length() > 20){ 
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Nome Cliente');                      
                    }
                    if(!String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2) && (fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20)){ 
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Recapito telefonico cliente 2');                         
                    }
                    if(!String.isBlank(fr_tmp.NOME_REFERENTE_TECNICO_OLO) && fr_tmp.NOME_REFERENTE_TECNICO_OLO.length() > 50){ 
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Nome referente tecnico OLO');                        
                    }                        
                    if(!String.isBlank(fr_tmp.COGNOME_REFERENTE_TECNICO_OLO) && fr_tmp.COGNOME_REFERENTE_TECNICO_OLO.length() > 50){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Cognome referente tecnico OLO');                        
                    }                        
                    if(!String.isBlank(fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO) && fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO.length() > 20){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Telefono referente tecnico OLO');                         
                    }                        
                    if(!String.isBlank(fr_tmp.EMAIL_REFERENTE_TECNICO_OLO) && fr_tmp.EMAIL_REFERENTE_TECNICO_OLO.length() > 255){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Email referente tecnico OLO');                        
                    }                    
                    if(!String.isBlank(fr_tmp.RECAPITO_TEST_LINEA) && fr_tmp.RECAPITO_TEST_LINEA.length() > 20){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Recapito test linea');                            
                        }
                    if(!String.isBlank(fr_tmp.OPZIONE_SYSTEM_UNICO) && fr_tmp.OPZIONE_SYSTEM_UNICO != 'Y' && fr_tmp.OPZIONE_SYSTEM_UNICO != 'N'){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Opzione System Unico');                            
                        }
                    if(!String.isBlank(fr_tmp.NUMERO_TELEFONICO_PRINCIPALE_LINEA) && fr_tmp.NUMERO_TELEFONICO_PRINCIPALE_LINEA.length() > 20){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Numero telefonico principale linea');                            
                        }
                    if(!String.isBlank(fr_tmp.NOTE) && fr_tmp.NOTE.length() > 255){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Note');                            
                        }            
                     
                    if(!String.isBlank(fr_tmp.ORARIO_APPUNTAMENTO)){                                                       
                        Time t = Time.newInstance(Integer.valueOf(fr_tmp.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(fr_tmp.ORARIO_APPUNTAMENTO.substring(3,5)),
                                                  Integer.valueOf(fr_tmp.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
                        c.EOF_Nuova_DAC__c = DateTime.newInstance(EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE), t );
                        c.EOF_data_Appuntamento__c=EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE);
                        c.EOF_Orario_Appuntamento__c=fr_tmp.ORARIO_APPUNTAMENTO;
                    }else{
                        c.EOF_data_Appuntamento__c=EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE);
                        c.EOF_Nuova_DAC__c = DateTime.newInstance(EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
                    }
                 if(!String.isBlank(fr_tmp.NOTE)){
                    c.EOF_Note_Appuntamento__c = fr_tmp.NOTE;
                 }
                 c.EOF_Pertinenza_RDAC__c = 'OLO';                    
                 update c;
                 //aggiungo l'ACK sul sl di riferimento
	             sl.EOF_Response__c='ACK';
	             //creo una lista per fare update dell'sl originale e inserire l'ACK
	             List<EOF_EAI_Service_Log__c> slListToUpsert = new List<EOF_EAI_Service_Log__c>();
	             slListToUpsert.add(sl);
	             slListToUpsert.add(EOF_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK', 'Codice_operatore' => fr.CODICE_OPERATORE, 'Caso' => c.id, 
	                                                                          'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,  'ID_notifica' => fr.ID_NOTIFICA,
	                                                                          'Tipo Comunicazione' => 'OLO->SF - ACK - FiberRequest - '+EOF_GW_GE_Utils.retCodOp(fr),
	                                                                          'SL Riferimento' => sl.Id}));
                  upsert slListToUpsert;
                 create_notify(c, 8, 'OK', null, null);                   
                    
             }
                
             //De-sospension
             if(fr.TIPO_COMUNICAZIONE == '3'){
                    if(c.status != 'Sospeso'){
			   			EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
			   			return EOF_GW_GE_Utils.syncError(fr,'A_K6','STATUS:' + c.status);
			   		}
                    
                    //Required field async control
                    if(String.isBlank(fr_tmp.COGNOME_CLIENTE)){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Cognome Cliente');                                              
                    }          
                    if(String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1)){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Recapito Telefonico Cliente');                       
                    }                    
                    if(fr_tmp.DATA_NOTIFICA==NULL){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Data Notifica');                      
                    }
                    
                    //Required fields format control
                    if(fr_tmp.COGNOME_CLIENTE.length() > 70){  
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Cognome Cliente');                        
                    }                                         
                    if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Recapito telefonico cliente');                        
                    }                        
                    
                    //Optional field format control
                    if(!String.isBlank(fr_tmp.NOME_CLIENTE) && fr_tmp.NOME_CLIENTE.length() > 20){  
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Nome Cliente');                         
                    }
                    if(!String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2) && fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20){ 
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Recapito telefonico cliente 2');                        
                    }
                    if(!String.isBlank(fr_tmp.NOME_REFERENTE_TECNICO_OLO) && fr_tmp.NOME_REFERENTE_TECNICO_OLO.length() > 50){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Nome referente tecnico OLO');                         
                    }                        
                    if(!String.isBlank(fr_tmp.COGNOME_REFERENTE_TECNICO_OLO) && fr_tmp.COGNOME_REFERENTE_TECNICO_OLO.length() > 50){ 
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Cognome referente tecnico OLO');                        
                    }                        
                    if(!String.isBlank(fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO) && fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO.length() > 20){ 
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Telefono referente tecnico OLO');                       
                    }                        
                    if(!String.isBlank(fr_tmp.EMAIL_REFERENTE_TECNICO_OLO) && fr_tmp.EMAIL_REFERENTE_TECNICO_OLO.length() > 255){
                        EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Email referente tecnico OLO');                         
                    }
                    if(!String.isBlank(fr_tmp.RECAPITO_TEST_LINEA) && fr_tmp.RECAPITO_TEST_LINEA.length() > 20){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Recapito test linea');                            
                        }
                    if(!String.isBlank(fr_tmp.OPZIONE_SYSTEM_UNICO) && fr_tmp.OPZIONE_SYSTEM_UNICO != 'Y' && fr_tmp.OPZIONE_SYSTEM_UNICO != 'N'){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Opzione System Unico');                            
                        }
                    if(!String.isBlank(fr_tmp.NUMERO_TELEFONICO_PRINCIPALE_LINEA) && fr_tmp.NUMERO_TELEFONICO_PRINCIPALE_LINEA.length() > 20){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Numero telefonico principale linea');                            
                        }    
                    if(!String.isBlank(fr_tmp.NOTE) && fr_tmp.NOTE.length() > 255){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Note');                            
                        }           

                    if(!String.isBlank(fr_tmp.ORARIO_APPUNTAMENTO) && !String.isBlank(fr_tmp.DATA_PREVISTA_ATTIVAZIONE)){                                                       
                        Time t = Time.newInstance(Integer.valueOf(fr_tmp.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(fr_tmp.ORARIO_APPUNTAMENTO.substring(3,5)),
                                                  Integer.valueOf(fr_tmp.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
                        c.EOF_Nuova_DAC__c = DateTime.newInstance(EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE), t );
                        c.EOF_data_Appuntamento__c=EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE);
                        c.EOF_Orario_Appuntamento__c=fr_tmp.ORARIO_APPUNTAMENTO;
                    }else if(!String.isBlank(fr_tmp.DATA_PREVISTA_ATTIVAZIONE)){
                        c.EOF_data_Appuntamento__c=EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE);
                        c.EOF_Nuova_DAC__c = DateTime.newInstance(EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
                        c.EOF_Orario_Appuntamento__c='';
                    }
                     if(!String.isBlank(fr_tmp.NOTE)){
                        c.EOF_Note_Appuntamento__c = fr_tmp.NOTE;
                     }
                        
                     c.EOF_Pertinenza_RDAC__c = 'OLO';
                     create_notify(c, 8, 'OK', null, null);
                    c.Status = 'Accettato';
                    c.EOF_Fase__c = 'Desospeso';
                    update c;
                    //aggiungo l'ACK sul sl di riferimento
	             sl.EOF_Response__c='ACK';
	             //creo una lista per fare update dell'sl originale e inserire l'ACK
	             List<EOF_EAI_Service_Log__c> slListToUpsert = new List<EOF_EAI_Service_Log__c>();
	             slListToUpsert.add(sl);
	             slListToUpsert.add(EOF_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK', 'Codice_operatore' => fr.CODICE_OPERATORE, 'Caso' => c.id, 
	                                                                          'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,  'ID_notifica' => fr.ID_NOTIFICA,
	                                                                          'Tipo Comunicazione' => 'OLO->SF - ACK - FiberRequest - '+EOF_GW_GE_Utils.retCodOp(fr),
	                                                                          'SL Riferimento' => sl.Id}));
                  upsert slListToUpsert;
                    create_notify(c, 10, 'OK', null, null);
                                                  
             }
              
             //Cancellation
             if(fr.TIPO_COMUNICAZIONE == '4'){                 
    			if(c.status != 'Acquisito' && c.status != 'Accettato' && c.status != 'Sospeso'){
			   			EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
			   			return EOF_GW_GE_Utils.syncError(fr,'A_K6','STATUS:' + c.status);
			   		}
                  
                  //Required field async control
                  if(String.isBlank(fr_tmp.COGNOME_CLIENTE)){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Cognome Cliente');                                               
                       }                       
                  if(fr_tmp.DATA_NOTIFICA==null){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Data Notifica');                                                                    
                       }               
                  if(String.isBlank(fr_tmp.CAUSALE_RICHIESTA_ANNULLAMENTO)){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Causale Richiesta Annullamento');                                                
                       } 
                  if(String.isBlank(fr_tmp.CODICE_RICHIESTA_ANNULLAMENTO)){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Codice Richiesta Annullamento');                                               
                       } 
                    
                   //Required fields format control
                  if(fr_tmp.COGNOME_CLIENTE.length() > 70){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Cognome Cliente');                         
                       }  
                  if(fr_tmp.CAUSALE_RICHIESTA_ANNULLAMENTO.length() > 255){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Causale Richiesta Annullamento');                            
                        }
                  if(fr_tmp.CODICE_RICHIESTA_ANNULLAMENTO.length() > 10){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Codice Richiesta Annullamento');                            
                        }
                                      
                  //Asynchronous check on field request
                  if(!String.isBlank(fr_tmp.NOME_CLIENTE) && fr_tmp.NOME_CLIENTE.length() > 20){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Nome Cliente');                         
                       }
                  if(!String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1) && fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Recapito telefonico cliente 1');                           
                       }
                  if(!String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2) && fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Recapito telefonico cliente 2');                           
                       }
                  if(!String.isBlank(fr_tmp.NOME_REFERENTE_TECNICO_OLO) && fr_tmp.NOME_REFERENTE_TECNICO_OLO.length() > 50){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Nome referente tecnico OLO');                          
                        }                        
                  if(!String.isBlank(fr_tmp.COGNOME_REFERENTE_TECNICO_OLO) && fr_tmp.COGNOME_REFERENTE_TECNICO_OLO.length() > 50){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Cognome referente tecnico OLO');                           
                        }                        
                  if(!String.isBlank(fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO) && fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO.length() > 20){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Telefono referente tecnico OLO');                          
                        }                        
                  if(!String.isBlank(fr_tmp.EMAIL_REFERENTE_TECNICO_OLO) && fr_tmp.EMAIL_REFERENTE_TECNICO_OLO.length() > 255){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Email referente tecnico OLO');                            
                        }
                  if(!String.isBlank(fr_tmp.RECAPITO_TEST_LINEA) && fr_tmp.RECAPITO_TEST_LINEA.length() > 20){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Recapito test linea');                            
                        }
                  if(!String.isBlank(fr_tmp.OPZIONE_SYSTEM_UNICO) && fr_tmp.OPZIONE_SYSTEM_UNICO != 'Y' && fr_tmp.OPZIONE_SYSTEM_UNICO != 'N'){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Opzione System Unico');                            
                        }
                  if(!String.isBlank(fr_tmp.NUMERO_TELEFONICO_PRINCIPALE_LINEA) && fr_tmp.NUMERO_TELEFONICO_PRINCIPALE_LINEA.length() > 20){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Numero telefonico principale linea');                            
                        }
                  if(!String.isBlank(fr_tmp.NOTE) && fr_tmp.NOTE.length() > 255){
                            EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                        	return EOF_GW_GE_Utils.syncError(fr, 'A_K6', 'Note');                            
                        }             

               c.Status = 'Annullato';
               c.EOF_Causale_Richiesta_Annullamento__c = fr_tmp.CAUSALE_RICHIESTA_ANNULLAMENTO;
               c.EOF_Codice_Richiesta_Annullamento__c = fr_tmp.CODICE_RICHIESTA_ANNULLAMENTO;               
               update c;
               //aggiungo l'ACK sul sl di riferimento
	             sl.EOF_Response__c='ACK';
	             //creo una lista per fare update dell'sl originale e inserire l'ACK
	             List<EOF_EAI_Service_Log__c> slListToUpsert = new List<EOF_EAI_Service_Log__c>();
	             slListToUpsert.add(sl);
	             slListToUpsert.add(EOF_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK', 'Codice_operatore' => fr.CODICE_OPERATORE, 'Caso' => c.id, 
	                                                                          'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO,  'ID_notifica' => fr.ID_NOTIFICA,
	                                                                          'Tipo Comunicazione' => 'OLO->SF - ACK - FiberRequest - '+EOF_GW_GE_Utils.retCodOp(fr),
	                                                                          'SL Riferimento' => sl.Id}));
                  upsert slListToUpsert;
               create_notify(c, 13, 'OK', null, null);                  

             }
             return res_temp;
         }
              
         if(fr.TIPO_COMUNICAZIONE == '1'){
         	
             //Synchronous check             
             if(fr_tmp.DATA_PREVISTA_ATTIVAZIONE==null){
             	EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
                 return EOF_GW_GE_Utils.syncError(fr, 'A_K5', 'Data Prevista Attivazione');                    
             }
            
            RecordType rt = [SELECT Id FROM RecordType WHERE sObjectType = 'Case' AND Name = 'EOF Caso - Attivazione' LIMIT 1];
            
            case_tmp = new Case(
            
                //Synchronous control
                Type = fr.TIPO_COMUNICAZIONE,
                RecordTypeId = rt.Id,
                EOF_Codice_Operatore_WS__c = fr.CODICE_OPERATORE,            
                EOF_Codice_Ordine_OLO__c = fr.CODICE_ORDINE_OLO,
                EOF_Data_Notifica__c = EOF_GW_GE_Utils.StringToDate(fr.DATA_NOTIFICA),
                EOF_Id_Notifica__c = fr.ID_NOTIFICA,                
                EOF_Data_Prevista_Attivazione__c = EOF_GW_GE_Utils.StringToDateNoTime(fr.DATA_PREVISTA_ATTIVAZIONE),
                //CRM 05/05/2017 aggiunto id building per verifiche B_K16 e B_K17
                EOF_Id_Building_WS__c=fr.ID_Building,
                //Status = 'Acquisito',  
                Status = 'Inviato', 
                EOF_Fase__c = 'NA',              
                Origin = 'Web'                          
            ); 
            /*parte eliminata per problemi su amministratori  
            //faccio il check per amministratori
            List<Case> caseAmm = [select Id,CA_Numero_Ordini_in_Corso__c from Case where recordtype.developername='CA_Amministratori' and CA_ID_Building__c=:fr_tmp.ID_Building
            						AND status!='Realizzazione Impianto Completata'
        						AND status!='Negoziazione OF Richiesta Permesso Lavori KO' AND status!='Negoziazione OF Accesso Censimento Interno KO'];
            if(!caseAmm.isEmpty()){
            	for(case cAmm : caseAmm){
            		cAmm.CA_Codice_Ordine_in_Corso__c=fr_tmp.CODICE_ORDINE_OLO;
        			cAmm.CA_Stato_Ordine_in_Corso__c=case_tmp.status;
            		cAmm.CA_Numero_Ordini_in_Corso__c=cAmm.CA_Numero_Ordini_in_Corso__c+1;
            	}
            	try{
            		update caseAmm;
            	}
            	catch(exception e){
            		system.debug('L exception è: '+e);
            	}
            } 
            */   
        }
        
         if(fr.TIPO_COMUNICAZIONE == '11'){      
             
             RecordType rt = [SELECT Id FROM RecordType WHERE sObjectType = 'Case' AND Name = 'EOF Caso - Cessazione' LIMIT 1];
            
             case_tmp = new Case(
                Type = fr.TIPO_COMUNICAZIONE,
                RecordTypeId = rt.Id,
                EOF_Codice_Operatore_WS__c = fr.CODICE_OPERATORE,            
                EOF_Codice_Ordine_OLO__c = fr.CODICE_ORDINE_OLO,
                EOF_Data_Notifica__c =EOF_GW_GE_Utils.StringToDate(fr.DATA_NOTIFICA),
                EOF_Id_Notifica__c = fr.ID_NOTIFICA,
                EOF_Id_Risorsa__c = fr.ID_RISORSA,           
                //Status = 'Acquisito',  
                Status = 'Inviato', 
                EOF_Fase__c = 'NA',  
                Origin = 'Web',
                Description = fr.NOTE
                );                 
            }     
        
             //A_K7 synchronous error checking - prevent insert
             List<Case> case_list = [SELECT Id, EOF_Codice_Ordine_OLO__c FROM Case WHERE EOF_Codice_Ordine_OLO__c = : fr.CODICE_ORDINE_OLO and RecordType.DeveloperName ='EOF_Caso_Cessazione'];
             if(!case_list.isEmpty()){
             	EOF_GW_GE_Utils.IDReferenceSl=sl.Id;
             	return EOF_GW_GE_Utils.syncError(fr, 'A_K7', null);
             }
                       
                                            
              Database.DMLOptions dmo = new Database.DMLOptions();
              dmo.assignmentRuleHeader.useDefaultRule = true;
              case_tmp.setOptions(dmo);
              insert case_tmp;                
              system.debug('DG_EOF_GW_Utils - Codice_Ordine_EOF__c: ' + case_tmp.Codice_Ordine_EOF__c);
          List<EOF_EAI_Service_Log__c> slListToUpsert = new List<EOF_EAI_Service_Log__c>();
          sl.Caso__c = case_tmp.id;
          sl.EOF_Response__c='ACK';
         slListToUpsert.add(sl);

          //Inserting ACK Service Log
          slListToUpsert.add(EOF_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK', 'Codice_operatore' => fr.CODICE_OPERATORE, 'Caso' => case_tmp.id, 
                                                                       'Codice_ordine_OLO' => fr.CODICE_ORDINE_OLO, 'ID_notifica' => fr.ID_NOTIFICA,
                                                                       'Tipo Comunicazione' => 'OLO->SF - ACK - FiberRequest - '+EOF_GW_GE_Utils.retCodOp(fr),
                                                                       'SL Riferimento' => sl.Id}));  
           upsert slListToUpsert;        
          res_temp.Esito = '0';      
        
          //Checking Asyncronous controls
          EOF_GW_Utils.checkAsync(case_tmp);              
    		system.debug('DG_EOF_GW_Utils - Codice_Ordine_EOF__c: ' + case_tmp.Codice_Ordine_EOF__c);
        
        // 23/05/2018 MM : aggiorno il timestamp. END corrisponde alla fine dei check generali.
        OM_GW_GE_Utils.tpl.Timestamp__c= OM_GW_GE_Utils.tpl.Timestamp__c + ', END : '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
		OM_GW_GE_Utils.tpl.Attraversamento__c = datetime.now().getTime() - OM_GW_GE_Utils.AttrTime;        	 
        
        // finisce qui

        // 25/05/2018 MM : inserisco il templog.
        try{
        	insert OM_GW_GE_Utils.tpl;
        }
        catch(Exception e){
	    	OM_GW_GE_Utils.tpl.Type__c='E';
	    	OM_GW_GE_Utils.tpl.desc__c='Errore :' +e;
			OM_GW_GE_Utils.tpl.Attraversamento__c = datetime.now().getTime() - OM_GW_GE_Utils.AttrTime;        	 
	    	
	    	insert OM_GW_GE_Utils.tpl;        	
        }
		// fine
		        
        return res_temp;
    } 
    
    public static void checkAsync(Case c){ 
                
        //Updating OLO lookup to case
        system.debug('INSIDE ASYNC');
        system.debug('f request'+fr_tmp);
        //system.debug('acc value'+fr_tmp.CODICE_OPERATORE);
        Account oloId = [SELECT Id, Type, EOF_Codice_Operatore__c  FROM Account WHERE Type = 'OLO' AND EOF_Codice_Operatore__c =: fr_tmp.CODICE_OPERATORE LIMIT 1];
         system.debug('acc value---'+oloId);
        c.EOF_Account_OLO__c = oloId.id;
        update c;
        
        //Activation        
        if(c.Type == '1'){ 
            if(String.isBlank(fr_tmp.IDENTIFICATIVO_DEL_POP)){
                c.EOF_Causale_Errore__c = 'Campo \'' + 'Identificativo del POP' + '\' obbligatorio non valorizzato';
                c.Status = 'Acquisito KO';
                c.EOF_Fase__c = 'NA'; 
                update c;
                create_notify(c, 5, 'KO', 'A_K1', 'Identificativo del POP');
                return;
            }
            if(fr_tmp.IDENTIFICATIVO_DEL_POP.length() > 10 ){
                c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Identificativo del POP' + '\' non ammesso';
                c.Status = 'Acquisito KO';
                c.EOF_Fase__c = 'NA';
                update c;
                create_notify(c, 5, 'KO', 'A_K2', 'Identificativo del POP');
                return;
            }   
            c.EOF_Identificativo_del_POP__c = fr_tmp.IDENTIFICATIVO_DEL_POP;
             
            if(String.isBlank(fr_tmp.COMUNE)){
                c.EOF_Causale_Errore__c = 'Campo \'' + 'Comune' + '\' obbligatorio non valorizzato';
                c.Status = 'Acquisito KO';
                c.EOF_Fase__c = 'NA'; 
                update c;
                create_notify(c, 5, 'KO', 'A_K1', 'Comune'); 
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
            
            c.EOF_Comune_WS__c=fr_tmp.COMUNE; 
                 
            //Required field sync control
            if(fr_tmp.DATA_PREVISTA_ATTIVAZIONE!=null){
                Date DPA = EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE);
                Integer year = DPA.year();
                Integer month = DPA.month();
                Integer day = DPA.day();
                Datetime targetTime = Datetime.newInstance(year, month, day, 0, 0, 0);
                BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
                Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);  
                
                if(isWithin == false && fr_tmp.progetto_speciale!='TIS_20170403_000000001'){ 
                        c.EOF_Causale_Errore__c = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA';
                        c.EOF_Data_Prevista_Attivazione__c=EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE);
                        update c;
                        create_notify(c, 5, 'KO', 'A_K14', 'Data Prevista Attivazione'); 
                        return; }                
            }
            
            //Required fields async controls
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
            if(fr_tmp.DATA_NOTIFICA==NULL){
            c.EOF_Causale_Errore__c = 'Campo \'' + 'Data Notifica' + '\' obbligatorio non valorizzato';
                c.Status = 'Acquisito KO';
                c.EOF_Fase__c = 'NA'; 
                update c;
                create_notify(c, 5, 'KO', 'A_K1', 'Data Notifica');
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
            if(String.isBlank(fr_tmp.NUMERO_TELEFONICO_PRINCIPALE_LINEA)){
                c.EOF_Causale_Errore__c = 'Campo \'' + 'Numero telefonico principale linea' + '\' obbligatorio non valorizzato';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K1', 'Numero telefonico principale linea');
                    return;                                                        
                }
            if(String.isBlank(fr_tmp.ID_BUILDING)){
                c.EOF_Causale_Errore__c = 'Campo \'' + 'ID Building' + '\' obbligatorio non valorizzato';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K1', 'ID Building');
                    return;
                }
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
            if(!String.isBlank(fr_tmp.GPON_ATTESTAZIONE) && String.isBlank(fr_tmp.GPON_VINCOLANTE)){
                c.EOF_Causale_Errore__c = 'Campo \'' + 'GPON Vincolante' + '\' obbligatorio non valorizzato';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K1', 'GPON Vincolante');
                    return;
                }
    
            //Required fields format control
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
                  
            if(fr_tmp.COGNOME_CLIENTE.length() > 70){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Cognome Cliente' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Cognome Cliente'); 
                    return; 
                }                                             
            if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Recapito telefonico cliente' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Recapito telefonico cliente'); 
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
            if(fr_tmp.ID_BUILDING.length() > 150){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Id Building' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Id Building'); 
                    return; 
                }
            if(fr_tmp.NUMERO_TELEFONICO_PRINCIPALE_LINEA.length() > 20){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Numero telefonico principale linea' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 13, 'KO', 'A_K2', 'Numero telefonico principale linea');
                    return;                                                       
                } 
    
            //Optional field format control
            if(!String.isBlank(fr_tmp.NOME_CLIENTE) && fr_tmp.NOME_CLIENTE.length() > 20){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Nome Cliente' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Nome Cliente'); 
                    return; 
                }                       
            if(!String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2) && fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Recapito telefonico cliente 2' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Recapito telefonico cliente 2'); 
                    return; 
                }
            if(!String.isBlank(fr_tmp.GPON_ATTESTAZIONE) && fr_tmp.GPON_ATTESTAZIONE.length() > 50){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'GPON di attestazione' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'GPON di attestazione'); 
                    return; 
                }// Marco : modifiche ai controlli
            if(!String.isBlank(fr_tmp.SCALA_PALAZZINA) && fr_tmp.SCALA_PALAZZINA.length() > 21){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Scala Palazzina' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Scala Palazzina'); 
                    return; 
            }
            // Marco : fine modifiche controlli
            if(!String.isBlank(fr_tmp.RECAPITO_TEST_LINEA) && fr_tmp.RECAPITO_TEST_LINEA.length() > 20){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Recapito Test Linea' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Recapito Test Linea'); 
                    return; 
                } 
            if(!String.isBlank(fr_tmp.PASSWORD_APPARATO) && fr_tmp.PASSWORD_APPARATO.length() > 20){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Password Apparato' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Password Apparato'); 
                    return; 
                }
            if(!String.isBlank(fr_tmp.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH) && fr_tmp.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH.length() > 20){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Telefono referente olo onfield notech' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Telefono referente olo onfield notech'); 
                    return; 
                }
            if(!String.isBlank(fr_tmp.TIPOLOGIA_APPARATO) && fr_tmp.TIPOLOGIA_APPARATO.length() > 100){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Tipologia Apparato' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Tipologia Apparato'); 
                    return; 
                }
            if(!String.isBlank(fr_tmp.PROGETTO_SPECIALE) && fr_tmp.PROGETTO_SPECIALE.length() > 50){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Progetto Speciale' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Progetto Speciale'); 
                    return; 
                }
            if(!String.isBlank(fr_tmp.COLLEGAMENTO_P2P) && fr_tmp.COLLEGAMENTO_P2P != '1'){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Collegamento P2P' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Collegamento P2P'); 
                    return; 
                }
            if(!String.isBlank(fr_tmp.NOTE) && fr_tmp.NOTE.length() > 255){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Note' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Note'); 
                    return; 
                }
            if(!String.isBlank(fr_tmp.TIPOLOGIA_SERVIZIO) && (fr_tmp.TIPOLOGIA_SERVIZIO.length() > 1)){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Tipologia Servizio' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Tipologia Servizio'); 
                    return; 
                }
            if(!String.isBlank(fr_tmp.SLA_PREMIUM_ASSURANCE) && fr_tmp.SLA_PREMIUM_ASSURANCE != 'Y' && fr_tmp.SLA_PREMIUM_ASSURANCE != 'N'){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'SLA Premium Assurance' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'SLA Premium Assurance'); 
                    return; 
                }
            if(!String.isBlank(fr_tmp.APPARATO) && fr_tmp.APPARATO != 'Y' && fr_tmp.APPARATO != 'N'){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Apparato' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Apparato'); 
                    return; 
                }
            if(!String.isBlank(fr_tmp.GPON_VINCOLANTE) && fr_tmp.GPON_VINCOLANTE != 'Y' && fr_tmp.GPON_VINCOLANTE!= 'N' ){
                c.EOF_Causale_Errore__c = 'Valore campo \'' + 'GPON Vincolante' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'GPON Vincolante');
                    return;
                }
            if(!String.isBlank(fr_tmp.OPZIONE_SYSTEM_UNICO) && fr_tmp.OPZIONE_SYSTEM_UNICO != 'Y' && fr_tmp.OPZIONE_SYSTEM_UNICO != 'N'){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Opzione System Unico' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Opzione System Unico'); 
                    return; 
                }                                
            if(!String.isBlank(fr_tmp.ORARIO_APPUNTAMENTO)){
             String tmp = fr_tmp.ORARIO_APPUNTAMENTO;
                try{
                    if(!tmp.split(':').get(0).isNumeric() || !tmp.split(':').get(1).isNumeric() || !tmp.split(':').get(2).isNumeric() ){
                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'SLA Premium Assurance' + '\' non ammesso';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA';
                        update c;
                        create_notify(c, 5, 'KO', 'A_K2', 'Orario Appuntamento');
                        return;
                    }                        
                    else if(Integer.valueOf(tmp.split(':').get(0)) > 23 || Integer.valueOf(tmp.split(':').get(1)) > 59 || Integer.valueOf(tmp.split(':').get(2)) > 59 ){
                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'SLA Premium Assurance' + '\' non ammesso';
                        c.Status = 'Acquisito KO';
                        c.EOF_Fase__c = 'NA';
                        update c;                           
                        create_notify(c, 5, 'KO', 'A_K2', 'Orario Appuntamento');
                        return;
                        }
                }catch(Exception e){
                    c.EOF_Causale_Errore__c = 'Valore campo \'' + 'SLA Premium Assurance' + '\' non ammesso';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    update c;
                    create_notify(c, 5, 'KO', 'A_K2', 'Orario Appuntamento');
                    return;
                }
            }
    
            //Network Inventory controls
            /*
            List<EOF_Network_Inventory__c> NI = new List<EOF_Network_Inventory__c>();
            List<EOF_Network_Inventory__c> NI2 = new List<EOF_Network_Inventory__c>();
            List<EOF_Network_Inventory__c> NI3 = new List<EOF_Network_Inventory__c>();                    
            */
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
            
            //faccio il check per amministratori
            List<Case> caseAmm = [select Id,CA_Numero_Ordini_in_Corso__c from Case where recordtype.developername='CA_Amministratori' and CA_ID_Building__c=:fr_tmp.ID_Building];
            if(!caseAmm.isEmpty()){
            	for(case cAmm : caseAmm){
            		cAmm.CA_Codice_Ordine_in_Corso__c=fr_tmp.CODICE_ORDINE_OLO;
            		cAmm.CA_Stato_Ordine_in_Corso__c=c.status;
            		cAmm.CA_Numero_Ordini_in_Corso__c=cAmm.CA_Numero_Ordini_in_Corso__c+1;
            	}
            	try{
            		update caseAmm;
            	}
            	catch(exception e){
            		system.debug('L exception è: '+e);
            	}
            }
            
            List<EOF_Network_Inventory__c> ni = [SELECT Id,EOF_Civico__c,EOF_Comune__c,EOF_GPON_ID__c,EOF_ID_Building__c,EOF_Pop__c,
                                    EOF_Indirizzo__c, EOF_Particella_Top__c,EOF_Provincia__c,EOF_Scala_Palazzina__c,EOF_Stato_Building__c
                                     FROM EOF_Network_Inventory__c WHERE EOF_ID_Building__c =: fr_tmp.ID_Building];  
            
            if(ni.isEMpty()){
                c.EOF_Causale_Errore__c = 'Identificativo Building Errato';
                c.Status = 'Acquisito KO'; 
                c.EOF_Fase__c = 'NA';
                update c;
                create_notify(c, 5, 'KO', 'B_K4', 'ID Building'); 
                return; 
            } 
            //creo la lista ordinata degli stati building positivi
            List<Integer> positivi = new List<Integer>();
			positivi.add(110);
			positivi.add(104);
			positivi.add(105);
			positivi.add(106);
			positivi.add(107);
			positivi.add(109);
			
			//creo la lista ordinata degli stati building negativi
			List<Integer> negativi = new List<Integer>();
			negativi.add(101);
			negativi.add(102);
			negativi.add(103);
			negativi.add(108);
			
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
				c.EOF_Causale_Errore__c = 'Building non RFC/RFA';
                c.Status = 'Acquisito KO';
                c.EOF_Fase__c = 'NA';
                c.EOF_Stato_Building__c = corretto.EOF_Stato_Building__c;
                c.EOF_Identificativo_del_POP__c = corretto.EOF_Pop__c;                          
                c.EOF_Istat_Provincia__c = corretto.EOF_Provincia__c;
                c.EOF_Istat_Comune__c= corretto.EOF_Comune__c;
                c.EOF_Particella_Toponomastica_WS__c = corretto.EOF_Particella_Top__c;
                c.EOF_Indirizzo_WS__c = corretto.EOF_Indirizzo__c;
                c.EOF_Numero_Civico_WS__c = corretto.EOF_Civico__c;
                c.EOF_ID_Building_WS__c = corretto.EOF_ID_Building__c;
                c.EOF_Scala_Palazzina_WS__c = corretto.EOF_Scala_Palazzina__c; 
                update c;
                create_notify(c, 5, 'KO', 'B_K5', 'ID Building'); 
                return; 
			}
            else{
            	//caso in cui è stato trovato nella lista degli stati building positivi
               if(((corretto.EOF_Stato_Building__c == 110 && EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE) < RFA.date()) || (corretto.EOF_Stato_Building__c != 110 && EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE) < RFC.date())) && fr_tmp.progetto_speciale!='TIS_20170403_000000001'){
                    c.EOF_Causale_Errore__c = 'Data Attesa Consegna non conforme agli SLA';
                    c.Status = 'Acquisito KO';
                    c.EOF_Fase__c = 'NA';
                    c.EOF_Stato_Building__c = corretto.EOF_Stato_Building__c;
                    c.EOF_Data_Prevista_Attivazione__c=EOF_GW_GE_Utils.StringToDateNoTime(fr_tmp.DATA_PREVISTA_ATTIVAZIONE);
                    c.EOF_Stato_Building__c = corretto.EOF_Stato_Building__c;
                    c.EOF_Identificativo_del_POP__c = corretto.EOF_Pop__c;                          
                    c.EOF_Istat_Provincia__c = corretto.EOF_Provincia__c;
                    c.EOF_Istat_Comune__c= corretto.EOF_Comune__c;
                    c.EOF_Particella_Toponomastica_WS__c = corretto.EOF_Particella_Top__c;
                    c.EOF_Indirizzo_WS__c = corretto.EOF_Indirizzo__c;
                    c.EOF_Numero_Civico_WS__c = corretto.EOF_Civico__c;
                    c.EOF_ID_Building_WS__c = corretto.EOF_ID_Building__c;
                    c.EOF_Scala_Palazzina_WS__c = corretto.EOF_Scala_Palazzina__c;
                    update c;
                    create_notify(c, 5, 'KO', 'A_K3', 'Data Prevista Attivazione'); 
                    return; 
                } 
            }
            if(corretto.EOF_Pop__c != fr_tmp.IDENTIFICATIVO_DEL_POP){ 
                c.EOF_Causale_Errore__c = 'Associazione ID Building-POP errata';
                c.Status = 'Acquisito KO';
                c.EOF_Fase__c = 'NA';
                c.EOF_Identificativo_del_POP__c = corretto.EOF_Pop__c;                          
                c.EOF_Istat_Provincia__c = corretto.EOF_Provincia__c;
                c.EOF_Istat_Comune__c= corretto.EOF_Comune__c;
                c.EOF_Particella_Toponomastica_WS__c = corretto.EOF_Particella_Top__c;
                c.EOF_Indirizzo_WS__c = corretto.EOF_Indirizzo__c;
                c.EOF_Numero_Civico_WS__c = corretto.EOF_Civico__c;
                c.EOF_ID_Building_WS__c = corretto.EOF_ID_Building__c;
                c.EOF_Scala_Palazzina_WS__c = corretto.EOF_Scala_Palazzina__c;
                c.EOF_Stato_Building__c = corretto.EOF_Stato_Building__c; 
                update c;
                create_notify(c, 5, 'KO', 'B_K6', 'ID Building'); 
                return; 
            }
            
            c.EOF_Identificativo_del_POP__c = corretto.EOF_Pop__c;                          
            c.EOF_Istat_Provincia__c = corretto.EOF_Provincia__c;
            c.EOF_Istat_Comune__c= corretto.EOF_Comune__c;
            c.EOF_Particella_Toponomastica_WS__c = corretto.EOF_Particella_Top__c;
            c.EOF_Indirizzo_WS__c = corretto.EOF_Indirizzo__c;
            c.EOF_Numero_Civico_WS__c = corretto.EOF_Civico__c;
            c.EOF_ID_Building_WS__c = corretto.EOF_ID_Building__c;
            c.EOF_Scala_Palazzina_WS__c = corretto.EOF_Scala_Palazzina__c;
            c.EOF_Stato_Building__c = corretto.EOF_Stato_Building__c;      
            
            //CRM 02/05/2017 - aggiunto per la gestione delle notifiche riguradanti i controlli commerciali e contrattuali
			String check = null;
			OF_UtilitiesManageOrderFromCase obj = new OF_UtilitiesManageOrderFromCase();
			system.debug('DG_EOF_GW_Utils - Codice_Ordine_EOF__c: ' + c.Codice_Ordine_EOF__c);
            check = obj.VerificheCommContratt1(c);
			system.debug('DG_EOF_GW_Utils dopo le verifiche--- check: ' + check);
			c.OF_IDContratto__c = obj.getIDContratto();
			system.debug('DG_EOF_GW_Utils - c.OF_IDContratto__c: ' + c.OF_IDContratto__c);
			//se check = true	--> le verifiche sono passate
			//se check = false	--> le verifiche non sono passate
			if(check == 'B_K17'){
                c.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
                c.Status = 'Acquisito KO';
                c.EOF_Fase__c = 'NA';
                update c;
                create_notify(c,5,'KO','B_K17',null);
                return;
			}
            if(check == 'B_K16'){
                c.EOF_Causale_Errore__c = 'Città/POP non vendibile per l\'OLO';
                c.Status = 'Acquisito KO';
                c.EOF_Fase__c = 'NA';
                update c;
                create_notify(c,5,'KO','B_K16',null);
                return;
			}
			//End CRM
             
    		/* adattamento  nuove specifiche di creazione del cliente SEMPRE 06/04/2017
            //Gathering account
            List<Account> acc;
              if(String.isBlank(fr_tmp.NOME_CLIENTE))
                acc = [SELECT Id, Name FROM Account WHERE Name =:fr_tmp.COGNOME_CLIENTE AND Phone =: fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1];
            else
                acc = [SELECT Id, Name FROM Account WHERE LastName =:fr_tmp.COGNOME_CLIENTE AND Phone =: fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1];         
            
            //Account found --- complete case fields using Account retrieved 
            if(!acc.isEmpty())
                c.AccountId = acc.get(0).Id;
            else{  
            	in caso aggiungere qui la logica di creazione del cliente
            }   
            */  
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
                                                c.AccountId = a.Id;
                                                update c;
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
                        c.AccountId = a.Id;
                        update c;
                    }            
                                                
                    //Using Technician required information in the request to retrieve the Account in the system
                    List<Contact> tech = [SELECT Id, FirstName, LastName, Phone, Email FROM Contact WHERE 
                                          FirstName =: fr_tmp.NOME_REFERENTE_TECNICO_OLO AND LastName =: fr_tmp.COGNOME_REFERENTE_TECNICO_OLO 
                                          AND LastName =: fr_tmp.COGNOME_REFERENTE_TECNICO_OLO AND Email =: fr_tmp.EMAIL_REFERENTE_TECNICO_OLO];  
                    if(!tech.isEmpty()){
                        c.EOF_Contact__c = tech.get(0).Id;                   
                    }
                    else{ 
                        Recordtype pa = [select Id from recordtype where name='Referente Tecnico OLO'];
                        COntact refTec = new COntact();
                        refTec.recordTypeId=pa.Id;
                        refTec.AccountId=oloid.id;
                        refTec.FirstName =fr_tmp.NOME_REFERENTE_TECNICO_OLO;
                        refTec.LastName = fr_tmp.COGNOME_REFERENTE_TECNICO_OLO;
                        refTec.LastName = fr_tmp.COGNOME_REFERENTE_TECNICO_OLO;
                        refTec.Email = fr_tmp.EMAIL_REFERENTE_TECNICO_OLO;
                        try{
                           insert refTec;
                           c.EOF_Contact__c = refTec.Id;
                        }
                        catch(DMLException e){
                            create_notify(c, 5, 'KO', 'A_K2', e.getDmlFields(0).get(0).getdescribe().getlabel());
                        }
                    }
                    //Asynchronous check on case field request                                       
                   c.EOF_Async_Check_ctrl__c = true;
                    c.EOF_GPON_Attestazione__c = fr_tmp.GPON_ATTESTAZIONE;
                    c.EOF_GPON_Vincolante__c = fr_tmp.GPON_VINCOLANTE;                         
                    c.EOF_Recapito_Test_Linea__c = fr_tmp.RECAPITO_TEST_LINEA;
                    c.EOF_Numero_Telefonico_Principale_Linea__c = fr_tmp.NUMERO_TELEFONICO_PRINCIPALE_LINEA;
                    c.EOF_Password_Apparato__c = fr_tmp.PASSWORD_APPARATO;
                    c.EOF_Telefono_Referente_OLO_Onfield_Notec__c   = fr_tmp.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH;
                    c.EOF_Opzione_System_Unico__c = fr_tmp.OPZIONE_SYSTEM_UNICO;                   
                    c.EOF_Apparato__c = fr_tmp.APPARATO;
                    c.EOF_Tipologia_Apparato__c = fr_tmp.TIPOLOGIA_APPARATO;
                    c.EOF_Progetto_Speciale__c = fr_tmp.PROGETTO_SPECIALE;            
                    c.EOF_Collegamento_P2P__c = fr_tmp.COLLEGAMENTO_P2P;
                    c.Description = fr_tmp.NOTE;
                    c.EOF_Tipologia_Servizio__c = fr_tmp.TIPOLOGIA_SERVIZIO;
                    c.EOF_SLA_Premium_Assurance__c = fr_tmp.SLA_PREMIUM_ASSURANCE;
                    c.EOF_Orario_Appuntamento__c = fr_tmp.ORARIO_APPUNTAMENTO;
                    c.Status = 'Acquisito'; 
                    c.EOF_Fase__c = 'Da lavorare';         
					 
					//campi nuovi 05/04/2017
					List<OF_ElencoComuniItaliani__c> cList = new List<OF_ElencoComuniItaliani__c>();
					cList=[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.EOF_Comune__c];
					if (!cList.isEmpty()){
						if(String.isNotBlank(cList[0].OF_Comune__c)){
							c.EOF_Comune_WS__c=cList[0].OF_Comune__c;
						}
						if(String.isNotBlank(cList[0].OF_Provincia__c)){
							c.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
						}
					}
 					
					
                    update c;					
                    create_notify(c, 5, 'OK', null, null); 
                } 
                        
        //Cessation
        if(c.Type == '11'){
            
                    //Required fields async controls
                    if(fr_tmp.DATA_NOTIFICA==NULL){
                                c.EOF_Causale_Errore__c = 'Campo \'' + 'Data Notifica' + '\' obbligatorio non valorizzato';
                                    c.Status = 'Cessato KO';
                                    c.EOF_Fase__c = 'NA';
                                    update c;
                                    create_notify(c, 12, 'KO', 'A_K1', 'Data Notifica');
                                    return;                   
                                    }            
                    if(String.isBlank(fr_tmp.ID_RISORSA)){
                                    c.EOF_Causale_Errore__c = 'Campo \'' + 'Id Risorsa' + '\' obbligatorio non valorizzato';
                                    c.Status = 'Cessato KO';
                                    c.EOF_Fase__c = 'NA'; 
                                    update c;
                                    create_notify(c, 12, 'KO', 'A_K1', 'Id Risorsa');
                                    return;
                                    }
                    if(!String.isBlank(fr_tmp.APPARATO) && fr_tmp.APPARATO == 'Y'){   
                        if(String.isBlank(fr_tmp.COGNOME_CLIENTE)){
                                        c.EOF_Causale_Errore__c = 'Campo \'' + 'Cognome Cliente' + '\' obbligatorio non valorizzato';
                                        c.Status = 'Cessato KO';
                                        c.EOF_Fase__c = 'NA'; 
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K1', 'Cognome Cliente');
                                        return;
                                    }
                        if(String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1)){
                                        c.EOF_Causale_Errore__c = 'Campo \'' + 'Recapito telefonico cliente 1' + '\' obbligatorio non valorizzato';
                                        c.Status = 'Cessato KO';
                                        c.EOF_Fase__c = 'NA'; 
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K1', 'Recapito telefonico cliente 1');
                                        return;
                                    }
                        if(fr_tmp.COGNOME_CLIENTE.length() > 70){
                                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Cognome Cliente' + '\' non ammesso';
                                        c.Status = 'Cessato KO';
                                        c.EOF_Fase__c = 'NA';
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K2', 'Cognome Cliente'); 
                                        return; 
                                    }                     
                        if(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20){
                                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Recapito telefonico cliente' + '\' non ammesso';
                                        c.Status = 'Cessato KO';
                                        c.EOF_Fase__c = 'NA';
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K2', 'Recapito telefonico cliente'); 
                                        return; 
                                    }
                    }
            
                    //Required fields format control
                    if(fr_tmp.ID_RISORSA.length() > 50){
                                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Id Risorsa' + '\' non ammesso';
                                        c.Status = 'Cessato KO';
                                        c.EOF_Fase__c = 'NA';
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K2', 'Cognome Cliente'); 
                                        return; 
                                    }
                    
                    //Optional fields format control
                    if(!String.isBlank(fr_tmp.COGNOME_CLIENTE) && fr_tmp.COGNOME_CLIENTE.length() > 70){
                                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Cognome Cliente' + '\' non ammesso';
                                        c.Status = 'Cessato KO';
                                        c.EOF_Fase__c = 'NA';
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K2', 'Cognome Cliente'); 
                                        return; 
                                    }
                    if(!String.isBlank(fr_tmp.NOME_CLIENTE) && fr_tmp.NOME_CLIENTE.length() > 20){
                                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Nome Cliente' + '\' non ammesso';
                                        c.Status = 'Cessato KO';
                                        c.EOF_Fase__c = 'NA';
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K2', 'Nome Cliente'); 
                                        return; 
                                    }
                    if(!String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1) && fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20){
                                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Recapito telefonico cliente 1' + '\' non ammesso';
                                        c.Status = 'Cessato KO';
                                        c.EOF_Fase__c = 'NA';
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K2', 'Recapito telefonico cliente 1'); 
                                        return; 
                                    }
                    if(!String.isBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2) && fr_tmp.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20){
                                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Recapito telefonico cliente 2' + '\' non ammesso';
                                        c.Status = 'Cessato KO';
                                        c.EOF_Fase__c = 'NA';
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K2', 'Recapito telefonico cliente 2'); 
                                        return; 
                                    }      
                    if(!String.isBlank(fr_tmp.NOTE) && fr_tmp.NOTE.length() > 255){
                                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Apparato' + '\' non ammesso';
                                        c.Status = 'Acquisito KO';
                                        c.EOF_Fase__c = 'NA';
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K2', 'Apparato');   
                                        return;                                                                   
                                    }
                    if(!String.isBlank(fr_tmp.APPARATO) && fr_tmp.APPARATO != 'Y' && fr_tmp.APPARATO != 'N'){
                                        c.EOF_Causale_Errore__c = 'Valore campo \'' + 'Apparato' + '\' non ammesso';
                                        c.Status = 'Acquisito KO';
                                        c.EOF_Fase__c = 'NA';
                                        update c;
                                        create_notify(c, 12, 'KO', 'A_K2', 'Apparato'); 
                                        return; 
                        } 
                        
                        
                    /* adattamento  nuove specifiche di creazione del cliente SEMPRE 06/04/2017
                    if(String.isNotBlank(fr_tmp.COGNOME_CLIENTE) && String.isNotBlank(fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1)){     
	                   //Gathering account
	                    List<Account> acc;
	                      if(String.isBlank(fr_tmp.NOME_CLIENTE))
	                        acc = [SELECT Id, Name FROM Account WHERE Name =:fr_tmp.COGNOME_CLIENTE AND Phone =: fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1];
	                    else
	                        acc = [SELECT Id, Name FROM Account WHERE LastName =:fr_tmp.COGNOME_CLIENTE AND Phone =: fr_tmp.RECAPITO_TELEFONICO_CLIENTE_1];         
	                    
	                    //Account found --- complete case fields using Account retrieved 
	                    if(!acc.isEmpty())
	                        c.AccountId = acc.get(0).Id;
	                    else{  
	                    	in caso aggiungere qui la logica di creazione del cliente
	                    } 
	                */
	                if(String.isNotBlank(fr_tmp.COGNOME_CLIENTE)) {
	                	       
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
			                                        c.AccountId = a.Id;
			                                        update c;
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
	                        c.AccountId = a.Id;
	                        update c;
	                    }            
	                } 
            	
                   
                   if(String.isNotBlank(fr_tmp.NOME_REFERENTE_TECNICO_OLO) && String.isNotBlank(fr_tmp.COGNOME_REFERENTE_TECNICO_OLO) && String.isNotBlank(fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO) && String.isNotBlank(fr_tmp.EMAIL_REFERENTE_TECNICO_OLO)){                  
	                    //Using Technician required information in the request to retrieve the Account in the system
	                    List<Contact> tech = [SELECT Id, FirstName, LastName, Phone, Email FROM Contact WHERE 
	                                          FirstName =: fr_tmp.NOME_REFERENTE_TECNICO_OLO AND LastName =: fr_tmp.COGNOME_REFERENTE_TECNICO_OLO 
	                                          AND Phone =: fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO AND Email =: fr_tmp.EMAIL_REFERENTE_TECNICO_OLO];  
	                    if(!tech.isEmpty()){
	                        c.EOF_Contact__c = tech.get(0).Id;                   
	                    }
	                    else{ 
	                        Recordtype pa = [select Id from recordtype where name='Referente Tecnico OLO'];
	                        COntact refTec = new COntact();
	                        refTec.recordTypeId=pa.Id;
	                        refTec.AccountId=oloid.id;
	                        refTec.FirstName =fr_tmp.NOME_REFERENTE_TECNICO_OLO;
	                        refTec.LastName = fr_tmp.COGNOME_REFERENTE_TECNICO_OLO;
	                        refTec.Phone = fr_tmp.TELEFONO_REFERENTE_TECNICO_OLO;
	                        refTec.Email = fr_tmp.EMAIL_REFERENTE_TECNICO_OLO;
	                        insert refTec;
	                        c.EOF_Contact__c = refTec.Id;
	                    }  
        			}                            
                    
                    List<Asset> a = [SELECT Id, EOF_ID_Risorsa__c, EOF_OLO__C, Status, Account.EOF_Codice_Operatore__c, Name FROM Asset WHERE EOF_ID_Risorsa__c =: fr_tmp.ID_RISORSA];
                   if(a.isempty() || a[0].Status=='Cessato' || (fr_tmp.codice_operatore!=a[0].Account.EOF_Codice_Operatore__c && fr_tmp.codice_operatore!=a[0].EOF_OLO__C)){  
                        c.Status = 'Cessato KO';
                        c.EOF_Fase__c = 'NA';  
                        c.EOF_Causale_Errore__c = 'ID Risorsa da cessare inesistente/errato';
                        update c; 
                        create_notify(c, 12, 'KO', 'C_K13', null);                       
                   }
                    else{ 
                            c.Status = 'Acquisito';
                            c.EOF_Fase__c = 'Da lavorare'; 
                            c.AssetId=a[0].Id;
                            //CRM 29-03-2017 - Aggiunti campi
                        	c.EOF_Apparato__c = fr_tmp.APPARATO;
                            update c;
                            //Commented out  due to Enel business requirements to be reviewed
                            //create_notify(c, 12, 'OK', null, null);
                    }
                    //CRM 04/05/2017 aggiunto aggiornamento service log per far scattare il process builder e popolare le date dei BE
                    list<EOF_EAI_Service_log__c> slog = [select id, EOF_NOTE__c,EOF_Tipo_Comunicazione__c, caso__c, caso__r.assetid from EOF_EAI_Service_log__c where caso__c =: c.id and EOF_Tipo_Comunicazione__c = '11' limit 1];
                    system.debug('DG_EOF_GW_Utils slog');
                    if(!slog.isempty()){
                    	system.debug('DG_EOF_GW_Utils dentro if slog: ' + slog);
                    	update slog;
                    }
                    //END CRM
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
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c   = '';
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
        RecordType rtNotify = [SELECT Id FROM RecordType WHERE Name = 'FiberNotify'];
        RecordType rt_Ack = [SELECT Id FROM RecordType WHERE Name = 'ACK' LIMIT 1];
        RecordType rt_Nack = [SELECT Id FROM RecordType WHERE Name = 'NACK' LIMIT 1];                
         
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
                        //EOF_Inviata__c = false,
                        Updated__c = true
                    );                    
                    try{
                        insert notify;
                        EOF_Notify__c notifyRec = new EOF_Notify__c();
                        notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                                                     
                        
                         EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----                       
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
					
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
                            //EOF_Inviata__c = false,
                            Updated__c = true
                        );                       
                        try{
                            insert notify;
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                           // notifyRec = EOF_GW_GE_Utils.updateFiberNotify(notifyRec);
                            EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
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
                            //EOF_Inviata__c = false,
                            Updated__c = true
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                            //notifyRec = EOF_GW_GE_Utils.updateFiberNotify(notifyRec);
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
                        }catch(Exception e){
                            res_temp.CausaleErrore = e.getmessage();
                     }  
                }                
                
                if(errorCode == 'B_K4'){                               
                    notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                        
                            EOF_Stato_Richiesta__c = objectStatus,                          
                            Motivo_Rifiuto_Sospensione_Annullamento__c = 'Identificativo Building Errato',
                            EOF_Data_Notifica__c = system.now(),
                            //EOF_Inviata__c = false,
                            Updated__c = true
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                          //  notifyRec = EOF_GW_GE_Utils.updateFiberNotify(notifyRec);
                            EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                     }  
                }    
                
                if(errorCode == 'B_K5'){                               
                    notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                                    
                            EOF_Stato_Richiesta__c = objectStatus,                          
                            Motivo_Rifiuto_Sospensione_Annullamento__c = 'Building non RFC/RFA',
                            EOF_Data_Notifica__c = system.now(),
                            //EOF_Inviata__c = false,
                            Updated__c = true
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                         // notifyRec = EOF_GW_GE_Utils.updateFiberNotify(notifyRec);
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                     }  
                }    
             
                if(errorCode == 'B_K6'){                               
                    notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                                    
                            EOF_Stato_Richiesta__c = objectStatus,                          
                            Motivo_Rifiuto_Sospensione_Annullamento__c = 'Associazione ID Building-POP errata',
                            EOF_Data_Notifica__c = system.now(),
                            //EOF_Inviata__c = false,
                            Updated__c = true
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                        //    notifyRec = EOF_GW_GE_Utils.updateFiberNotify(notifyRec);
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                     }  
                }    
               
                if(errorCode == 'A_K3'){                               
                    notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                                     
                            EOF_Stato_Richiesta__c = objectStatus,                          
                            Motivo_Rifiuto_Sospensione_Annullamento__c = 'Data Attesa Consegna non conforme agli SLA',
                            EOF_Data_Notifica__c = system.now(),
                            //EOF_Inviata__c = false,
                            Updated__c = true
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                         //   notifyRec = EOF_GW_GE_Utils.updateFiberNotify(notifyRec);
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                       
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                     }  
                } 
                
                if(errorCode == 'A_K14'){                               
                    notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                                    
                            EOF_Stato_Richiesta__c = objectStatus,                          
                            Motivo_Rifiuto_Sospensione_Annullamento__c = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato',
                            EOF_Data_Notifica__c = system.now(),
                            //EOF_Inviata__c = false,
                            Updated__c = true
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                        //  notifyRec = EOF_GW_GE_Utils.updateFiberNotify(notifyRec);
                            String reqString = EOF_GW_GE_Utils.copy_notify(notifyRec);
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                       
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                     }  
                }

				//CRM start 02/05/2017 Aggiunta logica per gestione notifiche B_K16 e B_K17
				if(errorCode == 'B_K16'){                               
                    notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                                    
                            EOF_Stato_Richiesta__c = objectStatus,                          
                            //Motivo_Rifiuto_Sospensione_Annullamento__c = 'Città/POP non vendibile per l\\' + '\'OLO',
                        	Motivo_Rifiuto_Sospensione_Annullamento__c = 'Città/POP non vendibile per l\'OLO',
                            EOF_Data_Notifica__c = system.now(),
                            //EOF_Inviata__c = false,
                            Updated__c = true
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                        //    notifyRec = EOF_GW_GE_Utils.updateFiberNotify(notifyRec);
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                     }  
                }
				
				if(errorCode == 'B_K17'){  
                    system.debug('DG_Passo EOF');
                    notify = new EOF_Notify__c(
                            RecordTypeId = rt_ko.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                                                    
                            EOF_Stato_Richiesta__c = objectStatus,                          
                            //Motivo_Rifiuto_Sospensione_Annullamento__c = 'OLO non abilitato all\\' + '\'invio dell\\' + '\'ordine',
                            Motivo_Rifiuto_Sospensione_Annullamento__c = 'OLO non abilitato all\'invio dell\'ordine',
                            EOF_Data_Notifica__c = system.now(),
                            //EOF_Inviata__c = false,
                            Updated__c = true
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                        //    notifyRec = EOF_GW_GE_Utils.updateFiberNotify(notifyRec);
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                     }  
                }
				//END CRM
               }            
        }  
        
        //Acceptance notify 
        if(notify_type == 6){
            
        //Gathering notify record type
        rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di accettazione' LIMIT 1];
        rt_ko = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di accettazione KO' LIMIT 1];
        system.debug('inside 6');
            if(objectStatus == 'OK'){
                 system.debug('inside ok');
                notify = new EOF_Notify__c(
                            RecordTypeId = rt.id,
                            Caso__c = c.id,
                            EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                            EOF_Codice_Ordine_EOF__c = c.id,
                            EOF_GPON_Attestazione__c = c.EOF_GPON_Attestazione__c,
                            EOF_Stato_Richiesta__c = objectStatus,
                            EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),           
                            EOF_Data_Notifica__c = system.now(),                        
                            EOF_Inviata__c = false
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
                        try{
                            insert notify;
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                            
                        notifyRec.EOF_Data_Espletamento_Ordine__c = null;
                        notifyRec.EOF_ID_Risorsa__c = '';
                        notifyRec.EOF_ID_Apparato_Consegnato__c = '';
                        notifyRec.EOF_Esito_Consegna_Apparato__c = '';  
                        notifyRec.EOF_Parametri_Trasmissivi_Ottici__c = '';
                        notifyRec.EOF_ID_Splitter_Secondario__c = '';
                        notifyRec.EOF_Posizione_Splitter_Secondario__c = '';
                        notifyRec.EOF_Nuova_DAC__c = null;
                      //notifyRec.EOF_Codice_Motivazione_Rimodulazione__c = '';
                        notifyRec.EOF_Reason_Rimodulazione_DAC__c = '';
                        notifyRec.Flag_Pagamento__c = '';
                        notifyRec.Numero_Operatore__c = '';
                        if(notifyRec.EOF_Stato_Richiesta__c != '1') {
                            notifyRec.Motivo_Rifiuto_Sospensione_Annullamento__c = '';
                        }
                        system.debug('not update----'+notifyRec.EOF_Esito_Consegna_Apparato__c);
                        
            
                        update notifyRec;
                        
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                         //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                         //createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
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
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                            String reqString = EOF_GW_GE_Utils.copy_notify(notifyRec);
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        //createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
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
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                       //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                       //createAckNackNotifyServiceLog(notifyRec.Id+'');
                       
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                      }
                
                    //EOF_Network_Inventory__c ni = [SELECT Id FROM EOF_Network_Inventory__c WHERE EOF_ID_Building__c =:]                    
                    /*DG 17/03/2017 Commentato per nuova gestione creazione asset
                    Asset a = new Asset();
                    a.Name = c.id;
                    a.AccountId = c.AccountId;
                    a.Status='Attivo';                    
                    insert a;
                    c.AssetId = a.id; 
                    update c;
                    */ 
                    system.debug('EOF_GW_Utils.Create_Notify --> NO CREAZIONE ASSET e NO AGGIORNAMENTO DEL CASE');           
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
                            EOF_Notify__c notifyRec = new EOF_Notify__c();
                            notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                            String reqString = EOF_GW_GE_Utils.copy_notify(notifyRec);
                             EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                         //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                         // createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
                        }catch(Exception e){                            
                            res_temp.CausaleErrore = e.getmessage();
                      }                
                }          
            }        
        
        //DAC Remodulation notify 
        if(notify_type == 8){
            
        //Gathering notify record type
        rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di rimodulazione DAC' LIMIT 1];
                                
            String orario_DAC = '';
            if(!String.isBlank(fr_tmp.ORARIO_APPUNTAMENTO))
                orario_DAC = fr_tmp.ORARIO_APPUNTAMENTO;
            else
                orario_DAC = '00:00';
            
            notify = new EOF_Notify__c(
                        RecordTypeId = rt.id,
                        Caso__c = c.id,
                        EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                        EOF_Codice_Ordine_EOF__c = c.id,
                        EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                        
                        EOF_Stato_Richiesta__c = objectStatus,
                        EOF_Data_Notifica__c = system.now(),
                        EOF_Nuova_DAC__c = EOF_GW_GE_Utils.StringToDateNoTIme(fr_tmp.DATA_PREVISTA_ATTIVAZIONE),
                        EOF_Orario_DAC__c = orario_DAC,
                        EOF_Reason_Rimodulazione_DAC__c = 'Ripianificazione appuntamento causa OLO',
                        EOF_Inviata__c = false
                    );
 
           if(objectStatus == 'KO'){                    
                if(errorCode == 'A_K1')
                    notify.Motivo_Rifiuto_Sospensione_Annullamento__c = 'Campo \'' + field + '\' obbligatorio non valorizzato';
                if(errorCode == 'A_K2')
                    notify.Motivo_Rifiuto_Sospensione_Annullamento__c = 'Valore campo \'' + field + '\' non ammesso';                    
                }            
        
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                        insert notify;
                        EOF_Notify__c notifyRec = new EOF_Notify__c();
                        notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id, EOF_Orario_DAC__c,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                        String reqString = EOF_GW_GE_Utils.copy_notify(notifyRec);  
                         EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;                
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        //createAckNackNotifyServiceLog(notifyRec.Id+'');
                        //c.EOF_Data_Prevista_Attivazione__c = notify.EOF_Nuova_DAC__c;
                        c.canModify__c = true;
                        update c;
                        
                    }catch(Exception e){                        
                        res_temp.CausaleErrore = e.getmessage();
                  }
            }        
        
        //Suspension notify 
        if(notify_type == 9){
            
        //Gathering notify record type
        rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di sospensione' LIMIT 1];
            
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
                        EOF_Notify__c notifyRec = new EOF_Notify__c();
                        notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                        String reqString = EOF_GW_GE_Utils.copy_notify(notifyRec);
                         EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
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
                    if(objectStatus == 'KO'){
                    if(errorCode == 'A_K1'){
                        notify.Motivo_Rifiuto_Sospensione_Annullamento__c = 'Campo \'' + field + '\' obbligatorio non valorizzato';
                    }
                    if(errorCode == 'A_K2'){
                        notify.Motivo_Rifiuto_Sospensione_Annullamento__c = 'Valore campo \'' + field + '\' non ammesso'; 
                    }
                    //aggiungo i campi di errore per il service log
                    fr_tmp.CAUSALE_RICHIESTA_ANNULLAMENTO=notify.Motivo_Rifiuto_Sospensione_Annullamento__c;
                    fr_tmp.CODICE_RICHIESTA_ANNULLAMENTO=errorCode;                   
                } 
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                        insert notify;
                        EOF_Notify__c notifyRec = new EOF_Notify__c();
                        notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                         EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        //createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
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
                        EOF_Notify__c notifyRec = new EOF_Notify__c();
                        notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                         EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----                       
                        if(c.EOF_Fase__c == 'Da lavorare')
                             createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
                    }catch(Exception e){                        
                        res_temp.CausaleErrore = e.getmessage();
                  }
                
               /*Asset a = new Asset(Id = c.assetId,status='Non Attivo');update a; */
                
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
                        EOF_Notify__c notifyRec = new EOF_Notify__c();
                        notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                         EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        if(c.EOF_Fase__c == 'NA')
                                createAckNackNotifyServiceLog(notifyRec.Id+'');
                       
                    }catch(Exception e){                       
                        res_temp.CausaleErrore = e.getmessage();
                  }
                }else{                
                
                if(errorCode == 'A_K1')    
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
                if(errorCode == 'A_K2')
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
                        EOF_Notify__c notifyRec = new EOF_Notify__c();
                        notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                        String reqString = EOF_GW_GE_Utils.copy_notify(notifyRec);
                         EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----                        
                        if(c.EOF_Fase__c == 'NA')
                             createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
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
                        Motivo_Rifiuto_Sospensione_Annullamento__c = 'Annullamento su richiesta OLO',
                        EOF_Data_Notifica__c = system.now(),
                        EOF_Esito_Consegna_Apparato__c = null,
                        //EOF_Inviata__c = false
                        Updated__c = true
                    );
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                        insert notify;
                        EOF_Notify__c notifyRec = new EOF_Notify__c();
                        notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                         EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
                        createAckNackNotifyServiceLog(notifyRec.Id+'');
                        
                    }catch(Exception e){                       
                        res_temp.CausaleErrore = e.getmessage();
                  }
            }     
      
        return notify.Id;                                                                                   
      }   
      
    //------------Method to create ack/nack log for fiber notify---------------------
    @Future(callout=true)    
    public static void createAckNackNotifyServiceLog(String idnotifyRec){
        
            
            
        
            EOF_Notify__c notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id, EOF_Orario_DAC__c,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: idnotifyrec];
            
            //Setting time zone format string            
            Integer offset = UserInfo.getTimeZone().getOffset(system.now())/3600000;
            String prefix = (offset >= 0) ? '+'  : '-';
            String a = prefix + ((Math.abs(offset) < 10) ? ('0'+ Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));
            String formatedStr = notifyRec.EOF_Data_Notifica__c.format('yyyy-MM-dd\'T\'HH:mm:ss\''+a+'\'');

            String Nuova_DAC = String.ValueOf(notifyRec.EOF_Nuova_DAC__c);
            if(notifyRec.RecordType.Name == 'Notifica di rimodulazione DAC'){
                if(!String.isBlank(notifyRec.EOF_Orario_DAC__c)){
                    Time Orario_DAC = Time.newInstance(Integer.valueOf(notifyRec.EOF_Orario_DAC__c.substring(0,2)), Integer.valueOf(notifyRec.EOF_Orario_DAC__c.substring(3,5)), 0, 0);
                    DateTime Orario_Nuova_DAC = DateTime.newInstance(notifyRec.EOF_Nuova_Dac__c, Orario_DAC);
                    Nuova_DAC = Orario_Nuova_DAC.format('yyyy-MM-dd\'T\'HH:mm:ss\''+a+'\'');
                    }
                else{
                    if(!String.isBlank(String.valueOf(notifyRec.EOF_Nuova_Dac__c))){
                        Time Orario_DAC = Time.newInstance(0, 0, 0, 0);
                        DateTime Orario_Nuova_DAC = DateTime.newInstance(notifyRec.EOF_Nuova_Dac__c, Orario_DAC);
                        Nuova_DAC = Orario_Nuova_DAC.format('yyyy-MM-dd\'T\'HH:mm:ss\''+a+'\'');
                    }                      
                }                    
            }                
        
            xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 stub = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();          
              
            xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType response = new xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();
        
            //set timeout
            stub.timeout_x = 30000;
            
            //Invoking the callout with corresponding parameters
            
            response = stub.Notify(notifyRec.EOF_Codice_Operatore__c,                
                                        notifyRec.EOF_Tipo_Comunicazione_ctrl__c, 
                                        notifyRec.EOF_Codice_Ordine_OLO__c,
                                        notifyRec.EOF_Codice_Ordine_EOF__c,                                                                        
                                        notifyRec.EOF_ID_Notifica__c,
                                        notifyRec.EOF_Stato_Richiesta_ctrl__c,
                                        notifyRec.EOF_GPON_Attestazione__c,
                                        notifyRec.Codice_Rifiuto_Sospensione_Annullamento__c,
                                        notifyRec.Motivo_Rifiuto_Sospensione_Annullamento__c,
                                        String.valueOf(notifyRec.EOF_Data_Espletamento_Ordine__c),
                                        notifyRec.EOF_ID_Risorsa__c,
                                        formatedStr,
                                        notifyRec.EOF_ID_Apparato_Consegnato__c,
                                        notifyRec.EOF_Esito_Consegna_Apparato_ctrl__c,
                                        notifyRec.EOF_Parametri_Trasmissivi_Ottici__c,
                                        notifyRec.EOF_ID_Splitter_Secondario__c,
                                        notifyRec.EOF_Posizione_Splitter_Secondario__c,
                                        Nuova_DAC,
                                        notifyRec.EOF_Codice_Motivazione_Rimodulazione__c,
                                        notifyRec.EOF_Reason_Rimodulazione_DAC__c,
                                        notifyRec.EOF_Note__c,
                                        notifyRec.Flag_Pagamento__c,
                                        notifyRec.Numero_Operatore__c);
        
            system.debug('The value of response--' + response);
            //Creating EAI_Service_Logs based on the response
            String s = notifyRec.Tipo_Comunicazione__c.right(notifyRec.Tipo_Comunicazione__c.length()-12);
            if(Integer.valueOf(response.Esito) == 0){
            	RecordType rt_Ack = [SELECT Id FROM RecordType WHERE Name = 'ACK' LIMIT 1];
                EOF_EAI_Service_Log__c ackLog = new EOF_EAI_Service_Log__c(
                	EOF_Tipo_COmunicazione_String__c='SF->OLO - ACK - Fibernotify - '+s,
                    Caso__c = notifyRec.Caso__c,
                    RecordTypeId = rt_Ack.id,
                    Notify__c = notifyRec.id,
                    EOF_Richiesta_Notifica__c =  'Esito:'+ response.Esito,     
                    EOF_ID_Notifica__c = notifyRec.EOF_ID_Notifica__c,
                    EOF_Codice_Ordine_OLO__c = notifyRec.EOF_Codice_Ordine_OLO__c,
                    EOF_Codice_Operatore__c = notifyRec.EOF_Codice_Operatore__c,
                    EOF_Data_Notifica__c = notifyRec.EOF_Data_Notifica__c       
                );
                //cerco il slog di riferimento su cui aggiornare il campo response
                String checkTipoComString='SF->OLO - Fibernotify - '+s;
                List<EOF_EAI_Service_Log__c> sl_reference = [select Id from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c =: notifyRec.EOF_ID_Notifica__c
                										and EOF_Codice_Ordine_OLO__c =: notifyRec.EOF_Codice_Ordine_OLO__c
                										and EOF_Tipo_COmunicazione_String__c= :checkTipoComString order by createdDate desc limit 1]; 
				if(!sl_reference.isEmpty()){
					sl_reference[0].EOF_Response__c='ACK';
					//lego l'ACK al slog di riferimento
					ackLog.EOF_SL_Riferimento__c=sl_reference[0].Id;
				}
				//se la lista è vuota (non dovrebbe avvenire) aggiungo solamente l'ack da inserire
				sl_reference.add(ackLog);
                upsert sl_reference;
            } 
            else{ 
            	RecordType rt_Nack = [SELECT Id FROM RecordType WHERE Name = 'NACK' LIMIT 1];
                EOF_EAI_Service_Log__c nackLog = new EOF_EAI_Service_Log__c(
                	EOF_Tipo_COmunicazione_String__c='SF->OLO - NACK - Fibernotify - '+s,
                    Caso__c = notifyRec.Caso__c,
                    RecordTypeId = rt_Nack.id,
                    Notify__c = notifyRec.id,
                    EOF_Richiesta_Notifica__c = 'Esito:'+ response.Esito + '\n' + 'Codice errore: ' + 
                                                 response.CodiceErrore + '\n' + 'Causale errore: ' +
                                                 response.CausaleErrore, 
                 	EOF_Codice_errore__c=response.CodiceErrore,
                    EOF_Causale_Errore__c=response.CausaleErrore,    
                    EOF_ID_Notifica__c = notifyRec.EOF_ID_Notifica__c,
                    EOF_Codice_Ordine_OLO__c = notifyRec.EOF_Codice_Ordine_OLO__c,
                    EOF_Codice_Operatore__c = notifyRec.EOF_Codice_Operatore__c,
                    EOF_Data_Notifica__c = notifyRec.EOF_Data_Notifica__c       
               ); 
               //cerco il slog di riferimento su cui aggiornare il campo response
                String checkTipoComString='SF->OLO - Fibernotify - '+s;
                List<EOF_EAI_Service_Log__c> sl_reference = [select Id from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c =: notifyRec.EOF_ID_Notifica__c
                										and EOF_Codice_Ordine_OLO__c =: notifyRec.EOF_Codice_Ordine_OLO__c
                										and EOF_Tipo_COmunicazione_String__c= :checkTipoComString order by createdDate desc limit 1]; 
				if(!sl_reference.isEmpty()){
					sl_reference[0].EOF_Response__c='NACK';
					//lego l'ACK al slog di riferimento
					nackLog.EOF_SL_Riferimento__c=sl_reference[0].Id;
				}
				//se la lista è vuota (non dovrebbe avvenire) aggiungo solamente il nack da inserire
				sl_reference.add(nackLog);
                upsert sl_reference;                 
            }           
      }
    
    
}
trigger SendNotify on EOF_Notify__c (before update, after update){
    //This trigger is written under single-notify edit case assumption  
    
    if(trigger.isBefore && trigger.isUpdate){
        EOF_Notify__c n = trigger.new.get(0);
        if(!n.EOF_Inviata__c)
            n.Updated__c = true;        
    }
    
    if(trigger.isAfter && trigger.isUpdate){
        for(EOF_Notify__c notify : trigger.new){
            
            if(!notify.EOF_Inviata__c && !Notify.Tipo_Comunicazione__c.containsIgnoreCase('Trouble Ticket')){
            
                Case originalCase = [SELECT Status,EOF_Fase__c,OwnerId,canModify__c,EOF_ID_Risorsa__c,EOF_Data_Prevista_Attivazione__c,EOF_Impresa__c, EOF_Nuova_DAC__c, EOF_Pertinenza_RDAC__c,
                                            EOF_Tipo_di_intervento__c, EOF_Tipo_di_intervento_aggiuntivo__c, EOF_Note_Appuntamento__c, EOF_Note_Sospensione__c,EOF_Order_Manager__c 
                                     FROM Case 
                                     WHERE Id = :notify.Caso__c];
                if(originalCase.EOF_Order_Manager__c==false){
	                Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
	                
	                if(notify.Tipo_comunicazione__c == 'Notifica di accettazione'){
	                    originalCase.Status = 'Accettato';
	                    originalcase.EOF_Fase__c = 'Da contattare';
	                    originalCase.EOF_Impresa__c = notify.EOF_Impresa__c;
	                    originalcase.EOF_GPON_Attestazione__c = notify.EOF_GPON_Attestazione__c;
	                    originalcase.canModify__c = true;
	                    update originalCase;
	                    EOF_EAI_Service_Log__C sl=EOF_GW_GE_Utils.create_EAI_Log(notify); 
				        insert sl;            
	                    EOF_GW_Utils.createAckNackNotifyServiceLog(notify.Id+'');
	                }
	                
	                if(notify.Tipo_comunicazione__c == 'Notifica di accettazione KO'){
	                    originalCase.Status = 'Accettato KO';
	                    originalcase.EOF_Fase__c = 'Accettato KO';
	                    originalcase.canModify__c = true;
	                    update originalCase;
	                    EOF_EAI_Service_Log__C sl=EOF_GW_GE_Utils.create_EAI_Log(notify); 
				        insert sl;
	                    if(!system.test.isRunningTest()){
	                        EOF_GW_Utils.createAckNackNotifyServiceLog(notify.Id+'');
	                    }
	                }
	                
	                if(notify.Tipo_comunicazione__c == 'Notifica di espletamento'){
	                     originalCase.EOF_Tipo_di_intervento__c = notify.EOF_Tipo_di_intervento__c;
	                     originalCase.EOF_Tipo_di_intervento_aggiuntivo__c = notify.EOF_Tipo_di_intervento_aggiuntivo__c;
	                     originalCase.Status = 'Espletato';
	                     originalcase.EOF_Fase__c = 'Espletato OK';
	                     originalcase.canModify__c = true;
	                     originalcase.EOF_ID_Apparato_Consegnato__c=notify.EOF_ID_Apparato_Consegnato__c;
						 /*OS30 Modifica 06_04_2017  Inizio*/
	                     system.debug('OS_NOTIFY ::'+originalcase);
	                     originalcase.EOF_ID_Risorsa__c = notify.EOF_ID_Risorsa__c;
	                     /*OS30 Modifica  06_04_2017 Fine */
	                     
	                     //aggiungo il campo per CRM
	                     if(String.isBlank(notify.eof_esito_consegna_apparato_ctrl__C)){
	                     	originalcase.OF_Esito_consegna_Apparato__c='0';
	                     }
	                     else{
	                     	originalcase.OF_Esito_consegna_Apparato__c=notify.eof_esito_consegna_apparato_ctrl__C;
	                     }
	
	                     update originalCase;
	                     EOF_EAI_Service_Log__C sl=EOF_GW_GE_Utils.create_EAI_Log(notify); 
			        	 insert sl;
	                     EOF_GW_Utils.createAckNackNotifyServiceLog(notify.Id+'');
	                }
	                
	                if(notify.Tipo_comunicazione__c == 'Notifica di espletamento KO'){
	                     originalCase.Status = 'Espletato KO';
	                     originalcase.EOF_Fase__c = 'Espletato KO';
	                     originalcase.canModify__c = true;
	                     update originalCase;
	                     EOF_EAI_Service_Log__C sl=EOF_GW_GE_Utils.create_EAI_Log(notify); 
		        		insert sl;
	                     EOF_GW_Utils.createAckNackNotifyServiceLog(notify.Id+'');
	                }
	                
	                if(notify.Tipo_comunicazione__c == 'Notifica di Rimodulazione DAC'){                
	                    Database.DMLOptions dmo = new Database.DMLOptions();
	                    dmo.assignmentRuleHeader.useDefaultRule = true;
	                    originalCase.setOptions(dmo);
	                    if(originalCase.Status == 'Accettato')
	                        originalCase.EOF_Fase__c='Appuntamento Fissato';
	                    else if(originalCase.Status == 'Acquisito')
	                        originalCase.EOF_Fase__c='In verifica BO';
	                    Time Orario_DAC = Time.newInstance(Integer.valueOf(notify.EOF_Orario_DAC__c.substring(0,2)), Integer.valueOf(notify.EOF_Orario_DAC__c.substring(3,5)), 0, 0);
	                    originalcase.EOF_Nuova_DAC__c = DateTime.newInstance(notify.EOF_Nuova_DAC__c, Orario_DAC);                
	                    originalcase.EOF_Pertinenza_RDAC__c = 'EOF';
	                    originalcase.EOF_Note_Appuntamento__c = notify.EOF_Note__c;
	
	                    originalcase.canModify__c = true;
	                    update originalCase;
	                    EOF_EAI_Service_Log__C sl=EOF_GW_GE_Utils.create_EAI_Log(notify); 
				        insert sl;
	                    EOF_GW_Utils.createAckNackNotifyServiceLog(notify.Id+'');
	                }
	                            
	                if(notify.Tipo_comunicazione__c == 'Notifica di sospensione'){   
	                    system.debug('l id dello user è: '+originalCase.OwnerId);
	
	                    User u;
	                    if(system.Test.isRunningTest()){
	                        u = [SELECT Id, Profile.Name FROM User WHERE Id =: userInfo.getUserId()];
	
	
	                    } 
	                    else{        
	                        u = [SELECT Id, Profile.Name FROM User WHERE Id =: originalCase.OwnerId];
	
	                    }
	                     if(u.Profile.Name == 'EOF Utente Back Office' || u.Profile.Name == 'EOF Responsabile BO'){
	                         originalCase.Status = 'Sospeso';
	                         originalcase.EOF_Fase__c = 'Sospeso BO';                 
	                     }
	                     else{
	                         originalCase.Status = 'Sospeso';
	                         originalcase.EOF_Fase__c = 'Sospeso Tecn.'; 
	                     }
	                    originalCase.OwnerId = bo.Id;
	                    originalcase.EOF_Note_Sospensione__c = notify.EOF_Note__c;
	
	                    originalcase.canModify__c = true;
	                    update originalCase;
	                    EOF_EAI_Service_Log__C sl=EOF_GW_GE_Utils.create_EAI_Log(notify); 
				        insert sl;
	                    EOF_GW_Utils.createAckNackNotifyServiceLog(notify.Id+'');
	                }
	                
	                if(notify.Tipo_comunicazione__c == 'Notifica di desospensione'){
	                    User u;
	                    if(system.Test.isRunningTest()){
	                        u = [SELECT Id, Profile.Name FROM User WHERE Id =: userInfo.getUserId()];
	
	
	                    } 
	                    else{        
	                        u = [SELECT Id, Profile.Name FROM User WHERE Id =: originalCase.OwnerId];
	
	                    }
	                    if(u.Profile.Name == 'EOF Utente Back Office' || u.Profile.Name == 'EOF Responsabile BO'){
	                         originalCase.Status = 'Accettato';
	                         originalcase.EOF_Fase__c = 'Da contattare';
	                         originalcase.canModify__c = true;
	                         update originalCase;
	                         EOF_EAI_Service_Log__C sl=EOF_GW_GE_Utils.create_EAI_Log(notify); 
			        		insert sl;
	                         EOF_GW_Utils.createAckNackNotifyServiceLog(notify.Id+'');
	                    }
	                    else{
	                        originalCase.Status = 'Accettato';
	                        originalcase.EOF_Fase__c = 'In Lavorazione';
	                        originalcase.canModify__c = true;
	                        update originalCase;
	                        EOF_EAI_Service_Log__C sl=EOF_GW_GE_Utils.create_EAI_Log(notify); 
				        insert sl;
	                        EOF_GW_Utils.createAckNackNotifyServiceLog(notify.Id+'');
	                    }
	                }
	                
	                if(notify.Tipo_comunicazione__c == 'Notifica di cessazione'){
	                     originalCase.Status = 'Cessato OK';
	                     originalcase.EOF_Fase__c = 'Cessato OK';
	                     originalcase.canModify__c = true;
	                     update originalCase; 
	                     /*CRM 30-03-2017 commentato per nuova gestione asset
	                     system.debug('case---'+originalCase.EOF_ID_Risorsa__c );           
	                     Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
	                     A.Status='Cessato';    
	
	
	                     update A;*/
						EOF_EAI_Service_Log__C sl=EOF_GW_GE_Utils.create_EAI_Log(notify); 
				        insert sl;
	                     EOF_GW_Utils.createAckNackNotifyServiceLog(notify.Id+'');
	                } 
	                
	                if(notify.Tipo_comunicazione__c == 'Notifica di cessazione KO'){
	                     originalCase.Status = 'Cessato KO';
	                     originalcase.EOF_Fase__c = 'Cessato KO';
	                     originalcase.canModify__c = true;                
	                     update originalCase;
	                     EOF_EAI_Service_Log__C sl=EOF_GW_GE_Utils.create_EAI_Log(notify); 
				        insert sl;
	                     EOF_GW_Utils.createAckNackNotifyServiceLog(notify.Id+'');
	                } 
                }
            }
            //check for trouble ticket
            if(!notify.EOF_Inviata__c && Notify.Tipo_Comunicazione__c.containsIgnoreCase('Trouble Ticket')){
                //List<recordType> listRec = [select Id from recordType where Name='Trouble Ticket - Notifica di Richiesta Chiusura'];
                Case originalCase = [SELECT Status,PO_TT_Portale__c,EOF_Fase__c,OwnerId,canModify__c,EOF_ID_Risorsa__c,EOF_Data_Prevista_Attivazione__c,EOF_Impresa__c, EOF_Nuova_DAC__c, EOF_Pertinenza_RDAC__c,
                                                EOF_Tipo_di_intervento__c, EOF_Tipo_di_intervento_aggiuntivo__c,EOF_Minuti_rimanenti_sospesi__c,EOF_Data_Max_Risoluzione_Ticket__c,
                                                EOF_Num_min_risoluzione_Ticket__c,EOF_COmunicazioni_con_OLO__C,EOF_Num_sec_risoluzione_Ticket__c,EOF_Secondi_Sospesi_allo_SLA__c,
												EOF_Rischedulazione_Appuntamento__c

                                         FROM Case 
                                         WHERE Id = :notify.Caso__c];
                                         

                if(notify.Tipo_comunicazione__c.equalsIgnoreCase('Trouble Ticket - Notifica di Richiesta Chiusura') && notify.EOF_Inviata__c==false){
                    originalCase.EOF_Descrizione_Intervento_Risoluzione__c=notify.Descrizione_evento_Risoluzione__c;
                    originalcase.status='Richiesta Chiusura';
                    originalcase.eof_fase__c='Attesa Chiusura';
                    if(String.isNotBlank(notify.EOF_NOte__c)){
                        if(String.isNotBlank(originalCase.EOF_COmunicazioni_con_OLO__C)){
                            originalCase.EOF_COmunicazioni_con_OLO__C=originalCase.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+notify.Tipo_comunicazione__c.right(notify.Tipo_comunicazione__c.length()-17)+' - '+userInfo.getName()+':\n'+notify.EOF_NOte__c;
                        }
                        else{
                            originalCase.EOF_COmunicazioni_con_OLO__C=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+notify.Tipo_comunicazione__c.right(notify.Tipo_comunicazione__c.length()-17)+' - '+userInfo.getName()+':\n'+notify.EOF_NOte__c;
                        }
                    } 
                    if(originalCase.EOF_Data_Max_Risoluzione_Ticket__c > OF_TT_Utils.now()){
                    	if(originalCase.EOF_Rischedulazione_Appuntamento__c!=null && originalCase.EOF_Rischedulazione_Appuntamento__c>OF_TT_Utils.now()){                    		
                			originalCase.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((originalCase.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-originalCase.EOF_Rischedulazione_Appuntamento__c.getTime()) / 1000);                    		
                    	}
                    	else{
                    		originalCase.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((originalCase.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-OF_TT_Utils.now().getTime()) / 1000);
                    	}
                    	
                    }
                    else{
                    	originalCase.EOF_Secondi_Sospesi_allo_SLA__c=0;
                    }

                    update originalcase;
                    insert OF_TT_Utils.create_EAI_Log(notify);
                    
                    //check se il case è da portale
					if(originalCase.PO_TT_Portale__c){
						OF_TT_Utils.updateSlPortale(String.valueOf(notify.Id));
					}
					else{
						OF_TT_Utils.createAckNackNotifyServiceLog(String.valueOf(notify.Id));
					}
                    
                }
                if(notify.Tipo_comunicazione__c.equalsIgnoreCase('Trouble Ticket - Notifica di Sospensione') && notify.EOF_Inviata__c==false){
                    if(originalcase.eof_fase__c.equalsIgnoreCase('in Analisi')){
                        originalcase.eof_fase__c='Sospeso Analisi';
                    }
                    if(originalcase.eof_fase__c.equalsIgnoreCase('On Field')){
                        originalcase.eof_fase__c='Sospeso On Field';
                    }
                    if(originalcase.eof_fase__c.equalsIgnoreCase('in Collaudo')){
                        originalcase.eof_fase__c='Sospeso Collaudo';
                    } 
                    //originalCase.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf(originalCase.EOF_Num_sec_risoluzione_Ticket__c);
                    if(originalCase.EOF_Data_Max_Risoluzione_Ticket__c > OF_TT_Utils.now()){
                    	if(originalCase.EOF_Rischedulazione_Appuntamento__c!=null && originalCase.EOF_Rischedulazione_Appuntamento__c>OF_TT_Utils.now()){                    		
                			originalCase.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((originalCase.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-originalCase.EOF_Rischedulazione_Appuntamento__c.getTime()) / 1000);                    		
                    	}
                    	else{
                    		originalCase.EOF_Secondi_Sospesi_allo_SLA__c=Integer.valueOf((originalCase.EOF_Data_Max_Risoluzione_Ticket__c.getTime()-OF_TT_Utils.now().getTime()) / 1000);
                    	}
                    	
                    }
                    else{
                    	originalCase.EOF_Secondi_Sospesi_allo_SLA__c=0;
                    }
                    if(notify.EOF_Rischedulazione_Appuntamento__c!=null){
                    	originalCase.EOF_Data_Max_Risoluzione_Ticket__c=notify.EOF_Rischedulazione_Appuntamento__c.addSeconds(Integer.ValueOF(originalCase.EOF_Secondi_Sospesi_allo_SLA__c));
                    	Integer numMin = Integer.valueOf(OF_TT_Parametri__c.getInstance().EOF_Num_min_ritorno_in_lavorazione__c) * (-1);
                    	if(notify.EOF_Rischedulazione_Appuntamento__c.addMinutes(numMin)<=Datetime.now()){
							originalCase.EOF_Data_Ritorno_In_Lavorazione__c=Datetime.now().addMinutes(1);
						}
						else{
							originalCase.EOF_Data_Ritorno_In_Lavorazione__c=notify.EOF_Rischedulazione_Appuntamento__c.addMinutes(numMin); 
						}
                    }
                    else{
                    	originalCase.EOF_Data_Max_Risoluzione_Ticket__c=OF_TT_Utils.now().addSeconds(Integer.ValueOF(originalCase.EOF_Secondi_Sospesi_allo_SLA__c));
                    }
                   		                    
					originalCase.EOF_Rischedulazione_Appuntamento__c=notify.EOF_Rischedulazione_Appuntamento__c;     		
                      
					
                    if(String.isNotBlank(notify.Causale_Sospensione__c)){
                    	originalCase.EOF_Causale_Sospensione__c=notify.Causale_Sospensione__c;
                    }
                                                  
                    else if(String.isNotBlank(originalCase.EOF_Causale_Sospensione__c)){
                    	notify.Causale_Sospensione__c=originalCase.EOF_Causale_Sospensione__c;
                    }
                    else{             
                    	originalCase.EOF_Causale_Sospensione__c='Cliente Indisponibile';
                    }
                    originalCase.EOF_Data_Ora_Sospensione__c=notify.EOF_Data_Ora_Notifica_Sospensione__c;
                    originalcase.EOF_Data_Ora_Intervento_congiunto__c=notify.EOF_Data_Ora_Intervento_congiunto__c;
                    originalCase.EOF_Minuti_rimanenti_sospesi__c=Integer.valueOf(originalCase.EOF_Num_min_risoluzione_Ticket__c);
                    //originalCase.EOF_Data_Max_Risoluzione_Ticket__c=null;
                    originalCase.EOF_Intervento_Congiunto__c=notify.EOF_Intervento_Congiunto__c;
                    originalCase.EOF_tec_eof__c=notify.EOF_tec_eof__c;
                    originalCase.EOF_Tel_Tec_EOF__c=Notify.EOF_Tel_Tec_EOF__c;  
                    if(String.isNotBlank(notify.EOF_NOte__c)){
                        if(String.isNotBlank(originalCase.EOF_COmunicazioni_con_OLO__C)){
                            originalCase.EOF_COmunicazioni_con_OLO__C=originalCase.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+notify.Tipo_comunicazione__c.right(notify.Tipo_comunicazione__c.length()-17)+' - '+userInfo.getName()+':\n'+notify.EOF_NOte__c;
                        }
                        else{
                            originalCase.EOF_COmunicazioni_con_OLO__C=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+notify.Tipo_comunicazione__c.right(notify.Tipo_comunicazione__c.length()-17)+' - '+userInfo.getName()+':\n'+notify.EOF_NOte__c;
                        }
                    } 
                    originalcase.status='Sospeso';                
                    Database.DMLOptions dmo = new Database.DMLOptions();
                    dmo.assignmentRuleHeader.useDefaultRule = true;
                    originalcase.setOptions(dmo);                    
                    update originalcase;
                    insert OF_TT_Utils.create_EAI_Log(notify);
                    //check se il case è da portale
					if(originalCase.PO_TT_Portale__c){
						system.debug('ENTRATOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO');
						OF_TT_Utils.updateSlPortale(String.valueOf(notify.Id));
					}
					else{
						OF_TT_Utils.createAckNackNotifyServiceLog(String.valueOf(notify.Id));
					}                   
                } 
                if(notify.Tipo_comunicazione__c.equalsIgnoreCase('Trouble Ticket - Notifica di Desospensione') && notify.EOF_Inviata__c==false){

               		originalcase.status='In Lavorazione';  
                    originalCase.EOF_Fase__c='Da Lavorare'; 
                    if(String.isNotBlank(notify.eof_referente_desospensione__c)){
                    	originalCase.EOF_Referente_Desospensione__c=notify.eof_referente_desospensione__c;
                    }                               
                    else if(String.isNotBlank(originalCase.EOF_Referente_Desospensione__c)){
                    	notify.eof_referente_desospensione__c=originalCase.EOF_Referente_Desospensione__c;
                    }
                    else{             
                    	notify.eof_referente_desospensione__c='Operatore BO';
                    	originalCase.EOF_Referente_Desospensione__c='Operatore BO';
                    }                   
                    originalCase.EOF_Data_ora_Desospensione__c=notify.EOF_Data_Ora_Notifica_Desospensione__c;
                    originalCase.EOF_Causale_Desospensione__c=originalCase.EOF_Causale_sospensione__c;
                    Database.DMLOptions dmo = new Database.DMLOptions();
                    Group analisi = [SELECT Id FROM Group WHERE Name = 'Trouble Ticket - Coda Analisi' AND Type = 'Queue'];
                    originalCase.ownerId=analisi.Id;  
                   if(String.isNotBlank(notify.EOF_NOte__c)){
                        if(String.isNotBlank(originalCase.EOF_COmunicazioni_con_OLO__C)){
                            originalCase.EOF_COmunicazioni_con_OLO__C=originalCase.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+notify.Tipo_comunicazione__c.right(notify.Tipo_comunicazione__c.length()-17)+' - '+userInfo.getName()+':\n'+notify.EOF_NOte__c;
                        }
                        else{
                            originalCase.EOF_COmunicazioni_con_OLO__C=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+notify.Tipo_comunicazione__c.right(notify.Tipo_comunicazione__c.length()-17)+' - '+userInfo.getName()+':\n'+notify.EOF_NOte__c;
                        }
                    }        
                    update originalcase;
                    insert OF_TT_Utils.create_EAI_Log(notify);
                    //check se il case è da portale
					if(originalCase.PO_TT_Portale__c){
						OF_TT_Utils.updateSlPortale(String.valueOf(notify.Id));
					}
					else{
						OF_TT_Utils.createAckNackNotifyServiceLog(String.valueOf(notify.Id));
					}                
                }
                if(notify.Tipo_comunicazione__c.equalsIgnoreCase('Trouble Ticket - Notifica di Annullamento')){
                    originalcase.status='Annullato';
                    originalCase.eof_fase__c='Annullato';
                    if(String.isNotBlank(notify.EOF_NOte__c)){
                        if(String.isNotBlank(originalCase.EOF_COmunicazioni_con_OLO__C)){
                            originalCase.EOF_COmunicazioni_con_OLO__C=originalCase.EOF_COmunicazioni_con_OLO__C+'\n'+OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+notify.Tipo_comunicazione__c.right(notify.Tipo_comunicazione__c.length()-17)+' - '+userInfo.getName()+':\n'+notify.EOF_NOte__c;
                        }
                        else{
                            originalCase.EOF_COmunicazioni_con_OLO__C=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+notify.Tipo_comunicazione__c.right(notify.Tipo_comunicazione__c.length()-17)+' - '+userInfo.getName()+':\n'+notify.EOF_NOte__c;
                        }
                    }   
                    originalCase.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();
                  	update originalCase;
                    insert OF_TT_Utils.create_EAI_Log(notify);
                    //check se il case è da portale
					if(originalCase.PO_TT_Portale__c){
						OF_TT_Utils.updateSlPortale(String.valueOf(notify.Id));
					}
					else{
						OF_TT_Utils.createAckNackNotifyServiceLog(String.valueOf(notify.Id));
					}
                    
                }
                if(notify.Tipo_comunicazione__c.equalsIgnoreCase('Trouble Ticket - Notifica di TimeoutOK')){
                    originalcase.status='Chiuso';
                    originalCase.EOF_Fase__c='Chiusura'; 
                    originalCase.EOF_Data_Ora_Chiusura_Ticket__c=OF_TT_Utils.now();

                    update originalCase;
                    insert OF_TT_Utils.create_EAI_Log(notify);
                    //check se il case è da portale
					if(originalCase.PO_TT_Portale__c){
						OF_TT_Utils.updateSlPortale(String.valueOf(notify.Id));
					}
					else{
						OF_TT_Utils.createAckNackNotifyServiceLog(String.valueOf(notify.Id));
					}
                    
                }              
            }
        }
    }
}
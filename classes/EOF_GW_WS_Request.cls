global class EOF_GW_WS_Request{
    
    global class FiberRequest{
            webservice String TIPO_COMUNICAZIONE;
            webservice String CODICE_OPERATORE;
            webservice String CODICE_ORDINE_OLO;
            webservice String DATA_NOTIFICA;
            webservice String ID_NOTIFICA;
            webservice String IDENTIFICATIVO_DEL_POP;
            webservice String GPON_ATTESTAZIONE;
            webservice String GPON_VINCOLANTE;
            webservice String ID_RISORSA;
            webservice String NOME_CLIENTE;
            webservice String COGNOME_CLIENTE;
            webservice String RECAPITO_TELEFONICO_CLIENTE_1;
            webservice String RECAPITO_TELEFONICO_CLIENTE_2;
            webservice String PROVINCIA;
            webservice String COMUNE;
            webservice String PARTICELLA_TOPONOMASTICA;
            webservice String INDIRIZZO;
            webservice String NUMERO_CIVICO;
            webservice String ID_BUILDING;
            webservice String SCALA_PALAZZINA;
            webservice String NOME_REFERENTE_TECNICO_OLO;
            webservice String COGNOME_REFERENTE_TECNICO_OLO;
            webservice String TELEFONO_REFERENTE_TECNICO_OLO;
            webservice String EMAIL_REFERENTE_TECNICO_OLO;
            webservice String RECAPITO_TEST_LINEA;
            webservice String NUMERO_TELEFONICO_PRINCIPALE_LINEA;
            webservice String PASSWORD_APPARATO;
            webservice String TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH;
            webservice String OPZIONE_SYSTEM_UNICO;
            webservice String DATA_PREVISTA_ATTIVAZIONE;
            webservice String CAUSALE_RICHIESTA_ANNULLAMENTO;
            webservice String CODICE_RICHIESTA_ANNULLAMENTO;
            webservice String APPARATO;
            webservice String TIPOLOGIA_APPARATO;
            webservice String PROGETTO_SPECIALE;
            webservice String COLLEGAMENTO_P2P;
            webservice String NOTE;
            webservice String TIPOLOGIA_SERVIZIO;
            webservice String SLA_PREMIUM_ASSURANCE;
            webservice String ORARIO_APPUNTAMENTO;
    }   
    
    global class TroubleTicket{
            webservice String TIPO_COMUNICAZIONE;
            webservice String CODICE_OPERATORE;
            webservice String CODICE_COMUNICAZIONE_OLO;
            webservice String CATEGORIA_GUASTO;        
            webservice String ID_NOTIFICA;        
            webservice String ID_RISORSA;
            webservice DateTime DATA_ORA_INIZIO_GUASTO;
            webservice DateTime DATA_ORA_RICHIESTA_ANNULLAMENTO;
            webservice DateTime DATA_ORA_DESOSPENSIONE;
            webservice DateTime DATA_ORA_AUTORIPRISTINATO;
            webservice String CAUSALE_RICHIESTA_ANNULLAMENTO;
            webservice String CAUSALE_DESOSPENSIONE;
            webservice String NOME_CLIENTE;
            webservice String COGNOME_CLIENTE;
            webservice String RECAPITO_TELEFONICO_CLIENTE_1;
            webservice String RECAPITO_TELEFONICO_CLIENTE_2;            
            webservice String NOME_REFERENTE_TECNICO_OLO;            
            webservice String TELEFONO_REFERENTE_TECNICO_OLO;
            webservice String EMAIL_REFERENTE_TECNICO_OLO;
            webservice String REFERENTE_DESOSPENSIONE;
            webservice String VERIFICA_APPARATO_CLIENTE;
            webservice String DESCRIZIONE_PROBLEMA;
            webservice String NOTE_CLIENTE;            
            webservice String NOTE;   
            webservice String CAUSALE_APERTURA;
            webservice String INTERVENTO_CONGIUNTO;
            webservice String TEC_OLO;
            webservice String TEL_TEC_OLO;
            webservice String DATA_ORA_INTERVENTO_CONGIUNTO;
    }
    
    global class returnFiberResponse{
        webservice String Esito;
        webservice String CodiceErrore;
        webservice String CausaleErrore;
    }
       
    webservice static returnFiberResponse FiberRequest(FiberRequest fr){
         
		OM_GW_GE_Utils.CreateTemplogOLO(fr);
        OM_GW_GE_Utils.AttrTime = datetime.now().getTime();
		// finisce qui

        
        /**CRM Modifica 30_03_2017**/
        List<OF_Configurazioni__c> listCustomSett =  OF_Configurazioni__c.getAll().values();
        
        boolean checkSystem = listCustomSett[0].EOF_Attiva_Check_POP_OLO__c;
        
     	
        //Generating FiberRequest Service Log
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(fr);
        OM_GW_GE_Utils.checkslOrig=true;
              
        if(String.isBlank(fr.TIPO_COMUNICAZIONE)){
            return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'Tipo Comunicazione');
        }      
        else if (fr.TIPO_COMUNICAZIONE == '1'){
                        
        	if(String.isBlank(fr.CODICE_ORDINE_OLO)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'Codice Ordine OLO');
            }
            if(checkSystem){
	            if(String.isBlank(fr.CODICE_OPERATORE)){
	            	return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'CODICE_OPERATORE');
	            }
	            if(String.isBlank(fr.IDENTIFICATIVO_DEL_POP)){
	            	return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'IDENTIFICATIVO_DEL_POP');
	            }
            	List<String> olos = new List<String>();
	        	List<String> Pops = new List<String>(); 
	        	if(!String.isBlank(listCustomSett[0].EOF_Codice_Operatore_OLO__c)){
		        	olos = listCustomSett[0].EOF_Codice_Operatore_OLO__c.split(';');
		        }
		         if(!String.isBlank(listCustomSett[0].EOF_Pop_OM__c)){
		        	Pops = listCustomSett[0].EOF_Pop_OM__c.split(';');
		        }               	
            	if(!olos.isEMpty() && !Pops.isEMpty()){
            		
            		boolean checkOLO = false;
            		for(integer i = 0; i<olos.size(); i++){
            			if(olos[i]==fr.CODICE_OPERATORE){
            				checkOLO=true;
            			}
            		}
            		boolean checkGPON = false;
            		for(integer i = 0; i<Pops.size(); i++){
        				if(Pops[i]==fr.IDENTIFICATIVO_DEL_POP){
            				checkGPON=true;
            			}
            		}
            		//checkTrueVaiSuOM significa che se true il pop e l'olo definiti nel cruscotto identificano i POP e gli OLO che devono essere inviati su OM 
            		//se false il pop e l'olo definiti nel cruscotto identificano i POP e gli OLO che NON devono essere inviati su OM
            		boolean checkTrueVaiSuOM = listCustomSett[0].OF_checkTrueVaiSuOM__c;
            		if(checkTrueVaiSuOM){
		        		if(checkGPON && checkOLO){
                            //return OM_GW_Utils.checkSync(fr);
                            // 8/06/2018 MM : nuovo richiamo metodo per inserimento Templog                
                            EOF_GW_WS_Request.returnFiberResponse respT = OM_GW_Utils.checkSync(fr);
                            
                            OM_GW_GE_Utils.EndTemplog();
                            
                            return respT;
                            // finisce qui            
		        		}
		        		else{
		            		return EOF_GW_Utils.checkSync(fr);
		            	}
            		}	
            		else{
            			if(checkGPON && checkOLO){
		        			return EOF_GW_Utils.checkSync(fr);
		        		}
		        		else{
                            //return OM_GW_Utils.checkSync(fr);
                            // 8/06/2018 MM : nuovo richiamo metodo per inserimento Templog                
                            EOF_GW_WS_Request.returnFiberResponse respT = OM_GW_Utils.checkSync(fr);
                            
                            OM_GW_GE_Utils.EndTemplog();
                            
                            return respT;
                            // finisce qui            
		            	}
            		}
            	}
            	else{
                    //return OM_GW_Utils.checkSync(fr);
                    // 8/06/2018 MM : nuovo richiamo metodo per inserimento Templog                
                    EOF_GW_WS_Request.returnFiberResponse respT = OM_GW_Utils.checkSync(fr);
                    
                    OM_GW_GE_Utils.EndTemplog();
                    
                    return respT;
                    // finisce qui            
            	}
	            
            }
            else{                
                //return OM_GW_Utils.checkSync(fr);
                // 8/06/2018 MM : nuovo richiamo metodo per inserimento Templog                
                EOF_GW_WS_Request.returnFiberResponse respT = OM_GW_Utils.checkSync(fr);
                
                OM_GW_GE_Utils.EndTemplog();
                
                return respT;
                // finisce qui
        	}
            
        }
        else if (fr.TIPO_COMUNICAZIONE == '11'){
            //return OM_GW_Utils.checkSync(fr);
            // 8/06/2018 MM : nuovo richiamo metodo per inserimento Templog                
            EOF_GW_WS_Request.returnFiberResponse respT = OM_GW_Utils.checkSync(fr);
            
            OM_GW_GE_Utils.EndTemplog();
            
            return respT;
            // finisce qui            
        }
        else if(fr.TIPO_COMUNICAZIONE == '2' || fr.TIPO_COMUNICAZIONE == '3' || fr.TIPO_COMUNICAZIONE == '4'){
            if(String.isBlank(fr.CODICE_ORDINE_OLO)){
                return OM_GW_GE_Utils.syncError(fr, 'A_K5', 'Codice Ordine OLO');
            }
            //check se trovo il case a sistema sfruttando il service log creato
            if(!OM_GW_GE_Utils.checkCaseOriginale){ 
                return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'Codice Ordine OLO');
            }
            if(OM_GW_GE_Utils.caseOriginale.EOF_Order_Manager__c){
                
                //return OM_GW_Utils.checkSync(fr);
                // 8/06/2018 MM : nuovo richiamo metodo per inserimento Templog                
                EOF_GW_WS_Request.returnFiberResponse respT = OM_GW_Utils.checkSync(fr);
                
                OM_GW_GE_Utils.EndTemplog();
                
                return respT;
                // finisce qui            
            }
            else{
                return EOF_GW_Utils.checkSync(fr);
            }
        }
        else{
            return OM_GW_GE_Utils.syncError(fr, 'A_K6', 'Tipo Comunicazione');
        }  
        
    }
}
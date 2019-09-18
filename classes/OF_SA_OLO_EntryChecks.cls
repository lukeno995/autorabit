public class OF_SA_OLO_EntryChecks {  
    public static case c;
     
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksReschedule(OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest r, EOF_EAI_Service_Log__c slPort){
         
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse resp = SyncChecksReschedule(r);
        if(resp.esito=='0'){
            slPort.EOF_Stato_Ordine__c=OF_SA_GE_Utils.caseOriginale.status;  
        }
        else{
        	slPort.EOF_MOtivazione__c=resp.motivazione;
        	if(resp.codice_motivazione=='A04'||resp.codice_motivazione=='200'||resp.codice_motivazione=='100'){
        		slPort.EOF_MOtivazione__c='Servizio Momentaneamente non disponibile';
        	}
            slPort.EOF_Stato_Ordine__c='error';
            slPort.EOF_COdice_MOtivazione__c=resp.codice_motivazione;
            //slPort.EOF_MOtivazione__c=resp.motivazione;
        }
        return slPort;  
    }
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksStatusUpdate(OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur, EOF_EAI_Service_Log__c slPort){
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse resp = SyncChecksStatusUpdate(sur);
        
        if(resp.esito=='0'){
            slPort.EOF_Stato_Ordine__c=OF_SA_GE_Utils.caseOriginale.status;  
        }
        else{
        	slPort.EOF_MOtivazione__c=resp.motivazione;
        	if(resp.codice_motivazione=='A04'||resp.codice_motivazione=='200'||resp.codice_motivazione=='100'){
        		slPort.EOF_MOtivazione__c='Servizio Momentaneamente non disponibile';
        	}
            slPort.EOF_Stato_Ordine__c='error';
            slPort.EOF_COdice_MOtivazione__c=resp.codice_motivazione;
            //slPort.EOF_MOtivazione__c=resp.motivazione;
        }        
        
        return slPort;  
    }
    
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksActivation(OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest act, EOF_EAI_Service_Log__c slPort){
        OF_SA_GE_Utils.PORTAL=true;
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse resp = SyncChecksActivation(act);
        if(resp.esito=='0'){
            slPort.EOF_Stato_Ordine__c=OF_SA_GE_Utils.caseOriginale.status;
            slPort.EOF_Codice_ordine_eof__c=Id.valueOf(OF_SA_GE_Utils.caseOriginale.Id);
            slPort.PO_SA_Data_Inserimento_Ordine__c=system.now();  
        }
        else{
        	slPort.EOF_MOtivazione__c=resp.motivazione;
        	if(resp.codice_motivazione=='A04'||resp.codice_motivazione=='200'||resp.codice_motivazione=='100'){
        		slPort.EOF_MOtivazione__c='Servizio Momentaneamente non disponibile';
        	}
            slPort.EOF_Stato_Ordine__c='error';
            slPort.EOF_COdice_MOtivazione__c=resp.codice_motivazione;
            //slPort.EOF_MOtivazione__c=resp.motivazione;
        }
        return slPort;  
    } 
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksDeactivation(OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deact, EOF_EAI_Service_Log__c slPort){
        OF_SA_GE_Utils.PORTAL=true;
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse resp = SyncChecksDeactivation(Deact);
        if(resp.esito=='0'){
            slPort.EOF_Stato_Ordine__c=OF_SA_GE_Utils.caseOriginale.status;
            slPort.EOF_COdice_MOtivazione__c=OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c;
            slPort.EOF_MOtivazione__c=OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c+' - '+OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c;
            slPort.EOF_Codice_ordine_eof__c=Id.valueOf(OF_SA_GE_Utils.caseOriginale.Id);
            slPort.PO_SA_Data_Inserimento_Ordine__c=system.now();  
        }
        else{
        	slPort.EOF_MOtivazione__c=resp.motivazione;
        	if(resp.codice_motivazione=='A04'||resp.codice_motivazione=='200'||resp.codice_motivazione=='100'){
        		slPort.EOF_MOtivazione__c='Servizio Momentaneamente non disponibile';
        	}
            slPort.EOF_Stato_Ordine__c='error';
            slPort.EOF_COdice_MOtivazione__c=resp.codice_motivazione;
            //slPort.EOF_MOtivazione__c=resp.motivazione;
        }
        return slPort;  
    } 



    public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksStatusUpdate(OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur){
       
       List<EOF_EAI_Service_Log__c> slToInsert = new List<EOF_EAI_Service_Log__c>();

        // 14/02/2018 MM :Aggiorno il timestamp. CG.1 corrisponde a inizio check generali.
		OF_SA_GE_Utils.partialTemplog('CG.1');
        // finisce qui
	    
        if(string.isblank(sur.CODICE_OPERATORE)){
            return OF_SA_GE_Utils.syncError (sur,'A05','CODICE_OPERATORE');
        }
            
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple){
            if(sur.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        }
        if(!olo_found){
             return OF_SA_GE_Utils.syncError (sur,'A06','CODICE_OPERATORE');     
        }
       
        if(string.isblank(sur.CODICE_ORDINE_OLO)){
            return OF_SA_GE_Utils.syncError (sur,'A05','CODICE_ORDINE_OLO');
        }
            
        //controllo se il case è a sistema
        // 9/01/2018 Marco : modifica alla query per inserire il codice operatore tra le condizioni
        List<Case> cList= [select id,status,Codice_Ordine_EOF__c,Previous_Status__c from Case where EOF_Codice_Ordine_OLO__c=:sur.codice_ordine_olo AND EOF_Codice_Operatore_WS__c=:sur.CODICE_OPERATORE and RecordType.DeveloperName = 'OF_SA_Attivazione'];
        // Marco : fine modifica
        //system.debug('OSCRM OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate casoDaDesospendere:'+cList);
        
        
        if(cList.isEmpty()){
            return OF_SA_GE_Utils.syncError (sur,'A06','CODICE_ORDINE_OLO');
        }
        else{
        	OF_SA_GE_Utils.caseOriginale=cList[0];
        	OF_SA_GE_Utils.checkCaseOriginale=true;
        }
        
        if(string.isblank(sur.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (sur,'A05','DATA_NOTIFICA');
        }
        if(!OF_SA_GE_Utils.checkDateTime(sur.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (sur,'A06','DATA_NOTIFICA');
        }
        
        if(string.isblank(sur.ID_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (sur,'A05','ID_NOTIFICA');
        }
        if(sur.ID_NOTIFICA.length()>100){
            return OF_SA_GE_Utils.syncError (sur,'A06','ID_NOTIFICA');
        }
        if(sur.ID_NOTIFICA.contains('�')){
            return OF_SA_GE_Utils.syncError (sur,'B04','ID_NOTIFICA');
        }

        if(string.isblank(sur.AZIONE)){
            return OF_SA_GE_Utils.syncError (sur,'A05','AZIONE');
        }
        if(sur.AZIONE!='0' && sur.AZIONE!='1'){
            return OF_SA_GE_Utils.syncError (sur,'A06','AZIONE');
        }

        // 14/02/2018 MM :Aggiorno il timestamp. CG.2 corrisponde a fine check generali.
		OF_SA_GE_Utils.partialTemplog('CG.2');
	    // finisce qui
	            
        if(sur.AZIONE=='1'){

	        // 14/02/2018 MM :Aggiorno il timestamp. ANN.1 corrisponde a inizio check per Annullamento.
			OF_SA_GE_Utils.partialTemplog('ANN.1');
		    // finisce qui
	            	
	    	if(string.isblank(sur.CODICE_MOTIVAZIONE)){
	            return OF_SA_GE_Utils.syncError (sur,'A05','CODICE MOTIVAZIONE');
	        }
	        if(sur.CODICE_MOTIVAZIONE.length()>3){
	            return OF_SA_GE_Utils.syncError (sur,'A06','CODICE MOTIVAZIONE');
	        }
	        if(sur.CODICE_MOTIVAZIONE.contains('�')){
	            return OF_SA_GE_Utils.syncError (sur,'B04','CODICE MOTIVAZIONE');
	        }
	        if(string.isblank(sur.MOTIVAZIONE)){
	            return OF_SA_GE_Utils.syncError (sur,'A05','MOTIVAZIONE');
	        }
	        if(sur.MOTIVAZIONE.length()>255){
	            return OF_SA_GE_Utils.syncError (sur,'A06','MOTIVAZIONE');
	        }
	        if(sur.MOTIVAZIONE.contains('�')){
	            return OF_SA_GE_Utils.syncError (sur,'B04','MOTIVAZIONE');
	        }
	        if(OF_SA_GE_Utils.caseOriginale.status!='Acquisito' && OF_SA_GE_Utils.caseOriginale.status!='Accettato' && OF_SA_GE_Utils.caseOriginale.status!='Sospeso'){
	            return OF_SA_GE_Utils.syncError (sur,'A07','STATUS: ' + OF_SA_GE_Utils.caseOriginale.status);
	        }
	        
	        // 14/02/2018 : Aggiorno il timestamp. ANN.2 corrisponde alla fine check per Annullamento.
			OF_SA_GE_Utils.partialTemplog('ANN.2');
	    	// finisce qui
	        
        } 
         
        if(sur.AZIONE=='0'){

            // 14/02/2018 MM : Aggiorno il timestamp. D.1 corrisponde a inizio check Desospensione.
			OF_SA_GE_Utils.partialTemplog('D.1');
		    // finisce qui

        	
        	if(OF_SA_GE_Utils.caseOriginale.status != 'Sospeso'){
        		return OF_SA_GE_Utils.syncError (sur,'A07','STATUS: ' + OF_SA_GE_Utils.caseOriginale.status);
        	}
        	if(!string.isblank(sur.CODICE_MOTIVAZIONE)){ 
        		if(sur.CODICE_MOTIVAZIONE.length()>3){
	                return OF_SA_GE_Utils.syncError (sur,'A06','CODICE MOTIVAZIONE');
	            }
        		if(sur.CODICE_MOTIVAZIONE.contains('�')){
        			return OF_SA_GE_Utils.syncError (sur,'B04','CODICE MOTIVAZIONE');
        		}
        	}

	        if(!string.isblank(sur.MOTIVAZIONE)){
	        	if(sur.MOTIVAZIONE.length()>255){
	                return OF_SA_GE_Utils.syncError (sur,'A06','MOTIVAZIONE');
	            }
	            if(sur.MOTIVAZIONE.contains('�')){
		            return OF_SA_GE_Utils.syncError (sur,'B04','MOTIVAZIONE');
		        }
	        
	        }
	        if(!string.isblank(sur.NOME_CLIENTE) && sur.NOME_CLIENTE.length()>20){
                return OF_SA_GE_Utils.syncError (sur,'A06','NOME_CLIENTE');
            }
            if(!string.isblank(sur.COGNOME_CLIENTE) && sur.COGNOME_CLIENTE.length()>70){
                return OF_SA_GE_Utils.syncError (sur,'A06','COGNOME_CLIENTE');
            }
            if(!string.isblank(sur.RECAPITO_TELEFONICO_CLIENTE_1) && sur.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
                return OF_SA_GE_Utils.syncError (sur,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
            }
            if(!string.isblank(sur.RECAPITO_TELEFONICO_CLIENTE_2) && sur.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
                return OF_SA_GE_Utils.syncError (sur,'A06','RECAPITO_TELEFONICO__2');
            }
            if(!string.isblank(sur.DATA_PREVISTA_ATTIVAZIONE)){
            	if(!OF_SA_GE_Utils.checkDate(sur.DATA_PREVISTA_ATTIVAZIONE)){
            		return OF_SA_GE_Utils.syncError (sur,'A06','DATA_PREVISTA_ATTIVAZIONE');
            	}
            	if(!string.isblank(sur.ORARIO_APPUNTAMENTO)){
	            	if(!OF_SA_GE_Utils.checkTime(sur.ORARIO_APPUNTAMENTO)){
	            		return OF_SA_GE_Utils.syncError (sur,'A06','ORARIO_APPUNTAMENTO');
	            	}
	            	
	            } 
	            Datetime targetTime = Datetime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(sur.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
		        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
		        Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);
		        if(!BusinessHours.isWithin(bh.Id, targetTime)){
		        	return OF_SA_GE_Utils.syncError (sur,'A10',null);
		        }
		        //controllo SLA
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
		        	return OF_SA_GE_Utils.syncError (sur,'A09',null);
		        }
            }
            
            // 14/02/2018 MM : Aggiorno il timestamp. D.2 corrisponde a fine check Desospensione.
			OF_SA_GE_Utils.partialTemplog('D.2');
		    // finisce qui
            
        } 

        // 14/02/2018 MM : Aggiorno il timestamp. SU.1 corrisponde a inizio check Status Update.
		OF_SA_GE_Utils.partialTemplog('SU.1');
	    // finisce qui

        if(!string.isblank(sur.NOTE)){
        	if(sur.NOTE.length()>255){
        		return OF_SA_GE_Utils.syncError (sur,'A06','NOTE');
        	}
        	if(sur.NOTE.contains('�')){
        		return OF_SA_GE_Utils.syncError (sur,'B04','NOTE');
        	}
        } 
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        
        //aggiungo codice_ordine_of per creare il service log
        sur.codice_ordine_of=OF_SA_GE_Utils.caseOriginale.Codice_Ordine_EOF__c;
        //system.debug('OSCRM sur:'+sur);
        Map<String,List<EOF_EAI_Service_Log__c>> responseFromOM = OF_SA_OLO_AsyncChecks.OLO_AsyncStatusUpdate(OF_SA_GE_Utils.caseOriginale, sur);
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();       
        if(responseFromOM.containsKey('0')) {
        
            //Aggiungo i 4 ACK e ritolgo il codice_ordine_of
            sur.codice_ordine_of='';
            
            slList.addAll(responseFromOM.get('0'));
            
            
            slList.add(OF_SA_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
                                             'Codice_operatore' => sur.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => sur.CODICE_ORDINE_OLO,
                                             'Flusso' => 'SF-OLO',
                                             'Metodo' => 'OLO_StatusUpdate',
                                             'ID_notifica' => sur.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'OLO->SF - ACK - StatusUpdate'}));
            
            Insert slList;
			
			//aggiungta la logica per ciclare sui sl inseriti e aggiornare l'ACK e il sl di riferimento (dopo inserimento in quanto servono gli ID salesforce)
	        List<EOF_EAI_Service_Log__c> slListToUpdate = new List<EOF_EAI_Service_Log__c>();
	        EOF_EAI_Service_Log__c OLO_SF;
	        EOF_EAI_Service_Log__c SF_OM;
	        EOF_EAI_Service_Log__c OLO_SF_ACK;
	        EOF_EAI_Service_Log__c SF_OM_ACK;
	        
	        for(EOF_EAI_Service_Log__c sl : slList){
	        	if(sl.eof_TIPO_Comunicazione_String__C=='OLO->SF - StatusUpdateRequest'){
	        		OLO_SF=sl;
	        		OLO_SF.EOF_Response__c='ACK';
	        		slListToUpdate.add(OLO_SF);
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='SF->OM - StatusUpdateRequest'){
	        		SF_OM=sl;
	        		SF_OM.EOF_Response__c='ACK';
	        		slListToUpdate.add(SF_OM);
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='OLO->SF - ACK - StatusUpdate'){
	        		OLO_SF_ACK=sl;	
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='SF->OM - ACK - StatusUpdate'){
	        		SF_OM_ACK=sl;	
	        	}
	        }
	        OLO_SF_ACK.EOF_SL_Riferimento__c=OLO_SF.Id; 
	        SF_OM_ACK.EOF_SL_Riferimento__c=SF_OM.Id;
	        slListToUpdate.add(OLO_SF_ACK);
	        slListToUpdate.add(SF_OM_ACK);
	        update slListToUpdate;
            
            responseToOlo.esito='0';
            //aggiorno il Case
            if(sur.azione=='0'){
                
                // 30/01/2018 Marco : modifica 
                if(string.isNotBlank(OF_SA_GE_Utils.caseOriginale.Previous_Status__c)){
                    
					OF_SA_GE_Utils.caseOriginale.Status = OF_SA_GE_Utils.caseOriginale.Previous_Status__c;
                    OF_SA_GE_Utils.caseOriginale.Previous_Status__c='';
                    
                }else{                
                    CaseHistory ch = [select oldValue from CaseHistory where CaseId=:OF_SA_GE_Utils.caseOriginale.Id and Field='Status' order by createdDate desc limit 1];                
                    OF_SA_GE_Utils.caseOriginale.Status= String.valueof(ch.oldValue);                                        
                }
                system.debug('30/01/2018 Marco : il previous status nella olo entrychecks è:'+ OF_SA_GE_Utils.caseOriginale.Previous_Status__c);
                
                // 30/01/2018 Marco : fine modifica
                
                // 8/01/2018 Marco : Modifica salvataggio dati per desospensione da OLO
                if(!string.isblank(sur.DATA_PREVISTA_ATTIVAZIONE)){
                    OF_SA_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c= OF_SA_GE_Utils.stringToDateNoTime(sur.DATA_PREVISTA_ATTIVAZIONE);
                }
                if(!string.isblank(sur.ORARIO_APPUNTAMENTO)){
                    OF_SA_GE_Utils.caseOriginale.EOF_Orario_Appuntamento__c= sur.ORARIO_APPUNTAMENTO;
                }
                // 8/01/2018 Marco : fine modifica salvataggio dati per desospensione da OLO
            }
            else{
                OF_SA_GE_Utils.caseOriginale.Status='In Annullamento';
            }
            update OF_SA_GE_Utils.caseOriginale;
            OF_SA_OLO_EntryChecks.c=OF_SA_GE_Utils.caseOriginale;
		    		    
        }
        else{
        
            slList.addAll(responseFromOM.get('1'));
            responseToOlo.esito='1';
            for(EOF_EAI_Service_Log__c sl: responseFromOM.get('1')){
                if(String.isNotBlank(sl.eof_TIPO_Comunicazione_String__C) && sl.eof_TIPO_Comunicazione_String__C.contains('NACK')){
                    responseToOlo.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
                    responseToOlo.motivazione=sl.EOF_MOTIVAZIONE__C;
                    responseToOlo.id_notifica=sl.EOF_Id_Notifica__c;
                }
            }
            slList.add(OF_SA_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
                                                     'Codice_errore' => responseToOlo.codice_motivazione,
                                                     'Causale_errore' => responseToOlo.motivazione,
                                                     'Flusso' => 'SF-OLO',
                                                    'Metodo' => 'OLO_StatusUpdate',
                                                     'Codice_operatore' => sur.CODICE_OPERATORE,
                                                     'Codice_ordine_OLO' => sur.CODICE_ORDINE_OLO,
                                                     'ID_notifica' => sur.ID_NOTIFICA,
                                                     'Tipo Comunicazione' => 'OLO->SF - NACK - StatusUpdate'}));
          
           Insert slList;
           //aggiungta la logica per ciclare sui sl inseriti e aggiornare l'ACK e il sl di riferimento
	        List<EOF_EAI_Service_Log__c> slListToUpdate = new List<EOF_EAI_Service_Log__c>();
	        EOF_EAI_Service_Log__c OLO_SF;
	        EOF_EAI_Service_Log__c SF_OM;
	        EOF_EAI_Service_Log__c OLO_SF_NACK;
	        EOF_EAI_Service_Log__c SF_OM_NACK;
	        
	        for(EOF_EAI_Service_Log__c sl : slList){
	        	if(sl.eof_TIPO_Comunicazione_String__C=='OLO->SF - StatusUpdateRequest'){
	        		OLO_SF=sl;
	        		OLO_SF.EOF_Response__c='NACK';
	        		slListToUpdate.add(OLO_SF);
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='SF->OM - StatusUpdateRequest'){
	        		SF_OM=sl;
	        		SF_OM.EOF_Response__c='NACK';
	        		slListToUpdate.add(SF_OM);
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='OLO->SF - NACK - StatusUpdate'){
	        		OLO_SF_NACK=sl;	
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='SF->OM - NACK - StatusUpdate'){
	        		SF_OM_NACK=sl;	
	        	}
	        }
	        system.debug('Alessandro lista: '+slList);
	        OLO_SF_NACK.EOF_SL_Riferimento__c=OLO_SF.Id;
	        SF_OM_NACK.EOF_SL_Riferimento__c=SF_OM.Id;
	        slListToUpdate.add(OLO_SF_NACK); 
	        slListToUpdate.add(SF_OM_NACK);
	        update slListToUpdate;
        }

        // 14/02/2018 MM : Aggiorno il timestamp. SU.2 corrisponde alla fine check Status Update.
		OF_SA_GE_Utils.partialTemplog('SU.2');
        // finisce qui

		OF_SA_GE_Utils.EndTemplog();
        
        return  responseToOlo;    
          
    } 
    
    public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksReschedule(OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest r){


        // 14/02/2018 MM : Aggiorno il timestamp. R.1 corrisponde a inizio check generali per RDAC
		OF_SA_GE_Utils.partialTemplog('R.1');
	    // finisce qui

        if(string.isblank(r.CODICE_OPERATORE))
        {
            return OF_SA_GE_Utils.syncError (r,'A05','CODICE_OPERATORE');
        }
        
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple)
            if(r.CODICE_OPERATORE == s.getLabel())
                olo_found = true;
                
        if(!olo_found)
                 return OF_SA_GE_Utils.syncError (r,'A06','CODICE_OPERATORE');
        
        
        if(string.isblank(r.CODICE_ORDINE_OLO)){
        	return OF_SA_GE_Utils.syncError (r,'A05','CODICE_ORDINE_OLO');
        } 
        //controllo se il case è a sistema
        // 9/01/2018 Marco : modifica alla query per inserire il codice operatore tra le condizioni
		List<Case> cList= [select id,status,Codice_Ordine_EOF__c,OF_SA_Id_Servizio__C from Case where EOF_Codice_Ordine_OLO__c=:r.codice_ordine_olo AND EOF_Codice_Operatore_WS__c=:r.CODICE_OPERATORE and RecordType.DeveloperName = 'OF_SA_Attivazione'];
        // Marco : fine modifica
                
        if(cList.isEmpty()){
            return OF_SA_GE_Utils.syncError (r,'A06','CODICE_ORDINE_OLO');
        }
        else{
        	OF_SA_GE_Utils.caseOriginale=cList[0];
        	OF_SA_GE_Utils.checkCaseOriginale=true;
        }
        
        if(OF_SA_GE_Utils.caseOriginale.status != 'Acquisito' && OF_SA_GE_Utils.caseOriginale.status != 'Accettato' && OF_SA_GE_Utils.caseOriginale.status != 'Sospeso'){
            return OF_SA_GE_Utils.syncError (r,'A07','STATUS: ' + OF_SA_GE_Utils.caseOriginale.status);
        }
        
        if(string.isblank(r.DATA_NOTIFICA)){
        	return OF_SA_GE_Utils.syncError (r,'A05','DATA_NOTIFICA');
        }
        if(!OF_SA_GE_Utils.checkDateTime(r.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (r,'A06','DATA_NOTIFICA');
        }

        if(string.isblank(r.ID_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (r,'A05','ID_NOTIFICA');
        }
        else if(r.ID_NOTIFICA.length()>100){
            return OF_SA_GE_Utils.syncError (r,'A06','ID_NOTIFICA');
        }
        else if(r.ID_NOTIFICA.contains('�')){
            return OF_SA_GE_Utils.syncError (r,'B04','ID_NOTIFICA');
        }
     
        if(!string.isblank(r.NOME_CLIENTE)){
        	if(r.NOME_CLIENTE.length()>20){
        		return OF_SA_GE_Utils.syncError (r,'A06','NOME_CLIENTE');
        	}
        	if(r.NOME_CLIENTE.contains('�')){
        		return OF_SA_GE_Utils.syncError (r,'B04','NOME_CLIENTE');
        	}
        } //Marco : Modifiche ai controlli
        if(!string.isblank(r.COGNOME_CLIENTE)){
        	if(r.COGNOME_CLIENTE.length()>70){
        		return OF_SA_GE_Utils.syncError (r,'A06','COGNOME_CLIENTE');
        	}
        	if(r.COGNOME_CLIENTE.contains('�')){
        		return OF_SA_GE_Utils.syncError (r,'B04','COGNOME_CLIENTE');
        	}// Marco : fine modifiche ai controlli 
        } 
        if(!string.isblank(r.RECAPITO_TELEFONICO_CLIENTE_1)){
        	if(r.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
        		return OF_SA_GE_Utils.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
        	}
        	if(r.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
        		return OF_SA_GE_Utils.syncError (r,'B04','RECAPITO_TELEFONICO_CLIENTE_1');
        	}
        } 
        if(!string.isblank(r.RECAPITO_TELEFONICO_CLIENTE_2)){
        	if(r.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
        		return OF_SA_GE_Utils.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
        	}
        	if(r.RECAPITO_TELEFONICO_CLIENTE_2.contains('�')){
        		return OF_SA_GE_Utils.syncError (r,'B04','RECAPITO_TELEFONICO_CLIENTE_2');
        	}
        } 
        if(string.isblank(r.DATA_PREVISTA_ATTIVAZIONE)){
        	return OF_SA_GE_Utils.syncError (r,'A05','DATA_PREVISTA_ATTIVAZIONE');
        } 
        if(!OF_SA_GE_Utils.checkDate(r.DATA_PREVISTA_ATTIVAZIONE)){
    		return OF_SA_GE_Utils.syncError (r,'A06','DATA_PREVISTA_ATTIVAZIONE');
        }
        if(!string.isblank(r.ORARIO_APPUNTAMENTO)){
        	if(!OF_SA_GE_Utils.checkTime(r.ORARIO_APPUNTAMENTO)){
        		return OF_SA_GE_Utils.syncError (r,'A06','ORARIO_APPUNTAMENTO');
        	}
        	
        } 

        if(string.isblank(r.CODICE_MOTIVAZIONE)){
            return OF_SA_GE_Utils.syncError (r,'A05','CODICE_MOTIVAZIONE');
        }
        else if(r.CODICE_MOTIVAZIONE.length()>3){
            return OF_SA_GE_Utils.syncError (r,'A06','CODICE_MOTIVAZIONE');
        }
        else if(r.CODICE_MOTIVAZIONE.contains('�')){
            return OF_SA_GE_Utils.syncError (r,'B04','CODICE_MOTIVAZIONE');
        }

        if(string.isblank(r.MOTIVAZIONE)){
            return OF_SA_GE_Utils.syncError (r,'A05','MOTIVAZIONE');
        }
        else if(r.MOTIVAZIONE.length()>255){
            return OF_SA_GE_Utils.syncError (r,'A06','MOTIVAZIONE');
        }
        else if(r.MOTIVAZIONE.contains('�')){
            return OF_SA_GE_Utils.syncError (r,'B04','MOTIVAZIONE');
        }

        if(!string.isblank(r.NOTE)){
        	if(r.NOTE.length()>255){
        		return OF_SA_GE_Utils.syncError (r,'A06','NOTE');
        	}
        	if(r.NOTE.contains('�')){
        		return OF_SA_GE_Utils.syncError (r,'B04','NOTE');
        	}
        }
        Datetime targetTime = Datetime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
        Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);
        if(!BusinessHours.isWithin(bh.Id, targetTime)){
        	return OF_SA_GE_Utils.syncError (r,'A10',null);
        }
        //controllo SLA
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
        	return OF_SA_GE_Utils.syncError (r,'A09',null);
        }
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        
        r.codice_ordine_of=OF_SA_GE_Utils.caseOriginale.Codice_Ordine_EOF__c;
        Map<String,List<EOF_EAI_Service_Log__c>> responseFromOM = OF_SA_OLO_AsyncChecks.OLO_AsyncReschedule(OF_SA_GE_Utils.caseOriginale, r);
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
        
        if(responseFromOM.containsKey('0')) {
            //Aggiungo i 4 ACK e ritolgo il codice_ordine_of
            r.codice_ordine_of='';
            
            slList.addAll(responseFromOM.get('0'));
            slList.add(OF_SA_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
                                             'Codice_operatore' => r.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => r.CODICE_ORDINE_OLO,
                                             'Flusso' => 'SF-OLO',
                                             'Metodo' => 'OLO_Reschedule',
                                             'ID_notifica' => r.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'SF->OLO - ACK - Reschedule'}));
            Insert slList;
            
            //aggiungta la logica per ciclare sui sl inseriti e aggiornare l'ACK e il sl di riferimento
	        List<EOF_EAI_Service_Log__c> slListToUpdate = new List<EOF_EAI_Service_Log__c>();
	        EOF_EAI_Service_Log__c OLO_SF;
	        EOF_EAI_Service_Log__c SF_OM;
	        EOF_EAI_Service_Log__c OLO_SF_ACK;
	        EOF_EAI_Service_Log__c SF_OM_ACK;
	        
	        for(EOF_EAI_Service_Log__c sl : slList){
	        	if(sl.eof_TIPO_Comunicazione_String__C=='OLO->SF - RescheduleRequest'){
	        		OLO_SF=sl;
	        		OLO_SF.EOF_Response__c='ACK';
	        		slListToUpdate.add(OLO_SF);
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='SF->OM - RescheduleRequest'){
	        		SF_OM=sl;
	        		SF_OM.EOF_Response__c='ACK';
	        		slListToUpdate.add(SF_OM);
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='SF->OLO - ACK - Reschedule'){
	        		OLO_SF_ACK=sl;	
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='SF->OM - ACK - Reschedule'){
	        		SF_OM_ACK=sl;	
	        	}
	        }
	        OLO_SF_ACK.EOF_SL_Riferimento__c=OLO_SF.Id;
	        SF_OM_ACK.EOF_SL_Riferimento__c=SF_OM.Id;
	        slListToUpdate.add(OLO_SF_ACK);
	        slListToUpdate.add(SF_OM_ACK);
	        update slListToUpdate;
	        
            
            responseToOlo.esito='0';
            
            //scrivo sul case la data di rischedule e la motivazione
            if (!string.isBlank(r.ORARIO_APPUNTAMENTO)){
                    Time t = Time.newInstance(Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(3,5)),
                            Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
                OF_SA_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), t );
            }else{


                OF_SA_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
            }

            OF_SA_GE_Utils.caseOriginale.EOF_Orario_Appuntamento__c=r.ORARIO_APPUNTAMENTO;
            OF_SA_GE_Utils.caseOriginale.EOF_Pertinenza_RDAC__c = 'OLO';
            OF_SA_GE_Utils.caseOriginale.OF_SA_Codice_Motivazione__c=r.CODICE_MOTIVAZIONE;
            OF_SA_GE_Utils.caseOriginale.OF_SA_Motivazione__c=r.MOTIVAZIONE;
            update OF_SA_GE_Utils.caseOriginale;
            OF_SA_OLO_EntryChecks.c=OF_SA_GE_Utils.caseOriginale;
            
            
        }
        else{
            slList.add(OF_SA_GE_Utils.Create_Eai_Log(r));
            slList.addAll(responseFromOM.get('1'));
            responseToOlo.esito='1';
            for(EOF_EAI_Service_Log__c sl: responseFromOM.get('1')){

                if(!String.isBlank(sl.eof_TIPO_Comunicazione_String__C) && sl.eof_TIPO_Comunicazione_String__C.contains('NACK')){
                    responseToOlo.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
                    responseToOlo.motivazione=sl.EOF_MOTIVAZIONE__C;
                    responseToOlo.id_notifica=sl.EOF_Id_Notifica__c;
                }
            }
            slList.add(OF_SA_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
                                                     'Codice_errore' => responseToOlo.codice_motivazione,
                                                     'Causale_errore' => responseToOlo.motivazione,
                                                     'Codice_operatore' => r.CODICE_OPERATORE,
                                                     'Flusso' => 'SF-OLO',
                                                        'Metodo' => 'OLO_Reschedule',
                                                     'Codice_ordine_OLO' => r.CODICE_ORDINE_OLO,
                                                     'ID_notifica' => r.ID_NOTIFICA,
                                                     'Tipo Comunicazione' => 'SF->OLO - NACK - Reschedule'}));
            Insert slList;
            
            //aggiungta la logica per ciclare sui sl inseriti e aggiornare l'ACK e il sl di riferimento
	        List<EOF_EAI_Service_Log__c> slListToUpdate = new List<EOF_EAI_Service_Log__c>();
	        EOF_EAI_Service_Log__c OLO_SF;
	        EOF_EAI_Service_Log__c SF_OM;
	        EOF_EAI_Service_Log__c OLO_SF_NACK;
	        EOF_EAI_Service_Log__c SF_OM_NACK;
	        
	        for(EOF_EAI_Service_Log__c sl : slList){
	        	if(sl.eof_TIPO_Comunicazione_String__C=='OLO->SF - RescheduleRequest'){
	        		OLO_SF=sl;
	        		OLO_SF.EOF_Response__c='NACK';
	        		slListToUpdate.add(OLO_SF);
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='SF->OM - RescheduleRequest'){
	        		SF_OM=sl;
	        		SF_OM.EOF_Response__c='NACK';
	        		slListToUpdate.add(SF_OM);
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='SF->OLO - NACK - Reschedule'){
	        		OLO_SF_NACK=sl;	
	        	}
	        	if(sl.eof_TIPO_Comunicazione_String__C=='SF->OM - NACK - Reschedule'){
	        		SF_OM_NACK=sl;	
	        	}
	        }
	        OLO_SF_NACK.EOF_SL_Riferimento__c=OLO_SF.Id;
	        SF_OM_NACK.EOF_SL_Riferimento__c=SF_OM.Id;
	        slListToUpdate.add(OLO_SF_NACK);
	        slListToUpdate.add(SF_OM_NACK);
	        update slListToUpdate;
 
        }
        
        //12/06/2018 MM : Aggiorno il timestamp. R.2 corrisponde alla fine check reschedule.
		OF_SA_GE_Utils.partialTemplog('R.2');
        // finisce qui
        
        OF_SA_GE_Utils.EndTemplog();        
        return  responseToOlo;
    } 
    
    public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksActivation(OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest act){
         
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse resp = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
        
        //creo e inserisco il log dell'attivazione da OLO (OLO->SF - ActivationRequest)
        OF_SA_GE_Utils.slOLOSF = OF_SA_GE_Utils.create_EAI_Log(act);
        
        resp.ID_NOTIFICA=String.valueOf(Datetime.now().gettime());
        resp.ESITO='0';
                
        OF_SA_GE_Utils.OPName='Attivazione';
                
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.1 corrisponde a inizio check acquisizione.
		OF_SA_GE_Utils.partialTemplog('ACQ.1');
        // finisce qui
        
        if(string.isblank(act.CODICE_OPERATORE)){
            return OF_SA_GE_Utils.syncError (act,'A05','CODICE_OPERATORE');
        }   

        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple){
        	if(act.CODICE_OPERATORE == s.getLabel()){
        		olo_found = true;
        	}    
        }
                    
        if(!olo_found){
        	return OF_SA_GE_Utils.syncError (act,'A06','CODICE_OPERATORE');
        }
                 
        if(string.isblank(act.CODICE_ORDINE_OLO)){
        	return OF_SA_GE_Utils.syncError (act,'A05','CODICE_ORDINE_OLO');
        }
        if(act.CODICE_ORDINE_OLO.length()>18){
            return OF_SA_GE_Utils.syncError (act,'A06','CODICE_ORDINE_OLO');
        }
        if(act.CODICE_ORDINE_OLO.contains('�')){
            return OF_SA_GE_Utils.syncError (act,'B04','CODICE_ORDINE_OLO');
        }

        if(OF_SA_GE_Utils.checkCaseOriginale){
            return OF_SA_GE_Utils.syncError (act,'A08','CODICE_ORDINE_OLO');
        }
        if(string.isblank(act.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (act,'A05','DATA_NOTIFICA');
        }
        if(!OF_SA_GE_Utils.checkDateTime(act.DATA_NOTIFICA)){
        	return OF_SA_GE_Utils.syncError (act,'A06','DATA_NOTIFICA');
        }
        if(string.isblank(act.ID_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (act,'A05','ID_NOTIFICA');
        }
        else if(act.ID_NOTIFICA.length()>100){
            return OF_SA_GE_Utils.syncError (act,'A06','ID_NOTIFICA');
        }
        else if(act.ID_NOTIFICA.contains('�')){
            return OF_SA_GE_Utils.syncError (act,'B04','ID_NOTIFICA');
        }
        resp.ID_NOTIFICA=act.ID_NOTIFICA;
        if(string.isblank(act.NOME_REFERENTE_TECNICO_OLO)){
            return OF_SA_GE_Utils.syncError (act,'A05','NOME_REFERENTE_TECNICO_OLO');
        }
        else if(act.NOME_REFERENTE_TECNICO_OLO.length()>50){
            return OF_SA_GE_Utils.syncError (act,'A06','NOME_REFERENTE_TECNICO_OLO');
        }
        else if(act.NOME_REFERENTE_TECNICO_OLO.contains('�')){
            return OF_SA_GE_Utils.syncError (act,'B04','NOME_REFERENTE_TECNICO_OLO');
        }
        if(string.isblank(act.COGNOME_REFERENTE_TECNICO_OLO)){
            return OF_SA_GE_Utils.syncError (act,'A05','COGNOME_REFERENTE_TECNICO_OLO');
        }
        else if(act.COGNOME_REFERENTE_TECNICO_OLO.length()>50){
            return OF_SA_GE_Utils.syncError (act,'A06','COGNOME_REFERENTE_TECNICO_OLO');
        }
        else if(act.COGNOME_REFERENTE_TECNICO_OLO.contains('�')){
            return OF_SA_GE_Utils.syncError (act,'B04','COGNOME_REFERENTE_TECNICO_OLO');
        }

        if(string.isblank(act.TELEFONO_REFERENTE_TECNICO_OLO)){
            return OF_SA_GE_Utils.syncError (act,'A05','TELEFONO_REFERENTE_TECNICO_OLO');
        }
        else if(act.TELEFONO_REFERENTE_TECNICO_OLO.length()>20){
            return OF_SA_GE_Utils.syncError (act,'A06','TELEFONO_REFERENTE_TECNICO_OLO');
        }
        else if(act.TELEFONO_REFERENTE_TECNICO_OLO.contains('�')){
            return OF_SA_GE_Utils.syncError (act,'B04','TELEFONO_REFERENTE_TECNICO_OLO');
        }
        if(string.isblank(act.EMAIL_REFERENTE_TECNICO_OLO)){
            return OF_SA_GE_Utils.syncError (act,'A05','EMAIL_REFERENTE_TECNICO_OLO');
        }
        if(!OF_SA_GE_Utils.checkEmail(act.EMAIL_REFERENTE_TECNICO_OLO)){
        	return OF_SA_GE_Utils.syncError (act,'A06','EMAIL_REFERENTE_TECNICO_OLO');
        }
        if(string.isblank(act.COGNOME_CLIENTE)){
            return OF_SA_GE_Utils.syncError (act,'A05','COGNOME_CLIENTE');
        }
        if(act.COGNOME_CLIENTE.length()>70){
            return OF_SA_GE_Utils.syncError (act,'A06','COGNOME_CLIENTE');
        }
        if(act.COGNOME_CLIENTE.contains('�')){
            return OF_SA_GE_Utils.syncError (act,'B04','COGNOME_CLIENTE');
        }
        if(string.isblank(act.RECAPITO_TELEFONICO_CLIENTE_1)){
            return OF_SA_GE_Utils.syncError (act,'A05','RECAPITO_TELEFONICO_CLIENTE_1');
        }
        else if(act.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
            return OF_SA_GE_Utils.syncError (act,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
        }
        else if(act.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
            return OF_SA_GE_Utils.syncError (act,'B04','RECAPITO_TELEFONICO_CLIENTE_1');
        }
        if(string.isblank(act.DATA_PREVISTA_ATTIVAZIONE)){
            return OF_SA_GE_Utils.syncError (act,'A05','DATA_PREVISTA_ATTIVAZIONE');
        }
        if(!OF_SA_GE_Utils.checkDate(act.DATA_PREVISTA_ATTIVAZIONE)){
        	return OF_SA_GE_Utils.syncError (act,'A06','DATA_PREVISTA_ATTIVAZIONE');
        }
        if(string.isblank(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA)){
            return OF_SA_GE_Utils.syncError (act,'A05','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
        }
        else if(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA.length()>20){
            return OF_SA_GE_Utils.syncError (act,'A06','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
        }
        else if(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA.contains('�')){
            return OF_SA_GE_Utils.syncError (act,'B04','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
        }
        if(string.isblank(act.IDENTIFICATIVO_DEL_POP)){
            return OF_SA_GE_Utils.syncError (act,'A05','IDENTIFICATIVO_DEL_POP');
        }
        else if(act.IDENTIFICATIVO_DEL_POP.length()>10){
            return OF_SA_GE_Utils.syncError (act,'A06','IDENTIFICATIVO_DEL_POP');
        }
        else if(act.IDENTIFICATIVO_DEL_POP.contains('�')){
            return OF_SA_GE_Utils.syncError (act,'B04','IDENTIFICATIVO_DEL_POP');
        }
        if(string.isblank(act.ID_BUILDING)){
    		return OF_SA_GE_Utils.syncError (act,'A05','ID BUILDING');
    	}
    	if(act.ID_BUILDING.length() > 150){
    		return OF_SA_GE_Utils.syncError (act,'A06','ID BUILDING');
    	}
    	if(act.ID_BUILDING.contains('�')){
    		return OF_SA_GE_Utils.syncError (act,'B04','ID BUILDING');
    	}
    	if(string.isblank(act.PROFILO)){
            return OF_SA_GE_Utils.syncError (act,'A05','PROFILO');
        }
        else if(act.PROFILO.length()>20){
            return OF_SA_GE_Utils.syncError (act,'A06','PROFILO');
        }
        else if(act.PROFILO.contains('�')){
            return OF_SA_GE_Utils.syncError (act,'B04','PROFILO');
        }
        //check  sugli opzionali
        if(!string.isblank(act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH)){
        	if(act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH.length()>20){
        		return OF_SA_GE_Utils.syncError (act,'A06','TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH');
        	}
        	if(act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH.contains('�')){
	            return OF_SA_GE_Utils.syncError (act,'B04','TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH');
	        }
        } 
        if(!string.isblank(act.NOME_CLIENTE)){
        	if(act.NOME_CLIENTE.length()>20){
	            return OF_SA_GE_Utils.syncError (act,'A06','NOME_CLIENTE');
	        }
	        
	        if(act.NOME_CLIENTE.contains('�')){
	            return OF_SA_GE_Utils.syncError (act,'B04','NOME_CLIENTE');
	        } 
        }
        if(!string.isblank(act.RECAPITO_TELEFONICO_CLIENTE_2)){
        	if(act.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
	            return OF_SA_GE_Utils.syncError (act,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
	        }
	        if(act.RECAPITO_TELEFONICO_CLIENTE_2.contains('�')){
	            return OF_SA_GE_Utils.syncError (act,'B04','RECAPITO_TELEFONICO_CLIENTE_2');
	        }
        }

        if(!string.isblank(act.ORARIO_APPUNTAMENTO) && !OF_SA_GE_Utils.checkTime(act.ORARIO_APPUNTAMENTO)){
            return OF_SA_GE_Utils.syncError (act,'A06','ORARIO_APPUNTAMENTO');
        }
        if(!string.isblank(act.CODICE_PROGETTO_SPECIALE)){
        	if(act.CODICE_PROGETTO_SPECIALE.length()>50){
	            return OF_SA_GE_Utils.syncError (act,'A06','CODICE_PROGETTO_SPECIALE');
	        }
	        
	        if(act.CODICE_PROGETTO_SPECIALE.contains('�')){
	            return OF_SA_GE_Utils.syncError (act,'B04','CODICE_PROGETTO_SPECIALE');
	        }
        }
		if(!string.isblank(act.PROMOZIONE)){
			if(act.PROMOZIONE.length()>50){
	            return OF_SA_GE_Utils.syncError (act,'A06','PROMOZIONE');
	        }
	        if(act.PROMOZIONE.contains('�')){
	            return OF_SA_GE_Utils.syncError (act,'B04','PROMOZIONE');
	        }
		}
        if(!string.isblank(act.CLUSTER_PROMOZIONE)){
        	if(act.CLUSTER_PROMOZIONE.length()>50){
	            return OF_SA_GE_Utils.syncError (act,'A06','CLUSTER_PROMOZIONE');
	        }
	        
	        if(act.CLUSTER_PROMOZIONE.contains('�')){
	            return OF_SA_GE_Utils.syncError (act,'B04','CLUSTER_PROMOZIONE');
	        }
        }
        if(!string.isblank(act.NOTE)){
        	if(act.NOTE.length()>255){
	            return OF_SA_GE_Utils.syncError (act,'A06','NOTE');
	        }
	        
	        if(act.NOTE.contains('�')){
	            return OF_SA_GE_Utils.syncError (act,'B04','NOTE');
	        }
        }
        if(!string.isblank(act.SCALA_PALAZZINA)){
        	if(act.SCALA_PALAZZINA.length()>21){
	            return OF_SA_GE_Utils.syncError (act,'A06','SCALA_PALAZZINA');
	        }
	        
	        if(act.SCALA_PALAZZINA.contains('�')){
	            return OF_SA_GE_Utils.syncError (act,'B04','SCALA_PALAZZINA');
	        }
        }
		if(!string.isblank(act.RECAPITO_TEST_LINEA)){
			if(act.RECAPITO_TEST_LINEA.length()>20){ 
	            return OF_SA_GE_Utils.syncError (act,'A06','RECAPITO_TEST_LINEA');
	        }
	        
	        if(act.RECAPITO_TEST_LINEA.contains('�')){
	            return OF_SA_GE_Utils.syncError (act,'B04','RECAPITO_TEST_LINEA');
	        }
		}
		if(act.VLAN==null || act.VLAN.isempty()){
			return OF_SA_GE_Utils.syncError (act,'A05','VLAN');
		}
		else{
            for(OF_SA_WS_IN_OLO_Activation.VLAN vln : act.VLAN){
                    
                if(string.isblank(vln.KIT_CONSEGNA_VLAN)){
                    return OF_SA_GE_Utils.syncError (act, 'A05','KIT_CONSEGNA_VLAN');
                }
                if(vln.KIT_CONSEGNA_VLAN.length()>10){
                    return OF_SA_GE_Utils.syncError (act, 'A06','KIT_CONSEGNA_VLAN');
                }
                if(!string.isblank(vln.KIT_CONSEGNA_VLAN) && vln.KIT_CONSEGNA_VLAN.contains('�')){
                    return OF_SA_GE_Utils.syncError (act, 'B04','KIT_CONSEGNA_VLAN');
                }
                if(string.isblank(vln.USER_VLAN)){
                    return OF_SA_GE_Utils.syncError (act, 'A05','USER_VLAN');
                }
                if(vln.USER_VLAN.length()>4){
                    return OF_SA_GE_Utils.syncError (act, 'A06','USER_VLAN');
                }
                if(!string.isblank(vln.USER_VLAN) && vln.USER_VLAN.contains('�')){
                    return OF_SA_GE_Utils.syncError (act, 'B04','USER_VLAN');
                }
                if(string.isblank(vln.SERVICE_VLAN)){
                    return OF_SA_GE_Utils.syncError (act, 'A05','SERVICE_VLAN');    
                }
                if(vln.SERVICE_VLAN.length()>4){
                    return OF_SA_GE_Utils.syncError (act, 'A06','SERVICE_VLAN');
                }
                if(!string.isblank(vln.SERVICE_VLAN) && vln.SERVICE_VLAN.contains('�')){
                    return OF_SA_GE_Utils.syncError (act, 'B04','SERVICE_VLAN');
                }
                if(string.isblank(vln.PROFILO_VLAN)){
                    return OF_SA_GE_Utils.syncError (act, 'A05','PROFILO_VLAN');
                }
                if(vln.PROFILO_VLAN.length()>4){
                    return OF_SA_GE_Utils.syncError (act, 'A06','PROFILO_VLAN');
                }
                if(!string.isblank(vln.PROFILO_VLAN) && vln.PROFILO_VLAN.contains('�')){
                    return OF_SA_GE_Utils.syncError (act, 'B04','PROFILO_VLAN');
                }
                if(!string.isblank(vln.CUSTOMER_VLAN) && vln.CUSTOMER_VLAN.length()>4){
                    return OF_SA_GE_Utils.syncError (act, 'A06','CUSTOMER_VLAN');
                }
                if(!string.isblank(vln.CUSTOMER_VLAN) && vln.CUSTOMER_VLAN.contains('�')){
                    return OF_SA_GE_Utils.syncError (act, 'B04','CUSTOMER_VLAN');
                }
                if(!string.isblank(vln.MODELLO_DI_SERVIZIO_VLAN) && vln.MODELLO_DI_SERVIZIO_VLAN.length()>20){
                    return OF_SA_GE_Utils.syncError (act, 'A06','MODELLO_DI_SERVIZIO_VLAN');
                }
                if(!string.isblank(vln.MODELLO_DI_SERVIZIO_VLAN) && vln.MODELLO_DI_SERVIZIO_VLAN.contains('�')){
                    return OF_SA_GE_Utils.syncError (act, 'B04','MODELLO_DI_SERVIZIO_VLAN');
                }
                if(!string.isblank(vln.INFORMAZIONI_VLAN) && vln.INFORMAZIONI_VLAN.length()>255){
                    return OF_SA_GE_Utils.syncError (act, 'A06','INFORMAZIONI_VLAN');
                }
                if(!string.isblank(vln.INFORMAZIONI_VLAN) && vln.INFORMAZIONI_VLAN.contains('�')){
                    return OF_SA_GE_Utils.syncError (act, 'B04','INFORMAZIONI_VLAN');
                }
            }
        }
        if(act.SERVIZIO_AGGIUNTIVO!=null && !act.SERVIZIO_AGGIUNTIVO.isempty()){
            for(OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO sa : act.SERVIZIO_AGGIUNTIVO){ 
                if(string.isblank(sa.NOME_SERVIZIO)){
                    return OF_SA_GE_Utils.syncError (act,'A05','NOME_SERVIZIO');
                }
                if(sa.NOME_SERVIZIO.length()>50){
                    return OF_SA_GE_Utils.syncError (act,'A06','NOME_SERVIZIO');
                }
                if(!string.isblank(sa.NOME_SERVIZIO) && sa.NOME_SERVIZIO.contains('�')){
                    return OF_SA_GE_Utils.syncError (act,'B04','NOME_SERVIZIO');
                }
                if(string.isblank(sa.INFORMAZIONI_SERVIZIO)){
                    return OF_SA_GE_Utils.syncError (act,'A05','INFORMAZIONI_SERVIZIO');
                }
                if(sa.INFORMAZIONI_SERVIZIO.length()>2) {
                    return OF_SA_GE_Utils.syncError (act,'A06','INFORMAZIONI_SERVIZIO'); 
                }
                if(!string.isblank(sa.INFORMAZIONI_SERVIZIO) && sa.INFORMAZIONI_SERVIZIO.contains('�')){
                    return OF_SA_GE_Utils.syncError (act,'B04','INFORMAZIONI_SERVIZIO');
                }
            }
            
        }
        
        if(act.APPARATO!=null && !act.APPARATO.isempty()){
            for(OF_SA_WS_IN_OLO_Activation.APPARATO ap :act.APPARATO){
                if(string.isblank(ap.TIPOLOGIA_APPARATO)){
                    return OF_SA_GE_Utils.syncError (act,'A05','TIPOLOGIA_APPARATO');
                }
                if(ap.TIPOLOGIA_APPARATO.length()>100){
                    return OF_SA_GE_Utils.syncError (act,'A06','TIPOLOGIA_APPARATO');
                }
                if(!string.isblank(ap.TIPOLOGIA_APPARATO) && ap.TIPOLOGIA_APPARATO.contains('�')){
                    return OF_SA_GE_Utils.syncError (act,'B04','TIPOLOGIA_APPARATO');
                }
                if(!string.isblank(ap.PASSWORD_APPARATO) && ap.PASSWORD_APPARATO.length()>50){
                    return OF_SA_GE_Utils.syncError (act,'A06','PASSWORD_APPARATO');
                }
                if(!string.isblank(ap.PASSWORD_APPARATO) && ap.PASSWORD_APPARATO.contains('�')){
                    return OF_SA_GE_Utils.syncError (act,'B04','PASSWORD_APPARATO');
                }
                if(string.isblank(ap.AZIONE_APPARATO)){
                    return OF_SA_GE_Utils.syncError (act,'A05','AZIONE_APPARATO');
                }
                if(ap.AZIONE_APPARATO.length()>1){
                    return OF_SA_GE_Utils.syncError (act,'A06','AZIONE_APPARATO');
                }
                if(!string.isblank(ap.AZIONE_APPARATO) && ap.AZIONE_APPARATO.contains('�')){
                    return OF_SA_GE_Utils.syncError (act,'B04','AZIONE_APPARATO');
                }
            }

            if(string.isblank(act.INFORMAZIONI_LOGISTICA_APPARATI)){
                return OF_SA_GE_Utils.syncError (act, 'A05','INFORMAZIONI_LOGISTICA_APPARATI');
            }
            if(act.INFORMAZIONI_LOGISTICA_APPARATI.length()>100){
            	return OF_SA_GE_Utils.syncError (act, 'A06','INFORMAZIONI_LOGISTICA_APPARATI');
            }
            if(!string.isblank(act.INFORMAZIONI_LOGISTICA_APPARATI) && act.INFORMAZIONI_LOGISTICA_APPARATI.contains('�')){
                return OF_SA_GE_Utils.syncError (act, 'B04','INFORMAZIONI_LOGISTICA_APPARATI');
            }  
        }
                
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.2 corrisponde alla fine check acquisizione.
		OF_SA_GE_Utils.partialTemplog('ACQ.2');
        // finisce qui        
       
       if(!OF_SA_GE_Utils.checkRTMap){
	        //vado a creare la mappa dei recordtype per poi utilizzarla
	    	OF_SA_GE_Utils.RTMap = new  map<String,String>();
	    	for(recordtype rt : [select id,developername from recordtype]){
	    		OF_SA_GE_Utils.RTMap.put(rt.developername,rt.id);
	    	}
	    	OF_SA_GE_Utils.checkRTMap=true;
       }
        //creo ed inserisco il case
        Case c = new Case(); 

        c.RecordTypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Attivazione');
        c.EOF_Codice_Ordine_Olo__c=act.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = act.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = act.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_SA_GE_Utils.StringToDate(act.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = act.ID_NOTIFICA;                
        c.EOF_Data_Prevista_Attivazione__c = OF_SA_GE_Utils.StringToDateNoTime(act.DATA_PREVISTA_ATTIVAZIONE);
        c.EOF_Identificativo_del_POP__c= act.IDENTIFICATIVO_DEL_POP;
        c.EOF_ID_Building_WS__c =act.ID_BUILDING;
        c.subject='Richiesta Attivazione';
        c.status='Inviato';
        c.EOF_FASE__C='NA';
        c.PO_SA_Portale__c=OF_SA_GE_Utils.PORTAL;
        insert c;
       

        //creo il record di generatore ID Servizio che poi mi andrò a querare in asincrono
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
        g.OF_Case_Id__c=c.Id;
        insert g;
        
        OF_SA_GE_Utils.caseOriginale=c; 
        OF_SA_GE_Utils.checkCaseOriginale=true;
        //creo ed inserisco l'ack ad OLO (OLO->SF - ACK - ActivationRequest) e aggiorno il sl di riferimento con l'ACK
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slToUpsert.add(OF_SA_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                             'Codice_operatore' => act.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => act.CODICE_ORDINE_OLO,
                                             'Flusso' => 'SF-OLO',
                                            'Metodo' => 'OLO_ActivationSetup_OpenStream',
                                             'ID_notifica' => act.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'OLO->SF - ACK - ActivationRequest',
											'SL Riferimento' => OF_SA_GE_Utils.slOLOSF.Id}));
		OF_SA_GE_Utils.slOLOSF.EOF_Response__c='ACK';	
		OF_SA_GE_Utils.slOLOSF.Caso__c=c.Id;															
		slToUpsert.add(OF_SA_GE_Utils.slOLOSF);
		upsert slToUpsert;
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,OF_SA_GE_Utils.slOLOSF.Id);
        
		OF_SA_GE_Utils.EndTemplog();
        
        return  resp; 
    } 
    
    
    public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksDeactivation(OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deact){
        
        //creo il log della fiberrequest
        OF_SA_GE_Utils.slOLOSF = OF_SA_GE_Utils.create_EAI_Log(deact);

	    // 14/02/2018 MM : Aggiorno il timestamp. C.1 corrisponde alla fine check Cessazione.
		OF_SA_GE_Utils.partialTemplog('C.1');
	    // finisce qui
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse resp = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
        resp.esito='0'; 

        if(string.isblank(deact.CODICE_OPERATORE)){
            return OF_SA_GE_Utils.syncError (deact,'A05','CODICE_OPERATORE');
        }
        
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        
        for(Schema.PicklistEntry s : ple){
            if(deact.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        }       
        if(!olo_found) {
             return OF_SA_GE_Utils.syncError (deact,'A06','CODICE_OPERATORE');
        }
    
        
        if(string.isblank(deact.CODICE_ORDINE_OLO) || deact.CODICE_ORDINE_OLO.length()>18 || deact.CODICE_ORDINE_OLO.contains('�')){
            if(string.isblank(deact.CODICE_ORDINE_OLO)){
                return OF_SA_GE_Utils.syncError (deact,'A05','CODICE_ORDINE_OLO');
            }
            else if(deact.CODICE_ORDINE_OLO.length()>18){
                return OF_SA_GE_Utils.syncError (deact,'A06','CODICE_ORDINE_OLO');
            }
            else if(deact.CODICE_ORDINE_OLO.contains('�')){
                return OF_SA_GE_Utils.syncError (deact,'B04','CODICE_ORDINE_OLO');
            }
        }
        
        if(OF_SA_GE_Utils.checkCaseOriginale){
            return OF_SA_GE_Utils.syncError (Deact,'A08','CODICE_ORDINE_OLO');
        }
        
        if(string.isblank(deact.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (deact,'A05','DATA_NOTIFICA');
        }
        if(!OF_SA_GE_Utils.checkDateTime(deact.DATA_NOTIFICA)){
        	return OF_SA_GE_Utils.syncError (deact,'A06','DATA_NOTIFICA');
        }    
                
        if(string.isblank(deact.ID_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (deact,'A05','ID_NOTIFICA');
        }
        else if(deact.ID_NOTIFICA.length()>100){
            return OF_SA_GE_Utils.syncError (deact,'A06','ID_NOTIFICA');
        }
        else if(deact.ID_NOTIFICA.contains('�')){
            return OF_SA_GE_Utils.syncError (deact,'B04','ID_NOTIFICA');
        }

        if(string.isblank(deact.ID_RISORSA)){
            return OF_SA_GE_Utils.syncError (deact,'A05','ID_RISORSA');
        }
        else if(deact.ID_RISORSA.length()>50){
            return OF_SA_GE_Utils.syncError (deact,'A06','ID_RISORSA');
        }
        else if(deact.ID_RISORSA.contains('�')){
            return OF_SA_GE_Utils.syncError (deact,'B04','ID_RISORSA');
        }
        
        if(!string.isblank(deact.NOME_CLIENTE)){
        	if(deact.NOME_CLIENTE.length()>20){
            	return OF_SA_GE_Utils.syncError (deact,'A06','NOME_CLIENTE');
        	}
        	if(deact.NOME_CLIENTE.contains('�')){
        		return OF_SA_GE_Utils.syncError (deact,'B04','NOME_CLIENTE');
        	}
        }
         
        if(deact.APPARATO!=null && !deact.APPARATO.isempty()){
            for(OF_SA_WS_IN_OLO_Deactivation.APPARATO ap :deact.APPARATO){
                
                if(string.isblank(ap.TIPOLOGIA_APPARATO)){
                    return OF_SA_GE_Utils.syncError (deact,'A05','TIPOLOGIA_APPARATO');
                }
                if(ap.TIPOLOGIA_APPARATO.length()>100){
                    return OF_SA_GE_Utils.syncError (deact,'A06','TIPOLOGIA_APPARATO');
                }
                if(string.isblank(ap.ID_APPARATO)){
                    return OF_SA_GE_Utils.syncError (deact,'A05','ID_APPARATO');
                }
                if(ap.ID_APPARATO.length()>50){
                    return OF_SA_GE_Utils.syncError (deact,'A06','ID_APPARATO');
                }
                
                if(!string.isblank(ap.TIPOLOGIA_APPARATO)){
    
                    if(!string.isblank(deact.COGNOME_CLIENTE) && deact.COGNOME_CLIENTE.length()>70){
                        return OF_SA_GE_Utils.syncError (deact,'A06','COGNOME_CLIENTE');
                    }
                    if(!string.isblank(deact.COGNOME_CLIENTE) && deact.COGNOME_CLIENTE.contains('�')){
                        return OF_SA_GE_Utils.syncError (deact,'B04','COGNOME_CLIENTE');
                    }
                    
                    if(string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_1)){
                        return OF_SA_GE_Utils.syncError (deact,'A05','RECAPITO_TELEFONICO_CLIENTE_1');
                    }
                    if(deact.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
                        return OF_SA_GE_Utils.syncError (deact,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
                    }
                    if(!string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_1) && deact.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
                        return OF_SA_GE_Utils.syncError (deact,'B04','RECAPITO_TELEFONICO_CLIENTE_1');
                    }
                    
                    if(!string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_2) && deact.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
                        return OF_SA_GE_Utils.syncError (deact,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
                    }
                    if(!string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_2) && deact.RECAPITO_TELEFONICO_CLIENTE_2.contains('�')){
                        return OF_SA_GE_Utils.syncError (deact,'B04','RECAPITO_TELEFONICO_CLIENTE_2');
                    }       
                }   
            }
        }

        if(!string.isblank(deact.NOTE)){
        	if(deact.NOTE.length()>255){
        		return OF_SA_GE_Utils.syncError (deact,'A06','NOTE');
        	}
        	if(deact.NOTE.contains('�')){
        		return OF_SA_GE_Utils.syncError (deact,'B04','NOTE');
        	}
        } 
        
        Case c = new Case();
        c.subject='Richiesta Cessazione';
        c.recordtypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Cessazione');
        c.Status='Inviato';
        c.EOF_Id_Risorsa__c=Deact.ID_Risorsa;
        c.EOF_Codice_Ordine_Olo__c=Deact.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = Deact.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = Deact.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_SA_GE_Utils.StringToDate(Deact.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = Deact.ID_NOTIFICA;
        c.PO_SA_Portale__c=OF_SA_GE_Utils.PORTAL;
        insert c;
        OF_SA_GE_Utils.caseOriginale=c;
        OF_SA_GE_Utils.checkCaseOriginale=true;
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slToUpsert.add(OF_SA_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                             'Codice_operatore' => Deact.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => Deact.CODICE_ORDINE_OLO,
                                             'Flusso' => 'OLO-SF',
                                             'Metodo' => 'OLO_DeactivationRequest',
                                             'ID_notifica' => Deact.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'OLO->SF - ACK - DeactivationRequest',
											 'SL Riferimento' => OF_SA_GE_Utils.slOLOSF.Id}));
		OF_SA_GE_Utils.slOLOSF.EOF_Response__c='ACK';	
		OF_SA_GE_Utils.slOLOSF.Caso__c=c.Id;															
		slToUpsert.add(OF_SA_GE_Utils.slOLOSF);
		upsert slToUpsert;
        OF_SA_OLO_AsyncChecks.OLO_AsyncDeactivation(c.Id,OF_SA_GE_Utils.slOLOSF.Id);
        
	    // 14/02/2018 MM : Aggiorno il timestamp. C.2 corrisponde alla fine check Cessazione.
		OF_SA_GE_Utils.partialTemplog('C.2');
	    // finisce qui
	    
		OF_SA_GE_Utils.EndTemplog();
        
        return resp;    
    }
    
    //AA: Metodo check values per "OLO_ChangeSetup_OpenStream"
  /* SPOSTATO IN CLASSE OF_CO_OLO_EntryChecks 
   public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksChangeSetup(OF_SA_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request deact){
                       
        //TODO AA: Modificare in "ChangeOrder"
        OF_SA_GE_Utils.OPNAme='ChangeOrder da OLO';
        
		OF_SA_GE_Utils.tmpl = new TEMPLOG__c();
		OF_SA_GE_Utils.tmpl.Name= Deact.CODICE_ORDINE_OLO +' - '+OF_SA_GE_Utils.OPName+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OF_SA_GE_Utils.tmpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome');
    	OF_SA_GE_Utils.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ Deact.codice_ordine_olo;
    	OF_SA_GE_Utils.tmpl.Type__c ='T';
        // finisce qui
                
        //TODO AA: Aggiungere al metodo "create_EAI_Log" instance of per gestione log del "ChangeOrder"
        //creo il log della fiberrequest
        OF_SA_GE_Utils.slOLOSF = OF_SA_GE_Utils.create_EAI_Log(deact);

        //Istanzio l'oggetto di response
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse res = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
        //Setto l'esito ad ok
        res.esito='0'; 

        //CONTROLLO CODICE OPERATORE
        if(string.isblank(deact.CODICE_OPERATORE)){
            //TODO AA: Aggiungere al metodo "syncError" instance of per gestione Ack/Nack del "ChangeOrder"
            return OF_SA_GE_Utils.syncError (deact,'A05','CODICE_OPERATORE');
        }
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        
        for(Schema.PicklistEntry s : ple){
            if(deact.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        }       
        if(!olo_found) {
             return OF_SA_GE_Utils.syncError (deact,'A06','CODICE_OPERATORE');
        }
        //FINE CONTROLLO CODICE OPERATORE
        //CONTROLLI CODICE_ORDINE_OLO
        if(string.isblank(deact.CODICE_ORDINE_OLO) || deact.CODICE_ORDINE_OLO.length()>18 || deact.CODICE_ORDINE_OLO.contains('�')){
            if(string.isblank(deact.CODICE_ORDINE_OLO)){
                return OF_SA_GE_Utils.syncError (deact,'A05','CODICE_ORDINE_OLO');
            }
            else if(deact.CODICE_ORDINE_OLO.length()>18){
                return OF_SA_GE_Utils.syncError (deact,'A06','CODICE_ORDINE_OLO');
            }
            else if(deact.CODICE_ORDINE_OLO.contains('�')){
                return OF_SA_GE_Utils.syncError (deact,'B04','CODICE_ORDINE_OLO');
            }
        }
        //FINE CONTROLLO CODICE OLO
        //CONTROLLO DATA_NOTIFICA
        if(string.isblank(deact.DATA_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (deact,'A05','DATA_NOTIFICA');
        }
        if(!OF_SA_GE_Utils.checkDateTime(deact.DATA_NOTIFICA)){
        	return OF_SA_GE_Utils.syncError (deact,'A06','DATA_NOTIFICA');
        }   
        //FINE CONTROLLO DATA NOTIFICA
        //CONTROLLO ID_NOTIFICA
        if(string.isblank(deact.ID_NOTIFICA)){
            return OF_SA_GE_Utils.syncError (deact,'A05','ID_NOTIFICA');
        }
        else if(deact.ID_NOTIFICA.length()>100){
            return OF_SA_GE_Utils.syncError (deact,'A06','ID_NOTIFICA');
        }
        else if(deact.ID_NOTIFICA.contains('�')){
            return OF_SA_GE_Utils.syncError (deact,'B04','ID_NOTIFICA');
        }
        //FINE CONTROLLO ID_NOTIFICA
        //CONTROLLO ID_RISORSA
        if(string.isblank(deact.ID_RISORSA)){
            return OF_SA_GE_Utils.syncError (deact,'A05','ID_RISORSA');
        }
        else if(deact.ID_RISORSA.length()>50){
            return OF_SA_GE_Utils.syncError (deact,'A06','ID_RISORSA');
        }
        else if(deact.ID_RISORSA.contains('�')){
            return OF_SA_GE_Utils.syncError (deact,'B04','ID_RISORSA');
        }
        //FINE CONTROLLO ID_RISORSA
        // CONTROLLO PROFILO
        if(string.isblank(deact.PROFILO)){
            return OF_SA_GE_Utils.syncError (deact,'A05','PROFILO');
        }
        else if(deact.PROFILO.length()>20){
            return OF_SA_GE_Utils.syncError (deact,'A06','PROFILO');
        }
        else if(deact.PROFILO.contains('�')){
            return OF_SA_GE_Utils.syncError (deact,'B04','PROFILO');
        }
        //FINE CONTROLLO PROFILO
        
        //CONTROLLI SUI CAMPI OPZIONALI
        //CONTROLLO SUL CAMPO OPZ CODICE_PROGETTO_SPECIALE
        if(!string.isblank(deact.CODICE_PROGETTO_SPECIALE)){
        	if(deact.CODICE_PROGETTO_SPECIALE.length()>50){
        		return OF_SA_GE_Utils.syncError (deact,'A06','CODICE_PROGETTO_SPECIALE');
        	}
        	if(deact.CODICE_PROGETTO_SPECIALE.contains('�')){
	            return OF_SA_GE_Utils.syncError (deact,'B04','CODICE_PROGETTO_SPECIALE');
	        }
        } 
        //CONTROLLO CAMPO OPZ PROMOZIONE
        if(!string.isblank(deact.PROMOZIONE)){
        	if(deact.PROMOZIONE.length()>50){
        		return OF_SA_GE_Utils.syncError (deact,'A06','PROMOZIONE');
        	}
        	if(deact.PROMOZIONE.contains('�')){
	            return OF_SA_GE_Utils.syncError (deact,'B04','PROMOZIONE');
	        }
        }
        //CONTROLLO CAMPO OPZ CLUSTER_PROMOZIONE
        if(!string.isblank(deact.CLUSTER_PROMOZIONE)){
        	if(deact.CLUSTER_PROMOZIONE.length()>50){
        		return OF_SA_GE_Utils.syncError (deact,'A06','CLUSTER_PROMOZIONE');
        	}
        	if(deact.CLUSTER_PROMOZIONE.contains('�')){
	            return OF_SA_GE_Utils.syncError (deact,'B04','CLUSTER_PROMOZIONE');
	        }
        }
        //CONTROLLO CAMPO OPZ NOTE
        if(!string.isblank(deact.NOTE)){
        	if(deact.NOTE.length()>255){
        		return OF_SA_GE_Utils.syncError (deact,'A06','NOTE');
        	}
        	if(deact.NOTE.contains('�')){
	            return OF_SA_GE_Utils.syncError (deact,'B04','NOTE');
	        }
        }
        //FINE CONTROLLI CAMPI OPZIONALI 
        //Se i controlli sincroni vanno a buon fine inserisco il case ed eseguo le varie operazioni
        //TODO AA: Settare i vari valori del case
        Case c = new Case();
        c.subject='Richiesta Cessazione';
        c.recordtypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Cessazione');
        c.Status='Inviato';
        c.EOF_Id_Risorsa__c=Deact.ID_Risorsa;
        c.EOF_Codice_Ordine_Olo__c=Deact.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = Deact.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = Deact.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_SA_GE_Utils.StringToDate(Deact.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = Deact.ID_NOTIFICA;
        c.PO_SA_Portale__c=OF_SA_GE_Utils.PORTAL;
        insert c;
        /*TODO AA: Creare una lista di Obj "OF_CommercialElementIstanziato__c" per la gestione delle VLAN e legarli al cade
            ESEMPIO: OF_SA_OLO_AsyncChecks da riga 102 a 168 
       

        OF_SA_GE_Utils.caseOriginale=c;
        OF_SA_GE_Utils.checkCaseOriginale=true;
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slToUpsert.add(OF_SA_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                                'Codice_operatore' => Deact.CODICE_OPERATORE,
                                                'Codice_ordine_OLO' => Deact.CODICE_ORDINE_OLO,
                                                'Flusso' => 'OLO-SF',
                                            'Metodo' => 'OLO_DeactivationRequest',
                                                'ID_notifica' => Deact.ID_NOTIFICA,
                                                'Tipo Comunicazione' => 'OLO->SF - ACK - DeactivationRequest',
                                            'SL Riferimento' => OF_SA_GE_Utils.slOLOSF.Id}));
        OF_SA_GE_Utils.slOLOSF.EOF_Response__c='ACK';	
        OF_SA_GE_Utils.slOLOSF.Caso__c=c.Id;															
        slToUpsert.add(OF_SA_GE_Utils.slOLOSF);
        upsert slToUpsert;
        //Richiamo il metodo di controlli asincroni
        //TODO AA: Aggiungere richiamo ai check asincroni di piergiorgio
        //OF_SA_OLO_AsyncChecks.OLO_AsyncDeactivation(c.Id,OF_SA_GE_Utils.slOLOSF.Id);
        
        // 14/02/2018 MM : Aggiorno il timestamp. C corrisponde alla fine check Cessazione.
        OF_SA_GE_Utils.tmpl.Timestamp__c = OF_SA_GE_Utils.tmpl.Timestamp__c + ', C: '+Datetime.now().format('HH:mm:ss','Europe/Rome');
        // finisce qui
        
        // 14/02/2018 MM : Inserisco il templog
        try{
            insert OF_SA_GE_Utils.tmpl;
        }
        catch(Exception e){
            OF_SA_GE_Utils.tmpl.Type__c='E';
            OF_SA_GE_Utils.tmpl.desc__c='Errore :' +e;
            insert OF_SA_GE_Utils.tmpl;	
        }
        // finisce qui

        return res;
    }*/

}
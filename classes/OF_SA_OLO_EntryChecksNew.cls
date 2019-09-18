public class OF_SA_OLO_EntryChecksNew {  
    public static case c;
    public static Boolean portalNewIf = false;

    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksActivationNew(OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest act, EOF_EAI_Service_Log__c slPort){
        OF_SA_GE_UtilsNew.PORTAL=true;
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse resp = SyncChecksActivationNew(act);
        if(resp.esito=='0'){            
            slPort.EOF_Stato_Ordine__c = OF_SA_GE_UtilsNew.caseOriginale.status;
            slPort.EOF_Codice_ordine_eof__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
            slPort.PO_SA_Data_Inserimento_Ordine__c = System.Now();  
        }else{
        	slPort.EOF_MOtivazione__c=resp.motivazione;
        	if(resp.codice_motivazione=='A04' || resp.codice_motivazione=='200' || resp.codice_motivazione=='100'){
        		slPort.EOF_MOtivazione__c='Servizio Momentaneamente non disponibile';
        	}
            slPort.EOF_Stato_Ordine__c='error';
            slPort.EOF_COdice_MOtivazione__c=resp.codice_motivazione;
            //slPort.EOF_MOtivazione__c=resp.motivazione;
        }
        return slPort;  
    } 
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksStatusUpdate(OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur, EOF_EAI_Service_Log__c slPort){        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse resp = SyncChecksStatusUpdateNew(sur);        
        
        if(resp.esito=='0'){
            slPort.EOF_Stato_Ordine__c=OF_SA_GE_UtilsNew.caseOriginale.status;  
        }else{
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
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksReschedule(OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest r, EOF_EAI_Service_Log__c slPort){         
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse resp = SyncChecksRescheduleNew(r);
        if(resp.esito=='0'){
            slPort.EOF_Stato_Ordine__c=OF_SA_GE_UtilsNew.caseOriginale.status;  
        }else{
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
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksDeactivationNew(OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest Deact, EOF_EAI_Service_Log__c slPort){
        OF_SA_GE_UtilsNew.PORTAL=true;
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse resp = SyncChecksDeactivationNew(Deact);
        if(resp.esito=='0'){
            slPort.EOF_Stato_Ordine__c = OF_SA_GE_UtilsNew.caseOriginale.status;
            slPort.EOF_COdice_MOtivazione__c = OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c;
            slPort.EOF_MOtivazione__c = OF_SA_GE_UtilsNew.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c+' - '+OF_SA_GE_UtilsNew.caseOriginale.OF_SA_MOTIVAZIONE__c;
            slPort.EOF_Codice_ordine_eof__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
            slPort.PO_SA_Data_Inserimento_Ordine__c=System.Now();  
        }else{
        	slPort.EOF_MOtivazione__c = resp.motivazione;
        	if(resp.codice_motivazione == 'A04' || resp.codice_motivazione == '200' || resp.codice_motivazione == '100'){
        		slPort.EOF_MOtivazione__c='Servizio Momentaneamente non disponibile';
        	}
            slPort.EOF_Stato_Ordine__c='error';
            slPort.EOF_COdice_MOtivazione__c=resp.codice_motivazione;
            //slPort.EOF_MOtivazione__c=resp.motivazione;
        }
        return slPort;  
    } 

    //AA 08/10/2018 - Nuovo metodo per esporre l'attivazione a sky
    public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse SyncChecksActivationNew(OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest act){
         
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse resp = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
        
        //creo e inserisco il log dell'attivazione da OLO (OLO->SF - ActivationRequest)
        //OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
        
        resp.ID_NOTIFICA=String.valueOf(Datetime.now().gettime());
        resp.ESITO='0';
                
        OF_SA_GE_UtilsNew.OPName='Attivazione';
                
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.1 corrisponde a inizio check acquisizione.
		OF_SA_GE_UtilsNew.partialTemplog('ACQ.1');
        // finisce qui

        
        
        if(string.isblank(act.CODICE_OPERATORE)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','CODICE_OPERATORE');
        }else if(act.CODICE_OPERATORE.length()>3){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','CODICE_OPERATORE');
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
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
        	return OF_SA_GE_UtilsNew.syncError (act,'A06','CODICE_OPERATORE');
        }
                 
        if(string.isblank(act.CODICE_ORDINE_OLO)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
        	return OF_SA_GE_UtilsNew.syncError (act,'A05','CODICE_ORDINE_OLO');
        }else if(act.CODICE_ORDINE_OLO.length()>18){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','CODICE_ORDINE_OLO');
        }else if(act.CODICE_ORDINE_OLO.contains('�')){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'B04','CODICE_ORDINE_OLO');
        }
        List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: act.CODICE_ORDINE_OLO];
        if(!cList.isEmpty()){
        //if(OF_SA_GE_UtilsNew.checkCaseOriginale){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A08','CODICE_ORDINE_OLO');
        }
        if(string.isblank(act.DATA_NOTIFICA)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','DATA_NOTIFICA');
        }else if(!OF_SA_GE_UtilsNew.checkDateTime(act.DATA_NOTIFICA)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
        	return OF_SA_GE_UtilsNew.syncError (act,'A06','DATA_NOTIFICA');
        }
        if(string.isblank(act.ID_NOTIFICA)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','ID_NOTIFICA');
        }else if(act.ID_NOTIFICA.length()>100){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','ID_NOTIFICA');
        }else if(act.ID_NOTIFICA.contains('�')){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'B04','ID_NOTIFICA');
        }
        resp.ID_NOTIFICA=act.ID_NOTIFICA;
        //AA - Commentata per test
        if(act.CODICE_OPERATORE != null && act.CODICE_OPERATORE == 'SKY'){
            if(String.isBlank(act.IDENTIFICATIVO_PRENOTAZIONE)){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                return OF_SA_GE_UtilsNew.syncError (act,'A05','IDENTIFICATIVO_PRENOTAZIONE');
            }else if(act.IDENTIFICATIVO_PRENOTAZIONE.length()>50){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                return OF_SA_GE_UtilsNew.syncError (act,'A06','IDENTIFICATIVO_PRENOTAZIONE');
            }
        }else{
            if(String.isNotBlank(act.IDENTIFICATIVO_PRENOTAZIONE) && act.IDENTIFICATIVO_PRENOTAZIONE.length()>50){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                return OF_SA_GE_UtilsNew.syncError (act,'A06','IDENTIFICATIVO_PRENOTAZIONE');
            }
        }
        if(string.isblank(act.NOME_REFERENTE_TECNICO_OLO)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','NOME_REFERENTE_TECNICO_OLO');
        }else if(act.NOME_REFERENTE_TECNICO_OLO.length()>50){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','NOME_REFERENTE_TECNICO_OLO');
        }else if(act.NOME_REFERENTE_TECNICO_OLO.contains('�')){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'B04','NOME_REFERENTE_TECNICO_OLO');
        }
        if(string.isblank(act.COGNOME_REFERENTE_TECNICO_OLO)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','COGNOME_REFERENTE_TECNICO_OLO');
        } else if(act.COGNOME_REFERENTE_TECNICO_OLO.length()>50){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','COGNOME_REFERENTE_TECNICO_OLO');
        }else if(act.COGNOME_REFERENTE_TECNICO_OLO.contains('�')){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'B04','COGNOME_REFERENTE_TECNICO_OLO');
        }

        if(string.isblank(act.TELEFONO_REFERENTE_TECNICO_OLO)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','TELEFONO_REFERENTE_TECNICO_OLO');
        }else if(act.TELEFONO_REFERENTE_TECNICO_OLO.length()>20){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','TELEFONO_REFERENTE_TECNICO_OLO');
        }else if(act.TELEFONO_REFERENTE_TECNICO_OLO.contains('�')){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'B04','TELEFONO_REFERENTE_TECNICO_OLO');
        }
        if(string.isblank(act.EMAIL_REFERENTE_TECNICO_OLO)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','EMAIL_REFERENTE_TECNICO_OLO');
        }else if(!OF_SA_GE_UtilsNew.checkEmail(act.EMAIL_REFERENTE_TECNICO_OLO)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
        	return OF_SA_GE_UtilsNew.syncError (act,'A06','EMAIL_REFERENTE_TECNICO_OLO');
        }
                //check  sugli opzionali
        if(!string.isblank(act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH)){
        	if(act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH.length()>20){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
        		return OF_SA_GE_UtilsNew.syncError (act,'A06','TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH');
        	}
        	if(act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'B04','TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH');
	        }
        } 
        if(!string.isblank(act.NOME_CLIENTE)){
        	if(act.NOME_CLIENTE.length()>20){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'A06','NOME_CLIENTE');
	        }
	        if(act.NOME_CLIENTE.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'B04','NOME_CLIENTE');
	        } 
        }
        if(string.isblank(act.COGNOME_CLIENTE)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','COGNOME_CLIENTE');
        }else if(act.COGNOME_CLIENTE.length()>70){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','COGNOME_CLIENTE');
        }else if(act.COGNOME_CLIENTE.contains('�')){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'B04','COGNOME_CLIENTE');
        }
        if(string.isblank(act.RECAPITO_TELEFONICO_CLIENTE_1)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','RECAPITO_TELEFONICO_CLIENTE_1');
        }else if(act.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
        }else if(act.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'B04','RECAPITO_TELEFONICO_CLIENTE_1');
        }
        if(!string.isblank(act.RECAPITO_TELEFONICO_CLIENTE_2)){
        	if(act.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
	        }
	        if(act.RECAPITO_TELEFONICO_CLIENTE_2.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'B04','RECAPITO_TELEFONICO_CLIENTE_2');
	        }
        }
        if(!string.isblank(act.INFORMAZIONI_LOGISTICA_APPARATI)){
            if(act.INFORMAZIONI_LOGISTICA_APPARATI.length()>100){
                   OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                   return OF_SA_GE_UtilsNew.syncError (act, 'A06','INFORMAZIONI_LOGISTICA_APPARATI');
            }else if(!string.isblank(act.INFORMAZIONI_LOGISTICA_APPARATI) && act.INFORMAZIONI_LOGISTICA_APPARATI.contains('�')){
                  OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                  return OF_SA_GE_UtilsNew.syncError (act, 'B04','INFORMAZIONI_LOGISTICA_APPARATI');
            }  
        }
        if(string.isblank(act.DATA_PREVISTA_ATTIVAZIONE)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','DATA_PREVISTA_ATTIVAZIONE');
        }else if(!OF_SA_GE_UtilsNew.checkDate(act.DATA_PREVISTA_ATTIVAZIONE)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
        	return OF_SA_GE_UtilsNew.syncError (act,'A06','DATA_PREVISTA_ATTIVAZIONE');
        }
        if(!string.isblank(act.ORARIO_APPUNTAMENTO) && !OF_SA_GE_UtilsNew.checkTime(act.ORARIO_APPUNTAMENTO)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','ORARIO_APPUNTAMENTO');
        }
        if(!string.isblank(act.CODICE_PROGETTO_SPECIALE)){
        	if(act.CODICE_PROGETTO_SPECIALE.length()>50){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'A06','CODICE_PROGETTO_SPECIALE');
	        }
	        if(act.CODICE_PROGETTO_SPECIALE.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'B04','CODICE_PROGETTO_SPECIALE');
	        }
        }
		if(!string.isblank(act.PROMOZIONE)){
			if(act.PROMOZIONE.length()>50){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'A06','PROMOZIONE');
	        }
	        if(act.PROMOZIONE.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'B04','PROMOZIONE');
	        }
		}
        if(!string.isblank(act.CLUSTER_PROMOZIONE)){
        	if(act.CLUSTER_PROMOZIONE.length()>50){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'A06','CLUSTER_PROMOZIONE');
	        }
	        if(act.CLUSTER_PROMOZIONE.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'B04','CLUSTER_PROMOZIONE');
	        }
        }
        if(!string.isblank(act.NOTE)){
        	if(act.NOTE.length()>255){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'A06','NOTE');
	        }
	        if(act.NOTE.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'B04','NOTE');
	        }
        }
        if(string.isblank(act.ID_BUILDING)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
    		return OF_SA_GE_UtilsNew.syncError (act,'A05','ID BUILDING');
    	}else if(act.ID_BUILDING.length() > 150){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
    		return OF_SA_GE_UtilsNew.syncError (act,'A06','ID BUILDING');
    	}else if(act.ID_BUILDING.contains('�')){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
    		return OF_SA_GE_UtilsNew.syncError (act,'B04','ID BUILDING');
    	}
        if(!string.isblank(act.SCALA_PALAZZINA)){
        	if(act.SCALA_PALAZZINA.length()>21){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'A06','SCALA_PALAZZINA');
	        }
	        if(act.SCALA_PALAZZINA.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'B04','SCALA_PALAZZINA');
	        }
        }

     /*/ EC Commento DIA 2019 04 05      if(String.isBlank(act.TIPOLOGIA_SERVIZIO)){ //aggiunto perché per DIA non è obbligatorio

            if(string.isblank(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA)){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                return OF_SA_GE_UtilsNew.syncError (act,'A05','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
            }else if(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA.length()>20){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                return OF_SA_GE_UtilsNew.syncError (act,'A06','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
            }else if(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                return OF_SA_GE_UtilsNew.syncError (act,'B04','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
            }

        }else{*/  // EC Commento DIA 2019 04 05  
            if (String.isNotBlank(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA)) {
                if(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA.length()>20){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'A06','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
                }else if(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA.contains('�')){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'B04','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
                }
            }
       // EC Commento DIA 2019 04 05 (chiude else)   }



    	if(!string.isblank(act.RECAPITO_TEST_LINEA)){
			if(act.RECAPITO_TEST_LINEA.length()>20){ 
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'A06','RECAPITO_TEST_LINEA');
	        }
	        
	        if(act.RECAPITO_TEST_LINEA.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
	            return OF_SA_GE_UtilsNew.syncError (act,'B04','RECAPITO_TEST_LINEA');
	        }
		}
        if(string.isblank(act.IDENTIFICATIVO_DEL_POP)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','IDENTIFICATIVO_DEL_POP');
        }else if(act.IDENTIFICATIVO_DEL_POP.length()>10){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','IDENTIFICATIVO_DEL_POP');
        }else if(act.IDENTIFICATIVO_DEL_POP.contains('�')){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'B04','IDENTIFICATIVO_DEL_POP');
        }
    	if(string.isblank(act.PROFILO)){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A05','PROFILO');
        }else if(act.PROFILO.length()>20){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'A06','PROFILO');
        }else if(act.PROFILO.contains('�')){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
            return OF_SA_GE_UtilsNew.syncError (act,'B04','PROFILO');
        }
        //AA - Aggiunti controlli per il nuovo campo tracciato trasco
        if(String.isNotBlank(act.TRACCIATO_TRASCODIFICATO)){
            if(act.TRACCIATO_TRASCODIFICATO.length() > 10 || (act.TRACCIATO_TRASCODIFICATO != 'SI' && act.TRACCIATO_TRASCODIFICATO != 'NO')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                return OF_SA_GE_UtilsNew.syncError (act,'A06','TRACCIATO_TRASCODIFICATO');
            }else if(act.TRACCIATO_TRASCODIFICATO.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                return OF_SA_GE_UtilsNew.syncError (act,'B04','TRACCIATO_TRASCODIFICATO');
            }
        }
        //AA - Nuovo campo CODICE OPERATORE SECONDARIO
        if(String.isNotBlank(act.CODICE_OPERATORE_SECONDARIO)){
            if(act.CODICE_OPERATORE_SECONDARIO.length() > 3){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                return OF_SA_GE_UtilsNew.syncError (act,'A06','CODICE_OPERATORE_SECONDARIO');
            }else if(act.CODICE_OPERATORE_SECONDARIO.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                return OF_SA_GE_UtilsNew.syncError (act,'B04','CODICE_OPERATORE_SECONDARIO');
            }
        }  
        if(act.SERVIZIO_AGGIUNTIVO!=null && !act.SERVIZIO_AGGIUNTIVO.isempty()){
            for(OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO sa : act.SERVIZIO_AGGIUNTIVO){ 
                if(string.isblank(sa.NOME_SERVIZIO)){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'A05','NOME_SERVIZIO');
                }else if(sa.NOME_SERVIZIO.length()>50){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'A06','NOME_SERVIZIO');
                }else if(!string.isblank(sa.NOME_SERVIZIO) && sa.NOME_SERVIZIO.contains('�')){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'B04','NOME_SERVIZIO');
                }
                if(string.isblank(sa.INFORMAZIONI_SERVIZIO)){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'A05','INFORMAZIONI_SERVIZIO');
                }else if(sa.INFORMAZIONI_SERVIZIO.length()>2) {
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'A06','INFORMAZIONI_SERVIZIO'); 
                }else if(!string.isblank(sa.INFORMAZIONI_SERVIZIO) && sa.INFORMAZIONI_SERVIZIO.contains('�')){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'B04','INFORMAZIONI_SERVIZIO');
                }
            }
            
        }

       if(act.APPARATO!=null && !act.APPARATO.isempty()){
            for(OF_SA_WS_IN_OLO_ActivationNew.APPARATO ap :act.APPARATO){
                if(string.isblank(ap.TIPOLOGIA_APPARATO)){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'A05','TIPOLOGIA_APPARATO');
                }else if(ap.TIPOLOGIA_APPARATO.length()>100){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'A06','TIPOLOGIA_APPARATO');
                }else if(!string.isblank(ap.TIPOLOGIA_APPARATO) && ap.TIPOLOGIA_APPARATO.contains('�')){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'B04','TIPOLOGIA_APPARATO');
                }
                if(!string.isblank(ap.PASSWORD_APPARATO)){
                    if (ap.PASSWORD_APPARATO.length()>50){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act,'A06','PASSWORD_APPARATO');
                    }else if (ap.PASSWORD_APPARATO.contains('�')){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act,'B04','PASSWORD_APPARATO');
                  }
                }
                if(string.isblank(ap.AZIONE_APPARATO)){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'A05','AZIONE_APPARATO');
                }else if(ap.AZIONE_APPARATO.length()>1){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'A06','AZIONE_APPARATO');
                }else if(!string.isblank(ap.AZIONE_APPARATO) && ap.AZIONE_APPARATO.contains('�')){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act,'B04','AZIONE_APPARATO');
                }
                
                if(!String.isBlank(ap.CAUSALE)){
                   if(ap.CAUSALE.length()>255){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act,'A06','CAUSALE');
                    }else if(ap.CAUSALE.contains('�')){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act,'B04','CAUSALE');
                    }
                }
            } 
       }
     // EC Commento DIA 2019 04 05     if(String.isBlank(act.TIPOLOGIA_SERVIZIO)){
         if(act.VLAN==null || act.VLAN.isempty()){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
    		return OF_SA_GE_UtilsNew.syncError (act,'A05','VLAN');
     		}else{
                for(OF_SA_WS_IN_OLO_ActivationNew.VLAN vln : act.VLAN){
                        
                    if(string.isblank(vln.KIT_CONSEGNA_VLAN)){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'A05','KIT_CONSEGNA_VLAN');
                    }else if(vln.KIT_CONSEGNA_VLAN.length()>10){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'A06','KIT_CONSEGNA_VLAN');
                    }else if(!string.isblank(vln.KIT_CONSEGNA_VLAN) && vln.KIT_CONSEGNA_VLAN.contains('�')){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'B04','KIT_CONSEGNA_VLAN');
                    }
                    if(string.isblank(vln.USER_VLAN)){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'A05','USER_VLAN');
                    }else if(vln.USER_VLAN.length()>4){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'A06','USER_VLAN');
                    }else if(!string.isblank(vln.USER_VLAN) && vln.USER_VLAN.contains('�')){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'B04','USER_VLAN');
                    }
                    if(string.isblank(vln.SERVICE_VLAN)){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'A05','SERVICE_VLAN');    
                    }else if(vln.SERVICE_VLAN.length()>4){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'A06','SERVICE_VLAN');
                    }else if(!string.isblank(vln.SERVICE_VLAN) && vln.SERVICE_VLAN.contains('�')){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'B04','SERVICE_VLAN');
                    }
                    if(string.isblank(vln.PROFILO_VLAN)){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'A05','PROFILO_VLAN');
                    }else if(vln.PROFILO_VLAN.length()>4){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'A06','PROFILO_VLAN');
                    }else if(vln.PROFILO_VLAN.contains('�')){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'B04','PROFILO_VLAN');
                    }
                    if(!string.isblank(vln.CUSTOMER_VLAN)){
                        if(vln.CUSTOMER_VLAN.length()>4){
                            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                            return OF_SA_GE_UtilsNew.syncError (act, 'A06','CUSTOMER_VLAN');
                        }else if(!string.isblank(vln.CUSTOMER_VLAN) && vln.CUSTOMER_VLAN.contains('�')){
                            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                            return OF_SA_GE_UtilsNew.syncError (act, 'B04','CUSTOMER_VLAN');
                        }
                    }
                    if(!string.isblank(vln.MODELLO_DI_SERVIZIO_VLAN)){ 
                        if(vln.MODELLO_DI_SERVIZIO_VLAN.length()>20){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                            return OF_SA_GE_UtilsNew.syncError (act, 'A06','MODELLO_DI_SERVIZIO_VLAN');
                        }else if(!string.isblank(vln.MODELLO_DI_SERVIZIO_VLAN) && vln.MODELLO_DI_SERVIZIO_VLAN.contains('�')){
                        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                        return OF_SA_GE_UtilsNew.syncError (act, 'B04','MODELLO_DI_SERVIZIO_VLAN');
                        }
                    }
                    if(!string.isblank(vln.INFORMAZIONI_VLAN)){
                        if(vln.INFORMAZIONI_VLAN.length()>255){
                            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                            return OF_SA_GE_UtilsNew.syncError (act, 'A06','INFORMAZIONI_VLAN');
                        }else if(!string.isblank(vln.INFORMAZIONI_VLAN) && vln.INFORMAZIONI_VLAN.contains('�')){
                            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                            return OF_SA_GE_UtilsNew.syncError (act, 'B04','INFORMAZIONI_VLAN');
                        }
                    }
                }
            /* if(string.isblank(act.INFORMAZIONI_LOGISTICA_APPARATI)){
                    OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
                    return OF_SA_GE_UtilsNew.syncError (act, 'A05','INFORMAZIONI_LOGISTICA_APPARATI');
                }*/
             }
     // EC Commento DIA 2019 04 05      }
        Boolean hasIdToken = false;
        //TODO AA 01/10/2018 - Andrò ad aggiungere il check sul campo IDENTIFICATIVO_PRENOTAZIONE per renderlo obbligatorio
        if(act.IDENTIFICATIVO_PRENOTAZIONE != null && String.isNotBlank(act.IDENTIFICATIVO_PRENOTAZIONE)){
			// chiamo il ws di SH
			OF_SA_GE_UtilsNew.responseFromSH = OF_SA_GE_UtilsNew.makeCalloutOLOSHConfirmation(act.IDENTIFICATIVO_PRENOTAZIONE, act.CODICE_ORDINE_OLO, act.CODICE_OPERATORE, act.DATA_PREVISTA_ATTIVAZIONE);

			if(OF_SA_GE_UtilsNew.responseFromSH != null){
				if(OF_SA_GE_UtilsNew.responseFromSH.Result.equalsIgnoreCase('OK')){
					hasIdToken = true;    
					//Se SH ci risponde che l'IDENTIFICATIVO_PRENOTAZIONE è valido, avrò dei campi da salvare (?)
				}else{//Se SH ci risponde che l'IDENTIFICATIVO_PRENOTAZIONE non è valido, è motivo di NACK
					//Done AA - Implementare i codici di errore
					OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
					//In caso di errore mi salvo comunque il log della chiamata verso SH
					if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
						insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
					}
					return OF_SA_GE_UtilsNew.syncError (act, '*KO_SH*','IDENTIFICATIVO_PRENOTAZIONE'); 
				}
			}
        }
        //END AA 01/10/2018
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.2 corrisponde alla fine check acquisizione.
		OF_SA_GE_UtilsNew.partialTemplog('ACQ.2');
        // finisce qui        
       
        if(!OF_SA_GE_UtilsNew.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_SA_GE_UtilsNew.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_SA_GE_UtilsNew.RTMap.put(rt.developername,rt.id);
            }
            OF_SA_GE_UtilsNew.checkRTMap=true;
        }
        //creo ed inserisco il case
        Case c = new Case(); 
        //Se è una richiesta da portale proxy, vado a valorizzare questi due campi
        if(OF_SA_OLO_EntryChecksNew.portalNewIf){
            c.OF_SA_Tipo_Lavorazione__c = 'Attivazione';
            c.OF_SA_Interfaccia_OM__c = 'Nuova IF';
        }
        //AA - Aggiunto salvataggio token id
        if(hasIdToken){ 
            c.OF_SH_Token_id__c = act.IDENTIFICATIVO_PRENOTAZIONE;
            c.OF_SH_ID_WO__c = OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_ID_WO__c;
            c.EOF_Data_Appuntamento__c = OF_SA_GE_UtilsNew.stringToDateNoTime(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.subString(0, OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('T')));
            c.EOF_Orario_Appuntamento__c = OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.subString(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('T')+1, OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('+'));
            c.OF_SH_DeliveryCompany__c = OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_DeliveryCompany__c;
        }
        //AA - Aggiunto check nuovo/vecchio flusso OM! 
        c.OF_OM_Nuovo_Flusso__c = true;
        //c.RecordTypeId=OF_SA_GE_UtilsNew.rtMap.get('OF_SA_Attivazione');
       // EC Commento DIA 2019 04 05    c.RecordTypeId= String.isBlank(act.TIPOLOGIA_SERVIZIO) ? OF_SA_GE_UtilsNew.rtMap.get('OF_SA_Attivazione') 
          // EC Commento DIA 2019 04 05                                                        : OF_SA_GE_UtilsNew.rtMap.get('OF_DIA_Attivazione');
        c.RecordTypeId= OF_SA_GE_UtilsNew.rtMap.get('OF_SA_Attivazione') ;  
        c.EOF_Codice_Ordine_Olo__c=act.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = act.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = act.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.StringToDate(act.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = act.ID_NOTIFICA;                
        c.EOF_Data_Prevista_Attivazione__c = OF_SA_GE_UtilsNew.StringToDateNoTime(act.DATA_PREVISTA_ATTIVAZIONE);
        c.EOF_Identificativo_del_POP__c= act.IDENTIFICATIVO_DEL_POP;
        c.EOF_ID_Building_WS__c = act.ID_BUILDING;
        c.EOF_Scala_Palazzina_WS__c = act.SCALA_PALAZZINA;
        //c.OF_SA_ID_Building__c = act.ID_BUILDING;
        c.subject='Richiesta Attivazione';
        c.status='Inviato';
        c.EOF_FASE__C='NA';
        c.PO_SA_Portale__c=OF_SA_GE_UtilsNew.PORTAL;
        //aa aggiunto campo 29/11/2018 
        c.TRACCIATO_TRASCODIFICATO__c=act.TRACCIATO_TRASCODIFICATO;
        c.OF_Codice_Operatore_Secondario__c = act.CODICE_OPERATORE_SECONDARIO;
        insert c;
        
        //Vado a salvare il sLog di SH
        if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
            OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = c.Id;
            insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
        }
        //creo il record di generatore ID Servizio che poi mi andrò a querare in asincrono 
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
        g.OF_Case_Id__c=c.Id;
        insert g;
        
        OF_SA_GE_UtilsNew.caseOriginale=c; 
        
        OF_SA_GE_UtilsNew.checkCaseOriginale=true;
        //Creo il log della request
        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(act);
        //AA - SAlvo sul log check nuovo/vecchio flusso OM!
        OF_SA_GE_UtilsNew.slOLOSF.OF_OM_Nuovo_Flusso__c = c.OF_OM_Nuovo_Flusso__c;
        //creo ed inserisco l'ack ad OLO (OLO->SF - ACK - ActivationRequest) e aggiorno il sl di riferimento con l'ACK
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();

       // EC Commento DIA 2019 04 05    if(String.isBlank(act.TIPOLOGIA_SERVIZIO)){//Aggiunto per distinguere il servizio DIA

            slToUpsert.add(OF_SA_GE_UtilsNew.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                                'Codice_operatore' => act.CODICE_OPERATORE,
                                                'Codice_ordine_OLO' => act.CODICE_ORDINE_OLO,
                                                'Flusso' => 'SF-OLO',
                                                'Metodo' => 'OLO_ActivationSetup_OpenStream',
                                                'ID_notifica' => act.ID_NOTIFICA,
                                                'Tipo Comunicazione' => 'OLO->SF - ACK - ActivationRequest',
                                                'SL Riferimento' => OF_SA_GE_UtilsNew.slOLOSF.Id}));
       /*  }// EC Commento DIA 2019 04 05  else{
            
            slToUpsert.add(OF_SA_GE_UtilsNew.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                                'Codice_operatore' => act.CODICE_OPERATORE,
                                                'Codice_ordine_OLO' => act.CODICE_ORDINE_OLO,
                                                'Flusso' => 'SF-OLO',
                                                'Metodo' => 'OLO_ActivationSetup_DIA',
                                                'ID_notifica' => act.ID_NOTIFICA,
                                                'Tipo Comunicazione' => 'OLO->SF - ACK - ActivationRequest',
                                                'SL Riferimento' => OF_SA_GE_UtilsNew.slOLOSF.Id}));
        }
        */ // EC Commento DIA 2019 04 05  

		OF_SA_GE_UtilsNew.slOLOSF.EOF_Response__c='ACK';	
		OF_SA_GE_UtilsNew.slOLOSF.Caso__c=c.Id;															
		slToUpsert.add(OF_SA_GE_UtilsNew.slOLOSF);
		upsert slToUpsert;
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(c.Id,OF_SA_GE_UtilsNew.slOLOSF.Id);
        
		OF_SA_GE_UtilsNew.EndTemplog();
        
        return resp; 
        } 
    //AA - Nuovo metodo per disattivazione sky
    public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse SyncChecksDeactivationNew(OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest Deact){
        
        //creo il log della fiberrequest
        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(deact);

	    // 14/02/2018 MM : Aggiorno il timestamp. C.1 corrisponde alla fine check Cessazione.
		OF_SA_GE_UtilsNew.partialTemplog('C.1');
	    // finisce qui
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse resp = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
        resp.esito='0'; 

        if(string.isblank(deact.CODICE_OPERATORE)){
            return OF_SA_GE_UtilsNew.syncError (deact,'A05','CODICE_OPERATORE');
        } else if(deact.CODICE_OPERATORE.length()>3){
                return OF_SA_GE_UtilsNew.syncError (deact,'A06','CODICE_OPERATORE');
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
             return OF_SA_GE_UtilsNew.syncError (deact,'A06','CODICE_OPERATORE');
        }
        
        if(string.isblank(deact.CODICE_ORDINE_OLO)){
                return OF_SA_GE_UtilsNew.syncError (deact,'A05','CODICE_ORDINE_OLO');
        } else if(deact.CODICE_ORDINE_OLO.length()>18){
                return OF_SA_GE_UtilsNew.syncError (deact,'A06','CODICE_ORDINE_OLO');
        }  else if(deact.CODICE_ORDINE_OLO.contains('�')){
                return OF_SA_GE_UtilsNew.syncError (deact,'B04','CODICE_ORDINE_OLO');
            }

        if(OF_SA_GE_UtilsNew.checkCaseOriginale){
            return OF_SA_GE_UtilsNew.syncError (Deact,'A08','CODICE_ORDINE_OLO');
        }
        
        if(string.isblank(deact.DATA_NOTIFICA)){
            return OF_SA_GE_UtilsNew.syncError (deact,'A05','DATA_NOTIFICA');
        } else if(!OF_SA_GE_UtilsNew.checkDateTime(deact.DATA_NOTIFICA)){
        	return OF_SA_GE_UtilsNew.syncError (deact,'A06','DATA_NOTIFICA');
        }    
                
        if(string.isblank(deact.ID_NOTIFICA)){
            return OF_SA_GE_UtilsNew.syncError (deact,'A05','ID_NOTIFICA');
        } else if(deact.ID_NOTIFICA.length()>100){
            return OF_SA_GE_UtilsNew.syncError (deact,'A06','ID_NOTIFICA');
        } else if(deact.ID_NOTIFICA.contains('�')){
            return OF_SA_GE_UtilsNew.syncError (deact,'B04','ID_NOTIFICA');
        }

        if(string.isblank(deact.ID_RISORSA)){
            return OF_SA_GE_UtilsNew.syncError (deact,'A05','ID_RISORSA');
        } else if(deact.ID_RISORSA.length()>50){
            return OF_SA_GE_UtilsNew.syncError (deact,'A06','ID_RISORSA');
        } else if(deact.ID_RISORSA.contains('�')){
            return OF_SA_GE_UtilsNew.syncError (deact,'B04','ID_RISORSA');
        }
        
        if(!string.isblank(deact.NOME_CLIENTE)){
        	if(deact.NOME_CLIENTE.length()>20){
            	return OF_SA_GE_UtilsNew.syncError (deact,'A06','NOME_CLIENTE');
        	} else if(deact.NOME_CLIENTE.contains('�')){
        		return OF_SA_GE_UtilsNew.syncError (deact,'B04','NOME_CLIENTE');
        	} 
        }
        //AA - Aggiunti controlli nuovo campo
        if(String.isNotBlank(deact.TRACCIATO_TRASCODIFICATO)){
            if(deact.TRACCIATO_TRASCODIFICATO.length() > 10 || (deact.TRACCIATO_TRASCODIFICATO != 'SI' && deact.TRACCIATO_TRASCODIFICATO != 'NO')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(deact);
                return OF_SA_GE_UtilsNew.syncError (deact,'A06','TRACCIATO_TRASCODIFICATO');
            }
        }
        //AA - Nuovo campo CODICE OPERATORE SECONDARIO
        if(String.isNotBlank(deact.CODICE_OPERATORE_SECONDARIO)){
            if(deact.CODICE_OPERATORE_SECONDARIO.length() > 3){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(deact);
                return OF_SA_GE_UtilsNew.syncError (deact,'A06','CODICE_OPERATORE_SECONDARIO');
            }else if(deact.CODICE_OPERATORE_SECONDARIO.contains('�')){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(deact);
                return OF_SA_GE_UtilsNew.syncError (deact,'B04','CODICE_OPERATORE_SECONDARIO');
            }
        }
        if(deact.APPARATO!=null && !deact.APPARATO.isempty()){
            for(OF_SA_WS_IN_OLO_DeactivationNew.APPARATO ap :deact.APPARATO){
                
                if(string.isblank(ap.TIPOLOGIA_APPARATO)){
                    return OF_SA_GE_UtilsNew.syncError (deact,'A05','TIPOLOGIA_APPARATO');
                }else if(ap.TIPOLOGIA_APPARATO.length()>100){
                    return OF_SA_GE_UtilsNew.syncError (deact,'A06','TIPOLOGIA_APPARATO');
                }
                
                if(!string.isblank(ap.TIPOLOGIA_APPARATO)){
    
                    if(string.isblank(deact.COGNOME_CLIENTE)){
                        return OF_SA_GE_UtilsNew.syncError (deact,'A06','COGNOME_CLIENTE');
                    } else if (deact.COGNOME_CLIENTE.length()>70){
                         return OF_SA_GE_UtilsNew.syncError (deact,'A06','COGNOME_CLIENTE');
                    } else if(deact.COGNOME_CLIENTE.contains('�')){
                        return OF_SA_GE_UtilsNew.syncError (deact,'B04','COGNOME_CLIENTE');
                    }
                    
                    if(string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_1)){
                        return OF_SA_GE_UtilsNew.syncError (deact,'A05','RECAPITO_TELEFONICO_CLIENTE_1');
                    }else if(deact.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
                        return OF_SA_GE_UtilsNew.syncError (deact,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
                    }else if(!string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_1) && deact.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
                        return OF_SA_GE_UtilsNew.syncError (deact,'B04','RECAPITO_TELEFONICO_CLIENTE_1');
                    }
                                     
                    if(string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_2)){
                        return OF_SA_GE_UtilsNew.syncError (deact,'A05','RECAPITO_TELEFONICO_CLIENTE_2');
                    }else if(deact.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
                        return OF_SA_GE_UtilsNew.syncError (deact,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
                    }else if(!string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_2) && deact.RECAPITO_TELEFONICO_CLIENTE_2.contains('�')){
                        return OF_SA_GE_UtilsNew.syncError (deact,'B04','RECAPITO_TELEFONICO_CLIENTE_2');
                    }    
                }   
            }
        }

        if(!string.isblank(deact.NOTE)){
        	if(deact.NOTE.length()>255){
        		return OF_SA_GE_UtilsNew.syncError (deact,'A06','NOTE');
        	}else if(deact.NOTE.contains('�')){
        		return OF_SA_GE_UtilsNew.syncError (deact,'B04','NOTE');
        	}
        } 
        
        Case c = new Case();
        if(OF_SA_OLO_EntryChecksNew.portalNewIf){
            c.OF_SA_Tipo_Lavorazione__c = 'Attivazione';
            c.OF_SA_Interfaccia_OM__c = 'Nuova IF';
        }
        c.OF_OM_Nuovo_Flusso__c = true;
        c.subject='Richiesta Cessazione';
       // EC Commento DIA 2019 04 05    c.recordtypeId = (String.isBlank(deact.TIPOLOGIA_SERVIZIO)) ? OF_SA_GE_UtilsNew.rtMap.get('OF_SA_Cessazione') : OF_SA_GE_UtilsNew.rtMap.get('EOF_Caso_Cessazione_DIA');
        c.recordtypeId =  OF_SA_GE_UtilsNew.rtMap.get('OF_SA_Cessazione') ;
        c.Status='Inviato';
        c.EOF_Id_Risorsa__c=Deact.ID_Risorsa;
        c.EOF_Codice_Ordine_Olo__c=Deact.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = Deact.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = Deact.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.StringToDate(Deact.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = Deact.ID_NOTIFICA;
        c.PO_SA_Portale__c=OF_SA_GE_UtilsNew.PORTAL;
        //aa aggiunto campo 29/11/2018
        c.TRACCIATO_TRASCODIFICATO__c= Deact.TRACCIATO_TRASCODIFICATO;
        c.OF_Codice_Operatore_Secondario__c = Deact.CODICE_OPERATORE_SECONDARIO;
        insert c; 
        OF_SA_GE_UtilsNew.caseOriginale=c;
        OF_SA_GE_UtilsNew.checkCaseOriginale=true;
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slToUpsert.add(OF_SA_GE_UtilsNew.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                            'Codice_operatore' => Deact.CODICE_OPERATORE,
                                            'Codice_ordine_OLO' => Deact.CODICE_ORDINE_OLO,
                                            'Flusso' => 'OLO-SF',
                                            'Metodo' => 'OLO_DeactivationRequest',
                                            'ID_notifica' => Deact.ID_NOTIFICA,
                                            'Tipo Comunicazione' => 'OLO->SF - ACK - DeactivationRequest',
                                            'SL Riferimento' => OF_SA_GE_UtilsNew.slOLOSF.Id}));        
        
		OF_SA_GE_UtilsNew.slOLOSF.EOF_Response__c='ACK';	
		OF_SA_GE_UtilsNew.slOLOSF.Caso__c=c.Id;												
		slToUpsert.add(OF_SA_GE_UtilsNew.slOLOSF);
		upsert slToUpsert;
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncDeactivationNew(c.Id,OF_SA_GE_UtilsNew.slOLOSF.Id);
        
	    // 14/02/2018 MM : Aggiorno il timestamp. C.2 corrisponde alla fine check Cessazione.
		OF_SA_GE_UtilsNew.partialTemplog('C.2');
	    // finisce qui
	    
		OF_SA_GE_UtilsNew.EndTemplog();
        
        return resp;    
    }
    //AA 02/10/2018 - Nuovo metodo per la gestione della comunicazione in async per sky fase 3
    public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse SyncChecksStatusUpdateNew(OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur){             
        //Creo il log della request
        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(sur);
        
        // 14/02/2018 MM :Aggiorno il timestamp. CG.1 corrisponde a inizio check generali.
        OF_SA_GE_UtilsNew.partialTemplog('CG.1');
        // finisce qui
        
        if(string.isblank(sur.CODICE_OPERATORE)){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A05','CODICE_OPERATORE');
        }else if(sur.CODICE_OPERATORE.length()>3){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A06','CODICE_OPERATORE');
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
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A06','CODICE_OPERATORE');     
        }
        
        if(string.isblank(sur.CODICE_ORDINE_OLO)){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A05','CODICE_ORDINE_OLO');
        }else if(sur.CODICE_ORDINE_OLO.length()>18){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A06','CODICE_ORDINE_OLO');
        }
        
        //controllo se il case è a sistema
        // 9/01/2018 Marco : modifica alla query per inserire il codice operatore tra le condizioni

        //Modifica aggiunta per gestire servizio DIA
        // EC Commento DIA 2019 04 05   String caseDevName = String.isBlank(sur.TIPOLOGIA_SERVIZIO) ? 'OF_SA_Attivazione' : 'OF_DIA_Attivazione';
        String caseDevName =  'OF_SA_Attivazione';
        List<Case> cList= [SELECT Id,status,Codice_Ordine_EOF__c,Previous_Status__c, OF_Blocked_Case__c, OF_OM_Nuovo_Flusso__c, OF_Response_da_SH__c, OF_Response_Da_OLO__c, 
                                OF_Response_Da_OM__c
                           FROM Case 
                           WHERE EOF_Codice_Ordine_OLO__c=:sur.codice_ordine_olo 
                           AND EOF_Codice_Operatore_WS__c=:sur.CODICE_OPERATORE 
                           AND RecordType.DeveloperName = :caseDevName];
        // Marco : fine modifica
        
        if(cList.isEmpty()){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A06','CODICE_ORDINE_OLO');
        }else{
            OF_SA_GE_UtilsNew.caseOriginale=cList[0];
            OF_SA_GE_UtilsNew.checkCaseOriginale=true;
        }         
        if( 'NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c) || 
            'NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OLO__c) ||
            'NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c))
        {
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A04','');
        }
        if(string.isblank(sur.DATA_NOTIFICA)){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A05','DATA_NOTIFICA');
        }else if(!OF_SA_GE_UtilsNew.checkDateTime(sur.DATA_NOTIFICA)){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A06','DATA_NOTIFICA');
        }        
        if(string.isblank(sur.ID_NOTIFICA)){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A05','ID_NOTIFICA');
        }else if(sur.ID_NOTIFICA.length()>100){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A06','ID_NOTIFICA');
        }else if(sur.ID_NOTIFICA.contains('�')){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'B04','ID_NOTIFICA');
        }
        if(string.isblank(sur.AZIONE)){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A05','AZIONE');
        }else if(sur.AZIONE!='0' && sur.AZIONE!='1'){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A06','AZIONE');
        }
        // 14/02/2018 MM :Aggiorno il timestamp. CG.2 corrisponde a fine check generali.
        OF_SA_GE_UtilsNew.partialTemplog('CG.2');
        // finisce qui
        //AA - Gestione vecchio/nuovo flusso!!
        //TODO AA - CHIEDERE CODICE DI ERRORE
        if(!OF_SA_GE_UtilsNew.caseOriginale.OF_OM_Nuovo_Flusso__c ){
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (sur,'A06','CODICE_ORDINE_OLO');
        }
        if(sur.AZIONE=='1'){
            // 14/02/2018 MM :Aggiorno il timestamp. ANN.1 corrisponde a inizio check per Annullamento.
            OF_SA_GE_UtilsNew.partialTemplog('ANN.1');
            // finisce qui
            
            if(string.isblank(sur.CODICE_MOTIVAZIONE)){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A05','CODICE MOTIVAZIONE');
            }else if(sur.CODICE_MOTIVAZIONE.length()>3){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A06','CODICE MOTIVAZIONE');
            }else if(sur.CODICE_MOTIVAZIONE.contains('�')){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'B04','CODICE MOTIVAZIONE');
            }
            if(string.isblank(sur.MOTIVAZIONE)){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A05','MOTIVAZIONE');
            }else if(sur.MOTIVAZIONE.length()>255){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A06','MOTIVAZIONE');
            }else if(sur.MOTIVAZIONE.contains('�')){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'B04','MOTIVAZIONE');
            }
            if(OF_SA_GE_UtilsNew.caseOriginale.status!='Acquisito' && OF_SA_GE_UtilsNew.caseOriginale.status!='Accettato' && OF_SA_GE_UtilsNew.caseOriginale.status!='Sospeso'){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
            }	        
            // 14/02/2018 : Aggiorno il timestamp. ANN.2 corrisponde alla fine check per Annullamento.
            OF_SA_GE_UtilsNew.partialTemplog('ANN.2');
            // finisce qui	        
        } 
        
        if(sur.AZIONE=='0'){
            // 14/02/2018 MM : Aggiorno il timestamp. D.1 corrisponde a inizio check Desospensione.
            OF_SA_GE_UtilsNew.partialTemplog('D.1');
            // finisce qui
            
            if(OF_SA_GE_UtilsNew.caseOriginale.status != 'Sospeso'){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
            }
            if(!string.isblank(sur.CODICE_MOTIVAZIONE)){ 
                if(sur.CODICE_MOTIVAZIONE.length()>3){
                    insert OF_SA_GE_UtilsNew.slOLOSF;
                    return OF_SA_GE_UtilsNew.syncError (sur,'A06','CODICE MOTIVAZIONE');
                }else if(sur.CODICE_MOTIVAZIONE.contains('�')){
                    insert OF_SA_GE_UtilsNew.slOLOSF;
                    return OF_SA_GE_UtilsNew.syncError (sur,'B04','CODICE MOTIVAZIONE');
                }
            }
            if(!string.isblank(sur.MOTIVAZIONE)){
                if(sur.MOTIVAZIONE.length()>255){
                    insert OF_SA_GE_UtilsNew.slOLOSF;
                    return OF_SA_GE_UtilsNew.syncError (sur,'A06','MOTIVAZIONE');
                }else if(sur.MOTIVAZIONE.contains('�')){
                    insert OF_SA_GE_UtilsNew.slOLOSF;
                    return OF_SA_GE_UtilsNew.syncError (sur,'B04','MOTIVAZIONE');
                }
            }
            if(!string.isblank(sur.NOME_CLIENTE) && sur.NOME_CLIENTE.length()>20){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A06','NOME_CLIENTE');
            }
            if(!string.isblank(sur.COGNOME_CLIENTE) && sur.COGNOME_CLIENTE.length()>70){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A06','COGNOME_CLIENTE');
            }
            if(!string.isblank(sur.RECAPITO_TELEFONICO_CLIENTE_1) && sur.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
            }
            if(!string.isblank(sur.RECAPITO_TELEFONICO_CLIENTE_2) && sur.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A06','RECAPITO_TELEFONICO__2');
            }
            
            if(!string.isblank(sur.DATA_PREVISTA_ATTIVAZIONE)){
                if(!OF_SA_GE_UtilsNew.checkDate(sur.DATA_PREVISTA_ATTIVAZIONE)){
                    insert OF_SA_GE_UtilsNew.slOLOSF;
                    return OF_SA_GE_UtilsNew.syncError (sur,'A06','DATA_PREVISTA_ATTIVAZIONE');
                }

                if(!string.isblank(sur.ORARIO_APPUNTAMENTO)){
                    if(!OF_SA_GE_UtilsNew.checkTime(sur.ORARIO_APPUNTAMENTO)){
                        insert OF_SA_GE_UtilsNew.slOLOSF;
                        return OF_SA_GE_UtilsNew.syncError (sur,'A06','ORARIO_APPUNTAMENTO');
                    }
                    
                } 
                Datetime targetTime = Datetime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(sur.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
                BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
                Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);
                if(!BusinessHours.isWithin(bh.Id, targetTime)){
                    insert OF_SA_GE_UtilsNew.slOLOSF;
                    return OF_SA_GE_UtilsNew.syncError (sur,'A10',null);
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
                    insert OF_SA_GE_UtilsNew.slOLOSF;
                    return OF_SA_GE_UtilsNew.syncError (sur,'A09',null);
                }
            }
            
            // 14/02/2018 MM : Aggiorno il timestamp. D.2 corrisponde a fine check Desospensione.
            OF_SA_GE_UtilsNew.partialTemplog('D.2');
            // finisce qui            
        } 
        // 14/02/2018 MM : Aggiorno il timestamp. SU.1 corrisponde a inizio check Status Update.
        OF_SA_GE_UtilsNew.partialTemplog('SU.1');
        // finisce qui
        
        if(!string.isblank(sur.NOTE)){
            if(sur.NOTE.length()>255){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A06','NOTE');
            }else if(sur.NOTE.contains('�')){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'B04','NOTE');
            }
        } 
        /*AA- Come da notifica di ale, non serve piu' il token id
        Boolean hasIdToken = false;
        //TODO AA 01/10/2018 - Andrò ad aggiungere il check sul campo id_token
        if(sur.TOKEN_ID != null && String.isNotBlank(sur.TOKEN_ID)){
            //Vado a fare i controlli sulla lunghezza e sul formato, dopodichè chiamo il ws di SH
            if(sur.TOKEN_ID.length() > 50){
                insert OF_SA_GE_UtilsNew.slOLOSF;
                return OF_SA_GE_UtilsNew.syncError (sur,'A06','ID_TOKEN'); 
            }else{
                //TODO AA - Chiamo il ws
                List<FakeResFromSH__c> listCustomSett = FakeResFromSH__c.getAll().values();
                String responseFromSH = listCustomSett[0].ResponseType__c;

                if(responseFromSH != null && String.isNotBlank(responseFromSH)){
                    if(responseFromSH.equalsIgnoreCase('ACK')){
                        hasIdToken = true;
                        //Se SH ci risponde che l'id_token è valido, avrò dei campi da salvare (?)
                    }else{//Se SH ci risponde che l'id_token non è valido, è motivo di NACK
                        insert OF_SA_GE_UtilsNew.slOLOSF;
                        return OF_SA_GE_UtilsNew.syncError (sur,'A06','ID_TOKEN'); 
                    }
                }
            }
        }
        */
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        
        //aggiungo codice_ordine_of per creare il service log
        //sur.codice_ordine_of = OF_SA_GE_UtilsNew.caseOriginale.Codice_Ordine_EOF__c;
        if(sur.azione=='0'){
            // 30/01/2018 Marco : modifica 
            if(string.isNotBlank(OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c)){                
                OF_SA_GE_UtilsNew.caseOriginale.Status = OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c;
                OF_SA_GE_UtilsNew.caseOriginale.Previous_Status__c='';                
            }else{                
                CaseHistory ch = [select oldValue from CaseHistory where CaseId=:OF_SA_GE_UtilsNew.caseOriginale.Id and Field='Status' order by createdDate desc limit 1];                
                OF_SA_GE_UtilsNew.caseOriginale.Status= String.valueof(ch.oldValue);                                        
            }
            // 30/01/2018 Marco : fine modifica
            
            // 8/01/2018 Marco : Modifica salvataggio dati per desospensione da OLO
            if(!string.isblank(sur.DATA_PREVISTA_ATTIVAZIONE)){
                OF_SA_GE_UtilsNew.caseOriginale.EOF_Data_Prevista_Attivazione__c= OF_SA_GE_UtilsNew.stringToDateNoTime(sur.DATA_PREVISTA_ATTIVAZIONE);
            }
            if(!string.isblank(sur.ORARIO_APPUNTAMENTO)){
                OF_SA_GE_UtilsNew.caseOriginale.EOF_Orario_Appuntamento__c= sur.ORARIO_APPUNTAMENTO;
            }
            // 8/01/2018 Marco : fine modifica salvataggio dati per desospensione da OLO
        }else{
            OF_SA_GE_UtilsNew.caseOriginale.Status='In Annullamento';
        }
        //Done AA - Aggiungere campo "blockedCase" per gestire le richieste di OM, verrà settato a false una volta ricevuto l'ack da OM
        OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c = true;
        /*
        //Salvo il token id sul case
        if(hasIdToken){
            OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c = sur.TOKEN_ID;
        }*/
        if(!Test.isRunningTest()){
            update OF_SA_GE_UtilsNew.caseOriginale;
        }
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
        responseToOlo.ESITO = '0';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_Response__c='ACK';
        insert OF_SA_GE_UtilsNew.slOLOSF;
        OF_SA_GE_UtilsNew.slOLOSFResp = OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
            'Codice_operatore' => sur.CODICE_OPERATORE,
            'Codice_ordine_OLO' => sur.CODICE_ORDINE_OLO,
            'Flusso' => 'SF-OLO',
            'Metodo' => 'OLO_StatusUpdate',
            'ID_notifica' => sur.ID_NOTIFICA,
            'SL Riferimento' => OF_SA_GE_UtilsNew.slOLOSF.Id,
            'Tipo Comunicazione' => 'OLO->SF - ACK - StatusUpdate'});
        insert OF_SA_GE_UtilsNew.slOLOSFResp;
        
        // 14/02/2018 MM : Aggiorno il timestamp. SU.2 corrisponde alla fine check Status Update.
        OF_SA_GE_UtilsNew.partialTemplog('SU.2');
        // finisce qui
        
        OF_SA_GE_UtilsNew.EndTemplog();
        //Richiamo il metodo async per chiamare OM
        if(!Test.isRunningTest()){
            OF_SA_OLO_AsyncChecksNew.OLO_AsyncStatusUpdateNew(OF_SA_GE_UtilsNew.caseOriginale.Id , OF_SA_GE_UtilsNew.slOLOSF.Id);
        }
        return  responseToOlo;   
    } 
    
    public static OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse SyncChecksRescheduleNew(OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest r){
        
        // 14/02/2018 MM : Aggiorno il timestamp. R.1 corrisponde a inizio check generali per RDAC
        OF_SA_GE_UtilsNew.partialTemplog('R.1');
        // finisce qui
        
        if(string.isblank(r.CODICE_OPERATORE)){
            return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_OPERATORE');
        }
        
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple)
            if(r.CODICE_OPERATORE == s.getLabel())
            olo_found = true;
        
        if(!olo_found)
            return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_OPERATORE');
        
        if(string.isblank(r.CODICE_ORDINE_OLO)){
            return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_ORDINE_OLO');
        } else if(r.CODICE_ORDINE_OLO.length()>18){
            return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_ORDINE_OLO');
        }
        //controllo se il case è a sistema
        // 9/01/2018 Marco : modifica alla query per inserire il codice operatore tra le condizioni
        //Modifica aggiunta per gestire servizio DIA
         // EC Commento DIA 2019 04 05  String caseDevName = String.isBlank(r.TIPOLOGIA_SERVIZIO) ? 'OF_SA_Attivazione' : 'OF_DIA_Attivazione';
        String caseDevName = 'OF_SA_Attivazione' ;
        List<Case> cList= [SELECT Id,status,Codice_Ordine_EOF__c,OF_SA_Id_Servizio__C, OF_Blocked_Case__c, OF_OM_Nuovo_Flusso__c,OF_Response_da_SH__c, OF_Response_Da_OLO__c, 
                                OF_Response_Da_OM__c 
                           FROM Case 
                           WHERE EOF_Codice_Ordine_OLO__c=:r.codice_ordine_olo 
                           AND EOF_Codice_Operatore_WS__c=:r.CODICE_OPERATORE 
                           AND RecordType.DeveloperName = :caseDevName];
        // Marco : fine modifica
        
        if(cList.isEmpty()){
            return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_ORDINE_OLO');
        }else{
            OF_SA_GE_UtilsNew.caseOriginale=cList[0];
            OF_SA_GE_UtilsNew.checkCaseOriginale=true;
        }

        if( 'NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_da_SH__c) || 
            'NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OLO__c) ||
            'NACK TECNICO'.equalsIgnoreCase(OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c))
        {
            insert OF_SA_GE_UtilsNew.slOLOSF;
            return OF_SA_GE_UtilsNew.syncError (r,'A04','');
        }
        if(OF_SA_GE_UtilsNew.caseOriginale.status != 'Acquisito' && OF_SA_GE_UtilsNew.caseOriginale.status != 'Accettato' && OF_SA_GE_UtilsNew.caseOriginale.status != 'Sospeso'){
            return OF_SA_GE_UtilsNew.syncError (r,'A07','STATUS: ' + OF_SA_GE_UtilsNew.caseOriginale.status);
        }     
        //AA - Gestione vecchio/nuovo flusso!!
        if(!OF_SA_GE_UtilsNew.caseOriginale.OF_OM_Nuovo_Flusso__c ){
            return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_ORDINE_OLO');
        }
        //TODO - Probabilmente arriverà una mail in cui verrà cambiato il type
        if(r.CODICE_OPERATORE != null && r.CODICE_OPERATORE == 'SKY'){
            if(String.isBlank(r.IDENTIFICATIVO_PRENOTAZIONE)){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(r);
                return OF_SA_GE_UtilsNew.syncError (r,'A05','IDENTIFICATIVO_PRENOTAZIONE');
            }else if(r.IDENTIFICATIVO_PRENOTAZIONE.length()>50){
                OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(r);
                return OF_SA_GE_UtilsNew.syncError (r,'A06','IDENTIFICATIVO_PRENOTAZIONE');
            }
        }
        if(String.isNotBlank(r.IDENTIFICATIVO_PRENOTAZIONE) && r.IDENTIFICATIVO_PRENOTAZIONE.length()>50){
            OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(r);
            return OF_SA_GE_UtilsNew.syncError (r,'A06','IDENTIFICATIVO_PRENOTAZIONE');        
        }
        if(string.isblank(r.DATA_NOTIFICA)){
            return OF_SA_GE_UtilsNew.syncError (r,'A05','DATA_NOTIFICA');
        }else if(!OF_SA_GE_UtilsNew.checkDateTime(r.DATA_NOTIFICA)){
            return OF_SA_GE_UtilsNew.syncError (r,'A06','DATA_NOTIFICA');
        }        
        if(string.isblank(r.ID_NOTIFICA)){
            return OF_SA_GE_UtilsNew.syncError (r,'A05','ID_NOTIFICA');
        }else if(r.ID_NOTIFICA.length()>100){
            return OF_SA_GE_UtilsNew.syncError (r,'A06','ID_NOTIFICA');
        }else if(r.ID_NOTIFICA.contains('�')){
            return OF_SA_GE_UtilsNew.syncError (r,'B04','ID_NOTIFICA');
        }        
        if(!string.isblank(r.NOME_CLIENTE)){
            if(r.NOME_CLIENTE.length()>20){
                return OF_SA_GE_UtilsNew.syncError (r,'A06','NOME_CLIENTE');
            }else if(r.NOME_CLIENTE.contains('�')){
                return OF_SA_GE_UtilsNew.syncError (r,'B04','NOME_CLIENTE');
            }
        } //Marco : Modifiche ai controlli
        if(!string.isblank(r.COGNOME_CLIENTE)){
            if(r.COGNOME_CLIENTE.length()>70){
                return OF_SA_GE_UtilsNew.syncError (r,'A06','COGNOME_CLIENTE');
            }else if(r.COGNOME_CLIENTE.contains('�')){
                return OF_SA_GE_UtilsNew.syncError (r,'B04','COGNOME_CLIENTE');
            }// Marco : fine modifiche ai controlli 
        } 
        if(!string.isblank(r.RECAPITO_TELEFONICO_CLIENTE_1)){
            if(r.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
                return OF_SA_GE_UtilsNew.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
            }else if(r.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
                return OF_SA_GE_UtilsNew.syncError (r,'B04','RECAPITO_TELEFONICO_CLIENTE_1');
            }
        } 
        if(!string.isblank(r.RECAPITO_TELEFONICO_CLIENTE_2)){
            if(r.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
                return OF_SA_GE_UtilsNew.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
            }else if(r.RECAPITO_TELEFONICO_CLIENTE_2.contains('�')){
                return OF_SA_GE_UtilsNew.syncError (r,'B04','RECAPITO_TELEFONICO_CLIENTE_2');
            }
        } 
        if(string.isblank(r.DATA_PREVISTA_ATTIVAZIONE)){
            return OF_SA_GE_UtilsNew.syncError (r,'A05','DATA_PREVISTA_ATTIVAZIONE');
        }else if(!OF_SA_GE_UtilsNew.checkDate(r.DATA_PREVISTA_ATTIVAZIONE)){
            return OF_SA_GE_UtilsNew.syncError (r,'A06','DATA_PREVISTA_ATTIVAZIONE');
        }
        if(!string.isblank(r.ORARIO_APPUNTAMENTO)){
            if(!OF_SA_GE_UtilsNew.checkTime(r.ORARIO_APPUNTAMENTO)){
                return OF_SA_GE_UtilsNew.syncError (r,'A06','ORARIO_APPUNTAMENTO');
            }            
        }         
        if(string.isblank(r.CODICE_MOTIVAZIONE)){
            return OF_SA_GE_UtilsNew.syncError (r,'A05','CODICE_MOTIVAZIONE');
        }else if(r.CODICE_MOTIVAZIONE.length()>3){
            return OF_SA_GE_UtilsNew.syncError (r,'A06','CODICE_MOTIVAZIONE');
        }else if(r.CODICE_MOTIVAZIONE.contains('�')){
            return OF_SA_GE_UtilsNew.syncError (r,'B04','CODICE_MOTIVAZIONE');
        }        
        if(string.isblank(r.MOTIVAZIONE)){
            return OF_SA_GE_UtilsNew.syncError (r,'A05','MOTIVAZIONE');
        }else if(r.MOTIVAZIONE.length()>255){
            return OF_SA_GE_UtilsNew.syncError (r,'A06','MOTIVAZIONE');
        }else if(r.MOTIVAZIONE.contains('�')){
            return OF_SA_GE_UtilsNew.syncError (r,'B04','MOTIVAZIONE');
        }        
        if(!string.isblank(r.NOTE)){
            if(r.NOTE.length()>255){
                return OF_SA_GE_UtilsNew.syncError (r,'A06','NOTE');
            }else if(r.NOTE.contains('�')){
                return OF_SA_GE_UtilsNew.syncError (r,'B04','NOTE');
            }
        }
        Datetime targetTime = Datetime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
        Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);
        if(!BusinessHours.isWithin(bh.Id, targetTime)){
            return OF_SA_GE_UtilsNew.syncError (r,'A10',null);
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
            return OF_SA_GE_UtilsNew.syncError (r,'A09',null);
        }        
        Boolean hasIdToken = false;
        //TODO AA 01/10/2018 - Andrò ad aggiungere il check sul campo IDENTIFICATIVO_PRENOTAZIONE per renderlo obbligatorio
        if(r.IDENTIFICATIVO_PRENOTAZIONE != null && String.isNotBlank(r.IDENTIFICATIVO_PRENOTAZIONE)){
			// chiamo il ws di SH
			OF_SA_GE_UtilsNew.responseFromSH = OF_SA_GE_UtilsNew.makeCalloutOLOSHConfirmation(r.IDENTIFICATIVO_PRENOTAZIONE, r.CODICE_ORDINE_OLO, r.CODICE_OPERATORE, r.DATA_PREVISTA_ATTIVAZIONE);

			if(OF_SA_GE_UtilsNew.responseFromSH != null){
				if(OF_SA_GE_UtilsNew.responseFromSH.Result.equalsIgnoreCase('OK')){
					hasIdToken = true;    
					//Se SH ci risponde che l'IDENTIFICATIVO_PRENOTAZIONE è valido, avrò dei campi da salvare (?)
				}else{//Se SH ci risponde che l'IDENTIFICATIVO_PRENOTAZIONE non è valido, è motivo di NACK
					//Done AA - Implementare i codici di errore
					OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(r);
					//In caso di errore mi salvo comunque il log della chiamata verso SH
					if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
                        OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
						insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
					}
					return OF_SA_GE_UtilsNew.syncError (r, '*KO_SH*','IDENTIFICATIVO_PRENOTAZIONE'); 
				}
			}
        }
        //END AA 01/10/2018
            
        //scrivo sul case la data di rischedule e la motivazione
        if (!string.isBlank(r.ORARIO_APPUNTAMENTO)){
            Time t = Time.newInstance(Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(3,5)),
                                      Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), t );
        }else{
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_SA_GE_UtilsNew.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
        }
        
        OF_SA_GE_UtilsNew.caseOriginale.EOF_Orario_Appuntamento__c = r.ORARIO_APPUNTAMENTO;
        OF_SA_GE_UtilsNew.caseOriginale.EOF_Pertinenza_RDAC__c = 'OLO';
        OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Codice_Motivazione__c = r.CODICE_MOTIVAZIONE;
        OF_SA_GE_UtilsNew.caseOriginale.OF_SA_Motivazione__c = r.MOTIVAZIONE;
        //Aggiorno i lcampo per bloccare eventuali flussi da OM
        OF_SA_GE_UtilsNew.caseOriginale.OF_Blocked_Case__c = true;
        //Salvo il token id sul case
        //AA - Aggiunto salvataggio token id
        if(hasIdToken){ 
            OF_SA_GE_UtilsNew.caseOriginale.OF_SH_Token_id__c = r.IDENTIFICATIVO_PRENOTAZIONE;
            OF_SA_GE_UtilsNew.caseOriginale.OF_SH_ID_WO__c = OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_ID_WO__c;
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Data_Appuntamento__c = OF_SA_GE_UtilsNew.stringToDateNoTime(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.subString(0, OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('T')));
            OF_SA_GE_UtilsNew.caseOriginale.EOF_Orario_Appuntamento__c = OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.subString(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('T')+1, OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('+'));
            OF_SA_GE_UtilsNew.caseOriginale.OF_SH_DeliveryCompany__c = OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.OF_SH_DeliveryCompany__c;
        }
        if(!Test.isRunningTest()){
            update OF_SA_GE_UtilsNew.caseOriginale;
        }
        //Vado a salvare il sLog di SH
        if(OF_SA_GE_UtilsNew.sLogOFSHReqANDRes != null){
            OF_SA_GE_UtilsNew.sLogOFSHReqANDRes.Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id;
            insert OF_SA_GE_UtilsNew.sLogOFSHReqANDRes;
        }
        //Creo il log per mappare la request
        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(r);
        	OF_SA_GE_UtilsNew.slOLOSF.EOF_Response__c = 'ACK';
        insert OF_SA_GE_UtilsNew.slOLOSF;
        
        OF_SA_GE_UtilsNew.slOLOSFResp = OF_SA_GE_UtilsNew.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
                'Codice_operatore' => r.CODICE_OPERATORE,
                'Codice_ordine_OLO' => r.CODICE_ORDINE_OLO,
                'Flusso' => 'SF-OLO',
                'Metodo' => 'OLO_Reschedule',
                'ID_notifica' => r.ID_NOTIFICA,
            	'SL Riferimento' => OF_SA_GE_UtilsNew.slOLOSF.Id,
                'Tipo Comunicazione' => 'SF->OLO - ACK - Reschedule'});
        insert OF_SA_GE_UtilsNew.slOLOSFResp;
        //FINE AA
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse responseToOlo = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
        	responseToOlo.esito='0';
        
        //12/06/2018 MM : Aggiorno il timestamp. R.2 corrisponde alla fine check reschedule.
        OF_SA_GE_UtilsNew.partialTemplog('R.2');
        // finisce qui
        
        OF_SA_GE_UtilsNew.EndTemplog();        
        if(!Test.isRunningTest()){
            OF_SA_OLO_AsyncChecksNew.OLO_AsyncRescheduleNew(OF_SA_GE_UtilsNew.caseOriginale.Id, OF_SA_GE_UtilsNew.slOLOSF.Id);
        }
        return  responseToOlo;
    }      
}
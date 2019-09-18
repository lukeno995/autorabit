public class OF_GPONP_OLO_EntryChecks {
    public static case c;
    
    //AA 10/10/2018 - Nuovo metodo per esporre l'attivazione a sky
    public static OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksActivationNew(OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP act){
        
        OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse resp = new OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse();
            resp.ID_NOTIFICA = String.valueOf(Datetime.now().getTime());
            resp.ESITO = '0';
        
        OF_GPONP_GE_Utils.OPName = 'Attivazione';
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.1 corrisponde a inizio check acquisizione.
        OF_GPONP_GE_Utils.partialTemplog('ACQ.1');
        // finisce qui
        
        if(String.isBlank(act.CODICE_OPERATORE)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','CODICE_OPERATORE');
        }else if(act.CODICE_OPERATORE.length() > 3){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','CODICE_OPERATORE');
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
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','CODICE_OPERATORE');
        }        
        if(String.isblank(act.CODICE_ORDINE_OLO)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','CODICE_ORDINE_OLO');
        }else if(act.CODICE_ORDINE_OLO.length() > 18){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','CODICE_ORDINE_OLO');
        }else if(act.CODICE_ORDINE_OLO.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'B04','CODICE_ORDINE_OLO');
        }
        List<Case> cList = [SELECT Id,OF_Bonifica_Locked_Row__c FROM Case Where  EOF_Codice_Ordine_OLO__c =: act.CODICE_ORDINE_OLO];
        if(!cList.isEmpty()){
        //if(OF_GPONP_GE_Utils.checkCaseOriginale){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A08','CODICE_ORDINE_OLO');
        }
        if(String.isBlank(act.DATA_NOTIFICA)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','DATA_NOTIFICA');
        }else if(!OF_GPONP_GE_Utils.checkDateTime(act.DATA_NOTIFICA)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','DATA_NOTIFICA');
        }        
        //Se l'OLO è SKY, il token id è obbligatorio
        if(act.CODICE_OPERATORE != null && act.CODICE_OPERATORE == 'SKY'){ 
            if(String.isBlank(act.IDENTIFICATIVO_PRENOTAZIONE)){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A05','IDENTIFICATIVO_PRENOTAZIONE');
            }else if(act.IDENTIFICATIVO_PRENOTAZIONE.length()>50){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','IDENTIFICATIVO_PRENOTAZIONE');
            }
        }else{
            if(String.isNotBlank(act.IDENTIFICATIVO_PRENOTAZIONE) && act.IDENTIFICATIVO_PRENOTAZIONE.length()>50){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','IDENTIFICATIVO_PRENOTAZIONE');
            }
        }
        if(String.isBlank(act.ID_NOTIFICA)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','ID_NOTIFICA');
        }else if(act.ID_NOTIFICA.length() > 100){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','ID_NOTIFICA');
        }else if(act.ID_NOTIFICA.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'B04','ID_NOTIFICA');
        }
        
        resp.ID_NOTIFICA = act.ID_NOTIFICA;
        
        if(String.isBlank(act.NOME_REFERENTE_TECNICO_OLO)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','NOME_REFERENTE_TECNICO_OLO');
        }else if(act.NOME_REFERENTE_TECNICO_OLO.length() > 50){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','NOME_REFERENTE_TECNICO_OLO');
        }else if(act.NOME_REFERENTE_TECNICO_OLO.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'B04','NOME_REFERENTE_TECNICO_OLO');
        }
        if(String.isBlank(act.COGNOME_REFERENTE_TECNICO_OLO)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','COGNOME_REFERENTE_TECNICO_OLO');
        }else if(act.COGNOME_REFERENTE_TECNICO_OLO.length() > 50){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','COGNOME_REFERENTE_TECNICO_OLO');
        }else if(act.COGNOME_REFERENTE_TECNICO_OLO.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'B04','COGNOME_REFERENTE_TECNICO_OLO');
        }
        
        if(String.isBlank(act.TELEFONO_REFERENTE_TECNICO_OLO)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','TELEFONO_REFERENTE_TECNICO_OLO');
        }else if(act.TELEFONO_REFERENTE_TECNICO_OLO.length() > 20){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','TELEFONO_REFERENTE_TECNICO_OLO');
        }else if(act.TELEFONO_REFERENTE_TECNICO_OLO.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'B04','TELEFONO_REFERENTE_TECNICO_OLO');
        }
        
        if(String.isBlank(act.EMAIL_REFERENTE_TECNICO_OLO)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','EMAIL_REFERENTE_TECNICO_OLO');
        }else if(!OF_GPONP_GE_Utils.checkEmail(act.EMAIL_REFERENTE_TECNICO_OLO)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','EMAIL_REFERENTE_TECNICO_OLO');
        }

        if(!String.isBlank(act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH)){
            if(act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH.length()>20){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH');
            }
            if(act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'B04','TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH');
            }
        }
        
        if(!String.isBlank(act.NOME_CLIENTE)){
            if(act.NOME_CLIENTE.length()>20){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','NOME_CLIENTE');
            }
            
            if(act.NOME_CLIENTE.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'B04','NOME_CLIENTE');
            } 
        }
        if(String.isBlank(act.COGNOME_CLIENTE)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','COGNOME_CLIENTE');
        }else if(act.COGNOME_CLIENTE.length() > 70){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','COGNOME_CLIENTE');
        }else if(act.COGNOME_CLIENTE.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'B04','COGNOME_CLIENTE');
        }
        if(String.isBlank(act.RECAPITO_TELEFONICO_CLIENTE_1)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','RECAPITO_TELEFONICO_CLIENTE_1');
        }else if(act.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
        }else if(act.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'B04','RECAPITO_TELEFONICO_CLIENTE_1');
        }

        if(!String.isBlank(act.RECAPITO_TELEFONICO_CLIENTE_2)){
            if(act.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
            }
            if(act.RECAPITO_TELEFONICO_CLIENTE_2.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'B04','RECAPITO_TELEFONICO_CLIENTE_2');
            }
        }       
       if(!String.isBlank(act.INFORMAZIONI_LOGISTICA_APPARATI) && act.INFORMAZIONI_LOGISTICA_APPARATI.length()>100){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act, 'A06','INFORMAZIONI_LOGISTICA_APPARATI');
        }
        if(!String.isBlank(act.INFORMAZIONI_LOGISTICA_APPARATI) && act.INFORMAZIONI_LOGISTICA_APPARATI.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act, 'B04','INFORMAZIONI_LOGISTICA_APPARATI');
        } 
        if(String.isBlank(act.DATA_PREVISTA_ATTIVAZIONE)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','DATA_PREVISTA_ATTIVAZIONE');
        }else if(!OF_GPONP_GE_Utils.checkDate(act.DATA_PREVISTA_ATTIVAZIONE)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','DATA_PREVISTA_ATTIVAZIONE');
        }
        if(!String.isBlank(act.ORARIO_APPUNTAMENTO) && !OF_GPONP_GE_Utils.checkTime(act.ORARIO_APPUNTAMENTO)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','ORARIO_APPUNTAMENTO');
        }
        if(!String.isBlank(act.CODICE_PROGETTO_SPECIALE)){
            if(act.CODICE_PROGETTO_SPECIALE.length()>50){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','CODICE_PROGETTO_SPECIALE');
            }else if(act.CODICE_PROGETTO_SPECIALE.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'B04','CODICE_PROGETTO_SPECIALE');
            }
        }
        if(!String.isBlank(act.PROMOZIONE)){
            if(act.PROMOZIONE.length()>50){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','PROMOZIONE');
            }else if(act.PROMOZIONE.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'B04','PROMOZIONE');
            }
        }
        if(!String.isBlank(act.CLUSTER_PROMOZIONE)){
            if(act.CLUSTER_PROMOZIONE.length() > 50){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','CLUSTER_PROMOZIONE');
            }else if(act.CLUSTER_PROMOZIONE.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'B04','CLUSTER_PROMOZIONE');
            }
        }
        if(!String.isBlank(act.NOTE)){
            if(act.NOTE.length()>255){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','NOTE');
            }
            if(act.NOTE.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'B04','NOTE');
            }
        }
        if(String.isBlank(act.ID_BUILDING)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','ID BUILDING');
        }else if(act.ID_BUILDING.length() > 150){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','ID BUILDING');
        }else if(act.ID_BUILDING.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'B04','ID BUILDING');
        }
        if(!String.isBlank(act.SCALA_PALAZZINA)){
            if(act.SCALA_PALAZZINA.length()>21){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','SCALA_PALAZZINA');
            }
            if(act.SCALA_PALAZZINA.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'B04','SCALA_PALAZZINA');
            }
        }
        if(String.isBlank(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
        }else if(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA.length()>20){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
        }else if(act.NUMERO_TELEFONICO_PRINCIPALE_LINEA.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'B04','NUMERO_TELEFONICO_PRINCIPALE_LINEA');
        }
        if(!String.isBlank(act.RECAPITO_TEST_LINEA)){
            if(act.RECAPITO_TEST_LINEA.length()>20){ 
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','RECAPITO_TEST_LINEA');
            }
            if(act.RECAPITO_TEST_LINEA.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'B04','RECAPITO_TEST_LINEA');
            }
        }
        if(String.isBlank(act.IDENTIFICATIVO_DEL_POP)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A05','IDENTIFICATIVO_DEL_POP');
        }else if(act.IDENTIFICATIVO_DEL_POP.length()>10){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'A06','IDENTIFICATIVO_DEL_POP');
        }else if(act.IDENTIFICATIVO_DEL_POP.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
            return OF_GPONP_GE_Utils.syncError (act,'B04','IDENTIFICATIVO_DEL_POP');
        }
        if(String.isNotBlank(act.GPON_RICHIESTA)){
            if(act.GPON_RICHIESTA.length() > 50){
              OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
              return OF_GPONP_GE_Utils.syncError (act,'A06','GPON_RICHIESTA');
            }else if(String.isNotBlank(act.GPON_RICHIESTA) && act.GPON_RICHIESTA.contains('�')){
              OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
              return OF_GPONP_GE_Utils.syncError (act,'B04','GPON_RICHIESTA');
            }
        }
        if(String.isNotBlank(act.TRACCIATO_TRASCODIFICATO)){
            if(act.TRACCIATO_TRASCODIFICATO.length() > 10 || (act.TRACCIATO_TRASCODIFICATO != 'SI' && act.TRACCIATO_TRASCODIFICATO != 'NO')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','TRACCIATO_TRASCODIFICATO');
            }
        }
        //AA - Nuovo campo CODICE OPERATORE SECONDARIO
        if(String.isNotBlank(act.CODICE_OPERATORE_SECONDARIO)){
            if(act.CODICE_OPERATORE_SECONDARIO.length() > 3){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'A06','CODICE_OPERATORE_SECONDARIO');
            }else if(act.CODICE_OPERATORE_SECONDARIO.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                return OF_GPONP_GE_Utils.syncError (act,'B04','CODICE_OPERATORE_SECONDARIO');
            }
        }
        //check  sugli opzionali
        if(act.SERVIZIO_AGGIUNTIVO != null && !act.SERVIZIO_AGGIUNTIVO.isEmpty()){
            for(OF_GPONP_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO sa : act.SERVIZIO_AGGIUNTIVO){ 
                if(String.isBlank(sa.NOME_SERVIZIO)){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'A05','NOME_SERVIZIO');
                }else if(sa.NOME_SERVIZIO.length()>50){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'A06','NOME_SERVIZIO');
                }else if(!String.isBlank(sa.NOME_SERVIZIO) && sa.NOME_SERVIZIO.contains('�')){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'B04','NOME_SERVIZIO');
                }
                if(String.isBlank(sa.INFORMAZIONI_SERVIZIO)){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'A05','INFORMAZIONI_SERVIZIO');
                }else if(sa.INFORMAZIONI_SERVIZIO.length()>2) {
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'A06','INFORMAZIONI_SERVIZIO'); 
                }else if(!String.isBlank(sa.INFORMAZIONI_SERVIZIO) && sa.INFORMAZIONI_SERVIZIO.contains('�')){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'B04','INFORMAZIONI_SERVIZIO');
                }
            }
        }
        
        if(act.APPARATO != null && !act.APPARATO.isEmpty()){
            for(OF_GPONP_WS_IN_OLO_Activation.APPARATO ap :act.APPARATO){
                if(String.isBlank(ap.TIPOLOGIA_APPARATO)){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'A05','TIPOLOGIA_APPARATO');
                }else if(ap.TIPOLOGIA_APPARATO.length()>100){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'A06','TIPOLOGIA_APPARATO');
                }else if(!String.isBlank(ap.TIPOLOGIA_APPARATO) && ap.TIPOLOGIA_APPARATO.contains('�')){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'B04','TIPOLOGIA_APPARATO');
                }

                if(!String.isBlank(ap.PASSWORD_APPARATO)){
                    if(ap.PASSWORD_APPARATO.length()>50){
                      OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                      return OF_GPONP_GE_Utils.syncError (act,'A06','PASSWORD_APPARATO');
                    }else if(!String.isBlank(ap.PASSWORD_APPARATO) && ap.PASSWORD_APPARATO.contains('�')){
                      OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                      return OF_GPONP_GE_Utils.syncError (act,'B04','PASSWORD_APPARATO');
                    }
                }
              
                if(String.isBlank(ap.AZIONE_APPARATO)){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'A05','AZIONE_APPARATO');
                }else if(ap.AZIONE_APPARATO.length()>1){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'A06','AZIONE_APPARATO'); 
                }else if(!String.isBlank(ap.AZIONE_APPARATO) && ap.AZIONE_APPARATO.contains('�')){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'B04','AZIONE_APPARATO');
                }
                if(!String.isBlank(ap.CAUSALE) && ap.CAUSALE.length()>255){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'A06','CAUSALE');
                }else if(!String.isBlank(ap.CAUSALE) && ap.CAUSALE.contains('�')){
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
                    return OF_GPONP_GE_Utils.syncError (act,'B04','CAUSALE');
                }
            }
        }
        Boolean hasIdToken = false;
        //TODO AA 01/10/2018 - Andrò ad aggiungere il check sul campo IDENTIFICATIVO_PRENOTAZIONE per renderlo obbligatorio
        if(act.IDENTIFICATIVO_PRENOTAZIONE != null && String.isNotBlank(act.IDENTIFICATIVO_PRENOTAZIONE)){
			// chiamo il ws di SH
			OF_GPONP_GE_Utils.responseFromSH = OF_GPONP_GE_Utils.makeCalloutOLOSHConfirmation(act.IDENTIFICATIVO_PRENOTAZIONE, act.CODICE_ORDINE_OLO);
 
			if(OF_GPONP_GE_Utils.responseFromSH != null){
				if(OF_GPONP_GE_Utils.responseFromSH.Result.equalsIgnoreCase('OK')){
					hasIdToken = true;    
					//Se SH ci risponde che l'IDENTIFICATIVO_PRENOTAZIONE è valido, avrò dei campi da salvare (?)
				}else{//Se SH ci risponde che l'IDENTIFICATIVO_PRENOTAZIONE non è valido, è motivo di NACK
					//Done AA - Implementare i codici di errore
					OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
					//In caso di errore mi salvo comunque il log della chiamata verso SH
					if(OF_GPONP_GE_Utils.sLogOFSHReqANDRes != null){
						insert OF_GPONP_GE_Utils.sLogOFSHReqANDRes;
					}
					return OF_GPONP_GE_Utils.syncError (act, '*KO_SH*','IDENTIFICATIVO_PRENOTAZIONE'); 
				}
			}
        }
        //END AA 01/10/2018
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.2 corrisponde alla fine check acquisizione.
        OF_GPONP_GE_Utils.partialTemplog('ACQ.2');
        // finisce qui        
        
        if(!OF_GPONP_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_GE_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_GE_Utils.checkRTMap=true;
        }
        //creo ed inserisco il case
        Case c = new Case(); 
        //AA - Aggiunto salvataggio token id
        if(hasIdToken){ 
            c.OF_SH_Token_id__c = act.IDENTIFICATIVO_PRENOTAZIONE;
            c.OF_SH_ID_WO__c = OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_ID_WO__c;
            c.EOF_Data_Appuntamento__c = OF_GPONP_GE_Utils.stringToDateNoTime(OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.subString(0, OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('T')));
            c.EOF_Orario_Appuntamento__c = OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.subString(OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('T')+1, OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('+'));
            c.OF_SH_DeliveryCompany__c = OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_DeliveryCompany__c;
        }
        //AA - Aggiunto check nuovo/vecchio flusso OM!
        c.OF_OM_Nuovo_Flusso__c = true;
        //Done AA - Modificare recordType
        c.RecordTypeId = OF_GPONP_GE_Utils.rtMap.get('EOF_Caso_Attivazione');
        c.EOF_Codice_Ordine_Olo__c = act.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = act.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = act.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_GPONP_GE_Utils.StringToDate(act.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = act.ID_NOTIFICA;                
        c.EOF_Data_Prevista_Attivazione__c = OF_GPONP_GE_Utils.StringToDateNoTime(act.DATA_PREVISTA_ATTIVAZIONE);
        c.EOF_Identificativo_del_POP__c = act.IDENTIFICATIVO_DEL_POP;
        c.EOF_ID_Building_WS__c = act.ID_BUILDING;
        c.EOF_Scala_Palazzina_WS__c = act.SCALA_PALAZZINA;
        c.subject='Richiesta Attivazione';
        c.status='Inviato';
        c.EOF_FASE__C='NA';
        c.PO_SA_Portale__c = OF_GPONP_GE_Utils.PORTAL;
        //aa aggiunto campo 29/11/2018
        c.TRACCIATO_TRASCODIFICATO__c=act.TRACCIATO_TRASCODIFICATO;
        c.OF_Codice_Operatore_Secondario__c = act.CODICE_OPERATORE_SECONDARIO;
        insert c;
        //Vado a salvare il sLog di SH
        if(OF_GPONP_GE_Utils.sLogOFSHReqANDRes != null){
            OF_GPONP_GE_Utils.sLogOFSHReqANDRes.Caso__c = c.Id;
            insert OF_GPONP_GE_Utils.sLogOFSHReqANDRes;
        }
        //creo il record di generatore ID Servizio che poi mi andrò a querare in asincrono
        /*OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
        g.OF_Case_Id__c=c.Id;
        insert g;*/
        
        OF_GPONP_GE_Utils.caseOriginale=c; 
        OF_GPONP_GE_Utils.checkCaseOriginale=true;
        //Creo il log della request
        OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(act);
        //AA - SAlvo sul log check nuovo/vecchio flusso OM!
        OF_GPONP_GE_Utils.slOLOSF.OF_OM_Nuovo_Flusso__c = c.OF_OM_Nuovo_Flusso__c;
        //creo ed inserisco l'ack ad OLO (OLO->SF - ACK - ActivationRequest) e aggiorno il sl di riferimento con l'ACK
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slToUpsert.add(OF_GPONP_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
            'Codice_operatore' => act.CODICE_OPERATORE,
            'Codice_ordine_OLO' => act.CODICE_ORDINE_OLO,
            'Flusso' => 'SF-OLO',
            'Metodo' => 'OLO_ActivationSetup',
            'ID_notifica' => act.ID_NOTIFICA,
            'Tipo Comunicazione' => 'OLO->SF - ACK - ActivationRequest',
            'SL Riferimento' => OF_GPONP_GE_Utils.slOLOSF.Id}));
        OF_GPONP_GE_Utils.slOLOSF.EOF_Response__c='ACK';	
        OF_GPONP_GE_Utils.slOLOSF.Caso__c=c.Id;															
        slToUpsert.add(OF_GPONP_GE_Utils.slOLOSF);
        upsert slToUpsert;
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,OF_GPONP_GE_Utils.slOLOSF.Id);
        
        OF_GPONP_GE_Utils.EndTemplog();
        
        return  resp; 
    } 
    //AA 11/10/2018 - Nuovo metodo per la gestione della comunicazione in async per sky fase 3
    public static OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksStatusUpdateNew(OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP sur){             
        //Creo il log della request
        OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(sur);
        
        // 14/02/2018 MM :Aggiorno il timestamp. CG.1 corrisponde a inizio check generali.
        OF_GPONP_GE_Utils.partialTemplog('CG.1');
        // finisce qui
        
        if(String.isBlank(sur.CODICE_OPERATORE)){
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A05','CODICE_OPERATORE');
        }else if((sur.CODICE_OPERATORE.length() > 3)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(sur);
            return OF_GPONP_GE_Utils.syncError (sur,'A06','CODICE_OPERATORE');
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
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A06','CODICE_OPERATORE');     
        }
        
        if(String.isblank(sur.CODICE_ORDINE_OLO)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(sur);
            return OF_GPONP_GE_Utils.syncError (sur,'A05','CODICE_ORDINE_OLO');
        }else if(sur.CODICE_ORDINE_OLO.length() > 18){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(sur);
            return OF_GPONP_GE_Utils.syncError (sur,'A06','CODICE_ORDINE_OLO');
        }else if(sur.CODICE_ORDINE_OLO.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(sur);
            return OF_GPONP_GE_Utils.syncError (sur,'B04','CODICE_ORDINE_OLO');
        }
        
        //controllo se il case è a sistema
        // 9/01/2018 Marco : modifica alla query per inserire il codice operatore tra le condizioni
        //Done AA - Modificare recordtype
        List<Case> cList = [SELECT Id, Status, Codice_Ordine_EOF__c, Previous_Status__c, OF_Blocked_Case__c, OF_OM_Nuovo_Flusso__c , OF_Response_da_SH__c, 
                                    OF_Response_Da_OLO__c, OF_Response_Da_OM__c
                            FROM Case 
                            WHERE EOF_Codice_Ordine_OLO__c = :sur.codice_ordine_olo 
                            AND EOF_Codice_Operatore_WS__c = :sur.CODICE_OPERATORE 
                            AND RecordType.DeveloperName = 'EOF_Caso_Attivazione'];
        // Marco : fine modifica
        
        if(cList.isEmpty()){
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A06','CODICE_ORDINE_OLO');
        }else{
            OF_GPONP_GE_Utils.caseOriginale = cList[0];
            OF_GPONP_GE_Utils.checkCaseOriginale = true;
        }         
        if( 'NACK TECNICO'.equalsIgnoreCase(OF_GPONP_GE_Utils.caseOriginale.OF_Response_da_SH__c) || 
            'NACK TECNICO'.equalsIgnoreCase(OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OLO__c) ||
            'NACK TECNICO'.equalsIgnoreCase(OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c))
        {
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A04','');
        }
        if(String.isBlank(sur.DATA_NOTIFICA)){
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A05','DATA_NOTIFICA');
        }else if(!OF_GPONP_GE_Utils.checkDateTime(sur.DATA_NOTIFICA)){
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A06','DATA_NOTIFICA');
        }        
        if(String.isBlank(sur.ID_NOTIFICA)){
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A05','ID_NOTIFICA');
        }else if(sur.ID_NOTIFICA.length() > 100){
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A06','ID_NOTIFICA');
        }else if(sur.ID_NOTIFICA.contains('�')){
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'B04','ID_NOTIFICA');
        }
        if(String.isBlank(sur.AZIONE)){
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A05','AZIONE');
        }else if(sur.AZIONE != '0' && sur.AZIONE != '1'){
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A06','AZIONE');
        }
        // 14/02/2018 MM :Aggiorno il timestamp. CG.2 corrisponde a fine check generali.
        OF_GPONP_GE_Utils.partialTemplog('CG.2');
        // finisce qui
        //AA - Gestione vecchio/nuovo flusso!!
        //TODO AA - CHIEDERE CODICE DI ERRORE
        if(!OF_GPONP_GE_Utils.caseOriginale.OF_OM_Nuovo_Flusso__c ){
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (sur,'A06','CODICE_ORDINE_OLO');
        }
        if(sur.AZIONE == '1'){
            // 14/02/2018 MM :Aggiorno il timestamp. ANN.1 corrisponde a inizio check per Annullamento.
            OF_GPONP_GE_Utils.partialTemplog('ANN.1');
            // finisce qui
            
            if(String.isBlank(sur.CODICE_MOTIVAZIONE)){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A05','CODICE MOTIVAZIONE');
            }else if(sur.CODICE_MOTIVAZIONE.length() > 3){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A06','CODICE MOTIVAZIONE');
            }else if(sur.CODICE_MOTIVAZIONE.contains('�')){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'B04','CODICE MOTIVAZIONE');
            }
            if(String.isBlank(sur.MOTIVAZIONE)){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A05','MOTIVAZIONE');
            }else if(sur.MOTIVAZIONE.length() > 255){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A06','MOTIVAZIONE');
            }else if(sur.MOTIVAZIONE.contains('�')){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'B04','MOTIVAZIONE');
            }
            if(OF_GPONP_GE_Utils.caseOriginale.Status != 'Acquisito' && OF_GPONP_GE_Utils.caseOriginale.Status != 'Accettato' && OF_GPONP_GE_Utils.caseOriginale.Status != 'Sospeso'){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A07','STATUS: ' + OF_GPONP_GE_Utils.caseOriginale.Status);
            }	        
            // 14/02/2018 : Aggiorno il timestamp. ANN.2 corrisponde alla fine check per Annullamento.
            OF_GPONP_GE_Utils.partialTemplog('ANN.2');
            // finisce qui	        
        } 
        
        if(sur.AZIONE=='0'){
            // 14/02/2018 MM : Aggiorno il timestamp. D.1 corrisponde a inizio check Desospensione.
            OF_GPONP_GE_Utils.partialTemplog('D.1');
            // finisce qui
            
            if(OF_GPONP_GE_Utils.caseOriginale.Status != 'Sospeso'){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A07','STATUS: ' + OF_GPONP_GE_Utils.caseOriginale.Status);
            }
            if(!String.isBlank(sur.CODICE_MOTIVAZIONE)){ 
                if(sur.CODICE_MOTIVAZIONE.length() > 3){
                    insert OF_GPONP_GE_Utils.slOLOSF;
                    return OF_GPONP_GE_Utils.syncError (sur,'A06','CODICE MOTIVAZIONE');
                }else if(sur.CODICE_MOTIVAZIONE.contains('�')){
                    insert OF_GPONP_GE_Utils.slOLOSF;
                    return OF_GPONP_GE_Utils.syncError (sur,'B04','CODICE MOTIVAZIONE');
                }
            }
            
            if(!String.isBlank(sur.MOTIVAZIONE)){
                if(sur.MOTIVAZIONE.length() > 255){
                    insert OF_GPONP_GE_Utils.slOLOSF;
                    return OF_GPONP_GE_Utils.syncError (sur,'A06','MOTIVAZIONE');
                }else if(sur.MOTIVAZIONE.contains('�')){
                    insert OF_GPONP_GE_Utils.slOLOSF;
                    return OF_GPONP_GE_Utils.syncError (sur,'B04','MOTIVAZIONE');
                }
                
            }
            if(!String.isBlank(sur.NOME_CLIENTE) && sur.NOME_CLIENTE.length() > 20){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A06','NOME_CLIENTE');
            }else if(!String.isBlank(sur.COGNOME_CLIENTE) && sur.COGNOME_CLIENTE.length()>70){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A06','COGNOME_CLIENTE');
            }
            if(!String.isBlank(sur.RECAPITO_TELEFONICO_CLIENTE_1) && sur.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
            }else if(!String.isBlank(sur.RECAPITO_TELEFONICO_CLIENTE_2) && sur.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A06','RECAPITO_TELEFONICO__2');
            }
            
            if(!String.isBlank(sur.DATA_PREVISTA_ATTIVAZIONE)){
                if(!OF_GPONP_GE_Utils.checkDate(sur.DATA_PREVISTA_ATTIVAZIONE)){
                    insert OF_GPONP_GE_Utils.slOLOSF;
                    return OF_GPONP_GE_Utils.syncError (sur,'A06','DATA_PREVISTA_ATTIVAZIONE');
                }else if(!String.isBlank(sur.ORARIO_APPUNTAMENTO)){
                    if(!OF_GPONP_GE_Utils.checkTime(sur.ORARIO_APPUNTAMENTO)){
                        insert OF_GPONP_GE_Utils.slOLOSF;
                        return OF_GPONP_GE_Utils.syncError (sur,'A06','ORARIO_APPUNTAMENTO');
                    }
                    
                } 
                Datetime targetTime = Datetime.newInstance(OF_GPONP_GE_Utils.StringToDateNoTime(sur.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
                BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
                Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);
                if(!BusinessHours.isWithin(bh.Id, targetTime)){
                    insert OF_GPONP_GE_Utils.slOLOSF;
                    return OF_GPONP_GE_Utils.syncError (sur,'A10',null);
                }
                //controllo SLA
                BusinessHours bh_dac = [SELECT Id 
                                        FROM BusinessHours 
                                        WHERE Name='DAC'];
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
                    insert OF_GPONP_GE_Utils.slOLOSF;
                    return OF_GPONP_GE_Utils.syncError (sur,'A09',null);
                }
            }
            
            // 14/02/2018 MM : Aggiorno il timestamp. D.2 corrisponde a fine check Desospensione.
            OF_GPONP_GE_Utils.partialTemplog('D.2');
            // finisce qui            
        } 
        // 14/02/2018 MM : Aggiorno il timestamp. SU.1 corrisponde a inizio check Status Update.
        OF_GPONP_GE_Utils.partialTemplog('SU.1');
        // finisce qui
        
        if(!String.isBlank(sur.NOTE)){
            if(sur.NOTE.length() > 255){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'A06','NOTE');
            }else if(sur.NOTE.contains('�')){
                insert OF_GPONP_GE_Utils.slOLOSF;
                return OF_GPONP_GE_Utils.syncError (sur,'B04','NOTE');
            }
        } 
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        
        if(sur.azione == '0'){
            // 30/01/2018 Marco : modifica 
            if(String.isNotBlank(OF_GPONP_GE_Utils.caseOriginale.Previous_Status__c)){                
                OF_GPONP_GE_Utils.caseOriginale.Status = OF_GPONP_GE_Utils.caseOriginale.Previous_Status__c;
                OF_GPONP_GE_Utils.caseOriginale.Previous_Status__c='';                
            }else{                
                CaseHistory ch = [SELECT oldValue 
                                  FROM CaseHistory 
                                  WHERE CaseId = :OF_GPONP_GE_Utils.caseOriginale.Id 
                                  AND Field='Status' 
                                  ORDER BY createdDate DESC
                                  LIMIT 1];                
                OF_GPONP_GE_Utils.caseOriginale.Status= String.valueof(ch.oldValue);                                        
            }
            // 30/01/2018 Marco : fine modifica
            
            // 8/01/2018 Marco : Modifica salvataggio dati per desospensione da OLO
            if(!String.isBlank(sur.DATA_PREVISTA_ATTIVAZIONE)){
                OF_GPONP_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c = OF_GPONP_GE_Utils.stringToDateNoTime(sur.DATA_PREVISTA_ATTIVAZIONE);
            }
            if(!String.isBlank(sur.ORARIO_APPUNTAMENTO)){
                OF_GPONP_GE_Utils.caseOriginale.EOF_Orario_Appuntamento__c = sur.ORARIO_APPUNTAMENTO;
            }
            // 8/01/2018 Marco : fine modifica salvataggio dati per desospensione da OLO
        }else{
            OF_GPONP_GE_Utils.caseOriginale.Status = 'In Annullamento';
        }
        //Done AA - Aggiungere campo "blockedCase" per gestire le richieste di OM, verrà settato a false una volta ricevuto l'ack da OM
        OF_GPONP_GE_Utils.caseOriginale.OF_Blocked_Case__c = true;

        update OF_GPONP_GE_Utils.caseOriginale;
        
        OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOlo = new OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse();
       		responseToOlo.ESITO = '0';
        OF_GPONP_GE_Utils.slOLOSF.EOF_Response__c='ACK';
        insert OF_GPONP_GE_Utils.slOLOSF;
        OF_GPONP_GE_Utils.slOLOSFResp = OF_GPONP_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
            'Codice_operatore' => sur.CODICE_OPERATORE,
            'Codice_ordine_OLO' => sur.CODICE_ORDINE_OLO,
            'Flusso' => 'SF-OLO',
            'Metodo' => 'OLO_StatusUpdate',
            'ID_notifica' => sur.ID_NOTIFICA,
            'SL Riferimento' => OF_GPONP_GE_Utils.slOLOSF.Id,
            'Tipo Comunicazione' => 'OLO->SF - ACK - StatusUpdate'});
        insert OF_GPONP_GE_Utils.slOLOSFResp;
        
        // 14/02/2018 MM : Aggiorno il timestamp. SU.2 corrisponde alla fine check Status Update.
        OF_GPONP_GE_Utils.partialTemplog('SU.2');
        // finisce qui        
        OF_GPONP_GE_Utils.EndTemplog();
        //Richiamo il metodo async per chiamare OM
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(OF_GPONP_GE_Utils.caseOriginale.Id , OF_GPONP_GE_Utils.slOLOSF.Id);
        return  responseToOlo;   
    } 
	//AA 11/10/2018 - Gestione REDAC da OLO
    public static OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksRescheduleNew(OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP r){        
        // 14/02/2018 MM : Aggiorno il timestamp. R.1 corrisponde a inizio check generali per RDAC
        OF_GPONP_GE_Utils.partialTemplog('R.1');
        // finisce qui
        
        if(String.isBlank(r.CODICE_OPERATORE)){
            return OF_GPONP_GE_Utils.syncError (r,'A05','CODICE_OPERATORE');
        }else if(r.CODICE_OPERATORE.length() > 3){
            return OF_GPONP_GE_Utils.syncError (r,'A06','CODICE_OPERATORE');
        }
        
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple)
            if(r.CODICE_OPERATORE == s.getLabel())
            olo_found = true;
        
        if(!olo_found)
            return OF_GPONP_GE_Utils.syncError (r,'A06','CODICE_OPERATORE');
        
        
        if(String.isblank(r.CODICE_ORDINE_OLO)){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(r);
            return OF_GPONP_GE_Utils.syncError (r,'A05','CODICE_ORDINE_OLO');
        }else if(r.CODICE_ORDINE_OLO.length() > 18){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(r);
            return OF_GPONP_GE_Utils.syncError (r,'A06','CODICE_ORDINE_OLO');
        }else if(r.CODICE_ORDINE_OLO.contains('�')){
            OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(r);
            return OF_GPONP_GE_Utils.syncError (r,'B04','CODICE_ORDINE_OLO');
        }
        //controllo se il case è a sistema
        // 9/01/2018 Marco : modifica alla query per inserire il codice operatore tra le condizioni
        //Done AA - Modificare recordtype
        List<Case> cList = [SELECT Id, Status, Codice_Ordine_EOF__c, OF_SA_Id_Servizio__C, OF_Blocked_Case__c, OF_OM_Nuovo_Flusso__c, OF_Response_da_SH__c,
                                OF_Response_Da_OLO__c, OF_Response_Da_OM__c 
                            FROM Case 
                            WHERE EOF_Codice_Ordine_OLO__c = :r.codice_ordine_olo 
                            AND EOF_Codice_Operatore_WS__c=:r.CODICE_OPERATORE 
                            AND RecordType.DeveloperName = 'EOF_Caso_Attivazione'];
        // Marco : fine modifica        
        if(cList.isEmpty()){
            return OF_GPONP_GE_Utils.syncError (r,'A06','CODICE_ORDINE_OLO');
        }else{
            OF_GPONP_GE_Utils.caseOriginale = cList[0];
            OF_GPONP_GE_Utils.checkCaseOriginale = true;
        }        
        if( 'NACK TECNICO'.equalsIgnoreCase(OF_GPONP_GE_Utils.caseOriginale.OF_Response_da_SH__c) || 
            'NACK TECNICO'.equalsIgnoreCase(OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OLO__c) ||
            'NACK TECNICO'.equalsIgnoreCase(OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c))
        {
            insert OF_GPONP_GE_Utils.slOLOSF;
            return OF_GPONP_GE_Utils.syncError (r,'A04','');
        }
        if(OF_GPONP_GE_Utils.caseOriginale.Status != 'Acquisito' && OF_GPONP_GE_Utils.caseOriginale.Status != 'Accettato' && OF_GPONP_GE_Utils.caseOriginale.Status != 'Sospeso'){
            return OF_GPONP_GE_Utils.syncError (r,'A07','STATUS: ' + OF_GPONP_GE_Utils.caseOriginale.Status);
        }     
        //AA - Gestione vecchio/nuovo flusso!!
        if(!OF_GPONP_GE_Utils.caseOriginale.OF_OM_Nuovo_Flusso__c ){
            return OF_GPONP_GE_Utils.syncError (r,'A06','CODICE_ORDINE_OLO');
        }
        if(String.isBlank(r.DATA_NOTIFICA)){
            return OF_GPONP_GE_Utils.syncError (r,'A05','DATA_NOTIFICA');
        }else if(!OF_GPONP_GE_Utils.checkDateTime(r.DATA_NOTIFICA)){
            return OF_GPONP_GE_Utils.syncError (r,'A06','DATA_NOTIFICA');
        }        
        if(String.isBlank(r.ID_NOTIFICA)){
            return OF_GPONP_GE_Utils.syncError (r,'A05','ID_NOTIFICA');
        }else if(r.ID_NOTIFICA.length() > 100){
            return OF_GPONP_GE_Utils.syncError (r,'A06','ID_NOTIFICA');
        }else if(r.ID_NOTIFICA.contains('�')){
            return OF_GPONP_GE_Utils.syncError (r,'B04','ID_NOTIFICA');
        }   
        
        if(r.CODICE_OPERATORE != null && r.CODICE_OPERATORE == 'SKY'){
            if(String.isBlank(r.IDENTIFICATIVO_PRENOTAZIONE)){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(r);
                return OF_GPONP_GE_Utils.syncError (r,'A05','IDENTIFICATIVO_PRENOTAZIONE');
            }else if(r.IDENTIFICATIVO_PRENOTAZIONE.length()>50){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(r);
                return OF_GPONP_GE_Utils.syncError (r,'A06','IDENTIFICATIVO_PRENOTAZIONE');
            }
        }else{
            if(String.isNotBlank(r.IDENTIFICATIVO_PRENOTAZIONE) && r.IDENTIFICATIVO_PRENOTAZIONE.length()>50){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(r);
                return OF_GPONP_GE_Utils.syncError (r,'A06','IDENTIFICATIVO_PRENOTAZIONE');
            }
        }   
        if(!String.isBlank(r.NOME_CLIENTE)){
            if(r.NOME_CLIENTE.length() > 20){
                return OF_GPONP_GE_Utils.syncError (r,'A06','NOME_CLIENTE');
            }else if(r.NOME_CLIENTE.contains('�')){
                return OF_GPONP_GE_Utils.syncError (r,'B04','NOME_CLIENTE');
            }
        } //Marco : Modifiche ai controlli
        if(!String.isBlank(r.COGNOME_CLIENTE)){
            if(r.COGNOME_CLIENTE.length() > 70){
                return OF_GPONP_GE_Utils.syncError (r,'A06','COGNOME_CLIENTE');
            }else if(r.COGNOME_CLIENTE.contains('�')){
                return OF_GPONP_GE_Utils.syncError (r,'B04','COGNOME_CLIENTE');
            }// Marco : fine modifiche ai controlli 
        } 
        if(!String.isBlank(r.RECAPITO_TELEFONICO_CLIENTE_1)){
            if(r.RECAPITO_TELEFONICO_CLIENTE_1.length() > 20){
                return OF_GPONP_GE_Utils.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
            }else if(r.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
                return OF_GPONP_GE_Utils.syncError (r,'B04','RECAPITO_TELEFONICO_CLIENTE_1');
            }
        } 
        if(!String.isBlank(r.RECAPITO_TELEFONICO_CLIENTE_2)){
            if(r.RECAPITO_TELEFONICO_CLIENTE_2.length() > 20){
                return OF_GPONP_GE_Utils.syncError (r,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
            }else if(r.RECAPITO_TELEFONICO_CLIENTE_2.contains('�')){
                return OF_GPONP_GE_Utils.syncError (r,'B04','RECAPITO_TELEFONICO_CLIENTE_2');
            }
        } 
        if(String.isBlank(r.DATA_PREVISTA_ATTIVAZIONE)){
            return OF_GPONP_GE_Utils.syncError (r,'A05','DATA_PREVISTA_ATTIVAZIONE');
        } else if(!OF_GPONP_GE_Utils.checkDate(r.DATA_PREVISTA_ATTIVAZIONE)){
            return OF_GPONP_GE_Utils.syncError (r,'A06','DATA_PREVISTA_ATTIVAZIONE');
        }
        if(!String.isBlank(r.ORARIO_APPUNTAMENTO)){
            if(!OF_GPONP_GE_Utils.checkTime(r.ORARIO_APPUNTAMENTO)){
                return OF_GPONP_GE_Utils.syncError (r,'A06','ORARIO_APPUNTAMENTO');
            }            
        }         
        if(String.isBlank(r.CODICE_MOTIVAZIONE)){
            return OF_GPONP_GE_Utils.syncError (r,'A05','CODICE_MOTIVAZIONE');
        }else if(r.CODICE_MOTIVAZIONE.length()>3){
            return OF_GPONP_GE_Utils.syncError (r,'A06','CODICE_MOTIVAZIONE');
        }else if(r.CODICE_MOTIVAZIONE.contains('�')){
            return OF_GPONP_GE_Utils.syncError (r,'B04','CODICE_MOTIVAZIONE');
        }        
        if(String.isBlank(r.MOTIVAZIONE)){
            return OF_GPONP_GE_Utils.syncError (r,'A05','MOTIVAZIONE');
        }else if(r.MOTIVAZIONE.length()>255){
            return OF_GPONP_GE_Utils.syncError (r,'A06','MOTIVAZIONE');
        }else if(r.MOTIVAZIONE.contains('�')){
            return OF_GPONP_GE_Utils.syncError (r,'B04','MOTIVAZIONE');
        }        
        if(!String.isBlank(r.NOTE)){
            if(r.NOTE.length()>255){
                return OF_GPONP_GE_Utils.syncError (r,'A06','NOTE');
            }
            if(r.NOTE.contains('�')){
                return OF_GPONP_GE_Utils.syncError (r,'B04','NOTE');
            }
        }
        Datetime targetTime = Datetime.newInstance(OF_GPONP_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
        BusinessHours bh = [SELECT Id 
                            FROM BusinessHours 
                            WHERE IsDefault = true];
        Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);
        if(!BusinessHours.isWithin(bh.Id, targetTime)){
            return OF_GPONP_GE_Utils.syncError (r,'A10',null);
        }
        //controllo SLA
        BusinessHours bh_dac = [SELECT Id 
                                FROM BusinessHours 
                                WHERE Name='DAC'];
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
            return OF_GPONP_GE_Utils.syncError (r,'A09',null);
        }        
        Boolean hasIdToken = false;
        //TODO AA 01/10/2018 - Andrò ad aggiungere il check sul campo id_token
        if(r.IDENTIFICATIVO_PRENOTAZIONE != null && String.isNotBlank(r.IDENTIFICATIVO_PRENOTAZIONE)){
            // chiamo il ws di SH
            OF_GPONP_GE_Utils.responseFromSH = OF_GPONP_GE_Utils.makeCalloutOLOSHConfirmation(r.IDENTIFICATIVO_PRENOTAZIONE, r.CODICE_ORDINE_OLO);
 
            if(OF_GPONP_GE_Utils.responseFromSH != null){
                if(OF_GPONP_GE_Utils.responseFromSH.Result.equalsIgnoreCase('OK')){
                    hasIdToken = true;    
                    //Se SH ci risponde che l'IDENTIFICATIVO_PRENOTAZIONE è valido, avrò dei campi da salvare (?)
                }else{//Se SH ci risponde che l'IDENTIFICATIVO_PRENOTAZIONE non è valido, è motivo di NACK
                    //Done AA - Implementare i codici di errore
                    OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(r);
                    //In caso di errore mi salvo comunque il log della chiamata verso SH
                    if(OF_GPONP_GE_Utils.sLogOFSHReqANDRes != null){
                        OF_GPONP_GE_Utils.sLogOFSHReqANDRes.Caso__c = OF_GPONP_GE_Utils.caseOriginale.Id;
                        insert OF_GPONP_GE_Utils.sLogOFSHReqANDRes;
                    }
                    return OF_GPONP_GE_Utils.syncError (r, '*KO_SH*','IDENTIFICATIVO_PRENOTAZIONE'); 
                }
            }
        } 
        //AA 03/10/2018 - Modifica sky 3
        
        //scrivo sul case la data di rischedule e la motivazione
        if (!string.isBlank(r.ORARIO_APPUNTAMENTO)){
            Time t = Time.newInstance(Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(0,2)), Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(3,5)),
                                      Integer.valueOf(r.ORARIO_APPUNTAMENTO.substring(6,8)), 0);                            
            OF_GPONP_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_GPONP_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), t );
        }else{
            OF_GPONP_GE_Utils.caseOriginale.EOF_Nuova_DAC__c = DateTime.newInstance(OF_GPONP_GE_Utils.StringToDateNoTime(r.DATA_PREVISTA_ATTIVAZIONE), Time.newInstance(0, 0, 0, 0));
        }
        
        OF_GPONP_GE_Utils.caseOriginale.EOF_Orario_Appuntamento__c = r.ORARIO_APPUNTAMENTO;
        OF_GPONP_GE_Utils.caseOriginale.EOF_Pertinenza_RDAC__c = 'OLO';
        OF_GPONP_GE_Utils.caseOriginale.OF_SA_Codice_Motivazione__c = r.CODICE_MOTIVAZIONE;
        OF_GPONP_GE_Utils.caseOriginale.OF_SA_Motivazione__c = r.MOTIVAZIONE;
        //Aggiorno i lcampo per bloccare eventuali flussi da OM
        OF_GPONP_GE_Utils.caseOriginale.OF_Blocked_Case__c = true;
        //Salvo il token id sul case
        if(hasIdToken){
            OF_GPONP_GE_Utils.caseOriginale.OF_SH_Token_id__c = r.IDENTIFICATIVO_PRENOTAZIONE;
            OF_GPONP_GE_Utils.caseOriginale.OF_SH_ID_WO__c = OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_ID_WO__c;
            OF_GPONP_GE_Utils.caseOriginale.EOF_Data_Appuntamento__c = OF_GPONP_GE_Utils.stringToDateNoTime(OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.subString(0, OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('T')));
            OF_GPONP_GE_Utils.caseOriginale.EOF_Orario_Appuntamento__c = OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.subString(OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('T')+1, OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_AppointmentDate__c.indexOf('+'));
            OF_GPONP_GE_Utils.caseOriginale.OF_SH_DeliveryCompany__c = OF_GPONP_GE_Utils.sLogOFSHReqANDRes.OF_SH_DeliveryCompany__c;    
        }
        //Vado a salvare il sLog di SH
        if(OF_GPONP_GE_Utils.sLogOFSHReqANDRes != null){
            OF_GPONP_GE_Utils.sLogOFSHReqANDRes.Caso__c = OF_GPONP_GE_Utils.caseOriginale.Id;
            insert OF_GPONP_GE_Utils.sLogOFSHReqANDRes;
        }
        update OF_GPONP_GE_Utils.caseOriginale;
        //Creo il log per mappare la request
        OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(r);
        OF_GPONP_GE_Utils.slOLOSF.EOF_Response__c = 'ACK';
        insert OF_GPONP_GE_Utils.slOLOSF;
        
        OF_GPONP_GE_Utils.slOLOSFResp = OF_GPONP_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
            'Codice_operatore' => r.CODICE_OPERATORE,
            'Codice_ordine_OLO' => r.CODICE_ORDINE_OLO,
            'Flusso' => 'SF-OLO',
            'Metodo' => 'OLO_Reschedule',
            'ID_notifica' => r.ID_NOTIFICA,
            'SL Riferimento' => OF_GPONP_GE_Utils.slOLOSF.Id,
            'Tipo Comunicazione' => 'SF->OLO - ACK - Reschedule'});
        insert OF_GPONP_GE_Utils.slOLOSFResp;
        //FINE AA
        OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOlo = new OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse();
        responseToOlo.esito='0';
        
        //12/06/2018 MM : Aggiorno il timestamp. R.2 corrisponde alla fine check reschedule.
        OF_GPONP_GE_Utils.partialTemplog('R.2');
        // finisce qui
        
        OF_GPONP_GE_Utils.EndTemplog();        
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncRescheduleNew(OF_GPONP_GE_Utils.caseOriginale.Id, OF_GPONP_GE_Utils.slOLOSF.Id);
        return  responseToOlo;
    } 
    //AA 24/10/18 - Gestione Deactivation da OLO
    public static OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksDeactivationNew(OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deact){
        
        //creo il log della fiberrequest
        OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(deact);

	    // 14/02/2018 MM : Aggiorno il timestamp. C.1 corrisponde alla fine check Cessazione.
		OF_GPONP_GE_Utils.partialTemplog('C.1');
	    // finisce qui
        
        OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse resp = new OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse();
        resp.esito='0'; 

        if(string.isblank(deact.CODICE_OPERATORE)){
            return OF_GPONP_GE_Utils.syncError (deact,'A05','CODICE_OPERATORE');
        }else if(deact.CODICE_OPERATORE.length()>18){
                return OF_GPONP_GE_Utils.syncError (deact,'A06','CODICE_OPERATORE');
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
             return OF_GPONP_GE_Utils.syncError (deact,'A06','CODICE_OPERATORE');
        }
        if(string.isblank(deact.CODICE_ORDINE_OLO)){
                return OF_GPONP_GE_Utils.syncError (deact,'A05','CODICE_ORDINE_OLO');
        } else if(deact.CODICE_ORDINE_OLO.length()>18){
                return OF_GPONP_GE_Utils.syncError (deact,'A06','CODICE_ORDINE_OLO');
        } else if(deact.CODICE_ORDINE_OLO.contains('�')){
                return OF_GPONP_GE_Utils.syncError (deact,'B04','CODICE_ORDINE_OLO');
            }
        if(OF_GPONP_GE_Utils.checkCaseOriginale){
            return OF_GPONP_GE_Utils.syncError (Deact,'A08','CODICE_ORDINE_OLO');
        }
        
        if(string.isblank(deact.DATA_NOTIFICA)){
            return OF_GPONP_GE_Utils.syncError (deact,'A05','DATA_NOTIFICA');
        }else if(!OF_GPONP_GE_Utils.checkDateTime(deact.DATA_NOTIFICA)){
        	return OF_GPONP_GE_Utils.syncError (deact,'A06','DATA_NOTIFICA');
        }    
                
        if(string.isblank(deact.ID_NOTIFICA)){
            return OF_GPONP_GE_Utils.syncError (deact,'A05','ID_NOTIFICA');
        }else if(deact.ID_NOTIFICA.length()>100){
            return OF_GPONP_GE_Utils.syncError (deact,'A06','ID_NOTIFICA');
        }else if(deact.ID_NOTIFICA.contains('�')){
            return OF_GPONP_GE_Utils.syncError (deact,'B04','ID_NOTIFICA');
        }

        if(string.isblank(deact.ID_RISORSA)){
            return OF_GPONP_GE_Utils.syncError (deact,'A05','ID_RISORSA');
        }else if(deact.ID_RISORSA.length()>50){
            return OF_GPONP_GE_Utils.syncError (deact,'A06','ID_RISORSA');
        }else if(deact.ID_RISORSA.contains('�')){
            return OF_GPONP_GE_Utils.syncError (deact,'B04','ID_RISORSA');
        }
        
        if(!string.isblank(deact.NOME_CLIENTE)){
        	if(deact.NOME_CLIENTE.length()>20){
            	return OF_GPONP_GE_Utils.syncError (deact,'A06','NOME_CLIENTE');
        	}
        	if(deact.NOME_CLIENTE.contains('�')){
        		return OF_GPONP_GE_Utils.syncError (deact,'B04','NOME_CLIENTE');
        	}
        }
        if(!string.isblank(deact.COGNOME_CLIENTE)){ 
            if(deact.COGNOME_CLIENTE.length()>70){
                return OF_GPONP_GE_Utils.syncError (deact,'A06','COGNOME_CLIENTE');
            }else if(!string.isblank(deact.COGNOME_CLIENTE) && deact.COGNOME_CLIENTE.contains('�')){
                return OF_GPONP_GE_Utils.syncError (deact,'B04','COGNOME_CLIENTE');
            }
        }
        //AA - Aggiunti controlli nuovo campo tracciato trascodificato
        if(String.isNotBlank(deact.TRACCIATO_TRASCODIFICATO)){
            if(deact.TRACCIATO_TRASCODIFICATO.length() > 10 || (deact.TRACCIATO_TRASCODIFICATO != 'SI' && deact.TRACCIATO_TRASCODIFICATO != 'NO')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(deact);
                return OF_GPONP_GE_Utils.syncError (deact,'A06','TRACCIATO_TRASCODIFICATO');
            } 
        }
        //AA - Nuovo campo CODICE OPERATORE SECONDARIO
        if(String.isNotBlank(deact.CODICE_OPERATORE_SECONDARIO)){
            if(deact.CODICE_OPERATORE_SECONDARIO.length() > 3){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(deact);
                return OF_GPONP_GE_Utils.syncError (deact,'A06','CODICE_OPERATORE_SECONDARIO');
            }else if(deact.CODICE_OPERATORE_SECONDARIO.contains('�')){
                OF_GPONP_GE_Utils.slOLOSF = OF_GPONP_GE_Utils.create_EAI_Log(deact);
                return OF_GPONP_GE_Utils.syncError (deact,'B04','CODICE_OPERATORE_SECONDARIO');
            }
        }
        if(deact.APPARATO!=null && !deact.APPARATO.isempty()){
            for(OF_GPONP_WS_IN_OLO_Deactivation.APPARATO ap : deact.APPARATO){ 
                
                if(string.isblank(ap.TIPOLOGIA_APPARATO)){
                    return OF_GPONP_GE_Utils.syncError (deact,'A05','TIPOLOGIA_APPARATO');
                }else if(ap.TIPOLOGIA_APPARATO.length()>100){
                    return OF_GPONP_GE_Utils.syncError (deact,'A06','TIPOLOGIA_APPARATO');
                }
                
                if(!string.isblank(ap.TIPOLOGIA_APPARATO)){
    
                    if(string.isblank(deact.COGNOME_CLIENTE)){
                        return OF_GPONP_GE_Utils.syncError (deact,'A05','COGNOME_CLIENTE');
                    }else if(deact.COGNOME_CLIENTE.length()>70){
                        return OF_GPONP_GE_Utils.syncError (deact,'A06','COGNOME_CLIENTE');
                    }else if(!string.isblank(deact.COGNOME_CLIENTE) && deact.COGNOME_CLIENTE.contains('�')){
                        return OF_GPONP_GE_Utils.syncError (deact,'B04','COGNOME_CLIENTE');
                    }

                    if(string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_1)){
                        return OF_GPONP_GE_Utils.syncError (deact,'A05','RECAPITO_TELEFONICO_CLIENTE_1');
                    }else if(deact.RECAPITO_TELEFONICO_CLIENTE_1.length()>20){
                        return OF_GPONP_GE_Utils.syncError (deact,'A06','RECAPITO_TELEFONICO_CLIENTE_1');
                    }else if(!string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_1) && deact.RECAPITO_TELEFONICO_CLIENTE_1.contains('�')){
                        return OF_GPONP_GE_Utils.syncError (deact,'B04','RECAPITO_TELEFONICO_CLIENTE_1');
                    }

                    if(string.isblank(deact.RECAPITO_TELEFONICO_CLIENTE_2)){
                        return OF_GPONP_GE_Utils.syncError (deact,'A05','RECAPITO_TELEFONICO_CLIENTE_2');
                    }else if(deact.RECAPITO_TELEFONICO_CLIENTE_2.length()>20){
                        return OF_GPONP_GE_Utils.syncError (deact,'A06','RECAPITO_TELEFONICO_CLIENTE_2');
                    }else if(deact.RECAPITO_TELEFONICO_CLIENTE_2.contains('�')){
                        return OF_GPONP_GE_Utils.syncError (deact,'B04','RECAPITO_TELEFONICO_CLIENTE_2');
                    }       
                }   
            }
        }

        if(!string.isblank(deact.NOTE)){
        	if(deact.NOTE.length()>255){
        		return OF_GPONP_GE_Utils.syncError (deact,'A06','NOTE');
        	}
        	if(deact.NOTE.contains('�')){
        		return OF_GPONP_GE_Utils.syncError (deact,'B04','NOTE');
        	} 
        } 
        Case c = new Case();
        c.OF_OM_Nuovo_Flusso__c = true;
        c.subject='Richiesta Cessazione';
        c.recordtypeId=OF_GPONP_GE_Utils.rtMap.get('EOF_Caso_Cessazione');
        c.Status='Inviato';
        c.EOF_Id_Risorsa__c=Deact.ID_Risorsa;
        c.EOF_Codice_Ordine_Olo__c=Deact.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = Deact.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = Deact.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_GPONP_GE_Utils.StringToDate(Deact.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = Deact.ID_NOTIFICA;
        c.PO_SA_Portale__c=OF_GPONP_GE_Utils.PORTAL;
        //aa aggiunto campo 29/11/2018
        c.TRACCIATO_TRASCODIFICATO__c=Deact.TRACCIATO_TRASCODIFICATO;     
        c.OF_Codice_Operatore_Secondario__c = Deact.CODICE_OPERATORE_SECONDARIO;   
        insert c; 
        OF_GPONP_GE_Utils.caseOriginale=c;
        OF_GPONP_GE_Utils.checkCaseOriginale=true;
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slToUpsert.add(OF_GPONP_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                             'Codice_operatore' => Deact.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => Deact.CODICE_ORDINE_OLO,
                                             'Flusso' => 'OLO-SF',
                                             'Metodo' => 'OLO_DeactivationRequest',
                                             'ID_notifica' => Deact.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'OLO->SF - ACK - DeactivationRequest',
											 'SL Riferimento' => OF_GPONP_GE_Utils.slOLOSF.Id}));
		OF_GPONP_GE_Utils.slOLOSF.EOF_Response__c='ACK';	
		OF_GPONP_GE_Utils.slOLOSF.Caso__c=c.Id;												
		slToUpsert.add(OF_GPONP_GE_Utils.slOLOSF);
		upsert slToUpsert;
        //Done AA - Modificare metodo async
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncDeactivationNew(c.Id,OF_GPONP_GE_Utils.slOLOSF.Id);
        
	    // 14/02/2018 MM : Aggiorno il timestamp. C.2 corrisponde alla fine check Cessazione.
		OF_GPONP_GE_Utils.partialTemplog('C.2');
	    // finisce qui
	    
		OF_GPONP_GE_Utils.EndTemplog();
        
        return resp;    
    }
}
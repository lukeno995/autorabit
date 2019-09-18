public class OF_TT_Utils {
    //SERV ATT ORI
    public static EOF_Notify__c notify;
    public static Case caseOriginale;
    public static boolean checkCaseOriginale=false;

    public static void setNotify(EOF_Notify__c nt){
        notify=nt;
    }
    
    public static EOF_Notify__c getNotify(){
        return notify;
    }

    public static EOF_EAI_Service_Log__c create_EAI_Log(Object o){  

        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        
        if(o instanceof OF_TT_WS_TroubleTicketRequest.TroubleTicket){
            OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = (OF_TT_WS_TroubleTicketRequest.TroubleTicket) o;
            RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'TroubleTicketRequest'];
            sl = new EOF_EAI_Service_Log__c(
            RecordTypeId = rt.id,
            EOF_Codice_Comunicazione_OLO__c = tt.CODICE_COMUNICAZIONE_OLO,                    
            EOF_Codice_Operatore__c = tt.CODICE_OPERATORE,
            EOF_Tipo_Comunicazione__c = 'TT - '+OF_TT_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE), 
            EOF_Data_Notifica__c = OF_TT_Utils.now(),
            EOF_ID_Notifica__c = tt.ID_NOTIFICA,                   
            EOF_Richiesta_Notifica__c = copy_tt_request(tt),
            // Marco : Modifica salvataggio sul service log. Adesso salva sui campi appositi del SL    
            EOF_ID_Risorsa__c = tt.ID_RISORSA,
            //EOF_Categoria_Guasto__c = tt.Categoria_Guasto,
            EOF_Data_Ora_Inizio_Guasto__c = StringToDate(tt.DATA_ORA_INIZIO_GUASTO),
            EOF_Data_Ora_Richiesta_Annullamento__c = StringToDate(tt.DATA_ORA_RICHIESTA_ANNULLAMENTO),
            EOF_Data_Ora_Desospensione__c = StringToDate(tt.DATA_ORA_DESOSPENSIONE),
            EOF_Data_Ora_Autoripristinato__c = StringToDate(tt.DATA_ORA_AUTORIPRISTINATO),
            EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c = tt.CAUSALE_RICHIESTA_ANNULLAMENTO,
            EOF_Causale_Desospensione__c = tt.CAUSALE_DESOSPENSIONE,
            EOF_Nome_Cliente__c = tt.NOME_CLIENTE,
            EOF_COgnome_CLiente__c = tt.COGNOME_CLIENTE,
            EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = tt.RECAPITO_TELEFONICO_CLIENTE_1,
            EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = tt.RECAPITO_TELEFONICO_CLIENTE_2,
            EOF_NOME_REFERENTE_TECNICO_OLO__c = tt.NOME_REFERENTE_TECNICO_OLO,
            EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = tt.TELEFONO_REFERENTE_TECNICO_OLO,
            EOF_EMAIL_REFERENTE_TECNICO_OLO__c = tt.EMAIL_REFERENTE_TECNICO_OLO,
            EOF_Referente_desospensione__c = tt.REFERENTE_DESOSPENSIONE,
            EOF_Verifica_apparato_cliente__c = tt.VERIFICA_APPARATO_CLIENTE,
            EOF_Descrizione_Problema__c = tt.DESCRIZIONE_PROBLEMA,
            EOF_NOTE_CLIENTE__c = tt.NOTE_CLIENTE,
            EOF_Causale_Apertura__c = tt.CAUSALE_APERTURA,
            EOF_Intervento_Congiunto__c = tt.INTERVENTO_CONGIUNTO,
            EOF_Tec_OLO__c = tt.TEC_OLO,
            EOF_Tel_Tec_OLO__c = tt.TEL_TEC_OLO,
            EOF_Data_Ora_Intervento_Congiunto__c = StringToDate(tt.DATA_ORA_INTERVENTO_CONGIUNTO)
            // Marco : fine modifica
            );
            
            // MM : troncatura campo note se > 255
            if(string.isnotBlank(tt.NOTE) && tt.NOTE!=null){
            	sl.EOF_Note__c =tt.NOTE.abbreviate(255);
            }
            else {
            	sl.EOF_Note__c = tt.NOTE;
            }
            //AA 14/06/18 : Modifica per recupero case originale Trouble_Ticket
            List<Case> cList = [SELECT Id,EOF_Id_Notifica__c,status, EOF_Codice_Operatore_WS__c, EOF_GPON_Attestazione__c, 
                                EOF_Id_Risorsa__c, EOF_Data_Notifica__c, EOF_Data_Prevista_Attivazione__c, EOF_Nuova_DAC__c,
                                RecordType.DeveloperName,OF_Bonifica_Locked_Row__c,EOF_Pertinenza_RDAC__c, canModify__c, EOF_Codice_Ordine_OM__c,
                                EOF_Order_Manager__c, OF_TroubleTicketManager__c
                                FROM Case 
                                Where EOF_Codice_Comunicazione_OLO__c =: tt.CODICE_COMUNICAZIONE_OLO 
                                and RecordType.DeveloperName = 'Trouble_Ticket'];

            if(!cList.isEmpty()){
                sl.caso__c=cList[0].Id;
                sl.EOF_COdice_ordine_EOF__C=cList[0].Id;
                OF_TT_Utils.caseOriginale=cList[0];
                OF_TT_Utils.checkCaseOriginale=true;
                OF_TTM_Utils.caseOriginale=cList[0];
                OF_TTM_Utils.checkCaseOriginale=true;
            } 
            //Fine AA 14/06/18
        }
        
        if(o instanceof EOF_Notify__c){
            notify = (EOF_Notify__c) o;
            RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'TroubleTicketNotify'];
            sl = new EOF_EAI_Service_Log__c(
                                            Caso__c = Notify.caso__c,
                                            EOF_Codice_Operatore__c = notify.EOF_Codice_Operatore__c,
                                            EOF_Codice_Comunicazione_OLO__c = notify.EOF_Codice_Comunicazione_OLO__c,
                                            RecordTypeId = rt.id,
                                            Notify__c = notify.id,
                                            EOF_Richiesta_Notifica__c = copy_TT_notify(notify),
                							// Marco : Modifica salvataggio sul service log. Adesso salva sui campi appositi del SL  
                                            EOF_ID_Notifica__c = notify.Name,
                                            EOF_Data_Notifica__c = notify.EOF_Data_Notifica__c,
                                            EOF_Tipo_Comunicazione__c = 'TT - '+notify.OF_TT_Tipo_Comunicazione__c,
                							EOF_ID_Risorsa__c = notify.EOF_ID_Risorsa__c,
                							EOF_Stato_Ticket__c = notify.Stato_Ticket__c,
                							EOF_Data_Ora_Scarto__c = notify.EOF_Data_Ora_Scarto__c,
                							EOF_Data_Ora_Creazione__c = notify.EOF_Data_Ora_Creazione__c,
                							EOF_Data_Ora_Notifica_Sospensione__c = notify.EOF_Data_Ora_Notifica_Sospensione__c,
                							EOF_Data_Ora_Notifica_Desospensione__c = notify.EOF_Data_Ora_Notifica_Desospensione__c,
                							EOF_Data_Ora_Notifica_Annullamento__c = notify.EOF_Data_Ora_Notifica_Annullamento__c,
                							EOF_Data_Ora_Notifica_Chiusura__c = notify.EOF_Data_Ora_Notifica_Chiusura__c,
                							Causale_Scarto__c = notify.Causale_Scarto__c,
                							EOF_Descrizione_Causale_Scarto__c = notify.EOF_Descrizione_Causale_Scarto__c,
                							Causale_Sospensione__c = notify.Causale_Sospensione__c,
                							EOF_Referente_desospensione__c = notify.EOF_Referente_desospensione__c,
                							Descrizione_Evento_Risoluzione__c = notify.Descrizione_Evento_Risoluzione__c,
                							EOF_Note__c = notify.EOF_Note__c,
                							EOF_Rischedulazione_Appuntamento__c = notify.EOF_Rischedulazione_Appuntamento__c,
                							EOF_Intervento_Congiunto__c = notify.EOF_Intervento_Congiunto__c,
                							EOF_Tec_Eof__c = notify.EOF_Tec_Eof__c,
                							EOF_Tel_Tec_Eof__c = notify.EOF_Tel_Tec_Eof__c,
                							EOF_Data_Ora_Intervento_Congiunto__c = notify.EOF_Data_Ora_Intervento_Congiunto__c
                							// Marco : fine modifica
                                        );
             
        }
        
        if(o instanceof Map<String, String>){
        
            if(((Map<String, String>) o).get('Type') == 'TT_ACK'){
                RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'TT - ACK' LIMIT 1];
                sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = rt.id,
                Caso__c=((Map<String, String>) o).get('CaseId'),
                EOF_Stato_Richiesta__c = 'OK',
                EOF_Codice_Comunicazione_OLO__c = ((Map<String, String>) o).get('Codice_comunicazione_OLO'),
                EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
                EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('TT_Request'),                 
                EOF_Data_Notifica__c = OF_TT_Utils.now(),
                EOF_Tipo_Comunicazione__c='TT - ACK - '+OF_TT_Utils.getStringTipoComunicazione(((Map<String, String>) o).get('Tipo Comunicazione'))     
                );
                
            }
            if(((Map<String, String>) o).get('Type') == 'TT_NACK'){
                RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'TT - NACK' LIMIT 1];
                sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = rt.id,
                Caso__c=((Map<String, String>) o).get('CaseId'),
                EOF_Stato_Richiesta__c = 'KO',
                EOF_Codice_Errore__c = ((Map<String, String>) o).get('Codice_errore'),
                EOF_Causale_Errore__c = ((Map<String, String>) o).get('Causale_errore'),
                EOF_Codice_Comunicazione_OLO__c = ((Map<String, String>) o).get('Codice_comunicazione_OLO'),
                EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
                EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('TT_Request'),                 
                EOF_Data_Notifica__c = OF_TT_Utils.now(),
                EOF_Tipo_Comunicazione__c='TT - NACK - '+OF_TT_Utils.getStringTipoComunicazione(((Map<String, String>) o).get('Tipo Comunicazione'))      
                );
                
            }
            if(((Map<String, String>) o).get('Type') == 'Trouble Ticket - Richiesta Scartata'){
                RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Trouble Ticket - Richiesta Scartata' LIMIT 1];
                //lego il log di request al case
                List<EOF_EAI_Service_Log__c> logs =[select Id from EOF_EAI_Service_Log__c where EOF_Codice_Comunicazione_OLO__c=:((Map<String, String>) o).get('Codice_comunicazione_OLO') 
                                                and RecordType.Name ='TroubleTicketRequest' order by  CreatedDate DESC LIMIT 1];
                if (!logs.isEmpty()){
                    logs[0].Caso__c=((Map<String, String>) o).get('CaseId');
                    update logs[0];
                }
                sl = new EOF_EAI_Service_Log__c(
                RecordTypeId = rt.id,
                Caso__c=((Map<String, String>) o).get('CaseId'),
                EOF_Stato_Richiesta__c = 'KO',
                EOF_Codice_Errore__c = ((Map<String, String>) o).get('Codice_errore'),
                EOF_Causale_Errore__c = ((Map<String, String>) o).get('Causale_errore'),
                EOF_Codice_Comunicazione_OLO__c = ((Map<String, String>) o).get('Codice_comunicazione_OLO'),
                EOF_ID_Notifica__c = ((Map<String, String>) o).get('ID_notifica'),
                EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('TT_Request'),                
                EOF_Data_Notifica__c = OF_TT_Utils.now(),
                EOF_Tipo_Comunicazione__c='TT - SCARTO - '+OF_TT_Utils.getStringTipoComunicazione(((Map<String, String>) o).get('Tipo Comunicazione'))    
                );
                
            }
        }
        
        System.debug(sl);
        return sl;
        
    }
    
    Public static datetime calcoloSLA(boolean premium){
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE name='DAC'];
        Long millisecEffettivi;
        Datetime SLADate;
        if (premium){
            if(OF_TT_Utils.now().Hour()<12 && BusinessHours.isWithin(bh.id, OF_TT_Utils.now())){
                Date d = OF_TT_Utils.now().date();
                time t = time.newInstance(23,59,59,0);
                Datetime endSLAtemp= datetime.newInstance(d,t);
                millisecEffettivi = endSLAtemp.getTime() - OF_TT_Utils.now().getTime();
            }
            else if(!BusinessHours.isWithin(bh.id, OF_TT_Utils.now())){
                Datetime endSLAtemp= OF_TT_Utils.now().addSeconds((24*60*60)-1);
                millisecEffettivi = endSLAtemp.getTime() - OF_TT_Utils.now().getTime();
            }
            else{
                Date d = OF_TT_Utils.now().addDays(1).date();
                time t = time.newInstance(12,0,0,0);
                Datetime endSLAtemp= datetime.newInstance(d,t);
                millisecEffettivi = endSLAtemp.getTime() - OF_TT_Utils.now().getTime();
            }
        }
        else{
            if(OF_TT_Utils.now().Hour()<20 && BusinessHours.isWithin(bh.id, OF_TT_Utils.now())){
                Date d = OF_TT_Utils.now().addDays(1).date();
                time t = time.newInstance(23,59,59,0);
                Datetime endSLAtemp= datetime.newInstance(d,t);
                millisecEffettivi = endSLAtemp.getTime() - OF_TT_Utils.now().getTime();
                system.debug('SlaDate senza bh: '+endSLAtemp+', millisec Effettivi: '+millisecEffettivi+ ', la somma fa: '+OF_TT_Utils.now().addSeconds(Integer.valueOf(millisecEffettivi/1000)));
            }
            else if(!BusinessHours.isWithin(bh.id, OF_TT_Utils.now())){
                Datetime endSLAtemp= OF_TT_Utils.now().addSeconds((48*60*60)-1);
                millisecEffettivi = endSLAtemp.getTime() - OF_TT_Utils.now().getTime();
            }
            else {
                Date d = OF_TT_Utils.now().addDays(2).date();
                time t = time.newInstance(23,59,59,0);
                Datetime endSLAtemp= datetime.newInstance(d,t);
                millisecEffettivi = endSLAtemp.getTime() - OF_TT_Utils.now().getTime();             
            }
            
        }
        SLADate=businessHours.Add(bh.id, OF_TT_Utils.now(), millisecEffettivi);
        return SLADate;
        
    } 

    //Auxiliar method to copy tt nel campo richiesta notifica del log
    
    public static String copy_TT_request(OF_TT_WS_TroubleTicketRequest.TroubleTicket tt){
        String s;
        
        s =   'TIPO_COMUNICAZIONE: ' + tt.TIPO_COMUNICAZIONE + '\n' +
              'CODICE_OPERATORE: '+ tt.CODICE_OPERATORE + '\n' +
              'CODICE_COMUNICAZIONE_OLO: '+ tt.CODICE_COMUNICAZIONE_OLO + '\n' +
              'CATEGORIA_GUASTO: '+ tt.CATEGORIA_GUASTO + '\n' +
              'ID_RISORSA: '+ tt.ID_RISORSA + '\n' +
              'ID_NOTIFICA: '+ tt.ID_NOTIFICA + '\n' +
              'DATA_ORA_INIZIO_GUASTO: '+ tt.DATA_ORA_INIZIO_GUASTO + '\n' +
              'DATA_ORA_RICHIESTA_ANNULLAMENTO: '+ tt.DATA_ORA_RICHIESTA_ANNULLAMENTO + '\n' +
              'DATA_ORA_DESOSPENSIONE: '+ tt.DATA_ORA_DESOSPENSIONE + '\n' +
              'DATA_ORA_AUTORIPRISTINATO: '+ tt.DATA_ORA_AUTORIPRISTINATO + '\n' +
              'CAUSALE_RICHIESTA_ANNULLAMENTO: '+ tt.CAUSALE_RICHIESTA_ANNULLAMENTO + '\n' +
              'CAUSALE_DESOSPENSIONE: '+ tt.CAUSALE_DESOSPENSIONE + '\n' +
              'NOME_CLIENTE: '+ tt.NOME_CLIENTE + '\n' +
              'COGNOME_CLIENTE: '+ tt.COGNOME_CLIENTE + '\n' +              
              'RECAPITO_TELEFONICO_CLIENTE_1: '+ tt.RECAPITO_TELEFONICO_CLIENTE_1 + '\n' +
              'RECAPITO_TELEFONICO_CLIENTE_2: '+ tt.RECAPITO_TELEFONICO_CLIENTE_2 + '\n' +
              'NOME_REFERENTE_TECNICO_OLO: '+ tt.NOME_REFERENTE_TECNICO_OLO + '\n' +
              'TELEFONO_REFERENTE_TECNICO_OLO: '+ tt.TELEFONO_REFERENTE_TECNICO_OLO + '\n' +
              'EMAIL_REFERENTE_TECNICO_OLO: '+ tt.EMAIL_REFERENTE_TECNICO_OLO + '\n' +
              'REFERENTE_DESOSPENSIONE: '+ tt.REFERENTE_DESOSPENSIONE + '\n' +
              'VERIFICA_APPARATO_CLIENTE: '+ tt.VERIFICA_APPARATO_CLIENTE + '\n' +
              'DESCRIZIONE_PROBLEMA: '+ tt.DESCRIZIONE_PROBLEMA + '\n' +
              'NOTE_CLIENTE: '+ tt.NOTE_CLIENTE + '\n' +
              'NOTE: '+ tt.NOTE + '\n' +
              'CAUSALE_APERTURA: '+ tt.CAUSALE_APERTURA + '\n' +
              'INTERVENTO_CONGIUNTO: '+ tt.INTERVENTO_CONGIUNTO + '\n' +
              'TEC_OLO: '+ tt.TEC_OLO + '\n' +
              'TEL_TEC_OLO: '+ tt.TEL_TEC_OLO + '\n' +
              'DATA_ORA_INTERVENTO_CONGIUNTO: '+ tt.DATA_ORA_INTERVENTO_CONGIUNTO + '\n';
              
        
        return s;
    }
    
    //Auxiliar method to copy tt nel campo richiesta notifica della notify
    public static String copy_TT_notify(EOF_Notify__c n){

        String s;
        
            Integer offset = UserInfo.getTimeZone().getOffset(OF_TT_Utils.now())/3600000;
            String prefix = (offset >= 0) ? '+'  : '-';
            String a = prefix + ((Math.abs(offset) < 10) ? ('0'+ Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));            
                 
        s = 'CODICE_OPERATORE :' + n.EOF_Codice_Operatore__c + '\n' +           
            'TIPO_COMUNICAZIONE :' + OF_TT_Utils.getValueTipoComunicazione(n.OF_TT_Tipo_Comunicazione__c) + '\n' + 
            'CODICE_COMUNICAZIONE_OLO :' + n.EOF_Codice_Comunicazione_OLO__c + '\n' +
            'ID_NOTIFICA :' + n.name + '\n' +
            'ID_RISORSA :' + n.EOF_ID_Risorsa__c + '\n' + 
            'STATO_TICKET :' + OF_TT_Utils.getValueStatoTicket(n.stato_ticket__c) + '\n' +
            'DATA_ORA_SCARTO :'+ OF_TT_Utils.dateToString(n.EOF_Data_Ora_Scarto__c) + '\n' +
            'DATA_ORA_CREAZIONE :'+ OF_TT_Utils.dateToString(n.EOF_Data_Ora_CREAZIONE__c) + '\n' +
            'DATA_ORA_NOTIFICA_SOSPENSIONE :'+ OF_TT_Utils.dateToString(n.EOF_Data_Ora_NOTIFICA_SOSPENSIONE__c) + '\n' +
            'DATA_ORA_NOTIFICA_DESOSPENSIONE :'+ OF_TT_Utils.dateToString(n.EOF_Data_Ora_NOTIFICA_DESOSPENSIONE__c) + '\n' +
            'DATA_ORA_NOTIFICA_ANNULLAMENTO :'+ OF_TT_Utils.dateToString(n.EOF_Data_Ora_NOTIFICA_ANNULLAMENTO__c) + '\n' +
            'DATA_ORA_NOTIFICA_CHIUSURA :'+ OF_TT_Utils.dateToString(n.EOF_DATA_ORA_NOTIFICA_CHIUSURA__c) + '\n' +
            'CAUSALE_SCARTO :'+ OF_TT_Utils.getValueCausaleScarto(n.CAUSALE_SCARTO__c) + '\n' +
            'DESCRIZIONE_CAUSALE_SCARTO :'+ n.EOF_DESCRIZIONE_CAUSALE_SCARTO__c + '\n' +
            'CAUSALE_SOSPENSIONE :'+ OF_TT_Utils.getValueCausaleSospensione(n.CAUSALE_SOSPENSIONE__c) + '\n' +
            'REFERENTE_DESOSPENSIONE :'+ n.EOF_REFERENTE_DESOSPENSIONE__c + '\n' +
            'DESCRIZIONE_INTERVENTO_RISOLUZIONE :'+ OF_TT_Utils.getValueDescrizioneInterventoRisoluzione(n.DESCRIZIONE_EVENTO_RISOLUZIONE__c) + '\n' +
            'NOTE :' + n.EOF_Note__c  + '\n' +
            'RISCHEDULAZIONE_APPUNTAMENTO :'+ OF_TT_Utils.dateToString(n.EOF_RISCHEDULAZIONE_APPUNTAMENTO__c) + '\n' +
            'INTERVENTO_CONGIUNTO :'+ n.EOF_INTERVENTO_CONGIUNTO__c + '\n' +
            'TEC_EOF :'+ n.EOF_TEC_EOF__c + '\n' +
            'TEL_TEC_EOF :'+ n.EOF_TEL_TEC_EOF__c + '\n' +
            'DATA_ORA_INTERVENTO_CONGIUNTO :'+ OF_TT_Utils.dateToString(n.EOF_DATA_ORA_INTERVENTO_CONGIUNTO__c) + '\n';
        return s;
    }

    public static String dateToString(datetime dt){
        if(String.isBlank(String.valueOf(dt))){
            return null;
        }
        Integer offset = UserInfo.getTimeZone().getOffset(OF_TT_Utils.now())/3600000;
        String prefix = (offset >= 0) ? '+'  : '-';
        String a = prefix + ((Math.abs(offset) < 10) ? ('0'+ Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));
        String s = dt.format('yyyy-MM-dd\'T\'HH:mm:ss\''+a+'\'');
        return s;
    }

    public static Datetime stringToDate(String s){
        if(String.isBlank(s)){
            return null;
        }
        Datetime dt = Datetime.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)),integer.valueOf(s.left(13).right(2)),integer.valueOf(s.left(16).right(2)),integer.valueOf(s.left(19).right(2)));
        return dt;
    }
	
    // Marco : aggiunto metodo conversione stringa - data
    public static Date stringToDateNoTime(String s){
        if(String.isBlank(s)){
            return null;
        }
        Date dt = Date.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)));
        return dt;
    }

	// Marco : modifica per aggiunta checks su date, time e datetime
    public static boolean checkDate(String S){
    	if(String.isBlank(s)){
    		return false;
    	}
    	try{
    		Date.valueOf(s);
    		if(s.split('-').get(0).isNumeric() && Integer.valueOf(s.split('-').get(0))<2016){
	          return false;
	        }
    	}
    	catch(Exception e){
    		return false;
    	}
        return true;
    }
	
    public static boolean checkTime(String tmp){
    	if(String.isBlank(tmp)){
    		return false;
    	}
    	try{
	        if(!tmp.split(':').get(0).isNumeric() || !tmp.split(':').get(1).isNumeric() || !tmp.split(':').get(2).isNumeric() ){
	          return false;
	        } 
	        if(tmp.split(':').get(0).length() != 2 || tmp.split(':').get(1).length() != 2 || tmp.split(':').get(2).length() != 2 ){
	          return false;
	        }                       
	        if(Integer.valueOf(tmp.split(':').get(0)) > 23 || Integer.valueOf(tmp.split(':').get(1)) > 59 || Integer.valueOf(tmp.split(':').get(2)) > 59 ){	
	          return false;
	        } 
	    }catch(Exception e){
	         return false;
	    }
	    return true;
    }
        
    public static boolean checkDateTime(String S){
        if(String.isBlank(s)){    		
            return false;
        }
        if(!OF_TT_Utils.checkDate(s.left(10))){    	
            return false;    		
        }
        if(!OF_TT_Utils.checkTime(s.left(19).right(8))){    		
            return false;    		
        }
        if(s.left(11).right(1)!='T'){    		
            return false;    		
        }
        if(s.right(6)!='+01:00' && s.right(6)!='+02:00'){
            return false;		
        }
        return true;
    }
	// Marco : fine modifica per aggiunta checks su date, time e datetime
    
    public static Datetime now(){
        Datetime dt=Datetime.newInstance(system.today(), system.now().Time());
        return dt;

    }

    public static String getStringTipoComunicazione(String s){
        if(String.isBlank(s)){
            return null;
        }
        if(s=='1'){
         return 'Richiesta Risoluzione Guasto';
        }
        if(s=='2'){
         return 'Notifica Scarto';
        }
        if(s=='3'){
         return 'Notifica Presa in Carico';
        }
        if(s=='4'){
         return 'Notifica Sospensione';
        }
        if(s=='5'){
         return 'Notifica Richiesta Chiusura';
        }
        if(s=='6'){
         return 'Richiesta Desospensione';
        }
        if(s=='7'){
         return 'Notifica Desospensione';
        }
        if(s=='8'){
         return 'Richiesta Autoripristinato';
        }
        if(s=='9'){
         return 'Richiesta Annullamento';
        }
        if(s=='10'){
         return 'Notifica Annullamento';
        }
        if(s=='11'){
         return 'Test KO';
        }
        if(s=='12'){
         return 'Test OK';
        }
        if(s=='13'){
         return 'Notifica Timeout OK';
        }
        if(s=='20'){
         return 'Richiesta Aggiornamento Dati';
        }
        if(s=='21'){
         return 'Notifica Aggiornamento Dati';
        }
        return null;
    }
    
    public static String getValueTipoComunicazione(String s){
        if(String.isBlank(s)){
            return null;
        }
        if(s.equalsIgnoreCase('Notifica Scarto')){
            return '2';
        }
        if(s.equalsIgnoreCase('Notifica Richiesta Chiusura')){
            return '5';
        }
         if(s.equalsIgnoreCase('Notifica Presa in Carico')){
            return '3';
        }
      
         if(s.equalsIgnoreCase('Notifica Sospensione')){
            return '4';
        }
        
        if(s.equalsIgnoreCase('Notifica Desospensione')){
            return '7';
        }
        
        if(s.equalsIgnoreCase('Notifica Annullamento')){
            return '10';
        }
        
        if(s.equalsIgnoreCase('Notifica Timeout OK')){
            return '13';
        }
        
        if(s.equalsIgnoreCase('Notifica Aggiornamento Dati')){
            return '21';
        }
        
        return null;
    }
    
    public static String getStringCategoriaGuasto(String s){
        if(String.isBlank(s)){
            return null;
        }
        if(s=='0'){
         return 'Disservizio';
        }
        if(s=='1'){
         return 'Degrado';
        }
        if(s=='2'){
         return 'Post Provisioning';
        }
        return null;
    }
    
    public static String getStringCausaleDesospensione(String s){
        
        if(String.isBlank(s)){
            return null;
        }
        if(s=='2'){
         return 'Cliente Irreperibile';
        }
        if(s=='3'){
         return 'Cliente Indisponibile';
        }
        return null;
    }
    
    public static String getStringCausaleApertura(String s){
        if(String.isBlank(s)){
            return null;
        }
        if(s=='1'){
         return 'Connettività non disponibile';
        }
        if(s=='2'){
         return 'Connessione instabile';
        }
        if(s=='3'){
         return 'Lentezza di navigazione';
        }
        if(s=='4'){
         return 'Mai Navigato';
        }
        return null;
    }
    
    public static String getValueStatoTicket(String s){
        if(String.isBlank(s)){
            return null;
        }
        if(s.equalsIgnoreCase('Scartato')){
         return '1';
        }
        if(s.equalsIgnoreCase('In Lavorazione')){
         return '2';
        }
        if(s.equalsIgnoreCase('Sospeso')){
         return '3';
        }
        if(s.equalsIgnoreCase('Chiuso')){
         return '4';
        }
        if(s.equalsIgnoreCase('Annullato')){
         return '5';
        }
        if(s.equalsIgnoreCase('Richiesta Chiusura')){
            return '6';
        }
        return null;
    }
    
    public static String getValueCausaleScarto(String s){
        if(String.isBlank(s)){
            return null;
        }
        if(s.equalsIgnoreCase('Formato dati errato o incompleto')){
         return '1';
        }
        if(s.equalsIgnoreCase('Ticket aperto per stesso ID risorsa')){
         return '2';
        }
        if(s.equalsIgnoreCase('ID Risorsa Inesistente')){
         return '3';
        }
        if(s.equalsIgnoreCase('Codice Comunicazione OLO già presente')){
         return '4';
        }        
        if(s.equalsIgnoreCase('Guasto Aperto come Post-Provisioning oltre i termini previsti')){
         return '5';
        }
        return null;
    }
    
    public static String getValueCausaleSospensione(String s){
        if(String.isBlank(s)){
            return null;
        }
        if(s.equalsIgnoreCase('SEDE OLO/CLIENTE FINALE INACCESSIBILE')){
         return '1';
        }
        if(s.equalsIgnoreCase('CLIENTE IRREPERIBILE')){
         return '2';
        }
        if(s.equalsIgnoreCase('CLIENTE INDISPONIBILE')){
         return '3';
        }
        return null;
    }
    
    public static String getValueDescrizioneInterventoRisoluzione(String s){
        if(String.isBlank(s)){
            return null;
        }
        if(s.equalsIgnoreCase('RISOLTO: TRATTA VERTICALE')){
         return '1';
        }
        if(s.equalsIgnoreCase('RISOLTO TRATTA ORIZZONTALE: CENTRALE')){
         return '2';
        }
        if(s.equalsIgnoreCase('RISOLTO TRATTA ORIZZONTALE: RETE PRIMARIA')){
         return '3';
        }
        if(s.equalsIgnoreCase('RISOLTO TRATTA ORIZZONTALE: RETE SECONDARIA')){
         return '4';
        }
        if(s.equalsIgnoreCase('NON RISCONTRATO: SENZA USCITA')){
         return '5';
        }
        if(s.equalsIgnoreCase('NON RISCONTRATO: CON USCITA')){
         return '6';
        }
        if(s.equalsIgnoreCase('RISOLTO: SBRACCIO')){
         return '7';
        }
        if(s.equalsIgnoreCase('RISOLTO: BORCHIA OTTICA')){
         return '8';
        }
        if(s.equalsIgnoreCase('NON RISOLVIBILE: CAUSA IMPIANTO CLIENTE')){
         return '9';
        }
        if(s.equalsIgnoreCase('NON RISOLVIBILE: CAUSA CPE CLIENTE')){
         return '10';
        }
        if(s.equalsIgnoreCase('RISOLTO OLO/CLIENTE: CONFIGURAZIONE CPE/ONT CLIENTE')){
         return '11';
        }
        if(s.equalsIgnoreCase('RISOLTO OLO/CLIENTE: SOSTITUZIONE CPE CLIENTE')){
         return '12';
        }
        if(s.equalsIgnoreCase('RISOLTO OLO/CLIENTE: SOSTITUZIONE ONT CLIENTE')){
         return '13';
        }
        if(s.equalsIgnoreCase('RISOLTO OLO/CLIENTE: RESET CPE/ONT CLIENTE')){
         return '14';
        }
        if(s.equalsIgnoreCase('RISOLTO OLO/CLIENTE: SOSTITUZIONE BRETELLA OTTICA')){
         return '15';
        }
        if(s.equalsIgnoreCase('RIBALTAMENTO EFFETTUATO')){
         return '16';
        }
        if(s=='Non Risolvibile: Problemi Di Rete OLO (Es. Problema di Scheda In Centrale OLO, Problema Di Configurazione OLO)'){
         return '17';
        }
        if(s=='Non Risolvibile: Problemi Di Rete Cliente (Es. Wi-Fi Poco Performante Causa Disposizione Casa Cliente, Configurazione PC)'){
         return '18';
        }
        if(s.equalsIgnoreCase('RISOLTO MEDIANTE INTERVENTO CONGIUNTO')){
         return '19';
        }
        if(s.equalsIgnoreCase('CHIUSO PER TIMEOUT_OK')){
         return '20';
        }
        return null;
    }
    
    
    public static OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse syncError(OF_TT_WS_TroubleTicketRequest.TroubleTicket tt, String errorCode, String fieldName){
     
        OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse tt_resp_temp = new OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
        tt_resp_temp.Esito = '1';
        String errorDesc;
        
        if(errorCode == 'A_K9')
            errorDesc = 'Campo \''+ fieldName +'\' obbligatorio non valorizzato';
        
        if(errorCode == 'A_K10')
            errorDesc = 'Valore campo \''+ fieldName + '\' non ammesso';
        
        tt_resp_temp.CodiceErrore = errorCode;
        tt_resp_temp.CausaleErrore = errorDesc;
        
        insert create_EAI_Log(new Map<String,String>{'Type' => 'TT_NACK', 'Codice_errore' => errorCode,
                                                    'Causale_errore' => errorDesc,
                                                    'Codice_operatore' => tt.CODICE_OPERATORE,
                                                    'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,
                                                    'ID_notifica' => tt.ID_NOTIFICA, 'TT_Request' => copy_TT_request(tt),
                                                    'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
         
        return tt_resp_temp;
    }

    public static void create_notify(Case c, Integer notifyType, String causaleScarto, String descr){
        
        
        Recordtype rt, rtServiceLog;      //Trouble Ticket - Notifica di Richiesta Chiusura  
        
        rtServiceLog= [SELECT Id, Name FROM RecordType WHERE Name = 'TroubleTicketNotify'];
        //Reject notify
        if(notifyType == 2){
            //lego al case il primo log creato
            List<EOF_EAI_Service_Log__c> logs =[select Id from EOF_EAI_Service_Log__c where EOF_Codice_Comunicazione_OLO__c=:c.EOF_Codice_Comunicazione_OLO__c 
                                                and RecordType.Name ='TroubleTicketRequest' order by  CreatedDate DESC LIMIT 1];
            if (!logs.isEmpty()){
                logs[0].Caso__c=c.Id;
                update logs[0];
            }
            rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket - Notifica Scarto'];
            //creo la notifica
            notify = new EOF_Notify__c(
                            OF_TT_Tipo_Comunicazione__c=OF_TT_Utils.getStringTipoComunicazione(String.valueOf(notifyType)),
                            EOF_Codice_Operatore__c=c.EOF_Codice_Operatore_WS__c,
                            RecordTypeId = rt.id,
                            Caso__c = c.id,             
                            EOF_Codice_Comunicazione_OLO__c = c.EOF_Codice_Comunicazione_OLO__c,                        
                            EOF_Id_Risorsa__c = c.EOF_ID_RISORSA__c,                            
                            Stato_Ticket__c = 'Scartato',                            
                            EOF_Data_Ora_Scarto__c = OF_TT_Utils.now(),
                            EOF_Data_Notifica__c = OF_TT_Utils.now(),
                            Causale_Scarto__c = causaleScarto,
                            EOF_Descrizione_Causale_Scarto__c = descr,
                          	//EOF_Rischedulazione_Appuntamento__c=c.EOF_Rischedulazione_Appuntamento__c,
                            Updated__c=true
                			 
                        );
            //Debug level only --- In practical cases, notifies will be always correctly generated
            
            insert notify;

            //assegnamo il name all'ID_NOTIFICA
            notify=[select Id, Name, OF_TT_Tipo_Comunicazione__c, EOF_Codice_Operatore__c,EOF_Codice_Comunicazione_OLO__c,
                    EOF_Id_Risorsa__c,Stato_Ticket__c,EOF_Data_Ora_Scarto__c,EOF_Data_Notifica__c,Causale_Scarto__c,EOF_Data_Ora_CREAZIONE__c,
                    EOF_Data_Ora_NOTIFICA_SOSPENSIONE__c,EOF_Data_Ora_NOTIFICA_DESOSPENSIONE__c,EOF_Data_Ora_NOTIFICA_ANNULLAMENTO__c,
                    EOF_DATA_ORA_NOTIFICA_CHIUSURA__c, EOF_DESCRIZIONE_CAUSALE_SCARTO__c,CAUSALE_SOSPENSIONE__c,EOF_REFERENTE_DESOSPENSIONE__c,
                    DESCRIZIONE_EVENTO_RISOLUZIONE__c, EOF_Note__c,EOF_RISCHEDULAZIONE_APPUNTAMENTO__c, EOF_INTERVENTO_CONGIUNTO__c,EOF_TEC_EOF__c,
                    EOF_TEL_TEC_EOF__c,EOF_DATA_ORA_INTERVENTO_CONGIUNTO__c
                    from EOF_Notify__c where id=:notify.Id];
            
            //creo il service log della notifica
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                                        Caso__c = c.Id,
                                        EOF_Codice_Operatore__c = notify.EOF_Codice_Operatore__c,
                                        EOF_Codice_Comunicazione_OLO__c = notify.EOF_Codice_Comunicazione_OLO__c,
                                        RecordTypeId = rtServiceLog.id,
                                        Notify__c = notify.id,
                                        EOF_Richiesta_Notifica__c = copy_TT_notify(notify),
                                        EOF_ID_Notifica__c = notify.Name,
                                        EOF_Data_Notifica__c = notify.EOF_Data_Notifica__c,
                                        EOF_Codice_Errore__c= causaleScarto,
                                        EOF_Tipo_Comunicazione__c='TT - '+OF_TT_Utils.getStringTipoComunicazione(String.valueOf(notifyType))
                						
                                    );
            
            insert sl;
            
            //check se il case è da portale
            if(c.PO_TT_Portale__c){
                OF_TT_Utils.updateSlPortale(String.valueOf(notify.Id));
            }
            else{
                createAckNackNotifyServiceLog(String.valueOf(notify.Id));
            }
            

        }
        
        //Acquisition notify
        if(notifyType == 3){
            //lego al case il primo log creato
            List<EOF_EAI_Service_Log__c> logs =[select Id from EOF_EAI_Service_Log__c where EOF_Codice_Comunicazione_OLO__c=:c.EOF_Codice_Comunicazione_OLO__c 
                                                and RecordType.Name ='TroubleTicketRequest' order by  CreatedDate DESC LIMIT 1];
            if (!logs.isEmpty()){
                logs[0].Caso__c=c.Id;
                update logs[0];
            }

            rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket - Notifica Presa In carico'];
            rtServiceLog= [SELECT Id, Name FROM RecordType WHERE Name = 'TroubleTicketNotify'];
            notify = new EOF_Notify__c(
                            OF_TT_Tipo_Comunicazione__c=OF_TT_Utils.getStringTipoComunicazione(String.valueOf(notifyType)),
                            EOF_Codice_Operatore__c=c.EOF_Codice_Operatore_WS__c,
                            RecordTypeId = rt.id,
                            Caso__c = c.id,             
                            EOF_Codice_Comunicazione_OLO__c = c.EOF_Codice_Comunicazione_OLO__c,                         
                            EOF_Id_Risorsa__c = c.EOF_Id_Risorsa__c,
                            EOF_Data_Notifica__c = OF_TT_Utils.now(),                          
                            Stato_Ticket__c = 'In Lavorazione',
                            EOF_Data_Ora_Creazione__c = OF_TT_Utils.now(),
                            EOF_Rischedulazione_Appuntamento__c=c.EOF_Rischedulazione_Appuntamento__c,
                            Updated__c=true
                			
                        );
        //Debug level only --- In practical cases, notifies will be always correctly generated
        
        insert notify;       

        //assegnamo il name all'ID_NOTIFICA
        notify=[select Id, Name, OF_TT_Tipo_Comunicazione__c, EOF_Codice_Operatore__c,EOF_Codice_Comunicazione_OLO__c,
                    EOF_Id_Risorsa__c,Stato_Ticket__c,EOF_Data_Ora_Scarto__c,EOF_Data_Notifica__c,Causale_Scarto__c,EOF_Data_Ora_CREAZIONE__c,
                    EOF_Data_Ora_NOTIFICA_SOSPENSIONE__c,EOF_Data_Ora_NOTIFICA_DESOSPENSIONE__c,EOF_Data_Ora_NOTIFICA_ANNULLAMENTO__c,
                    EOF_DATA_ORA_NOTIFICA_CHIUSURA__c, EOF_DESCRIZIONE_CAUSALE_SCARTO__c,CAUSALE_SOSPENSIONE__c,EOF_REFERENTE_DESOSPENSIONE__c,
                    DESCRIZIONE_EVENTO_RISOLUZIONE__c, EOF_Note__c,EOF_RISCHEDULAZIONE_APPUNTAMENTO__c, EOF_INTERVENTO_CONGIUNTO__c,EOF_TEC_EOF__c,
                    EOF_TEL_TEC_EOF__c,EOF_DATA_ORA_INTERVENTO_CONGIUNTO__c
                    from EOF_Notify__c where id=:notify.Id];

        //creo il service log della notifica
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                                    Caso__c = c.Id,
                                    EOF_Codice_Operatore__c = notify.EOF_Codice_Operatore__c,
                                    EOF_Codice_Comunicazione_OLO__c = notify.EOF_Codice_Comunicazione_OLO__c,
                                    RecordTypeId = rtServiceLog.id,
                                    Notify__c = notify.id,
                                    EOF_Richiesta_Notifica__c = copy_TT_notify(notify),
                                    EOF_ID_Notifica__c = notify.Name,
                                    EOF_Data_Notifica__c = notify.EOF_Data_Notifica__c,
                                    EOF_Tipo_Comunicazione__c='TT - '+OF_TT_Utils.getStringTipoComunicazione(String.valueOf(notifyType)),
                                    EOF_Codice_Errore__c= causaleScarto,
                                    EOF_Causale_Errore__c=descr            						
                                );
            insert sl;
            //check se il case è da portale
            if(c.PO_TT_Portale__c){
                
                OF_TT_Utils.updateSlPortale(String.valueOf(notify.Id));
            }
            else{
                createAckNackNotifyServiceLog(String.valueOf(notify.Id));
            }
        }
        //Closure notify
        if(notifyType == 5){
            rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket - Notifica di Richiesta Chiusura'];
            notify = new EOF_Notify__c(
                            OF_TT_Tipo_Comunicazione__c=OF_TT_Utils.getStringTipoComunicazione(String.valueOf(notifyType)),
                            EOF_Codice_Operatore__c=c.EOF_Codice_Operatore_WS__c,
                            RecordTypeId = rt.id,
                            Caso__c = c.id,  
                            Descrizione_evento_Risoluzione__c=c.EOF_Descrizione_Intervento_Risoluzione__c,           
                            EOF_Codice_comunicazione_olo__c = c.EOF_Codice_Comunicazione_OLO__c,                         
                            EOF_Id_Risorsa__c = c.EOF_Id_Risorsa__c,                            
                            Stato_ticket__c = 'Richiesta Chiusura',  
                            EOF_Data_Notifica__c  = OF_TT_Utils.now(),                      
                            EOF_Data_Ora_Notifica_Chiusura__c = OF_TT_Utils.now(),                       
                            EOF_Inviata__c = false
                			
                        );
            //Debug level only --- In practical cases, notifies will be always correctly generated
        
            insert notify;
            //il service log della notifica verrà creato in after update dal trigger
                
            
        }
        
        //Suspension notify
        if(notifyType == 4){                
            rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket - Notifica di Sospensione'];
            notify = new EOF_Notify__c(
                            OF_TT_Tipo_Comunicazione__c=OF_TT_Utils.getStringTipoComunicazione(String.valueOf(notifyType)),
                            EOF_Codice_Operatore__c=c.EOF_Codice_Operatore_WS__c,
                            RecordTypeId = rt.id,
                            Caso__c = c.id,             
                            EOF_Codice_comunicazione_olo__c = c.EOF_Codice_Comunicazione_OLO__c,                      
                            EOF_Id_Risorsa__c = c.EOF_Id_Risorsa__c,                          
                            Stato_Ticket__c = 'Sospeso',        
                            EOF_Data_Notifica__c  = OF_TT_Utils.now(),                 
                            EOF_Data_Ora_Notifica_Sospensione__c = OF_TT_Utils.now(),                        
                            EOF_Inviata__c = false
                			
                			
                        );
            //Debug level only --- In practical cases, notifies will be always correctly generated
            
            insert notify;
            
            if(descr=='Invia'){
                notify.updated__C=true;
                notify.EOF_Rischedulazione_Appuntamento__c=OF_TT_Utils.StringToDate(causaleScarto);
                notify.EOF_Referente_Desospensione__c=c.EOF_Referente_Desospensione__c;
                if(c.EOF_Causale_Sospensione__c!='Cliente Irreperibile'){
                    notify.Causale_Sospensione__c=c.EOF_Causale_Sospensione__c;
                }
                else{
                    notify.Causale_Sospensione__c='Cliente Indisponibile';
                }
            update notify;
            
            }
            
        }
        

        //De-suspension notify    
        if(notifyType == 7){
            rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket - Notifica di Desospensione'];
            notify = new EOF_Notify__c(
                            OF_TT_Tipo_Comunicazione__c=OF_TT_Utils.getStringTipoComunicazione(String.valueOf(notifyType)),
                            EOF_Codice_Operatore__c=c.EOF_Codice_Operatore_WS__c,
                            RecordTypeId = rt.id,
                            Caso__c = c.id,             
                            EOF_Codice_comunicazione_olo__c = c.EOF_Codice_Comunicazione_OLO__c,                      
                            EOF_Id_Risorsa__c = c.EOF_Id_Risorsa__c,   
                            EOF_Data_Notifica__c  = OF_TT_Utils.now(),                         
                            Stato_ticket__c = 'In Lavorazione',                           
                            EOF_Data_Ora_Notifica_Desospensione__c = OF_TT_Utils.now(),   
                            EOF_Data_Ora_Notifica_Sospensione__c = c.EOF_Data_Ora_Sospensione__c,  
                            Causale_Sospensione__c=c.EOF_Causale_Sospensione__c,                
                            EOF_Inviata__c = false
                			
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
            
            insert notify;
            
            //vedo se proviene dal trigger per data rischedulazione popolata e in caso faccio scattare il trigger per invio notifica
            if(descr=='Invia'){
                notify.updated__C=true;
                notify.EOF_Referente_Desospensione__c=userinfo.getName();
                notify.EOF_Data_Ora_Notifica_Desospensione__c = c.EOF_Rischedulazione_Appuntamento__c;
            update notify;
            }
            
        }
        
        //Cancellation notify
        if(notifyType == 10){
            rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket - Notifica di Annullamento'];
            notify = new EOF_Notify__c(
                            OF_TT_Tipo_Comunicazione__c=OF_TT_Utils.getStringTipoComunicazione(String.valueOf(notifyType)),
                            EOF_Codice_Operatore__c=c.EOF_Codice_Operatore_WS__c,
                            RecordTypeId = rt.id,
                            Caso__c = c.id,             
                            EOF_Codice_comunicazione_olo__c = c.EOF_Codice_Comunicazione_OLO__c,                      
                            EOF_Id_Risorsa__c = c.EOF_Id_Risorsa__c,                            
                            Stato_ticket__c = 'Annullato',                    
                            EOF_Data_Notifica__c  = OF_TT_Utils.now(),       
                            EOF_Data_Ora_Notifica_Annullamento__c = OF_TT_Utils.now(),
                            EOF_Inviata__c = false
                			
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
            
                insert notify;
               
        
            //vado in update per far scattare il trigger da in annullamento cosi invia la notifica
            /*
            notify.updated__c=true;
            update notify;
            */
            //EC: la classe di test potrebbe andare in errore su questo update
            //
             notify.updated__c=true;
           // try{          
                update notify;   
         /* }
           //  catch(Exception e){
             //System.debug('The following exception has occurred: ' + e.getMessage());
             }
			//06-04-2018 try catch commentati per non alterare le classi EC
			*/

        }
        //timeout OK
        if(notifyType == 13){
            //estraggo la notifica di richiesta chiusura per la data/ora notifica chiusura
            Eof_Notify__c notifyClosure= [select EOF_Data_Ora_Notifica_Chiusura__c from EOF_Notify__c where recordtype.name='Trouble Ticket - Notifica di Richiesta Chiusura'
                                            and EOF_Codice_comunicazione_olo__c =: c.EOF_Codice_Comunicazione_OLO__c and EOF_Inviata__c=true order by createddate desc limit 1]; //AS ADD  and EOF_Inviata__c=true order by createddate desc limit 1
            rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket - Notifica di TimeoutOK'];
            notify = new EOF_Notify__c(
                            OF_TT_Tipo_Comunicazione__c=OF_TT_Utils.getStringTipoComunicazione(String.valueOf(notifyType)),
                            EOF_Codice_Operatore__c=c.EOF_Codice_Operatore_WS__c,
                            RecordTypeId = rt.id,
                            Caso__c = c.id, 
                            EOF_Note__c=c.EOF_Note__c,
                            Descrizione_Evento_Risoluzione__c=c.EOF_Descrizione_Intervento_Risoluzione__c,            
                            EOF_Codice_comunicazione_olo__c = c.EOF_Codice_Comunicazione_OLO__c,   
                            EOF_Data_Notifica__c  = OF_TT_Utils.now(),                 
                            EOF_Id_Risorsa__c = c.EOF_Id_Risorsa__c,                            
                            Stato_ticket__c = 'Chiuso',                          
                            EOF_Data_Ora_Notifica_Chiusura__c = notifyClosure.EOF_Data_Ora_Notifica_Chiusura__c,
                            EOF_Inviata__c = false
                        );
                        //Debug level only --- In practical cases, notifies will be always correctly generated
            
                insert notify;
               
        
            //vado in update per far scattare il trigger da in Richiesta Chiusura cosi invia la notifica
            notify.updated__c=true;
            update notify;            
        }
                    
    }
    
    /* TO DO: Clonare il contenuto del metodo updateSlPortale ed AGGIUNGERE l'integrazione con il ws OUTBOUND: 
    	        	OF_TTM_WS_OUT_Sincronizzazione
    	 			OF_TTM_WS_OUT_Notifica
    	 Nello specifico la request dovrà essere organizzata in 4 element:
    	            public OF_TTM_WS_OUT_Notifica.TroubleTicketNotify_element TroubleTicketNotify; :: VUOTO.
			        public String ID_REQ_FORWARD2TTM;  :: Valorizzare con l'ID della Notify.
			        public String REQ_FORWARD2TTM;     :: Richiamare il metodo della classe OF_TT_WS_Notifica_Request_TTM in base al tipo di comunicazione.
			        public String TIPO_COMUNICAZIONE_FORWARD2TTM;  :: Valorizzare con: OF_TTM_WS_Notify_Utils.getTipoComunicazioneByString(Notify.OF_TT_Tipo_Comunicazione__c) -->
			                                                          NB_GB            OF_TTM_WS_Notify_Utils.obj.getKeyByValue_TipoComunicazione(Notify.OF_TT_Tipo_Comunicazione__c)
        */
    //------------Method to create ack/nack log for TTM notify PORTALE    
    public static void updateSlPortale_TTeTTM(String idnotifyRec){
       
    	EOF_Notify__c notifyRec = [SELECT Caso__c,Caso__r.status,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                         EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                         EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                         EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                         EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                         EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                         Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c,OF_TT_Tipo_Comunicazione__c,
                         EOF_Codice_Comunicazione_OLO__c, Stato_Ticket__c,EOF_Data_Ora_Scarto__c, EOF_Data_Ora_Creazione__c, EOF_Data_Ora_Notifica_Sospensione__c,EOF_Data_Ora_Notifica_Desospensione__c,
                         EOF_Data_Ora_Notifica_Annullamento__c, EOF_Data_Ora_Notifica_Chiusura__c,Causale_Scarto__c, EOF_Descrizione_Causale_Scarto__c, Causale_Sospensione__c,
                         EOF_Referente_desospensione__c,Descrizione_Evento_Risoluzione__c,EOF_Rischedulazione_Appuntamento__c,EOF_Intervento_Congiunto__c,EOF_Tec_Eof__c,
                         EOF_Tel_Tec_Eof__c,EOF_Data_Ora_Intervento_Congiunto__c FROM EOF_Notify__c where id=: idnotifyrec];
     
     //inserisco l'ACK finto da restituire a OLO
     recordtype rt_Ack1 = [select id from recordtype where developername='TT_ACK'];
     EOF_EAI_Service_Log__c ackLog1 = new EOF_EAI_Service_Log__c(
                Caso__c = notifyRec.Caso__c,
                RecordTypeId = rt_Ack1.id,
                Notify__c = notifyRec.id,
                EOF_Richiesta_Notifica__c =  'Esito: 0',     
                EOF_ID_Notifica__c = notifyRec.Name,
                EOF_Codice_Operatore__c = notifyRec.EOF_Codice_Operatore__c,
                EOF_Data_Notifica__c = notifyRec.EOF_Data_Notifica__c,
                EOF_Tipo_Comunicazione__c='TT - ACK - '+notifyRec.OF_TT_Tipo_Comunicazione__c,
                EOF_Codice_Comunicazione_OLO__c=notifyRec.EOF_Codice_Comunicazione_OLO__c       
            ); 
            
     
    EOF_EAI_Service_Log__c slPortale = [select id from EOF_EAI_Service_Log__c where recordtype.developername='PO_TT_TroubleTicketRequest' AND EOF_Codice_Comunicazione_OLO__c=:notifyRec.EOF_Codice_Comunicazione_OLO__c
                                        AND (EOF_Stato_Richiesta__c='In Inserimento' OR EOF_Stato_Richiesta__c='Inserita Portale')];
    slPortale.EOF_ID_Notifica__c=notifyRec.Name;
    slPortale.EOF_STATO_ORDINE__c=notifyRec.Caso__r.status;
    if(notifyRec.EOF_Data_Ora_Scarto__c!=null){
        slPortale.EOF_Data_Ora_Scarto__c =notifyRec.EOF_Data_Ora_Scarto__c;
    } 
    if(notifyRec.EOF_Data_Ora_Creazione__c!=null){
        slPortale.EOF_Data_Ora_Creazione__c =notifyRec.EOF_Data_Ora_Creazione__c;
    }
    if(notifyRec.EOF_Data_Ora_Notifica_Sospensione__c!=null){
        slPortale.EOF_Data_Ora_Notifica_Sospensione__c =notifyRec.EOF_Data_Ora_Notifica_Sospensione__c;
    }
    if(notifyRec.EOF_Data_Ora_Notifica_Desospensione__c!=null){
        slPortale.EOF_Data_Ora_Notifica_Desospensione__c =notifyRec.EOF_Data_Ora_Notifica_Desospensione__c;
    }
    if(notifyRec.EOF_Data_Ora_Notifica_Annullamento__c!=null){
        slPortale.EOF_Data_Ora_Notifica_Annullamento__c =notifyRec.EOF_Data_Ora_Notifica_Annullamento__c;
    }
    if(notifyRec.EOF_Data_Ora_Notifica_Chiusura__c!=null){
        slPortale.EOF_Data_Ora_Notifica_Chiusura__c =notifyRec.EOF_Data_Ora_Notifica_Chiusura__c;
    }
    if(!String.isBlank(notifyRec.Causale_Scarto__c)){
        slPortale.Causale_Scarto__c =notifyRec.Causale_Scarto__c;
    }
    if(!String.isBlank(notifyRec.EOF_Descrizione_Causale_Scarto__c)){
        slPortale.EOF_Descrizione_Causale_Scarto__c =notifyRec.EOF_Descrizione_Causale_Scarto__c;
    }
    if(!String.isBlank(notifyRec.Causale_Sospensione__c)){
        slPortale.Causale_Sospensione__c =notifyRec.Causale_Sospensione__c;
    }
    if(!String.isBlank(notifyRec.EOF_Referente_desospensione__c)){
        slPortale.EOF_Referente_desospensione__c =notifyRec.EOF_Referente_desospensione__c;
    }
    if(!String.isBlank(notifyRec.Descrizione_Evento_Risoluzione__c)){
        slPortale.Descrizione_Evento_Risoluzione__c =notifyRec.Descrizione_Evento_Risoluzione__c;
    }
    if(notifyRec.EOF_Rischedulazione_Appuntamento__c!=null){
        slPortale.EOF_Rischedulazione_Appuntamento__c =notifyRec.EOF_Rischedulazione_Appuntamento__c;
    }
    if(!String.isBlank(notifyRec.EOF_Intervento_Congiunto__c)){
        slPortale.EOF_Intervento_Congiunto__c =notifyRec.EOF_Intervento_Congiunto__c;
    }
    if(!String.isBlank(notifyRec.EOF_Tec_Eof__c)){
        slPortale.EOF_Tec_Eof__c =notifyRec.EOF_Tec_Eof__c;
    }
    if(!String.isBlank(notifyRec.EOF_Tel_Tec_Eof__c)){
        slPortale.EOF_Tel_Tec_Eof__c =notifyRec.EOF_Tel_Tec_Eof__c;
    }
    if(notifyRec.EOF_Data_Ora_Intervento_Congiunto__c!=null){
        slPortale.EOF_Data_Ora_Intervento_Congiunto__c =notifyRec.EOF_Data_Ora_Intervento_Congiunto__c;
    }
    slPortale.EOF_Note__c =notifyRec.EOF_Note__c;
    
    //faccio una lista dove inserisco entrambi i log (ACK e portale)
    List<EOF_EAI_Service_Log__c> slListToUpsert = new List<EOF_EAI_Service_Log__c>();
    slListToUpsert.add(ackLog1);
    slListToUpsert.add(slPortale);
    upsert slListToUpsert; 
    
    
    // 23/03/2018 MM : inizio modifiche per integrazione con TTM
     
 		String ID_REQ_FORWARD2TTM;
		String REQ_FORWARD2TTM;
		String TIPO_COMUNICAZIONE_FORWARD2TTM;	
     
 		ID_REQ_FORWARD2TTM = notifyRec.id;
     
		OF_TT_WS_Notifica_Request_TTM nrt = new OF_TT_WS_Notifica_Request_TTM(notifyRec,'');
		
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_RICHIESTA_RISOLUZIONE_GUASTO){
				nrt.CreateNewTT();
				REQ_FORWARD2TTM = nrt.requestTTM;
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_NOTIFICA_SCARTO){
				nrt.DiscardTicket();
				REQ_FORWARD2TTM = nrt.requestTTM;				
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_RICHIESTA_DESOSPENSIONE){
				nrt.ResumeTicket();
				REQ_FORWARD2TTM = nrt.requestTTM;
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_RICHIESTA_AUTORIPRISTINATO){
				nrt.AutoResetToClosed('','');
				REQ_FORWARD2TTM = nrt.requestTTM;
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_RICHIESTA_ANNULLAMENTO){
				nrt.Cancel();
				REQ_FORWARD2TTM = nrt.requestTTM;
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_TEST_KO){
				nrt.TestKO();
				REQ_FORWARD2TTM = nrt.requestTTM;
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_TEST_OK){
				nrt.TestOKRequestToClose();
				REQ_FORWARD2TTM = nrt.requestTTM;				
			}			

            
            TIPO_COMUNICAZIONE_FORWARD2TTM = OF_TTM_WS_Notify_Utils.obj.getKeyByValue_TipoComunicazione(notifyRec.OF_TT_Tipo_Comunicazione__c);
            
            OF_TTM_WS_OUT_Notifica.TroubleTicketNotify_element TroubleTicketNotify = new OF_TTM_WS_OUT_Notifica.TroubleTicketNotify_element();
            
            OF_TTM_WS_OUT_Sincronizzazione.SyncPortTypeEndpoint1 stub = new OF_TTM_WS_OUT_Sincronizzazione.SyncPortTypeEndpoint1();          
            stub.timeout_x=30000; 
            OF_TTM_WS_OUT_Notifica.TroubleTicketNotifyResp_element response = new OF_TTM_WS_OUT_Notifica.TroubleTicketNotifyResp_element();
        
            //Invoking the callout with corresponding parameters
            
          	response = stub.NotifyTroubleTicket(TroubleTicketNotify, ID_REQ_FORWARD2TTM, REQ_FORWARD2TTM, TIPO_COMUNICAZIONE_FORWARD2TTM);
          	
          	//GB: TODO e della Response NON LA SALVI DA NESSUNA PARTE????????
            RecordType rt_Ack = [SELECT Id FROM RecordType WHERE Name = 'TT - ACK' LIMIT 1];
            RecordType rt_Nack = [SELECT Id FROM RecordType WHERE Name = 'TT - NACK' LIMIT 1];

          	
	        system.debug('The value of response--' + response);
	        //Creating EAI_Service_Logs based on the response
	        if(Integer.valueOf(response.Esito) == 0){
	            EOF_EAI_Service_Log__c ackLog = new EOF_EAI_Service_Log__c(
	                Caso__c = notifyRec.Caso__c,
	                RecordTypeId = rt_Ack.id,
	                Notify__c = notifyRec.id,
	                EOF_Richiesta_Notifica__c =  'Esito:'+ response.Esito,     
	                EOF_ID_Notifica__c = notifyRec.Name,
	                EOF_Codice_Operatore__c = notifyRec.EOF_Codice_Operatore__c,
	                EOF_Data_Notifica__c = notifyRec.EOF_Data_Notifica__c,
	                EOF_Tipo_Comunicazione__c='TT - ACK - '+notifyRec.OF_TT_Tipo_Comunicazione__c,
	                EOF_Codice_Comunicazione_OLO__c=notifyRec.EOF_Codice_Comunicazione_OLO__c       
	            ); 
	            insert ackLog;
	        }
	        else{
	            EOF_EAI_Service_Log__c nackLog = new EOF_EAI_Service_Log__c(
	                Caso__c = notifyRec.Caso__c,
	                RecordTypeId = rt_Nack.id,
	                Notify__c = notifyRec.id,
	                EOF_Richiesta_Notifica__c = 'Esito:'+ response.Esito + '\n' + 'Codice errore: ' + 
	                                             response.CodiceErrore + '\n' + 'Causale errore: ' +
	                                             response.CausaleErrore,
	                EOF_Codice_errore__c=response.CodiceErrore,
	                EOF_Causale_Errore__c=response.CausaleErrore,     
	                EOF_ID_Notifica__c = notifyRec.Name,
	                EOF_Codice_Operatore__c = notifyRec.EOF_Codice_Operatore__c,
	                EOF_Data_Notifica__c = notifyRec.EOF_Data_Notifica__c,
	                EOF_Tipo_Comunicazione__c='TT - NACK - '+notifyRec.OF_TT_Tipo_Comunicazione__c,
	                EOF_Codice_Comunicazione_OLO__c=notifyRec.EOF_Codice_Comunicazione_OLO__c       
	           ); 
	           insert nackLog;                
	        }          	
          	
	//23/03/2018 MM : fine modifiche integrazione con TTM
	}
    
    public static void updateSlPortale(String idnotifyRec){
        EOF_Notify__c notifyRec = [SELECT Caso__c,Caso__r.status,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c,OF_TT_Tipo_Comunicazione__c,
                                     EOF_Codice_Comunicazione_OLO__c, Stato_Ticket__c,EOF_Data_Ora_Scarto__c, EOF_Data_Ora_Creazione__c, EOF_Data_Ora_Notifica_Sospensione__c,EOF_Data_Ora_Notifica_Desospensione__c,
                                     EOF_Data_Ora_Notifica_Annullamento__c, EOF_Data_Ora_Notifica_Chiusura__c,Causale_Scarto__c, EOF_Descrizione_Causale_Scarto__c, Causale_Sospensione__c,
                                     EOF_Referente_desospensione__c,Descrizione_Evento_Risoluzione__c,EOF_Rischedulazione_Appuntamento__c,EOF_Intervento_Congiunto__c,EOF_Tec_Eof__c,
                                     EOF_Tel_Tec_Eof__c,EOF_Data_Ora_Intervento_Congiunto__c FROM EOF_Notify__c where id=: idnotifyrec];
         
         //inserisco l'ACK finto da restituire a OLO
         recordtype rt_Ack = [select id from recordtype where developername='TT_ACK'];
         EOF_EAI_Service_Log__c ackLog = new EOF_EAI_Service_Log__c(
                    Caso__c = notifyRec.Caso__c,
                    RecordTypeId = rt_Ack.id,
                    Notify__c = notifyRec.id,
                    EOF_Richiesta_Notifica__c =  'Esito: 0',     
                    EOF_ID_Notifica__c = notifyRec.Name,
                    EOF_Codice_Operatore__c = notifyRec.EOF_Codice_Operatore__c,
                    EOF_Data_Notifica__c = notifyRec.EOF_Data_Notifica__c,
                    EOF_Tipo_Comunicazione__c='TT - ACK - '+notifyRec.OF_TT_Tipo_Comunicazione__c,
                    EOF_Codice_Comunicazione_OLO__c=notifyRec.EOF_Codice_Comunicazione_OLO__c       
                ); 
                
         
         EOF_EAI_Service_Log__c slPortale = [select id from EOF_EAI_Service_Log__c where recordtype.developername='PO_TT_TroubleTicketRequest' AND EOF_Codice_Comunicazione_OLO__c=:notifyRec.EOF_Codice_Comunicazione_OLO__c
                                            AND (EOF_Stato_Richiesta__c='In Inserimento' OR EOF_Stato_Richiesta__c='Inserita Portale')];
        slPortale.EOF_ID_Notifica__c=notifyRec.Name;
        slPortale.EOF_STATO_ORDINE__c=notifyRec.Caso__r.status;
        if(notifyRec.EOF_Data_Ora_Scarto__c!=null){
            slPortale.EOF_Data_Ora_Scarto__c =notifyRec.EOF_Data_Ora_Scarto__c;
        } 
        if(notifyRec.EOF_Data_Ora_Creazione__c!=null){
            slPortale.EOF_Data_Ora_Creazione__c =notifyRec.EOF_Data_Ora_Creazione__c;
        }
        if(notifyRec.EOF_Data_Ora_Notifica_Sospensione__c!=null){
            slPortale.EOF_Data_Ora_Notifica_Sospensione__c =notifyRec.EOF_Data_Ora_Notifica_Sospensione__c;
        }
        if(notifyRec.EOF_Data_Ora_Notifica_Desospensione__c!=null){
            slPortale.EOF_Data_Ora_Notifica_Desospensione__c =notifyRec.EOF_Data_Ora_Notifica_Desospensione__c;
        }
        if(notifyRec.EOF_Data_Ora_Notifica_Annullamento__c!=null){
            slPortale.EOF_Data_Ora_Notifica_Annullamento__c =notifyRec.EOF_Data_Ora_Notifica_Annullamento__c;
        }
        if(notifyRec.EOF_Data_Ora_Notifica_Chiusura__c!=null){
            slPortale.EOF_Data_Ora_Notifica_Chiusura__c =notifyRec.EOF_Data_Ora_Notifica_Chiusura__c;
        }
        if(!String.isBlank(notifyRec.Causale_Scarto__c)){
            slPortale.Causale_Scarto__c =notifyRec.Causale_Scarto__c;
        }
        if(!String.isBlank(notifyRec.EOF_Descrizione_Causale_Scarto__c)){
            slPortale.EOF_Descrizione_Causale_Scarto__c =notifyRec.EOF_Descrizione_Causale_Scarto__c;
        }
        if(!String.isBlank(notifyRec.Causale_Sospensione__c)){
            slPortale.Causale_Sospensione__c =notifyRec.Causale_Sospensione__c;
        }
        if(!String.isBlank(notifyRec.EOF_Referente_desospensione__c)){
            slPortale.EOF_Referente_desospensione__c =notifyRec.EOF_Referente_desospensione__c;
        }
        if(!String.isBlank(notifyRec.Descrizione_Evento_Risoluzione__c)){
            slPortale.Descrizione_Evento_Risoluzione__c =notifyRec.Descrizione_Evento_Risoluzione__c;
        }
        if(notifyRec.EOF_Rischedulazione_Appuntamento__c!=null){
            slPortale.EOF_Rischedulazione_Appuntamento__c =notifyRec.EOF_Rischedulazione_Appuntamento__c;
        }
        if(!String.isBlank(notifyRec.EOF_Intervento_Congiunto__c)){
            slPortale.EOF_Intervento_Congiunto__c =notifyRec.EOF_Intervento_Congiunto__c;
        }
        if(!String.isBlank(notifyRec.EOF_Tec_Eof__c)){
            slPortale.EOF_Tec_Eof__c =notifyRec.EOF_Tec_Eof__c;
        }
        if(!String.isBlank(notifyRec.EOF_Tel_Tec_Eof__c)){
            slPortale.EOF_Tel_Tec_Eof__c =notifyRec.EOF_Tel_Tec_Eof__c;
        }
        if(notifyRec.EOF_Data_Ora_Intervento_Congiunto__c!=null){
            slPortale.EOF_Data_Ora_Intervento_Congiunto__c =notifyRec.EOF_Data_Ora_Intervento_Congiunto__c;
        }
        slPortale.EOF_Note__c =notifyRec.EOF_Note__c;
        
        //faccio una lista dove inserisco entrambi i log (ACK e portale)
        List<EOF_EAI_Service_Log__c> slListToUpsert = new List<EOF_EAI_Service_Log__c>();
        slListToUpsert.add(ackLog);
        slListToUpsert.add(slPortale);
        upsert slListToUpsert;
    }
    
    @Future(callout=true)
    //------------Method to create ack/nack log for TTM notify
    /* TO DO: Clonare il contenuto del metodo createAckNackNotifyServiceLog e poi modificarlo in modo che il ws OUTBOUND richiamato sia il nuovo servizio: 
    	        	OF_TTM_WS_OUT_Sincronizzazione
    	 			OF_TTM_WS_OUT_Notifica
    	 Nello specifico la request dovrà essere organizzata in 4 element:
    	            public OF_TTM_WS_OUT_Notifica.TroubleTicketNotify_element TroubleTicketNotify; :: Lasciare la logica esistente.
			        public String ID_REQ_FORWARD2TTM;  :: Valorizzare con l'ID della Notify.
			        public String REQ_FORWARD2TTM;     :: Richiamare il metodo della classe OF_TT_WS_Notifica_Request_TTM in base al tipo di comunicazione.
			        public String TIPO_COMUNICAZIONE_FORWARD2TTM;  :: Valorizzare con: OF_TTM_WS_Notify_Utils.getTipoComunicazioneByString(Notify.OF_TT_Tipo_Comunicazione__c)
                                                                                NB_GB: OF_TTM_WS_Notify_Utils.obj.getKeyByValue_TipoComunicazione(Notify.OF_TT_Tipo_Comunicazione__c) */                   
    public static void createAckNackNotify_TTeTTM_ServiceLog(String idnotifyRec){
   	
            RecordType rt_Ack = [SELECT Id FROM RecordType WHERE Name = 'TT - ACK' LIMIT 1];
            RecordType rt_Nack = [SELECT Id FROM RecordType WHERE Name = 'TT - NACK' LIMIT 1];
        
            EOF_Notify__c notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c,OF_TT_Tipo_Comunicazione__c,
                                     EOF_Codice_Comunicazione_OLO__c, Stato_Ticket__c,EOF_Data_Ora_Scarto__c, EOF_Data_Ora_Creazione__c, EOF_Data_Ora_Notifica_Sospensione__c,EOF_Data_Ora_Notifica_Desospensione__c,
                                     EOF_Data_Ora_Notifica_Annullamento__c, EOF_Data_Ora_Notifica_Chiusura__c,Causale_Scarto__c, EOF_Descrizione_Causale_Scarto__c, Causale_Sospensione__c,
                                     EOF_Referente_desospensione__c,Descrizione_Evento_Risoluzione__c,EOF_Rischedulazione_Appuntamento__c,EOF_Intervento_Congiunto__c,EOF_Tec_Eof__c,
                                     EOF_Tel_Tec_Eof__c,EOF_Data_Ora_Intervento_Congiunto__c FROM EOF_Notify__c where id=: idnotifyrec];
            
			// 23/03/2018 MM : modifiche per integrazione con TTM:
			
    		String ID_REQ_FORWARD2TTM;
			String REQ_FORWARD2TTM;
			String TIPO_COMUNICAZIONE_FORWARD2TTM;	
			
			ID_REQ_FORWARD2TTM = notifyRec.id;
			
			OF_TT_WS_Notifica_Request_TTM nrt = new OF_TT_WS_Notifica_Request_TTM(notifyRec,'');
			
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_RICHIESTA_RISOLUZIONE_GUASTO){
				nrt.CreateNewTT();
				REQ_FORWARD2TTM = nrt.requestTTM;
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_NOTIFICA_SCARTO){
				nrt.DiscardTicket();
				REQ_FORWARD2TTM = nrt.requestTTM;				
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_RICHIESTA_DESOSPENSIONE){
				nrt.ResumeTicket();
				REQ_FORWARD2TTM = nrt.requestTTM;
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_RICHIESTA_AUTORIPRISTINATO){
				nrt.AutoResetToClosed('','');
				REQ_FORWARD2TTM = nrt.requestTTM;
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_RICHIESTA_ANNULLAMENTO){
				nrt.Cancel();
				REQ_FORWARD2TTM = nrt.requestTTM;
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_TEST_KO){
				nrt.TestKO();
				REQ_FORWARD2TTM = nrt.requestTTM;
			}
			if(notifyRec.OF_TT_Tipo_Comunicazione__c == OF_TTM_WS_WRAP_Utility.NOTIFY_TEST_OK){
				nrt.TestOKRequestToClose();
				REQ_FORWARD2TTM = nrt.requestTTM;				
			}			

            
            TIPO_COMUNICAZIONE_FORWARD2TTM = OF_TTM_WS_Notify_Utils.obj.getKeyByValue_TipoComunicazione(notifyRec.OF_TT_Tipo_Comunicazione__c);
            
            OF_TTM_WS_OUT_Notifica.TroubleTicketNotify_element TroubleTicketNotify = new OF_TTM_WS_OUT_Notifica.TroubleTicketNotify_element();
            
            OF_TTM_WS_OUT_Sincronizzazione.SyncPortTypeEndpoint1 stub = new OF_TTM_WS_OUT_Sincronizzazione.SyncPortTypeEndpoint1();          
            stub.timeout_x=30000; 
            OF_TTM_WS_OUT_Notifica.TroubleTicketNotifyResp_element response = new OF_TTM_WS_OUT_Notifica.TroubleTicketNotifyResp_element();
        	
            //Invoking the callout with corresponding parameters
            
          	response = stub.NotifyTroubleTicket(TroubleTicketNotify, ID_REQ_FORWARD2TTM, REQ_FORWARD2TTM, TIPO_COMUNICAZIONE_FORWARD2TTM);
    		
    		// 23/03/2018 MM : fine modifiche per integrazione con TTM
    		
        system.debug('The value of response--' + response);
        //Creating EAI_Service_Logs based on the response
        if(Integer.valueOf(response.Esito) == 0){
            EOF_EAI_Service_Log__c ackLog = new EOF_EAI_Service_Log__c(
                Caso__c = notifyRec.Caso__c,
                RecordTypeId = rt_Ack.id,
                Notify__c = notifyRec.id,
                EOF_Richiesta_Notifica__c =  'Esito:'+ response.Esito,     
                EOF_ID_Notifica__c = notifyRec.Name,
                EOF_Codice_Operatore__c = notifyRec.EOF_Codice_Operatore__c,
                EOF_Data_Notifica__c = notifyRec.EOF_Data_Notifica__c,
                EOF_Tipo_Comunicazione__c='TT - ACK - '+notifyRec.OF_TT_Tipo_Comunicazione__c,
                EOF_Codice_Comunicazione_OLO__c=notifyRec.EOF_Codice_Comunicazione_OLO__c       
            ); 
            insert ackLog;
        }
        else{
            EOF_EAI_Service_Log__c nackLog = new EOF_EAI_Service_Log__c(
                Caso__c = notifyRec.Caso__c,
                RecordTypeId = rt_Nack.id,
                Notify__c = notifyRec.id,
                EOF_Richiesta_Notifica__c = 'Esito:'+ response.Esito + '\n' + 'Codice errore: ' + 
                                             response.CodiceErrore + '\n' + 'Causale errore: ' +
                                             response.CausaleErrore,
                EOF_Codice_errore__c=response.CodiceErrore,
                EOF_Causale_Errore__c=response.CausaleErrore,     
                EOF_ID_Notifica__c = notifyRec.Name,
                EOF_Codice_Operatore__c = notifyRec.EOF_Codice_Operatore__c,
                EOF_Data_Notifica__c = notifyRec.EOF_Data_Notifica__c,
                EOF_Tipo_Comunicazione__c='TT - NACK - '+notifyRec.OF_TT_Tipo_Comunicazione__c,
                EOF_Codice_Comunicazione_OLO__c=notifyRec.EOF_Codice_Comunicazione_OLO__c       
           ); 
           insert nackLog;                
        } 
        
            
  	}
      
    @Future(callout=true)
    //------------Method to create ack/nack log for TT notify
    public static void createAckNackNotifyServiceLog(String idnotifyRec){
            
            system.debug('@@@@@@@@@@@@@@@ entra nel metodo per l invio');
            RecordType rt_Ack = [SELECT Id FROM RecordType WHERE Name = 'TT - ACK' LIMIT 1];
            RecordType rt_Nack = [SELECT Id FROM RecordType WHERE Name = 'TT - NACK' LIMIT 1];
        
            EOF_Notify__c notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c,OF_TT_Tipo_Comunicazione__c,
                                     EOF_Codice_Comunicazione_OLO__c, Stato_Ticket__c,EOF_Data_Ora_Scarto__c, EOF_Data_Ora_Creazione__c, EOF_Data_Ora_Notifica_Sospensione__c,EOF_Data_Ora_Notifica_Desospensione__c,
                                     EOF_Data_Ora_Notifica_Annullamento__c, EOF_Data_Ora_Notifica_Chiusura__c,Causale_Scarto__c, EOF_Descrizione_Causale_Scarto__c, Causale_Sospensione__c,
                                     EOF_Referente_desospensione__c,Descrizione_Evento_Risoluzione__c,EOF_Rischedulazione_Appuntamento__c,EOF_Intervento_Congiunto__c,EOF_Tec_Eof__c,
                                     EOF_Tel_Tec_Eof__c,EOF_Data_Ora_Intervento_Congiunto__c FROM EOF_Notify__c where id=: idnotifyrec];
            

            OF_TT_WS_Sincronizzazione.SyncPortTypeEndpoint1 stub = new OF_TT_WS_Sincronizzazione.SyncPortTypeEndpoint1();          
            stub.timeout_x=30000; 
            OF_TT_WS_Notifica.TroubleTicketNotifyResp_element response = new OF_TT_WS_Notifica.TroubleTicketNotifyResp_element();
            
            //Invoking the callout with corresponding parameters
            
            response = stub.NotifyTroubleTicket(notifyRec.EOF_Codice_Operatore__c,
                                        OF_TT_Utils.getValueTipoComunicazione(notifyRec.OF_TT_Tipo_Comunicazione__c), 
                                        notifyRec.EOF_Codice_Comunicazione_OLO__c,                                                                        
                                        notifyRec.Name,
                                        notifyRec.EOF_ID_Risorsa__c,
                                        OF_TT_Utils.getValueStatoTicket(notifyRec.Stato_Ticket__c),
                                        OF_TT_Utils.dateToString(notifyRec.EOF_Data_Ora_Scarto__c),
                                        OF_TT_Utils.dateToString(notifyRec.EOF_Data_Ora_Creazione__c),
                                        OF_TT_Utils.dateToString(notifyRec.EOF_Data_Ora_Notifica_Sospensione__c),
                                        OF_TT_Utils.dateToString(notifyRec.EOF_Data_Ora_Notifica_Desospensione__c),
                                        OF_TT_Utils.dateToString(notifyRec.EOF_Data_Ora_Notifica_Annullamento__c),
                                        OF_TT_Utils.dateToString(notifyRec.EOF_Data_Ora_Notifica_Chiusura__c),
                                        OF_TT_Utils.getValueCausaleScarto(notifyRec.Causale_Scarto__c),
                                        notifyRec.EOF_Descrizione_Causale_Scarto__c,
                                        OF_TT_Utils.getValueCausaleSospensione(notifyRec.Causale_Sospensione__c),
                                        notifyRec.EOF_Referente_desospensione__c,
                                        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione(notifyRec.Descrizione_Evento_Risoluzione__c),
                                        notifyRec.EOF_Note__c,
                                        OF_TT_Utils.dateToString(notifyRec.EOF_Rischedulazione_Appuntamento__c),
                                        notifyRec.EOF_Intervento_Congiunto__c,
                                        notifyRec.EOF_Tec_Eof__c,
                                        notifyRec.EOF_Tel_Tec_Eof__c,
                                        OF_TT_Utils.dateToString(notifyRec.EOF_Data_Ora_Intervento_Congiunto__c)
                                        );
        
            system.debug('The value of response--' + response);
            //Creating EAI_Service_Logs based on the response
        if(Test.isRunningTest()){
              OF_TT_WS_Notifica.TroubleTicketNotifyResp_element response1 = new OF_TT_WS_Notifica.TroubleTicketNotifyResp_element();
           		
            response1.Esito ='0';
            response=response1;
            
            	
        }
            if(Integer.valueOf(response.Esito) == 0){
                
                EOF_EAI_Service_Log__c ackLog = new EOF_EAI_Service_Log__c(
                    Caso__c = notifyRec.Caso__c,
                    RecordTypeId = rt_Ack.id,
                    Notify__c = notifyRec.id,
                    EOF_Richiesta_Notifica__c =  'Esito:'+ response.Esito,     
                    EOF_ID_Notifica__c = notifyRec.Name,
                    EOF_Codice_Operatore__c = notifyRec.EOF_Codice_Operatore__c,
                    EOF_Data_Notifica__c = notifyRec.EOF_Data_Notifica__c,
                    EOF_Tipo_Comunicazione__c='TT - ACK - '+notifyRec.OF_TT_Tipo_Comunicazione__c,
                    EOF_Codice_Comunicazione_OLO__c=notifyRec.EOF_Codice_Comunicazione_OLO__c       
                ); 
                insert ackLog;
            }
            else{
                EOF_EAI_Service_Log__c nackLog = new EOF_EAI_Service_Log__c(
                    Caso__c = notifyRec.Caso__c,
                    RecordTypeId = rt_Nack.id,
                    Notify__c = notifyRec.id,
                    EOF_Richiesta_Notifica__c = 'Esito:'+ response.Esito + '\n' + 'Codice errore: ' + 
                                                 response.CodiceErrore + '\n' + 'Causale errore: ' +
                                                 response.CausaleErrore,
                    EOF_Codice_errore__c=response.CodiceErrore,
                    EOF_Causale_Errore__c=response.CausaleErrore,     
                    EOF_ID_Notifica__c = notifyRec.Name,
                    EOF_Codice_Operatore__c = notifyRec.EOF_Codice_Operatore__c,
                    EOF_Data_Notifica__c = notifyRec.EOF_Data_Notifica__c,
                    EOF_Tipo_Comunicazione__c='TT - NACK - '+notifyRec.OF_TT_Tipo_Comunicazione__c,
                    EOF_Codice_Comunicazione_OLO__c=notifyRec.EOF_Codice_Comunicazione_OLO__c       
               ); 
               insert nackLog;                
            } 
            
            
                
      }
      
}
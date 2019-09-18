public class PO_COMP_CessazioneInserita_Controller {
    public EOF_EAI_Service_Log__c sl{get;set;}
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
    public List<EOF_EAI_Service_Log__c> SlApparati{get;set;}
    public boolean Apparati{get;set;}
    public boolean confirmPage{get;set;} 
    public String IdApparato{get;set;} 
    public boolean success{get;set;}
    public boolean error{get;set;}
    public String motivoErr{get;set;}
    
    public PO_COMP_CessazioneInserita_Controller(){
        Apparati=false;
        sl=slOrig;
        
        if(ApexPages.currentPage().getParameters().get('proc') =='confirmPageCESS'){
        	confirmPage=true;
        }
        if(ApexPages.currentPage().getParameters().get('proc') =='successInsertCESS'){
        	success=true;
        	confirmPage=true;
        }
        if(ApexPages.currentPage().getParameters().get('proc') =='errorInsertCESS'){
        	error=true;
        	motivoErr=ApexPages.currentPage().getParameters().get('motivo');
        	confirmPage=true;
        }
        
        List<EOF_EAI_Service_Log__c> slList = [select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                                                    OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,
                                                    OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,OF_SA_ID_APPARATO__c
                                                    from EOF_EAI_Service_Log__c where OF_SA_Cpe_Log__c=:slOrig.Id];
        if(!slList.isEmpty()){
          	Apparati=true;
            SlApparati=new List<EOF_EAI_Service_Log__c>();
            
            for(EOF_EAI_Service_Log__c slAgg : slList){
                SlApparati.add(slAgg);
            }
           
        }
    }
    
    
    
    public pageReference editslCESS(){
    
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        pg.getParameters().put('proc','editCessazione');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    public pageReference deleteslCESS(){
        delete sl;
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        return pg;
    }
    public pageReference inserisciApparatoCESS(){
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        pg.getParameters().put('proc','insApp');
        pg.getParameters().put('orig','CESS');
        pg.getParameters().put('origID',sl.Id);
        pg.getParameters().put('codOrdOlo',sl.EOF_Codice_Ordine_OLO__c);
        return pg;
    }
    
    public pagereference deleteApparatoCESS(){ 
        EOF_EAI_Service_Log__c ApparatoToDelete = new EOF_EAI_Service_Log__c();
        ApparatoToDelete.Id=IdApparato;
        delete ApparatoToDelete;
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        pg.getParameters().put('proc','cessazioneInserita');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    public pagereference editApparatoCESS(){ 
        
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        pg.getParameters().put('proc','editApparato');
        pg.getParameters().put('IdApparato',IdApparato);
        pg.getParameters().put('orig','CESS');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    
    public pagereference confermaRequestCESS(){
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        if(apparati && (String.isBlank(sl.EOF_COgnome_CLiente__c) || String.isBlank(sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c))){
    		
	        pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
	        pg.getParameters().put('proc','editCessazione');
	        pg.getParameters().put('app','true');
	        pg.getParameters().put('origID',sl.Id);
	        
    	}
    	else{
    		pg.getParameters().put('proc','confirmPageCESS');
        	pg.getParameters().put('origID',sl.Id);
    	}
        
        pg.setRedirect(true);
        return pg;
    }
   	
   	public pageReference inoltraRequestCESS(){
    	//2019 - 04 - 02 start doppia gestione semaforo/custom settings configurazione proxy	
    	Boolean nuovaIf = OF_Change_InterfacciaOM.OF_Interfaccia_OM(sl, 'Cessazione'); //EC 2019 - 03 - 27 OK
		//Valorizzo la mappa dei rtype
    	PO_OpenStreamService_Controller.RTMap= PO_OpenStreamService_Controller.rtMapCreation();
    	PageReference pg;
    	if(nuovaIf){
    		system.debug('@@@@EC cessazione dentro if nuovaIf true');
    		OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest deact = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest();
				deact.CODICE_OPERATORE=sl.EOF_CODICE_OPERATORE__c;
				deact.CODICE_ORDINE_OLO=sl.EOF_CODICE_ORDINE_OLO__c;
				deact.DATA_NOTIFICA=OF_SA_GE_Utils.DateToString(system.now());
				deact.ID_NOTIFICA=String.valueOf(system.now().getTime());
				deact.ID_RISORSA=sl.EOF_ID_RISORSA__c;
				deact.NOME_CLIENTE=sl.EOF_NOME_CLIENTE__c;
				//deact.TRACCIATO_TRASCODIFICATO =
				//deact.CODICE_OPERATORE_SECONDARIO = 'SKY';
				deact.COGNOME_CLIENTE=sl.EOF_COGNOME_CLIENTE__c;
				deact.RECAPITO_TELEFONICO_CLIENTE_1=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
				deact.RECAPITO_TELEFONICO_CLIENTE_2=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
				deact.NOTE=sl.EOF_NOTE__c;
			//EC 2019 04 03
	        if(Apparati){
	        	system.debug('@@@@EC cessazione dentro if nuovaIf true ci sono apparati');
	        	deact.APPARATO = new List<OF_SA_WS_IN_OLO_DeactivationNew.APPARATO>();
	        	for(EOF_EAI_Service_Log__c slApp : SlApparati){
	        		OF_SA_WS_IN_OLO_DeactivationNew.APPARATO app = new OF_SA_WS_IN_OLO_DeactivationNew.APPARATO();
	        			app.TIPOLOGIA_APPARATO=slApp.EOF_TIPOLOGIA_APPARATO__c;
	        		deact.APPARATO.add(app);
	        	} 
	        }
        	//Done AA - Sostituire metodo
			OF_SA_OLO_EntryChecksNew.portalNewIf = true;
        	sl = OF_SA_OLO_EntryChecksNew.PORTAL_SyncChecksDeactivationNew(Deact, sl);
			//Salvo le info sulla nuova interfaccia, così da sapere per gli altri flussi se è nuovo o vecchio
			sl.OF_SA_Interfaccia_OM__c = 'Nuova IF';
			if(sl.EOF_STATO_Ordine__c!='error'){ 
				List<EOF_EAI_Service_Log__C> slToUpdate = new List<EOF_EAI_Service_Log__C>();
				if(apparati){
					for(EOF_EAI_Service_Log__c slApp : SlApparati){
						slApp.EOF_Stato_Richiesta__c='Inserita Portale';
						slToUpdate.add(slApp);
					} 
				}
				
				sl.EOF_Stato_Richiesta__c='Inserita Portale';
				sl.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(deact.DATA_NOTIFICA);
				sl.EOF_ID_NOTIFICA__c=deact.ID_NOTIFICA;
			
				slToUpdate.add(sl);
				update slToUpdate;
				pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
				pg.getParameters().put('proc','successInsertCESS');
				pg.getParameters().put('origID',sl.Id);       
			}else{
				pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
				pg.getParameters().put('motivo',sl.EOF_motivazione__c);
				pg.getParameters().put('proc','errorInsertCESS');
				pg.getParameters().put('origID',sl.Id);	        
        	}
    	}else{//Vecchia IF
			system.debug('@@@@EC cessazione vecchia if '); 	
	        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest deact = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
				deact.CODICE_OPERATORE=sl.EOF_CODICE_OPERATORE__c;
				deact.CODICE_ORDINE_OLO=sl.EOF_CODICE_ORDINE_OLO__c;
				deact.DATA_NOTIFICA=OF_SA_GE_Utils.DateToString(system.now());
				deact.ID_NOTIFICA=String.valueOf(system.now().getTime());
				deact.ID_RISORSA=sl.EOF_ID_RISORSA__c;
				deact.NOME_CLIENTE=sl.EOF_NOME_CLIENTE__c;
				deact.COGNOME_CLIENTE=sl.EOF_COGNOME_CLIENTE__c;
				deact.RECAPITO_TELEFONICO_CLIENTE_1=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
				deact.RECAPITO_TELEFONICO_CLIENTE_2=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
				deact.NOTE=sl.EOF_NOTE__c;
	        if(Apparati){
	        	system.debug('@@@@EC cessazione vecchia if ci sono apparati');
	        	deact.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
	        	for(EOF_EAI_Service_Log__c slApp : SlApparati){
	        		OF_SA_WS_IN_OLO_Deactivation.APPARATO app = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
	        		app.TIPOLOGIA_APPARATO=slApp.EOF_TIPOLOGIA_APPARATO__c;
	        		app.ID_APPARATO=slApp.OF_SA_ID_APPARATO__c;
	        		deact.APPARATO.add(app);
	        	} 
	        }
	        sl = OF_SA_OLO_EntryChecks.PORTAL_SyncChecksDeactivation(Deact, sl);
    	
        
			if(sl.EOF_STATO_Ordine__c!='error'){ 
				List<EOF_EAI_Service_Log__C> slToUpdate = new List<EOF_EAI_Service_Log__C>();
				if(apparati){
					for(EOF_EAI_Service_Log__c slApp : SlApparati){
						slApp.EOF_Stato_Richiesta__c='Inserita Portale';
						slToUpdate.add(slApp);
					} 
				}
				
				sl.EOF_Stato_Richiesta__c='Inserita Portale';
				sl.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(deact.DATA_NOTIFICA);
				sl.EOF_ID_NOTIFICA__c=deact.ID_NOTIFICA;
			
				slToUpdate.add(sl);
				update slToUpdate;
				pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
				pg.getParameters().put('proc','successInsertCESS');
				pg.getParameters().put('origID',sl.Id);       
			}else{
				pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
				pg.getParameters().put('motivo',sl.EOF_motivazione__c);
				pg.getParameters().put('proc','errorInsertCESS');
				pg.getParameters().put('origID',sl.Id);	        
			}    		
        }       
        return pg;       
    }
   
    public pagereference annullaInoltroCESS(){
    	system.debug('Alessandro: entrato nel metodo annulla inoltro');
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        pg.getParameters().put('proc','cessazioneInserita');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    
    public pagereference insNewReq(){
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        return pg;
    }
    
    public pagereference goToRicIns(){
        PageReference pg = new PageReference('/PO_OpenStream_DisplayRequest');
        return pg;
    }
}
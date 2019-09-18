public class PO_KIT_AttInserita_Controller {
 
    public EOF_EAI_Service_Log__c sl{get;set;}
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
    //public List<EOF_EAI_Service_Log__c> SlApparati{get;set;}
    //public List<EOF_EAI_Service_Log__c> SlServiziAggiuntivi{get;set;}
    //public List<EOF_EAI_Service_Log__c> SlVLAN{get;set;}
    public String id_log_richiestaVLAN{get;set;}
    public boolean idNonValido{get;set;}
    public boolean Apparati{get;set;}
    public List<EOF_EAI_Service_Log__c> log_richieste {get;set;}
    public boolean ServiziAggiuntivi{get;set;}
    public boolean VLAN{get;set;} 
    public boolean richiestaAttivazione{get;set;}
    public boolean confirmPage{get;set;} 
    public boolean isAvailable{get;set;}
    public boolean isVisible{get;set;}
    public String Nomekit{get;set;} 
    public String Stato{get;set;} 
    //public String IdVLAN{get;set;}
    //public String IdApparato{get;set;}
    //public String IdServAgg{get;set;}
    public boolean success{get;set;}
    public boolean showAnnulla {get;set;}
    public boolean showAnnullaBtn {get;set;}
    public boolean showDesospBtn {get;set;}
    public boolean showInsertVLAN {get;set;}
    public String codOp{get;set;}
    public boolean error{get;set;}
    public String motivoErr{get;set;}
    public String IdLog {get;set;}
    public String Traffico {get;set;}
    //public String nomeTraffico {get;set;}
    public List<EOF_EAI_Service_Log__c> slList{get;set;}
    public List<EOF_EAI_Service_Log__c> slListVlan{get;set;}
    public List<EOF_EAI_Service_Log__c> slListRichiesteVLAN {get;set;}
    public List<Id> listIdRicVlan {get;set;}
    public boolean showListaVlan {get;set;}
    
    public string profiloCommerciale{ 
    	get{
    	OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(sl.EOF_PROFILO__c);
    	If(objListino != null){
    		return (string)objListino.OF_ProfiloCommerciale__c; 
    	}else{
    		return '';  		
    	} 
    	
    	}
    	set;} 
    
    public PO_KIT_AttInserita_Controller(){
        
                //Added Rajani
        isAvailable = False;
        Nomekit = ApexPages.currentPage().getParameters().get('NomeKit');
        Stato = 'ATTIVO' ;
        String Str = apexpages.currentpage().getparameters().get('isAvailable');
        
        if(str == 'True'){
        isAvailable = True;
        }
        else{
        isAvailable = False;
        } 
        
        
        isVisible = False;
        String Str1 = apexpages.currentpage().getparameters().get('isVisible');
        
        if(str1 == 'True'){
        isVisible = True;
        }
        else{
        isVisible = False;
        } 
        //Ended Rajani

        String[] traffico = new String[]{'VULA Openstream Direct','VULA Openstream City Edge','BITSTREAM - Openstream Regional'};
		this.elencoTRAFFICO = new SelectOption[]{};
		
		for (String t: traffico) {
			this.elencoTRAFFICO.add(new SelectOption(t,t));
		}
		
        String[] interfaccia = new String[]{'None','1 Giga','10 Giga'};
		this.elencoInterfacce = new SelectOption[]{};
		
        for (String i: interfaccia) {
			this.elencoInterfacce.add(new SelectOption(i,i));
		}

        Apparati=false;
        ServiziAggiuntivi=false;
        VLAN=false;
        confirmPage=false;
        richiestaAttivazione=false;
        showAnnulla=false;
        showAnnullaBtn=false;
        showInsertVLAN =false;
        if(ApexPages.currentPage().getParameters().get('showInsVlan') =='SI'){
            showInsertVLAN =true;
        }    
        
        //sl=slOrig;
    	IdLog=ApexPages.currentPage().getParameters().get('origId');
    	system.debug('------------------------> ID Service LOG : ' + IdLog);
    	system.debug('------------------------> Prima della query');

        sl = [select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
            EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
            EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
            EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
            EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
            OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,
            OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,OF_PP_NomeRichiesta__c,
            Nome_del_KIT__c,Modello_di_Servizio__c,POP__c,Banda_Interfaccia__c, Posizione_ODF__c, Traffico__c,Servizi_per_utenti_finali__c,
            EOF_Codice_Ordine_EOF__c, EOF_Stato_Richiesta__c, PO_PP_Interfaccia__c,Caso__r.Codice_Ordine_EOF__c,EOF_STATO_ORDINE__c,EOF_Comunicazioni_con_OLO__c ,Codice_Ordine_SO__c
            from EOF_EAI_Service_Log__c 
            where id=:IdLog];
        
        if(sl!=null)
        {
            //Recupero le richieste VLAN relazionalte al log del KIT
            slListRichiesteVLAN = [select id, name, EOF_Stato_Richiesta__c, EOF_STATO_Ordine__c, OF_PP_KIT_Log__c, EOF_Codice_Operatore__c,
                                  OF_PP_KIT_Log__r.Nome_del_KIT__c, EOF_Tipo_Comunicazione_String__c, CreatedDate, OF_PP_NomeRichiesta__c,
                                  OF_PP_NomeRichiesta_Figlio__c
                                  from EOF_EAI_Service_Log__c 
                                  where OF_PP_KIT_Log__c =: sl.id
                                  ];
                                  
            System.debug('*****slListRichiesteVLAN*****:'+slListRichiesteVLAN.size());
            listIdRicVlan = new List<ID>();
            
            for(EOF_EAI_Service_Log__c ricV : slListRichiesteVLAN){
                listIdRicVlan.add(ricV.id);
            }
            System.debug('*****listIdRicVlan*****:'+listIdRicVlan);
            
            //Recupero tutte le VLAN
            slListVlan = [select id, name, OF_PP_KIT_Log__c, recordtype.developername, Nome_del_KIT__c,EOF_Codice_Operatore__c,
                            PO_PP_POP_raccolta__c, Banda_Interfaccia__c, PO_PP_cos_type__c, SVLAN__c, EOF_Note__c, CreatedDate, Codice_Ordine_SO__c,
                            PO_PP_cos_class__c, PO_PP_MultiCos_Class__c, PO_PP_cos_remarking__c, PO_PP_dhcp_Option82__c, PO_PP_User_VLAN__c, 
                            EOF_Stato_Richiesta__c, EOF_STATO_Ordine__c,OF_PP_NomeRichiesta__c,OF_PP_NomeRichiesta_Figlio__c, Caso__r.status
                            from EOF_EAI_Service_Log__c 
                            where PO_PP_ID_RichiestaVLAN__c in : listIdRicVlan
                            and RecordType.DeveloperName = 'PO_PP_VLAN'
                            order by CreatedDate desc];
        }
        
        showDesospBtn=false;
        if (sl.EOF_STATO_Ordine__c=='Sospeso') 
            showDesospBtn=true;
            
        slList=new List<EOF_EAI_Service_Log__c>();
        slList.add(sl);
        if(ApexPages.currentPage().getParameters().get('proc') =='attivazioneInserita'){
            system.debug('------------------------>confirmPage=true');
        	confirmPage=true;
        }
        
        if(ApexPages.currentPage().getParameters().get('proc') =='successInsertATT'){
        	success=true;
        	error=false;
        	confirmPage=true;
        	if (sl.EOF_STATO_Ordine__c=='Espletato' || sl.EOF_STATO_Ordine__c =='Espletato KO' || sl.EOF_STATO_Ordine__c=='Annullato' ) 
                showAnnullaBtn=false;
        	else
        	    showAnnullabtn=true;
        }
        if(ApexPages.currentPage().getParameters().get('proc') =='errorInsertATT'){
        	error=true;
        	motivoErr=ApexPages.currentPage().getParameters().get('motivo');
        	confirmPage=true;
        	
        }
        if(ApexPages.currentPage().getParameters().get('proc') =='successAnnull'){
            showAnnulla=true;
        }
        
        /*system.debug('------------------------> Prima del IF');
         if(!slList.isEmpty()){
            system.debug('------------------------>dentro IF');
            
            SlApparati=new List<EOF_EAI_Service_Log__c>();
            SlServiziAggiuntivi=new List<EOF_EAI_Service_Log__c>();
            SlVLAN=new List<EOF_EAI_Service_Log__c>();
           for(EOF_EAI_Service_Log__c slAgg : slList){
                system.debug('------------------------> Dentro FOR');
                if(slAgg.recordtype.developername=='OF_SA_Cpe'){
                    SlApparati.add(slAgg);
                    Apparati=true;
                    system.debug('------------------------> OF_SA_Cpe');
                }
                if(slAgg.recordtype.developername=='OF_SA_Servizi_Aggiuntivi'){
                    SlServiziAggiuntivi.add(slAgg);
                    ServiziAggiuntivi=true;
                    system.debug('------------------------> OF_SA_Servizi_Aggiuntivi');
                }
                if(slAgg.recordtype.developername=='OF_SA_Vlan'){
                    SlVLAN.add(slAgg);
                    VLAN=true;
                    system.debug('------------------------> OF_SA_Vlan');
                    
                }
            }
            
        }*/
        
         if(ApexPages.currentPage().getParameters().get('proc') =='editAttivazione'){
        	richiestaAttivazione=true;
        	slOrig=[select id,name,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
        		EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
        		EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
        		EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
        		EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
        		EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c,EOF_Codice_Ordine_EOF__c,Caso__r.Codice_Ordine_EOF__c,EOF_Comunicazioni_con_OLO__c ,	OF_PP_NomeRichiesta__c,Codice_Ordine_SO__c
        		from EOF_EAI_Service_Log__c where ID=:ApexPages.currentPage().getParameters().get('origId')];
        }
    }
    
    
    public PageReference inserisciVLAN(){
        system.debug('------------------------>inserisciVLAN');
        
        PageReference pageRef = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        pageRef.getParameters().put('proc','insVLAN');
        pageRef.getParameters().put('orig','ATT');
        pageRef.getParameters().put('origID',sl.Id);
        pageRef.getParameters().put('codOrdOlo',sl.EOF_Codice_Ordine_OLO__c);
        return pageref;
    } 
    public pageReference editsl(){
    system.debug('------------------------>editsl');
        PageReference pg = new PageReference('/PO_RiepilogoKit');
        pg.getParameters().put('proc','editAttivazione');
        pg.getParameters().put('origID',sl.Id);
       
        return pg;
    }
    
    public pageReference insertVLAN(){
        
        string selectednameKit;
	
        codOp = [SELECT Contact.account.name 
		        FROM User 
		        WHERE id = :userinfo.getuserid() 
		        LIMIT 1].Contact.account.name;
		 
		System.debug('***CodOP****:'+codOp);
		        
		EOF_EAI_Service_Log__c kitLogSelected = [Select id, Nome_del_KIT__c
	                                              from EOF_EAI_Service_Log__c
	                                              where id=: sl.id
	                                              and EOF_STATO_ORDINE__c = 'Espletato'
	                                             ];
        
        
        selectednameKit = kitLogSelected.Nome_del_KIT__c;
		System.debug('selectednameKit: '+selectednameKit);
		
		log_richieste = new list<EOF_EAI_Service_Log__c>();

        //Query su object OF_CommercialElementIstanziato__c
        OF_CommercialElementIstanziato__c kit_selezionato = [Select id, name, PO_PP_Nome_KIT__c, PO_PP_Servizio_Commerciale__c, RecordType.name, of_asset__r.name, OF_Asset__r.account.name, OF_Case__c
                                                             from OF_CommercialElementIstanziato__c
                                                             where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                                                             and OF_Asset__r.account.name =:codOp
                                                             and OF_Asset__r.status='Attivo'
                                                             and PO_PP_Nome_KIT__c=:selectednameKit
                                                             limit 1];
        System.debug('***kit_selezionato.PO_PP_Nome_KIT__c***: '+kit_selezionato.PO_PP_Nome_KIT__c);
         
        if(kit_selezionato!=null)
        {
         	log_richieste = [Select id,OF_PP_KIT_Log__c
                            from EOF_EAI_Service_Log__c
                            where OF_PP_KIT_Log__r.Nome_del_KIT__c =:selectednameKit
                            and recordtype.developerName = 'OF_RichiestaVLAN_LOG'
                            and EOF_stato_richiesta__c ='Bozza Portale'
                            limit 1];
            
            System.debug('***log_richieste***:'+log_richieste.size());
    
    		Pagereference pg = new PageReference('/PO_PP_InserimentoSVLAN');
    		
    		//Se la lista contiene già una richiesta VLAN allora passo l'ID come parametro
    		if(log_richieste.size()>0){
    		    pg.getParameters().put('richVLan','NO');
    		    id_log_richiestaVLAN = log_richieste.get(0).id;
    		    pg.getParameters().put('id_richVLAN',id_log_richiestaVLAN);
    		    System.debug('***ID LOG Richiesta VLAN***: '+id_log_richiestaVLAN);
    		    System.debug('***Richiesta VLAN presente!!***');
    		}
    		else{
    		    pg.getParameters().put('richVLan','SI');
    		    System.debug('***Nessuna Richiesta VLAN presente!!***');
    		}
    	    pg.getParameters().put('nameKit',selectednameKit);
	    
    		if (kit_selezionato==null){
    			idNonValido=true;
    		}
    		else{
    			idNonValido=false;
    			return pg;
    		}
        }
	    return null;
    }
    
    public pageReference deletesl(){
        system.debug('------------------------>deletesl');
        delete slList;
        PageReference pg = new PageReference('/PO_PP_InserimentoKit');
        return pg;
    }
      public pageReference annullasl(){
        system.debug('------------------------>deletesl');
        //delete slList;
        PageReference pg = new PageReference('/PO_PP_InserimentoKit');
        return pg;
    }
    
    public pageReference desosp(){
        system.debug('------------------------>desosp');
        //delete slList;
        PageReference pg = new PageReference('/PO_PP_AnnullaDesosp');
        pg.getParameters().put('proc','desospensione');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }

    public pageReference inoltraRequest(){

        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest act = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
        
        act.NOME_KIT                    = '';//sl.Nome_del_KIT__c;
        act.MODELLO_SERVIZIO            = '';//sl.Modello_di_Servizio__c;
        act.IDENTIFICATIVO_DEL_POP      = sl.POP__c;
        act.BANDA                       = sl.Banda_Interfaccia__c;
        act.INTERFACCIA                 = sl.PO_PP_Interfaccia__c;
        act.ODF                         = '';//sl.Posizione_ODF__c;
        act.TRAFFICO                    = sl.Traffico__c;
        act.SERVIZIFINALI               = '';//sl.Servizi_per_utenti_finali__c;
        act.DATA_NOTIFICA               = OF_SA_GE_Utils.DateToString(system.now());
        act.ID_NOTIFICA                 = String.valueOf(system.now().getTime());
        act.CODICE_OPERATORE            = sl.EOF_CODICE_OPERATORE__c;
        act.CODICE_ORDINE_OLO           = sl.eof_Codice_Ordine_EOF__c; 
        act.CODICE_ORDINE_OF            = sl.eof_Codice_Ordine_EOF__c; 
        act.PROFILO                     = sl.EOF_PROFILO__c;
        act.CODICE_ORDINE_SO            = sl.OF_PP_NomeRichiesta__c;
        //act.STATO_ORDINE=sl.EOF_STATO_Ordine__c;
        act.NOTE                        = sl.EOF_Comunicazioni_con_OLO__c;
        
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> PORTAL_SyncChecksActivation');
        sl = OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksActivation(act,sl);
        PageReference pg;
        
        if(sl.EOF_STATO_Ordine__c!='error'){ 
        	
        	List<EOF_EAI_Service_Log__C> slToUpdate = new List<EOF_EAI_Service_Log__C>();
        	sl.EOF_Stato_Richiesta__c='Richiesta Portale';
        	sl.EOF_STATO_Ordine__c = 'Accettato';
        	sl.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(act.DATA_NOTIFICA);
        	sl.EOF_ID_NOTIFICA__c=act.ID_NOTIFICA;
        	slToUpdate.add(sl);
        	update slToUpdate;
        	richiestaAttivazione=false;
        
        	pg = new PageReference('/PO_RiepilogoKit');
	        pg.getParameters().put('proc','successInsertATT');
	        pg.getParameters().put('origID',sl.Id);
	        showAnnullaBtn=true;
	        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>richiestaAttivazione: ' + richiestaAttivazione  +' <<<<<<<<<<<<<<<<<<<<<<<<<<<' );
        }
        else{
        	
        	pg = new PageReference('/PO_RiepilogoKit');
        	pg.getParameters().put('motivo',sl.EOF_motivazione__c);
	        pg.getParameters().put('proc','errorInsertATT');
	        pg.getParameters().put('origID',sl.Id);
        }
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> return pg');
        return pg;
    }
    
    
    public pagereference annullaInoltro(){
        
        PageReference pg;
        
    	if(richiestaAttivazione){
    		
    		pg = new PageReference('/PO_PP_InserimentoKit');
    		
    	}else{
        	
            pg = new PageReference('/PO_PP_InserimentoKit');
            pg.getParameters().put('proc','attivazioneInserita');
            pg.getParameters().put('origID',sl.Id);
            pg.setRedirect(true);
            
    	}
        richiestaAttivazione=false;
        error=false;
        return pg;
    }
    
    public pageReference salvaModifche(){
         
        update sl;
        
        PageReference pg = new PageReference('/PO_RiepilogoKit');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origId',sl.Id);
        richiestaAttivazione=false;
        return pg;
        
    }
    public pagereference annullaModifica(){
        
        PageReference pg;
        pg = new PageReference('/PO_RiepilogoKit');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origID',sl.Id);
        pg.setRedirect(true);

        return pg;
    }
    
    public SelectOption[] elencoTRAFFICO {
		public get;
		private set;
	}
	
	public SelectOption[] elencoInterfacce {
		public get;
		private set;
	}
	
	// gestione della fase di annullamento:
	public pageReference inoltraRequestAnnnulla(){
    	    
	    system.debug('8888888888888 Annullo DENTRO Richiesta inoltraRequestAnnnulla ---> '+sl.EOF_Codice_ordine_eof__c);
        sl.EOF_MOTIVAZIONE__c='D12 - Annullamento su richiesta OLO';
        sl.EOF_STATO_Ordine__c = 'Annullato';
        sl.EOF_Note__c='';
        update sl;
       
        PageReference pg;
        OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur = new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        
        sur.NOME_KIT                    = '';//sl.Nome_del_KIT__c;
        sur.MODELLO_SERVIZIO            = '';//sl.Modello_di_Servizio__c;
        sur.IDENTIFICATIVO_DEL_POP      = sl.POP__c;
        sur.BANDA                       = sl.Banda_Interfaccia__c;
        //da aggiungere
        //sur.INTERFACCIA               = sl.PO_PP_Interfaccia__c;
        sur.ODF                         = '';//sl.Posizione_ODF__c;
        sur.TRAFFICO                    = sl.Traffico__c;
        sur.SERVIZIFINALI               = '';//sl.Servizi_per_utenti_finali__c;
        sur.DATA_NOTIFICA               = OF_SA_GE_Utils.DateToString(system.now());
        sur.ID_NOTIFICA                 = String.valueOf(system.now().getTime());
        sur.CODICE_OPERATORE            = sl.EOF_CODICE_OPERATORE__c;
        sur.CODICE_ORDINE_OLO           = sl.eof_Codice_Ordine_EOF__c; 
        sur.PROFILO                     = sl.EOF_PROFILO__c;
        sur.NOTE                        = sl.EOF_NOTE__c;
        sur.CODICE_ORDINE_OF            = sl.eof_Codice_Ordine_EOF__c; 
        sur.AZIONE='1'; 
        sur.CODICE_MOTIVAZIONE=sl.EOF_MOTIVAZIONE__c.left(3);
        sur.MOTIVAZIONE=sl.EOF_MOTIVAZIONE__c.right(sl.EOF_MOTIVAZIONE__c.length()-5);
        sur.MOTIVAZIONE=sur.MOTIVAZIONE.trim();
        
        sur.ORARIO_APPUNTAMENTO=sl.EOF_ORARIO_APPUNTAMENTO__c;
        
        system.debug('8888888888888 Annullo Richiesta Prima di PORTAL_SyncChecksStatusUpdate sur.MOTIVAZIONE:' +sur.MOTIVAZIONE + '-sur.CODICE_MOTIVAZIONE:' + sur.CODICE_MOTIVAZIONE  );
        sl = OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksStatusUpdate(sur,sl);
        
        if(sl.EOF_STATO_Ordine__c!='error'){ 
            sl.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(sur.DATA_NOTIFICA);
            sl.EOF_ID_NOTIFICA__c=sur.ID_NOTIFICA;
            update sl;
            pg = new PageReference('/PO_RiepilogoKit');
            pg.getParameters().put('proc','successAnnull');
            
        }
        else{
            pg = new PageReference('/PO_RiepilogoKit');
            pg.getParameters().put('motivo',sl.EOF_motivazione__c);
            pg.getParameters().put('proc','errorAnnull');
            
        }
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    
    
    // gestione della fase di desospensione:
	public pageReference inoltraRequestDesosp(){
    	    
	    system.debug('8888888888888 DENTRO Richiesta inoltraRequestDesosp ---> '+sl.EOF_Codice_ordine_eof__c);
        sl.EOF_MOTIVAZIONE__c='D12 - DESOSPensione su richiesta OLO';
        sl.EOF_Note__c='';
        update sl;
       
        PageReference pg;
        OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur = new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        
        sur.NOME_KIT                    = '';//sl.Nome_del_KIT__c;
        sur.MODELLO_SERVIZIO            = '';//sl.Modello_di_Servizio__c;
        sur.IDENTIFICATIVO_DEL_POP      = sl.POP__c;
        sur.BANDA                       = sl.Banda_Interfaccia__c;
       // da aggiungere
        //sur.INTERFACCIA               = sl.PO_PP_Interfaccia__c;
        sur.ODF                         = '';//sl.Posizione_ODF__c;
        sur.TRAFFICO                    = sl.Traffico__c;
        sur.SERVIZIFINALI               = '';//sl.Servizi_per_utenti_finali__c;
        sur.CODICE_ORDINE_OF            = sl.EOF_Codice_ordine_eof__c; 
        sur.CODICE_OPERATORE            = sl.EOF_CODICE_OPERATORE__c; 
        sur.CODICE_ORDINE_OLO           = sl.EOF_Codice_ordine_eof__c;
        sur.DATA_NOTIFICA               = OF_PP_GE_Utils.DateToString(system.now());
        sur.ID_NOTIFICA                 = String.valueOf(system.now().getTime());
        sur.AZIONE                      = '0'; 
        sur.CODICE_MOTIVAZIONE          = sl.EOF_MOTIVAZIONE__c.left(3);
        sur.MOTIVAZIONE                 = sl.EOF_MOTIVAZIONE__c.right(sl.EOF_MOTIVAZIONE__c.length()-5); 
        sur.DATA_PREVISTA_ATTIVAZIONE   = OF_PP_GE_Utils.DateToStringNoTime(sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c);
        sur.ORARIO_APPUNTAMENTO         = sl.EOF_ORARIO_APPUNTAMENTO__c;
        sur.NOTE                        = sl.EOF_NOTE__c;
        
        
        
        system.debug('8888888888888 Annullo Richiesta Prima di PORTAL_SyncChecksStatusUpdate sur.MOTIVAZIONE:' +sur.MOTIVAZIONE + '-sur.CODICE_MOTIVAZIONE:' + sur.CODICE_MOTIVAZIONE  );
        sl = OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksStatusUpdate(sur,sl);
        
        if(sl.EOF_STATO_Ordine__c!='error'){ 
            sl.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(sur.DATA_NOTIFICA);
            sl.EOF_ID_NOTIFICA__c=sur.ID_NOTIFICA;
            update sl;
            pg = new PageReference('/PO_RiepilogoKit');
            pg.getParameters().put('proc','successAnnull');
            
        }
        else{
            pg = new PageReference('/PO_RiepilogoKit');
            pg.getParameters().put('motivo',sl.EOF_motivazione__c);
            pg.getParameters().put('proc','errorAnnull');
            
        }
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }

}
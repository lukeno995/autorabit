public class PO_COMP_GPON_Passiva_CeD_Att_Ins_Contr {
    
    public EOF_EAI_Service_Log__c sl{get;set;}
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
    public List<EOF_EAI_Service_Log__c> SlApparati{get;set;}
    public List<EOF_EAI_Service_Log__c> SlServiziAggiuntivi{get;set;}
    public List<EOF_EAI_Service_Log__c> SlVLAN{get;set;}
    public boolean Apparati{get;set;}
    public boolean ServiziAggiuntivi{get;set;}
    //public boolean VLAN{get;set;} 
    public boolean confirmPage{get;set;} 
    //public String IdVLAN{get;set;}
    public String IdApparato{get;set;}
    public String IdServAgg{get;set;}
    public boolean success{get;set;}
    public boolean error{get;set;}
    public String motivoErr{get;set;}
    public List<EOF_EAI_Service_Log__c> slList{get;set;}
    
    /*
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
    */
    
    public PO_COMP_GPON_Passiva_CeD_Att_Ins_Contr()
    {
        Apparati=false;
        ServiziAggiuntivi=false;
        //VLAN=false;
        confirmPage=false;
        sl=slOrig;
        
        if(ApexPages.currentPage().getParameters().get('proc') =='confirmPageATT'){
        	confirmPage=true;
        }
        
        if(ApexPages.currentPage().getParameters().get('proc') =='successInsertATT'){
        	success=true;
        	confirmPage=true;
        }
        if(ApexPages.currentPage().getParameters().get('proc') =='errorInsertATT'){
        	error=true;
        	motivoErr=ApexPages.currentPage().getParameters().get('motivo');
        	confirmPage=true;
        }
        
        slList = [select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                    OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,
                    OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c
                    from EOF_EAI_Service_Log__c 
                    where /*OF_SA_VLan_Log__c=:slOrig.Id OR */ OF_SA_Servizi_Aggiuntivi_Log__c=:slOrig.Id 
                    OR OF_SA_Cpe_Log__c=:slOrig.Id];
                
        if(!slList.isEmpty())
        {
            SlApparati = new List<EOF_EAI_Service_Log__c>();
            SlServiziAggiuntivi = new List<EOF_EAI_Service_Log__c>();
            //SlVLAN=new List<EOF_EAI_Service_Log__c>();
            
            System.debug('##### slList ##### :'+slList);
            
            for(EOF_EAI_Service_Log__c slAgg : slList)
            {
                if(slAgg.recordtype.developername=='OF_SA_Cpe'){
                    SlApparati.add(slAgg);
                    Apparati=true;
                }
                if(slAgg.recordtype.developername=='OF_SA_Servizi_Aggiuntivi')
                {
                    SlServiziAggiuntivi.add(slAgg);
                    ServiziAggiuntivi=true;
                }
                /*
                if(slAgg.recordtype.developername=='OF_SA_Vlan'){
                    SlVLAN.add(slAgg);
                    VLAN=true;
                }
                */
            }
        }
    }
    
    /*
    public PageReference inserisciVLAN(){
        
        PageReference pageRef = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        pageRef.getParameters().put('proc','insVLAN');
        pageRef.getParameters().put('orig','ATT');
        pageRef.getParameters().put('origID',sl.Id);
        pageRef.getParameters().put('codOrdOlo',sl.EOF_Codice_Ordine_OLO__c);
        return pageref;
    } 
    */
    
    public pageReference editsl(){
    
        PageReference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        pg.getParameters().put('proc','editAttivazione');
        pg.getParameters().put('origID',sl.Id);
       
        return pg;
    }
    
    public pageReference deletesl()
    {
        delete slList;
        PageReference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        return pg;
    }
    
    public pageReference inserisciApparato()
    {
        PageReference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        pg.getParameters().put('proc','insApp');
        pg.getParameters().put('orig','ATT');
        pg.getParameters().put('origID',sl.Id);
        pg.getParameters().put('codOrdOlo',sl.EOF_Codice_Ordine_OLO__c);
        return pg;
    }
    
    public pageReference inserisciServAgg()
    {
        PageReference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        pg.getParameters().put('proc','insServAgg');
        pg.getParameters().put('orig','ATT');
        pg.getParameters().put('origID',sl.Id);
        pg.getParameters().put('codOrdOlo',sl.EOF_Codice_Ordine_OLO__c);
        return pg; 
    }         
    /*
    public pagereference deleteVLAN(){ 
        EOF_EAI_Service_Log__c VLANToDelete = new EOF_EAI_Service_Log__c();
        VLANToDelete.Id=IdVLAN;
        delete VLANToDelete;
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    public pagereference editVLAN(){ 
        
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        pg.getParameters().put('proc','editVLAN');
        pg.getParameters().put('IdVLAN',IdVLAN);
        pg.getParameters().put('orig','ATT');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    */
    
    public pagereference deleteApparato()
    { 
        EOF_EAI_Service_Log__c ApparatoToDelete = new EOF_EAI_Service_Log__c();
        ApparatoToDelete.Id=IdApparato;
        delete ApparatoToDelete;
        PageReference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    public pagereference editApparato()
    { 
        PageReference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        pg.getParameters().put('proc','editApparato');
        pg.getParameters().put('IdApparato',IdApparato);
        pg.getParameters().put('orig','ATT');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    
    public pagereference deleteServAgg()
    { 
        EOF_EAI_Service_Log__c ServAggToDelete = new EOF_EAI_Service_Log__c();
        ServAggToDelete.Id=IdServAgg;
        delete ServAggToDelete;
        PageReference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    
    public pagereference editServAgg(){ 
        
        PageReference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        pg.getParameters().put('proc','editServAgg');
        pg.getParameters().put('IdServAgg',IdServAgg);
        pg.getParameters().put('orig','ATT');
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    
    public pagereference confermaRequest()
    {
    	PageReference pg;
        if(apparati && String.isBlank(sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c))
        {
	        pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
	        pg.getParameters().put('proc','editAttivazione');
	        pg.getParameters().put('app','true');
	        pg.getParameters().put('origID',sl.Id);
	        pg.setRedirect(true);
	        return pg;
    	}
        pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        pg.getParameters().put('proc','confirmPageATT');
    	pg.getParameters().put('origId',sl.Id);
    	pg.setRedirect(true);
        return pg;
    }
    
    public pageReference inoltraRequest()
    {
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest act = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        act.CODICE_OPERATORE = sl.EOF_CODICE_OPERATORE__c;
        act.CODICE_ORDINE_OLO = sl.EOF_CODICE_ORDINE_OLO__c;
        act.DATA_NOTIFICA = OF_SA_CD_GE_Utils.DateToString(system.now());
        act.ID_NOTIFICA = String.valueOf(system.now().getTime());
        act.NOME_CLIENTE = sl.EOF_NOME_CLIENTE__c;
        act.COGNOME_CLIENTE = sl.EOF_COGNOME_CLIENTE__c;
        act.RECAPITO_TELEFONICO_CLIENTE_1 = sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
        act.RECAPITO_TELEFONICO_CLIENTE_2 = sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
        act.NOTE = sl.EOF_NOTE__c;
        act.NOME_REFERENTE_TECNICO_OLO = sl.EOF_NOME_REFERENTE_TECNICO_OLO__c;
        act.COGNOME_REFERENTE_TECNICO_OLO = sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c;
        act.TELEFONO_REFERENTE_TECNICO_OLO = sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;
        act.EMAIL_REFERENTE_TECNICO_OLO = sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
        act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = sl.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c;        
        act.INFORMAZIONI_LOGISTICA_APPARATI = sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c;
        act.DATA_PREVISTA_ATTIVAZIONE = OF_SA_CD_GE_Utils.DateToStringNoTime(sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c);
        act.ORARIO_APPUNTAMENTO = sl.EOF_ORARIO_APPUNTAMENTO__c;
        act.CODICE_PROGETTO_SPECIALE = sl.EOF_CODICE_PROGETTO_SPECIALE__c;
        act.PROMOZIONE = sl.EOF_PROMOZIONE__c;
        act.CLUSTER_PROMOZIONE = sl.EOF_CLUSTER_PROMOZIONE__c;
        act.ID_BUILDING = sl.EOF_ID_BUILDING__c;
        act.SCALA_PALAZZINA = sl.EOF_SCALA_PALAZZINA__c;
        act.NUMERO_TELEFONICO_PRINCIPALE_LINEA = sl.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c;
        act.RECAPITO_TEST_LINEA = sl.EOF_RECAPITO_TEST_LINEA__c;
        act.IDENTIFICATIVO_DEL_POP = sl.EOF_ID_Pop__c;
        act.PROFILO = sl.EOF_PROFILO__c;
        
        /*
        //inserisco le VLAN
        act.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        
        for(EOF_EAI_Service_Log__c slV : SlVLAN){
        		OF_SA_WS_IN_OLO_Activation.VLAN Vlan = new OF_SA_WS_IN_OLO_Activation.VLAN();
        		vlan.KIT_CONSEGNA_VLAN=slv.OF_SA_KIT_CONSEGNA_VLAN__c;
		        vlan.USER_VLAN=slv.OF_SA_USER_VLAN__c;
		        vlan.SERVICE_VLAN=slv.OF_SA_SERVICE_VLAN__c;
		        vlan.PROFILO_VLAN=slv.OF_SA_PROFILO_VLAN__c;
		        vlan.INFORMAZIONI_VLAN=slv.OF_SA_INFORMAZIONI_VLAN__c;
		        vlan.CUSTOMER_VLAN=slv.OF_SA_CUSTOMER_VLAN__c;
		        vlan.MODELLO_DI_SERVIZIO_VLAN=slv.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c;
        		act.VLAN.add(vlan);
        }
        */
        System.debug('@@@ Apparati @@@ : '+Apparati);
        if(Apparati)
        {
        	act.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        	for(EOF_EAI_Service_Log__c slApp : SlApparati){
        		OF_SA_WS_IN_OLO_Activation.APPARATO app = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        		app.TIPOLOGIA_APPARATO = slApp.EOF_TIPOLOGIA_APPARATO__c;
        		app.AZIONE_APPARATO = slApp.OF_SA_Azione_APPARATO__c.left(1);
        		app.Password_APPARATO = slApp.OF_SA_Password_APPARATO__c;
        		act.APPARATO.add(app);
        	} 
        }
        System.debug('@@@ ServiziAggiuntivi @@@ : '+ServiziAggiuntivi);
        if(ServiziAggiuntivi)
        {
        	act.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        	for(EOF_EAI_Service_Log__c slSA : SlServiziAggiuntivi){
        		OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO slServAgg = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        		slServAgg.NOME_SERVIZIO = slSA.OF_SA_NOME_SERVIZIO__c;
        		slServAgg.INFORMAZIONI_SERVIZIO = slSA.OF_SA_INFORMAZIONI_SERVIZIO__c.left(1);
        		act.SERVIZIO_AGGIUNTIVO.add(slServAgg);
        	} 
        }
        //TODO: PG - C&D - Chiamata a metodi sincroni 
        sl = OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksActivation(act,sl);
       
        PageReference pg;
        
        if(sl.EOF_STATO_Ordine__c!='error')
        { 
        	List<EOF_EAI_Service_Log__C> slToUpdate = new List<EOF_EAI_Service_Log__C>();
            /*
        	for(EOF_EAI_Service_Log__c slV : SlVLAN){
        		slv.EOF_Stato_Richiesta__c='Inserita Portale';
        		slToUpdate.add(slV);
        	}
        	*/
        	if(apparati){
        		for(EOF_EAI_Service_Log__c slApp : SlApparati){
        			slApp.EOF_Stato_Richiesta__c = 'Inserita Portale';
        			slToUpdate.add(slApp);
        		} 
        	}
        	if(ServiziAggiuntivi){
        		for(EOF_EAI_Service_Log__c slSA : SlServiziAggiuntivi){
        			slSA.EOF_Stato_Richiesta__c = 'Inserita Portale';
        			slToUpdate.add(slSA);
        		} 
        	}
        	sl.EOF_Stato_Richiesta__c = 'Inserita Portale';
        	sl.EOF_DATA_NOTIFICA__c = OF_SA_CD_GE_Utils.StringToDate(act.DATA_NOTIFICA);
        	sl.EOF_ID_NOTIFICA__c = act.ID_NOTIFICA;
        	slToUpdate.add(sl);
        	
        	update slToUpdate;
        	
        	pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
	        pg.getParameters().put('proc','successInsertATT');
	        pg.getParameters().put('origID',sl.Id);
        }
        else
        {
        	pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        	pg.getParameters().put('motivo',sl.EOF_motivazione__c);
	        pg.getParameters().put('proc','errorInsertATT');
	        pg.getParameters().put('origID',sl.Id);
        }
        return pg;
    }
    
    
    public pagereference annullaInoltro(){
        PageReference pg;
        pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origID',sl.Id);
        pg.setRedirect(true);
        return pg;
    }
    
    public pagereference insNewReq(){
        PageReference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
        return pg;
    }
    
    public pagereference goToRicIns(){
        PageReference pg = new PageReference('/PO_GPON_Passiva_CeD_DisplayRequest');
        return pg;
    }
}
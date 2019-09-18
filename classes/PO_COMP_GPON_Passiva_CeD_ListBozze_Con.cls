public class PO_COMP_GPON_Passiva_CeD_ListBozze_Con{

	public List<EOF_EAI_Service_Log__c> listBozze{get;set;} 
	public boolean richieste{get;set;}
	public String IdBozza{get;set;}
	public String tipoRIchiesta{get;set;}
    public Integer totalRecord{get;set;} 
    public Integer pageActual{get;set;} 
    public Decimal totalpage{get;set;} 
    public boolean showPag{get;set;} 
    public Decimal pageRecord{get;set;}
    public Integer offset_page{get;set;}
    public Decimal totpg{get;set;} 
    public boolean showRow{get;set;} 
    public Integer totRec{get;set;} 
    
    public PO_COMP_GPON_Passiva_CeD_ListBozze_Con()
    {
        totalRecord=0; 
	    pageActual=0;
	    pageRecord=5; 
	    totalpage=0; 
	    showRow=true; 
	    showPag=true; 
    	richieste=true;
        listBozze = new List<EOF_EAI_Service_Log__c>();
        Integer off=0; 
        //Id accId =  [SELECT AccountId  FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId;
    	User attuale=[select Id,Account.EOF_Codice_Operatore__c 
    	              from user 
    	              where Id=:userinfo.getUserId()];
    	
    	listBozze=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                    OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,
                    OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,
                    EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c
                    from EOF_EAI_Service_Log__c 
                    where (recordType.developerName='PO_SA_CD_Log_GPONPRequest' 
                    /*OR recordType.developerName='PO_CO_FiberRequest'*/) 
                    AND EOF_Stato_Richiesta__c='Bozza Portale' 
                    AND EOF_Codice_Ordine_OLO__c!='' 
                    AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                    LIMIT :(integer)pageRecord OFFSET :off];
        
        totRec=[Select count()
                from EOF_EAI_Service_Log__c 
                where (recordType.developerName='PO_SA_CD_Log_GPONPRequest' 
                /*OR recordType.developerName='PO_CO_FiberRequest'*/ ) 
                AND EOF_Stato_Richiesta__c='Bozza Portale' 
                AND EOF_Codice_Ordine_OLO__c!='' 
                AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c ];
                
        totpg = (totRec /pageRecord).round(RoundingMode.CEILING); 
        setPagination(null);  
    }

    public pageReference vediReq(){
        /*
        //AA: Modifica 
        if(tipoRIchiesta.equalsIgnoreCase('Change Order')){
            Pagereference pg1 = new Pagereference('/PO_OF_DetailBozze');
            pg1.getParameters().put('idRisorsa', IdBozza);
            return pg1;
        }
        */
    	Pagereference pg = new Pagereference('/PO_GPON_Passiva_CeD_InsertNewReq');
    	if(tipoRIchiesta=='Attivazione'){
    		pg.getParameters().put('proc','attivazioneInserita');
    	}
    	if(tipoRIchiesta=='Cessazione'){
    		pg.getParameters().put('proc','cessazioneInserita');
    	}
        pg.getParameters().put('origID',IdBozza);
    	return pg;
    }

    public PageReference pageDown(){ 
    	setPagination(false); 
    	return null; 
    }
    
    public PageReference pageUp(){ 
        setPagination(true); 
        return null; 
    }

    public void setPagination(boolean next){ 
    	if(next==null){
    		pageActual=1; 
    		totalpage = totpg; 
    		totalRecord =totRec;
    	}else if(next){ 
    		if(pageActual<totalpage){ 
    			pageActual++;
    			totalpage = totpg; 
    			totalRecord = totRec;
    			preparePage(); 
    		} 
    	}else{ 
    		if(pageActual>1){ 
    			pageActual--; 
    			totalpage = totpg; 
    			totalRecord = totRec;
    			preparePage(); 
    		} 
    	} 
    }

    public void preparePage(){ 
        
    	/*integer index=0;
    	if(pageActual==totalpage||pageRecord>listBozze.size()){ 
    
    		index=((pageActual-1)*((integer)pageRecord))+math.mod(totalRecord,(integer)pageRecord);
    		System.debug('**** indexx!!! ' + index);  
    		}else{ 
    			index=(pageActual)*(integer)pageRecord; 
            } */
    	Integer off=(pageActual-1)*((integer)pageRecord); 
    	
        User attuale=[select Id,Account.EOF_Codice_Operatore__c 
                        from user 
                        where Id=:userinfo.getUserId()];
        
    	//Id accId =  [SELECT AccountId  FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId;
        listBozze=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                    OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,
                    OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,
                    EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c
                    from EOF_EAI_Service_Log__c 
                    where (recordType.developerName='PO_SA_CD_Log_GPONPRequest' 
                    /*OR recordType.developerName='PO_CO_FiberRequest'*/ )
                    AND EOF_Stato_Richiesta__c='Bozza Portale' 
                    AND EOF_Codice_Ordine_OLO__c!='' 
                    AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c  
                    LIMIT:(integer)pageRecord  OFFSET :off ];
    
    } 
}
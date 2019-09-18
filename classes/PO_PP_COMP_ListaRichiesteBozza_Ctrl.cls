public with sharing class PO_PP_COMP_ListaRichiesteBozza_Ctrl {
	
	public List<EOF_EAI_Service_Log__c> listBozze{get;set;} 
	public boolean richieste{get;set;}
	public String IdBozza{get;set;}
	public String tipoRichiesta{get;set;}
    public Integer totalRecord{get;set;} 
    public Integer pageActual{get;set;} 
    public Decimal totalpage{get;set;} 
    public boolean showPag{get;set;} 
    public Decimal pageRecord{get;set;}
    public Integer offset_page{get;set;}
    public Decimal totpg{get;set;} 
    public boolean showRow{get;set;} 
    public Integer totRec{get;set;} 
    public EOF_EAI_Service_Log__c log_richiestaVLAN{get;set;}
    public EOF_EAI_Service_Log__c log_VLAN{get;set;}
    
    public PO_PP_COMP_ListaRichiesteBozza_Ctrl()
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
    	
    	listBozze=[select id, name,recordtype.developername, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore__c,EOF_Data_Notifica__c, 
    	            EOF_ID_Notifica__c, EOF_Tipo_Comunicazione_String__c, EOF_STATO_ORDINE__c, EOF_Stato_Richiesta__c,
    	            POP__c, Nome_del_KIT__c, Traffico__c, Banda_Interfaccia__c, PO_PP_Interfaccia__c, CreatedDate 
                    from EOF_EAI_Service_Log__c 
                    where recordType.developerName in('PO_PP_KIT','PO_PP_VLAN') 
                    AND EOF_Stato_Richiesta__c='Bozza Portale' 
                    AND EOF_Tipo_Comunicazione_String__c in ('KIT Consegna','VLAN')
                    AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                    order by CreatedDate DESC
                    LIMIT :(integer)pageRecord OFFSET :off
                    ];
                                                                                    
        totRec=[Select count()  
                from EOF_EAI_Service_Log__c 
                where recordType.developerName in('PO_PP_KIT','PO_PP_VLAN') 
                AND EOF_Stato_Richiesta__c='Bozza Portale' 
                AND EOF_Tipo_Comunicazione_String__c in ('KIT Consegna','VLAN')
                AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c];
        
        totpg = (totRec /pageRecord).round(RoundingMode.CEILING); 
        setPagination(null); 
    }

    public pageReference vediReq()
    {
        //AA: Modifica 
        //if(tipoRIchiesta.equalsIgnoreCase('Change Order')){
            //Pagereference pg = new Pagereference('/PO_PP_RiepilogoKIT');
            //pg.getParameters().put('origId', IdBozza);
            //return pg;
        //}
    
        system.debug('########> RICHIAMO RIEPILOGO CON ID:IdBozza= '+IdBozza);
        
    	if(tipoRichiesta.equalsIgnoreCase('KIT Consegna'))
    	{
    	    Pagereference pageR = new Pagereference('/PO_RiepilogoKIT');
    		pageR.getParameters().put('origId',IdBozza);
    		pageR.getParameters().put('proc','attivazioneInserita');
    		return pageR;
    	}
        if(tipoRichiesta.equalsIgnoreCase('VLAN'))
        {
            log_VLAN = [Select id, PO_PP_ID_RichiestaVLAN__c
                        from EOF_EAI_Service_Log__c
                        where id =: IdBozza
                        limit 1];
            
            //System.debug('###log_VLAN###: '+log_VLAN);

            log_richiestaVLAN = [Select id, OF_PP_KIT_Log__r.Nome_del_KIT__c
                                from EOF_EAI_Service_Log__c
                                where id =: log_VLAN.PO_PP_ID_RichiestaVLAN__c
                                limit 1];
                          
    	    Pagereference pg = new Pagereference('/PO_PP_RiepilogoSVLAN');
    		pg.getParameters().put('id_richVLAN',log_richiestaVLAN.id);
    		pg.getParameters().put('nameKit',log_richiestaVLAN.OF_PP_KIT_Log__r.Nome_del_KIT__c);
    		return pg;
    	}
    	return null;
    }
    
    //Metodi per la paginazione
    public PageReference pageDown(){ 
    	setPagination(false); 
    	return null; 
    }
    
    public PageReference pageUp(){ 
    	setPagination(true); 
    	return null; 
    }

    public void setPagination(boolean next)
    { 
    	if(next==null)
    	{
    		pageActual=1; 
    		totalpage = totpg; 
    		totalRecord =totRec;
    	}
    	else if(next)
    	{ 
    		if(pageActual<totalpage)
    		{ 
    			pageActual++;
    			totalpage = totpg; 
    			totalRecord = totRec;
    			preparePage(); 
    		} 
    	}
    	else
    	{ 
    		if(pageActual>1)
    		{ 
    			pageActual--; 
    			totalpage = totpg; 
    			totalRecord = totRec;
    			preparePage(); 
    		} 
    	} 
    }

    public void preparePage()
    { 
    
        /*integer index=0;
        if(pageActual==totalpage||pageRecord>listBozze.size()){ 
        
        	index=((pageActual-1)*((integer)pageRecord))+math.mod(totalRecord,(integer)pageRecord);
        	System.debug('**** indexx!!! ' + index);  
        	}else{ 
        		index=(pageActual)*(integer)pageRecord; 
            } */
            
        Integer off=(pageActual-1)*((integer)pageRecord); 
        User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        //Id accId =  [SELECT AccountId  FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId;
        listBozze=[select id,NAME,recordtype.developername, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore__c,EOF_Data_Notifica__c, 
    	            EOF_ID_Notifica__c, EOF_Tipo_Comunicazione_String__c, EOF_STATO_ORDINE__c, EOF_Stato_Richiesta__c,
    	            POP__c, Nome_del_KIT__c, Traffico__c, Banda_Interfaccia__c, PO_PP_Interfaccia__c, CreatedDate 
                    from EOF_EAI_Service_Log__c 
                    where recordType.developerName in('PO_PP_KIT','PO_PP_VLAN')  
                    AND EOF_Stato_Richiesta__c='Bozza Portale' 
                    AND EOF_Tipo_Comunicazione_String__c in ('KIT Consegna','VLAN')
                    AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c  
                    order by CreatedDate DESC
                    LIMIT:(integer)pageRecord  OFFSET :off ];
    }
}
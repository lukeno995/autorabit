public without sharing class PO_COMP_CeD_RichiestaAttivazione_Contr {
	 
	 public static EOF_EAI_Service_Log__c slOrig{get;set;}
     public EOF_EAI_Service_Log__c sl{get;set;}
     public boolean modifyMode{get;set;}
     public boolean insertMode{get;set;}
     public boolean Apparati{get;set;}
     public String DATA_PREVISTA_ATTIVAZIONE{get;set;}
     public Map<String,Id> rtMap;
     public string profiloCommerciale{get;set;}
     public string dataPrevistaAttivazione{get;set;}
     public List<SelectOption> ListaPop{get;set;}
     public boolean verifyProfilo{get;set;} //PG 2-02-2018
     public boolean viewError{get;set;}
     public boolean viewProfilo{get;set;}
     public boolean showErrorEmail{get;set;}
     
     public PO_COMP_CeD_RichiestaAttivazione_Contr()
     {    	 
     	modifyMode=false;
     	insertMode=false;
     	Apparati=false;
     	profiloCommerciale='';
        
        verifyProfilo = true;
     	viewError=false;
        viewProfilo=false;
        showErrorEmail = false;
        
        User attuale=[select Id,Account.EOF_Codice_Operatore__c 
                      from user 
                      where Id=:userinfo.getUserId()];
         
     	if(slOrig!=null){
     		sl=slOrig;
     		modifyMode=true;
     		if(ApexPages.currentPage().getParameters().get('app') =='true'){
     			Apparati=true;
     		}
     		
     		//Add PG - 10-12 - Sezione commentata
     		/*
     		List<EOF_EAI_Service_Log__c> LslVlan= new List<EOF_EAI_Service_Log__c>();
     		
	     	system.debug('gb'+slOrig.EOF_Codice_Ordine_OLO__c);
	     	
	        LslVlan=[Select id 
	                 from EOF_EAI_Service_Log__c 
	                 Where EOF_Codice_Ordine_OLO__c=:slOrig.EOF_Codice_Ordine_OLO__c 
	                 and RecordType.DeveloperName ='OF_SA_Vlan']; 		
     		
     		if(LslVlan.isEmpty())
     		{
 		        Set<String> TuttiIPop = new Set<String>();
		    	for(OF_CommercialElementIstanziato__c vlan:[select PO_PP_POP_SVLAN__c 
		    	                                            from OF_CommercialElementIstanziato__c 
                    										where RecordType.DeveloperName = 'SVLAN' 
                    										and OF_Asset__r.RecordType.DeveloperName = 'PreProvisioning' 
                    										and OF_Asset__r.Account.EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c]){
					TuttiIPop.add(vlan.PO_PP_POP_SVLAN__c);		
				}
				ListaPop = new List<SelectOption>();
				ListaPop.add(new SelectOption('',''));
				
				if(!TuttiIPop.isEMpty())
				{
					for(String pop:TuttiIPop){
						ListaPop.add(new SelectOption(pop,pop));
					}
		        }
     		}
     		else
     		{
                ListaPop = new List<SelectOption>();
                ListaPop.add(new SelectOption(sl.EOF_ID_Pop__c,sl.EOF_ID_Pop__c));
     		}  
     		//End PG - 10-12 - Sezione commentata
     		*/
     	}
     	else
     	{
     		insertMode=true;	
	     	sl = new EOF_EAI_Service_Log__c();
	    	List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
	        rtMap = new Map<String,Id>(); 
	        for(recordtype rt :rtList){
	            rtMap.put(rt.developerName, rt.Id); 
	        } 
	    	sl.recordtypeId=rtMap.get('PO_SA_CD_Log_OpenStreamRequest');
	    	sl.EOF_Stato_Richiesta__c = 'Bozza Portale';
	    	sl.EOF_CODICE_OPERATORE__c = attuale.Account.EOF_Codice_Operatore__c;
	    	sl.EOF_Tipo_Comunicazione_String__c = 'Attivazione';
     	    
     	    //Add PG - 10-12 - Sezione commentata
     	    /*
     	    Set<String> TuttiIPop = new Set<String>();
	    	for(OF_CommercialElementIstanziato__c vlan:[select PO_PP_POP_SVLAN__c 
	    	                                            from OF_CommercialElementIstanziato__c 
                    									where RecordType.DeveloperName='SVLAN' 
                    									and OF_Asset__r.RecordType.DeveloperName ='PreProvisioning' 
                    									and OF_Asset__r.Account.EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c])
			{
                TuttiIPop.add(vlan.PO_PP_POP_SVLAN__c);		
            }
			ListaPop = new List<SelectOption>();
			ListaPop.add(new SelectOption('',''));
			
			if(!TuttiIPop.isEMpty())
			{
				for(String pop:TuttiIPop){
					ListaPop.add(new SelectOption(pop,pop));
				}
		    }
		    */
		    //End PG - 10-12 - Sezione commentata
     	}
    }
       
    public PageReference runSearchProfilo() {
        
    	String TextProfilo = Apexpages.currentPage().getParameters().get('TextProfilo');  
		OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
    	If(objListino != null /*&& objListino.IsPortalValid__c==true*/ && objListino.PO_CD_Profilo_Commerciale__c!=null){
    		profiloCommerciale=(string)objListino.PO_CD_Profilo_Commerciale__c; 
    	}else{
    		profiloCommerciale= 'N/A';  		
    	}
    	//profiloCommerciale ='TEST 2 TEST';
    	viewError=false;
        viewProfilo=true;
	    return null;
	}
	
	//GB 03-04-2018    
    public boolean verifyProfiloNew(String TextProfilo) {
        OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
      
        If(objListino != null /*&& objListino.IsPortalValid__c==true*/ && objListino.PO_CD_Profilo_Commerciale__c!=null){
            verifyProfilo = true;
        }else{
            verifyProfilo = false;
        }      
        system.debug('verifyProfiloNewGB'+verifyProfilo);    
        return verifyProfilo;
    }
    
    /*
    //Verifico la validità dell'indirizzo email
    public Boolean checkValidateEmail() {
        
        String emailRef = sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
        System.debug('****CHECK EMAIL IN CORSO**** : '+emailRef);
        
        if(emailRef!=null)
        {
            String InputString = emailRef;
            String emailRegex = '([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})';
            Pattern MyPattern = Pattern.compile(emailRegex);
            
            // Then instantiate a new Matcher object "MyMatcher"
            Matcher MyMatcher = MyPattern.matcher(InputString);
            
            if(!MyMatcher.matches()) 
            {
                System.debug('*****SONO qui****');
                System.debug('******showErrorEmail****** '+showErrorEmail);
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Check your email')); 
                return false;
            }
            else {
                return true;
            }
        }
        return false;
    }
    */
    
    public pageReference savesl()
    {
    	//GB 03-04-2018
    	if(!verifyProfiloNew(sl.EOF_PROFILO__c))
    	{
    	    viewError=true;
            viewProfilo=false;
            return null; 
    	}     	
        try
        {
            //AS MODIFICA CALENDARIO
            //System.debug('### mt string date'  +dataPrevistaAttivazione);
            //sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c=date.parse(dataPrevistaAttivazione);
            insert sl; 
		}
		catch(DMLexception e)
		{
			ApexPages.addMessages(e); 
			return null;
		}
        PageReference pg = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origId',sl.Id);
        return pg;        
    }
    
    public pageReference annullaInsSl()
    {
    	PageReference pg;
    	if(insertMode){
    		pg = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
    	}
    	//aggiungo la condizione che se si arriva dal clona e annulla cancella tutti i slog
    	else if(ApexPages.currentPage().getParameters().get('tipo') =='clona')
    	{
    		List<EOF_EAI_Service_Log__c> slListToDelete = [select id 
                                                    		from EOF_EAI_Service_Log__c 
                                                    		where id=:ApexPages.currentPage().getParameters().get('origID')
    														OR OF_SA_Cpe_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
					    									OR OF_SA_VLAN_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
					    									OR OF_SA_Servizi_Aggiuntivi_Log__c=:ApexPages.currentPage().getParameters().get('origID')];
			delete slListToDelete;
			pg = new PageReference('/PO_OpenStream_CeD_DisplayRequest');
    	}
    	else
    	{
    		pg = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
    		pg.getParameters().put('proc','attivazioneInserita');
    		pg.getParameters().put('origId',sl.Id);
    	}
    	return pg;
    }
    
    public pageReference updatesl()
    {
        //GB 03-04-2018
    	if(!verifyProfiloNew(sl.EOF_PROFILO__c)){
    	    viewError=true;
            viewProfilo=false;
            return null; 
    	}        
        try
        {
            if(ApexPages.currentPage().getParameters().get('tipo') =='clona')
            {
                //aggiorno con il codice_ordine_OLO tutti i sl associati
                List<EOF_EAI_Service_Log__c> slListToUpdate = [select id 
                                                               from EOF_EAI_Service_Log__c 
                                                               where OF_SA_Cpe_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
                                                               OR OF_SA_VLAN_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
                                                               OR OF_SA_Servizi_Aggiuntivi_Log__c=:ApexPages.currentPage().getParameters().get('origID')];
                slListToUpdate.add(sl);
                update slListToUpdate;
            }
            else
            {
                //AS MODIFICA CALENDARIO
                //sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c=date.parse(dataPrevistaAttivazione);
                update sl;
            }
    	}
    	catch(DMLexception e)
        {
    		ApexPages.addMessages(e);
    		return null;
    	}
        PageReference pg = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origId',sl.Id);
        return pg;
    }
}
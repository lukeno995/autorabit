public class PO_TP_Buttons_Controller {
    
    public Case originalCase{get;set;}
    public boolean sceltaCoda{get;set;}
    public user attuale{get;set;} 
    public String codaTerr{get;set;}
	public String destinatario{get;set;}
	public boolean passaggio{get;set;}
	public boolean chiusura{get;set;}
	
	public boolean noteInterne{get;set;}
	public boolean noteOLO{get;set;}
    public boolean showButtonBlock{get;set;} //FIX IDR019 - PG - 13-04
    public boolean showNoteIncident{get;set;} //Add by PG - 16-05 
    public boolean showNoteProv {get;set;} //Add by PG - 16-05 
    
    
    public PO_TP_Buttons_Controller(ApexPages.StandardController stdController){ 
        
        passaggio=false;
        chiusura=false;
        noteInterne=false;
        noteOLO=false;
        showButtonBlock = true; //FIX IDR019 - PG - 13-04
        showNoteIncident = false;
        showNoteProv = false;
        
        originalCase = (Case)stdController.getRecord();
        
        Attuale=[select id, profile.id, profile.name, Name,UserRoleId from user where id=: userinfo.getUserId()];
        
        originalCase=[select Id, owner.name, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name, 
                        EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c, 
                        PO_Richiesta_a_fattibilit__c, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c, 
                        PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c, 
                        PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c, 
                        PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, 
                        EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c, 
                        OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c, 
                        OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c, 
                        EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c, 
                        PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c, subject
                        from Case 
                        where Id=:ApexPages.currentPage().getParameters().get('Id')]; 
		 
		if(!String.isBlank(originalCase.EOF_Note_Interne__c)){
		    noteOLO=false;
			noteInterne=true;
		}     
		if(!String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)){
			noteOLO=true;
		} 
		if(originalCase.EOF_Fase__c=='In Lavorazione SOC'){
		    noteOLO=false;
            destinatario='Coda Territoriale';
        }
        else if(originalCase.EOF_Fase__c=='In Lavorazione Coda Territoriale'){
            noteOLO=false;
            destinatario='SOC';
        }    
        if(ApexPages.currentPage().getParameters().get('proc')=='pass'){
        	passaggio=true;	        
   	 	    showNoteProv = true; //Add by PG - 16-05 
        }
   	 	else if(ApexPages.currentPage().getParameters().get('proc')=='close'){
   	 		chiusura=true;
            showNoteProv = true;
   	 		destinatario='OLO';
   	 	}
        //START - Add by PG - 16-05 
        else if(ApexPages.currentPage().getParameters().get('proc')=='closeIncident'){
            chiusura=true;
            showNoteIncident = true;
            destinatario='OLO';
        } 
        //END - Add by PG - 16-05
       
        //START - Add by PP CR07 NOTE - 16-05 
        else if(ApexPages.currentPage().getParameters().get('proc')=='addNote'){
            
            passaggio=false;	 
            showNoteProv = true;
            destinatario='OLO';
            noteOLO=true;
        } 
        else if(ApexPages.currentPage().getParameters().get('proc')=='addNoteInc'){
            
            passaggio=false;	 
            showNoteIncident = true;
            destinatario='OLO';
            noteOLO=true;
        } 
        //END - Add by PP CR07 NOTE - 16-05 

        //FIX IDR019 - PG - 13-04
        if(originalCase.owner.name!='TT - Coda SOC Ordini in Attivazione' && originalCase.owner.id!=Attuale.id && Attuale.profile.name=='TP Soc'){
            showButtonBlock = false;
        }
    }
    
    //PG 17-04 - Code territoriali rinominate
    public List<SelectOption> getCodeTerr(){
    	List<SelectOption> codeTerr= new List<SelectOption>();
    	codeTerr.add(new SelectOption('',''));
    	codeTerr.add(new SelectOption('TP_Coda_Delivery_Nord','TT - Coda Nord Ordini in Attivazione'));
    	codeTerr.add(new SelectOption('TP_Coda_Delivery_Centro','TT - Coda Centro Ordini in Attivazione'));
    	codeTerr.add(new SelectOption('TP_Coda_Delivery_Sud','TT - Coda Sud Ordini in Attivazione'));
    	return codeTerr;
    }
    
    public pagereference lavoraCase(){
    	pagereference pg = new pagereference('/'+originalCase.id+'/e');
    	pg.setRedirect(true);
    	return pg;
    }
    
    public pageReference inviaAllaCodaTerr(){
        //System.debug('**CODA TERR***: '+codaTerr);
    	if(String.isNotBlank(codaTerr)){
    		Group owner = [select Id from group where developername=:codaTerr];
    		originalCase.ownerId=owner.Id;
    		originalCase.EOF_Fase__c='In Lavorazione Coda Territoriale';
    		if(String.isBlank(originalCase.EOF_Note_Interne__c)){
    			originalCase.EOF_Note_Interne__c=Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+originalCase.EOF_Note__c;
    		}
    		else{
    			originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c+'\n'+Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+originalCase.EOF_Note__c;
    		}
    		originalCase.EOF_Note__c='';
    		update originalCase; 
    	}
    	return null;
    }
    
    public pageReference inviaAlSOC(){
		Group owner = [select Id from group where developername='TP_Coda_SOC'];
		originalCase.ownerId=owner.Id;
		originalCase.EOF_Fase__c='In Lavorazione SOC';
		if(String.isBlank(originalCase.EOF_Note_Interne__c)){
			originalCase.EOF_Note_Interne__c=Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+originalCase.EOF_Note__c;
		}
		else{
			originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c+'\n'+Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+originalCase.EOF_Note__c;
		}
		originalCase.EOF_Note__c='';
		update originalCase; 
        System.debug('****INVIA AL SOC***'+originalCase);
    	return null;
    }
    
   
    public void PrendiInCarico(){
        originalCase.ownerId=attuale.Id;
        if(originalCase.status=='Acquisito'){
        	originalCase.status='In Lavorazione';
        }
        update originalCase; 
    }
    
    public pageReference chiudiTicket(){
        
    	originalCase.Status='Chiuso';
    	originalCase.EOF_Fase__c='Chiuso';
		if(String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)){
			originalCase.EOF_Comunicazioni_con_OLO__c=Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+originalCase.EOF_Note__c;
		}
		else{
			originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c+'\n'+Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+originalCase.EOF_Note__c;
		}
		originalCase.EOF_Note__c='';
		update originalCase; 
    	return null;
    }  
    
    public pageReference InviaNotaOLO(){
        
    	//originalCase.Status='Chiuso';
    	//originalCase.EOF_Fase__c='Chiuso';
		if(String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)){
			originalCase.EOF_Comunicazioni_con_OLO__c=Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+originalCase.EOF_Note__c;
		}
		else{
			originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c+'\n'+Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+originalCase.EOF_Note__c;
		}
		originalCase.EOF_Note__c='';
		update originalCase; 
    	return null;
    }  

}
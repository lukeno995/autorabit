public class PO_COMP_CeD_RichiestaCessazione_Contr {
    
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
	public EOF_EAI_Service_Log__c sl{get;set;}
	public boolean modifyMode{get;set;}
	public boolean insertMode{get;set;}
	public boolean Apparati{get;set;}
	public String messages{get;set;}
	public Map<String,Id> rtMap;
     
	public PO_COMP_CeD_RichiestaCessazione_Contr()
	{
		modifyMode=false;
		insertMode=false;
		apparati=false;

		if(slOrig!=null)
		{
			sl=slOrig;
			modifyMode=true;
			if(ApexPages.currentPage().getParameters().get('app') =='true')
			{
				Apparati=true;
				if(String.isBlank(sl.EOF_cognome_Cliente__c) && String.isBlank(sl.EOF_Recapito_Telefonico_Cliente_1__c)){
					messages='Compilare i campi \'Cognome Cliente\' e \'Recapito Telefonico CLiente 1\'';
				}else if(String.isBlank(sl.EOF_cognome_Cliente__c)){
					messages='Compilare il campo \'Cognome Cliente\'';
				}else{
					messages='Compilare il campo \'Recapito Telefonico CLiente 1\'';
				}
			}
		}
		else
		{
     		insertMode=true;
     		User attuale=[select Id,Account.EOF_Codice_Operatore__c 
     		              from user 
     		              where Id=:userinfo.getUserId()];
     		              
	     	sl = new EOF_EAI_Service_Log__c();
	    	List<recordtype> rtList=[select Id,developerName 
	    	                         from recordtype];                                                                               
	        rtMap = new Map<String,Id>(); 
	        for(recordtype rt :rtList){
	            rtMap.put(rt.developerName, rt.Id); 
	        } 
	        
	    	sl.recordtypeId=rtMap.get('PO_SA_CD_Log_OpenStreamRequest'); 
	    	sl.EOF_Stato_Richiesta__c = 'Bozza Portale';
	    	sl.EOF_CODICE_OPERATORE__c = attuale.Account.EOF_Codice_Operatore__c;
	    	sl.EOF_Tipo_Comunicazione_String__c = 'Cessazione';
			sl.EOF_ID_Risorsa__c = ApexPages.currentPage().getParameters().get('IdRisorsa');
     	}
	}
	
	public pageReference savesl()
	{
    	try{
    		insert sl;
    	}
    	catch(DMLexception e){
    		ApexPages.addMessages(e);
    		return null; 
    	}
    	PageReference pg = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
    	pg.getParameters().put('proc','cessazioneInserita');
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
    	else if(ApexPages.currentPage().getParameters().get('tipo') =='clona'){
    		List<EOF_EAI_Service_Log__c> slListToDelete = [select id 
    		                                                from EOF_EAI_Service_Log__c 
    		                                                where id=:ApexPages.currentPage().getParameters().get('origID')
    														OR OF_SA_Cpe_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
					    									OR OF_SA_VLAN_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
					    									OR OF_SA_Servizi_Aggiuntivi_Log__c=:ApexPages.currentPage().getParameters().get('origID')];
			delete slListToDelete;
			pg = new PageReference('/PO_OpenStream_DisplayRequest');
    	}
    	else{
    		pg = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
    		pg.getParameters().put('proc','cessazioneInserita');
    		pg.getParameters().put('origId',sl.Id);
    	}
    	return pg;
    }
    
    public pageReference updatesl()
    {
    	try{
    		if(ApexPages.currentPage().getParameters().get('tipo') =='clona'){
    			//aggiorno con il codice_ordine_OLO tutti i sl associati
    			List<EOF_EAI_Service_Log__c> slListToUpdate = [select id 
    			                                                from EOF_EAI_Service_Log__c 
    			                                                where OF_SA_Cpe_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
					    									    OR OF_SA_VLAN_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
					    									    OR OF_SA_Servizi_Aggiuntivi_Log__c=:ApexPages.currentPage().getParameters().get('origID')];
				slListToUpdate.add(sl);
				update slListToUpdate;
    		}
    		else{
    			update sl;
    		}
    	}
    	catch(DMLexception e){
    		ApexPages.addMessages(e);
    		return null;
    	}
    	PageReference pg = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
    	pg.getParameters().put('proc','cessazioneInserita');
    	pg.getParameters().put('origId',sl.Id);
    	return pg;
    }
}
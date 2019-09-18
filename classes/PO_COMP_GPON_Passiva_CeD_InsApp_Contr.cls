public class PO_COMP_GPON_Passiva_CeD_InsApp_Contr {
    
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
    public EOF_EAI_Service_Log__c slApparato{get;set;}
    public Map<String,Id> rtMap{get;set;}
    public static String idApparato{get;set;}
    public boolean modifyMode{get;set;}
    public boolean insertMode{get;set;}
    public boolean attivazione{get;set;}
    public boolean cessazione{get;set;}
    public List<SelectOption> azioneApparatoOptions{get;set;}
     
    public PO_COMP_GPON_Passiva_CeD_InsApp_Contr()
    {
    	modifyMode = false;
     	insertMode = false;
     	attivazione = false;
     	cessazione = false;
     	
     	azioneApparatoOptions = new List<SelectOption>();
    	azioneApparatoOptions.add(new SelectOption('0 - Consegna','0 - Consegna'));
    	azioneApparatoOptions.add(new SelectOption('1 - Consegna e installazione','1 - Consegna e installazione'));
    	azioneApparatoOptions.add(new SelectOption('2 - Solo installazione','2 - Solo installazione'));

     	if(ApexPages.currentPage().getParameters().get('idApparato')!=null)
     	{
     		slApparato=[select Id, EOF_TIPOLOGIA_APPARATO__c,
    					OF_SA_ID_APPARATO__c, OF_SA_PASSWORD_APPARATO__c, OF_SA_AZIONE_APPARATO__c  
    					from EOF_EAI_Service_Log__c 
    					where id=:ApexPages.currentPage().getParameters().get('idApparato')];
     		
     		modifyMode=true;
     	}
     	else
     	{
     		insertMode=true;
	    	slApparato = new EOF_EAI_Service_Log__c();
	    	slApparato.OF_SA_Cpe_Log__c=slOrig.Id;
	    	List<recordtype> rtList = [select Id,developerName 
	    	                           from recordtype];                                                                               
	        
	        rtMap = new Map<String,Id>(); 
	        
	        for(recordtype rt :rtList){
	            rtMap.put(rt.developerName, rt.Id); 
	        } 
	    	slApparato.recordtypeId=rtMap.get('OF_SA_Cpe');
	    	slApparato.EOF_Stato_Richiesta__c = 'Bozza Portale';
	    	slApparato.EOF_Codice_Ordine_OLO__c = ApexPages.currentPage().getParameters().get('codOrdOlo');
     	}
     	
     	if(ApexPages.currentPage().getParameters().get('orig') =='ATT'){
     		attivazione=true;
     	}
     	if(ApexPages.currentPage().getParameters().get('orig') =='CESS'){
     		cessazione=true;
     	}
    }
    
    public PageReference annullaApparato()
    {
    	PageReference pageRef = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
    	if(ApexPages.currentPage().getParameters().get('orig') =='ATT'){
    		pageRef.getParameters().put('proc','attivazioneInserita');
    		pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
    	}
    	if(ApexPages.currentPage().getParameters().get('orig') =='CESS'){
    		pageRef.getParameters().put('proc','cessazioneInserita');
    		pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
    	}
    	pageRef.setRedirect(true);
    	return pageref;
    }
    
    public PageReference InserisciApparato()
    { 
    	insert slApparato;
    	PageReference pageRef = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
    	if(ApexPages.currentPage().getParameters().get('orig') =='ATT'){   
    		pageRef.getParameters().put('proc','attivazioneInserita');
    		pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
    	}
    	if(ApexPages.currentPage().getParameters().get('orig') =='CESS'){
    		pageRef.getParameters().put('proc','cessazioneInserita');
    		pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
    	}
    	pageRef.setRedirect(true);
    	return pageref;
    }
    
    public PageReference updateApparato()
    { 
    	update slApparato;
    	PageReference pageRef = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
    	if(ApexPages.currentPage().getParameters().get('orig') == 'ATT'){
    		pageRef.getParameters().put('proc','attivazioneInserita');
    		pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId')); 
    	}
    	if(ApexPages.currentPage().getParameters().get('orig') == 'CESS'){
    		pageRef.getParameters().put('proc','cessazioneInserita');
    		pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
    	}
    	pageRef.setRedirect(true);
    	return pageref;
    }
}
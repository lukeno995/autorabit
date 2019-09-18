public class PO_COMP_CeD_InsertServAgg_Controller {
    
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
    public EOF_EAI_Service_Log__c slServAgg{get;set;}
    public Map<String,Id> rtMap{get;set;}
    public static String idServAgg{get;set;}
    public boolean modifyMode{get;set;}
    public boolean insertMode{get;set;}
    public List<SelectOption> nomeServizioOptions{get;set;}
    public List<SelectOption> infoServizioOptions{get;set;}
    
    public PO_COMP_CeD_InsertServAgg_Controller()
    {
    	modifyMode = false;
     	insertMode = false;
     	
     	nomeServizioOptions = new List<SelectOption>();
    	nomeServizioOptions.add(new SelectOption('Ribaltamento Impianto','Ribaltamento Impianto'));
    	nomeServizioOptions.add(new SelectOption('Estensione Impianto Cliente','Estensione Impianto Cliente'));
    	
    	infoServizioOptions = new List<SelectOption>();
    	infoServizioOptions.add(new SelectOption('0 - Fornire servizio','0 - Fornire servizio'));
    	infoServizioOptions.add(new SelectOption('1 - Fornire servizio solo se richiesto dal cliente on field','1 - Fornire servizio solo se richiesto dal cliente on field'));
     	
     	if(idServAgg!=null)
     	{
     		slServAgg=[select Id, OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c
					    from EOF_EAI_Service_Log__c 
					    where id=:idServAgg];
     		
     		modifyMode=true;
     	}
     	else
     	{
    		insertMode=true;
	    	slServAgg = new EOF_EAI_Service_Log__c();
	    	slServAgg.OF_SA_Servizi_Aggiuntivi_Log__c=slOrig.Id;
	    	List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
	        rtMap = new Map<String,Id>(); 
	        
	        for(recordtype rt :rtList){
	            rtMap.put(rt.developerName, rt.Id); 
	        } 
	        
	    	slServAgg.recordtypeId=rtMap.get('OF_SA_Servizi_Aggiuntivi');
	    	slServAgg.EOF_Stato_Richiesta__c = 'Bozza Portale';
	    	slServAgg.EOF_Codice_Ordine_OLO__c = ApexPages.currentPage().getParameters().get('codOrdOlo');
     	}
    }
    
    public PageReference annullaServAgg()
    {
    	PageReference pageRef = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
    	
    	if(ApexPages.currentPage().getParameters().get('orig') =='ATT')
    	{
    		pageRef.getParameters().put('proc','attivazioneInserita');
    		pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
    	}
    	if(ApexPages.currentPage().getParameters().get('orig') =='CESS')
    	{
    		pageRef.getParameters().put('proc','cessazioneInserita');
    		pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
    	}
    	pageRef.setRedirect(true);
    	return pageref;
    }
    
    public PageReference InserisciServAgg()
    {
    	insert slServAgg;
    	PageReference pageRef = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
    	
    	if(ApexPages.currentPage().getParameters().get('orig') =='ATT')
    	{
    		pageRef.getParameters().put('proc','attivazioneInserita');
    		pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
    	}
    	if(ApexPages.currentPage().getParameters().get('orig') =='CESS')
    	{
    		pageRef.getParameters().put('proc','cessazioneInserita');
    		pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
    	}
    	pageRef.setRedirect(true);
    	return pageref;
    }
    
    public PageReference updateServAgg()
    {
    	update slServAgg;
    	PageReference pageRef = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
    	if(ApexPages.currentPage().getParameters().get('orig') =='ATT')
    	{
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
}
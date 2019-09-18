public class PO_COMP_CeD_SceltaRequest_Controller {
    
    public String AccountName{get;set;}
    public String requestSelected{get;set;}
    public List<SelectOption> requestOptions{get;set;}
    
    public PO_COMP_CeD_SceltaRequest_Controller(){
        
    	User attuale=[select Id,Account.name 
                	  from user 
                	  where Id=:userinfo.getUserId()];
    	
    	AccountName=attuale.account.name;
    	
    	requestOptions = new List<SelectOption>();
    	requestOptions.add(new SelectOption('ATT','Ordine di Attivazione'));
    	requestOptions.add(new SelectOption('CESS','Ordine di Cessazione'));
    	requestOptions.add(new SelectOption('CHANORD','Ordine di Variazione'));
    }
    
    public pagereference annullaScelta(){
    	Pagereference pg = new PageReference('/PO_Index');
    	return pg;
    }
    
    public pagereference inserisciRequest(){
    	Pagereference pg = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
    	pg.getParameters().put('proc','InserimentoRichiesta'+requestSelected);
    	return pg;
    }
}
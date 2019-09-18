public class PO_COMP_GPON_Passiva_CeD_SceltaReq_Contr {
    
    public String AccountName{get;set;}
    public String requestSelected{get;set;}
    public List<SelectOption> requestOptions{get;set;}
    
    public PO_COMP_GPON_Passiva_CeD_SceltaReq_Contr(){
        
    	User attuale = [select Id, Account.name 
                        from user 
                        where Id=:userinfo.getUserId()];
                    	
    	AccountName = attuale.account.name;
    	
    	requestOptions = new List<SelectOption>();
    	requestOptions.add(new SelectOption('ATT','Ordine di Attivazione'));
    	requestOptions.add(new SelectOption('CESS','Ordine di Cessazione'));
        /*
    	//EC - 2018 - 05 - 21 ChangeOrder START  
    	requestOptions.add(new SelectOption('CHANORD','Ordine di Variazione'));
        //EC - 2018 - 05 -21 ChangeOrder END
        */
    }
    
    public pagereference annullaScelta()
    {
    	Pagereference pg = new PageReference('/PO_Index');
    	return pg;
    }
    
    public pagereference inserisciRequest()
    {
    	Pagereference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
    	pg.getParameters().put('proc','InserimentoRichiesta'+requestSelected);
    	return pg;
    }
}
public class PO_TP_EditFieldsCase {

    public String idCaseTP {get;set;}
    public Case caseTP {get;set;}

    public SelectOption[] elencoSeverity {
    	public get;
    	private set;
    }
    
    //costruttore    
    public PO_TP_EditFieldsCase(ApexPages.StandardController stdController)
    {
        //caseTP = (Case)stdController.getRecord();
     	idCaseTP = ApexPages.currentPage().getParameters().get('Id');
     
     	System.debug(']]]]idCaseTP]]]]: '+idCaseTP);
        
     	//Query sul Case
     	caseTP = [Select id, status, PO_TP_Severity__c, PO_TP_Data_Prevista_Chiusura__c, subject, PO_TP_Causale_Apertura_Segnalazione__c
                   from Case
                   where id=:idCaseTP
 	              ];

		String[] sev = new String[]{'Critical','Alto','Medio','Basso'};
		this.elencoSeverity = new SelectOption[]{};
		
        for (String s: sev) {
			this.elencoSeverity.add(new SelectOption(s,s));
		}
    }
    
    public pageReference aggiornaDati()
    {
        update caseTP;
        PageReference pg = new PageReference('/'+caseTP.id);
        return pg;   
    }
    
    public pageReference annulla()
    {
        PageReference pg = new PageReference('/'+caseTP.id);
        return pg;   
    }
}
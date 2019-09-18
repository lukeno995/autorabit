public class PO_PP_EditFieldsCaseKit {

    public String idCaseKit {get;set;}
    public Case caseKit {get;set;}

    public SelectOption[] elencoTraffico {
    	public get;
    	private set;
    }
    public SelectOption[] elencoInterfacce {
    	public get;
    	private set;
    }
    
    //costruttore    
    public PO_PP_EditFieldsCaseKit(ApexPages.StandardController stdController)
    {
        //caseKit = (Case)stdController.getRecord();
     	idCaseKit = ApexPages.currentPage().getParameters().get('Id');
     
     	System.debug(']]]]idCaseKit]]]]: '+idCaseKit);
        
     	//Query sul Case
     	caseKit = [Select id, status, PO_PP_Posizione_ODF__c,PO_PP_NomeKit__c, PO_PP_POP__c, PO_PP_Traffico__c, PO_PP_Banda__c,
     	           PO_PP_Interfaccia_Kit__c, EOF_Fase__c
                   from Case
                   where id=:idCaseKit
 	              ];
 	    
 	    String[] traffico = new String[]{'VULA','VULA Direct','BITSTREAM'};
		this.elencoTraffico = new SelectOption[]{};
		
		for (String t: traffico) {
			this.elencoTraffico.add(new SelectOption(t,t));
		}
		
		String[] interfaccia = new String[]{'None','1 Giga','10 Giga'};
		this.elencoInterfacce = new SelectOption[]{};
		
        for (String i: interfaccia) {
			this.elencoInterfacce.add(new SelectOption(i,i));
		}
    }
    
    public pageReference aggiornaDati()
    {
        update caseKit;
        PageReference pg = new PageReference('/'+caseKit.id);
        return pg;   
    }
    
    public pageReference annulla()
    {
        PageReference pg = new PageReference('/'+caseKit.id);
        return pg;   
    }
}
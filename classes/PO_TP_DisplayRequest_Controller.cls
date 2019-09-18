public class PO_TP_DisplayRequest_Controller {
	
    public boolean showList{get;set;}
    public boolean showIncidentList{get;set;}
    public String tipo_filtro{get;set;}
    
    public PO_TP_DisplayRequest_Controller(){

		if(ApexPages.currentPage().getParameters().get('azione')=='Provisioning') {            
			tipo_filtro = 'Segnalazione Provisioning';
			showList = true;
		}
		else if(ApexPages.currentPage().getParameters().get('azione')=='Incident') {            
			tipo_filtro = 'Problema tecnico/applicativo';
			showIncidentList = true;
		}
		else{
	    	showList=true;
		}

    }
}
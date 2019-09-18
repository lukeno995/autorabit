public class PO_TP_Service_Controller {
    //public EOF_EAI_Service_Log__c miocase {get;set;}
    public boolean showInsert{get;set;}
    public boolean showIncident{get;set;} //ADD by PG - 27-04 - Sdoppiata logica tra Segnalazione Prov e Incident Management
    public boolean visualizzaTP{get;set;}
    public boolean visualizzaTP_Incident{get;set;} //ADD by PG - 27-04
    public String tipo_azione{get;set;}
    
    public PO_TP_Service_Controller() {

        if(ApexPages.currentPage().getParameters().get('proc')=='TPVisualizza'){
        	visualizzaTP=true;
        }
        else if(ApexPages.currentPage().getParameters().get('azione')=='Provisioning') {            
            tipo_azione = 'Segnalazione Provisioning';
            showInsert = true;
        }
        else if(ApexPages.currentPage().getParameters().get('azione')=='Incident') {            
            tipo_azione = 'Problema tecnico/applicativo';
            showIncident = true;
        }
        else if(ApexPages.currentPage().getParameters().get('proc')=='TPVisualizzaIncident'){
            visualizzaTP_Incident=true;
        }
        else{
        	showInsert = true;
        }
    }
}
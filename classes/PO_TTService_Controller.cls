//@Author O.S ATOS CRM
public with sharing class PO_TTService_Controller {
    //public EOF_EAI_Service_Log__c miocase {get;set;}
    public boolean showInsert{get;set;}
    public boolean showVisualizza{get;set;}
    public boolean showRichiestaAnnullamento{get;set;}
    public boolean showTestKO{get;set;}
    public boolean showTestOK{get;set;}
    public boolean showDesospensione{get;set;}
    public boolean showAutoripristino{get;set;} 
    
    public PO_TTService_Controller() {
        showInsert = true;
        showVisualizza = false;
        showRichiestaAnnullamento = false;
        showTestKO = false;
        showDesospensione = false;
        showAutoripristino = false;
        
    	//miocase = new case();
    	//miocase.Data_Ora_Autoripristinato__c = Datetime.now();
        system.debug('val========='+ApexPages.currentPage().getParameters().get('proc') == 'TTVisualizza');
        
        if( ApexPages.currentPage().getParameters().get('proc') == 'TTVisualizza')
        {
            showVisualizza = true;
            showInsert = false;
            showRichiestaAnnullamento = false;
            showTestKO = false;
            showTestOK = false;
            showDesospensione = false;
        	showAutoripristino = false;
        }
        if( ApexPages.currentPage().getParameters().get('proc') == 'TTModifica')
        {
            showVisualizza = false;
            showInsert = true;
            showRichiestaAnnullamento = false;
            showTestKO = false;
            showTestOK = false;
            showDesospensione = false;
        	showAutoripristino = false;
        }
        if( ApexPages.currentPage().getParameters().get('proc') == 'TTRichiestaAnnullamento')
        {
            showVisualizza = false;
            showInsert = false;
            showRichiestaAnnullamento = true;
            showTestKO = false;
            showTestOK = false;
            showDesospensione = false;
        	showAutoripristino = false;
        }
        if( ApexPages.currentPage().getParameters().get('proc') == 'TTTestKO')  
        {
            showVisualizza = false;
            showInsert = false;
            showRichiestaAnnullamento = false;
            showTestKO = true;
            showTestOK = false;
            showDesospensione = false;
        	showAutoripristino = false;
        }
		if( ApexPages.currentPage().getParameters().get('proc') == 'TTTestOK')  
        {
            showVisualizza = false;
            showInsert = false;
            showRichiestaAnnullamento = false;
            showTestKO = false;
            showTestOK = true;
            showDesospensione = false;
        	showAutoripristino = false;
        }
        if( ApexPages.currentPage().getParameters().get('proc') == 'TTDesospensione')
        {
            showVisualizza = false;
            showInsert = false;
            showRichiestaAnnullamento = false;
            showTestKO = false;
            showTestOK = false;
            showDesospensione = true;
        	showAutoripristino = false;
        }
        if( ApexPages.currentPage().getParameters().get('proc') == 'TTAutoripristinato')
        {
            showVisualizza = false;
            showInsert = false;
            showRichiestaAnnullamento = false;
            showTestKO = false;
            showTestOK = false;
            showDesospensione = false;
        	showAutoripristino = true;
        }
        
        
    }
}
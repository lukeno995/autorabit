public with sharing class OF_TT_PhaseTransictions_Controller {

    public String oper{get;set;}
    public final Case c{get;set;}
    public final String urlRedir{get;set;}

    public String getTitle(){
        return c.EOF_Fase__C;
    }

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public OF_TT_PhaseTransictions_Controller(ApexPages.StandardController stdController) {        
        c = [Select Id,EOF_Causale_Errore__c,EOF_Fase__c,Status,EOF_Note_Operatore_Analisi__C,EOF_Note_Operatore_on_Field__C, EOF_Note_Operatore__c,EOF_Note_Interne__c,
            EOF_Note_Operatore_Collaudo__C,Owner.name,CaseNumber,EOF_Descrizione_Intervento_Risoluzione__c
			from Case where Id=:ApexPages.currentPage().getParameters().get('Id')];
        oper=ApexPages.currentPage().getParameters().get('Oper');
        Schema.DescribeSObjectResult result = Case.SObjectType.getDescribe();
        urlRedir='/'+result.getKeyPrefix() + '/o';

    }

    public void inviaOnField(){
        c.eof_fase__c='On Field';
        if(String.isBlank(c.EOF_Note_Interne__c)){
        	c.EOF_Note_Interne__c=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+c.owner.name+':\n'+c.EOF_Note_Operatore__c;
        }
        else{
        	c.EOF_Note_Interne__c=c.EOF_Note_Interne__c+'\n'+ OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+c.owner.name+':\n'+c.EOF_Note_Operatore__c;
        }
        c.EOF_Note_Operatore__c='';
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = true;
        c.setOptions(dmo); 
        update c;
       
    }
    public void inviaInCollaudo(){
    	
       if(String.isBlank(c.EOF_Note_Interne__c)){
        	c.EOF_Note_Interne__c=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+c.owner.name+':\n'+c.EOF_Note_Operatore__c;
        }
        else{
        	c.EOF_Note_Interne__c=c.EOF_Note_Interne__c+'\n'+ OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+c.owner.name+':\n'+c.EOF_Note_Operatore__c;
        }
        c.EOF_Note_Operatore__c='';
        c.eof_fase__c='In Collaudo';
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = true;
        c.setOptions(dmo); 
        update c;
    }
    public void inviaInAnalisi(){
    	
        if(String.isBlank(c.EOF_Note_Interne__c)){
        	c.EOF_Note_Interne__c=OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+c.owner.name+':\n'+c.EOF_Note_Operatore__c;
        }
        else{
        	c.EOF_Note_Interne__c=c.EOF_Note_Interne__c+'\n'+ OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+c.owner.name+':\n'+c.EOF_Note_Operatore__c;
        }
        c.EOF_Note_Operatore__c='';
        c.eof_fase__c='Da Lavorare';
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = true;
        c.setOptions(dmo); 
        update c;
    }

    
}
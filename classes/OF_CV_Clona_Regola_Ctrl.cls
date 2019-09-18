public class OF_CV_Clona_Regola_Ctrl {
    
    public List<OLO_ID__c> operatori{get;set;}
    public String operatore{get;set;}
    public String servizio{get;set;}
    public String ruleToCopy{get;set;}
    public String oldOlo{get;set;}
    public String oldServ{get;set;}

    public OF_CV_Clona_Regola_Ctrl(){
        ruleToCopy = ApexPages.currentPage().getParameters().get('ruleName');
        oldOlo = ApexPages.currentPage().getParameters().get('oldOlo');
        oldServ = ApexPages.currentPage().getParameters().get('oldServ');
    }
    
    public List<SelectOption> getOptOperatori() 
    {
        List<SelectOption> options = new List<SelectOption>();
        operatori = [Select id, name
                    from OLO_ID__c 
                    ];
                    
        for(OLO_ID__c op:operatori){
            options.add(new SelectOption(op.name,op.name));
        }
        return options;
    }
    
    public List<SelectOption> getOptServizi(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('ATTIVO','ATTIVO'));
        options.add(new SelectOption('PASSIVO','PASSIVO'));

        return options;
    }

    public PageReference clonaRegola(){
        //Richiamo il metodo per clonare la regola selezionata
        String esito = OF_CV_Regole_Utils.clonaRegola(ruleToCopy, operatore, servizio, oldServ, oldOlo);
        //Se il metodo mi restituisce un KO, mostro l'errore in pagina
        if(esito == 'KO'){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Errore durante la clonazione della regola. Riprovare piu\' tardi.'));
            return null;
        }else{//Se il metodo mi restituisce un OK, vado alla home
            PageReference pg = new PageReference('/apex/OF_CV_Home');
            return pg;
        }
    }

    public PageReference annulla(){
        PageReference pg = new PageReference('/apex/OF_CV_home');
        return pg;        
    }
}
public class OF_CV_CreaRegola_Controller {

    public List<OLO_ID__c> operatori{get;set;}
    public List<Case> servizi{get;set;}
    public String stato{get;set;}
    public String operatore{get;set;}
    public String servizio{get;set;}

    public OF_CV_CreaRegola_Controller(){}
    
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
    
    public List<SelectOption> getOptServizi() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('ATTIVO','ATTIVO'));
        options.add(new SelectOption('PASSIVO','PASSIVO'));
        /*
        servizi = [Select id, OF_Servizio__c
                    from Case
                    where OF_Servizio__c!=null
                    order by createdDate desc
                    limit 7
                  ];
                  
        for(Case s:servizi){
            options.add(new SelectOption(s.OF_Servizio__c,s.OF_Servizio__c));
        }
        */
        return options;
    }
    
    public List<SelectOption> getStati() 
    {
        List<SelectOption> stati = new List<SelectOption>();
        stati.add(new SelectOption('',''));
        stati.add(new SelectOption('101','101'));
        //stati.add(new SelectOption('102','102'));
        //stati.add(new SelectOption('103','103'));
        stati.add(new SelectOption('104','104'));
        stati.add(new SelectOption('105','105'));
        stati.add(new SelectOption('106','106'));
        stati.add(new SelectOption('110','110'));

        return stati;
    }
    
    public PageReference sceltaPop()
    {
        PageReference pg = new PageReference('/apex/OF_CV_SceltaPOP');
        pg.getParameters().put('olo', operatore);
        pg.getParameters().put('servizio_selected', servizio);
        pg.getParameters().put('statoRegola', stato);
        return pg;
    }
    
    public PageReference annulla()
    {
        PageReference pg = new PageReference('/apex/OF_CV_home');
        return pg;        
    }
}
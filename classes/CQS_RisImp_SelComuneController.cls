public class CQS_RisImp_SelComuneController {
    
    public OF_CQS_Risorse_Impiegate__c rImp {get;set;}
    
    public List<SelectOption> optListaComune{get; set;}
    public String optSceltaComune{get; set;}
    
    public List<SelectOption> optListaProgetti{get; set;}
    public String optSceltaProgetto{get; set;}    
    
    public boolean rtiImpresa{get;set;}
    
    public string ldoStr{get;set;} // sostituisce jnldo
    public string ragSocialeImpresa{get;set;} //sostituisce Snjun
    
    public List<SelectOption> optTipoForm {get;set;}
    public List<String> tipoForm {get;set;}
    public String optScelta{get; set;}
    public boolean consRisSett{get;set;}
    public boolean pianRisMensB{get;set;}
    public String consRis{get;set;}
    public String pianRisMens{get;set;}
    public String pianRisSett{get;set;}
    
    // public CQS_RisImp_SelComuneController(){
    public CQS_RisImp_SelComuneController(ApexPages.StandardController stdController) {
        //   public CQS_RisorseImpiegateController() {  
        system.debug('siamo dentro al controller');
        rImp = new OF_CQS_Risorse_Impiegate__c();
        this.rImp = (OF_CQS_Risorse_Impiegate__c)stdController.getRecord();
        scegliTipoForm();
        definisciComuniPl();
    }
    
    public void definisciComuniPl(){
        System.debug('dentro a definisciComuniPl()');
        List<String> juncUserProg = new List<String>();
        
        // optNomeProgetto = optListaComune  
        optListaComune = new List<SelectOption>();
        Set<String> nomeComuneSet = new Set<String>();
        Map<String,String> ldoMap = new Map<String, String>();
        
        Map<String,String> rsocial = new Map<String, String>(); //rsocial= ragione sociale
        
        
        map<string,CQS_Prog_An_junc__c> mapComuneAnJu = new map<string,CQS_Prog_An_junc__c>();
        
        for(CQS_Prog_An_junc__c jnt :  [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Progetto__r.CQS_Pro_Comune__c,CQS_Praj_Ragione_Sociale__c,CQS_Praj_Ragione_Sociale__r.name
                                        from CQS_Prog_An_junc__c])
        {
            mapComuneAnJu.put(jnt.CQS_Praj_Progetto__r.CQS_Pro_Comune__c,jnt);
        }
        
        CQS_Prog_An_junc__c anJunc  = new CQS_Prog_An_junc__c();
        System.debug('userId= ' +userinfo.getUserId());
        
        for(Progetto_Utente_junction__c prUtJunc:[select CQS_junc_progetto__r.Name,CQS_junc_progetto__r.CQS_Pro_Comune__c,CQS_junc_progetto__c 
                                                  from Progetto_Utente_junction__c where CQS_junc_user__c =:userinfo.getUserId()]){
                                                      nomeComuneSet.add(prUtJunc.CQS_junc_progetto__r.CQS_Pro_Comune__c); //EC 2018 - 09 - 18 
                                                      
                                                    //  optListaComune.add(new SelectOption(prUtJunc.CQS_junc_progetto__r.CQS_Pro_Comune__c,prUtJunc.CQS_junc_progetto__r.CQS_Pro_Comune__c)); 
                                                      system.debug('peppe'+prUtJunc.CQS_junc_progetto__r.CQS_Pro_Comune__c);
                                                      
                                                      anJunc =  mapComuneAnJu.get(prUtJunc.CQS_junc_progetto__r.CQS_Pro_Comune__c);
                                                      
                                                      system.debug('anJunc======='+anJunc); 
                                                      if(anJunc != null && anJunc.CQS_Praju_LDO__c != null)                                 
                                                          ldoStr =anJunc.CQS_Praju_LDO__c;
                                                      if(anJunc != null && anJunc.CQS_Praj_Ragione_Sociale__c != null)
                                                          ragSocialeImpresa = anJunc.CQS_Praj_Ragione_Sociale__r.name;
                                                      system.debug('optSceltaComune===='+prUtJunc.CQS_junc_progetto__r.CQS_Pro_Comune__c);
                                                      system.debug('ldo===='+ldoStr);
                                                      system.debug('rsoci===='+ragSocialeImpresa); 
                                                      system.debug('rImp===='+rImp);
                                                      optSceltaComune= anJunc.CQS_Praj_Progetto__c;            
                                                      system.debug(optListaComune);                                         
                                                  } 
        for(string s: nomeComuneSet){
        optListaComune.add(new SelectOption(s,s));
        }
    }
    
    public PageReference goToRealForm(){
        consRisSett=false;
        pianRisMensB=false;
        system.debug('@@@@@@@@ optSceltaForm: ' + optScelta);
        PageReference pg = new PageReference('/apex/CQS_RisorseImpiegate');  
        pg.getParameters().put('optSceltaComune', optSceltaComune);
        if(optScelta=='Consuntivo Risorse Giornaliero' || optScelta==null || optScelta==''){
            consRis= 'true';
            pg.getParameters().put('consRis',consRis);
        }
        else if(optScelta=='Pianificato Risorse Settimanale'){
            pianRisSett= 'true';
            pg.getParameters().put('pianRisSett',pianRisSett);
            pg= null;
        }
        else if(optScelta=='Pianificato Risorse Mensile'){
            pianRisMens= 'true';
            pg.getParameters().put('pianRisMens',pianRisMens);
            pg= null;
        }
        pg.setRedirect(true);
        return pg;
        //return null;
    }
    
    public void scegliTipoForm(){
        tipoForm = new List<String>();    
        optTipoForm= new List<SelectOption>();
        optTipoForm.add(new SelectOption('Consuntivo Risorse Giornaliero','Consuntivo Risorse Giornaliero'));
        optTipoForm.add(new SelectOption('Pianificato Risorse Settimanale','Pianificato Risorse Settimanale'));
        optTipoForm.add(new SelectOption('Pianificato Risorse Mensile','Pianificato Risorse Mensile'));
        //  optScelta=SelectOption.getLabel();
    }
    
  
    
}
public class CQS_RisorseImpiegateController {
    
    public OF_CQS_Risorse_Impiegate__c rImp {get;set;}
    
    public List<SelectOption> optListaComune{get; set;}
    public String optSceltaComune{get; set;}
    public String ComuneSelezionato{get; set;}
    
    public String idProg{get;set;}
    public List<SelectOption> optListaProgetti{get; set;}
    public String optSceltaProgetto{get; set;}
    public List<String> idProgList {get; set;}    
    
    public boolean rtiImpresa{get;set;}
    
    public string ldoStr{get;set;} // sostituisce jnldo
    public string ragSocialeImpresa{get;set;} //sostituisce Snjun
    
    public List<CQS_Prog_An_junc__c> impreseAti  {get;set;}
    public boolean ati{get;set;}
    public String nomeImpresa{get;set;}
    public map<String,Id> rtmap{get; set;}
    
    public PageReference pageRef{get;set;}
    public integer SommaFTEConsuntivati {get;set;}//2018 - 09 - 19
    public List<OF_CQS_Risorse_Impiegate__c> sommaFTEconsList {get;set;}
    
    
    public CQS_RisorseImpiegateController(ApexPages.StandardController stdController) {
        //   public CQS_RisorseImpiegateController() {  
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@EC siamo dentro al controller di Risorse Impiegate');
        SommaFTEConsuntivati=0;
        rImp = new OF_CQS_Risorse_Impiegate__c();
        this.rImp = (OF_CQS_Risorse_Impiegate__c)stdController.getRecord();
         rtmap=new map<String,Id>();
                 for(recordtype rt : [select developername,id from recordtype where sObjectType='OF_CQS_Risorse_Impiegate__c']){
                    rtmap.put(rt.developername,rt.Id);
                    system.debug('@@@@@@@@@@@@@@@EC nel controller di risorse Impiegate, popoliamo la mappa dei recordtype di risorse impiegate. la stampa della mappa è la seguente: ' + rtmap);
                 }
        ati=false;
        if(ApexPages.currentPage().getParameters().get('optSceltaComune') !='' && ApexPages.currentPage().getParameters().get('optSceltaComune') != null  && ApexPages.currentPage().getParameters().get('optSceltaComune') !='null') {
            system.debug('@@@@@@@@@@@@@@EC apex currentpage get param != null e vale ' + optSceltaComune );
            ComuneSelezionato=ApexPages.currentPage().getParameters().get('optSceltaComune');
           
            system.debug('@@@@@@@@@@@@@@EC ComuneSelezionato ' + ComuneSelezionato);
            // optListaProgetti=definisciProgettiPlsO(optSceltaComune);
            definisciProgettiPl2(ComuneSelezionato);
            
        }
        else{
            system.debug('@@@@@@@@@@@@@@EC apex currentpage param è null'); 
        }
        
    /*    sommaFTEconsList= [Select id, CQS_RisImp_Data__c, CQS_RI_LDO__c, CQS_RisImp_Impresa_Mandataria__c,
                           CQS_RisImp_Somma_FTE_formula1__c,CQS_RisImp_TipoRapporto__c,OF_CQS_Comune_Ris_Imp__c 
                           from OF_CQS_Risorse_Impiegate__c where CQS_RisImp_TipoRapporto__c ='Consuntivo'];
        for(integer i=0; i<= sommaFTEconsList.size(); i++)
        for(OF_CQS_Risorse_Impiegate__c risImp : sommaFTEconsList){
       //     if(risImp.OF_CQS_Comune_Ris_Imp__c==sommaFTEconsList.OF_CQS_Comune_Ris_Imp__c){
                
          //  }*/
        
    }
    
    public void definisciProgettiPl2(string ComuneSelezionato){
        System.debug('dentro a definisciProgettiPl()');
        List<String> juncUserProg = new List<String>();
        impreseAti = new List<CQS_Prog_An_junc__c>();
        
        optListaProgetti = new List<SelectOption>();
        Map<String,String> ldoMap = new Map<String, String>();
        Map<String,String> rsocial = new Map<String, String>();
        map<string,CQS_Prog_An_junc__c> mapComuneAnJu = new map<string,CQS_Prog_An_junc__c>();
        
        for(CQS_Prog_An_junc__c jnt :  [select CQS_Praju_LDO__c,CQS_Praj_Progetto__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c, 
                                        CQS_Praj_Ragione_Sociale__r.Name, CQS_Praj_Progetto__r.CQS_Pro_Comune__c,
                                        CQS_Praj_Ragione_Sociale__r.RecordType.DeveloperName,CQS_Praj_Ragione_Sociale__r.RecordTypeId
                                        from CQS_Prog_An_junc__c where CQS_Praj_Progetto__r.CQS_Pro_Comune__c=:ComuneSelezionato])
        {
            mapComuneAnJu.put(jnt.CQS_Praj_Progetto__r.Name,jnt);
        }
        
        CQS_Prog_An_junc__c jnc  = new CQS_Prog_An_junc__c();
        System.debug('userId= ' +userinfo.getUserId());
        for(Progetto_Utente_junction__c jpu:[select CQS_junc_progetto__r.Name,CQS_junc_progetto__c,CQS_junc_progetto__r.CQS_Pro_Comune__c 
                                             from Progetto_Utente_junction__c 
                                             where CQS_junc_user__c =:userinfo.getUserId() and CQS_junc_progetto__r.CQS_Pro_Comune__c=: ComuneSelezionato]){
                                                 optListaProgetti.add(new SelectOption(jpu.CQS_junc_progetto__c,jpu.CQS_junc_progetto__r.Name)); 
                                                 system.debug('peppe'+jpu.CQS_junc_progetto__r.Name);                                   
                                                 jnc =  mapComuneAnJu.get(jpu.CQS_junc_progetto__r.Name);
                                                 
                                                 system.debug('jnc======='+jnc); 
                                                 if(jnc != null && jnc.CQS_Praju_LDO__c != null)                                 
                                                     ldoStr =jnc.CQS_Praju_LDO__c;
                                                 if(jnc != null && jnc.CQS_Praj_Ragione_Sociale__c != null)
                                                     ragSocialeImpresa = jnc.CQS_Praj_Ragione_Sociale__r.name;
                                                 //system.debug('projectName===='+jnc.CQS_Praj_Progetto__c);                                   
                                                 system.debug('ldo===='+ldoStr);
                                                 system.debug('rsoci===='+ragSocialeImpresa); 
                                                 
                                                 optSceltaProgetto= jnc.CQS_Praj_Progetto__c;            
                                                 system.debug(optSceltaProgetto); 
                                                 if(jnc.CQS_Praj_Ragione_Sociale__r.RecordType.DeveloperName=='CQS_Imprese_in_raggruppamento'){
                                                     impreseAti.add(jnc);
                                                     ati=true;
                                                 }
                                             } 
        /* for(CQS_Prog_An_junc__c jpu2: [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c
from CQS_Prog_An_junc__c where CQS_Praj_Progetto__r.Name=:optSceltaProgetto )
{
ldoMap.put(jpu2.CQS_Praj_Progetto__r.Name,jpu2.CQS_Praju_LDO__c );
rsocial.put(jpu2.CQS_Praj_Progetto__r.Name,jpu2.CQS_Praj_Ragione_Sociale__c); 
ldoMap.put(jpu2.CQS_Praj_Progetto__r.Name,jpu2.CQS_Praju_LDO__c );

} */
        defineLDO();
    }  
    
    public pageReference defineLDO(){
        //  definisciProgettiPl();
        system.debug('@@@@@@@@@@@@@@EC nel metodo defineLDO optSceltaProgetto è' + optSceltaProgetto);
        Map<String,String> ldoMap = new Map<String, String>();
        Map<String,String> regMap = new Map<String, String>();
        Map<String,String> regMapName = new Map<String, String>();
        for(CQS_Prog_An_junc__c jpu2: [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c,
                                       CQS_Praj_Progetto__r.CQS_Pro_Comune__c, CQS_Praj_Ragione_Sociale__r.Name, CQS_Praj_Ragione_Sociale__r.RecordType.DeveloperName
                                       from CQS_Prog_An_junc__c where CQS_Praj_Progetto__c=:optSceltaProgetto] ){
                                           ldoMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praju_LDO__c );
                                           regMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praj_Ragione_Sociale__c);
                                           regMapName.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praj_Ragione_Sociale__r.Name);
                                           // rImp.CQS_RI_LDO__c=ldoMap.get(jpu2.CQS_junc_progetto__c);
                                       }
        rimp.OF_CQS_Comune_Ris_Imp__c=ComuneSelezionato;
        rImp.CQS_RI_LDO__c=ldoMap.get(optSceltaProgetto);
        rImp.CQS_RisImp_Impresa_Mandataria__c=regMap.get(optSceltaProgetto);
        nomeImpresa=regMapName.get(optSceltaProgetto);
        system.debug('@@@@@@@@@@@@@@@@@EC nomeImpresa è ' + nomeImpresa);
        rimp.CQS_RisImp_Progetto__c=optSceltaProgetto;
        if(nomeImpresa!=null && nomeImpresa!=''){
      //  ati=defAtiBool(nomeImpresa);
      //if(nomeImpresa.contains('RTI-')){
      if(nomeImpresa.contains('RTI-') || nomeImpresa.contains('RTI -')){
      ati=true;
      rImp.OF_CQS_Contrattista_Lotto1__c=[select id, CQS_An_ConsorziataCapogruppo__c,CQS_An_Consorziata_2__c,CQS_An_Consorziata_3__c, CQS_An_Consorziata_4__c from OF_CQS_Anagrafica__c where id=: regMap.get(optSceltaProgetto)].CQS_An_ConsorziataCapogruppo__c;  
      rImp.OF_CQS_Contrattista_Lotto2__c=[select id, CQS_An_ConsorziataCapogruppo__c,CQS_An_Consorziata_2__c,CQS_An_Consorziata_3__c, CQS_An_Consorziata_4__c from OF_CQS_Anagrafica__c where id=: regMap.get(optSceltaProgetto)].CQS_An_Consorziata_2__c;  
      rImp.OF_CQS_Contrattista_Lotto3__c=[select id, CQS_An_ConsorziataCapogruppo__c,CQS_An_Consorziata_2__c,CQS_An_Consorziata_3__c, CQS_An_Consorziata_4__c from OF_CQS_Anagrafica__c where id=: regMap.get(optSceltaProgetto)].CQS_An_Consorziata_3__c;  
      rImp.OF_CQS_Contrattista_Lotto4__c=[select id, CQS_An_ConsorziataCapogruppo__c,CQS_An_Consorziata_2__c,CQS_An_Consorziata_3__c, CQS_An_Consorziata_4__c from OF_CQS_Anagrafica__c where id=: regMap.get(optSceltaProgetto)].CQS_An_Consorziata_4__c;
     //EC contrattista 5 2018 - 10 - 22
      rImp.OF_CQS_Contrattista_Lotto5__c=[select id, CQS_An_ConsorziataCapogruppo__c,CQS_An_Consorziata_2__c,CQS_An_Consorziata_3__c, CQS_An_Consorziata_4__c,CQS_An_Consorziata_5__c from OF_CQS_Anagrafica__c where id=: regMap.get(optSceltaProgetto)].CQS_An_Consorziata_5__c;  
      }
      else{
      ati=false;
      rImp.OF_CQS_Contrattista_Lotto1__c=rImp.CQS_RisImp_Impresa_Mandataria__c;
      rImp.OF_CQS_Contrattista_Lotto2__c=null;
      rImp.OF_CQS_Contrattista_Lotto3__c=null;
      rImp.OF_CQS_Contrattista_Lotto4__c=null;
      rImp.OF_CQS_Contrattista_Lotto5__c=null;//EC contrattista 5 2018 - 10 - 22
      }
      
      
         // ati=(nomeImpresa.contains('RTI')?true:false);
            system.debug('@@@@@@@@@@@@@@EC nel metodo defineLDO il boolean ati è ' + ati);
        }
       // if(rImp.CQS_RisImp_Impresa_Mandataria__r.RecordType.DeveloperName=='CQS_Imprese_in_raggruppamento'){
       
     //   }
      //  else{
        //rImp.OF_CQS_Contrattista_Lotto1__c='';   
//        }
     //   */
        system.debug('Testin'+ ldoMap);     
        return null;
        //return ev.CQS_Ev_Lettera_D_Ordine__c=ldoMap.get(optSceltaProgetto);
        
    }
    
    public boolean defAtiBool(String nImpr){
        ati=(nomeImpresa.contains('RTI -')?true:false);
        system.debug('@@@@@@@@@@@@@@EC nel metodo defAtiBool il boolean ati è ' + ati + ', perché il nome dell\'impresa passato come parametro è ' + nImpr);
        return ati;
    }
    
    public List<SelectOption> definisciProgettiPlsO(string nomeComune) {     
        List<SelectOption> optListaProgetti = new List<SelectOption>();
        system.debug('@@@@@@@ nel metodo definisciProgettiPl, il parametro passato è ' + optSceltaComune);
        for(CQS_Prog_An_junc__c sPro : [select CQS_Praju_LDO__c,CQS_Praj_Progetto__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c,CQS_Praj_Ragione_Sociale__r.name, CQS_Praj_Progetto__r.CQS_Pro_Comune__c
                                        from CQS_Prog_An_junc__c where CQS_Praj_Progetto__r.CQS_Pro_Comune__c=:optSceltaComune] ){
                                            system.debug('@@@@@@@ optSceltaComune è ' + optSceltaComune + ', sPro ' + sPro + ', sPro.CQS_Praj_Progetto__c' + sPro.CQS_Praj_Progetto__c + 'sPro.CQS_Praj_Progetto__r.Name ' + sPro.CQS_Praj_Progetto__r.Name );
                                            optListaProgetti.add(new  SelectOption(sPro.CQS_Praj_Progetto__c, sPro.CQS_Praj_Progetto__r.Name));
                                            system.debug('');
                                        }
        return optListaProgetti;
    }
    
    
    public PageReference definisciProgettiPl(){
        Map<String,String> ldoMap = new Map<String, String>();
        List<SelectOption> optListaProgetti = new List<SelectOption>();
        List<String> optListaNomeProg =new List<String>();
        
        system.debug('@@@@@@@ nel metodo definisciProgettiPl, il parametro passato è ' + optSceltaComune);
        
        
        Map<String,String> regMap = new Map<String, String>();
        
        for(CQS_Prog_An_junc__c jpu2: [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c, CQS_Praj_Ragione_Sociale__r.Name, CQS_Praj_Progetto__r.CQS_Pro_Comune__c
                                       from CQS_Prog_An_junc__c where CQS_Praj_Progetto__r.CQS_Pro_Comune__c=:optSceltaComune] ){
                                           
                                           //ldoMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praju_LDO__c );
                                           //regMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praj_Ragione_Sociale__c);
                                           optListaProgetti.add(new  SelectOption(jpu2.CQS_Praj_Progetto__c, jpu2.CQS_Praj_Progetto__r.Name));
                                           
                                           
                                       }
        
        system.debug('@@@@@@ optListaProgetti' + optListaProgetti);
        // isp.CQS_ISP_LDO__c=ldoMap.get(projectName);
        // isp.OF_CQS_Impresa_Mandataria__c=regMap.get(projectName);
        
        //   system.debug('Testin'+ ldoMap);     
        return null;
    }
 /*   
    public PageReference passaParComune(){
        PageReference pg = ApexPages.currentPage();
        pg.getParameters().put('optSceltaComune',optSceltaComune);
        return pg;
        
    }
*/    
    public PageReference SalvaConsuntivo(){
        system.debug('nel metodo SalvaConsuntivo.'); 
         if(ApexPages.currentPage().getParameters().get('consRis')=='true'){
            rimp.RecordTypeId=rtmap.get('Consuntivo_Risorse_Giornaliero');
            rimp.CQS_RisImp_TipoRapporto__c='Consuntivo';
            }
            rimp.CQS_RisImp_Progetto__c=optSceltaProgetto;
        try{
                insert rimp;
                system.debug('@@@@@@@EC stiamo salvando rimp: '+ rimp);
                 Schema.DescribeSObjectResult result = OF_CQS_Risorse_Impiegate__c.SObjectType.getDescribe();
                 System.debug('@@@@@@@EC stampiamo anche il result (Schema.DescribeSObjectResult result) ' + result);
                 pageRef = new PageReference('/' + result.getKeyPrefix()+ '/o');
                 system.debug(pageRef);
                 pageRef.setRedirect(true);
                 return pageRef;
        }   
            catch(System.DMLException e) {
                
                for (Integer i = 0; i < e.getNumDml(); i++) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(i)));
                system.debug('nel catch pagereference è ' + pageRef);
                
                return null;
              
                }
            }
            return null;
        }
    
    public PageReference tornaSelezioneComune(){
        pageRef = new PageReference('/apex/CQS_RisImp_SelComune'); 
        return pageRef;
    }
    
    
}
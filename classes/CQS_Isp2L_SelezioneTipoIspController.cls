public class CQS_Isp2L_SelezioneTipoIspController {
	
	public List<SelectOption> optList {get; set;}
	public List<String> tipiIspezione {get; set;}
	public String optScelta{get; set;}
	public PageReference pageRef{get;set;}
	public String shortOpt {get;set;}
	public Ispezione_II_Livello__c isp2L {get;set;}
	
	public List<SelectOption> optListaComuni {get;set;}
	public List<SelectOption> optListaRegioni {get;set;}
	public Set<String> nomeComuneSet {get;set;}
	public Map<String,Set<String>> RegioneProvMap {get;set;}
	public Map<String,String> ProvComuneMap {get;set;}
	public Map<Id,String> roleIdRoleNameMap {get;set;}
	public String userGeoZone {get;set;}
	public String roleName{get;set;}
	public String optSceltaRegione{get;set;}
	public String optSceltaComune{get;set;}
	public Set<String> setComuniRegioneScelta {get;set;}
	public Set<String> regioneSet {get;set;}
	public Set<String> provSet {get;set;}
	public String nomeRegione {get;set;} //to substitute with optSceltaRegione
    public User usrAtt {get;set;}
    public Boolean isCM {get;set;}
	
    
    
	public CQS_Isp2L_SelezioneTipoIspController(ApexPages.StandardController standardController){
		isp2L= new Ispezione_II_Livello__c();
		this.isp2L = (Ispezione_II_Livello__c)standardController.getRecord();     
		RegioneProvMap = new Map<String,Set<String>>();
		roleIdRoleNameMap = new Map<Id,String>();
		provSet= new Set<String>();
        isCM=false;
		scegliTipoIspezione();
        
		
		for(UserRole ur: [Select id, DeveloperName from UserRole]){
			system.debug('@@@@@@@EC nel for dello UserRole, ur.id: ' + ur.id + ', ur.DeveloperName: ' + ur.DeveloperName);
		roleIdRoleNameMap.put(ur.id,ur.DeveloperName);
		system.debug('@@@@@@@EC nel for dello UserRole, roleIdRoleNameMap: ' + roleIdRoleNameMap);
		}
		system.debug('@@@@@@@EC fuori dal for dello UserRole, roleIdRoleNameMap: ' + roleIdRoleNameMap);
		system.debug('@@@@@@EC roleIdRoleNameMap è: ' + roleIdRoleNameMap);
		
		roleName = roleIdRoleNameMap.get(UserInfo.getUserRoleId());
        usrAtt=[Select id, UserRoleId, ProfileId, Name, LastName from User where Id=:userinfo.getUserId() LIMIT 1];
		system.debug('@@@@@@EC nel controller CQS_Isp2L_SelezRegioneComuneController, userGeoZone è: ' +userGeoZone +', perché UserInfo.getUserRoleId() è: ' +UserInfo.getUserRoleId());     
        
        if(!String.isBlank(roleName) && roleName.contains('City_Manager_')){
            isCM=true;
            definisciComuniPl(usrAtt.id);
        }
        else{
		scegliRegioneAndComune(roleName);
        }
        
		if(!String.isBlank(optSceltaRegione)){
        	
                for(OF_ElencoComuniItaliani__c eCi: [select id,OF_Regione__c,OF_Provincia__c,OF_Comune__c 
                                                        from OF_ElencoComuniItaliani__c 
                                                        where OF_Regione__c=: optSceltaRegione]){
                    provSet.add(eCi.OF_Provincia__c);
                                                        
                    }
                    RegioneProvMap.put(nomeRegione,provSet);
                }	
	}
	
	
	public void defineComuni(){
		
		optListaComuni = new List<SelectOption>();
		system.debug('@@@@@EC dentro il metodo defineComuni. optSceltaRegione: ' + optSceltaRegione);
		
		for(OF_ElencoComuniItaliani__c eCi: [select id,OF_Regione__c,OF_Provincia__c,OF_Comune__c 
												from OF_ElencoComuniItaliani__c 
												where OF_Regione__c=: optSceltaRegione]){
			system.debug('@@@@@EC dentro il metodo defineComuni nel for. eCi= ' + eCi);
			
		/*	optListaComuni.add(new SelectOption(eCi.OF_Provincia__c,eCi.OF_Provincia__c));
			system.debug('@@@@@EC dentro il metodo defineComuni nel for. optListaComuni= ' + optListaComuni);*/
			provSet.add(eCi.OF_Provincia__c);
			system.debug('@@@@@EC dentro il metodo defineComuni nel for. provSet= ' + provSet);
												
			}
			RegioneProvMap.put(optSceltaRegione,provSet);
        	
			
			system.debug('@@@@@EC dentro il metodo defineComuni nel for. RegioneProvMap= ' + RegioneProvMap);
        
        	
		for(String str: provSet){
			
		optListaComuni.add(new SelectOption(str,str));
		}
		system.debug('@@@@@@EC optListaComuni è così popolata: ' + optListaComuni);
		provSet.clear();

    }
	


	public void scegliTipoIspezione(){
		system.debug('@@@@@EC nel metodo scegliTipoIspezione');
	    tipiIspezione = new List<String>();    
	    optList= new List<SelectOption>();
	    optList.add(new SelectOption('Verifica Rispetto Adempimenti Contrattuali Societa di Servizio','Verifica Rispetto Adempimenti Contrattuali Società di Servizio'));
	    optList.add(new SelectOption('Verifica Rispetto Adempimenti Contrattuali RL','Verifica Rispetto Adempimenti Contrattuali RL'));
	    optList.add(new SelectOption('Verifica Rispetto Adempimenti Contrattuali DL','Verifica Rispetto Adempimenti Contrattuali DL'));
	    optList.add(new SelectOption('Verifica Rispetto Adempimenti Contrattuali CSE','Verifica Rispetto Adempimenti Contrattuali CSE'));
	    }
	
	//public void scegliRegioneAndComune(String ZonaNCS){
    public void scegliRegioneAndComune(String roleName){
	
		optListaRegioni = new List<SelectOption>();
		set<String> regioneSet = new Set<String>();
        optListaRegioni.add(new SelectOption('- - - - - - ','- - - - - - - - - - - - - - - -'));
     /*   if(roleName.contains('City_Manager_')){
			system.debug('@@@@EC lo user è un city manager e il suo id è: '+usrAtt.id);
            definisciComuniPl(usrAtt.id);
        }*/
   		if(roleName=='Ispettore_II_Livello_Nord'){
            optListaRegioni.add(new SelectOption('Valle d\'Aosta','Valle d\'Aosta'));
            optListaRegioni.add(new SelectOption('Piemonte','Piemonte'));
            optListaRegioni.add(new SelectOption('Liguria','Liguria'));
            optListaRegioni.add(new SelectOption('Lombardia','Lombardia'));
            optListaRegioni.add(new SelectOption('Trentino Alto Adige','Trentino Alto Adige'));
            optListaRegioni.add(new SelectOption('Veneto','Veneto'));
            optListaRegioni.add(new SelectOption('Friuli Venezia Giulia','Friuli Venezia Giulia'));
            optListaRegioni.add(new SelectOption('Emilia Romagna','Emilia Romagna'));
		}
        else if(roleName=='Ispettore_II_Livello_Centro_Sud'){
            optListaRegioni.add(new SelectOption('Toscana','Toscana'));
            optListaRegioni.add(new SelectOption('Umbria','Umbria'));
            optListaRegioni.add(new SelectOption('Marche','Marche'));
            optListaRegioni.add(new SelectOption('Lazio','Lazio'));
            optListaRegioni.add(new SelectOption('Abruzzo','Abruzzo'));
            optListaRegioni.add(new SelectOption('Molise','Molise'));
            optListaRegioni.add(new SelectOption('Campania','Campania'));
            optListaRegioni.add(new SelectOption('Puglia','Puglia'));
            optListaRegioni.add(new SelectOption('Basilicata','Basilicata'));
            optListaRegioni.add(new SelectOption('Calabria','Calabria'));
            optListaRegioni.add(new SelectOption('Sicilia','Sicilia'));
            optListaRegioni.add(new SelectOption('Sardegna','Sardegna'));
		}
		else{
            optListaRegioni.add(new SelectOption('Valle d\'Aosta','Valle d\'Aosta'));
            optListaRegioni.add(new SelectOption('Piemonte','Piemonte'));
            optListaRegioni.add(new SelectOption('Liguria','Liguria'));
            optListaRegioni.add(new SelectOption('Lombardia','Lombardia'));
            optListaRegioni.add(new SelectOption('Trentino Alto Adige','Trentino Alto Adige'));
            optListaRegioni.add(new SelectOption('Veneto','Veneto'));
            optListaRegioni.add(new SelectOption('Friuli Venezia Giulia','Friuli Venezia Giulia'));
            optListaRegioni.add(new SelectOption('Emilia Romagna','Emilia Romagna'));
            optListaRegioni.add(new SelectOption('Toscana','Toscana'));
            optListaRegioni.add(new SelectOption('Umbria','Umbria'));
            optListaRegioni.add(new SelectOption('Marche','Marche'));
            optListaRegioni.add(new SelectOption('Lazio','Lazio'));
            optListaRegioni.add(new SelectOption('Abruzzo','Abruzzo'));
            optListaRegioni.add(new SelectOption('Molise','Molise'));
            optListaRegioni.add(new SelectOption('Campania','Campania'));
            optListaRegioni.add(new SelectOption('Puglia','Puglia'));
            optListaRegioni.add(new SelectOption('Basilicata','Basilicata'));
            optListaRegioni.add(new SelectOption('Calabria','Calabria'));
            optListaRegioni.add(new SelectOption('Sicilia','Sicilia'));
            optListaRegioni.add(new SelectOption('Sardegna','Sardegna'));
		}
	}
	
   
    
    
	public void definisciComuniPl(Id usrId){
        System.debug('dentro a definisciComuniPl()');
        List<String> juncUserProg = new List<String>();
        
        optListaComuni = new List<SelectOption>();
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
                                                  from Progetto_Utente_junction__c where CQS_junc_user__c =:usrId]){
                                                      nomeComuneSet.add(prUtJunc.CQS_junc_progetto__r.CQS_Pro_Comune__c); //EC 2018 - 09 - 18 
                                                      
                                                            
                                                      system.debug(optListaComuni);                                         
                                                  } 
        for(string s: nomeComuneSet){
        optListaComuni.add(new SelectOption(s,s));
        }
    }	

	
	public PageReference pagPresel(){
		system.debug('@@@@@EC nel metodo pagPresel');
        
        
          if(!isCM && optSceltaRegione.contains('- - - - - -')){
             String str1='Il campo Regione è Obbligatorio. Bisogna selezionare un valore dalla tendina delle Regioni';
          
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,str1);
           ApexPages.addMessage(myMsg);
           return null;
            
        }
        else{        
            
            //pageRef =  new PageReference('/apex/CQS_Isp2L_SelezioneRegioneComune'); //da cancellare sia la pagina sia la classe
            if(optScelta=='Verifica Rispetto Adempimenti Contrattuali Societa di Servizio'){
                pageRef = new PageReference('/apex/CQS_Isp2L_AdempimentiSS');  
                shortOpt='SocServ';
            }
            else if(optScelta=='Verifica Rispetto Adempimenti Contrattuali RL'){
                pageRef = new PageReference('/apex/CQS_Isp2L_AdempimentiRL');
                shortOpt='RL';
            }
            else if(optScelta=='Verifica Rispetto Adempimenti Contrattuali DL'){
                pageRef = new PageReference('/apex/CQS_Isp2L_AdempimentiDL');
                shortOpt='DL';
            }
            else if(optScelta=='Verifica Rispetto Adempimenti Contrattuali CSE'){
                pageRef = new PageReference('/apex/CQS_Isp2L_AdempimentiCSE');
                shortOpt='CSE';
            }
        }
		pageRef.getParameters().put('shortOpt',shortOpt);
		pageRef.getParameters().put('Prov',optSceltaComune);
        pageRef.getParameters().put('roleName',roleName);
		pageRef.setRedirect(true);
		system.debug('@@@@@EC alla fine del metodo pagPresel, pageRef è ' + pageRef);
		return pageRef;
	}
	

}
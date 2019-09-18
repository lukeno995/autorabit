public class CQS_Isp2L_AdempimentiController {
	
	public Ispezione_II_Livello__c isp2L {get;set;}
	public List<SelectOption> optList {get; set;}
	public List<String> tipiIspezione {get; set;}
	public id isp2Lid{get;set;}
	public String nomeProv {get;set;}
	public Set<String> provSet {get;set;}
	public Map<String,Set<String>> RegioneProvMap {get;set;}
    public User usrAtt {get;set;}
    public Map<Id,String> roleIdRoleNameMap {get;set;}
    public List<SelectOption> optNomeProgetto{get; set;}
    public String jnldo {get;set;} //CQS_Prog_An_junc__c jnc ldo
	public String Snjun {get;set;} //Snjun = jnc.CQS_Praj_Ragione_Sociale__r.name;
    public String yM {get;set;}
    public String projectName {get;set;}
    public boolean isLowProfile {get;set;}
    public String shortOpt {get;set;} //parametro per determinare il tipo di ispezione di secondo livello
    public String searchTerm {get; set;}
    public String selectedIdComune {get; set;}
    public PageReference pageRef {get;set;}
    public Map<String,Id> rtmap {get;set;}
    public String roleName {get;set;}
    
	
	public CQS_Isp2L_AdempimentiController(ApexPages.StandardController standardController){
		//isp2Lid=ApexPages.CurrentPage().getParameters().get('isp2Lid');
		//isp2L= [select id from Ispezione_II_Livello__c where id=:isp2Lid];
		isp2L = new Ispezione_II_Livello__c();
		this.isp2L = (Ispezione_II_Livello__c)standardController.getRecord();
        
       /*  rtmap=new Map<String,Id>();
	        	 for(recordtype rt : [select developername,id from recordtype where sObjectType='Ispezione_II_Livello__c']){
	        	 	rtmap.put(rt.developername,rt.Id);
	        	 	system.debug('nel controller dell\'ispezione di secondo livello, popoliamo la mappa dei recordtype di ispezione. la stampa della mappa è la seguente: ' + rtmap);
	        	 }
        */
		nomeProv= ApexPages.currentPage().getParameters().get('Prov');
        system.debug('@@@@EC nel controller nomeProv è: ' +nomeProv);
        shortOpt=ApexPages.currentPage().getParameters().get('shortOpt');
        system.debug('@@@@EC nel controller shortOpt è: ' +shortOpt);
        roleName=ApexPages.currentPage().getParameters().get('roleName');
        system.debug('@@@@EC nel controller roleName è: ' +roleName);
        usrAtt=[Select id, UserRoleId, ProfileId, Name, LastName from User where Id=:userinfo.getUserId() LIMIT 1];
        system.debug('@@@@EC nel controller usrAtt è: ' +usrAtt);
        definisciProgettiPl();
       /* 
        for(UserRole ur: [Select id, DeveloperName from UserRole]){
			system.debug('@@@@@@@EC nel for dello UserRole, ur.id: ' + ur.id + ', ur.DeveloperName: ' + ur.DeveloperName);
		roleIdRoleNameMap.put(ur.id,ur.DeveloperName);
		system.debug('@@@@@@@EC nel for dello UserRole, roleIdRoleNameMap: ' + roleIdRoleNameMap);
		}
	 	*/
	}
      
    
    // JS Remoting action called when searching
    @RemoteAction
    public static List<OF_ElencoComuniItaliani__c > searchComune(String searchTerm) 
    {
        // System.debug('Comune Name is: '+searchTerm );
        List<OF_ElencoComuniItaliani__c > eventList = Database.query('SELECT Id,OF_Comune__c  FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm) + '%\'  order by OF_Comune__c ASC ' );
        System.debug('eventList : '+eventList );
        return eventList ;        
    } 
   
    public PageReference salvaIspezione(){
 		system.debug('nel metodo salva ispezione. projectName è ' + projectName);
       
        rtmap=new Map<String,Id>();
	        	 for(recordtype rt : [select developername,id from recordtype where sObjectType='Ispezione_II_Livello__c']){
	        	 	rtmap.put(rt.developername,rt.Id);
	        	 	system.debug('nel controller dell\'ispezione di secondo livello, popoliamo la mappa dei recordtype di ispezione. la stampa della mappa è la seguente: ' + rtmap);
	        	 }
     /*   
        if((selectedIdComune=='')||(selectedIdComune==null)){
        	String str1='Il campo Comune è Obbligatorio. Bisogna selezionarlo dalla tendina di autocompilazione';
          
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,str1);
           ApexPages.addMessage(myMsg);
           PageReference pageRef= null;
        }
        else{ */
       
		String s= ApexPages.currentPage().getUrl();
            
      	system.debug('@@@@@@ pageRef getUrl: ' + s);
        isp2L.CQS_Isp2L_Progetto__c = projectName;
        system.debug('nel metodo salva ispezione. Associamo projectName al campo isp.CQS_ISP_Progetto__c, che ora è così valorizzato: ' + isp2L.CQS_Isp2L_Progetto__c);
        
        isp2L.CQS_Isp2L_Comune__c = nomeProv;
            //[select id,of_Comune__c,OF_Provincia__c from  OF_ElencoComuniItaliani__c where Id=:selectedIdComune].of_Comune__c;
       
  		system.debug('siamo nel metodo salvaIspezione. shortOpt è: ' + shortOpt + ' stiamo per entrare in uno degli if in base al getUrl');
	        if(s.contains('CQS_Isp2L_AdempimentiSS')){
	        	system.debug('opt scelta CQS_Isp2L_AdempimentiSS, al momento siamo nell\'if nel metodo di salvataggio e stiamo assegnando il recordtype alla nuova ispezione');
	            isp2L.recordtypeId=rtmap.get('CQS_IspIIL_AL1_Verifica_Rispetto_Adempimenti_Contrattuali_SocietaServizio');
                system.debug('l\'id del recordtype della nuova ispezione è ' + isp2L.recordtypeId);
	        } 
	        else if(s.contains('CQS_Isp2L_AdempimentiRL')){ //EC start Ispezione Tema Ambientale 2019 - 01 - 02
	        	system.debug('opt scelta è ispezione Tema Ambientale, al momento siamo nell\'if nel metodo di salvataggio e stiamo assegnando il recordtype alla nuova ispezione');
	        	isp2L.recordtypeId=rtmap.get('CQS_IspIIL_AL2_Verifica_Rispetto_Adempimenti_Contrattuali_RL');
               	system.debug('l\'id del recordtype della nuova ispezione è ' + isp2L.recordtypeId);
            } 
            else if(s.contains('CQS_Isp2L_AdempimentiDL')){ //EC start Ispezione Tema Ambientale 2019 - 01 - 02
	        	system.debug('opt scelta è ispezioneCQS_Isp2L_AdempimentiDL, al momento siamo nell\'if nel metodo di salvataggio e stiamo assegnando il recordtype alla nuova ispezione');
	        	isp2L.recordtypeId=rtmap.get('CQS_IspIIL_AL3_Verifica_Rispetto_Adempimenti_Contrattuali_DL');
            	system.debug('l\'id del recordtype della nuova ispezione è ' + isp2L.recordtypeId);
            } //EC end Ispezione Tema Ambientale 2019 - 01 - 02
            else if(s.contains('CQS_Isp2L_AdempimentiCSE')){ //EC start Ispezione Tema Ambientale 2019 - 01 - 02
	        	system.debug('opt scelta è CQS_Isp2L_AdempimentiCSE, al momento siamo nell\'if nel metodo di salvataggio e stiamo assegnando il recordtype alla nuova ispezione');
	        	isp2L.recordtypeId=rtmap.get('CQS_IspIIL_AL4_Verifica_Rispetto_Adempimenti_Contrattuali_CSE');
               	system.debug('l\'id del recordtype della nuova ispezione è ' + isp2L.recordtypeId);
            } 
                      
	   		try{
	       		insert isp2L;
		        system.debug('@@@@@@@EC ispezione2L: '+isp2L);
	 	         Schema.DescribeSObjectResult result = Ispezione_II_Livello__c.SObjectType.getDescribe();
				 pageRef = new PageReference('/' + result.getKeyPrefix()+ '/o');
				 system.debug(pageRef);
	  			 pageRef.setRedirect(true);
			}
	   		catch(System.DMLException e) {
	   			
	   			for (Integer i = 0; i < e.getNumDml(); i++) {
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(i)));
				system.debug(pageRef);
				
				pageRef= null;
  			  
				}
			}
       // }
			return	pageRef;
		}
    
    public pageReference backToSel(){
   		return pageRef = new PageReference('/apex/CQS_Isp2L_SelezioneTipoIspezione'); 
    }

	public void definisciProgettiPl(){
        System.debug('dentro a definisciProgettiPl()');
        List<String> juncUserProg = new List<String>();
                               
        optNomeProgetto = new List<SelectOption>();
        Map<String,String> ldoMap = new Map<String, String>();
        Map<String,String> rsocial = new Map<String, String>();
        CQS_Prog_An_junc__c jnc  = new CQS_Prog_An_junc__c();
        
        map<string,CQS_Prog_An_junc__c> vmapjnu = new map<string,CQS_Prog_An_junc__c>();
        
          for(CQS_Prog_An_junc__c jnt :  [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,
                                          		CQS_Praj_Ragione_Sociale__c,CQS_Praj_Ragione_Sociale__r.name,
                                          		CQS_PAJ_SS__c, CQS_PAJ_SS__r.Name, CQS_PAJ_LDOService__c
                                                 from CQS_Prog_An_junc__c]){
                vmapjnu.put(jnt.CQS_Praj_Progetto__r.Name,jnt);
          }
        system.debug('@@@@@EC nel metodo definisciProgettiPl la mappa vmapjnu con chiave il name del progetto e output progettoAnagraficaJunction è così valorizzata sin dal principio: ' + vmapjnu);
        
        
        if(!String.isBlank(roleName) && roleName.contains('City_Manager_')){
            string LikeNameProg = '%' + nomeProv + '%';		
            System.debug('@@@@@@@EC siamo nel caso che lo userRole è un cityManager userId= ' +userinfo.getUserId());
            for(Progetto_Utente_junction__c jpu:[select CQS_junc_progetto__r.Name,CQS_junc_progetto__c 
                                                 from Progetto_Utente_junction__c 
                                                 where CQS_junc_user__c =:userinfo.getUserId()
                                                 AND CQS_junc_progetto__r.Name LIKE: LikeNameProg ]){
            	optNomeProgetto.add(new SelectOption(jpu.CQS_junc_progetto__c,jpu.CQS_junc_progetto__r.Name)); 
                system.debug('peppe'+jpu.CQS_junc_progetto__r.Name);                                   
                jnc =  vmapjnu.get(jpu.CQS_junc_progetto__r.Name);
                system.debug('jnc======='+jnc);
			}
            if(jnc != null && jnc.CQS_Praju_LDO__c != null){                                
               jnldo =jnc.CQS_Praju_LDO__c;
               if(jnc != null && jnc.CQS_Praj_Ragione_Sociale__c != null)
                Snjun = jnc.CQS_Praj_Ragione_Sociale__r.name;
                system.debug('projectName===='+jnc.CQS_Praj_Progetto__c);                                   
                system.debug('ldo===='+jnldo);
                system.debug('rsoci===='+Snjun); 
              // system.debug('isp===='+isp);
                   projectName= jnc.CQS_Praj_Progetto__c;            
            system.debug(optNomeProgetto);                                         
            } 
            for(CQS_Prog_An_junc__c jpu2: [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c,
                                           		CQS_PAJ_SS__c, CQS_PAJ_SS__r.Name, CQS_PAJ_LDOService__c
                                                from CQS_Prog_An_junc__c
                                           		where CQS_Praj_Progetto__r.Name=:string.valueof(optNomeProgetto)]){
                ldoMap.put(jpu2.CQS_Praj_Progetto__r.Name,jpu2.CQS_PAJ_LDOService__c);
                rsocial.put(jpu2.CQS_Praj_Progetto__r.Name,jpu2.CQS_Praj_Ragione_Sociale__c); 
           //   ldoMap.put(jpu2.CQS_Praj_Progetto__r.Name,jpu2.CQS_Praju_LDO__c );
            } 
        }
        else{
            string LikeNameProg = '%' + nomeProv + '%';		
			for(CQS_Progetto__c pro:[select id, Name, CQS_Pro_Comune__c
                                      from CQS_Progetto__c where Name LIKE: LikeNameProg]){
                optNomeProgetto.add(new SelectOption(pro.id,pro.Name));
                system.debug('peppe'+pro.Name);
				//vmapjnu.put(pro.Name,pro.id);commentiamo perché dovrebbe essere ridondante dal momento che creiamo la mappa già all'inizio del metodo.
                jnc =  vmapjnu.get(pro.Name);
                system.debug('jnc======='+jnc); 
				if(jnc != null && jnc.CQS_Praju_LDO__c != null){
                	jnldo =jnc.CQS_Praju_LDO__c;                          
				}                                 
              	if(jnc != null && jnc.CQS_Praj_Ragione_Sociale__c != null){
                    Snjun = jnc.CQS_Praj_Ragione_Sociale__r.name;
                    system.debug('projectName===='+jnc.CQS_Praj_Progetto__c);                                   
                    system.debug('ldo===='+jnldo);
                    system.debug('rsoci===='+Snjun); 
                  //system.debug('isp===='+isp);
                    projectName= jnc.CQS_Praj_Progetto__c;                                 
                 }
                	        
            system.debug('@@@@@@@EC alla fine optNomeProgetto è: '+optNomeProgetto);
			}
        }
         defineLDO();
	   }   
			
	public pageReference defineLDO(){
          //  definisciProgettiPl();
          system.debug('++++++' + projectName);
             Map<String,String> ldoMap = new Map<String, String>();
              Map<String,String> regMap = new Map<String, String>();
            for(CQS_Prog_An_junc__c jpu2: [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c,
                                           		 CQS_PAJ_SS__c, CQS_PAJ_SS__r.Name, CQS_PAJ_LDOService__c
                                                 from CQS_Prog_An_junc__c where CQS_Praj_Progetto__c=:projectName ] ){
            ldoMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_PAJ_LDOService__c );
            regMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_PAJ_SS__c);
            
            }
            isp2L.CQS_Isp2L_LDO__c=ldoMap.get(projectName);
			isp2L.CQS_IspIIL_Service__c=regMap.get(projectName);
            
            system.debug('Testin'+ ldoMap);     
            return null;
        }	
	
	
}
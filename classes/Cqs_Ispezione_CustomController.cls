public with sharing class Cqs_Ispezione_CustomController {
    private ApexPages.StandardController standardController{get;set;}
	public OF_CQS_Ispezione__c isp{get; set;}
	public List<OF_CQS_Ispezione__c> ispList{get; set;}
	public List<SelectOption> opt{get; set;}
	public List<String> tipiIspezione{get; set;}
	public String pageName{get; set;}
	public String parentId {get;set;}
	public String optScelta{get; set;}
    public Attachment file {get; set;}
    public List<Attachment> atList{get; set;}
    public List<Integer> intList {get; set;}
    public String projectName{get; set;}
    public List<SelectOption> optNomeProgetto{get; set;}
    public Progetto_Utente_junction__c jPu{get; set;}
    public pageReference pageRef{get; set;}
    public String ispId{get; set;}
    public map<String,Id> rtmap{get; set;}
	public String errorMessage{get; set;}
	public List<String> emList {get; set;}
	public Boolean showRow {get; set;}
	public List<String> fieldList{get; set;}
	//EC 2018 - 05 - 25
	
	public boolean ispezioneSicurezza{get;set;}
	public boolean ispezioneTamb {get;set;} //EC 2018 - 12 - 24
	public boolean sez1s{get;set;}
	public boolean sez2s{get;set;}
	public boolean sez3s{get;set;}
	public boolean sez4s{get;set;}
	public boolean sez5s{get;set;}
	public boolean sez6s{get;set;}
	public boolean ispezioneQualita{get;set;}
	public boolean sez1q{get;set;}
	public boolean sez2q{get;set;}
	public boolean sez3q{get;set;}
	public boolean sez4q{get;set;}
	public boolean sez5q{get;set;}
	public boolean sez6q{get;set;}
	public boolean sez7q{get;set;}
	public boolean sez8q{get;set;}
	public boolean sez9q{get;set;}
	public boolean sez10q{get;set;}
	public boolean sez11q{get;set;}
	public boolean sez12q{get;set;}
	public boolean sez13q{get;set;}
	//END EC 2018 - 05 - 25
	//EC 2018 - 05 - 28
	public String iS{get; set;}
	public String iQ{get; set;}
	public String ispSicurezza {get;set;}
	public String ispQuality {get;set;}
	public String iTa{get; set;} //EC 2018 - 12 - 24
	public String ispTa {get;set;} //EC 2018 - 12 - 24
	public boolean ss1{get;set;}
	public boolean ss2{get;set;}
	public boolean ss3{get;set;}
	public boolean ss4{get;set;}
	public boolean ss5{get;set;}
	public boolean ss6{get;set;}
	public boolean ss7{get;set;}
	public boolean ss8{get;set;}
	public boolean ss9{get;set;}
	public boolean ss10{get;set;}
	public boolean ss11{get;set;}
	public boolean ss12{get;set;}
	public boolean ss13{get;set;}
	public boolean showRow1{get;set;}
	public boolean showRow2{get;set;}
	public boolean showRow3{get;set;}
	public boolean showRow4{get;set;}
	public boolean showRow5{get;set;}
	public boolean showRow6{get;set;}
	public boolean showRow7{get;set;}
	public boolean showRow8{get;set;}
	public boolean showRow9{get;set;}
	public boolean showRow10{get;set;}
	//END EC 2018 - 05 - 28	
	//EC - 2018 - 05 - 30
	public String jnldo {get;set;}
	public String Snjun {get;set;}
    public String yM {get;set;}
	
	public Cqs_Ispezione_CustomController(ApexPages.StandardController standardController){
		isp= new OF_CQS_Ispezione__c();
		this.isp = (OF_CQS_Ispezione__c)standardController.getRecord();      
		scegliTipoIspezione();
		definisciProgettiPl();
		ym=String.valueOf(System.now().format('HH:mm'));
		//EC 2018 - 05 -25 Setto le variabili per la selezione del tipo di isp a false e delle singole sezioni da scegliere
		showRow=false;
		ispezioneSicurezza=false;
		sez1s=false;
		sez2s=false;
		sez3s=false;
		sez4s=false;
		sez5s=false;
		sez6s=false;
		ispezioneQualita=false;
		ispezioneTamb=false; //EC 2018 - 12 - 24
		sez1q=false;
		sez2q=false;
		sez3q=false;
		sez4q=false;
		sez5q=false;
		sez6q=false;
		sez7q=false;
		sez8q=false;
		sez9q=false;
		sez10q=false;
		sez11q=false;
		sez12q=false;
		sez13q=false;
		String iS= 'false';
        String iQ= 'false';
        String iTa ='false'; //EC 2018 - 12 - 24
        String ispTa =''; //EC 2018 - 12 - 24
        String ispSicurezza ='';
		String ispQuality ='';
		String urlPage = '';
		ss1=false;
		ss2=false;
		ss3=false;
		ss4=false;
		ss5=false;
		ss6=false;
		ss7=false;
		ss8=false;
		ss9=false;
		ss10=false;
		ss11=false;
		ss12=false;
		ss13=false;
		showRow1=false;
		showRow2=false;
		showRow3=false;
		showRow4=false;
		showRow5=false;
		showRow6=false;
		showRow7=false;
		showRow8=false;
		showRow9=false;
		showRow10=false;
	
		//End EC 2018 - 05 -25 
					
		//EC 2018 - 05 -30
		//impostazione automatica LDO e Impresa Affidataria
		
		Map<String,String> ldoMap = new Map<String, String>();
                   Map<String,String> regMap = new Map<String, String>();
                 
                  system.debug('inside Controller'+ projectName);  
                 if(projectName!=''){
                 	//ma projectName è un id? EC
                  	for(CQS_Prog_An_junc__c jpu2: [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c
                                                 from CQS_Prog_An_junc__c where CQS_Praj_Progetto__c=:projectName]){
           					
           					 ldoMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praju_LDO__c );
             				 regMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praj_Ragione_Sociale__c);
            		}
			             	 isp.CQS_ISP_LDO__c=ldoMap.get(projectName);
			              	 isp.OF_CQS_Impresa_Mandataria__c=regMap.get(projectName);
			                     //ev.OF_CQS_Impresa_Mandataria__c = rsocial.get(projectName);
			                     system.debug('ldo===='+ isp.CQS_ISP_LDO__c);
                    		  //system.debug('rsoci===='+isp.OF_CQS_Impresa_Mandataria__c);
                 }
		
		
		//End EC 2018 - 05 - 30 
			
		 rtmap=new map<String,Id>();
	        	 for(recordtype rt : [select developername,id from recordtype where sObjectType='OF_CQS_Ispezione__c']){
	        	 	rtmap.put(rt.developername,rt.Id);
	        	 	system.debug('nel controller dell\'ispezione, popoliamo la mappa dei recordtype di ispezione. la stampa della mappa è la seguente: ' + rtmap);
	        	 }
	        	if(ApexPages.currentPage().getParameters().get('optScelta')!=null){
					optScelta=ApexPages.currentPage().getParameters().get('optScelta');
					system.debug('l\'optscelta è: ' + optScelta);												
				}
				  system.debug('prima dell\'IF ...URL Ispezione Sicurezza: ' + ApexPages.CurrentPage().getUrl()); 
			if(ApexPages.CurrentPage().getParameters().get('ispSicurezza')=='true'){//containsKey('/apex/Selezione_Sezioni_Ispezioni_da_Compilare')){
				//String s= ApexPages.CurrentPage().getParameters();
			//	if(ApexPages.CurrentPage().getParameters().containsKey('ispSicurezza')){
					optScelta='Ispezione di Sicurezza';
               	//EC 2018 - 05 - 25 settiamo a true ispezione sicurezza in modo da rendere visibile il div nella VFpage
					ispezioneSicurezza=true;
					ispSicurezza ='true';
					  system.debug('URL Ispezione Sicurezza: ' + ApexPages.CurrentPage().getUrl()); 
				System.debug('Siamo nell\'ispSicurezza, abbiamo appena selezionato il tipo di ispezione che vogliamo censire. il sistema dovrebbe mostrare una sola sezione');
			}
            else if(ApexPages.CurrentPage().getParameters().get('ispQuality')=='true'){
               		optScelta='Ispezione di Qualità';
               		//EC 2018 - 05 - 25 settiamo a true ispezione qualità in modo da rendere visibile il div nella VFpage
					ispezioneQualita=true;
					ispQuality ='true';
					System.debug('Siamo nell\'ispQuality');
			}
			//EC start 2018 - 12 - 24
			
			 else if(ApexPages.CurrentPage().getParameters().get('ispTa')=='true'){
               		optScelta='Ispezione Tema Ambientale';
               		//EC 2018 - 05 - 25 settiamo a true ispezione qualità in modo da rendere visibile il div nella VFpage
					ispezioneTamb=true;
					ispTa ='true';
					System.debug('Siamo nell\'ispTamb');
			}
			
			//EC end 2018 - 12 - 24
			
			urlPage= ApexPages.CurrentPage().getUrl();
			
			if(urlPage.contains('CQS_Isp_2018_06_Sicurezza')){
			//else if(ApexPages.CurrentPage().getParameters().containsKey('/apex/CQS_Ispezione_Sicurezza')){
					System.debug('siamo nella page ApexPages.CurrentPage().getParameters().containsKey(\'/apex/CQS_Ispezione_Sicurezza'+')');
					system.debug('il primo check è sez1 che è' + sez1s);
					if(ApexPages.CurrentPage().getParameters().get('sez1s')=='true'){
					ss1=true;
					system.debug('il primo check è ss1 che è' + ss1);
					
					}
					if(ApexPages.CurrentPage().getParameters().get('sez2s')=='true'){
					ss2=true;
					system.debug('il primo check è ss2 che è' + ss2);
					
					}
					if(ApexPages.CurrentPage().getParameters().get('sez3s')=='true'){
					ss3=true;
					system.debug('il primo check è ss3 che è' + ss3);
					
					}
					if(ApexPages.CurrentPage().getParameters().get('sez4s')=='true'){
					ss4=true;
					system.debug('il primo check è ss4 che è' + ss4);
					
					}
					if(ApexPages.CurrentPage().getParameters().get('sez5s')=='true'){
					ss5=true;
					system.debug('il primo check è ss5 che è' + ss5);
					
					}
					if(ApexPages.CurrentPage().getParameters().get('sez6s')=='true'){
					ss6=true;
					system.debug('il primo check è ss6 che è' + ss6);
					
					}
					
					/*			
						try{		
								salvaIspezione();
						}
						catch(Exception e) {
							for (Integer i = 0; i < e.getNumDml(); i++) {
				   			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(0)));
							system.debug(e);
							pageRef= null;
				   			}
						}
						*/
			}
			else {
				if(ApexPages.CurrentPage().getParameters().get('sez1q')=='true'){
				ss1=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez2q')=='true'){
				ss2=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez3q')=='true'){
				ss3=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez4q')=='true'){
				ss4=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez5q')=='true'){
				ss5=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez6q')=='true'){
				ss6=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez7q')=='true'){
				ss7=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez8q')=='true'){
				ss8=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez9q')=='true'){
				ss9=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez10q')=='true'){
				ss10=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez11q')=='true'){
				ss11=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez12q')=='true'){
				ss12=true;
				}
				if(ApexPages.CurrentPage().getParameters().get('sez13q')=='true'){
				ss13=true;
				}
				System.debug('siamo nella page ApexPages.CurrentPage().getParameters().containsKey(\'/apex/CQS_Ispezione):  '+ ApexPages.CurrentPage().getUrl() +', che sarebbe la pagina creata per l\'ispezione di qualità');		
						/*
						try{		
								salvaIspezione();
						}
						catch(Exception e) {
						    for (Integer i = 0; i < e.getNumDml(); i++) {
				   			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(0)));
							system.debug(e);
							pageRef= null;
				   			}
						} 
						*/
			}
		
	}
	
	
	
	
	public void scegliTipoIspezione(){
	        tipiIspezione = new List<String>();    
	        opt= new List<SelectOption>();
	        opt.add(new SelectOption('Ispezione di Sicurezza','Ispezione di Sicurezza'));
	        opt.add(new SelectOption('Ispezione di Qualità','Ispezione di Qualità'));
	        opt.add(new SelectOption('Ispezione Tema Ambientale','Ispezione Tema Ambientale'));
	        //  optScelta=SelectOption.getLabel();
        }
        //EC toDo Modifica portaVF 2018 - 12 - 24
        //Bisogna creare una nuova pagina per Ispezioni a Tema Ambientale
     public PageReference portaVF(){

            system.debug('Siamo nel metodo portaVF. il valore optScelta è: ' +optScelta) ;    
            PageReference pageRef;
          	
          	System.debug('Siamo nel metodo portaVF. i valori dei booleani sono per IspezioneSicurezza: ' + ispezioneSicurezza + ' ,per Ispezione Qualità: ' + ispezioneQualita + ', per Ispezione Tema Ambientale');
         	if(ispezioneSicurezza){
         		pageRef =new PageReference('/apex/CQS_Isp_2018_06_Sicurezza');
         	}
         	else if(ispezioneTamb){
         		pageRef =new PageReference('/apex/CQS_Ispezione_Tema_Ambientale');
         	}
         	else{
         		pageRef=new PageReference('/apex/CQS_Ispezione');
         	}
         	
         	
       	    if(sez1s){
	       	pageRef.getParameters().put('sez1s','true');	
	       	}
	       	if(sez2s){
	       	pageRef.getParameters().put('sez2s','true');	
	       	}
	       	if(sez3s){
	       	pageRef.getParameters().put('sez3s','true');	
	       	}
	       	if(sez4s){
	       	pageRef.getParameters().put('sez4s','true');	
	       	}
	       	if(sez5s){
	       	pageRef.getParameters().put('sez5s','true');	
	       	}
	       	if(sez6s){
	       	pageRef.getParameters().put('sez6s','true');	
	       	}
		
			if(sez1q){
			pageRef.getParameters().put('sez1q','true');
			}
			if(sez2q){
			pageRef.getParameters().put('sez2q','true');
			}
			if(sez3q){
			pageRef.getParameters().put('sez3q','true');
			}
			if(sez4q){
			pageRef.getParameters().put('sez4q','true');
			}
			if(sez5q){
			pageRef.getParameters().put('sez5q','true');
			}
			if(sez6q){
			pageRef.getParameters().put('sez6q','true');
			}
			if(sez7q){
			pageRef.getParameters().put('sez7q','true');
			}
			if(sez8q){
			pageRef.getParameters().put('sez8q','true');
			}
			if(sez9q){
			pageRef.getParameters().put('sez9q','true');
			}
			if(sez10q){
			pageRef.getParameters().put('sez10q','true');
			}
			if(sez11q){
			pageRef.getParameters().put('sez11q','true');
			}
			if(sez12q){
			pageRef.getParameters().put('sez12q','true');
			}
			if(sez13q){
			pageRef.getParameters().put('sez13q','true');
			}		   
	
            pageRef.setRedirect(true);
            return pageRef;
        } 
        
        public PageReference pagPresel(){
         
            system.debug('Siamo nel metodo pagPresel. il valore optScelta è: ' +optScelta) ;        
            PageReference pagePresel;
            ispezioneSicurezza=false;
            ispezioneQualita=false;
            ispezioneTamb=false;
               pagePresel = new PageReference('/apex/Selezione_Sezioni_Ispezioni_da_Compilare');      
               if(optScelta=='Ispezione di Sicurezza'){
               	//EC 2018 - 05 - 25 settiamo a true ispezione sicurezza in modo da rendere visibile il div nella VFpage
					//ispezioneSicurezza=true;
					iS= 'true';
					pagePresel.getParameters().put('ispSicurezza',iS);
					//pagePresel.setAnchor('ispSicurezza');
                 }
               else if(optScelta=='Ispezione di Qualità'){
               		//EC 2018 - 05 - 25 settiamo a true ispezione qualità in modo da rendere visibile il div nella VFpage
					//ispezioneQualita=true;
					iQ= 'true';
					//pagePresel.setAnchor('ispQuality');
					pagePresel.getParameters().put('ispQuality',iQ);
                }
                //EC start 2018 - 12 - 24
                else if(optScelta=='Ispezione Tema Ambientale'){
               		
					iTa= 'true';
					//pagePresel.setAnchor('ispQuality');
					pagePresel.getParameters().put('ispTa',iTa);
                }
              //
                pagePresel.setRedirect(true);
                
               System.debug('Siamo nel metodo pagPresel. i valori dei booleani sono per IspezioneSicurezza: ' + ispezioneSicurezza + ', per Ispezione Qualità: ' + ispezioneQualita);
                return pagePresel;
        }
        
          public List<Attachment> fileUpload(){   
            for(integer i=0; i<5; i++){
            atList= new List<Attachment>();
                file= new Attachment();
                atList.add(file);
                  system.debug(atList.size());
        
            }  return atList; 
        } 
            
        public PageReference upload(){
            insert file;
            file.body = null;
           return null;       
        }
    
    public PageReference salvaIspezione(){
 		system.debug('nel metodo salva ispezione. projectName è ' + projectName);
        if((selectedIdComune=='')||(selectedIdComune==null)){
        	String str1='Il campo Comune è Obbligatorio. Bisogna selezionarlo dalla tendina di autocompilazione';
          
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,str1);
           ApexPages.addMessage(myMsg);
           PageReference pageRef= null;
        }
        else{
        //PageReference pageRef= ApexPages.currentPage();
		String s= ApexPages.currentPage().getUrl();
      	system.debug('@@@@@@ pageRef getUrl: ' + s);
        isp.CQS_ISP_Progetto__c = projectName;
        system.debug('nel metodo salva ispezione. Associamo projectName al campo isp.CQS_ISP_Progetto__c, che ora è così valorizzato: ' + isp.CQS_ISP_Progetto__c);
        
        isp.OF_CQS_ISP_Comune__c = [select id,of_Comune__c,OF_Provincia__c from  OF_ElencoComuniItaliani__c where Id=:selectedIdComune].of_Comune__c;
        OF_ElencoComuniItaliani__c  OF_ElencoComuniItalianiobj  = new OF_ElencoComuniItaliani__c ();
        OF_ElencoComuniItalianiobj  = [select id,of_Comune__c,OF_Provincia__c from  OF_ElencoComuniItaliani__c where Id=:selectedIdComune];
        isp.OF_CQS_ISP_Provincia__c  = OF_ElencoComuniItalianiobj.OF_Provincia__c; 
  		system.debug('siamo nel metodo salvaIspezione. optScelta è: ' + optScelta + ' stiamo per entrare in uno degli if in base al getUrl');
	        if(s.contains('CQS_Isp_2018_06_Sicurezza')){
	        	system.debug('opt scelta è ispezione di sicurezza, al momento siamo nell\'if nel metodo di salvataggio e stiamo assegnando il recordtype alla nuova ispezione');
	        	
              
                   isp.recordtypeId=rtmap.get('Ispezione_Sicurezza_2018_06');
               system.debug('l\'id del recordtype della nuova ispezione è ' + isp.recordtypeId);
                               	      
	        } 
	        
	        else if(s.contains('CQS_Ispezione_Tema_Ambientale')){ //EC start Ispezione Tema Ambientale 2019 - 01 - 02
	        	system.debug('opt scelta è ispezione Tema Ambientale, al momento siamo nell\'if nel metodo di salvataggio e stiamo assegnando il recordtype alla nuova ispezione');
	        	
              
                   isp.recordtypeId=rtmap.get('CQS_Isp_Ispezione_Tema_Ambientale');
               system.debug('l\'id del recordtype della nuova ispezione è ' + isp.recordtypeId);
                               	      
	        } //EC end Ispezione Tema Ambientale 2019 - 01 - 02
	        
	        else{
	        	system.debug('opt scelta è ispezione di qualità, al momento siamo nell\'else if nel metodo di salvataggio e stiamo assegnando il recordtype alla nuova ispezione');
               
               //	isp.recordtypeId=rtmap.get('CQS_Ispezioni_Qualita');
              	isp.recordTypeId= rtmap.get('CQS_IspQv2'); //EC 2019 - 01 - 15 nuovo recordtype successivo allo scorporo delle ispezioni a tema ambientale.
               	system.debug('l\'id del recordtype della nuova ispezione è ' + 	isp.recordtypeId + 'la mappa è ' + rtmap);
               	
               } 
	               
	   		try{
	       		insert isp;
		        system.debug('@@@@@@@ ispezione: '+isp);
	 	         Schema.DescribeSObjectResult result = OF_CQS_Ispezione__c.SObjectType.getDescribe();
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
        }
			return	pageRef;
		}
		
		public PageReference showRow(){
			
			List<String> fieldList = new List<String>();
			fieldList.add(0,'CQS_ISP_Nome_Cognome__c');
			fieldList.add(1,'Cqs_Isp_Autorizzato__c');
			fieldList.add(2,'CQS_ISP_Nome_Cognome2__c');
			fieldList.add(3,'Cqs_Isp_Autorizzato2__c');
			fieldList.add(4,'CQS_ISP_Nome_Cognome3__c');
			fieldList.add(5,'Cqs_Isp_Autorizzato3__c');
			fieldList.add(6,'CQS_ISP_Nome_Cognome4__c');
			fieldList.add(7,'Cqs_Isp_Autorizzato4__c');
			fieldList.add(8,'CQS_ISP_Nome_Cognome5__c');
			fieldList.add(9,'Cqs_Isp_Autorizzato5__c');
			fieldList.add(10,'CQS_ISP_Nome_Cognome6__c');
			fieldList.add(11,'Cqs_Isp_Autorizzato6__c');
			String row;
		
		for(integer i=1; i<=fieldList.size();i++){
				showRow=true;
				row=row+i;
				system.debug('row è ' + row);
			if(row=='row2'){
				showRow2=true;
				system.debug('showRow2 è ' + showRow2);
				}
			if(row=='row3'){
				showRow3=true;
			}
			if(row=='row4'){
				showRow4=true;
				}
			if(row=='row5'){
				showRow5=true;
			}
			if(row=='row6'){
				showRow6=true;
				}
			if(row=='row7'){
				showRow7=true;
			}
			if(row=='row8'){
				showRow8=true;
				}
			if(row=='row9'){
				showRow9=true;
			}
			if(row=='row10'){
				showRow10=true;
			}
		}
			
			
			return null;
		
		}
		////EC - 2018 - 05 - 30  -		//Commentiamo questo metodo poiché copiamo il metodo dal controller di evento. Se funziona cancelliamo questo.
		/*
		 public void definisciProgettiPl(){
            List<String> juncUserProg = new List<String>();
             			
            optNomeProgetto = new List<SelectOption>();
            for(Progetto_Utente_junction__c jpu:[select CQS_junc_progetto__r.Name,CQS_junc_progetto__c 
                                                 from Progetto_Utente_junction__c where CQS_junc_user__c =:userinfo.getUserId()]){
            optNomeProgetto.add(new SelectOption(jpu.CQS_junc_progetto__c,jpu.CQS_junc_progetto__r.Name));      
            system.debug(optNomeProgetto);                                         
            } 
         }

		*/
		
		//EC - 2018 - 05 - 30 metodi copiato
		
		public void definisciProgettiPl(){
        	System.debug('dentro a definisciProgettiPl()');
            List<String> juncUserProg = new List<String>();
                        
            optNomeProgetto = new List<SelectOption>();
             Map<String,String> ldoMap = new Map<String, String>();
                   Map<String,String> rsocial = new Map<String, String>();
            map<string,CQS_Prog_An_junc__c> vmapjnu = new map<string,CQS_Prog_An_junc__c>();
            for(CQS_Prog_An_junc__c jnt :  [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c,CQS_Praj_Ragione_Sociale__r.name
                                                 from CQS_Prog_An_junc__c])
            {
                vmapjnu.put(jnt.CQS_Praj_Progetto__r.Name,jnt);
            }
              
            CQS_Prog_An_junc__c jnc  = new CQS_Prog_An_junc__c();
                    	System.debug('userId= ' +userinfo.getUserId());
            for(Progetto_Utente_junction__c jpu:[select CQS_junc_progetto__r.Name,CQS_junc_progetto__c 
                                                 from Progetto_Utente_junction__c where CQS_junc_user__c =:userinfo.getUserId()]){
            	optNomeProgetto.add(new SelectOption(jpu.CQS_junc_progetto__c,jpu.CQS_junc_progetto__r.Name)); 
                system.debug('peppe'+jpu.CQS_junc_progetto__r.Name);                                   
                jnc =  vmapjnu.get(jpu.CQS_junc_progetto__r.Name);
                                                     
                 system.debug('jnc======='+jnc); 
                    if(jnc != null && jnc.CQS_Praju_LDO__c != null)                                 
               jnldo =jnc.CQS_Praju_LDO__c;
               if(jnc != null && jnc.CQS_Praj_Ragione_Sociale__c != null)
                Snjun = jnc.CQS_Praj_Ragione_Sociale__r.name;
                  system.debug('projectName===='+jnc.CQS_Praj_Progetto__c);                                   
                system.debug('ldo===='+jnldo);
                system.debug('rsoci===='+Snjun); 
               system.debug('isp===='+isp);
                   projectName= jnc.CQS_Praj_Progetto__c;            
            system.debug(optNomeProgetto);                                         
            } 
           /* for(CQS_Prog_An_junc__c jpu2: [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c
                                                 from CQS_Prog_An_junc__c where CQS_Praj_Progetto__r.Name=:optNomeProgetto )
            {
                ldoMap.put(jpu2.CQS_Praj_Progetto__r.Name,jpu2.CQS_Praju_LDO__c );
                rsocial.put(jpu2.CQS_Praj_Progetto__r.Name,jpu2.CQS_Praj_Ragione_Sociale__c); 
                ldoMap.put(jpu2.CQS_Praj_Progetto__r.Name,jpu2.CQS_Praju_LDO__c );
                
            } */
            defineLDO();
            
         }   
			
		 public pageReference defineLDO(){
          //  definisciProgettiPl();
          system.debug('++++++' + projectName);
             Map<String,String> ldoMap = new Map<String, String>();
              Map<String,String> regMap = new Map<String, String>();
            for(CQS_Prog_An_junc__c jpu2: [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c
                                                 from CQS_Prog_An_junc__c where CQS_Praj_Progetto__c=:projectName ] ){
            ldoMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praju_LDO__c );
             regMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praj_Ragione_Sociale__c);
            
            }
            isp.CQS_ISP_LDO__c=ldoMap.get(projectName);
			isp.OF_CQS_Impresa_Mandataria__c=regMap.get(projectName);
            
            system.debug('Testin'+ ldoMap);     
            return null;
        }	
        
        //End EC - 2018 - 05 - 30 metodo copiato
		
		
		
		/*
		
		private String ispezioneG{get; set;}
		private List<String> campiAccessibili{get; set;}
									
		public OF_CQS_Ispezione__c isp2{

			get;
			set{
			 setOF_CQS_Ispezione__c(ispezioneG);
			 discovercampiAccessibili(ispezioneG);
			 isp2 = reloadOjectWithAllFieldData();
			
			}
		}
		
		public String getObjectType(){
		return(this.ispezioneG);
		}
		
		public List<String> getcampiAccessibili(){
		return(this.campiAccessibili);
		} 
																  //newoIsp

		private void discovercampiAccessibili(OF_CQS_Ispezione__c newoIsp){
			this.campiAccessibili= new List<String>();
				Map<String, Schema.sObjectField> fields = Schema.getSObjectType().describe().fields.getMap();
					for(String s : fields.keySet()){
						if(field.get(s).getDescribe().IsAccessible()){
						this.campiAccessibili.add(s);
						}
					
					}
		
		}
				//soIspect 

		private OF_CQS_Ispezione__c reloadObjectWithAllFieldData() {
		        String qid = ApexPages.currentPage().getParameters().get('id');
		        String theQuery = 'SELECT ' + joinList(getcampiAccessibili(), ', ') +
		                          ' FROM ' + getObjectType() +

		                          ' WHERE Id = :qid';
		        return(Database.query(theQuery));      
		    }
		
		
		private static String joinList(List<String> theList, String separator) {
		        if (theList == null)   { return null; }
		        if (separator == null) { separator = ''; }
					String joined = '';
					Boolean firstItem = true;
						for (String item : theList) {
							if(null != item) {
								if(firstItem){ 
									firstItem = false; 
								}
								else { 
									joined += separator; 
								}
							joined += item;
							}
						}
					return joined;
		    }
		    */
    
    public String searchTerm {get; set;}
    public String selectedIdComune {get; set;}
    
    // JS Remoting action called when searching
    @RemoteAction
    public static List<OF_ElencoComuniItaliani__c > searchComune(String searchTerm) 
    {
        // System.debug('Comune Name is: '+searchTerm );
        List<OF_ElencoComuniItaliani__c > eventList = Database.query('SELECT Id,OF_Comune__c  FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm) + '%\'  order by OF_Comune__c ASC ' );
        System.debug('eventList : '+eventList );
        return eventList ;        
    }
    
   /* public OF_ElencoComuniItaliani__c getComune()
    {
        OF_ElencoComuniItaliani__c ag = [SELECT Id,OF_Comune__c  FROM OF_ElencoComuniItaliani__c where id =: 'selectedIdComune' limit 1];
        return ag;
    }*/
	
     public static String dateHToString(){
        
        String yM = String.valueOf(System.now().format('HH:mm')) ;
        return yM;
    }

}
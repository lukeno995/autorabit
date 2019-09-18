public class CQS_Utils {
	 
	 public static boolean updateTrigger = true;
     public static Decimal x = 0; //per il totale
	 public static Decimal y = 0; //per il totale massimo
	 public static String na='N/A'; 
	 public static String n='No';
	 public static String s='Sì';
  	 public static String s1='Si';
     
     //EC da qui inseriamo variabili statiche per Eventi
     
   //public static String etEventoInserito='Incidente_Email_Template'; //commento poiché al momento viene utilizzato lo stesso EmailTemplate per tutti i tipi di eventi ad eccezione degli Infortuni (che comunque al momento non vengono censiti)
	 
	 public static String etDanni_Iss_L_M='Incidente_Email_Template';
	 public static String etInfortunio='Email Alert Infortunio';
	 
	 public static String indexGravL ='L - Lieve';
	 public static String indexGravM ='M - Media';
	 public static String indexGravA ='A - Alta';
	 public static String indexGravNP ='NP - Non Pervenuto';
     public static String eDa  ='OF_CQS_Danni_Arrecati';
     public static String eIss ='OF_CQS_Interferenza_Sottoservizi';
     public static String eInf ='OF_CQS_Infortunio';
     public static String eBadP ='OF_CQS_Bad_Practice';
    
    //EC Start - 2018 - 04 - 19
    
	 public static List<String> mailAddresses = new List<String>();
     public static String eTfolderName ='CQS_Email_Template';
     
     public static Set<Id> Idprogetto = new Set <Id>();		
	 public static List<Id> listUserId = new List<Id>(); 
	 public Static String cmStr='City Manager';
	
	 public Static String cmCentro='City Manager Centro';
	 public Static String cmSud='City Manager Sud';
	 public Static String cmNord='City Manager Nord';
	  
    
	//EmailTemplate  -> //subject 	//body //FolderId//Folder.Name  //Name //DeveloperName			v fatto
	//User Superiori al citymanager																	v fatto
	//indirizzi email in base a zona e gravità
	//EC - start 2018_04_23
	
	public Static Id cm=null;
	
	//Start EC - 2018 - 04 - 23  Invio email
	//GB rivisto
    @future
	public static void inviaMail3(Set<Id> evSetId){	
		System.debug('@@@@@@@@@@ entriamo nel metodo di invio email');
		Set<OF_CQS_Evento__c> evSet = new Set<OF_CQS_Evento__c>([Select Id, name, CQS_Ev_Progetto__c, 
																CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
																Owner.Name, recordType.DeveloperName, recordType.Name,
																recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
																OF_CQS_Impresa_Esecutrice_Eventi__c, 
																OF_CQS_Impresa_Mandataria__r.Name, OF_CQS_Impresa_Esecutrice_Eventi__r.Name
																from OF_CQS_Evento__c 
																where Id IN :evSetId and Skip_Email__c = false]);
		List<String> listStrinf=new List<String>();
		listStrinf.add(etInfortunio);
		listStrinf.add(etDanni_Iss_L_M);
		Map<String,EmailTemplate> mappaOut= ritornaTemplates(listStrinf);
		
		List<Id> listProg=new List<Id>();
		for(OF_CQS_Evento__c ev : evSet){
			listProg.add(ev.CQS_Ev_Progetto__c);
	    	System.debug('@@@@@@@@@@ la lista contiene ' + listProg.size() +'progetti' );
			System.debug('@@@@@@@@@@ i progetti aggiunti al set sono' + ev.CQS_Ev_Progetto__c );
		}		 
		Map<Id,List<ID>> progUtDestPuJMap=getUListPro(listProg);
		
		List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); //commenta riga 345
	    for(OF_CQS_Evento__c ev : evSet){
	    	
             
			List<Id> listTargetUser=progUtDestPuJMap.get(ev.CQS_Ev_Progetto__c);
			System.debug('@@@@@@@@@@ la lista listTargetUser contiene ' + listTargetUser.size() +'user' );
			List<Id> listAddUser=listTargetUser;
			System.debug('@@@@@@@@@@ la lista listAddUser contiene ' + listAddUser.size() +'user' );
			Set<Id> listaRuoliSuperiori= new Set<Id>();
            if(!(ev.recordType.DeveloperName.equals(eBadP))){	
            	if(indexGravA.equals(ev.CQS_Indice_Gravita_Taglio_Danneggiamento__c)){
	            	system.debug('@@@@@ Siamo nel caso dell\'indice di gravità alta');
		            for(User userX:[select id, UserRoleId, UserRole.Name from User where Id=:listTargetUser]){
		               if(userX.UserRole.Name.contains(cmStr)){
		               	   listaRuoliSuperiori.addAll(getUserRoleSup(userX.UserRoleId));
		               	   system.debug('@@@@@ Gli utenti sono' + listaRuoliSuperiori);
		               }
		            }
		            List<User> listUser=[Select id, Name from User Where UserRoleId=:listaRuoliSuperiori];
		            for(User li:listUser){
		           		 listAddUser.add(li.id);
		           		  System.debug('@@@@@@@@@@ prendiamo gli user li: ' + li.Name);
	        
		            }
		            System.debug('@@@@@@@@@@ la lista listAddUser, con l\'aggiunta di user con ruolo superiore contiene infine ' + listAddUser.size() +'user' );
	        	}
	    	}   
	     for(Id idd:listAddUser){	
		    Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
		    singleMail.setSubject('Evento Inserito');
			singleMail.setSaveAsActivity(false);
		    singleMail.setTargetObjectId(idd);	
		    System.debug('@@@@@@@@@ l\' id degli user è: '+ idd);        
		    String nameTemplate=(ev.recordType.DeveloperName).equals(eInf)?etInfortunio:etDanni_Iss_L_M;
		    EmailTemplate eT=new EmailTemplate();
		    eT=mappaOut.get(nameTemplate);
		    System.debug('@@@@@ stiamo scegliendo il seguente emailTemplate' + eT);
		    System.debug('@@@@@ stiamo scegliendo l\'emailTemplate sulla base del recordType');
		    singleMail.setTemplateId(eT.Id); 
		    System.debug('@@@@@ stiamo settando l\'id dell\'emailTemplate');
		 	
		 
		    System.debug('@@@@@@@@@ EV è: '+ ev);
		       		//EC
		    singleMail.setSenderDisplayName(ev.Owner.Name);
		           
		             //EC2
		   /*          
			System.debug('@@@@HTMLValue: ' + eT.HtmlValue);
		    String htmlBody = eT.HtmlValue;
	        System.debug('@@@@HTMLBODY: ' + htmlBody);
 			
    		htmlBody = htmlBody.replaceFirst('{!OF_CQS_Evento__c.RecordTypeId}', ev.RecordTypeId);
 			htmlBody = htmlBody.replaceFirst('{!OF_CQS_Evento__c.Name}', ev.Name);
			htmlBody = htmlBody.replaceFirst('{!OF_CQS_Evento__c.OF_CQS_Impresa_Mandataria__c}', ev.OF_CQS_Impresa_Mandataria__c);
			htmlBody = htmlBody.replaceFirst('{!OF_CQS_Evento__c.OF_CQS_Impresa_Esecutrice_Eventi__c}', ev.OF_CQS_Impresa_Esecutrice_Eventi__c);
			htmlBody = htmlBody.replaceFirst('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', ev.CQS_Indice_Gravita_Taglio_Danneggiamento__c);
			htmlBody = htmlBody.replaceFirst('{!OF_CQS_Evento__c.OwnerFullName}', ev.Owner.Name);
			htmlBody = htmlBody.replaceFirst('{!OF_CQS_Evento__c.RecordType}', ev.RecordType.Name);
			htmlBody = htmlBody.replaceFirst('{!OF_CQS_Evento__c.Name}', ev.Name);
			htmlBody = htmlBody.replaceFirst('{!OF_CQS_Evento__c.Link}','href=https://cs87.salesforce.com/'+ev.Id+' >clicca qui.</a>');
			*/
				
			String plainBody = eT.Body;
			//plainBody=plainBody.replaceAll('OF_CQS_Evento__c','ev');
			System.debug('@@@@eTBody: ' + eT.Body);
			System.debug('@@@@plainBody: ' + plainBody);
			
	    	plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', ev.RecordType.Name);
	    	plainBody = plainBody.replace('{!OF_CQS_Evento__c.Name}', ev.Name);
	    	plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Mandataria__c}', ev.OF_CQS_Impresa_Mandataria__r.Name);
	    	plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Esecutrice_Eventi__c}', ev.OF_CQS_Impresa_Esecutrice_Eventi__r.Name);
	    	plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', ev.CQS_Indice_Gravita_Taglio_Danneggiamento__c);
	    	plainBody = plainBody.replace('{!OF_CQS_Evento__c.OwnerFullName}', ev.Owner.Name);
	    	//plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs87.salesforce.com/'+ev.Id+' >clicca sul link.</a>');
            //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs87.salesforce.com/'+ev.Id+' >clicca sul link.</a>'); //Sviluppo
	    	//plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs83.salesforce.com/'+ev.Id+' >clicca sul link.</a>');//Collaudo
	    	plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://openfiber-it.my.salesforce.com/'+ev.Id+' >clicca sul link.</a>'); //produzione prima eu6
	             //END EC2 openfiber-it.my.salesforce.com  openfiber-it.my.salesforce.com
	        
	       // singleMail.setHtmlBody(eT.HtmlValue);
     	    // singleMail.setHtmlBody(htmlBody);
			//singleMail.setPlainTextBody(eT.body);
     	    singleMail.setPlainTextBody(plainBody);
	         //End EC
	       
	      
		   			 
	       		emails.add(singleMail);
	       		system.debug('Abbiamo appena inserito nella lista di email le SingleEmail, questa è l\'ultima operazione prima di uscire dal FOR');
	       } 
	    }    
	    System.debug('@@@@@@@@@@ la lista contiene ' + emails.size() +' email' );
	    Messaging.sendEmail(emails); 
	   System.debug('@@@@@@@@@@ sono state inviate ' + emails.size() +' email' );
    }    
	
	
	//Start EC 2018 - 04 - 24 nuovo metodo che torna una mappa con id progetto e lista di user destinatari. Metodo copiato
	//GB rivisto
	public static Map<Id,List<Id>> getUListPro(List<Id> listaProg){
		system.debug('passiamo la seguente listaProg' + listaProg);
		Map<Id,List<Id>>  progUtDestPuJMap = new Map<Id,List<Id>>();
		List<Progetto_Utente_junction__c> listResult=[select CQS_junc_progetto__c, CQS_junc_user__c, CQS_junc_user__r.UserRole.Name, 
													  CQS_junc_user__r.UserRoleId, CQS_junc_user__r.Email from Progetto_Utente_junction__c 
													  where CQS_junc_progetto__c =:listaProg and CQS_junc_user__r.IsActive = true];
		
		for(Id prog:listaProg){
		  List<Id> listUser=new List<Id>(); 	  
		  for(Progetto_Utente_junction__c puj:listResult){
		   	  listUser.add(puj.CQS_junc_user__c);
		  } 
		  progUtDestPuJMap.put(prog,listUser);
		}		
		return progUtDestPuJMap;
	}
		
		
		
			
		
	
	public static List<User> getUtSup(Set<ID> roleIds) {
		List<User> uList= new List<User>();
		
		uList = [select Id,userroleId,userrole.ParentRoleId, email from user where UserRoleId IN: roleIds];
		
		return uList;
	}
	
	public static Set<Id> getUtSupId(Set<ID> roleIds) {
		Set<Id> uIdSet= new Set<Id>();
			For(User u : [select Id from user where UserRoleId IN: roleIds]){
				uIdSet.add(u.id);	
			}
			return uIdSet;
	}
		
		
	//GB rivisto
	public static Set<ID> getUserRoleSup(ID cmRole){
		Set<Id> roleIds = new Set<Id>();
		
		UserRole ur =[select Id, ParentRoleId from UserRole where Id =: cmRole limit 1];
   	    roleIds.add(ur.ParentRoleId);
        
        UserRole ur2 =[select Id, ParentRoleId from UserRole where Id =: ur.ParentRoleId limit 1];
		roleIds.add(ur2.ParentRoleId);
		
		return roleIds;
	}
	
	//GB rivisto
	public static Map<String,EmailTemplate> ritornaTemplates(List<String> listaNameTemplate){
		//String nameTemplate=rtEvento.equals(eInf)?etInfortunio:etDanni_Iss_L_M;
		Map<String,EmailTemplate> mappaT=new Map<String,EmailTemplate>();
		List<EmailTemplate> et=[Select id, Name, subject, body, FolderId, Folder.Name, HtmlValue from 	EmailTemplate where Folder.Name=:eTfolderName and Name=:listaNameTemplate];
		for(EmailTemplate el:et){
		   mappaT.put(el.Name,el);
		}
		return mappaT;
	}
	
	//End EC - 2018 - 04 - 19
	
         /*
         
         
         
         
	   List<Progetto_Utente_junction__c> listaPUJ =[select id,CQS_junc_user__r.Email, CQS_junc_progetto__c
														from Progetto_Utente_junction__c
                                                     	where CQS_junc_progetto__r.Name =:ListIdprog  and CQS_junc_user__r.IsActive = true];
       for(OF_CQS_Evento__c ev: [Select CQS_Ev_Progetto__c from OF_CQS_Evento__c where id IN:idEvSet]){
        ListIdprog.add(ev.CQS_Ev_Progetto__c);
        }
        indirizziEmailPuJ.put();
		 */
     /* 
        for(CQS_Progetto__c pro: [Select Id, (select CQS_junc_user__r.email from Progetto_Utente_junctions__r 
												where CQS_junc_user__r.isactive=true)
                                   from CQS_Progetto__c where ID in:setProgetti]){
                                       List<String> indirizziEmail = new List<String>();
                                          for(Progetto_Utente_junction__c u : pro.Progetto_Utente_junctions__r){
                                             if(u.CQS_junc_user__r.IsActive==true){ 
                                              indirizziEmail.add(u.CQS_junc_user__r.email);
                                             }
                                          }
		indirizziEmailPuJ.put(pro.Id, indirizziEmail);
                                   }
  }
    */
    
    
    /* Start EC 2018 - 04 - 24 metodo che torna una lista di stringhe. Ora lo copio e incollo e lo faccio tornare una mappa di Id progetto e List User destinatari, se funziona cancellare questo metodo commentato.
	public static List<String> getIndirizziEmail(Set<id> idEvSet, Set<Id> setProgetti){
		
		Map<Id,List<String>>  indirizziEmailPuJMap = new Map<Id,List<String>>();
		
		List<Schema.PicklistEntry> ple = OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c.getDescribe().getpicklistValues();
		Integer indexGravL = 0;
		Integer indexGravM = 1;
		Integer indexGravA = 2;
		Integer indexGravNP = 3;
		
		for(OF_CQS_Evento__c ev : [select id from OF_CQS_Evento__c where id IN : idEvSet]){
			
			IF(ev.RecordType.DeveloperName.equals(eIss)||ev.RecordType.DeveloperName.equals(eDa)){ //se il tipo di evento è una interferenza ai sottoservizi o danneggiamenti a terzi entri nell'if
				System.debug('@@@@@@@EC - Siamo nel metodo relativo agli indirizzi email a cui inviare gli alert nello specifico mi trovo nell\'if di una interferenza ai sottoservizi o danneggiamenti a terzi in particolare: ' + ev.RecordType.DeveloperName);
				if(!(ev.CQS_Indice_Gravita_Taglio_Danneggiamento__c.equals(indexGravA))){
						System.debug('@@@@@@@EC - Siamo nel metodo relativo agli indirizzi email a cui inviare gli alert nello specifico mi trovo nell\'if di una interferenza ai sottoservizi o danneggiamenti a terzi in particolare: ' + ev.RecordType.DeveloperName + 'e l\'indice di gravita è il seguente: ' + ev.CQS_Indice_Gravita_Taglio_Danneggiamento__c);
					for(Progetto_Utente_junction__c puj : [select CQS_junc_progetto__c, CQS_junc_user__c, CQS_junc_user__r.UserRole.Name, 
															CQS_junc_user__r.UserRoleId, CQS_junc_user__r.Email from Progetto_Utente_junction__c 
															where CQS_junc_progetto__c =:setProgetti and CQS_junc_user__r.IsActive = true]){
         			  	listUserId.add(puj.CQS_junc_user__c);
          			  	//aggiungiamo gli indirizzi email degli utenti legati allo stesso progetto
           				 mailAddresses.add(puj.CQS_junc_user__r.Email);
           				//popoliamo la mappa con gli id dei progetti e la lista degli indirizzi email degli utenti legati a quei progetti. 
          				indirizziEmailPuJMap.put(puj.CQS_junc_progetto__c, mailAddresses);
					}
					return mailAddresses;
					System.debug('@@@@EC nel caso di Iss o Danni di tipo non grave il numero di indirizzi email all\'interno della lista è di: ' + mailAddresses.size() +' indirizzi email' );
				}
				else{
					for(Progetto_Utente_junction__c puj : [select CQS_junc_progetto__c, CQS_junc_user__c, 
														CQS_junc_user__r.UserRole.Name, CQS_junc_user__r.UserRoleId, CQS_junc_user__r.Email 
														from Progetto_Utente_junction__c where CQS_junc_progetto__c =:setProgetti and CQS_junc_user__r.IsActive = true]){
				          		//aggiungiamo gli indirizzi email degli utenti legati allo stesso progetto
				            	listUserId.add(puj.CQS_junc_user__c);
					            mailAddresses.add(puj.CQS_junc_user__r.Email);
					          	indirizziEmailPuJMap.put(puj.CQS_junc_progetto__c, mailAddresses);
					          
			          			if(puj.CQS_junc_user__r.UserRole.Name.contains(cmStr)){
			          				String emTemp;
	          						//in cm storiamo il valore dell'id del ruolo del CM.
	    								cm=puj.CQS_junc_user__r.UserRoleId;
	    						//		getEmailUtSup(getUserRoleSup(cm));
	    								//torno così una lista di user 
	    								//listUserId è una lista di ID
	          					}
	          						mailAddresses.addAll(getEmailUtSup(getUserRoleSup(cm)));
	          					listUserId.addAll(getUtSupId(getUserRoleSup(cm)));
	  	  			}
	  				return mailAddresses;
		  			//return cm; 
//						listUserId.addAll(getUserRoleSup(cm).getUtSup());
							for(user u : [select id, email, name from User where id=: listUserID]){
							mailAddresses.add(u.email);
							}						
				return  mailAddresses;
					System.debug('@@@@EC nel caso di Iss o Danni di tipo grave il numero di indirizzi email all\'interno della lista è di: ' + mailAddresses.size() +' indirizzi email' );
				}
			}
			else{ //nel caso in cui il tipo di evento sia una Bad Practice non è necessario allertare gli utenti superiori
				for(Progetto_Utente_junction__c puj : [select CQS_junc_progetto__c, CQS_junc_user__c, CQS_junc_user__r.UserRole.Name, 
															CQS_junc_user__r.UserRoleId, CQS_junc_user__r.Email from Progetto_Utente_junction__c 
															where CQS_junc_progetto__c =:setProgetti and CQS_junc_user__r.IsActive = true]){
         			 
          			  	listUserID.add(puj.CQS_junc_user__c);
          			  	//aggiungiamo gli indirizzi email degli utenti legati allo stesso progetto
           				 mailAddresses.add(puj.CQS_junc_user__r.Email);
           				//popoliamo la mappa con gli id dei progetti e la lista degli indirizzi email degli utenti legati a quei progetti. 
          				indirizziEmailPuJMap.put(puj.CQS_junc_progetto__c, mailAddresses);
					}
					return mailAddresses;
			}
		}return mailAddresses;
	}
	*/ //Ec - stop 2018 - 04 - 24
	
	/* EC - 2018 - 04 - 20
	
	public static list<String> getEmailUt(List<User> uList){
		List<String> indEmailUt = new List<String>();
		for(User u : [Select id, email from User where ID in: uList]){
			indEmailUt.add(u.Email);
		}	
		return indEmailUt;
	}
	*/
	
	/*
	@future
	public static void inviaMail(){
		
		for(user U : w.ruoliSuperioriECityM){
        				Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
        				//Messaging.SingleEmailMessage singleMail=Messaging.renderStoredEmailTemplate(templateId, whoId, whatId);
		                //set email object
        				singleMail.setSubject('Inserimento Pratica Evento');
                        //set object Id
		                singleMail.setTargetObjectId(u.Id);
		                //singleMail.setTargetObjectId(u.Id);
		                //set template Id
		                singleMail.setTemplateId(w.et.Id);
		                //flag to false to stop inserting activity history
		                singleMail.setSaveAsActivity(false);
		                //add mail 
		                emails.add(singleMail);
		                System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui siamo nell\'if del wrapperEmail w.ruoliSup=true e aggiungiamo le email');
        				System.debug('@@@@@stiamo inviando una email a ' + w.cityManagerEmail);
        			//	Messaging.sendEmail(emails);
        			//	System.debug('@@@@@@@ stiamo mandando l\'email a ' + u.mail);
        			}
        			Messaging.sendEmail(emails);
	
	}
	*/
	/*
		public static emailTemplate scegliEt(String rtEvento, String indGrav){
		emailTemplate eT = new emailTemplate();
		if(rtEvento.equals(eInf)){
			eT=[Select id, Name, subject, body, FolderId, Folder.Name from emailTemplate where Folder.Name=:eTfolderName and Name=:etInfortunio];
		}
		else {
			eT=[Select id, Name, subject, body, FolderId, Folder.Name from emailTemplate where Folder.Name=:eTfolderName and Name=:etDanni_Iss_L_M];
		}
		return eT;	
	//et=rtEvento.equals(eInf)?[Select id, Name, subject, body, FolderId, Folder.Name from emailTemplate where Folder.Name=:eTfolderName and Name=:etInfortunio]:[Select id, Name, subject, body, FolderId, Folder.Name from emailTemplate where Folder.Name=:eTfolderName and Name=:etDanni_Iss_L_M];
	}
	*/
	
	// End EC - 2018 - 04 -20
    
    
    @future
    //metodo asincrono per l'invio di email alert per Incidente Grave, Lieve, Medio, Infortunio o Nuovo Evento inserito
   // public static void inviaMail(Map<Id,Id> mapEvProg,Set<Id> setProgetti){
   	public static void inviaMail(List<Id> evIdList,Map<Id,Id> mapEvProg,Set<Id> setProgetti){ 
   		
   		
   		        System.debug('@@@@@@@ entriamo nel public static void inviaMail Method' );
   	
    String emailTemplateEventoInserito='Incidente_Email_Template';
	String emailTemplateDanni_InterferenzaLievi_Medi='Incidente_Email_Template';
	String emailTemplateInfortunio='Email Alert Infortunio';
	 
	String indexGravL ='L - Lieve';
	String indexGravM ='M - Media';
	String indexGravA ='A - Alta';
	String indexGravNP ='NP - Non Pervenuto';
    String eDa  ='OF_CQS_Danni_Arrecati';
    String eIss ='OF_CQS_Interferenza_Sottoservizi';
    String eInf ='OF_CQS_Infortunio';
    String eBadP ='OF_CQS_Bad_Practice';
    
    List<String> emailList = new List<String>();
    List<User> userToSendMail = new List<User>();
    EmailTemplate et = new  EmailTemplate();
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    User cityManager  = new User();
    UserRole ur = new UserRole();
    UserRole ur2 = new UserRole();
    List<userrole> listUr = new List<userrole>();
    List<Id> listUrId = new List<Id>();
    Map<List<String>, EmailTemplate> indMailTempl = new Map<List<String>, EmailTemplate>();
    Map<Id, wrapperEmail> MapUserWrapper = new Map<Id, wrapperEmail>();   
    Map<Id, wrapperEmail> MapProgettoWrapper = new Map<Id, wrapperEmail>();
    List<wrapperEmail> allWrappers = new  List<wrapperEmail>();
    Map<String,EmailTemplate> MapEmailTemplate = new Map<String,EmailTemplate>();
        
		Map<Id, map<Id,String>> MapProgCityM = new Map<Id, map<Id,String>>();
        set<Id> UserIdProf = new Set<Id>();
		for(CQS_Progetto__c pro: [select Id, (select CQS_junc_user__c,CQS_junc_user__r.email from Progetto_Utente_junctions__r 
												where CQS_junc_user__r.isactive=true and CQS_junc_user__r.Profile.name='OF_CQS_City_Manager')
                                      from CQS_Progetto__c where ID in:setProgetti]){  
			List<Id> newList = new List<Id>();
			map<Id,String> cityMan;
			wrapperEmail wrap = new wrapperEmail();
			wrap.prog=pro;
			System.debug('@@@@@@@ siamo nel public static void inviaMail Method dopo aver creato map<Id,String> cityMan,wrapperEmail wrap = new wrapperEmail();	wrap.prog=pro;' );
			for(Progetto_Utente_junction__c u : pro.Progetto_Utente_junctions__r){
				newList.add(u.CQS_junc_user__c);
				wrap.cityManagerEmail=u.CQS_junc_user__r.email;
				wrap.cityManagerId=u.CQS_junc_user__c;
				
				UserIdProf.add(u.CQS_junc_user__c);
				cityMan = new map<Id,String>();
				cityMan.put(u.CQS_junc_user__c,u.CQS_junc_user__r.email);
				MapUserWrapper.put(u.CQS_junc_user__c,wrap);
				MapProgettoWrapper.put(pro.id,wrap);
			System.debug('@@@@@@@ siamo nel public static void inviaMail Method nel for del ProjectJunctionObj, qui popoliamo le mappe');
			}
			allWrappers.add(wrap);
			System.debug('@@@@@@@ siamo nel public static void inviaMail Method fuori dal for del ProjectJunctionObj, qui abbiamo aggiunto wrap all\'allWappers, allWrappers.add(wrap); ');
 			MapProgCityM.put(pro.Id,cityMan);   
			System.debug('@@@@@@@ siamo nel public static void inviaMail Method fuori dal for del ProjectJunctionObj, qui popoliamo la mappa MapProgCityM.put(pro.Id,cityMan);');
        }                                      
         //UserIdProf per cercare per profilo
    //  Map<Map<id, Id>, Map<List<String>, EmailTemplate>> idEvProEmailTemp = new Map<Map<id, Id>,Map<List<String>, EmailTemplate>>();
      String queryCM = '[Select id, email, Profile.name, userroleId from User where Id In: UserIdProf and Profile.name=\'OF_CQS_City_Manager\']';
      String queryUr='[select Id, ParentRoleId from UserRole where id=:cityManager.userroleId]';
      String queryUr2 ='[select Id, ParentRoleId from UserRole where id=:ur.parentroleId]';
      
      
      Map<Id,String> userRoleEmailMap = new Map<Id,String>();
      Map<Id,Id> userIdRoleMap = new Map<Id,Id>();
      for(user u:[select id,email,userroleid from user]){
    
      	userRoleEmailMap.put(u.userroleid,u.email);
      	userIdRoleMap.put(u.Id,u.userroleid);
		System.debug('@@@@@@@ siamo nel public static void inviaMail Method nel for degli utenti, qui popoliamo le mappe userRoleEmailMap.put(u.userroleid,u.email) e userIdRoleMap.put(u.Id,u.userroleid)');
      }
      for(emailtemplate e : [select Id,Name, Subject, HtmlValue, Body from emailtemplate]){
      	MapEmailTemplate.put(e.name,e);
      	System.debug('@@@@@@@ siamo nel public static void inviaMail Method nel for per popolare MapEmailTemplate.put(e.name,e)');
      }
      List<wrapperEmail> ruoliSuperiori = new List<wrapperEmail>();
      for(OF_CQS_Evento__c ev :[Select id, Name, OwnerID, RecordType.Name, RecordType.DeveloperName, OF_CQS_Comune_Text__c,OF_CQS_Data_Apertura_Pratica__c,
                                   OF_CQS_Data_Att_Assicurazione_Impresa__c,OF_CQS_Data_Chiusura_Pratica__c,OF_CQS_Data_Evento__c,
                                   Prognosi__c,OF_CQS_Giorni_Persi_e__c,OF_CQS_Impresa_Mandataria__c,OF_CQS_Impresa_Esecutrice_Eventi__c,
                                   CQS_Indice_Gravita_Taglio_Danneggiamento__c,OF_CQS_Indice_Gravita_Infortunio__c,CQS_Ev_Lettera_D_Ordine__c,
                                   CQS_Ev_Progetto__c,OF_CQS_Prognosi_Riservata__c,OF_CQS_Provincia_Evento__c,OF_CQS_Ricovero__c,Rimborso_richiesto__c,
                                   Rimborso_Riconociuto__c,Skip_Email__c,Sottoservizio__c,OF_CQS_Stato_Evento__c,OF_CQS_Stato_Pratica__c,
                                   OF_CQS_Struttura_Danneggiata__c from OF_CQS_Evento__c where Id in:evIdList]){
		      	System.debug('@@@@@@@ siamo nel public static void inviaMail Method nel for che cicla ogni evento');      	     
      	    if(ev.Skip_Email__c==false){ 
		      	wrapperEmail wrap = MapProgettoWrapper.get(ev.CQS_Ev_Progetto__c);
	            wrap.ev=ev;
	        	System.debug('@@@@@@@ siamo nel public static void inviaMail Method nel for, nell\'if dello skip mail');
	        	System.debug('@@@@ dev: '+ev.RecordType.DeveloperName+' '+eDa+' '+ eIss);
	            if((ev.RecordType.DeveloperName.equals(eDa))||(ev.RecordType.DeveloperName.equals(eIss))){
	            	System.debug('@@@@@@@ siamo nel public static void inviaMail Method scegliamo il template se censiamo danni o interferenze');
	            	
	            	if(ev.CQS_Indice_Gravita_Taglio_Danneggiamento__c.equals(indexGravA)||ev.CQS_Indice_Gravita_Taglio_Danneggiamento__c.equals(indexGravNP)){
		            ruoliSuperiori.add(wrap);
		            wrap.ruoliSup=true;
		            wrap.et=MapEmailTemplate.get(emailTemplateDanni_InterferenzaLievi_Medi);
					System.debug('@@@@@@@ siamo nel public static void inviaMail Method scegliamo il template se censiamo danni o interferenze e a chi mandarlo se l\'evento è grave');
					}
					else if(ev.CQS_Indice_Gravita_Taglio_Danneggiamento__c.equals(indexGravL)||ev.CQS_Indice_Gravita_Taglio_Danneggiamento__c.equals(indexGravM)){
					emailList.add(MapProgCityM.get(ev.CQS_Ev_Progetto__c).values()[0]);
					userToSendMail.add(cityManager);
					wrap.ruoliSup=false;
					wrap.et=MapEmailTemplate.get(emailTemplateDanni_InterferenzaLievi_Medi);
					System.debug('@@@@@@@ siamo nel public static void inviaMail Method scegliamo il template se censiamo danni o interferenze e achi mandarlo se l\'evento è lieve');
					}
		        }
		        else if(ev.RecordType.DeveloperName.equals(eInf)){ 
            		wrap.et=MapEmailTemplate.get(emailTemplateInfortunio);
            		ruoliSuperiori.add(wrap);
		            wrap.ruoliSup=true;
		        					System.debug('@@@@@@@ siamo nel public static void inviaMail Method scegliamo il template se censiamo un infortunio');
		        } 
		        else if(ev.RecordType.DeveloperName.equals(eBadP)){
		        	wrap.et=MapEmailTemplate.get(emailTemplateEventoInserito);
		        	emailList.add(MapProgCityM.get(ev.CQS_Ev_Progetto__c).values()[0]);
					userToSendMail.add(cityManager);
					wrap.ruoliSup=false;
		        					System.debug('@@@@@@@ siamo nel public static void inviaMail Method scegliamo il template se censiamo tutto il resto');
		        }
		      	
      	    }
        }
        //caso in cui non ci sono eventi gravi
        if(ruoliSuperiori.isEmpty()){
        //if(wrap.ruoliSup==false){	
        	for(wrapperEmail wr : allWrappers){
        		Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
        		System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui settiamo il necessario per inviare le email se la lista dei ruoli superiori è vuota');
        		//set email object
        		singleMail.setSubject('Inserimento Pratica Evento');
                //set object Id
                singleMail.setTargetObjectId(wr.cityManagerId);
                //singleMail.setTargetObjectId(u.Id);
                //set template Id
                singleMail.setTemplateId(wr.et.Id);
                //flag to false to stop inserting activity history
                singleMail.setSaveAsActivity(false);
                //add mail
                emails.add(singleMail);
        	System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui mandiamo le email a: ' + wr.cityManagerId + ',all\'indirizzo email ' + wr.cityManagerEmail);
        	}
        	Messaging.sendEmail(emails); 
        	System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui mandiamo le email se la lista dei ruoli è vuota');
        }
        //caso in cui ci sono eventi gravi
        else{
        	System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui Se si sta inserendo anche un solo evento grave bisogna rivalutare a chi inviare le email');
        	Set<Id> userConRuoliSuperiori = new Set<Id>();
        	list<User> tuttiGliUtentiSuperiori = new list<User>();
        	list<Id> tuttiICityManagersId = new list<Id>();
        	for(wrapperEmail wr : allWrappers){
        		if(wr.ruoliSup==true){
					System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui Se si stanno considerando gli eventi che richiedono l\'invio agli utenti con ruolo superiore');
        			userConRuoliSuperiori.add(userIdRoleMap.get(wr.citymanagerId));
        			tuttiICityManagersId.add(wr.citymanagerId);
        			System.debug('@@@@@@@ Ruoli superiori true, abbiamo aggiunto + wr.citymanagerId + wr.');
        			
        		}
        		else{
        			System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui invece siamo nell\'else quindi non si stanno inserendo eventi di grave entità');
        			Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
        			//set email object
        			singleMail.setSubject('Inserimento Pratica Evento');
                	//set object Id
	                singleMail.setTargetObjectId(wr.cityManagerId);
	                //singleMail.setTargetObjectId(u.Id);
	                //set template Id
	                singleMail.setTemplateId(wr.et.Id);
	                //flag to false to stop inserting activity history
	                singleMail.setSaveAsActivity(false);
	                //add mail
	                emails.add(singleMail);
        		}  
        		
        	}
        	tuttiGliUtentiSuperiori=CQS_Utils.getAboveUsers(userConRuoliSuperiori);
        	list<User> tuttiICityManagers = [select Id,userroleId, userrole.parentroleId, email from user where Id in :tuttiICityManagersId];
        	System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui abbiamo la lista di tutti i CityManagers');
        	wrapperEmail wr;
        	TEMPLOG__c tL = new TEMPLOG__c();
   			tL.class__c ='CQS_Utils__c';
   			System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui stiamo inserendo il nome della classe del templog: ' + tL.class__c);
        	for(user u :tuttiICityManagers){
        		wr=MapUserWrapper.get(u.Id);
        		wr.ruoliSuperioriECityM=new List<User>();
				wr.ruoliSuperioriECityM.add(u);
  			//	wr.ruoliSuperioriECityM.add(tuttiICityManagers.get(0));
        		tl.desc__c='Evento: '+wr.ev.Id+', User 1: '+u.email;
				System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui oltre al nome della classe impostiamo anche il primo user, User 1: '+u.email);
	   			System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui oltre al nome della classe impostiamo anche la descrizione del templog per il primo user');
        		for(user u2 : tuttiGliUtentiSuperiori){
        			tl.desc__c=tl.desc__c+', user 2: '+u2.email;
		   			System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui oltre al nome della classe impostiamo anche la descrizione del templog per il secondo user');
        			if(u.userrole.parentroleId==u2.userroleId){
        				wr.ruoliSuperioriECityM.add(u2);
        				System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui oltre al nome della classe impostiamo anche il primo user, User 2: '+u2.email);
        				for(user u3 : tuttiGliUtentiSuperiori){
        					tl.desc__c=tl.desc__c+', user 3: '+u3.email;
    						System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui oltre al nome della classe impostiamo anche la descrizione del templog per il terzo user');
        					if(u2.userrole.parentroleId==u3.userroleId){
        						wr.ruoliSuperioriECityM.add(u3);
        						System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui oltre al nome della classe impostiamo anche il primo user, User 3: '+u3.email);
        						System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui aggiungiamo anche il terzo user al wr.ruoliSuperioriECityM');
        					}
        				}
        			}
        			
        		} 
        	}
        	insert tL;
        	System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui inseriamo davvero il templog');
        	
        	for(wrapperEmail w : allWrappers){
        		if(w.ruoliSup==true){
        			System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui siamo nell\'if del wrapperEmail w.ruoliSup=true');
        			for(user U : w.ruoliSuperioriECityM){
        				Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
        				//Messaging.SingleEmailMessage singleMail=Messaging.renderStoredEmailTemplate(templateId, whoId, whatId);
		                //set email object
        				singleMail.setSubject('Inserimento Pratica Evento');
                        //set object Id
		                singleMail.setTargetObjectId(u.Id);
		                //singleMail.setTargetObjectId(u.Id);
		                //set template Id
		                singleMail.setTemplateId(w.et.Id);
		                //flag to false to stop inserting activity history
		                singleMail.setSaveAsActivity(false);
		                //add mail 
		                emails.add(singleMail);
		                System.debug('@@@@@@@ siamo nel public static void inviaMail Method qui siamo nell\'if del wrapperEmail w.ruoliSup=true e aggiungiamo le email');
        				System.debug('@@@@@stiamo inviando una email a ' + w.cityManagerEmail);
        			//	Messaging.sendEmail(emails);
        			//	System.debug('@@@@@@@ stiamo mandando l\'email a ' + u.mail);
        			}
        			Messaging.sendEmail(emails);
        		}
        	}
        }
     //query on template object
	/*
        if((ev.RecordType.Name.equals(eDa))||(ev.RecordType.Name.equals(eIss))){
                	et=[Select id from EmailTemplate where name=: emailTemplateDanni_InterferenzaLievi_Medi];
        }
        else if(ev.RecordType.Name.equals(eInf)){ 
            		et=[Select id from EmailTemplate where name=: emailTemplateInfortunio];
        } 
        else{
        			et=[Select id from EmailTemplate where name=: emailTemplateEventoInserito];
        }	
		  //list of emails
		  indMailTempl.put(emailList,et);
		//  idEvProEmailTemp.put(pMap2, indMailTempl);
      
   
        for(User u : userToSendMail){
                          //initiallize messaging method
                Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();

                //set object Id
                singleMail.setTargetObjectId(ev.Id);
                //singleMail.setTargetObjectId(u.Id);

                //set template Id
                singleMail.setTemplateId(et.Id);

                //flag to false to stop inserting activity history
               // singleMail.setSaveAsActivity(false);

                //add mail
                emails.add(singleMail);
            }
        
            //send mail
        Messaging.sendEmail(emails);
		
      */
	}
    // To get all Parent Roles.
    public static List<User> getAboveUsers(Set<ID> roleIds) {
    	
    	
        // get all of the parent roles.
        System.debug('@@@@@@@ entriamo nel public Static List<User> getAboveUsers Method' );
        Set<Id> currentRoleIds = new Set<Id>();
        List<User> listUserID = new List<User>();
        for(UserRole ur :[select Id, ParentRoleId from UserRole where Id IN: roleIds]) {
            currentRoleIds.add(ur.ParentRoleId);
            System.debug('questi sono l\'id del ruolo che sto ciclando' + ur.id + ', questo il parentRoleID ' + ur.ParentRoleId );
            
           
        }
        Map<Id,String> emailRuoliSup = new Map<Id,String>();
        // go fetch some more rolls!
        if(currentRoleIds.size() > 0) { 
  //      	for(integer i=0; i<=currentRoleId.size();i++){
        	listUserID=[select Id,userroleId,userrole.ParentRoleId, email from user where UserRoleId IN: currentRoleIds];
        	//	listUserID.add([select Id,userroleId,userrole.ParentRoleId, email from user where UserRoleId IN: currentRoleIds]);	
        		
//        	}
        	for(User u :listUserID) {
	            currentRoleIds.add(u.userrole.ParentRoleId);
	            
	            TEMPLOG__c tL = new TEMPLOG__c();
	            tL.class__c ='CQS_Utils__c';
            	System.debug('@@@@@@@ Owner: ' +tL.Owner + ' Classe: ' + tL.class__c + ' CPU_TIME: ' + tl.OF_CPU_Time__c );
	        	insert tL;
	        	emailRuoliSup.put(u.id,u.email);
	        } 
        }
        return listUserID;
    }
	

/*
   public static void inviaMailAfter(List<Id> evIdList,Map<Id,Id> mapEvProg,Set<Id> setProgetti){
        // public static List<User> inviaMailAfter(List<User> Users)
    
    //query on template object
        EmailTemplate et=[Select id from EmailTemplate where name=: nomiEmailTemplate];

        //list of emails
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();   
        
         for(User u : userToSendMail)
        {
          //check for Account
           // if((u.Email != null)||(cityManager.email!= null)){

                //initiallize messaging method
                Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();

                //set object Id
                singleMail.setTargetObjectId(u.Id);

                //set template Id
                singleMail.setTemplateId(et.Id);

                //flag to false to stop inserting activity history
               // singleMail.setSaveAsActivity(false);

                //add mail
                emails.add(singleMail);
            }
         //send mail
        Messaging.sendEmail(emails); 
        } 
     */      
     //EC start metodo asincrono per ApexSharingRule di Risorse Impiegate 2018 - 10 - 18 
 @future
    public static void setApexSharingRisImp(Map<Id,Id> mapRisImpProg,Set<Id> setProgetti){
    	system.debug('@@@@@@@@@EC è stato chiamato il metodo setApexSharingRisImp');
         CQS_Utils.updateTrigger=false;
                Map<Id, list<Id>> pMap = new Map<Id, list<Id>>();
            		
				for(CQS_Progetto__c pro: [select Id, (select CQS_junc_user__c, CQS_junc_user__r.IsActive from Progetto_Utente_junctions__r)
                                      from CQS_Progetto__c where ID in:setProgetti]){  
                                          List<Id> newList = new List<Id>();
                                          for(Progetto_Utente_junction__c u : pro.Progetto_Utente_junctions__r){
                                             if(u.CQS_junc_user__r.IsActive==true){ 
                                              newList.add(u.CQS_junc_user__c);
                                             }
                                          }
     					pmap.put(pro.Id,newList);                                         
                }   
           List<OF_CQS_Risorse_Impiegate__Share> risImpShares = new List<OF_CQS_Risorse_Impiegate__Share>();
            for(id idRisImp : mapRisImpProg.keySet()){
                for(id idUser : pmap.get(mapRisImpProg.get(idRisImp))){
                    OF_CQS_Risorse_Impiegate__Share risImpRecord = new OF_CQS_Risorse_Impiegate__Share();
                    risImpRecord.ParentId = idRisImp;
                    risImpRecord.UserOrGroupId = idUser;
                    risImpRecord.AccessLevel = 'read';
                	risImpRecord.RowCause = Schema.OF_CQS_Risorse_Impiegate__Share.RowCause.Progetto_di_competenza__c;
                	//risImpRecord.RowCause = Schema.OF_CQS_Risorse_Impiegate__Share.RowCause.TerritoryRule;
					risImpShares.add(risImpRecord);
                    System.debug('Gli user che hanno accesso a questo record sono: ' + risImpRecord.UserOrGroupId);
                }
            }                              
				
		 Database.SaveResult[] risImpShareInsertResult = Database.insert(risImpShares,false);
	/*	 
		  for (Database.SaveResult sr : risImpShareInsertResult) {
	    if (sr.isSuccess()) {
	        // Operation was successful, so get the ID of the record that was processed
	        System.debug('Successfully shared ispezioni. Ispezione ID: ' + sr.getId());
	    }
	    else {
	        // Operation failed, so get all errors               
	        for(Database.Error err : sr.getErrors()) {
	            System.debug('The following error has occurred.');                   
	            System.debug(err.getStatusCode() + ': ' + err.getMessage());
	            System.debug('Ispezione fields that affected this error: ' + err.getFields());
				System.debug('Ispezione fields that affected this error: ' + err.fields);	            
	        }
	    }
		  }
        */
		}
     
     //EC end metodo asincrono per ApexSharingRule di Risorse Impiegate 2018 - 10 - 18
     
     
	//metodo asincrono per ApexSharingRule di Eventi 
    @future
    public static void setApexSharingEventi(Map<Id,Id> mapEvProg,Set<Id> setProgetti){
         CQS_Utils.updateTrigger=false;
                Map<Id, list<Id>> pMap = new Map<Id, list<Id>>();
            		
				for(CQS_Progetto__c pro: [select Id, (select CQS_junc_user__c, CQS_junc_user__r.IsActive from Progetto_Utente_junctions__r)
                                      from CQS_Progetto__c where ID in:setProgetti]){  
                                          List<Id> newList = new List<Id>();
                                          for(Progetto_Utente_junction__c u : pro.Progetto_Utente_junctions__r){
                                             if(u.CQS_junc_user__r.IsActive==true){ 
                                              newList.add(u.CQS_junc_user__c);
                                             }
                                          }
     					pmap.put(pro.Id,newList);                                         
                }   
           List<OF_CQS_Evento__Share> evShares = new List<OF_CQS_Evento__Share>();
            for(id idEv : mapEvProg.keySet()){
                for(id idUser : pmap.get(mapEvProg.get(idEv))){
                    OF_CQS_Evento__Share evRecord = new OF_CQS_Evento__Share();
                    evRecord.ParentId = idEv;
                    evRecord.UserOrGroupId = idUser;
                    evRecord.AccessLevel = 'read';
                	evRecord.RowCause = Schema.OF_CQS_Evento__Share.RowCause.Progetto_di_competenza__c;
                	//evRecord.RowCause = Schema.OF_CQS_Evento__Share.RowCause.TerritoryRule;
					evShares.add(evRecord);
                    System.debug('Gli user che hanno accesso a questo record sono: ' + evRecord.UserOrGroupId);
                }
            }                              
				
		 Database.SaveResult[] evShareInsertResult = Database.insert(evShares,false);
	/*	 
		  for (Database.SaveResult sr : evShareInsertResult) {
	    if (sr.isSuccess()) {
	        // Operation was successful, so get the ID of the record that was processed
	        System.debug('Successfully shared ispezioni. Ispezione ID: ' + sr.getId());
	    }
	    else {
	        // Operation failed, so get all errors               
	        for(Database.Error err : sr.getErrors()) {
	            System.debug('The following error has occurred.');                   
	            System.debug(err.getStatusCode() + ': ' + err.getMessage());
	            System.debug('Ispezione fields that affected this error: ' + err.getFields());
				System.debug('Ispezione fields that affected this error: ' + err.fields);	            
	        }
	    }
		  }
        */
		}
            
     //per Ispezioni Metodi calcolaPunteggio(); e ApexSharingRule per il settaggio della visibilità;
	
	@future
    //metodo asincrono per ApexSharingRule di ispezioni
    public static void setApexSharing(Map<Id,Id> mapIspProg,Set<Id> setProgetti){
         CQS_Utils.updateTrigger=false;
                Map<Id, list<Id>> pMap = new Map<Id, list<Id>>();
            		
				for(CQS_Progetto__c pro: [select Id, (select CQS_junc_user__c, CQS_junc_user__r.IsActive from Progetto_Utente_junctions__r)
                                      from CQS_Progetto__c where ID in:setProgetti]){  
                                          List<Id> newList = new List<Id>();
                                          for(Progetto_Utente_junction__c u : pro.Progetto_Utente_junctions__r){
                                             if(u.CQS_junc_user__r.isActive==true){ 
                                              newList.add(u.CQS_junc_user__c);
                                             }
                                          }
     					pmap.put(pro.Id,newList);                                         
                }   
           List<OF_CQS_Ispezione__Share> ispShares = new List<OF_CQS_Ispezione__Share>();
            for(id idIsp : mapIspProg.keySet()){
                for(id idUser : pmap.get(mapIspProg.get(idIsp))){
                    OF_CQS_Ispezione__Share ispRecord = new OF_CQS_Ispezione__Share();
                    ispRecord.ParentId = idIsp;
                    ispRecord.UserOrGroupId = idUser;
                    ispRecord.AccessLevel = 'read';
                	ispRecord.RowCause = Schema.OF_CQS_Ispezione__Share.RowCause.Progetto_di_competenza__c;
                	//ispRecord.RowCause = Schema.OF_CQS_Ispezione__Share.RowCause.TerritoryRule;
					ispShares.add(ispRecord);
                    System.debug('Gli user che hanno accesso a questo record sono: ' + ispRecord.UserOrGroupId);
                }
            }                              
				
		 Database.SaveResult[] ispShareInsertResult = Database.insert(ispShares,false); 
        /*
        for (Database.SaveResult sr : ispShareInsertResult) {
	    if (sr.isSuccess()) {
	        // Operation was successful, so get the ID of the record that was processed
	        System.debug('Successfully shared ispezioni. Ispezione ID: ' + sr.getId());
	    }
	    else {
	        // Operation failed, so get all errors               
	        for(Database.Error err : sr.getErrors()) {
	            System.debug('The following error has occurred.');                   
	            System.debug(err.getStatusCode() + ': ' + err.getMessage());
	            System.debug('Ispezione fields that affected this error: ' + err.getFields());
				System.debug('Ispezione fields that affected this error: ' + err.fields);	            
	        }
	    }
        }
        */
    }
    
      public static void calcolaPunteggio(OF_CQS_Ispezione__c isp){
      	system.debug('siamo nella classe CQS_Utils. Chiamiamo il metodo calcolaPunteggio, il recrdType dell\'ispezione di Sicurezza RT precedente. Il recordtype passato è: ' + isp.recordType + '  @@@@ispe è: ' + isp);
      	system.debug('@@@@@@@@@@@ isp RT completa è: ' + isp.RecordTypeId);
      	List<recordType> rtList = [select DeveloperName from recordType where SobjectType='OF_CQS_Ispezione__c' and id=: isp.RecordTypeId];
          String sRt = rtList.get(0).DeveloperName;
          System.debug('string s è: ' + sRt);
      	if(updateTrigger=true){ 
      	 if(sRt=='Ispezione_Sicurezza_2018_06'){
      	 	system.debug('nella classe CQS Utils. siamo nell\'if che chiama il metodo calcola punteggio2');
           	CQS_Utils.calcolaPunteggio2(isp);
           	}
            //EC start 20190102
            else  if(sRt=='CQS_Isp_Ispezione_Tema_Ambientale'){
			system.debug('nella classe CQS Utils. siamo nell\'if che chiama il metodo calcolaPunteggioIspTamb');
          	CQS_Utils.calcolaPunteggioIspTamb(isp);	
          }
            //EC end 20190102
         else  if((sRt=='CQS_Ispezioni_Qualita') || (sRt=='CQS_IspQv2')){
			system.debug('nella classe CQS Utils. siamo nell\'if che chiama il metodo calcola punteggio3');
          	CQS_Utils.calcolaPunteggio3(isp);	
          }
      	  else {
	      		   	
	    	//non devo instanziare Isp perché la passa Il trigger
	    	//EC Variato il valore del peso della domanda - Doc mail 2018 - 05 - 04 thread "ampliamento test" da 2 a 3
	         if(isp.CQS_ISP_PSC__c.equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_ISP_PSC__c.equals(n)) {
				x+=0;
				y+=2;
				} else IF(isp.CQS_ISP_PSC__c.equals(na)){
				x+=0;
				y+=0;
				}
				//End Variazione EC
	      //   	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			IF(isp.CQS_ISP_POS__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_POS__c.equals(n)){
				x+=0;
				y+=2;
			 } else IF(isp.CQS_ISP_POS__c.equals(na)){
				x+=0;
				y+=0;
			 }
	     //    system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y); 
	       //EC Variato il valore del peso della domanda - Doc mail 2018 - 05 - 04 thread "ampliamento test" da 3 a 2
			 IF(isp.CQS_ISP_Notifica_prel_corretta_valida__c.equals(s)){
				x+=3;
				y+=3;
				} else IF(isp.CQS_ISP_Notifica_prel_corretta_valida__c.equals(n)) {
				x+=0;
				y+=3;
			  } else IF(isp.CQS_ISP_Notifica_prel_corretta_valida__c.equals(na)){
				x+=0;
				y+=0;
			  }
	       //End Variazione EC           
		//	  	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			  
			IF(isp.CQS_ISP_DURC_regolare__c.equals(s)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_ISP_DURC_regolare__c.equals(n)){
				x+=0;
			 	y+=3;
			 } else IF(isp.CQS_ISP_DURC_regolare__c.equals(na)){
				x+=0;
				y+=0;
			 }
	         
	    //     system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			 
			IF(isp.CQS_ISP_Attivita_Imprese_autorizzate_OF__c.equals(s)){
				x+=1;
				y+=1;
			
			 } else IF(isp.CQS_ISP_Attivita_Imprese_autorizzate_OF__c.equals(n)){
				x+=0; 
				y+=1;
			 } else IF(isp.CQS_ISP_Attivita_Imprese_autorizzate_OF__c.equals(na)){
				 x+=0;
				 y+=0;
			} 
	         
	    //     system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Autorizzazione_amm_competente__c.equals(s)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_ISP_Autorizzazione_amm_competente__c.equals(n)){
				 x+=0; 
				 y+=3;
			 }else IF(isp.CQS_ISP_Autorizzazione_amm_competente__c.equals(na)){
				 x+=0; 
				 y+=0;
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Presenza_prog_cartografie_enti__c.equals(s)){
				x+=3;
				y+=3;	
			 } else IF(isp.CQS_ISP_Presenza_prog_cartografie_enti__c.equals(n)){
				x+=0; 
				y+=3;	
			 } else IF(isp.CQS_ISP_Presenza_prog_cartografie_enti__c.equals(na)){
				x+=0; 
				y+=0;
			}
	                  
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_indagini_preventive_scavo__c.equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_ISP_indagini_preventive_scavo__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_ISP_indagini_preventive_scavo__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	   //      system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Accantieramento_conforme__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_Accantieramento_conforme__c.equals(n)){
				x+=0; 
				y+=2;
			 }else IF(isp.CQS_ISP_Accantieramento_conforme__c.equals(na)){
			 	x+=0; 
				y+=0;
			 }
	         
	//		 	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				
			 
			IF(isp.CQS_ISP_Esposizione_Cartello__c.equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_ISP_Esposizione_Cartello__c.equals(n)) {
				x+=0; 
				y+=2;	
			 }else IF(isp.CQS_ISP_Esposizione_Cartello__c.equals(na)) {
				x+=0; 
				y+=0;	
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_RispettoCodice_SegnaleticaStrada__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_RispettoCodice_SegnaleticaStrada__c.equals(n)) {
				x+=0;
				y+=2;
			}else IF(isp.CQS_ISP_RispettoCodice_SegnaleticaStrada__c.equals(na)) {
				x+=0;
				y+=0;
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				
			
			IF(isp.CQS_ISP_Idoneit_delimit_Cantiere_AD__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_Idoneit_delimit_Cantiere_AD__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_ISP_Idoneit_delimit_Cantiere_AD__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				
			
			IF(isp.CQS_ISP_Buono_stato_cartellonistica__c.equals(s)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_ISP_Buono_stato_cartellonistica__c.equals(n)){
				x+=0; 
				y+=1;
			 } else IF(isp.CQS_ISP_Buono_stato_cartellonistica__c.equals(na)){
				x+=0; 
				y+=0; 
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_assicurata_viabilita__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_assicurata_viabilita__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_ISP_assicurata_viabilita__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				
			
			IF(isp.CQS_ISP_Passaggi_su_scavi_idonei__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_Passaggi_su_scavi_idonei__c.equals(n)){
				x+=0;
				y+=2; 
			}else IF(isp.CQS_ISP_Passaggi_su_scavi_idonei__c.equals(na)){
				x+=0;
				y+=0; 
			}
	         
	//			system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Pozzetti_non_pericolosi__c.equals(s)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_ISP_Pozzetti_non_pericolosi__c.equals(n)){
				x+=0;
				y+=3;	
			} else IF(isp.CQS_ISP_Pozzetti_non_pericolosi__c.equals(na)){
				x+=0;
				y+=0;	
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_Presenza_WC__c.equals(s)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_ISP_Presenza_WC__c.equals(n)){
				x+=0; 
				y+=1;
			 }else IF(isp.CQS_ISP_Presenza_WC__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_Presenti_autorizzati__c .equals(s)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_ISP_Presenti_autorizzati__c .equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_ISP_Presenti_autorizzati__c .equals(na)){
				x+=0; 
			 	y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Tesserino_Check__c.equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_ISP_Tesserino_Check__c.equals(s)){
				x+=0; 
			 	y+=2;
			} else IF(isp.CQS_ISP_Tesserino_Check__c.equals(s)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Preposto_Cantiere_Presente__c.equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_ISP_Preposto_Cantiere_Presente__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_ISP_Preposto_Cantiere_Presente__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Addetto_PS_presente__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_Addetto_PS_presente__c.equals(n)){
				x+=0; 
				y+=2;
			} else IF(isp.CQS_ISP_Addetto_PS_presente__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Addetto_Antincendio_presente__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_Addetto_Antincendio_presente__c.equals(n)){
				x+=0;
				y+=2;		
			} else IF(isp.CQS_ISP_Addetto_Antincendio_presente__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_DPI_idonei_in_dotazione__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_DPI_idonei_in_dotazione__c.equals(n)){
				x+=0; 
				y+=2;
			} else IF(isp.CQS_ISP_DPI_idonei_in_dotazione__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
	//		 system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_DPI_lavorazioni_in_quota__c.equals(s)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_ISP_DPI_lavorazioni_in_quota__c.equals(n)){
				x+=0; 
				y+=3;
			 } else IF(isp.CQS_ISP_DPI_lavorazioni_in_quota__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_DPI_rischio_elettrico__c.equals(s)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_ISP_DPI_rischio_elettrico__c.equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_ISP_DPI_rischio_elettrico__c.equals(na)){
				x+=0; 
				y+=0;	
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.Presenza_Moviere_qualora_necessario__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.Presenza_Moviere_qualora_necessario__c.equals(n)){
				x+=0;
				y+=2;
			} else IF(isp.Presenza_Moviere_qualora_necessario__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.Personale_dotato_di_quanto_richiesto__c.equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.Personale_dotato_di_quanto_richiesto__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.Personale_dotato_di_quanto_richiesto__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_Mezzi_Attrezzature_autorizati__c .equals(s)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_ISP_Mezzi_Attrezzature_autorizati__c .equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_ISP_Mezzi_Attrezzature_autorizati__c .equals(na)){
				x+=0;
				y+=0; 
			}
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_conformita_mezzi_attrezzature__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_conformita_mezzi_attrezzature__c.equals(n)){
				x+=0;
				y+=2; 
			} else IF(isp.CQS_ISP_conformita_mezzi_attrezzature__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_Documentazione_verifiche_legge__c.equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_ISP_Documentazione_verifiche_legge__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_ISP_Documentazione_verifiche_legge__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_Marcatura_CE__c.equals(s)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_ISP_Marcatura_CE__c.equals(n)){
				x+=0;
				y+=1;	
			} else IF(isp.CQS_ISP_Marcatura_CE__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_Documentazione_noli_a_freddo__c.equals(s)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_ISP_Documentazione_noli_a_freddo__c.equals(n)){
				x+=0; 
			 	y+=1;
			} else IF(isp.CQS_ISP_Documentazione_noli_a_freddo__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_attrezzature_sollevamento__c.equals(s)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_ISP_attrezzature_sollevamento__c.equals(n)){
				x+=0;
				y+=3;
			}
			 else IF(isp.CQS_ISP_attrezzature_sollevamento__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.Cassetta_primo_soccorso_conforme__c .equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.Cassetta_primo_soccorso_conforme__c .equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.Cassetta_primo_soccorso_conforme__c .equals(na)){
				x+=0; 
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_Estintore_con_cartellino_e_revisione__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_Estintore_con_cartellino_e_revisione__c.equals(n)){
				x+=0; 
				y+=2;
			 }
			 else IF(isp.CQS_Estintore_con_cartellino_e_revisione__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			 
			IF(isp.Autorizzazioni_ENEL_prossimit_E_Distrib__c .equals(s)){
				x+=1;
				y+=1;
			} else IF(isp.Autorizzazioni_ENEL_prossimit_E_Distrib__c .equals(n)){
				 x+=0;
				 y+=1; 
			} else IF(isp.Autorizzazioni_ENEL_prossimit_E_Distrib__c .equals(na)){
				 x+=0;
				 y+=0; 
			}
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Presenza_Profili_E_Distrib__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_Presenza_Profili_E_Distrib__c.equals(n)){
				x+=0; 
				y+=2;
			} else IF(isp.CQS_ISP_Presenza_Profili_E_Distrib__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
	  //           system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c.equals(s)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c.equals(n)){
				x+=0;
				y+=3;	
			} else IF(isp.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c.equals(na)){
				x+=0;
				y+=0;	
			}
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				    
			try{            
	        	isp.CQS_ISP_Punteggio_Totale__c = x;
				isp.CQS_Punteggio_Tot_Max_Isp__c= y;
	            isp.CQS_ISP_Perc_Tot_Punt__c= (isp.CQS_ISP_Punteggio_Totale__c/isp.CQS_Punteggio_Tot_Max_Isp__c)*100; 
	            }
	            catch(Exception e){
	                isp.CQS_ISP_Punteggio_Totale__c = x;
					isp.CQS_Punteggio_Tot_Max_Isp__c= y;
			        isp.CQS_ISP_Perc_Tot_Punt__c=0;
	            }
	          
			// isp.CQS_ISP_Perc_Tot_Punt__c= x.divide(y, 2)*100;         
	        // isp.CQS_ISP_Punteggio_Totale__c = x.divide(1, 2);
			// isp.CQS_Punteggio_Tot_Max_Isp__c=y.divide(1, 2);
	
			//return isp;
			 system.debug('il totale infine è: ' + isp.CQS_ISP_Punteggio_Totale__c + ', mentre il totale massimo è ' + isp.CQS_Punteggio_Tot_Max_Isp__c +' Per cui il rapporto in percentuale è ' +  isp.CQS_ISP_Perc_Tot_Punt__c);
	         }
	      }
      }	 
		 
		 public class wrapperEmail{
			public List<User> ruoliSuperioriECityM;
			public boolean ruoliSup;
			public emailTemplate et;
			public CQS_Progetto__c prog;
			public OF_CQS_Evento__c ev;
			public user cityManager; 
			public Id cityManagerId;
			public String cityManagerEmail;
			public set<Id> allUsersId;
			//id userCM, String indirizzo email superiori
			public Map<Id,String> emailRuoliSup;
		}
		
		//EC Metodo calcolapunteggio2() per Ispezione di Sicurezza campi nuovi ed eliminati
		
		 public static void calcolaPunteggio2(OF_CQS_Ispezione__c isp){
		 	system.debug('siamo nella classe CQS_Utils. Chiamiamo il metodo calcolaPunteggio2, il recrdType dell\'ispezione di Sicurezza RT nuovo');
	      	If(updateTrigger=true){    	
	    	//non devo instanziare Isp perché la passa Il trigger
	    	//EC Variato il valore del peso della domanda - Doc mail 2018 - 05 - 04 thread "ampliamento test" da 2 a 3
	          IF(isp.CQS_ISP_PSC__c.equals(s)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_ISP_PSC__c.equals(n)) {
				x+=0;
				y+=3;
				} else IF(isp.CQS_ISP_PSC__c.equals(na)){
				x+=0;
				y+=0;
				}
				//End Variazione EC
	      //   	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			IF(isp.CQS_ISP_POS__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_POS__c.equals(n)){
				x+=0;
				y+=2;
			 } else IF(isp.CQS_ISP_POS__c.equals(na)){
				x+=0;
				y+=0;
			 }
	     //    system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y); 
	       //EC Variato il valore del peso della domanda - Doc mail 2018 - 05 - 04 thread "ampliamento test" da 3 a 2
			 IF(isp.CQS_ISP_Notifica_prel_corretta_valida__c.equals(s)){
				x+=2;
				y+=2;
				} else IF(isp.CQS_ISP_Notifica_prel_corretta_valida__c.equals(n)) {
				x+=0;
				y+=2;
			  } else IF(isp.CQS_ISP_Notifica_prel_corretta_valida__c.equals(na)){
				x+=0;
				y+=0;
			  }
	       //End Variazione EC           
		//	  	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			  //EC  Campo DURC sostituito con CQS_IspS_Presenza_riferimenti_emergenza__c nuovo punteggio 1 invece di 3
			IF(isp.CQS_IspS_Presenza_riferimenti_emergenza__c.equals(s1)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_IspS_Presenza_riferimenti_emergenza__c.equals(n)){
				x+=0;
			 	y+=1;
			 } else IF(isp.CQS_IspS_Presenza_riferimenti_emergenza__c.equals(na)){
				x+=0;
				y+=0;
			 }
	         
	    //     system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			 //EC campo CQS_ISP_Attivita_Imprese_autorizzate_OF__c sostituito con CQS_IspS_Subappalto_autorizzato_OF__c punteggio  3 invece di 1
			IF(isp.CQS_IspS_Subappalto_autorizzato_OF__c.equals(s1)){
				x+=3;
				y+=3;
			
			 } else IF(isp.CQS_IspS_Subappalto_autorizzato_OF__c.equals(n)){
				x+=0; 
				y+=3;
			 } else IF(isp.CQS_IspS_Subappalto_autorizzato_OF__c.equals(na)){
				 x+=0;
				 y+=0;
			} 
	         
	    //     system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Autorizzazione_amm_competente__c.equals(s)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_ISP_Autorizzazione_amm_competente__c.equals(n)){
				 x+=0; 
				 y+=3;
			 }else IF(isp.CQS_ISP_Autorizzazione_amm_competente__c.equals(na)){
				 x+=0; 
				 y+=0;
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			//EC Sostituzione Campo CQS_ISP_Presenza_prog_cartografie_enti__c con CQS_IspS_Presenza_cartografie_enti__c il nuovo valore 2 invece di 3
			IF(isp.CQS_IspS_Presenza_cartografie_enti__c.equals(s1)){
				x+=2;
				y+=2;	
			 } else IF(isp.CQS_IspS_Presenza_cartografie_enti__c.equals(n)){
				x+=0; 
				y+=2;	
			 } else IF(isp.CQS_IspS_Presenza_cartografie_enti__c.equals(na)){
				x+=0; 
				y+=0;
			}
	                  
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_indagini_preventive_scavo__c.equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_ISP_indagini_preventive_scavo__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_ISP_indagini_preventive_scavo__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	   //      system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			//EC Sostituzione campo CQS_ISP_Accantieramento_conforme__c con CQS_IspS_Accantieramento_conforme_a_PSC__c punteggio resta invariato (2)
			IF(isp.CQS_IspS_Accantieramento_conforme_a_PSC__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspS_Accantieramento_conforme_a_PSC__c.equals(n)){
				x+=0; 
				y+=2;
			 }else IF(isp.CQS_IspS_Accantieramento_conforme_a_PSC__c.equals(na)){
			 	x+=0; 
				y+=0;
			 }
	         
	//		 	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				
			 
			IF(isp.CQS_ISP_Esposizione_Cartello__c.equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_ISP_Esposizione_Cartello__c.equals(n)) {
				x+=0; 
				y+=2;	
			 }else IF(isp.CQS_ISP_Esposizione_Cartello__c.equals(na)) {
				x+=0; 
				y+=0;	
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
		//EC sostituzione campo CQS_ISP_RispettoCodice_SegnaleticaStrada__c con CQS_IspS_Segnaletica_stradale_suff__c valore invariato(2)	
			IF(isp.CQS_IspS_Segnaletica_stradale_suff__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspS_Segnaletica_stradale_suff__c.equals(n)) {
				x+=0;
				y+=2;
			}else IF(isp.CQS_IspS_Segnaletica_stradale_suff__c.equals(na)) {
				x+=0;
				y+=0;
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				
			
			IF(isp.CQS_ISP_Idoneit_delimit_Cantiere_AD__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_Idoneit_delimit_Cantiere_AD__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_ISP_Idoneit_delimit_Cantiere_AD__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				
			
			IF(isp.CQS_ISP_Buono_stato_cartellonistica__c.equals(s)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_ISP_Buono_stato_cartellonistica__c.equals(n)){
				x+=0; 
				y+=1;
			 } else IF(isp.CQS_ISP_Buono_stato_cartellonistica__c.equals(na)){
				x+=0; 
				y+=0; 
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			//EC modifica campo CQS_ISP_assicurata_viabilita__c con CQS_IspS_Viabilit_come_ordinanza__c valore invariato (2)
			IF(isp.CQS_IspS_Viabilit_come_ordinanza__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspS_Viabilit_come_ordinanza__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspS_Viabilit_come_ordinanza__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				
	//EC Sostituzione campo CQS_ISP_Passaggi_su_scavi_idonei__c con CQS_IspS_Protezione_scavi_in_minitrincea__c valore invariato (2)
			IF(isp.CQS_IspS_Protezione_scavi_in_minitrincea__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspS_Protezione_scavi_in_minitrincea__c.equals(n)){
				x+=0;
				y+=2; 
			}else IF(isp.CQS_IspS_Protezione_scavi_in_minitrincea__c.equals(na)){
				x+=0;
				y+=0; 
			}
	         
	//			system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
	//EC Sostituzione campo CQS_ISP_Pozzetti_non_pericolosi__c 	con CQS_IspS_Protezione_scavi_trad_pozzetti__c	valore invariato (3)
			IF(isp.CQS_IspS_Protezione_scavi_trad_pozzetti__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspS_Protezione_scavi_trad_pozzetti__c.equals(n)){
				x+=0;
				y+=3;	
			} else IF(isp.CQS_IspS_Protezione_scavi_trad_pozzetti__c.equals(na)){
				x+=0;
				y+=0;	
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
		//EC Sostituzione campo CQS_ISP_Presenza_WC__c con CQS_IspS_Utilizzo_DPC_rischi_particolari__c valore 2 invece di 1	
			IF(isp.CQS_IspS_Utilizzo_DPC_rischi_particolari__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspS_Utilizzo_DPC_rischi_particolari__c.equals(n)){
				x+=0; 
				y+=2;
			 }else IF(isp.CQS_IspS_Utilizzo_DPC_rischi_particolari__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
	//EC inizio Sezione Personale di cantiere		
			
			IF(isp.CQS_ISP_Presenti_autorizzati__c .equals(s)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_ISP_Presenti_autorizzati__c .equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_ISP_Presenti_autorizzati__c .equals(na)){
				x+=0; 
			 	y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
		//EC variazione del solo valore della risposta  (1 invece di 2)	
			IF(isp.CQS_ISP_Tesserino_Check__c.equals(s)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_ISP_Tesserino_Check__c.equals(s)){
				x+=0; 
			 	y+=1;
			} else IF(isp.CQS_ISP_Tesserino_Check__c.equals(s)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Preposto_Cantiere_Presente__c.equals(s)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_ISP_Preposto_Cantiere_Presente__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_ISP_Preposto_Cantiere_Presente__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
	//EC Sostituzione campo CQS_ISP_Addetto_PS_presente__c con CQS_IspS_Addetto_primo_soccorso_presente__c valore invariato (2)		
			IF(isp.CQS_IspS_Addetto_primo_soccorso_presente__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspS_Addetto_primo_soccorso_presente__c.equals(n)){
				x+=0; 
				y+=2;
			} else IF(isp.CQS_IspS_Addetto_primo_soccorso_presente__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_Addetto_Antincendio_presente__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_Addetto_Antincendio_presente__c.equals(n)){
				x+=0;
				y+=2;		
			} else IF(isp.CQS_ISP_Addetto_Antincendio_presente__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_ISP_DPI_idonei_in_dotazione__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_ISP_DPI_idonei_in_dotazione__c.equals(n)){
				x+=0; 
				y+=2;
			} else IF(isp.CQS_ISP_DPI_idonei_in_dotazione__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
	//		 system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
	//EC Sostituzione campo CQS_ISP_DPI_lavorazioni_in_quota__c con CQS_IspS_DPI_3_categoria_utilizzati_OK__c valore invariato (3)		
			IF(isp.CQS_IspS_DPI_3_categoria_utilizzati_OK__c.equals(s1)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_IspS_DPI_3_categoria_utilizzati_OK__c.equals(n)){
				x+=0; 
				y+=3;
			 } else IF(isp.CQS_IspS_DPI_3_categoria_utilizzati_OK__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
		/* EC Sostituzione con Presenza Personale E-Distribuzione se necessario.	
			IF(isp.CQS_ISP_DPI_rischio_elettrico__c.equals(s)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_ISP_DPI_rischio_elettrico__c.equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_ISP_DPI_rischio_elettrico__c.equals(na)){
				x+=0; 
				y+=0;	
			} */
			//EC inoltre modifica valore 1 invece di 2
			IF(isp.CQS_ISP_Presenza_Profili_E_Distrib__c.equals(s)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_ISP_Presenza_Profili_E_Distrib__c.equals(n)){
				x+=0; 
				y+=1;
			} else IF(isp.CQS_ISP_Presenza_Profili_E_Distrib__c.equals(na)){
				x+=0; 
				y+=0;
			 }	
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.Presenza_Moviere_qualora_necessario__c.equals(s)){
				x+=2;
				y+=2;
			} else IF(isp.Presenza_Moviere_qualora_necessario__c.equals(n)){
				x+=0;
				y+=2;
			} else IF(isp.Presenza_Moviere_qualora_necessario__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			//EC Sostituzione Campo Personale_dotato_di_quanto_richiesto__c con CQS_IspS_Formazione_HS_conforme_mansione__c Valore invariato (2)
			IF(isp.CQS_IspS_Formazione_HS_conforme_mansione__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspS_Formazione_HS_conforme_mansione__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspS_Formazione_HS_conforme_mansione__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
	//inizio sezione Mezzi e attrezzature:		
	
		//EC sostituzione campo CQS_ISP_Mezzi_Attrezzature_autorizati__c con CQS_IspS_Autorizzati_e_presenti_nel_POS__c valore immutato (3)		
			IF(isp.CQS_IspS_Autorizzati_e_presenti_nel_POS__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspS_Autorizzati_e_presenti_nel_POS__c.equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_IspS_Autorizzati_e_presenti_nel_POS__c.equals(na)){
				x+=0;
				y+=0; 
			}
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
		//EC sostituzione campo CQS_ISP_conformita_mezzi_attrezzature__c con CQS_IspS_Sono_in_buono_stato__c con variazione di valore 1 invece di 2	
			IF(isp.CQS_IspS_Sono_in_buono_stato__c.equals(s1)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_IspS_Sono_in_buono_stato__c.equals(n)){
				x+=0;
				y+=1; 
			} else IF(isp.CQS_IspS_Sono_in_buono_stato__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
		//EC Sostituzione campo CQS_ISP_Documentazione_verifiche_legge__c con CQS_IspS_Libretti_rev_mezzi_presenti__c valore invariato (2)	
			IF(isp.CQS_IspS_Libretti_rev_mezzi_presenti__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspS_Libretti_rev_mezzi_presenti__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspS_Libretti_rev_mezzi_presenti__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_Marcatura_CE__c.equals(s)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_ISP_Marcatura_CE__c.equals(n)){
				x+=0;
				y+=1;	
			} else IF(isp.CQS_ISP_Marcatura_CE__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_Documentazione_noli_a_freddo__c.equals(s)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_ISP_Documentazione_noli_a_freddo__c.equals(n)){
				x+=0; 
			 	y+=1;
			} else IF(isp.CQS_ISP_Documentazione_noli_a_freddo__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_ISP_attrezzature_sollevamento__c.equals(s)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_ISP_attrezzature_sollevamento__c.equals(n)){
				x+=0;
				y+=3;
			}
			 else IF(isp.CQS_ISP_attrezzature_sollevamento__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.Cassetta_primo_soccorso_conforme__c .equals(s)){
				x+=1;
				y+=1;
			 } else IF(isp.Cassetta_primo_soccorso_conforme__c .equals(n)){
				x+=0; 
				y+=1;
			 } else IF(isp.Cassetta_primo_soccorso_conforme__c .equals(na)){
				x+=0; 
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_Estintore_con_cartellino_e_revisione__c.equals(s)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_Estintore_con_cartellino_e_revisione__c.equals(n)){
				x+=0; 
				y+=1;
			 }
			 else IF(isp.CQS_Estintore_con_cartellino_e_revisione__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				    
			try{            
	        	isp.CQS_ISP_Punteggio_Totale__c = x;
				isp.CQS_Punteggio_Tot_Max_Isp__c= y;
	            isp.CQS_ISP_Perc_Tot_Punt__c= (isp.CQS_ISP_Punteggio_Totale__c/isp.CQS_Punteggio_Tot_Max_Isp__c)*100; 
	            }
	            catch(Exception e){
	                isp.CQS_ISP_Punteggio_Totale__c = x;
					isp.CQS_Punteggio_Tot_Max_Isp__c= y;
			        isp.CQS_ISP_Perc_Tot_Punt__c=0;
	            }
	          
			// isp.CQS_ISP_Perc_Tot_Punt__c= x.divide(y, 2)*100;         
	        // isp.CQS_ISP_Punteggio_Totale__c = x.divide(1, 2);
			// isp.CQS_Punteggio_Tot_Max_Isp__c=y.divide(1, 2);
	
			//return isp;
			 system.debug('il totale infine è: ' + isp.CQS_ISP_Punteggio_Totale__c + ', mentre il totale massimo è ' + isp.CQS_Punteggio_Tot_Max_Isp__c +' Per cui il rapporto in percentuale è ' +  isp.CQS_ISP_Perc_Tot_Punt__c);
	         }
	      }
	    
    //EC Metodo calcolapunteggio3() per Ispezione di Qualità
		
		 public static void calcolaPunteggio3(OF_CQS_Ispezione__c isp){
		 	      	system.debug('siamo nella classe CQS_Utils. Chiamiamo il metodo calcolaPunteggio3, il recrdType dell\'ispezione di Qualità');
	      	If(updateTrigger=true){    	
	    	//non devo instanziare Isp perché la passa Il trigger
	    	system.debug('nel metodo calcolaPunteggio3. il campo isp.CQS_IspQ_Presenza_planimetrie_entige__c è valorizzato a: ' + isp.CQS_IspQ_Presenza_planimetrie_entige__c); 
	          IF(isp.CQS_IspQ_Presenza_planimetrie_entige__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Presenza_planimetrie_entige__c.equals(n)) {
				x+=0;
				y+=2;
				} else IF(isp.CQS_IspQ_Presenza_planimetrie_entige__c.equals(na)){
				x+=0;
				y+=0;
				}
				//End Variazione EC
	         	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			IF(isp.CQS_IspQ_Presenza_planimetrie_georadar__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Presenza_planimetrie_georadar__c.equals(n)){
				x+=0;
				y+=2;
			 } else IF(isp.CQS_IspQ_Presenza_planimetrie_georadar__c.equals(na)){
				x+=0;
				y+=0;
			 }
	        system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y); 
	       //EC Variato il valore del peso della domanda - Doc mail 2018 - 05 - 04 thread "ampliamento test" da 3 a 2
			 IF(isp.CQS_IspQ_Presenza_Progetto_lancio_noDig__c.equals(s1)){
				x+=3;
				y+=3;
				} else IF(isp.CQS_IspQ_Presenza_Progetto_lancio_noDig__c.equals(n)) {
				x+=0;
				y+=3;
			  } else IF(isp.CQS_IspQ_Presenza_Progetto_lancio_noDig__c.equals(na)){
				x+=0;
				y+=0;
			  }
	       //End Variazione EC           
			  system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			  
			IF(isp.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c.equals(s1)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c.equals(n)){
				x+=0;
			 	y+=3;
			 } else IF(isp.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c.equals(na)){
				x+=0;
				y+=0;
			 }
	         
	    system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			 
			IF(isp.CQS_IspQ_Permessi_rilasciati_con_deroghe__c.equals(s1)){
				x+=3;
				y+=3;
			
			 } else IF(isp.CQS_IspQ_Permessi_rilasciati_con_deroghe__c.equals(n)){
				x+=0; 
				y+=3;
			 } else IF(isp.CQS_IspQ_Permessi_rilasciati_con_deroghe__c.equals(na)){
				 x+=0;
				 y+=0;
			} 
		
			IF(isp.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c.equals(s1)){
				x+=2;
				y+=2;	
			 } else IF(isp.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c.equals(n)){
				x+=0; 
				y+=2;	
			 } else IF(isp.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c.equals(na)){
				x+=0; 
				y+=0;
			}
	                  
		//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			        
	//		 	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			IF(isp.Evidenze_comunicazioni_propriet_cliente__c.equals(s1)){
				x+=1;
				y+=1;
			} else IF(isp.Evidenze_comunicazioni_propriet_cliente__c.equals(n)){
				x+=0; 
				y+=1;
			 }else IF(isp.Evidenze_comunicazioni_propriet_cliente__c.equals(na)){
			 	x+=0; 
				y+=0;
			 }
	            
	 //EC - SEZIONE ORGANIZZAZIONE DEL CANTIERE           
			 
			IF(isp.CQS_IspQ_Apposizione_cartelli_cantiereOK__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Apposizione_cartelli_cantiereOK__c.equals(n)) {
				x+=0; 
				y+=2;	
			 }else IF(isp.CQS_IspQ_Apposizione_cartelli_cantiereOK__c.equals(na)) {
				x+=0; 
				y+=0;	
			}
	         
	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_IspQ_AreaCantiere_del_stoc_materiali__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_AreaCantiere_del_stoc_materiali__c.equals(n)) {
				x+=0;
				y+=2;
			}else IF(isp.CQS_IspQ_AreaCantiere_del_stoc_materiali__c.equals(na)) {
				x+=0;
				y+=0;
			}
	         
		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				
			
			IF(isp.CQS_IspQ_Conformita_stoccaggio_materiali__c.equals(s1)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_IspQ_Conformita_stoccaggio_materiali__c.equals(n)){
				x+=0; 
				y+=1;
			 } else IF(isp.CQS_IspQ_Conformita_stoccaggio_materiali__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
			system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
                IF(isp.CQS_IspQ_Tracciato_conf_prog_aut__c.equals(s1)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_IspQ_Tracciato_conf_prog_aut__c.equals(n)){
				x+=0; 
				y+=3;
			 } else IF(isp.CQS_IspQ_Tracciato_conf_prog_aut__c.equals(na)){
				x+=0; 
				y+=0;
			}
				
		
			IF(isp.CQS_IspQ_Sottoservizi_segnalati_asfalto__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Sottoservizi_segnalati_asfalto__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Sottoservizi_segnalati_asfalto__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
			system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_DPI_previsti_indossati__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_DPI_previsti_indossati__c.equals(n)){
				x+=0;
				y+=3;	
			} else IF(isp.CQS_IspQ_DPI_previsti_indossati__c.equals(na)){
				x+=0;
				y+=0;	
			}
	         
		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
	// EC - SEZIONE - SCAVI// EC - SEZIONE - SCAVI// EC - SEZIONE - SCAVI
			
			IF(isp.CQS_IspQ_Scavo_netto_lineare__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Scavo_netto_lineare__c.equals(n)){
				x+=0; 
				y+=2;
			 }else IF(isp.CQS_IspQ_Scavo_netto_lineare__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_IspQ_Profondita_scavo_conforme__c .equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_Profondita_scavo_conforme__c .equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_IspQ_Profondita_scavo_conforme__c .equals(na)){
				x+=0; 
			 	y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_Larghezza_scavo_conforme__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Larghezza_scavo_conforme__c.equals(s1)){
				x+=0; 
			 	y+=2;
			} else IF(isp.CQS_IspQ_Larghezza_scavo_conforme__c.equals(s1)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_Fondo_scavo_pulito__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_Fondo_scavo_pulito__c.equals(n)){
				x+=0;
				y+=3;	
			} else IF(isp.CQS_IspQ_Fondo_scavo_pulito__c.equals(na)){
				x+=0;
				y+=0;
			}
	            
	        IF(isp.CQS_IspQ_segnalatore_30cm_piano_calp__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_segnalatore_30cm_piano_calp__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_segnalatore_30cm_piano_calp__c.equals(na)){
				x+=0;
				y+=0;
			}
	            
	        IF(isp.CQS_IspQ_Cambi_Bruschi_evitati__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_Cambi_Bruschi_evitati__c.equals(n)){
				x+=0;
				y+=3;	
			} else IF(isp.CQS_IspQ_Cambi_Bruschi_evitati__c.equals(na)){
				x+=0;
				y+=0;
			}
	
	//EC - SEZIONE INFRASTRUTTURE            
	         
	        IF(isp.CQS_IspQ_SupAppoggio_pozzetto_OK__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_SupAppoggio_pozzetto_OK__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_SupAppoggio_pozzetto_OK__c.equals(na)){
				x+=0;
				y+=0;
			}
	            
	        IF(isp.CQS_IspQ_Chiusino_compl_piano_calpestio__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_Chiusino_compl_piano_calpestio__c.equals(n)){
				x+=0;
				y+=3;	
			} else IF(isp.CQS_IspQ_Chiusino_compl_piano_calpestio__c.equals(na)){
				x+=0;
				y+=0;
			}
	        
	            
	        IF(isp.CQS_IspQ_Pozzetto_conf_sp_tecniche__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Pozzetto_conf_sp_tecniche__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_Pozzetto_conf_sp_tecniche__c.equals(na)){
				x+=0;
				y+=0;
			}
	        
	        IF(isp.CQS_IspQ_Chiusino_conf_sp_tecniche__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Chiusino_conf_sp_tecniche__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_Chiusino_conf_sp_tecniche__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	        IF(isp.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c.equals(na)){
				x+=0;
				y+=0;
			}
	   
	        IF(isp.CQS_IspQ_Corretta_fratturazione_pozzetto__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Corretta_fratturazione_pozzetto__c.equals(n)){
				x+=0; 
				y+=2;
			} else IF(isp.CQS_IspQ_Corretta_fratturazione_pozzetto__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	        IF(isp.CQS_IspQ_Rientro_monotubo_pozzetto_OK__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Rientro_monotubo_pozzetto_OK__c.equals(n)){
				x+=0; 
				y+=2;
			} else IF(isp.CQS_IspQ_Rientro_monotubo_pozzetto_OK__c.equals(na)){
				x+=0;
				y+=0;
			}    
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_Malta_sigilla_ingr_monotubi__c.equals(s1)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_IspQ_Malta_sigilla_ingr_monotubi__c.equals(n)){
				x+=0; 
				y+=1;
			} else IF(isp.CQS_IspQ_Malta_sigilla_ingr_monotubi__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_tubi_posati_conformi_NT__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_tubi_posati_conformi_NT__c.equals(n)){
				x+=0;
				y+=2;		
			} else IF(isp.CQS_IspQ_tubi_posati_conformi_NT__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_N_tubi_posati_conformi_progetto__c.equals(s1)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_IspQ_N_tubi_posati_conformi_progetto__c.equals(n)){
				x+=0; 
				y+=3;
			} else IF(isp.CQS_IspQ_N_tubi_posati_conformi_progetto__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
	//		 system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_Ingresso_al_building_posaOK__c.equals(s1)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_IspQ_Ingresso_al_building_posaOK__c.equals(n)){
				x+=0; 
				y+=1;
			 } else IF(isp.CQS_IspQ_Ingresso_al_building_posaOK__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_IspQ_Ingresso_building_esecuzione_OK__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Ingresso_building_esecuzione_OK__c.equals(n)){
				x+=0; 
			 	y+=2;
			} else IF(isp.CQS_IspQ_Ingresso_building_esecuzione_OK__c.equals(na)){
				x+=0; 
				y+=0;	
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			    
	//EC - Sezione RIPRISTINI PROVVISORI            
	            
	            
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c .equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c .equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c .equals(na)){
				x+=0;
				y+=0; 
			}
	            
	            
	        IF(isp.CQS_IspQ_Mat_riempimento_conforme_spec__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Mat_riempimento_conforme_spec__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Mat_riempimento_conforme_spec__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
	        IF(isp.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c.equals(s1)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c.equals(n)){
				x+=0; 
				y+=1;
			 } else IF(isp.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c.equals(na)){
				x+=0; 
				y+=0;
			}
	        
	        IF(isp.CQS_IspQ_Corretta_cilindr_rullo_compr__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Corretta_cilindr_rullo_compr__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Corretta_cilindr_rullo_compr__c.equals(na)){
				x+=0; 
				y+=0;
			}
	            
	        IF(isp.CQS_IspQ_Stendimento_idonea_graniglia__c.equals(s1)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_IspQ_Stendimento_idonea_graniglia__c.equals(n)){
				x+=0; 
				y+=1;
			 } else IF(isp.CQS_IspQ_Stendimento_idonea_graniglia__c.equals(na)){
				x+=0; 
				y+=0;
			}    
	            
	  //EC - SEZIONE GESTIONE RIFIUTI - LAVORI IN CORSO          
			
			IF(isp.CQS_IspQ_Mat_trasp_discarica_autorizz__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_Mat_trasp_discarica_autorizz__c.equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_IspQ_Mat_trasp_discarica_autorizz__c.equals(na)){
				x+=0;
				y+=0; 
			}
	            
	        IF(isp.CQS_IspQ_gestione_compilazione_FIR_OK__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_gestione_compilazione_FIR_OK__c.equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_IspQ_gestione_compilazione_FIR_OK__c.equals(na)){
				x+=0;
				y+=0; 
			}  
	       
	        IF(isp.CQS_Isp_Gest_comp_registro_car_scar_OK__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_Isp_Gest_comp_registro_car_scar_OK__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_Isp_Gest_comp_registro_car_scar_OK__c.equals(na)){
				x+=0; 
				y+=0;
			}
	        
	         IF(isp.CQS_IspQ_Identif_tipi_rifiuti_presenti__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Identif_tipi_rifiuti_presenti__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Identif_tipi_rifiuti_presenti__c.equals(na)){
				x+=0; 
				y+=0;
			}    
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c.equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c.equals(na)){
				x+=0;
				y+=0; 
			}    
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c.equals(n)){
				x+=0;
				y+=2; 
			} else IF(isp.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	         IF(isp.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c.equals(s1)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c.equals(n)){
				x+=0; 
				y+=1;
			 } else IF(isp.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c.equals(na)){
				x+=0; 
				y+=0;
			}    
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
	//EC - RIPRISTINO DEFINITIVO 
			
			IF(isp.CQS_IspQ_Scarifica_idonea_largh_prof__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Scarifica_idonea_largh_prof__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Scarifica_idonea_largh_prof__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
			system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			//
			IF(isp.CQS_IspQ_Manto_stradale_ripristinato_OK__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Manto_stradale_ripristinato_OK__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Manto_stradale_ripristinato_OK__c.equals(na)){
				x+=0;
				y+=0;
			}
	        
	        IF(isp.CQS_IspQ_Manto_usura_ripristinato_OK__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Manto_usura_ripristinato_OK__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Manto_usura_ripristinato_OK__c.equals(na)){
				x+=0;
				y+=0;
			}
	        //TO CHANGE    
			IF(isp.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c.equals(s1)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c.equals(n)){
				x+=0;
				y+=1;	
			} else IF(isp.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c.equals(na)){
				x+=0;
				y+=0;
			}
	     
	        IF(isp.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c.equals(n)){
				x+=0; 
				y+=3;
			 } else IF(isp.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c.equals(na)){
				x+=0;
				y+=0;
			}
	            
	        IF(isp.CQS_IspQ_Ripr_segnaletica_orizz_vert__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Ripr_segnaletica_orizz_vert__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Ripr_segnaletica_orizz_vert__c.equals(na)){
				x+=0;
				y+=0;
			}
	      
	        IF(isp.CQS_IspQ_Opere_finitura_pavimentazioneOK__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Opere_finitura_pavimentazioneOK__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Opere_finitura_pavimentazioneOK__c.equals(na)){
				x+=0;
				y+=0;
			}
	            
	         
		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
	// EC - Sezione		MATERIALI 
	// 
			IF(isp.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c.equals(s1)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c.equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
		system.debug('il valore di CQS_IspQ_Verifica_tipo_CLS_riempimenti__c selezionato è ' + isp.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c);
			
			
			IF(isp.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c.equals(n)){
				x+=0;
				y+=2;
			}
			 else IF(isp.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c.equals(na)){
				x+=0;
				y+=0;
			}
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_IspQ_Mat_conformi_spec_tec_OF__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Mat_conformi_spec_tec_OF__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Mat_conformi_spec_tec_OF__c.equals(na)){
				x+=0; 
				y+=0;
			}
	  
	  
	         IF(isp.CQS_IspQ_UbiInstal_Muffola_StaffOK__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_UbiInstal_Muffola_StaffOK__c.equals(n)){
				x+=0; 
				y+=2;
			 }
			 else IF(isp.CQS_IspQ_UbiInstal_Muffola_StaffOK__c.equals(na)){
				x+=0; 
				y+=0;
			 }   
	            
	         IF(isp.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c.equals(n)){
				x+=0; 
				y+=2;
			 }
			 else IF(isp.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
	         IF(isp.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c.equals(n)){
				x+=0; 
				y+=2;
			 }
			 else IF(isp.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
	         IF(isp.CQS_IspQ_Sistem_spl_fibre_mod_giun__c.equals(s1)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_IspQ_Sistem_spl_fibre_mod_giun__c.equals(n)){
				x+=0; 
				y+=3;
			 }
			 else IF(isp.CQS_IspQ_Sistem_spl_fibre_mod_giun__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	        
	         IF(isp.CQS_IspQ_Rispetto_NT_scorte_minicavo__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Rispetto_NT_scorte_minicavo__c.equals(n)){
				x+=0; 
				y+=2;
			 }
			 else IF(isp.CQS_IspQ_Rispetto_NT_scorte_minicavo__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	            
	         IF(isp.Minitubi_non_usati_chiusi_idonei_tappi__c.equals(s1)){
				x+=1;
				y+=1;
			} else IF(isp.Minitubi_non_usati_chiusi_idonei_tappi__c.equals(n)){
				 x+=0;
				 y+=1; 
			} else IF(isp.Minitubi_non_usati_chiusi_idonei_tappi__c.equals(na)){
				 x+=0;
				 y+=0; 
			}
	         
			system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			 
			IF(isp.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c.equals(s1)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c.equals(n)){
				 x+=0;
				 y+=1; 
			} else IF(isp.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c.equals(na)){
				 x+=0;
				 y+=0; 
			}
	
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
		//EC Sezione Armadi	
			IF(isp.CQS_IspQ_Caratteristiche_PFS_previste_NT__c.equals(s1)){
				x+=3;
				y+=3;
			} else IF(isp.CQS_IspQ_Caratteristiche_PFS_previste_NT__c.equals(n)){
				x+=0; 
				y+=3;
			} else IF(isp.CQS_IspQ_Caratteristiche_PFS_previste_NT__c.equals(na)){
				x+=0; 
				y+=0;
			 }
	         
	  //           system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_Basamento_PFS__c.equals(s1)){
				x+=1;
				y+=1;
			} else IF(isp.CQS_IspQ_Basamento_PFS__c.equals(n)){
				x+=0;
				y+=1;	
			} else IF(isp.CQS_IspQ_Basamento_PFS__c.equals(na)){
				x+=0;
				y+=0;	
			}
	            
	        IF(isp.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c.equals(na)){
				x+=0;
				y+=0;	
			}
	        
	        IF(isp.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c.equals(na)){
				x+=0;
				y+=0;	
			}
	             
	        IF(isp.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c.equals(na)){
				x+=0;
				y+=0;	
			}
	        
	        IF(isp.CQS_IspQ_Etichette_identificative_cavo1__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Etichette_identificative_cavo1__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_Etichette_identificative_cavo1__c.equals(na)){
				x+=0;
				y+=0;	
			}
	             
	        IF(isp.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c.equals(na)){
				x+=0;
				y+=0;	
			}
	        
	       IF(isp.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c.equals(na)){
				x+=0;
				y+=0;	
			}
	    
	         
			system.debug('il totale finale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				    
			try{            
	        	isp.CQS_ISP_Punteggio_Totale__c = x;
				isp.CQS_Punteggio_Tot_Max_Isp__c= y;
	            isp.CQS_ISP_Perc_Tot_Punt__c= (isp.CQS_ISP_Punteggio_Totale__c/isp.CQS_Punteggio_Tot_Max_Isp__c)*100; 
	            }
	            catch(Exception e){
	                isp.CQS_ISP_Punteggio_Totale__c = x;
					isp.CQS_Punteggio_Tot_Max_Isp__c= y;
			        isp.CQS_ISP_Perc_Tot_Punt__c=0;
	            }
	          
			// isp.CQS_ISP_Perc_Tot_Punt__c= x.divide(y, 2)*100;         
	        // isp.CQS_ISP_Punteggio_Totale__c = x.divide(1, 2);
			// isp.CQS_Punteggio_Tot_Max_Isp__c=y.divide(1, 2);
	
			//return isp;
			 system.debug('il totale infine è: ' + isp.CQS_ISP_Punteggio_Totale__c + ', mentre il totale massimo è ' + isp.CQS_Punteggio_Tot_Max_Isp__c +' Per cui il rapporto in percentuale è ' +  isp.CQS_ISP_Perc_Tot_Punt__c);
	         }
	      }
    
    //EC Start calcolo punteggio Ispezioni Tema Ambientale 20190102
     //EC Metodo calcolapunteggio3() per Ispezione di Qualità
		
		 public static void calcolaPunteggioIspTamb(OF_CQS_Ispezione__c isp){
		 	      	system.debug('siamo nella classe CQS_Utils. Chiamiamo il metodo calcolaPunteggio3, il recrdType dell\'ispezione di Qualità');
	      	If(updateTrigger=true){    	
	    	//non devo instanziare Isp perché la passa Il trigger
	    	system.debug('nel metodo calcolaPunteggio3. il campo isp.CQS_IspQ_Presenza_planimetrie_entige__c è valorizzato a: ' + isp.CQS_IspQ_Presenza_planimetrie_entige__c); 
	    
	  //EC - SEZIONE GESTIONE RIFIUTI - LAVORI IN CORSO          
			
			IF(isp.CQS_IspQ_Mat_trasp_discarica_autorizz__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_Mat_trasp_discarica_autorizz__c.equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_IspQ_Mat_trasp_discarica_autorizz__c.equals(na)){
				x+=0;
				y+=0; 
			}
	            
	        IF(isp.CQS_IspQ_gestione_compilazione_FIR_OK__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_gestione_compilazione_FIR_OK__c.equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_IspQ_gestione_compilazione_FIR_OK__c.equals(na)){
				x+=0;
				y+=0; 
			}  
	       
	        IF(isp.CQS_Isp_Gest_comp_registro_car_scar_OK__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_Isp_Gest_comp_registro_car_scar_OK__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_Isp_Gest_comp_registro_car_scar_OK__c.equals(na)){
				x+=0; 
				y+=0;
			}
	        
	         IF(isp.CQS_IspQ_Identif_tipi_rifiuti_presenti__c.equals(s1)){
				x+=2;
				y+=2;
			 } else IF(isp.CQS_IspQ_Identif_tipi_rifiuti_presenti__c.equals(n)){
				x+=0; 
				y+=2;
			 } else IF(isp.CQS_IspQ_Identif_tipi_rifiuti_presenti__c.equals(na)){
				x+=0; 
				y+=0;
			}    
	         
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			
			IF(isp.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c.equals(s1)){
				x+=3;
				y+=3;
			 } else IF(isp.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c.equals(n)){
				x+=0; 
			 	y+=3;
			} else IF(isp.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c.equals(na)){
				x+=0;
				y+=0; 
			}    
		//	system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
			
			IF(isp.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c.equals(n)){
				x+=0;
				y+=2; 
			} else IF(isp.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c.equals(na)){
				x+=0; 
				y+=0;
			}
	         
	         IF(isp.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c.equals(s1)){
				x+=1;
				y+=1;
			 } else IF(isp.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c.equals(n)){
				x+=0; 
				y+=1;
			 } else IF(isp.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c.equals(na)){
				x+=0; 
				y+=0;
			}    
	         
	//		system.debug('il totale al momento è: ' + x + ', mentre il totale massimo è ' + y);
	
	 //EC - SEZIONE GESTIONE RIFIUTI - LAVORI CONCLUSI
	 
	       IF(isp.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c.equals(s1)){
				x+=2;
				y+=2;
			} else IF(isp.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c.equals(n)){
				x+=0;
				y+=2;	
			} else IF(isp.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c.equals(na)){
				x+=0;
				y+=0;	
			}
	    
	         
			system.debug('il totale finale al momento è: ' + x + ', mentre il totale massimo è ' + y);
				    
			try{            
	        	isp.CQS_ISP_Punteggio_Totale__c = x;
				isp.CQS_Punteggio_Tot_Max_Isp__c= y;
	            isp.CQS_ISP_Perc_Tot_Punt__c= (isp.CQS_ISP_Punteggio_Totale__c/isp.CQS_Punteggio_Tot_Max_Isp__c)*100; 
	            }
	            catch(Exception e){
	                isp.CQS_ISP_Punteggio_Totale__c = x;
					isp.CQS_Punteggio_Tot_Max_Isp__c= y;
			        isp.CQS_ISP_Perc_Tot_Punt__c=0;
	            }
	          
			// isp.CQS_ISP_Perc_Tot_Punt__c= x.divide(y, 2)*100;         
	        // isp.CQS_ISP_Punteggio_Totale__c = x.divide(1, 2);
			// isp.CQS_Punteggio_Tot_Max_Isp__c=y.divide(1, 2);
	
			//return isp;
			 system.debug('il totale infine è: ' + isp.CQS_ISP_Punteggio_Totale__c + ', mentre il totale massimo è ' + isp.CQS_Punteggio_Tot_Max_Isp__c +' Per cui il rapporto in percentuale è ' +  isp.CQS_ISP_Perc_Tot_Punt__c);
	         }
	      }
		 


	//EC end Ispezioni Tema Ambientale 20190102
    
    
		 }



	
		
 /*
	 public static OF_CQS_Ispezione__c toTestIspezione(){
	 	
	 	rtmap=new map<String,Id>();
 		
 		OF_CQS_Ispezione__c ispAs = new OF_CQS_Ispezione__c();
 		//ispAs=[select id, name, CQS_ISP_PSC__ca, CQS_ISP_POS__c, CQS_ISP_Notifica_prel_corretta_valida__c, CQS_ISP_DURC_regolare__c, CQS_ISP_Attivita_Imprese_autorizzate_OF__c, CQS_ISP_Autorizzazione_amm_competente__c, CQS_ISP_Presenza_prog_cartografie_enti__c, CQS_ISP_indagini_preventive_scavo__c, CQS_ISP_Accantieramento_conforme__c, CQS_ISP_Esposizione_Cartello__c, CQS_ISP_RISPettoCodice_SegnaleticaStrada__c, CQS_ISP_Idoneit_delimit_Cantiere_AD__c, CQS_ISP_Buono_stato_cartellonistica__c, CQS_ISP_assicurata_viabilita__c, CQS_ISP_Passaggi_su_scavi_idonei__c, CQS_ISP_Pozzetti_non_pericolosi__c,  CQS_ISP_Presenza_WC__c, CQS_ISP_Presenti_autorizzati__c , CQS_ISP_Tesserino_Check__c, CQS_ISP_Preposto_Cantiere_Presente__c, CQS_ISP_Addetto_PS_presente__c, CQS_ISP_Addetto_Antincendio_presente__c, CQS_ISP_DPI_idonei_in_dotazione__c, CQS_ISP_DPI_lavorazioni_in_quota__c, CQS_ISP_DPI_rischio_elettrico__c, Presenza_Moviere_qualora_necessario__c, Personale_dotato_di_quanto_richiesto__c, CQS_ISP_Mezzi_Attrezzature_autorizati__c , CQS_ISP_conformita_mezzi_attrezzature__c, CQS_ISP_Documentazione_verifiche_legge__c, CQS_ISP_Marcatura_CE__c, CQS_ISP_Documentazione_noli_a_freddo__c, CQS_ISP_attrezzature_sollevamento__c, Cassetta_primo_soccorso_conforme__c , CQS_Estintore_con_cartellino_e_revisione__c, Autorizzazioni_ENEL_prossimit_E_Distrib__c , CQS_ISP_Presenza_Profili_E_Distrib__c, CQS_ISP_Dotazione_DPI_3_Cat_eDist__c from OF_CQS_Ispezione__c];
 
 		ispAs.CQS_ISP_PSC__c='Sì';
		ispAs.CQS_ISP_POS__c='Sì';
		ispAs.CQS_ISP_Notifica_prel_corretta_valida__c='Sì';
		ispAs.CQS_ISP_DURC_regolare__c='Sì';
		ispAs.CQS_ISP_Attivita_Imprese_autorizzate_OF__c='Sì';
		ispAs.CQS_ISP_Autorizzazione_amm_competente__c='Sì';
		ispAs.CQS_ISP_Presenza_prog_cartografie_enti__c='Sì';
		ispAs.CQS_ISP_indagini_preventive_scavo__c='Sì';
		ispAs.CQS_ISP_Accantieramento_conforme__c='Sì';
		ispAs.CQS_ISP_Esposizione_Cartello__c='Sì';
		ispAs.CQS_ISP_RispettoCodice_SegnaleticaStrada__c='Sì';
		ispAs.CQS_ISP_Idoneit_delimit_Cantiere_AD__c='Sì';
		ispAs.CQS_ISP_Buono_stato_cartellonistica__c='Sì';
		ispAs.CQS_ISP_assicurata_viabilita__c='Sì';
		ispAs.CQS_ISP_Passaggi_su_scavi_idonei__c='Sì';
		ispAs.CQS_ISP_Pozzetti_non_pericolosi__c='Sì';
		ispAs.CQS_ISP_Presenza_WC__c='Sì';
		ispAs.CQS_ISP_Presenti_autorizzati__c ='Sì';
		ispAs.CQS_ISP_Tesserino_Check__c='Sì';
		ispAs.CQS_ISP_Preposto_Cantiere_Presente__c='Sì';
		ispAs.CQS_ISP_Addetto_PS_presente__c='Sì';
		ispAs.CQS_ISP_Addetto_Antincendio_presente__c='Sì';
		ispAs.CQS_ISP_DPI_idonei_in_dotazione__c='Sì';
		ispAs.CQS_ISP_DPI_lavorazioni_in_quota__c='Sì';
		ispAs.CQS_ISP_DPI_rischio_elettrico__c='Sì';
		ispAs.Presenza_Moviere_qualora_necessario__c='Sì';
		ispAs.Personale_dotato_di_quanto_richiesto__c='Sì';
		ispAs.CQS_ISP_Mezzi_Attrezzature_autorizati__c ='Sì';
		ispAs.CQS_ISP_conformita_mezzi_attrezzature__c='Sì';
		ispAs.CQS_ISP_Documentazione_verifiche_legge__c='Sì';
		ispAs.CQS_ISP_Marcatura_CE__c='Sì';
		ispAs.CQS_ISP_Documentazione_noli_a_freddo__c='Sì';
		ispAs.CQS_ISP_attrezzature_sollevamento__c='Sì';
		ispAs.Cassetta_primo_soccorso_conforme__c ='Sì';
		ispAs.CQS_Estintore_con_cartellino_e_revisione__c='Sì';
		ispAs.Autorizzazioni_ENEL_prossimit_E_Distrib__c ='Sì';
		ispAs.CQS_ISP_Presenza_Profili_E_Distrib__c='Sì';
		ispAs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='Sì';
 		
 		return ispAs;
 		
 		
 		
 		OF_CQS_Ispezione__c ispAn = new OF_CQS_Ispezione__c();
 		
 		ispAn.CQS_ISP_PSC__c='No';
		ispAn.CQS_ISP_POS__c='No';
		ispAn.CQS_ISP_Notifica_prel_corretta_valida__c='No';
		ispAn.CQS_ISP_DURC_regolare__c='No';
		ispAn.CQS_ISP_Attivita_Imprese_autorizzate_OF__c='No';
		ispAn.CQS_ISP_Autorizzazione_amm_competente__c='No';
		ispAn.CQS_ISP_Presenza_prog_cartografie_enti__c='No';
		ispAn.CQS_ISP_indagini_preventive_scavo__c='No';
		ispAn.CQS_ISP_Accantieramento_conforme__c='No';
		ispAn.CQS_ISP_Esposizione_Cartello__c='No';
		ispAn.CQS_ISP_RispettoCodice_SegnaleticaStrada__c='No';
		ispAn.CQS_ISP_Idoneit_delimit_Cantiere_AD__c='No';
		ispAn.CQS_ISP_Buono_stato_cartellonistica__c='No';
		ispAn.CQS_ISP_assicurata_viabilita__c='No';
		ispAn.CQS_ISP_Passaggi_su_scavi_idonei__c='No';
		ispAn.CQS_ISP_Pozzetti_non_pericolosi__c='No';
		ispAn.CQS_ISP_Presenza_WC__c='No';
		ispAn.CQS_ISP_Presenti_autorizzati__c ='No';
		ispAn.CQS_ISP_Tesserino_Check__c='No';
		ispAn.CQS_ISP_Preposto_Cantiere_Presente__c='No';
		ispAn.CQS_ISP_Addetto_PS_presente__c='No';
		ispAn.CQS_ISP_Addetto_Antincendio_presente__c='No';
		ispAn.CQS_ISP_DPI_idonei_in_dotazione__c='No';
		ispAn.CQS_ISP_DPI_lavorazioni_in_quota__c='No';
		ispAn.CQS_ISP_DPI_rischio_elettrico__c='No';
		ispAn.Presenza_Moviere_qualora_necessario__c='No';
		ispAn.Personale_dotato_di_quanto_richiesto__c='No';
		ispAn.CQS_ISP_Mezzi_Attrezzature_autorizati__c ='No';
		ispAn.CQS_ISP_conformita_mezzi_attrezzature__c='No';
		ispAn.CQS_ISP_Documentazione_verifiche_legge__c='No';
		ispAn.CQS_ISP_Marcatura_CE__c='No';
		ispAn.CQS_ISP_Documentazione_noli_a_freddo__c='No';
		ispAn.CQS_ISP_attrezzature_sollevamento__c='No';
		ispAn.Cassetta_primo_soccorso_conforme__c ='No';
		ispAn.CQS_Estintore_con_cartellino_e_revisione__c='No';
		ispAn.Autorizzazioni_ENEL_prossimit_E_Distrib__c ='No';
		ispAn.CQS_ISP_Presenza_Profili_E_Distrib__c='No';
		ispAn.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='No';

 		return ispAn;
 
	 }
		
	public static OF_CQS_Ispezione__c insert_IspAs(){
	
		OF_CQS_Ispezione__c ispAs = toTestIspezione();
		insert ispAs;
		return ispAs;
		
		OF_CQS_Ispezione__c ispAn = toTestIspezione();
		insert ispAn;
		return ispAn;
		
		
	}		 
	
	
	 public static OF_CQS_Evento__c toTestEvento(){
 		
 		OF_CQS_Evento__c e = new OF_CQS_Evento__c();
 		
 		return e;
 
	 }
		
	public static OF_CQS_Evento__c insert_E(){
	
		OF_CQS_Evento__c e = toTestEvento();
		  	 for(recordtype rt : [select developername,id from recordtype Where SObject='OF_CQS_Evento__c']){
	        	 	rtmap.put(rt.developername,rt.Id);
	        	 }
		
		insert e;
		return e;
	}	
	 
	public CQS_Utils(){

	}	

	public enum triggeredAction {beforeInsert, beforeUpdate, afterInsert, afterUpdate}
	
	public CQS_Utils(List<OF_CQS_Ispezione__c> ispList, List<OF_CQS_Ispezione__c> oldIspList, triggeredAction ta){}  
		////////////////////////////////
		// BEFORE INSERT
	//	if (ta==triggeredAction.beforeInsert){
		//	someBeforeInsertMethod()
		//}
		// BEFORE UPDATE
		//if (ta==triggeredAction.beforeUpdate){
			//someBeforeUpdateMethod();
		//}
		
}
		////////////////////////////////
		// AFTER INSERT
/*
		if (ta==triggeredAction.afterInsert){
			public static void calcolaTotale(List<OF_CQS_Ispezione__c> ispList){
			
			List<OF_CQS_Ispezione__c> ispList = new List<OF_CQS_Ispezione__c>();
            for(OF_CQS_Ispezione__c isp : Trigger.New){
            ispList=[select id, CQS_ISP_Somma_Totale_Domande__c, CQS_ISP_Totale_Divisore_PunteggioDomande__c, CQS_ISP_Punteggio_Totale__c from OF_CQS_Ispezione__c where ID IN : Trigger.New];
            }
            for(integer i = 0; i<ispList.size();i++){
              for(OF_CQS_Ispezione__c isp: ispList){
                isp.CQS_ISP_Punteggio_Totale__c=isp.CQS_ISP_Somma_Totale_Domande__c/isp.CQS_ISP_Totale_Divisore_PunteggioDomande__c;            
              }
            } update ispList;
	     //     return isp.CQS_ISP_Punteggio_Totale__c;
			} 
		}
		*/
	/*
		// AFTER UPDATE
	//	if (ta==triggeredAction.afterUpdate){
		List<OF_CQS_Ispezione__c> ispListToUpdate = new List<OF_CQS_Ispezione__c>();
		for (OF_CQS_Ispezione__c isp : trigger.new){
			
			double oldSommaTot= trigger.oldMap.get(isp.id).CQS_ISP_Somma_Totale_Domande__c;
			double newSommaTot= isp.CQS_ISP_Somma_Totale_Domande__c;
			
			double oldDivTot=  trigger.oldMap.get(isp.id).CQS_ISP_Totale_Divisore_PunteggioDomande__c;
			double newDivTot=  isp.CQS_ISP_Totale_Divisore_PunteggioDomande__c;
			
			if((oldSommaTot!=newSommaTot)||(oldDivTot!=newDivTot)){
				isp.CQS_ISP_Punteggio_Totale__c=newSommaTot/newDivTot;
				//isp.CQS_ISP_Punteggio_Totale__c=isp.CQS_ISP_Somma_Totale_Domande__c/isp.CQS_ISP_Totale_Divisore_PunteggioDomande__c;
				
				ispListToUpdate.add(isp);
			}
			if(ispListToUpdate.size()>0){
				update ispListToUpdate;
			}
		 }
		}
    */
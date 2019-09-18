public with sharing class CQS_HomeTipoEvento_cController {
    //EC 2019-01-20 Prima del deploy modificare il puntamento del link inviato nell'email. 
    //cercando plainBody.replace('{!OF_CQS_Evento__c.Link}', 
    //nel commento a lato il puntamento corretto in base all'ambiente.
   
            public OF_CQS_Evento__c ev {get;set;}
            public List<SelectOption> opt{get; set;}
            public List<String> tipiEvento {get; set;}
            public String parentId {get;set;}
            public String pageName{get; set;}
            public String optScelta{get; set;}
            public String jnldo {get;set;}
            public String Snjun {get;set;}
            public Attachment file {get; set;}
            public List<Attachment> atList{get; set;}
            public List<Integer> intList {get; set;}
            public String projectName{get; set;}
            public String statoPratica{get;set;}
            public List<SelectOption> optNomeProgetto{get; set;}
            public Progetto_Utente_junction__c jPu{get; set;}
            public pageReference pageRef{get; set;}
            public String evId{get; set;}
            public map<Id,String> rtmapIdDv{get; set;}
            public map<String,Id> rtmap{get; set;}
            public String errorMessage{get; set;}
            public List<String> emList {get; set;}
            //EC 2018 - 05 - 31
            public String optTipoAtt{get; set;}   //projectName
            public List<SelectOption> optTipoAllegato{get; set;}   //optNomeProgetto   
            public String nameFile1{get;set;}
            public String nameFile2{get;set;}
            public String nameFile3{get;set;}
            public String nameFile4{get;set;}
            public String nameFile5{get;set;}
            public Blob fileb {get; set;}
            public List<Blob> blobList{get; set;}
            public Attachment[] atts {get;set;}
            public Attachment att{get;set;}
            public CQS_Allegati__c allegato{get;set;}
            
            public String selectedType {get;set;} // optTipoAtt
//          public Boolean selectedAwesomeness {get;set;}//
            public String description {get;set;} //descrizione
        //  private OF_CQS_Evento__c ev {get;set;} 
            public String fileName {get;set;}
            public Blob fileBody {get;set;}
                    
            //EC 2018 - 06 - 07  variabili per il workflow
            public Boolean spInserita{get;set;}
            public Boolean spAperta{get;set;}        
            public Boolean spInLavorazione{get;set;}        
            public Boolean spIntegrataInLavorazione{get;set;}
            public Boolean spChiusa{get;set;}
            public Boolean checkOwnerCurrentUser{get;set;}
            public Static String cmStr='City Manager';
            public Static String cseStr='CSE';
            User cm {get;set;}
            User cse {get;set;}
            
            //EC 2018 - 06 - 11
           public Id cmProject {get;set;}
           public Id cseProject {get;set;}
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
                
           
        //public CQS_HomeTipoEvento_cController(){
        
        
        //}
        public CQS_HomeTipoEvento_cController(ApexPages.StandardController stdController) {
              	//ev= new OF_CQS_Evento__c();
              	List<String> sList = new List<String>();
            	sList.add('CQS_Ev_Skip_Controller__c');
            	sList.add('CQS_Ev_Progetto__c');
            	if (!Test.isRunningTest()) {
                     stdController.addFields(sList);
           		}
	           	system.debug('@@@@@EC stdController: ' + stdController);
                this.ev = (OF_CQS_Evento__c)stdController.getRecord();
            	
                //statoPratica = ev.OF_CQS_Stato_Pratica__c;
                
				system.debug('@@@@@@EC chiamiamo il controller, ev è: ' + ev);
                spInserita= true;
                spAperta= false;
                spInLavorazione= false;
                spIntegrataInLavorazione= false;
                spChiusa= false;
                checkOwnerCurrentUser=false;
                projectName=ev.CQS_Ev_Progetto__c;
               	if(!ev.CQS_Ev_Skip_Controller__c){   
                 system.debug('@@@@@@EC è la prima volta che  chiamiamo il controller, skip controller infatti è ' +ev.CQS_Ev_Skip_Controller__c);
                 scegliTipoEvento();
                 system.debug('nel controller abbiamo appena chiamato il metodo scegliTipoEvento()');
                 definisciProgettiPl();
                 system.debug('nel controller abbiamo appena chiamato il metodo definisciProgettiPl()');
                }  
							
                Map<String,String> ldoMap = new Map<String, String>();
                Map<String,String> regMap = new Map<String, String>();
                 
                system.debug('inside Controller'+ projectName);
                scegliTipoAttachment();  
                atts = new Attachment[5];
                  
                  
                 if(projectName!=''){
                    //ma projectName è un id? EC
                    for(CQS_Prog_An_junc__c jpu2: [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c
                                                 from CQS_Prog_An_junc__c where CQS_Praj_Progetto__c=:projectName]){
                            
                             ldoMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praju_LDO__c );
                             regMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praj_Ragione_Sociale__c);
                    }
                             ev.CQS_Ev_Lettera_D_Ordine__c=ldoMap.get(projectName);
                             ev.OF_CQS_Impresa_Mandataria__c=regMap.get(projectName);
                                 //ev.OF_CQS_Impresa_Mandataria__c = rsocial.get(projectName);
                                 system.debug('ldo===='+ev.CQS_Ev_Lettera_D_Ordine__c);
                              //system.debug('rsoci===='+ev.OF_CQS_Impresa_Mandataria__c);
                 }
                 
                 rtmap=new map<String,Id>();
                 for(recordtype rt : [select developername,id from recordtype where SobjectType='OF_CQS_Evento__c']){
                    rtmap.put(rt.developername,rt.Id);
                 }
            
                            
                if(ApexPages.currentPage().getParameters().get('optScelta')!=null){
                    optScelta=ApexPages.currentPage().getParameters().get('optScelta');                                                     
                }
                        
                if(ApexPages.CurrentPage().getParameters().containsKey('/apex/CQS_Evento')){
                //ApexPages.getMessage().clear();
               //ApexPages.CurrentPage().getMessage().clear();
                        try{        
                                salvaEvento();
                        }
                        catch(Exception e) {
                            //List<String> emList = new List<String>();
                            for (Integer i = 0; i < e.getNumDml(); i++) {
                            //String errorMessage ='errorMeeeeeeessage';
                        //  String errorMessage = e.getMessage();
                            //ApexPages.addMessages(e);
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(0)));
                            //ApexPages.addMessages(e);
                            system.debug(e);
                        //  emList.add(errorMessage);
                            pageRef= null;
                            }
                        }
            }
            else if(ApexPages.CurrentPage().getParameters().containsKey('/apex/CQS_DanneggiamentoAterzi')){
                                try{        
                                salvaEvento();
                        }
                        catch(Exception e) {
                            for (Integer i = 0; i < e.getNumDml(); i++) {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(0)));
                            system.debug(e);
                            pageRef= null;
                            }
                        }
            }
            /*
            else if(ApexPages.CurrentPage().getParameters().containsKey('/apex/CQS_Infortunio')){
                                try{        
                                salvaEvento();
                        }
                        catch(Exception e) {
                            for (Integer i = 0; i < e.getNumDml(); i++) {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(0)));
                            system.debug(e);
                            pageRef= null;
                            }
                        }
            }
            */
            else if(ApexPages.CurrentPage().getParameters().containsKey('/apex/CQS_Interferenze_a_sottoservizi')){
                                try{        
                                salvaEvento();
                        }
                        catch(Exception e) {
                            for (Integer i = 0; i < e.getNumDml(); i++) {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(0)));
                            system.debug(e);
                            pageRef= null;
                            }
                        }
            }
        }

        //EC 2018 - 06 - 11
        
            public void updateRTEvento(String statoPratica){
                List<recordType> rtStringList = [select DeveloperName from RecordType where SobjectType = 'OF_CQS_Evento__c' AND Id =: ev.RecordTypeId Limit 1];
                String stringaRt= rtStringList.get(0).DeveloperName;
                system.debug('ev: ' + ev + 'ev.RecordType.DeveloperName: ' + stringaRt);
                statoPratica=ev.OF_CQS_Stato_Pratica__c;
                system.debug('@@@@@@@ Nel metodo updateRTEvento prima degli if. Stampiamo il valore della stringa statoPratica:' + statoPratica + ', mentre ev.OF_CQS_Stato_Pratica__c vale: ' + ev.OF_CQS_Stato_Pratica__c);
                if(statoPratica=='Inserita'){
                //   spInserita= true;  
                }
                if(statoPratica=='Aperta'){
                   
                    if(stringaRt.equals(eBadP)){ 
                        ev.RecordTypeId= rtmap.get('Bad_Practice_Aperta');
                        system.debug('nel primo if innestato del metodo updateRTEvento. la mappa del recordType è così popolata: ' + rtmap + ' e l\'id del recordType per Bad_Practice_Aperta, appena riassegnato è: ' + ev.RecordTypeId );
                    }
                    else if(stringaRt.equals(eDa)){
                        ev.RecordTypeId= rtmap.get('Danneggiamento_a_Terzi_Aperta');
                    }
                    else if(stringaRt.equals(eIss)){
                        ev.RecordTypeId= rtmap.get('Interferenza_a_Sotto_servizi_Aperta');
                    }
                //     spAperta= true;        
                }
                if(statoPratica=='In Lavorazione'){
                    if(stringaRt.equals('Bad_Practice_Aperta')){
                        ev.RecordTypeId= rtmap.get('Bad_Practice_in_Lavorazione');
                    }
                    else if(stringaRt.equals('Danneggiamento_a_Terzi_Aperta')){
                        ev.RecordTypeId= rtmap.get('Danneggiamento_a_Terzi_in_Lavorazione');
                    }
                    else if(stringaRt.equals('Interferenza_a_Sotto_servizi_Aperta')){
                        ev.RecordTypeId= rtmap.get('Interferenza_a_Sotto_servizi_in_Lavorazione');
                    }
                //    spInLavorazione= true;
                }
                if(statoPratica=='Integrata/In Approvazione'){
                    if(stringaRt.equals('Bad_Practice_in_Lavorazione')){
                        ev.RecordTypeId= rtmap.get('Bad_Practice_Integrata');
                    }
                    else if(stringaRt.equals('Danneggiamento_a_Terzi_in_Lavorazione')){
                        ev.RecordTypeId= rtmap.get('Danneggiamento_a_Terzi_Integrata');
                    }
                    else if(stringaRt.equals('Interferenza_a_Sotto_servizi_in_Lavorazione')){
                        ev.RecordTypeId= rtmap.get('Interferenza_a_Sotto_servizi_Integrata');
                    }
                //     spIntegrataInLavorazione= true;
                }
                if(statoPratica=='Chiuso'){
                     if(stringaRt.equals('Bad_Practice_Integrata')){
                        ev.RecordTypeId= rtmap.get('Bad_Practice_Chiusa');
                    }
                    else if(stringaRt.equals('Danneggiamento_a_Terzi_Integrata')){
                        ev.RecordTypeId= rtmap.get('Danneggiamento_a_Terzi_Chiusa');
                    }
                    else if(stringaRt.equals('Interferenza_a_Sotto_servizi_Integrata')){
                        ev.RecordTypeId= rtmap.get('Interferenza_a_Sotto_servizi_Chiusa');
                    }
                 //    spChiusa= true;
                }
                system.debug('l\'evento è: ' + ev);
                try{
                update ev;
                }catch(exception e){}
            }
    

        //EC 2018 - 06 - 08 METODO WORKFLOW
        public void  setBooleanStatoPratica(){
            if(ev.OF_CQS_Stato_Pratica__c=='Inserita'){
                 spInserita= true;
            }
            else if(ev.OF_CQS_Stato_Pratica__c=='Aperta'){
                 spAperta= true;   
				 spInserita=false;				 
            }
            else if(ev.OF_CQS_Stato_Pratica__c=='In Lavorazione'){
                 spInLavorazione= true;
				 spAperta= false;   
				 spInserita=false;
            }
            else if(ev.OF_CQS_Stato_Pratica__c=='Integrata/In Approvazione'){
                 spIntegrataInLavorazione= true;
				 spInLavorazione= false;
				 spAperta= false;   
				 spInserita=false;
            }
            else if(ev.OF_CQS_Stato_Pratica__c=='Chiuso'){
                 spChiusa= true;
				 spIntegrataInLavorazione= false;
				 spInLavorazione= false;
				 spAperta= false;   
				 spInserita=false;
            }
        }
        
        public void sendToApprove1lv(){
        ev.OF_CQS_Stato_Pratica__c='Aperta';
        setBooleanStatoPratica();
    //  CQS_Utils.inviaMail3();
        }
    
        public void checkOwnerSameUser(){
        checkOwnerCurrentUser=(ev.OwnerId==UserInfo.getUserId())?true:false;    
        }
        
        public void changeOwner(String statoPratica){
            statoPratica=ev.OF_CQS_Stato_Pratica__c;
            system.debug('è stato chiamato il metodo changeOwner, e ci troviamo al suo interno');
            system.debug('L\'evento è ' + ev + ', lo stato della pratica è ' + ev.OF_CQS_Stato_Pratica__c+ 'la variabile statoPratica è '+statoPratica);
            if(statoPratica=='Inserita'){
                system.debug('è stato chiamato il metodo changeOwner, e ci troviamo nell\'if dello stato pratica = inserita. evento: ' + ev);
                
                ev.OwnerId= getCSE(ev);
                update ev;
            }
            else if(statoPratica=='Aperta'){
                system.debug('è stato chiamato il metodo changeOwner, e ci troviamo nell\'if dello stato pratica = Aperta');
                ev.OwnerId= getCM(ev);
                update ev;
            }
            else if(statoPratica=='In Lavorazione'){
                system.debug('è stato chiamato il metodo changeOwner, e ci troviamo nell\'if dello stato pratica = In Lavorazione');
                ev.OwnerId= getCSE(ev);
                update ev;
            }
            else if(statoPratica=='Integrata/In Approvazione'){
                system.debug('è stato chiamato il metodo changeOwner, e ci troviamo nell\'if dello stato pratica = Integrata/In Approvazione');
                ev.OwnerId= getCM(ev);
                update ev;
            }
            else if(statoPratica=='Chiuso'){
                system.debug('è stato chiamato il metodo changeOwner, e ci troviamo nell\'if dello stato pratica = chiuso');
                ev.OwnerId= getCSE(ev);
                update ev;
            }
        }
    
        public void changeStatoP(String statoPratica){
            system.debug('è stato chiamato il metodo changeStatoP, e ci troviamo al suo interno. lo stato pratica che arriva è: ' + ev.OF_CQS_Stato_Pratica__c);
            if(statoPratica=='Inserita'){
                system.debug('è stato chiamato il metodo changeStatoP, e ci troviamo nell\'if dello stato pratica = inserita');
                ev.OF_CQS_Stato_Pratica__c='Aperta';
                update ev;
            }
            else if(statoPratica=='Aperta'){
                system.debug('è stato chiamato il metodo changeStatoP, e ci troviamo nell\'if dello stato pratica = Aperta');
                ev.OF_CQS_Stato_Pratica__c='In Lavorazione';
                update ev;    
            }
            else if(statoPratica=='In Lavorazione'){
                system.debug('è stato chiamato il metodo changeStatoP, e ci troviamo nell\'if dello stato pratica = In Lavorazione');
                ev.OF_CQS_Stato_Pratica__c='Integrata/In Approvazione';
                update ev;
            }
            else if(statoPratica=='Integrata/In Approvazione'){
                system.debug('è stato chiamato il metodo changeStatoP, e ci troviamo nell\'if dello stato pratica = integrata/In Approvazione');
                ev.OF_CQS_Stato_Pratica__c='Chiuso';
                update ev;
            }
        }
         
        public pageReference gestioneEvento(){
            system.debug(this.ev);
            
    //      salvaEvento();
    //      inviaMailgen(ev.OF_CQS_Stato_Pratica__c);
            //cambiaStato();
    //      setOwnership();
        return null;
        } 
    //invio mail 
    
        //Start EC 2018 - 04 - 24 nuovo metodo che torna una mappa con id progetto e lista di user destinatari. Metodo copiato
    //GB rivisto
//CQS_Utils.ritornaTemplates();

    //if( ev.Skip_Email__c = false)
        public void inviaMailgen(String statoPratica){ 
                rtmapIdDv=new map<Id,String>();
                for(recordtype rt : [select developername,id from recordtype where SobjectType='OF_CQS_Evento__c']){
                     system.debug('la mappa rtmapIdDv è popolata con i seguenti valori singoli: developername ' + rt.developername + ' recortypeid: ' + rt.Id);
                    rtmapIdDv.put(rt.Id,rt.developername);
                     system.debug('la mappa rtmapIdDv è così popolata: ' + rtmapIdDv);
                 }
            
            system.debug('la mappa rtmapIdDv è così popolata: ' + rtmapIdDv);
         
            system.debug('è stato chiamato il metodo inviaMailgen, e ci troviamo al suo interno. l\'id ev vale: ' +ev.id);
          // ApexPages.CurrentPage().getParameters(); 
            List<OF_CQS_Evento__c> evento = [Select Id, name, CQS_Ev_Progetto__c, 
                                                                CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
                                                                Owner.Name, recordType.DeveloperName, recordType.Name,
                                                                recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
                                                                OF_CQS_Impresa_Esecutrice_Eventi__c, OF_CQS_Impresa_Mandataria__r.Name, 
                                                                OF_CQS_Impresa_Esecutrice_Eventi__r.Name, OF_CQS_Stato_Pratica__c,
																CQS_Ev_Skip_Controller__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =: ev.id limit 1];
            system.debug('il recordTypeDeveloperName è: ' + evento.get(0).recordType.DeveloperName );
            system.debug('la query ha compilato così la lista di eventi con un solo record: ' + evento);
            String rtDevName = rtmapIdDv.get(evento.get(0).recordTypeId);
            system.debug('rtDevName è popolata così: ' + rtmapIdDv.get(evento.get(0).recordTypeId) + 'la relativa stringa dunque vale: ' + rtDevName);
            //inserire if su gravità lieve o media else con i metodi  per gravità alta
            
            if('Inserita'.equals(statoPratica)){
                system.debug('è stato chiamato il metodo inviaMailge, e ci troviamo nell\'if dello stato pratica = inserita');
                inviomailInserita('inserita'); 
                
            }
            if('Aperta'.equals(statoPratica)){
                system.debug('if di stato pratica aperta, l\'indice di gravità è: ' +  evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c + 'la stringa indexGravA vale' + indexGravA);
                system.debug('@@@siamo nel metodo inviaMailgen nell\'if dello stato pratica= Aperta. @@@  il recordTypeId è ' + evento.get(0).recordTypeId + ' ,mentre il recordTypeDeveloperName è : ' +evento.get(0).recordType.DeveloperName + 'e la stringa relativa al developer name del recordtype è stata popolata dalla mappa con questo valore: ' + rtDevName);
                //if((rtDevName.equals(eBadP))&& (rtDevName.equals('Bad_Practice_Aperta')) && (rtDevName.equals('Bad_Practice_Chiusa')) && (rtDevName.equals('Bad_Practice_Integrata')) && (rtDevName.equals('Bad_Practice_in_Lavorazione')) || (!(indexGravA.equals(ev.CQS_Indice_Gravita_Taglio_Danneggiamento__c)))){
                if((rtDevName.equals('Bad_Practice_Aperta')) || (!(indexGravA.equals(evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c)))){
                    system.debug('è stato chiamato il metodo inviaMailge, e ci troviamo nell\'if dello stato pratica = Aperta con invioMailApertaLieve');
                    system.debug('if di stato pratica aperta, l\'indice di gravità è: ' + evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c + 'la stringa indexGravA vale' + indexGravA);
                    invioMailApertaLieve('aperta');
                    
                }
                else{   
                    system.debug('è stato chiamato il metodo inviaMailge, e ci troviamo nell\'else dello stato pratica = Aperta con invioMailAperta (G)');
                    invioMailAperta();
                }
            }
            if('In Lavorazione'.equals(statoPratica)){
                system.debug('è stato chiamato il metodo inviaMailge, e ci troviamo nell\'if dello stato pratica = In Lavorazione');
                inviomailInserita('in lavorazione'); 
                
            }
            
            if('Integrata/In Approvazione'.equals(statoPratica)){
                system.debug('è stato chiamato il metodo inviaMailge, e ci troviamo nell\'if dello stato pratica = Integrata in Approvazione con invioMailIntegrata');
                //invioMailIntegrata();
                if((rtDevName.equals('Bad_Practice_Integrata')) || (!(indexGravA.equals(evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c)))){
                    system.debug('è stato chiamato il metodo inviaMailge, e ci troviamo nell\'if dello stato pratica = Chiuso con invioMailChiusoLieve');
                    invioMailChiusaLieve();
                }
                else{
                    system.debug('è stato chiamato il metodo inviaMailge, e ci troviamo nell\'if dello stato pratica = Chiuso con invioMailChiuso (Grave)');    
                    invioMailChiusa();
                }

            }
            if('Chiuso'.equals(statoPratica)){
                system.debug('è stato chiamato il metodo inviaMailge, e ci troviamo all\'interno dello stato pratica = Chiuso');
                if((rtDevName.equals('Bad_Practice_Chiusa'))|| (!(indexGravA.equals(evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c)))){
                    system.debug('è stato chiamato il metodo inviaMailge, e ci troviamo nell\'if dello stato pratica = Chiuso con invioMailChiusoLieve');
                    invioMailChiusaLieve();
                }
                else{
                    system.debug('è stato chiamato il metodo inviaMailge, e ci troviamo nell\'if dello stato pratica = Chiuso con invioMailChiuso (Grave)');    
                    invioMailChiusa();
                }
            }   
        }   
        public id getCM(OF_CQS_Evento__c eL){
            List<OF_CQS_Evento__c> evento = [Select  CQS_Ev_Progetto__c,CQS_Ev_Skip_Controller__c 
                                                                from OF_CQS_Evento__c 
                                                                where Id =: eL.id limit 1];
            
            system.debug('è stato chiamato il metodo getCM, e ci troviamo al suo interno');
            List<Id> listProg=new List<Id>();
            listProg.add(evento.get(0).CQS_Ev_Progetto__c);
            system.debug('è stato chiamato il metodo getCM, la listProg è così popolata: ' + listProg);
            Map<Id,List<ID>> progUtDestPuJMap= CQS_Utils.getUListPro(listProg);
            system.debug('è stato chiamato il metodo getCM, la progUtDestPuJMap è così popolata: ' + progUtDestPuJMap);
            List<ID> listTargetUser=progUtDestPuJMap.get(evento.get(0).CQS_Ev_Progetto__c);
            system.debug('è stato chiamato il metodo getCM, la listTargetUser è così popolata: ' + listTargetUser);
            for(User userX:[select id, UserRoleId, UserRole.Name from User where Id=:listTargetUser and (UserRoleId!='' and UserRoleId!=null)]){
                if(userX.UserRole.Name.contains(cmStr)){
                    cmProject= userX.Id;
                    system.debug('è stato chiamato il metodo getCM, nell\'if dell\'if userRoleName contiene la stringa cmStr. L\'id del CM è: ' + cmProject);     
                 }
           }
            return cmProject;
        }
        
        public id getCSE(OF_CQS_Evento__c eL){
            List<OF_CQS_Evento__c> evento = [Select  CQS_Ev_Progetto__c,CQS_Ev_Skip_Controller__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =: eL.id limit 1];
            
            system.debug('è stato chiamato il metodo getCSE, e ci troviamo al suo interno. stampiamo id evento: ' + eL.Id + 'il progetto è: ' + evento.get(0).CQS_Ev_Progetto__c);
            List<Id> listProg=new List<Id>();
            listProg.add(evento.get(0).CQS_Ev_Progetto__c);
            system.debug('è stato chiamato il metodo getCSE, la listProg è così popolata: ' + listProg);
            Map<Id,List<ID>> progUtDestPuJMap= CQS_Utils.getUListPro(listProg);
            system.debug('è stato chiamato il metodo getCSE, la progUtDestPuJMap è così popolata: ' + progUtDestPuJMap);
            List<ID> listTargetUser=progUtDestPuJMap.get(evento.get(0).CQS_Ev_Progetto__c);
            system.debug('è stato chiamato il metodo getCSE, la listTargetUser è così popolata: ' + listTargetUser);
            for(User userX:[select id, UserRoleId, UserRole.Name from User where Id=:listTargetUser and (UserRoleId!='' and UserRoleId!=null)]){
                if(userX.UserRole.Name.contains(cseStr)){
                    cseProject= userX.Id;
                    system.debug('è stato chiamato il metodo getCM, nell\'if dell\'if userRoleName contiene la stringa cseStr. L\'id del CSE è: ' + cseProject);     
                 }
           }
            return cseProject;
        }
        
        //End EC 2018 - 06 - 08 

        public void scegliTipoEvento(){
            tipiEvento = new List<String>();    
            opt= new List<SelectOption>();
           opt.add(new SelectOption('Bad Practice','Bad Practice'));
            opt.add(new SelectOption('Danneggiamento a terzi','Danneggiamento a terzi'));
             
         //   opt.add(new SelectOption('Infortunio','Infortunio'));
            opt.add(new SelectOption('Interferenza a sottoservizi','Interferenza a sottoservizi'));
            //  optScelta=SelectOption.getLabel();
        }
        
        public void scegliTipoAttachment(){
         //optTipoAtt{get; set;}   //projectName public String optScelta
         optTipoAllegato = new List<SelectOption>();  //optNomeProgetto      public List<SelectOption>  
            optTipoAllegato.add(new SelectOption(' - ',' - '));
            optTipoAllegato.add(new SelectOption('Documento Pre Ripristino','Documento Pre Ripristino'));
            optTipoAllegato.add(new SelectOption('Documento Post Ripristino','Documento Post Ripristino'));
            optTipoAllegato.add(new SelectOption('Verbale Rilascio Ente Gestore','Verbale Rilascio Ente Gestore'));
            optTipoAllegato.add(new SelectOption('Altro','Altro'));
        }

        public PageReference portaVF(){
         
            system.debug(optScelta) ;    
            PageReference pageRef;
                    
               if(optScelta=='Bad Practice'){
                 //  ev.recordType.Name='OF_CQS_Bad_Practice';
                    pageRef = new PageReference('/apex/CQS_Evento');
                }
               else if(optScelta=='Danneggiamento a terzi'){
               //   ev.recordType.Name='OF_CQS_Danni_Arrecati';
                     pageRef = new PageReference('/apex/CQS_DanneggiamentoAterzi');
                }
                /*
                else if(optScelta=='Infortunio'){
                //  ev.recordType.Name='OF_CQS_Infortunio';
                     pageRef = new PageReference('/apex/CQS_Infortunio');
                }
                */
                else if(optScelta=='Interferenza a sottoservizi'){
                    //ev.recordType.Name='OF_CQS_Interferenza_Sottoservizi  ';
                     pageRef = new PageReference('/apex/CQS_Interferenze_a_sottoservizi');
                } 
                pageref.getParameters().put('optScelta',optScelta);
                pageRef.setRedirect(true);
                return pageRef;
        } 

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
               system.debug('ev===='+ev);
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
         
         /*
        public String definisciLDO(){
            definisciProgettiPl();
             Map<String,String> ldoMap = new Map<String, String>();
            for(Progetto_Utente_junction__c jpu2: [select CQS_junc_progetto__r.Name,CQS_junc_progetto__r.CQS_Pro_LDO__c 
                                                 from Progetto_Utente_junction__c where CQS_junc_user__c =:userinfo.getUserId()] ){
            ldoMap.put(jpu2.CQS_junc_progetto__c,jpu2.CQS_junc_progetto__r.CQS_Pro_LDO__c);
           // ev.CQS_Ev_Lettera_D_Ordine__c=ldoMap.get(jpu2.CQS_junc_progetto__c);
            
            }
            return  ev.CQS_Ev_Lettera_D_Ordine__c=ldoMap.get(projectName);
            //return ev.CQS_Ev_Lettera_D_Ordine__c=ldoMap.get(projectName);
    
        }
        */
                             
        public List<Attachment> fileUpload1(){
            system.debug('è stato chiamato il metodo fileUpload()');   
            for(integer i=0; i<=5; i++){
            atList= new List<Attachment>();
                file= new Attachment();
                atList.add(file);
                  system.debug(atList.size());
        
            } 
             return atList; 
        } 
        public List<Attachment> fileUpload(Attachment att){
            system.debug('è stato chiamato il metodo fileUpload()');   
            system.debug('l\'attachment è così valorizzato: ' + att);
            atts= new Attachment[]{};
           // for(integer i=0; i<=5; i++){
            
             //   att= new Attachment();
                atts.add(att);
                  system.debug('la lista di attach conta '+ atts.size() + ' allegati');
        
            //} 
             return atts; 
        } 
            
        public PageReference upload(){
            insert file;
            file.body = null;
           return null;       
        }
    
    /*
    *Metodo da richiamare nel bottone da LayoutStandard con javascript
    al suo interno richiamiamo salvaEvento();
    EC - 2018 - 06 - 15
    */
   /*public void salvaEventoFromButton(){
   Webservice static void salvaEventoFromButton(){
       system.debug('stiamo chiamando il metodo salvaeventofrombutton. l\'id dell\'evento che passiamo come parametro è: ' );
/*  OF_CQS_Evento__c ev = [select id, name, CQS_Ev_Progetto__c, 
                               CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
                               Owner.Name, recordType.DeveloperName, recordType.Name,
                               recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
                               OF_CQS_Impresa_Esecutrice_Eventi__c, 
                               OF_CQS_Impresa_Mandataria__r.Name, OF_CQS_Impresa_Esecutrice_Eventi__r.Name from OF_CQS_Evento__c where id=:localId limit 1];
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ev);
        CQS_HomeTipoEvento_cController stdr = new CQS_HomeTipoEvento_cController(sc);
       
        stdr.salvaEvento();
      salvaEvento();
               
    }*/ 
                
    public PageReference salvaEvento(){
                system.debug('EvId '+ ev.id +'siamo nel metodo salvaEvento. oPTSCELTA vale' + optScelta +  '. Il progetto è: ' + projectName + ', il comune selezionato è ' + selectedIdComune + 'la lettera d\'ordine è ' + jnldo +'la mandataria associata è '+ Snjun);
		PageReference pageRef;
        if((selectedIdComune=='')||(selectedIdComune==null)){
          String str1='Il campo Comune è Obbligatorio. Bisogna selezionarlo dalla tendina di autocompilazione';
          
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,str1);
           ApexPages.addMessage(myMsg);
           return null;
        }
        else{
        
       
        ev.CQS_Ev_Progetto__c= projectName;
        ev.CQS_ev_Tipo_Allegato__c=optTipoAtt;
    //    if((selectedIdComune!=null) && (selectedIdComune!='')){
    //    ev.OF_CQS_Comune_Text__c = selectedIdComune;
    	  ev.OF_CQS_Comune_Text__c=[select id,of_Comune__c,OF_Provincia__c from  OF_ElencoComuniItaliani__c where Id=:selectedIdComune].of_Comune__c;
   //     ev.CQS_Ev_Lettera_D_Ordine__c = jnldo;
 //       ev.OF_CQS_Impresa_Mandataria__c = Snjun;
        
        OF_ElencoComuniItaliani__c  OF_ElencoComuniItalianiobj  = new OF_ElencoComuniItaliani__c ();
        OF_ElencoComuniItalianiobj  = [select id,of_Comune__c,OF_Provincia__c from  OF_ElencoComuniItaliani__c where Id=:selectedIdComune];
        ev.OF_CQS_Provincia_Evento__c =OF_ElencoComuniItalianiobj.OF_Provincia__c; 
		ev.CQS_Ev_Skip_Controller__c=true;
   //     }    
            if(optScelta=='Bad Practice'){
                   ev.recordtypeId=rtmap.get('OF_CQS_Bad_Practice');
                 
            } else if(optScelta=='Danneggiamento a terzi'){
                ev.recordtypeId=rtmap.get('OF_CQS_Danni_Arrecati');
               } 
               
                else if(optScelta=='Interferenza a sottoservizi'){
                ev.recordtypeId=rtmap.get('OF_CQS_Interferenza_Sottoservizi');
            }
               /*
               else if(optScelta=='Infortunio'){
                ev.recordtypeId=rtmap.get('OF_CQS_Infortunio');
            } 
            */
                   
            try{
                insert ev;
                List<OF_CQS_Evento__c> evento = [Select OF_CQS_Stato_Pratica__c,CQS_Ev_Skip_Controller__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =: ev.id limit 1];
                statoPratica= evento.get(0).OF_CQS_Stato_Pratica__c;
                
                system.debug('siamo nel try del metodo salvaEvento.id evento vale: ' + ev.id + 'lo stato pratica è ' +  evento.get(0).OF_CQS_Stato_Pratica__c);
                system.debug('@@@@@@@ evento: '+ev);
                system.debug('@@@@@@@@@ stato pratica: ' + ev.OF_CQS_Stato_Pratica__c + 'la variabile stato pratica è: ' + statoPratica);
                inviaMailgen(statoPratica);
                system.debug('siamo nel metodo salvaEvento, abbiamo appena chiamato il metodo inviaMailgen');
                changeStatoP(statoPratica);
                system.debug('siamo nel metodo salvaEvento, abbiamo appena chiamato il metodo changeStatoP');
                updateRTEvento(ev.OF_CQS_Stato_Pratica__c);
                system.debug('siamo nel metodo salvaEvento, abbiamo appena chiamato il metodo changeOwner');
                changeOwner(ev.OF_CQS_Stato_Pratica__c);
                System.debug('@@@@stiamo per chiamare il metodo di updateRTEvento, gli passiamo ev.OF_CQS_Stato_Pratica__c, che vale ' + ev.OF_CQS_Stato_Pratica__c);
                Schema.DescribeSObjectResult result = OF_CQS_Evento__c.SObjectType.getDescribe();
                pageRef = new PageReference('/' + result.getKeyPrefix()+ '/o');
                system.debug('@@@@@ La pageRef nel try del salvaEvento è: '+ pageRef);
                pageRef.setRedirect(true);
                return pageRef;
            }
            catch(System.DMLException e) {
                
                for (Integer i = 0; i < e.getNumDml(); i++) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(i)));
                system.debug('@@@@@ La pageRef nel catch del salvaEvento è: '+ pageRef);
                return null;
              
                }
            }
        }
        return  null;
        }   
        
        public PageReference salvaEventoSuccessivo(){
             system.debug('siamo nel metodo salvaEventoSuccessivo 1. L\'id dell\'evento è: ' + ev.Id);
            
            //string idEvStr = ApexPages.currentPage().getParameters().get('Id');
            //system.debug('La stringa dell\'idEvStr è così valorizzata:' + idEvStr);
            List<OF_CQS_Evento__c> evento = [Select Id, name, CQS_Ev_Progetto__c, 
                                                                CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
                                                                Owner.Name, recordType.DeveloperName, recordType.Name,
                                                                recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
                                                                OF_CQS_Impresa_Esecutrice_Eventi__c, 
                                                                OF_CQS_Impresa_Mandataria__r.Name, OF_CQS_Impresa_Esecutrice_Eventi__r.Name, 
                                             					OF_CQS_Stato_Pratica__c,CQS_Ev_Skip_Controller__c, OF_CQS_Comune_Text__c,
                                             					CQS_Ev_Lettera_D_Ordine__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =:  ev.Id  limit 1];
            statoPratica= evento.get(0).OF_CQS_Stato_Pratica__c;
            system.debug('siamo nel metodo salvaEventoSuccessivo 2. L\'id dell\'evento è: ' + evento.get(0).id + '.  Il progetto è: ' + evento.get(0).CQS_Ev_Progetto__c + ', il comune selezionato è ' + evento.get(0).OF_CQS_Comune_Text__c + 'la lettera d\'ordine è ' + evento.get(0).CQS_Ev_Lettera_D_Ordine__c +'la mandataria associata è '+ evento.get(0).OF_CQS_Impresa_Mandataria__r.Name);
            
            PageReference pageRef;
        
       
            ev.CQS_ev_Tipo_Allegato__c=optTipoAtt;
                   
            try{
                system.debug('siamo nel try del metodo salvaEventoSuccessivo');
                system.debug('@@@@@@@ evento: '+ev);
                inviaMailgen(statoPratica);
                system.debug('siamo nel metodo salvaEventoSuccessivo, abbiamo appena chiamato il metodo inviaMailgen. Lo stato pratica è: ' + ev.OF_CQS_Stato_Pratica__c );
                changeStatoP(statoPratica);
                update ev;
                system.debug('siamo nel metodo salvaEventosuccessivo, abbiamo appena chiamato il metodo changeStatoP');
                updateRTEvento(ev.OF_CQS_Stato_Pratica__c);
                system.debug('siamo nel metodo salvaEventosuccessivo, abbiamo appena chiamato il metodo changeOwner');
                changeOwner(ev.OF_CQS_Stato_Pratica__c);
              //  update ev;
                Schema.DescribeSObjectResult result = OF_CQS_Evento__c.SObjectType.getDescribe();
            //  pageRef = new PageReference('/' + result.getKeyPrefix()+ '/o');
              //  pageRef = new PageReference('javascript: window.close()');
              pageRef = new PageReference('/' + result.getKeyPrefix()+ '/o');
                system.debug('@@@@@ La pageRef nel try del salvaEvento è: '+ pageRef);
                pageRef.setRedirect(true);
                
            }
            catch(System.DMLException e) {
                
                for (Integer i = 0; i < e.getNumDml(); i++) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(i)));
                system.debug('@@@@@ La pageRef nel catch del salvaEvento è: '+ pageRef);
                pageRef= null;
              
                }
            }
        return  pageRef;
        }
    //EC - 2018 - 06 -21    
        public PageReference ricusaIntegrazione(){
                system.debug('siamo nel metodo salvaEventoSuccessivo. L\'id dell\'evento è: ' + ev.Id + '.  Il progetto è: ' + projectName + ', il comune selezionato è ' + selectedIdComune + 'la lettera d\'ordine è ' + jnldo +'la mandataria associata è '+ Snjun);
            //string idEvStr = ApexPages.currentPage().getParameters().get('Id');
            //system.debug('La stringa dell\'idEvStr è così valorizzata:' + idEvStr);
            List<OF_CQS_Evento__c> evento = [Select Id, name, CQS_Ev_Progetto__c, 
                                                                CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
                                                                Owner.Name, recordType.DeveloperName, recordType.Name,
                                                                recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
                                                                OF_CQS_Impresa_Esecutrice_Eventi__c, 
                                                                OF_CQS_Impresa_Mandataria__r.Name, OF_CQS_Impresa_Esecutrice_Eventi__r.Name, 
                                             					OF_CQS_Stato_Pratica__c,CQS_Ev_Skip_Controller__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =:  ev.Id  limit 1];
            statoPratica= evento.get(0).OF_CQS_Stato_Pratica__c;
            PageReference pageRef;
            List<recordType> rtStringList = [select DeveloperName from RecordType where SobjectType = 'OF_CQS_Evento__c' AND Id =: ev.RecordTypeId Limit 1];
            String stringaRt= rtStringList.get(0).DeveloperName;
        
       
            ev.CQS_ev_Tipo_Allegato__c=optTipoAtt;
                   
            try{
                system.debug('siamo nel try del metodo salvaEventoSuccessivo');
                system.debug('@@@@@@@ evento: '+ev);
                invioMailApertaLieve('rifiutato');
                system.debug('siamo nel metodo salvaEventoSuccessivo, abbiamo appena chiamato il metodo inviaMailgen. Lo stato pratica è: ' + evento.get(0).OF_CQS_Stato_Pratica__c );
                ev.OF_CQS_Stato_Pratica__c='In Lavorazione';
                update ev;    
                system.debug('siamo nel metodo salvaEventosuccessivo, abbiamo appena chiamato il metodo changeStatoP');
               
                
                    if(stringaRt.equals('Bad_Practice_Integrata')){
                        ev.RecordTypeId= rtmap.get('Bad_Practice_in_Lavorazione');
                    }
                    else if(stringaRt.equals('Danneggiamento_a_Terzi_Integrata')){
                        ev.RecordTypeId= rtmap.get('Danneggiamento_a_Terzi_in_Lavorazione');
                    }
                    else if(stringaRt.equals('Interferenza_a_Sotto_servizi_Integrata')){
                        ev.RecordTypeId= rtmap.get('Interferenza_a_Sotto_servizi_in_Lavorazione');
                    }
                changeOwner(ev.OF_CQS_Stato_Pratica__c);
                system.debug('siamo nel metodo salvaEventosuccessivo, abbiamo appena chiamato il metodo changeOwner');
                //update ev;
                Schema.DescribeSObjectResult result = OF_CQS_Evento__c.SObjectType.getDescribe();
                pageRef = new PageReference('/' + result.getKeyPrefix()+ '/o');
                system.debug('@@@@@ La pageRef nel try del salvaEvento è: '+ pageRef);
                pageRef.setRedirect(true);
                
            }
            catch(System.DMLException e) {
                
                for (Integer i = 0; i < e.getNumDml(); i++) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(i)));
                system.debug('@@@@@ La pageRef nel catch del salvaEvento è: '+ pageRef);
                pageRef= null;
              
                }
            }
        return  pageRef;
        }
    //EC - end METODO RIFIUTA INTEGRAZIONE
        
        /*
        public ApexPages showMessage(DMLException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(i)));
                //system.debug(pageRef);
                //pageRef= null;
                return ApexPages.addmessage;
                }
        salvaEvento();
        
        }
        */
    
    public String searchTerm {get; set;}
    public String selectedIdComune {get; set;}
    
    
    // JS Remoting action called when searching
    @RemoteAction
    public static List<OF_ElencoComuniItaliani__c > searchComune(String searchTerm) {
        // System.debug('Comune Name is: '+searchTerm );
        List<OF_ElencoComuniItaliani__c > eventList = Database.query('SELECT Id,OF_Comune__c,OF_Provincia__c  FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm) + '%\'  order by OF_Comune__c ASC ' );
        
        System.debug('eventList : '+eventList );
        return eventList ;
        
    }
    
    /* public OF_ElencoComuniItaliani__c getComune()
{
OF_ElencoComuniItaliani__c ag = [SELECT Id,OF_Comune__c  FROM OF_ElencoComuniItaliani__c where id =: 'selectedIdComune' limit 1];
return ag;
    }*/
        
    public pageReference defineLDO(){
          //  definisciProgettiPl();
          system.debug('++++++' + projectName);
             Map<String,String> ldoMap = new Map<String, String>();
              Map<String,String> regMap = new Map<String, String>();
            for(CQS_Prog_An_junc__c jpu2: [select CQS_Praju_LDO__c,CQS_Praj_Progetto__r.Name,CQS_Praj_Ragione_Sociale__c
                                                 from CQS_Prog_An_junc__c where CQS_Praj_Progetto__c=:projectName ] ){
            ldoMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praju_LDO__c );
             regMap.put(jpu2.CQS_Praj_Progetto__c,jpu2.CQS_Praj_Ragione_Sociale__c);
           // ev.CQS_Ev_Lettera_D_Ordine__c=ldoMap.get(jpu2.CQS_junc_progetto__c);
            
            }
              ev.CQS_Ev_Lettera_D_Ordine__c=ldoMap.get(projectName);
              ev.OF_CQS_Impresa_Mandataria__c=regMap.get(projectName);
              system.debug('Testin'+ ldoMap);     
              return null;
            //return ev.CQS_Ev_Lettera_D_Ordine__c=ldoMap.get(projectName);
    
    }
    /*
    //JD/EC
    
    // creates a new CQS_Allegati__c record
    private Database.SaveResult saveCustomAttachment() {
        
        CQS_Allegati__c obj = new CQS_Allegati__c();
        obj.CQS_All_ev__c = ev.Id; //masterdetail su evento
        obj.CQS_All_Descrizione__c = description;
        obj.CQS_All_Tipo_Allegato__c = selectedType; //in caso da cambiare con optTipoAtt
    //    obj.awesome__c = selectedAwesomeness;
        // fill out cust obj fields
        return Database.insert(obj);
    }
    
    // create an actual Attachment record with the Contact_Attachment__c as parent
    private Database.SaveResult saveStandardAttachment(Id parentId) {
        Database.SaveResult result;
        
        Attachment attachment = new Attachment();
        attachment.body = this.fileBody;
        attachment.name = this.fileName;
        attachment.parentId = parentId;
        // inser the attahcment
        result = Database.insert(attachment);
        // reset the file for the view state
        fileBody = Blob.valueOf(' ');
        return result;
    }
    
    /**
    * Upload process is:
    *  1. Insert new Contact_Attachment__c record
    *  2. Insert new Attachment with the new Contact_Attachment__c record as parent
    *  3. Update the Contact_Attachment__c record with the ID of the new Attachment
    **/
    /*
    public PageReference processUpload() {
        try {
            Database.SaveResult customAttachmentResult = saveCustomAttachment();
        
            if (customAttachmentResult == null || !customAttachmentResult.isSuccess()) {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Could not save attachment.'));
                return null;
            }
        
            Database.SaveResult attachmentResult = saveStandardAttachment(customAttachmentResult.getId());
        
            if (attachmentResult == null || !attachmentResult.isSuccess()) {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Could not save attachment.'));            
                return null;
            } else {
                // update the custom attachment record with some attachment info
                CQS_Allegati__c customAttachment = [select id from CQS_Allegati__c where id = :customAttachmentResult.getId()];
                customAttachment.name = this.fileName;
                customAttachment.CQS_Ev_Allegato__c = attachmentResult.getId();
                update customAttachment;
            }
        
        } catch (Exception e) {
            ApexPages.AddMessages(e);
            return null;
        }
        
        return new PageReference('/'+ev.Id);
    }
    
    public PageReference back() {
        return new PageReference('/'+ev.Id);
    } 
        */
    
    public static Set<ID> getUserRoleSup(ID cmRole){
        system.debug('siamo nel metodo getUserRoleSup');
        Set<Id> roleIds = new Set<Id>();
        
        UserRole ur =[select Id, ParentRoleId from UserRole where Id =: cmRole limit 1];
        roleIds.add(ur.ParentRoleId);
        system.debug('cmRole vale: ' + cmRole + ' il parentRoleId di cmRole è ' + ur.ParentRoleId);
        
        UserRole ur2 =[select Id, ParentRoleId from UserRole where Id =: ur.ParentRoleId limit 1];
        roleIds.add(ur2.ParentRoleId);
        system.debug('ur.ParentRole: ' + cmRole + ' il parentRoleId è ' + ur2.ParentRoleId);        
        
        UserRole ur3 =[select Id, ParentRoleId from UserRole where Id =: ur2.ParentRoleId limit 1];
        roleIds.add(ur3.ParentRoleId);
        system.debug('cmRole vale: ' + cmRole + ' il parentRoleId  è ' + ur3.ParentRoleId);
        return roleIds;
        
    }
        
      public void invioMailAperta(){  
        System.debug('@@@@@@@@@ è stato chiamato il metodo invioMailAperta');
        List<OF_CQS_Evento__c> evento = [Select Id, name, CQS_Ev_Progetto__c, 
                                                                CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
                                                                Owner.Name, recordType.DeveloperName, recordType.Name,
                                                                recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
                                                                OF_CQS_Impresa_Esecutrice_Eventi__c, 
                                                                OF_CQS_Impresa_Mandataria__r.Name, OF_CQS_Impresa_Esecutrice_Eventi__r.Name,
                                                                OF_CQS_Diffida__c, OF_CQS_Richiesta_Danni__c,OF_CQS_Inadempienze_Operative__c,
                                                                OF_CQS_ev_Segnalazione_Comune__c,CQS_Ev_Skip_Controller__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =: ev.id limit 1];
        String rtDn = evento.get(0).recordType.DeveloperName;
        String stringaCheckbox ='';
        if(rtDn.contains('Bad_Practice')){
              
              if(evento.get(0).OF_CQS_Diffida__c){
                  stringaCheckbox= 'Diffida';
              }
              if(evento.get(0).OF_CQS_Richiesta_Danni__c){
                  stringaCheckbox+= ' Richiesta Danni';
              }
              if(evento.get(0).OF_CQS_Inadempienze_Operative__c){
                  stringaCheckbox+= ' Inadempienze Operative';
              }
              if(evento.get(0).OF_CQS_ev_Segnalazione_Comune__c){
                  stringaCheckbox+= ' Segnalazione Comune';
              }
              
         }          
                
                
        List<String> listStrinf=new List<String>();
        listStrinf.add(etInfortunio);
        listStrinf.add(etDanni_Iss_L_M);
        Map<String,EmailTemplate> mappaOut= CQS_Utils.ritornaTemplates(listStrinf);
        
        List<Id> listProg=new List<Id>();
        listProg.add(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista contiene ' + listProg.size() +'progetti' );
        System.debug('@@@@@@@@@@ i progetti aggiunti al set sono' + evento.get(0).CQS_Ev_Progetto__c );
        Map<Id,List<ID>> progUtDestPuJMap= CQS_Utils.getUListPro(listProg);
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); //commenta riga 345
       
        List<Id> listTargetUser=progUtDestPuJMap.get(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista listTargetUser contiene ' + listTargetUser.size() +'user' );
        List<Id> listAddUser=listTargetUser;
        System.debug('@@@@@@@@@@ la lista listAddUser contiene ' + listAddUser.size() +'user' );
        Set<Id> listaRuoliSuperiori= new Set<Id>();
        system.debug('@@@@@ Siamo nel caso dell\'indice di gravità alta');
        for(User userX:[select id, UserRoleId, UserRole.Name from User where Id=:listTargetUser and (UserRoleId!='' and UserRoleId!=null)]){
            if(userX.UserRole.Name.contains(cmStr)){
                listaRuoliSuperiori.addAll(getUserRoleSup(userX.UserRoleId));
                system.debug('@@@@@ Gli utenti sono' + listaRuoliSuperiori);
                listaRuoliSuperiori.remove(userX.id);
                system.debug('@@@@@ Gli utenti dopo il remove sono' + listaRuoliSuperiori);
            }
        }
        List<User> listUser=[Select id, Name from User Where UserRoleId=:listaRuoliSuperiori];
        for(User li:listUser){
            listAddUser.add(li.id);
            System.debug('@@@@@@@@@@ prendiamo gli user li: ' + li.Name);
        }
        System.debug('@@@@@@@@@@ la lista listAddUser, con l\'aggiunta di user con ruolo superiore contiene infine ' + listAddUser.size() +' user' );
          
        system.debug('la lista listAddUser è così popolata: ' + listAddUser);    
        for(Id idd:listAddUser){    
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setSubject('Evento Inserito');
            singleMail.setSaveAsActivity(false);
            singleMail.setTargetObjectId(idd);  
            System.debug('@@@@@@@@@ l\' id degli user è: '+ idd);        
            String nameTemplate=(evento.get(0).recordType.DeveloperName).equals(eInf)?etInfortunio:etDanni_Iss_L_M;
            EmailTemplate eT=new EmailTemplate();
            eT=mappaOut.get(nameTemplate);
            System.debug('@@@@@ stiamo scegliendo il seguente emailTemplate' + eT);
            System.debug('@@@@@ stiamo scegliendo l\'emailTemplate sulla base del recordType');
            singleMail.setTemplateId(eT.Id); 
            System.debug('@@@@@ stiamo settando l\'id dell\'emailTemplate');
            System.debug('@@@@@@@@@ EV è: '+ evento.get(0));
            singleMail.setSenderDisplayName(evento.get(0).Owner.Name);
                
            String plainBody = eT.Body;
            //plainBody=plainBody.replaceAll('OF_CQS_Evento__c','ev');
            System.debug('@@@@eTBody: ' + eT.Body);
            System.debug('@@@@plainBody: ' + plainBody);
            plainBody = plainBody.replace('inserito', 'messo in lavorazione');
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', evento.get(0).RecordType.Name + ': ' + stringaCheckbox );
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Name}', evento.get(0).Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Mandataria__c}', evento.get(0).OF_CQS_Impresa_Mandataria__r.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Esecutrice_Eventi__c}', evento.get(0).OF_CQS_Impresa_Esecutrice_Eventi__r.Name);
            if((!(evento.get(0).recordType.DeveloperName.equals(eBadP)))&& (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Aperta'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Chiusa'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Integrata'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_in_Lavorazione')))){
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c);
            }
            else {
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', 'L - Lieve');
            }
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OwnerFullName}',evento.get(0).Owner.Name);
           // plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs87.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //sviluppo
           //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://collaudo--eofdev.cs83.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //Collaudo
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://openfiber-it.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //produzione
                //END EC2
            
           // singleMail.setHtmlBody(eT.HtmlValue);
            // singleMail.setHtmlBody(htmlBody);
            //singleMail.setPlainTextBody(eT.body);
            singleMail.setPlainTextBody(plainBody);
             //End EC
                     
                emails.add(singleMail);
                system.debug('Abbiamo appena inserito nella lista di email le SingleEmail, questa è l\'ultima operazione prima di uscire dal FOR');
           } 
           
        System.debug('@@@@@@@@@@ la lista contiene ' + emails.size() +' email' );
        Messaging.sendEmail(emails); 
       System.debug('@@@@@@@@@@ sono state inviate ' + emails.size() +' email' );
    
    }
    
    public void invioMailApertaLieve(String statoS){  
        System.debug('@@@@@@@@@ è stato chiamato il metodo invioMailAperta');
        List<OF_CQS_Evento__c> evento = [Select Id, name, CQS_Ev_Progetto__c, 
                                                                CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
                                                                Owner.Name, recordType.DeveloperName, recordType.Name,
                                                                recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
                                                                OF_CQS_Impresa_Esecutrice_Eventi__c, 
                                                                OF_CQS_Impresa_Mandataria__r.Name, OF_CQS_Impresa_Esecutrice_Eventi__r.Name,
                                                                OF_CQS_Diffida__c, OF_CQS_Richiesta_Danni__c,OF_CQS_Inadempienze_Operative__c,
                                                                OF_CQS_ev_Segnalazione_Comune__c,CQS_Ev_Skip_Controller__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =: ev.id limit 1];
        String rtDn = evento.get(0).recordType.DeveloperName;
        System.debug('String rtDN, valorizzato con  String rtDn = evento.get(0).recordType.DeveloperName. String rtDn: ' + rtDn + '  evento.get(0).recordType.DeveloperName: ' +  evento.get(0).recordType.DeveloperName);
        String stringaCheckbox ='';
        System.debug('i valori della checkbox di Bad Practice sono: per evento.get(0).OF_CQS_Diffida__c: ' + evento.get(0).OF_CQS_Diffida__c +'; evento.get(0).OF_CQS_Richiesta_Danni__c: ' + evento.get(0).OF_CQS_Richiesta_Danni__c +'; (evento.get(0).OF_CQS_Inadempienze_Operative__c: )' + (evento.get(0).OF_CQS_Inadempienze_Operative__c) + '; evento.get(0).OF_CQS_ev_Segnalazione_Comune__c: ' + evento.get(0).OF_CQS_ev_Segnalazione_Comune__c);
        if(rtDn.contains('Bad_Practice')){
              
              if(evento.get(0).OF_CQS_Diffida__c){
                  stringaCheckbox= 'Diffida';
              }
              if(evento.get(0).OF_CQS_Richiesta_Danni__c){
                  stringaCheckbox+= ' Richiesta Danni';
              }
              if(evento.get(0).OF_CQS_Inadempienze_Operative__c){
                  stringaCheckbox+= ' Inadempienze Operative';
              }
              if(evento.get(0).OF_CQS_ev_Segnalazione_Comune__c){
                  stringaCheckbox+= ' Segnalazione Comune';
              }
              
         }
        List<String> listStrinf=new List<String>();
        listStrinf.add(etInfortunio);
        listStrinf.add(etDanni_Iss_L_M);
        Map<String,EmailTemplate> mappaOut= CQS_Utils.ritornaTemplates(listStrinf);
        
        List<Id> listProg=new List<Id>();
        listProg.add(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista contiene ' + listProg.size() +'progetti' );
        System.debug('@@@@@@@@@@ i progetti aggiunti al set sono' + evento.get(0).CQS_Ev_Progetto__c );
        Map<Id,List<ID>> progUtDestPuJMap= CQS_Utils.getUListPro(listProg);
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); //commenta riga 345
       
        List<ID> listTargetUser=progUtDestPuJMap.get(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista listTargetUser contiene ' + listTargetUser.size() +'user' );
        List<Id> listAddUser= new List<Id>();
        System.debug('@@@@@@@@@@ la lista listAddUser contiene ' + listAddUser.size() +'user' );
        Set<Id> listaRuoliSuperiori= new Set<Id>();
        system.debug('@@@@@ Siamo nel caso dell\'indice di gravità alta');
        for(User userX:[select id, UserRoleId, UserRole.Name from User where Id=:listTargetUser and (UserRoleId!='' and UserRoleId!=null)]){
            if(userX.UserRole.Name.contains(cseStr)){
                listAddUser.add(userX.Id);
                //rimane ancora da aggiungere l'ente
                system.debug('@@@@@ Gli utenti sono' + listAddUser);
            }
        }
        System.debug('@@@@@@@@@@ la lista listAddUser, con l\'aggiunta di user con ruolo superiore contiene infine ' + listAddUser.size() +'user' );
        for(Id idd:listAddUser){    
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setSubject('Evento Inserito');
            singleMail.setSaveAsActivity(false);
            singleMail.setTargetObjectId(idd);  
            System.debug('@@@@@@@@@ l\' id degli user è: '+ idd);        
            String nameTemplate=(evento.get(0).recordType.DeveloperName).equals(eInf)?etInfortunio:etDanni_Iss_L_M;
            EmailTemplate eT=new EmailTemplate();
            eT=mappaOut.get(nameTemplate);
            System.debug('@@@@@ stiamo scegliendo il seguente emailTemplate' + eT);
            System.debug('@@@@@ stiamo scegliendo l\'emailTemplate sulla base del recordType');
            singleMail.setTemplateId(eT.Id); 
            System.debug('@@@@@ stiamo settando l\'id dell\'emailTemplate');
            
         
            System.debug('@@@@@@@@@ EV è: '+ evento.get(0));
                    //EC
            singleMail.setSenderDisplayName(evento.get(0).Owner.Name);
                
            String plainBody = eT.Body;
            //plainBody=plainBody.replaceAll('OF_CQS_Evento__c','ev');
            System.debug('@@@@eTBody: ' + eT.Body);
            System.debug('@@@@plainBody: ' + plainBody);
            if(statoS=='rifiutato'){
            plainBody = plainBody.replace('inserito', 'rifiutato');    
            }
            else{
            plainBody = plainBody.replace('inserito', 'messo in lavorazione');
            }
            if((!(evento.get(0).recordType.DeveloperName.equals(eBadP)))&& (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Aperta'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Chiusa'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Integrata'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_in_Lavorazione')))){
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', evento.get(0).RecordType.Name);
            }
            else{
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', evento.get(0).RecordType.Name /*+ ': ' + stringaCheckbox*/ );     
            }
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Name}', evento.get(0).Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Mandataria__c}',  evento.get(0).OF_CQS_Impresa_Mandataria__r.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Esecutrice_Eventi__c}', evento.get(0).OF_CQS_Impresa_Esecutrice_Eventi__r.Name);
            if((!(evento.get(0).recordType.DeveloperName.equals(eBadP)))&& (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Aperta'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Chiusa'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Integrata'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_in_Lavorazione')))){
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c);
            }
            else {
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', 'L - Lieve');
            }
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OwnerFullName}', evento.get(0).Owner.Name);
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs87.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>');//sviluppo
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://collaudo--eofdev.cs83.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //Collaudo
 		    plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://openfiber-it.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>');//produzione
                 //END EC2
            
           // singleMail.setHtmlBody(eT.HtmlValue);
            // singleMail.setHtmlBody(htmlBody);
            //singleMail.setPlainTextBody(eT.body);
            singleMail.setPlainTextBody(plainBody);
             //End EC
                     
                emails.add(singleMail);
                system.debug('Abbiamo appena inserito nella lista di email le SingleEmail, questa è l\'ultima operazione prima di uscire dal FOR');
           } 
           
        System.debug('@@@@@@@@@@ la lista contiene ' + emails.size() +' email' );
        Messaging.sendEmail(emails); 
       System.debug('@@@@@@@@@@ sono state inviate ' + emails.size() +' email' );
    
    }
    
    /* Invio Email CM
    
    */
    
    public void invioMailInserita(String statoS){
        System.debug('@@@@@@@@@ è stato chiamato il metodo invioMailInserita');
        List<OF_CQS_Evento__c> evento = [Select Id, name, CQS_Ev_Progetto__c, 
                                                                CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
                                                                Owner.Name, recordType.DeveloperName, recordType.Name,
                                                                recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
                                                                OF_CQS_Impresa_Esecutrice_Eventi__c, 
                                                                OF_CQS_Impresa_Mandataria__r.Name, OF_CQS_Impresa_Esecutrice_Eventi__r.Name,
                                                                OF_CQS_Diffida__c, OF_CQS_Richiesta_Danni__c,OF_CQS_Inadempienze_Operative__c,
                                                                OF_CQS_ev_Segnalazione_Comune__c,CQS_Ev_Skip_Controller__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =: ev.id limit 1];
        String rtDn = evento.get(0).recordType.DeveloperName;
        System.debug('String rtDN, valorizzato con  String rtDn = evento.get(0).recordType.DeveloperName. String rtDn: ' + rtDn + '  evento.get(0).recordType.DeveloperName: ' +  evento.get(0).recordType.DeveloperName);
        String stringaCheckbox ='';
        System.debug('i valori della checkbox di Bad Practice sono: per evento.get(0).OF_CQS_Diffida__c: ' + evento.get(0).OF_CQS_Diffida__c +'; evento.get(0).OF_CQS_Richiesta_Danni__c: ' + evento.get(0).OF_CQS_Richiesta_Danni__c +'; (evento.get(0).OF_CQS_Inadempienze_Operative__c: )' + (evento.get(0).OF_CQS_Inadempienze_Operative__c) + '; evento.get(0).OF_CQS_ev_Segnalazione_Comune__c: ' + evento.get(0).OF_CQS_ev_Segnalazione_Comune__c);
        if(rtDn.contains('Bad_Practice')){
              
              if(evento.get(0).OF_CQS_Diffida__c){
                  stringaCheckbox= 'Diffida';
              }
              if(evento.get(0).OF_CQS_Richiesta_Danni__c){
                  stringaCheckbox+= ' Richiesta Danni';
              }
              if(evento.get(0).OF_CQS_Inadempienze_Operative__c){
                  stringaCheckbox+= ' Inadempienze Operative';
              }
              if(evento.get(0).OF_CQS_ev_Segnalazione_Comune__c){
                  stringaCheckbox+= ' Segnalazione Comune';
              }
              
         }      List<String> listStrinf=new List<String>();
        listStrinf.add(etInfortunio);
        listStrinf.add(etDanni_Iss_L_M);
        Map<String,EmailTemplate> mappaOut= CQS_Utils.ritornaTemplates(listStrinf);
        system.debug('la mappa degli email template è popolata così: ' + mappaOut );
        
        List<Id> listProg=new List<Id>();
        
        listProg.add(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista contiene ' + listProg.size() +'progetti' );
        System.debug('@@@@@@@@@@ i progetti aggiunti al set sono' + evento.get(0).CQS_Ev_Progetto__c );
                 
        Map<Id,List<ID>> progUtDestPuJMap= CQS_Utils.getUListPro(listProg);
        system.debug('la mappa progUtDestPuJMap è così valorizzata:' + progUtDestPuJMap);
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); //commenta riga 345
         
        List<Id> listTargetUser= progUtDestPuJMap.get(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista listTargetUser contiene ' + listTargetUser.size() +'user' );
        List<Id> listAddUser= new List<ID>();
        System.debug('@@@@@@@@@@ la lista listAddUser contiene ' + listAddUser.size() +'user' );
        Set<Id> listaRuoliSuperiori= new Set<Id>();
        system.debug('la listatargetUser prima del for che va in errore è così popolata: ' + listTargetUser);
        for(User userX:[select id, UserRoleId, UserRole.Name from User where Id=:listTargetUser and UserRoleId!=null]){
            system.debug('gli userRoleName sono: ' + userX.UserRole.Name);
            if(userX.UserRole.Name.contains(cmStr)){
                
                listAddUser.add(userX.id);
                system.debug('@@@@@ Gli utenti sono' + listAddUser);
             }
        }
                    
        for(Id idd:listAddUser){    
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setSubject('Evento Inserito');
            singleMail.setSaveAsActivity(false);
            singleMail.setTargetObjectId(idd);  
            System.debug('@@@@@@@@@ l\' id degli user è: '+ idd);        
            String nameTemplate=(evento.get(0).recordType.DeveloperName).equals(eInf)?etInfortunio:etDanni_Iss_L_M;
            EmailTemplate eT=new EmailTemplate();
            eT=mappaOut.get(nameTemplate);
            System.debug('@@@@@ stiamo scegliendo il seguente emailTemplate' + eT);
            System.debug('@@@@@ stiamo scegliendo l\'emailTemplate sulla base del recordType');
            singleMail.setTemplateId(eT.Id); 
            System.debug('@@@@@ stiamo settando l\'id dell\'emailTemplate');

         
            System.debug('@@@@@@@@@ EV è: '+evento.get(0));
                    //EC
            singleMail.setSenderDisplayName(evento.get(0).Owner.Name);

            String plainBody = eT.Body;
            //plainBody=plainBody.replaceAll('OF_CQS_Evento__c','ev');
            System.debug('@@@@eTBody: ' + eT.Body);
            System.debug('@@@@plainBody: ' + plainBody);
            if(statoS=='in lavorazione'){
            plainBody = plainBody.replace('inserito', 'lavorato');    
            }
            if((!(evento.get(0).recordType.DeveloperName.equals(eBadP)))&& (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Aperta'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Chiusa'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Integrata'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_in_Lavorazione')))){
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', evento.get(0).RecordType.Name);
            }
            else{
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', evento.get(0).RecordType.Name + ' - ' + stringaCheckbox );     
            }
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Name}', evento.get(0).Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Mandataria__c}',evento.get(0).OF_CQS_Impresa_Mandataria__r.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Esecutrice_Eventi__c}', evento.get(0).OF_CQS_Impresa_Esecutrice_Eventi__r.Name);
            if((!(evento.get(0).recordType.DeveloperName.equals(eBadP)))&& (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Aperta'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Chiusa'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Integrata'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_in_Lavorazione')))){
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c);
            }
            else {
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', 'L - Lieve');
            }
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OwnerFullName}', evento.get(0).Owner.Name);
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs87.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //Sviluppo
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://collaudo--eofdev.cs83.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //Collaudo
          	plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://openfiber-it.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //produzione
            //END EC2

           // singleMail.setHtmlBody(eT.HtmlValue);
            // singleMail.setHtmlBody(htmlBody);
            //singleMail.setPlainTextBody(eT.body);
            singleMail.setPlainTextBody(plainBody);
             //End EC


            
            emails.add(singleMail);
            system.debug('Abbiamo appena inserito nella lista di email le SingleEmail, questa è l\'ultima operazione prima di uscire dal FOR');
        } 
        System.debug('@@@@@@@@@@ la lista contiene ' + emails.size() +' email' );
        Messaging.sendEmail(emails); 
        System.debug('@@@@@@@@@@ sono state inviate ' + emails.size() +' email' );
    
    }
    //to check con Claudio - EC
        public void invioMailIntegrata(){
            System.debug('@@@@@@@@@ è stato chiamato il metodo invioMailInserita');
        List<OF_CQS_Evento__c> evento = [Select Id, name, CQS_Ev_Progetto__c, 
                                                                CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
                                                                Owner.Name, recordType.DeveloperName, recordType.Name,
                                                                recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
                                                                OF_CQS_Impresa_Esecutrice_Eventi__c, 
                                                                OF_CQS_Impresa_Mandataria__r.Name, OF_CQS_Impresa_Esecutrice_Eventi__r.Name,
																CQS_Ev_Skip_Controller__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =: ev.id];
        List<String> listStrinf=new List<String>();
        listStrinf.add(etInfortunio);
        listStrinf.add(etDanni_Iss_L_M);
        Map<String,EmailTemplate> mappaOut= CQS_Utils.ritornaTemplates(listStrinf);
        
        List<Id> listProg=new List<Id>();
        
        listProg.add(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista contiene ' + listProg.size() +'progetti' );
        System.debug('@@@@@@@@@@ i progetti aggiunti al set sono' + evento.get(0).CQS_Ev_Progetto__c );
                 
        Map<Id,List<ID>> progUtDestPuJMap= CQS_Utils.getUListPro(listProg);
        system.debug('la mappa progUtDestPuJMap è così valorizzata:' + progUtDestPuJMap);
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); //commenta riga 345
         
        List<Id> listTargetUser= progUtDestPuJMap.get(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista listTargetUser contiene ' + listTargetUser.size() +'user' );
        List<Id> listAddUser= new List<ID>();
        System.debug('@@@@@@@@@@ la lista listAddUser contiene ' + listAddUser.size() +'user' );
        Set<Id> listaRuoliSuperiori= new Set<Id>();
        system.debug('la listatargetUser prima del for che va in errore è così popolata: ' + listTargetUser);
        for(User userX:[select id, UserRoleId, UserRole.Name from User where Id=:listTargetUser and UserRoleId!=null]){
            system.debug('gli userRoleName sono: ' + userX.UserRole.Name);
            if(userX.UserRole.Name.contains(cmStr)){
                
                listAddUser.add(userX.id);
                system.debug('@@@@@ Gli utenti sono' + listAddUser);
             }
        }
                    
        for(Id idd:listAddUser){    
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setSubject('Evento Inserito');
            singleMail.setSaveAsActivity(false);
            singleMail.setTargetObjectId(idd);  
            System.debug('@@@@@@@@@ l\' id degli user è: '+ idd);        
            String nameTemplate=(evento.get(0).recordType.DeveloperName).equals(eInf)?etInfortunio:etDanni_Iss_L_M;
            EmailTemplate eT=new EmailTemplate();
            eT=mappaOut.get(nameTemplate);
            System.debug('@@@@@ stiamo scegliendo il seguente emailTemplate' + eT);
            System.debug('@@@@@ stiamo scegliendo l\'emailTemplate sulla base del recordType');
            singleMail.setTemplateId(eT.Id); 
            System.debug('@@@@@ stiamo settando l\'id dell\'emailTemplate');

         
            System.debug('@@@@@@@@@ EV è: '+evento.get(0));
                    //EC
            singleMail.setSenderDisplayName(evento.get(0).Owner.Name);

            String plainBody = eT.Body;
            //plainBody=plainBody.replaceAll('OF_CQS_Evento__c','ev');
            System.debug('@@@@eTBody: ' + eT.Body);
            System.debug('@@@@plainBody: ' + plainBody);
            
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', evento.get(0).recordType.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Name}', evento.get(0).Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Mandataria__c}',evento.get(0).OF_CQS_Impresa_Mandataria__r.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Esecutrice_Eventi__c}', evento.get(0).OF_CQS_Impresa_Esecutrice_Eventi__r.Name);
            if((!(evento.get(0).recordType.DeveloperName.equals(eBadP)))&& (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Aperta'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Chiusa'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Integrata'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_in_Lavorazione')))){
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c);
            }
            else {
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', 'L - Lieve');
            }
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OwnerFullName}', evento.get(0).Owner.Name);
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs87.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>');//Sviluppo
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://collaudo--eofdev.cs83.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //Collaudo     
          	plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://openfiber-it.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //produzione
            //END EC2

           // singleMail.setHtmlBody(eT.HtmlValue);
            // singleMail.setHtmlBody(htmlBody);
            //singleMail.setPlainTextBody(eT.body);
            singleMail.setPlainTextBody(plainBody);
             //End EC

            emails.add(singleMail);
            system.debug('Abbiamo appena inserito nella lista di email le SingleEmail, questa è l\'ultima operazione prima di uscire dal FOR');
        } 
        System.debug('@@@@@@@@@@ la lista contiene ' + emails.size() +' email' );
        Messaging.sendEmail(emails); 
        System.debug('@@@@@@@@@@ sono state inviate ' + emails.size() +' email' );
        }  
        
    public void invioMailChiusa(){  
        System.debug('@@@@@@@@@ è stato chiamato il metodo invioMailAperta');
        List<OF_CQS_Evento__c> evento = [Select Id, name, CQS_Ev_Progetto__c, 
                                                                CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
                                                                Owner.Name, recordType.DeveloperName, recordType.Name,
                                                                recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
                                                                OF_CQS_Impresa_Esecutrice_Eventi__c, OF_CQS_Stato_Pratica__c,
                                                                OF_CQS_Impresa_Mandataria__r.Name, OF_CQS_Impresa_Esecutrice_Eventi__r.Name,
																CQS_Ev_Skip_Controller__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =: ev.id limit 1];
    //    changeStatoP(evento.get(0).OF_CQS_Stato_Pratica__c);
        List<String> listStrinf=new List<String>();
        listStrinf.add(etInfortunio);
        listStrinf.add(etDanni_Iss_L_M);
        Map<String,EmailTemplate> mappaOut= CQS_Utils.ritornaTemplates(listStrinf);
        
        List<Id> listProg=new List<Id>();
        listProg.add(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista contiene ' + listProg.size() +'progetti' );
        System.debug('@@@@@@@@@@ i progetti aggiunti al set sono' + evento.get(0).CQS_Ev_Progetto__c );
        Map<Id,List<ID>> progUtDestPuJMap= CQS_Utils.getUListPro(listProg);
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); //commenta riga 345
       
        List<Id> listTargetUser=progUtDestPuJMap.get(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista listTargetUser contiene ' + listTargetUser.size() +'user' );
        List<Id> listAddUser=listTargetUser;
        System.debug('@@@@@@@@@@ la lista listAddUser contiene ' + listAddUser.size() +'user' );
        Set<Id> listaRuoliSuperiori= new Set<Id>();
        system.debug('@@@@@ Siamo nel caso dell\'indice di gravità alta');
        for(User userX:[select id, UserRoleId, UserRole.Name from User where Id=:listTargetUser and (UserRoleId!='' and UserRoleId!=null)]){
            if(userX.UserRole.Name.contains(cmStr)){
                listaRuoliSuperiori.addAll(getUserRoleSup(userX.UserRoleId));
                system.debug('@@@@@ Gli utenti sono' + listaRuoliSuperiori);
                listaRuoliSuperiori.remove(userX.id);
                system.debug('@@@@@ Gli utenti dopo il remove sono' + listaRuoliSuperiori);
            }
        }
        List<User> listUser=[Select id, Name from User Where UserRoleId=:listaRuoliSuperiori and (UserRoleId!='' and UserRoleId!=null)];
        
        for(User li:listUser){
            listAddUser.add(li.id);
            System.debug('@@@@@@@@@@ prendiamo gli user li: ' + li.Name);
        }
        System.debug('@@@@@@@@@@ la lista listAddUser, con l\'aggiunta di user con ruolo superiore contiene infine ' + listAddUser.size() +' user' );
     // listAddUser.addAll(getIndirizziAggiuntivi(evento)); 
        system.debug('la lista listAddUser è così popolata: ' + listAddUser);
        
          //start attach EC
            PageReference pdf = Page.CQS_Evento_PDF;
            System.debug('abbiamo appena crato il pageReference pdf dalla Page.printableViewEvento');
            System.debug('il valore del PageReference pdf è: ' + pdf);
            // add parent id to the parameters for standardcontroller
            pdf.getParameters().put('id',evento.get(0).Id);
            System.debug('stiamo mettendo dei parametri al pdf con il geetParameters().put con l\' id dell\'evento '+ evento.get(0).Id);
            // the contents of the attachment from the pdf
            Blob pdfbody;
            System.debug('il blob pdfBody è così valorizzato '+ pdfbody);
            try {
               system.debug('siamo nel try. Stiamo impostando il contenuto con il metodo getContent() '); 
                
                // returns the output of the page as a PDF
                pdfbody = pdf.getContent();
                System.debug('nel try il blob pdfBody viene così valorizzato '+ pdfbody); 
                // need to pass unit test -- current bug  
            } catch (Exception e) {
                system.debug('siamo nel catch dell\'exception. L\'eccezione generica è la seguente: ' + e);
                pdfbody = Blob.valueOf('Some Text');
                system.debug('nel catch. il pdfbody è così valorizzato: ' + pdfbody);
            }
            
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/pdf');
            attach.setFileName(evento.get(0).Name + '_Verbale.pdf');
            attach.setInline(false);
            attach.Body = pdfbody;
            System.debug('l\'attach viene valorizzato con il seguente pdfbody '+ pdfbody + ', che va a valorizzare l\'attach.body così: ' + attach.Body);
             
            //
        //End Attach EC
        
        
        for(Id idd:listAddUser){    
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setSubject('Evento Inserito');
            singleMail.setSaveAsActivity(false);
            singleMail.setTargetObjectId(idd);
         //   singleMail.setCcAddresses(getIndirizziAggiuntivi(evento));
            System.debug('@@@@@@@@@ l\' id degli user è: '+ idd);        
            String nameTemplate=(evento.get(0).recordType.DeveloperName).equals(eInf)?etInfortunio:etDanni_Iss_L_M;
            EmailTemplate eT=new EmailTemplate();
            eT=mappaOut.get(nameTemplate);
            System.debug('@@@@@ stiamo scegliendo il seguente emailTemplate' + eT);
            System.debug('@@@@@ stiamo scegliendo l\'emailTemplate sulla base del recordType');
            singleMail.setTemplateId(eT.Id); 
            System.debug('@@@@@ stiamo settando l\'id dell\'emailTemplate');
            System.debug('@@@@@@@@@ EV è: '+ evento.get(0));
            singleMail.setSenderDisplayName(evento.get(0).Owner.Name);
                
            String plainBody = eT.Body;
            //plainBody=plainBody.replaceAll('OF_CQS_Evento__c','ev');
            System.debug('@@@@eTBody: ' + eT.Body);
            System.debug('@@@@plainBody: ' + plainBody);
            plainBody = plainBody.replace('inserito', 'chiuso'); 
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', evento.get(0).RecordType.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Name}', evento.get(0).Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Mandataria__c}',evento.get(0).OF_CQS_Impresa_Mandataria__r.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Esecutrice_Eventi__c}', evento.get(0).OF_CQS_Impresa_Esecutrice_Eventi__r.Name);
            if((!(evento.get(0).recordType.DeveloperName.equals(eBadP)))&& (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Aperta'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Chiusa'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Integrata'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_in_Lavorazione')))){
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c);
            }
            else {
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', 'L - Lieve');
            }
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OwnerFullName}',evento.get(0).Owner.Name);
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs87.salesforce.com/'+evento.get(0).Id+'  clicca sul link.');//sviluppo
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://collaudo--eofdev.cs83.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //Collaudo
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://openfiber-it.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //produzione
                 //END EC2
            
           // singleMail.setHtmlBody(eT.HtmlValue);
            // singleMail.setHtmlBody(htmlBody);
            //singleMail.setPlainTextBody(eT.body);
            singleMail.setPlainTextBody(plainBody);
             //End EC
            singleMail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });       
                emails.add(singleMail);
                system.debug('Abbiamo appena inserito nella lista di email le SingleEmail, questa è l\'ultima operazione prima di uscire dal FOR');
           } 
        //ora aggiungiamo la parte per l'invio alle imprese.
            //List<String> sListIndirizzi= getIndirizziAggiuntivi(evento);
        
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setSubject('Verificato Evento');
            singleMail.setSaveAsActivity(false);
          //singleMail.setTargetObjectId(getIdAggiuntivi(evento).get(0));
            system.debug('passiamo il seguente id dell\'impresa al setTargetObject: ' + getIdAggiuntivi(evento));
            singleMail.setToAddresses(getIndirizziAggiuntivi(evento));
            System.debug('@@@@@@@@@ l\' indirizzo dell\'impresa è il seguente: '+ getIndirizziAggiuntivi(evento));        
            String nameTemplate=(evento.get(0).recordType.DeveloperName).equals(eInf)?etInfortunio:etDanni_Iss_L_M;
            EmailTemplate eT=new EmailTemplate();
            eT=mappaOut.get(nameTemplate);
            System.debug('@@@@@ stiamo scegliendo il seguente emailTemplate' + eT);
            System.debug('@@@@@ stiamo scegliendo l\'emailTemplate sulla base del recordType');
            singleMail.setTemplateId(eT.Id); 
            System.debug('@@@@@ stiamo settando l\'id dell\'emailTemplate');
            System.debug('@@@@@@@@@ EV è: '+ evento.get(0));
            singleMail.setSenderDisplayName(evento.get(0).Owner.Name);
            singleMail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
            System.debug('stiamo per creare il pageReference pdf dalla Page.printableViewEvento');
          
        
        
                
            String plainBody = eT.Body;
            //plainBody=plainBody.replaceAll('OF_CQS_Evento__c','ev');
            System.debug('@@@@eTBody: ' + eT.Body);
            System.debug('@@@@plainBody: ' + plainBody);
            plainBody = plainBody.replace('inserito', 'chiuso');  
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', evento.get(0).RecordType.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Name}', evento.get(0).Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Mandataria__c}', evento.get(0).OF_CQS_Impresa_Mandataria__r.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Esecutrice_Eventi__c}', evento.get(0).OF_CQS_Impresa_Esecutrice_Eventi__r.Name);
            if((!(evento.get(0).recordType.DeveloperName.equals(eBadP)))&& (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Aperta'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Chiusa'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Integrata'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_in_Lavorazione')))){
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c);
            }
            else {
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', 'L - Lieve');
            }
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OwnerFullName}', evento.get(0).Owner.Name);
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs87.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>');
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://collaudo--eofdev.cs83.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //Collaudo  
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://openfiber-it.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //produzione
        //END EC2
            
           // singleMail.setHtmlBody(eT.HtmlValue);
            // singleMail.setHtmlBody(htmlBody);
            //singleMail.setPlainTextBody(eT.body);
            singleMail.setPlainTextBody(plainBody);
             //End EC
                     
                emails.add(singleMail);
        
        
        System.debug('@@@@@@@@@@ la lista contiene ' + emails.size() +' email' );
        Messaging.sendEmail(emails); 
       System.debug('@@@@@@@@@@ sono state inviate ' + emails.size() +' email' );
    
    }
    
    public void invioMailChiusaLieve(){  
        System.debug('@@@@@@@@@ è stato chiamato il metodo invioMailChiusaLieve');
         List<OF_CQS_Evento__c> evento = [Select Id, name, CQS_Ev_Progetto__c, 
                                                                CQS_Indice_Gravita_Taglio_Danneggiamento__c, OwnerId, 
                                                                Owner.Name, recordType.DeveloperName, recordType.Name,
                                                                recordTypeId, Skip_Email__c, OF_CQS_Impresa_Mandataria__c,
                                                                OF_CQS_Impresa_Esecutrice_Eventi__c, OF_CQS_Stato_Pratica__c,
                                                                OF_CQS_Impresa_Mandataria__r.Name, OF_CQS_Impresa_Esecutrice_Eventi__r.Name,
																CQS_Ev_Skip_Controller__c
                                                                from OF_CQS_Evento__c 
                                                                where Id =: ev.id limit 1];
      //  changeStatoP(evento.get(0).OF_CQS_Stato_Pratica__c);
        
        List<String> listStrinf=new List<String>();
        listStrinf.add(etInfortunio);
        listStrinf.add(etDanni_Iss_L_M);
        Map<String,EmailTemplate> mappaOut= CQS_Utils.ritornaTemplates(listStrinf);
        
        List<Id> listProg=new List<Id>();
        listProg.add(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista contiene ' + listProg.size() +'progetti' );
        System.debug('@@@@@@@@@@ i progetti aggiunti al set sono' + evento.get(0).CQS_Ev_Progetto__c );
        Map<Id,List<ID>> progUtDestPuJMap= CQS_Utils.getUListPro(listProg);
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); //commenta riga 345
       
        List<ID> listTargetUser=progUtDestPuJMap.get(evento.get(0).CQS_Ev_Progetto__c);
        System.debug('@@@@@@@@@@ la lista listTargetUser contiene ' + listTargetUser.size() +'user' );
        List<Id> listAddUser= new List<Id>();
        System.debug('@@@@@@@@@@ la lista listAddUser contiene ' + listAddUser.size() +'user' );
        Set<Id> listaRuoliSuperiori= new Set<Id>();
        system.debug('@@@@@ Siamo nel caso dell\'indice di gravità alta');
        for(User userX:[select id, UserRoleId, UserRole.Name from User where Id=:listTargetUser and (UserRoleId!='' and UserRoleId!=null)]){
            if(userX.UserRole.Name.contains(cseStr)){
                listAddUser.add(userX.Id);
                //rimane ancora da aggiungere l'ente
                system.debug('@@@@@ Gli utenti sono' + listAddUser);
            }
        }
       // listAddUser.addAll(getIndirizziAggiuntivi(evento));
        System.debug('@@@@@@@@@@ la lista listAddUser, con l\'aggiunta di user con ruolo superiore contiene infine ' + listAddUser.size() +'user' );
        //start attach EC
            PageReference pdf = Page.CQS_Evento_PDF;
            System.debug('abbiamo appena crato il pageReference pdf dalla Page.printableViewEvento');
            System.debug('il valore del PageReference pdf è: ' + pdf);
            // add parent id to the parameters for standardcontroller
            pdf.getParameters().put('id',evento.get(0).Id);
            System.debug('stiamo mettendo dei parametri al pdf con il geetParameters().put con l\' id dell\'evento '+ evento.get(0).Id);
            // the contents of the attachment from the pdf
            Blob pdfbody;
            System.debug('il blob pdfBody è così valorizzato '+ pdfbody);
            try {
               system.debug('siamo nel try. Stiamo impostando il contenuto con il metodo getContent() '); 
                
                // returns the output of the page as a PDF
                pdfbody = pdf.getContent();
                System.debug('nel try il blob pdfBody viene così valorizzato '+ pdfbody); 
                // need to pass unit test -- current bug  
            } catch (Exception e) {
                system.debug('siamo nel catch dell\'exception. L\'eccezione generica è la seguente: ' + e);
                pdfbody = Blob.valueOf('Some Text');
                system.debug('nel catch. il pdfbody è così valorizzato: ' + pdfbody);
            }
            
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/pdf');
            attach.setFileName(evento.get(0).Name + '_Verbale.pdf');
            attach.setInline(false);
            attach.Body = pdfbody;
            System.debug('l\'attach viene valorizzato con il seguente pdfbody '+ pdfbody + ', che va a valorizzare l\'attach.body così: ' + attach.Body);
             
            //
        //End Attach EC
        
        for(Id idd:listAddUser){    
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setSubject('Evento Inserito');
            singleMail.setSaveAsActivity(false);
            singleMail.setTargetObjectId(idd);  
            System.debug('@@@@@@@@@ l\' id degli user è: '+ idd);        
            String nameTemplate=(evento.get(0).recordType.DeveloperName).equals(eInf)?etInfortunio:etDanni_Iss_L_M;
            EmailTemplate eT=new EmailTemplate();
            eT=mappaOut.get(nameTemplate);
            System.debug('@@@@@ stiamo scegliendo il seguente emailTemplate' + eT);
            System.debug('@@@@@ stiamo scegliendo l\'emailTemplate sulla base del recordType');
            singleMail.setTemplateId(eT.Id); 
            System.debug('@@@@@ stiamo settando l\'id dell\'emailTemplate');
            
         
            System.debug('@@@@@@@@@ EV è: '+ evento.get(0));
                    //EC
            singleMail.setSenderDisplayName(evento.get(0).Owner.Name);
            singleMail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
                
            String plainBody = eT.Body;
            //plainBody=plainBody.replaceAll('OF_CQS_Evento__c','ev');
            System.debug('@@@@eTBody: ' + eT.Body);
            System.debug('@@@@plainBody: ' + plainBody);
            plainBody = plainBody.replace('inserito', 'chiuso'); 
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', evento.get(0).RecordType.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Name}', evento.get(0).Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Mandataria__c}', evento.get(0).OF_CQS_Impresa_Mandataria__r.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Esecutrice_Eventi__c}', evento.get(0).OF_CQS_Impresa_Esecutrice_Eventi__r.Name);
            if((!(evento.get(0).recordType.DeveloperName.equals(eBadP)))&& (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Aperta'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Chiusa'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Integrata'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_in_Lavorazione')))){
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c);
            }
            else {
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', 'L - Lieve');
            }
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OwnerFullName}',evento.get(0).Owner.Name);
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs87.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>');
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://collaudo--eofdev.cs83.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //Collaudo  
          	plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://openfiber-it.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //produzione
 
            //END EC2
            
           // singleMail.setHtmlBody(eT.HtmlValue);
            // singleMail.setHtmlBody(htmlBody);
            //singleMail.setPlainTextBody(eT.body);
            singleMail.setPlainTextBody(plainBody);
             //End EC
                     
                emails.add(singleMail);
                system.debug('Abbiamo appena inserito nella lista di email le SingleEmail, questa è l\'ultima operazione prima di uscire dal FOR');
           } 
        Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setSubject('Verificato Evento');
            singleMail.setSaveAsActivity(false);
          //singleMail.setTargetObjectId(getIdAggiuntivi(evento).get(0));
            system.debug('passiamo il seguente id dell\'impresa al setTargetObject: ' + getIdAggiuntivi(evento));
            singleMail.setToAddresses(getIndirizziAggiuntivi(evento));
            System.debug('@@@@@@@@@ l\' indirizzo dell\'impresa è il seguente: '+ getIndirizziAggiuntivi(evento));        
            String nameTemplate=(evento.get(0).recordType.DeveloperName).equals(eInf)?etInfortunio:etDanni_Iss_L_M;
            EmailTemplate eT=new EmailTemplate();
            eT=mappaOut.get(nameTemplate);
            System.debug('@@@@@ stiamo scegliendo il seguente emailTemplate' + eT);
            System.debug('@@@@@ stiamo scegliendo l\'emailTemplate sulla base del recordType');
            singleMail.setTemplateId(eT.Id); 
            System.debug('@@@@@ stiamo settando l\'id dell\'emailTemplate');
            System.debug('@@@@@@@@@ EV è: '+ evento.get(0));
            singleMail.setSenderDisplayName(evento.get(0).Owner.Name);
            singleMail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
            System.debug('stiamo per creare il pageReference pdf dalla Page.printableViewEvento');
          
        
        
                
            String plainBody = eT.Body;
            //plainBody=plainBody.replaceAll('OF_CQS_Evento__c','ev');
            System.debug('@@@@eTBody: ' + eT.Body);
            System.debug('@@@@plainBody: ' + plainBody);
             plainBody = plainBody.replace('inserito', 'chiuso');  
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.RecordType}', evento.get(0).RecordType.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.Name}', evento.get(0).Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Mandataria__c}', evento.get(0).OF_CQS_Impresa_Mandataria__r.Name);
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OF_CQS_Impresa_Esecutrice_Eventi__c}', evento.get(0).OF_CQS_Impresa_Esecutrice_Eventi__r.Name);
            if((!(evento.get(0).recordType.DeveloperName.equals(eBadP)))&& (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Aperta'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Chiusa'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_Integrata'))) && (!(evento.get(0).recordType.DeveloperName.equals('Bad_Practice_in_Lavorazione')))){
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', evento.get(0).CQS_Indice_Gravita_Taglio_Danneggiamento__c);
            }
            else {
                plainBody = plainBody.replace('{!OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c}', 'L - Lieve');
            }
            plainBody = plainBody.replace('{!OF_CQS_Evento__c.OwnerFullName}', evento.get(0).Owner.Name);
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://cs87.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>');//Sviluppo
          //plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://collaudo--eofdev.cs83.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //Collaudo  
          	plainBody = plainBody.replace('{!OF_CQS_Evento__c.Link}','https://openfiber-it.my.salesforce.com/'+evento.get(0).Id+' >clicca sul link.</a>'); //produzione
           //END EC2
            
           // singleMail.setHtmlBody(eT.HtmlValue);
            // singleMail.setHtmlBody(htmlBody);
            //singleMail.setPlainTextBody(eT.body);
            singleMail.setPlainTextBody(plainBody);
             //End EC
                     
                emails.add(singleMail);
        
        
        System.debug('@@@@@@@@@@ la lista contiene ' + emails.size() +' email' );
        Messaging.sendEmail(emails); 
        System.debug('@@@@@@@@@@ sono state inviate ' + emails.size() +' email' );
    
    }
    
    //EC start 2019 - 01 - 16  modifica del metodo in modo da inviare le email alle imprese associate ai progetti.
    public List<String> getIndirizziAggiuntivi(List<OF_CQS_Evento__c> eL){
        List<String> indirizziAggiuntivi = new List<String>();
        //id pro = eL.get(0).CQS_Ev_Progetto__c;
        for(CQS_Prog_An_junc__c paj : [Select id, CQS_Praj_Ragione_Sociale__c, CQS_Praj_Ragione_Sociale__r.OF_CQS_Indirizzo_Email__c,
                                       CQS_Paj_Email_Affidataria__c 
                                       FROM CQS_Prog_An_junc__c 
                                       WHERE CQS_Praj_Progetto__c =: eL.get(0).CQS_Ev_Progetto__c 
                                       AND (CQS_Paj_Email_Affidataria__c !=''
                                       AND CQS_Paj_Email_Affidataria__c != null)]){ 
                                                                                   /*   AND (CQS_Praj_Ragione_Sociale__r.OF_CQS_Indirizzo_Email__c!='' 
                                                                               AND CQS_Praj_Ragione_Sociale__r.OF_CQS_Indirizzo_Email__c!= null)*/
          																	 // indirizziAggiuntivi.add(paj.CQS_Praj_Ragione_Sociale__r.OF_CQS_Indirizzo_Email__c);
           	indirizziAggiuntivi.add(paj.CQS_Paj_Email_Affidataria__c);
            system.debug('siamo nel for del metodo getIndirizziAggiuntivi. aggiungiamo il seguente indirizzo email alla lista degli indirizzi aggiuntivi:  ' + paj.CQS_Praj_Ragione_Sociale__r.OF_CQS_Indirizzo_Email__c);
        }
        return indirizziAggiuntivi;
    }
    //EC end 2019 - 01 - 16  modifica del metodo in modo da inviare le email alle imprese associate ai progetti.
    
     public List<Id> getIdAggiuntivi(List<OF_CQS_Evento__c> eL){
        List<Id> idAggiuntivi = new List<String>();
        //id pro = eL.get(0).CQS_Ev_Progetto__c;
        for(CQS_Prog_An_junc__c paj : [Select id, CQS_Praj_Ragione_Sociale__c, CQS_Paj_Email_Affidataria__c,CQS_Praj_Ragione_Sociale__r.OF_CQS_Indirizzo_Email__c from CQS_Prog_An_junc__c where CQS_Praj_Progetto__c =: eL.get(0).CQS_Ev_Progetto__c and (CQS_Praj_Ragione_Sociale__r.OF_CQS_Indirizzo_Email__c!='' AND CQS_Praj_Ragione_Sociale__r.OF_CQS_Indirizzo_Email__c!= null)]){
            idAggiuntivi.add(paj.CQS_Praj_Ragione_Sociale__c);
            system.debug('siamo nel for del metodo getidAggiuntivi. aggiungiamo il seguente indirizzo email alla lista degli idAggiuntivi:  ' + paj.CQS_Praj_Ragione_Sociale__c);
        }
        return idAggiuntivi;
    }
    
    /*
    *EC PdfGenerator Method to generate and attach evento record and send email 
    *
    */
    
    
        
        
}
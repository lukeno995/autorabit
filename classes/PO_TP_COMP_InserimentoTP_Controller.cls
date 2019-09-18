/**
* Author:       Team Napoli
* Description:  Ticket Provisioning
* SI:           doc. "Documento Tecnico - Ticket Provisioning v3" 
*/
public class PO_TP_COMP_InserimentoTP_Controller {
    
    public EOF_EAI_Service_Log__c slToInsert{get;set;}
    
    public Map<String,Id> rtMap;
    public boolean puoScalare{get; set;}
    public boolean dettaglioRichiestaRequired{get; set;}
    public Id caseId{get; set;}
    public String statusTP{get; set;}
    public boolean NoOrdine{get; set;}
    public boolean ordineChiuso{get; set;} 
    public string statoASistema{get; set;}
    public boolean insertSuccess{get; set;}
    public String insertSuccessString{get; set;}
    public user attuale;
    public Case tpASistema{get; set;}
    public string msg_escalation {get; set;}   //FIX - 16-04 - IDR005
    public boolean dettaglioRequired{get;set;}
    //PG - ADD 3-10
    public String comuneAttivazione {get;set;}
    public User userPoloMilano {get;set;}
    //Costruttore
    
    public PO_TP_COMP_InserimentoTP_Controller(){

        dettaglioRequired=false;

        attuale=[select id,Name,UserRoleId,Account.EOF_Codice_Operatore__c from user where id=: userinfo.getUserId()];
        List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
        rtMap = new Map<String,Id>(); 

        //FIX - 16-04 - IDR005
        msg_escalation = 'Gentile Cliente, è già presente una richiesta per lo stesso ordine. E’ possibile richiedere aggiornamenti tramite la funzionalità di “escalation. Per procedere a scalare la segnalazione, seleziona “OK”.';
       
        if(apexpages.currentPage().getParameters().get('res')=='success'){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Segnalazione inviata correttamente');
            ApexPages.addMessage(myMsg);
        }
        for(recordtype rt :rtList){
           rtMap.put(rt.developerName, rt.Id); 
        } 
        puoScalare=false;
        dettaglioRichiestaRequired=false;
        NoOrdine=false;
        ordineChiuso=false;
        insertSuccess=false;
        statusTP='';

        slToInsert = new EOF_EAI_Service_Log__c();
        slToInsert.recordtypeId = rtMap.get('PO_TP_TicketProvisioning_sLog');
        slToInsert.EOF_Stato_Richiesta__c = 'Bozza';
       // User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        if(attuale!=null){
            slToInsert.EOF_Codice_Operatore__c=attuale.Account.EOF_Codice_Operatore__c; 
        }
        System.debug('1>>>>slToInsert: '+slToInsert);

        //slToInsert.PO_SA_Portale__c =true;        
    }
    
    
    public void calcDescCaus(){
        dettaglioRequired=false;
        if(String.isNotBlank(slToInsert.PO_TP_Causale_Apertura_Segnalazione__c) && slToInsert.PO_TP_Causale_Apertura_Segnalazione__c.equalsIgnoreCase('Problema Tecnico/Applicativo')){
            dettaglioRequired=true;
        }
    }    
    
            
    //Funzionalità bottone ANNULLA
    public PageReference AnnullaS(){
        PageReference pg = new PageReference('/PO_Index');
        return pg;
    }
    
    public pageReference vaiInEscalation(){
        try{
            Case c = new Case();
            c.Id=caseId;
            c.PO_TP_Escalation__c=true;
            update c;
            system.debug('@@@@@@@@@@@@ aggiornato correttamente: '+caseId);
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
            return null;
        }

        PageReference pg = new PageReference('/PO_TP_InsertNewRequest');
        pg.getParameters().put('proc','TPVisualizza');
        pg.getParameters().put('origId',caseId);
        pg.getParameters().put('escalated','true');
        return pg;
    }
    
    //EC Modifiche FIX - ticket provisioning
    /*
    Se l'ordine esiste su SF si lascia tutto com'è, se non esiste si crea un case e 
    lo associo sempre a POLO Milano codice ordine OF è vuoto perché non esiste.
    il metodo SalvaC() è uguale al precedente ora chiamato SalvaC_old() 
    */
    public void SalvaC(){
		
		                                   
        List<Case> ListaOrdini=[select Id,Status,EOF_Codice_Ordine_OLO__c,recordtype.developername,EOF_Causale_Errore__c,
                                EOF_Identificativo_del_POP__c,EOF_Codice_Operatore_WS__c,EOF_Comune_WS__c, EOF_Provincia_WS__c
                                from Case 
                                WHERE recordtype.developername in ('OF_SA_Attivazione','EOF_Caso_Attivazione')
                                AND EOF_Codice_Ordine_OLO__c =: slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c
                                /*AND EOF_Codice_Operatore_WS__c=:slToInsert.EOF_Codice_Operatore__c*/];  
        
        //caso in cui la lista di Ordini non è vuota ma il codice operatore dell'ordine estratto è diverso da quello che si sta tentando di inserire.
       if(!ListaOrdini.isEmpty() && ListaOrdini.get(0).EOF_Codice_Operatore_WS__c != slToInsert.EOF_Codice_Operatore__c){
          
            NoOrdine=true;
            statusTP='Codice Ordine Inesistente';
            return;
            
        }
        if(ListaOrdini.isEmpty()){
			List<Case> ListaTicketProv=[select Id,Status,EOF_Codice_Comunicazione_OLO__c,recordtype.developername,EOF_Causale_Errore__c,
                                    PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Descrizione_Causale__c,createdDate,EOF_Fase__c,
                                    PO_TP_Escalation__c,casenumber
                                    from Case 
                                    WHERE recordtypeId= :rtMap.get('PO_TP_TicketProvisioning_Case')
                                    AND PO_TP_Descrizione_Causale__c!='Richiesta Informazioni'
                                    AND status!='Chiuso'
                                    AND status!='Annullato'
                                    /*AND PO_TP_Ordine_Di_Riferimento__c =: ListaOrdini[0].Id*/
                                    AND PO_TP_Codice_Ordine_Ticket_Provisioning__c=: slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c
                                    AND PO_TP_Causale_Apertura_Segnalazione__c=:slToInsert.PO_TP_Causale_Apertura_Segnalazione__c];
        
	        System.debug('@@@Size ListaTicketProv: '+ListaTicketProv);
	        //System.debug('***slToInsert.EOF_STATO_ORDINE__c*** '+slToInsert.EOF_STATO_ORDINE__c);
	        //caso in cui la lista è vuota
		        if(ListaTicketProv.isEmpty())
		        {
		        	system.debug('@@@@@@@@@@EC Ordine non esistente e listaTicket vuota');
			        Case TPNew = new Case();
		            TPNew.recordtypeId=rtMap.get('PO_TP_TicketProvisioning_Case');
		           
		            TPNew.PO_TP_Causale_Apertura_Segnalazione__c=slToInsert.PO_TP_Causale_Apertura_Segnalazione__c;
		            TPNew.subject='Segnalazione Provisioning';
		            TPNew.PO_TP_Codice_Ordine_Ticket_Provisioning__c=slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c;
		            TPNew.PO_TP_Stato_Ordine_Ticket_Provisioning__c=slToInsert.EOF_STATO_ORDINE__c;
		            TPNew.PO_TP_Descrizione_Causale__c=slToInsert.PO_TP_Descrizione_Causale__c;
		            TPNew.PO_TP_Dettaglio_Richiesta__c=slToInsert.PO_TP_Dettaglio_Richiesta__c;
		            TPNew.PO_TP_Sottocausale__c = slToInsert.PO_TP_Sottocausale__c;
		            TPNew.status='Acquisito';
		            TPNew.Origin='Portale';
		            TPNew.Description=TPNew.PO_TP_Causale_Apertura_Segnalazione__c+' - '+TPNew.PO_TP_Descrizione_Causale__c;
		            TPNew.EOF_Codice_Operatore_WS__c=attuale.Account.EOF_Codice_Operatore__c;
		           	
                    // TPNew.EOF_Identificativo_del_POP__c=c.EOF_Identificativo_del_POP__c;
		            
		            if(!String.isBlank(slToInsert.PO_TP_Dettaglio_Richiesta__c)){
		                TPNew.EOF_Comunicazioni_con_OLO__c=Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+slToInsert.PO_TP_Dettaglio_Richiesta__c;
		            }
		           
		            TPNew.EOF_Fase__c='In Lavorazione SOC';
		            TPNew.PO_TP_Ordine_Di_Riferimento__c=null;
	            	TPNew.ownerId = [Select id from User where name = 'Segnalazioni Provisioning Polo Milano'].Id; 
	                insert TPNew;
	                caseId=TPNew.Id;
	                insertSuccess=true;                
	                insertSuccessString='Segnalazione inserita correttamente';
	                statusTP='Segnalazione inserita correttamente';
		          
	        	}
	        	else{
	        		system.debug('@@@@@@@@@@EC Ordine non esistente e ma listaTicket non vuota: ' + ListaTicketProv);
		        	tpASistema=ListaTicketProv[0];
		        	if(tpASistema.PO_TP_Escalation__c){
		            	statusTP='Segnalazione già in Escalation';
		            	return;
		        	}
		        
	
		        	//ticket non in escalation verificare data apertura se > 5 gg lavorativi
			        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
			        Integer giorniLineari = Date.valueOf(tpASistema.createdDate).daysbetween(Date.today());
			        system.debug('@@@@@@@@@ giorni lineari: '+giorniLineari);
			        Datetime giorno = Datetime.newInstance(Date.valueOf(tpASistema.createdDate), Time.newInstance(0, 0, 0, 0));
			        puoScalare=false;
			        Integer giorniLavorativi=0;
			
			        for(integer i=1;i<=giorniLineari;i++)
			        {
			            system.debug('@@@@@@@@@ giorno lineare');
			            if(BusinessHours.isWithin(bh_dac.Id, giorno.addDays(i)) == true )
			            {
			                system.debug('@@@@@@@@@ giorno lavorativo');
			                giorniLavorativi=giorniLavorativi+1;
			            }
			            if(giorniLavorativi>5) 
			            {
			                puoScalare=true;
			                break;
			            }
			        }
			        system.debug('@@@@@@@@@ puoScalare: '+puoScalare+', giorni lavorativi: '+giorniLavorativi+', giorni lineari: '+giorniLineari);
			
			        if(puoScalare){
			            caseId=tpASistema.Id;
			            statusTP='Escalation';
			            return;
			        }
			        else{
			            //FIX IDR008 - TO DO 
			            statusTP='Gentile Cliente, è già presente una richiesta per lo stesso ordine. E’ possibile richiedere aggiornamenti solo dopo 5 giorni dall’inserimento della richiesta originaria, tramite la funzionalità di “escalation”.';
			            return;
			        }
			        	
			        	
		        }
        }
        else{ //se invece l'ordine è esistente
        	system.debug('@@@@@@@@@@EC ListaOrdini esistente ' + ListaOrdini);
	        comuneAttivazione = ListaOrdini.get(0).EOF_Comune_WS__c;
	        System.debug('****comuneAttivazione***:'+comuneAttivazione);
	        system.debug('oneoneone');
	        
	        //caso in cui è in uno status definitivo
	        Case c=ListaOrdini[0];
	        if(c.status=='Espletato KO' || c.status=='Annullato' || c.status=='Acquisito KO' || c.status=='Accettato KO' || c.status=='Espletato' || c.status=='In annullamento'){
	            statoASistema='Ordine in stato '+c.status;
	
	            if(String.isNotBlank(c.EOF_Causale_Errore__c)){
	                String escapedStr = String.escapeSingleQuotes(c.EOF_Causale_Errore__c);
	                statoASistema=statoASistema+' per '+ escapedStr;
	            }
	            ordineChiuso=true;
	            statusTP=statoASistema;
	            return;
	        }
	        system.debug('dueduedue');
	
	        system.debug('fourfoour');
	        //caso in cui non è richiesta di informazioni per cui va verificato se ci sono a sistema eventuali altri 
	        //ticket provisioning dello stesso tipo (apertura segnalazione)
	        List<Case> ListaTicketProv=[select Id,Status,EOF_Codice_Comunicazione_OLO__c,recordtype.developername,EOF_Causale_Errore__c,
	                                    PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Descrizione_Causale__c,createdDate,EOF_Fase__c,
	                                    PO_TP_Escalation__c,casenumber
	                                    from Case 
	                                    WHERE recordtypeId= :rtMap.get('PO_TP_TicketProvisioning_Case')
	                                    AND PO_TP_Descrizione_Causale__c!='Richiesta Informazioni'
	                                    AND status!='Chiuso'
	                                    AND status!='Annullato'
	                                    AND PO_TP_Ordine_Di_Riferimento__c =: ListaOrdini[0].Id
	                                    AND PO_TP_Codice_Ordine_Ticket_Provisioning__c=: slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c
	                                    AND PO_TP_Causale_Apertura_Segnalazione__c=:slToInsert.PO_TP_Causale_Apertura_Segnalazione__c];
	        
	        System.debug('@@@Size ListaTicketProv: '+ListaTicketProv);
	        //System.debug('***slToInsert.EOF_STATO_ORDINE__c*** '+slToInsert.EOF_STATO_ORDINE__c);
	        //caso in cui la lista è vuota
	        if(ListaTicketProv.isEmpty())
	        {
	        	system.debug('@@@@@@@@@@EC ListaOrdini esistente e ListaTicketProv vuota quindi creiamo un nuovo Case di TicketProvisioning');
	        	
	            Case TPNew = new Case();
	            TPNew.recordtypeId=rtMap.get('PO_TP_TicketProvisioning_Case');
	            TPNew.PO_TP_Ordine_Di_Riferimento__c=c.Id;
	            TPNew.PO_TP_Causale_Apertura_Segnalazione__c=slToInsert.PO_TP_Causale_Apertura_Segnalazione__c;
	            TPNew.subject='Segnalazione Provisioning';
	            TPNew.PO_TP_Codice_Ordine_Ticket_Provisioning__c=slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c;
	            TPNew.PO_TP_Stato_Ordine_Ticket_Provisioning__c=slToInsert.EOF_STATO_ORDINE__c;
	            TPNew.PO_TP_Descrizione_Causale__c=slToInsert.PO_TP_Descrizione_Causale__c;
	            TPNew.PO_TP_Dettaglio_Richiesta__c=slToInsert.PO_TP_Dettaglio_Richiesta__c;
	            TPNew.PO_TP_Sottocausale__c = slToInsert.PO_TP_Sottocausale__c;
	            TPNew.status='Acquisito';
	            TPNew.Origin='Portale';
	            TPNew.Description=TPNew.PO_TP_Causale_Apertura_Segnalazione__c+' - '+TPNew.PO_TP_Descrizione_Causale__c;
	            //TPNew.EOF_Codice_Operatore_WS__c=c.EOF_Codice_Operatore_WS__c;
	            TPNew.EOF_Codice_Operatore_WS__c=attuale.Account.EOF_Codice_Operatore__c;
	            TPNew.EOF_Identificativo_del_POP__c=c.EOF_Identificativo_del_POP__c;
	            
	            
	            if(!String.isBlank(slToInsert.PO_TP_Dettaglio_Richiesta__c)){
	                TPNew.EOF_Comunicazioni_con_OLO__c=Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+slToInsert.PO_TP_Dettaglio_Richiesta__c;
	            }
	           
	            TPNew.EOF_Fase__c='In Lavorazione SOC';
	          
	            //ADD - PG - 3-10
	            
	                                                                
	            //System.debug('****list_comuniNord ***:'+list_comuniNord);
	         //   if(!ListaOrdini.isEmpty()){ Commentiamo, dovrebbe essere ridondante. EC 2018 - 10 - 30
	            	List<OF_ElencoComuniItaliani__c> list_comuniNord = [Select id, OF_Comune__c, OF_Provincia__c, OF_Regione__c
	                                                                from OF_ElencoComuniItaliani__c 
	                                                                where OF_Provincia__c in ('Bologna','Torino','Milano')
	                                                                and OF_Comune__c =: comuneAttivazione 
	                                                                ];
	            	if(list_comuniNord.isEmpty()){
	            		TPNew.PO_TP_Ordine_Di_Riferimento__c=c.Id;
		                TPNew.ownerId=[select Id from group where developername='TP_Coda_SOC'].id;                                
		                insert TPNew; 
		                caseId=TPNew.Id;
		                insertSuccess=true;                
		                insertSuccessString='Segnalazione inserita correttamente';
		                statusTP='Segnalazione inserita correttamente';
	            	}
	            	else{
	            		TPNew.ownerId = [Select id from User where name = 'Segnalazioni Provisioning Polo Milano'].Id; 
		                TPNew.PO_TP_Ordine_Di_Riferimento__c=c.Id;
		                insert TPNew;
		                caseId=TPNew.Id;
		                insertSuccess=true;                
		                insertSuccessString='Segnalazione inserita correttamente';
		                statusTP='Segnalazione inserita correttamente';
	            	}
	            //} Commentiamo, dovrebbe essere ridondante. EC 2018 - 10 - 30
	           
	        } //Chiudiamo l'if ListaTicketProv.isEmpty()
	        else{
	        	
	        	system.debug('@@@@@@@@@@EC ListaOrdini esistente e ListaTicketProv non vuota: ' + ListaTicketProv);
		        tpASistema=ListaTicketProv[0];
		        //caso in cui c'è gia un altro ticket provisioning uguale a sistema
	        	//controllo se è già in escalation
		        if(tpASistema.PO_TP_Escalation__c){
		            statusTP='Segnalazione già in Escalation';
		            return;
		        }
		        //ticket non in escalation verificare data apertura se > 5 gg lavorativi
		        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
		        Integer giorniLineari = Date.valueOf(tpASistema.createdDate).daysbetween(Date.today());
		        system.debug('@@@@@@@@@ giorni lineari: '+giorniLineari);
		        Datetime giorno = Datetime.newInstance(Date.valueOf(tpASistema.createdDate), Time.newInstance(0, 0, 0, 0));
		        puoScalare=false;
		        Integer giorniLavorativi=0;
		
		        for(integer i=1;i<=giorniLineari;i++)
		        {
		            system.debug('@@@@@@@@@ giorno lineare');
		            if(BusinessHours.isWithin(bh_dac.Id, giorno.addDays(i)) == true )
		            {
		                system.debug('@@@@@@@@@ giorno lavorativo');
		                giorniLavorativi=giorniLavorativi+1;
		            }
		            if(giorniLavorativi>5) 
		            {
		                puoScalare=true;
		                break;
		            }
		        }
		        system.debug('@@@@@@@@@ puoScalare: '+puoScalare+', giorni lavorativi: '+giorniLavorativi+', giorni lineari: '+giorniLineari);
		
		        if(puoScalare){
		            caseId=tpASistema.Id;
		            statusTP='Escalation';
		            return;
		        }
		        else{
		            //FIX IDR008 - TO DO 
		            statusTP='Gentile Cliente, è già presente una richiesta per lo stesso ordine. E’ possibile richiedere aggiornamenti solo dopo 5 giorni dall’inserimento della richiesta originaria, tramite la funzionalità di “escalation”.';
		            return;
		        }
		            
		            //END - PG - 3-10
		            return;
		        }//chiudiamo l'else dell'ordine esistente.
		        
		        system.debug('5555');
            	system.debug('@@@@@@@@@@EC caseId alla fine è ' + caseId);
	        
        }
	           
    }
   
  /*  //Funzionalità bottone SAVE
    public void SalvaC_old(){
                                   
        List<Case> ListaOrdini=[select Id,Status,EOF_Codice_Ordine_OLO__c,recordtype.developername,EOF_Causale_Errore__c,
                                EOF_Identificativo_del_POP__c,EOF_Codice_Operatore_WS__c,EOF_Comune_WS__c, EOF_Provincia_WS__c
                                from Case 
                                WHERE recordtype.developername in ('OF_SA_Attivazione','EOF_Caso_Attivazione')
                                AND EOF_Codice_Ordine_OLO__c =: slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c
                                AND EOF_Codice_Operatore_WS__c=:slToInsert.EOF_Codice_Operatore__c];  
        
        //caso in cui il codice ordine olo è insesistente
        if (ListaOrdini.isEmpty()){
            NoOrdine=true;
            statusTP='Codice Ordine Inesistente';
            return;
        }
        comuneAttivazione = ListaOrdini.get(0).EOF_Comune_WS__c;
        System.debug('****comuneAttivazione***:'+comuneAttivazione);
        system.debug('oneoneone');
        
        //caso in cui è in uno status definitivo
        Case c=ListaOrdini[0];
        if(c.status=='Espletato KO' || c.status=='Annullato' || c.status=='Acquisito KO' || c.status=='Accettato KO' || c.status=='Espletato' || c.status=='In annullamento'){
            statoASistema='Ordine in stato '+c.status;

            if(String.isNotBlank(c.EOF_Causale_Errore__c)){
                String escapedStr = String.escapeSingleQuotes(c.EOF_Causale_Errore__c);
                statoASistema=statoASistema+' per '+ escapedStr;
            }
            ordineChiuso=true;
            statusTP=statoASistema;
            return;
        }
        system.debug('dueduedue');

        system.debug('fourfoour');
        //caso in cui non è richiesta di informazioni per cui va verificato se ci sono a sistema eventuali altri 
        //ticket provisioning dello stesso tipo (apertura segnalazione)
        List<Case> ListaTicketProv=[select Id,Status,EOF_Codice_Comunicazione_OLO__c,recordtype.developername,EOF_Causale_Errore__c,
                                    PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Descrizione_Causale__c,createdDate,EOF_Fase__c,
                                    PO_TP_Escalation__c,casenumber
                                    from Case 
                                    WHERE recordtypeId= :rtMap.get('PO_TP_TicketProvisioning_Case')
                                    AND PO_TP_Descrizione_Causale__c!='Richiesta Informazioni'
                                    AND status!='Chiuso'
                                    AND status!='Annullato'
                                    AND PO_TP_Ordine_Di_Riferimento__c =: ListaOrdini[0].Id
                                    AND PO_TP_Codice_Ordine_Ticket_Provisioning__c=: slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c
                                    AND PO_TP_Causale_Apertura_Segnalazione__c=:slToInsert.PO_TP_Causale_Apertura_Segnalazione__c];
        
        System.debug('@@@Size ListaTicketProv: '+ListaTicketProv);
        //System.debug('***slToInsert.EOF_STATO_ORDINE__c*** '+slToInsert.EOF_STATO_ORDINE__c);
        //caso in cui la lista è vuota
        if(ListaTicketProv.isEmpty())
        {
            Case TPNew = new Case();
            TPNew.recordtypeId=rtMap.get('PO_TP_TicketProvisioning_Case');
            TPNew.PO_TP_Ordine_Di_Riferimento__c=c.Id;
            TPNew.PO_TP_Causale_Apertura_Segnalazione__c=slToInsert.PO_TP_Causale_Apertura_Segnalazione__c;
            TPNew.subject='Segnalazione Provisioning';
            TPNew.PO_TP_Codice_Ordine_Ticket_Provisioning__c=slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c;
            TPNew.PO_TP_Stato_Ordine_Ticket_Provisioning__c=slToInsert.EOF_STATO_ORDINE__c;
            TPNew.PO_TP_Descrizione_Causale__c=slToInsert.PO_TP_Descrizione_Causale__c;
            TPNew.PO_TP_Dettaglio_Richiesta__c=slToInsert.PO_TP_Dettaglio_Richiesta__c;
            TPNew.PO_TP_Sottocausale__c = slToInsert.PO_TP_Sottocausale__c;
            TPNew.status='Acquisito';
            TPNew.Origin='Portale';
            TPNew.Description=TPNew.PO_TP_Causale_Apertura_Segnalazione__c+' - '+TPNew.PO_TP_Descrizione_Causale__c;
            TPNew.EOF_Codice_Operatore_WS__c=c.EOF_Codice_Operatore_WS__c;
            TPNew.EOF_Identificativo_del_POP__c=c.EOF_Identificativo_del_POP__c;
            
            if(!String.isBlank(slToInsert.PO_TP_Dettaglio_Richiesta__c)){
                TPNew.EOF_Comunicazioni_con_OLO__c=Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+slToInsert.PO_TP_Dettaglio_Richiesta__c;
            }
            Group owner= new Group();
            owner = [select Id 
                    from group 
                    where developername='TP_Coda_SOC'];
            
            userPoloMilano = [Select id
                              from User
                              where name = 'Segnalazioni Provisioning Polo Milano'];

            TPNew.EOF_Fase__c='In Lavorazione SOC';
          
            //ADD - PG - 3-10
            List<OF_ElencoComuniItaliani__c> list_comuniNord = [Select id, OF_Comune__c, OF_Provincia__c, OF_Regione__c
                                                                from OF_ElencoComuniItaliani__c 
                                                                where OF_Provincia__c in ('Bologna','Torino','Milano')
                                                                and OF_Comune__c =: comuneAttivazione 
                                                                ];
                                                                
            //System.debug('****list_comuniNord ***:'+list_comuniNord);
            
            if(list_comuniNord.size()>0)
            {
                //assegnare il case all'utenza Polo-Milano
                TPNew.ownerId = userPoloMilano.Id; 
                insert TPNew;
                caseId=TPNew.Id;
                insertSuccess=true;                
                insertSuccessString='Segnalazione inserita correttamente';
                statusTP='Segnalazione inserita correttamente';           
            }
            else //assegna a coda SOC ---> giro normale
            {
                TPNew.ownerId=owner.Id;                                
                insert TPNew; 
                caseId=TPNew.Id;
                insertSuccess=true;                
                insertSuccessString='Segnalazione inserita correttamente';
                statusTP='Segnalazione inserita correttamente';     
            }
            //END - PG - 3-10
            return;
        }
        system.debug('5555');

        //caso in cui c'è gia un altro ticket provisioning uguale a sistema
        //controllo se è già in escalation
        tpASistema=ListaTicketProv[0];
        if(tpASistema.PO_TP_Escalation__c){
            statusTP='Segnalazione già in Escalation';
            return;
        }

        //ticket non in escalation verificare data apertura se > 5 gg lavorativi
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        Integer giorniLineari = Date.valueOf(tpASistema.createdDate).daysbetween(Date.today());
        system.debug('@@@@@@@@@ giorni lineari: '+giorniLineari);
        Datetime giorno = Datetime.newInstance(Date.valueOf(tpASistema.createdDate), Time.newInstance(0, 0, 0, 0));
        puoScalare=false;
        Integer giorniLavorativi=0;

        for(integer i=1;i<=giorniLineari;i++)
        {
            system.debug('@@@@@@@@@ giorno lineare');
            if(BusinessHours.isWithin(bh_dac.Id, giorno.addDays(i)) == true )
            {
                system.debug('@@@@@@@@@ giorno lavorativo');
                giorniLavorativi=giorniLavorativi+1;
            }
            if(giorniLavorativi>5) 
            {
                puoScalare=true;
                break;
            }
        }
        system.debug('@@@@@@@@@ puoScalare: '+puoScalare+', giorni lavorativi: '+giorniLavorativi+', giorni lineari: '+giorniLineari);

        if(puoScalare){
            caseId=tpASistema.Id;
            statusTP='Escalation';
            return;
        }
        else{
            //FIX IDR008 - TO DO 
            statusTP='Gentile Cliente, è già presente una richiesta per lo stesso ordine. E’ possibile richiedere aggiornamenti solo dopo 5 giorni dall’inserimento della richiesta originaria, tramite la funzionalità di “escalation”.';
            return;
        }   
    }*/
}
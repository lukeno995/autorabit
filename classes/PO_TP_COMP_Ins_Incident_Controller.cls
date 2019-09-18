/**
* Author:       Team Napoli
* Description:  Incident Management Controller
* SI:           doc. "Documento Tecnico - Ticket Provisioning v3" 
*/
public class PO_TP_COMP_Ins_Incident_Controller {
    
    public EOF_EAI_Service_Log__c slToInsert{get;set;}
    
    public Map<String,Id> rtMap;
    public Id caseId{get; set;}
    public String statusTP{get; set;}
    public boolean NoOrdine{get; set;}
    public boolean ordineChiuso{get; set;} 
    public string statoASistema{get; set;}
    public boolean insertSuccess{get; set;}
    public String insertSuccessString{get; set;}
    public user attuale;
    public Case tpASistema{get; set;}
    public boolean dettaglioRequired{get;set;}
    
    public SelectOption[] elencoSeverity {
        public get;
        private set;
    }
    
    //Costruttore
    public PO_TP_COMP_Ins_Incident_Controller (){

        String[] sev = new String[]{'None','Critical','Alto','Medio','Basso'};
		this.elencoSeverity = new SelectOption[]{};
		
        for (String s: sev) {
			this.elencoSeverity.add(new SelectOption(s,s));
		}

        dettaglioRequired=false;
        Attuale=[select id,Name,UserRoleId from user where id=: userinfo.getUserId()];
        List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
        rtMap = new Map<String,Id>(); 
       
        if(apexpages.currentPage().getParameters().get('res')=='success'){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Segnalazione inviata correttamente');
            ApexPages.addMessage(myMsg);
        }
        for(recordtype rt :rtList){
           rtMap.put(rt.developerName, rt.Id); 
        } 

        NoOrdine=false;
        ordineChiuso=false;
        insertSuccess=false;
        statusTP='';

        slToInsert = new EOF_EAI_Service_Log__c();
        slToInsert.recordtypeId = rtMap.get('PO_TP_TicketProvisioning_sLog');
        slToInsert.EOF_Stato_Richiesta__c = 'Bozza';
        
        User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        
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
        pg.getParameters().put('proc','TPVisualizzaIncident');
        pg.getParameters().put('origId',caseId);
        //pg.getParameters().put('escalated','true');
        return pg;
    }
   
    //Funzionalità bottone INOLTRA
    public void SalvaC(){

        Case TPNew = new Case();
        TPNew.recordtypeId = rtMap.get('PO_TP_TicketProvisioning_Case');
        TPNew.PO_TP_Causale_Apertura_Segnalazione__c = slToInsert.PO_TP_Causale_Apertura_Segnalazione__c;
        TPNew.subject = 'Incident Management';
        TPNew.PO_TP_Descrizione_Causale__c = slToInsert.PO_TP_Descrizione_Causale__c;
        TPNew.PO_TP_Dettaglio_Richiesta__c = slToInsert.PO_TP_Dettaglio_Richiesta__c;
        
        /*Add by PG - 16/10 - START */
        if(slToInsert.Severity__c.equalsIgnoreCase('None'))
            TPNew.PO_TP_Severity__c = '';
        else
            TPNew.PO_TP_Severity__c = slToInsert.Severity__c;
        /*Add by PG - 16/10 - END */
        
        TPNew.status = 'Acquisito';
        TPNew.Origin = 'Portale';
        TPNew.Description = TPNew.PO_TP_Causale_Apertura_Segnalazione__c+' - '+TPNew.PO_TP_Descrizione_Causale__c;
        TPNew.EOF_Codice_Operatore_WS__c = slToInsert.EOF_Codice_Operatore__c;
       
        if(!String.isBlank(slToInsert.PO_TP_Dettaglio_Richiesta__c)){
            TPNew.EOF_Comunicazioni_con_OLO__c = Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+slToInsert.PO_TP_Dettaglio_Richiesta__c;
        }

        Group owner= new Group();

        owner = [select Id 
                from group 
                where developername='TP_Coda_Operations'];  

        TPNew.EOF_Fase__c = 'In Lavorazione Operation';

        TPNew.ownerId = owner.Id;
        insert TPNew;   
        
        caseId = TPNew.Id;
        insertSuccess = true;
        insertSuccessString = 'Segnalazione inserita correttamente';
        statusTP = 'Segnalazione inserita correttamente';
        return;
    }    

    /*01-10 - PG - CR 13 */
    //Funzionalità bottone AggiungiAllegato (Viene creato il case e poi è possibile aggiungere l'attach)
    public PageReference aggiungiAllegato(){
        
        Case TPNew = new Case();
        TPNew.recordtypeId=rtMap.get('PO_TP_TicketProvisioning_Case');
        TPNew.PO_TP_Causale_Apertura_Segnalazione__c=slToInsert.PO_TP_Causale_Apertura_Segnalazione__c;
        TPNew.subject = 'Incident Management';
        TPNew.PO_TP_Descrizione_Causale__c=slToInsert.PO_TP_Descrizione_Causale__c;
        TPNew.PO_TP_Dettaglio_Richiesta__c=slToInsert.PO_TP_Dettaglio_Richiesta__c;
        
        /*Add by PG - 16/10 - START */
        if(slToInsert.Severity__c.equalsIgnoreCase('None'))
            TPNew.PO_TP_Severity__c = '';
        else
            TPNew.PO_TP_Severity__c = slToInsert.Severity__c;
        /*Add by PG - 16/10 - END */
        
        TPNew.status='Acquisito';
        TPNew.Origin='Portale';
        TPNew.Description=TPNew.PO_TP_Causale_Apertura_Segnalazione__c+' - '+TPNew.PO_TP_Descrizione_Causale__c;
        TPNew.EOF_Codice_Operatore_WS__c = slToInsert.EOF_Codice_Operatore__c;
       
        if(!String.isBlank(slToInsert.PO_TP_Dettaglio_Richiesta__c)){
            TPNew.EOF_Comunicazioni_con_OLO__c=Datetime.now().format('dd-MM-yyyy HH:mm','Europe/Rome')+' - '+attuale.name+' - '+slToInsert.PO_TP_Dettaglio_Richiesta__c;
        }

        Group owner= new Group();

        owner = [select Id 
                from group 
                where developername ='TP_Coda_Operations'];  

        TPNew.EOF_Fase__c = 'In Lavorazione Operation';

        TPNew.ownerId = owner.Id;
        insert TPNew;   
        
        caseId = TPNew.Id;
        insertSuccess = true;
        insertSuccessString = 'Segnalazione inserita correttamente';
        statusTP = 'Segnalazione inserita correttamente';
        
        PageReference pg = new PageReference('/PO_TP_AggiungiAllegato');
        pg.getParameters().put('origId',caseId);

        return pg;
    }
}
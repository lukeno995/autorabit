public class PO_TP_COMP_VisualizzaTP_Controller {
    
    public Case TicketProvisioning{get;set;}
    public boolean escalated{get;set;}
    public boolean fromEscalation{get;set;}
    public boolean noteOLO{get;set;}
    public boolean reqAnnullata {get;set;}
    public String IdScelta{get;set;}
    public String notaLocaleOLO{get;set;}
    public PageReference pageRef{get;set;}
    public boolean mostraBottone{get; set;}
    public Map<Id,Id> caseAttTicketMap {get;set;}
    public Case cA{get;set;}
    List<Case> cAttList {get;set;}
    public String commento{get;set;}
    public boolean showPopup{get; set;}
    public String infoDettaglioInPagina{get; set;} //FIX by PG - 24-04
    
    public PO_TP_COMP_VisualizzaTP_Controller(){
        escalated=false;
        fromEscalation=false;
        noteOLO=false;
        reqAnnullata=false;
        mostraBottone=false;
        
        TicketProvisioning=[Select id, casenumber, RecordType.developername,PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Sottocausale__c,
                            PO_TP_Codice_Ordine_Ticket_Provisioning__c, PO_TP_Stato_Ordine_Ticket_Provisioning__c,PO_TP_Descrizione_Causale__c, 
                            PO_TP_Dettaglio_Richiesta__c, status, CreatedDate,PO_TP_Escalation__c,EOF_Comunicazioni_con_OLO__c, 
                            PO_TP_Ordine_Di_Riferimento__c, PO_TP_Ordine_Di_Riferimento__r.id, PO_TP_Ordine_Di_Riferimento__r.status
                            from Case 
                            where id =: ApexPages.currentPage().getParameters().get('origId')];
                            
        // caseAttTicketMap.put(TicketProvisioning.id, TicketProvisioning.PO_TP_Ordine_Di_Riferimento__c);  
                           
        if(ApexPages.currentPage().getParameters().get('escalated')=='true'){
            fromEscalation=true;
            
        }
        if(TicketProvisioning.PO_TP_Escalation__c==true){
            escalated=true;
            
        }
        if(!String.isBlank(TicketProvisioning.EOF_Comunicazioni_con_OLO__c)){
            noteOLO=true;
            
        }
        //FIX by PG - 24-04 - START
        if(TicketProvisioning.PO_TP_Causale_Apertura_Segnalazione__c.equalsIgnoreCase('Segnalazione Provisioning'))
        {
            infoDettaglioInPagina = 'Segnalazione Provisioning';
        }
        else 
        {
            infoDettaglioInPagina = 'Incident Management'; 
        }
        //FIX by PG - 24-04 - END

        /*
        if(ApexPages.currentPage().getParameters().get('reqAnnullata')=='true'){
            reqAnnullata=true;
            update TicketProvisioning;
        }
        */
       
    }

     public PageReference annullaTicketPro(){
        
        try{
            //  if(escalated=true){
            //  escalated=false;
            TicketProvisioning.id=IdScelta;
            system.debug('@@@@@@@@@@@@ da annullare : '+TicketProvisioning.id);
            //TicketProvisioning.PO_TP_Stato_Ordine_Ticket_Provisioning__c='Annullato';
            TicketProvisioning.Status='Annullato'; //FIX 17-04 lo stato passa da chiuso in Annullato
            //TicketProvisioning.EOF_Note__c+='\n '+ OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+userinfo.getName()+':\n'+ commento;
            //TicketProvisioning.EOF_Note_Interne__c+='\n '+ OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+userinfo.getName()+':\n'+ commento;
            TicketProvisioning.EOF_Comunicazioni_con_OLO__c+='\n '+ OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+userinfo.getName()+':\n'+ commento;
            update TicketProvisioning;  
            reqAnnullata=true;
            pageRef= null;
            // }
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
            pageRef= null;  
        }
        //pageRef= Page.PO_TP_DisplayRequest;
        //pageRef.setRedirect(true);
        pageRef = new PageReference('/PO_TP_DisplayRequest');
        pageRef.getParameters().put('azione','Provisioning');
        return pageRef;
    }
    
    public PageReference vsAnnullamento(){
        try{
            showPopup=true;
            //PageReference pageRef = new PageReference('/PO_TP_InsertNewRequest');
            PageReference pageRef = new PageReference('/PO_TP_AnnullaTP');
            pageRef.getParameters().put('proc','TPVisualizza');
            pageRef.getParameters().put('origId',IdScelta);
            //pageRef= Page.PO_TP_AnnullaTP;
            pageRef.setRedirect(true);
            return pageRef;
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
                
        }
    //  finally {
        //update TicketProvisioning;
        //pageRef= Page.PO_TP_AnnullaTP;
    //  }
        return pageRef;
    }
    
    
        public PageReference vsAnnullaNota(){
        try{
            showPopup=true;
            //PageReference pageRef = new PageReference('/PO_TP_InsertNewRequest');
            PageReference pageRef = new PageReference('/PO_TP_DisplayRequest');
            string act = ApexPages.currentPage().getParameters().get('azione');
            pageRef.getParameters().put('azione',act);
           
           // pageRef.getParameters().put('origId',IdScelta);
            //pageRef= Page.PO_TP_AnnullaTP;
            pageRef.setRedirect(true);
            return pageRef;
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
                
        }
    //  finally {
        //update TicketProvisioning;
        //pageRef= Page.PO_TP_AnnullaTP;
    //  }
        return pageRef;
    }
    
    public PageReference vsNote(){
        
        try{
            showPopup=true;
            //PageReference pageRef = new PageReference('/PO_TP_InsertNewRequest');
            PageReference pageRef = new PageReference('/PO_TP_Inserisci_Note');
            pageRef.getParameters().put('proc','TPVisualizza');
            pageRef.getParameters().put('azione','Provisioning');
            pageRef.getParameters().put('origId',IdScelta);
            //  pageRef= Page.PO_TP_AnnullaTP;
            pageRef.setRedirect(true);
            return pageRef;
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        //  finally {
        //update TicketProvisioning;
        //pageRef= Page.PO_TP_AnnullaTP;
        //  }
        return pageRef;
    }
    
    
    public PageReference SalvaNota()
    {
        system.debug('@@@@@@@@@@@@ NOTAOLO');
        
        try{
            //TicketProvisioning.id=IdScelta;
            //system.debug('@@@@@@@@@@@@ NOTAOLO : ' + TicketProvisioning.id);
            TicketProvisioning.EOF_Comunicazioni_con_OLO__c+='\n '+ OF_TT_Utils.DateToString(OF_TT_Utils.now()).left(19)+' - '+userinfo.getName()+':\n'+ commento;
            update TicketProvisioning;  
            //reqAnnullata=true;
            pageRef= null;
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
            pageRef= null;  
        }
            
        if (ApexPages.currentPage().getParameters().get('azione') == 'Provisioning') {
            pageRef = new PageReference('/PO_TP_DisplayRequest');
            pageRef.getParameters().put('azione','Provisioning');
        }else{
            pageRef = new PageReference('/PO_TP_DisplayRequest');
            pageRef.getParameters().put('azione','Incident');
        }
        return pageRef;
    }
    
       
    public void showAnnButton(){
    
        caseAttTicketMap.put(TicketProvisioning.id, TicketProvisioning.PO_TP_Ordine_Di_Riferimento__c);  
        //cAttList è una lista che contiene solo Case per i quali il ticketProvisioning è annullabile           
        for(Case cA :[Select id,RecordType.developername,PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Codice_Ordine_Ticket_Provisioning__c,
                        PO_TP_Stato_Ordine_Ticket_Provisioning__c,PO_TP_Descrizione_Causale__c, PO_TP_Sottocausale__c, PO_TP_Dettaglio_Richiesta__c, status,
                        CreatedDate,PO_TP_Escalation__c,EOF_Comunicazioni_con_OLO__c, (select id, PO_TP_Ordine_Di_Riferimento__c, 
                        PO_TP_Ordine_Di_Riferimento__r.id, PO_TP_Ordine_Di_Riferimento__r.status 
                        from PO_TP_Ordine_Di_Riferimento__r 
                        where PO_TP_Ordine_Di_Riferimento__r.status IN('In Lavorazione', 'In verifica'))
                        from Case where id =: caseAttTicketMap.get(TicketProvisioning.id) and Status!='Chiuso']){
                            
           cAttList.add(cA);                            
           mostraBottone=true;  
        }
   
    }
    
    public PageReference closePopup(){
        showPopup=false;
        return null;
        
    }
    
    public PageReference showPopup(){
        showPopup=true;
        return null;
    }
    
}
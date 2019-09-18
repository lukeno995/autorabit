public without sharing class PO_TP_ExportListaIncident_Ctrl {

	public String DataInizio{get;set;}
	public String DataFine{get;set;}
	public String descrizioneCasualeJSON{get;set;}
	public String statusJSON{get;set;}
	public String escalationJSON{get;set;}
	public String causApertuAtt{get;set;}
	public User attuale;
	public String soql {get;set;}
	public List<Case> listRichiesteTP {get;set;}

	public PageReference fetchList(){
  		
  		System.debug('#fetchList');
  		String DataInizio= System.currentPagereference().getParameters().get('DataInizio');
		String DataFine= System.currentPagereference().getParameters().get('DataFine');
		String descrizioneCasualeJSON= System.currentPagereference().getParameters().get('descrizioneCasualeJSON');
		String statusJSON= System.currentPagereference().getParameters().get('statusJSON');
		String escalationJSON= System.currentPagereference().getParameters().get('escalationJSON');
 		DataFine = DataFine.replace(' ','+');
		DataInizio= DataInizio.replace(' ','+'); 
		System.debug('#'+DataInizio);
		System.debug('##'+DataFine);
		System.debug('###'+descrizioneCasualeJSON);
		System.debug('####'+statusJSON);
		System.debug('#####'+escalationJSON);
       
       	attuale=[select Id,Account.EOF_Codice_Operatore__c, contact.account.name
	            from user 
	            where Id=:userinfo.getUserId()];
	    
	    causApertuAtt='Problema tecnico/applicativo';
        

  		soql = 'Select id,RecordType.developername,PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Codice_Ordine_Ticket_Provisioning__c,'+
                 'PO_TP_Stato_Ordine_Ticket_Provisioning__c,PO_TP_Descrizione_Causale__c,PO_TP_Dettaglio_Richiesta__c, status,'+
                    'PO_TP_Escalation__c,CreatedDate, PO_TP_TicketNumber__c,PO_TP_Stato_Ticket__c,casenumber '+
                    'from Case where  recordtype.DeveloperName = \'PO_TP_TicketProvisioning_Case\'';
         
        if (DataInizio!=null && !DataInizio.equals('')){
          soql += ' and CreatedDate >='+String.escapeSingleQuotes(DataInizio);
        }
        if (DataFine!=null && !DataFine.equals('')){
          soql += ' and CreatedDate <='+String.escapeSingleQuotes(DataFine);
        }            
        soql += ' and PO_TP_Causale_Apertura_Segnalazione__c =\'' + causApertuAtt + '\'' ;        

        if(String.isNotBlank(descrizioneCasualeJSON)){
            List<String> ListDescrizioneCasuale = (List<String>)System.JSON.deserialize(descrizioneCasualeJSON, List<String>.class);
          if(ListDescrizioneCasuale!=null && !ListDescrizioneCasuale.isEmpty()){
              soql += ' and PO_TP_Descrizione_Causale__c in (';
              for (string mystring:ListDescrizioneCasuale){
                soql +='\'' + mystring + '\',';
              }
              soql = soql.removeEnd(',');
              soql += ')';  
          }     
        }
        System.debug('STATUS JSON' + statusJSON);
        if(String.isNotBlank(statusJSON)){
            List<String> ListStatus = (List<String>)System.JSON.deserialize(statusJSON, List<String>.class);
          if(ListStatus!=null && !ListStatus.isEmpty()){
              soql += ' and status in (';
              //soql +=' and in Case_Portale__r.Status  (';
              for (string mystring:ListStatus){
                  System.debug('sTRING JSON' + mystring);
                soql +='\'' + mystring + '\',';
              }
              soql = soql.removeEnd(',');
              soql += ')';  
          }
        }
        if(String.isNotBlank(escalationJSON)){

            List<String> ListEscalation = (List<String>)System.JSON.deserialize(escalationJSON, List<String>.class);
          
            if(ListEscalation!=null && !ListEscalation.isEmpty()){
              soql += ' and PO_TP_Escalation__c in (';
                for (string mystring:ListEscalation){
                    soql += +mystring+ ',';
              }
              soql = soql.removeEnd(',');
              soql += ')';  
          }     
        }
                  
        soql += ' and TP_Codice_Operatore_Esteso__c=\'' + attuale.contact.account.name  + '\' ';
   		listRichiesteTP  =Database.query(soql + ' order by CreatedDate DESC');

            System.debug( Database.query(soql + ' order by CreatedDate DESC'));

		      System.debug('#query'+soql);

  		System.debug('#List******'+listRichiesteTP); 
        System.debug('#List******'+listRichiesteTP.size()); 
        
		return null; 
	}
}
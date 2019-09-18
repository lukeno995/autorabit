public class PO_TP_ExportRichiesteProvisioning_Ctrl {
		
	public String DataInizio{get;set;}
	public String DataFine{get;set;}
	public String descrizioneCasualeJSON{get;set;}
	public String statusJSON{get;set;}
	public String escalationJSON{get;set;}
	public String causApertuAtt{get;set;}
	public User attuale;
	public String soql {get;set;}
	public List<Case> listRichiesteTP {get;set;}
	//COSTRUTTORE

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
       	attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
		causApertuAtt='Segnalazione Provisioning'; 
            
    /*    
    soql='Select id, casenumber, RecordType.developername,PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Codice_Ordine_Ticket_Provisioning__c,'+ 
                'PO_TP_Stato_Ordine_Ticket_Provisioning__c,PO_TP_Descrizione_Causale__c, PO_TP_TicketNumber__c, PO_TP_Stato_Ticket__c, PO_TP_Dettaglio_Richiesta__c, status, CreatedDate,'+ 
                 'PO_TP_Escalation__c from Case ';*/            
       
        soql = 'Select id,RecordType.developername,PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Codice_Ordine_Ticket_Provisioning__c,'+
                    'PO_TP_Stato_Ordine_Ticket_Provisioning__c,PO_TP_Descrizione_Causale__c, PO_TP_Dettaglio_Richiesta__c, status,'+
                    'PO_TP_Escalation__c,CreatedDate, PO_TP_TicketNumber__c,PO_TP_Stato_Ticket__c,casenumber '+
                    'from Case where recordtype.DeveloperName =\'PO_TP_TicketProvisioning_Case\'';     
        
        System.debug('**SOQL_1:'+soql);

        if (DataInizio!=null && !DataInizio.equals('')){
          soql += ' and CreatedDate >='+String.escapeSingleQuotes(DataInizio);
        }
        if (DataFine!=null && !DataFine.equals('')){
          soql += ' and CreatedDate <='+String.escapeSingleQuotes(DataFine);
        }
        soql += ' and PO_TP_Causale_Apertura_Segnalazione__c =\''+ causApertuAtt +'\'';
    	System.debug('**SOQL_2:'+soql);
                		
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
        System.debug('**SOQL_3:'+soql);

        if(String.isNotBlank(statusJSON)){
            List<String> ListStatus = (List<String>)System.JSON.deserialize(statusJSON, List<String>.class);
          if(ListStatus!=null && !ListStatus.isEmpty()){
              soql += ' and status in (';
              //soql +=' and in Case_Portale__r.Status  (';
              for (string mystring:ListStatus){
                soql +='\'' + mystring + '\',';
              }
              soql = soql.removeEnd(',');
              soql += ')';  
          }
        }
        System.debug('**SOQL_4:'+soql);
        	
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
        System.debug('**SOQL_5:'+soql);       
    
        soql += ' and PO_TP_Ordine_Di_Riferimento__r.EOF_Codice_Operatore_WS__c=\''+ attuale.Account.EOF_Codice_Operatore__c  + '\' ';
        System.debug('**SOQL_6:'+soql);     		
		listRichiesteTP = Database.query(soql + ' order by CreatedDate DESC');               

		System.debug('#query'+soql);
  		System.debug('#size'+listRichiesteTP);
      
		return null;
	}
}
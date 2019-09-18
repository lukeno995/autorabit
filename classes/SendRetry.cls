global class SendRetry implements Schedulable{
    
    global void execute(SchedulableContext SC){        
        
	
        List<EOF_Notify__c> sent_notifies = [SELECT Id, recordType.Name, Caso__C,CreatedDate,Caso__r.EOF_order_manager__c FROM EOF_Notify__c WHERE EOF_Inviata__c = true AND Createddate < :system.now().addminutes(-10)
                                     		AND Createddate > :system.now().addHours(-48)
        									AND (Caso__r.EOF_ORder_Manager__c=false 
        									OR (Caso__r.EOF_ORder_Manager__c=true AND (EOF_Tipo_Comunicazione_ctrl__C = '5' OR(EOF_Tipo_Comunicazione_ctrl__C = '12' AND EOF_Stato_richiesta__c='KO')))) order by createdDate ASC];         
        
        //Gathering all sent notifies related ACKs
        Map<Id, EOF_EAI_Service_log__c> log_map = new Map<Id, EOF_EAI_Service_log__c>();        
        List<EOF_EAI_Service_log__c> log_list = [SELECT Id, Notify__c FROM EOF_EAI_Service_log__c 
                                                 WHERE Notify__c IN :sent_notifies 
                                                 AND ((RecordType.Name = 'ACK' OR RecordType.Name = 'TT - ACK')
                                                 OR ((RecordType.Name = 'NACK' OR RecordType.Name = 'TT - NACK') AND (EOF_Codice_errore__c!='A_K4' AND EOF_Codice_errore__c!='A_K8' AND EOF_Codice_errore__c!='100')))];
                                                 
                    
        //Gathering notifies without ACK
        List<EOF_Notify__c> notifies_without_ack = new List<EOF_Notify__c>(); 
        for(EOF_EAI_Service_log__c sl : log_list)
                    log_map.put(sl.Notify__c, sl);      
        for(EOF_Notify__c n : sent_notifies)
            if(log_map.get(n.Id) == null)
                notifies_without_ack.add(n);

       
       
       system.debug('@@@@@@@@@@@@@@@@@ La lista di notifiche da inviare è: '+notifies_without_ack);
       system.debug('@@@@@@@@@@@@@@@@@ Il numero di notifiche da inviare è: '+notifies_without_ack.size());
       
       //faccio un check in modo da eliminare le notifiche sullo stesso case per prendere solo la prima
       Set<Id> Cases = new Set<Id>();
       List<EOF_Notify__c> single_notifies_without_ack = new List<EOF_Notify__c>();
       
       for(EOF_Notify__c n : notifies_without_ack){
			//il metodo add restituisce un boolean (true se riesce ad inserirlo altrimenti false)
			if (Cases.add(n.Caso__c)){
				single_notifies_without_ack.add(n);
			}
       }
       Integer i = 0;
       for(EOF_Notify__c n : single_notifies_without_ack){
          //Asynchronous callouts are limited for 50 per execution flow
          if(i<50)                   
                if(n.RecordType.Name.contains('Trouble Ticket')) {               
                	OF_TT_Utils.createAckNackNotifyServiceLog(n.Id);
                }
                else if(n.Caso__r.EOF_order_manager__c){
                	OF_TT_Utils.createAckNackNotifyServiceLog(n.Id);
                }
            	else{	
                    OF_TT_Utils.createAckNackNotifyServiceLog(n.Id);
            	}
           i++; 
        }
        
        //Deleting previous job        
        CronTrigger c = [SELECT Id FROM CronTrigger WHERE cronJobDetail.Name = 'Retry Job'];
        system.abortJob(c.Id);
        
        //Re-scheduling job for the next 30 minutes
        SendRetry sr = new SendRetry();       
        DateTime next_run = system.now().addMinutes(30);        
		String sch = '0 ' + next_run.minute() + ' * * * ?';
		String jobID = system.schedule('Retry Job', sch, sr);
        
        
    } 
}
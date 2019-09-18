global class OF_Schedule_DeleteAmmNoCase implements Schedulable{
    
    global void execute(SchedulableContext SC){   
    	OF_Batch_DeleteAmmNoCase DANC = new OF_Batch_DeleteAmmNoCase();
		
		DANC.query = 'select Id from CA_Amministratore__c where id not in (select CA_Amministratore__c from Case where recordtype.developername=\'CA_Amministratori\' and CA_Amministratore__c!=null)';
		DANC.email=new List<String>();
		DANC.email.add('germano.capoccia@enel.com');  
		Database.executeBatch(DANC);   
		//System.debug('Returned batch process ID: ' + batchProcessId);
        //Deleting previous job        
        CronTrigger c = [SELECT Id FROM CronTrigger WHERE cronJobDetail.Name = 'Delete Amm'];
        system.abortJob(c.Id);
        
        //Re-scheduling job for the next 30 minutes
        OF_Schedule_DeleteAmmNoCase sr = new OF_Schedule_DeleteAmmNoCase();             
		String sch = '0 0 7 * * ?';
		String jobID = system.schedule('Delete Amm', sch, sr); 
        
        
    } 
}
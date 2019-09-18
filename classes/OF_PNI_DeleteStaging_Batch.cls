global class OF_PNI_DeleteStaging_Batch implements Database.Batchable<sObject>,Database.Stateful {

    global String query;
	
    global Database.QueryLocator start(Database.BatchableContext BC){
        
       // query = 'SELECT  Id FROM OF_Staging_PNI__c where name =\'xxx\'';
        query = 'SELECT  Id FROM OF_Staging_PNI__c ';
            
        system.debug('>>>>>>>>>>>> query: ' + query);                 

        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<OF_Staging_PNI__c> listaStaging){
        
       
        system.debug('>>>>>>>>>>>> cancello la staging: ' );                 
        delete listaStaging;
        system.debug('>>>>>>>>>>>> staging cancellata: ' ); 
  
    }
    
    global void finish(Database.BatchableContext BC){
    
         }
    
}
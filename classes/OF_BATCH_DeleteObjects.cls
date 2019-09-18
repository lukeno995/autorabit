global class OF_BATCH_DeleteObjects implements Database.Batchable<sObject>{
	
    global Database.QueryLocator start(Database.BatchableContext BC){
    	List<Objects_Delete__c> myCustomValues = Objects_Delete__c.getAll().Values();
        String query = 'SELECT Id FROM '+myCustomValues[0].Nome_Oggetto__c+' where '+myCustomValues[0].DateTime_Check_Field__c+' < '+myCustomValues[0].OF_Delete_Records_Before__c+' LIMIT '+myCustomValues[0].OF_Record_Limit__c;
        return Database.getQueryLocator(query);
    }
 
    global void execute(Database.BatchableContext BC, List<sObject> scope){		
    	if(scope!=null && !scope.isEmpty()){
    		delete scope;
    		Database.emptyRecycleBin(scope);
    	}
    }  
    global void finish(Database.BatchableContext BC){
		AsyncApexJob a = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors
                    FROM AsyncApexJob WHERE ID =: BC.getJobId() ];
        system.debug('Processed ' +a.TotalJobItems +' batches with '+ a.NumberOfErrors + ' failures.');
    	Templog__c t = new Templog__c();
     	t.Type__c='T'; 
    	t.Name='Batch_DeleteObjects';
    	t.DataInserimento__c=system.now().format('YYYY-MM-dd HH:mm:ss');
    	t.Timestamp__c=system.now().format('YYYY-MM-dd HH:mm:ss');
    	t.Desc__c='Processed ' +a.TotalJobItems +' batches with '+ a.NumberOfErrors + ' failures.';
    	t.Class__c='OF_BATCH_DeleteObjects';
    	t.Method__c='execute';
    	insert t;
    }
}
global class OF_BATCH_BonificaOrdini implements Database.Batchable<sObject>{
	
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, accountId,OF_AccountTemporaneo__c, OF_ContractTemporaneo__c FROM order where account.type=\'Temp\'';
        return Database.getQueryLocator(query);
    }
 
    global void execute(Database.BatchableContext BC, List<Order> scope){		
    	list<Account> accToDelete = new List<Account>();
    	List<Order> orderToUpdate =  new List<Order>();
         for(Order o : scope){
         	if(String.isNotBlank(o.OF_AccountTemporaneo__c)){
         		Account a = new Account();
         		a.id=o.accountId;
         		accToDelete.add(a);
         		o.accountId=o.OF_AccountTemporaneo__c;
         		o.OF_AccountTemporaneo__c=null;
         	}
         	if(String.isNotBlank(o.OF_ContractTemporaneo__c)){
         		o.contractId=o.OF_ContractTemporaneo__c;
         		o.OF_ContractTemporaneo__c=null;
         	}          
         }
         try{
         	update scope;
         	if(!accToDelete.isEmpty()){
         		delete accToDelete; 
         		DataBase.emptyRecycleBin(accToDelete);
         	}
         }
         catch(DMLException e){
         	insert OF_Utility.logMessageNew2('Batch_BonificaOrdini_Error','E','OF_BonificaOrdini','execute',null, e);
         }
    }  
    global void finish(Database.BatchableContext BC){
		AsyncApexJob a = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors 
                    FROM AsyncApexJob WHERE ID =: BC.getJobId() ];
        system.debug('Processed ' +a.TotalJobItems +' batches with '+ a.NumberOfErrors + ' failures.');
    	Templog__c t = new Templog__c();
     	t.Type__c='T'; 
    	t.Name='Batch_BonificaOrdini';
    	t.DataInserimento__c=system.now().format('YYYY-MM-dd HH:mm:ss');
    	t.Timestamp__c=system.now().format('YYYY-MM-dd HH:mm:ss');
    	t.Desc__c='Processed ' +a.TotalJobItems +' batches with '+ a.NumberOfErrors + ' failures.';
    	t.Class__c='OF_BonificaOrdini';
    	t.Method__c='execute';
    	insert t;
    }
}
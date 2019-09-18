global class Batch_PBEStaging implements Database.Batchable<sObject> {
    
    global String query;
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        query  =  'select id,ERROR__c,Quantity__c,OF_Order__c,isActive__c,OF_Asset__c,OF_CommercialElementIstanziato__c,'+
            'OF_DataAttivazione2__c,OF_DataCessazione2__c,UnitPrice__c,Pricebook2Id__c,Product2Id__c,tipoApparato__c,'
            +'UseStandardPrice__c from OF_STAGING_PBE__c';
        
		system.debug('>>>>>>>>>>>> query: ' + query);
		return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<OF_STAGING_PBE__c> scope){
        system.debug('####ScopeSize: ' +  scope.size());
		
        List <PriceBookEntry> pricebookList  =  new List<PriceBookEntry>();
        
        for(OF_STAGING_PBE__c stagingpbe : scope){
            pricebookList.add(new PricebookEntry(OF_Order__c = stagingpbe.OF_Order__c,
                                                 isActive = stagingpbe.isActive__c,
                                                 OF_Asset__c = stagingpbe.OF_Asset__c,
                                                 OF_CommercialElementIstanziato__c = stagingpbe.OF_CommercialElementIstanziato__c,
												 OF_DataAttivazione2__c = stagingpbe.OF_DataAttivazione2__c,
                                                 OF_DataCessazione2__c = stagingpbe.OF_DataCessazione2__c,
                                                 UnitPrice = stagingpbe.UnitPrice__c,
                                                 Pricebook2Id = stagingpbe.Pricebook2Id__c,
                                                 Product2Id = stagingpbe.Product2Id__c,
          	                                     tipoApparato__c = stagingpbe.tipoApparato__c,
                                                 UseStandardPrice = stagingpbe.UseStandardPrice__c));
        }
        
         //inserire i nuovi Price Book Entry nel database
         //cancello oggetti OF STAGING PBE
         
		  try {
              if(pricebookList.size()>0){
                insert pricebookList;
               	delete scope;   
              }
			}
			catch(Exception ex){
				system.debug('Exception');                
                for(OF_STAGING_PBE__c stagingpbe : scope){
                   stagingpbe.ERROR__C = true;
               }
                update scope;
				// If SOQL didn't get Account record
			}
            // if (scope.size()>0 && !scope.isEmpty() && scopeupdate.isEmpty()) 
	
    }
    
    global void finish(Database.BatchableContext BC) {
       
    }

}
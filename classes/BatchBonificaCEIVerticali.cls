global class BatchBonificaCEIVerticali implements Database.Batchable<sObject>,Database.Stateful 
{
   

    global String query;
    /*global BatchContactUpdate (string meil) { 
     ccmail = meil ;
     PO_MassiveImport_Batch 
     PO_ImportaCollegamentiMassivo
     Database.executeBatch(new BatchBonificaCEIVerticali());
    }*/
    
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
       query =	'select id,name,isdabonificare__c,Asset__c, Asset_Verticale__c from OF_Billing_Element_Verticale__c where OF_Status__c =\'Attivo\'';

        system.debug('>>>>>>>>>>>> query: ' + query);                 
        
        return Database.getQueryLocator(query);
    }
    

    global void execute(Database.BatchableContext BC, List<OF_Billing_Element_Verticale__c> scope){
              
        Set<String> idAssetList = new Set<String>();
        for (OF_Billing_Element_Verticale__c record : scope) {
			idAssetList.add(record.Asset__c);
		}
        
        List<OF_CommercialElementIstanziato__c> ceiv_totali = [SELECT id, name, OF_Asset__c, OF_Stato__c, OF_DataCessazione__c
		                                                       FROM OF_CommercialElementIstanziato__c
		                                                       WHERE OF_CommercialElement__r.name = 'Servizio Verticale'
		                                                           AND OF_Stato__c = 'Attivo' AND OF_Asset__c IN :idAssetList];
       
        if (scope != null  && !scope.isEmpty()) {
        map<Id, OF_CommercialElementIstanziato__c> mapIdCeiv = new map<Id, OF_CommercialElementIstanziato__c> ();
    	for (OF_CommercialElementIstanziato__c cei : ceiv_totali) {
			mapIdCeiv.put(cei.OF_Asset__c, cei);
		}

        for (OF_Billing_Element_Verticale__c bev : scope) {
            OF_CommercialElementIstanziato__c old_cei = mapIdCeiv.get(bev.Asset__c);
    		if (old_cei == null) {
    			 bev.isdabonificare__c =true;
    		}
        }
        update scope; 
         
      }  
    } 
	
    global void finish(Database.BatchableContext BC){
        
       
    }
    
    
    
}
trigger CompilaTotalone on OF_CQS_Ispezione__c (before insert, after insert, before update) {
	
    if((Trigger.isBefore)&&(Trigger.isInsert)){
        system.debug('Parte before Insert');
        for(OF_CQS_Ispezione__c isp : Trigger.New){
           CQS_Utils.calcolaPunteggio(isp);
        }
    } 
    if((Trigger.isAfter)&&(Trigger.isInsert)){
        system.debug('Parte after Insert');
        Set<Id> SetProgetti = new Set<Id>();
        Map<Id,Id> mapIspProg = new Map<Id,Id>();
        for(OF_CQS_Ispezione__c isp2 : Trigger.New){
           SetProgetti.add(isp2.CQS_ISP_Progetto__c);
           mapIspProg.put(isp2.id,isp2.CQS_ISP_Progetto__c);
           
        }
        CQS_Utils.setApexSharing(mapIspProg,SetProgetti); 		
    	CQS_Utils.updateTrigger=false;
    }
   
    if((Trigger.isBefore)&&(Trigger.isUpdate)){

      	  system.debug('Parte before Update');        
       if(CQS_Utils.updateTrigger) {
    	CQS_Utils.x=0;
    	CQS_Utils.y=0;        	
           List<OF_CQS_Ispezione__c> ispListToUpdate = new List<OF_CQS_Ispezione__c>();
            for (OF_CQS_Ispezione__c isp : trigger.new){
                CQS_Utils.calcolaPunteggio(isp);
            }
     	}
     } 
    
}
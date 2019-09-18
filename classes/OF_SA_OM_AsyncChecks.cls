public with sharing class OF_SA_OM_AsyncChecks {
    public static Map<String,EOF_EAI_Service_Log__c> OM_AsyncCompletionOrder(Case c,OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co){
 					
    	return OF_SA_OM_SendToOLO.OM_CreateAckNackCompletionOrder(c, co); 
    	
    }
    
    public static Map<String,EOF_EAI_Service_Log__c> OM_AsyncReschedule(Case c,OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r){
 		 
    	
    	return OF_SA_OM_SendToOLO.OM_CreateAckNackReschedule(c, r);
    }
     
    public static Map<String,EOF_EAI_Service_Log__c> OM_AsyncStatusUpdate(Case c,OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su){
 		
 		return OF_SA_OM_SendToOLO.OM_CreateAckNackStatusUpdateDaOM(c, su);
    	
    }
}
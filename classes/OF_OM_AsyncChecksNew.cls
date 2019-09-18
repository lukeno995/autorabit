public class OF_OM_AsyncChecksNew {
    //StatusUpdate Attivi
    public static Map<String,EOF_EAI_Service_Log__c> OM_AsyncStatusUpdateNew(Case c,OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su){        
        return OF_OM_SendToOLONew.OM_CreateAckNackStatusUpdateDaOMNew(c, su);
    }
    //StatusUpdate Passivi
    public static Map<String,EOF_EAI_Service_Log__c> OM_AsyncStatusUpdateNew_GPONP(Case c,OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su){      
        //Done AA - Ricreare metodo verso OLO 
        return OF_OM_SendToOLONew.OM_CreateAckNackStatusUpdateDaOMNew_GPONP(c, su);
    }
    //Reschedule Attivi
    public static Map<String,EOF_EAI_Service_Log__c> OM_AsyncReschedule(Case c,OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r){
        return OF_OM_SendToOLONew.OM_CreateAckNackRescheduleNew(c, r);
    }
    //Reschedule Passivi
     public static Map<String,EOF_EAI_Service_Log__c> OM_AsyncReschedule_GPONP(Case c,OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r){
        return OF_OM_SendToOLONew.OM_CreateAckNackRescheduleNew_GPONP(c, r);
    }
    //CompletionOrder Attivi
    public static Map<String,EOF_EAI_Service_Log__c> OM_AsyncCompletionOrderNew(Case c, OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co){ 					
    	return OF_OM_SendToOLONew.OM_CreateAckNackCompletionOrderNew(c, co);     	
    }
    //CompletionOrder Passivi
    public static Map<String,EOF_EAI_Service_Log__c> OM_AsyncCompletionOrderNew_GPONP(Case c, OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co){ 					
    	return OF_OM_SendToOLONew.OM_CreateAckNackCompletionOrderNew_GPONP(c, co);     	
    }
}
public with sharing class OF_SA_OM_CreateNotify {
    public static void OM_Notify_CompletionOrder(Case c, OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co){
    	eof_Notify__c n = new eof_Notify__c();
    }
    
    public static void OM_Notify_Reschedule(Case c, OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule co){
    	eof_Notify__c n = new eof_Notify__c();
    }
    
    public static void OM_Notify_StatusUpdate(Case c, OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate co){
    	eof_Notify__c n = new eof_Notify__c();
    }
}
@isTest
public class OF_SA_OM_CreateNotify_Test
{
    public static testmethod void OF_SA_OM_CreateNotifyTest()
    {
        OF_SA_OM_CreateNotify CreateNotify = new OF_SA_OM_CreateNotify();
        Case c = new Case();
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder completionOrder = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule reschedule = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();      
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate statusUpdate  = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate ();      
        
        Test.StartTest();
        OF_SA_OM_CreateNotify.OM_Notify_CompletionOrder(c,completionOrder);
        OF_SA_OM_CreateNotify.OM_Notify_Reschedule(c,reschedule);
        OF_SA_OM_CreateNotify.OM_Notify_StatusUpdate(c,statusUpdate);
        Test.StopTest();
        
     
   }

}
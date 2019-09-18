@isTest
public class OF_SA_CD_WS_IN_OM_TEST{

   public static testmethod void test1()
   {
       OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate notify1 = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
       OF_SA_CD_WS_IN_OM.CD_OM_Notify_StatusUpdate(notify1);
   }
   
   public static testmethod void test2()
   {
       OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder notify2 = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
       OF_SA_CD_WS_IN_OM.CD_OM_Notify_CompletionOrder(notify2);
   }
   
   public static testmethod void test3()
   {
       OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule notify3 = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
       OF_SA_CD_WS_IN_OM.OM_Reschedule(notify3);
   }
}
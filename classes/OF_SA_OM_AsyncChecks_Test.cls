@isTest
public class OF_SA_OM_AsyncChecks_Test {
    static testmethod void FirstMethod(){        
        Case c = new case();
        insert c;
        try{
            OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder test1 = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
            OF_SA_OM_AsyncChecks.OM_AsyncCompletionOrder(c,test1);
        }
        catch(exception e){}       
        
    }
    static testmethod void SecondMethod() {
        try {
            Case c = new case();
            insert c;
            OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule test2 = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
            
            OF_SA_OM_AsyncChecks.OM_AsyncReschedule(c,test2);
        } catch(exception e){}
        
    }
    static testmethod void ThirdMethod(){
        try{
            Case c = new case();
            insert c;
            OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate test3 = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
            
            OF_SA_OM_AsyncChecks.OM_AsyncStatusUpdate(c,test3);
        }catch(exception e){}
        
    }
}
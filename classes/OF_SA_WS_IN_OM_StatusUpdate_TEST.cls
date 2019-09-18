@isTest
public class OF_SA_WS_IN_OM_StatusUpdate_TEST {
    static testMethod void testOF_SA_WS_IN_OM_StatusUpdate(){
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate omStatusUpdate = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate(omStatusUpdate);
        
    }
    static testMethod void testOF_SA_WS_IN_OM_StatusUpdate2(){
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate omStatusUpdate = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();

        omStatusUpdate.STATO_ORDINE='0';
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate(omStatusUpdate);

        omStatusUpdate.STATO_ORDINE='1';
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate(omStatusUpdate);
        
        omStatusUpdate.STATO_ORDINE='2';
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate(omStatusUpdate);

        omStatusUpdate.STATO_ORDINE='3';
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate(omStatusUpdate);

        omStatusUpdate.STATO_ORDINE='4';
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate(omStatusUpdate);
        
        omStatusUpdate.STATO_ORDINE='5';
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate(omStatusUpdate);

        omStatusUpdate.STATO_ORDINE='6';
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate(omStatusUpdate);

        omStatusUpdate.STATO_ORDINE='7';
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate(omStatusUpdate);
       
    }

    
}
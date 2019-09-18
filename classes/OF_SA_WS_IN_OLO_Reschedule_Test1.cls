@isTest
global class OF_SA_WS_IN_OLO_Reschedule_Test1 {
    global static testmethod void TestOF_SA_WS_IN_OLO_Reschedule()
    {
        
        try{
            OF_SA_WS_IN_OLO_Reschedule testObj = new OF_SA_WS_IN_OLO_Reschedule();
            OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest re1 = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
            OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleResponse re2 = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleResponse();
            
            OF_SA_WS_IN_OLO_Reschedule.OLO_Reschedule(re1);
        }
        catch(exception e ){
            system.debug('error message----->'+e.getStackTraceString());
        }
    }
    
}
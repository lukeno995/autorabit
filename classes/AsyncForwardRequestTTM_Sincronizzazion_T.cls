@isTest
public class AsyncForwardRequestTTM_Sincronizzazion_T{
    
    public static testmethod void Method(){
       
        test.startTest();
        AsyncForwardRequestTTM_Sincronizzazion.TroubleTicketFwdResp_elementFuture obj1 = new AsyncForwardRequestTTM_Sincronizzazion.TroubleTicketFwdResp_elementFuture();
        ForwardRequestTTM_Sincronizzazion.TroubleTicketFwdResp_element getValue = obj1.getValue();
        test.stopTest();
    }
}
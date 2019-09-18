@isTest
public class AsyncForwardRequestTTM_Test{
    public static testMethod void AsyncMethod(){
        AsyncForwardRequestTTM.AsyncSyncPortTypeEndpoint1  req = new AsyncForwardRequestTTM.AsyncSyncPortTypeEndpoint1();
        Continuation con = new Continuation(40);
        //insert con;
        req.beginForwardTroubleTicket_TTM(con,'Test','Test','Test');
    }
}
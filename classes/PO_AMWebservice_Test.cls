@isTest
public class PO_AMWebservice_Test{
    public static testMethod void PO_AMWebserviceMethod(){
    
        Test.StartTest();
       // Test.setMock(WebServiceMock.class, new PO_AMWebservice_Mock ());
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock ());

        PO_AMWebservice amweb = new PO_AMWebservice();
        amweb.get('Roma');
        amweb.getviaservice('Roma','123');
        amweb.getproductavailability('123');
        amweb.getcivicoservice('Roma','123');
        Test.StopTest();
    }
    
}
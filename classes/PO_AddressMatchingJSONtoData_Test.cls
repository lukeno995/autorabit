@isTest
public class PO_AddressMatchingJSONtoData_Test {
     
   
    
    @isTest
    public static void test1A()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        String com = 'ROMA1';
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        obj.PO_AddressMatchingJSONtoData(com);
        
        
        Test.StopTest();
        
    }
    
    @isTest
    public static void test1B()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        String com = 'ROMA2';
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        obj.PO_AddressMatchingJSONtoData(com);
        
        
        Test.StopTest();
        
    }
    
    @isTest
    public static void test2A()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        String com = 'ROMA';
        String ComuneId = '123';
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        obj.getVia(com,ComuneId);
        
        
        Test.StopTest();
        
    }
    
    @isTest
    public static void test2B()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        String com = 'ROMA';
        String ComuneId = '456';
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        obj.getVia(com,ComuneId);
        
        
        Test.StopTest();
        
    }
    
     @isTest
    public static void test3A()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        String com = 'Roma';
        String civicoId = '123';
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        obj.getcivico(com,civicoId);
        
        
        Test.StopTest();
        
    }
    
    @isTest
    public static void test3B()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        String com = 'Roma';
        String civicoId = '456';
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        obj.getcivico(com,civicoId);
        
        
        Test.StopTest();
        
    }
    
     @isTest
    public static void test4A()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        String civicoId='380100004006087';
        obj.getProductAvaiResp(civicoId);
        Test.StopTest();
        
    }
@isTest
    public static void test4B()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        String civicoId='380100004006081';
        obj.getProductAvaiResp(civicoId);
        Test.StopTest();
        
    }
    
    @isTest
    public static void test4C()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        String civicoId='380100004037089';
        obj.getProductAvaiResp(civicoId);
        Test.StopTest();
        
    }
     //Edited on 10122018 by Priyanka and Nikita 
     @isTest
    public static void test4D()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        String civicoId='380100004006088';
        obj.getProductAvaiResp(civicoId);
        Test.StopTest();
        
    }
    
     @isTest
    public static void test4E()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        String civicoId='380100004037011';
        obj.getProductAvaiResp(civicoId);
        Test.StopTest();
        
    }
    
     @isTest
    public static void test4F()
    {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new PO_AMWebservice_Mock2());
        PO_AddressMatchingJSONtoData obj = new PO_AddressMatchingJSONtoData();
        String civicoId='380100004037012';
        obj.getProductAvaiResp(civicoId);
        Test.StopTest();
        
    }


}
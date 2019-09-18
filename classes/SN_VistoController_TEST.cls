@isTest
public class SN_VistoController_TEST {
    
    public static testmethod void test1(){
        
        TestDataFactory.CreateTestRecords('SN_Social_Request',null,null);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(TestDataFactory.cList[0]);
        
        test.startTest();
		SN_VistoController snv = new SN_VistoController(sc);
		snv.updateField();
                
		test.stopTest();
        
    }

}
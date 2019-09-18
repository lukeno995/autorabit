@isTest
public class SN_RollUpReTweet_TEST {
    
    public static testmethod void test1(){
        
        TestDataFactory.CreateTestRecords('SN_Social_Request',null,null);
		
		SocialPost ccv = new SocialPost();
        ccv.Name='Tweet';
        ccv.MessageType='';
        ccv.IsOutbound =true;
        ccv.ParentId = TestDataFactory.cList[0].id;
        
        test.startTest();
        
        insert ccv;
        
        test.stopTest();
        
    }
    
    public static testmethod void test2(){
        
        TestDataFactory.CreateTestRecords('SN_Social_Request',null,null);
		
		SocialPost ccv = new SocialPost();
        ccv.Name='Tweet';
        ccv.MessageType='Retweet';
        ccv.IsOutbound =true;
        ccv.ParentId = TestDataFactory.cList[0].id;
        
        test.startTest();
        
        insert ccv;
        
        test.stopTest();
        
    }
    
    public static testmethod void test3(){
        
        TestDataFactory.CreateTestRecords('SN_Social_Request',null,null);
		
		SocialPost ccv = new SocialPost();
        ccv.Name='Tweet';
        ccv.MessageType='';
        ccv.IsOutbound =false;
        ccv.ParentId = TestDataFactory.cList[0].id;
        
        test.startTest();
        
        insert ccv;
        
        test.stopTest();
        
    }
    
    

}
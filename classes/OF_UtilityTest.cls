@isTest
public class OF_UtilityTest {
    static testMethod void OF_UtilityTest1()
    {
        OF_Utility.logMessage(true,'L','ClassTest','MethodTest','ErrorMessageTest');
        OF_Utility.logMessage(true,'E','ClassTest','MethodTest','ErrorMessageTest');
        OF_Utility.logMessage(true,'P','ClassTest','MethodTest','ErrorMessageTest');
        OF_Utility.logMessage(true,'X','ClassTest','MethodTest','ErrorMessageTest');

    }
    static testMethod void OF_UtilityTest2()
    {
        OF_Utility.logMessageProcessBuilder(new List<String>{'Message1','Message2'});
        OF_Utility.DebugLimitQuery(true,'T','Entity','Method');
        OF_Utility.DebugLimitQuery(true,'C','Entity','Method');
        OF_Utility.DeleteLog('All');

    }
    
    static testMethod void OF_UtilityTest3(){
        
        test.startTest();
        try{
            case c = [select id, accountId from case where createddate =:system.now()];
            delete c;
        }catch(exception e){
 
                    OF_utility.logMessageNew2('test','E','OF_UtilityTest','OF_UtilityTest2',0,e);

        }

            
        test.stopTest();
    }

}
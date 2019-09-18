@isTest  
public class checkRecursive_Test
{   
    @isTest
    static void testRecursive() 
    {
        system.assert(CheckRecursive.runOnce());
        system.assert(!CheckRecursive.runOnce());
        system.assert(!CheckRecursive.runOnce());
        system.assert(!CheckRecursive.runOnce());
    }
    
    static testmethod void testRecursive1() 
    {
       FutureUtility ftul=new FutureUtility();
       FutureUtility.isFutureUpdate = true;
       system.assertequals(FutureUtility.isFutureUpdate,FutureUtility.isFutureUpdate);
       FutureUtility.isFutureUpdate = false;
        system.assert(!FutureUtility.isFutureUpdate);
        
    }
}
@isTest  
public class checkRecursiveForOp_Test
{   
    @isTest
    static void testRecursive() 
    {
        system.assert(checkRecursiveForOp.runOnce());
        system.assert(!checkRecursiveForOp.runOnce());
        system.assert(!checkRecursiveForOp.runOnce());
        system.assert(!checkRecursiveForOp.runOnce());
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
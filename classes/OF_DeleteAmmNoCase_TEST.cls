@isTest
public class OF_DeleteAmmNoCase_TEST {
	
	public static testMethod void testschedule() {
		CA_Amministratore__c amm = new CA_Amministratore__c (); 
		insert amm;
		test.startTest();
	    OF_Schedule_DeleteAmmNoCase sr = new OF_Schedule_DeleteAmmNoCase();             
		String sch = '0 0 5 * * ?';
		String jobID = system.schedule('Delete Amm', sch, sr);
		Test.stopTest();
	}
}
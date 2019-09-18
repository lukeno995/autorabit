@isTest
public class PO_ServFattInfo_Test {

	public static testmethod void test1() {
		PO_ServFatt_DataFactory.createCustomSettings();

		Test.startTest();
		PO_ServFattInfo cs = new PO_ServFattInfo();
		System.assertEquals(false, cs.getNames().isEmpty());
		System.assertEquals(false, cs.getCodes().isEmpty());
		System.assertEquals(false, cs.getEspletamentoPSMServiceMap().isEmpty());
		System.assertEquals(false, cs.getDevNamesForOpportunityHandler().isEmpty());
		System.assertEquals(false, cs.getCaseDevNameMap().isEmpty());
		System.assertEquals(true, cs.getCessazioneBeList('abc').isEmpty());
		System.assertEquals(false, cs.getCessazioneBeList('Backhauling').isEmpty());
		Test.stopTest();
	}
}
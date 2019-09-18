@isTest
public class PO_AMJSONtoApexVia_Test {

    static testMethod void testParse() {
        
        PO_AMJSONtoApexVia obj = new PO_AMJSONtoApexVia();
        
		String json=		'{'+
		'"Result": "OK",'+
		'"Address": {'+
		'"Comune": {'+
		'"NumRecord": "1",'+
		'"Strada": ['+
		'{'+
		'"IdEgonStrada": "38000649550",'+
		'"DescStrada": "VIALE DELLO STADIO",'+
		'"Cap": "05100"'+
		'}'+
		']'+
		'}'+
		'}'+
		'}'+
		'';
		PO_AMJSONtoApexVia.parse(json);
		
	}
}
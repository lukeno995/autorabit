@isTest
public class PO_AMJSONtoApexCivico_Test {
    
    static testMethod void testParse() {
        
        PO_AMJSONtoApexCivico obj = new PO_AMJSONtoApexCivico();
        
		String json=		'{'+
		'"Result": "OK",'+
		'"Address": {'+
		'"Comune": {'+
		'"Strada":{'+
		'"NumRecord": "1",'+
		'"civico":[{'+
		''+
		'"IdEgonCivico": "380000024980000",'+
		'"DescCivico": "55",'+
		'"Esponente":"",'+
		'"TipoCivico ": "0"'+
		'}'+
		']'+
		''+
		'}'+
		'}'+
		'}}'+
		'';
		PO_AMJSONtoApexCivico.parse(json);
		
	}

}
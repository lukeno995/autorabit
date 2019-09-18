@isTest
public class PO_AMJSONtoApexComune_Test {
    
    @isTest
    
    public static void test1()
    {
        
        //PO_AMJSONtoApexComune PC1=new PO_AMJSONtoApexComune();
        
            
            String json=		'{'+
		'"Address": {'+
		'"NumRecord": "1",'+
		'"Comune": ['+
		'{'+
		'"IdEgonComune": "38000000533",'+
		'"Cap": "05100",'+
		'"DescProvincia": "TERNI",'+
		'"DescComune": "TERNI"'+
		'}'+
		']'+
		'},'+
		'"Result": "OK"'+
		'}'+
		'';
        PO_AMJSONtoApexComune.parse(json);
		
		//System.assert(obj != null);
    }

}
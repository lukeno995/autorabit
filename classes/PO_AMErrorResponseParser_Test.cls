@isTest
public class PO_AMErrorResponseParser_Test {
    
   static testMethod void testParse() {
		String str=	'{"Result": "KO","Code":"C01","Description": "Service not available"}';

		PO_AMErrorResponseParser.parse(str);
		//System.assert(obj != null);
	}

}
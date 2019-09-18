@isTest
public class PO_AMJSONtoApexProductAvailabilty_Test {

    
    @isTest
    
    public static void test1()
    {
      
         
            String json=		'{'+
		'  "Result": "OK",'+
		'  "Description": "",'+
		'  "NumRecord": "2",'+
		'  "IdCivico": ['+
		'    {'+
		'      "ID_BUILDING": "10_054_054039_8000065082_78 ",'+
		'      "SCALA_PALAZZINA": "A",'+
		'      "POP": "PG_01",'+
		'      "SERVICE_TYPE": "Attivo",'+
		'      "SERVICE_STATUS": "110",'+
		'      "DATA_RFC_INDICATIVA": "01/04/2018 00:00",'+
		'      "DATA_RFC_EFFETTIVA": "01/04/2018 00:00",'+
		'      "DATA_RFA_INDICATIVA": "01/04/2018 00:00",'+
		'      "DATA_RFA_EFFETTIVA": "01/04/2018 00:00",'+
		'      "DATA_ULTIMA_MODIFICA_RECORD": "01/04/2018 00:00",'+
		'      "DATA_ULTIMA_VARIAZIONE_STATO_BUILDING": "01/04/2018 00:00",'+
		'      "DATA_ULTIMA_VARIAZIONE_STATO_SCALA_PALAZZINA": ""'+
		'    },'+
		'    {'+
		'      "ID_BUILDING": "10_054_054039_8000065082_78",'+
		'      "SCALA_PALAZZINA": "B",'+
		'      "POP": "PG_01",'+
		'      "SERVICE_TYPE": "Attivo",'+
		'      "SERVICE_STATUS": "110",'+
		'      "DATA_RFC_INDICATIVA": "01/04/2018 00:00",'+
		'      "DATA_RFC_EFFETTIVA": "01/04/2018 00:00",'+
		'      "DATA_RFA_INDICATIVA": "01/04/2018 00:00",'+
		'      "DATA_RFA_EFFETTIVA": "01/04/2018 00:00",'+
		'      "DATA_ULTIMA_MODIFICA_RECORD": "01/04/2018 00:00",'+
		'      "DATA_ULTIMA_VARIAZIONE_STATO_BUILDING": "01/04/2018 00:00",'+
		'      "DATA_ULTIMA_VARIAZIONE_STATO_SCALA_PALAZZINA": ""'+
		'    },'+
		'    {'+
		'      "ID_BUILDING": "10_054_054039_8000065082_78",'+
		'      "SCALA_PALAZZINA": "A",'+
		'      "POP": "PG_01",'+
		'      "SERVICE_TYPE": "Passivo",'+
		'      "SERVICE_STATUS": "110",'+
		'      "DATA_RFC_INDICATIVA": "01/04/2018 00:00",'+
		'      "DATA_RFC_EFFETTIVA": "01/04/2018 00:00",'+
		'      "DATA_RFA_INDICATIVA": "01/04/2018 00:00",'+
		'      "DATA_RFA_EFFETTIVA": "01/04/2018 00:00",'+
		'      "DATA_ULTIMA_MODIFICA_RECORD": "01/04/2018 00:00",'+
		'      "DATA_ULTIMA_VARIAZIONE_STATO_BUILDING": "01/04/2018 00:00",'+
		'      "DATA_ULTIMA_VARIAZIONE_STATO_SCALA_PALAZZINA": ""'+
		'    }'+
		'  ]'+
		'}'+
		'';
         PO_AMJSONtoApexProductAvailabilty.parse(json);
		
		//System.assert(obj != null);
    }

}
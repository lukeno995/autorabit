@isTest
global class PO_AMWebservice_Mock2 implements HttpCalloutMock {
    global string String1A ='https://ofs-ws.enel.com:44300/address/comune?Str=ROMA1';
    global string String1B ='https://ofs-ws.enel.com:44300/address/comune?Str=ROMA2';
    global string String2A = 'https://ofs-ws.enel.com:44300/address/comune/strada?Str=ROMA&IdEgonComune=123';
    global string String2B = 'https://ofs-ws.enel.com:44300/address/comune/strada?Str=ROMA&IdEgonComune=456';
    global string String3A = 'https://ofs-ws.enel.com:44300/address/comune/strada/civico?Str=Roma&IdEgonStrada=123';
    global string String3B = 'https://ofs-ws.enel.com:44300/address/comune/strada/civico?Str=Roma&IdEgonStrada=456';
    global string String4A = 'https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004006087';
    global string String4B = 'https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004006081';
    global string String4C = 'https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004037089';
    global string String4D = 'https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004006088';
    global string String4E = 'https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004037011';
    global string String4F = 'https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004037012';
    global string String5  = 'https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=8000002491';
    global HTTPResponse respond(HTTPRequest req) {
        System.debug('Test'+req.getEndpoint());
        if(req.getEndpoint()==String1A)
        {
        System.assertEquals('https://ofs-ws.enel.com:44300/address/comune?Str=ROMA1', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
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
        '');
        res.setStatusCode(200);
        return res;
        }else if(req.getEndpoint()==String1B)
        {
        System.assertEquals('https://ofs-ws.enel.com:44300/address/comune?Str=ROMA2', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
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
        '"Result": "KO"'+
        '}'+
        '');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String2A){
        System.assertEquals('https://ofs-ws.enel.com:44300/address/comune/strada?Str=ROMA&IdEgonComune=123', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
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
        '');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String2B){
        System.assertEquals('https://ofs-ws.enel.com:44300/address/comune/strada?Str=ROMA&IdEgonComune=456', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
        '"Result": "KO",'+
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
        '');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String3A){
        System.assertEquals('https://ofs-ws.enel.com:44300/address/comune/strada/civico?Str=Roma&IdEgonStrada=123', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
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
        '');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String3B){
        System.assertEquals('https://ofs-ws.enel.com:44300/address/comune/strada/civico?Str=Roma&IdEgonStrada=456', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
        '"Result": "KO",'+
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
        '');
        res.setStatusCode(200);
        return res;
        }
        
        else if(req.getEndpoint()==String4A){
        System.assertEquals('https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004006087', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
        '  "Result": "OK",'+
        '  "Description": "",'+
        '  "NumRecord": "1",'+
        '  "IdCivico": ['+
        '    {'+
        '      "ID_BUILDING": "10_054_054039_8000065082_78 ",'+
        '      "SCALA_PALAZZINA": "A",'+
        '      "POP": "PG_01",'+
        '      "SERVICE_TYPE": "attivo",'+
        '      "SERVICE_STATUS": "110",'+
        '      "DATA_RFC_INDICATIVA": "01/04/2018 00:00",'+
        '      "DATA_RFC_EFFETTIVA": "01/04/2018 00:00",'+
        '      "DATA_RFA_INDICATIVA": "01/04/2018 00:00",'+
        '      "DATA_RFA_EFFETTIVA": "01/04/2018 00:00",'+
        '      "DATA_ULTIMA_MODIFICA_RECORD": "01/04/2018 00:00",'+
        '      "DATA_ULTIMA_VARIAZIONE_STATO_BUILDING": "01/04/2018 00:00",'+
        '      "DATA_ULTIMA_VARIAZIONE_STATO_SCALA_PALAZZINA": ""'+
        '        }'+
        '  ]'+
        '}'+
        '');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String4B){
        System.assertEquals('https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004006081', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{  '+
        '    "Result":"OK",'+
        '    "Description":"",'+
        '    "NumRecord":"0"'+
        '}'+
        '');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String4C){
        System.assertEquals('https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004037089', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
        '   "Result": "OK",'+
        '   "NumRecord": "2",'+
        '   "IdCivico": ['+
        '      {'+
        '         "IdBuilding": "03_015_015146_8000050314_11",'+
        '         "ScalaPalazzina": "SX",'+
        '         "Pop": "MI/FCO/1",'+
        '         "Service_Type": "attivo",'+
        '         "Service_Status": "110",'+
        '         "DataUltimaModificaRecord": "14/03/2018 00:00",'+
        '         "DataUltimaVariazioneStatoBuilding": "04/12/2014 00:00",'+
        '         "DataUltimaVariazioneStatoScalaPalazzina": "04/12/2014 00:00"'+
        '      },'+
        '      {'+
        '         "IdBuilding": "03_015_015146_8000050314_11",'+
        '         "ScalaPalazzina": "DX",'+
        '         "Pop": "MI/FCO/1",'+
        '         "Service_Type": "attivo",'+
        '         "Service_Status": "110",'+
        '         "DataUltimaModificaRecord": "14/03/2018 00:00",'+
        '         "DataUltimaVariazioneStatoBuilding": "04/12/2014 00:00",'+
        '         "DataUltimaVariazioneStatoScalaPalazzina": "04/12/2014 00:00"'+
        '      }'+
        '   ]'+
        '}');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String4D){
        System.assertEquals('https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004006088', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
        '  "Result": "OK",'+
        '  "Description": "",'+
        '  "NumRecord": "1",'+
        '  "IdCivico": ['+
        '    {'+
        '      "ID_BUILDING": "10_054_054039_8000065082_78 ",'+
        '      "SCALA_PALAZZINA": "A",'+
        '      "POP": "PG_01",'+
        '      "SERVICE_TYPE": "passivo",'+
        '      "SERVICE_STATUS": "110",'+
        '      "DATA_RFC_INDICATIVA": "01/04/2018 00:00",'+
        '      "DATA_RFC_EFFETTIVA": "01/04/2018 00:00",'+
        '      "DATA_RFA_INDICATIVA": "01/04/2018 00:00",'+
        '      "DATA_RFA_EFFETTIVA": "01/04/2018 00:00",'+
        '      "DATA_ULTIMA_MODIFICA_RECORD": "01/04/2018 00:00",'+
        '      "DATA_ULTIMA_VARIAZIONE_STATO_BUILDING": "01/04/2018 00:00",'+
        '      "DATA_ULTIMA_VARIAZIONE_STATO_SCALA_PALAZZINA": ""'+
        '        }'+
        '  ]'+
        '}'+
        '');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String4E){
        System.assertEquals('https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004037011', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
        '   "Result": "OK",'+
        '   "NumRecord": "2",'+
        '   "IdCivico": ['+
        '      {'+
        '         "IdBuilding": "03_015_015146_8000050314_11",'+
        '         "ScalaPalazzina": "SX",'+
        '         "Pop": "MI/FCO/1",'+
        '         "Service_Type": "passivo",'+
        '         "Service_Status": "110",'+
        '         "DataUltimaModificaRecord": "14/03/2018 00:00",'+
        '         "DataUltimaVariazioneStatoBuilding": "04/12/2014 00:00",'+
        '         "DataUltimaVariazioneStatoScalaPalazzina": "04/12/2014 00:00"'+
        '      },'+
        '      {'+
        '         "IdBuilding": "03_015_015146_8000050314_11",'+
        '         "ScalaPalazzina": "DX",'+
        '         "Pop": "MI/FCO/1",'+
        '         "Service_Type": "passivo",'+
        '         "Service_Status": "110",'+
        '         "DataUltimaModificaRecord": "14/03/2018 00:00",'+
        '         "DataUltimaVariazioneStatoBuilding": "04/12/2014 00:00",'+
        '         "DataUltimaVariazioneStatoScalaPalazzina": "04/12/2014 00:00"'+
        '      }'+
        '   ]'+
        '}');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String4F){
        System.assertEquals('https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=380100004037012', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{'+
        '   "Result": "OK",'+
        '   "NumRecord": "2",'+
        '   "IdCivico": ['+
        '      {'+
        '         "IdBuilding": "03_015_015146_8000050314_11",'+
        '         "ScalaPalazzina": "SX",'+
        '         "Pop": "MI/FCO/1",'+
        '         "Service_Type": "attivo",'+
        '         "Service_Status": "110",'+
        '         "DataUltimaModificaRecord": "14/03/2018 00:00",'+
        '         "DataUltimaVariazioneStatoBuilding": "04/12/2014 00:00",'+
        '         "DataUltimaVariazioneStatoScalaPalazzina": "04/12/2014 00:00"'+
        '      },'+
        '      {'+
        '         "IdBuilding": "03_015_015146_8000050314_11",'+
        '         "ScalaPalazzina": "DX",'+
        '         "Pop": "MI/FCO/1",'+
        '         "Service_Type": "passivo",'+
        '         "Service_Status": "110",'+
        '         "DataUltimaModificaRecord": "14/03/2018 00:00",'+
        '         "DataUltimaVariazioneStatoBuilding": "04/12/2014 00:00",'+
        '         "DataUltimaVariazioneStatoScalaPalazzina": "04/12/2014 00:00"'+
        '      }'+
        '   ]'+
        '}');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String5){
        System.assertEquals('https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=8000002491', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"Result":"KO","NumRecord":"0"}' );
        res.setStatusCode(200);
        return res;
        }
        else{
        return null;
        }
        
    }
    
    
}
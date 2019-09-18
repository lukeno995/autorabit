@isTest
global class PO_AMWebservice_Mock implements HttpCalloutMock {
    global string String1 ='https://ofs-ws.enel.com:44300/address/comune?Str=Roma';
    global string String2 = 'https://ofs-ws.enel.com:44300/address/comune/strada?Str=Roma&IdEgonComune=123';
    global string String3 = 'https://ofs-ws.enel.com:44300/address/comune/strada/civico?Str=Roma&IdEgonStrada=123';
    global string String4 = 'https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=123';
    global HTTPResponse respond(HTTPRequest req) {
        System.debug('Test'+req.getEndpoint());
        if(req.getEndpoint()==String1)
        {
        System.assertEquals('https://ofs-ws.enel.com:44300/address/comune?Str=Roma', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String2){
        System.assertEquals('https://ofs-ws.enel.com:44300/address/comune/strada?Str=Roma&IdEgonComune=123', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
        }
        else if(req.getEndpoint()==String3){
        System.assertEquals('https://ofs-ws.enel.com:44300/address/comune/strada/civico?Str=Roma&IdEgonStrada=123', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
        }
        
        else if(req.getEndpoint()==String4){
        System.assertEquals('https://ofs-ws.enel.com:44300/productavailability/idcivico?Str=123', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
        }
        else{
        return null;
        }
        
    }
    
    
}
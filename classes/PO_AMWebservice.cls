public class PO_AMWebservice {
   
   //Abhishek Anand 21112028 - FOR CR34 addreessmatching requirement this class is used to call the external endpoint and 
   //receive the JSON response 



    public String get(String com) {
        System.debug('com: '+ com);
        HttpRequest req = new HttpRequest();
       
     // req.setEndpoint('https://ofs-svil-ws.enel.com:44300/address/comune?Str='+com);
     //  req.setEndpoint('https://ofs-test-ws.enel.com:44300/address/comune?Str='+com);
         req.setEndpoint('https://ofs-ws.enel.com:44300/address/comune?Str='+com);
                
        req.setMethod('GET');
        req.setTimeout(120000);
        Http http = new Http();
        
        HTTPResponse response = http.send(req);
        system.debug('response========='+response.getBody());
        system.debug('status code========'+response.getStatusCode());
        String currval =  response.getBody();
       return currval;  
        
         
      }  
    
    
    public String getviaservice(String com,String ComuneId) {
        System.debug('com: '+ com);
        HttpRequest req = new HttpRequest();
       
       // /strada?Str=lui&IdEgonComune=38000000533
       //String endpointstrvia = 'https://ofs-svil-ws.enel.com:44300/address/comune/strada?Str='+com+'&IdEgonComune='+ComuneId; 
        //String endpointstrvia = 'https://ofs-test-ws.enel.com:44300/address/comune/strada?Str='+com+'&IdEgonComune='+ComuneId; 
        String endpointstrvia = 'https://ofs-ws.enel.com:44300/address/comune/strada?Str='+com+'&IdEgonComune='+ComuneId; 
       System.debug('endpointstr: '+endpointstrvia);
      req.setEndpoint(endpointstrvia);
        
                
        req.setMethod('GET');
        req.setTimeout(120000);
        Http http = new Http();
        
        HTTPResponse response = http.send(req);
        system.debug('response========='+response.getBody());
        system.debug('status code========'+response.getStatusCode());
        String currval =  response.getBody();
       return currval;  
        
         
      }  
    
    public String getcivicoservice(String com,String civicoId) {
        System.debug('com: '+ com);
        HttpRequest req = new HttpRequest();
       
       // /civico?Str=2&IdEgonStrada=38000647675

      // String endpointstrcivico = 'https://ofs-svil-ws.enel.com:44300/address/comune/strada/civico?Str='+com+'&IdEgonStrada='+civicoId; 
       // String endpointstrcivico = 'https://ofs-test-ws.enel.com:44300/address/comune/strada/civico?Str='+com+'&IdEgonStrada='+civicoId; 
         String endpointstrcivico = 'https://ofs-ws.enel.com:44300/address/comune/strada/civico?Str='+com+'&IdEgonStrada='+civicoId;
       System.debug('endpointstr: '+endpointstrcivico);
      req.setEndpoint(endpointstrcivico);
        
                
        req.setMethod('GET');
        req.setTimeout(120000);
        Http http = new Http();
        
        HTTPResponse response = http.send(req);
        system.debug('response========='+response.getBody());
        system.debug('status code========'+response.getStatusCode());
        String currval =  response.getBody();
       return currval;  
        
         
      }
    
    
     public String getproductavailability(String civicoId) {
        System.debug('com: '+ civicoId);
        HttpRequest req = new HttpRequest();
       
       // https://ofs-svil-ws.enel.com:44300/productavailability/idcivico

       //String endpointstrproductavailability = 'https://ofs-svil-ws.enel.com:44300/productavailability/idcivico?Str='+civicoId; 
        //String endpointstrproductavailability = 'https://ofs-test-ws.enel.com:44300/productavailability/idcivico?Str='+civicoId;
          String endpointstrproductavailability = 'https://ofs-ws.enel.com:44300/productavailability/idcivico?Str='+civicoId; 
       System.debug('endpointstrcivicoId: '+endpointstrproductavailability);
      req.setEndpoint(endpointstrproductavailability);
        
                
        req.setMethod('GET');
        req.setTimeout(120000);
        Http http = new Http();
        
        HTTPResponse response = http.send(req);
        system.debug('response========='+response.getBody());
        system.debug('status code========'+response.getStatusCode());
        String currval =  response.getBody();
       return currval;  
        
         
      }
   
}
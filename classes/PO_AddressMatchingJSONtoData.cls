public class PO_AddressMatchingJSONtoData {

    //Abhishek Anand 21112028 - FOR CR34 addreessmatching requirement this class is used to return Id and name from parsed JSON response values of comune, via and Civico  

   
       List<PO_AMResponseWrapper> accountWrappers = new List<PO_AMResponseWrapper>();
          public List<PO_AMResponseWrapper> PO_AddressMatchingJSONtoData (String repo){   
     system.debug('repo: '+repo);
              
              String replacedrepo ;
      
         replacedrepo = repo.replace(' ', '%20');
         system.debug('replacedrepocomuneId: '+replacedrepo);
              
             PO_AMWebservice callweb = new PO_AMWebservice();
            String reponsefromwebser=  callweb.get(replacedrepo);
             // String reponsefromwebser = '{"Address":{"NumRecord":"20","Comune":[{"IdEgonComune":"38000000243","Cap":"00100","DescProvincia":"ROMA","DescComune":"ROMA"},{"IdEgonComune":"38000007022","Cap":"84020","DescProvincia":"SALERNO","DescComune":"ROMAGNANO AL MONTE"},{"Cap":"28078","DescProvincia":"NOVARA","DescComune":"ROMAGNANO SESIA"},{"IdEgonComune":"38000003754","Cap":"27050","DescProvincia":"PAVIA","DescComune":"ROMAGNESE"},{"IdEgonComune":"38000004793","Cap":"38028","DescProvincia":"TRENTO","DescComune":"ROMALLO"},{"IdEgonComune":"38000000608","Cap":"07010","DescProvincia":"SASSARI","DescComune":"ROMANA"},{"IdEgonComune":"38000003446","Cap":"26014","DescProvincia":"CREMONA","DescComune":"ROMANENGO"},{"IdEgonComune":"38000001256","Cap":"10090","DescProvincia":"TORINO","DescComune":"ROMANO CANAVESE"}]},"Result":"OK"}';
    if (!reponsefromwebser.contains('KO')){
              
              PO_AMJSONtoApexComune actuals = PO_AMJSONtoApexComune.parse(reponsefromwebser);
              String NumRec = actuals.Address.NumRecord;
              if(actuals.Result == 'OK' && NumRec!='0' )
              {
                        for (PO_AMJSONtoApexComune.cls_Comune oct:actuals.Address.Comune){
                
                            accountWrappers.add(new PO_AMResponseWrapper(oct.DescComune,oct.IdEgonComune));
                            }        
              }
              else if (actuals.Result == 'OK' && NumRec=='0' )
              {
                // String message = 'Nessun Comune trovato';  //commented out for CR34 Improvement Abhishek Anand 12122018
                  
                // accountWrappers.add(new PO_AMResponseWrapper(message,NumRec)); //commented out for CR34 Improvement Abhishek Anand 12122018
                accountWrappers.add(new PO_AMResponseWrapper('Nessun Comune trovato',' '));
              }
    }
              else  if (reponsefromwebser.contains('KO'))
              {
               PO_AMErrorResponseParser errorresponse = PO_AMErrorResponseParser.parse(reponsefromwebser);
                  //Edited on 10122018 by Priyanka and Nikita
                  if(errorresponse.Description=='Il parametro Str è maggiore di 20 caratteri.'||errorresponse.Description=='Nessun Record Trovato') //CR34 Improvement Abhishek Anand 12122018 added the OR logic with errorresponse.Description=='Nessun Record Trovato'
                  {
                     //accountWrappers.add(new PO_AMResponseWrapper('Nessun Comune trovato',errorresponse.Code)); //commented out for CR34 Improvement Abhishek Anand 12122018
                      accountWrappers.add(new PO_AMResponseWrapper('Nessun Comune trovato',' ')); //CR34 Improvement Abhishek Anand 12122018
                  }
                  
                 else 
                 {
                 accountWrappers.add(new PO_AMResponseWrapper(errorresponse.Description,errorresponse.Code)); 
                 }
              }
               system.debug('accountWrappers: '+ accountWrappers);
             return accountWrappers; 
          }
    
    public List<PO_AMResponseWrapper> getVia(String repo,String ComuneId){   
      
               system.debug('repo: '+repo);
         system.debug('viaId: '+ComuneId);
        
        String replacedrepo ;
      
         replacedrepo = repo.replace(' ', '%20');
         system.debug('replacedrepoviaId: '+replacedrepo);
        
             PO_AMWebservice callweb = new PO_AMWebservice();
            String reponsefromwebser=  callweb.getviaservice(replacedrepo,ComuneId);
        system.debug('String reponsefromwebser: '+ reponsefromwebser);
              //String reponsefromwebser = '{"Address":{"Comune":{"NumRecord":"11","Strada":[{"DescStrada":"VIA DON LUIGI STURZO","Cap":"05100","IdEgonStrada":"38000647675"},{"DescStrada":"VIA LUIGI CASALE","Cap":"05100","IdEgonStrada":"38001217342"},{"DescStrada":"VIA LUIGI CORRADI","Cap":"05100","IdEgonStrada":"38001278154"},{"DescStrada":"VIA LUIGI GALVANI","Cap":"05100","IdEgonStrada":"38000647718"},{"DescStrada":"VIALE LUIGI CAMPOFREGOSO","Cap":"05100","IdEgonStrada":"38000649572"}]}},"Result":"OK"}';
    
         if (!reponsefromwebser.contains('KO')){
        PO_AMJSONtoApexVia actuals = PO_AMJSONtoApexVia.parse(reponsefromwebser);
            
        String NumRec = actuals.Address.Comune.NumRecord;
              if(actuals.Result == 'OK' && NumRec!='0' )
              {
                         for (PO_AMJSONtoApexVia.cls_Strada oct:actuals.Address.Comune.Strada){
                 
              system.debug('Stradaoct: '+ oct);
                  accountWrappers.add(new PO_AMResponseWrapper(oct.DescStrada,oct.IdEgonStrada));
              }             
              }
              else if (actuals.Result == 'OK' && NumRec=='0' )
              {
                 //String message = 'Nessuna Via trovata'; //commented out for CR34 Improvement Abhishek Anand 12122018
                  
               //  accountWrappers.add(new PO_AMResponseWrapper(message,NumRec)); //commented out for CR34 Improvement Abhishek Anand 12122018
                accountWrappers.add(new PO_AMResponseWrapper('Nessun Via trovato',' ')); //added for CR34 Improvement Abhishek Anand 12122018
                  
              }
         }
              else  if (reponsefromwebser.contains('KO'))
              {
                   PO_AMErrorResponseParser errorresponse = PO_AMErrorResponseParser.parse(reponsefromwebser);
                 //Edited on 10122018 by Priyanka and Nikita 
               if(errorresponse.Description=='Il parametro Str è maggiore di 20 caratteri.' ||errorresponse.Description=='Nessun Record Trovato' ) //CR34 Improvement Abhishek Anand 12122018 added the OR logic with errorresponse.Description=='Nessun Record Trovato'
                  {
                     // accountWrappers.add(new PO_AMResponseWrapper('Nessuna Via trovata',errorresponse.Code)); //commented out for CR34 Improvement Abhishek Anand 12122018
                       accountWrappers.add(new PO_AMResponseWrapper('Nessun Via trovato',' ')); //added for CR34 Improvement Abhishek Anand 12122018
                  }
                  
                 else 
                 {
                 accountWrappers.add(new PO_AMResponseWrapper(errorresponse.Description,errorresponse.Code)); 
                 }
              }
        
      system.debug('actuals: '+ accountWrappers);
               return accountWrappers; 
          }
    
    
    public List<PO_AMResponseWrapper > getcivico(String repo,String civicoId){   
      
               system.debug('repo: '+repo);
         system.debug('civicoId: '+civicoId);
         
        String replacedrepo ;
      
         replacedrepo = repo.replace(' ', '%20');
         system.debug('replacedrepocivicoId: '+replacedrepo);
        
             PO_AMWebservice callweb = new PO_AMWebservice();
            String reponsefromwebser=  callweb.getcivicoservice(replacedrepo,civicoId);
        system.debug('String civico reponsefromwebser : '+ reponsefromwebser);
             // String reponsefromwebser = '{"Address":{"Comune":{"Strada":{"NumRecord":"5","Civico":[{"Esponente":"","DescCivico":"20","IdEgonCivico":"380100091702009","TipoCivico":"0"},{"Esponente":"","DescCivico":"22","IdEgonCivico":"380130073695343","TipoCivico":"0"},{"Esponente":"","DescCivico":"24","IdEgonCivico":"380100091702015","TipoCivico":"0"},{"Esponente":"","DescCivico":"26","IdEgonCivico":"380130073695344","TipoCivico":"0"},{"Esponente":"","DescCivico":"28","IdEgonCivico":"380100091702021","TipoCivico":"0"}]}}},"Result":"OK"}';
        if (!reponsefromwebser.contains('KO')){
        PO_AMJSONtoApexCivico actuals = PO_AMJSONtoApexCivico.parse(reponsefromwebser);
        
            String NumRec = actuals.Address.Comune.Strada.NumRecord;
        if(actuals.Result == 'OK' && NumRec!='0' ){
              for (PO_AMJSONtoApexCivico.cls_civico oct:actuals.Address.Comune.Strada.civico){
                 
              system.debug('Civicooct: '+ oct);
                  String civicoEsponente = oct.DescCivico+' '+oct.Esponente;
                   system.debug('Civicooct: '+ civicoEsponente);
                  accountWrappers.add(new PO_AMResponseWrapper(civicoEsponente,oct.IdEgonCivico));
              }        
                        
              }
              else if (actuals.Result == 'OK' && NumRec=='0' )
              {
               //  String message = 'Nessun record trovato';
                  
                // accountWrappers.add(new PO_AMResponseWrapper(message,NumRec)); //commented out for CR34 Improvement Abhishek Anand 12122018
                   accountWrappers.add(new PO_AMResponseWrapper('Nessun Civico trovato',' ')); //added for CR34 Improvement Abhishek Anand 12122018
              } }
              else if (reponsefromwebser.contains('KO'))
              {
              PO_AMErrorResponseParser errorresponse = PO_AMErrorResponseParser.parse(reponsefromwebser);
                 //Edited on 10122018 by Priyanka and Nikita 
               if(errorresponse.Description=='Il parametro Str non è numerico.' ||errorresponse.Description=='Nessun Record Trovato' ) //CR34 Improvement Abhishek Anand 12122018 added the OR logic with errorresponse.Description=='Nessun Record Trovato'
                  {
                     // accountWrappers.add(new PO_AMResponseWrapper('Inserire un valore numerico',errorresponse.Code));  //commented out for CR34 Improvement Abhishek Anand 12122018
                      accountWrappers.add(new PO_AMResponseWrapper('Inserire un valore numerico',' ')); //added for CR34 Improvement Abhishek Anand 12122018
                  }
                  
                 else 
                 {
                 accountWrappers.add(new PO_AMResponseWrapper(errorresponse.Description,errorresponse.Code)); 
                 }
              }
               system.debug('accountWrappers: '+ accountWrappers); 
                  
        
             return accountWrappers; 
          }
     
    //Edited on 21122018 by Priyanka and Nikita
    public List<PO_AMResponseWrapper >  getProductAvaiResp(String civicoId){   
      
         String message;   
         system.debug('civicoId in getProductAvaiResp of PO_AddressMatchingJSONtoData: '+civicoId);
             PO_AMWebservice callweb = new PO_AMWebservice();
            String reponsefromwebser=  callweb.getproductavailability(civicoId);
        system.debug('String getProductAvaiResp reponsefromwebser : '+ reponsefromwebser);
             // String reponsefromwebser = '{"Address":{"Comune":{"Strada":{"NumRecord":"5","Civico":[{"Esponente":"","DescCivico":"20","IdEgonCivico":"380100091702009","TipoCivico":"0"},{"Esponente":"","DescCivico":"22","IdEgonCivico":"380130073695343","TipoCivico":"0"},{"Esponente":"","DescCivico":"24","IdEgonCivico":"380100091702015","TipoCivico":"0"},{"Esponente":"","DescCivico":"26","IdEgonCivico":"380130073695344","TipoCivico":"0"},{"Esponente":"","DescCivico":"28","IdEgonCivico":"380100091702021","TipoCivico":"0"}]}}},"Result":"OK"}';
    if (!reponsefromwebser.contains('KO')){
        PO_AMJSONtoApexProductAvailabilty actuals = PO_AMJSONtoApexProductAvailabilty.parse(reponsefromwebser);
        
        system.debug('String getProductAvaiResp actuals: '+ actuals.NumRecord);
       
     if(actuals.Result == 'OK') 
       {
            
         if( actuals.NumRecord=='0')
             
        {
            system.debug('Inside actuals.NumRecord==0 if condition');
             accountWrappers.add(new PO_AMResponseWrapper('Disponibilità Rete Open Fiber Soggetta a Studio di fattibilità preventivo',''));
        }
            
       /* else if(actuals.NumRecord=='1')
        {
            for (PO_AMJSONtoApexProductAvailabilty.cls_IdCivico Sertype1:actuals.IdCivico ){
            if(Sertype1.SERVICE_TYPE=='attivo')
            {
                accountWrappers.add(new PO_AMResponseWrapper('Disponibile','Non Disponibile'));
            }
                
             else if(Sertype1.SERVICE_TYPE=='passivo')  
             {
                  accountWrappers.add(new PO_AMResponseWrapper('Non Disponibile','Disponibile'));
             }
        }
        }*/
        
        else if(actuals.NumRecord=='2')
        {
                String Serty1 ;
            String Serty2 ;
            
                 system.debug('actuals.IdCivico[0].SERVICE_TYPE: '+ actuals.IdCivico[0].SERVICE_TYPE);
            system.debug('actuals.IdCivico[1].SERVICE_TYPE: '+ actuals.IdCivico[1].SERVICE_TYPE);
             
            
                   /* if(actuals.IdCivico[0].SERVICE_TYPE=='attivo' && actuals.IdCivico[1].SERVICE_TYPE=='attivo')
                    {
                        accountWrappers.add(new PO_AMResponseWrapper('Disponibile','Non Disponibile'));
                    }
                        
                     else if(actuals.IdCivico[0].SERVICE_TYPE=='passivo'  && actuals.IdCivico[1].SERVICE_TYPE=='passivo')  
                     {
                          accountWrappers.add(new PO_AMResponseWrapper('Non Disponibile','Disponibile'));
                     }*/
                    
                     if(actuals.IdCivico[0].SERVICE_TYPE=='passivo' && actuals.IdCivico[1].SERVICE_TYPE=='attivo' || actuals.IdCivico[0].SERVICE_TYPE=='attivo' && actuals.IdCivico[1].SERVICE_TYPE=='passivo')  
                     {
                          accountWrappers.add(new PO_AMResponseWrapper('Rete Open Fiber Disponibile',''));
                     }
                
        }
       }}
        
    else if (reponsefromwebser.contains('KO'))
    {
        PO_AMErrorResponseParser errorresponse = PO_AMErrorResponseParser.parse(reponsefromwebser);
         accountWrappers.add(new PO_AMResponseWrapper(errorresponse.Description,errorresponse.Code));
    }
                        system.debug('accountWrappers: '+ accountWrappers);             
            return accountWrappers;
            
          }
    
     
    
}
public class OF_UtilitiesCreazioneAsset{
        
         /**This method return an List of Listini,given the ContractID of many contract**/
         public static Set<ID> getListino(Set<ID> lc)
         {
            try{
                      if( lc != null )
                      {
                         Set<ID> idListini = new Set<ID>();
                         List<OF_Listino__c> listOfLis = [SELECT ID,Name,OF_IDContract__c
                                                          FROM OF_Listino__c
                                                          WHERE OF_IDContract__c in : lc ];
                         if( listOfLis != null && listOfLis.size() > 0 )
                         {
                            for( OF_Listino__c l : listOfLis )
                            {
                                 idListini.add(l.Id);
                            }
                         }
                         return idListini;
                                 
                      }
                     return null;
               }catch(Exception e )
               {
                  OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: getListino',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );           
                return null;
               }
           }
          
          /**1.Se EsitoConsegnaApparato == 0 o 1,si aggiungono i BillingElement 'Contributo qualificazione e installazione'
                                                                              'Contributo logistica'
             2.Se EsitoConsegnaApparato == 2,si aggiungono i BillingElement   'Contributo qualificazione e installazione'
                                                                            'Contributo logistica'
                                                                            'Contributo ribaltamento impianto'
            
             3.In ogni caso si aggiunge il BillingElement 'Contributo attivazione'
             4.Se SlaPremiumAssurance == 'N' oppure SlaPremiumAssurance == vuoto,si aggiunge il Billing 'Canone'
             5.Se SlaPremiumAssurance == 'Y' oppure SlaPremiumAssurance == vuoto,si aggiunge il Billing 'Canone Premium'
           **/
          public static List<String> getControlli1(String EsitoConsegnaApparato,String SlaPremiumAssurance)
          {
           try{
                    List<String> s1 = new List<String>();
                    
                    if( EsitoConsegnaApparato != null && !String.isBlank(EsitoConsegnaApparato) )
                    {
                            if( EsitoConsegnaApparato.contains('Installazione CPE')){          
                                s1.add('CONTRIBUTO QUALIFICAZIONE E INSTALLAZIONE');
                                s1.add('CONTRIBUTO LOGISTICA');
                            }
                            if(EsitoConsegnaApparato.contains('Ribaltamento Impianto')){
                                s1.add('CONTRIBUTO QUALIFICAZIONE E INSTALLAZIONE');
                                s1.add('CONTRIBUTO LOGISTICA');
                                s1.add('CONTRIBUTO RIBALTAMENTO IMPIANTO');
                            }
                    }
                       s1.add('CONTRIBUTO ATTIVAZIONE');
                       if(SlaPremiumAssurance == 'N' || SlaPremiumAssurance == null || String.isBlank(SlaPremiumAssurance) ){
                            s1.add('CANONE');
                       }
                       else{
                            if(SlaPremiumAssurance == 'Y'){
                                s1.add('CANONE PREMIUM');
                            }
                       }
                       
                       system.debug('DG20 - s: ' + s1);
                       
                      if(s1.size() > 0 ) return s1;
                      return null;
                      
              }catch(Exception e )
               {
                  OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: getControlli1',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                return null;
               }

    
          }
          
          
          /**Se apparato == N o vuoto,si aggiunge un BillingElement 'Contributo disattivazione'
             Se apparato == Y ,si aggiungono i BillingElement 'Contributo disattivazione'
                                                              'Contributo rimozione'**/
                                           
          public static List<String> getControlli2(String Apparato)
          {
              try{
                      List<String> s2 = new List<String>();
                      system.debug('DG - Apparato: ' + Apparato);
                    if( Apparato != null)
                    {
                      if( Apparato == 'N' || String.isBlank(Apparato) )
                      {          
                           s2.add('CONTRIBUTO DISATTIVAZIONE');
                      }else if( Apparato == 'Y')
                      {
                           s2.add('CONTRIBUTO DISATTIVAZIONE');
                           s2.add('CONTRIBUTO RIMOZIONE');
                      }
                    }
                        
                       system.debug('DG20 - s2: ' + s2);
                       
                      if(s2.size() > 0 ) return s2;
                      return null;
                      
                  }catch( Exception e )
                  {
                  OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: getControlli2',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );            
                return null;

                  }
              }
    
          /**Questo metodo prende in input una lista di Contratti,ed una mappa idContratto-ListaOrder.
             Si itera prima nei contratti e per ogni contratto,si va a prendere la lista degli Ordini relativi,
             e per ogni ordine si istanzia un Asset.Il tutto è stato pensato perun caricamento massivo di Ordini 
             con caratteristiche diverse,e di conseguenza anche contratti diversi ad esempio.**/
          public static List<Asset> CreazioneAsset(List<Contract> listaC ,Map<ID,List<Order>> contrOrder)
          {
             try{
                      /**OS30 Modifica 06_04_2017 Gestione con o senza OM***/
                        List<OF_Configurazioni__c> listCustomSett = OF_Configurazioni__c.getAll().values();
                        DateTime dataswitch = listCustomSett[0].DataSwitchOM__c;
                      
                       List<Asset> listAsset = new List<Asset>();
                       if( listaC.size() > 0 )
                       {
                        for( Contract c : listaC )
                        { 
                           List<Order> listOrder = contrOrder.get(c.Id);
                           for(Order o : listOrder)
                           {
                                 Asset ass = new Asset();
                                 system.debug('Order->'+o);
                                 ass.Name = o.OF_IDRisorsa__c;
                                 ass.AccountId = c.AccountId;
                                 ass.OF_Contract__c = c.Id;
                                 //ass.OF_Stato__c = 'Attivo';
                                 ass.Status = 'Attivo';
                                 ass.OF_ID_Building__c = o.OF_IDBuilding__c;
                                 ass.OF_Identificativo_del_POP__c = o.OF_IdentificativoDelPOP__c;
                                 ass.OF_GPON_Attestazione__c = o.OF_GPONAttestazione__c;
                                 ass.OF_Comune__c = o.OF_Comune__c;
                                 //ass.OF_DataAttivazione__c = Date.today();
                                 ass.OF_OrdineID__c = o.Id;
                                 ass.OF_Provincia__c = o.OF_Provincia__c;
                                 ass.OF_Particella_Toponomastica__c = o.OF_ParticellaToponomastica__c;
                                 ass.OF_Indirizzo__c = O.OF_Indirizzo__c;
                                 ass.OF_Civico__c = o.OF_Civico__c;
                                 ass.OF_Scala_Palazzina__c = o.OF_ScalaPalazzina__c;
                                 ass.OF_ServizioRichiesto__c = 'GPON Passiva';
                                 ass.EOF_ID_Risorsa__c = o.OF_IDRisorsa__c;
                                 ass.EOF_ID_Splitter_Secondario__c = o.OF_IDSplitterSecondario__c;
                                 ass.EOF_Posizione_Splitter_Secondario__c = o.OF_PosizioneSplitterSecondario__c;
                                 /**Modifica CRM 06_04_2017 Popolamento date senza OM**/
                                 if(system.now() < dataSwitch )
                                 {
                                     /*DG 28/04/2017 Commentato per nuova gestione date --> Process Builder: Data Attivazione Cessazione Asset e BillingElement
                                     ass.OF_DataAttivazione2__c = system.now(); //Campo di tipo DATE/TIME
                                     ass.OF_DataAttivazione__c = Date.today(); //Campo di tipo DATE
                                     */
                                 }
                                 /***************************/
            
                                 listAsset.add(ass);
                                 //system.debug('--\nDentro il secondo for()--\n');
                             }
                        }
                    }
                           if( listAsset.size() > 0 ) insert listAsset;
                         
                           return listAsset;
                           
                }catch( Exception e )
                  {
                  OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: CreazioneAsset',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );            
                return null;

                  }
                   
                 }
         
          /**Questo metodo ritorna una Mappa<ID,ID> che tiene traccia tra ID del PriceBook2
             e Product2**/
          /*
          public static Map<Id,PriceBook2>getMappaPriceBook2Product2(Set<ID> idListini,Order ord,Integer type)
          {
               system.debug('DG ord: ' + ord);
               Map<Id,PriceBook2> listaPriceProduct = new Map<Id,PriceBook2>();
               /**Mappa che tiene traccia dei IdListino - IdPriceBook2**
               Map<Id,Id> listiniProduct2 = new Map<Id,Id>();
               
               List<Product2> listaProduct2 = new List<Product2>();
               /**Nota:17-03-2017 - ad oggi l'unico servizio che si può richiedere è la GPON Passiva.*
               
               //DG Logica istanziazione Billing Element
               list<string> s = new list<string>();
              // system.debug('DG20 - ord.OF_EsitoConsegnaApparato__c: ' + ord.OF_EsitoConsegnaApparato__c);
               //system.debug('DG20 - ord.OF_SlaPremiumAssurance__c: ' + ord.OF_SlaPremiumAssurance__c);
               //system.debug('DG20 - type: ' + type);
               /**Attivazione**
               if( type == 0 )
               {
                  system.debug('DG20 - type == 0');
                  s = getControlli1(ord.OF_EsitoConsegnaApparato__c,ord.OF_SlaPremiumAssurance__c);
               }else if( type == 1 )
               {
               /**Cessazione**
                   system.debug('DG20 - type == 1');
                 //system.debug('stepOrlando dentro metodo getMappaPriceBook2Product2() ');
                 s = getControlli2(ord.OF_Apparato__c);
               }
               
               
               system.debug('DG20- s:'+s);  
               system.debug('OS30 idListini : '+idListini);
               
               
               
               
               listaProduct2 = [SELECT Id,OF_ListinoCustom__c,Name 
                                From Product2 
                                WHERE OF_ListinoCustom__c in : idListini AND OF_Servizio__c = 'GPON Passiva' AND Name IN: s];
              
              system.debug('orlando_listaProduct2-->'+listaProduct2);
               
               if( listaProduct2.size() > 0 )
               {
                 for( Product2 pr2 : listaProduct2 )
                 {
                     listiniProduct2.put(pr2.OF_ListinoCustom__c,pr2.Id);
                 }
               }
               system.debug('orlando_listiniProduct2:'+listiniProduct2);
               List<PriceBook2> listPriceBook2 = [SELECT Id,OF_Listino__r.OF_IDContract__c 
                                                  FROM PriceBook2 WHERE OF_Listino__c in : listiniProduct2.keySet()];
               if( listPriceBook2 != null && listPriceBook2.size() > 0 )
               {
                  for( PriceBook2 priceb2 : listPriceBook2)
                  {
                        listaPriceProduct.put(listiniProduct2.get(priceb2.OF_Listino__c),priceb2);
                  }
               }
               system.debug('orlando_listaPriceProduct:'+listaPriceProduct);
               if ( listaPriceProduct.size() > 0 )return listaPriceProduct;
               return null;
           }         
            /**Questo metodo disattiva i Billing Element associati ad un Asset.
               L'evento di inserimento di un Ordine di 'Cessazione' richiama questo metodo**/
            
            
            /**CRM Modifica 18_04_2017**/
            public static Map<Id,Map<Id,PriceBook2>> getMappaPriceBook2Product2(Map<Id,Set<ID>> OrderSetidListini,Map<ID,Order> orderID,Integer type)
            {
              try{
                      //system.debug('DG ord: ' + ord);
                       Map<Id,Map<Id,PriceBook2>> listaPriceProduct = new Map<Id,Map<Id,PriceBook2>>();
                       /**Mappa che tiene traccia dei IdListino - IdPriceBook2**/
                       Map<Id,Id> listiniProduct2 = new Map<Id,Id>();
                       
            
                       /**Nota:17-03-2017 - ad oggi l'unico servizio che si può richiedere è la GPON Passiva.*/
                       
                       //DG Logica istanziazione Billing Element
                       Map<Id,Set<string>> s = new Map<Id,Set<string>>();
                       Set<ID> totalListini = new Set<ID>();
                       
                       for( ID idOrdine : OrderSetIdListini.keyset())
                       {
                 
                         totalListini.addAll(OrderSetIdListini.get(idOrdine));
                         Order ord = orderID.get(idOrdine);
                           if( ord != null )
                            {
                                /**Attivazione**/
                                if( type == 0 )
                                {
                                    List<String> ls = new List<String>();
                                    Set<String> lsSet = new Set<String>();
                                    system.debug('DG20 - type == 0');
                                    ls = getControlli1(ord.OF_EsitoConsegnaApparato__c,ord.OF_SlaPremiumAssurance__c);
                                    lsSet.addAll(ls);
                                    
                                    s.put(idOrdine,lsSet);
                                }else if( type == 1 )
                                {
                                /**Cessazione**/
                                    List<String> lc = new List<String>();
                                    Set<String> lsSet = new Set<String>();
                                    system.debug('DG20 - type == 1');
                                    //system.debug('stepOrlando dentro metodo getMappaPriceBook2Product2() ');
                                    lc = getControlli2(ord.OF_Apparato__c);
                                    lsSet.addAll(lc);
                                    
                                    s.put(idOrdine,lsSet);
                                }
                            
                            }
                         
                         }
                         
                         system.debug('CRM OS : Order-List<String>():'+s);
                 
                         Map<ID,Product2> listaProduct2 = new Map<ID,Product2>([SELECT Id,OF_ListinoCustom__c,Name 
                                        From Product2 
                                        WHERE OF_ListinoCustom__c in : totalListini AND OF_Servizio__c = 'GPON Passiva']);
                                        
                          system.debug('CRM_listaProduct2-->'+listaProduct2);
                       
                          if( listaProduct2.size() > 0 )
                          {
                              for( ID pr2 : listaProduct2.keyset())
                              {
                                 listiniProduct2.put(listaProduct2.get(pr2).OF_ListinoCustom__c,pr2);
                              }
                          }
                         system.debug('CRM_listiniProduct2:'+listiniProduct2);
                         
                         List<PriceBook2> listPriceBook2 = [SELECT Id,OF_Listino__r.OF_IDContract__c 
                                                          FROM PriceBook2 WHERE OF_Listino__c in : listiniProduct2.keySet()];
                         
                         system.debug('CRM_listPriceBook2: '+listPriceBook2);
                         
                         if( listPriceBook2 != null && listPriceBook2.size() > 0 )
                         {
                             for( PriceBook2 priceb2 : listPriceBook2)
                             {
                                  Map<Id,PriceBook2> mpx = new Map<Id,PriceBook2>();
                                  mpx.put(listiniProduct2.get(priceb2.OF_Listino__c),priceb2);
                                  
                                  listaPriceProduct.put(priceb2.OF_Listino__c,mpx);
                                  
                                  //listaPriceProduct.put(listiniProduct2.get(priceb2.OF_Listino__c),priceb2);
                                  //mappa<id,
                             }
                         }
                         /**Creazione Mappa Order - Map<IdProduct,PriceBook>**/
                         system.debug('CRM listaPriceProduct : '+listaPriceProduct);
                         
                         Map<Id,Map<Id,PriceBook2>> OrdinePriceProduct = new Map<Id,Map<Id,PriceBook2>>();
                         system.debug('CRM_OrdinePriceProduct: '+OrdinePriceProduct);
                         
                        for( ID idord :  OrderSetidListini.keyset() )
                        {
                                for( ID idlistino : OrderSetidListini.get(idord))
                                {
                                       
                                       
                                       
                                       if( OrdinePriceProduct.containsKey(idord))
                                         {
                                            
                                         Map<Id,PriceBook2> ProdPriceBook2 = OrdinePriceProduct.get(idord);
                                         system.debug('CRM_ProdPriceBook2 : '+ProdPriceBook2);
                                         
                                         ProdPriceBook2.putAll(listaPriceProduct.get(idlistino)); //ProdPriceBook2.put(listaPriceProduct.get(idlistino).keyset() ,listaPriceProduct.get(idlistino));
                                         
                                         
                                         OrdinePriceProduct.put(idord,ProdPriceBook2);
                                         
                                         system.debug('CRM_OrdinePriceProduct(contains): '+OrdinePriceProduct);
                                         
                                         }else{
                                            
                                         Map<Id,PriceBook2> ProdPriceBook2 = new Map<Id,PriceBook2>();
                                         ProdPriceBook2 = listaPriceProduct.get(idlistino);
                                         
                                         system.debug('CRM_ProdPriceBook2(NOT contains : '+ProdPriceBook2);
                                         
                                         OrdinePriceProduct.put(idord,ProdPriceBook2);
                                         
                                         system.debug('CRM_OrdinePriceProduct:'+OrdinePriceProduct);
                                         
                                         }
                                  }
                          }
                         
                         system.debug('CRM OrdinePriceProduct : ' + OrdinePriceProduct);
                 
                         /**Logica di filtro sui BillingElement,in base ai controlli che vengono fatti in getControlli1()
                            e getControlli2()**/
                         Map<Id,Map<Id,PriceBook2>> OrdinePriceProductFilter = new Map<Id,Map<Id,PriceBook2>>();
                         
                         for( ID idord :  OrdinePriceProduct.keyset() )
                         {
                                Map<Id,PriceBook2> mapToInsert = new Map<Id,PriceBook2>();
                                Map<Id,PriceBook2> mapExist = OrdinePriceProduct.get(idord);
                                system.debug('CRM_20_04 idord'+idord);
                                system.debug('CRM_20_04 mapExist:'+mapExist + 'size: ' + mapExist.size());
                                system.debug('CRM_20_04 s :'+s);
                                
                                Set<String> ProductToCompare = s.get(idord);
                                system.debug('CRM_20_04 ProductToCompare :'+ProductToCompare);
                                
                                for( ID idProd : mapExist.keySet())
                                {
                                      
                                      String NomeProduct = listaProduct2.get(idProd).Name.ToUpperCase();
                                      system.debug('CRM_20_04 idProd : '+idProd+' -----NomeProduct: '+NomeProduct);
                                      //if( NomeProduct != null && !String.isBlank(NomeProduct))
                                      //{
                                      //system.debug('CMR_20_04 pointTo'
                                       system.debug('CRM_20_04 pointToFix : '+ProductToCompare.Contains(NomeProduct));
                                        if( ProductToCompare.Contains(NomeProduct) )
                                         {
                                          
                                         mapToInsert.put(idProd,mapExist.get(idProd));
                                         }
                                         
                                      //}
                                      system.debug('CRM_20_04 mapToInsert'+mapToInsert);
                                }
                                        
                               if( mapToInsert.size() > 0 ) OrdinePriceProductFilter.put(idord,mapToInsert);   
                                         
                          }
                          system.debug('CRM_20_04 OrdinePriceProductFilter'+OrdinePriceProductFilter);
                         
                         if( OrdinePriceProductFilter.size() > 0 ) return OrdinePriceProductFilter;
                         return null;
                }catch( Exception e )    
                {
                OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: getMappaPriceBook2Product2',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );            
                return null;
                } 
               
            }
            
            /**CRM Fine Modifica 18_04_2017**/ 
            
            public static void AggiornamentoDisattivazioneBE(List<Asset> listaAsset,Map<String,Order> idrisorsa)
            {
               try{
                        /**OS30 Modifica 06_04_2017 Gestione con o senza OM***/
                        List<OF_Configurazioni__c> listCustomSett = OF_Configurazioni__c.getAll().values();
                        DateTime dataswitch = listCustomSett[0].DataSwitchOM__c;
                        
                          Set<ID> idAsset = new Set<ID>();
                          List<PriceBookEntry> listPriceNonActive = new List<PriceBookEntry>();
                          list<Asset> AssetToUpdate = new list<Asset>();
                         
                          for( Asset ass : listaAsset )
                          {
                                  idAsset.add(ass.Id);
                                  ass.OF_OrdineId__c = idrisorsa.get(ass.EOF_ID_Risorsa__c).Id;
                                  AssetToUpdate.add(ass);
                          }
                          
                          system.debug('OS_AggiornamentoDisattivazioneBE idAsset '+idAsset);
                          List<PriceBookEntry> listPriceBookEntry = [SELECT Id,IsActive,OF_DataDiCessazione__c, OF_DataCessazione2__c 
                                                                     FROM PriceBookEntry WHERE OF_Asset__c IN : idAsset];
                          
                          if( listPriceBookEntry != null && listPriceBookEntry.size() > 0 )
                          {
                            for(PriceBookEntry prE : listPriceBookEntry)
                            {
                              prE.isActive = false;
                             //START Modifica CRM 06/04/2017 DG modifica data di cessazione pricebookentry per gestione senza OM
                              if(system.now() < dataswitch){
                                /*DG 28/04/2017 Commentato per nuova gestione date --> Process Builder: Data Attivazione Cessazione Asset e BillingElement
                                prE.OF_DataDiCessazione__c = system.today();
                                prE.OF_DataCessazione2__c = system.now();//idrisorsa.get(ass.EOF_ID_Risorsa__c).ClosedDate;
                                */
                              }
                              //END Modifica
                              listPriceNonActive.add(prE);
                            }
                          }
                          system.debug('OS_AggiornamentoDisattivazioneBE listPriceNonActive '+listPriceNonActive);
                          if( AssetToUpdate != null && AssetToUpdate.size() > 0 ) update AssetToUpdate;
                          if( listPriceNonActive != null && listPriceNonActive.size() > 0 ) update listPriceNonActive;
                          return;
            
                }catch( Exception e )
                {
                    OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: AggiornamentoDisattivazioneBE',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );           
                
                }
            
            }
                        
            public static void AggiornamentoAsset(List<Asset> AssetList,Map<String,Order> idrisorsa)
            {
              try{  
                       // system.debug('DG% - dentro AggiornamentoAsset');
                        //system.debug('DG% - AssetList: ' + AssetList);
                        list<Asset> AssetToUpdate = new list<Asset>();
                        List<PriceBookEntry> listPriceNonActive = new List<PriceBookEntry>();
            
                        for(Asset ass : AssetList )
                        {
                             //ass.OF_stato__c = 'Cessato';
                             ass.status = 'Cessato';
                             ass.OF_DataCessazione__c = Date.today();
                             ass.OF_OrdineId__c = idrisorsa.get(ass.EOF_ID_Risorsa__c).Id;              
                             AssetToUpdate.add(ass);
                        }
                                            
                        if( (AssetToUpdate.size() > 0) && (AssetToUpdate != null) ){
                            update AssetToUpdate;
                        }
                        
                        return;
               }catch( Exception e )
                {
                    OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: AggiornamentoAsset',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                
                }

            }
         
         /**Modifica 24_03_2017**/
         /**Questo metodo mi crea una Mappa tra Order,list<Listini> in modo da avere sotto
            l'Asset(legato al Case-Order) solo i Billing Element come da specifica.
            Se il campo SLA_PREMIUM_ASSURANCE = 'N' prendo Canone,altrimenti 'Canone Premium'**/
         
         public static Map<ID,Map<ID,PriceBook2> > getMappaOrder( Map<ID,ID> idOrderIdContract ,Map<ID,Order> orderID,Integer type)
         {
            try{
                     /**Mappa con chiave idOrder e values List<OF_Listini**/
                     Map<ID,Map<ID,PriceBook2>> OrderBillingElements = new Map<ID,Map<Id,PriceBook2>>();
                     
                     system.debug('OS_getMappaOrder()  orderId '+orderId);
                     system.debug('OS_getMappaOrder()  idOrderIdContract '+idOrderIdContract);
                     
                     /**CRM Modifica 28_03_2017 per evitare di chiamare sempre getContractListini(query dentro il for)**/
                     //funzione(param = idOrderIdContract )  ==> return set<ID> dei Listini
                     Map<Id,Set<Id>> ContractListini = new Map<Id,Set<Id>>();
                     /**CRM Modifica 18_04_2017 per evitare di chiamare sempre getMappaPriceBook2Product2(query dentro il for)**/
                     Map<Id,Set<Id>>  OrdiniListini = new Map<Id,Set<Id>>();
                     /****fine modifica**/
                     Set<ID> ids = new Set<ID>();
                     
                     if( idOrderIdContract.size() > 0 )
                     {
                         for( ID index : idOrderIdContract.values() )
                         {
                              ids.add(index);
                         }
                     }
                     system.debug('OS_DEBUG0 '+ids);
                     ContractListini = getContractListini(ids);
                     system.debug('OS_DEBUG2 '+ idOrderIdContract.keyset());
                     system.debug('OS_DEBUG3 ' + ContractListini );
                     
                             /**CRM Modifica 18_04_2017**/
                     if( ContractListini.size() > 0 )
                     {
                        if( idOrderIdContract != null && idOrderIdContract.size()>0 )
                        {
                            for( ID idOrder : idOrderIdContract.keyset())
                            {
                                ID idContrattoAssociatoOrdine = idOrderIdContract.get(idOrder);
                                if( idContrattoAssociatoOrdine != null )
                                {
                                OrdiniListini.put(idOrder,ContractListini.get(idContrattoAssociatoOrdine));
                                }
                            }
                        }
                     }
                     system.debug('CRM19 OrdiniListini');
                     for(ID idord : OrdiniListini.keyset())
                     {
                         system.debug('idord:'+idord);
                         system.debug('Set<Id>(dei Listini):'+OrdiniListini.get(idord));
                     }
                     
                     system.debug('CRM OrdiniListini : ' + OrdiniListini);
                     system.debug('CRM IDOrder : '+orderID);
                     
                     /**Creazione Mappa Order- Mappa(PriceBooKEntry-Product2)**/
                      OrderBillingElements = getMappaPriceBook2Product2(OrdiniListini,orderID,type);
                      
                      system.debug('CRM19 OrderBillingElements');
                      for(ID idord : OrderBillingElements.keyset() )
                      {
                         system.debug('idord:'+idord);
                         system.debug('Map<Id,PriceBook2>()):'+OrderBillingElements.get(idord));
                     
                      }
                     /**CRM Fine Modifica 18_04_2017**/
                     
                     /****
                     for( ID io : idOrderIdContract.keyset() )
                     {
                         Set<ID> P = new Set<ID>();
                         P = ContractListini.get(idOrderIdContract.get(io));
                         system.debug('OS_getMappaOrder() orderId.get(io) : '+orderId.get(io));
                         system.debug('OS_getMappaOrder() orderId.get(P) : '+P);
                         
                         
                         
                         Map<Id,PriceBook2> V = getMappaPriceBook2Product2(P,orderId.get(io),type);
                         
                         system.debug('OS_getMappaOrder()  V '+V);
                         OrderBillingElements.put(io,V);
                          
                      }*/
                     
                     system.debug('OS_getMappaOrder() orderId.get(io) : '+OrderBillingElements);
                     return OrderBillingElements;
                     
             }catch( Exception e )
             {
                    OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: AggiornamentoAsset',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );            
                return null;   
             }
 
          }
          public static Map<Id,set<id>> getContractListini(Set<ID> contratto)
          {
             try{
                     Map<id,Set<id>> IDContractListini = new Map<id,Set<id>>();
                    
                     List<OF_Listino__c> listOfListino = [ select id,OF_IDContract__c 
                                                           from OF_listino__c 
                                                           where OF_IDContract__c IN : contratto AND OF_Servizio__c = 'GPON Passiva'];
                     
                     if( listOfListino != null && listOfListino.size() > 0 )
                     { 
                        for( of_listino__c oc : listOfListino )
                        {
                          //ids.add(oc.id);
                          system.debug('OS_DEBUG0 '+oc);
                          if( IDContractListini.containsKey(oc.OF_IDContract__c) )
                          {
                              Set<Id> x = IDContractListini.get(oc.OF_IDContract__c);
                              x.add(oc.id);
                              IDContractListini.put(oc.OF_IDContract__c,x);
                          }else{
                              IDContractListini.put(oc.OF_IDContract__c,new Set<ID>{oc.Id});
                           }
                        }
                     }
                     //system.debug('OS_DEBUG1 : '+IDContractListini); 
                     if(IDContractListini.size() > 0 ) return IDContractListini;
                      return null;
                      
                 }catch( Exception e )
                 {
                    OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: getContractListini',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );           
                     return null;
                 }
            }
           
          public static void CreazionePriceBookEntry(Map<ID,Map<ID,PriceBook2>> mappa, Map<ID,ID> OrderAsset)
            {
               try{
                        /**OS30 Modifica 06_04_2017 Gestione con o senza OM***/
                         List<OF_Configurazioni__c> listCustomSett = OF_Configurazioni__c.getAll().values();
                         DateTime dataswitch = listCustomSett[0].DataSwitchOM__c;
                        
                           system.debug('OS-CreazionePriceBookEntry--\n');
                           system.debug('OS-Mappa: '+mappa);
                           system.debug('OS-Mappa.size(): '+ mappa.size());
                           system.debug('OS-OrderAsset: '+OrderAsset);
                           
                           List<PriceBookEntry> listaPriceBookEntry = new List<PriceBookEntry>();
                           
                           Set<ID> idPriceBook2Esistenti = new Set<ID>();
                           
                           if( mappa.size() > 0)
                           {
                                for( ID ix1 : mappa.keySet())
                                {
                                     for( ID ix2 : mappa.get(ix1).keyset() )
                                     {
                                     idPriceBook2Esistenti.add(mappa.get(ix1).get(ix2).Id);
                                     }
                                }
                           }
                                
                            Map<ID,PriceBook2> PriceBookEsistenti = new Map<ID,PriceBook2>([SELECT Id,IsActive,Name,OF_Listino__c 
                                                      FROM PriceBook2 
                                                      WHERE Id IN : idPriceBook2Esistenti]);
                      
                            system.debug('OS-PriceBookEsistenti: ' + PriceBookEsistenti);
                            
                            /**********************************Clonazione PriceBookEntry**********************************/
                            List<PriceBook2> listPriceBook2Clonate = new List<PriceBook2>();
                            Map<ID,Map<ID,PriceBook2>> orderPriceBookEntryClone = new Map<ID,Map<Id,PriceBook2>>();
                            /*********************************************************************************************/
                            
                            for( ID ix1: mappa.keyset() )
                            {
                                 Map<ID,PriceBook2> mapPriceProd= mappa.get(ix1);
                                 for(ID ix2 : mapPriceProd.keyset())
                                 {
                                      PriceBookEntry pbE = new PricebookEntry();
                                      Id y = mapPriceProd.get(ix2).Id;
                                      system.debug('CRM y : '+y);
                                      PriceBook2 obj = PriceBookEsistenti.get(y);
                                      
                                      system.debug('CRM3 : '+obj);
                                      system.debug('CRM3 PriceBookEsistenti'+PriceBookEsistenti);
                                      if( obj == null)
                                      {
                                             system.debug('orlando_obj = null');
                                             pbE.Pricebook2Id = y;
                                              pbE.IsActive=true;
                                             pbE.UnitPrice = 0;
                                              pbE.Product2Id=ix2;
                                              /**Start Modifica OS30 CRM 06/04/2017 per gestione data attivazione pricebookentry senza OM**/
                                              if( system.now()< dataswitch)
                                                  {
                                                     /* DG 28/04/2017 Commentato per nuova gestione date --> Process Builder: Data Attivazione Cessazione Asset e BillingElement
                                                     pbE.OF_DataAttivazione2__c = system.now(); //Campo di tipo DATE/TIME
                                                     */
                                                  }
                                              /**END modifica**/
                                              pbE.OF_Order__c = ix1;
                                              pbE.OF_Asset__c = OrderAsset.get(ix1);
                                              listaPriceBookEntry.add(pbE);
                                      }else{
                                         
                                         if( orderPriceBookEntryClone.containsKey(ix1)) 
                                          {
                                                    Map<Id,PriceBook2> PriceBookEntryClone = new Map<Id,PriceBook2>();
                                                    PriceBookEntryClone = orderPriceBookEntryClone.get(ix1);
                                                    PriceBookEntryClone.put(ix2,obj.clone());
                                                    orderPriceBookEntryClone.put(ix1,PriceBookEntryClone);
                                          }else{
                                                    Map<Id,PriceBook2> PriceBookEntryClone = new Map<Id,PriceBook2>();
                                                    PriceBookEntryClone.put(ix2,obj.clone());
                                                    orderPriceBookEntryClone.put(ix1,PriceBookEntryClone);
                                          }
                                     }
                                     
                                            
                                   }/**Chiusura primo for**/
                             }  
                               
                            system.debug('stepOrlando listaPriceBookEntryNonClonate '+listaPriceBookEntry);
                            if(listaPriceBookEntry.size()>0) insert listaPriceBookEntry;
                            
                            system.debug('stepOrlando orderPriceBookEntryClonate '+orderPriceBookEntryClone);
                            if( orderPriceBookEntryClone != null && orderPriceBookEntryClone.size() > 0 )
                            {
                                for( ID ix : orderPriceBookEntryClone.keyset() )
                                {
                                    listPriceBook2Clonate.addAll(orderPriceBookEntryClone.get(ix).values());
                                }
                            }
                            
                            if( listPriceBook2Clonate.size() > 0 ) insert listPriceBook2Clonate;
                            system.debug('stepOrlando listPriceBook2Clonate :'+listPriceBook2Clonate);
                            system.debug('stepOrlando orderPriceBookEntryClonate after insertClone :'+orderPriceBookEntryClone);
                            
                            /************************************************************************************/
                            /**Creazione PriceBookEntry/BillingElement Clonati che verranno associati all'Asset**/
                            /************************************************************************************/
                            List<PriceBookEntry> listPriceBookEntryClonate = new List<PriceBookEntry>();
                            //Integer i = 100;
                            if( orderPriceBookEntryClone.size() > 0 )
                            {
                                 for( ID ix1: orderPriceBookEntryClone.keyset() )
                                 {
                                      Map<ID,PriceBook2> mapPriceProd= orderPriceBookEntryClone.get(ix1);
                                      system.debug('stepOrlando1 id(Ordine):'+ix1+'--mapPriceProd : '+mapPriceProd);
                                      for(ID ix2 : mapPriceProd.keyset())
                                      {
                                             system.debug('stepOrlando1 ix2(PriceBook2)');
                                             PriceBookEntry pbE = new PricebookEntry();
                                             pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
                                             pbE.IsActive=true;
                                             pbE.UnitPrice = 0;
                                             pbE.Product2Id=ix2;
                                             /**Start Modifica OS30 CRM 06/04/2017 per gestione data attivazione pricebookentry senza OM**/
                                             if( system.now()< dataswitch)
                                             {
                                                /* DG 28/04/2017 Commentato per nuova gestione date --> Process Builder: Data Attivazione Cessazione Asset e BillingElement
                                                pbE.OF_DataAttivazione2__c = system.now(); //Campo di tipo DATE/TIME
                                                */
                                             }
                                             /**END modifica**/
                                             pbE.OF_Order__c = ix1;
                                             pbE.OF_Asset__c = OrderAsset.get(ix1);
                                             listPriceBookEntryClonate.add(pbE);
                                             //i++;
                                      }
                                 }  
                             }
                             system.debug('stepOrlando listPriceBookEntryClonate finalInsert : '+listPriceBookEntryClonate);
                             if( listPriceBookEntryClonate.size()>0) insert listPriceBookEntryClonate;
                             
                           
                         return;
               }catch( Exception e )
               {
               OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: CreazionePriceBookEntry',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                     return;

               }
            
            }   
          
    
    
    }
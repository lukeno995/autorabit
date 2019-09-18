public class OF_GestioneServiziPassiviNEW {
    
 Map<ID,Map<String,OF_CommercialElementIstanziato__c>> mappaAssetComm = new Map<ID,Map<String,OF_CommercialElementIstanziato__c>>();
 Map<ID,Map<String,OF_CommercialElementIstanziato__c>> mappaAssetCommCess = new Map<ID,Map<String,OF_CommercialElementIstanziato__c>>();
    
    
/**Modifica 24_03_2017**/
         /**Questo metodo mi crea una Mappa tra Order,list<Listini> in modo da avere sotto
            l'Asset(legato al Case-Order) solo i Billing Element come da specifica.
            Se il campo SLA_PREMIUM_ASSURANCE = 'N' prendo Canone,altrimenti 'Canone Premium'**/
 public Map<ID,Map<ID,PriceBook2> > getMappaOrder( Map<ID,ID> idOrderIdContract ,Map<ID,Order> orderID,Map<ID,ID> AssetOrder,Map<ID,Asset> MapAsset,Integer type)
 {
     try{
            /**Mappa con chiave idOrder e values List<OF_Listini**/
             Map<ID,Map<ID,PriceBook2>> OrderBillingElements = new Map<ID,Map<Id,PriceBook2>>();
             
             system.debug('OS_getMappaOrder()  orderId '+orderId);
             system.debug('OS_getMappaOrder()  idOrderIdContract '+idOrderIdContract);
             
             /**CRM Modifica 28_03_2017 per evitare di chiamare sempre getContractListini(query dentro il for)**/
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
             ContractListini = getContractListini(ids,'GPON Passiva');
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
             system.debug('OSCRM OrdiniListini:'+OrdiniListini);
             /**Chiamo un metodo ad hoc per filtrare ulteriormente i listini,
                in base alle informazioni che mi trovo sull'ordine(Tipologia Apparato,Progetto Speciale).
                Questi due campi mi arrivano dal Case all'Ordine in fase di creazione dell'ordine**/
                
              Map<ID,Set<ID>> OrdiniListiniFilter2 = new Map<ID,Set<ID>>();
         
              OF_UtilitiesServiziAttivi obj = new OF_UtilitiesServiziAttivi();
              /********ATTIVAZIONE********/
              if( type == 0 )
              {
              system.debug('DG_OF_UtilitiesCreazioneAsset - dentro type = 0');
              //obj.getCEListini(OrdiniListini,orderID,'GPON Passiva');
              
              OrdiniListiniFilter2 = filtroListini(OrdiniListini,orderID);
              OrderBillingElements = getMappaPriceBook2Product2(OrdiniListiniFilter2,orderID,AssetOrder,MapAsset,type);
              
              /*********CESSAZIONE*********/
              }else if( type == 1 )
              {
              system.debug('DG_OF_UtilitiesCreazioneAsset - dentro type = 1');
              OrderBillingElements = getMappaPriceBook2Product2(OrdiniListini,orderID,AssetOrder,MapAsset,type);
              }
                      
              system.debug('OSCRM OrderBillingElements'+OrderBillingElements);
              return OrderBillingElements;
                
                /**************** FINE SERVIZI PASSIVI **********************/
                system.debug('DG_OF_UtilitiesCreazioneAsset - return null');
                return null;
                     
             }catch( Exception e )
             {
                    OF_Utility.logMessage(true,'E','Classe: OF_GestioneServiziPassiviNEW','getMappaOrder',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );            
                return null;   
             }
 
  }
  
   public static Map<Id,set<id>> getContractListini(Set<ID> contratto , String Servizio)
          {
             try{
                     Map<id,Set<id>> IDContractListini = new Map<id,Set<id>>();
                    
                     List<OF_Listino__c> listOfListino = [ select id,OF_IDContract__c 
                                                           from OF_listino__c 
                                                           where OF_IDContract__c IN : contratto AND OF_Servizio__c =: Servizio ];
                     
                     if( listOfListino != null && listOfListino.size() > 0 )
                     { 
                        for( of_listino__c oc : listOfListino )
                        {
                          //ids.add(oc.id);
                          //system.debug('OS_DEBUG0 '+oc);
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
                    OF_Utility.logMessage(true,'E','OF_GestioneServiziPassiviNEW','getContractListini',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );           
                     return null;
                 }
            }
            
 /****************************/
 /**Metodo filtro Listini(Progetto Speciale,Tipologia Apparato)**/
    public Map<Id,Set<ID>>filtroListini( Map<ID,Set<ID>> OrdiniListini , Map<ID,Order> orderID)
    {
        Map<ID,Set<ID>> OrdiniListiniFiltro2 = new Map<ID,Set<ID>>();
        set<id> TotalListini = new set<id>();
        
        for( ID idOrder : OrdiniListini.keyset())
        {
             TotalListini.addAll( OrdiniListini.get(idOrder));
        }
        //system.debug('OSCRM filtroListini TotalListini: '+ TotalListini);
            
        Map<ID,OF_Listino__c> mappaListini = new Map<ID,OF_Listino__c>([select id,OF_IDContract__c,OF_TipologiaApparato__c,OF_ProgettoSpeciale__c,
                                                                        OF_ServizioBillingElement__c,OF_ServizioBillingElement__r.Name,
                                                                        OF_Attivo__c, OF_ListinoDefault__c
                                                                        from OF_listino__c 
                                                                        where  Id IN : TotalListini AND OF_Servizio__c = 'GPON Passiva']);
        /**Chiamo metodo ad hoc per avere Ordini - ListaCatalogoProdottiOLO**/
        
        
        
        Map<Id,set<String>> listaOrdinieCatalogoProdOLO = getOrderCatalogoProdottiOLO(orderID);
        //system.debug('OSCRM listaOrdinieCatalogoProdOLO : '+listaOrdinieCatalogoProdOLO);
        /*****/ 
        //system.debug( 'OSCRM filtroListini mappaListini: '+ mappaListini );
        
        for( ID ix : OrdiniListini.keyset())
        {
         
            Order o = orderID.get(ix);
            Set<ID> listini = OrdiniListini.get(ix);
            
            set<String> listaStrCatProdOLO = listaOrdinieCatalogoProdOLO.get( ix );
            system.debug('OSCRM listaStrCatProdOLO : '+listaStrCatProdOLO );
            system.debug('OSCRM o.OF_TipologiaApparato__c : '+o.OF_TipologiaApparato__c );
            
            //16/06/2017 aggiunto controllo su o.OF_TipologiaApparato__c
            boolean checkProdottoApparato;
            
            if(o.OF_TipologiaApparato__c != null)
            {
                checkProdottoApparato = listaStrCatProdOLO.contains(o.OF_TipologiaApparato__c.toUpperCase());
            }
            //END 16/06/2017
            
            /**Ordine corrente a tutti i OF_ServizioBillingElement__c che sono nel Listini 
               sotto quell'Ordine**/
            Map<Id,Set<ID>> OrderBE = new Map<Id,Set<ID>>();
            
            Map<ID,List<OF_Listino__c>> BEListListini = new Map<ID,List<OF_Listino__c>>();
            
            Set<ID> ServizioBE = new Set<ID>();
            
            
            for( ID idlistini : listini )
            {
                 ID idBE = mappaListini.get( idListini ).OF_ServizioBillingElement__c;
                 OF_Listino__c listino = mappaListini.get( idListini );
                 
                 ServizioBE.add ( idBE );
                 
                 if( BEListListini.containsKey( idBE ))
                 {
                     List<OF_Listino__c> listini1 = BEListListini.get( idBE );
                     listini1.add( listino );
                     BEListListini.put( idBE , listini1 );
                     
                 }else{
                     List<OF_Listino__c> listini1 = new List<OF_Listino__c>();
                     listini1.add( listino );
                     BEListListini.put( idBE , listini1 );
                 }
                                 
            }
            
            OrderBE.put( ix , ServizioBE );
            /*****************************************************************************/
            
            system.debug('OSCRM OrderBE : '+OrderBE);
            system.debug('OSCRM BEListListini: '+BEListListini);
            
            /******************************************************************************/
            Set<ID> setBE = OrderBE.get( ix );
            
            Set<ID> setListiniFiltrati = new Set<ID>();
             
            for( ID iy : setBE )
            {
                    Integer count = 0;
                    List<OF_Listino__c> iyListListini = BEListListini.get(iy);
                    OF_Listino__c listinoDiDefault;
                    
                    for( OF_Listino__c listino : iyListListini )
                    {
                            //count++;
                            
                            if( checkProdottoApparato == true )
                            {      
                                    //system.debug('OSCRM OF_SA_OLO_EntryChecks');
                                   
                                    if( o.OF_TipologiaApparato__c == listino.OF_TipologiaApparato__c  &&
                                        o.OF_ProgettoSpeciale__c  == listino.OF_ProgettoSpeciale__c && 
                                        listino.OF_Attivo__c == true  )
                                        {
                                           setListiniFiltrati.add( listino.Id );
                                           break;
                                        }else{
                                            count++;
                                        }
                                        
                                    if( listino.OF_ListinoDefault__c == true) listinoDiDefault=listino;
                                   
                            }else{
                                 count++;
                                 if( listino.OF_ListinoDefault__c == true) listinoDiDefault=listino;
                                
                            }
                       
                      }
                    
                   /**In questo caso,ho ciclato per tutti i Listini che contengono quel BE( Esempio : Contributo Attivazione)
                      ma non ho trovato nessuno che avesse la stessa tipologiaApparato e ProgettoSpeciale uguale all'Ordine diAttivazione**/
                     //system.debug('OSCRM count: '+count);
                     //system.debug('OSCRM lista.size(): '+ iyListListini );
                     if( count == iyListListini.size())
                     {
                              /**Controllo per evitare la mancanza in fase di Configurazione 
                                 del listino di default**/
                              if( listinoDiDefault != null)setListiniFiltrati.add( listinoDiDefault.Id);
                     }
             }
             if( setListiniFiltrati.size()>0){
                 system.debug('OSCRM setListiniFiltrati: '+setListiniFiltrati);
                 OrdiniListiniFiltro2.put( ix , setListiniFiltrati );
             }
        }
        
         system.debug('OSCRM OrdiniListiniFiltro2 : '+OrdiniListiniFiltro2);
                    
        return OrdiniListiniFiltro2;
    }
    /***************************/
    /**CRM Modifica 18_04_2017**/
    public Map<Id,Map<Id,PriceBook2>> getMappaPriceBook2Product2(Map<Id,Set<ID>> OrderSetidListini,Map<ID,Order> orderID,Map<ID,ID> AssetOrder,Map<ID,Asset> mappaAsset,Integer type)
            {

              try{
                      //system.debug('DG ord: ' + ord);
                       Map<Id,Map<Id,PriceBook2>> listaPriceProduct = new Map<Id,Map<Id,PriceBook2>>();
                       /**Mappa che tiene traccia dei IdListino - IdPriceBook2**/
                       Map<Id,Id> listiniProduct2 = new Map<Id,Id>();
                       
                      /**Nota:17-03-2017 - ad oggi l'unico servizio che si può richiedere è la GPON Passiva.*/
                       
                       //DG Logica istanziazione Billing Element
                       Map<Id,Set<string>> OrderBE = new Map<Id,Set<string>>();
                       Set<ID> totalListini = new Set<ID>();
                       Map<ID,Set<String>> OrderCE = new Map<ID,Set<String>>();
                       
                       /**Il metodo chiamato getIdOrderBECE fa l'associazione tra idOrdine e un set di stringhe
                          che contengono i nomi dei CE e BE da istanziare.
                          Può essere considerato come un metodo Helper**/
                        
                       system.debug('OSCRM getMappaPriceBook2Product2 : ' + OrderSetidListini );
                       getIdOrderBECE( totalListini , OrderSetidListini , OrderID , OrderBE , OrderCE , type );
                       system.debug('OSCRM OrderBE:'+OrderBE);
                       system.debug('OSCRM OrderCE:'+OrderCE);
                       
                         /**CREAZIONE CE**/
                         system.debug('OSCRM mappaAsset:'+mappaAsset);
                         if( type == 0)
                         {
                         CreazioneCE_Attivazione(AssetOrder,OrderCE,mappaAsset,type);
                         system.debug('OSCRM mappaAsset:'+mappaAsset+' type:'+type);
                         }else if( type == 1 )
                         {
                         system.debug('OSCRM mappaAsset:'+mappaAsset+' type:'+type);
                         associazioneBEDissativazione_CEIst(mappaAsset);
                         }
                        /***/
                         system.debug('CRM OS : Order-List<String>():'+OrderCE);
                         
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
                         
                         List<PriceBook2> listPriceBook2 = [SELECT Id,name,IsActive,OF_Listino__c,OF_Listino__r.OF_IDContract__c,OF_Listino__r.OF_CommercialElement__c,Commercial_element__c
                                                          FROM PriceBook2 WHERE OF_Master__c=true AND OF_Listino__c in : listiniProduct2.keySet()];
                         system.debug('CRM_listPriceBook2: '+listPriceBook2);
                         
                         if( listPriceBook2 != null && listPriceBook2.size() > 0 )
                         {
                             for( PriceBook2 priceb2 : listPriceBook2)
                             {
                                  Map<Id,PriceBook2> mpx = new Map<Id,PriceBook2>();
                                  mpx.put(listiniProduct2.get(priceb2.OF_Listino__c),priceb2);
                                  listaPriceProduct.put(priceb2.OF_Listino__c,mpx);
                             }
                         }
                         /**Creazione Mappa Order - Map<IdProduct,PriceBook>**/
                         system.debug('CRM listaPriceProduct : '+listaPriceProduct);
                         Map<Id,Map<Id,PriceBook2>> OrdinePriceProduct = new Map<Id,Map<Id,PriceBook2>>();
                         for( ID idord :  OrderSetidListini.keyset() )
                         {
                              system.debug('OSCRM for1');
                              for( ID idlistino : OrderSetidListini.get(idord))
                              {
                                   system.debug('OSCRM for2');
                                   if( OrdinePriceProduct.containsKey(idord))
                                   {
                                      Map<Id,PriceBook2> ProdPriceBook2 = OrdinePriceProduct.get(idord);
                                      system.debug('CRM_ProdPriceBook2 : '+ProdPriceBook2);
                                      
                                      ProdPriceBook2.putAll(listaPriceProduct.get(idlistino)); //ProdPriceBook2.put(listaPriceProduct.get(idlistino).keyset() ,listaPriceProduct.get(idlistino));
                                      OrdinePriceProduct.put(idord,ProdPriceBook2);
                                      system.debug('CRM_OrdinePriceProduct(contains): '+OrdinePriceProduct);
                                    }else{
                                            
                                         Map<Id,PriceBook2> ProdPriceBook2 = new Map<Id,PriceBook2>();
                                         
                                         system.debug('OSCRM listaPriceProduct : '+listaPriceProduct);
                                         system.debug('OSCRM listaPriceProduct.get(idlistino):'+listaPriceProduct.get(idlistino));
                                         
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
                                system.debug('CRM_20_04 OrderBE :'+OrderBE);
                                
                                Set<String> ProductToCompare = OrderBE.get(idord);
                                
                                system.debug('CRM_20_04 ProductToCompare :'+ProductToCompare);
                                
                                for( ID idProd : mapExist.keySet())
                                {
                                      String NomeProduct = listaProduct2.get(idProd).Name.ToUpperCase();
                                      system.debug('CRM_20_04 idProd : '+idProd+' -----NomeProduct: '+NomeProduct);
                                      system.debug('CRM_20_04 pointToFix : '+ProductToCompare.Contains(NomeProduct));
                                      if( ProductToCompare.Contains(NomeProduct) )
                                      {
                                          mapToInsert.put(idProd,mapExist.get(idProd));
                                      }
                                      system.debug('CRM_20_04 mapToInsert'+mapToInsert);
                                }
                              if( mapToInsert.size() > 0 ) OrdinePriceProductFilter.put(idord,mapToInsert);   
                         
                         }
                          system.debug('CRM_20_04 OrdinePriceProductFilter'+OrdinePriceProductFilter);
                          if( OrdinePriceProductFilter.size() > 0 ) return OrdinePriceProductFilter;
                          
                          return null;
                }catch( Exception e )    
                {
                OF_Utility.logMessage(true,'E','OF_GestioneServiziPassiviNEW','getMappaPriceBook2Product2',
                      'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                   );            
                return null;
                } 
               
            }
/****************************/

/**Questo metodo ritorna una Mappa tra IDOrder-CatalogoProdotti che si trovanno
       sotto gli AccountOLO che sono legati con gli Ordini**/
    
 public void getIdOrderBECE(Set<ID> totListini , Map<Id,Set<ID>> OrderSetidListini,Map<ID,Order> orderID,
                               Map<Id,Set<string>> mapBE , Map<Id,Set<string>> mapCE , Integer tipo)
 {
    try{
           system.debug( 'oscrm geIdOrderBECE :'+OrderSetidListini );
           for( ID idOrdine : OrderSetIdListini.keyset())
           {
                  totListini.addAll(OrderSetIdListini.get(idOrdine));
                  Order ord = orderID.get(idOrdine);
                  if( ord != null )
                   {
                          /**Attivazione**/
                      if( tipo  == 0 )
                      {
                            List<String> lsBE = new List<String>();
                            Set<String> lsSetBE = new Set<String>();
                            
                            List<String> lsCE = new List<String>();
                            Set<String> lsSetCE = new Set<String>();
                            system.debug( '####### esito :'+ord.OF_EsitoConsegnaApparato__c+' ####### slaPremium: '+ ord.OF_SlaPremiumAssurance__c);
                            lsBE = OF_GestioneServizi.AttivazioneBECE(ord.OF_EsitoConsegnaApparato__c,ord.OF_SlaPremiumAssurance__c).get('BE');
                            lsCE = OF_GestioneServizi.AttivazioneBECE(ord.OF_EsitoConsegnaApparato__c,ord.OF_SlaPremiumAssurance__c).get('CE');
                            
                            lsSetBE.addAll(lsBE);
                            lsSetCE.addAll(lsCE);
                            
                            mapBE.put(idOrdine,lsSetBE);
                            mapCE.put(idOrdine,lsSetCE);
                        
                       /**Cessazione**/   
                       }else if( tipo == 1 ){
                        
                            List<String> lc = new List<String>();
                            Set<String> lsSet = new Set<String>();
                           
                            lc = OF_GestioneServizi.CessazioneBECE(ord.OF_Apparato__c).get('BE');
                            lsSet.addAll(lc);
                            mapBE.put(idOrdine,lsSet);
                        }
                                
                }
              }
                return;
           }catch( Exception e )
           {
               OF_Utility.logMessage(true,'E','OF_GestioneServiziPassiviNEW','getIdOrderBECE',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                     return;
           }
      //return;
    }
    
    /***************************************/
    /**Questo metodo ritorna una Mappa tra IDOrder-CatalogoProdotti che si trovanno
       sotto gli AccountOLO che sono legati con gli Ordini**/
       public Map<ID,set<String>> getOrderCatalogoProdottiOLO(Map<ID,Order> orderID)
       {
           try{
         
                  Map<ID,set<String>> ordiniCatalogoProdottiOLO = new Map<ID,Set<String>>();
                  
                  Map<ID,Account> mappaOLO = new Map<ID,Account>([SELECT Id,Name,(SELECT Id,Name,OF_TipologiaApparato__c FROM CataloghiProdottiOlo__r)
                                            FROM Account WHERE Recordtype.Name = 'OLO']);
        
                  for( ID ido : orderID.keyset())
                  {
                    //OF_CatalogoApparati__c
                      List<OF_CatalogoApparati__c> listaCatalogoProdotti = new List<OF_CatalogoApparati__c>();
                      
                      //metto l'if in caso abbiamo legato all'ordine l'account temporaneo
                      if(mappaOLO.containsKey(orderID.get(ido).AccountId)){
                      	listaCatalogoProdotti = mappaOLO.get( orderID.get(ido).AccountId ).CataloghiProdottiOlo__r;
                      }
                      else{
                      	listaCatalogoProdotti = mappaOLO.get( orderID.get(ido).OF_AccountTemporaneo__c ).CataloghiProdottiOlo__r;
                      }

                      set<String> CatalogoProdottiList = new set<String>();
                      
                      for( OF_CatalogoApparati__c cat : listaCatalogoProdotti)
                      {
                        
                        CatalogoProdottiList.add( cat.OF_TipologiaApparato__c.toUpperCase());
                      }
                      
                     ordiniCatalogoProdottiOLO.put( ido, CatalogoProdottiList );
                  }
                  system.debug('OSCRM getOrderCatalogoProdottiOLO ordiniCatalogoProdottiOLO:'+ordiniCatalogoProdottiOLO);    
                 
                  return ordiniCatalogoProdottiOLO;
           }catch(Exception e )
               {
                  OF_Utility.logMessage(true,'E',
                     'OF_GestioneServiziPassiviNEW',
                     'getOrderCatalogoProdottiOLO',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                return null;
               }
     }
    
/****************************************/

//19/07/2017 DG modifica recordtype, per i passivi è stato creato un nuovo recordtype 'CPE Passivi'
//Popolamento dei record type del Commercial Element Istanziato
public static id RecordTypeCE(string name){
	
	String CPERecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE Passivi').getRecordTypeId();
	String VLANRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
	String ServiziAggiuntiviRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
	String StandardRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Standard').getRecordTypeId();
	
	//CRM Modifica 03_07_2017
	String InterventoVuoto = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Intervento a vuoto').getRecordTypeId();
	String Verticale = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
	
	
	system.debug('DG_OF_AttivazManualeCEController name: ' + name);
	
	if(name == 'CPE'){return CPERecordTypeId;
	}else if(name == 'VLAN'){return VLANRecordTypeId;
	}else if((name == 'Servizi Aggiuntivi') || (name == 'RIBALTAMENTO IMPIANTO') || (name == 'ESTENSIONE IMPIANTO CLIENTE') || (name == 'SLA PREMIUM ASSURANCE')){return ServiziAggiuntiviRecordTypeId;
	}else if( name == 'Intervento a vuoto'){return InterventoVuoto;
    }else if( name == 'Verticale'){return Verticale;
    }else{
		return StandardRecordTypeId;
	}
}

public  void CreazioneCE_Attivazione(Map<ID,ID> OrderAsset , Map<ID,Set<String>> idOrder , Map<Id,Asset> mappaAsset, Integer tipo)
     {
        try{
               List<OF_CommercialElement__c> listaCommercialElement =[ SELECT Id,Name 
                                                                       FROM OF_CommercialElement__c ];
                                                                       
                                                                       
               //system.debug('OSCRM listaCommercialElement : '+listaCommercialElement );                                                         
               Map<String,Id> elencoNome = new Map<String,Id>(); 
                                                                       
               for( OF_CommercialElement__c ce : listaCommercialElement ){
               		elencoNome.put(ce.Name,ce.Id);
               }
               
               //system.debug('OSCRM elencoNome : '+elencoNome );
               
               List<OF_CommercialElementIstanziato__c> listaCommercialElementIstanz = new List<OF_CommercialElementIstanziato__c>();
               
               
               
               Map<ID,Set<String>> AssetSetCE = new Map<ID,Set<String>>();
               
               for( ID ix : idOrder.keyset() )
               {
                    AssetSetCE.put( OrderAsset.get( ix ) , idOrder.get(ix) );
               }
               
               
               //system.debug('OSCRM AssetSetCE : '+AssetSetCE ); 
               for( ID idAsset : AssetSetCE.keyset() )
               {
                     Set<String> setStr = AssetSetCE.get(idAsset);
                      for( String str : setStr  )
                      {
                          OF_CommercialElementIstanziato__c ceIst = new OF_CommercialElementIstanziato__c();
                          //ceIst.Name = str;
                          system.debug('OSCRM NomeCommercial: '+ str);
                          //19/07/2017 DG Modifica recordtype
                          //ID RecordType = OF_AttivazManualeCEController.RecordTypeCE(str);
                          ID RecordType = RecordTypeCE(str);
                          //system.debug('OSCRM RecordType : '+RecordType );
                          ceIst.OF_CommercialElement__c = elencoNome.get( str );
                          ceIst.OF_Asset__c = idAsset;
                          ceIst.RecordTypeId = RecordType;
                          Asset a = mappaAsset.get( idAsset );
                          system.debug('OSCRM Asset a :'+a);
                          ceIst.OF_IDRisorsa__c = a.EOF_ID_Risorsa__c;
                          ceIst.OF_IDOrdine__c = a.OF_OrdineID__c;
                          ceIst.OF_Stato__c = a.Status;
                          ceIst.OF_Case__c = a.OF_IDCaseAttivazione__c;
							if(ceIst.RecordTypeId==OM_GW_GE_Utils.rtMap.get('OF_CPE')) {
								ceIst.OF_CPE__c=ceIst.OF_Asset__c;
							}
							else if(ceIst.RecordTypeId==OM_GW_GE_Utils.rtMap.get('CPE_Passivi')){
								ceIst.OF_CPEPassivi__c=ceIst.OF_Asset__c;
								ceist.OF_SA_CPE__c=ceIst.OF_Case__c;
							}
							else if(ceIst.RecordTypeId==OM_GW_GE_Utils.rtMap.get('OF_VLAN')) {
								ceIst.OF_VLAN__c=ceIst.OF_Asset__c;
							}	
							else if(ceIst.RecordTypeId==OM_GW_GE_Utils.rtMap.get('OF_ServiziAggiuntivi')) {
								ceIst.OF_ServiziAggiuntivi__c=ceIst.OF_Asset__c;
							}
							else if(ceIst.RecordTypeId==OM_GW_GE_Utils.rtMap.get('OF_Standard')) {
								ceIst.OF_CEStandard__c=ceIst.OF_Asset__c;
							}
                          //CRM MODIFICA 07_11_2017
                          if( OM_GW_GE_Utils.slSFOLO.EOF_Tipo_comunicazione__c == '7' )
                          {
                              ceIst.OF_DataAttivazione__c = OM_GW_GE_Utils.slSFOLO.EOF_Data_espletamento_ordine__c;
                          }
                          //FINE
                          
                          
                          
                          /**MappaAssetComm serve per tenere traccia tra Asset - ListaCommercialIstanziati,
                             Questa mappaserve in fase di CreazionePriceBookEntry per associare ogni
                             PriceBookEntry,all corrispettivo CEIstanziato**/
                             
                          if( mappaAssetComm.containsKey( idAsset ))
                          {
                            Map<String,OF_CommercialElementIstanziato__c> x = mappaAssetComm.get(idAsset);
                            x.put( str,ceIst );
                            mappaAssetComm.put( idAsset, x );
                          }else{
                            Map<String,OF_CommercialElementIstanziato__c> y = new Map<String,OF_CommercialElementIstanziato__c>();
                            y.put( str,ceIst);
                            mappaAssetComm.put( idAsset , y );
                          }
                          system.debug('OSCRM mappaAssetCE before INSERT: '+mappaAssetComm);            
                          listaCommercialElementIstanz.add(ceIst);
                          system.debug('OSCRM listaCommercialElementIstanz: '+listaCommercialElementIstanz); 
                      }
                 }
                 if( listaCommercialElementIstanz.size()>0)insert listaCommercialElementIstanz;
                 // system.debug('OSCRM mappaAssetCE after INSERT: '+mappaAssetComm);   
               
            }catch( Exception e )
               {
               OF_Utility.logMessage(true,'E',
                     'OF_GestioneServiziPassiviNEW',
                     'CreazioneCE_Attivazione',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                     return;

               }
        }
        
/******************/
 public  void associazioneBEDissativazione_CEIst( Map<Id,Asset> mappaAsset)
    {
        /**Associazione CEIst con le PriceBookEntry sotto la CEIsta**/
        
       try{
            List<Asset> listaAssetCommercialIstanziati = [Select id,(select id,OF_CommercialElementName__c from Commercial_element_istanziati__r )
                                                            from Asset
                                                            where id In : mappaAsset.keyset() ];
                                                            
            for( Asset idAsset : listaAssetCommercialIstanziati )
            {
                 List<OF_CommercialElementIstanziato__c> listCist = idAsset.Commercial_element_istanziati__r;
                 
                 Map<String,OF_CommercialElementIstanziato__c> mappaCist = new Map<String,OF_CommercialElementIstanziato__c>();
                 
                 for( OF_CommercialElementIstanziato__c obj : listCist)mappaCist.put( obj.OF_CommercialElementName__c , obj );
                 
                
                //if( listCist != null && listCist.size()>0 )
                mappaAssetCommCess.put( idAsset.Id , mappaCist );
            }
          system.debug('OSCRM associazioneBEDissativazione_CEIst : '+ listaAssetCommercialIstanziati );
          
          
          }catch(Exception e)
            {
                 OF_Utility.logMessage(true,'E',
                     'OF_GestioneServiziPassiviNEW',
                     'associazioneBEDissativazione_CEIst',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                     return;
            }
         
        
    }
    
    public void CreazionePriceBookEntry(Map<ID,Map<ID,PriceBook2>> mappa, Map<ID,ID> OrderAsset,Integer tipo)
            {
               try{
               List<PriceBook2> listPriceBook2Clonate = new List<PriceBook2>();
               Map<ID,Map<ID,PriceBook2>> orderPriceBookEntryClone = new Map<ID,Map<Id,PriceBook2>>();
                        
               for( ID ix1: mappa.keyset() )
                {
                    Map<ID,PriceBook2> mapPriceProd= mappa.get(ix1);
                    for(ID ix2 : mapPriceProd.keyset())
                    {
                        if( orderPriceBookEntryClone.containsKey(ix1)) 
                          {
                                    Map<Id,PriceBook2> PriceBookEntryClone = new Map<Id,PriceBook2>();
                                    PriceBookEntryClone = orderPriceBookEntryClone.get(ix1);
                                    PriceBookEntryClone.put(ix2,mapPriceProd.get(ix2).clone());
                                    orderPriceBookEntryClone.put(ix1,PriceBookEntryClone);
                          }else{
                                    Map<Id,PriceBook2> PriceBookEntryClone = new Map<Id,PriceBook2>();
                                    PriceBookEntryClone.put(ix2,mapPriceProd.get(ix2).clone());
                                    orderPriceBookEntryClone.put(ix1,PriceBookEntryClone);
                          }
                     }
                    
                }
                system.debug('DG_16 orderPriceBookEntryClonate '+orderPriceBookEntryClone);
                if( orderPriceBookEntryClone != null && orderPriceBookEntryClone.size() > 0 )
                {
                    for( ID ix : orderPriceBookEntryClone.keyset() )
                    {
                        listPriceBook2Clonate.addAll(orderPriceBookEntryClone.get(ix).values());
                    }
                }
                system.debug('DG_16 listPriceBook2Clonate: '+listPriceBook2Clonate);
                
                if( listPriceBook2Clonate.size()>0) insert listPriceBook2Clonate;
                             
               
                List<PriceBookEntry> listPriceBookEntry = new List<PriceBookEntry>();
                for( ID ix1: orderPriceBookEntryClone.keyset() )
                {
                    Map<ID,PriceBook2> mapPriceProd= orderPriceBookEntryClone.get(ix1);
                    for(ID ix2 : mapPriceProd.keyset())
                    {
                        PriceBookEntry pbE = new PricebookEntry();
                        system.debug('OSCRM PriceBook2Completa:'+mapPriceProd.get(ix2));
                 
                        pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
                        pbE.IsActive=true;
                        pbE.UnitPrice = -9999;
                        pbE.Product2Id=ix2;
                        pbE.OF_Order__c = ix1;
                        pbE.OF_Asset__c = OrderAsset.get(ix1);
                        system.debug('OSCRM mappaAssetComm(): '+mappaAssetComm);
                        // system.debug('OSCRM OrderAsset.get(ix1):'+OrderAsset.get(ix1));
                        //system.debug('mappaAssetComm.containsKey( OrderAsset.get(ix1))'+mappaAssetComm.containsKey( OrderAsset.get(ix1)));
                        /**Modifica 23_05_2017**/

                        /**Attivazione**/ 
                        if( tipo == 0)
                        {
                            if( mappaAssetComm.containsKey( OrderAsset.get(ix1)))
                            {               
                            Map<String,OF_CommercialElementIstanziato__c> listaCEIst = mappaAssetComm.get( OrderAsset.get(ix1));
                            String sy =  mapPriceProd.get(ix2).Commercial_Element__c;
                            // system.debug('OSCRM sy:'+sy);
                            pbE.OF_CommercialElementIstanziato__c = listaCEIst.get(sy).Id;
                            }
                            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ data attivazione BE attivazione: '+OM_GW_GE_Utils.slSFOLOResp);
                            pbE.OF_DataAttivazione2__c = OM_GW_GE_Utils.slSFOLOResp.lastModifiedDate;  
                             //FINE
                        }else if( tipo == 1 )
                        {
                            system.debug( 'OSCRM CreazionePriceBookEntry mappaAssetCommCess():'+mappaAssetCommCess);
                            if( mappaAssetCommCess.containsKey( OrderAsset.get(ix1)))
                            {
                            // system.debug('OSCRM CreazionePriceBookEntry OrderAsset.get(ix1):'+OrderAsset.get(ix1));
                            Map<String,OF_CommercialElementIstanziato__c> listaCEIst = mappaAssetCommCess.get( OrderAsset.get(ix1));
                            String sy =  mapPriceProd.get(ix2).Commercial_Element__c;
                            // system.debug('OSCRM sy:'+sy);
                            // system.debug('OSCRM listaCEIst'+listaCEIst);
                            //system.debug('OSCRM listaCEIst.get(sy):'+listaCEIst.get(sy));
                            //system.debug('OSCRM listaCEIst.get(sy).Id:'+listaCEIst.get(sy).Id);
                            pbE.OF_CommercialElementIstanziato__c = listaCEIst.get(sy).Id;
                            } 
                            
                            //CRM MODIFICA 07_11_2017
                            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ data attivazione BE cesazione: '+OM_GW_GE_Utils.slOrig);
                            pbE.OF_DataAttivazione2__c = OM_GW_GE_Utils.slOrig.EOF_Data_Notifica__c;
                        }
                        /**Fine Modifica 23_05_2017**/

                        listPriceBookEntry.add(pbE);
                    }
                }
                if(listPriceBookEntry.size() > 0 && listPriceBookEntry != null){
                	boolean inserito=false;
		            boolean templog=false;
		            Templog__c t = new Templog__c();	
		            for(integer x=0; x<50; x++){
			            try{
		                    insert listPriceBookEntry;
		                    inserito=true; 
	            		}
	            		catch(exception e){
	            			if(!templog){
			            		t=OF_Utility.logMessageNew2(listPriceBookEntry[0].Pricebook2Id,'E','OF_GestioneServiziPassiviNEW','CreazionePriceBookEntry',(x+1), e);
			            		templog=true;
			            	}
			            	else{
			            		t.OF_tentativi__c=(x+1);
			            	}
			            }
			            if(inserito==true){
			            	break;
			            }
		            }
	            	if(templog){
			        	insert t;
			        }
                }
            }catch( Exception e )
               {
               OF_Utility.logMessage(true,'E',
                     'OF_GestioneServiziPassiviNEW',
                     'CreazionePriceBookEntry',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                     return;

               }
            }         


}
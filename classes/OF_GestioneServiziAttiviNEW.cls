public class OF_GestioneServiziAttiviNEW {
    
 Map<ID,Map<String,OF_CommercialElementIstanziato__c>> mappaAssetComm = new Map<ID,Map<String,OF_CommercialElementIstanziato__c>>();
 Map<ID,Map<String,OF_CommercialElementIstanziato__c>> mappaAssetCommCess = new Map<ID,Map<String,OF_CommercialElementIstanziato__c>>();
 public  Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> MappaMultipleCE  = new Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>>();
 Map<ID,OF_Listino__c> mappaListini = new Map<ID,OF_Listino__c>();


             /**Modifica 24_03_2017**/
         /**Questo metodo mi crea una Mappa tra Order,list<Listini> in modo da avere sotto
            l'Asset(legato al Case-Order) solo i Billing Element come da specifica.
            Se il campo SLA_PREMIUM_ASSURANCE = 'N' prendo Canone,altrimenti 'Canone Premium'**/
         
         public Map<ID,Map<ID,PriceBook2> > getMappaOrder( Map<ID,ID> idOrderIdContract ,Map<ID,Order> orderID,Map<ID,ID> AssetOrder,Map<ID,Asset> MapAsset,Integer type , String CessazioneAttivi)
         {
            try{
                     /**Mappa con chiave idOrder e values List<OF_Listini**/
                     Map<ID,Map<ID,PriceBook2>> OrderBillingElements = new Map<ID,Map<Id,PriceBook2>>();
                     
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
                     ContractListini = getContractListini(ids,'Open Stream');
                     
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
                     /**Chiamo un metodo ad hoc per filtrare ulteriormente i listini,
                        in base alle informazioni che mi trovo sull'ordine(Tipologia Apparato,Progetto Speciale).
                        Questi due campi mi arrivano dal Case all'Ordine in fase di creazione dell'ordine**/
                        
                      Map<ID,Set<ID>> OrdiniListiniFilter2 = new Map<ID,Set<ID>>();
                     
                      OF_UtilitiesServiziAttivi obj = new OF_UtilitiesServiziAttivi();
                      /**OSCRM Quando arriva l'espletamento per un Case di tipo 'Open Stream',
                          prendo tutte le VLAN che sono sotto il Case e li sposto sotto l'Asset
                          nella rispettiva related list delle VLAN
                       **/
                       /**ATTIVAZIONE**/
                       if( type == 0)
                       {
                         
                       /*************************************/
                       /****************VLAN*****************/
                       /*************************************/
                       Map<Id,list<OF_CommercialElementIstanziato__c>> OrderCE = obj.createCEIstOrder( orderID , 0 , null , null);
                       system.debug('@@@@@@@@@@@@@@@@@@  Order CE: '+OrderCE);
                       
                       //DG 21/07/2017 Aggiunto MapAsset
                       
                       VLANIstanziazione( OrderCE , AssetOrder, MapAsset );
                       
                       /***************************************************************/
                       /******ISTANZIAZIONE SERVIZIO FIBRA BASE**********
                                   BE 'Contributo di attivazione'
                                   BE 'Canone'
                      /***************************************************/
                          Map<ID,Map<ID,PriceBook2>> mp = CreatePriceBookEntry_ServizioBase( orderID , ids , idOrderIdContract , AssetOrder ,MapAsset , 0);
                          CreazionePriceBookEntry_Attivi( mp , AssetOrder , 0 , true );
                       
                         //qui che cazzo succede??
                         Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> mpx = obj.getCEListini(OrdiniListini,orderID,'Open Stream',0,null,null);
                         Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> mpxFilter = obj.FilterCEAttivi(mpx,obj.listOfListino);
                         if(mpxFilter.size() > 0)
                         {
                            map<id,map<id,list<OF_Listino__c>>> mpxfilter2 = obj.CEListini(mpxFilter,obj.listOfListino,orderID);
                            MappaMultipleCE = obj.getMultipleCEPerListino(mpxfilter2);
                            /**Attivo i Commercial element istanziati sotto il case e li associo all'asset**/
                            obj.AttivazioneCE(mpxfilter2,AssetOrder,MapAsset); 
                            /**Creazione Mappa Order - ProductPriceBook**/
                            Map<ID,Set<ID>> map1 = getOrderSetIdListini(mpxfilter2);
                            mappaListini.clear();
                            Map<Id,Map<Id,PriceBook2>> OrdineProdPriceBook = getMappaPriceBook2Product2_Attivi(map1,orderID,AssetOrder,MapAsset,mappaListini,0);
                            return OrdineProdPriceBook;
                         }else{
                            return null;
                         }
                       }else if( type == 1 ) 
                       {
                           if( CessazioneAttivi == 'INSERT_OUTORDER')
                           {
	                           
	                           //Cessazione
	                            Map<ID,Map<ID,PriceBook2>> mp = CreatePriceBookEntry_ServizioBase( orderID , ids , idOrderIdContract , AssetOrder ,MapAsset , 1);
	                            CreazionePriceBookEntry_Attivi( mp , AssetOrder , 1 , true );
	                            //system.debug('Creazione PriceBookEntry ServiziAttivi 13');  
	                            return null;
	                            
	                       }else if( CessazioneAttivi == 'UPDATE_OUTORDER')
                           {
	                            Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> mpx = obj.getCEListini(OrdiniListini,orderID,'Open Stream',1,MapAsset,AssetOrder);
	                           
	                            Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> mpxFilter = obj.FilterCEAttiviCessazioneCPE(mpx,obj.listOfListino);
	                          
                               if(mpxFilter.size() > 0)
                               {
		                            map<id,map<id,list<OF_Listino__c>>> mpxfilter2 = obj.CEListini(mpxFilter,obj.listOfListino,orderID);		                           
	                          
	                                MappaMultipleCE = obj.getMultipleCEPerListino(mpxfilter2);
	                                /**Attivo i Commercial element istanziati sotto il case e li associo all'asset**/
	                                /**Creazione Mappa Order - ProductPriceBook**/
	                                Map<ID,Set<ID>> map1 = getOrderSetIdListini(mpxfilter2);
	                                
	                                mappaListini.clear();
	                                Map<Id,Map<Id,PriceBook2>> OrdineProdPriceBook = getMappaPriceBook2Product2_Attivi(map1,orderID,AssetOrder,MapAsset,mappaListini,0);
	                                return OrdineProdPriceBook;
	                         }
                            
                            
                            
                           }
                           
                        } 
                         
                     
                return null;
                     
             }catch( Exception e )
             {
                    OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','AggiornamentoAsset','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());            
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
                     if(IDContractListini.size() > 0 ) return IDContractListini;
                      return null;
                      
                 }catch( Exception e )
                 {
                    OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','getContractListini','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());           
                     return null;
                 }
            }
    
    //DG 21/07/2017 Aggiunto Map<ID,Asset> MapAsset
    public void VLANIstanziazione(Map<Id,list<OF_CommercialElementIstanziato__c>> OrderCE ,Map<ID,ID> OrderAsset, Map<ID,Asset> MapAsset)
     {
        try{
             List<OF_CommercialElementIstanziato__c> listaCEIst = new List<OF_CommercialElementIstanziato__c>();
             
             //system.debug('03_11_2017 OrderCE: '+OrderCE );
             for( ID idOrder : OrderCE.keyset() )
             {
              List<OF_CommercialElementIstanziato__c> listX = OrderCE.get(idOrder);
              system.debug('@@@@@@@@@@@@@@@@@@@@ la lista listx: '+listX);
              for( OF_CommercialElementIstanziato__c objCEIst : listX )
              {
               if( objCEIst.recordtypeId == OF_SA_GE_Utils.rtMap.get('OF_VLAN'))
               {
               	system.debug('@@@@@@@@@@@@@@@@@@@@ entrato nelle VLAN, idAsset: '+OrderAsset.get(idOrder)+' @@@@@@ id risorsa: '+MapAsset.get(OrderAsset.get(idOrder)).EOF_ID_Risorsa__c);
                   id assID = OrderAsset.get(idOrder);
                   objCEIst.OF_Asset__c = assID;
                   //DG 21/07/2017 Aggiunto ID Risorsa
                   objCEIst.OF_IDRisorsa__c = MapAsset.get(assID).EOF_ID_Risorsa__c;
                   objCEIst.OF_VLAN__c = assID;
                   objCEIst.OF_Stato__c = 'Attivo';
                   objCEIst.OF_DataAttivazione__c =OF_SA_GE_Utils.slSFOLOResp.lastModifiedDate;
                   listaCEIst.add(objCEIst);
               }
              }
            }
            
            //system.debug('03_11_2017 listaCEIst:'+listaCEIst);
            if( listaCEIst.size()>0){
            	 update listaCEIst;
            }
         }catch( Exception e ) 
               {
               OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','VLANIstanziazione','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
               }
      }
    
    public Map<ID,Map<ID,PriceBook2>> CreatePriceBookEntry_ServizioBase( Map<ID,Order> orderID ,Set<ID> idContratti , Map<ID,ID> idOrderIdContract , Map<ID,ID> AssetOrder,Map<ID,Asset> MapAsset , Integer tipo)
      {
        try{
                Map<ID,Set<id>> IDContractSetIdListini = getContractListiniAttivi( idContratti , 'Open Stream' , 'SERVIZIO OPEN STREAM BASE' , tipo );
                ////system.debug('OSCRM Cessazione IDContractSetIdListini : '+IDContractSetIdListini);
                Map<Id,Set<Id>>  OrdiniListini = new Map<Id,Set<Id>>();
                Map<ID,Set<ID>>  OrdiniListiniFilter = new Map<ID,Set<ID>>();
                 if( IDContractSetIdListini.size() > 0 )
                 {
                    if( idOrderIdContract != null && idOrderIdContract.size()>0 )
                    {
                        for( ID idOrder : idOrderIdContract.keyset())
                        {
                            ID idContrattoAssociatoOrdine = idOrderIdContract.get(idOrder);
                            if( idContrattoAssociatoOrdine != null )
                            {
                            OrdiniListini.put(idOrder,IDContractSetIdListini.get(idContrattoAssociatoOrdine));
                            }
                        }
                    }
                 }
                 ////system.debug('OSCRM OrdiniListini:'+OrdiniListini);
                 OrdiniListiniFilter = filtroListiniAttivi( OrdiniListini , orderID );
                 ////system.debug('OSCRM Cessazione OrdiniListiniFilter : '+OrdiniListiniFilter );
                 
                 return getMappaPriceBook2Product2_Attivi( OrdiniListiniFilter,orderID,AssetOrder,MapAsset,mappaListini,tipo);
                
        }catch( Exception e )
        {
             OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','CreatePriceBookEntry_ServizioBase','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()); 
            return null;
        }
      }
    
    /**Creazione PriceBookEntry ServiziAttivi**/
     public void CreazionePriceBookEntry_Attivi(Map<ID,Map<ID,PriceBook2>> mappa, Map<ID,ID> OrderAsset,Integer tipo,boolean IstanzioCE){
               try{
               List<PriceBook2> listPriceBook2Clonate = new List<PriceBook2>();
               Map<ID,Map<ID,PriceBook2>> orderPriceBookEntryClone = new Map<ID,Map<Id,PriceBook2>>();
                            
               //system.debug('Creazione PriceBookEntry ServiziAttivi 1');
               for( ID ix1: mappa.keyset() ){
               		//system.debug('Creazione PriceBookEntry ServiziAttivi 2');
                    Map<ID,PriceBook2> mapPriceProd= mappa.get(ix1);
                    
                    for(ID ix2 : mapPriceProd.keyset()){
                    	//system.debug('Creazione PriceBookEntry ServiziAttivi 3');
                        if( orderPriceBookEntryClone.containsKey(ix1)){
                        	//system.debug('Creazione PriceBookEntry ServiziAttivi 4');
                                    Map<Id,PriceBook2> PriceBookEntryClone = new Map<Id,PriceBook2>();
                                    PriceBookEntryClone = orderPriceBookEntryClone.get(ix1);
                                    PriceBookEntryClone.put(ix2,mapPriceProd.get(ix2).clone());
                                    orderPriceBookEntryClone.put(ix1,PriceBookEntryClone);
                          }
                          else{
                          	//system.debug('Creazione PriceBookEntry ServiziAttivi 5');
                                    Map<Id,PriceBook2> PriceBookEntryClone = new Map<Id,PriceBook2>();
                                    PriceBookEntryClone.put(ix2,mapPriceProd.get(ix2).clone());
                                    orderPriceBookEntryClone.put(ix1,PriceBookEntryClone);
                          }
                     }
                }     
                ////system.debug('stepOrlando orderPriceBookEntryClonate '+orderPriceBookEntryClone);
                if( orderPriceBookEntryClone != null && orderPriceBookEntryClone.size() > 0 ){
                	//system.debug('Creazione PriceBookEntry ServiziAttivi 6');
                    for( ID ix : orderPriceBookEntryClone.keyset() ){
                        listPriceBook2Clonate.addAll(orderPriceBookEntryClone.get(ix).values());
                    }
                }
                ////system.debug('stepOrlando listPriceBook2Clonate: '+listPriceBook2Clonate);
                if( listPriceBook2Clonate.size()>0){ 
                	//system.debug('Creazione PriceBookEntry ServiziAttivi 7');
                	insert listPriceBook2Clonate;
                }
               
                List<PriceBookEntry> listPriceBookEntry = new List<PriceBookEntry>();
                for( ID ix1: orderPriceBookEntryClone.keyset() ){
                	//system.debug('Creazione PriceBookEntry ServiziAttivi 8');
                    Map<ID,PriceBook2> mapPriceProd= orderPriceBookEntryClone.get(ix1);
                    for(ID ix2 : mapPriceProd.keyset()){
                    	//system.debug('Creazione PriceBookEntry ServiziAttivi 9');
                        PriceBookEntry pbE = new PricebookEntry();
                 
                        pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
                        pbE.IsActive=true;
                        pbE.UnitPrice = -9999;
                        pbE.Product2Id=ix2;
                        pbE.OF_Order__c = ix1;
                        pbE.OF_Asset__c = OrderAsset.get(ix1);
                        //if cessazione
                        if(OF_SA_GE_Utils.slOLOSF!=null){
                        	pbE.OF_DataAttivazione2__c =OF_SA_GE_Utils.slOLOSF.EOF_Data_Notifica__c;
                        }
                        //if attivazione
                        if(OF_SA_GE_Utils.slSFOLO!=null){
                        	pbE.OF_DataAttivazione2__c =OF_SA_GE_Utils.slSFOLOResp.lastModifiedDate;
                        }
                        /**Modifica--23_05_2017**/
                        ////system.debug('OSCRM mappaAssetComm(): '+mappaAssetComm);
                        ////system.debug('OSCRM OrderAsset.get(ix1):'+OrderAsset.get(ix1));
                         
                        ////system.debug('mappaAssetComm.containsKey( OrderAsset.get(ix1))'+mappaAssetComm.containsKey( OrderAsset.get(ix1)));
                        /**Modifica 23_05_2017**/
						//system.debug('IstanzioCE: '+IstanzioCE+', tipo: '+tipo);
                      if( IstanzioCE == true )
                      {
                      	//system.debug('Creazione PriceBookEntry ServiziAttivi 10');
                            /**Attivazione**/
                            if( tipo == 0)
                            {
                            	
                                if( mappaAssetComm.containsKey( OrderAsset.get(ix1)))
                                {             
                                Map<String,OF_CommercialElementIstanziato__c> listaCEIst = mappaAssetComm.get( OrderAsset.get(ix1));
                                String sy =  mapPriceProd.get(ix2).Commercial_Element__c;
                                ////system.debug('OSCRM sy:'+sy);
                                
                                pbE.OF_CommercialElementIstanziato__c = listaCEIst.get(sy).Id;
                                }
                              }else if( tipo == 1 )
                             {
                   
                                if( mappaAssetCommCess.containsKey( OrderAsset.get(ix1)))
                                {
                    			//system.debug('Creazione PriceBookEntry ServiziAttivi 12');  
                                //system.debug('OSCRM CreazionePriceBookEntry OrderAsset.get(ix1):'+OrderAsset.get(ix1));
                                Map<String,OF_CommercialElementIstanziato__c> listaCEIst = mappaAssetCommCess.get( OrderAsset.get(ix1));
                                String sy =  mapPriceProd.get(ix2).Commercial_Element__c;
                                //system.debug('OSCRM sy:'+sy);
                                //system.debug('OSCRM listaCEIst'+listaCEIst);
                                //system.debug('OSCRM listaCEIst.get(sy):'+listaCEIst.get(sy));
                                
                                //system.debug('OSCRM listaCEIst.get(sy).Id:'+listaCEIst.get(sy).Id);
            
                                pbE.OF_CommercialElementIstanziato__c = listaCEIst.get(sy).Id;
                                } 
                            }
                           /**Fine Modifica 23_05_2017**/
                          }
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
			            		t=OF_Utility.logMessageNew2(listPriceBookEntry[0].Pricebook2Id,'E','OF_GestioneServiziAttiviNEW','CreazionePriceBookEntry_Attivi',(x+1), e);
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
               OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','CreazionePriceBookEntry_Attivi','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
                     return;

               }
           
            }
    
    public static Map<ID,Set<ID>> getOrderSetIdListini(map<id,map<id,list<OF_Listino__c>>> OrderCEListini )
    {
        try{
        
            Map<ID,Set<ID>> OrderSetIDListini = new Map<ID,Set<ID>>();
                
                for( ID orderId : OrderCEListini.keyset() )
                {
                    Map<ID,List<OF_Listino__c>> mpx = OrderCEListini.get(orderId);
                    Set<ID> idListini = new Set<ID>();
                    
                    for( ID idCE : mpx.keyset())
                    {
                        for(OF_Listino__c listino : mpx.get(idCE))
                        {
                            idListini.add(listino.id);
                        }
                    }
                    ////system.debug('DG_getOrderSetIdListini: idListini: '+idListini);
                    OrderSetIDListini.put( orderID , idListini);
                }
                ////system.debug('DG_getOrderSetIdListini: OrderSetIDListini: '+OrderSetIDListini);
                return OrderSetIDListini;
        }catch(Exception e)
        {
            OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','getOrderSetIdListini','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());            
            return null;
         }
    }

    public Map<Id,Map<Id,PriceBook2>> getMappaPriceBook2Product2_Attivi( Map<Id,Set<ID>> OrderSetidListini,Map<ID,Order> orderID,Map<ID,ID> AssetOrder,Map<ID,Asset> mappaAsset,Map<id,OF_Listino__c> mapListini , Integer type)
     {
       try{
                      ////system.debug('DG ord: ' + ord);
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
                        
                        OrdineBECE_Attivi( OrderSetidListini , totalListini , mapListini ,OrderBE,OrderCE,orderID, type);
                       
                         /**CREAZIONE CE**/
                         
                         ////system.debug('OSCRM mappaAsset:'+mappaAsset);
                         if( type == 0)
                         {
                         ////system.debug('OSCRM getMappaPriceBook2Product2_Attivi CreazioneCE_Attivazione');
                         CreazioneCE_Attivazione(AssetOrder,OrderCE,mappaAsset,type);
                         }else if( type == 1 )
                         {
                         ////system.debug('OSCRM mappaAsset:'+mappaAsset+' type:'+type);
                         associazioneBEDissativazione_CEIst(mappaAsset);
                         }
                        /***/
                         ////system.debug('CRM OS : Order-List<String>():'+OrderCE);
                         

                         Map<ID,Product2> listaProduct2 = new Map<ID,Product2>([SELECT Id,OF_ListinoCustom__c,Name 
                                        From Product2 
                                        WHERE OF_ListinoCustom__c in : totalListini AND OF_Servizio__c = 'Open Stream']);
                                        
                          ////system.debug('CRM_listaProduct2-->'+listaProduct2);
                       

                          if( listaProduct2.size() > 0 )
                          {
                              for( ID pr2 : listaProduct2.keyset())
                              {
                                 listiniProduct2.put(listaProduct2.get(pr2).OF_ListinoCustom__c,pr2);
                              }

                          }
                         ////system.debug('CRM_listiniProduct2:'+listiniProduct2);
                         

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
                                  
                                  //listaPriceProduct.put(listiniProduct2.get(priceb2.OF_Listino__c),priceb2);
                                  //mappa<id,
                             }
                         }

                         /**Creazione Mappa Order - Map<IdProduct,PriceBook>**/
                         ////system.debug('CRM listaPriceProduct : '+listaPriceProduct);
                         
                         
                         
                         Map<Id,Map<Id,PriceBook2>> OrdinePriceProduct = new Map<Id,Map<Id,PriceBook2>>();
                         ////system.debug('CRM_OrdinePriceProduct: '+OrdinePriceProduct);
                         ////system.debug('OSCRM OrderSetidListini: '+OrderSetidListini);
                         
                        
                        for( ID idord :  OrderSetidListini.keyset() )
                        {
                            
                                ////system.debug('OSCRM for1');
                                for( ID idlistino : OrderSetidListini.get(idord))
                                {
                                       
                                       
                                       ////system.debug('OSCRM for2');
                                       if( OrdinePriceProduct.containsKey(idord))
                                         {
                                            
                                         Map<Id,PriceBook2> ProdPriceBook2 = OrdinePriceProduct.get(idord);
                                         ////system.debug('CRM_ProdPriceBook2 : '+ProdPriceBook2);
                                         



                                         ProdPriceBook2.putAll(listaPriceProduct.get(idlistino)); //ProdPriceBook2.put(listaPriceProduct.get(idlistino).keyset() ,listaPriceProduct.get(idlistino));
                                         
                                         
                                         OrdinePriceProduct.put(idord,ProdPriceBook2);
                                         
                                         ////system.debug('CRM_OrdinePriceProduct(contains): '+OrdinePriceProduct);
                                         
                                         }else{
                                            
                                         Map<Id,PriceBook2> ProdPriceBook2 = new Map<Id,PriceBook2>();
                                         
                                         ////system.debug('OSCRM listaPriceProduct : '+listaPriceProduct);
                                         ////system.debug('OSCRM listaPriceProduct.get(idlistino):'+listaPriceProduct.get(idlistino));
                                         
                                         ProdPriceBook2 = listaPriceProduct.get(idlistino);
                                         
                                         ////system.debug('CRM_ProdPriceBook2(NOT contains : '+ProdPriceBook2);
                                         
                                         OrdinePriceProduct.put(idord,ProdPriceBook2);
                                         
                                         ////system.debug('CRM_OrdinePriceProduct:'+OrdinePriceProduct);
                                         
                                         }
                                  }
                          }
                         
                         ////system.debug('CRM OrdinePriceProduct : ' + OrdinePriceProduct);
                 
                         
                         if( OrdinePriceProduct.size() > 0 ) return OrdinePriceProduct;
                         return null;
                }catch( Exception e )    
                {
                OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','getMappaPriceBook2Product2','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());            
                return null;
                } 
               
    }
    
    public static Map<Id,set<id>> getContractListiniAttivi(Set<ID> contratto , String Servizio , String ServizioBase , Integer tipo)
          {
             try{
                     Map<id,Set<id>> IDContractListini = new Map<id,Set<id>>();
                     List<String> BE_DA_ISTANZIARE = new List<String>();
                     
                     //Attivazione
                     if( tipo == 0)
                     {
                        BE_DA_ISTANZIARE.add( 'Canone' );
                        BE_DA_ISTANZIARE.add( 'Contributo Attivazione' );
                     }else if( tipo == 1 )//Cessazione
                     {
                        BE_DA_ISTANZIARE.add( 'Contributo Disattivazione');
                     }
                     
                     List<OF_Listino__c> listOfListino = [ select id,OF_IDContract__c,
                                                                  OF_Promozione__c,OF_CodiceProgettoSpeciale__c,
                                                                  OF_ClusterPromozione__c,
                                                                  OF_TipologiaApparato__c,
                                                                  OF_Attivo__c,OF_ListinoDefault__c
                                                           from OF_listino__c 
                                                           where OF_IDContract__c IN : contratto 
                                                            AND OF_Servizio__c =: Servizio 
                                                            AND OF_CommercialElement__c =: ServizioBase 
                                                            AND OF_ServizioBillingElement__r.OF_BillingElement__r.name IN : BE_DA_ISTANZIARE ];
                     ////system.debug('DG_Test - listOfListino: ' + listOfListino);
                     ////system.debug('DG_Test - contratto: ' + contratto + '----Servizio: ' + Servizio + '----ServizioBase: ' + ServizioBase);
                     if( listOfListino != null && listOfListino.size() > 0 )
                     { 
                        for( of_listino__c oc : listOfListino )
                        {
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
                     ////system.debug('OS_DEBUG1 : '+IDContractListini); 
                     if(IDContractListini.size() > 0 ) return IDContractListini;
                      return null;
                      
                 }catch( Exception e )
                 {
                    OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','getContractListini','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());           
                     return null;
                 }
            }
    
    /**Metodo filtro Listini(Progetto Speciale,Tipologia Apparato)**/
    public Map<Id,Set<ID>>filtroListiniAttivi( Map<ID,Set<ID>> OrdiniListini , Map<ID,Order> orderID)
    {
        try{
                Map<ID,Set<ID>> OrdiniListiniFiltro2 = new Map<ID,Set<ID>>();
                set<id> TotalListini = new set<id>();
                
                for( ID idOrder : OrdiniListini.keyset())
                {
                     TotalListini.addAll( OrdiniListini.get(idOrder));
                }
                ////system.debug('OSCRM filtroListini TotalListini: '+ TotalListini);
                
                    
                mappaListini = new Map<ID,OF_Listino__c>([select id,OF_IDContract__c,OF_TipologiaApparato__c,OF_ProgettoSpeciale__c,
                                                                                OF_ServizioBillingElement__c,OF_ServizioBillingElement__r.Name,OF_CommercialElement__c,
                                                                                OF_Attivo__c, OF_ListinoDefault__c,
                                                                                OF_Promozione__c,OF_CodiceProgettoSpeciale__c,
                                                                                OF_ClusterPromozione__c,Name
                                                                                from OF_listino__c 
                                                                                where  Id IN : TotalListini AND OF_Servizio__c = 'Open Stream']);
                /**Chiamo metodo ad hoc per avere Ordini - ListaCatalogoProdottiOLO**/
                
                
                
                Map<Id,set<String>> listaOrdinieCatalogoProdOLO = getOrderCatalogoProdottiOLO(orderID);
                ////system.debug('OSCRM listaOrdinieCatalogoProdOLO : '+listaOrdinieCatalogoProdOLO);
                /*****/ 
                                                            
                ////system.debug( 'OSCRM filtroListini mappaListini: '+ mappaListini );
                
                for( ID ix : OrdiniListini.keyset())
                {
                 
                    Order ordine = orderID.get(ix);
                    Set<ID> listini = OrdiniListini.get(ix);
                    /*
                    set<String> listaStrCatProdOLO = listaOrdinieCatalogoProdOLO.get( ix );
                    ////system.debug('OSCRM listaStrCatProdOLO : '+listaStrCatProdOLO );
                    ////system.debug('OSCRM o.OF_TipologiaApparato__c : '+ordine.OF_TipologiaApparato__c );
                     
                    //boolean checkProdottoApparato = listaStrCatProdOLO.contains(ordine.OF_TipologiaApparato__c.toUpperCase());
                    
                    
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
                    
                    ////system.debug('OSCRM OrderBE : '+OrderBE);
                    ////system.debug('OSCRM BEListListini: '+BEListListini);
                    
                    /******************************************************************************/
                    Set<ID> setBE = OrderBE.get( ix );
                    
                    Set<ID> setListiniFiltrati = new Set<ID>();
                     
                    for( ID iy : setBE )
                    {
                        Integer count = 0;
                        List<OF_Listino__c> iyListListini = BEListListini.get(iy);
                        OF_Listino__c listinoDiDefault;
                        
                        //20/07/2017 DG Start nuova versione di scelta dei listini di canone e contributo attivazione
                        string str = iyListListini[0].OF_ServizioBillingElement__r.Name;
                        
                        if(str == 'Canone'){
                            for( OF_Listino__c listino : iyListListini )
                            {
                                if((listino.Name == ordine.OF_Profilo__c) &&
                                   (listino.OF_Attivo__c == true)
                                  )
                                {
                                    setListiniFiltrati.add( listino.Id );
                                    break;
                                }else{
                                    count++;
                                }
                                
                                if( listino.OF_ListinoDefault__c == true) listinoDiDefault=listino;
                            }
                        }else{
                            for( OF_Listino__c listino : iyListListini )
                            {
                                if((listino.OF_Promozione__c == ordine.OF_Promozione__c) &&
                                   (listino.OF_CodiceProgettoSpeciale__c == ordine.OF_CodiceProgettoSpeciale__c) &&
                                   (listino.OF_ClusterPromozione__c == ordine.OF_ClusterPromozione__c) &&
                                   (listino.OF_TipologiaApparato__c == ordine.OF_TipologiaApparato__c) &&
                                   (listino.OF_Attivo__c == true)
                                  )
                                {
                                    setListiniFiltrati.add( listino.Id );
                                    break;
                                }else{
                                    count++;
                                }
                                
                                if( listino.OF_ListinoDefault__c == true) listinoDiDefault=listino;
                            }
                        }
                        //20/07/2017 END DG
                        
                        /*20/07/2017 DG OLD VERSION
                        for( OF_Listino__c listino : iyListListini )
                            {
                                //count++;
                                
                                //if( checkProdottoApparato == true )
                                //{      
                                ////system.debug('OSCRM OF_SA_OLO_EntryChecks');
                                
                                
                                if( (listino.OF_Profilo__c == ordine.OF_Profilo__c) &&
                                   (listino.OF_Promozione__c == ordine.OF_Promozione__c) &&
                                   (listino.OF_CodiceProgettoSpeciale__c == ordine.OF_CodiceProgettoSpeciale__c) &&
                                   (listino.OF_ClusterPromozione__c == ordine.OF_ClusterPromozione__c) &&
                                   (listino.OF_TipologiaApparato__c == ordine.OF_TipologiaApparato__c) &&
                                   (listino.OF_Attivo__c == true)
                                  )
                                {
                                    setListiniFiltrati.add( listino.Id );
                                    break;
                                }else{
                                    count++;
                                }
                                
                                if( listino.OF_ListinoDefault__c == true) listinoDiDefault=listino;
                                /*        
                                }else{
                                count++;
                                if( listino.OF_ListinoDefault__c == true) listinoDiDefault=listino;
                                
                                }
                                *
                            }*/
                        
                        /**In questo caso,ho ciclato per tutti i Listini che contengono quel BE( Esempio : Contributo Attivazione)
							ma non ho trovato nessuno che avesse la stessa tipologiaApparato e ProgettoSpeciale uguale all'Ordine diAttivazione**/
                        ////system.debug('OSCRM count: '+count);
                        ////system.debug('OSCRM lista.size(): '+ iyListListini );
                        if( count == iyListListini.size())
                        {
                            /**Controllo per evitare la mancanza in fase di Configurazione 
								del listino di default**/
                            if( listinoDiDefault != null) 
                                setListiniFiltrati.add( listinoDiDefault.Id);
                        }
                     }
                     ////system.debug('OSCRM Cessazione setListiniFiltrati: '+setListiniFiltrati );
                     ////system.debug('OSCRM Cessazione OrdiniListiniFiltro2: '+OrdiniListiniFiltro2 );
                     
                     
                     if( setListiniFiltrati.size()>0){
                         ////system.debug('OSCRM setListiniFiltrati: '+setListiniFiltrati);
                         OrdiniListiniFiltro2.put( ix , setListiniFiltrati );
                     }
                }
                
                 ////system.debug('OSCRM OrdiniListiniFiltro2 : '+OrdiniListiniFiltro2);
                            
                return OrdiniListiniFiltro2;
        }catch( Exception e )
        {
             OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','filtroListiniAttivi','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()); 
             return null;
        }
    }

    public void OrdineBECE_Attivi(Map<ID,Set<ID>> orderListini,
                                  Set<ID> totalListini, 
                                  Map<ID,OF_Listino__c> mappaListini , 
                                  Map<Id,Set<string>> OrderBE , 
                                  Map<ID,Set<String>> OrderCE ,
                                  Map<ID,Order> orderID,
                                  Integer tipo)
    {
        try{
             for( ID idOrdine : orderListini.keyset())
             {
                  totalListini.addAll(orderListini.get(idOrdine));
                  
                  Order ord = orderID.get(idOrdine);
                  Set<ID> listini = orderListini.get(idOrdine);
                  
                  Set<String> lsBE = new Set<String>();
                  Set<String> lsCE = new Set<String>();
                  
                  ////system.debug('DG_OF_UtilitiesCreazioneAsset - orderListini: ' + orderListini);
                  ////system.debug('DG_OF_UtilitiesCreazioneAsset - mappaListini: ' + mappaListini);
                  ////system.debug('DG_OF_UtilitiesCreazioneAsset - orderID: ' + orderID);
                  if(mappaListini.size() > 0){
                      for( ID idlistino : listini )
                      {
                           OF_Listino__c listinoOBJ = mappaListini.get( idlistino );
                           lsBE.add(listinoOBJ.OF_ServizioBillingElement__r.Name);
                           lsCE.add(listinoOBJ.OF_CommercialElement__c);
                      }
                      OrderBE.put( idOrdine , lsBE );
                      OrderCE.put( idOrdine , lsCE );
                      ////system.debug('DG_OF_UtilitiesCreazioneAsset - OrderBE: ' + OrderBE);
                      ////system.debug('DG_OF_UtilitiesCreazioneAsset - OrderCE: ' + OrderCE);
                  }
              }
                return;
           }catch( Exception e )
           {
               OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','getIdOrderBECE','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
                     return;
           }
    }
    
    public  void CreazioneCE_Attivazione(Map<ID,ID> OrderAsset , Map<ID,Set<String>> idOrder , Map<Id,Asset> mappaAsset, Integer tipo)
     {
        try{
               List<OF_CommercialElement__c> listaCommercialElement =[ SELECT Id,Name 
                                                                       FROM OF_CommercialElement__c ];
                                                                       
                                                                       
               ////system.debug('OSCRM listaCommercialElement : '+listaCommercialElement );                                                         
               Map<String,Id> elencoNome = new Map<String,Id>(); 
                                                                       
               for( OF_CommercialElement__c ce : listaCommercialElement )elencoNome.put(ce.Name,ce.Id);
               
               ////system.debug('OSCRM elencoNome : '+elencoNome );
               
               List<OF_CommercialElementIstanziato__c> listaCommercialElementIstanz = new List<OF_CommercialElementIstanziato__c>();
               
               
               
               Map<ID,Set<String>> AssetSetCE = new Map<ID,Set<String>>();
               
               for( ID ix : idOrder.keyset() )
               {
                    AssetSetCE.put( OrderAsset.get( ix ) , idOrder.get(ix) );
               }
               
               
               ////system.debug('OSCRM AssetSetCE : '+AssetSetCE ); 
                   for( ID idAsset : AssetSetCE.keyset() )
                   {
                      
                      Set<String> setStr = AssetSetCE.get(idAsset);
                      for( String str : setStr  )
                      {
                          OF_CommercialElementIstanziato__c ceIst = new OF_CommercialElementIstanziato__c();
                          //ceIst.Name = str;
                          
                          ////system.debug('OSCRM NomeCommercial : '+elencoNome.get( str ));
                          ID RecordType = OF_AttivazManualeCEController.RecordTypeCE(str);

                          //ID RecordType = OF_AttivazManualeCEController.RecordTypeCE(elencoNome.get( str ));
                          
                          ////system.debug('OSCRM RecordType : '+RecordType );
                          
                          ceIst.OF_CommercialElement__c = elencoNome.get( str );
                          ceIst.OF_Asset__c = idAsset;
                          ceIst.RecordTypeId = RecordType;
                          
                          /**Riempimento campi CEIstanziato prendendo i campi dall'Asset**/
                          //ceIst.OF_DataAttivazione__c = system.now();
                         
                          Asset a = mappaAsset.get( idAsset );
                          ////system.debug('OSCRM Asset a :'+a);
                          ceIst.OF_IDRisorsa__c = a.Name;
                          ceIst.OF_IDOrdine__c = a.OF_OrdineID__c;
                          ceIst.OF_Stato__c = a.Status;
                          ceIst.OF_Case__c = a.OF_IDCaseAttivazione__c;
                          if(!Test.isRunningTest()){
                              ceIst.OF_DataAttivazione__c =OF_SA_GE_Utils.slSFOLOResp.lastModifiedDate;
                          }
                          system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Ceist: '+ceIst);
                          if(ceIst.RecordTypeId==OF_SA_GE_Utils.rtMap.get('OF_CPE')) {
								ceIst.OF_CPE__c=ceIst.OF_Asset__c;
							}
							else if(ceIst.RecordTypeId==OF_SA_GE_Utils.rtMap.get('CPE_Passivi')){
								ceIst.OF_CPEPassivi__c=ceIst.OF_Asset__c;
							}
							else if(ceIst.RecordTypeId==OF_SA_GE_Utils.rtMap.get('OF_VLAN')) {
								ceIst.OF_VLAN__c=ceIst.OF_Asset__c;
							}	
							else if(ceIst.RecordTypeId==OF_SA_GE_Utils.rtMap.get('OF_ServiziAggiuntivi')) {
								ceIst.OF_ServiziAggiuntivi__c=ceIst.OF_Asset__c;
							}
							else if(ceIst.RecordTypeId==OF_SA_GE_Utils.rtMap.get('OF_Standard')) {
								ceIst.OF_CEStandard__c=ceIst.OF_Asset__c;
							}
                          
                          //ceIst.OF_Case__c = 
                          
                          
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
                          ////system.debug('OSCRM mappaAssetCE before INSERT: '+mappaAssetComm);            
                          listaCommercialElementIstanz.add(ceIst);
                      }
                   
                   
                   if( listaCommercialElementIstanz.size()>0)insert listaCommercialElementIstanz;
                   ////system.debug('OSCRM mappaAssetCE after INSERT: '+mappaAssetComm);
                   
                 }         
               
            }catch( Exception e )
               {
               OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','CreazioneCE_Attivazione','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
                     return;

               }
        }
    
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
          ////system.debug('OSCRM associazioneBEDissativazione_CEIst : '+ listaAssetCommercialIstanziati );
          
          
          }catch(Exception e)
            {
                 OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','associazioneBEDissativazione_CEIst','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
                     return;
            }
    }
    
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
                  ////system.debug('OSCRM getOrderCatalogoProdottiOLO ordiniCatalogoProdottiOLO:'+ordiniCatalogoProdottiOLO);    
                 
                  return ordiniCatalogoProdottiOLO;
           }catch(Exception e )
               {
                  OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','getOrderCatalogoProdottiOLO','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
                return null;
               }
     }
    
    /***OSCRM 05_06_2017***/
    /**Creazione PriceBookEntry ServiziAttivi**/
     public void CreazionePriceBookEntry_AttiviCPE(Map<ID,Map<ID,PriceBook2>> mappa, Map<ID,ID> OrderAsset,Integer tipo, Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> mappaMultipleCE,boolean IstanzioCE)
            {
               try{

               
               List<PriceBook2> listPriceBook2Clonate = new List<PriceBook2>();
               
               Map<ID,Map<ID, List<PriceBook2> >> orderPriceBookEntryClone = new Map<ID,Map<Id, List<PriceBook2>>>();
                            
               
               for( ID ix1: mappa.keyset() )
                {
                    Map<ID,PriceBook2> mapPriceProd= mappa.get(ix1);
                    Map<ID,List<OF_CommercialElementIstanziato__c>> mpxy = mappaMultipleCE.get( ix1 );
                    Map<ID,List<PriceBook2>> mpx = new Map<ID,List<PriceBook2>>();
                    
                    for(ID ix2 : mapPriceProd.keyset())
                    {
                        PriceBook2 pricebook2 = mapPriceProd.get(ix2);
                        List<PriceBook2> listaPriceBook2 = new List<PriceBook2>();
                        
                        ID idListino = pricebook2.OF_Listino__c;
                        List<OF_CommercialElementIstanziato__c> listaCE = mpxy.get( idListino );
                        for( Integer i = 0 ; i < listaCE.size() ; i++)
                        {
                            listaPriceBook2.add( pricebook2.clone() );
                        }
                        
                        listPriceBook2Clonate.addAll( listaPriceBook2);
                        mpx.put( ix2 , listaPriceBook2);
                        
                    }
                    
                    orderPriceBookEntryClone.put( ix1 , mpx );
                }
                
                
                ////system.debug('OSCRM CreazionePriceEntry_AttiviCPE : orderPriceBookEntryClone :'+orderPriceBookEntryClone );
                if( listPriceBook2Clonate.size() > 0 ) insert listPriceBook2Clonate;
                ////system.debug('OSCRM CreazionePriceEntry_AttiviCPE : listPriceBook2Clonate :'+listPriceBook2Clonate );
                
               
                /**Creazione PriceBookEntry**/
                List<PriceBookEntry> listPriceBookEntry = new List<PriceBookEntry>();
                for( ID ix1: orderPriceBookEntryClone.keyset() )
                {
                    Map<ID,List<PriceBook2>> mapPriceProd= orderPriceBookEntryClone.get(ix1);
                    ////system.debug('OSCRM CreazionePriceEntry_AttiviCPE : mapPriceProd :'+mapPriceProd );
                    
                    Map<ID,List<OF_CommercialElementIstanziato__c>> mpxy = mappaMultipleCE.get( ix1 );
                    ////system.debug('OSCRM CreazionePriceEntry_AttiviCPE : mpxy :'+mpxy );
                    
                    for(ID ix2 : mapPriceProd.keyset())
                    {
                        Integer index = 0;
                        for( PriceBook2 pricebook2 :  mapPriceProd.get(ix2) )
                        {   
                             PriceBookEntry pbE = new PricebookEntry();
                             pbE.Pricebook2Id = pricebook2.Id;
                             pbE.IsActive=true;
                             pbE.UnitPrice = -9999;
                             pbE.Product2Id=ix2;
                             pbE.OF_Order__c = ix1;
                             pbE.OF_Asset__c = OrderAsset.get(ix1);
                             pbE.OF_DataAttivazione2__c =OF_SA_GE_Utils.slSFOLOResp.lastModifiedDate;
                             pbE.OF_CommercialElementIstanziato__c = mpxy.get( pricebook2.OF_Listino__c)[index].Id;
                            listPriceBookEntry.add(pbE);
                            index++;
                        }
                     }
                  }
                 ////system.debug('OSCRM CreazionePriceEntry_AttiviCPE : listPriceBookEntry :'+listPriceBookEntry );
                  
                  
                
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
			            		t=OF_Utility.logMessageNew2(listPriceBookEntry[0].Pricebook2Id,'E','OF_GestioneServiziAttiviNEW','CreazionePriceBookEntry_AttiviCPE',(x+1), e);
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
               OF_Utility.logMessage(true,'E','OF_GestioneServiziAttiviNEW','CreazionePriceBookEntry_AttiviCPE','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
                     return;

               }
           
            }

	
	
}
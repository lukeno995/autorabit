public with sharing class OF_UtilitiesServiziAttivi {
    
    /**CRM_OS Metodo 1**/
    /**Questo metodo prende in input una stringa che indica il nome del servizio,
       e poi tira giù tutti i listini configurati per quel Servizio.A quel punto
       Itera sui Listini e crea Una Mappa tra NomeCommercial - IDListini**/
       public  Map<ID,OF_Listino__c> listOfListino{get;set;}
       
       //Costruttore
       public OF_UtilitiesServiziAttivi()
       {
              listOfListino = new Map<ID,OF_Listino__c>();
       }
       
       
    public Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> getCEListini( Map<ID,Set<ID>> IDOrderListini ,Map<ID,Order> mapOrders,String Servizio,Integer tipo , Map<ID,Asset> mpAsset , Map<ID,ID> assetOrder )
    {
        
        try{
        //system.debug('2106_IDOrderListini'+IDOrderListini);
        Map<Id,list<OF_CommercialElementIstanziato__c>> ordersCE = createCEIstOrder( mapOrders , tipo , mpAsset , assetOrder );
        //system.debug('OSCRM OF_UtilitiesServiziAttivi  ordersCE : '+ordersCE );
        
        
        set<id> IDSet = new set<id>();
        for( ID ix : IDOrderListini.keySet())
        {
             IDSet.addall(IDOrderListini.get(ix));
        }
        
        
        //Map<String, Set<ID>> mappaCEListini = new Map<String,Set<ID>>();
        Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> mappaOrderListinoCE = new Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>>();
        
        
        listOfListino = new Map<ID,OF_Listino__c>(
                                                 [select id,OF_IDContract__c,OF_CommercialElement__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name, OF_Promozione__c, OF_CodiceProgettoSpeciale__c, OF_ClusterPromozione__c, OF_TipologiaApparato__c, OF_ListinoDefault__c, OF_Attivo__c
                                                 from OF_Listino__c 
                                                 where OF_Servizio__c =: Servizio And Id IN : IDSet ]
                                                 );
       //system.debug('OSCRM OF_UtilitiesServiziAttivi listOfListino : '+listOfListino );
       for( ID idOrder : IDOrderListini.keySet() )
       {
            Set<ID> listiniID = IDOrderListini.get( idOrder);
            List<OF_CommercialElementIstanziato__c> CEOrder = ordersCE.get( idOrder );
            //system.debug('DG_OF_UtilitiesServiziAttivi - CEOrder: ' + CEOrder);
            Map<ID,List<OF_CommercialElementIstanziato__c>> idListinoCE = new Map<ID,List<OF_CommercialElementIstanziato__c>>();
            for( ID idlistino : listiniID )
            {
                
                OF_Listino__c objListino = listOfListino.get( idlistino );
                //system.debug('OSCRM OF_UtilitiesServiziAttivi objListino:'+objListino);
                //system.debug('OSCRM OF_UtilitiesServiziAttivi CEOrder :'+CEOrder );
                
                for( OF_CommercialElementIstanziato__c obj : CEOrder )
                {
                     //List<String> str = new List<String>();
                     //system.debug('OSCRM OF_UtilitiesServiziAttivi objListino.OF_CommercialElement__c : '+objListino.OF_CommercialElement__c );
                     //system.debug('OSCRM OF_UtilitiesServiziAttivi obj.OF_CommercialElementName__c : '+obj.OF_CommercialElementName__c );
                     
                     
                     if( objListino.OF_CommercialElement__c == obj.OF_CommercialElementName__c )
                     {
                        
                        if( idListinoCE.containsKey (idlistino))
                        {
                            List<OF_CommercialElementIstanziato__c> str = idListinoCE.get( idlistino);
                            str.add(obj);
                            idListinoCE.put( idlistino, str );
                        }else{
                            List<OF_CommercialElementIstanziato__c> str = new List<OF_CommercialElementIstanziato__c>();
                            str.add(obj);
                            idListinoCE.put( idlistino, str);
                        }
                        
                     }
                
                }
            }
                
                
             mappaOrderListinoCE.put( idOrder , idListinoCE );
         }
        
        //system.debug('OSCRM mappaOrderListinoCE : '+mappaOrderListinoCE );
        return mappaOrderListinoCE;
        
        }catch(Exception e )
        {
        OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesServiziAttivi','Method: getCEListini','Exception:' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());           
                return null;

        }
        
       }
   /**Crea mappa tra: id CE ist sotto il case - id ordine**/
    public Map<Id,list<OF_CommercialElementIstanziato__c>> createCEIstOrder(Map<ID,Order> orderID , Integer tipo , Map<ID,Asset> mapAsset , Map<ID,ID> assetOrder )
    {
        try{
            Set<id> idcase = new set<id>();
            
            for(id idOrd : orderID.keyset())
            {
                idcase.add(orderID.get(idOrd).OF_CaseID__c);
            }
            
            system.debug('OSCRM OF_UtilitiesServiziAttivi idcase: '+idcase);
            Map<Id,List<OF_CommercialElementIstanziato__c>> mappaOrdineCE = new Map<Id,List<OF_CommercialElementIstanziato__c>>();
            
            //Attivazione
            if( tipo == 0 )
            {
	            
	            List<case> listaCaseCEIst = [Select id,OF_Order__c,(select id,OF_CommercialElementName__c, OF_Asset__c, OF_Stato__c, recordtype.name, recordtypeId ,OF_Nome_Servizio__c, OF_ESITOSERVIZIO__c, OF_EsitoConsegnaApparato__c, OF_Promozione__c, OF_CodiceProgettoSpeciale__c, OF_ClusterPromozione__c, OF_TipologiaApparato__c from Commercial_element_istanziati__r )
	                                                                    from case
	                                                                    where id IN : idcase];
	            //system.debug('OSCRM OF_UtilitiesServiziAttivi listaCaseCEIst: '+ listaCaseCEIst);
	            for( Case Cases : listaCaseCEIst )
		         {
		                List<OF_CommercialElementIstanziato__c> listCist = Cases.Commercial_element_istanziati__r;
		                //system.debug('OSCRM OF_UtilitiesServiziAttivi listCist:'+listCist );
		                mappaOrdineCE.put(Cases.OF_Order__c, listCist); 
		         }
		    //Cessazione    
		    }else if( tipo == 1 )
		    {
		    	//system.debug('OSCRM OF_UtilitiesServiziAttivi: tipo = 1');
		    	//system.debug('OSCRM OF_UtilitiesServiziAttivi orderID:'+orderID );
		    	
		    	List<OF_CommercialElementIstanziato__c> listCistFilter = new List<OF_CommercialElementIstanziato__c>();
		    	
		    	for( ID iord : orderID.keyset() )
		    	{
		    		//system.debug('OSCRM OF_UtilitiesServiziAttivi assetOrder.get(iord):'+assetOrder.get( iord));
		    	    //system.debug('OSCRM OF_UtilitiesServiziAttivi mapAsset.get( assetOrder.get( iord ):'+mapAsset.get( assetOrder.get( iord )));
		    		
		    		Asset a = mapAsset.get( assetOrder.get( iord ) );
		    		//system.debug('OSCRM OF_UtilitiesServiziAttivi asset:'+a);
		    		List<OF_CommercialElementIstanziato__c> listCist = a.Commercial_element_istanziati3__r;
		    	    
		    	    for( OF_CommercialElementIstanziato__c ceIst : listCist )
		    	    {
		    	    	if( ceIst.OF_EsitoRitiroApparato__c == '0')
		    	    	listCistFilter.add( ceIst );
		    	    }
		    	    
		    	    /**Associo solo i CPE che hanno il campo ESITO_RITIRO_APPARATO = 0**/
		    	    
		    	    //system.debug('OSCRM OF_UtilitiesServiziAttivi asset:'+a);
		    		mappaOrdineCE.put( iord , listCistFilter );
		    	}
		    	//Commercial_element_istanziati3
		    }
            system.debug('OSCRM OF_UtilitiesServiziAttivi mappaOrdineCE : '+ mappaOrdineCE);   
            if( mappaOrdineCE != null && mappaOrdineCE.size()>0 )
            {
                return mappaOrdineCE;
            }else
                return null;
                
        }catch(Exception e )
        {
        OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesServiziAttivi','Method: createCEIstOrder','Exception:' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());           
                return null;

        }
    }
    
    /**Lega i commercial element sotto il case all'asset e mette lo stato dei CEIst in attivo
    public static void AggiornamentoCEAttivi (Map<Id,list<OF_CommercialElementIstanziato__c>> mapOrderCE, map<Id,Id> mapOrderAsset){
        
        try{
            list<OF_CommercialElementIstanziato__c> CEIstToUpdate =  new list<OF_CommercialElementIstanziato__c>();
            
            //system.debug('DG_OF_UtilitiesServiziAttivi - mapOrderCE: ' + mapOrderCE);
            
            for(id ids : mapOrderCE.keyset())
            {   
                //system.debug('DG_OF_UtilitiesServiziAttivi - mapOrderAsset.get(ids): ' + mapOrderAsset.get(ids));
                for(OF_CommercialElementIstanziato__c CEIST : mapOrderCE.get(ids))
                {
                    CEIST.OF_Asset__c = mapOrderAsset.get(ids);
                    CEIST.OF_Stato__c = 'Attivo';
                    CEIstToUpdate.add(CEIST);
                }
            }
            if(CEIstToUpdate.size() > 0)    update CEIstToUpdate;
            //system.debug('DG_OF_UtilitiesServiziAttivi - dopo CEIstToUpdate: ' + CEIstToUpdate);
            
        }catch(Exception e )
        {
        OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesServiziAttivi','Method: AggiornamentoCEAttivi','Exception:' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());           
        }
    
    }**/
    
    
    //Metodo che filtra i CEIstanziati in base alle logiche richeste
    public Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> FilterCEAttivi (Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> TheMap, map<id,OF_listino__c> listOFListino){
        
        try{
            
            Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> FilterMap = new Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>>();
            Map<ID,List<OF_CommercialElementIstanziato__c>> filter1 = new Map<ID,List<OF_CommercialElementIstanziato__c>>();
            
             //system.debug('DG_OF_UtilitiesServiziAttivi -TheMap.keyset(): ' + TheMap.keyset());
             //system.debug('DG_OF_UtilitiesServiziAttivi -TheMap: ' + TheMap);
            
            for(id idOrder : TheMap.keyset())
            {
                for(id idList : TheMap.get(idOrder).keyset())
                {
                    OF_Listino__c currentList = listOFListino.get(idList);
                    string strCE = currentList.OF_CommercialElement__c;
                    //system.debug('DG_OF_UtilitiesServiziAttivi -strCE: ' + strCE);
                    string strBE = currentList.OF_ServizioBillingElement__r.OF_BillingElement__r.name;
                    //system.debug('DG_OF_UtilitiesServiziAttivi -strBE: ' + strBE);
                    List<OF_CommercialElementIstanziato__c> filter2 = new List<OF_CommercialElementIstanziato__c>();
                    
                    for(OF_CommercialElementIstanziato__c CEIst : TheMap.get(idOrder).get(idList))
                    {
                        if( (CEIst.recordtype.name == 'Servizi Aggiuntivi')&&
                            (CEIst.OF_Nome_Servizio__c == 'RIBALTAMENTO IMPIANTO')&&
                            (CEIst.OF_ESITOSERVIZIO__c == '0'))
                            {
                                //system.debug('DG_OF_UtilitiesServiziAttivi - dentro ribaltamento impianto');
                                //Ribaltamento impianto
                                filter2.add(CEIst);
                            }
                        if( (CEIst.recordtype.name == 'Servizi Aggiuntivi') &&
                            (CEIst.OF_Nome_Servizio__c == 'ESTENSIONE IMPIANTO CLIENTE')&&
                            (CEIst.OF_ESITOSERVIZIO__c == '0'))
                            {
                                //system.debug('DG_OF_UtilitiesServiziAttivi - dentro estensione impianto');
                                //Estensione impianto
                                filter2.add(CEIst);
                            }
                        if( (CEIst.recordtype.name == 'CPE') &&
                            (CEIst.OF_EsitoConsegnaApparato__c == '1' || CEIst.OF_EsitoConsegnaApparato__c == '3')&&
                            (strBE == 'Contributo Consegna'))
                            {
                                //system.debug('DG_OF_UtilitiesServiziAttivi - dentro Contributo consegna');
                                //Contributo consegna
                                filter2.add(CEIst);
                            }
                        if( (CEIst.recordtype.name == 'CPE') &&
                            (CEIst.OF_EsitoConsegnaApparato__c == '2') &&
                            (strBE == 'Contributo Consegna e Istallazione'))
                            {
                                //system.debug('DG_OF_UtilitiesServiziAttivi - dentro Contributo consegna e istallazione');
                                //Contributo consegna e istallazione
                                filter2.add(CEIst);
                            }
                        if( (CEIst.recordtype.name == 'CPE') &&
                            (CEIst.OF_EsitoConsegnaApparato__c == '4')&&
                            (strBE == 'Contributo istallazione'))
                            {
                                //system.debug('DG_OF_UtilitiesServiziAttivi - dentro Contributo istallazione');
                                //Contributo istallazione
                                filter2.add(CEIst);
                            }
                    }
                    if(filter2.size() > 0){
                        filter1.put(idList,filter2);
                        //system.debug('DG_OF_UtilitiesServiziAttivi - filter1: ' + filter1);
                    }
                }
                if(filter1.size() > 0){
                    FilterMap.put(idOrder,filter1);
                    //system.debug('DG_OF_UtilitiesServiziAttivi - FilterMap: ' + FilterMap);
                }
            }
            //system.debug('DG_OF_UtilitiesServiziAttivi - FilterMap: ' + FilterMap);
            return FilterMap;
            
        }catch(Exception e )
        {
        OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesServiziAttivi','Method: FilterCEAttivi','Exception:' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());           
                return null;

        }
    }
    
    
    
    //31/05/2017 struttura per fare il match tra campi listino e Commercial Element istanziato
    //Match tra listini e CE
    //Associo al CE il listino che ha caratteristiche uguali
    public map<id,map<id,list<OF_Listino__c>>> CEListini (Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> TheMap, map<id,OF_listino__c> listOFListino, map<id,order> orderID)
    {
        try{
            /***********START creazione struttura**************/
            //Strutture per la mappa tra ordine e ce istanziato
            map<id, map<id,OF_CommercialElementIstanziato__c>> OrderCEMap = new map<id, map<id,OF_CommercialElementIstanziato__c>>();
            map<id,OF_CommercialElementIstanziato__c> CEMap = new map<id,OF_CommercialElementIstanziato__c>();
            
            //Strutture per la mappa tra ordine e mappa tra ce e listini
            map<id,map<id,list<OF_Listino__c>>> OrdCEListMap = new map<id,map<id,list<OF_Listino__c>>>();
            list<OF_Listino__c> ListinoList = new list<OF_Listino__c>();
            
            //Ciclo per creare la struttura mappa <ordine,mappa<CE,list<Listini>>>
            for(id idOrder : TheMap.keyset())
            {
                map<id,list<OF_Listino__c>> CEListMap = new map<id,list<OF_Listino__c>>();
                map<id,OF_CommercialElementIstanziato__c> CEMap1 = new map<id,OF_CommercialElementIstanziato__c>();
                
                for(id idList : TheMap.get(idOrder).keyset())
                {
                    for(OF_CommercialElementIstanziato__c CEIst : TheMap.get(idOrder).get(idList))
                    {
                        if( CEListMap.containsKey(CEIst.id))
                        {
                            List<OF_Listino__c> str = CEListMap.get(CEIst.id);
                            str.add(listOFListino.get(idList));
                            CEListMap.put(CEIst.id,str);
                        }else
                        {
                            List<OF_Listino__c> str = new List<OF_Listino__c>();
                            str.add(listOFListino.get(idList));
                            CEListMap.put(CEIst.id,str);
                        }
                        //system.debug('DG_OF_UtilitiesServiziAttivi - CEListMap: ' + CEListMap);
                        CEMap1.put(CEIst.id, CEIst);
                    }
                }
                OrderCEMap.put(idOrder, CEMap1);
                OrdCEListMap.put(idOrder,CEListMap);
            }
            //system.debug('DG_OF_UtilitiesServiziAttivi - OrderCEMap: ' + OrderCEMap);
            //system.debug('DG_OF_UtilitiesServiziAttivi - OrdCEListMap: ' + OrdCEListMap);
            
            /***********END creazione struttura**************/
            
            
            /***********START scelta listino**************/
            //Mappa tra ordine e lista di apparati per l'OLO presente nell'ordine
            Map<ID,set<String>> ListaCatApparati = getOrderCatalogoProdottiOLO(orderID);
            
            //Strutture per la mappa tra ordine e mappa tra ce e listini
            map<id,map<id,list<OF_Listino__c>>> OrdCEListMap1 = new map<id,map<id,list<OF_Listino__c>>>();
            
            
            //Ciclo per trovare il listino corretto per quel commercial element
            for(id idorder : OrdCEListMap.keyset())
            {
                //system.debug('DG_OF_UtilitiesServiziAttivi - dentro ciclo ordine');
                Order o = orderID.get(idorder);
                //system.debug('DG_OF_UtilitiesServiziAttivi - o: ' + o);
                
                map<id,list<OF_Listino__c>> CEListMap1 = new map<id,list<OF_Listino__c>>();
                
                for(id idCE : OrdCEListMap.get(idOrder).keyset())
                {
                    //system.debug('DG_OF_UtilitiesServiziAttivi - dentro ciclo CE');
                    
                    //Prendo il commercial element istanziato
                    OF_CommercialElementIstanziato__c CurrentCEIst = OrderCEMap.get(idorder).get(idCE);
                    //system.debug('DG_OF_UtilitiesServiziAttivi - CurrentCEIst: ' + CurrentCEIst);
                    
                    //Considero la tipologia apparato solo per i CPE
                    boolean checkProdottoApparato;
                    if(CurrentCEIst.OF_CommercialElementName__c == 'CPE'){
                        set<String> listaStrCatProdOLO = ListaCatApparati.get(idorder);
                        //system.debug('DG_OF_UtilitiesServiziAttivi - listaStrCatProdOLO: ' + listaStrCatProdOLO);
                        checkProdottoApparato = listaStrCatProdOLO.contains(CurrentCEIst.OF_TipologiaApparato__c.toUpperCase());
                        //system.debug('DG_OF_UtilitiesServiziAttivi - checkProdottoApparato: ' + checkProdottoApparato);
                    }
                    
                    Integer count = 0;
                    OF_Listino__c listinoDiDefault;
                    list<OF_Listino__c> listx = OrdCEListMap.get(idOrder).get(idCE);
                    //system.debug('DG_OF_UtilitiesServiziAttivi - listx: ' + listx);
                    
                    list<OF_Listino__c> ListinoList1 = new list<OF_Listino__c>();
                    
                    for(OF_Listino__c listino : listx)
                    {
                        //system.debug('DG_OF_UtilitiesServiziAttivi - dentro ciclo listini');
                        if(checkProdottoApparato == true)
                        {      
                            //system.debug('DG_OF_UtilitiesServiziAttivi - checkProdottoApparato = true');
                            //system.debug('DG_OF_UtilitiesServiziAttivi - listino: ' + listino);
                            //system.debug('DG_OF_UtilitiesServiziAttivi - CurrentCEIst: ' + CurrentCEIst);
                           
                            if( (listino.OF_Promozione__c == CurrentCEIst.OF_Promozione__c) &&
                                (listino.OF_CodiceProgettoSpeciale__c == CurrentCEIst.OF_CodiceProgettoSpeciale__c) &&
                                (listino.OF_ClusterPromozione__c == CurrentCEIst.OF_ClusterPromozione__c) &&
                                (listino.OF_Attivo__c == true)
                            )
                            {
                                //system.debug('DG_OF_UtilitiesServiziAttivi - CurrentCEIst.OF_CommercialElementName__c: ' + CurrentCEIst.OF_CommercialElementName__c);
                                //system.debug('DG_OF_UtilitiesServiziAttivi - listino.OF_TipologiaApparato__c: ' + listino.OF_TipologiaApparato__c);
                                //system.debug('DG_OF_UtilitiesServiziAttivi - CurrentCEIst.OF_TipologiaApparato__c: ' + CurrentCEIst.OF_TipologiaApparato__c);
                                
                                if(CurrentCEIst.OF_CommercialElementName__c == 'CPE'){
                                    if(listino.OF_TipologiaApparato__c == CurrentCEIst.OF_TipologiaApparato__c){
                                        ListinoList1.add(listino);
                                        //system.debug('DG_OF_UtilitiesServiziAttivi - ho trovato un listino non default');
                                        break;
                                    }else{
                                        count++;
                                    }
                                }else{
                                    ListinoList1.add(listino);
                                    break;
                                }
                            }else{
                                count++;
                            }
                            //Se il listino è di default lo memorizzo
                            if( listino.OF_ListinoDefault__c == true)
                                listinoDiDefault = listino;
                        
                         }else{
                             count++;
                             //Se il listino è di default lo memorizzo
                             if( listino.OF_ListinoDefault__c == true)
                                listinoDiDefault = listino;
                        }
                    }
                    if(count == listx.size())
                    {
                        /**Controllo per evitare la mancanza in fase di Configurazione del listino di default**/
                        if(listinoDiDefault != null) 
                            ListinoList1.add(listinoDiDefault);
                    }
                    CEListMap1.put(idCE,ListinoList1);
                    //system.debug('DG_OF_UtilitiesServiziAttivi - CEListMap1: ' + CEListMap1);
                }
                OrdCEListMap1.put(idorder,CEListMap1);
                //system.debug('DG_OF_UtilitiesServiziAttivi - OrdCEListMap1: ' + OrdCEListMap1);
            }
            if(OrdCEListMap1.size() > 0){
                //system.debug('DG_OF_UtilitiesServiziAttivi - OrdCEListMap1: ' + OrdCEListMap1);
                return OrdCEListMap1;
            }
            else
                return null;
            /***********END scelta listino**************/
        }catch(Exception e )
        {
        OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesServiziAttivi','Method: CEListini','Exception:' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());           
                return null;

        }
    }
    
    //Metodo che associa i CEIstanziati sotto il case all'asset e li porta in stato attivo
    public void AttivazioneCE(map<id,map<id,list<OF_Listino__c>>> OrderCEListini, Map<ID,ID> OrderAsset, Map<ID,Asset> MapAsset)
    {
        try{
            List<OF_CommercialElementIstanziato__c> listaCEIst = new List<OF_CommercialElementIstanziato__c>();
            
            //Mappa tra ID e CommercialELementIstanziato
            map<Id,OF_CommercialElementIstanziato__c> mapCE = CEMap(OrderCEListini);
            
            for( ID idOrder : OrderCEListini.keyset() )
            {
                set<ID> listX = OrderCEListini.get(idOrder).keyset();
    
                for( id CEID : listX )
                {
                    id AssID = OrderAsset.get(idOrder);
                    mapCE.get(CEID).OF_Asset__c = AssID;
                    mapCE.get(CEID).OF_Stato__c = 'Attivo';
                    mapCE.get(CEID).OF_IDRisorsa__c = MapAsset.get(AssID).EOF_ID_Risorsa__c;
                    mapCE.get(CEID).OF_DataAttivazione__c =OF_SA_GE_Utils.slSFOLOResp.lastModifiedDate;
                    if(mapCE.get(CEID).RecordTypeId==OF_SA_GE_Utils.rtMap.get('OF_CPE')) {
                    	mapCE.get(CEID).OF_CPE__c=mapCE.get(CEID).OF_Asset__c;
					}
					else if(mapCE.get(CEID).RecordTypeId==OF_SA_GE_Utils.rtMap.get('CPE_Passivi')){
						mapCE.get(CEID).OF_CPEPassivi__c=mapCE.get(CEID).OF_Asset__c;
					}
					else if(mapCE.get(CEID).RecordTypeId==OF_SA_GE_Utils.rtMap.get('OF_VLAN')) {
						mapCE.get(CEID).OF_VLAN__c=mapCE.get(CEID).OF_Asset__c;
					}	
					else if(mapCE.get(CEID).RecordTypeId==OF_SA_GE_Utils.rtMap.get('OF_ServiziAggiuntivi')) {
						mapCE.get(CEID).OF_ServiziAggiuntivi__c=mapCE.get(CEID).OF_Asset__c;
					}
					else if(mapCE.get(CEID).RecordTypeId==OF_SA_GE_Utils.rtMap.get('OF_Standard')) {
						mapCE.get(CEID).OF_CEStandard__c=mapCE.get(CEID).OF_Asset__c;
					}
                    listaCEIst.add(mapCE.get(CEID));
                }
             }
            system.debug('DG_AttivazioneCE - listaCEIst: ' + listaCEIst);
            if( listaCEIst.size()>0) update listaCEIst;
            
        }catch( Exception e )
            {
            OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesCreazioneAsset','Method: AttivazioneCE','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
            }
    }
    
    //Metodo che restituisce una mappa tra ID_CommercialElementIstanziato e CommercialElementIstanziato
    public map<Id,OF_CommercialElementIstanziato__c> CEMap(map<id,map<id,list<OF_Listino__c>>> OrderCEListini)
    {
        try{
            List<OF_CommercialElementIstanziato__c> listaCEIst = new List<OF_CommercialElementIstanziato__c>();
            
            set<id> setID = new set<id>();
            
            for( ID idOrder : OrderCEListini.keyset() )
            {
                setID.addall(OrderCEListini.get(idOrder).keyset());
            }
            
            //system.debug('DG_AttivazioneCE - setID: ' + setID);
            
            map<Id,OF_CommercialElementIstanziato__c> mapCE = new map<Id,OF_CommercialElementIstanziato__c>([select id, OF_Stato__c, OF_Asset__c,recordtypeId from OF_CommercialElementIstanziato__c where id IN: setID]);
            
            //system.debug('DG_AttivazioneCE - mapCE: ' + mapCE);
            
            return mapCE;
            
        }catch( Exception e )
        {
        OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesCreazioneAsset','Method: CEMap','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());       
            return null;
        }
    }    
    
    /****Creato 01_06_2017***************/
    /**********Metodo ad hoc che serve per ritornare un strutture dove per ogni Ordine
               ho una mappa tra idListino e lista di CEIstanziati che fanno riferimento a quel listino.
               Serve per creare n-PriceBookEntry quando si chiama il metodo CreazionePriceBookEntry_Attivi
    **/
    public  Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> getMultipleCEPerListino(map<id,map<id,list<OF_Listino__c>>> idOrderIdCEListini)
    {
      
      try{
        
            Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> idOrderIDListinoCE =
            new Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>>();
            
            map<id,OF_CommercialElementIstanziato__c> idCE_objCE = CEMap(idOrderIdCEListini);
           
            for( ID idOrder : idOrderIdCEListini.keySet() )
            {
                map<id,list<OF_Listino__c>> idCEListini = idOrderIdCEListini.get(idOrder);
                map<Id,List<OF_CommercialElementIstanziato__c>> idListinoCE = new map<Id,List<OF_CommercialElementIstanziato__c>>();
                
                    for( ID idCE : idCEListini.keySet() )
                    {
                            list<OF_Listino__c> listini = idCEListini.get(idCE);
                            
                            for( OF_Listino__c objListino : listini)
                            {
                                if( idListinoCE.containsKey( objListino.Id))
                                {
                                    List<OF_CommercialElementIstanziato__c> listaCEIst = idListinoCE.get(objListino.Id);
                                    listaCEIst.add( idCE_objCE.get( idCE ) );
                                    idListinoCE.put( objListino.Id , listaCEIst );
                                }else{
                                    List<OF_CommercialElementIstanziato__c> listaCEIst =
                                    new List<OF_CommercialElementIstanziato__c>();
                                    
                                    listaCEIst.add( idCE_objCE.get( idCE ) );
                                    idListinoCE.put( objListino.Id , listaCEIst );
                                }
                            }
                    }
                         idOrderIDListinoCE.put( idOrder , idListinoCE );
                    }
                       //system.debug('OSCRM OF_UtilitiesServiziAttivi - getMultipleCEPerListino : '+ idOrderIDListinoCE);
                    return idOrderIDListinoCE;
                
          }catch( Exception e )
          {
            OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesServiziAttivi','Method: getMultipleCEPerListino','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());       
            return null;
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
                      
                      listaCatalogoProdotti = mappaOLO.get( orderID.get(ido).AccountId ).CataloghiProdottiOlo__r;
                      set<String> CatalogoProdottiList = new set<String>();
                      
                      for( OF_CatalogoApparati__c cat : listaCatalogoProdotti)
                      {
                        
                        CatalogoProdottiList.add( cat.OF_TipologiaApparato__c.toUpperCase());
                      }
                      
                     ordiniCatalogoProdottiOLO.put( ido, CatalogoProdottiList );
                  }
                  //system.debug('OSCRM getOrderCatalogoProdottiOLO ordiniCatalogoProdottiOLO:'+ordiniCatalogoProdottiOLO);    
                 
                  return ordiniCatalogoProdottiOLO;
           }catch(Exception e )
               {
                  OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: getOrderCatalogoProdottiOLO',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                return null;
               }
     }


   //Modifica 19_06_2017
   public Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> FilterCEAttiviCessazioneCPE (Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> TheMap, map<id,OF_listino__c> listOFListino)
   {
   	
   	try{
            
            Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> FilterMap = new Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>>();
            Map<ID,List<OF_CommercialElementIstanziato__c>> filter1 = new Map<ID,List<OF_CommercialElementIstanziato__c>>();
            
             //system.debug('DG_OF_UtilitiesServiziAttivi -TheMap.keyset(): ' + TheMap.keyset());
             //system.debug('DG_OF_UtilitiesServiziAttivi -TheMap: ' + TheMap);
            
            for(id idOrder : TheMap.keyset())
            {
                for(id idList : TheMap.get(idOrder).keyset())
                {
                    OF_Listino__c currentList = listOFListino.get(idList);
                    string strBE = currentList.OF_ServizioBillingElement__r.OF_BillingElement__r.name;
                    //system.debug('DG_OF_UtilitiesServiziAttivi -strBE: ' + strBE);
                    List<OF_CommercialElementIstanziato__c> filter2 = new List<OF_CommercialElementIstanziato__c>();
                    
                    for(OF_CommercialElementIstanziato__c CEIst : TheMap.get(idOrder).get(idList))
                    {
                       
                        if( (CEIst.recordtype.name == 'CPE') &&
                            (strBE == 'Contributo ritiro'))
                            {
                                filter2.add(CEIst);
                            }
                   }
                    if(filter2.size() > 0){
                        filter1.put(idList,filter2);
                        //system.debug('DG_OF_UtilitiesServiziAttivi - filter1: ' + filter1);
                    }
                }
                if(filter1.size() > 0){
                    FilterMap.put(idOrder,filter1);
                    //system.debug('DG_OF_UtilitiesServiziAttivi - FilterMap: ' + FilterMap);
                }
            }
            //system.debug('DG_OF_UtilitiesServiziAttivi - FilterMap: ' + FilterMap);
            return FilterMap;
            
        }catch(Exception e )
        {
        OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesServiziAttivi','Method: FilterCEAttivi','Exception:' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());           
                return null;

        }
   	
   	return null;
   }

}
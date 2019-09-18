public class PO_UtilitiesPortalino {
    
public Map<Id,PriceBook2> mappaIDPricebook2Obj;
//14/07/2017 DG modificata mappa
//public Map<ID,ID> mappaAssetIDOrderID = new Map<ID,ID>();
public Map<ID,order> mappaAssetIDOrder = new Map<ID,order>();
//CRM 30_08_2017
public Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
public map<id, opportunity> MappaAssetOpportunity = new map<id, opportunity>();
public map<id, OpportunityLineItem> MapOppoLineItem = new map<id, OpportunityLineItem>();
Map<String,Id> mapRType;

public PO_UtilitiesPortalino(){
	mapRType= new Map<String,Id>();
    for(recordtype rt : [select id,developername from recordtype]){
    	mapRType.put(rt.developername,rt.id);
    }
}

public void PO_CreatePBE_Portalino( List<Order> listaOrdini ,String tipologiaServizioPortalino)
{
    system.debug('OSCRM_PO_CreatePBE_Portalino listaOrdini:'+listaOrdini);
    
    /*
    Id RecordType_ServiziPassivi = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
    Id RecordType_ServiziAttivi = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
    Id RecordType_AssetPortalino = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('P2P').getRecordTypeId();
    Id RecordType_AssetFiberLink = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Fiber Link').getRecordTypeId();
    Id RecordType_AssetFiberLease = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Fiber Lease').getRecordTypeId();
	
	
    
    
    List<Asset> listAsset = OF_IstanziazioneAsset.CreazioneAssetFromProcess(listaOrdini,
                                                                            RecordType_ServiziPassivi,
                                                                            RecordType_ServiziAttivi,
                                                                            RecordType_AssetPortalino,
                                                                            RecordType_AssetFiberLink,
                                                                            RecordType_AssetFiberLease
                                                                           );
   */
   List<Asset> listAsset = OF_IstanziazioneAsset.CreazioneAssetFromProcess(listaOrdini,
                                                                            mapRType.get('OF_GPONPassiva'),
                                                                            mapRType.get('OF_OpenStream'),
                                                                            mapRType.get('P2P'),
                                                                            mapRType.get('Fiber_Link'),
                                                                            mapRType.get('Fiber_Lease')
                                                                           );
    //modifiche per asset da portalino
    if(listAsset.size()>0){
    	PO_ServiziFattibilita_Controller.createAssetId=listAsset[0].Id;
    }
    system.debug('OSCRM_PO_CreatePBE_Portalino listAsset: '+listAsset);
    
    //27/07/2017 DG Aggiunto metodo per associare all'ordine l'asset
    AssociazioneOrderAsset( listAsset, listaOrdini);
    
    system.debug('OSCRM 30_08 tipologiaServizioPortalino:'+ tipologiaServizioPortalino );
    
    AssociazioneTRATTEAsset( listAsset );
    
    //30_08_2017
    if( tipologiaServizioPortalino == 'FiberLease')
    {
        insert createCEFiberLease(listAsset, mappaAssetIDOrderFiberLease );
        return;
    }
    
	//Map<ID,Opportunity> mappaAssetIDOpportunity = getOrderIDOpportunityLineItem( listaOrdini );
    map<id, map<id,pricebook2>> mappaAssetOppLin = getAssetOppLineItem( listaOrdini );
    //system.debug('PO_UtilitiesPortalino_PO_CreatePBE_Portalino mappaAssetIDOpportunity: '+mappaAssetIDOpportunity);
    system.debug('PO_UtilitiesPortalino_PO_CreatePBE_Portalino mappaAssetOppLin: '+mappaAssetOppLin);
    Method_CreatePBE1( mappaAssetOppLin , tipologiaServizioPortalino );
          
}

public map<id, map<id,pricebook2>> getAssetOppLineItem( List<Order> listaOrdini )
{
    Map<ID,ID> mappaAssetIDOpportunityID = new Map<ID,ID>();
    Set<ID> opportunityID = new Set<ID>();    
    
    for( Order o : listaOrdini)
    {
        mappaAssetIDOpportunityID.put( o.OF_Asset__c , o.PO_Opportunity__c );
        opportunityID.add( o.PO_Opportunity__c);
        //14/07/2017 DG modificata mappa
        mappaAssetIDOrder.put( o.OF_Asset__c , o);
    }
    
    system.debug('PO_UtilitiesPortalino_getAssetOppLineItem mappaAssetIDOpportunityID: '+mappaAssetIDOpportunityID );
    system.debug('PO_UtilitiesPortalino_getAssetOppLineItem mappaAssetIDOrder: '+mappaAssetIDOrder );
	
    Map<ID,Opportunity> mappaOpportunity = new Map<ID,Opportunity>(
                                           [select id,PriceBook2.Id,Pricebook2.PO_Commercial_element__c,
                                            PriceBook2.PO_Commercial_element__r.Name,PO_Offerta_totale__r.PO_Durata_affitto__c,
                                                      (select id,name,Product2.Id,Product2.OF_ListinoCustom__c,Quantity,UnitPrice,
                                                              Subtotal,TotalPrice,ListPrice,Discount,Product2.PO_Anni_Fiber_Link__c
                                                              from opportunityLineItems
                                                       )
                                            from opportunity 
                                            where id IN : opportunityID 
                                            ]);
    system.debug('PO_UtilitiesPortalino_getAssetOppLineItem mappaOpportunity : '+mappaOpportunity );

	map<id,id> PriceBoSet = new map<id,id>();
	map<id,list<opportunityLineItem>> MapAssOppLin = new map<id,list<opportunityLineItem>>();
	MapOppoLineItem = new map<id,OpportunityLineItem>();
	
	for( ID assetID : mappaAssetIDOpportunityID.keyset())
	{
        ID oppID = mappaAssetIDOpportunityID.get(assetID);
        Opportunity opp = mappaOpportunity.get(oppID);
        system.debug('PO_UtilitiesPortalino_getAssetOppLineItem opp: '+opp);
		MappaAssetOpportunity.put(assetID,opp);
		
		list<opportunityLineItem> OppLineItemList = opp.opportunityLineItems;
        system.debug('PO_UtilitiesPortalino_getAssetOppLineItem OppLineItemList: '+OppLineItemList);
		for(opportunityLineItem OppLinIte : OppLineItemList)
		{
			PriceBoSet.put(OppLinIte.Product2.OF_ListinoCustom__c,OppLinIte.id);
			MapOppoLineItem.put(OppLinIte.id, OppLinIte);
		}
		MapAssOppLin.put(assetid,OppLineItemList);
    }
	
    system.debug('PO_UtilitiesPortalino_getAssetOppLineItem PriceBoSet: '+PriceBoSet);
    system.debug('PO_UtilitiesPortalino_getAssetOppLineItem MapAssOppLin: '+MapAssOppLin);
	/*
	list<pricebook2> PricebookList = [select id,Name,PO_Commercial_element__c,PO_Commercial_element__r.Name,isActive,OF_Listino__c
									  from PriceBook2
									  where OF_Listino__c IN: PriceBoSet.keySet()];
	
	system.debug('PO_UtilitiesPortalino_getAssetOppLineItem PricebookList: '+PricebookList);
	*/
	list<pricebook2> PricebookList=new list<pricebook2>();
	for(OF_Listino__c l  : [select Id,Name from OF_Listino__c where id in: PriceBoSet.keyset()]){
		Pricebook2 pb = new Pricebook2();
		pb.OF_Listino__c=l.Id;
		pb.name=l.name;
		pb.isActive=true;
		PricebookList.add(pb);  
	}
	if(PricebookList.size()>0){
		insert PricebookList;
	}
	map<id,Pricebook2> MapOppLinPriceBo = new map<id,Pricebook2>();

	for(pricebook2 pric : PricebookList)
	{
		id OppLinID = PriceBoSet.get(pric.OF_Listino__c);
		MapOppLinPriceBo.put(OppLinID,pric);		
	}
	
	system.debug('PO_UtilitiesPortalino_getAssetOppLineItem MapOppLinPriceBo: '+MapOppLinPriceBo);
	
	map<id, map<id,pricebook2>> mapAssOppPric = new map<id, map<id,pricebook2>>();
	for(id AssetID : MapAssOppLin.keyset())
	{
		map<id,pricebook2> MappaTemp = new map<id,pricebook2>();
		system.debug('PO_UtilitiesPortalino_getAssetOppLineItem MapAssOppLin.get(AssetID): '+MapAssOppLin.get(AssetID));
		for(opportunityLineItem OppLin : MapAssOppLin.get(AssetID))
		{
			system.debug('PO_UtilitiesPortalino_getAssetOppLineItem OppLin: '+OppLin);
			pricebook2 pr = MapOppLinPriceBo.get(OppLin.id);
            system.debug('PO_UtilitiesPortalino_getAssetOppLineItem pr: '+pr);
			MappaTemp.put(OppLin.id,pr);
			system.debug('PO_UtilitiesPortalino_getAssetOppLineItem MappaTemp: '+MappaTemp);
		}
		mapAssOppPric.put(AssetID,MappaTemp);
	}
	
    system.debug('PO_UtilitiesPortalino_getAssetOppLineItem mapAssOppPric: '+mapAssOppPric);
    return mapAssOppPric;    
}

public void Method_CreatePBE1( map<id, map<id,pricebook2>> mappaAssetOppLin , String tipologiaServizioPortalino){
	List<PriceBook2> listPriceBook2Clonate = new List<PriceBook2>();
	Map<ID,Map<ID,PriceBook2>> AssetPriceBookEntryClone = new Map<ID,Map<Id,PriceBook2>>();
	Map<ID,OF_CommercialElementIstanziato__c> assetIDCEIst= new Map<ID,OF_CommercialElementIstanziato__c>();
	
	for( ID AssetID : mappaAssetOppLin.keyset()){
		Opportunity opp = MappaAssetOpportunity.get( AssetID );
		
		assetIDCEIst.put(AssetID,createCEPortalino( AssetID , opp.priceBook2.PO_Commercial_element__c, mappaAssetIDOrder) );
	
		/**Clonazione Pricebook2**/
		/*
		Map<ID,PriceBook2> mapPriceProd= mappaAssetOppLin.get(AssetID);
		
		for(ID ix2 : mapPriceProd.keyset())
        {
            system.debug('PO_UtilitiesPortalino_Method_CreatePBE1 mapPriceProd.get(ix2): '+mapPriceProd.get(ix2));
            //12/10/2017 - Aggiunta condizione per non far andare in errore quando non c'è la procebook
            if(mapPriceProd.get(ix2) != null)
            {
                if( AssetPriceBookEntryClone.containsKey(AssetID)) 
                {
                    Map<Id,PriceBook2> PriceBookEntryClone = new Map<Id,PriceBook2>();
                    PriceBookEntryClone = AssetPriceBookEntryClone.get(AssetID);
                    PriceBookEntryClone.put(ix2,mapPriceProd.get(ix2).clone());
                    AssetPriceBookEntryClone.put(AssetID,PriceBookEntryClone);
                }else{
                    Map<Id,PriceBook2> PriceBookEntryClone = new Map<Id,PriceBook2>();
                    PriceBookEntryClone.put(ix2,mapPriceProd.get(ix2).clone());
                    AssetPriceBookEntryClone.put(AssetID,PriceBookEntryClone);
                }
            } 
		}
		system.debug('PO_UtilitiesPortalino_Method_CreatePBE1 AssetPriceBookEntryClone: '+AssetPriceBookEntryClone);
		
		if( AssetPriceBookEntryClone != null && AssetPriceBookEntryClone.size() > 0 )
		{
			for( ID ix : AssetPriceBookEntryClone.keyset() )
			{
				listPriceBook2Clonate.addAll(AssetPriceBookEntryClone.get(ix).values());
			}
		}
		*/
		/**END Clonazione Pricebook2**/
	}
	/**Insert Commercial Element Istanziati**/
	system.debug('PO_UtilitiesPortalino_Method_CreatePBE1 assetIDCEIst: '+assetIDCEIst);
	if( assetIDCEIst.size()>0) insert assetIDCEIst.values();
	
	/**Insert Pricebook2 clonate**/
	/*
	system.debug('PO_UtilitiesPortalino_Method_CreatePBE1 listPriceBook2Clonate: '+listPriceBook2Clonate);
	if( listPriceBook2Clonate.size()>0) insert listPriceBook2Clonate;
    */
	
	/**Creazione PriceBookEntry**/
    List<PriceBookEntry> listPriceBookEntry = new List<PriceBookEntry>();
	if( tipologiaServizioPortalino == 'FiberLink')
	{
		createBE_FiberLink1(mappaAssetOppLin, assetIDCEIst);
		return;
	}else{
		for( ID AssetID : mappaAssetOppLin.keyset())
		{
			Map<ID,PriceBook2> mapPriceProd = mappaAssetOppLin.get(AssetID);
			
			for(ID ix2 : mapPriceProd.keyset()){
				if(mapPriceProd.get(ix2) != null){
					OpportunityLineItem opplineitem = MapOppoLineItem.get(ix2);
					
					PriceBookEntry pbE = new PricebookEntry();
					pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
					pbE.UnitPrice = opplineitem.UnitPrice;
					pbE.Product2Id = opplineitem.Product2Id;
					pbE.OF_Order__c =  mappaAssetIDOrder.get(assetID).id;
					pbE.OF_Asset__c = AssetID;
					pbE.OF_CommercialElementIstanziato__c = assetIDCEIst.get( AssetID ).Id;
					
					listPriceBookEntry.add(pbE);
				}
			}
		}
		}
		system.debug('PO_UtilitiesPortalino_Method_CreatePBE1 listPriceBookEntry: '+listPriceBookEntry);
	if(listPriceBookEntry.size() > 0 && listPriceBookEntry != null){
		insert listPriceBookEntry;
	}
	/**END Creazione PriceBookEntry**/
}

public OF_CommercialElementIstanziato__c createCEPortalino( ID assetID , ID CECatalogoId, Map<ID,order> mappaAssetIDOrder)
{
      
       Id RecordType_CEPortalino = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Portalino').getRecordTypeId();
    
       OF_CommercialElementIstanziato__c ceIst = new OF_CommercialElementIstanziato__c();
       
       ceIst.OF_CommercialElement__c = CECatalogoId;
       ceIst.OF_Asset__c = assetID;
       ceIst.RecordTypeId = RecordType_CEPortalino;
       //ceIst.OF_Stato__c = 'Attivo';
       //14/07/2017 DG Aggiunta data di attivazione
       //ceIst.OF_DataAttivazione__c = mappaAssetIDOrder.get(assetID).PO_DataAttivazioneOrdine__c;
       return ceIst;
}


public List<OF_CommercialElementIstanziato__c> createCEFiberLease( List<Asset> listAsset ,  Map<ID,order> mappaAssetIDOrder)
{
       
       Id RecordType_CEPortalino = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Portalino').getRecordTypeId();
       List<OF_CommercialElementIstanziato__c> listCEIst = new List<OF_CommercialElementIstanziato__c>();
      
       List<OF_CommercialElement__c> ListCECat = [select id,
                                                  (select id,name 
                                                   from CommercialElements__r
                                                  )
                                                  from OF_Servizio__c
                                                  where Name = 'Fiber Lease'].CommercialElements__r;
      Map<String,OF_CommercialElement__c> mapCECat = new Map<String,OF_CommercialElement__c>();
      
      for( OF_CommercialElement__c obj : ListCECat )
      {
          mapCECat.put( obj.Name , obj );
      }
        
      for( Asset ass : listAsset )
      {
         OF_CommercialElementIstanziato__c ceIst = new OF_CommercialElementIstanziato__c();
         
         ceIst.OF_CommercialElement__c = mapCECat.get( mappaAssetIDOrder.get( ass.Id ).Description).Id;
         ceIst.OF_Asset__c = ass.ID;
         ceIst.RecordTypeId = RecordType_CEPortalino;
         //ceIst.OF_Stato__c = 'Attivo';
         //14/07/2017 DG Aggiunta data di attivazione
         //ceIst.OF_DataAttivazione__c = mappaAssetIDOrder.get(ass.ID).PO_DataAttivazioneOrdine__c;
         //return ceIst;
         listCEIst.add( ceIst );
      }
      return listCEIst;
}
    
    //27/07/2017 DG Metodo per associare all'ordine l'asset
public void AssociazioneOrderAsset(List<Asset> listAsset,List<Order> TriggerNew)
{
        Map<ID,ID> assetOrder = new Map<ID,ID>();
        if( listAsset!=null && listAsset.size() > 0 )
         { 
             for( Asset ax : listAsset )
             {
                  assetOrder.put(ax.OF_OrdineID__c,ax.Id);
              }
          }
                 
         if( assetOrder!=null && assetOrder.size()>0)
         {
             for( Order or1 : TriggerNew)
             {
                 or1.OF_Asset__c = assetOrder.get(or1.Id);
                 system.debug('AssociazioneOrderAsset--> or1.OF_Asset__c: ' + or1.OF_Asset__c);
                 //CRM 30_08
                 if( or1.isFiberLease__c)mappaAssetIDOrderFiberLease.put( or1.OF_Asset__c , or1 );
              }
          }
     }

public void createBE_FiberLink1(Map<ID,Map<ID,PriceBook2>> AssetPriceBookEntryClone,
                                Map<ID,OF_CommercialElementIstanziato__c> assetIDCEIst
                              ) 
{
    List<PriceBookEntry> listPriceBookEntry = new List<PriceBookEntry>();
	for( ID AssetID : AssetPriceBookEntryClone.keyset())
	{
		Map<ID,PriceBook2> mapPriceProd = AssetPriceBookEntryClone.get(AssetID);
		Opportunity opp = MappaAssetOpportunity.get(AssetID);
		system.debug('PO_UtilitiesPortalino_createBE_FiberLink1 mapPriceProd: '+mapPriceProd);
        system.debug('PO_UtilitiesPortalino_createBE_FiberLink1 mapPriceProd.keyset(): '+mapPriceProd.keyset());
		for(ID ix2 : mapPriceProd.keyset())
		{
			if(mapPriceProd.get(ix2) != null){
	            system.debug('PO_UtilitiesPortalino_createBE_FiberLink1 MapOppoLineItem: '+MapOppoLineItem);
				OpportunityLineItem opplineitem = MapOppoLineItem.get(ix2);
	            system.debug('PO_UtilitiesPortalino_createBE_FiberLink1 opplineitem: '+opplineitem);
				
				/**Anno 1**/
				if( opp.PO_Offerta_totale__r.PO_Durata_affitto__c == 1 &&  
					opplineItem.Product2.PO_Anni_Fiber_Link__c == '1 Anno')
				{
					PriceBookEntry pbE = new PricebookEntry();
					pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
					pbE.UnitPrice = opplineitem.UnitPrice;
					pbE.Product2Id= opplineitem.Product2Id;
					pbE.OF_Order__c =  mappaAssetIDOrder.get(assetID).id;
					pbE.OF_Asset__c = AssetID;
					pbE.OF_CommercialElementIstanziato__c = assetIDCEIst.get( AssetID ).Id;
					
					listPriceBookEntry.add(pbE);
				}else
				/**Anno 2**/
				if( opp.PO_Offerta_totale__r.PO_Durata_affitto__c == 2 && 
					opplineItem.Product2.PO_Anni_Fiber_Link__c == '2 Anni')
				{
					PriceBookEntry pbE = new PricebookEntry();
					pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
					pbE.UnitPrice = opplineitem.UnitPrice;
					pbE.Product2Id= opplineitem.Product2Id;
					pbE.OF_Order__c =  mappaAssetIDOrder.get(assetID).id;
					pbE.OF_Asset__c = AssetID;
					pbE.OF_CommercialElementIstanziato__c = assetIDCEIst.get( AssetID ).Id;
	                    
	                listPriceBookEntry.add(pbE);  
				}else
				/**3 Anni**/
				if( opp.PO_Offerta_totale__r.PO_Durata_affitto__c == 3 && 
					opplineItem.Product2.PO_Anni_Fiber_Link__c == '3 Anni' ) 
				{
					PriceBookEntry pbE = new PricebookEntry();
					pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
					pbE.UnitPrice = opplineitem.UnitPrice;
					pbE.Product2Id= opplineitem.Product2Id;
					pbE.OF_Order__c =  mappaAssetIDOrder.get(assetID).id;
					pbE.OF_Asset__c = AssetID;
					pbE.OF_CommercialElementIstanziato__c = assetIDCEIst.get( AssetID ).Id;
					
					listPriceBookEntry.add(pbE);  
				}else
				/**X Anni**/
				if( opp.PO_Offerta_totale__r.PO_Durata_affitto__c > 3 && 
					opplineItem.Product2.PO_Anni_Fiber_Link__c == 'X Anni')
				{
					PriceBookEntry pbE = new PricebookEntry();
					pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
					pbE.UnitPrice = opplineitem.UnitPrice;
					pbE.Product2Id= opplineitem.Product2Id;
					pbE.OF_Order__c =  mappaAssetIDOrder.get(assetID).id;
					pbE.OF_Asset__c = AssetID;
					pbE.OF_CommercialElementIstanziato__c = assetIDCEIst.get( AssetID ).Id;
					
					listPriceBookEntry.add(pbE);    
				}
			}
		}
	}
	
	system.debug('PO_UtilitiesPortalino_createBE_FiberLink1 listPriceBookEntry: '+listPriceBookEntry);
	if( listPriceBookEntry.size() > 0 ) insert listPriceBookEntry;
}
    
//CRM 11/09/2017
public void AssociazioneTRATTEAsset(List<Asset> listaAsset)
{
        Map<Id,Id> CaseIdAssetId = new Map<Id,Id>();
    
        for( Asset ass : listaAsset )CaseIdAssetId.put(ass.OF_IDCaseAttivazione__c , ass.Id);
    
        

    
        List<Case> listaCase = [Select id,OF_Order__c,AssetId,
                                (select id, OF_AssetTratta__c, OF_Stato__c from Commercial_element_istanziati1__r )
                                from case
                                where id IN : CaseIdAssetId.keyset()];
    
        system.debug('11_09 listaCase:'+listaCase);
        List<OF_CommercialElementIstanziato__c> TratteTOUpdate = new List<OF_CommercialElementIstanziato__c>();    
    
        for( Case c : listaCase )
        {
            List<OF_CommercialElementIstanziato__c> listaCETratte = c.Commercial_element_istanziati1__r;
            ID AssetID = CaseIdAssetId.get( c.Id );
            
            for( OF_CommercialElementIstanziato__c ce : listaCETratte )
            {
                 ce.OF_AssetTratta__c = AssetID;
                 TratteTOUpdate.add(ce);
            }
            
        }
        
        system.debug('11_09 TratteTOUpdate:'+TratteTOUpdate);

        if( TratteTOUpdate.size() > 0 ) update TratteTOUpdate;
       
        return;
	}

}
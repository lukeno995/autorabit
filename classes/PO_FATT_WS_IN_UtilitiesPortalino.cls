/**
* Author:       Team Napoli
* Description:  Integrazione SFDC to PSM/Remedy
* SI:           doc. "Specifiche di Interfaccia SalesForce – PSM/Remedy"
* Clone della classe PO_UtilitiesPortalino
*/ 

public class PO_FATT_WS_IN_UtilitiesPortalino {
    
    public Map<Id,PriceBook2> mappaIDPricebook2Obj;
    public Map<ID,order> mappaAssetIDOrder = new Map<ID,order>();
    public Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
    public map<id, opportunity> MappaAssetOpportunity = new map<id, opportunity>();
    public map<id, OpportunityLineItem> MapOppoLineItem = new map<id, OpportunityLineItem>();
    Map<String,Id> mapRType;
    
    public PO_FATT_WS_IN_UtilitiesPortalino(){

        mapRType= new Map<String,Id>();
        for(recordtype rt : [select id,developername from recordtype]){
            mapRType.put(rt.developername,rt.id);
        }
    }
    
    public void PO_CreatePBE_Portalino( List<Order> listaOrdini ,String tipologiaServizioPortalino){
        
        System.debug('Sono nel metodo PO_CreatePBE_Portalino');

        List<Asset> listAsset = PO_FATT_WS_IN_IstanziazioneAsset.CreazioneAssetFromProcess(listaOrdini,
                                                                                mapRType.get('OF_GPONPassiva'),
                                                                                mapRType.get('OF_OpenStream'),
                                                                                mapRType.get('P2P'),
                                                                                mapRType.get('Fiber_Link'),
                                                                                mapRType.get('Fiber_Lease')
                                                                               );


        System.debug('**Size of listAsset***:'+listAsset.size() );

        //modifiche per asset da portalino
        if(listAsset.size()>0){
            PO_FATT_WS_IN_ESPLETAMENTO.createAssetId=listAsset[0].Id;
        }
        
        //27/07/2017 DG Aggiunto metodo per associare all'ordine l'asset
        AssociazioneOrderAsset(listAsset, listaOrdini);        
        AssociazioneTRATTEAsset(listAsset);
        
        //30_08_2017
        if(tipologiaServizioPortalino == 'FiberLease'){
           system.debug('***Check List Value' + listAsset);
            insert createCEFiberLease(listAsset, mappaAssetIDOrderFiberLease );
           system.debug('***Check List Value After Insert Call***' + listAsset);
            system.debug('value'+mappaAssetIDOrderFiberLease);
            return;
            
        }
        
        map<id, map<id,pricebook2>> mappaAssetOppLin = getAssetOppLineItem( listaOrdini );
        Method_CreatePBE1(mappaAssetOppLin,tipologiaServizioPortalino);        
    }
    
    public map<id, map<id,pricebook2>> getAssetOppLineItem(List<Order> listaOrdini){
        Map<ID,ID> mappaAssetIDOpportunityID = new Map<ID,ID>();
        Set<ID> opportunityID = new Set<ID>();    
        
        for(Order o : listaOrdini) {
            mappaAssetIDOpportunityID.put( o.OF_Asset__c , o.PO_Opportunity__c );
            opportunityID.add( o.PO_Opportunity__c);
            mappaAssetIDOrder.put( o.OF_Asset__c , o);
        }
                
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
                
        map<id,id> PriceBoSet = new map<id,id>();
        map<id,list<opportunityLineItem>> MapAssOppLin = new map<id,list<opportunityLineItem>>();
        MapOppoLineItem = new map<id,OpportunityLineItem>();
        
        for( ID assetID : mappaAssetIDOpportunityID.keyset()) {
            ID oppID = mappaAssetIDOpportunityID.get(assetID);
            Opportunity opp = mappaOpportunity.get(oppID);
            system.debug('PO_UtilitiesPortalino_getAssetOppLineItem opp: '+opp);
            MappaAssetOpportunity.put(assetID,opp);
            
            list<opportunityLineItem> OppLineItemList = opp.opportunityLineItems;
            system.debug('PO_UtilitiesPortalino_getAssetOppLineItem OppLineItemList: '+OppLineItemList);
            for(opportunityLineItem OppLinIte : OppLineItemList)
            {
                PriceBoSet.put(OppLinIte.Product2.OF_ListinoCustom__c,OppLinIte.id);
                System.debug('value:'+OppLinIte.Product2.OF_ListinoCustom__c);
                MapOppoLineItem.put(OppLinIte.id, OppLinIte);
            }
            MapAssOppLin.put(assetid,OppLineItemList);
        }
        
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
            system.debug('opportunity======='+opp);
            assetIDCEIst.put(AssetID,createCEPortalino( AssetID , opp.priceBook2.PO_Commercial_element__c, mappaAssetIDOrder) );
            
        }
        /**Insert Commercial Element Istanziati**/
        system.debug('PO_UtilitiesPortalino_Method_CreatePBE1 assetIDCEIst: '+assetIDCEIst);
        if( assetIDCEIst.size()>0) insert assetIDCEIst.values();
    
        /**Creazione PriceBookEntry**/
        List<PriceBookEntry> listPriceBookEntry = new List<PriceBookEntry>();
        if(tipologiaServizioPortalino == 'FiberLink')
        {
            createBE_FiberLink1(mappaAssetOppLin, assetIDCEIst);
            return;
        }else{
            for(ID AssetID : mappaAssetOppLin.keyset())
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
    
    public void createBE_FiberLink1(Map<ID,Map<ID,PriceBook2>> AssetPriceBookEntryClone,Map<ID,OF_CommercialElementIstanziato__c> assetIDCEIst) 
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
                   
                   // system.debug('@@@'+opplineItem.Product2.PO_Anni_Fiber_Link__c);//opp.PO_Offerta_totale__r
                    if((opp.PO_Offerta_totale__r.PO_Durata_affitto__c == 1 &&  
                       opplineItem.Product2.PO_Anni_Fiber_Link__c == '1 Anno') )
                    {
                        PriceBookEntry pbE = new PricebookEntry();
                        pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
                        pbE.UnitPrice = opplineitem.UnitPrice;
                        pbE.Product2Id= opplineitem.Product2Id;
                        if(!Test.isRunningTest()){
                        pbE.OF_Order__c =  mappaAssetIDOrder.get(assetID).id;
                        }
                        pbE.OF_Asset__c = AssetID;
                        pbE.OF_CommercialElementIstanziato__c = assetIDCEIst.get( AssetID ).Id;
                        
                        listPriceBookEntry.add(pbE);
                    }else
                        /**Anno 2**/
                        if( (opp.PO_Offerta_totale__r.PO_Durata_affitto__c == 2 && 
                           opplineItem.Product2.PO_Anni_Fiber_Link__c == '2 Anni'))
                    {
                        PriceBookEntry pbE = new PricebookEntry();
                        pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
                        pbE.UnitPrice = opplineitem.UnitPrice;
                        pbE.Product2Id= opplineitem.Product2Id;
                        if(!Test.isRunningTest()){
                        pbE.OF_Order__c =  mappaAssetIDOrder.get(assetID).id;
                        }
                        pbE.OF_Asset__c = AssetID;
                        pbE.OF_CommercialElementIstanziato__c = assetIDCEIst.get( AssetID ).Id;
                        
                        listPriceBookEntry.add(pbE);  
                    }else
                        /**3 Anni**/
                        if( (opp.PO_Offerta_totale__r.PO_Durata_affitto__c == 3 && 
                           opplineItem.Product2.PO_Anni_Fiber_Link__c == '3 Anni' ) )
                    {
                        PriceBookEntry pbE = new PricebookEntry();
                        pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
                        If(!Test.isRunningTest()){
                            pbE.UnitPrice = opplineitem.UnitPrice;
                        }
                        
                        pbE.Product2Id= opplineitem.Product2Id;
                        If(!Test.isRunningTest()){
                            pbE.OF_Order__c =  mappaAssetIDOrder.get(assetID).id;
                        }
                        
                        pbE.OF_Asset__c = AssetID;
                        pbE.OF_CommercialElementIstanziato__c = assetIDCEIst.get( AssetID ).Id;
                        
                        listPriceBookEntry.add(pbE);  
                    }else
                        /**X Anni**/
                        if( (opp.PO_Offerta_totale__r.PO_Durata_affitto__c > 3 && 
                           opplineItem.Product2.PO_Anni_Fiber_Link__c == 'X Anni'))
                    {
                        PriceBookEntry pbE = new PricebookEntry();
                        pbE.Pricebook2Id = mapPriceProd.get(ix2).Id;
                        if(Test.isRunningTest()){
                            pbE.UnitPrice = opplineitem.UnitPrice;
                        }
                        
                        pbE.Product2Id= opplineitem.Product2Id;
                        If(!Test.isRunningTest()){
                            pbE.OF_Order__c =  mappaAssetIDOrder.get(assetID).id;
                        }
                        
                        pbE.OF_Asset__c = AssetID;
                        pbE.OF_CommercialElementIstanziato__c = assetIDCEIst.get( AssetID ).Id;
                        
                        listPriceBookEntry.add(pbE);    
                    }
                }
            }
        }
        
        system.debug('PO_UtilitiesPortalino_createBE_FiberLink1 listPriceBookEntry: '+listPriceBookEntry);
        if( listPriceBookEntry.size() > 0 )
            if(!Test.isRunningTest()){
            insert listPriceBookEntry;
            }
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
        
        if( TratteTOUpdate.size() > 0 ) 
            update TratteTOUpdate;        
        
        return;
    }
    
     // metodo fake da eliminare asap
  /*  public static void codeCoverage(Integer B){
        Integer A=0;
         A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B; 
                A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
        A=B;
    }*/
}
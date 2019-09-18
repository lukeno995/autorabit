trigger OF_CreazioneAsset on Order(after insert,before update){
  /*
  system.debug('\n---1.Dentro trigger update---\n');
 
  try{
 
     Map<string,Order> IDRisorsa = new Map<string,Order>();
     List<Asset> AssetOrderCess = new List<Asset>();
     Map<ID,Order> mappaIDOrder = new Map<ID,Order>();
     Map<ID,ID> ContractIdFromOrderCessazione = new Map<ID,ID>();
     Integer type;     
/*****************************Disattivazione Billing Elements*******************************************
     if( Trigger.isInsert && Trigger.isAfter )
     {
           system.debug('DG Siamo dentro OF_CreazioneAsset isAfter');
           for( Order ord : Trigger.new )
           {
              mappaIDOrder.put(ord.Id,ord);
                if( ord.Status == 'Aperto' && ord.OF_Type__c == 'OUTORDER')
                {
                    IDRisorsa.put(ord.OF_IDRisorsa__c,ord);  
                    type = 1;           
                }
           }
           
           system.debug('DG - IDRisorsa: ' + IDRisorsa);
           
           if(IDRisorsa.size() > 0 )
           {
              AssetOrderCess = [SELECT id, status, OF_Trigger__c,OF_Contract__c,OF_OrdineID__c,EOF_ID_Risorsa__c FROM asset WHERE EOF_ID_Risorsa__c IN : IDRisorsa.keyset()];
           }
           
           system.debug('DG - AssetOrderCess: ' + AssetOrderCess);
          
           if(AssetOrderCess.size() > 0 )
           {
              OF_UtilitiesCreazioneAsset.AggiornamentoDisattivazioneBE(AssetOrderCess,IDRisorsa);
           }
           
           Map<ID,ID> assetOrderCessazione = new Map<ID,ID>();
           system.debug('OS_MappaIDOrder-->'+mappaIDOrder);
           for( Asset ass : AssetOrderCess)
           {
              String str = ass.OF_OrdineID__c;
              Id i = Id.valueOf(str);
              // ID id = ID.valueOf(ass.OF_OrdineID__c);
              system.debug('OS_Trigger.new  OF_OrdineID : '+i);
              ContractIdFromOrderCessazione.put(i,ass.OF_Contract__c);
              assetOrderCessazione.put(i,ass.Id);
           }
        
           
           system.debug('OS_Trigger getMappaOrder/ContractIdFromOrderCessazione'+ContractIdFromOrderCessazione);
           system.debug('OS_Trigger getMappaOrder/ContractIdFromOrderCessazione'+mappaIDOrder);
           
           if( ContractIdFromOrderCessazione != null && ContractIdFromOrderCessazione.size() > 0 )
           {
           /*Map<ID,Map<ID,PriceBook2>> PriceProductMapCessazione = OF_UtilitiesCreazioneAsset.getMappaOrder(ContractIdFromOrderCessazione,mappaIDOrder,type); 
           
           system.debug('stepOrlando:PriceProductMap type = 1 '+PriceProductMapCessazione);
           system.debug('stepOrlando:assetOrderCessazione type = 1' +assetOrderCessazione);
           
                if( PriceProductMapCessazione != null && PriceProductMapCessazione.size()>0)
                {
                 OF_UtilitiesCreazioneAsset.CreazionePriceBookEntry(PriceProductMapCessazione,assetOrderCessazione);
                }*
           }
               
        
        }
        /*******************************************************************************************************/ 
        
        
        /**Caso di Update**
        if(Trigger.isUpdate){
        
          List<Contract> ContractOnOrder = new List<Contract>();
          Map<ID,ID> ContractIdFromOrder = new Map<ID,ID>();
          Map<ID,List<Order>> idContrOrder = new Map<ID,List<Order>>();
          List<OF_Listino__c> listinoList = new List<OF_Listino__c>();
          List<Asset> listAsset = new List<Asset>();
          
          /**Update status Order = 'Chiuso' ed Esito == 'KO'**
          for(Order o :Trigger.new)
          {   
              /*DG Commentato - viene valorizzato nel trigger OF_ManageOrderFromCase
                o.OF_DataEsito__c = Date.Today();*
              mappaIDOrder.put(o.Id,o); 
              if( (Trigger.oldMap.get(o.Id).Status != 'Chiuso') && ( o.Status == 'Chiuso' && o.OF_Esito__c == 'OK') &&(o.OF_Type__c == 'INORDER') )
               {
                  //system.debug('DG - attivazione: ' + o.OF_Type__c);
                  system.debug('OSCRM attivazione:'+o.OF_Type__c);
                  type = 0;
                  ContractIdFromOrder.put(o.Id,o.ContractId);
                  /**Modifica per processare più Ordini che hanno lo stesso contratto**
                  if( idContrOrder.containsKey(o.ContractId) )
                  {
                      List<Order> x = idContrOrder.get(o.ContractId);
                      x.add(o);
                      idContrOrder.put(o.ContractId,x);
                  }else
                  {
                      idContrOrder.put(o.ContractId,new List<Order>{o});
                  } 
        
               }
               
               if( (Trigger.oldMap.get(o.Id).Status != 'Chiuso') && 
                   ( o.Status == 'Chiuso' && o.OF_Esito__c == 'OK') &&
                   (o.OF_Type__c == 'OUTORDER')
                ){
                    //system.debug('DG - cessazione: ' + o.OF_Type__c);
                    IDRisorsa.put(o.OF_IDRisorsa__c,o);
                    
                    }
          }
          
            /*******************Start Cessazione****************************************** 
            //system.debug('DG - IDRisorsa: ' + IDRisorsa);
            
            if(IDRisorsa.size() > 0 ){
              AssetOrderCess = [SELECT id, status, OF_Trigger__c,OF_Contract__c,OF_OrdineID__c,EOF_ID_Risorsa__c FROM asset WHERE EOF_ID_Risorsa__c IN : IDRisorsa.keyset()];
            }
            
            //system.debug('DG - AssetOrderCess: ' + AssetOrderCess);
            if(AssetOrderCess.size() > 0 ){
             OF_UtilitiesCreazioneAsset.AggiornamentoAsset(AssetOrderCess,IDRisorsa);
            }
          
          
          /***********************************Orlando Sinademaj ATTIVAZIONE**********************************
          if( ContractIdFromOrder.size() > 0 )
          {
                ContractOnOrder = [SELECT Id,OF_IdContratto__c,StartDate,AccountId 
                                   FROM Contract WHERE Id IN : ContractIdFromOrder.values()];
          }
          //system.debug('OS: Trigger ContractOnOrder.size(): '+ContractOnOrder.size());
          if(ContractOnOrder.size() > 0)
          {
                   //system.debug('OS: Trigger ContractOnOrder dentro if');
                  /**************STEP_1***************
                  Set<ID> listinoID = new Set<ID>();
                  listinoID = OF_UtilitiesCreazioneAsset.getListino(ContractIdFromOrder.keyset());
                  
                  /***************STEP_2***************
                  /**Creazione Asset**
                  if( idContrOrder != null && idContrOrder.size()>0){
                  listAsset = OF_UtilitiesCreazioneAsset.CreazioneAsset(ContractOnOrder,idContrOrder);
                  system.debug('OSCRM Creazione Asset: '+listAsset);
                  }
           
                  Map<ID,ID> assetOrder = new Map<ID,ID>();
                  
                  if( listAsset!=null && listAsset.size() > 0 )
                  { 
                       for( Asset ax : listAsset )
                       {
                            assetOrder.put(ax.OF_OrdineID__c,ax.Id);
                       }
                  }
           
                 
                  List<Order> listaOrderToUpdate = new List<Order>(); 
                  
                  if( assetOrder!=null && assetOrder.size()>0)
                  {
                       for( Order or1 : Trigger.new )
                       {
                 
                          //system.debug('assetOrder-->'+assetOrder.get(or1.Id));
                          or1.OF_Asset__c = assetOrder.get(or1.Id); 
                          listaOrderToUpdate.add(or1);
                          //system.debug('\nDentro il terzo for()--\n');
                        }
                  }
                  /***************************************/
             
                      
                  /*******************STEP_4*****************/
                  
                   //if(listaOrderToUpdate.size() > 0 ) update listaOrderToUpdate;
                   //system.debug('listaOrderToUpdate-->'+listaOrderToUpdate);
                   
                   /**Creazione PriceBooEntry + Associazione Asset**/
                   //system.debug('orlando_listinoID '+listinoID);
                   //PriceProductMap = OF_UtilitiesCreazioneAsset.getMappaPriceBook2Product2(listinoID);
                   
                   //system.debug('Orlando.S type : '+type);
                  
                  /**Attivazione**
                  if( type == 0 )
                  { 
                     /*
                     Map<ID,Map<ID,PriceBook2>> PriceProductMap = OF_UtilitiesCreazioneAsset.getMappaOrder(ContractIdFromOrder,mappaIDOrder,type);
                   
                     system.debug('stepOrlando:PriceProductMap type = 0'+PriceProductMap);
                     OF_UtilitiesCreazioneAsset.CreazionePriceBookEntry(PriceProductMap,assetOrder);
                     *
                   }
                      
            } 
           
        
                                          
        }/*Fine evento if(Trigger.isUpdate)* 
        
          system.debug('\n---2.Fine trigger update---\n');  
          
      }catch ( Exception e )
      {
      OF_Utility.logMessage(true,'E',
                     'Trigger: OF_CreazioneAsset',
                     'sObject: Order',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );  
      }
*/
}
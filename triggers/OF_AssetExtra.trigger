trigger OF_AssetExtra on Asset (before insert,after update) {
    
    
    // Id RecordTypeId_InterventoAVuoto = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Intervento a vuoto').getRecordTypeId();
    // Id RecordTypeId_Verticale = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
    
    // //CRM 04_09_2017 INIZIO----
    // Id RecordTypeId_P2P = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('P2P').getRecordTypeId();
    // Id RecordTypeId_FiberLink = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Fiber Link').getRecordTypeId();
    // Id RecordTypeId_FiberLease = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Fiber Lease').getRecordTypeId();
    
    // if( trigger.isAfter )
    // {
    //   Set<Id> assetFattIds= new Set<Id>();
      
    //   for( Asset a :Trigger.new)
    //   {  
    //       if( (a.RecordTypeId == RecordTypeId_P2P)  ||
    //           (a.RecordTypeId == RecordTypeId_FiberLink)  || 
    //           (a.RecordTypeId == RecordTypeId_FiberLease) 
    //           )
    //       {
               
    //           if( Trigger.oldMap.get( a.Id ).Data_Avvio_Fatturazione__c != 
    //                 a.Data_Avvio_Fatturazione__c )
    //           {
    //               assetFattIds.add( a.Id ) ; 
    //           }
    //       }
    //   }
      
    
    //   if( assetFattIds.size() > 0 )
    //   {
    //       List<Asset> listaAsset = [
    //                                  SELECT id,Data_Avvio_Fatturazione__c,OF_DataScadenza__c,
    //                                   (SELECT Id,OF_DataAttivazione2__c,IsActive
    //                                     FROM Price_Book_Entries__r
    //                                   ),
    //                                   (SELECT Id,OF_DataAttivazione__c,OF_Stato__c
    //                                     FROM Commercial_element_istanziati__r
    //                                   ),
    //                                   (SELECT Id,Recordtype.DeveloperName,
    //                                           PO_Case_Collegamento__r.PO_Richiesta_a_fattibilit__r.PO_Durata_mesi__c,
    //                                           PO_Case_Collegamento__r.PO_Richiesta_a_fattibilit__r.PO_Durata_affitto__c
    //                                     FROM Cases
    //                                   )
    //                                  FROM Asset
    //                                  WHERE Id In : assetFattIds
    //                               ];
           
    //       List<OF_CommercialElementIstanziato__c> ListaCEIst = new List<OF_CommercialElementIstanziato__c>();
    //       List<PriceBookEntry> ListaPBE = new List<PriceBookEntry>();
    //       for( Asset ass : listaAsset )
    //       {
    //           List<PriceBookEntry> listPBE = ass.Price_Book_Entries__r;
    //           List<OF_CommercialElementIstanziato__c> listCEIst = ass.Commercial_element_istanziati__r;
              
    //           if( ass.Data_Avvio_Fatturazione__c != null)
    //           { 
    //               //Datetime dtTime;
    //               //dtTime.date()
    //               Date dt = ass.Data_Avvio_Fatturazione__c;
    //               system.debug('OSCRM 11_10_2017 dt:'+dt);
                   
    //               List<Case> listCase = ass.Cases;
                   
    //               if( listCase[0].Recordtype.DeveloperName == 'PO_Ordine_Fiber_Link' )
    //               {
    //                   Integer numeroAnni = Integer.valueOf( listCase[0].PO_Case_Collegamento__r.PO_Richiesta_a_fattibilit__r.PO_Durata_affitto__c );
    //                   ass.OF_DataScadenza__c = dt.addYears( numeroAnni );
    //                   system.debug( 'OSCRM 11_10_2017 ass.OF_DataScadenza__c:'+ass.OF_DataScadenza__c );
    //               }
    //               if( listCase[0].Recordtype.DeveloperName == 'PO_Ordine_Misto_Fiber_Lease_Link_per_Fastweb' )
    //               {
    //                   Integer numeroMesi = Integer.valueOf( listCase[0].PO_Case_Collegamento__r.PO_Richiesta_a_fattibilit__r.PO_Durata_mesi__c );
    //                   ass.OF_DataScadenza__c = dt.addMonths( numeroMesi );
    //               }
    //           }
                   
    //           /*
    //           if(ass.Data_Avvio_Fatturazione__c != null)
    //           {
    //                 string str = string.valueof(ass.Data_Avvio_Fatturazione__c);
    //                 string str1 = str + ' ' + '00:00:00';
    //                 dt = DateTime.valueof(str1);
    //           }
    //           */
    //           for( PriceBookEntry var : listPBE )
    //           {
    //               if( var.IsActive == false ) var.isActive = true;
                   
    //               //var.OF_DataAttivazione2__c = dt;
    //               var.OF_DataAttivazione2__c = ass.Data_Avvio_Fatturazione__c; 
    //               ListaPBE.add( var );
    //           }
               
    //           for( OF_CommercialElementIstanziato__c ceIst : listCEIst )
    //           {
               
    //               if( ceIst.OF_Stato__c != 'Attivo') ceIst.OF_Stato__c = 'Attivo';
    //               //ceIst.OF_DataAttivazione__c = dt;
    //               ceIst.OF_DataAttivazione__c = ass.Data_Avvio_Fatturazione__c;
    //               ListaCEIst.add( ceIst );
    //           }
    //       }
           
    //       system.debug('CRM 04_09 OF_AssetExtra ListaPBE--> '+ListaPBE);
    //       if( ListaPBE.size() > 0 ) update ListaPBE;
           
    //       system.debug('CRM 04_09 OF_AssetExtra listCEIst--> '+ListaCEIst);
    //       if( ListaCEIst.size() > 0 ) update ListaCEIst;
           
    //     }
    // }
     
    //CRM 04_09_2017 FINE---- 
          
    // if(trigger.isBefore){
        
    //     //CRM 04_09_2017
    //     list<case> cases = new list<case>();
    //     set<id> ids = new set<id>();
    //     for(Asset a : trigger.new){
    //         ids.add(a.OF_Case__c);
    //     }
        
    //     cases = [select id, OF_IDContratto__c, AssetId from case where id IN: ids];
    //     map<id, string> caseContract = new map<id, string>();
    //     map<id, string> caseAsset = new map<id, string>();
        
    //     if(cases.size() > 0){
    //         for(case c : cases){
    //             caseContract.put(c.id, c.OF_IDContratto__c);
    //             caseAsset.put(c.id, c.AssetId);
    //         }
        
    //     //system.debug('DG_OF_AssetExtra caseContract: ' + caseContract);
    //     //system.debug('DG_OF_AssetExtra caseAsset: ' + caseAsset);
    //     List<OF_Configurazioni__c> listCustomSett = OF_Configurazioni__c.getAll().values();
    //     Integer NomeServizioExtra = (Integer)listCustomSett[0].OF_ServizioExtraName__c;
        
    //     for( Asset a : trigger.new){
    //         //system.debug('OSCRM a.recordtypeID: '+a.recordtypeId + '----a.recordtype.Name: '+a.recordtype.Name + '-----a.OF_Case__c: ' + a.OF_Case__c);
    //         //Creazione del name in automatico
    //         if((a.recordtypeId == RecordTypeId_InterventoAVuoto ) || (a.recordtypeId == RecordTypeId_Verticale))
    //         {
                
    //             //system.debug('OSCRM asset : ' + a);
    //             string aaa = string.valueOf(NomeServizioExtra);
    //             a.name = 'Extra' + aaa;
    //             NomeServizioExtra ++;
    //             //system.debug('OSCRM asset after: ' + a);
    
    //         }
    //         //Nel caso di interventi a vuoti i campi account, contratto e id risorsa vengono presi direttamente dal case
    //         if( (a.recordtypeId == RecordTypeId_InterventoAVuoto) && (a.OF_Case__c != null) ){
    //             //system.debug('DG_OF_AssetExtra - a.OF_Case__c: ' + a.OF_case__c);
    //             //system.debug('DG_OF_AssetExtra - caseContract.get(a.OF_Case__c): ' + caseContract.get(a.OF_Case__c));
    //             //system.debug('DG_OF_AssetExtra - caseAsset.get(a.OF_Case__c): ' + caseAsset.get(a.OF_Case__c));

    //             a.OF_Contract__c = caseContract.get(a.OF_Case__c);
    //             if(caseAsset.get(a.OF_Case__c) != null){
    //                 //system.debug('DG_OF_AssetExtra - dentro assetid != null');
    //                 a.OF_Asset__c = caseAsset.get(a.OF_Case__c);
    //             }
    //         }
    //     }
    //     listCustomSett[0].OF_ServizioExtraName__c = NomeServizioExtra;
    //     update listCustomSett[0];
    //     }
    // }

    
}
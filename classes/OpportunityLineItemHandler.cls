public class OpportunityLineItemHandler {
    
   public  OpportunityLineItemHandler()
     {  }
    
    // public static void UpdateOppwithProductPrice(list<opportunitylineitem> opplst)
    // {
    //     //CRM 23_08
    //     //system.debug('CRM 23_08 opplst:'+opplst);
        
    //     set<id> oppids = new set<id>(); 
    //     set<id> caseids = new set<id>();
    //     map<id,opportunitylineitem> oppLILst ;
    //     decimal CorrispIRU;
    //     for(opportunitylineitem opp : opplst)
    //     {
    //         if(opp.opportunityid != null)
    //         {
    //             oppids.add(opp.opportunityid );
    //         }
            
    //     }

    //     map<id,opportunitylineitem> oppLineLst = new map<id,opportunitylineitem>([SELECT Id,ListPrice,Name,opportunity.PO_Collegamento__c,PO_SalesPrice__c,OpportunityId,PricebookEntryId,Product2Id,Product2.name,ProductCode,
    //                     ProductsOpportunity__c,Quantity,TotalPrice,UnitPrice,Product2.PO_Anni_Fiber_Link__c FROM OpportunityLineItem where 
    //                     id IN : opplst and opportunity.PO_Collegamento__c != null and OpportunityId !=null]);
        
        
    //     //system.debug('products====='+oppids);
    //     system.debug('CRM 23_08 oppLineLst:'+oppLineLst);
        
    //     map<id,opportunity> childoppsMap;
    //     if(oppids.size()>0)
            
    //         childoppsMap = new map<id,opportunity>([select id,name,PO_Canone_collegamento__c,PO_Contributo_attivazione_collegamento__c,
    //                                                 PO_Costi_aggiuntivi_collegamento__c,PO_Canone_collegamento_scontato__c,PO_Costi_aggiuntivi_collegamento_sconta2__c,
    //                                                 PO_Contributo_attivaz_collegam_scontato__c,PO_Canone_manutenzione_colleg_scontato__c,
    //                                                 PO_Canone_manutenzione_collegamento__c,PO_Offerta_totale__c , PO_Collegamento__c,PO_Corrispettivo_IRU__c,PO_Costi_aggiuntivi_collegamento_scontat__c
    //                                                 from opportunity where id IN :oppids and  PO_Collegamento__c != null]);
        
    //     for(opportunity opp : childoppsMap.values())
    //     {
    //         caseids.add(opp.PO_Collegamento__c); 
    //     }
    //     map<id,opportunity> vmapopplst = new map<id,opportunity>();
    //     map<id,case> caseMap = new map<id,case>([select id,PO_Tipo_di_collegamento__c,PO_Lunghezza_tratte_complessiva__c, recordtype.name from case where id IN :caseids]);
        
    //     /**25/09/2017 Modifica CRM**/
    //     for(opportunitylineitem oli : oppLineLst.values())
    //     {
    //         opportunity opp = childoppsMap.get(oli.opportunityid);
    //         case cs = caseMap.get(opp.PO_Collegamento__c);
    //         if(cs.PO_Tipo_di_collegamento__c == 'Backhauling' || cs.PO_Tipo_di_collegamento__c == 'P2P - Cliente')
    //         {
    //             if(oli.Product2.name == 'Corrispettivo IRU')
    //             {
    //                 if(cs.PO_Lunghezza_tratte_complessiva__c != null)
    //                 {
    //                     CorrispIRU = cs.PO_Lunghezza_tratte_complessiva__c * oli.PO_SalesPrice__c;
    //                     break;
    //                 }
    //             }
    //         }else
    //         {
    //             break;
    //         }
    //     }
    //     system.debug('CRM_OpportunityLineItemHandler_UpdateOppwithProductPrice CorrispIRU: ' + CorrispIRU);
    //     /**25/09/2017 END CRM**/
        
    //     for(opportunitylineitem oli : oppLineLst.values())
    //     {
    //         opportunity opp = childoppsMap.get(oli.opportunityid);
    //         case cs = caseMap.get(opp.PO_Collegamento__c);
    //         system.debug('CRM_OpportunityLineItemHandler_UpdateOppwithProductPrice oli.Product2.name: '+oli.Product2.name);
               
    //             /*CRM
    //             if(oli.Product2.name == 'Contributo Aggiuntivo')
    //             {
    //                 opp.PO_Costi_aggiuntivi_collegamento_sconta2__c = opp.PO_Costi_aggiuntivi_collegamento_scontat__c;
    //                 vmapopplst.put(opp.id, opp);
    //             }*/
            
    //             if(oli.Product2.name == 'Canone')
    //             {
    //                 //system.debug('Enetering==========3');
    //                 opp.PO_Canone_collegamento__c = oli.PO_SalesPrice__c;
                    
    //                 //system.debug('val====1'+opp.PO_Canone_collegamento__c);
    //                 //system.debug('val====2'+oli.PO_SalesPrice__c);
    //                 vmapopplst.put(opp.id, opp);
    //             }
    //             if(oli.Product2.name == 'Contributo Attivazione')
    //             {
    //                 //system.debug('Enetering==========4');
    //                 opp.PO_Contributo_attivazione_collegamento__c = oli.PO_SalesPrice__c; 
    //                 //system.debug('val====3'+opp.PO_Contributo_attivazione_collegamento__c);
    //                 //system.debug('val====4'+oli.PO_SalesPrice__c);
    //                 vmapopplst.put(opp.id, opp);
    //             }
                
    //             if(cs.PO_Tipo_di_collegamento__c == 'Backhauling' || cs.PO_Tipo_di_collegamento__c == 'P2P - Cliente')
    //             {
                      
    //                 if(oli.Product2.name == 'Corrispettivo IRU')
    //                 {
                        
    //                     if(cs.PO_Lunghezza_tratte_complessiva__c != null)
    //                     {
    //                         system.debug('Dentro if - CorrispIRU: ' + CorrispIRU);
    //                         opp.PO_Corrispettivo_IRU__c = CorrispIRU;
    //                         vmapopplst.put(opp.id, opp);
    //                     }
    //                     else
    //                     {
    //                         /**25/09/2017 CRM Modifica - aggiunto lo 0 **/
    //                         opp.PO_Corrispettivo_IRU__c =  0 * oli.PO_SalesPrice__c;
    //                         vmapopplst.put(opp.id, opp); 
    //                     }
                        
    //                 }
    //                 /**25/09/2017 CRM Modifica - Canone manutenzione calcolato come il 3% del corrispettivo IRU appena calcolato**/
    //                 if(oli.Product2.name == 'Canone Manutenzione')
    //                 {
    //                     if(cs.PO_Lunghezza_tratte_complessiva__c != null)
    //                     {
    //                         opp.PO_Canone_manutenzione_collegamento__c = CorrispIRU * 0.03;
    //                         vmapopplst.put(opp.id, opp);
    //                     }
    //                     else
    //                     {
    //                         opp.PO_Canone_manutenzione_collegamento__c = 0 * oli.PO_SalesPrice__c;
    //                         vmapopplst.put(opp.id, opp);
    //                     }
    //                 }
    //                 /**25/09/2017 CRM END Modifica**/
    //             }
            
    //             if(cs.PO_Tipo_di_collegamento__c == 'BTS' || cs.PO_Tipo_di_collegamento__c == 'Dark Fiber')
    //             {
    //                 if(oli.Product2.name == 'Corrispettivo IRU')
    //                 {
    //                     opp.PO_Corrispettivo_IRU__c = oli.PO_SalesPrice__c;
    //                     vmapopplst.put(opp.id, opp);
    //                 }
                    
    //                 /**25/09/2017 CRM Modifica - Canone manutenzione per BTS e Dark Fiber**/
    //                 if(oli.Product2.name == 'Canone Manutenzione')
    //                 {
    //                     opp.PO_Canone_manutenzione_collegamento__c =  oli.PO_SalesPrice__c;
    //                     vmapopplst.put(opp.id, opp);
    //                 }
    //                 /**25/09/2017 CRM END Modifica**/
    //             }
    //             //28/08/2017 CRM Modifica per fiber link
    //             if(cs.recordtype.name == 'PO Collegamento Fiber link')
    //             {
    //                 //system.debug('DG_OpportunityLineItemHandler - dentro fiber link');
    //                 /**ANNO 1**/
    //                 if(oli.Product2.name == 'Canone' && oli.product2.PO_Anni_Fiber_Link__c == '1 Anno')
    //                 {
    //                     opp.PO_Canone_annuo_1anno__c = oli.PO_SalesPrice__c;
    //                     vmapopplst.put(opp.id, opp);
    //                 }
    //                 if(oli.Product2.name == 'Contributo Attivazione' && oli.product2.PO_Anni_Fiber_Link__c == '1 Anno')
    //                 {
    //                     opp.PO_Contributo_attivazione_1anno__c = oli.PO_SalesPrice__c;
    //                     vmapopplst.put(opp.id, opp);
    //                 }
    //                 /**ANNO 2**/
    //                 if(oli.Product2.name == 'Canone' && oli.product2.PO_Anni_Fiber_Link__c == '2 Anni')
    //                 {
    //                     opp.PO_Canone_annuo_2anni__c = oli.PO_SalesPrice__c;
    //                     vmapopplst.put(opp.id, opp);
    //                 }
    //                 if(oli.Product2.name == 'Contributo Attivazione' && oli.product2.PO_Anni_Fiber_Link__c == '2 Anni')
    //                 {
    //                     opp.PO_Contributo_attivazione_2anni__c = oli.PO_SalesPrice__c;
    //                     vmapopplst.put(opp.id, opp);
    //                 }
    //                 /**ANNO 3**/
    //                 if(oli.Product2.name == 'Canone' && oli.product2.PO_Anni_Fiber_Link__c == '3 Anni')
    //                 {
    //                     opp.PO_Canone_annuo_3anni__c = oli.PO_SalesPrice__c;
    //                     vmapopplst.put(opp.id, opp);
    //                 }
    //                 if(oli.Product2.name == 'Contributo Attivazione' && oli.product2.PO_Anni_Fiber_Link__c == '3 Anni')
    //                 {
    //                     opp.PO_Contributo_attivazione_3anni__c = oli.PO_SalesPrice__c;
    //                     vmapopplst.put(opp.id, opp);
    //                 }
    //                 /**ANNO X**/
    //                 if(oli.Product2.name == 'Canone' && oli.product2.PO_Anni_Fiber_Link__c == 'X Anni')
    //                 {
    //                     opp.PO_Canone_annuo_AltriAnni__c = oli.PO_SalesPrice__c;
    //                     vmapopplst.put(opp.id, opp);
    //                 }
    //                 if(oli.Product2.name == 'Contributo Attivazione' && oli.product2.PO_Anni_Fiber_Link__c == 'X Anni')
    //                 {
    //                     opp.PO_Contributo_attivazione_altri_anni__c = oli.PO_SalesPrice__c;
    //                     vmapopplst.put(opp.id, opp);
    //                 }
    //             }
    //             //28/08/2017 END CRM
            
    //     }
        
    //     if(vmapopplst.values().size()>0) 
    //         update vmapopplst.values();
    //     //system.debug('vmapopplst===='+vmapopplst);
        
    // }
    
}
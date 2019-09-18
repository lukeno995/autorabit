public class UtilityHandler {
    public Static Void updateContract(list<opportunity> Listopp){
        Set<ID> caseIds = new Set<ID>();
        set<id> accids = new set<id>();
        List<Opportunity> oppList = new List<Opportunity>();
        //List<Contract> contra = [SELECT Id,OF_IdContratto__c,StartDate,ContractTerm,Status FROM Contract]; // 25/05/2018 MM : commento
        for(Opportunity opp : Listopp){
            if(opp.PO_Collegamento__c != null){
                caseIds.add(opp.PO_Collegamento__c);
                
            }
        }
        
        //List<pricebook2> pricelist=[SELECT Id,Name,PO_Commercial_element__c,PO_Commercial_element__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__r.accountid  from pricebook2 where PO_Commercial_element__r.name = 'SINGOLA VIA BIFIBRA' or PO_Commercial_element__r.name = 'SINGOLA VIA MONOFIBRA'];
        Map<id,case>  caseList = new map<id,case>([SELECT ID,PO_Tipo_di_collegamento__c,PO_Tipologia_Offerta__c,PO_Comune2__c,PO_Comune2__r.OF_Comune__c,contact.accountid,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c FROM Case WHERE ID IN : caseIds]);
        map<id,OF_ElencoComuniItaliani__c> vmapElenco = new map<id,OF_ElencoComuniItaliani__c>([select id,OF_Comune__c from OF_ElencoComuniItaliani__c]);
        for(case c : caseList.values())
        {
            accids.add(c.contact.accountid);
        }
        map<id,OF_AreaGeograficaJunction__c> AreaGeoMap = new map<id,OF_AreaGeograficaJunction__c>([select id, OF_Contratto__c,OF_Contratto__r.AccountId,OF_Contratto__r.id,Servizio__c,Servizio__r.name,OF_Comune__c from OF_AreaGeograficaJunction__c where OF_Contratto__r.AccountId IN : accids and (Servizio__r.name = 'P2P Base' OR Servizio__r.name = 'IRU')]);
        try
        {
            if(AreaGeoMap.values().size()>0 && caseList.values().size() >0)
            { 
                
                for(Opportunity opp1 : Listopp){ 
                    
                    case cs = caseList.get(opp1.PO_Collegamento__c);
                    string agv = vmapElenco.get(cs.PO_Comune2__c).OF_Comune__c;
                    
                    //system.debug('comune======== 4'+agv);
                    for(OF_AreaGeograficaJunction__c ag : [select id, OF_Contratto__c,OF_Contratto__r.AccountId,OF_Contratto__r.id,Servizio__c,Servizio__r.name,OF_Comune__c from OF_AreaGeograficaJunction__c where OF_Contratto__r.AccountId IN : accids and (Servizio__r.name = 'P2P Base'   OR Servizio__r.name = 'IRU' OR Servizio__r.name = 'Fiber Link' OR Servizio__r.name = 'Fiber Lease') and OF_Comune__c =: agv])//AreaGeoMap.values()
                    {
                        
                        if(cs.PO_Tipologia_Offerta__c == 'P2P Base' && cs.PO_Tipologia_Offerta__c != null )
                        {
                            if( ag.OF_Comune__c == cs.PO_Comune2__r.OF_Comune__c && ag.Servizio__r.name == cs.PO_Tipologia_Offerta__c)
                            { 
                                opp1.PO_Contratto__c = ag.OF_Contratto__r.id;
                                
                            }
                            
                        }
                        if(cs.PO_Tipologia_Offerta__c == 'IRU' && cs.PO_Tipologia_Offerta__c != null )
                        {
                            if( ag.OF_Comune__c == cs.PO_Comune2__r.OF_Comune__c && ag.Servizio__r.name == cs.PO_Tipologia_Offerta__c)
                            { 
                                opp1.PO_Contratto__c = ag.OF_Contratto__r.id;
                                
                            }
                            
                        }
                        if(cs.PO_Tipologia_Offerta__c == 'Fiber Link' && cs.PO_Tipologia_Offerta__c != null )
                        {
                            
                            if( ag.OF_Comune__c == cs.PO_Comune2__r.OF_Comune__c && ag.Servizio__r.name == cs.PO_Tipologia_Offerta__c)
                            { 
                                
                                opp1.PO_Contratto__c = ag.OF_Contratto__r.id;
                                
                            }
                            
                        }
                        if(cs.PO_Tipologia_Offerta__c == 'Fiber Lease' && cs.PO_Tipologia_Offerta__c != null )
                        {
                            
                            system.debug('FL1======');
                            if( ag.OF_Comune__c == cs.PO_Comune2__r.OF_Comune__c && ag.Servizio__r.name == cs.PO_Tipologia_Offerta__c)
                            { 
                                
                                opp1.PO_Contratto__c = ag.OF_Contratto__r.id;
                                
                            }
                            
                        }
                    }
                }
            }
        }
        catch(exception e){
            system.debug('error===='+e.getStackTraceString());}
    }
    
    public static void ChildOppDiscountUpdation(list<opportunity> vlstopp)
    {
        set<id> childopps = new set<id>();
        Map<id,opportunity> childoppsMap ;
        Map<id,opportunity> ParentoppsMap ;
        
        for(opportunity opp : vlstopp)
        {
            childopps.add(opp.id);
        }
        //system.debug('CRM_UtilityHandler_ChildOppDiscountUpdation childopps: '+childopps);
        
        if(childopps.size()>0)
        {
            //Prendo i figli
            childoppsMap = new map<id,opportunity>([select id,name,recordtype.name,PO_CostiCollegamento__c,
                                                    PO_Canone_collegamento__c,PO_Contributo_attivazione_collegamento__c,
                                                    PO_Costi_aggiuntivi_collegamento__c,PO_CostiAggiuntiviCollegamento__c,PO_CanoneCollegamentoScontato__c,PO_Costi_aggiuntivi_collegamento_sconta2__c,
                                                    PO_Contributo_attivaz_collegam_scontato__c,PO_ContributoAttivazCollegamScontato__c,PO_Canone_manutenzione_colleg_scontato__c,
                                                    PO_Canone_manutenzione_collegamento__c,PO_Offerta_totale__c , PO_Collegamento__c,PO_Corrispettivo_IRU__c,
                                                    PO_Costi_aggiuntivi_collegamento_scontat__c,PO_CorrispettivoIRUCollegamentoScontato__c,PO_CanoneManutenzioneCollegScontato__c,
                                                    PO_Canone_annuo_Collegamento1anno_Scont2__c,PO_Contributo_annuo_Colleg1anno_Scontat2__c,PO_Costi_Aggiuntivi_Anno1_Scontati__c,
                                                    PO_Canone_annuo_Collegamento2anno_Scont2__c,PO_Contributo_annuo_Colleg2anni_Scontat2__c,PO_Costi_Aggiuntivi_Anno2_Scontati__c,
                                                    PO_Canone_annuo_Collegamento3anno_Scont2__c,PO_Contributo_annuo_Colleg3anni_Scontat2__c,PO_Costi_Aggiuntivi_Anno3_Scontati__c,
                                                    PO_Canone_annuo_altri_anni_Scontato2__c,PO_Contributo_Attivaz_altri_anni_Scont2__c,PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c,
                                                    (SELECT id,OpportunityId,opportunity.PO_Offerta_totale__c,ListPrice,PricebookEntryId,Product2Id,ProductCode,PO_SalesPrice__c,UnitPrice,Product2.name,product2.PO_Anni_Fiber_Link__c
                                                     FROM OpportunityLineItems)
                                                    
                                                    from opportunity
                                                    where
                                                    PO_Offerta_totale__c IN :childopps and 
                                                    PO_Collegamento__c != null and
                                                    PO_Offerta_totale__c != null
                                                   ]);
        }
        
        //system.debug('CRM_UtilityHandler_ChildOppDiscountUpdation childoppsMap: '+childoppsMap);
        
        map<id,opportunitylineItem> itemstoupdateMap = new  map<id,opportunitylineItem>() ;
        
        for(opportunity opp : childoppsMap.values() )
        {
            //04/08/2017 Modifica CRM
            list<opportunitylineItem> OppLinItems = childoppsMap.get(opp.id).OpportunityLineItems;
            //END 04/08/2017 Modifica CRM
            
            for(opportunitylineItem OppLinIt : OppLinItems)
            {
                //system.debug('CRM_UtilityHandler_ChildOppDiscountUpdation opp.recordtype.name: '+opp.recordtype.name);
                
                if(opp.recordtype.name == 'PO Oppty collegamenti' || 
                   opp.recordtype.name == 'PO Oppty Evento Temporaneo' ||
                   opp.recordtype.name == 'PO Oppty Misto Lease-Link per FW')
                {
                    //system.debug('CRM_UtilityHandler_ChildOppDiscountUpdation dentro P2P');
                    itemstoupdateMap = OppLineItemP2P(opp, OppLinIt, itemstoupdateMap);
                }
                if(opp.recordtype.name == 'PO Oppty IRU')
                {
                    //system.debug('CRM_UtilityHandler_ChildOppDiscountUpdation dentro IRU');
                    itemstoupdateMap = OppLineItemIRU(opp, OppLinIt, itemstoupdateMap);
                }
                if(opp.recordtype.name == 'PO Oppty Fiber Link')
                {
                    //system.debug('CRM_UtilityHandler_ChildOppDiscountUpdation dentro Fiber Link');
                    itemstoupdateMap = OppLineItemFiberLink(opp, OppLinIt, itemstoupdateMap);
                }
            }
        }
        
        //system.debug('CRM_UtilityHandler_ChildOppDiscountUpdation itemstoupdateMap:'+itemstoupdateMap);
        
        if(itemstoupdateMap.values().size()>0 && !itemstoupdateMap.values().isEmpty())
        {
            database.update(itemstoupdateMap.values(),false);
        }
        
    }
    //07/08/2017 Modifica CRM
    public static map<id,opportunitylineItem> OppLineItemP2P(opportunity opp, opportunitylineitem OppLinIt, map<id,opportunitylineItem> itemstoupdateMap)
    {
        if(opp.PO_Costi_aggiuntivi_collegamento_scontat__c != null)
        {
            
            if(OppLinIt.product2.name == 'Contributo Aggiuntivo')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemP2P opp.PO_Costi_aggiuntivi_collegamento_scontat__c: '+opp.PO_Costi_aggiuntivi_collegamento_scontat__c);
                
                OppLinIt.unitprice = opp.PO_Costi_aggiuntivi_collegamento_scontat__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }
        }
        if(opp.PO_CanoneCollegamentoScontato__c != null)
        {
            if(OppLinIt.product2.name == 'Canone')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemP2P opp.PO_CanoneCollegamentoScontato__c: '+opp.PO_CanoneCollegamentoScontato__c);
                
                OppLinIt.unitprice = opp.PO_CanoneCollegamentoScontato__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_ContributoAttivazCollegamScontato__c != null)
        {
            if(OppLinIt.product2.name == 'Contributo Attivazione')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemP2P opp.PO_ContributoAttivazCollegamScontato__c: '+opp.PO_ContributoAttivazCollegamScontato__c);
                
                OppLinIt.unitprice = opp.PO_ContributoAttivazCollegamScontato__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.recordtype.name == 'PO Oppty Misto Lease-Link per FW')
        {
            if(opp.PO_CostiCollegamento__c != null)
            {
                if(OppLinIt.product2.name == 'Contributo Aggiuntivo')
                {
                    //system.debug('CRM_UtilityHandler_OppLineItemP2P opp.PO_Costi_aggiuntivi_collegamento_scontat__c: '+opp.PO_Costi_aggiuntivi_collegamento_scontat__c);
                    
                    OppLinIt.unitprice = opp.PO_CostiCollegamento__c;
                    itemstoupdateMap.put(OppLinIt.id,OppLinIt);
                }
            }
        }
        
        return itemstoupdateMap;
    }
    
    
    public static map<id,opportunitylineItem> OppLineItemIRU(opportunity opp, opportunitylineitem OppLinIt, map<id,opportunitylineItem> itemstoupdateMap)
    {
        if(opp.PO_Costi_aggiuntivi_collegamento_scontat__c != null)
        {
            
            if(OppLinIt.product2.name == 'Contributo Aggiuntivo')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemIRU opp.PO_Costi_aggiuntivi_collegamento_scontat__c: '+opp.PO_Costi_aggiuntivi_collegamento_scontat__c);
                
                OppLinIt.unitprice = opp.PO_Costi_aggiuntivi_collegamento_scontat__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }
        }
        if(opp.PO_ContributoAttivazCollegamScontato__c != null)
        {
            if(OppLinIt.product2.name == 'Contributo Attivazione')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemIRU opp.PO_ContributoAttivazCollegamScontato__c: '+opp.PO_ContributoAttivazCollegamScontato__c);
                
                OppLinIt.unitprice = opp.PO_ContributoAttivazCollegamScontato__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_CorrispettivoIRUCollegamentoScontato__c != null)
        {
            if(OppLinIt.product2.name == 'Corrispettivo IRU')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemIRU opp.PO_CorrispettivoIRUCollegamentoScontato__c: '+opp.PO_CorrispettivoIRUCollegamentoScontato__c);
                
                OppLinIt.unitprice = opp.PO_CorrispettivoIRUCollegamentoScontato__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_CanoneManutenzioneCollegScontato__c != null)
        {
            if(OppLinIt.product2.name == 'Canone Manutenzione')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemIRU opp.PO_CanoneManutenzioneCollegScontato__c: '+opp.PO_CanoneManutenzioneCollegScontato__c);
                
                OppLinIt.unitprice = opp.PO_CanoneManutenzioneCollegScontato__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        return itemstoupdateMap;
    }
    
    
    public static map<id,opportunitylineItem> OppLineItemFiberLink(opportunity opp, opportunitylineitem OppLinIt, map<id,opportunitylineItem> itemstoupdateMap)
    {
        /**PRIMO ANNO**/
        if(opp.PO_Canone_annuo_Collegamento1anno_Scont2__c != null)
        {
            if(OppLinIt.product2.name == 'Canone' && OppLinIt.product2.PO_Anni_Fiber_Link__c == '1 Anno')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Canone_annuo_Collegamento1anno_Scont2__c: '+opp.PO_Canone_annuo_Collegamento1anno_Scont2__c);
                
                OppLinIt.unitprice = opp.PO_Canone_annuo_Collegamento1anno_Scont2__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_Contributo_annuo_Colleg1anno_Scontat2__c != null)
        {
            if(OppLinIt.product2.name == 'Contributo Attivazione' && OppLinIt.product2.PO_Anni_Fiber_Link__c == '1 Anno')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Contributo_annuo_Colleg1anno_Scontat2__c: '+opp.PO_Contributo_annuo_Colleg1anno_Scontat2__c);
                
                OppLinIt.unitprice = opp.PO_Contributo_annuo_Colleg1anno_Scontat2__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_Costi_Aggiuntivi_Anno1_Scontati__c != null)
        {
            if(OppLinIt.product2.name == 'Contributo Aggiuntivo' && OppLinIt.product2.PO_Anni_Fiber_Link__c == '1 Anno')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Costi_Aggiuntivi_Anno1_Scontati__c: '+opp.PO_Costi_Aggiuntivi_Anno1_Scontati__c);
                
                OppLinIt.unitprice = opp.PO_Costi_Aggiuntivi_Anno1_Scontati__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        /**SECONDO ANNO**/
        if(opp.PO_Canone_annuo_Collegamento2anno_Scont2__c != null)
        {
            if(OppLinIt.product2.name == 'Canone'  && OppLinIt.product2.PO_Anni_Fiber_Link__c == '2 Anni')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Canone_annuo_Collegamento2anno_Scont2__c: '+opp.PO_Canone_annuo_Collegamento2anno_Scont2__c);
                
                OppLinIt.unitprice = opp.PO_Canone_annuo_Collegamento2anno_Scont2__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_Contributo_annuo_Colleg2anni_Scontat2__c != null)
        {
            if(OppLinIt.product2.name == 'Contributo Attivazione' && OppLinIt.product2.PO_Anni_Fiber_Link__c == '2 Anni')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Contributo_annuo_Colleg2anni_Scontat2__c: '+opp.PO_Contributo_annuo_Colleg2anni_Scontat2__c);
                
                OppLinIt.unitprice = opp.PO_Contributo_annuo_Colleg2anni_Scontat2__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_Costi_Aggiuntivi_Anno2_Scontati__c != null)
        {
            if(OppLinIt.product2.name == 'Contributo Aggiuntivo' && OppLinIt.product2.PO_Anni_Fiber_Link__c == '2 Anni')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Costi_Aggiuntivi_Anno2_Scontati__c: '+opp.PO_Costi_Aggiuntivi_Anno2_Scontati__c);
                
                OppLinIt.unitprice = opp.PO_Costi_Aggiuntivi_Anno2_Scontati__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        /**TERZO ANNO**/
        if(opp.PO_Canone_annuo_Collegamento3anno_Scont2__c != null)
        {
            if(OppLinIt.product2.name == 'Canone' && OppLinIt.product2.PO_Anni_Fiber_Link__c == '3 Anni')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Canone_annuo_Collegamento3anno_Scont2__c: '+opp.PO_Canone_annuo_Collegamento3anno_Scont2__c);
                
                OppLinIt.unitprice = opp.PO_Canone_annuo_Collegamento3anno_Scont2__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_Contributo_annuo_Colleg3anni_Scontat2__c != null)
        {
            if(OppLinIt.product2.name == 'Contributo Attivazione' && OppLinIt.product2.PO_Anni_Fiber_Link__c == '3 Anni')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Contributo_annuo_Colleg3anni_Scontat2__c: '+opp.PO_Contributo_annuo_Colleg3anni_Scontat2__c);
                
                OppLinIt.unitprice = opp.PO_Contributo_annuo_Colleg3anni_Scontat2__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_Costi_Aggiuntivi_Anno3_Scontati__c != null)
        {
            if(OppLinIt.product2.name == 'Contributo Aggiuntivo' && OppLinIt.product2.PO_Anni_Fiber_Link__c == '3 Anni')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Costi_Aggiuntivi_Anno3_Scontati__c: '+opp.PO_Costi_Aggiuntivi_Anno3_Scontati__c);
                
                OppLinIt.unitprice = opp.PO_Costi_Aggiuntivi_Anno3_Scontati__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        /**ALTRI ANNI**/
        if(opp.PO_Canone_annuo_altri_anni_Scontato2__c != null)
        {
            if(OppLinIt.product2.name == 'Canone' && OppLinIt.product2.PO_Anni_Fiber_Link__c == 'X Anni')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Canone_annuo_altri_anni_Scontato2__c: '+opp.PO_Canone_annuo_altri_anni_Scontato2__c);
                
                OppLinIt.unitprice = opp.PO_Canone_annuo_altri_anni_Scontato2__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_Contributo_Attivaz_altri_anni_Scont2__c != null)
        {
            if(OppLinIt.product2.name == 'Contributo Attivazione' && OppLinIt.product2.PO_Anni_Fiber_Link__c == 'X Anni')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Contributo_Attivaz_altri_anni_Scont2__c: '+opp.PO_Contributo_Attivaz_altri_anni_Scont2__c);
                
                OppLinIt.unitprice = opp.PO_Contributo_Attivaz_altri_anni_Scont2__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        if(opp.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c != null)
        {
            if(OppLinIt.product2.name == 'Contributo Aggiuntivo' && OppLinIt.product2.PO_Anni_Fiber_Link__c == 'X Anni')
            {
                //system.debug('CRM_UtilityHandler_OppLineItemFiberLink opp.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c: '+opp.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c);
                
                OppLinIt.unitprice = opp.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c;
                itemstoupdateMap.put(OppLinIt.id,OppLinIt);
            }  
        }
        return itemstoupdateMap;
    }
    //END 07/08/2017 Modifica CRM
    
    //CRM Modifica 31_07_2017.
    //Il seguente metodo aggiorna tutti i campi dell'opportunity con RecordType IN ( 'PO Oppty collegamenti', 'PO Oppty IRU','PO Oppty Fiber Link').
    //Aggiorna anche i campi dei Product sotto quella Opportunity
    public static void ChildOppOrphanDiscountUpdation(  Map<Id,Opportunity> TriggerNewMap  , Integer flagInsertUpdate )
    {
        List<Opportunity> listChilds = [ SELECT id,name,recordtype.name,PO_CostiCollegamento__c,
                                        PO_Canone_collegamento__c,PO_Contributo_attivazione_collegamento__c,
                                        PO_Costi_aggiuntivi_collegamento__c,PO_CostiAggiuntiviCollegamento__c,PO_CanoneCollegamentoScontato__c,
                                        PO_Costi_aggiuntivi_collegamento_sconta2__c,PO_ContributoAttivazCollegamScontato__c,
                                        PO_Canone_manutenzione_colleg_scontato__c,PO_Canone_manutenzione_collegamento__c,
                                        PO_Offerta_totale__c , PO_Collegamento__c,PO_Corrispettivo_IRU__c,
                                        PO_Costi_aggiuntivi_collegamento_scontat__c,
                                        PO_CorrispettivoIRUCollegamentoScontato__c,PO_CanoneManutenzioneCollegScontato__c, //04/08/2017 Modifica CRM
                                        PO_Costi_Aggiuntivi_Anno3_Scontati__c,PO_Costi_Aggiuntivi_Anno2_Scontati__c,PO_Costi_Aggiuntivi_Anno1_Scontati__c,
                                        PO_Canone_annuo_Collegamento1anno_Scont2__c,PO_Contributo_annuo_Colleg1anno_Scontat2__c,
                                        PO_Canone_annuo_Collegamento2anno_Scont2__c,PO_Contributo_annuo_Colleg2anni_Scontat2__c,
                                        PO_Canone_annuo_Collegamento3anno_Scont2__c,PO_Contributo_annuo_Colleg3anni_Scontat2__c,
                                        PO_Canone_annuo_altri_anni_Scontato2__c,PO_Contributo_Attivaz_altri_anni_Scont2__c,PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c,
                                        (select id,OpportunityId,opportunity.PO_Offerta_totale__c,ListPrice,PricebookEntryId,
                                         Product2Id,ProductCode,PO_SalesPrice__c,UnitPrice,Product2.name,product2.PO_Anni_Fiber_Link__c
                                         FROM OpportunityLineItems)
                                        FROM opportunity
                                        WHERE RecordType.Name IN ( 'PO Oppty collegamenti', 'PO Oppty IRU','PO Oppty Fiber Link','PO Oppty Evento Temporaneo', 'PO Oppty Misto Lease-Link per FW') and  //04/08/2017 Modifica CRM
                                        Id in : TriggerNewMap.keyset() and
                                        PO_Collegamento__c != null and
                                        PO_Offerta_totale__c = null];
        map<id,opportunitylineItem> itemstoupdateMap = new  map<id,opportunitylineItem>() ;
        
        
        if( listChilds.size() > 0 ) 
        {
            for( Opportunity opp : listChilds )
            {
                List<OpportunityLineItem> oppLineItemsList = opp.OpportunityLineItems;
                
                if( oppLineItemsList.size() > 0 )
                {
                    for( OpportunityLineItem oppLItem : oppLineItemsList )
                    {
                        //flagInsertUpdate == 0 =>Update event
                        if( flagInsertUpdate == 0 )
                        {
                            //08/07/2017 Modifica CRM
                            if((opp.recordtype.name == 'PO Oppty collegamenti') || 
                               (opp.recordtype.name == 'PO Oppty Evento Temporaneo')||
                               (opp.recordtype.name == 'PO Oppty Misto Lease-Link per FW'))
                            {
                                //system.debug('CRM_UtilityHandler_ChildOppDiscountUpdation dentro P2P');
                                itemstoupdateMap = OppLineItemP2P(opp, oppLItem, itemstoupdateMap);
                            }
                            if(opp.recordtype.name == 'PO Oppty IRU')
                            {
                                //system.debug('CRM_UtilityHandler_ChildOppDiscountUpdation dentro IRU');
                                itemstoupdateMap = OppLineItemIRU(opp, oppLItem, itemstoupdateMap);
                            }
                            if(opp.recordtype.name == 'PO Oppty Fiber Link')
                            {
                                //system.debug('CRM_UtilityHandler_ChildOppDiscountUpdation dentro Fiber Link');
                                itemstoupdateMap = OppLineItemFiberLink(opp, oppLItem, itemstoupdateMap);
                            }
                        }
                        
                        if( flagInsertUpdate == 1 )
                        {
                            if(opp.recordtype.name == 'PO Oppty IRU' || opp.recordtype.name == 'PO Oppty collegamenti' || 
                               opp.recordtype.name == 'PO Oppty Evento Temporaneo' || opp.recordtype.name == 'PO Oppty Misto Lease-Link per FW')
                            {
                                if( opp.PO_Costi_aggiuntivi_collegamento_scontat__c != null && oppLItem.Product2.Name == 'Contributo Aggiuntivo' )
                                {
                                    //system.debug('CRM UtilityHandler 31_07_3 : opp.PO_Costi_aggiuntivi_collegamento_scontat__c:'+opp.PO_Costi_aggiuntivi_collegamento_scontat__c );
                                    oppLItem.UnitPrice = opp.PO_Costi_aggiuntivi_collegamento_scontat__c;
                                    itemstoupdateMap.put( oppLItem.Id , oppLItem );
                                }
                            }
                            if(opp.recordtype.name == 'PO Oppty Fiber Link')
                            {
                                if(opp.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c != null && oppLItem.product2.name == 'Contributo Aggiuntivo' && oppLItem.product2.PO_Anni_Fiber_Link__c == 'X Anni')
                                {
                                    //system.debug('CRM_UtilityHandler field====opp.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c: '+opp.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c);
                                    oppLItem.unitprice = opp.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c;
                                    itemstoupdateMap.put(oppLItem.id,oppLItem);
                                }
                                if(opp.PO_Costi_Aggiuntivi_Anno3_Scontati__c != null && oppLItem.product2.name == 'Contributo Aggiuntivo' && oppLItem.product2.PO_Anni_Fiber_Link__c == '3 Anni')
                                {
                                    //system.debug('CRM_UtilityHandler field====opp.PO_Costi_Aggiuntivi_Anno3_Scontati__c: '+opp.PO_Costi_Aggiuntivi_Anno3_Scontati__c);
                                    oppLItem.unitprice = opp.PO_Costi_Aggiuntivi_Anno3_Scontati__c;
                                    itemstoupdateMap.put(oppLItem.id,oppLItem);
                                }
                                if(opp.PO_Costi_Aggiuntivi_Anno2_Scontati__c != null && oppLItem.product2.name == 'Contributo Aggiuntivo' && oppLItem.product2.PO_Anni_Fiber_Link__c == '2 Anni')
                                {
                                    //system.debug('CRM_UtilityHandler field====opp.PO_Costi_Aggiuntivi_Anno2_Scontati__c: '+opp.PO_Costi_Aggiuntivi_Anno2_Scontati__c);
                                    oppLItem.unitprice = opp.PO_Costi_Aggiuntivi_Anno2_Scontati__c;
                                    itemstoupdateMap.put(oppLItem.id,oppLItem);
                                }
                                if(opp.PO_Costi_Aggiuntivi_Anno1_Scontati__c != null && oppLItem.product2.name == 'Contributo Aggiuntivo' && oppLItem.product2.PO_Anni_Fiber_Link__c == '1 Anno')
                                {
                                    //system.debug('CRM_UtilityHandler field====opp.PO_Costi_Aggiuntivi_Anno1_Scontati__c: '+opp.PO_Costi_Aggiuntivi_Anno1_Scontati__c);
                                    oppLItem.unitprice = opp.PO_Costi_Aggiuntivi_Anno1_Scontati__c;
                                    itemstoupdateMap.put(oppLItem.id,oppLItem);
                                }
                            }
                        }
                    }
                }
            }           
        }
        if( itemstoupdateMap.size() > 0 )
        {
            //system.debug('CRM UtilityHandler dentro update finale');
            update itemstoupdateMap.values();
        }
        
    }
    
    //CRM 28/08/2017
    //Calcolo il valore del campo "Valore totale prima coppia fino al 2030"
    //Valore totale prima coppia fino al 2030 = (Prezzo totale anni + Prezzo totale mesi) * Posa 1 nuovo Drop
    public static void FiberLease(List<Opportunity> TriggerNewList)
    {
        list<Opportunity> OppToUpdate = new list<Opportunity>();
        map<id, id> OppCaseMap = new map<id, id>();
        
        //Recupero i recordtype delle opportunity
        Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Opportunity.getRecordTypeInfosById();
        //system.debug('CRM UtilityHandler_FiberLease - TriggerNewList: '+ TriggerNewList);
        set<id> idOpp = new set<id>();
        for(opportunity opp : TriggerNewList)
        {
            //Recupero il recordtype name dell'opportunity considerata
            string RTName = rtMap.get(opp.RecordTypeId).getName();
            
            //system.debug('CRM UtilityHandler_FiberLease - RTName: '+ RTName);
            
            if(RTName == 'PO Oppty Fiber Lease' || RTName == 'PO Oppty Misto Lease-Link per FW' )
            {
                idOpp.add(opp.id);
            }
        }
        
        list<Opportunity> OppList = [SELECT id, PO_Valore_totale_prima_coppia_fino_2030__c, PO_Valore_medio_annuo_altre_coppie__c, PO_Valore_medio_annuo_totale__c,
                                     recordtype.name, PO_Collegamento__c, createddate,
                                     PO_CostoStruttura__c,PO_CostoDiAttivazione__c,PO_CostiCollegamento__c,PO_ContributoDiAttivazione__c,
                                     PO_Collegamento__r.PO_BB_1_interessato__c, PO_Collegamento__r.PO_BB_2_interessato__c,
                                     PO_Collegamento__r.PO_Posa_1_nuovo_Drop__c, PO_Collegamento__r.PO_Posa_2_nuovo_Drop__c,
                                     PO_Collegamento__r.PO_Lunghezza_m__c
                                     FROM opportunity
                                     WHERE id IN : idOpp];
        //system.debug('CRM UtilityHandler_FiberLease - OppList: '+ OppList);
        //Custom setting con i prezzi per anno
        Map <string, OF_FiberLeaseListinoPrezzoAnnuo__c> mapListPrezzo = OF_FiberLeaseListinoPrezzoAnnuo__c.getAll();
        
        //Custom setting con i prezzi medi dei dati metrici ottici
        Map <string, OF_FiberLeasePrezzoMedioAnnuo__c> mapPrezziMedi = OF_FiberLeasePrezzoMedioAnnuo__c.getAll();
        
        //Calcolo il "Prezzo totale anni"
        map<id, decimal> MapAnni = FiberLease_PrezzoTotaleAnni(OppList, mapListPrezzo);
        system.debug('CRM UtilityHandler_FiberLease - MapAnni: '+ MapAnni);
        
        //Calcolo il "Prezzo totale mesi"
        map<id, decimal> MapMesi = FiberLease_PrezzoTotaleMesi(OppList, mapListPrezzo);
        system.debug('CRM UtilityHandler_FiberLease - MapMesi: '+ MapMesi);
        
        for(opportunity Opp : OppList)
        {
            decimal PriceAnni = MapAnni.get(Opp.id);
            system.debug('CRM UtilityHandler_FiberLease - PriceAnni: '+ PriceAnni);
            
            decimal PriceMesi = MapMesi.get(Opp.id);
            system.debug('CRM UtilityHandler_FiberLease - PriceMesi: '+ PriceMesi);
            
            system.debug('CRM UtilityHandler_FiberLease - opp.PO_Collegamento__c: '+ opp.PO_Collegamento__c);
            
            if(opp.PO_Collegamento__r.PO_BB_2_interessato__c == null)
            {
                opp.PO_Collegamento__r.PO_BB_2_interessato__c = 0;
            }
            if(opp.PO_Collegamento__r.PO_Posa_2_nuovo_Drop__c == null)
            {
                opp.PO_Collegamento__r.PO_Posa_2_nuovo_Drop__c = 0;
            }
            if(opp.PO_Collegamento__r.PO_Posa_1_nuovo_Drop__c == null)
            {
                opp.PO_Collegamento__r.PO_Posa_1_nuovo_Drop__c = 0;
            }
            if(opp.PO_Collegamento__r.PO_BB_1_interessato__c == null)
            {
                opp.PO_Collegamento__r.PO_BB_1_interessato__c = 0;
            }
            /*
//19/09/2017 Distinzione tra fiber lease e fiber lease mista. E' da confermare e testare
if(opp.PO_Collegamento__r.PO_Lunghezza_m__c == null)
{
opp.PO_Collegamento__r.PO_Lunghezza_m__c = 0;
}

string RTName = rtMap.get(opp.RecordTypeId).getName();
decimal var = 0.00;
if(RTName == 'PO Oppty Fiber Lease')
{
var = opp.PO_Collegamento__r.PO_Posa_1_nuovo_Drop__c;
}
if(RTName == 'PO Oppty Misto Lease-Link per FW')
{
var = opp.PO_Collegamento__r.PO_Lunghezza_m__c;
}
*/
            
            system.debug('CRM UtilityHandler_FiberLease - opp.PO_Collegamento__r.PO_Posa_1_nuovo_Drop__c: '+ opp.PO_Collegamento__r.PO_Posa_1_nuovo_Drop__c);
            
            //Calcolo il "Valore totale prima coppia fino al 2030"
            Opp.PO_Valore_totale_prima_coppia_fino_2030__c = (PriceAnni + PriceMesi) * opp.PO_Collegamento__r.PO_Posa_1_nuovo_Drop__c;
            //19/09/2017 Distinzione tra fiber lease e fiber lease mista. E' da confermare e testare
            //Opp.PO_Valore_totale_prima_coppia_fino_2030__c = (PriceAnni + PriceMesi) * var;
            
            //Calcolo il "Valore medio annuo altre coppie" = (1° Backbone *BB 1 Interessato) + (2° Backbone*BB 2 interessato) +  (2° Drop*Posa 2 nuovo Drop)
            Opp.PO_Valore_medio_annuo_altre_coppie__c = (opp.PO_Collegamento__r.PO_BB_1_interessato__c * mapPrezziMedi.get('Backbone1').Prezzo__c )+(opp.PO_Collegamento__r.PO_BB_2_interessato__c * mapPrezziMedi.get('Backbone2').Prezzo__c )+(opp.PO_Collegamento__r.PO_Posa_2_nuovo_Drop__c * mapPrezziMedi.get('Drop2AltreCoppie').Prezzo__c );
            
            //Calcolo il "Valore medio annuo totale" = (1° Backbone *BB 1 Interessato) + (2° Backbone*BB 2 interessato) + (1° Drop*Posa 1 nuovo Drop) + (2° Drop*Posa 2 nuovo Drop)
            Opp.PO_Valore_medio_annuo_totale__c = (opp.PO_Collegamento__r.PO_BB_1_interessato__c * mapPrezziMedi.get('Backbone1').Prezzo__c )+(opp.PO_Collegamento__r.PO_Posa_1_nuovo_Drop__c * mapPrezziMedi.get('Drop1').Prezzo__c )+(opp.PO_Collegamento__r.PO_BB_2_interessato__c * mapPrezziMedi.get('Backbone2').Prezzo__c )+ (opp.PO_Collegamento__r.PO_Posa_2_nuovo_Drop__c * mapPrezziMedi.get('Drop2').Prezzo__c );
            //19/09/2017 Distinzione tra fiber lease e fiber lease mista. E' da confermare e testare
            //Opp.PO_Valore_medio_annuo_totale__c = (opp.PO_Collegamento__r.PO_BB_1_interessato__c * mapPrezziMedi.get('Backbone1').Prezzo__c ) + (var * mapPrezziMedi.get('Drop1').Prezzo__c ) + (opp.PO_Collegamento__r.PO_BB_2_interessato__c * mapPrezziMedi.get('Backbone2').Prezzo__c ) + (opp.PO_Collegamento__r.PO_Posa_2_nuovo_Drop__c * mapPrezziMedi.get('Drop2').Prezzo__c );
            
            /**14/09/2017 aggiunti nuovi campi**/
            Opp.PO_CostoStruttura__c = (Opp.PO_CostiCollegamento__c+ 100 ) * mapPrezziMedi.get('CostanteFiberLease1').Prezzo__c;
            Opp.PO_CostoDiAttivazione__c = Opp.PO_CostoStruttura__c + Opp.PO_CostiCollegamento__c;
            Opp.PO_ContributoDiAttivazione__c = (Opp.PO_CostiCollegamento__c + 100 + Opp.PO_CostoStruttura__c) * mapPrezziMedi.get('CostanteFiberLease2').Prezzo__c;
            /**END 14/09/2017**/
            
            OppToUpdate.add(Opp);
        }
        
        if(OppToUpdate.size() > 0)
        {
            database.update(OppToUpdate,false);
            //update OppToUpdate;
        }
        
    }
    
    //CRM Calcolo il prezzo totale anni.
    //Si calcola la differenza tra il 2030 e l'anno di creazione dell'opportunity
    //Si sommano tutti i prezzi che hanno anno minore o uguale a quello appena trovato (i prezzi si trovano nel custom setting OF_FiberLeaseListinoPrezzoAnnuo__c)
    public static map<id, decimal> FiberLease_PrezzoTotaleAnni(List<Opportunity> OppoList, Map <string, OF_FiberLeaseListinoPrezzoAnnuo__c> mapListPrezzo)
    {        
        map<id, decimal> mapDecimal = new map<id, decimal>();
        
        for(opportunity opp : OppoList)
        {
            integer Year = 2030 - opp.createddate.year();
            decimal val = 0;
            
            for(integer i = 1; i <= Year ; i++)
            {
                string str = string.valueOf(i);
                val += mapListPrezzo.get(str).Prezzo__c;
            }
            //Siamo nel 2030. Non entra nel ciclo e si prende il valore del 2030 dal custom setting
            if(Year == 0){
                val = mapListPrezzo.get('1').Prezzo__c;
            }
            /*
for(string str : mapListPrezzo.keySet())
{
if(integer.valueof(str) < Year)
{
val += mapListPrezzo.get(str).Prezzo__c;
}
if(Year == 0){
val += mapListPrezzo.get('0').Prezzo__c;
}
}
*/
            //system.debug('CRM UtilityHandler_FiberLease_PrezzoTotaleAnni - Year: '+ Year);
            //system.debug('CRM UtilityHandler_FiberLease_PrezzoTotaleAnni - val: '+ val);
            
            mapDecimal.put(opp.id, val);
        }
        //system.debug('CRM UtilityHandler_FiberLease_PrezzoTotaleAnni - mapDecimal: '+ mapDecimal);
        
        return mapDecimal;
    }
    
    //CRM Calcolo il prezzo totale mesi.
    /*Prezzo totale mesi = Prezzo mese (valore listino N°anno / 12) * numero mesi (Numero di mesi dalla presunta data di attivazione alla fine dell’anno in corso)
Dove:
La presunta data di attivazione inizia dal secondo mese successivo alla data di emissione dell'offerta.
Per le offerte emesse nei mesi di novembre e dicembre il numero mesi è zero.
*/
    public static map<id, decimal> FiberLease_PrezzoTotaleMesi(List<Opportunity> OppoList, Map <string, OF_FiberLeaseListinoPrezzoAnnuo__c> mapListPrezzo)
    {
        map<id, decimal> mapDecimal = new map<id, decimal>();
        for(opportunity opp : OppoList)
        {
            integer Year = 2030 - opp.createddate.year();
            integer Month = 0;
            decimal val = 0.000;
            decimal Price = 0.000;
            
            if((opp.CreatedDate.month() != 11) &&
               (opp.CreatedDate.month() != 12))
            {
                Month = 12 - (opp.CreatedDate.month() + 1);
            }
            
            system.debug('CRM UtilityHandler_FiberLease_PrezzoTotaleMesi - Month: '+ Month);
            
            system.debug('CRM UtilityHandler_FiberLease_PrezzoTotaleMesi - mapListPrezzo.get(string.valueof(Year)).Prezzo__c: '+ mapListPrezzo.get(string.valueof(Year)).Prezzo__c);
            
            Price = mapListPrezzo.get(string.valueof(Year)).Prezzo__c / 12;
            
            system.debug('CRM UtilityHandler_FiberLease_PrezzoTotaleMesi - Price: '+ Price);
            
            val = Price * Month;
            
            system.debug('CRM UtilityHandler_FiberLease_PrezzoTotaleMesi - val: '+ val);
            
            mapDecimal.put(opp.id, val);
        }
        
        //system.debug('CRM UtilityHandler_FiberLease_PrezzoTotaleMesi - mapDecimal: '+ mapDecimal);
        
        return mapDecimal;
    }
    //END CRM 28/08/2017
    
}
public class CaseUtilityHandler {
    public static void CalculateOpp(list<Case> vcaselst)
    {
        set<id> parentcaseids = new set<id>();
        set<id> childcaseids = new set<id>();
        for(case cs : vcaselst)
        {
            if(cs.PO_Incluso_nell_offerta__c == true)
            {
                parentcaseids.add(cs.PO_Richiesta_a_fattibilit__c);
                
            }
        }
        
        map<id,opportunity> MapParentopp = new map<id,opportunity>([select id,name,PO_Richiesta_fattibilit__c,PO_Richiesta_fattibilit__r.id,PO_Totale_canoni__c,
                                                                    PO_Totale_contributi_attivazione__c,PO_Totale_costi_aggiuntivi__c from Opportunity where PO_Richiesta_fattibilit__c IN :parentcaseids and PO_Richiesta_fattibilit__c != null]);
        
        
        map<id,opportunity> MapChildOpp = new map<id,opportunity>([select id,name,PO_Collegamento__r.id,PO_Incluso_nell_offerta__c,PO_Collegamento__c,PO_Offerta_totale__c,PO_Costi_aggiuntivi_collegamento__c,
                                                                   PO_Canone_collegamento__c,PO_Contributo_attivazione_collegamento__c from opportunity where PO_Offerta_totale__c IN :MapParentopp.keySet() and PO_Offerta_totale__c != null]);
        map<id,opportunity> updateCalcs = new map<id,opportunity>();
        if(MapChildOpp.values().size()>0 && MapParentopp.values().size()>0)
        {
            for(case cs : vcaselst)
            {
                for(opportunity childOpps : MapChildOpp.values())
                {
                    if(cs.id == childOpps.PO_Collegamento__r.id)
                    {
                        opportunity parentOpp  = MapParentopp.get(childOpps.PO_Offerta_totale__c);
                        decimal val1 = parentOpp.PO_Totale_canoni__c;
                        decimal val2 =  parentOpp.PO_Totale_contributi_attivazione__c;
                        decimal val3 =  parentOpp.PO_Totale_costi_aggiuntivi__c;
                        system.debug('val1==========='+val1);
                        system.debug('val2==========='+val2);
                        system.debug('val3==========='+val3);
                        system.debug('Checkbox======='+cs.PO_Incluso_nell_offerta__c );
                        system.debug('Checkbox======='+childOpps.PO_Incluso_nell_offerta__c );
                        system.debug('parent record======='+childOpps.PO_Offerta_totale__c );
                        if(cs.PO_Incluso_nell_offerta__c == false && childOpps.PO_Offerta_totale__c != null)
                        {
                            system.debug('entering======');
                            if(childOpps.PO_Canone_collegamento__c != null)
                            {
                                val1 -= childOpps.PO_Canone_collegamento__c;  
                            }
                            
                            if(childOpps.PO_Contributo_attivazione_collegamento__c != null)
                            {
                                val2 -= childOpps.PO_Contributo_attivazione_collegamento__c;  
                            }
                            
                            if(childOpps.PO_Costi_aggiuntivi_collegamento__c != null)
                            {
                                val3 -= childOpps.PO_Costi_aggiuntivi_collegamento__c;
                            }
                            
                            
                            if(val1 != null  && parentOpp != null)
                            {
                                
                                parentOpp.PO_Totale_canoni__c = val1;
                                updateCalcs.put(parentOpp.id,parentOpp);
                            }
                            
                            if(val2 != null && parentOpp != null)
                            {
                                
                                parentOpp.PO_Totale_contributi_attivazione__c = val2;
                                updateCalcs.put(parentOpp.id,parentOpp);
                            }
                            
                            
                            if(val3 != null && parentOpp != null)
                            {
                                
                                parentOpp.PO_Totale_costi_aggiuntivi__c = val3; 
                                updateCalcs.put(parentOpp.id,parentOpp);
                            }
                            
                        }
                    }
                }
            }
        }
        if(updateCalcs.values().size()>0 && !updateCalcs.values().isEmpty())
        {
            system.debug('before update======'+ updateCalcs.values());
            update updateCalcs.values();
            system.debug('after update======'+ updateCalcs.values());
        }
    }
    
}
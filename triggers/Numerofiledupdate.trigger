trigger Numerofiledupdate on Opportunity (after update,after insert)
{
	// List<Opportunity> vlsttoupdate = new List<Opportunity>();
	//List<opportunity> opplst = [select id,PO_Richiesta_fattibilit__c ,PO_Richiesta_fattibilit__r.id,PO_Numero_Anni__c from opportunity where id in : trigger.new ];
	List<Case> caseToUpdate = new List<Case>();
	Set<id> caseids = new Set<id>();
	Map<Id, List<Opportunity>> mapCaseIdOpp = new Map<Id, List<Opportunity>>();
	for (Opportunity opp : trigger.new) {
		if (opp.PO_Richiesta_fattibilit__c != null) {
			caseids.add(opp.PO_Richiesta_fattibilit__c);
			List<Opportunity> l = mapCaseIdOpp.get(opp.PO_Richiesta_fattibilit__c);
			if (l == null) {
				l = new List<Opportunity>();
				mapCaseIdOpp.put(opp.PO_Richiesta_fattibilit__c, l);
			}
			l.add(opp);
		}
	}

	List<Case> caseList = [SELECT Id, PO_Numero_Anni__c FROM Case WHERE Id in :caseids];
	for (Case c : caseList) {
		for (Opportunity opp : mapCaseIdOpp.get(c.Id)) {
			if (opp.PO_Numero_Anni__c == null) {
				system.debug('entering the loop====' + opp.PO_Numero_Anni__c);
				if (c.PO_Numero_Anni__c != null) {
					c.PO_Numero_Anni__c = null;
					caseToUpdate.add(c);
				}
			} else {
				c.PO_Numero_Anni__c = opp.PO_Numero_Anni__c;
				caseToUpdate.add(c);
			}
		}
	}
	if (!caseToUpdate.isEmpty()) {
		update caseToUpdate;
	}
	/*
	   for(Opportunity opp : trigger.new)
	   {
	    for(case cs : caselist )
	    {

	        system.debug('opp======='+opp.PO_Richiesta_fattibilit__c);
	        system.debug('csid====='+cs.id);
	        system.debug('numero===='+ opp.PO_Numero_Anni__c);
	        if(opp.PO_Richiesta_fattibilit__c == cs.id)

	        {
	              if( opp.PO_Numero_Anni__c == null)
	                {
	                    system.debug('entering the loop===='+ opp.PO_Numero_Anni__c);
	                    if(cs.PO_Numero_Anni__c  != null)
	                    {
	                        cs.PO_Numero_Anni__c  = null;
	                        lsttoupdatecs.add(cs);
	                    }
	                }
	                else
	                {
	                    cs.PO_Numero_Anni__c  = opp.PO_Numero_Anni__c;
	                    lsttoupdatecs.add(cs);
	                }
	                //vlsttoupdate.add(opp.PO_Richiesta_fattibilit__r.PO_Numero_Anni__c);

	        }
	    }
	   }
	   if(lsttoupdatecs.size()>0 && !lsttoupdatecs.isEmpty())
	   {
	    update lsttoupdatecs;
	   }
	 */
}
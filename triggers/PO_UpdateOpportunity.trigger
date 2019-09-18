trigger PO_UpdateOpportunity on Opportunity (after insert, after update, before insert, before update) {
	Map<String,String> mapRTId_DevName = OF_Utility.getRT_IdDevName_Map();
	Set<String> servFattDevNames = new PO_ServFattInfo().getDevNamesForOpportunityHandler();

	List<Opportunity> oppServFattList = new List<Opportunity>();
	//List<Opportunity> oppList = new List<Opportunity>();
	for (Opportunity o : Trigger.new) {
		String devName = mapRTId_DevName.get(o.recordtypeId);
		if (servFattDevNames.contains(devName)) {
			oppServFattList.add(o);
		}// else {
		 //oppList.add(o);
		//}
	}
	System.debug('PO_UpdateOpportunity - oppServFattList.size = ' + oppServFattList.size());
	//System.debug('PO_UpdateOpportunity - oppList.size = ' + oppList.size());
	/*
	   if (!oppList.isEmpty()) {
	    System.debug('PO_UpdateOpportunity oppList.size = ' + oppList.size());
	    Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
	    for (Opportunity o : oppList) {
	        oppMap.put(o.Id, o);
	    }
	    if (Trigger.isInsert) {
	        if (Trigger.isBefore) {
	            UtilityHandler.updateContract(oppList);
	            OpportunityUtilityHandler.updatePricebook(oppList);
	            OpportunityUtilityHandler.CalculateOpp(oppList);
	        } else {
	            //CRM 28/08/2017
	            UtilityHandler.FiberLease(oppList);
	            //END CRM 28/07/2017

	            //CRM 22_08
	            system.debug('CRM 22_08 After_Insert -- trigger.new:' + oppList);
	            OpportunityUtilityHandler.ParentOpportunityUpdation(oppList);

	            system.debug('CRM 22_08 After_Insert.updateProduct');
	            OpportunityUtilityHandler.updateProduct(oppList);

	            UtilityHandler.ChildOppDiscountUpdation(oppList);

	            //CRM Modifica 31_07_2017
	            UtilityHandler.ChildOppOrphanDiscountUpdation(oppMap, 1);
	        }
	    } else if (Trigger.isUpdate) {
	        if (Trigger.isBefore) {
	            system.debug('CRM 22_08 Before_Update');
	            OpportunityUtilityHandler.CalculateOpp(oppList);
	        } else {
	            //CRM 22_08
	            system.debug('CRM 22_08 After_Update');
	            UtilityHandler.ChildOppDiscountUpdation(oppList);

	            //CRM Modifica 31_07_2017
	            UtilityHandler.ChildOppOrphanDiscountUpdation(oppMap, 0 );

	            Set<Id> idsToProcess = new Set<Id>();
	            //CRM 22_08
	            system.debug('CRM 22_08 futureutility.isFutureUpdate:' + Futureutility.isFutureUpdate);
	            if (Futureutility.isFutureUpdate == null) {
	                Futureutility.isFutureUpdate = false;
	            }
	            if (!Futureutility.isFutureUpdate) {
	                for (Opportunity opp : oppList) {
	                    //CRM 25/07/2017 modifica
	                    if (opp.PO_Collegamento__c != null) {
	                        idsToProcess.add(opp.PO_Offerta_Totale__c);
	                    }
	                }
	                System.debug('idsToProcess====' + idsToProcess);
	                OpportunityUtilityHandler.ChildCalculateOpp(idsToProcess);
	            }
	        }
	    }
	   } else
	 */
	if (!oppServFattList.isEmpty()) {
		if (Trigger.isAfter && Trigger.isUpdate && !PO_ServFatt_OpportunityHandler.checkParentRecalculation) {
			Set<Id> parentOppIdSet = new Set<Id>();
			for (Opportunity o: oppServFattList) {
				Opportunity old = Trigger.oldMap.get(o.Id);
				if (PO_ServFatt_OpportunityHandler.haveDifferentPrice(o, old)) {
					if (String.isNotBlank(o.PO_Offerta_totale__c)) {
						parentOppIdSet.add(o.PO_Offerta_totale__c);
					} else {
						parentOppIdSet.add(o.Id);
					}
				}
			}
			if (!parentOppIdSet.isEmpty()) {
				PO_ServFatt_OpportunityHandler.ricalculateOppParent(parentOppIdSet);
			}
		}
	}

}
trigger EOF_Activity_Date_On_Case on Task (after insert, after update) {
	/*
     for (Task t: Trigger.New){
        // if they are related to a contact, add the contact id (whoID) and their values to a map
        if (String.isNotBlank(String.valueOf(t.EOF_Data_Ora_Chiamata__c))){
            //taskMap.put(t.WhatId, t);
            
            List<Case> caseList=[select id from Case where Id=:t.WhatId];
            if(!caseList.isempty()){
            	caseList[0].EOF_Data_appuntamento__c=t.Data_Appuntamento__c;
            	caseList[0].EOF_Fascia_Oraria_appuntamento__c=t.Fascia_Oraria_appuntamento__c;
            	update caseList[0];
            }
        }
    }
    */
}
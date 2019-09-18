trigger SN_UpdateStatusInReply_V2 on Case (before update) {

    RecordType rt_social_req = [Select id, name
                                from RecordType 
                                where name = 'SN Social Request'
                                limit 1];
								
	Map<Id, String> caseSourceIdsMap = new Map<Id, String>();
	List<Case> caseToUpdate = new List<Case>();

    for (Case c: Trigger.new) {
        
        Case old_case = Trigger.oldMap.get(c.ID);
        System.debug('Update_Status_Trigger');
        if(old_case.status=='Chiuso' && c.status =='Inviato' 
            && c.RecordTypeId.equals(rt_social_req.Id) ) {
       
            c.status = 'In Lavorazione';
        }
		
		if(old_case.SourceId == null && c.SourceId != null 
			&& c.RecordTypeId.equals(rt_social_req.Id)){
			
			caseSourceIdsMap.put(c.Id, c.SourceId);
			caseToUpdate.add(c);
		}
    }
	
	if(!caseSourceIdsMap.isEmpty()){
	
		System.debug('@@@@ caseSourceIdsMap: '+caseSourceIdsMap);
		
		Map<Id, SocialPost> sourceMap = new Map<Id, SocialPost>([SELECT Id, PostPriority FROM SocialPost WHERE Id IN :caseSourceIdsMap.values()]);
		
		System.debug('@@@@ sourceMap: '+sourceMap);
		
		for(Case newCase : caseToUpdate){
			SocialPost sp = sourceMap.get(caseSourceIdsMap.get(newCase.Id));
			
			if(sp.PostPriority == 'High'){
				newCase.Alert__c = 1;
			}else if(sp.PostPriority == 'Medium'){
				newCase.Alert__c = 2;
			}else{
				newCase.Alert__c = 3;
			}
		}
		
	}
}
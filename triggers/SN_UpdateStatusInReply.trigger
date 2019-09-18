trigger SN_UpdateStatusInReply on Case (before update) {

    RecordType rt_social_req = [Select id, name
                                from RecordType 
                                where name = 'SN Social Request'
                                limit 1];
    Group codaSocial = [select Id 
                        from group 
                        where DeveloperName ='SN_Coda_Social_Cases' 
                        limit 1];
    
    Group codaRetweet = [Select id,name,DeveloperName
                        from Group
                        where DeveloperName = 'Coda_SN_Social_Retweet'
                        limit 1];

    for (Case c: Trigger.new) {
        
        Case old_case = Trigger.oldMap.get(c.ID);
        System.debug('Update_Status_OwnerQueue_Trigger');

        if(old_case.status=='Chiuso' && c.status=='Inviato' && c.RecordTypeId.equals(rt_social_req.Id) && old_case.ownerId!=codaRetweet.id) 
        {       
            c.status = 'In Lavorazione';
            System.debug('°°°Stato Case cambiato°°°');
        }
        System.debug('**c.ownerId**: '+c.ownerID);
        System.debug('**OldCase.ownerID**:'+old_case.ownerID);
        
        //Ownerid = (Coda SN - Social Retweet)
        if(old_case.status=='Chiuso' && c.status =='Inviato' && c.RecordTypeId.equals(rt_social_req.Id) && old_case.ownerId==codaRetweet.id)
        {       
            c.status = 'In Lavorazione';
            c.ownerID = codaSocial.id;
            System.debug('**c.ownerName**: '+c.owner.name);
        }
    }
}
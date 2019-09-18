trigger SN_SendInitialSocialPost on SocialPost (after insert) {

    List<Id> listId=new List<Id>();
    for(SocialPost Spost:trigger.new) {
        listId.add(Spost.Id);
    }
    
    if(Trigger.isInsert && shouldIRun.canIRun()) 
    {   
        System.debug('****SOCIAL POST INSERITO!!!***');
        
        System.debug('****risposta automatica *** SU ID POST: ' + listId[0]);
        SocialCaseSend.sendAckforSocialCase(listId[0]);
        
    }
    
}
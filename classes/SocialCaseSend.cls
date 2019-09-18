global class SocialCaseSend{

    @future(callout=true)
    public static void sendAckforSocialCase(Id socialpostid)
    {
        
        system.debug('########### - cerco il post a cui rispondere');
        SocialPost fbsocialpost = [select id,name,MessageType,parentid,OutboundSocialAccountId,personaid,ExternalPostId
                                   from SocialPost 
                                   where id=:socialpostid];
        
        system.debug('****SocialPersona.id****: '+fbsocialpost.personaid);
        
        system.debug('########### - fbsocialpost.id: ' + fbsocialpost.id);
        if(fbsocialpost.personaid!=null)
        {    
            if(fbsocialpost.MessageType == 'Private' || fbsocialpost.MessageType == 'Direct')
            {
                system.debug('########### - Cerco la social persona collegata al post');
                SocialPersona fbsocialpers = [select id,name,SN_AutomaticReply__c
                                                from SocialPersona 
                                                where id=:fbsocialpost.personaid limit 1];
                
                system.debug('########### - Se la social persona non ha avuto la notifica continuo');
                if (fbsocialpers.SN_AutomaticReply__c==false)
                {
                    SocialPost newPost = new SocialPost();
                    newPost.ParentId = fbsocialpost.parentid; // Id del paret record in questo caso il CASE ID
                    //newPost.OutboundSocialAccountId = fbsocialpost.OutboundSocialAccountId; // Id del SocialAccount 
                    newPost.ReplyToId = fbsocialpost.Id; // Id del SocialPost originale a cui risposndere
                    newpost.PersonaId = fbsocialpost.personaid;
                    system.debug('########### - Gestiamo solo i messaggi privati di FB (Private e TWT (direct)');
                    if(fbsocialpost.MessageType == 'Private')
                    {
                        system.debug('########### - if Private');
                        newPost.MessageType = 'Private';
                    }
                    else if(fbsocialpost.MessageType == 'Direct')
                    {
                        system.debug('########### - elseif Direct');
                        newPost.MessageType = 'Direct';
                    }
                    
                    system.debug('########### - setto il messaggio di risposta');
                    String AutoReplay_msg = Label.PO_AutoReplay;
                    newPost.Content = AutoReplay_msg;
                    
                    
                    system.debug('########### - instanzio il  QuickAction standard SocialPublisher action sul Case');
                    QuickAction.QuickActionRequest req = new QuickAction.QuickActionRequest();
                    req.quickActionName = Schema.Case.QuickAction.SocialPublisher;
                    system.debug('########### - setto il messaggio del quickaction');
                    req.record = newPost; 
                    req.contextId = fbsocialpost.parentid; //  Case ID per il context del  QuickAction
                    
                    system.debug('########### - attivo lo switch per impedire il loop nel trigger');
                    shouldIRun.stopTrigger();
                    
                    system.debug('########### - invoco il  QuickAction');
                    if(!Test.isRunningTest())
                    {
                        QuickAction.QuickActionResult res = QuickAction.performQuickAction(req);
                        system.debug('########### - esito del della chiamata al quickaction: ' + res);
                        system.debug('########### - se il quickaction da esito ok setto il flag sulla social persona per evitare di rispedire il messaggio'); 
                        
                        if (res.isSuccess()) 
                        {
                            system.debug('########### - if settaggio flag');
                            fbsocialpers.SN_AutomaticReply__c=true;
                            update fbsocialpers;
                        }
                    }
                }
            }
         }    
    }    
}
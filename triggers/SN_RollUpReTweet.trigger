trigger SN_RollUpReTweet on SocialPost (after insert ) {

    
    //roll up count su lookup (padre Case figlio Spostoratory)
    //field su Case Spost_Count__c tipo numerico
    Set <Id> CaseIdsReTw = new Set<Id> ();
    Set <Id> CaseIdsInbound = new Set<Id> ();
    Set <Id> CaseIdsOutbound = new Set<Id> ();
    List <Case> CaseSxReTw = new List<Case>();
    List <Case> CaseSxReTwClosed = new List<Case>();
     List <Case> CaseSxIn = new List<Case>();
    List <Case> CaseSxOut = new List<Case>();
    //List <AggregateResult> Spostsx = new List<AggregateResult>();
    List <SocialPost> Spostsx = new List<SocialPost>();
    
    
    if(Trigger.isInsert) {   
        for(SocialPost Spost:trigger.new){
            // gestione retweet
            System.debug('@@@ TRIGGER NEW Spost Spost.ParentId: ' + Spost.ParentId);
            if(Spost.MessageType=='Retweet'){
                CaseIdsReTw.add(Spost.ParentId);  
            }
            
            //gestione nuovo commento da social
            //System.debug('@@@ TRIGGER NEW Spost Spost.ParentId: ' + Spost.ParentId);
            if(Spost.MessageType!='Retweet' && Spost.IsOutbound==false){
                CaseIdsInbound.add(Spost.ParentId);  
            }
            
            if(Spost.MessageType!='Retweet' && Spost.IsOutbound==True){
                CaseIdsOutbound.add(Spost.ParentId);  
            }
                       
        }
    }
    
        
 
    

 
    System.debug('@@@ TRIGGER Spost CaseIdsReTw: ' + CaseIdsReTw);
    System.debug('@@@ TRIGGER Spost CaseIds: ' + CaseIdsInbound);
    
    try{
        if( Trigger.isInsert && CaseIdsReTw.size()>0 ){
            Group[] Qretweet=[select Id from group where DeveloperName ='Coda_SN_Social_Retweet' limit 1];
           
            for(Id cId:CaseIdsReTw){
                case c=new Case(Id=cId,SN_IsRetweet__c=true,OwnerID=Qretweet[0].id,Status='In Lavorazione');
                //case c=new Case(Id=cId,SN_IsRetweet__c=true); 
                CaseSxReTw.add(c);
            }
            System.debug('@@@ TRIGGER Spost UPDATE CaseSxReTw: ' + CaseSxReTw);
            update(CaseSxReTw);
            
            for(Id cId:CaseIdsReTw){
                case c=new Case(Id=cId,Status='Chiuso');
                //case c=new Case(Id=cId,SN_IsRetweet__c=true); 
                CaseSxReTwClosed.add(c);
            }
            System.debug('@@@ TRIGGER Spost UPDATE CaseSxReTw: ' + CaseSxReTw);
            update(CaseSxReTwClosed);
        }
        
        if(Trigger.isInsert && CaseIdsInbound.size()>0){
            //User[] DataInt= [select Id from User where FirstName='User'And LastName='Social'];
            for(Id cId:CaseIdsInbound){
                case c=new Case(Id=cId,SN_NuovoPost__c=true);
                CaseSxIn.add(c);
            }
            System.debug('@@@ TRIGGER Spost UPDATE CaseSx: ' + CaseSxIn);
            update(CaseSxIn);

        }

        if(Trigger.isInsert && CaseIdsOutbound.size()>0){
            //User[] DataInt= [select Id from User where FirstName='User'And LastName='Social'];
            for(Id cId:CaseIdsOutbound){
                case c=new Case(Id=cId,SN_NuovoPost__c=False);
                CaseSxOut.add(c);
            }
            System.debug('@@@ TRIGGER Spost UPDATE CaseSx: ' + CaseSxOut);
            update(CaseSxOut);

        }           
    }Catch(Exception e){
        System.debug('@@@ TRIGGER Spost Exception :'+e.getMessage());
    } 
}
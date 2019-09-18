/* Precondizione: Record type Ticket Provisioning & Stato acquisito/In lavorazione

- Condizione 1: Se Case.OwnerOld!=CurrentUser && Case.OwnerNew!=Case.OwnerOld --> Msg errore.

- Condizione 2: Se Case.OwnerOld==CurrentUser && Case.OwnerNew!=Case.OwnerOld && CurrentUser.profile==TP SOC 
&& Case.OwnerNew NOT IN ”TP Coda Nord; TP Coda Sud; TP Coda Centro;“ && Case.OwnerNew.Profile!=TP SOC --> Msg errore.

- Condizione 3: Se Case.OwnerOld==CurrentUser && Case.OwnerNew!=Case.OwnerOld && CurrentUser.profile==TP DELIVERY AREA 
&& Case.OwnerNew NOT IN ”TP Coda SOC;“ &&  Case.OwnerNew.Profile!=TP DELIVERY AREA --> Msg errore.
*/

trigger TP_Case_Assigned_rules on Case (before update) 
{    
    System.debug('***TP_Case_Assigned_rules__TRIGGER START***');

    RecordType rt_tp = [Select id, name
                        from RecordType 
                        where name = 'PO - TP - TicketProvisioning Case'
                        limit 1];
    
    List<String> listCode= new List<String>();
    listCode.add('TT - Coda SOC Ordini in Attivazione');
    listCode.add('TT - Coda Centro Ordini in Attivazione');
    listCode.add('TT - Coda Nord Ordini in Attivazione');
    listCode.add('TT - Coda Sud Ordini in Attivazione');
    //listCode.add('Incident - IT Operations');
    List<Group> listGroup= [select Id, name from Group where Type = 'Queue' and name =:listCode];
    map<String,Id> mapGroup= new map<String,Id>();
    for (Group g: listGroup){
       mapGroup.put(g.name,g.id);
    }
        
    Set<Id> setId=new Set<Id>();
    setId.add(userinfo.getUserId());
    for (Case c: Trigger.new){
            setId.add(c.OwnerId);
    }
    List<User> listUser = [select Id, name, profileId, profile.name 
                           from user 
                           where Id=:setId];

    User currentUser = new User();                     
    map<Id,User> mappina= new map<Id,User>();
    for (Case c: Trigger.new){
        for (User u: listUser) {
            if(c.OwnerId==u.id){
                mappina.put(c.Id,u);
            }
            if(u.Id==userinfo.getUserId()){
              currentUser=u;
            }
        }
    }

    System.debug('CURRENT USER PROFILE :'+currentUser.Profile.name);
    
    for (Case c: Trigger.new) {        
        Case old_case = Trigger.oldMap.get(c.ID);        
        //String old_case_OwnerId = Trigger.oldMap.get(c.ID).ownerid; 
        //String new_case_OwnerId = (String)c.id;  
        String initialOwn_ID = ((String)c.OwnerId).left(3);
        System.debug('***TP_Case_Assigned_rules__TRIGGER FOR***');        
        
        if(currentUser.Profile.name!='System Administrator'){

             if(c.RecordTypeId==rt_tp.id && ( 'Acquisito'.equalsIgnoreCase(c.Status) || 'In Lavorazione'.equalsIgnoreCase(c.Status)) ) {
            if('Segnalazione Provisioning'.equalsIgnoreCase(c.PO_TP_Causale_Apertura_Segnalazione__c))
            {
               /* System.debug('***TP_Case_Assigned_rules__TRIGGER - PRECONDIZIONE***');
                System.debug('***TP_Case_Assigned_rules__Old_case***: '+old_case.id+ ' '+old_case.casenumber);
                System.debug('***TP_Case_Assigned_rules__Old_caseOwnerID***: '+old_case.OwnerId);
                System.debug('***TP_Case_Assigned_rules__New_caseOwnerID***: '+c.ownerid);
                //System.debug('***TP_Case_Assigned_rules__New_caseOwnerProfileID***: '+c.owner.profileId); //NULL
                System.debug('***TP_Case_Assigned_rules__CurrentUser***: '+currentUser.Id+' '+currentUser.name);
                System.debug('***TP_Case_Assigned_rules__CurrentUserProfile***: '+currentUser.profileId+' '+currentUser.profile.name);
                System.debug('***TP_Case_Assigned_rules__id_profilo_SOC***: '+id_profilo_SOC); 
                //System.debug('***TP_Case_Assigned_rules__mappina.get(c.Id).profileId*** '+mappina.get(c.Id).profileId);               
                System.debug('****C.ID***: '+c.id);
                System.debug('****initialOwn_ID: '+initialOwn_ID);  */              

                //Condizione 1            
                if(old_case.OwnerId!=currentUser.id && c.ownerId!=old_case.OwnerId && c.OwnerId!=currentUser.id){
                    System.debug('***TP_Case_Assigned_rules__TRIGGER - PRIMO IF***');
                    c.addError('Non è possibile assegnare il case a questa utenza. (1)');                
                }                          
                //Condizione 2
                else if(old_case.OwnerId==currentUser.id && c.ownerid!=old_case.OwnerId && currentUser.profile.name=='TP Soc' 
                   && c.ownerId!=mapGroup.get('TT - Coda Centro Ordini in Attivazione') && c.ownerId!=mapGroup.get('TT - Coda Nord Ordini in Attivazione') && c.ownerId!=mapGroup.get('TT - Coda Sud Ordini in Attivazione')
                   && initialOwn_ID.equals('005') && mappina.get(c.Id).profile.Name!='TP Soc' /*&& mappina.get(c.Id).profileId!=tp_Soc.id*/) {
                    System.debug('***TP_Case_Assigned_rules__TRIGGER - SECONDO IF***');
                    c.addError('Non è possibile assegnare il case a questa utenza. (2)');
                }   
                //Condizione 3
                else if(old_case.OwnerId==currentUser.id && c.ownerid!=old_case.OwnerId && currentUser.profile.name=='TP Delivery Area' 
                   && c.ownerId!=mapGroup.get('TT - Coda SOC Ordini in Attivazione') && initialOwn_ID.equals('005') && mappina.get(c.Id).profile.Name!='TP Delivery Area' /* mappina.get(c.Id).profileId!=tp_Delivery.id*/) 
                {
                    System.debug('***TP_Case_Assigned_rules__TRIGGER - TERZO IF***');
                    c.addError('Non è possibile assegnare il case a questa utenza. (3)');
                }        
            }
            else {
                if(old_case.OwnerId!=currentUser.id && c.ownerId!=old_case.OwnerId && c.OwnerId!=currentUser.id){
                    System.debug('***TP_Case_Assigned_rules__TRIGGER - PRIMO IF (RAMO ELSE)***');
                    c.addError('Non è possibile assegnare il case a questa utenza. (1)');                
                }
                else if(old_case.OwnerId==currentUser.id && c.ownerid!=old_case.OwnerId && currentUser.profile.name=='TP Operations' 
                   && initialOwn_ID.equals('005') && mappina.get(c.Id).profile.Name!='TP Operations' /* mappina.get(c.Id).profileId!=tp_Op.id*/){
                    System.debug('***TP_Case_Assigned_rules__TRIGGER - SECONDO IF (RAMO ELSE)***');
                    c.addError('Non è possibile assegnare il case a questa utenza. (2)');
                }
            }
          }         
        }
    }
}
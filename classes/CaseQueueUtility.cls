public class CaseQueueUtility {
    
    public static void BeforeUpdate(list<case> vlstcase)
    {
      list<GroupMember> gmlst = [ Select id, userorgroupid,Group.Name from GroupMember where Group.Type = 'Queue' 
                        and group.name='TT - Coda SOC Ordini in Attivazione'];
       map<string,GroupMember> vmapgroupMembers = new map<string,GroupMember>();
        for(GroupMember gm : gmlst)
        {
            vmapgroupMembers.put(gm.UserOrGroupId,gm);
        }
       // system.debug('gmap========'+vmapgroupMembers);
       // system.debug('Login user========'+userinfo.getUserId());
           for(case cs : vlstcase)
            {
                 GroupMember gm =   vmapgroupMembers.get(userinfo.getUserId());
                 //system.debug('gm========'+gm);
                if( gm != null )
                {
                   cs.QueueName__c = gm.group.name;
                    //system.debug('IF Entering========'+cs.QueueName__c);
                    cs.SN_bypassValidation__c = true;
                }
                else
                {
                    cs.QueueName__c = '';
                    // system.debug('Else Entering========'+cs.QueueName__c);
                    cs.SN_bypassValidation__c = false;
                }
            }
        
       
        
    }

}
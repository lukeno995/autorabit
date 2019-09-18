@isTest   

public class SN_UpdateStatusInReply_TEST {
    
    @isTest static void TestUpdateStatus() {
        
         OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom;  
        
        SocialPost s1 = new SocialPost();        
        s1.provider = 'Facebook';
        s1.content = 'Prova contenuto';
        s1.name = 'Comment From: Utente TEST';
        insert s1;
        
        RecordType rt_social_req = [Select id, name
                                    from RecordType 
                                    where name = 'SN Social Request'
                                    limit 1];
        
        User u = [Select id, name
                 from User
                 where name = 'User Social'
                 limit 1];
        
        Case c1 = new Case();
        c1.recordTypeId = rt_social_req.Id;
        c1.status = 'Chiuso';
        c1.ownerId = u.id;
        
        Test.startTest();
        insert c1;  
        c1.status ='Inviato'; 
        update c1;
        Test.stopTest();       
    
    }
}
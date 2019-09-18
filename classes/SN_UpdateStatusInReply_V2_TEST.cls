@isTest
public class SN_UpdateStatusInReply_V2_TEST {
	 @isTest static void TestUpdateStatus() {
         
         
         
         RecordType rt_social_req = [Select id, name
                                    from RecordType 
                                    where name = 'SN Social Request'
                                    limit 1];

        Group gruppoRetw = [Select id, name, DeveloperName
                           from Group
                           where DeveloperName = 'Coda_SN_Social_Retweet'];
        
		Profile profilo = [SELECT Id, name
							FROM Profile 
							WHERE Name = 'SN - Social Operator'];

		UserRole ruolo = [SELECT id, name
							FROM UserRole
							WHERE name = 'Social Administrator'];

		User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = profilo.id;
        u.UserRoleId = ruolo.id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
        
        System.RunAs(u)
		{
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
        
        
        
        Case c1 = new Case();
        c1.recordTypeId = rt_social_req.Id;
        c1.status = 'Chiuso';
        c1.ownerId = u.id;
        
        
        Test.startTest();
        insert c1;  
        c1.status ='Inviato';
        c1.SourceId = s1.Id;
        update c1;
        Test.stopTest();   
        }
    
    }
}
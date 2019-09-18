@istest
public class PO_MyInfoComponentControllerTest {
    
    public static testmethod void EditContact() {
        
        //user usr = [Select FirstName,LastName,email,phone,ContactId, AccountId From User Where Id =:UserInfo.getUserId()];
        profile pr =    [SELECT id FROM profile where Name = 'System Administrator'];
        User u = new User();
        u.Firstname = 'mike';
        u.LastName = 'SmithTest';
        u.email = 'msmithtest@company.com';
        u.Alias = 'alias1';
        u.CommunityNickname = 'commnick1';
        u.EmailEncodingKey = 'UTF-8';
        u.Username = 'msmithtest@company.com';
        u.TimeZoneSidKey = 'America/Denver';
        u.LocaleSidKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'en_US';
        u.ProfileId = pr.Id;
        insert u;
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        account a = new account();
        a.RecordTypeId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        a.name = 'test';
        insert a;
        
        contact con = new contact();
        con.FirstName = u.FirstName;
        con.lastname = u.LastName;
        con.Email = u.email;
        con.PO_Contatto_telefonico__c = u.phone;
        con.PO_N_Licenza__c = 'test';
        con.PO_Struttura_di_appartenenza__c = 'test';
        con.AccountId = a.Id;
        con.id = u.ContactId;
        
        insert con;
        
        contact con1 = new contact(); 
        
        /* con1 = [Select FirstName,LastName, Email,PO_Contatto_telefonico__c,
PO_N_Licenza__c,
PO_Struttura_di_appartenenza__c
From Contact
Where Id =:con.id];*/
        
        user user = [Select Contact.Name,
                     Contact.FirstName,
                     Contact.LastName,
                     Contact.Email,
                     Contact.PO_Contatto_telefonico__c,                         
                     Contact.PO_N_Licenza__c,
                     Contact.PO_Struttura_di_appartenenza__c,
                     AccountId,
                     ContactId
                     From User Where Id = :UserInfo.getUserId()];
        
        PO_MyInfoComponentController edCon = new PO_MyInfoComponentController(); 
        edCon.usr.Id = userInfo.getUserId();   
        //edCon.saveIt();
        //edCon.cancelIt();
    }
}
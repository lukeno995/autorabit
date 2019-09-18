@isTest
public class EmailMessages_Test{
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    public static testMethod void EmailMessagesMethod(){
    
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
    
        List<Case> cseList = new List<Case>();
        Case cse = new Case();
        cse.Status = 'Acquisito';
        cse.ContactId = con.Id;
        cseList.add(cse);
        insert cseList;
        
        
        
        List<EmailMessage> outList= new List<EmailMessage>();
        EmailMessage outGoingMail= new EmailMessage();
        outGoingMail.fromaddress='test@test.com';
        outGoingMail.toAddress = 'con1.Email';
        outGoingMail.subject = 'Opt Out Test Message';
        outGoingMail.TextBody= 'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS';
        outGoingMail.parentid=cseList[0].id;
        outGoingMail.EmailBody__c = 'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS';
        outList.add(outGoingMail);
        insert outList;  
        
        List<Attachment> attachList=new List<Attachment>(); 
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=outList[0].id;
        attachList.add(attach);
        insert attachList;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(cseList[0]);
        EmailMessages  emsg = new EmailMessages(sc);
        ApexPages.currentPage().getParameters().put('id',outGoingMail.Id);
        emsg.contactmail = 'Test@gmail.com';
        emsg.fileName = attachList[0].Name;
        emsg.fileBody = attachList[0].body;
        // emsg.redirectReplymail();
        //emsg.Canceling();
        emsg.getEmail();
        emsg.getDisplayEmails();
        emsg.DisplayMessage();
        emsg.replyEmail();
        
        //AAemsg.replyEmailSocial();
        ApexPages.currentPage().getParameters().put('id',cseList[0].Id);
        emsg.replyEmailNew();
        emsg.redirectReplymailPagelayout();
        emsg.redirectReplymailPagelayoutNew();
        emsg.redirectReplymailNew();
        emsg.replyEmailRispondi();
        emsg.emailbody = 'tqwesat';
        emsg.replyEmailrelatedlist();
        emsg.CancelingNew();
        emsg.caseDetail();
        emsg.replymail =outList[0];
        emsg.ListOfcases = cseList;
        emsg.newAtt =attachList;
        emsg.redirectReplymail();
        emsg.Canceling();    
    }
}
public class EmailMessages {
    public case currentCase {get;set;}
    public case replyCase {get;set;}
    public List<case> ListOfcases{get;set;}
    public list<emailMessage> vlstMessages {get;set;}
    public string repemailid {get;set;}
    //public list<emailMessage> oneMessage {get;set;}
    public emailMessage oneMessage {get;set;}
    public string recid {get;set;}
    public emailMessage replymail {get;set;}
    public string emailbody {get;set;}
    public string contactmail {get;set;}
    public Attachment attachment{get;set;}
    public string idCaseEmail {get;set;}
    public string fileName{get;set;}
    public transient Blob fileBody{get;set;}
    public list<attachment> newAtt{get;set;}
    public string origMess {get;set;}
    public string caseOwnerId {get;set;}
    public string currentUserId {get;set;}
    public Case c {get;set;}
    public string header1 {get;set;}
    public string header2 {get;set;}
    public string footer {get;set;}
    public Case rispCase {get;set;}
    
    public EmailMessages(ApexPages.StandardController controller)
    {
        currentCase = (Case)controller.getRecord();
        
        attachment = new Attachment();
        idCaseEmail = ApexPages.currentPage().getParameters().get('parentid');
        repemailid = ApexPages.currentPage().getParameters().get('emailid');

        system.debug(' Costruttore============ '+idCaseEmail + ' ' + repemailid  + '  ' + currentCase.id);
        vlstMessages = [select id, EmailBody__c,parentid,FromAddress,ToAddress,TextBody,MessageDate,subject,FromName,status 
                        from emailmessage 
                        where parentid=:currentCase.id 
                        order by createddate desc];
                        
        if (repemailid != null){
            oneMessage = [select id, EmailBody__c,parentid,FromAddress,ToAddress,TextBody,MessageDate,subject,FromName,status 
                          from emailmessage 
                          where id=:repemailid 
                          order by createddate desc
                         ];
                         
            c = [Select ownerId from Case where id=:idCaseEmail];
            caseOwnerId = c.ownerId;
            currentUserId = userInfo.getUserId();
            
            rispCase = [select contactEmail,subject,id,contact.name,casenumber,origin,Tipologia_Cliente__c 
                        from case 
                        where id=:ApexPages.currentPage().getParameters().get('parentid')];
            
            header1 = 'Gentile '+rispCase.contact.name+',';
            header2 = 'di seguito la risposta alla tua richiesta numero '+rispCase.casenumber+'.';
            //footer = 'Grazie, Open Fiber';
            //origMess=oneMessage[0].TextBody;
        }
    }
    public pagereference caseDetail()
    {
      return new pagereference('/'+ currentCase.id + '?srKp=500&srPos=0');  
    }
   
    public pagereference redirectReplymailNew()
    {
        replyCase = [select contactEmail,subject,id,contact.name,casenumber,origin,Tipologia_Cliente__c,status,Previous_Status__c,closedDate from case where id=:currentCase.id];
       
        replymail = new emailMessage();
        string emailaddress = [select email from user where id=: userinfo.getUserId() limit 1].email;
        replymail.FromAddress = 'contattaci@openfiber.it';//emailaddress;
        replymail.ToAddress = replyCase.contactEmail;
        replymail.TextBody = emailbody;
        replymail.ParentId = replyCase.id;
        replymail.Subject = replyCase.Tipologia_Cliente__c;
       
        return new pagereference('/apex/RispondiButtonRedirectPage?parentid'+ currentCase.id);
    }
    
    public pagereference redirectReplymailPagelayout()
    {
         idCaseEmail = ApexPages.currentPage().getParameters().get('id');
        system.debug('idCaseEmail======='+idCaseEmail);
       
        replyCase = [select contactEmail,subject,id,contact.name,casenumber,origin,Tipologia_Cliente__c from case where id=:idCaseEmail];
       
        replymail = new emailMessage();
        string emailaddress = [select email from user where id=: userinfo.getUserId() limit 1].email;
        replymail.FromAddress = 'contattaci@openfiber.it';//emailaddress;
        replymail.ToAddress = replyCase.contactEmail;
        replymail.TextBody = emailbody;
        replymail.ParentId = replyCase.id;
        replymail.Subject = replyCase.Tipologia_Cliente__c;
       
        return new pagereference('/apex/RispondiReplyEmailPage?parentid'+ replyCase.id);
        // return new pagereference('/apex/SN_PageMess?parentid'+ currentCase.id);
    }
    
    public pagereference redirectReplymailPagelayoutNew()
    {
        replyCase = [select contactEmail,subject,id,contact.name,casenumber,origin,Tipologia_Cliente__c from 
                    case where id=:currentCase.id];
       
        replymail = new emailMessage();
        string emailaddress = [select email from user where id=: userinfo.getUserId() limit 1].email;
        replymail.FromAddress = 'contattaci@openfiber.it';//emailaddress;
        replymail.ToAddress = replyCase.contactEmail;
        replymail.TextBody = emailbody;
        replymail.ParentId = replyCase.id;
        replymail.Subject = replyCase.Tipologia_Cliente__c;
       
        return new pagereference('/apex/RispondiPageLayoutRelatedList?parentid'+ replyCase.id);
        // return new pagereference('/apex/RispondiButtonRedirectPage?parentid'+ currentCase.id); 
    }
    
    
    public emailMessage getEmail()
    {
        system.debug('current case============'+currentCase);
        replyCase = [select contactEmail,subject,id,contact.name,casenumber,origin,Tipologia_Cliente__c,Previous_Status__c,status,closedDate from case where id=:currentCase.id];
        replymail = new emailMessage();
        string emailaddress = [select email from user where id=: userinfo.getUserId() limit 1].email;
        replymail.FromAddress = 'contattaci@openfiber.it';// emailaddress;
        replymail.ToAddress = replyCase.contactEmail;
        replymail.TextBody = emailbody;
        replymail.ParentId = replyCase.id;
        replymail.Subject = replyCase.Tipologia_Cliente__c;
        
        return replymail;
    }
    
    public list<emailMessage> getDisplayEmails()
    {
        vlstMessages = [select id, EmailBody__c,parentid,FromAddress,ToAddress,TextBody,MessageDate,subject,FromName,status 
                        from emailmessage 
                        where parentid=:currentCase.id 
                        order by createddate desc];
        system.debug('vlstMessages====='+vlstMessages);
        
        return vlstMessages;
    }
    
    public pagereference redirectReplymail()
    {
        replymail = new emailMessage();
        string emailaddress = [select email from user where id=: userinfo.getUserId() limit 1].email;
        replymail.FromAddress = 'contattaci@openfiber.it';//emailaddress;
        replymail.ToAddress = replyCase.contactEmail;
        replymail.TextBody = emailbody;
        replymail.ParentId = replyCase.id;
        replymail.Subject = replyCase.Tipologia_Cliente__c;
       
        return new pagereference('/apex/replyEmail?parentid'+  replymail.ParentId);
    }
    
    public pagereference replyEmail()
    {
        try
        {
            insert replymail; 
            system.debug('replymail.TextBody========'+replymail.TextBody);
            /*********Start Rajani******/    
                //To update status field in case based on Email CreatedDate and ClosedDate
            /*   emailmessage mymsg = [select id,parentid,parent.closedDate,createddate from emailmessage where parentid=:replymail.parentid
                                 order by CreatedDate Desc limit 1];
            if(replymail!=null){
                system.debug('days==='+mymsg.parent.closeddate.date().daysBetween(mymsg.createddate.date()));
                integer noofdays =mymsg.parent.closeddate.date().daysBetween(mymsg.createddate.date());
                
                ListOfcases= [select contactEmail,Previous_Status__c,CreatedDate,ClosedDate,status,subject,id,contact.name,casenumber,origin,Tipologia_Cliente__c from case where id=:currentCase.id];
                
                List<case> csList = new List<case>();
                for(case cse:ListOfcases){
                   // Datetime CreatedDate = cse.CreatedDate;
                    //Datetime ClosedDate = cse.ClosedDate;
                    //Integer numberDaysDue = CreatedDate.Date().daysBetween(ClosedDate.Date());
                    if(noofdays<=5 && cse.Status == 'Chiuso'){
                            
                            cse.Status= cse.Previous_Status__c;
                            csList.add(cse);
                     }
                
                   }
                    if(!csList.isEmpty()){  
                        update csList;
                    }
               } */
               
             /*********End Rajani******/     
            
            if(replymail.TextBody.length()>50)
            {
                replymail.EmailBody__c = replymail.TextBody.substring(0,50);
                update replymail;
            }
            else
            {
                replymail.EmailBody__c = replymail.TextBody;
                update replymail;
                system.debug('testing====='+replymail);
            }
            attachment.OwnerId = UserInfo.getUserId();
            attachment.ParentId = replymail.id;
            //attachment.IsPrivate = true;
            attachment.name = fileName;
            attachment.body = fileBody;
            
            
            system.debug('Comming here in try==>'+attachment);
            insert attachment;
            
            if(attachment.id != null)
            {
                newAtt = [select id,name,createddate,parentid,ownerid from attachment where id =:attachment.id];
            }
        }
        catch(exception e)
        {
            system.debug('error======'+e.getStackTraceString());
            system.debug('Comming here in catch==>'+attachment);
            system.debug('error====='+e.getStackTraceString());
        }
        finally {
            system.debug('Comming here in finally==>'+attachment);
            attachment.body = null;
            attachment = new Attachment();
        }
        string imgid = System.Label.PinkLogo;
        string reportmail = '';
        reportmail += '<center>';
        reportmail += '<table id="topTable" width="500" cellspacing="0" cellpadding="0">';
        reportmail += '<tbody>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r1st1; blabel: header; vertical-align: top; height: 60; text-align: left;">';
        reportmail += '<img id="r1sp1" src="https://c.cs87.content.force.com/servlet/servlet.ImageServer?id=0158E000000hsiO&oid=00D8E0000009QhN&lastMod=1531913440000" border="0" /></td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r2st1; blabel: accent1; height: 0;">&nbsp;</td>';
        reportmail += ' </tr>';
        reportmail += '<tr valign="top">';
        reportmail += ' <td style="background-color: #ffffff; beditid: r3st1; color: #000000; blabel: main; font-size: 12pt; font-family: arial;" height="300">';
        reportmail += '<table border="0" width="550" cellspacing="5" cellpadding="5">';
        reportmail += '  <tbody>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r3st1; color: #000000; blabel: main; font-size: 12pt; font-family: arial;">';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">Gentile&nbsp;</span>';
        reportmail += '<span style="color: #1f497d; font-family: arial;">';
        reportmail += replyCase.Contact.Name;
        reportmail += '</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">,</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">di seguito la risposta alla tua richiesta numero&nbsp;</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">' + replyCase.CaseNumber +'</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">:</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">' + replymail.TextBody +'</span>';
        
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"> <br /> </span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"> <br /></span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"><br /> </span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">Grazie&nbsp;</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-family: arial;">Open Fiber</span>';
        reportmail += '</p>';
        
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        //Add by PG - FIX Contattaci 3-01 - Correzione Testo Disclaimer
        //reportmail += '<span style="color: #1f497d; font-family: arial;">Questo indirizzo email non è presidiato, si prega di non rispondere all’email.</span>';
        reportmail += '<span style="color: #1f497d; font-family: arial;">Questo è un messaggio automatico; pertanto, si prega di non rispondere all’email.</span>';
        
        reportmail += '</p>';
        
        reportmail += '</td>';
        reportmail += '</tr>';
        reportmail += '</tbody>';
        reportmail += '</table>';
        reportmail += '</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r4st1; blabel: accent2; height: 0;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r5st1; blabel: footer; vertical-align: top; height: 0; text-align: left;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r6st1; blabel: accent3; height: 0;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '</tbody>';
        reportmail += '</table>';
        reportmail += '</center>';
        
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();     
        
        // Step 1: Create a new Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Step 2: Set list of people who should get the email
        List<String> sendTo = new List<String>();
        
        sendTo.add(replymail.ToAddress);
        mail.setToAddresses(sendTo);
        
        // Step 3: Set who the email is sent from
        mail.setReplyTo('noreply@gmail.com'); // change it with your mail address.
        mail.setSenderDisplayName('salesforce User'); 
        
        // Step 4. Set email contents - you can use variables!
        //Add by PG - FIX Contattaci 3-01 - Correzione setSubject Email
        mail.setSubject('Open Fiber Contattaci: ' + replyCase.CaseNumber);
        //mail.setSubject(replyCase.Tipologia_Cliente__c);
        
        mail.setHtmlBody(reportmail);
        
        // Step 5. Add your email to the master list
        mails.add(mail);
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        for (Attachment a : [select Name, Body, BodyLength from Attachment where ParentId = :replymail.Id])
        {
            // Add to attachment file list
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
            efa.setFileName(a.Name);
            efa.setBody(a.Body);
            fileAttachments.add(efa);
        }
        mail.setFileAttachments(fileAttachments);
        // Step 6: Send all emails in the master list
        Messaging.sendEmail(mails);
        string recid = apexpages.currentPage().getParameters().get('id');
        return new pagereference('/console?id'+replymail.parentid);
    }
    
    public pagereference replyEmailNew()
    {
        try
        {
            insert replymail; 
            system.debug('replymail.TextBody========'+replymail.TextBody);
            if(replymail.TextBody.length()>50)
            {
                replymail.EmailBody__c = replymail.TextBody.substring(0,50);
                update replymail;
            }
            else
            {
                replymail.EmailBody__c = replymail.TextBody;
                update replymail;
            }
            attachment.OwnerId = UserInfo.getUserId();
            attachment.ParentId = replymail.id;
            //attachment.IsPrivate = true;
            attachment.name = fileName;
            attachment.body = fileBody;
            
            
            system.debug('Comming here in try==>'+attachment);
            insert attachment;
            
            if(attachment.id != null)
            {
                newAtt = [select id,name,createddate,parentid,ownerid from attachment where id =:attachment.id];
            }
       
            
        }
        catch(exception e)
        {
            system.debug('error======'+e.getStackTraceString());
            system.debug('Comming here in catch==>'+attachment);
            system.debug('error====='+e.getStackTraceString());
        }
        finally {
            system.debug('Comming here in finally==>'+attachment);
            attachment.body = null;
            attachment = new Attachment();
        }
        string imgid = System.Label.PinkLogo;
        string reportmail = '';
        reportmail += '<center>';
        reportmail += '<table id="topTable" width="500" cellspacing="0" cellpadding="0">';
        reportmail += '<tbody>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r1st1; blabel: header; vertical-align: top; height: 60; text-align: left;">';
        reportmail += '<img id="r1sp1" src="https://c.cs87.content.force.com/servlet/servlet.ImageServer?id=0158E000000hsiO&oid=00D8E0000009QhN&lastMod=1531913440000" border="0" /></td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r2st1; blabel: accent1; height: 0;">&nbsp;</td>';
        reportmail += ' </tr>';
        reportmail += '<tr valign="top">';
        reportmail += ' <td style="background-color: #ffffff; beditid: r3st1; color: #000000; blabel: main; font-size: 12pt; font-family: arial;" height="300">';
        reportmail += '<table border="0" width="550" cellspacing="5" cellpadding="5">';
        reportmail += '  <tbody>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r3st1; color: #000000; blabel: main; font-size: 12pt; font-family: arial;">';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        
        //Header
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">Gentile&nbsp;</span>';
        reportmail += '<span style="color: #1f497d; font-family: arial;">';
        reportmail += replyCase.Contact.Name ;
        reportmail += '</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">,</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">di seguito la risposta alla tua richiesta numero&nbsp;</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">' + replyCase.CaseNumber +'</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">:</span>';
        reportmail += '</p>';
        //Header
        
        //Body
        reportmail += '<p class="MsoNormal">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">' + replymail.TextBody +'</span>';
        //Body
        
        //Footer
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"> <br /> </span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"> <br /></span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"><br /> </span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">Grazie&nbsp;</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-family: arial;">Open Fiber</span>';
        reportmail += '</p>';
        
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        //Add by PG - FIX Contattaci 3-01 - Correzione Testo Disclaimer
        //reportmail += '<span style="color: #1f497d; font-family: arial;">Questo indirizzo email non è presidiato, si prega di non rispondere all’email.</span>';
        reportmail += '<span style="color: #1f497d; font-family: arial;">Questo è un messaggio automatico; pertanto, si prega di non rispondere all’email.</span>';
        reportmail += '</p>';
        
        reportmail += '</td>';
        reportmail += '</tr>';
        reportmail += '</tbody>';
        reportmail += '</table>';
        reportmail += '</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r4st1; blabel: accent2; height: 0;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r5st1; blabel: footer; vertical-align: top; height: 0; text-align: left;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r6st1; blabel: accent3; height: 0;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '</tbody>';
        reportmail += '</table>';
        reportmail += '</center>';
        //Footer
        
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();     
        
        // Step 1: Create a new Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Step 2: Set list of people who should get the email
        List<String> sendTo = new List<String>();
        
        sendTo.add(replymail.ToAddress);
        mail.setToAddresses(sendTo);
        
        // Step 3: Set who the email is sent from
        mail.setReplyTo('noreply@gmail.com'); // change it with your mail address.
        mail.setSenderDisplayName('salesforce User'); 
        
        // Step 4. Set email contents - you can use variables!
        //Add by PG - FIX Contattaci 3-01 - Correzione setSubject Email
        mail.setSubject('Open Fiber Contattaci: ' + replyCase.CaseNumber);
        //mail.setSubject(replyCase.Tipologia_Cliente__c);
    
        mail.setHtmlBody(reportmail);
        
        // Step 5. Add your email to the master list
        mails.add(mail);
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        for (Attachment a : [select Name, Body, BodyLength from Attachment where ParentId = :replymail.Id])
        {
        // Add to attachment file list
        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName(a.Name);
        efa.setBody(a.Body);
        fileAttachments.add(efa);
        }
        mail.setFileAttachments(fileAttachments);
        // Step 6: Send all emails in the master list
        Messaging.sendEmail(mails);
       
        return new pagereference('/apex/EmailMessagesPage?id'+replymail.parentid);
    }
     public pagereference replyEmailRispondi()
     {
        
        try
        {
        
            insert replymail; 
            system.debug('replymail.TextBody========'+replymail.TextBody);
                
            /*********Start Rajani******/    
            //To update status field in case based on Email CreatedDate and ClosedDate
        /*  emailmessage mymsg = [select id,parentid,parent.closedDate,createddate from emailmessage where parentid=:replymail.parentid
                                 order by CreatedDate Desc limit 1];
            if(replymail!=null){
                system.debug('days==='+mymsg.parent.closeddate.date().daysBetween(mymsg.createddate.date()));
                integer noofdays = mymsg.parent.closeddate.date().daysBetween(mymsg.createddate.date());
                
                ListOfcases= [select contactEmail,Previous_Status__c,CreatedDate,ClosedDate,status,subject,id,contact.name,casenumber,origin,Tipologia_Cliente__c from case where id=:currentCase.id];
                
                List<case> csList = new List<case>();
                for(case cse:ListOfcases){
                   // Datetime CreatedDate = cse.CreatedDate;
                   // Datetime ClosedDate = cse.ClosedDate;
                   // Integer numberDaysDue = CreatedDate.Date().daysBetween(ClosedDate.Date());
                    if(noofdays<=5 && cse.Status == 'Chiuso'){
                            cse.Status= cse.Previous_Status__c;
                            csList.add(cse);
                     }
                     
                    if(replymail.TextBody.length()>50)
                    {
                        replymail.EmailBody__c = replymail.TextBody.substring(0,50);
                        
                    }
                    else
                    {
                        replymail.EmailBody__c = replymail.TextBody;
                        
                    }
                
                   }
                    if(!csList.isEmpty()){  
                        update csList;
                    }
                    
                    
               } */
            /*********End Rajani******/ 
           
            attachment.OwnerId = UserInfo.getUserId();
            attachment.ParentId = replymail.id;
            //attachment.IsPrivate = true;
            attachment.name = fileName;
            attachment.body = fileBody;
            
            
            system.debug('Comming here in try==>'+attachment);
            insert attachment;
            
            if(attachment.id != null)
            {
                newAtt = [select id,name,createddate,parentid,ownerid from attachment where id =:attachment.id];
            }
        }
        catch(exception e)
        {
            system.debug('error======'+e.getStackTraceString());
            system.debug('Comming here in catch==>'+attachment);
            system.debug('error====='+e.getStackTraceString());
        }
        finally {
            system.debug('Comming here in finally==>'+attachment);
            attachment.body = null;
            attachment = new Attachment();
        }
        string imgid = System.Label.PinkLogo;
        string reportmail = '';
        reportmail += '<center>';
        reportmail += '<table id="topTable" width="500" cellspacing="0" cellpadding="0">';
        reportmail += '<tbody>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r1st1; blabel: header; vertical-align: top; height: 60; text-align: left;">';
        reportmail += '<img id="r1sp1" src="https://c.cs87.content.force.com/servlet/servlet.ImageServer?id=0158E000000hsiO&oid=00D8E0000009QhN&lastMod=1531913440000" border="0" /></td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r2st1; blabel: accent1; height: 0;">&nbsp;</td>';
        reportmail += ' </tr>';
        reportmail += '<tr valign="top">';
        reportmail += ' <td style="background-color: #ffffff; beditid: r3st1; color: #000000; blabel: main; font-size: 12pt; font-family: arial;" height="300">';
        reportmail += '<table border="0" width="550" cellspacing="5" cellpadding="5">';
        reportmail += '  <tbody>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r3st1; color: #000000; blabel: main; font-size: 12pt; font-family: arial;">';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">Gentile&nbsp;</span>';
        reportmail += '<span style="color: #1f497d; font-family: arial;">';
        reportmail += replyCase.Contact.Name ;
        reportmail += '</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">,</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">di seguito la risposta alla tua richiesta numero&nbsp;</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">' + replyCase.CaseNumber +'</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">:</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">' + replymail.TextBody +'</span>';
        
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"> <br /> </span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"> <br /></span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"><br /> </span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">Grazie&nbsp;</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-family: arial;">Open Fiber</span>';
        reportmail += '</p>';
        
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        //Add by PG - FIX Contattaci 3-01 - Correzione Testo Disclaimer
        //reportmail += '<span style="color: #1f497d; font-family: arial;">Questo indirizzo email non è presidiato, si prega di non rispondere all’email.</span>';
        reportmail += '<span style="color: #1f497d; font-family: arial;">Questo è un messaggio automatico; pertanto, si prega di non rispondere all’email.</span>';
        
        reportmail += '</p>';
        
        reportmail += '</td>';
        reportmail += '</tr>';
        reportmail += '</tbody>';
        reportmail += '</table>';
        reportmail += '</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r4st1; blabel: accent2; height: 0;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r5st1; blabel: footer; vertical-align: top; height: 0; text-align: left;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r6st1; blabel: accent3; height: 0;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '</tbody>';
        reportmail += '</table>';
        reportmail += '</center>';
        
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();     
        
        // Step 1: Create a new Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Step 2: Set list of people who should get the email
        List<String> sendTo = new List<String>();
        
        sendTo.add(replymail.ToAddress);
        mail.setToAddresses(sendTo);
        
        // Step 3: Set who the email is sent from
        mail.setReplyTo('noreply@gmail.com'); // change it with your mail address.
        mail.setSenderDisplayName('salesforce User'); 
        
        // Step 4. Set email contents - you can use variables!
        //Add by PG - FIX Contattaci 3-01 - Correzione setSubject Email
        mail.setSubject('Open Fiber Contattaci: ' + replyCase.CaseNumber);
        //mail.setSubject(replyCase.Tipologia_Cliente__c);
        
        mail.setHtmlBody(reportmail);
        
        // Step 5. Add your email to the master list
        mails.add(mail);
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        for (Attachment a : [select Name, Body, BodyLength from Attachment where ParentId = :replymail.Id])
        {
        // Add to attachment file list
        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName(a.Name);
        efa.setBody(a.Body);
        fileAttachments.add(efa);
        }
        mail.setFileAttachments(fileAttachments);
        // Step 6: Send all emails in the master list
        Messaging.sendEmail(mails);
       
        return new pagereference('/'+replymail.parentid);
    }
    
    //MOD - PG
    public pagereference replyEmailrelatedlist()
    {
        //AA 15/10/2018 - Controllo per body vuoto
        if(String.isBlank(emailbody) ){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error!! Inserire il body della mail!'));
            return null;
        }
        //FINE AA
        system.debug('@@@@@ INSIDE REPLY REL LISt prima try======');
        
        try
        {
            system.debug('currentid======'+ApexPages.currentPage().getParameters().get('parentid'));
       
            replyCase = [select contactEmail,subject,id,contact.name,casenumber,origin,Tipologia_Cliente__c 
                        from case 
                        where id=:ApexPages.currentPage().getParameters().get('parentid')];
                        
            system.debug('currentid======'+replyCase.contactEmail + ' userid: ' + userinfo.getUserId());
            replymail = new emailMessage();
            string emailaddress = [select email 
                                    from user 
                                    where id=: userinfo.getUserId() limit 1].email;
            system.debug('emailaddress======'+emailaddress);
            
            //replymail.FromAddress = emailaddress;
            replymail.FromAddress = 'contattaci@openfiber.it';
            system.debug('************* replymailFromAddress======'+replymail.FromAddress);
            system.debug('currentid======'+replyCase.contactEmail);
            replymail.ToAddress = replyCase.contactEmail;
            replymail.TextBody = emailbody;
            replymail.ParentId = ApexPages.currentPage().getParameters().get('parentid');
            replymail.EmailBody__c = emailbody;
            
            if (emailbody.length()>50){
                if(emailbody.length() > 99){
                    replymail.EmailBody__c = emailbody.substring(0,99);
                }else{
                    replymail.EmailBody__c = emailbody.substring(0, emailbody.length());
                } 
                //replymail.EmailBody__c = emailbody.substring(0,99);
            }
            replymail.Subject = 'Open Fiber Contattaci: ' + replyCase.CaseNumber;  //replyCase.Tipologia_Cliente__c;
            system.debug('@@@@@@@@@@@ Prima di insert email'+replymail.TextBody);
            insert replymail; 
            system.debug('replymail.TextBody========'+replymail.TextBody);
            
            /*********Start Rajani******/    
                //To update status field in case based on Email CreatedDate and ClosedDate
            /*   emailmessage mymsg = [select id,parentid,parent.closedDate,createddate from emailmessage where parentid=:replymail.parentid
                                 order by CreatedDate Desc limit 1];
            if(replymail!=null){
                system.debug('days==='+mymsg.parent.closeddate.date().daysBetween(mymsg.createddate.date()));
                integer noofdays =mymsg.parent.closeddate.date().daysBetween(mymsg.createddate.date());
                
                ListOfcases= [select contactEmail,Previous_Status__c,CreatedDate,ClosedDate,status,subject,id,contact.name,casenumber,origin,Tipologia_Cliente__c from case where id=:currentCase.id];
                
                List<case> csList = new List<case>();
                for(case cse:ListOfcases){
                   // Datetime CreatedDate = cse.CreatedDate;
                    //Datetime ClosedDate = cse.ClosedDate;
                    //Integer numberDaysDue = CreatedDate.Date().daysBetween(ClosedDate.Date());
                    if(noofdays<=5 && cse.Status == 'Chiuso'){
                            cse.Status= cse.Previous_Status__c;
                            csList.add(cse);
                     }
                   }
                    if(!csList.isEmpty()){  
                        update csList;
                    }
               } */
               
            /*********End Rajani******/     
            
            if(replymail.TextBody.length()>50)
            {
                replymail.EmailBody__c = replymail.TextBody.substring(0,50);
                update replymail;
            }
            else
            {
                replymail.EmailBody__c = replymail.TextBody;
                update replymail;
                system.debug('testing====='+replymail);
            }
            attachment.OwnerId = UserInfo.getUserId();
            attachment.ParentId = replymail.id;
            //attachment.IsPrivate = true;
            attachment.name = fileName;
            attachment.body = fileBody;
            
            
            system.debug('Comming here in try==>'+attachment);
            insert attachment;
            
            if(attachment.id != null)
            {
                newAtt = [select id,name,createddate,parentid,ownerid from attachment where id =:attachment.id];
            }
        }
        catch(exception e)
        {
            system.debug('error======'+e.getStackTraceString());
            system.debug('Comming here in catch==>'+attachment);
            system.debug('error====='+e.getStackTraceString());
        }
        finally {
            system.debug('Comming here in finally==>'+attachment);
            attachment.body = null;
            attachment = new Attachment();
        }
        string imgid = System.Label.PinkLogo;
        system.debug('+++++++++++++++ PINK LOG: ' + imgid);
        string reportmail = '';
        reportmail += '<center>';
        reportmail += '<table id="topTable" width="500" cellspacing="0" cellpadding="0">';
        reportmail += '<tbody>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r1st1; blabel: header; vertical-align: top; height: 60; text-align: left;">';
        reportmail += '<img id="r1sp1" src="https://c.cs87.content.force.com/servlet/servlet.ImageServer?id=0158E000000hsiO&oid=00D8E0000009QhN&lastMod=1531913440000" border="0" /></td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r2st1; blabel: accent1; height: 0;">&nbsp;</td>';
        reportmail += ' </tr>';
        reportmail += '<tr valign="top">';
        reportmail += ' <td style="background-color: #ffffff; beditid: r3st1; color: #000000; blabel: main; font-size: 12pt; font-family: arial;" height="300">';
        reportmail += '<table border="0" width="550" cellspacing="5" cellpadding="5">';
        reportmail += '  <tbody>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r3st1; color: #000000; blabel: main; font-size: 12pt; font-family: arial;">';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">Gentile&nbsp;</span>';
        reportmail += '<span style="color: #1f497d; font-family: arial;">';
        reportmail += replyCase.Contact.Name ;
        reportmail += '</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">,</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">di seguito la risposta alla tua richiesta numero&nbsp;</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">' + replyCase.CaseNumber +'</span>';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">:</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">' + replymail.TextBody +'</span>';
        
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"> <br /> </span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"> <br /></span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;"><br /> </span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-size: 12pt;">Grazie&nbsp;</span>';
        reportmail += '</p>';
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        reportmail += '<span style="color: #1f497d; font-family: arial;">Open Fiber</span>';
        reportmail += '</p>';
        reportmail += '<br>';
        
        reportmail += '<p class="MsoNormal" style="color: #000000;">';
        //Add by PG - FIX Contattaci 3-01 - Correzione Testo Disclaimer
        //reportmail += '<span style="color: #1f497d; font-family: arial;">Questo indirizzo email non è presidiato, si prega di non rispondere all’email.</span>';
        reportmail += '<span style="color: #1f497d; font-family: arial;">Questo è un messaggio automatico; pertanto, si prega di non rispondere all’email.</span>';
        
        reportmail += '</p>';
        reportmail += '</td>';
        reportmail += '</tr>';
        reportmail += '</tbody>';
        reportmail += '</table>';
        reportmail += '</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r4st1; blabel: accent2; height: 0;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r5st1; blabel: footer; vertical-align: top; height: 0; text-align: left;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '<tr valign="top">';
        reportmail += '<td style="background-color: #ffffff; beditid: r6st1; blabel: accent3; height: 0;">&nbsp;</td>';
        reportmail += '</tr>';
        reportmail += '</tbody>';
        reportmail += '</table>';
        reportmail += '</center>';
        
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();     
        
        // Step 1: Create a new Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //AA 15/10/2018 - Modifica per nascondere email dell'utente salesforce
        OrgWideEmailAddress[] owea = [select Id, Address from OrgWideEmailAddress where DisplayName = 'Contattaci OpenFiber'];        
        if ( owea.size() > 0 ) {
            mail.setOrgWideEmailAddressId(owea.get(0).Id);
            mail.setReplyTo(owea.get(0).Address);
        }
        //FINE AA 15/10/2018
        // Step 2: Set list of people who should get the email
        List<String> sendTo = new List<String>();
        
        sendTo.add(replymail.ToAddress);
        mail.setToAddresses(sendTo);
        
        // Step 3: Set who the email is sent from
        /*AA 15/10/2018 - Modifica per nascondere email dell'utente salesforce
            mail.setReplyTo('noreply@gmail.com'); // change it with your mail address.
            mail.setSenderDisplayName('salesforce User');             
        * FINE AA 
        */
        // Step 4. Set email contents - you can use variables!
        //Add by PG - FIX Contattaci 3-01 - Correzione setSubject Email
        mail.setSubject('Open Fiber Contattaci: ' + replyCase.CaseNumber);
        //mail.setSubject(replyCase.Tipologia_Cliente__c);
        
        mail.setHtmlBody(reportmail);
        
        // Step 5. Add your email to the master list
        mails.add(mail);
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        for (Attachment a : [select Name, Body, BodyLength from Attachment where ParentId = :replymail.Id])
        {
        // Add to attachment file list
        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName(a.Name);
        efa.setBody(a.Body);
        fileAttachments.add(efa);
        }
        mail.setFileAttachments(fileAttachments);
        // Step 6: Send all emails in the master list
        Messaging.sendEmail(mails);
        string recid = apexpages.currentPage().getParameters().get('id');
        
        PageReference orderPage = new PageReference('/' + replymail.parentid);
        orderPage.setRedirect(true);
        return orderPage;

       // return new pagereference('/'+replymail.parentid);
       
    }
    public pagereference DisplayMessage()
    {
        recid = ApexPages.currentPage().getParameters().get('id');
        
        return new pagereference('/'+replymail.id);
    }
    public pagereference Canceling()
    {
         recid = ApexPages.currentPage().getParameters().get('id');
      // return new pagereference('https://cs87.salesforce.com/console?id=5008E00000AM9FH'replymail.parentid+'?srPos=0&srKp=500');
       
       return new pagereference('/console?id'+replycase.id);
    }
    public pagereference CancelingNew()
    {
        return new pagereference('/'+replymail.parentid);
    }
     public pagereference CancelingMessage()
    {
        return new pagereference('/'+oneMessage.parentid);
    }
    
}
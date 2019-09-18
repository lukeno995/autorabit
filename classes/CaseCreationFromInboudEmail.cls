global class CaseCreationFromInboudEmail implements Messaging.InboundEmailHandler{   
    public class applicationException extends Exception {} 
    public static Id caseId;
    public static String Subject = '';
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope){     
        EmailServiceVerificationCodeHandler esv = new EmailServiceVerificationCodeHandler();
            esv.log(email,envelope);
        Messaging.InboundEmailResult results = new Messaging.InboundEmailresult();
        Subject = email.subject;        
        Boolean Res = CaseCreationFromInboudEmail.contactCreationFromEmail(email.plainTextBody,email);
        
        if(Res == true){   
            // CaseCreationFromInboudEmail.InsertAttachment(caseId,email);
            results.success = true;
            return results;
        }
        results.success = false;
        return results;
    }
    
    public static Boolean contactCreationFromEmail(String body, Messaging.InboundEmail email){
        String citt='';
        Id contactRecordType = Schema.SObjectType.contact.getRecordTypeInfosByName().get('SN Social Contact').getRecordTypeId();        
        if((subject.ContainsIgnoreCase('Residenziale')) || (subject.ContainsIgnoreCase('Business')) || (subject.ContainsIgnoreCase('PA')) || (subject.containsIgnoreCase('Amministratore di condominio')) || (subject.ContainsIgnoreCase('Istituzione Finanziaria')) ){            
            String[] bodyArr = body.split('\n');
            system.debug('bodyArr==='+bodyArr);
            Contact con = new Contact();
            con.RecordTypeId = contactRecordType;
            
            if(bodyArr.size() > 0){      
                system.debug('bodyArr.size()'+bodyArr.size());      
                for(Integer i = 0; i < bodyArr.size(); i++ ){
                    if(bodyArr[i].contains('Nome:')){    
                        //C1- Commentato poichè da CR anche Business PA e Amm.Cond. devon avere nome e cognome
                        //if(!subject.ContainsIgnoreCase('Istituzione Finanziaria')){
                        if( bodyArr[i].split(':').size() > 1){
                            con.FirstName = bodyArr[i].split(':')[1];
                        }
                        //}
                    }
                    if(bodyArr[i].contains('Cognome:')){                 
                        //C1 - Vedi su
                        //if(!subject.ContainsIgnoreCase('Istituzione Finanziaria')){
                        if( bodyArr[i].split(':').size() > 1){
                            con.LastName = bodyArr[i].split(':')[1]; 
                        }
                        //}
                    }
                    /*if(bodyArr[i].contains('Istituzione Finanziaria:')){
                        if(subject.ContainsIgnoreCase('Istituzione Finanziaria')){
                            if( bodyArr[i].split(':').size() > 1){
                                con.LastName = bodyArr[i].split(':')[1]; 
                            }
                        }
                    }*/
                    if(bodyArr[i].contains('Indirizzo:')){
                        if( bodyArr[i].split(':').size()>1){
                            con.Indirizzo__c = bodyArr[i].split(':')[1];  
                        }                    
                    }
                    if(bodyArr[i].contains('Civico:')){
                        if( bodyArr[i].split(':').size()>1){
                            con.Civico__c = bodyArr[i].split(':')[1];     
                        }                   
                    }
                    if(bodyArr[i].contains('CAP:')){
                        if( bodyArr[i].split(':').size()>1){
                            con.CAP__c = bodyArr[i].split(':')[1];
                        }
                    }
                    if(bodyArr[i].contains('Città')){
                        if( bodyArr[i].split(':').size()>1){
                            citt = bodyArr[i].split(':')[1];
                            citt = citt.trim();
                        }
                    }
                    if(bodyArr[i].contains('Email')){
                        if( bodyArr[i].split(':').size()>1){
                            con.Email = bodyArr[i].split(':')[1].stripHtmlTags();
                        }
                    }
                    if(bodyArr[i].contains('Telefono:')){
                        if( bodyArr[i].split(':').size()>1){
                            con.Phone= bodyArr[i].split(':')[1];
                        }
                    }
                    //Add by PG - 7-01 - FIX - Il name del Contact deve essere sempre Nome + Cognome
                    /*
                    if(bodyArr[i].contains('Ragione Sociale:')){
                        if(subject.ContainsIgnoreCase('Business')){   
                            if( bodyArr[i].split(':').size()>1){
                                con.LastName = bodyArr[i].split(':')[1];
                            }
                        }
                    }
                    */
                    //Add by PG - 7-01 - Aggiunto campo Ragione Sociale
                    if(bodyArr[i].contains('Ragione Sociale:')){
                        if(subject.ContainsIgnoreCase('Business')){   
                            if( bodyArr[i].split(':').size()>1){
                                con.Ragione_Sociale__c = bodyArr[i].split(':')[1];
                            }
                        }
                    }
                    
                    if(bodyArr[i].contains('P.IVA:')){
                        if( bodyArr[i].split(':').size()>1){
                            con.P_IVA_Codice_Fiscale__c = bodyArr[i].split(':')[1];
                        }
                    }
                    if(bodyArr[i].contains('Ente:')){
                        if( bodyArr[i].split(':').size()>1){
                            con.Ente__c = bodyArr[i].split(':')[1];
                        }
                        //Add by PG - 7-01 - FIX - Il name del Contact deve essere sempre Nome + Cognome
                        /*
                        if(subject.ContainsIgnoreCase('PA')){
                            if( bodyArr[i].split(':').size()>1){
                                con.LastName = bodyArr[i].split(':')[1];
                            }
                        }
                        */
                    }
                    if(bodyArr[i].contains('NDipendenti:')){
                        if( bodyArr[i].split(':').size()>1){
                            con.n_Dipendenti__c = bodyArr[i].split(':')[1];
                        }
                    }
                    if(bodyArr[i].contains('Nota:')){
                        if( bodyArr[i].split(':').size()>1){
                            con.Nota__c = bodyArr[i].split(':')[1];
                        }
                    }                 
                }
                try{
                    system.debug('contact'+con);
                    List<OF_ElencoComuniItaliani__c> elenco = new List<OF_ElencoComuniItaliani__c>();
                    elenco = [select Id,OF_CodiceIstat__c,OF_Comune__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:citt ];
                    system.debug('citta test'+elenco);
                    if(elenco.size() > 0){
                        for(OF_ElencoComuniItaliani__c ec : elenco){
                            citt = ec.OF_comune__c;
                        }
                    }
                    else{
                        citt='';
                    }
                    con.mailingStreet=con.indirizzo__c+','+con.Civico__c;
                    con.mailingCity=citt;
                    con.MailingPostalCode=con.CAP__c;
                    con.indirizzo__c= con.indirizzo__c+','+con.Civico__c+','+con.CAP__c+','+ con.Citt__c;
                   
                    insert con;
                    boolean caseResult = caseCreationFromEmail(con.id,body,email);                    
                    if(caseResult = true){
                        return true;
                    }else{
                        return false;
                    }
                }
                catch(Exception e){                   
                    return false;
                }
            }            
        }
        return false;       
    }
    
    public static Boolean caseCreationFromEmail(Id conId, String body, Messaging.InboundEmail email){
        string citt;
        string zipcode;
        string fromemail;
        id queid = [select id 
                    from group 
                    where type='Queue' 
                    and developername = 'SN_Coda_Social_Cases'].id;
        
        Id caseRecordType = Schema.SObjectType.case.getRecordTypeInfosByName().get('SN_Email_Request').getRecordTypeId();        
        if((subject.ContainsIgnoreCase('Residenziale')) || (subject.ContainsIgnoreCase('Business')) || (subject.ContainsIgnoreCase('PA'))  || (subject.containsIgnoreCase('Amministratore di condominio')) || (subject.containsIgnoreCase('Istituzione Finanziaria')) )
        {
            String[] bodyArr = body.split('\n');
            Case cs = new Case();
            cs.RecordTypeId = caseRecordType;
            cs.Origin = 'Web';
            cs.Status = 'Inviato';
            cs.Tipologia_Cliente__c = subject;
            // Edited by Priyanka date-19/04/2018
            if(subject.ContainsIgnoreCase('Residenziale')){ 
                cs.Tipo_cliente__c='Residenziale';
            }
            if(subject.ContainsIgnoreCase('Amministratore di condominio')){ 
                cs.Tipo_cliente__c='Amministratore di condominio';
            }            
            if(subject.ContainsIgnoreCase('Business')){  
                cs.Tipo_cliente__c='Business';
            }            
            if(subject.ContainsIgnoreCase('PA')){ 
                cs.Tipo_cliente__c='Public Administration';
            }
            if(subject.ContainsIgnoreCase('Istituzione Finanziaria')){ 
                cs.Tipo_cliente__c='Istituzione Finanziaria';
            }
            //cs.Subject = 'Richiesta web da:'+;     
            cs.ContactId = conId;
            cs.ownerid = queid;
            
            if(bodyArr.size() > 0){                
                for(Integer i=0;i<bodyArr.size();i++ ){
                    if(bodyArr[i].contains('Nome')){
                        // Commentato poichè da CR anche Business PA e Amm.Cond. devon avere nome e cognome
                        //if(!subject.ContainsIgnoreCase('Istituzione Finanziaria')){
                        if( bodyArr[i].split(':').size()>1){
                            cs.Name_from_Email__c = bodyArr[i].split(':')[1];    
                        }                      
                        //} 
                    }
                    if(bodyArr[i].contains('Cognome')){
                        //Commentato poichè da CR anche Business PA e Amm.Cond. devon avere nome e cognome
                        //if(!subject.ContainsIgnoreCase('Istituzione Finanziaria')){
                        if( bodyArr[i].split(':').size()>1){
                            cs.Name_from_Email__c = cs.Name_from_Email__c +' '+bodyArr[i].split(':')[1];     
                        }            
                        //}
                    }
                    if(bodyArr[i].contains('Indirizzo')){
                        if( bodyArr[i].split(':').size()>1){
                            cs.Address_from_Email__c = bodyArr[i].split(':')[1];
                        }
                    }
                    if(bodyArr[i].contains('Civico')){
                        if( bodyArr[i].split(':').size()>1){
                            cs.Address_from_Email__c = cs.Address_from_Email__c+','+bodyArr[i].split(':')[1];
                        }
                    }
                    if(bodyArr[i].contains('CAP')){
                        if( bodyArr[i].split(':').size()>1){
                            zipcode = bodyArr[i].split(':')[1];
                            cs.Address_from_Email__c = cs.Address_from_Email__c+','+bodyArr[i].split(':')[1];     
                        }  
                    }
                    if(bodyArr[i].contains('Città')){
                        if( bodyArr[i].split(':').size()>1){
                            //  cs.Address_from_Email__c = cs.Address_from_Email__c+','+ bodyArr[i].split(':')[1];
                            citt = bodyArr[i].split(':')[1];
                            citt = citt.trim();
                            //  cs.SN_Provincia__c = bodyArr[i].split(':')[1];
                        }
                    }
                    if(bodyArr[i].contains('Email')){
                        if( bodyArr[i].split(':').size()>1){
                            cs.Email_from_Mail__c = bodyArr[i].split(':')[1].stripHtmlTags();
                            fromemail=bodyArr[i].split(':')[1].stripHtmlTags();
                        }
                    }
                    if(bodyArr[i].contains('Telefono')){
                        if( bodyArr[i].split(':').size()>1){
                            cs.Telefone_Number__c = bodyArr[i].split(':')[1];
                        }
                    }
                    if(bodyArr[i].contains('Nota')){
                        if( bodyArr[i].split(':').size()>1){
                            //  cs.Description =  bodyArr[i].split(':')[1];
                        }
                    }
                    System.debug('Key-->' + bodyArr[i]);
                    if(bodyArr[i].contains('Tipologia'))
                    {
                        if( bodyArr[i].split(':').size()>1){
                            // System.debug('Value-->' + bodyArr[i].split(':')[1]);
                            if(bodyArr[i].split(':')[1].containsIgnoreCase('Informazioni Generali')){
                                //  system.debug('before Picklist Value'+bodyArr[i].split(':')[1]);
                                cs.SN_Argomento__c = bodyArr[i].split(':')[1];    
                                //  system.debug('After picklist value'+cs.SN_Argomento__c);  
                            }
                            if(bodyArr[i].split(':')[1].containsIgnoreCase('Copertura')){
                                cs.SN_Argomento__c  = 'Informazioni generali';
                                cs.SN_Social_Reason__c = 'Vendibilità'; 
                                //cs.SN_Social_Reason__c = bodyArr[i].split(':')[1];                         
                            }
                            if(bodyArr[i].split(':')[1].containsIgnoreCase('Infratel')){
                                cs.SN_Argomento__c   = 'Informazioni Infratel';
                            }
                            if(bodyArr[i].split(':')[1].containsIgnoreCase('Assistenza')){
                                cs.SN_Argomento__c = 'Problemi';
                                cs.SN_Social_Reason__c = 'Assurance';
                            } 
                        }
                    }
                    if(bodyArr[i].contains('Ragione Sociale')){
                        if(subject.ContainsIgnoreCase('Business')){
                            if( bodyArr[i].split(':').size()>1){
                                cs.Name_from_Email__c = bodyArr[i].split(':')[1]; 
                            }                       
                        }
                    }
                    if(bodyArr[i].contains('Operatore')){
                        if( bodyArr[i].split(':').size()>1){
                            cs.OperatorePartner__c = bodyArr[i].split(':')[1];
                        }
                    }
                } 
                List<OF_ElencoComuniItaliani__c> elenco = new List<OF_ElencoComuniItaliani__c>();
                elenco = [select Id,OF_CodiceIstat__c,OF_Comune__c 
                          from OF_ElencoComuniItaliani__c 
                          where (OF_CodiceIstat__c=:citt OR OF_Comune__c =:citt) ];
                id ecid;
                system.debug('elenco======'+elenco);
                if(elenco.size()>0)
                {
                    for(OF_ElencoComuniItaliani__c ec:elenco){
                        citt=ec.OF_comune__c +','+ zipcode/*ec.OF_CodiceIstat__c*/;
                        ecid = ec.id;
                    }
                    system.debug('citt======'+citt);
                    cs.SN_Provincia__c = citt;
                    cs.SN_Provincia_New__c = ecid;
                }
                //try
                //{
                    /*********Start Rajani******/    
                    //To update status field in case based on from addres,Subject and closeddate <=5 days 
                    System.debug('Entering======');
                    
                    if(Subject.containsIgnoreCase('Residenziale')){
                        Subject = 'Residenziale';
                    }
                    if(Subject.containsIgnoreCase('Business')){
                        Subject = 'Business';
                    }
                    if(Subject.containsIgnoreCase('PA')){
                        Subject = 'Public Administration';
                    }
                    if(subject.ContainsIgnoreCase('Amministratore di condominio')){ 
                        Subject = 'Amministratore di condominio';
                    } 
                    if(subject.ContainsIgnoreCase('Istituzione Finanziaria')){ 
                        Subject = 'Istituzione Finanziaria';
                    } 
                    //FromAddress__c=:fromemail
                    system.debug('@@@fromemail'+fromemail +  + '   Subject : ' +Subject + '  caseRecordType  ' +  caseRecordType );
                    
                    //Add by PG - FIX Contattaci - 7-01 - Rimuovere check sui 5 giorni
                    //Inizio - Commento - PG - 7-01
                    //Va creato sempre un nuovo case
                    
                    /*
                    Case csexistig = [Select Id, casenumber, Status,Previous_Status__c,contact.name,closeddate,createddate,Email_from_Mail__c,Tipo_cliente__c  
                                      from Case 
                                      Where Email_from_Mail__c=:fromemail 
                                      AND Tipo_cliente__c= :Subject 
                                      AND Status='Chiuso' 
                                      AND RecordTypeId =:caseRecordType
                                      order by closeddate 
                                      DESC limit 1];
                
                    system.debug('@@@csexistig'+csexistig);
                    integer noofdays = csexistig.closeddate.date().daysBetween(csexistig.createddate.date());
                    System.debug('noofdays======'+noofdays);
                    
                    if(csexistig !=null && noofdays<=5 )
                    {
                        System.debug('entering if');
                        csexistig.status = csexistig.Previous_Status__c;
                        csexistig.ApexContext__c = True;
                        update csexistig;
                        
                        EmailMessage emailMsg = new EmailMessage();
                        emailMsg.FromAddress = fromemail;//email.fromAddress;
                        system.debug('FromAddress'+emailMsg.FromAddress);
                        emailMsg.ToAddress = email.toAddresses[0];
                        system.debug('ToAddress'+email.toAddresses[0]);
                        emailMsg.TextBody = body;
                        //Add by PG - FIX Contattaci 3-01 - Correzione subject email Creation case
                        //emailMsg.subject = email.subject;
                        emailMsg.subject = 'Open Fiber Contattaci: ' +csexistig.CaseNumber;
                        
                        emailMsg.ParentId = csexistig.id; 
                        emailMsg.FromName = csexistig.contact.Name; 
                        emailMsg.status = '1';
                        
                        system.debug('body======'+body);
                        if(body.length()>50){
                            emailMsg.EmailBody__c = body.substring(0,50);
                        }else{
                            emailMsg.EmailBody__c = body;
                        }
                        insert emailMsg;
                        return true;
                    }
                    else
                    {
                        System.debug('Entering else');
                        throw new applicationException('You can nott do that here');
                    }
                }
                catch(exception e)
                {
                    System.debug('@@@Test'+e.getMessage());
                    */
                    //Fine - Commento - PG - 7-01
                    cs.FromAddress__c = fromemail;//email.fromAddress;  
                    insert cs; 
                    
                    //End Rajani
                    EmailMessage emailMsg= new EmailMessage();
                    emailMsg.FromAddress = fromemail;//email.fromAddress;
                    system.debug('@@@@@@@FromAddress'+emailMsg.FromAddress);
                    emailMsg.ToAddress = email.toAddresses[0];
                    system.debug('ToAddress'+email.toAddresses[0]);
                    emailMsg.TextBody = body;
                    emailMsg.ParentId = cs.id; 
                    emailMsg.FromName = cs.contact.Name; 
                    emailMsg.status = '1';
                    
                    //Add by PG - FIX Contattaci 3-01 - Correzione subject email Creation case
                    //emailMsg.subject = email.subject;
                    //System.debug('>>>>cs>>>> :'+cs.CaseNumber);
                    String caseNumbIns = [Select casenumber 
                                         from Case
                                         where id=: cs.id].casenumber;
                                         
                    emailMsg.subject = 'Open Fiber Contattaci: '+caseNumbIns;
                    
                    system.debug('body======'+body);
                    
                    if(body.length()>50){
                       emailMsg.EmailBody__c =  body.substring(0,50);
                    }else{
                        emailMsg.EmailBody__c =  body;
                    }
                    insert emailMsg;         
                    system.debug('test123'+emailMsg.id);
                    system.debug('Check Case creation--->' + cs);
                    //CaseCreationFromInboudEmail.InsertAttachment(cs.Id,email);
                    if(!Test.isRunningTest()){
                        Contact con = new Contact();
                        con = [select id, name 
                               from contact 
                               where id=: conID 
                               Limit 1];
                        cs.Subject = 'Richiesta web da:'+con.Name;
                        cs.Origin = 'Web';
                        cs.sourceid = emailMsg.id;
                        update cs;
                    }
                    system.debug('test123'+cs.source);
                    if(email.textAttachments != null){
                        system.debug('Check email textAttachments--->' + email.textAttachments);
                        for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments){
                            Attachment attachment = new Attachment();                
                            attachment.Name = tAttachment.fileName;
                            attachment.Body = Blob.valueOf(tAttachment.body);
                            attachment.ParentId = cs.Id;
                            insert attachment;
                        } 
                        for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments){
                            Attachment attachment = new Attachment();                
                            attachment.Name = tAttachment.fileName;
                            attachment.Body = Blob.valueOf(tAttachment.body);
                            attachment.ParentId = emailMsg.Id;
                            insert attachment;
                        } 
                        return true;
                    }
                    
                    //Save any Binary Attachment
                    if(email.binaryAttachments != null){
                        system.debug('Check email binaryAttachments--->' + email.binaryAttachments);
                        for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments){
                            Attachment attachment = new Attachment();            
                            attachment.Name = bAttachment.fileName;
                            attachment.Body = bAttachment.body;
                            attachment.ParentId = cs.Id;
                            insert attachment;
                        }
                        for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments){
                            Attachment attachment = new Attachment();            
                            attachment.Name = bAttachment.fileName;
                            attachment.Body = bAttachment.body;
                            attachment.ParentId = emailMsg.Id;
                            insert attachment;
                        }
                        return true;
                    }
                    return true;
                }
               // catch(Exception e)
               // {                   
                  //  return false;
               // }
            }            
        //}
        return false;        
    }
}
@isTest
public class CaseCreationFromInboudEmailTest 
{
    @isTest Public static void CaseCreationFromInboudEmailTestMethod() 
    {        
        // create a new email and envelope object
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom;       
        
        // setup the data for the email
        String[] mail = new String[]{'test@gmails.com,test1@ymails.com'};
        email.subject = 'Residenziale';
        email.fromname = 'FirstName LastName';
        email.fromAddress = 'someaddress@email.com';
        email.toAddresses = mail;
        email.plainTextBody = 'Nome:Test\nCognome:Test\nIndirizzo: Test\nCivico:Via Roma\nCAP: 632001\nCittà: Roma\nRagione Sociale: Test\nP.IVA: Test\nEnte:Test\nNDipendenti:Test\nEmail:testmail.test@example.com\nTelefono:1234456\nBody:This is just a test mail\nNota: testing first record\nTipologia:informazioni Generali\nOperatore:Test\n';
        
        // add an attachment
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text');
        attachment.fileName = 'textfile.txt';
        attachment.mimeTypeSubType = 'text/plain';        
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
        // call the email service class and test it with the data in the testMethod
        CaseCreationFromInboudEmail emailProcess = new CaseCreationFromInboudEmail();
        emailProcess.handleInboundEmail(email, env);
    }
    
    @isTest Public static void CaseCreationFromInboudEmailTestMethod1() 
    {        
        // create a new email and envelope object
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom;       
        
        // setup the data for the email
        String[] mail = new String[]{'test@gmails.com,test1@ymails.com'};
        email.subject = 'PA';
        email.fromname = 'FirstName LastName';
        email.fromAddress = 'someaddress@email.com';
        email.toAddresses = mail;
        email.plainTextBody = 'Nome:Test\nCognome:Test\nIndirizzo: Test\nCivico:Via Roma\nCAP: 632001\nCittà: Test\nRagione Sociale: Test\nP.IVA: Test\nEnte:Test\nNDipendenti:Test\nEmail:testmail.test@example.com\nTelefono:1234456\nBody:This is just a test mail\nNota: testing first record\nTipologia:informazioni Generali\nOperatore:Test\n';
        
        // add an attachment
        Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
        attachmenttext.body = 'my attachment text';
        attachmenttext.fileName = 'textfiletwo3.txt';
        attachmenttext.mimeTypeSubType = 'texttwo/plain';        
        email.textAttachments = new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
               
        // call the email service class and test it with the data in the testMethod
        CaseCreationFromInboudEmail emailProcess = new CaseCreationFromInboudEmail();
        emailProcess.handleInboundEmail(email, env);
    } 
    
    @isTest Public static void CaseCreationFromInboudEmailTestMethod2() 
    {        
        // create a new email and envelope object
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom;       
        
        // setup the data for the email
        String[] mail = new String[]{'test@gmails.com,test1@ymails.com'};
        email.subject = 'Business';
        email.fromname = 'FirstName LastName';
        email.fromAddress = 'someaddress@email.com';
        email.toAddresses = mail;
        email.plainTextBody = 'Nome:Test\nCognome:Test\nIndirizzo: Test\nCivico:Via Roma\nCAP: 632001\nCittà: Test\nRagione Sociale: Test\nP.IVA: Test\nEnte:Test\nNDipendenti:Test\nEmail:testmail.test@example.com\nTelefono:1234456\nBody:This is just a test mail\nNota: testing first record\nTipologia:informazioni Generali\nOperatore:Test\n';
        
        // add an attachment
        Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
        attachmenttext.body = 'my attachment text';
        attachmenttext.fileName = 'textfiletwo3.txt';
        attachmenttext.mimeTypeSubType = 'texttwo/plain';        
        email.textAttachments = new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
               
        // call the email service class and test it with the data in the testMethod
        CaseCreationFromInboudEmail emailProcess = new CaseCreationFromInboudEmail();
        emailProcess.handleInboundEmail(email, env);
    } 
    
    @isTest Public static void CaseCreationFromInboudEmailTestMethod3() 
    {   
        
        // create a new email and envelope object
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
         String citt = 'Test';
        List<OF_ElencoComuniItaliani__c> elenco=new List<OF_ElencoComuniItaliani__c>();
        OF_ElencoComuniItaliani__c elen = new OF_ElencoComuniItaliani__c();
        elen.OF_CodiceIstat__c = citt;
        elen.OF_Comune__c = citt;
       //insert elen;
        elenco.add(elen);
        //insert elenco;
        
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom;       
        
        // setup the data for the email
        String[] mail = new String[]{'test@gmails.com,test1@ymails.com'};
        email.subject = 'Business';
        email.fromname = 'FirstName LastName';
        email.fromAddress = 'someaddress@email.com';
        email.toAddresses = mail;
        email.plainTextBody = 'Nome:Test\nCognome:Test\nIndirizzo: Test\nCivico:Via Roma\nCAP: 632001\nCittà: Test\nRagione Sociale: Test\nP.IVA: Test\nEnte:Test\nNDipendenti:Test\nEmail:testmail.test@example.com\nTelefono:1234456\nBody:This is just a test mail\nNota: testing first record\nTipologia:informazioni Generali\nOperatore:Test\n';
        
        
        // add an attachment
        Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
        attachmenttext.body = 'my attachment text';
        attachmenttext.fileName = 'textfiletwo3.txt';
        attachmenttext.mimeTypeSubType = 'texttwo/plain';        
        email.textAttachments = new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
            
            
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
       Contact con=new Contact();
con.lastname='Testing';
insert con;
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SN_Email_Request').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Chiuso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        //c.PO_PP_ID_Richiesta__c=c.id;
        c.Tipo_cliente__c = 'Richiesta di attivazione';
        c.FromAddress__c = email.fromAddress; 
        c.Status='Chiuso';
        c.contactid=con.id;

       
       
        insert c;
        vlstcase.add(c);
             
        // call the email service class and test it with the data in the testMethod
        CaseCreationFromInboudEmail emailProcess = new CaseCreationFromInboudEmail();
        emailProcess.handleInboundEmail(email, env);
    }
    
       
        static testMethod  void zillowEmail() {
        
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        // setup the data for the email
        email.ccAddresses = new String[] {'jsmith@salesforce.com'};
        email.subject = 'Test ZillowEmail';
        email.fromAddress = 'yogi262308@gmail.com';
        env.toAddress=('forwardzillowemail@2ydvi7xh9fe3oh0ltcv8utuk7sxf4czsk9rsxchmloqeky0301.c-9mdleaq.cl.apex.sandbox.salesforce.com');
        email.htmlBody='<html><title>This s A test mail</title><body>Hi i am here.</body></html>';
        test.startTest();
       CaseCreationFromInboudEmail emailProcess = new CaseCreationFromInboudEmail();
        emailProcess.handleInboundEmail(email, env);
        test.stopTest();
        } 
            
}
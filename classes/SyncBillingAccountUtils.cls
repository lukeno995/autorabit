public class SyncBillingAccountUtils {
    
    public class Wrapper{
        public Account acc{get;set;}
        public String action{get;set;}        
    }
    
    
    public static String GetCRONExpression(Datetime dt) {
        return ('' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year());
    }
    
    public static string checkFields(SyncBillingAccountUtils.Wrapper wrp)
    {
        Id RecTypeId = [Select Id from RecordType where DeveloperName ='OLO' limit 1].Id;
        Account acc = wrp.acc;
        
        if(!RecTypeId.Equals(acc.RecordTypeId))
        {
            return 'RecTypeId';
        }
        else if(wrp.action!='Modify' && wrp.action!='Activate' )
        {
            return 'action';
        }
        else if(acc.Status__c!='Attivo')
        {
            return 'Status';
        }
        else if(acc.AccountNumber==null || acc.AccountNumber.length() > 30)
        {
            return 'AccountNumber';
        }
        else if(acc.StartDate__c == null)
        {
            return 'StartDate';   
        }            
        else if(acc.Name.length() > 255)
        {
            return 'Name';
        }
        else if(acc.VATNumber__c == null || acc.VATNumber__c.length() > 30)
        {
            return 'Vat Number';
        }
        else if(acc.TaxationCode__c!= null && string.valueOf(acc.TaxationCode__c).length() > 30)
        {
            return 'TaxationCode';
        }
        else if(acc.BillingEmail__c!= null && acc.BillingEmail__c.length() > 255)
        {
            return 'Billing email';
        }
        else  if(acc.PEC__c!= null && acc.PEC__c.length() > 255){
            
            return 'PEC';
        }
        else  if(acc.BillingCity== null || acc.BillingCity.length() > 255)
        {
            return 'BillingCity';
        }
        else  if(acc.BillingState== null || acc.BillingState.length() > 255)
        {
            return 'BillingState';
        }
        else  if(acc.BillingStreet== null || acc.BillingStreet.length() > 255)
        {
            return 'BillingStreet';
        }
        else  if(acc.BillingCountry== null || acc.BillingCountry.length() > 30)
        {
            return 'BillingCountry';
        }
        else  if(acc.Industry!= null && acc.Industry.length() > 30)
        {
            return 'Industry';
        }
        else  if(acc.BillingPostalCode== null || acc.BillingPostalCode.length() > 30)
        {
            return 'BillingPostalCode';
        }
        else
        {
            return 'true';
        }
    }
    
    public static void callBatch(SyncBillingAccountUtils.Wrapper wrp)
    {
        OF_SyncBillingAccount_Batch batch = new OF_SyncBillingAccount_Batch(wrp.acc.Id,wrp.action);
        database.executeBatch(batch);  
    }
    
    public static EOF_Notify__c createNotify(SyncBillingAccountUtils.Wrapper wrp)
    {
        Account acc = wrp.acc;
        EOF_Notify__c notifica = new EOF_Notify__c();
        Id rt = [Select Id from RecordType where DeveloperName ='EOF_BILL_ACCCOUNT' limit 1].Id;
        
        notifica.Account__c=acc.Id;
        notifica.RecordTypeId=rt;
        notifica.OF_Billing_Type__c=wrp.action;
        notifica.EOF_ID_Notifica__c = String.valueOf(system.now().getTime());
        notifica.EOF_Codice_Comunicazione_OLO__c = acc.AccountNumber;
        //insert notifica;
        
        system.debug('@@@ Notifica creata '+ notifica);
        return notifica;
    }
    
    public static  List<EOF_Notify__c> createListNotify(List<SyncBillingAccountUtils.Wrapper> wrps)
    {
        List<EOF_Notify__c> notifiche = new List<EOF_Notify__c>();
        for(SyncBillingAccountUtils.Wrapper  wrp : wrps){
            Account acc = wrp.acc;
            EOF_Notify__c notifica = new EOF_Notify__c();
            Id rt = [Select Id from RecordType where DeveloperName ='EOF_BILL_ACCCOUNT' Limit 1].Id;
            
            notifica.Account__c=acc.Id;
            notifica.RecordTypeId=rt;
            notifica.OF_Billing_Type__c=wrp.action;
            notifica.EOF_ID_Notifica__c = String.valueOf(system.now().getTime());
            notifica.EOF_Codice_Comunicazione_OLO__c = acc.AccountNumber;
            
            notifiche.add(notifica);
        }
        
        insert notifiche;
        
        return notifiche;
    }
     
    
    public static void createLog(string notifica, string request, string response, string codice, string esito,  string descrizione, string message)
    {
        EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
        log.Notify__c=notifica;
        
        if(!string.isEmpty(request))
        {
            Id recId = [Select Id from RecordType where DeveloperName ='SF_To_BILL' limit 1 ].Id ;
            log.RecordTypeId = recId;
            log.EOF_Richiesta_Notifica__c = request;
        }
        else if(!string.isEmpty(response))
        {
            Id recId = [Select Id from RecordType where DeveloperName ='BILL_To_SF' limit 1].Id ;
            log.RecordTypeId = recId;
            log.EOF_Response__c = response;
            log.OF_SA_Esito__c = esito;
            log.EOF_CODICE_MOTIVAZIONE__c=codice;
            log.EOF_Descrizione_Causale_Scarto__c = descrizione;
        }
        else
        {
            Id recId = [Select Id from RecordType where DeveloperName ='Nack_Billing' limit 1].Id ;
            log.RecordTypeId = recId;
            log.EOF_Descrizione_Causale_Scarto__c=message;
        } 
        insert log;
    }
    
    public static void createListLog(List<EOF_Notify__c> notifiche, List<string> errors, string request, string response, string codice,string esito,string descrizione, string message)
    {
        List<EOF_EAI_Service_Log__c> logs = new  List<EOF_EAI_Service_Log__c>();
        
        Id recId=null;
        
        if(!string.isEmpty(request))
        {
            recId = [Select Id from RecordType where DeveloperName ='SF_To_BILL' limit 1].Id ;
        }
        else if(!string.isEmpty(response))
        {
            recId = [Select Id from RecordType where DeveloperName ='BILL_To_SF' limit 1].Id ;
        }
        else
        {
            recId = [Select Id from RecordType where DeveloperName ='Nack_Billing' limit 1].Id ;
        }
        
        for(EOF_Notify__c notifica : notifiche){
            message= 'Il controllo del campo '+errors[0]+' non è andato a buon fine';
            
            EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
            
            log.Notify__c=notifica.Id;
            
            if(!string.isEmpty(request))
            {
                log.RecordTypeId = recId;
                log.EOF_Richiesta_Notifica__c = request;
            }
            else if(!string.isEmpty(response))
            {
                log.RecordTypeId = recId;
                log.EOF_Response__c = response;
                log.EOF_CODICE_MOTIVAZIONE__c=codice;
                log.EOF_Descrizione_Causale_Scarto__c=descrizione;
                log.OF_SA_Esito__c = esito;
            }
            else
            {
                
                log.RecordTypeId = recId;
                log.EOF_Descrizione_Causale_Scarto__c=message;
            }
            
            logs.add(log);
        }
        
        insert logs;
    }
    
    
    
    public static string createRequest(SyncBillingAccountUtils.Wrapper wrp, string notificaId,string status,String industry,String countryC, String countryN, String class_x , string TimeStamp)
    {
        
        string req ='Action: '+wrp.action +
            +'\n ID Notifica: ' +notificaId+
            +'\n Industry: ' + industry+
            +'\n CountryCode: ' + countryC+
            +'\n CountryName: ' + wrp.acc.BillingCountry+
            +'\n Class: ' + class_x+
            +'\n TimeStamp' + TimeStamp+
            +'\n Staus: ' + status+
            +'\n AccountNumber: ' + wrp.acc.AccountNumber+
            +'\n StartDate: ' + string.valueOf(wrp.acc.StartDate__c)+
            +'\n AccountName: ' + wrp.acc.Name+
            +'\n ShortCode: ' + wrp.acc.EOF_Codice_Operatore__c+
            +'\n VATnumber: ' + wrp.acc.VATNumber__c+
            +'\n TaxationCode: ' + wrp.acc.TaxationCode__c+
            +'\n Email: ' + wrp.acc.BillingEmail__c+
            +'\n PEC: ' + wrp.acc.PEC__c+
            +'\n City: ' + wrp.acc.BillingCity+
            +'\n Street: ' + wrp.acc.BillingStreet+
            +'\n State: ' + wrp.acc.BillingState+
            +'\n PostalCode: ' + wrp.acc.BillingPostalCode;
        return req;
        
    }
    
    public static string createResponse(OF_Billing_Outbound_Schema.BillingAccountManagerResponsetType res)
    {
        return 	+'ID NOTIFICA: ' + res.notificaId+
            +'\n ESITO: ' + res.esito+          
            +'\n CODICE MOTIVAZIONE: ' + res.codiceMotivazione+
            +'\n MOTIVAZIONE: ' + res.motivazione;
    }
    
    public static void callWSAccount(SyncBillingAccountUtils.Wrapper wrp, String notificaId)
    {
        string class_x ='Premium';
        if(String.isNotBlank(wrp.acc.Class__c))
        {
            class_x=wrp.acc.Class__c;
        }
        
        string countryC='ITA';
        
        
        string Industry='ANY';
        if('GOVERNMENT'.equalsIgnoreCase(wrp.acc.Industry))
        {
            Industry='GOVERNMENT';
        }else if('PRIVATE'.equalsIgnoreCase(wrp.acc.Industry))
        {
            Industry='PRIVATE';
        }
        
        
         string Status = wrp.acc.Status__c;
        
        
        if('Attivo'.equals(Status))
        {
            Status = 'Active';
        }
        else if('Non Attivo'.equals(Status))
        {
            Status = 'Inactive';
        }
        
        
        
        system.debug('@@@@ notificaId '+ notificaId);
        
        EOF_Notify__c noti = null;
        if(string.isEmpty(notificaId))
        {
            noti = SyncBillingAccountUtils.createNotify(wrp);
            notificaId = noti.EOF_ID_Notifica__c;
        }
        
        DateTime now = Datetime.now();
        string request = SyncBillingAccountUtils.createRequest(wrp,notificaId,Status,industry,countryC,wrp.acc.BillingCountry,class_x,string.valueOf(now));
        
        
        OF_Billing_Outbound_Service.BillingAccountManagerSOAP port = new OF_Billing_Outbound_Service.BillingAccountManagerSOAP();   
        
        string nowString = now.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        string startString = wrp.acc.StartDate__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        
        OF_Billing_Outbound_Schema.BillingAccountManagerResponsetType res = port.AccountManager(wrp.action, Status, notificaId, nowString, wrp.acc.AccountNumber, startString, wrp.acc.Name, wrp.acc.EOF_Codice_Operatore__c, class_x , wrp.acc.VatNumber__c, string.valueOf(Integer.valueOf(wrp.acc.TaxationCode__c)), wrp.acc.BillingEmail__c, wrp.acc.PEC__c, wrp.acc.BillingCity, wrp.acc.BillingStreet, wrp.acc.BillingState, wrp.acc.BillingPostalCode, countryC, wrp.acc.BillingCountry, industry);
        
        string response = SyncBillingAccountUtils.createResponse(res);
         system.debug('@@@@'+ request);
        
        if(noti!= null)
        {
            insert noti;
        }
        else
        {
            noti = [select id from EOF_Notify__c where EOF_ID_Notifica__c =:notificaId];
        }
        
        
        SyncBillingAccountUtils.createLog(noti.Id, request,'','','','','');
        SyncBillingAccountUtils.createLog(noti.Id, '',response, res.codiceMotivazione,res.esito,res.descrizione,'');
        
        if(res.esito.Equals('0'))
        {
            wrp.acc.SyncBilling__c = true;
            wrp.acc.OF_BillingSyncronized__c=true;
            update wrp.acc; 
        }       
    }
}
public class SyncBillingContractUtils { 
    public class Wrapper{
        public Contract con {get;set;}
        public string action{get;set;}
        public string operationType{get;set;}  
    }
    public class CustomObject {
        public string action {get; set;}
        public string operationType {get; set;}
        public OF_CommercialElementIstanziato__c CEI {get; set;}
        public string JsonString {get; set;}
        public string notificaId {get; set;}
        public List<PricebookEntry> bei {get; set;}
        public EOF_Notify__c notifica {get; set;}
        public string errore {get; set;}
    }
    
    public static String checkField(SyncBillingContractUtils.Wrapper wrp){
        Contract con = wrp.con;
        if(wrp.action!='Activate' && wrp.action != 'Modify' && wrp.action != 'Terminate')
        {
            return 'action';
        }
        else if(wrp.operationType != 'Create' && wrp.operationType != 'Update')
        {
            return 'operationType';
        }
        else if(con.Status != 'Attivo' && con.Status!='Cessato')
        {
            return 'Status';
        }
        else if(con.ContractNumber== null || con.ContractNumber.length() > 30)
        {
            return 'ContractNumber';
        }
        else if(con.OF_IdContratto__c == null || con.OF_IdContratto__c.length() > 30)
        {
            return 'OF_IdContratto__c';
        }
        else if(con.Name== null || con.Name.length() > 255)
        {
            return 'Name';
        }
        else if(con.OF_TermPayment__c == null || string.valueOf(con.OF_TermPayment__c).length() > 30)
        {
            return 'TermPayment';
        }
        else if(con.BillingFrequency__c == null || string.valueOf(con.BillingFrequency__c).length() > 30)
        {
            return 'BillingFrequency';
        }
        else if(con.Account.AccountNumber == null || con.Account.AccountNumber.length() > 30)
        {
            return 'AccountNumber';
        }
        else
        {    
            return 'true';
        }
    }
    public static EOF_Notify__c createNotify(SyncBillingContractUtils.Wrapper wrp){
        Contract con = wrp.con;
        EOF_Notify__c notifica = new EOF_Notify__c();
        Id rt = [Select Id from RecordType where DeveloperName ='EOF_BILL_Contract' Limit 1].Id;
        notifica.Contract__c=con.Id;
        notifica.RecordTypeId=rt;
        notifica.OF_Billing_Type__c=wrp.action;
        notifica.OF_Billing_OperationType__c = wrp.operationType;
        notifica.EOF_ID_Notifica__c = String.valueOf(system.now().getTime());
        return notifica;
    }
    public static List<EOF_Notify__c> createListNotify( List<SyncBillingContractUtils.Wrapper> errors) {
        Id rt = [Select Id from RecordType where DeveloperName ='EOF_BILL_Contract' Limit 1].Id;
        List<EOF_Notify__c> notifiche = new List<EOF_Notify__c>();
        for(SyncBillingContractUtils.Wrapper wrp: errors){          
            Contract con = wrp.con;
            EOF_Notify__c notifica = new EOF_Notify__c();
            notifica.Contract__c=con.Id;
            notifica.RecordTypeId=rt;
            notifica.OF_Billing_Type__c=wrp.action;
            notifica.OF_Billing_OperationType__c = wrp.operationType;
            notifica.EOF_ID_Notifica__c = String.valueOf(system.now().getTime());
            notifiche.add(notifica);  
        }   
        insert notifiche;
        return notifiche;
    }
    public static void createListLog(List<EOF_Notify__c> notifiche, List<string> errors, string request, string response, string codice,string esito, string message){
        List<EOF_EAI_Service_Log__c> logs = new  List<EOF_EAI_Service_Log__c>();
        
        Id recId=null;
        
        if(!string.isEmpty(request))
        {
            recId = [Select Id from RecordType where DeveloperName ='SF_To_BILL' Limit 1].Id ;
        }
        else if(!string.isEmpty(response))
        {
            recId = [Select Id from RecordType where DeveloperName ='BILL_To_SF' Limit 1].Id ;
        }
        else
        {
            recId = [Select Id from RecordType where DeveloperName ='Nack_Billing' Limit 1].Id ;
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
    public static string createRequest(Wrapper wrp,String notificaId,string TimeStamp, string status){
        return 'Action: '+ wrp.action 
            +'\n Operation Type: '+ wrp.operationType
            +'\n Status: '+status
            +'\n NotificaId: '+ notificaId
            +'\n TimeStamp: '+ TimeStamp
            +'\n Start Date: '+wrp.con.StartDate
            +'\n End Date: '+wrp.con.EndDate
            +'\n Contract Code: '+ wrp.con.ContractNumber
            +'\n Contract Name: ' + wrp.con.OF_IdContratto__c
            +'\n Suspend Date: '+wrp.con.SuspendedDate__c
            +'\n Term Payment: '+string.valueOf(Integer.valueOf(wrp.con.OF_TermPayment__c))
            +'\n Billing Frequency: '+wrp.con.BillingFrequency__c
            +'\n Contract Duration: '+wrp.con.ContractTerm
            +'\n Contract Name: '+wrp.con.Name
            +'\n Account Number: '+wrp.con.Account.AccountNumber
        	+'\n ODA: '+wrp.con.NS_Rif__c;
}
    public static string createResponse(OF_Billing_Outbound_Schema2.BillingAgreementManagerResponseType res){
        return 	+'ID NOTIFICA: ' + res.notificaId+
            +'\n ESITO: ' + res.esito+          
            +'\n CODICE MOTIVAZIONE: ' + res.codiceMotivazione+
            +'\n MOTIVAZIONE: ' + res.motivazione;
    }
    public static void createLog(string notifica, string request, string response, string codice,string esito, string message){
        EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
        log.Notify__c=notifica;
        
        if(!string.isEmpty(request))
        {
            Id recId = [Select Id from RecordType where DeveloperName ='SF_To_BILL' Limit 1].Id ;
            log.RecordTypeId = recId;
            log.EOF_Richiesta_Notifica__c = request;
        }
        else if(!string.isEmpty(response))
        {
            Id recId = [Select Id from RecordType where DeveloperName ='BILL_To_SF' Limit 1].Id ;
            log.RecordTypeId = recId;
            log.EOF_Response__c = response;
            log.OF_SA_Esito__c = esito;
            log.EOF_CODICE_MOTIVAZIONE__c=codice;
        }
        else
        {
            Id recId = [Select Id from RecordType where DeveloperName ='Nack_Billing' Limit 1].Id ;
            log.RecordTypeId = recId;
            log.EOF_Descrizione_Causale_Scarto__c=message;
        }
        insert log;
    }
    public static void callWSContract(SyncBillingContractUtils.Wrapper wrp,String notificaId){
        system.debug('@@@@callWSContract '+ wrp);
        system.debug('@@@@notificaId '+ notificaId);
        Contract con = wrp.con;        
        
        EOF_Notify__c noti = null;
        if(string.isEmpty(notificaId))
        {
            noti = createNotify(wrp);
            notificaId = noti.EOF_ID_Notifica__c;
        }
        
        string Status = wrp.con.Status;
        
        
        if('Attivo'.equals(wrp.con.Status))
        {
            Status = 'Active';
        }
        else if('Cessato'.equals(wrp.con.Status))
        {
            Status = 'Inactive';
        }
        else
        {
            Status='Suspended';
        }
        
        
        DateTime now = Datetime.now();
        string request = createRequest(wrp,notificaId,string.valueOf(now),Status );
        
        system.debug('@@@@@req' + request);
        
        OF_Billing_Outbound_Service2.BillingAgreementManagerSOAP port = new OF_Billing_Outbound_Service2.BillingAgreementManagerSOAP();
        
        DateTime startDate = wrp.con.StartDate; 
        system.debug('@@@@@wrp.con.EndDate' + wrp.con.EndDate);
        DateTime endDate =wrp.con.EndDate;
        DateTime suspendDate = wrp.con.SuspendedDate__c;    
        
        Date myDatD = date.newinstance(endDate.year(), endDate.month(), endDate.day());
        Date myDateNow = date.newinstance(now.year(), now.month(), now.day());
        
        integer daytoEnd =  myDatD.daysBetween(myDateNow);
        
        system.debug('@@@@@' + daytoEnd);
        
        string nowString = now.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        
        string StartString = startDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        
        string EndString = endDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        
        string suspenString ='';
        
        if(suspendDate!= null)
        {
            suspenString= suspendDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        }
        
        OF_Billing_Outbound_Schema2.BillingAgreementManagerResponseType res = port.AgreementManager(wrp.action, wrp.operationType, status, notificaId, nowString, StartString ,EndString, suspenString, string.valueOf(Integer.valueOf(wrp.con.OF_TermPayment__c)), wrp.con.BillingFrequency__c, wrp.con.ContractTerm, wrp.con.ContractNumber, wrp.con.OF_IdContratto__c, wrp.con.Account.AccountNumber,wrp.con.NS_Rif__c);
        //OF_Billing_Outbound_Schema2.BillingAgreementManagerResponseType res = port.AgreementManager(wrp.action, wrp.operationType, status, notificaId, nowString, StartString ,EndString, suspenString, string.valueOf(Integer.valueOf(wrp.con.OF_TermPayment__c)), wrp.con.BillingFrequency__c, wrp.con.ContractTerm, wrp.con.ContractNumber, wrp.con.OF_IdContratto__c, wrp.con.Account.AccountNumber);
        
        String response = createResponse(res);
        
        if(noti!= null)
        {
            insert noti;
        }
        else
        {
            noti = [select id from EOF_Notify__c where EOF_ID_Notifica__c =:notificaId];
        }
        
        SyncBillingContractUtils.createLog(noti.Id, request,'','','','');
        SyncBillingContractUtils.createLog(noti.Id, '',response,res.codiceMotivazione,res.esito,'');
        
        if(res.esito.Equals('0')){
            wrp.con.SyncBilling__c = true;
            wrp.con.OF_BillingSyncronized__c = true;
            update wrp.con; 
        }
    } 
    public static void callBatch(SyncBillingContractUtils.Wrapper wrp){
        OF_SyncBillingContract_Batch batch = new OF_SyncBillingContract_Batch(wrp.con.Id,wrp.action, wrp.operationType);
        database.executeBatch(batch);
    }
    
    //FIBER LEASE
    /*
    public static void CallFiberLease(List<OF_CommercialElementIstanziato__c> cei){
        system.debug('@@@@CallFiberLease');
        List<string> ceiIds = new List<string>();
        for (OF_CommercialElementIstanziato__c ce : cei) {
            ceiIds.add(ce.id);
        }
        try {
            List<PricebookEntry> beis = SyncBillingAssetUtils.getListBEICustom(ceiIds);
            Map<String,List<PricebookEntry>> mapBei = new Map<String,List<PricebookEntry>>();
            for (PricebookEntry be : beis) {
                List<PricebookEntry> pe = mapBei.get(be.OF_CommercialElementIstanziato__c);
                if (pe == null)
                {
                    pe = new List<PricebookEntry>();
                    mapBei.put(be.OF_CommercialElementIstanziato__c, pe);
                }
                pe.add(be);
            }
            Integer i = 1;
            List<CustomObject> callTodo = new  List<CustomObject>(); 
            for (OF_CommercialElementIstanziato__c ce : cei) {
                CustomObject co = new CustomObject();  
                co.CEI = ce;
                co.bei = mapBei.get(ce.Id);
                if ('Cessato'.equals(ce.OF_Stato__c)) {
                    co.operationType = 'Update';
                    co.action='Terminate';
                } else if (ce.OF_BillingSyncronized__c) {
                    co.operationType = 'Update';
                    co.action='Modify';
                } else {
                    co.operationType = 'Create';
                    co.action='Activate';
                }
                string resCheck = checkfieldFiberLease(co);
                system.debug('@@@@resCheck:'+resCheck);
                co.notificaId = String.valueOf(System.now().getTime()) + '_' + i++;
                if ('true'.equals(resCheck)) {
                    CreateRequestForCall(co); 
                }
                else
                {
                    co.errore = rescheck;
                }
                callTodo.add(co);   
            }
            system.debug('@@@@callTodo:'+ callTodo.size());
            List<EOF_Notify__c> resnot= createListNotifyCustom(callTodo);
            insert resnot;
            List<EOF_EAI_Service_Log__c> logs =  createRequestLog(callTodo);
            insert logs; 
            Map<string,string> notif = new Map<string,string>();
            for(EOF_Notify__c n : resnot)
            {
                notif.put(n.EOF_ID_Notifica__c,n.Id);
            }
            createAttachCustom(callTodo,notif);
        }
        catch (Exception ex)
        {
            system.debug('@@@@Exception ' + ex.getLineNumber() + '  ' + ex.getMessage());
        } 
    }
    public static string checkfieldFiberLease(CustomObject co){
        OF_CommercialElementIstanziato__c cei = co.cei;
        string rt = cei.RecordType.DeveloperName;
        List<PricebookEntry> beis = co.bei;
        
        if ((co.action != 'Activate') && (co.action != 'Modify') && (co.action != 'Change') && (co.action != 'Terminate')){
            return 'action';
        }
        if ((co.operationType != 'Create') && (co.operationType != 'Update')){
            return 'operationType';
        }
        if(cei.FiberLeaseDaGISId__r.ContractId__r.ContractNumber == null || cei.FiberLeaseDaGISId__r.ContractId__r.ContractNumber.length()> 30){
            return 'Contract Number';
        }
        if(cei.FiberLeaseDaGISId__r.ContractId__r.Account.AccountNumber == null || cei.FiberLeaseDaGISId__r.ContractId__r.Account.AccountNumber.length()> 30){
            return 'Account Number';
        }
        if(cei.FiberLeaseDaGISId__r.ContractId__r.OF_IdContratto__c == null || cei.FiberLeaseDaGISId__r.ContractId__r.OF_IdContratto__c.length()> 30){
            return 'Contract OF_IdContratto__c';
        }
        if(cei.FiberLeaseDaGISId__r.Comune__c == null || cei.FiberLeaseDaGISId__r.Comune__c.length()> 255){
            return 'FiberLease Da GIS Comune';
        }
        if (cei.OF_DataAttivazione__c == null)
        {
            return 'Commercial element istanziato Data Attivazione';
        }
        if ((cei.OF_CommercialElement__r.OF_Commercial_Element_Code__c == null) || (cei.OF_CommercialElement__r.OF_Commercial_Element_Code__c.length() > 255))
        {
            return 'Commercial element code';
        }
        if ((cei.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c == null) || (cei.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c.length() > 30))
        {
            return 'Servizio Code';
        }
        if (cei.OF_CommercialElement__r.OF_Servizio__r.OF_DataInizioValidita__c == null)
        {
            return 'Servizio Inizio Validità';
        }
        if (cei.OF_CommercialElement__r.OF_Servizio__r.OF_DataFineValidita__c == null)
        {
            return 'Servizio Fine Validità';
        }
        if(beis==null || beis.size() == 0 )
        {
            return 'Billing Element size';
        }
        else 
        {
            for (PricebookEntry cbei : beis)
            {
                if (cbei.OF_DataAttivazione2__c == null)
                {
                    return 'BEI StartDate';
                }
                if ((cbei.Product2.OF_BillingElement__r.OF_Billing_Element_Code__c == null) || (cbei.Product2.OF_BillingElement__r.OF_Billing_Element_Code__c.length() > 30))
                {
                    return 'Billing Element code';
                }
                if(cbei.numCoppia__c == null)
                    return 'BEI Numero Coppia';
            }
        }
        return 'true';   
    }
    public static OF_Billing_Outbound_Schema3.OrderItemType createOrderItemTypeCustom(CustomObject wrp){
        OF_Billing_Outbound_Schema3.OrderItemType orderItem = new OF_Billing_Outbound_Schema3.OrderItemType();
        DateTime tmp = Datetime.now();
        Datetime orderDate = DateTime.newInstance(tmp.year(), tmp.month(), tmp.day());
        orderItem.operationType=wrp.operationType;
        orderItem.action=wrp.action;
        orderItem.timestamp =tmp.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        orderItem.OFCodeOrder=wrp.notificaId;//MODIFICA EFFETTUATA per MAPPING 
        orderItem.notificaId=wrp.notificaId;
        orderItem.commercialElementIstanziato= wrp.CEI.Name;
        orderItem.orderDate = orderDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        orderItem.accountNumber = wrp.CEI.FiberLeaseDaGISId__r.ContractId__r.Account.AccountNumber;
        orderItem.contractNumber=wrp.CEI.FiberLeaseDaGISId__r.ContractId__r.ContractNumber;
        orderItem.currencyCode='EUR';
        orderItem.commercialElementCode=wrp.CEI.OF_CommercialElement__r.OF_Commercial_Element_Code__c;
        orderItem.numeroBillingElement=wrp.bei.size();
        orderItem.startDateCEI=wrp.CEI.OF_DataAttivazione__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        if ('Cessato'.equals(wrp.CEI.OF_Stato__c))
        {
            orderItem.endDateCEI = wrp.cei.OF_DataCessazione__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        }
        orderItem.servizioCode=wrp.cei.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c;
        orderItem.expectedDate=wrp.CEI.OF_DataAttivazione__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        return orderItem;
    }
    public static OF_Billing_Outbound_Schema3.OrderItemOtherType createOrderItemOtherTypeCustom(CustomObject wrp){
        OF_Billing_Outbound_Schema3.OrderItemOtherType orderItemOther = new OF_Billing_Outbound_Schema3.OrderItemOtherType();
        orderItemOther.city=wrp.cei.FiberLeaseDaGISId__r.Comune__c;
        orderItemOther.agreementOperationCode=wrp.CEI.FiberLeaseDaGISId__r.ContractId__r.OF_IdContratto__c;
        orderItemOther.operatorOrderCode='N.A.';
        Date beginDate =  wrp.Cei.OF_CommercialElement__r.OF_Servizio__r.OF_DataInizioValidita__c;
        Date endDate =  wrp.Cei.OF_CommercialElement__r.OF_Servizio__r.OF_DataFineValidita__c;
        orderItemOther.durataFornituraDelServizio=string.valueOf(beginDate.monthsBetween(endDate));
        orderItemOther.idRisorsa='N.A.';
        return orderItemOther;
    }
    public static OF_Billing_Outbound_Schema3.orderItemPrices_element createOrderItemPrices_elementCustom(CustomObject wrp){
        OF_Billing_Outbound_Schema3.orderItemPrices_element orderItemPrices = new OF_Billing_Outbound_Schema3.orderItemPrices_element();
        List<OF_Billing_Outbound_Schema3.OrderItemPriceType> res = new List<OF_Billing_Outbound_Schema3.OrderItemPriceType>();
        for (PricebookEntry pe : wrp.bei)
        {
            OF_Billing_Outbound_Schema3.OrderItemPriceType ordItemPrice = new OF_Billing_Outbound_Schema3.OrderItemPriceType();
            if(pe.Quantity__c!=null)
                ordItemPrice.quantity=pe.Quantity__c.intValue();
            else
            {
                ordItemPrice.quantity=1;
            }
            ordItemPrice.price=null;
            ordItemPrice.startDateBEI=pe.OF_DataAttivazione2__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
            if (pe.OF_DataCessazione2__c != null)
            {
                ordItemPrice.endDateBEI=pe.OF_DataCessazione2__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
            }     
            ordItemPrice.priceBookName=pe.Product2.OF_BillingElement__r.OF_Billing_Element_Code__c;
            ordItemPrice.billingElementIstanziato=string.valueOf(pe.Id);
            ordItemPrice.coupleNumber= pe.numCoppia__c.intValue();
            res.add(ordItemPrice);
        }
        orderItemPrices.orderItemPrice = res;
        return orderItemPrices;
    }
    public static void CreateRequestForCall(CustomObject co){
        OF_Billing_Outbound_Schema3.OrderItemType orderItem = createOrderItemTypeCustom(co);
        OF_Billing_Outbound_Schema3.OrderItemOtherType orderItemOther = createOrderItemOtherTypeCustom(co);
        OF_Billing_Outbound_Schema3.orderItemPrices_element orderItemPrices = createOrderItemPrices_elementCustom(co);
        OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType req = new OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType();
        req.orderItem = orderItem;
        req.orderItemOther = orderItemOther;
        req.orderItemPrices = orderItemPrices;    
        co.JsonString = JSON.serialize(req);  
    } 
    public static List<EOF_Notify__c> createListNotifyCustom(List<CustomObject> calls){
        system.debug('@@@@createListNotifyCustom:');
        Id rt = [Select Id from RecordType where DeveloperName ='EOF_BILL_FIBER' Limit 1].Id;
        List<EOF_Notify__c> notifiche = new List<EOF_Notify__c>();
        
        List<EOF_Notify__c> n = [SELECT Id, indice__c FROM EOF_Notify__c WHERE RecordType.DeveloperName = 'EOF_BILL_FIBER'
                                 AND indice__c != null ORDER BY indice__c DESC LIMIT 1];
        Decimal i = 1;
        if (!n.isEmpty()) {
            i = n.get(0).indice__c + 1;
        }
        
        for (CustomObject wrp: calls) {
            EOF_Notify__c notifica = new EOF_Notify__c();
            notifica.FiberLeaseDaGIS__c=wrp.cei.FiberLeaseDaGISId__c;
            notifica.Commercial_element_istanziato__c = wrp.Cei.Id;
            notifica.RecordTypeId=rt;
            notifica.OF_isElaborato__c = true;
            notifica.OF_Billing_Type__c=wrp.action;
            notifica.OF_Billing_OperationType__c = wrp.operationType;
            notifica.EOF_ID_Notifica__c = wrp.notificaId;
            notifica.indice__c = i++;
            wrp.notifica = notifica;
            notifiche.add(notifica);
        }
        
        return notifiche;
    }
    public static List<EOF_EAI_Service_Log__c> createRequestLog(List<CustomObject> calls) {
        system.debug('@@@@createRequestLog:');
        List<EOF_EAI_Service_Log__c> toReturn = new List<EOF_EAI_Service_Log__c>();
        List<CustomObject> invalidRecords = new List<CustomObject>();
        if (calls != null) {
            Id recId = [SELECT Id FROM RecordType WHERE DeveloperName = 'SF_To_BILL' Limit 1].Id;
            for (CustomObject wrp : calls) {
                if (string.isBlank(wrp.errore)) {
                    EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
                    log.Notify__c = wrp.notifica.Id;
                    log.RecordTypeId = recId;
                    log.EOF_Richiesta_Notifica__c = 'NodificaID: '+wrp.notificaId;
                    toReturn.add(log);
                } else {
                    invalidRecords.add(wrp);
                }
            }
        }  
        System.debug('@@@@ Creo i LOG di Errore ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
        List<EOF_EAI_Service_Log__c> nackBillingLogList = createNackBillingLog(invalidRecords);
        insert nackBillingLogList;
        System.debug('@@@@ Creati i LOG di Errore ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
        System.debug('Creati ' + toReturn.size() + ' log su un totale di ' + calls.size() + ' notifiche');
        return toReturn;
    }
    public static List<EOF_EAI_Service_Log__c> createNackBillingLog(List<CustomObject> calls){
        system.debug('@@@@createNackBillingLog:');
        List<EOF_EAI_Service_Log__c> toReturn = new List<EOF_EAI_Service_Log__c>();
        if (calls != null) {
            Id recId = [Select Id from RecordType where DeveloperName = 'Nack_Billing' Limit 1].Id;
            for (CustomObject wrp : calls) {
                EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
                log.Notify__c = wrp.notifica.Id;
                log.RecordTypeId = recId;
                log.EOF_Descrizione_Causale_Scarto__c = 'Il controllo del campo ' + wrp.errore + ' non è andato a buon fine';
                toReturn.add(log);
            }
        }
        
        return toReturn;
    }
    public static void createAttachCustom(List<CustomObject> calls, Map<string,string> notifiche){
        system.debug('@@@@createAttachCustom:');
        List<Attachment> att = new List<Attachment>();
        for (CustomObject wrp: calls) {
            string parent = notifiche.get(wrp.notificaId);
            if(!string.isBlank(parent)){
                Attachment attachment = new Attachment();
                attachment.Body = Blob.valueOf(wrp.JsonString);
                attachment.Name = String.valueOf(wrp.notificaId+'.txt');
                attachment.ParentId = parent; 
                att.add(attachment);
            }
        }
        if(!att.isEmpty())
            insert att;
    }
    public static boolean callWSByCei(string ceiId,string IdNotifica){
        EOF_Notify__c notifica = [SELECT id, OF_JsonRequest__c, Asset__c
                                  FROM EOF_Notify__c
                                  where EOF_ID_Notifica__c  = : IdNotifica and REcordType.DeveloperName ='EOF_BILL_FIBER' LIMIT 1];
        
        List<Attachment> att = [select Id,ParentId, Name,body from Attachment where parentId =: notifica.Id limit 1];
        Boolean mustUpdate=false;
        if(!att.isEmpty())
        { 
            string bodyFile=att[0].body.toString();  
            if (!string.isBlank(bodyFile)){
                OF_CommercialElementIstanziato__c CEI = [select id,OF_Stato__C,OF_BillingSyncronized__c,Asset_Verticale__c,UpdateBilling__c,RecordType.DeveloperName
                                                         from OF_CommercialElementIstanziato__c
                                                         where id =:ceiId limit 1];
                OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType req = (OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType) JSON.deserialize(bodyFile, OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType.class);
                OF_Billing_Outbound_Service3.BillingOrderManagerSOAP port = new OF_Billing_Outbound_Service3.BillingOrderManagerSOAP();
                port.timeout_x = 120000;
                OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType resp = port.OrderManager(req.orderItem, req.orderItemOther, req.orderItemPrices);  
                
                //OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType resp = new OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType();
                //resp.esito ='0';
                if ('0'.equals(resp.esito)){
                    mustUpdate = true;
                    CEI.OF_BillingSyncronized__c = true;
                    CEI.UpdateBilling__c= false; 
                    update CEI;
                }  
                System.debug('@@@@ Creo il log di response ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
                Id recId2 = [Select Id from RecordType where DeveloperName ='BILL_To_SF' Limit 1].Id;
                EOF_EAI_Service_Log__c log2 = new EOF_EAI_Service_Log__c();
                log2.Notify__c=notifica.id;
                log2.RecordTypeId = recId2;
                log2.EOF_Response__c = resp.motivazione;
                log2.EOF_Descrizione_Causale_Scarto__c = resp.descrizione;
                log2.EOF_CODICE_MOTIVAZIONE__c=resp.codiceMotivazione;
                log2.OF_SA_Esito__c=resp.esito;
                insert log2;
            }
        }
        return mustUpdate;
    }
     @future(callout=true)
    public static void CallCei(string IdCei, string nId){
        Boolean b =callWSByCei(IdCei,nId);
        if(b){}
    }
    */
}
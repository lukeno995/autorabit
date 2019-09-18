global class OF_Billing_RetrySchedule implements Schedulable,Database.AllowsCallouts {
    global string IdNotifica{get;set;}
    public OF_Billing_RetrySchedule(String IdNot) { 
        IdNotifica = IdNot;
    }
    global void execute(SchedulableContext SC){     
        EOF_Notify__c notifica = [select id,OF_Billing_Type__c, EOF_ID_Notifica__c, OF_Billing_OperationType__c,Commercial_element_istanziato__r.Id,  Account__r.Id , Contract__r.Id from EOF_Notify__c where EOF_ID_Notifica__c=:IdNotifica Limit 1];
        if(notifica.Account__r.Id!=null)
        {
            Account acc = [Select id,AccountNumber,RecordTypeId, Name,EOF_Codice_Operatore__c, BillingCity, BillingCountry, BillingEmail__c, BillingPostalCode, BillingState, BillingStreet, Status__c, StartDate__c, TaxationCode__c,VATNumber__c, PEC__c, Class__c,  Industry from Account where Id =: notifica.Account__r.Id Limit 1];
            
            SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
            wrp.acc=acc;
            wrp.action = notifica.OF_Billing_Type__c;
            
            string check = SyncBillingAccountUtils.checkFields(wrp);
            if('true'.equals(check)){
                
                String jsonString = JSON.serialize(wrp);
                CallAccount(jsonString,IdNotifica); 
            }
            
        }
        else if(notifica.Contract__r.Id!=null)
        {
            Contract con = [SELECT Id,Status,StartDate,Name,OF_Contract_Code__c, Account.AccountNumber, ContractNumber, EndDate, SuspendedDate__c, OF_TermPayment__c, BillingFrequency__c, ContractTerm, OF_IdContratto__c  FROM contract where Id =:notifica.Contract__r.Id Limit 1];
            SyncBillingContractUtils.Wrapper wrpC = new SyncBillingContractUtils.Wrapper();
            wrpC.action = notifica.OF_Billing_Type__c;
            wrpC.operationType=notifica.OF_Billing_OperationType__c;
            wrpc.con= con; 
            
            string check = SyncBillingContractUtils.CheckField(wrpC); 
            if('true'.equals(check))
            {
                String jsonString = JSON.serialize(wrpC);
                CallContract(jsonString,IdNotifica);
            }
        }
        else if(notifica.Commercial_element_istanziato__c!=null)
       /* {
            if('PO_CEI_FiberLease'.equals(notifica.Commercial_element_istanziato__r.RecordType.DeveloperName)){
                SyncBillingContractUtils.CallCei(notifica.Commercial_element_istanziato__c,notifica.EOF_ID_Notifica__c);
            }
            else*/{
                SyncBillingAssetUtils.CallCei(notifica.Commercial_element_istanziato__c,notifica.EOF_ID_Notifica__c);
           // }
        }
    }
    @future(callout=true)
    public static void CallContract(String JsonString,string Idnotifica){
        SyncBillingContractUtils.Wrapper wrp =  (SyncBillingContractUtils.Wrapper)Json.deserialize(jsonString, SyncBillingContractUtils.Wrapper.class);
        SyncBillingContractUtils.callWSContract(wrp,Idnotifica);
    }
    @future(callout=true)
    public static void CallAccount (String JsonString,string Idnotifica){

        SyncBillingAccountUtils.Wrapper wrp =  (SyncBillingAccountUtils.Wrapper)Json.deserialize(jsonString, SyncBillingAccountUtils.Wrapper.class);
        SyncBillingAccountUtils.callWSAccount(wrp,Idnotifica);
        
    }
}
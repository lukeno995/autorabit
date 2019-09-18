trigger OF_SyncBillingAccountTrigger on Account (before insert, after insert, before update, after update) {
    
    List<String> errors = new List<String>();
    List<SyncBillingAccountUtils.Wrapper> ErrorWrapper = new List<SyncBillingAccountUtils.Wrapper>();
    
    Id RecTypeId = [Select Id from RecordType where DeveloperName ='OLO' limit 1].Id;  

    for(Account acc : Trigger.New)
    {
        if(RecTypeId.equals(acc.RecordTypeId))
        { 
            if(Trigger.isBefore)
            {
                if(Trigger.isUpdate){
                    Account oldAccount = Trigger.oldMap.get(acc.ID);
                    
                    if(('Bozza'.equals(oldAccount.Status__c) ||'Non Attivo'.Equals(oldAccount.Status__c))&& 'Attivo'.Equals(acc.Status__c) )
                    {
                        acc.SyncBilling__c = false; 
                        acc.StartDate__c = DateTime.now(); 
                    }
                    else if('Attivo'.Equals(oldAccount.Status__c) && 'Attivo'.Equals(acc.Status__c) && oldAccount.SyncBilling__c && acc.SyncBilling__c)
                    {
                        acc.SyncBilling__c = false;
                    }
                }
                else if ('Attivo'.Equals(acc.Status__c)  )
                {   
                    acc.SyncBilling__c = false;
                    acc.StartDate__c = DateTime.now(); 
                } 
            }
            else if(Trigger.isAfter)
            {
                if(!acc.SyncBilling__c)
                {
                    SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
                    wrp.acc= acc;
                    if(Trigger.isInsert)
                    {
                        wrp.action='Activate';
                    }
                    else 
                    { 
                        Account oldAccount = Trigger.oldMap.get(acc.ID);
                        
                        if(acc.OF_BillingSyncronized__c)
                        {
                            wrp.action='Modify'; 
                        }
                        else
                        {
                            wrp.action='Activate'; 
                        }   
                    }
                    string check = SyncBillingAccountUtils.checkFields(wrp);
                    if('true'.equals(check)){
                        SyncBillingAccountUtils.callBatch(wrp);
                    }
                    else 
                    {
                        ErrorWrapper.add(wrp);
                        errors.add(check);
                    }
                }
            }
        }
    }
    
    //creare notifiche e log  
    
    List<EOF_Notify__c> notif = SyncBillingAccountUtils.createListNotify(ErrorWrapper);   
    SyncBillingAccountUtils.createListLog(notif, errors, '', '','','', '', '');
}
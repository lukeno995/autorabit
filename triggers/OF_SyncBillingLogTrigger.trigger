trigger OF_SyncBillingLogTrigger on EOF_EAI_Service_Log__c (after insert){
    
    List<RecordType> RecTypeIds = [Select Id,DeveloperName from RecordType where DeveloperName ='BILL_TO_SF' or DeveloperName ='Nack_Billing' limit 2];
    
    Map<string,Id> recIdsMap = new Map<string,Id>();
    
    for(RecordType r : RecTypeIds)
    {
        recIdsMap.put(r.DeveloperName, r.Id);
    }
    
    
    Boolean contains = false;
    
    Set<Id> values = new Set<Id>(recIdsMap.values());
    for(EOF_EAI_Service_Log__c log :trigger.New)
    {
        system.debug('@@@@@OF_SyncBillingLogTrigger LOG '+ log);
        
        if(values.contains(log.RecordTypeId))
        {
            contains = true;
            break;
        }
    }
    
    system.debug('@@@@@@@ map '+recIdsMap);
    
    if(contains)
    { 
        
        Id RecTypeId = recIdsMap.get('BILL_To_SF'); 
        Id NackBillingId = recIdsMap.get('Nack_Billing'); 
        
        //Deleting previous job        
        List<CronTrigger> ctr = [SELECT Id,cronJobDetail.Name FROM CronTrigger WHERE cronJobDetail.Name like 'Retry Billing Job%'];
        
        List<EOF_EAI_Service_Log__c> currentLogs = [select recordTypeId, Id,EOF_CODICE_MOTIVAZIONE__c,Notify__r.EOF_ID_Notifica__c,Notify__c from EOF_EAI_Service_Log__c where Id in: Trigger.New];
        
        List<string> notifiche = new List<string>();
        
        for(EOF_EAI_Service_Log__c l : currentLogs)
        {
            if(string.isNotBlank(l.Notify__c))
            {
                notifiche.add(l.Notify__c);
            }
        }
        
        system.debug('@@@@@ notifiche' + notifiche);
        List<EOF_EAI_Service_Log__c> logs = [select Id,Notify__c 
                                             from EOF_EAI_Service_Log__c 
                                             where Notify__c in:notifiche 
                                             and EOF_CODICE_MOTIVAZIONE__c in ('A02','A00')];
        
        
        map<String,Integer> mapA= new  map<String,Integer>();
        for(EOF_EAI_Service_Log__c xx:logs){
            Integer tmp= mapA.get(xx.Notify__c);
            if(tmp!=null)
                mapA.put(xx.Notify__c,tmp+1);
            else{
                mapA.put(xx.Notify__c,1);
            }
        }            
        
        for(EOF_EAI_Service_Log__c log : currentLogs)
        {
            system.debug('@@@@@RecTypeId :' + RecTypeId);
            system.debug('@@@@@log :' + log);
            if(RecTypeId != null && RecTypeId.equals(log.recordTypeId))
            {
                if('A02'.equals(log.EOF_CODICE_MOTIVAZIONE__c) || 'A00'.equals(log.EOF_CODICE_MOTIVAZIONE__c))
                {                
                    if(mapA.get(log.Notify__c)<4)
                    {
                        for(CronTrigger c : ctr){
                            if(c.cronJobDetail.Name.equals('Retry Billing Job'+String.valueOf(log.Notify__r.EOF_ID_Notifica__c)))
                            {
                                system.abortJob(c.Id);
                            }
                        }
                        
                        OF_Billing_RetrySchedule retry = new OF_Billing_RetrySchedule(String.valueOf(log.Notify__r.EOF_ID_Notifica__c));
                        string Cron = SyncBillingAccountUtils.GetCRONExpression(System.now().addMinutes(10));
                        system.schedule('Retry Billing Job'+String.valueOf(log.Notify__r.EOF_ID_Notifica__c), Cron, retry);
                    }
                    else
                    {
                        //Deleting previous job        
                        for(CronTrigger c : ctr){
                            if(c.CronJobDetail.Name.equals('Retry Billing Job'+String.valueOf(log.Notify__r.EOF_ID_Notifica__c)))
                            {
                                system.abortJob(c.Id);
                            }
                        }
                    }
                    
                }
                else 
                {
                    //Deleting previous job        
                    for(CronTrigger c : ctr){
                        if(c.CronJobDetail.Name.equals('Retry Billing Job'+String.valueOf(log.Notify__r.EOF_ID_Notifica__c)))
                        {
                            system.abortJob(c.Id);
                        }
                    }
                }
            }
            else if(NackBillingId != null && NackBillingId.equals(log.recordTypeId))
            {
                for(CronTrigger c : ctr){ 
                    if(c.cronJobDetail.Name.equals('Retry Billing Job'+String.valueOf(log.Notify__r.EOF_ID_Notifica__c)))
                    {
                        system.abortJob(c.Id);
                    }
                } 
            }
        }
    }
}
trigger OF_SyncBillingContractTrigger on Contract (before insert, before update, after insert, after update) {

    for(Contract con : Trigger.New)
    {        
        system.debug('@@@@con' + con);
        if(trigger.isBefore)
        {
            if(trigger.isUpdate)
            {
                Contract oldContract = Trigger.oldMap.get(con.ID);  
                if('Draft'.equals(oldContract.Status) && 'Attivo'.equals(con.Status))
                {
                    con.SyncBilling__c=false;
                }
                else if('Attivo'.equals(con.Status))
                {
                    if(oldContract.SyncBilling__c == con.SyncBilling__c)
                    {
                        con.SyncBilling__c=false;
                    }                    
                }
                else if('Attivo'.equals(oldContract.Status) && 'Cessato'.equals(con.Status))
                {
                    if(con.OF_BillingSyncronized__c)
                    {
                        con.SyncBilling__c=false;
                    }
                }
                else if('Cessato'.equals(oldContract.Status) && 'Cessato'.equals(con.Status))
                {
                    if(oldContract.SyncBilling__c == con.SyncBilling__c && con.SyncBilling__c == false)
                    {
                        if(con.OF_BillingSyncronized__c)
                        {
                            con.SyncBilling__c=false;
                        }
                    }     
                }
            }
            else
            {
                if('Attivo'.equals(con.Status) )
                { 
                    con.SyncBilling__c=false;
                }
            }
        }
        else
        {
            SyncBillingContractUtils.Wrapper wrpC = new SyncBillingContractUtils.Wrapper();      
            if(trigger.isUpdate)
            {      
                if(con.OF_BillingSyncronized__c)
                {
                    wrpC.operationType='Update';
                }
                else
                {
                    wrpC.operationType='Create';
                }
                Contract oldContract = Trigger.oldMap.get(con.ID);  
                system.debug('@@@@OLD' + oldContract.Status);
                system.debug('@@@@current' + con.Status);

                if('Draft'.equals(oldContract.Status) && 'Attivo'.equals(con.Status))
                {
                    wrpC.action='Activate';
                }
                else if( !('Cessato'.equals(oldContract.Status)) && 'Attivo'.equals(con.Status))
                {
                    if(!con.SyncBilling__c)
                    {
                        if(con.OF_BillingSyncronized__c)
                        {
                            wrpC.action='Modify';
                        }
                        else
                        {
                            wrpC.action='Activate';
                        }
                    }                    
                }
                else if('Attivo'.equals(oldContract.Status) && 'Cessato'.equals(con.Status))
                {
                    if(con.OF_BillingSyncronized__c)
                    {
                        wrpC.action='Terminate';
                    }
                }
                else if('Cessato'.equals(oldContract.Status) && 'Cessato'.equals(con.Status))
                {
                    if(con.OF_BillingSyncronized__c)
                    {
                        wrpC.action='Terminate';
                    }
                } 
            }
            else
            {   
                if('Attivo'.equals(con.Status) )
                { 
                    wrpC.operationType='Create';
                    wrpC.action='Activate';
                }
            }
            wrpC.con= con;
            
            system.debug('@@@@@@@ WRP ' + wrpC);
            if(string.isNotBlank(wrpC.action)){
                if(!con.SyncBilling__c){
                    SyncBillingContractUtils.callBatch(wrpC);
                }
            }  
        }
    }
}
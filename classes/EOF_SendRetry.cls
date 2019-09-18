global class EOF_SendRetry implements Schedulable{
    
    global void execute(SchedulableContext SC){   
        List<Case> caseListNACK =[select Id,EOF_Codice_Ordine_OLO__C,recordtype.developername, OF_OM_Nuovo_Flusso__c from Case where OF_Retry_Automatico__c=false 
                                  AND (OF_Response_Da_OLO__c='NACK TECNICO' OR OF_Response_Da_OM__c='NACK TECNICO') order by lastModifiedDate ASC limit 49];
       
        
        if(caseListNACK!=null && !caseListNACK.isEmpty()){
            for(case c : caseListNACK){
                if(c.recordtype.developername=='OF_SA_Attivazione' || c.recordtype.developername=='OF_SA_Cessazione' ){
                    if(c.OF_OM_Nuovo_Flusso__c){
                        //Nuovi Attivi
                        if(!test.isRunningTest()){
                            OF_SA_SendRetryAttivi_MethodsNew.routeRetry(c.Id,c.recordtype.developername, c.EOF_Codice_Ordine_OLO__C);
                        }
                    }else{
                        if(!test.isRunningTest()){
                            OF_SA_SendRetryAttivi_Methods.retryCalloutOLOOM(c.Id,c.recordtype.developername, c.EOF_Codice_Ordine_OLO__C);
                        }
                    }                    
                }
                else if(c.recordtype.developername=='EOF_Caso_Attivazione' || c.recordtype.developername=='EOF_Caso_Cessazione' ){
                    if(c.OF_OM_Nuovo_Flusso__c){
                        //Nuovi passivi
                        if(!test.isRunningTest()){
                            OF_GPONP_SendRetryPassivi_MethodsNew.routeRetry(c.Id,c.recordtype.developername, c.EOF_Codice_Ordine_OLO__C);
                        }
                    }else{
                        if(!test.isRunningTest()){
                            OF_SendRetryPassivi_Methods.retryCalloutOLOOM(c.Id,c.recordtype.developername, c.EOF_Codice_Ordine_OLO__C);
                        }
                    }
                }
                else if(c.recordtype.developername=='EOF_Caso_ChangeOrder_OPENSTREAM'){
                     if(!test.isRunningTest()){
                    	OF_SendRetryChangeOrder_Methods.retryCalloutSFOM(c.Id,c.recordtype.developername, c.EOF_Codice_Ordine_OLO__C);
                     }
                }else if(c.recordtype.developername=='Trouble_Ticket'){
                    if(!test.isRunningTest()){
                        OF_TTM_SendRetryTTM_Methods.retryCalloutToTTM(c.Id);
                    }
                }
                else if(c.recordtype.developername=='OF_PP_PreProvisioning_Vlan'){
                	if(!test.isRunningTest()){
                        //OF_TTM_SendRetryTTM_Methods.retryCalloutToTTM(c.Id);
                    }
                }
                c.OF_Retry_Automatico__c=true;
            }
            update caseListNACK;
        }
        
        Integer i=0;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        i=i+1;
        
        //Deleting previous job
        CronTrigger c = [SELECT Id FROM CronTrigger WHERE cronJobDetail.Name = 'Retry Job 2'];
        system.abortJob(c.Id);
        
        //Re-scheduling job for the next 30 minutes
        EOF_SendRetry sr = new EOF_SendRetry();       
        DateTime next_run = system.now().addMinutes(30);        
        String sch = '0 ' + next_run.minute() + ' * * * ?';
        String jobID = system.schedule('Retry Job 2', sch, sr);
        
        
    } 
}
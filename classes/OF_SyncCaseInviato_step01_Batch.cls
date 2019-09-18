//GB OK

global class OF_SyncCaseInviato_step01_Batch implements Database.AllowsCallouts,Database.Batchable<sObject>, Database.Stateful {

    private Set<String> caseDevNames = new Set<String>{'OF_SA_Attivazione', 'OF_SA_Cessazione', 'EOF_Caso_Attivazione', 'EOF_Caso_Cessazione'};
            
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('@@@@ Inizio Batch 1: ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));

        Datetime d = System.now().addMinutes(-50);  
                
        String query = 'SELECT Id, EOF_Codice_Ordine_OLO__c, OF_Bonifica_Locked_Row__c, OF_Bypassa_SLA__c, RecordType.DeveloperName, Status, LastModifiedDate'
            + ' FROM Case ';
        if(Test.isRunningTest()){
          query = query +'limit 1';
        }    
        else{    query = query + ' WHERE status=\'Inviato\' AND createdDate < :d  AND RecordType.DeveloperName IN :caseDevNames ORDER BY createdDate DESC, OF_Bonifica_Locked_Row__c DESC';
            //query = query + ' WHERE id=\'5004E000009IWumQAG\'';
        }

        system.debug('@@@@query ' + query);

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Case> scope) {
        
        for(Case c : scope){
            System.debug('Case: ' + c.Id);
            //se devo bloccare le callout perche gia avvenute
            c.OF_Bonifica_Locked_Row__c = true;
            //se devo bypassare gli SLA
            c.OF_bypassa_SLA__c = true;
        }
        update scope;
    }

    global void finish(Database.BatchableContext BC) {
           for (CronTrigger ct : [SELECT Id, CronJobDetail.Name, CronJobDetail.JobType
                                   FROM CronTrigger
                                   WHERE CronJobDetail.Name like 'SYNC_STEP2%' limit 1]) {

                System.abortJob(ct.id);
            }                    

            DateTime t = System.now().addSeconds(29);
            String nextFireTime = getCRONExpression(t);
            System.schedule('SYNC_STEP2', nextFireTime, new OF_SyncCaseInviato_step2_Sched());
    }
    
    public static String getCRONExpression(Datetime dt) {
        return ('' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year());
    }
}
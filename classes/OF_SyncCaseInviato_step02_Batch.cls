//GB OK

global class OF_SyncCaseInviato_step02_Batch implements Database.AllowsCallouts,Database.Batchable<sObject>, Database.Stateful {
        
    private Set<String> logDevNames = new Set<String>{'OF_SA_FiberRequest', 'FiberRequest'};
    private Set<String> tipoComunicazione = new Set<String>{'OLO->SF - ActivationRequest', 'OLO->SF - FiberRequest - Attivazione', 'OLO->SF - FiberRequest - Cessazione', 'OLO->SF - DeactivationRequest'};


    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('@@@@ Inizio Batch 2: ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
            
        String query = 'SELECT Id, Caso__r.Id, RecordType.DeveloperName, OF_SA_Metodo__c'
            + ' FROM EOF_EAI_Service_Log__c ';
        if(Test.isRunningTest()){
          query = query +'order by createddate desc limit 1';
        }    
        else{
          query = query + ' WHERE Caso__r.status=\'Inviato\' and Caso__r.OF_Bonifica_Locked_Row__c=true and Caso__r.OF_bypassa_SLA__c=true AND RecordType.DeveloperName IN :logDevNames AND EOF_Tipo_Comunicazione_String__c IN :tipoComunicazione ORDER BY createdDate ASC';
            //query = query + ' WHERE Caso__c=\'5004E000009IWumQAG\' AND RecordType.DeveloperName IN :logDevNames AND EOF_Tipo_Comunicazione_String__c IN :tipoComunicazione ORDER BY createdDate ASC';
        }
        system.debug('@@@@query ' + query);

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<EOF_EAI_Service_Log__c> scope) {
        
        for(EOF_EAI_Service_Log__c sl : scope){
            try{
            if('FiberRequest'.equalsIgnoreCase(sl.RecordType.DeveloperName)){
                OM_GW_Utils.checkAsyncSync(sl.Caso__r.Id, sl.Id);
            } else if('OF_SA_FiberRequest'.equalsIgnoreCase(sl.RecordType.DeveloperName)) {
                if('OLO_ActivationSetup_OpenStream'.equalsIgnoreCase(sl.OF_SA_Metodo__c)){
                    OF_SA_OLO_AsyncChecks.OLO_AsyncActivationSync(sl.Caso__r.Id, sl.Id);
                } else  if('OLO_DeactivationOrder'.equalsIgnoreCase(sl.OF_SA_Metodo__c)){
                    OF_SA_OLO_AsyncChecks.OLO_AsyncDeactivationSync(sl.Caso__r.Id, sl.Id);
                }
            }
            }
            catch(Exception e){
              system.debug('e'+e);
            }
        }
    }

    global void finish(Database.BatchableContext BC) {
        
    }
}
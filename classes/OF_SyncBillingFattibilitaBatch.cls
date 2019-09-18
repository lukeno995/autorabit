global class OF_SyncBillingFattibilitaBatch implements Database.AllowsCallouts,Database.Batchable<sObject>, Database.Stateful {
    
    private List<String> idAsset;
    
    global Integer scopeSize;
    global Integer firstIndex;
    
    public OF_SyncBillingFattibilitaBatch(List<string> assetId) {
        idAsset = assetId;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('@@@@ Inizio Fattibilita Batch: ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
        
        Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
        Integer lim = verticaliCS.createNotifyBatchLimit__c.intValue();
        
        String rTypes = verticaliCS.RecorTypesList__c;
        String ServiceList = verticaliCS.serviceList__c;
        String query = 'SELECT id, RecordType.DeveloperName, OF_DataAttivazione__c,OF_Stato__c,'
            +'Name,Asset_Verticale__c,LastModifiedDate,OF_BillingSyncronized__c,Code_IAV__c,Descrizione_IAV__c,OF_TT_Number__c,OLO_Comm_Code__c,'
            +'Provincia__c,Comune__c,Indirizzo__c,OF_DataCessazione__c,Civico__c,Particella_Toponomastica__c,'
            +'OF_CommercialElement__r.OF_Commercial_Element_Code__c,'
            +'OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,'
            +'OF_CommercialElement__r.OF_Servizio__r.OF_DataInizioValidita__c,'
            +'OF_CommercialElement__r.OF_Servizio__r.OF_DataFineValidita__c,'
            +'OF_CommercialElement__r.Name,ID_GIS_Scala_Palazzina__c,ID_DB_Building__c,ID_DB_Scala_Palazzina__c,UI_Scala_Palazzina__c,'
            +'OF_Asset__c,OF_Asset__r.name,OF_Asset__r.Account.name,'
            +'OF_Asset__r.Account.AccountNumber,'
            +'OF_Asset__r.Data_Avvio_Fatturazione__c,'
            +'OF_Asset__r.OF_DataAttivazione2__c,'
            +'OF_Asset__r.Accordo_Operativo__c,'
            +'OF_Asset__r.OF_Provincia__c,'
            +'OF_Asset__r.OF_Comune__c,'
            +'OF_Asset__r.OF_Indirizzo__c,'
            +'OF_Asset__r.OF_Civico__c,'
            +'OF_Asset__r.OF_Particella_Toponomastica__c,'
            +'OF_Asset__r.EOF_ID_Risorsa__c,'
            +'OF_Asset__r.Status,'
            +'OF_Asset__r.OF_ID_Building__c,'
            +'OF_Asset__r.OF_Contract__c,'
            +'OF_Asset__r.recordType.name,'
            +'OF_Asset__r.recordType.developername,'
            +'OF_DataSospensione__c,OF_Asset__r.OF_ProfiloOpenStream__c'
            + ' FROM OF_CommercialElementIstanziato__c WHERE RecordType.DeveloperName in ( '+rTypes+' ) and OF_CommercialElement__r.OF_Servizio__r.Name IN ( '+ServiceList+' ) and UpdateBilling__c =true and OF_Asset__c != null and OF_Stato__c != \'Sospeso\'';
        if (!idAsset.isEmpty()) {
            query = query + ' and OF_Asset__c in :idAsset LIMIT :lim';
        }        
        
        system.debug('@@@@@DOPO: '+ query);
        List<EOF_Notify__c> n = [SELECT Id, indice__c FROM EOF_Notify__c WHERE RecordType.DeveloperName = 'EOF_BILL_Asset'
                                 AND indice__c != null ORDER BY indice__c DESC LIMIT 1];
        Decimal i = 1;
        if (!n.isEmpty()) {
            i = n.get(0).indice__c + 1;
        }
        firstIndex = i.intValue();
        rTypes = rTypes.replaceAll('\'','') ;
        List<string> RecorTypes = rTypes.split(',');
        
        AggregateResult size = [SELECT count(Id) tot FROM OF_CommercialElementIstanziato__c
                                WHERE RecordType.DeveloperName in :RecorTypes and UpdateBilling__c = true];
        scopeSize = Integer.valueOf(size.get('tot'));
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<OF_CommercialElementIstanziato__c> scope) {
        
        system.debug('@@@@@scope: '+ scope.size());
        SyncBillingAssetUtils.callWSAssetFattibilitaCustom(scope);
    }
    
    global void finish(Database.BatchableContext BC) {
        //se non è vuoto vuol dire che la chiamata è fatta dal tasto
        if (!idAsset.isEmpty()) {
            List<Asset> assets = [SELECT id, OF_SyncNoVert__c FROM Asset WHERE Id IN :idAsset];
            for (Asset asse : assets) {
                asse.OF_SyncNoVert__c = false;
            }
            
            update assets;
            
            List<EOF_Notify__c> n = [SELECT Id, indice__c FROM EOF_Notify__c WHERE RecordType.DeveloperName = 'EOF_BILL_Asset'
                                     AND indice__c != null ORDER BY indice__c DESC LIMIT 1];
            
            if(!n.isEmpty()){
                OF_CallWSFattibilita batchable = new OF_CallWSFattibilita(firstIndex, n.get(0).Indice__c.intValue());
                Database.executeBatch(batchable, 1);
                return;
            }
        }//end !idAsset.isEmpty
        
        Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
        Integer numBatch = verticaliCS.callWsBillingBatchSize__c.intvalue();
        
        List<OF_CallWSFattibilitaBatch_Sched> schedList = new List<OF_CallWSFattibilitaBatch_Sched>();
        if (scopeSize >= numBatch) {
            Integer offset = scopeSize / numBatch;
            Integer startIndex = firstIndex;
            Integer endIndex = startIndex + offset;
            
            for (Integer i = 1; i < numBatch; i++) {
                schedList.add(new OF_CallWSFattibilitaBatch_Sched(startIndex, endIndex));
                startIndex = endIndex + 1;
                endIndex += offset;
            }
            
            schedList.add(new OF_CallWSFattibilitaBatch_Sched(startIndex, firstIndex + scopeSize));
            
        } else if (scopeSize > 0) {
            schedList.add(new OF_CallWSFattibilitaBatch_Sched(firstIndex, firstIndex + scopeSize));
        }
        
        if (!schedList.isEmpty()) {
            for (CronTrigger ct : [SELECT Id, CronJobDetail.Name, CronJobDetail.JobType
                                   FROM CronTrigger
                                   WHERE CronJobDetail.Name like 'CALL WS BILLING FATTIBILITA %' LIMIT :numBatch]) {
                                       
                                       System.abortJob(ct.id);
                                   }
             
            Integer i = 1;
            DateTime t = System.now().addSeconds(29);
            for (OF_CallWSFattibilitaBatch_Sched s : schedList) {
                String nextFireTime = getCRONExpression(t.addSeconds(i));
                System.schedule('CALL WS BILLING FATTIBILITA ' + i, nextFireTime, s);
                i++;
            }
        }
    }
    
    public static String getCRONExpression(Datetime dt) {
        return ('' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year());
    }
}
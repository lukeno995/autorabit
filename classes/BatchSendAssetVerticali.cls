global class BatchSendAssetVerticali implements Database.Batchable<sObject>,Database.Stateful 
{
    
    global String csvColumnHeader;
    global List<String> csvRowValuesNew = new List<String>();
    global List<String> csvRowValuesOld = new List<String>();
    global String query;
    global String finalStringOld='';
    global String finalStringNew='';
    global String rowTesta = 'ID Risorsa;ID Building;Particella Toponomastica;Indirizzo;Numero Civico;Comune\n';
    global Blob bOld ;
    global Blob bNew ;
    global integer LimitCount;// = Integer.valueOf(Label.OF_Limit_PNI); //Inserire customLabel in Prod 
    global String subject ;
    global String fromEmail ;
    global String textBody ;
    global String textBody2 ;
    global List<String> toAddresses ;
    global List<String> ccAddresses ;
    global EOF_EAI_Service_Log__c slTrackPNI;
    global Integer count = 0;
    global Integer atchCount =0;
    Global EOF_EAI_Service_Log__c sl;
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        query =	'select id,name,OF_ServizioRichiesto__c ,recordType.name,EOF_ID_Risorsa__c,OF_ID_Building__c,OF_Particella_Toponomastica__c,OF_Indirizzo__c,OF_Civico__c,OF_Comune__c '
            +' from asset where Status in(\'Attivo\',\'Cessato\') and recordType.name in(\'Open Stream\', \'GPON Passiva\') and EOF_ID_Risorsa__c != null and OF_ID_Building__c != null'
            +'  and OF_Particella_Toponomastica__c  != null and OF_Indirizzo__c != null and OF_Civico__c != null and OF_Comune__c !=null ';
        
        system.debug('#######> query: ' + query);
        finalStringOld = rowTesta;
        Id rt = [select id,name from RecordType where DeveloperName ='OF_Tracciamento_PNI'].id;
        sl = new EOF_EAI_Service_Log__c();
        sl.EOF_NOTE__c = 'Invio a PNI del: ' + system.now();
        sl.RecordTypeId=rt;
        insert sl;
        system.debug('++++ sl : ' + sl.id);
        return Database.getQueryLocator(query);
    }
    
    
    global void execute(Database.BatchableContext BC, List<Asset> scope){	       
        if (scope != null  && !scope.isEmpty()) {
            system.debug('++++ size scope: ' + scope.size ());
            system.debug('++++ size LimitCount: ' + LimitCount);
            List<ReportVerticali__c> reps = new List<ReportVerticali__c>();
            for(Asset a : scope) {
                String checkRisorsa = a.EOF_ID_Risorsa__c;
                if (checkRisorsa.isNumeric() && checkRisorsa.length() ==19){
                    ReportVerticali__c r = new ReportVerticali__c();
                    r.Civico__c = a.OF_Civico__c;
                    r.Comune__c = a.OF_Comune__c;
                    r.IDBuilding__c = a.OF_ID_Building__c;
                    r.IDRisorsa__c= a.EOF_ID_Risorsa__c;
                    r.Indirizzo__c= a.OF_Indirizzo__c;
                    r.ParticellaTop__c= a.OF_Particella_Toponomastica__c;
                    reps.add(r);
                }
            }
            if(!reps.isEmpty())
            {
                insert reps;
            } 
        }
    }  
    
    global void finish(Database.BatchableContext BC){
        
        List<CronTrigger> ctr = [SELECT Id,cronJobDetail.Name FROM CronTrigger WHERE cronJobDetail.Name ='CreateREportBilling'];
        for(CronTrigger c : ctr){ 
            system.abortJob(c.Id);
        } 
        
        Database.executeBatch(new OF_PNI_DeleteStaging_Batch());
        
        if(!test.isRunningTest()){
            RunReportAsyncSched b = new RunReportAsyncSched();
            system.schedule('CreateREportBilling', GetCRONExpression(Datetime.now().addSeconds(20)), b);
        }
    }
    private static String GetCRONExpression(Datetime dt) {
        return ('' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year());
    }     
}
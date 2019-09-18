global class OF_PNI_BonificaAssetVerticali_Batch implements Database.Batchable<sObject>, Database.Stateful {

	global String query;
	global EOF_EAI_Service_Log__c slTrackPNI;

	global Database.QueryLocator start(Database.BatchableContext BC) {

		List<AggregateResult> aggr = [SELECT Asset_Verticale__c FROM OF_Billing_Element_Verticale__c
									  WHERE OF_Status__c = 'ATTIVO' GROUP BY Asset_Verticale__c, OLO__r.name
									  HAVING count(id) > 1];

		Set<String> idAVList = new Set<String>();
		String field = 'Asset_Verticale__c';
		for (AggregateResult ag : aggr) {
			idAVList.add(String.valueOf(ag.get(field)));
		}

		query = 'SELECT id, ID_Risorsa__c, Update_Billing__c, Asset__c, Asset__r.OF_Contract__c, Asset__r.OF_OrdineID__c, Asset_Verticale__c, Asset_Verticale__r.ID_GIS_Scala_Palazzina__c, OLO__r.name, Data_Attivazione__c, CreatedDate, LastModifiedDate ' +
			'FROM OF_Billing_Element_Verticale__c ' +
			'WHERE OF_Status__c = \'ATTIVO\' AND Asset_Verticale__c IN :idAVList ' +
			'ORDER BY Asset_Verticale__c, OLO__r.name, Data_Attivazione__c ';


		System.debug('Query batch Verticali Step3: ' + query);

		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<OF_Billing_Element_Verticale__c> bevs) {

		system.debug('listaBEV size: ' + bevs.size());
		OF_PNI_GIS_Obsoleti_Check_Bonifica ctrl = new OF_PNI_GIS_Obsoleti_Check_Bonifica();
		try {
			ctrl.run(bevs);
		}
		catch (Exception ex) {
			system.debug('@@ERRORE: ' + ex.getMessage() + ' negli oggetti: ' + ex.getStackTraceString());
		}
	}

	global void finish(Database.BatchableContext BC) {
		List<AggregateResult> aggr =  [SELECT Asset_Verticale__c FROM OF_Billing_Element_Verticale__c
									   WHERE OF_Status__c = 'ATTIVO' GROUP BY Asset_Verticale__c, OLO__r.name
									   HAVING count(id) > 1 LIMIT 1];

		if (!aggr.isEmpty()) {
			DateTime bTime = System.now().addSeconds(2);

			//String hour = String.valueOf(bTime.hour());
			//String min = String.valueOf(bTime.minute());
			//String ss = String.valueOf(bTime.second());

			String nextFireTime = OF_WS_SEMAFORO_VERTICALE.GetCRONExpression(bTime);//ss + ' ' + min + ' ' + hour + ' * * ?';

			OF_PNI_BonificaAssetVerticali_sched b = new OF_PNI_BonificaAssetVerticali_sched();

			//rimuovo il job esistente
			List<CronTrigger> ct = [SELECT Id, CronJobDetail.Name, CronJobDetail.JobType
									FROM CronTrigger
									WHERE CronJobDetail.Name = 'Bonifica Asset Vert' LIMIT 1];

			if (!ct.isEmpty()) {
				system.abortJob(ct[0].id);
			}

			System.schedule('Bonifica Asset Vert', nextFireTime, b);
		} else {
			DateTime bTime = System.now().addHours(1);
			String nextFireTime = OF_WS_SEMAFORO_VERTICALE.GetCRONExpression(bTime);

			OF_SyncBillingAssetVerticale_Batch b = new OF_SyncBillingAssetVerticale_Batch();
			//rimuovo il job esistente
			List<CronTrigger> ct = [SELECT Id, CronJobDetail.Name, CronJobDetail.JobType
									FROM CronTrigger
									WHERE CronJobDetail.Name = 'Billing Vert' LIMIT 1];
			if (!ct.isEmpty()) {
				system.abortJob(ct[0].id);
			}

			if (!Test.isRunningTest()) {
				System.schedule('Billing Vert', nextFireTime, b);
			}
		}
	}

}
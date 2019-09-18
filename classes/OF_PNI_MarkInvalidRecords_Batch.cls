global class OF_PNI_MarkInvalidRecords_Batch implements Database.Batchable<sObject>, Database.Stateful {

	global String query;
	global EOF_EAI_Service_Log__c slTrackPNI;

	global Database.QueryLocator start(Database.BatchableContext BC) {

		query = 'SELECT Id, indice__c, OF_Id_Risorsa__c, OF_Source_System__c, OF_ID_GIS_ScalaPalazzina__c, OF_GIS_OLO__c, OF_GIS_Data_Espletamento__c, OF_Comune__c, OF_Particella_Toponomastica__c, OF_Indirizzo__c, OF_Civico__c, OF_UI_Scala_Palazzina__c, OF_GIS_Codice_Ordine_Olo__c, isValid__c, STG_Info_Esecuzione__c' +
			' FROM OF_Staging_PNI__c' +
			' WHERE isValid__c = true AND isElaborato__c = false AND OF_ID_GIS_ScalaPalazzina__c NOT IN (null, \'N/D\', \'#N/D\', \'N/A\', \'#N/A\') AND OF_Id_Risorsa__c NOT IN (null, \'N/D\', \'#N/D\', \'N/A\', \'#N/A\')' +
			' ORDER BY OF_ID_GIS_ScalaPalazzina__c, OF_GIS_OLO__c, OF_GIS_Data_Espletamento__c ASC';

		system.debug('>> query: ' + query);

		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<OF_Staging_PNI__c> listaStaging) {

		OF_Staging_CheckInvalidRecords ctrl = new OF_Staging_CheckInvalidRecords();

		List<OF_Staging_PNI__c> invalids = [SELECT Id, isValid__c, STG_Info_Esecuzione__c FROM OF_Staging_PNI__c
											WHERE isValid__c = true AND isElaborato__c = false
												AND (OF_ID_GIS_ScalaPalazzina__c IN (null, 'N/A', '#N/A') OR OF_Id_Risorsa__c IN (null, 'N/D', '#N/D', 'N/A', '#N/A'))];

		try {
			ctrl.run(listaStaging, invalids);
		}
		catch (Exception ex) {
			system.debug('@@ERRORE: ' + ex.getMessage() + ' negli oggetti: ' + ex.getStackTraceString());
		}
	}

	global void finish(Database.BatchableContext BC) {
		DateTime jobAlgoritmo = System.now().addSeconds(30);
		String hour = String.valueOf(jobAlgoritmo.hour());
		String min = String.valueOf(jobAlgoritmo.minute());
		String ss = String.valueOf(jobAlgoritmo.second());

		//parse to cron expression
		String nextFireTime = OF_WS_SEMAFORO_VERTICALE.GetCRONExpression(jobAlgoritmo);//ss + ' ' + min + ' ' + hour + ' * * ?';

		OF_PNI_Obsoleti_Batch_sched b1 = new OF_PNI_Obsoleti_Batch_sched();

		//rimuovo i job esistenti
		for (CronTrigger ct : [SELECT Id, CronJobDetail.Name, CronJobDetail.JobType
							   FROM CronTrigger
							   WHERE CronJobDetail.Name like 'Algoritmo PNI GIS %' LIMIT 1]) {

			System.abortJob(ct.id);
		}

		if (!Test.isRunningTest()) {
			System.schedule('Algoritmo PNI GIS 01', nextFireTime, b1);
		}
	}

}
global class OF_PNI_Obsoleti_Batch implements Database.Batchable<sObject>,Database.Stateful {

	global String query;
	global EOF_EAI_Service_Log__c slTrackPNI;

	global Database.QueryLocator start(Database.BatchableContext BC) {

		// Verticali__c verticaliCS = Verticali__c.getOrgDefaults();

		query = 'SELECT  Id, OF_GIS_Codice_Ordine_Olo__c,OF_GIS_Data_Espletamento__c,OF_GIS_Nome_Scala__c,OF_GIS_OLO__c,' +
			+'OF_Civico__c,OF_Comune__c,OF_ID_Building__c,OF_Id_DB_Scala_palazzina__c,OF_ID_GIS_ScalaPalazzina__c,' +
			+'OF_Id_Palazzina__c,OF_Id_Risorsa__c,OF_Indirizzo__c,OF_Palazzina__c,OF_Particella_Toponomastica__c,' +
			+'OF_Scala__c,OF_Scala_Palazzina__c,OF_Source_System__c,OF_UI_Scala_Palazzina__c,OF_GIS_Pop_Tmw__c' +
			+' FROM OF_Staging_PNI__c Where isElaborato__c = false and isvalid__C = true ORDER BY OF_ID_GIS_ScalaPalazzina__c, OF_GIS_OLO__c, OF_GIS_Data_Espletamento__c ';
		// +' FROM OF_Staging_PNI__c Where isElaborato__c = false and isvalid__C = true limit '+ verticaliCS.limitBatch__c.intvalue();
		//+' FROM OF_Staging_PNI__c Where indice__c > = '+ limitlow + ' and indice__c < ' + limitup + '  and isElaborato__c=false and isvalid__C=true limit '+ verticaliCS.limitBatch__c.intvalue();

		system.debug('> query: ' + query);

		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<OF_Staging_PNI__c> listaStaging) {

		OF_PNI_GIS_Obsoleti_Check ctrl = new OF_PNI_GIS_Obsoleti_Check();
		try {

			for (OF_Staging_PNI__c l:listaStaging) {
				l.isElaborato__c = true;
			}
			update listaStaging;

			ctrl.updateElemVerticali(listaStaging);
		}
		catch (Exception ex) {
			system.debug('@@ERRORE: ' + ex.getMessage() + ' negli oggetti: ' + ex.getStackTraceString());
		}
	}

	global void finish(Database.BatchableContext BC) {
		DateTime dt = System.now().addMinutes(1);
		String hour = String.valueOf(dt.hour());
		String min = String.valueOf(dt.minute());
		String ss = String.valueOf(dt.second());

		//parse to cron expression
		String nextFireTime = OF_WS_SEMAFORO_VERTICALE.GetCRONExpression(dt);//ss + ' ' + min + ' ' + hour + ' * * ?';

		OF_PNI_BonificaAssetVerticali_sched b = new OF_PNI_BonificaAssetVerticali_sched();

		//rimuovo il job esistente
		List <CronTrigger> ct = [SELECT Id, CronJobDetail.Name, CronJobDetail.JobType
								 FROM CronTrigger
								 WHERE CronJobDetail.Name = 'Bonifica Asset Vert' limit 1];

		if (!ct.isEmpty()) {
			system.abortJob(ct[0].id);
		}

		system.schedule('Bonifica Asset Vert', nextFireTime, b);
	}
}
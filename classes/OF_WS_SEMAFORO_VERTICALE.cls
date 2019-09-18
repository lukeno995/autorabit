global class OF_WS_SEMAFORO_VERTICALE {

	global class OF_WS_SEMAFORO_VERTICALE_Request {
		webservice String ESITO_CARICAMENTO;
		webservice String DESCRIZIONE;
	}

	global class OF_WS_SEMAFORO_VERTICALE_Response {
		webservice String PRESO_IN_CARICO;
		webservice String NOTE;
	}

	public static String GetCRONExpression(Datetime dt) {
		return ('' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year());
	}

	webservice static OF_WS_SEMAFORO_VERTICALE_Response StatusChiamata (OF_WS_SEMAFORO_VERTICALE_Request sur) {

		Verticali__c verticaliCS = Verticali__c.getOrgDefaults();

		/*DateTime jobAlgoritmo = System.now().addMinutes(verticaliCS.delayAlgoritmo__c.intvalue());
		String hour = String.valueOf(jobAlgoritmo.hour());
		String min = String.valueOf(jobAlgoritmo.minute());
		String ss = String.valueOf(jobAlgoritmo.second());

		//parse to cron expression
		String nextFireTime = GetCRONExpression(jobAlgoritmo);//ss + ' ' + min + ' ' + hour + ' * * ?';

		OF_PNI_Obsoleti_Batch_sched b1 = new OF_PNI_Obsoleti_Batch_sched();


		//rimuovo i job esistenti
		for (CronTrigger ct : [SELECT Id, CronJobDetail.Name, CronJobDetail.JobType
							   FROM CronTrigger
							   WHERE CronJobDetail.Name like 'Algoritmo PNI GIS %']) {

			system.abortJob(ct.id);
		}

		system.schedule('Algoritmo PNI GIS 01', nextFireTime, b1);*/

		/*
		   DateTime jobBonifica = System.now().addMinutes(verticaliCS.delayBonifica__c.intvalue());

		   hour = String.valueOf(jobBonifica.hour());
		   min = String.valueOf(jobBonifica.minute());
		   ss = String.valueOf(jobBonifica.second());

		   nextFireTime =  GetCRONExpression(jobBonifica);//ss + ' ' + min + ' ' + hour + ' * * ?';

		   OF_PNI_BonificaAssetVerticali_sched b100 = new OF_PNI_BonificaAssetVerticali_sched();

		   //rimuovo il job esistente
		   List <CronTrigger> ct2 = [SELECT Id, CronJobDetail.Name, CronJobDetail.JobType
		                FROM CronTrigger
		               WHERE CronJobDetail.Name = 'Bonifica Asset Vert' limit 1];

		   if (ct2.size()>0 ){
		    system.abortJob(ct2[0].id);
		   }

		   system.schedule('Bonifica Asset Vert', nextFireTime, b100);
		 */

		Integer scopeSize = verticaliCS.step1ScopeSize__c.intValue();
		Database.executeBatch(new OF_PNI_MarkInvalidRecords_Batch(), scopeSize);
		OF_WS_SEMAFORO_VERTICALE_Response resp = new OF_WS_SEMAFORO_VERTICALE_Response();
		resp.PRESO_IN_CARICO = 'OK';
		resp.NOTE = 'Operazione è stata presa in carico';
		return resp;
	}
}
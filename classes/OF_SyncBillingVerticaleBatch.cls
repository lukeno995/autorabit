global class OF_SyncBillingVerticaleBatch implements Database.AllowsCallouts,Database.Batchable<sObject>, Database.Stateful {

	private List<String> idAsset;

	global Integer scopeSize;
	global Integer firstIndex;

	public OF_SyncBillingVerticaleBatch(List<string> assetId) {
		idAsset = assetId;
	}

	global Database.QueryLocator start(Database.BatchableContext BC) {
		System.debug('@@@@ Inizio Verticali Batch: ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));

		Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
		Integer lim = verticaliCS.createNotifyBatchLimit__c.intValue();

		String query = 'SELECT id, Update_Billing__c, Asset__c '
			+ ' FROM OF_Billing_Element_Verticale__c ';
		if (!idAsset.isEmpty()) {
			query = query + ' WHERE Update_Billing__c =true AND Asset__c in :idAsset ';
		} else {
			query = query + ' WHERE Update_Billing__c =true LIMIT :lim';
		}

		system.debug('@@@@query ' + query);

		system.debug('@@@@AssetId: ' +  idAsset);


		List<EOF_Notify__c> n = [SELECT Id, indice__c FROM EOF_Notify__c WHERE RecordType.DeveloperName = 'EOF_BILL_Asset'
									 AND indice__c != null ORDER BY indice__c DESC LIMIT 1];
		Decimal i = 1;
		if (!n.isEmpty()) {
			i = n.get(0).indice__c + 1;
		}
		firstIndex = i.intValue();

		AggregateResult size = [SELECT count(Id) tot FROM OF_Billing_Element_Verticale__c
								WHERE Update_Billing__c = true];
		scopeSize = Integer.valueOf(size.get('tot'));

		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<OF_Billing_Element_Verticale__c> scope) {
		//system.debug('@@@@@@@@@scope' + scope);
		List<String> idsAssets = SyncBillingAssetUtils.getListAssetId(scope);

		// system.debug('@@@@@@@@@IdsAssets' + idsAssets);
		SyncBillingAssetUtils.callWSAssetVerticaleCustom(idsAssets);
	}

	global void finish(Database.BatchableContext BC) {
		if (!idAsset.isEmpty()) {
			List<Asset> assets = [SELECT id, Sync_Verticali__c FROM Asset WHERE Id IN :idAsset];
			for (Asset asse : assets) {
				asse.Sync_Verticali__c = false;
			}
			update assets;
            List<EOF_Notify__c> n = [SELECT Id, indice__c FROM EOF_Notify__c WHERE RecordType.DeveloperName = 'EOF_BILL_Asset'
									 AND indice__c != null ORDER BY indice__c DESC LIMIT 1];

            if(!n.isEmpty()){
                OF_CallWSVerticaliBatch batchable = new OF_CallWSVerticaliBatch(firstIndex, n.get(0).Indice__c.intValue());
                Database.executeBatch(batchable, 1);
                return;
            }
		}

		Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
		Integer numBatch = verticaliCS.callWsBillingBatchSize__c.intvalue();

		List<OF_CallWSVerticaliBatch_Sched> schedList = new List<OF_CallWSVerticaliBatch_Sched>();
		if (scopeSize >= numBatch) {
			Integer offset = scopeSize / numBatch;
			Integer startIndex = firstIndex;
			Integer endIndex = startIndex + offset;

			for (Integer i = 1; i < numBatch; i++) {
				schedList.add(new OF_CallWSVerticaliBatch_Sched(startIndex, endIndex));
				startIndex = endIndex + 1;
				endIndex += offset;
			}

			schedList.add(new OF_CallWSVerticaliBatch_Sched(startIndex, firstIndex + scopeSize));

		} else if (scopeSize > 0) {
			schedList.add(new OF_CallWSVerticaliBatch_Sched(firstIndex, firstIndex + scopeSize));
		}

		if (!schedList.isEmpty()) {
			for (CronTrigger ct : [SELECT Id, CronJobDetail.Name, CronJobDetail.JobType
								   FROM CronTrigger
								   WHERE CronJobDetail.Name like 'CALL WS BILLING %' LIMIT :numBatch]) {

				System.abortJob(ct.id);
			}

			Integer i = 1;
			DateTime t = System.now().addSeconds(29);
			for (OF_CallWSVerticaliBatch_Sched s : schedList) {
				String nextFireTime = getCRONExpression(t.addSeconds(i));
				System.schedule('CALL WS BILLING ' + i, nextFireTime, s);
				i++;
			}
		}
	}

	public static String getCRONExpression(Datetime dt) {
		return ('' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year());
	}
}
trigger PO_UpdateOppCase on Case (before update) {
	/*
	   il trigger gestisce l'update sul case padre che poi fa scattare il process builder PO Crea Oppty da Collegamento
	   che fa scattare il trigger PO_UpdateOpportunity che crea l'opportunity per i seguenti case di fattibilità:
	   PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb
	   PO_Collegamento_Fiber_link
	   PO_Collegamento_Fiber_Lease
	   PO_Collegamento_IRU
	   PO_Collegamento_P2P

	   Le opportunity della P2P attiva vengono invece create dall'apposita classe PO_P2PAtt_OpportunityHandler
	 */
	//Start--Sasya-18-09-2018-Updating QueueName in Case
	CaseQueueUtility.BeforeUpdate(Trigger.new);

	Map<String, Id> devNameIdMap = PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();
	List<ServFattList__c> servList = ServFattList__c.getAll().values();
	Set<Id> recordTypeIdList = new Set<Id>();
	
	for (ServFattList__c serv : servList) {
		if (String.isNotBlank(serv.caseCollegamentoDevName__c)) {
			recordTypeIdList.add(devNameIdMap.get(serv.caseCollegamentoDevName__c));
		}
	}

	Id fiberLeaseCollId = devNameIdMap.get('PO_Collegamento_Fiber_Lease');
	Set<Id> caseIds = new Set<Id>();
	for (Case c : Trigger.new) {
		if ((c.RecordTypeId == fiberLeaseCollId) && c.PO_Drop_FL_1__c) {
			c.PO_Posa_1_nuovo_Drop__c = 0.0;
		}
		if (recordTypeIdList.contains(c.RecordTypeId) && !c.PO_Incluso_nell_offerta__c && (c.PO_Incluso_nell_offerta__c != Trigger.oldMap.get(c.Id).PO_Incluso_nell_offerta__c)) {
			c.Status = 'Annullato';
			caseIds.add(c.Id);
		}
	}

	List<Opportunity> oppCollList = [SELECT Id, PO_Sconto_canone__c FROM Opportunity WHERE PO_Collegamento__c IN :caseIds];
	for (Opportunity o : oppCollList) {
		// PO_Sconto_canone__c non è usato sulle opportunity collegamento
		if (o.PO_Sconto_canone__c == null) {
			o.PO_Sconto_canone__c = 0;
		} else {
			o.PO_Sconto_canone__c = (o.PO_Sconto_canone__c == 0) ? 1 : 0;
		}
	}

	update oppCollList;

	//End--Sasya-18-09-2018-Updating QueueName in Case
	// //FD 2019-01-14 Classi di test - Servizi a Fattibilità - START
	// /*OF_Tibco_userID__c tibco=OF_Tibco_userID__c.getInstance('Tibco UserID');
	// if(userinfo.getuserId()!=tibco.OF_Tibco_ID__c){*/
	// system.debug('#### Entro nel trigger 001');
	// if(userinfo.getuserId()!=OF_Tibco_userID__c.getInstance('Tibco UserID').OF_Tibco_ID__c){
	//     //verifico il custom setting per accendere e spegnere il trigger
	//     OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =OF_Enable_PO_UpdateOppCase_Trigger__c.getInstance('Status');
	//     if(abilitaTrig.OF_Enable_Trigger__c){
	//         boolean checkCase=false;
	//         List<Case> cList = new List<Case>();
	//         Map<String,ID> mappaRTCase = new Map<String,ID>();
	//         list<recordtype> rtList = [SELECT Id, DeveloperName FROM Recordtype WHERE sobjecttype = 'Case'];
	//         for( Recordtype rt : rtList)
	//         {
	//             mappaRTCase.put( rt.DeveloperName , rt.Id );
	//         }
	//         for(Case c: trigger.new){
	//             //controllo l'ownerId
	//             //controllo il recordtype
	//             if(c.recordtypeId == mappaRTCase.get('PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb') ||
	//                c.recordtypeId == mappaRTCase.get('PO_Collegamento_Fiber_link') ||
	//                c.recordtypeId == mappaRTCase.get('PO_Collegamento_Fiber_Lease') ||
	//                c.recordtypeId == mappaRTCase.get('PO_Collegamento_IRU') ||
	//                c.recordtypeId == mappaRTCase.get('PO_Collegamento_P2P') ){

	//                checkCase=true;
	//                cList.add(c);
	//             }

	//         }
	//         if(checkCase){
	//             if(Trigger.isBefore && Trigger.isUpdate){
	//                 Set<Id> caseId= new Set<Id>();
	//                 Set<Id> caseFatt= new Set<Id>();
	//                 for(Case cs : cList){
	//                     // recTypeCheck=true;
	//                     caseId.add(cs.Id);
	//                     //20/10/2017 CRM
	//                     /*if(cs.PO_Incluso_nell_offerta__c == false &&
	//                        cs.PO_Incluso_nell_offerta__c != Trigger.oldMap.get(cs.Id).PO_Incluso_nell_offerta__c)*/

	//                     if(cs.PO_Incluso_nell_offerta__c == false &&
	//                         cs.PO_Incluso_nell_offerta__c != Trigger.oldMap.get(cs.Id).PO_Incluso_nell_offerta__c)
	//                     {
	//                         cs.status='Annullato';
	//                         caseFatt.add(cs.PO_Richiesta_a_fattibilit__c);
	//                     }
	//                    /* else if(cs.PO_Incluso_nell_offerta__c == true){
	//                          cs.status='Completato';
	//                         caseFatt.add(cs.PO_Richiesta_a_fattibilit__c);
	//                     }*/
	//                     //20/10/2017 END CRM
	//                 }
	//                 List<Opportunity> opplist = [SELECT PO_Incluso_nell_offerta__c,PO_Offerta_totale__c, PO_Contratto__c, PO_Contributo_attivazione_collegamento__c,PO_Collegamento__c,
	//                                          PO_Canone_collegamento__c ,PO_Costi_aggiuntivi_collegamento__c,PO_Totale_canoni__c,
	//                                          PO_Sconto_costi_aggiuntivi_collegamento__c, //CRM 31/07/2017 Aggiunti campi
	//                                          PO_Totale_contributi_attivazione__c,PO_Totale_costi_aggiuntivi__c
	//                                          from Opportunity where PO_Collegamento__c =:caseId
	//                                         ] ;

	//                 System.debug('opplist===>'+opplist);
	//                 if(opplist.size()>0){
	//                     PO_CaseUtilityHandler.CalculateOpp(opplist);
	//                 }
	//                 //20/10/2017 CRM
	//                 list<case> caseFattList = new list<case>();
	//                 if(caseFatt.size() > 0 && caseFatt != null)
	//                 {
	//                     caseFattList = [select id, (select id, status, EOF_Fase__c, PO_Drop_FL_1__c from Collegamenti__r) from case where id IN: caseFatt];
	//                 }
	//                 if(caseFattList.size() > 0)
	//                 {
	//                     PO_CaseUtilityHandler.OffertaCreataDaTriggerPOUpdateOppCase(caseFattList);
	//                 }

	//                 map<Id, case> mapCaseFatt = new map<Id, case>();
	//                 map<Id, case> mapCaseColl = new map<Id, case>();
	//                 map<Id, boolean> mapCaseDropFL = new map<Id, boolean>();

	//                 Map<ID, Schema.RecordTypeInfo> rtCaseMap = Schema.SObjectType.Case.getRecordTypeInfosById();
	//                 for(Case cs : Trigger.new){

	//                     //Prendo il recordtype name del case che sto ciclando
	//                     string RTCaseName = rtCaseMap.get(cs.RecordTypeId).getName();
	//                     /**FIBER LINK**/
	//                     if(RTCaseName == 'PO Collegamento Fiber link' && cs.PO_Lunghezza_tratta_prima_via__c != null)
	//                     {
	//                         system.debug('#### Entro nel trigger 002');
	//                         if(Trigger.oldMap.get(cs.Id).PO_Lunghezza_tratta_prima_via__c != cs.PO_Lunghezza_tratta_prima_via__c)
	//                         {
	//                             mapCaseFatt.put(cs.id, cs);
	//                         }
	//                     }
	//                     /**FIBER LEASE**/
	//                     if(RTCaseName == 'PO Collegamento Fiber Lease')
	//                     {
	//                         if(cs.PO_Drop_FL_1__c == true &&
	//                            cs.PO_Lunghezza_m__c != null &&
	//                            Trigger.oldMap.get(cs.Id).PO_Lunghezza_m__c != cs.PO_Lunghezza_m__c)
	//                         {
	//                             mapCaseFatt.put(cs.id, cs);
	//                         }
	//                         //05/09/2017 Modifica CRM - il campo PO_Drop_FL_1__c sul padre deve essere uguale a quello presente sul figlio.
	//                         if(Trigger.oldMap.get(cs.Id).PO_Drop_FL_1__c != cs.PO_Drop_FL_1__c)
	//                         {
	//                             System.debug('DG_PO_UpdateOppCase cs.PO_Drop_FL_1__c: '+cs.PO_Drop_FL_1__c);
	//                             mapCaseDropFL.put(cs.PO_Richiesta_a_fattibilit__c, cs.PO_Drop_FL_1__c);
	//                         }
	//                         //END 05/09/2017
	//                         //19/09/2017 Modifica CRM Se il campo PO_Drop_FL_1__c == true allora il campo PO_Posa_1_nuovo_Drop__c deve essere messo a 0
	//                         if(cs.PO_Drop_FL_1__c == true && cs.PO_Posa_1_nuovo_Drop__c != 0)
	//                         {
	//                             System.debug('DG_PO_UpdateOppCase dentro if che mette a 0 il campo PO_Posa_1_nuovo_Drop__c');
	//                             mapCaseColl.put(cs.id, cs);
	//                         }
	//                     }
	//                 }
	//                 System.debug('DG_PO_UpdateOppCase mapCaseFatt: '+mapCaseFatt);
	//                 system.debug('#### Entro nel trigger 003');
	//                 if(mapCaseFatt.size() > 0)
	//                 {
	//                     PO_CaseUtilityHandler.ParamFattibilita(mapCaseFatt);
	//                     system.debug('#### Entro nel trigger 004');
	//                 }
	//                 if(mapCaseDropFL.size() > 0)
	//                 {
	//                     PO_CaseUtilityHandler.CaseFattDropFL(mapCaseDropFL);
	//                     system.debug('#### Entro nel trigger 005');
	//                 }
	//                 if(mapCaseColl.size() > 0)
	//                 {
	//                     PO_CaseUtilityHandler.CaseCollDropFL(mapCaseColl);
	//                     system.debug('#### Entro nel trigger 006');
	//                 }
	//             }
	//        }
	//     //END 08/08/2017 CRM
	//     }
	// }
	//     //}
	// //}
}
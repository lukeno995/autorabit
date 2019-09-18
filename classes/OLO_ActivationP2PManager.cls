public without sharing class OLO_ActivationP2PManager {

    // tentativi di retry
    private static final Integer MAX_ATTEMPT = 3;
    private static final String SCHEDULADED_NAME = 'ActivationP2P - id fattibilità ';

    private static OLO_Activation_P2PSchema.Create_P2P_Request_element rqst = 
        new OLO_Activation_P2PSchema.Create_P2P_Request_element();

    private OLO_ActivationP2PManager() {
    }

    public static void sendToDOM(Map<Id,Id> map_collgIdOrdId, Id fattId) {
        Id notifyId = OLO_ActivationP2PUtils.createIdNotifica(fattId);
        execute(map_collgIdOrdId, fattId, notifyId);
    }
   
    private static void execute(Map<Id,Id> map_collgIdOrdId, Id fattId, Id notifyId) {
        sendToDOM(map_collgIdOrdId, fattId, notifyId, 0);   
    }

    @future(callout=true)
    public static void sendToDOM(Map<Id,Id> map_collgIdOrdId, Id fattId, Id notifyId, Integer currentAttempt) {
        System.debug('##### OLO_ActivationP2PManager.sendToDOM -- map_collgIdOrdId: ' + map_collgIdOrdId + 
            ' - id fattibilita : ' + fattId + ' - id notifica ' + notifyId  + ' - tentativo di callout:' + currentAttempt);

        List<Case> lParentCase = [SELECT Id, Status, EOF_Fase__c, isDOM__c, isPSM__c, View_PopUp_PSM__c,  View_PopUp_DOM__c 
                                  FROM Case 
			                      WHERE Id =: fattId limit 1];        
        System.debug('##### OLO_ActivationP2PManagere.start: parentCase: ' + lParentCase);

        OLO_Activation_P2PSchema.Create_Response response =  new OLO_Activation_P2PSchema.Create_Response();
        List<Case> ordineCases = new List<Case>();
        Group codaSupportoVendite  = new Group();
        try {
            ordineCases = [SELECT Id, Status, OwnerId, EOF_Fase__c, isPSM__c
                                        FROM Case
                                        WHERE Id IN : map_collgIdOrdId.values()
                                        AND PO_Data_Attivazione_Richiesta__c != null
                                        AND PO_Nome_E_Cognome_PM__c != null
                                        AND PO_Numero_Telefonico_PM__c != null
                                        AND Status = 'Accettato'];

            codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita' limit 1];

            rqst = createRqst(map_collgIdOrdId, notifyId);
            if(!Test.isRunningTest()) {
                OLO_ActivationP2PRequestCheck.checkActivationRequest(rqst);
            }            
            response = makeCallout(rqst);          
            abortScheduled(SCHEDULADED_NAME + fattId); 

            if(response.ESITO == '0') {
                handlePositiveResponse(ordineCases, codaSupportoVendite);
            } else {
                if(response.CODICE_MOTIVAZIONE.equalsIgnoreCase(OF_CheckManager_P2P.TECH_ERROR_CODE_TB)) {
                    handleTechnicalError(map_collgIdOrdId, fattId, notifyId, currentAttempt);

                    lParentCase[0].View_PopUp_DOM__c = true;
                    for (Case caseToUpdate : ordineCases) {
                        caseToUpdate.status = 'In Lavorazione';
                        caseToUpdate.EOF_Fase__c = 'In Lavorazione Supporto Vendite';
                        caseToUpdate.OwnerId = codaSupportoVendite.Id;
                        caseToUpdate.View_PopUp_DOM__c = true;
                    }
                    System.debug('##### handleGeneralError - esito ko -- fase \'In Lavorazione Supporto Vendite\'');
                    List<Case> toUpdate = new List<Case>();
                    toUpdate.add(lParentCase[0]);
                    toUpdate.addAll(ordineCases);
                    update toUpdate;

                } else {
                    handleGeneralError(lParentCase[0], ordineCases, codaSupportoVendite);

                }
            }
        } catch (IllegalRequestException e) {
            System.debug('##### Exception: ' + e.getMessage() + ' - ' + e.getStackTraceString());
            response.ESITO = '1';
            response.ID_NOTIFICA = notifyId;
            response.MOTIVAZIONE = e.getCode();               
            response.CODICE_MOTIVAZIONE = e.getDescription();
            handleGeneralError(lParentCase[0], ordineCases, codaSupportoVendite);
        } catch(Exception e) {
            System.debug('##### Exception: ' + e.getMessage() + ' - ' + e.getStackTraceString());
            response.ESITO = '1';
            response.ID_NOTIFICA = notifyId;
            response.MOTIVAZIONE = e.getMessage().abbreviate(100);               
            response.CODICE_MOTIVAZIONE = OF_CheckManager_P2P.TECH_ERROR_CODE;
            System.debug('error: ' + e.getStackTraceString());
        }
      	OLO_ActivationP2PUtils.writeLog(rqst, response);
        OLO_ActivationP2PUtils.writeResponseLog(rqst, response);
   
    }

    private static OLO_Activation_P2PSchema.Create_P2P_Request_element createRqst(Map<Id,Id> map_collgIdOrdId, Id notifyId) {
        return OLO_ActivationP2PUtils.createActivationRqst(map_collgIdOrdId, notifyId);     
    }

    private static OLO_Activation_P2PSchema.Create_Response makeCallout(OLO_Activation_P2PSchema.Create_P2P_Request_element rqst) {
        OLO_Activation_P2P.SF_DOM_WsdlSOAP servicee = new OLO_Activation_P2P.SF_DOM_WsdlSOAP();

        System.debug('##### OLO_ActivationP2PManager.makeCallout -- request id_fattibilita: ' + rqst.fattibilita.ID_FATTIBILITA);
        OLO_Activation_P2PSchema.Create_Response rsponse = servicee.OLO_ActivationSetup_P2P(rqst.header, rqst.fattibilita);

        System.debug('##### OLO_ActivationP2PManager.makeCallout -- response: ' + rsponse);
        return rsponse;
         
    }
    
    public static String createCronExpMinutesDelayed(Integer delay) {
        Datetime noww = System.now();
        Datetime cronTime = noww.addMinutes(delay);
        String cronExp = '';
        cronExp += cronTime.second() + ' ' + cronTime.minute() + ' ' + cronTime.hour() + ' ' + 
            cronTime.day() + ' ' + cronTime.month() + ' ? ' + cronTime.year();
        return cronExp;

    }

    public static void abortScheduled(String name) {
        List<CronTrigger> ctr = [SELECT Id,cronJobDetail.Name FROM CronTrigger WHERE cronJobDetail.Name =: name];
        for(CronTrigger c : ctr) {                     
            System.abortJob(c.Id);
        }
    }
	
    @testVisible
    private static void handlePositiveResponse(List<Case> ordineCases, Group codaSupportoVendite) {
        for (Case caseToUpdate : ordineCases) {
            caseToUpdate.status = 'In Lavorazione';
            caseToUpdate.EOF_Fase__c = 'In Lavorazione Network Creation';
            caseToUpdate.OwnerId = codaSupportoVendite.Id;
        }                   
        System.debug('##### handlePositiveResponse - esito ok -- fase \'In Lavorazione Network Creation\'');
        update ordineCases;
    }
	
    @testVisible
    private static void handleGeneralError(Case parentCase, List<Case> ordineCases, Group codaSupportoVendite) {
        parentCase.View_PopUp_DOM__c = true;
        for (Case caseToUpdate : ordineCases) {
            caseToUpdate.status = 'In Lavorazione';
            caseToUpdate.EOF_Fase__c = 'In Lavorazione Supporto Vendite';
            caseToUpdate.OwnerId = codaSupportoVendite.Id;
            caseToUpdate.View_PopUp_DOM__c = true;
        }
        System.debug('##### handleGeneralError - esito ko -- fase \'In Lavorazione Supporto Vendite\'');
        List<Case> toUpdate = new List<Case>();
        toUpdate.add(parentCase);
        toUpdate.addAll(ordineCases);
        update toUpdate;
    }
	
    @testVisible
    private static void handleTechnicalError(Map<Id,Id> map_collgIdOrdId, Id fattId, Id notifyId, Integer currentAttempt) {
        System.debug('##### handleTechnicalError');
        String cronExp = createCronExpMinutesDelayed(30);
        currentAttempt++;
        if(currentAttempt <= MAX_ATTEMPT) {
            Schedulable sched = new OLO_ActivationP2PRetry(map_collgIdOrdId, fattId, notifyId, currentAttempt, MAX_ATTEMPT);
            System.schedule(SCHEDULADED_NAME + fattId, cronExp, sched);
        }
    }
    
}
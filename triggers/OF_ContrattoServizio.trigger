trigger OF_ContrattoServizio on OF_ContrattoServizio__c (before insert) {
	OF_ContrattoServizioTriggerHandler.controlloUnivocita(Trigger.new);
}
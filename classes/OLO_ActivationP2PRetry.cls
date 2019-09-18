public without sharing class OLO_ActivationP2PRetry extends SchedulableRetry {

    protected Map<Id,Id> map_collgIdOrdId;
    protected Id fattId;
    protected Id notifyId;

    public OLO_ActivationP2PRetry(Map<Id,Id> map_collgIdOrdId, Id fattId, Id notifyId, Integer currentAttempt, Integer maxAttempt) {
            
        super(currentAttempt, maxAttempt);
        this.map_collgIdOrdId = map_collgIdOrdId;
        this.fattId = fattId;
        this.notifyId = notifyId;
    }

    protected override void executeJob(SchedulableContext ctx) {
        System.debug('##### OLO_ActivationP2PRetry.executeJob - current attempt: ' + currentAttempt);
        OLO_ActivationP2PManager.sendToDOM(map_collgIdOrdId, fattId, notifyId, currentAttempt);
    }
}
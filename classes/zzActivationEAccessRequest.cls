public without sharing class zzActivationEAccessRequest extends zzActivationBaseRequest {

    public zzActivationEAccessRequest() {
    }

    public zzActivationEAccessRequest(Map<Id, Case> map_collIDs_obj) {
        super(map_collIDs_obj);
    }

    public zzActivationEAccessRequest(Set<Id> collIDs) {
        super(collIDs);
    }

    protected override void setValuesByService(Id cID, OLO_Activation_P2PSchema.ORDINE_element ordine, OLO_Activation_P2PSchema.SEDE sede) {
        ordine.TIPO_COLLEGAMENTO = map_collIDs_obj.get(cID).PO_Tipo_di_collegamento__c;
    }

    protected override void findKitConsegna(Id collId){}
}
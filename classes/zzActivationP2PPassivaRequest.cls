public without sharing class zzActivationP2PPassivaRequest extends zzActivationBaseRequest {

    public zzActivationP2PPassivaRequest() {

    }

    public zzActivationP2PPassivaRequest(Map<Id, Case> map_collIDs_obj) {
        super(map_collIDs_obj);
    }

    public zzActivationP2PPassivaRequest(Set<Id> collIDs) {
        super(collIDs);
    }

    protected override void setValuesByService(Id cID, OLO_Activation_P2PSchema.ORDINE_element ordine, OLO_Activation_P2PSchema.SEDE sede) {
        ordine.TIPO_COLLEGAMENTO = COLLEGAMENTO_P2P_PASSIVA;
    }

    protected override void findKitConsegna(Id collId){}
}
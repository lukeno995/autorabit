public without sharing class StatusUpdateP2PHelper {

    public StatusUpdateP2PHelper() {

    }

    public Id updateVlan(String codeOrdineOlo, String svlanId) {
        System.debug('updateVlan, start updating...');
        Id collegId = findCollegamentoByOrdine(codeOrdineOlo);
        EOF_VLAN__c vlan = findVlan(collegId);
        vlan.svlanId__c = svlanId;
        update vlan;
        System.debug('svlanId__c field updated...');
        return vlan.Id;
    }

    public Id findCollegamentoByOrdine(String codeOrdineOlo) {
        System.debug('findCollegamentoByOrdine, searching case ordine...EOF_Codice_Ordine_OLO__c: ' + codeOrdineOlo);
        List<Case> ordine = [SELECT parentId FROM Case WHERE EOF_Codice_Ordine_OLO__c =: codeOrdineOlo];
        if(!ordine.isEmpty()) {
            System.debug('Case ordine found, id: ' + ordine[0].Id);
            return ordine[0].parentId;
        } else {
            throw new InvalidParameterValueException('StatusUpdateP2PHelper.findCollegamentoByOrdine', 'Case ordine not found. codeOrdineOlo: ' + codeOrdineOlo);
        }
    }

    public EOF_VLAN__c findVlan(Id collegamentoId) {
        System.debug('findVlan, searching vlan...id collegamento: ' + collegamentoId);
        List<EOF_VLAN__c> vlans = [SELECT svlanId__c FROM EOF_VLAN__c WHERE Caso__c =: collegamentoId];
        if(!vlans.isEmpty()) {
            System.debug('Vlan found, id: ' + vlans[0].Id);
            return vlans[0];
        } else {
            throw new InvalidParameterValueException('StatusUpdateP2PHelper.findVlan', 'Vlan not found. Caso__c: ' + collegamentoId);
        }
    } 
}
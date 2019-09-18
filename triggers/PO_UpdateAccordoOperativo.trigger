trigger PO_UpdateAccordoOperativo on Case (after update) {
    System.debug('### Trigger PO_UpdateAccordoOperativo');
    /*la sola modifica del campo Accordo Operativo, per i seguenti servizi:
-   BTS
-   Backhauling
-   Dark Fiber
-   P2P Base
-   Fiber Link
    dovrà essere estesa a tutti gli altri obj (ordine, Asset, case richiesta fattibilità che contengono il valore del campo Accordo Operativo).*/
    Set<String> caseDevNames = new Set<String>{'PO_Ordine_BTS', 'PO_Ordine_Backhauling', 'PO_Ordine_DarkFiber', 'PO_Ordine_Fiber_Link', 'PO_Ordine_P2P'};
    List<Case> caseOrdini = [SELECT PO_Richiesta_a_fattibilit_ordine__c, PO_Richiesta_a_fattibilit_ordine__r.Accordo_Operativo__c, OF_Order__c, OF_Order__r.PO_Accordo_Operativo__c, RecordType.DeveloperName, Accordo_Operativo__c FROM Case WHERE Id IN: Trigger.newMap.keyset() AND RecordType.DeveloperName IN :caseDevNames AND OF_Order__c != null AND PO_Richiesta_a_fattibilit_ordine__c != null];
    if (!caseOrdini.isEmpty()) {
        Map<Id, Case> mapRichieste = new Map<Id, Case>();
        Map<Id,Order> mapOrdini = new Map<Id, Order>();
        List<Case> richieste = new List<Case>();
        List<Order> ordini = new List<Order>();
        List<Id> idRichieste = new List<Id>();
        List<Id> idOrdini = new List<Id>();
        for(Case cOrder : caseOrdini){
            idRichieste.add(cOrder.PO_Richiesta_a_fattibilit_ordine__c);
            idOrdini.add(cOrder.OF_Order__c);
            Case richiesta = new Case();
            richiesta.Id = cOrder.PO_Richiesta_a_fattibilit_ordine__c;
            richiesta.Accordo_Operativo__c = cOrder.PO_Richiesta_a_fattibilit_ordine__r.Accordo_Operativo__c;
            mapRichieste.put(richiesta.Id, richiesta);
            
            Order ordine = new Order();
            ordine.Id = cOrder.OF_Order__c;
            ordine.PO_Accordo_Operativo__c = cOrder.OF_Order__r.PO_Accordo_Operativo__c;
            mapOrdini.put(ordine.Id, ordine);
        }
        //for(Case richiesta : [SELECT Id, Accordo_Operativo__c FROM Case WHERE Id IN: idRichieste]) mapRichieste.put( richiesta.Id, richiesta);
        //for(Order ordine : [SELECT Id, PO_Accordo_Operativo__c FROM Order WHERE Id IN: idOrdini]) mapOrdini.put(ordine.Id, ordine);
        for(Case cOrder : caseOrdini){
            if(cOrder.Accordo_Operativo__c != Trigger.oldMap.get(cOrder.Id).Accordo_Operativo__c){
                    System.debug('Modifica di Accordo Operativo, nuovo valore: ' + cOrder.Accordo_Operativo__c);
                    System.debug('PO_UpdateAccordoOperativo cOrder.PO_Richiesta_a_fattibilit_ordine__c ' + cOrder.PO_Richiesta_a_fattibilit_ordine__c);
                    //mapRichieste.get(cOrder.PO_Richiesta_a_fattibilit_ordine__c).Accordo_Operativo__c = cOrder.Accordo_Operativo__c;
                    //richieste.add(mapRichieste.get(cOrder.PO_Richiesta_a_fattibilit_ordine__c));
                    Case caseRichiesta = mapRichieste.remove(cOrder.PO_Richiesta_a_fattibilit_ordine__c);
                    if (caseRichiesta != null) {
                        caseRichiesta.Accordo_Operativo__c = cOrder.Accordo_Operativo__c;
                        richieste.add(caseRichiesta);
                    }                  
                    System.debug('PO_UpdateAccordoOperativo cOrder.OF_Order__c ' + cOrder.OF_Order__c);
                    mapOrdini.get(cOrder.OF_Order__c).PO_Accordo_Operativo__c = cOrder.Accordo_Operativo__c;
                    ordini.add(mapOrdini.get(cOrder.OF_Order__c));
                }
        }
        update richieste;
        update ordini;
    }
}
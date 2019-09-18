@isTest
public with sharing class OLO_ActivationP2PRetryTest {
    @isTest
    static void retryTest() {
        PO_ServFatt_DataFactory.WrapData p2pattiva = PO_ServFatt_DataFactory.createP2PAttivaData();
        Map<Id, Id> map_collegOrdine = new Map<Id, Id>();
        map_collegOrdine.put(p2pattiva.caseCollegamento.Id, p2pattiva.caseOrdine.Id);
        Id fattId = p2pattiva.casePadre.Id;
        Id notifyId = OLO_ActivationP2PUtils.createIdNotifica(fattId);

        SchedulableRetry retry = new OLO_ActivationP2PRetry(map_collegOrdine, fattId, notifyId, 1, 2);
        String cronExp = OLO_ActivationP2PManager.createCronExpMinutesDelayed(1);
        String name = 'Activation retry ' + fattId;
        System.schedule(name, cronExp, retry); 

        List<CronTrigger> ctr = [SELECT Id,cronJobDetail.Name FROM CronTrigger WHERE cronJobDetail.Name =: name];
        System.assertEquals(name, ctr[0].cronJobDetail.Name);

    }
}
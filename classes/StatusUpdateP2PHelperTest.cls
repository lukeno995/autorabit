@isTest
public without sharing class StatusUpdateP2PHelperTest {
    
    @isTest
    static void updateVlanTest() {
        String codeOlo = 'TIS_xxxx_1';
        String svlanId = 'id_test';

        Case collegamento = new Case();
        insert collegamento;
        
        Case ordine = new Case();
        ordine.EOF_Codice_Ordine_OLO__c = codeOlo;
        ordine.parentId = collegamento.Id;
        insert ordine;

        EOF_VLAN__c vlan = new EOF_VLAN__c();
        vlan.Caso__c = collegamento.Id;
        insert vlan;

        StatusUpdateP2PHelper helper = new StatusUpdateP2PHelper();
        Id vlanId = helper.updateVlan(codeOlo, svlanId);

        EOF_VLAN__c actual = [SELECT svlanId__c FROM EOF_VLAN__c WHERE Id =: vlanId];
        System.assertEquals(svlanId, actual.svlanId__c);

    }

    @isTest
    static void findCollegamentoByOrdineTest() {
        Case collegamento = new Case();
        insert collegamento;
        Case ordine = new Case();
        String codeOlo = 'TIS_xxxx_1';
        ordine.EOF_Codice_Ordine_OLO__c = codeOlo;
        ordine.parentId = collegamento.Id;
        insert ordine;

        StatusUpdateP2PHelper helper = new StatusUpdateP2PHelper();
        Id actual = helper.findCollegamentoByOrdine(codeOlo);

        System.assertEquals(collegamento.Id, actual);
    }

    
    @isTest
    static void findCollegamentoByOrdineMustThrowException() {
        Case ordine = new Case();
        String codeOlo = 'TIS_xxxx_1';
        insert ordine;

        StatusUpdateP2PHelper helper = new StatusUpdateP2PHelper();
        try {
             Id actual = helper.findCollegamentoByOrdine(codeOlo);
        } catch (Exception e) {
            System.assert(e instanceof InvalidParameterValueException);
        }
    }

    @isTest
    static void findVlanTest() {
        // Preparazione dati
        Case collegamento = new Case();
        insert collegamento;
        EOF_VLAN__c vlan = new EOF_VLAN__c();
        vlan.caso__c = collegamento.Id;
        insert vlan;

        StatusUpdateP2PHelper helper = new StatusUpdateP2PHelper();
        EOF_VLAN__c actual = helper.findVlan(collegamento.Id);

        System.assertEquals(vlan.Id, actual.Id);
    } 

    @isTest
    static void findVlanMustThrowException() {
        // Preparazione dati
        Case collegamento = new Case();
        insert collegamento;
        EOF_VLAN__c vlan = new EOF_VLAN__c();
        insert vlan;

        StatusUpdateP2PHelper helper = new StatusUpdateP2PHelper();
        try {
             EOF_VLAN__c actual = helper.findVlan(collegamento.Id);
        } catch (Exception e) {
            System.assert(e instanceof InvalidParameterValueException);
        }
    } 
}
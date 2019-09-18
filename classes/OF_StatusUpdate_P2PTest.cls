@isTest
public with sharing class OF_StatusUpdate_P2PTest {
    @isTest
    static void updateStatTestNack() {
        OF_StatusUpdate_P2P.Request request = new OF_StatusUpdate_P2P.Request();
        OF_StatusUpdate_P2P.Response actual = null;
        actual = OF_StatusUpdate_P2P.updateStat(request);
        String esitoNack = '1';
        System.assertEquals(esitoNack, actual.esito);

    }

    @isTest
    static void updateStatTestMustThrowException() {
        OF_StatusUpdate_P2P.Request request = new OF_StatusUpdate_P2P.Request();
        request.id_notifica = 'id_notifica';
        request.id_esito = 'id_esito_1';
        request.id_fattibilita = 'TIS_0004184812';
        request.data_notifica = System.now();
        request.tipo_notifica = 'Kit';
        request.id_ordine_kit = 'TIS_0004184814';
        request.stato_ordine = '2';
        request.id_risorsa = 'risorsa';
        request.data_espletamento_ordine = '2019-05-14';
        OF_StatusUpdate_P2P.Response actual = OF_StatusUpdate_P2P.updateStat(request);

    }
    
    @isTest
    static void updateStatTestMustThrowException1() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        data.casePadre.EOF_Codice_Ordine_OLO__c = 'TIS_0001';
        data.caseOrdine.EOF_Codice_Ordine_OLO__c = 'TIS_0002';
        List<Case> toUpdate = new List<Case>();
        toUpdate.add(data.casePadre);
        toUpdate.add(data.caseOrdine);
        update toUpdate;
        OF_StatusUpdate_P2P.Request request = new OF_StatusUpdate_P2P.Request();
       
        request.id_notifica = 'id_notifica';
        request.id_esito = 'id_esito_1';
        request.id_fattibilita = 'TIS_0001';
        request.data_notifica = System.now();
        request.tipo_notifica = 'Ordine';
        request.id_ordine_kit = 'TIS_0004184814';
        request.stato_ordine = '2';
        request.id_risorsa = 'risorsa';
        request.data_espletamento_ordine = '2019-05-14';
        OF_StatusUpdate_P2P.Response actual = OF_StatusUpdate_P2P.updateStat(request);
    }
    
    @isTest
    static void updateStatWrongIDOrdine() {
        OF_StatusUpdate_P2P.Request request = new OF_StatusUpdate_P2P.Request();
        request.id_notifica = 'id_notifica';
        request.id_esito = 'id_esito_1';
        request.id_fattibilita = 'TIS_0004184812';
        request.data_notifica = System.now();
        request.tipo_notifica = 'Ordine';
        request.id_ordine = 'fake';
        request.stato_ordine = '2';
        request.id_risorsa = 'risorsa';
        request.data_espletamento_ordine = '2019-05-14';
        OF_StatusUpdate_P2P.Response actual = OF_StatusUpdate_P2P.updateStat(request);

    }

    @isTest
    static void updateStatTestBase() {
        OF_StatusUpdate_P2P.Request request = new OF_StatusUpdate_P2P.Request();
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PBaseData();
        String codeOlo = 'TIS_0001';
        data.caseOrdine.EOF_Codice_Ordine_OLO__c = codeOlo;
        update data.caseOrdine;

        request.id_notifica = 'id_notifica';
        request.id_esito = 'id_esito_1';
        request.id_fattibilita = 'TIS_0004184812';
        request.data_notifica = System.now();
        request.tipo_notifica = 'Ordine';
        request.id_ordine = codeOlo;
        request.stato_ordine = '2';
        request.id_risorsa = 'risorsa';
        request.data_espletamento_ordine = '2019-05-14';
        OF_StatusUpdate_P2P.Response actual = OF_StatusUpdate_P2P.updateStat(request);

    }

     @isTest
    static void updateStatTestAttiva() {
        OF_StatusUpdate_P2P.Request request = new OF_StatusUpdate_P2P.Request();
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        String codeOlo = 'TIS_0001';
        data.caseOrdine.EOF_Codice_Ordine_OLO__c = codeOlo;
        update data.caseOrdine;

        request.id_notifica = 'id_notifica';
        request.id_esito = 'id_esito_1';
        request.id_fattibilita = 'TIS_0004184812';
        request.data_notifica = System.now();
        request.tipo_notifica = 'Ordine';
        request.id_ordine = codeOlo;
        request.stato_ordine = '2';
        request.id_risorsa = 'risorsa';
        request.data_espletamento_ordine = '2019-05-14';
        OF_StatusUpdate_P2P.Response actual = OF_StatusUpdate_P2P.updateStat(request);

    } 
}
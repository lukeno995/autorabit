@isTest
public with sharing class OLO_ActivationP2PManagerTest {

    @isTest
    static void sendToDOMWrongRequestTest() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        Map<Id,Id> map_collgIdOrdId = new Map<Id,Id>();
        map_collgIdOrdId.put(data.caseCollegamento.Id, data.caseOrdine.Id);
        Id fattId = data.casePadre.Id;

        data.caseOrdine.PO_Data_Attivazione_Richiesta__c = String.valueOf(System.today());
        data.caseOrdine.PO_Nome_E_Cognome_PM__c = 'Mario il Rosso';
        data.caseOrdine.PO_Numero_Telefonico_PM__c = '081123456789';
        data.caseOrdine.Status = 'Accettato';
        update data.caseOrdine;

        OLO_ActivationP2PManager.sendToDOM(map_collgIdOrdId, fattId);
    }

    @isTest
    static void sendToDOMTechnicalErrorTest() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        Map<Id,Id> map_collgIdOrdId = new Map<Id,Id>();
        map_collgIdOrdId.put(data.caseCollegamento.Id, data.caseOrdine.Id);
        Id fattId = data.casePadre.Id;

        data.caseOrdine.PO_Data_Attivazione_Richiesta__c = String.valueOf(System.today());
        data.caseOrdine.PO_Nome_E_Cognome_PM__c = 'Mario il Rosso';
        data.caseOrdine.PO_Numero_Telefonico_PM__c = '081123456789';
        data.caseOrdine.Status = 'Accettato';
        update data.caseOrdine;

        insert new OF_Puntamento_Callout__c(Tibco_Collaudo__c = '#', Name='CustomTest');
        Test.setMock(WebServiceMock.class, new OLO_Activation_P2PMockRetry());
        OLO_ActivationP2PManager.sendToDOM(map_collgIdOrdId, fattId);
    }

    @isTest
    static void sendToDOMGeneralErrorTest() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        Map<Id,Id> map_collgIdOrdId = new Map<Id,Id>();
        map_collgIdOrdId.put(data.caseCollegamento.Id, data.caseOrdine.Id);
        Id fattId = data.casePadre.Id;

        data.caseOrdine.PO_Data_Attivazione_Richiesta__c = String.valueOf(System.today());
        data.caseOrdine.PO_Nome_E_Cognome_PM__c = 'Mario il Rosso';
        data.caseOrdine.PO_Numero_Telefonico_PM__c = '081123456789';
        data.caseOrdine.Status = 'Accettato';
        update data.caseOrdine;

        insert new OF_Puntamento_Callout__c(Tibco_Collaudo__c = '#', Name='CustomTest');
        Test.setMock(WebServiceMock.class, new OLO_Activation_P2PMockGeneralError());
        OLO_ActivationP2PManager.sendToDOM(map_collgIdOrdId, fattId);
    }

    @isTest
    static void sendToDOMPositiveResponseTest() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        Map<Id,Id> map_collgIdOrdId = new Map<Id,Id>();
        map_collgIdOrdId.put(data.caseCollegamento.Id, data.caseOrdine.Id);
        Id fattId = data.casePadre.Id;

        data.caseOrdine.PO_Data_Attivazione_Richiesta__c = String.valueOf(System.today());
        data.caseOrdine.PO_Nome_E_Cognome_PM__c = 'Mario il Rosso';
        data.caseOrdine.PO_Numero_Telefonico_PM__c = '081123456789';
        data.caseOrdine.Status = 'Accettato';
        update data.caseOrdine;

        insert new OF_Puntamento_Callout__c(Tibco_Collaudo__c = '#', Name='CustomTest');
        Test.setMock(WebServiceMock.class, new OLO_Activation_P2PMock());
        OLO_ActivationP2PManager.sendToDOM(map_collgIdOrdId, fattId);
    }


}
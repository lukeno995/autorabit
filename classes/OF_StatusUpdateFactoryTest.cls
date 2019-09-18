@isTest
public with sharing class OF_StatusUpdateFactoryTest {

    static String oloCode = 'TIS_0001';

    @isTest
    static void getP2PServiceTestAttiva() {   
        Map<String, Id> map_devNameId = PO_ServFatt_DataFactory.getRtDevNameIdMap();   		
        Id idAttiva = RTypeServFattibilita.getRecordTypeIdByDevName(Case.SobjectType, 
                                                                   RTypeServFattibilita.CASE_P2P_ATTIVA_ORDINE);
        System.debug('id Attiva: ' + idAttiva);
        Case ordine = new Case();
        ordine.EOF_Codice_Ordine_OLO__c = oloCode;
        ordine.status = 'In Lavorazione';
        ordine.recordTypeId = idAttiva;
        insert ordine;
        
        OF_StatusUpdateP2PService service = OF_StatusUpdateFactory.getP2PService(oloCode);
        System.assert(service instanceof OF_StatusUpdateP2PAttiva);
    }

    @isTest
    static void getP2PServiceTestBase() {
		Map<String, Id> map_devNameId = PO_ServFatt_DataFactory.getRtDevNameIdMap();   		
        Id idBase = RTypeServFattibilita.getRecordTypeIdByDevName(Case.SobjectType, 
                                                                   RTypeServFattibilita.CASE_P2P_BASE_ORDINE);
        System.debug('id Base: ' + idBase);
        Case ordine = new Case();
        ordine.EOF_Codice_Ordine_OLO__c = oloCode;
        ordine.status = 'In Lavorazione';
        ordine.recordTypeId = idBase;
        insert ordine;
        
        OF_StatusUpdateP2PService service = OF_StatusUpdateFactory.getP2PService(oloCode);
        System.assert(service instanceof OF_StatusUpdateP2PBase);
    }

    @isTest
    static void getP2PServiceTestNull() {
        OF_StatusUpdateP2PService service = OF_StatusUpdateFactory.getP2PService(oloCode);
        System.assert(service == null);
    }
}
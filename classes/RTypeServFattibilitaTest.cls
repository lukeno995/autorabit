@isTest
public class RTypeServFattibilitaTest {
    
    @isTest
    static void getRecordTypeIdByDevNameTest() {
        // record type id in 'collaudo' / developer name 'PO_Ordine_P2P_Attiva'
        Map<String, Id> map_devNameId = PO_ServFatt_DataFactory.getRtDevNameIdMap();        
        Id expected = map_devNameId.get(RTypeServFattibilita.CASE_P2P_ATTIVA_ORDINE);
        
        Id actual = RTypeServFattibilita.getRecordTypeIdByDevName(Case.SObjectType, 
                                                                 RTypeServFattibilita.CASE_P2P_ATTIVA_ORDINE);
        
        System.assertEquals(expected, actual);
         
    }
    
    @isTest    
    static void getRecordTypeIdByDevNameShouldThrowException() {
        try {
            Id actual = RTypeServFattibilita.getRecordTypeIdByDevName(Case.SObjectType, 
                                                                 '');
        } catch (Exception e) {
            System.assert(e instanceof InvalidParameterValueException);
        }
        
    }
    
    @isTest    
    static void getRecordTypeIdByNameShouldThrowException() {
        try {
            Id actual = RTypeServFattibilita.getRecordTypeIdByName(Case.SObjectType, 
                                                                 '');
        } catch (Exception e) {
            System.assert(e instanceof InvalidParameterValueException);
        }
        
    }
}
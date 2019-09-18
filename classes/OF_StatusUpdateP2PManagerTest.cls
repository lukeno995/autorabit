@isTest
public class OF_StatusUpdateP2PManagerTest {

     @isTest
    static void Test1() {
       
        OF_StatusUpdate_P2P.Request rqst= new OF_StatusUpdate_P2P.Request();
        OF_StatusUpdateP2PManager.start(rqst);
    }
    
     @isTest
    static void Test2() {
        //OF_StatusUpdateP2PManager SUP1=new OF_StatusUpdateP2PManager();
        //OF_StatusUpdate_P2P.Request rqst= new OF_StatusUpdate_P2P.Request();
        OF_StatusUpdate_P2P.Request rqst = new OF_StatusUpdate_P2P.Request();
       rqst.id_notifica = '1234id';
        rqst.id_esito = '1234dom';
        rqst.data_notifica = System.now();
        rqst.id_fattibilita = '123456789';
        rqst.tipo_notifica = 'Ordine';
        rqst.id_ordine = 'tis_111';
        rqst.id_ordine_kit = '';
        rqst.stato_ordine = '2';
        rqst.id_risorsa = 'r1';
        rqst.data_espletamento_ordine = '2019-05-22';
        rqst.attachment = null;
        OF_StatusUpdateP2PManager.start(rqst);
    }
    @isTest
    static void Test3() {
        
        Map<String, Id> map_devNameId = PO_ServFatt_DataFactory.getRtDevNameIdMap();        
        Id idBase = RTypeServFattibilita.getRecordTypeIdByDevName(Case.SobjectType, 
                                                                   RTypeServFattibilita.CASE_P2P_BASE_ORDINE);
        System.debug('id Base: ' + idBase);
        Case ordine = new Case();
        ordine.EOF_Codice_Ordine_OLO__c ='TIS_0001' ;
        ordine.status = 'In Lavorazione';
        ordine.recordTypeId = idBase;
        insert ordine;

        EOF_Notify__c ecnew=new EOF_Notify__c();
        //OF_StatusUpdateP2PManager SUP1=new OF_StatusUpdateP2PManager();
        //OF_StatusUpdate_P2P.Request rqst= new OF_StatusUpdate_P2P.Request();
        OF_StatusUpdate_P2P.Request rqst = new OF_StatusUpdate_P2P.Request();
        rqst = new OF_StatusUpdate_P2P.Request();
         rqst.id_notifica = '1234id';
        rqst.id_esito = '1234dom';
        rqst.data_notifica = System.now();
        rqst.id_fattibilita = '123456789';
        rqst.tipo_notifica = 'ordine';
        rqst.id_ordine = 'TIS_0001';
        rqst.id_ordine_kit = '';
        rqst.stato_ordine = '2';
        rqst.id_risorsa = 'r1';
        rqst.data_espletamento_ordine = '2019-05-22';
        rqst.attachment = null;
        OF_StatusUpdateP2PManager.start(rqst);
    }
    /*@isTest
    static void Test4() {
        
        Map<String, Id> map_devNameId = PO_ServFatt_DataFactory.getRtDevNameIdMap();        
        Id idBase = RTypeServFattibilita.getRecordTypeIdByDevName(Case.SobjectType, 
                                                                   RTypeServFattibilita.CASE_P2P_BASE_ORDINE);
        System.debug('id Base: ' + idBase);
        Case ordine = new Case();
        ordine.EOF_Codice_Ordine_OLO__c ='TIS_0001' ;
        ordine.status = 'In Lavorazione';
        ordine.recordTypeId = idBase;
        insert ordine;

        //OF_StatusUpdateP2PManager SUP1=new OF_StatusUpdateP2PManager();
        //OF_StatusUpdate_P2P.Request rqst= new OF_StatusUpdate_P2P.Request();
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
       // OF_StatusUpdate_P2P.Response actual = OF_StatusUpdate_P2P.updateStat(request);
        OF_StatusUpdateP2PManager.start(request);
    }*/
}
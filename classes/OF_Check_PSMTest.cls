@isTest
public with sharing class OF_Check_PSMTest {

    // to cover trigger OF_Check_PSM
    @isTest
    static void checkPSMTest() {
        Date myDate = Date.newInstance(2017, 3, 17);
        Datetime caseDate = Datetime.newInstance(2017, 2, 17);
        
        PSM_TAP_OUT_CS__c psm = new PSM_TAP_OUT_CS__c();
        psm.On_Off__c = true;
        psm.Start_Date__c = myDate;
        psm.Elenco_Citta__c = 'Napoli';
        psm.name = 'Test';
        insert psm;

        Case c = new Case();
        Id rTypeId = RTypeServFattibilita.getRecordTypeIdByDevName(Case.SObjectType, 
            RTypeServFattibilita.CASE_P2P_BASE_ORDINE);
        c.status = 'Accettato';
        c.eof_fase__c = 'In Lavorazione Supporto Vendite';
        c.recordTypeId = rTypeId;
        c.ispsm__c = false; 
        
        insert c;   
        c.PO_PP_NomeKit__c = 'kit';
        Test.setCreatedDate(c.id, caseDate);
        update c;      
        Case cc = [SELECT createdDate FROM Case WHERE id =: c.Id];
        System.debug('created date: ' + cc.createdDate );
   
    }

}
@isTest
private class CA_CheckOrdiniInCorso_Trigger_TEST {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        RecordType rtAmm= [select Id from recordtype where developername='CA_Amministratori'];
        RecordType rtAtt= [select Id from recordtype where developername='EOF_Caso_Attivazione'];
        Case c = new Case();
        c.recordtypeId=rtAtt.Id;
        c.EOF_ID_Building_WS__c='test';
        insert c;
        Case c2 = new Case();
        c2.recordtypeId=rtAmm.Id;
        c2.CA_ID_Building__c='test';
        system.test.starttest();
        insert c2;
        system.test.stoptest();
    }
}
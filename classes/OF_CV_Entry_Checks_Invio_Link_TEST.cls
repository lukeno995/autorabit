@isTest
private class OF_CV_Entry_Checks_Invio_Link_TEST {
    
    private static EOF_CV_TRACCIAMENTO_VENDIBILITA__c createTrack()
    {
        EOF_CV_TRACCIAMENTO_VENDIBILITA__c tracciato = new EOF_CV_TRACCIAMENTO_VENDIBILITA__c();
        tracciato.ID_request__c = 'ID_RIC_001';
        tracciato.olo__c = 'TIS';
        tracciato.servizio__c = 'ATTIVO';
        tracciato.esito__c = 'OK';
        tracciato.Email__c = 'prova@test.com';
        return tracciato;
    }

	private static testMethod void test_syncCheck() {
	    
	    OF_CV_WS_Invio_Link.ResponseFromSend rfs = new OF_CV_WS_Invio_Link.ResponseFromSend();
	    OF_CV_WS_Invio_Link.Tracking track = new OF_CV_WS_Invio_Link.Tracking();
	    track.ID_REQUEST = '';
	    
	    OF_CV_WS_Invio_Link.Tracking track1 = new OF_CV_WS_Invio_Link.Tracking();
	    track1.ID_REQUEST = 'ID_REQ_001';
	    track1.ID_RICHIESTA_VENDIBILITA = '';
	    
	    OF_CV_WS_Invio_Link.Tracking track2 = new OF_CV_WS_Invio_Link.Tracking();
	    track2.ID_REQUEST = 'ID_REQ_001';
	    track2.ID_RICHIESTA_VENDIBILITA = 'ID_RIC_001';
	    track2.ESITO = 'OK';
	    track2.OLO = '';
	    
	    OF_CV_WS_Invio_Link.Tracking track3 = new OF_CV_WS_Invio_Link.Tracking();
	    track3.ID_REQUEST = 'ID_REQ_001';
	    track3.ID_RICHIESTA_VENDIBILITA = 'ID_RIC_001';
	    track3.ESITO = 'OK';
	    track3.OLO = 'TIS';
	    track3.SERVIZIO = '';
	    
	    OF_CV_WS_Invio_Link.Tracking track4 = new OF_CV_WS_Invio_Link.Tracking();
	    track4.ID_REQUEST = 'ID_REQ_001';
	    track4.ID_RICHIESTA_VENDIBILITA = 'ID_RIC_001';
	    track4.ESITO = 'OK';
	    track4.OLO = 'TIS';
	    track4.SERVIZIO = 'ATTIVO';
	    track4.LINK_FILE = '';
	    
	    EOF_CV_TRACCIAMENTO_VENDIBILITA__c t = createTrack();
	    insert t;
	    
	    OF_CV_WS_Invio_Link.Tracking track5 = new OF_CV_WS_Invio_Link.Tracking();
	    track5.ID_REQUEST = 'ID_REQ_001';
	    track5.ID_RICHIESTA_VENDIBILITA = 'ID_RIC_001';
	    track5.ESITO = 'OK';
	    track5.OLO = 'TIS';
	    track5.SERVIZIO = 'ATTIVO';
	    track5.LINK_FILE = 'test_file';
	    
	    OF_CV_WS_Invio_Link.Tracking track6 = new OF_CV_WS_Invio_Link.Tracking();
	    track6.ID_REQUEST = 'ID_REQ_001';
	    track6.ID_RICHIESTA_VENDIBILITA = 'ID_RIC_001';
	    track6.ESITO = 'KO';
	    track6.OLO = 'TIS';
	    track6.SERVIZIO = 'ATTIVO';
	    track6.LINK_FILE = 'test_file';
	    
	    Test.startTest();
	    rfs = OF_CV_Entry_Checks_Invio_Link.syncCheck(track);
	    rfs = OF_CV_Entry_Checks_Invio_Link.syncCheck(track1);
	    rfs = OF_CV_Entry_Checks_Invio_Link.syncCheck(track2);
	    rfs = OF_CV_Entry_Checks_Invio_Link.syncCheck(track3);
	    rfs = OF_CV_Entry_Checks_Invio_Link.syncCheck(track4);
	    rfs = OF_CV_Entry_Checks_Invio_Link.syncCheck(track5);
	    rfs = OF_CV_Entry_Checks_Invio_Link.syncCheck(track6);
	    Test.stopTest();
	}
	
	private static testMethod void test_syncCheck_1() {
	    
	    OF_CV_WS_Invio_Link.ResponseFromSend rfs = new OF_CV_WS_Invio_Link.ResponseFromSend();
	    OF_CV_WS_Invio_Link.Tracking track = new OF_CV_WS_Invio_Link.Tracking();
	    
        EOF_CV_TRACCIAMENTO_VENDIBILITA__c t_vuoto = new EOF_CV_TRACCIAMENTO_VENDIBILITA__c();
	    insert t_vuoto;
	    
	    track.ID_REQUEST = 'ID_REQ_001';
	    track.ID_RICHIESTA_VENDIBILITA = 'ID_RIC_001';
	    track.ESITO = 'OK';
	    track.OLO = 'TIS';
	    track.SERVIZIO = 'ATTIVO';
	    track.LINK_FILE = 'test_file';
	    
	    Test.startTest();
	    rfs = OF_CV_Entry_Checks_Invio_Link.syncCheck(track);
	    Test.stopTest();
	}
	
	private static testMethod void test_WS() {
	    
	    OF_CV_WS_Invio_Link.ResponseFromSend rfs = new OF_CV_WS_Invio_Link.ResponseFromSend();
	    OF_CV_WS_Invio_Link.Tracking track = new OF_CV_WS_Invio_Link.Tracking();
	    
        EOF_CV_TRACCIAMENTO_VENDIBILITA__c t = createTrack();
	    insert t;
	    
	    track.ID_REQUEST = 'ID_REQ_001';
	    track.ID_RICHIESTA_VENDIBILITA = 'ID_RIC_001';
	    track.ESITO = 'OK';
	    track.OLO = 'TIS';
	    track.SERVIZIO = 'ATTIVO';
	    track.LINK_FILE = 'test_file';
	    
	    Test.startTest();
	    //rfs = OF_CV_Entry_Checks_Invio_Link.syncCheck(track);
	    OF_CV_WS_Invio_Link.ResponseFromSend resp = OF_CV_WS_Invio_Link.ResponseRegoleVendita(track);
	    Test.stopTest();
	}
}
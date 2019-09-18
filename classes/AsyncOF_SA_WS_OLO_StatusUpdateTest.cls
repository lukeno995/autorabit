@isTest
global class AsyncOF_SA_WS_OLO_StatusUpdateTest {
    
    global static testMethod void TestAsyncOF_SA_WS_OLO_StatusUpdate(){
        AsyncOF_SA_WS_OLO_StatusUpdate aObj = new AsyncOF_SA_WS_OLO_StatusUpdate();
        AsyncOF_SA_WS_OLO_StatusUpdate.AsyncNotifyPortTypeEndpoint bObj = new AsyncOF_SA_WS_OLO_StatusUpdate.AsyncNotifyPortTypeEndpoint();
        
        Test.setMock(WebServiceMock.class, new AsyncOF_SA_WS_OLO_StatusUpdateMockCls());
        
        OF_SA_WS_OLO_Classi OfClassi = new OF_SA_WS_OLO_Classi();
        
        OF_SA_WS_OLO_Classi.RITIRO_APPARATO_element RITIROAPPARATelement = new OF_SA_WS_OLO_Classi.RITIRO_APPARATO_element();
        
        
        List< OF_SA_WS_OLO_Classi.RITIRO_APPARATO_element> RITIROAPPARATelementList = new List< OF_SA_WS_OLO_Classi.RITIRO_APPARATO_element>();
        
        
        RITIROAPPARATelement.TIPOLOGIA_APPARATO = 'test 1';
        RITIROAPPARATelementList.add(RITIROAPPARATelement);
        
        Continuation cont = new Continuation(120);        
        
        
        bObj.beginNotifyAggiornaStato(cont,'String CODICE_OPERATORE','String CODICE_ORDINE_OLO',
                                      'String CODICE_ORDINE_OF','String DATA_NOTIFICA','String ID_NOTIFICA',
                                      'String STATO_ORDINE','String CODICE_MOTIVAZIONE','String MOTIVAZIONE',
                                      'String GPON_DI_ATTESTAZIONE','String NOME_CLIENTE','String COGNOME_CLIENTE',
                                      'String RECAPITO_TELEFONICO_CLIENTE','String DATA_PREVISTA_ATTIVAZIONE',
                                      'String ORARIO_APPUNTAMENTO','String PIN_INTERVENTO_A_VUOTO','String NOTE',
                                      RITIROAPPARATelementList) ;
    }
    
}
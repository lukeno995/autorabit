@isTest
global class AsyncOF_SA_WS_OM_DeactivationTest {
    
      global static testMethod void TestAsyncOF_SA_WS_OM_Deactivation(){
        AsyncOF_SA_WS_OM_Deactivation aObj = new AsyncOF_SA_WS_OM_Deactivation();
        AsyncOF_SA_WS_OM_Deactivation.AsyncDisattivazioneOrdinePortTypeEndpoint bObj = new AsyncOF_SA_WS_OM_Deactivation.AsyncDisattivazioneOrdinePortTypeEndpoint();
        
        Test.setMock(WebServiceMock.class, new AsyncOF_SA_WS_OM_DeactivationMockCls());
        
        OF_SA_WS_OLO_Classi OfClassi = new OF_SA_WS_OLO_Classi();
       
        OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element DISAPPARATOEle = new OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element();
        
        
        List< OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element> DISAPPARATOEleList = new List< OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element>();
        
        
        
        DISAPPARATOEle.TIPOLOGIA_APPARATO = 'test 1';
        DISAPPARATOEleList.add(DISAPPARATOEle);
      
        Continuation cont = new Continuation(120);
        
        bObj.beginDeactivationOrderOM(cont,'String CODICE_OPERATORE','String CODICE_ORDINE_OLO',
                                        'String DATA_NOTIFICA','String ID_NOTIFICA','String ID_RISORSA','String NOME_CLIENTE',
                                        'String COGNOME_CLIENTE','String RECAPITO_TELEFONICO_CLIENTE_1','String RECAPITO_TELEFONICO_CLIENTE_2',
                                        'String NOTE','String TIPO_COMUNICAZIONE','String SORGENTE','String CODICE_ORDINE_OF',
                                        'String SLA_DATE','String GPON_ATTESTAZIONE','String GPON_VINCOLANTE','String OPZIONE_SYSTEM_UNICO',
                                        'String CODICE_MOTIVAZIONE','String MOTIVAZIONE','String COLLEGAMENTO_P2P','String TRACCIATO',
                                        'String ID_SERVIZIO','String PROFILO','String PROVINCIA','String COMUNE','String INDIRIZZO',
                                        'String NUMERO_CIVICO',DISAPPARATOEleList);
    }
    

}
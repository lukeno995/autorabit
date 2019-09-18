@isTest
global class AsyncOF_SA_WS_OLO_RescheduleTest {
    
      global static testMethod void TestAsyncOF_SA_WS_OLO_Reschedule(){
        AsyncOF_SA_WS_OLO_Reschedule aObj = new AsyncOF_SA_WS_OLO_Reschedule();
        AsyncOF_SA_WS_OLO_Reschedule.AsyncNotifyPortTypeEndpoint bObj = new AsyncOF_SA_WS_OLO_Reschedule.AsyncNotifyPortTypeEndpoint();
        
        Test.setMock(WebServiceMock.class, new AsyncOF_SA_WS_OLO_RescheduleMockCls());
        
      /*  OF_SA_WS_OLO_Classi OfClassi = new OF_SA_WS_OLO_Classi();
       
        OF_SA_WS_OLO_Classi.VLAN_element vlan = new OF_SA_WS_OLO_Classi.VLAN_element();
        OF_SA_WS_OLO_Classi.SERVIZIO_AGGIUNTIVO_element serEle = new OF_SA_WS_OLO_Classi.SERVIZIO_AGGIUNTIVO_element();
        OF_SA_WS_OLO_Classi.CONSEGNA_APPARATO_element conEle = new OF_SA_WS_OLO_Classi.CONSEGNA_APPARATO_element();
        
        List<OF_SA_WS_OLO_Classi.VLAN_element> vlanList = new List<OF_SA_WS_OLO_Classi.VLAN_element>();
        List<OF_SA_WS_OLO_Classi.SERVIZIO_AGGIUNTIVO_element> serEleList = new List<OF_SA_WS_OLO_Classi.SERVIZIO_AGGIUNTIVO_element>();
        List<OF_SA_WS_OLO_Classi.CONSEGNA_APPARATO_element> conEleList = new List<OF_SA_WS_OLO_Classi.CONSEGNA_APPARATO_element>();
        
        
        vlan.USER_VLAN = 'test 1';
        vlanList.add(vlan);
        serEle.NOME_SERVIZIO = 'test 2';
        serEleList.add(serEle);
        conEle.TIPOLOGIA_APPARATO = 'test 3';        
        conEleList.add(conEle);*/
        
        Continuation cont = new Continuation(120);
        
        bObj.beginNotifyRischedulazione(cont,'String CODICE_OPERATORE','String CODICE_ORDINE_OLO','String DATA_NOTIFICA','String ID_NOTIFICA','String NOME_CLIENTE','String COGNOME_CLIENTE','String RECAPITO_TELEFONICO_CLIENTE_1','String RECAPITO_TELEFONICO_CLIENTE_2','String DATA_PREVISTA_ATTIVAZIONE','String ORARIO_APPUNTAMENTO','String CODICE_MOTIVAZIONE','String MOTIVAZIONE','String NOTE') ;
                
    }

    

}
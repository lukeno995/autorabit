@isTest
global class AsyncOF_SA_WS_OLO_CompletionOrderTest{
    
    global static testMethod void TestAsyncOF_SA_WS_OLO_CompletionOrder(){
        AsyncOF_SA_WS_OLO_CompletionOrder aObj = new AsyncOF_SA_WS_OLO_CompletionOrder();
        AsyncOF_SA_WS_OLO_CompletionOrder.AsyncNotifyPortTypeEndpoint bObj = new AsyncOF_SA_WS_OLO_CompletionOrder.AsyncNotifyPortTypeEndpoint();
        
        Test.setMock(WebServiceMock.class, new AsyncOF_SA_WS_OLO_CompletionOrderMockCls());
        
        OF_SA_WS_OLO_Classi OfClassi = new OF_SA_WS_OLO_Classi();
       
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
        conEleList.add(conEle);
        
        Continuation cont = new Continuation(120);
        
       bObj.beginNotifyCompletamentoOrdine(cont,'Test 1','Test 2','Test 3','Test 4',
                                            'Test 5','Test 6','String CODICE_MOTIVAZIONE',
                                            'String MOTIVAZIONE','String ID_RISORSA','String DATA_ESPLETAMENTO_ORDINE',
                                            'String SCALA_PALAZZINA','String DDT','String NOTE',
                                            vlanList,serEleList,conEleList);
    }
    
}
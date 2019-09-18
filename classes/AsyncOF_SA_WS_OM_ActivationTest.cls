@isTest
global class AsyncOF_SA_WS_OM_ActivationTest {
    
        global static testMethod void TestAsyncOF_SA_WS_OM_Activation(){
        AsyncOF_SA_WS_OM_Activation aObj = new AsyncOF_SA_WS_OM_Activation();
        AsyncOF_SA_WS_OM_Activation.AsyncAttivazioneGponaPortTypeEndpoint bObj = new AsyncOF_SA_WS_OM_Activation.AsyncAttivazioneGponaPortTypeEndpoint();
        
        Test.setMock(WebServiceMock.class, new AsyncOF_SA_WS_OM_ActivationMockCls());
        
        OF_SA_WS_OLO_Classi OfClassi = new OF_SA_WS_OLO_Classi();
       
        OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element SERVIZIOAGGIUNTIVOEle = new OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element();
        OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element ATTIVAZIONEAPPARATOelement = new OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element();
		OF_SA_WS_OM_Classi.VLAN_element VLANelement = new OF_SA_WS_OM_Classi.VLAN_element();
        
        List< OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element> SERVIZIOAGGIUNTIVOEleList = new List< OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element>();
		List< OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element> ATTIVAZIONEAPPARATOelementList = new List< OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element>();
		List< OF_SA_WS_OM_Classi.VLAN_element> VLANelementList = new List< OF_SA_WS_OM_Classi.VLAN_element>();
        
        
        
        SERVIZIOAGGIUNTIVOEle.NOME_SERVIZIO = 'test 1';
        SERVIZIOAGGIUNTIVOEleList.add(SERVIZIOAGGIUNTIVOEle);
		
		ATTIVAZIONEAPPARATOelement.TIPOLOGIA_APPARATO = 'test 1';
        ATTIVAZIONEAPPARATOelementList.add(ATTIVAZIONEAPPARATOelement);
		
		
		VLANelement.KIT_CONSEGNA_VLAN = 'test 1';
        VLANelementList.add(VLANelement);
      
        Continuation cont = new Continuation(120);
        
		EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
		
        bObj.beginActivationOpenStreamOM(cont,
		sl,
		SERVIZIOAGGIUNTIVOEleList,
		ATTIVAZIONEAPPARATOelementList,
		VLANelementList) ;
    }

}
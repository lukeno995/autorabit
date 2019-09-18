@isTest
public with sharing class OLO_Activation_P2PTest {

    @isTest
    static void testCallout() {
        insert new OF_Puntamento_Callout__c(Tibco_Collaudo__c = '#', Name='CustomTest');           
		Test.startTest();        
        OLO_Activation_P2P.SF_DOM_WsdlSOAP servicee = new OLO_Activation_P2P.SF_DOM_WsdlSOAP();
        OLO_Activation_P2PSchema.Header_Request header = new OLO_Activation_P2PSchema.Header_Request();
        OLO_Activation_P2PSchema.Fattibilita fattibilita = new OLO_Activation_P2PSchema.Fattibilita();
        
		Test.setMock(WebServiceMock.class, new OLO_Activation_P2PMock());
        OLO_Activation_P2PSchema.Create_Response result = servicee.OLO_ActivationSetup_P2P(header, fattibilita);
        Test.stopTest();
        System.assertEquals('0', result.ESITO);
    }

    @isTest
    static void getUserVlanTest() {
        // 835
        String cos0 = 'COS0';
        String cos0cos5 = 'COS0,COS5';
        String cos0cos1cos5 = 'COS0,COS1,COS5';
        // 935
        String cos1 = 'COS1';
        // 837
        String cos5 = 'COS5';        

        String user835 = '835';
        String user837 = '837';
        String user935 = '935';

        // 835
        System.assertEquals(user835, OLO_ActivationP2PUtils.getUserVlan(cos0));
        System.assertEquals(user835, OLO_ActivationP2PUtils.getUserVlan(cos0cos5));
        System.assertEquals(user835, OLO_ActivationP2PUtils.getUserVlan(cos0cos1cos5));
        // 935
        System.assertEquals(user935, OLO_ActivationP2PUtils.getUserVlan(cos1));
        // 837
        System.assertEquals(user837, OLO_ActivationP2PUtils.getUserVlan(cos5));

        // blank
        System.assertEquals('', OLO_ActivationP2PUtils.getUserVlan('COS'));


    }
}
@isTest
public class GW_ChangeSetupOpenStream_Test{
    public static testMethod void GW_ChangeSetupOpenStreamMethod(){
        OF_Puntamento_Callout__c tamento = new OF_Puntamento_Callout__c();
        tamento.name = 'OGW';
        tamento.OF_OGW__c = 'Test';
        insert tamento;
        
        Test.startTest();
        
        GW_ChangeSetupOpenStream.ChangeSetupOpenStreamPortTypeEndpoint1  change = new GW_ChangeSetupOpenStream.ChangeSetupOpenStreamPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new GW_ChangeSetupOpenStream_mock_Test());
        GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element change1 = new GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element();
        GW_ChangeSetupOpenStream.ChangeSetupOpenStreamPortTypeEndpoint1  service = new GW_ChangeSetupOpenStream.ChangeSetupOpenStreamPortTypeEndpoint1();
        service.ChangeSetupOpenStream(change1);
        
        Test.stoptest();
        
    
    }

}
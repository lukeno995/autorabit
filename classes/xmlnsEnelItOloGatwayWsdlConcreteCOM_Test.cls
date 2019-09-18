@isTest(seealldata=true)
public class xmlnsEnelItOloGatwayWsdlConcreteCOM_Test {
    static testmethod void xmlnsEnelItOloGatwayWsdlConcreteCOMtest()
    {
      xmlnsEnelItOloGatwayWsdlConcreteCOM.InstantLinkSOAEndpoint1 aobj = new xmlnsEnelItOloGatwayWsdlConcreteCOM.InstantLinkSOAEndpoint1();
        Test.setMock(WebServiceMock.class, new xmlnsEnelItOloGatwayWsdlConcreteCOM_Mock());
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
           aobj.Delete_x('String NeType', 'String OrderNo', sl, 'String TIPO_comunicazione');
       Map<String,String> field_map = new map<string,string>();
        DateTime dtm = system.now();
        Date dt = system.today();
        aobj.Create('String NeType', 'String OrderNo', field_map,dtm,dt);
        aobj.AmendOrder('String NeType', 'String OrderNo', field_map,dtm,dt);
    }
}
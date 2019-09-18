@isTest
public class OF_TTM_WS_OUT_Sincronizzazione_Test {
    
    public static testmethod void Method(){
        
        OF_Puntamento_Callout__c p = new OF_Puntamento_Callout__c();
        p.Name='OGW';
        p.OF_OGW__c='OFS-SVIL-WS';
        insert p;
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TTM_WS_OUT_Sincronizzazione_Mock());
        OF_TTM_WS_OUT_Notifica.TroubleTicketNotifyResp_element obj1 = new OF_TTM_WS_OUT_Notifica.TroubleTicketNotifyResp_element();
        OF_TTM_WS_OUT_Sincronizzazione.SyncPortTypeEndpoint1 obj2 = new OF_TTM_WS_OUT_Sincronizzazione.SyncPortTypeEndpoint1();
        OF_TTM_WS_OUT_Notifica.TroubleTicketNotify_element TroubleTicketNotify = new OF_TTM_WS_OUT_Notifica.TroubleTicketNotify_element();
        obj2.NotifyTroubleTicket(TroubleTicketNotify,'ID_REQ_FORWARD2TTM','REQ_FORWARD2TTM','TIPO_COMUNICAZIONE_FORWARD2TTM');

    }

}
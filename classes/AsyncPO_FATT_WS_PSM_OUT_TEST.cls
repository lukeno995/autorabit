@isTest
public class AsyncPO_FATT_WS_PSM_OUT_TEST {

    static testMethod void myUnitTest() {
    	OF_Puntamento_Callout__c p = new OF_Puntamento_Callout__c();
        p.Name='OGW';
        p.OF_OGW__c='OFS-SVIL-WS';
        insert p;
        system.test.startTest();
        Test.setMock(WebServiceMock.class, new AsyncPO_FATT_WS_PSM_OUT_MOCK());
        AsyncPO_FATT_WS_PSM_OUT_Notify.OutputMapping1Future n= new AsyncPO_FATT_WS_PSM_OUT_Notify.OutputMapping1Future();
        n.getValue(); 
        Continuation cont = new Continuation(120);
        AsyncPO_FATT_WS_PSM_OUT_Sincronizzazione.AsyncPortTypeEndpoint1 stub = new AsyncPO_FATT_WS_PSM_OUT_Sincronizzazione.AsyncPortTypeEndpoint1();
        PO_FATT_WS_PSM_OUT_Notify.SubInput SubInput = new PO_FATT_WS_PSM_OUT_Notify.SubInput();
        List<PO_FATT_WS_PSM_OUT_Notify.Sedi_element> Sedi = new List<PO_FATT_WS_PSM_OUT_Notify.Sedi_element>();
        stub.beginSF_PSMOperation(cont,double.valueOf(0.0),double.valueOf(0.0),'ID_CIRCUITO_PRIMA_TRATTA','CODICE_ORDINE','ID_NOTIFICA','DATA_ORDINE_COMPLETATO','DATA_NOTIFICA','AZIONE','FATTIBILITA_CREATA_DA','DATA_ATTIVAZIONE_RICHIESTA_CLIENTE','DATA_ORDINE',SubInput,'DISPONIBILITA_RETE','MOTIVAZIONE_ANNULLAMENTO',double.valueOf(0.0),double.valueOf(0.0),'POP_DI_RIFERIMENTO_1','POP_DI_RIFERIMENTO_2','DROP_FL','DROP_FL2',double.valueOf(0.0),double.valueOf(0.0),double.valueOf(0.0),0,double.valueOf(0.0),double.valueOf(0.0),double.valueOf(0.0),'ID_CIRCUITO_SECONDA_TRATTA','NOTE_COLLEGAMENTO','ID_COLLEGAMENTO',Sedi);
        system.test.stopTest(); 
    }
}
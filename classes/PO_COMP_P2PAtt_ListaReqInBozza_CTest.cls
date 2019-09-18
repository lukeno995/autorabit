@isTest
public class PO_COMP_P2PAtt_ListaReqInBozza_CTest {
	@isTest
    public static void testMethod1(){
        PO_COMP_P2PAtt_ListaReqInBozza_Cntrl cntrl = new PO_COMP_P2PAtt_ListaReqInBozza_Cntrl();
        cntrl.tipoRIchiesta = 'Ordine di Cessazione';
        cntrl.vediReq();
        cntrl.pageDown();
        cntrl.pageUp();
        cntrl.setPagination(true);
        cntrl.preparePage();
    }
    
    @isTest
    public static void testMethod2(){
        PO_COMP_P2PAtt_ListaReqInBozza_Cntrl cntrl = new PO_COMP_P2PAtt_ListaReqInBozza_Cntrl();
        cntrl.tipoRIchiesta = 'Ordine di Cessazione1';
        cntrl.vediReq();
    }
}
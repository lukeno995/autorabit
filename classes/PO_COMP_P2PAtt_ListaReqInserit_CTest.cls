@isTest
public class PO_COMP_P2PAtt_ListaReqInserit_CTest {
	@isTest
    public static void testMethod1(){
        PO_COMP_P2PAtt_ListaReqInserit_Cntrl cntrl = new PO_COMP_P2PAtt_ListaReqInserit_Cntrl();
        cntrl.DataInizioNotifica = '01/01/2018';
        cntrl.DataFineNotifica = '01/01/2018';
        cntrl.DataInizioCreazione = '01/01/2018';
        cntrl.DataFineCreazione = '01/01/2018';
        cntrl.ListTipo = new List<String>{'test'};
        cntrl.ListStatus = new List<String>{'test'};
        cntrl.valPOP = 'test';
        cntrl.valCodOrdOLO = 'test';
        cntrl.valIDRisorsa = 'test';
        cntrl.tipoRIchiesta= 'Ordine di Cessazione';
        EOF_EAI_Service_Log__c recordTest = new EOF_EAI_Service_Log__c();
        insert recordTest;
        EOF_EAI_Service_Log__c recordTest1 = new EOF_EAI_Service_Log__c(OF_SA_Cpe_Log__c = recordTest.Id);
        insert recordTest1;
        cntrl.IdInserita = recordTest.Id;
        PageReference myVfPage = Page.PO_P2P_Attivo_DisplayRequest;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('DataInizioNotifica','01/01/2018');
        ApexPages.currentPage().getParameters().put('DataFineNotifica','01/01/2018');
        ApexPages.currentPage().getParameters().put('DataInizioCreazione','01/01/2018');
        ApexPages.currentPage().getParameters().put('DataFineCreazione','01/01/2018');
        ApexPages.currentPage().getParameters().put('selectValueL1','test');
        ApexPages.currentPage().getParameters().put('selectValueL2','test');
        ApexPages.currentPage().getParameters().put('valPOP','test');
        ApexPages.currentPage().getParameters().put('valCodOrdOLO','test');
        ApexPages.currentPage().getParameters().put('valIDRisorsa','test');
        Double d = cntrl.offset;
        cntrl.pageUp();
        cntrl.pageDown();
        cntrl.setPagination(true);
        cntrl.preparePage();
        cntrl.runSearch();
        cntrl.runQuery();
        cntrl.vediReq();
        cntrl.clonaRequest();
        cntrl.ricalcolaOptionFiltri( new List<EOF_EAI_Service_Log__c>{new EOF_EAI_Service_Log__c()});
    }
    
    public static void testMethod2(){
        PO_COMP_P2PAtt_ListaReqInserit_Cntrl cntrl = new PO_COMP_P2PAtt_ListaReqInserit_Cntrl();
        cntrl.tipoRIchiesta='Attivazione';
        cntrl.clonaRequest();
    }
    
    public static void testMethod3(){
        PO_COMP_P2PAtt_ListaReqInserit_Cntrl cntrl = new PO_COMP_P2PAtt_ListaReqInserit_Cntrl();
        cntrl.tipoRIchiesta='Cessazione';
        cntrl.clonaRequest();  
    }
}
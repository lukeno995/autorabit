@isTest
public class PO_COMP_TT_Inserimento_ControllerTest {
    static testmethod void method1()
    {
        
          PageReference pg = page.PO_TT_InsertNewRequest;
        pg.getParameters().put('proc','TTVisualizza');
        String proc = ApexPages.currentPage().getParameters().get('proc');
      
        test.setCurrentPage(pg);
        PO_COMP_TT_Inserimento_Controller pcc = new PO_COMP_TT_Inserimento_Controller();
        pcc.AnnullaS();
       // pcc.SalvaC();
    }
    
     
    
     static testmethod void method3()
    {
        
          PageReference pg = page.PO_TT_InsertNewRequest;
        pg.getParameters().put('proc','TTModifica');
        
        String proc = ApexPages.currentPage().getParameters().get('proc');
        String origId = ApexPages.currentPage().getParameters().get('origId');
        
        EOF_EAI_Service_Log__c slToInsert= new EOF_EAI_Service_Log__c();
        slToInsert.eof_tipo_comunicazione_String__c='Test';
        slToInsert.EOF_Codice_Ordine_OLo__C = 'Test';
      //  slToInsert.EOF_Codice_Comunicazione_OLO__c = 'Test';
        insert slToInsert;
        
        
      pg.getParameters().put('origId',slToInsert.Id);  
     // ApexPages.currentPage().getParameters().put('origId',slToInsert.ID);
     
        test.setCurrentPage(pg);
        PO_COMP_TT_Inserimento_Controller pcc = new PO_COMP_TT_Inserimento_Controller();
        pcc.AnnullaS();
       pcc.SalvaC();
    }
    static testmethod void method2()
    {
        
          PageReference pg = page.PO_TT_InsertNewRequest;
        pg.getParameters().put('proc','TTModifica1');
        
        String proc = ApexPages.currentPage().getParameters().get('proc');
        String origId = ApexPages.currentPage().getParameters().get('origId');
        
        EOF_EAI_Service_Log__c slToInsert= new EOF_EAI_Service_Log__c();
        slToInsert.eof_tipo_comunicazione_String__c='Test';
        slToInsert.EOF_Codice_Ordine_OLo__C = 'Test';
      //  slToInsert.EOF_Codice_Comunicazione_OLO__c = 'Test';
       // insert slToInsert;
        
        
      //pg.getParameters().put('origId',slToInsert.Id);  
     // ApexPages.currentPage().getParameters().put('origId',slToInsert.ID);
     
        test.setCurrentPage(pg);
        PO_COMP_TT_Inserimento_Controller pcc = new PO_COMP_TT_Inserimento_Controller();
        pcc.inputTimeStr2=string.valueof(DateTime.now());
       pcc.AnnullaS();
       pcc.SalvaC();
    }
}
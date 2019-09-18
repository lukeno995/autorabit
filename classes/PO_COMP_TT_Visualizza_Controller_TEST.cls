@isTest
public class PO_COMP_TT_Visualizza_Controller_TEST {
    
    static Map<String,String> RecordType(){ 
        //Record Type case
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Asset')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
            
            for(RecordType rt: rtypes)
            RecordType.put(rt.Name,rt.Id);
        
        return RecordType;
}
    
    public static testmethod void test1(){
        
        TestDataFactory.CreateTestRecords('Trouble Ticket','PO - TT - TroubleTicketRequest',null);//  case c5 o CList[0]
        
        //Apexpages.currentPage().getParameters().put('origId',eaiLog.Id);
        //Apexpages.currentPage().getParameters().put('inoltrato',string.ValueOF(system.today()));
        Test.setCurrentPageReference(new pageReference('PO_TT_InsertNewRequest'));
        system.currentPageReference().getParameters().put('origId',TestDataFactory.ESlog[0].id);
        
        test.startTest();
        PO_COMP_TT_Visualizza_Controller ptv = new PO_COMP_TT_Visualizza_Controller();
        ptv.ListaRichiesteInserite();
        ptv.ReferenceNewInsertPage();
        ptv.ToModifyCase();
        ptv.ToAnnulla();
        ptv.ToTestOK();
        ptv.ToTestKO();
        ptv.ToDesospensione();
        ptv.ToAutoripristinato();
        ptv.ToAnnullaOperazione();
        ptv.ToInviaRichiesta();
        
        test.stopTest();
    }    
    
    public static testmethod void test2(){
        
        TestDataFactory.CreateTestRecords('Trouble Ticket','PO - TT - TroubleTicketRequest',null);
        
        Test.setCurrentPageReference(new pageReference('PO_TT_InsertNewRequest'));
        system.currentPageReference().getParameters().put('origId',TestDataFactory.ESlog[0].id);
        
        OF_TT_EntryChecks.c= TestDataFactory.c5;
        
        test.startTest();
        PO_COMP_TT_Visualizza_Controller ptv = new PO_COMP_TT_Visualizza_Controller();
        ptv.ToInoltraCase();
        ptv.ToInoltraTestOK();
        ptv.ToInoltraTestKO();
        test.stopTest();        
    }
    
    public static testmethod void test3(){
        
        TestDataFactory.CreateTestRecords('Trouble Ticket','PO - TT - TroubleTicketRequest',null);
        
        Test.setCurrentPageReference(new pageReference('PO_TT_InsertNewRequest'));
        system.currentPageReference().getParameters().put('origId',TestDataFactory.ESlog[0].id);
        
        OF_TT_EntryChecks.c= TestDataFactory.c5;

        
        test.startTest();
        PO_COMP_TT_Visualizza_Controller ptv = new PO_COMP_TT_Visualizza_Controller();
        ptv.inputTimeStr2 = '2018-01-23 17:21:00';
        ptv.ToInoltraRichiestaAnnullamento();
        ptv.ToInoltraNotificaDesospensione();
        ptv.ToInoltraAutoripristinato();
		test.stopTest();
    }
       
}
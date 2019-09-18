@istest
public class PO_TTService_Controller_Test {
    
    static testmethod void Method1()
    {
        
        PageReference pageRef = page.PO_TT_InsertNewRequest;
        string TTModifica = 'TTModifica';
        
        pageRef.getParameters().put('proc' , 'TTRichiestaAnnullamento');
        String proc = ApexPages.currentPage().getParameters().get('proc');
        Test.setCurrentPageReference(pageRef);
        PO_TTService_Controller pot = new PO_TTService_Controller();
    }
    static testmethod void Method2()
    {
        
        PageReference pageRef = page.PO_TT_InsertNewRequest;
        string TTModifica = 'TTModifica';
        
        pageRef.getParameters().put('proc' , 'TTVisualizza');
        String proc = ApexPages.currentPage().getParameters().get('proc');
        Test.setCurrentPageReference(pageRef);
        PO_TTService_Controller pot = new PO_TTService_Controller();
    }
    static testmethod void Method3()
    {
        
        PageReference pageRef = page.PO_TT_InsertNewRequest;
        string TTModifica = 'TTModifica';
        
        pageRef.getParameters().put('proc' , 'TTModifica');
        String proc = ApexPages.currentPage().getParameters().get('proc');
        Test.setCurrentPageReference(pageRef);
        PO_TTService_Controller pot = new PO_TTService_Controller();
    }
    static testmethod void Method4()
    {
        
        PageReference pageRef = page.PO_TT_InsertNewRequest;
        string TTModifica = 'TTModifica';
        
        pageRef.getParameters().put('proc' , 'TTTestKO');
        String proc = ApexPages.currentPage().getParameters().get('proc');
        Test.setCurrentPageReference(pageRef);
        PO_TTService_Controller pot = new PO_TTService_Controller();
    }
    static testmethod void Method5()
    {
        
        PageReference pageRef = page.PO_TT_InsertNewRequest;
        string TTModifica = 'TTModifica';
        
        pageRef.getParameters().put('proc' , 'TTTestOK');
        String proc = ApexPages.currentPage().getParameters().get('proc');
        Test.setCurrentPageReference(pageRef);
        PO_TTService_Controller pot = new PO_TTService_Controller();
    }
    static testmethod void Method6()
    {
        
        PageReference pageRef = page.PO_TT_InsertNewRequest;
        string TTModifica = 'TTModifica';
        
        pageRef.getParameters().put('proc' , 'TTDesospensione');
        String proc = ApexPages.currentPage().getParameters().get('proc');
        Test.setCurrentPageReference(pageRef);
        PO_TTService_Controller pot = new PO_TTService_Controller();
    }
    static testmethod void Method7()
    {
        
        PageReference pageRef = page.PO_TT_InsertNewRequest;
        string TTModifica = 'TTModifica';
        
        pageRef.getParameters().put('proc' , 'TTAutoripristinato');
        String proc = ApexPages.currentPage().getParameters().get('proc');
        Test.setCurrentPageReference(pageRef);
        PO_TTService_Controller pot = new PO_TTService_Controller();
    }
}
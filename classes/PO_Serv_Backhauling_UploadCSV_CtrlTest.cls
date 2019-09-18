@isTest
private class PO_Serv_Backhauling_UploadCSV_CtrlTest {
    
    @testSetup
    public static void beginInfo()
    {
        List<OF_ElencoComuniItaliani__c> comuni = new List<OF_ElencoComuniItaliani__c>();
        OF_ElencoComuniItaliani__c el = new OF_ElencoComuniItaliani__c();
        el.OF_Comune__c='Napoli';
        el.OF_CodiceIstat__c='0000';
        comuni.add(el);
        
        OF_ElencoComuniItaliani__c el1 = new OF_ElencoComuniItaliani__c();
        el1.OF_Comune__c='Roma';
        el1.OF_CodiceIstat__c='1111';
        comuni.add(el1);
        
        insert comuni;
    }
    
    
    @isTest
    public static void PO_Serv_Backhauling_UploadCSV_Ctrl_test1(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_Backhauling_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_Backhauling_UploadCSV_Ctrl ctrl = new PO_Serv_Backhauling_UploadCSV_Ctrl(new ApexPages.StandardController(log1));
        PO_Serv_Backhauling_UploadCSV_Ctrl ctrl1 = new PO_Serv_Backhauling_UploadCSV_Ctrl();
        ctrl1.Annulla();
        ctrl1.ReadFile();
        Blob bl = Blob.valueof('%7c');
        PO_Serv_Backhauling_UploadCSV_Ctrl.blobToString(bl , 'UTF-8');
    }
    
    @isTest
    public static void PO_Serv_Backhauling_UploadCSV_Ctrl_test2(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_Backhauling_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_Backhauling_UploadCSV_Ctrl ctrl1 = new PO_Serv_Backhauling_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('qwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        ctrl1.ReadFile();
    }
    @isTest
    public static void PO_Serv_Backhauling_UploadCSV_Ctrl_test00(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        OF_ElencoComuniItaliani__c ec =  new OF_ElencoComuniItaliani__c();
        ec.OF_Comune__c = 'Napoli';
        ec.OF_CodiceIstat__c = '063005';
        OF_ElencoComuniItaliani__c ec2 =  new OF_ElencoComuniItaliani__c();
        ec2.OF_Comune__c = '';
        ec2.OF_CodiceIstat__c = '063006';
        List<OF_ElencoComuniItaliani__c> listCom =  new List <OF_ElencoComuniItaliani__c>();
        listCom.add(ec);
        listCom.add(ec2);
        insert listCom;
        PageReference pageRef = Page.PO_Serv_Backhauling_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_Backhauling_UploadCSV_Ctrl ctrl1 = new PO_Serv_Backhauling_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('qwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        ctrl1.ReadFile();
    }
    @isTest
    public static void PO_Serv_Backhauling_UploadCSV_Ctrl_test3(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_Backhauling_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_Backhauling_UploadCSV_Ctrl ctrl1 = new PO_Serv_Backhauling_UploadCSV_Ctrl();
        Blob bl = Blob.valueof('qwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nBTS,rty,rty\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }
    @isTest
    public static void PO_Serv_Backhauling_UploadCSV_Ctrl_test10(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_Backhauling_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_Backhauling_UploadCSV_Ctrl ctrl1 = new PO_Serv_Backhauling_UploadCSV_Ctrl();
        Blob bl = Blob.valueof(',,, ,,,,,,,,,,,,\nqwe,,, ,,,,,,,,,,,,\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }
    @isTest
    public static void PO_Serv_Backhauling_UploadCSV_Ctrl_test9(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_Backhauling_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_Backhauling_UploadCSV_Ctrl ctrl1 = new PO_Serv_Backhauling_UploadCSV_Ctrl();
        Blob bl = null;
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }
    
    @isTest
    public static void PO_Serv_Backhauling_UploadCSV_Ctrl_test4(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_Backhauling_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_Backhauling_UploadCSV_Ctrl ctrl1 = new PO_Serv_Backhauling_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('qweeeeeeeeeeeeeeeeeeeeeeee,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n,,,,,,,,,n');
        ctrl1.ReadFile();    }
    
    @isTest
    public static void PO_Serv_Backhauling_UploadCSV_Ctrl_test5(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_Backhauling_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_Backhauling_UploadCSV_Ctrl ctrl1 = new PO_Serv_Backhauling_UploadCSV_Ctrl();
        Blob bl = Blob.valueof('qwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }
    
    @isTest
    public static void PO_Serv_Backhauling_UploadCSV_Ctrl_6()
    {
        PO_Serv_Backhauling_UploadCSV_Ctrl_testTemplate('qwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        PO_Serv_Backhauling_UploadCSV_Ctrl_testTemplate('qwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,Backhauling,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        PO_Serv_Backhauling_UploadCSV_Ctrl_testTemplate('qwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,Backhauling,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        PO_Serv_Backhauling_UploadCSV_Ctrl_testTemplate('qwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,Backhauling,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        PO_Serv_Backhauling_UploadCSV_Ctrl_testTemplate('qwe,BTS,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n,,,,,,,,,,,,,,,\n');
        
    }
    
    public static void PO_Serv_Backhauling_UploadCSV_Ctrl_testTemplate(string blobS){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_Backhauling_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_Backhauling_UploadCSV_Ctrl ctrl1 = new PO_Serv_Backhauling_UploadCSV_Ctrl();
        Blob bl = Blob.valueof(blobS);
        ctrl1.ReadContent(bl , 'accId', log1);
        ctrl1.nameFile = 'test';
    }
}
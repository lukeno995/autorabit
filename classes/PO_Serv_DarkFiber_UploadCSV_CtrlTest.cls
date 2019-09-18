@isTest
public class PO_Serv_DarkFiber_UploadCSV_CtrlTest {
    @isTest
    public static void PO_Serv_DarkFiber_UploadCSV_Ctrl_test1(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_DarkFiber_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_DarkFiber_UploadCSV_Ctrl ctrl = new PO_Serv_DarkFiber_UploadCSV_Ctrl(new ApexPages.StandardController(log1));
        PO_Serv_DarkFiber_UploadCSV_Ctrl ctrl1 = new PO_Serv_DarkFiber_UploadCSV_Ctrl();
        ctrl1.Annulla();
        ctrl1.ReadFile();
        Blob bl = Blob.valueof('%7c');
        PO_Serv_DarkFiber_UploadCSV_Ctrl.blobToString(bl , 'UTF-8');
    }
    
    @isTest
    public static void PO_Serv_DarkFiber_UploadCSV_Ctrl_test2(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_DarkFiber_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_DarkFiber_UploadCSV_Ctrl ctrl1 = new PO_Serv_DarkFiber_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('qwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        ctrl1.ReadFile();
    }
    @isTest
    public static void PO_Serv_DarkFiber_UploadCSV_Ctrl_test3(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_DarkFiber_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_DarkFiber_UploadCSV_Ctrl ctrl1 = new PO_Serv_DarkFiber_UploadCSV_Ctrl();
        Blob bl = Blob.valueof('qwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nDarkFiber,rty,rty\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }
    
    @isTest
    public static void PO_Serv_DarkFiber_UploadCSV_Ctrl_test4(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_DarkFiber_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_DarkFiber_UploadCSV_Ctrl ctrl1 = new PO_Serv_DarkFiber_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('qweeeeeeeeeeeeeeeeeeeeeeee,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n,,,,,,,,,n');
        ctrl1.ReadFile();    }
    
    @isTest
    public static void PO_Serv_DarkFiber_UploadCSV_Ctrl_test5(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_DarkFiber_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_DarkFiber_UploadCSV_Ctrl ctrl1 = new PO_Serv_DarkFiber_UploadCSV_Ctrl();
        Blob bl = Blob.valueof('qwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }    
    
    
    
    
    @isTest
    public static void PO_Serv_DarkFiber_UploadCSV_Ctrl_test9(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_DarkFiber_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_DarkFiber_UploadCSV_Ctrl ctrl1 = new PO_Serv_DarkFiber_UploadCSV_Ctrl();
        Blob bl = null;
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }  
    
    
    @isTest
    public static void PO_Serv_DarkFiber_UploadCSV_Ctrl_test10(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_DarkFiber_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_DarkFiber_UploadCSV_Ctrl ctrl1 = new PO_Serv_DarkFiber_UploadCSV_Ctrl();
        Blob bl = Blob.valueof(',,, ,,,,,,,,,,,,\nqwe,,, ,,,,,,,,,,,,\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }    
    @isTest
    public static void PO_Serv_DarkFiber_UploadCSV_Ctrl_test00(){
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
        System.debug('@@@@commm'+listCom);
        PageReference pageRef = Page.PO_Serv_DarkFiber_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_DarkFiber_UploadCSV_Ctrl ctrl1 = new PO_Serv_DarkFiber_UploadCSV_Ctrl();
        Blob bl = Blob.valueof('qwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,DarkFiber,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
        
    }    
    
    
}
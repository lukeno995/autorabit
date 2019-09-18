@isTest
private class PO_Serv_FiberLease_UploadCSV_CtrlTest {
    
    @isTest
    public static void PO_Serv_FiberLease_UploadCSV_Ctrl_test1(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLease_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLease_UploadCSV_Ctrl ctrl = new PO_Serv_FiberLease_UploadCSV_Ctrl(new ApexPages.StandardController(log1));
        PO_Serv_FiberLease_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLease_UploadCSV_Ctrl();
        ctrl1.Annulla();
        ctrl1.ReadFile();
        Blob bl = Blob.valueof('%7c');
        PO_Serv_FiberLease_UploadCSV_Ctrl.blobToString(bl , 'UTF-8');
    }
    
    @isTest
    public static void PO_Serv_FiberLease_UploadCSV_Ctrl_test5(){
        OF_ElencoComuniItaliani__c comm = new OF_ElencoComuniItaliani__c();
        comm.OF_CodiceIstat__c = 'test';
        comm.OF_Comune__c = 'Torino';
        insert comm;
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        log1.EOF_Codice_Ordine_OLO__c = 'LOG-BANANA';
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLease_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLease_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLease_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione, Particella Toponomastica, Indirizzo Destinazione,Civico Destinazione,Nota Sito Destinazione,Comune Partenza, Sito Partenza, Particella Toponomastica, Indirizzo Partenza,Civico Partenza,Nota Sito Partenza\nVodafone,SDH,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,Via,VIA COLOMBO  ,24,45.05711 - 7.66285,Torino,1OF60225 - TORINO CENTRO TI,Via,VIA MERCANTINI  ,9,45.0704181532206 - 7.67610544977457,,,,,,\n');
        ctrl1.ReadFile();
    }
    
    @isTest
    public static void PO_Serv_FiberLease_UploadCSV_Ctrl_test2(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLease_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLease_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLease_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('qwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        ctrl1.ReadFile();
    }
    @isTest
    public static void PO_Serv_FiberLease_UploadCSV_Ctrl_test00(){
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
        PageReference pageRef = Page.PO_Serv_FiberLease_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLease_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLease_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('qwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        ctrl1.ReadFile();
    }
    @isTest
    public static void PO_Serv_FiberLease_UploadCSV_Ctrl_test3(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLease_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLease_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLease_UploadCSV_Ctrl();
        Blob bl = Blob.valueof('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione, Particella Toponomastica, Indirizzo Destinazione,Civico Destinazione,Nota Sito Destinazione,Comune Partenza, Sito Partenza, Particella Toponomastica, Indirizzo Partenza,Civico Partenza,Nota Sito Partenza\nVodafone,SDH,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,Via,VIA COLOMBO  ,24,45.05711 - 7.66285,Torino,1OF60225 - TORINO CENTRO TI,Via,VIA MERCANTINI  ,9,45.0704181532206 - 7.67610544977457,,,,,,\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }
    
    @isTest
    public static void PO_Serv_FiberLease_UploadCSV_Ctrl_test4(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLease_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLease_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLease_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione, Particella Toponomastica, Indirizzo Destinazione,Civico Destinazione,Nota Sito Destinazione,Comune Partenza, Sito Partenza, Particella Toponomastica, Indirizzo Partenza,Civico Partenza,Nota Sito Partenza\nqweeeeeeeeeeeeeeeeeeeeeeee,FiberLease,2+2,Doppia via Diversificata,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLease,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n,,,,,,,,,n');
        ctrl1.ReadFile();    }
    
}
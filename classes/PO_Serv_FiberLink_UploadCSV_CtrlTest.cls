@isTest
private class PO_Serv_FiberLink_UploadCSV_CtrlTest {
    
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
    public static void PO_Serv_FiberLink_UploadCSV_Ctrl_test1(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLink_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLink_UploadCSV_Ctrl ctrl = new PO_Serv_FiberLink_UploadCSV_Ctrl(new ApexPages.StandardController(log1));
        PO_Serv_FiberLink_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLink_UploadCSV_Ctrl();
        ctrl1.Annulla();
        ctrl1.ReadFile();
        Blob bl = Blob.valueof('%7c');
        PO_Serv_FiberLink_UploadCSV_Ctrl.blobToString(bl , 'UTF-8');
    }
    
    @isTest
    public static void PO_Serv_FiberLink_UploadCSV_Ctrl_test2(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLink_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLink_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLink_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('qwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n');
        ctrl1.ReadFile();
    }
    @isTest
    public static void PO_Serv_FiberLink_UploadCSV_Ctrl_test3(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLink_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLink_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLink_UploadCSV_Ctrl();
        Blob bl = Blob.valueof('qwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nFiberLink,rty,rty\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }
    
    @isTest
    public static void PO_Serv_FiberLink_UploadCSV_Ctrl_test4(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLink_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLink_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLink_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('qweeeeeeeeeeeeeeeeeeeeeeee,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n,,,,,,,,,n');
        ctrl1.ReadFile();    }
    
    @isTest
    public static void PO_Serv_FiberLink_UploadCSV_Ctrl_test00(){
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
        PageReference pageRef = Page.PO_Serv_FiberLink_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLink_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLink_UploadCSV_Ctrl();
        ctrl1.contentFile = Blob.valueof('qweeeeeeeeeeeeeeeeeeeeeeee,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\nqwe,FiberLink,2,Singola via,Roma,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe,qwe\n,,,,,,,,,n');
        ctrl1.ReadFile();    }
    
    @isTest
    public static void PO_Serv_FiberLink_UploadCSV_Ctrl_test5(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLink_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLink_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLink_UploadCSV_Ctrl();
        Blob bl = Blob.valueof('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Particella Toponomastica,Indirizzo1,Civico1,Nota Sito1,Comune2,Sito2,Particella Toponomastica,Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Particella Toponomastica,Indirizzo3,Civico3,Nota Sito3,EventoTemporaneo,DurataEvento\nTest Upload massivo,Backhauling,1,Singola Via,Roma,Sito Cliente,Largo,Colli Albani,141,Nota del sito1,Roma,Sito 2 di terminazione,Corso,Garibaldi,142,Nota del Sito 2,Napoli,Sito31,Via,Via test 31,31,NOTA31,TRUE,43\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }   
    
    @isTest
    public static void PO_Serv_FiberLink_UploadCSV_Ctrl_test9(){
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLink_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLink_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLink_UploadCSV_Ctrl();
        Blob bl = Blob.valueof(',,, ,,,,,,,,,,,,\nqwe,,, ,,,,,,,,,,,,\n');
        Blob blo = Blob.valueof('');
        ctrl1.ReadContent(bl , 'accId', log1);
        //ctrl1.ReadContent(blo , 'accId', log1);
        ctrl1.nameFile = 'test';
    }   
    
    @isTest
    public static void PO_Serv_FiberLink_UploadCSV_Ctrl_test6(){
        PO_Serv_FiberLink_UploadCSV_Ctrl_testTemplate('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Particella Toponomastica,Indirizzo1,Civico1,Nota Sito1,Comune2,Sito2,Particella Toponomastica,Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Particella Toponomastica,Indirizzo3,Civico3,Nota Sito3,EventoTemporaneo,DurataEvento\nTest Upload massivo,Backhauling,5,Singola Via,Roma,Sito Cliente,Largo,Colli Albani,141,Nota del sito1,Roma,Sito 2 di terminazione,Corso,Garibaldi,142,Nota del Sito 2,Napoli,Sito31,Via,Via test 31,31,NOTA31,TRUE,43\n');
        PO_Serv_FiberLink_UploadCSV_Ctrl_testTemplate('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Particella Toponomastica,Indirizzo1,Civico1,Nota Sito1,Comune2,Sito2,Particella Toponomastica,Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Particella Toponomastica,Indirizzo3,Civico3,Nota Sito3,EventoTemporaneo,DurataEvento\nTest Upload massivo,Backhling,2,Singola Via,Roma,Sito Cliente,test,Colli Albani,141,Nota del sito1,Roma,Sito 2 di terminazione,Corso,Garibaldi,142,Nota del Sito 2,Napoli,Sito31,Via,Via test 31,31,NOTA31,TRUE,43\n');
        PO_Serv_FiberLink_UploadCSV_Ctrl_testTemplate('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Particella Toponomastica,Indirizzo1,Civico1,Nota Sito1,Comune2,Sito2,Particella Toponomastica,Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Particella Toponomastica,Indirizzo3,Civico3,Nota Sito3,EventoTemporaneo,DurataEvento\nTest Upload massivo,Backhauling,2,DoppiaVia,Roma,Sito Cliente,Largo,Colli Albani,141,Nota del sito1,Roma,Sito 2 di terminazione,Corso,Garibaldi,142,Nota del Sito 2,Napoli,Sito31,Via,Via test 31,31,NOTA31,TRUE,43\n');
        PO_Serv_FiberLink_UploadCSV_Ctrl_testTemplate('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Particella Toponomastica,Indirizzo1,Civico1,Nota Sito1,Comune2,Sito2,Particella Toponomastica,Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Particella Toponomastica,Indirizzo3,Civico3,Nota Sito3,EventoTemporaneo,DurataEvento\nTest Upload massivo,Backhauling,1,Singola VIAVIAVIA,Roma,Sito Cliente,Largo,Colli Albani,141,Nota del sito1,Roma,Sito 2 di terminazione,Corso,Garibaldi,142,Nota del Sito 2,Napoli,Sito31,Via,Via test 31,31,NOTA31,TRUE,43\n');
        PO_Serv_FiberLink_UploadCSV_Ctrl_testTemplate('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Particella Toponomastica,Indirizzo1,Civico1,Nota Sito1,Comune2,Sito2,Particella Toponomastica,Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Particella Toponomastica,Indirizzo3,Civico3,Nota Sito3,EventoTemporaneo,DurataEvento\nTest Upload massivo,Backhauling,5,Singola Via,Roma,Sito Cliente,Largo,Colli Albani,141,Nota del sito1,Roma,Sito 2 di terminazione,Corso,Garibaldi,142,Nota del Sito 2,Napoli,Sito31,Via,Via test 31,31,NOTA31,TRUE,43\n');
        PO_Serv_FiberLink_UploadCSV_Ctrl_testTemplate('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Particella Toponomastica,Indirizzo1,Civico1,Nota Sito1,Comune2,Sito2,Particella Toponomastica,Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Particella Toponomastica,Indirizzo3,Civico3,Nota Sito3,EventoTemporaneo,DurataEvento\nTest Upload massivo,Backhauling,1,Doppia via Diversificata,Roma,Sito Cliente,Largo,Colli Albani,141,Nota del sito1,Roma,Sito 2 di terminazione,Corso,Garibaldi,142,Nota del Sito 2,Napoli,Sito31,Via,Via test 31,31,NOTA31,TRUE,43\n');
        PO_Serv_FiberLink_UploadCSV_Ctrl_testTemplate('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Particella Toponomastica,Indirizzo1,Civico1,Nota Sito1,Comune2,Sito2,Particella Toponomastica,Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Particella Toponomastica,Indirizzo3,Civico3,Nota Sito3,EventoTemporaneo,DurataEvento\nTest Upload massivo,Backhauling,2+2,Doppia via Diversificata,Roma,Sito Cliente,Largo,Colli Albani,141,Nota del sito1,Roma,Sito 2 di terminazione,Corso,Garibaldi,142,Nota del Sito 2,Napoli,Sito31,Via,Via test 31,31,NOTA31,TRUE,43\n');
    }    
    
    public static void PO_Serv_FiberLink_UploadCSV_Ctrl_testTemplate(string blobS)
    {
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        insert log1;
        PageReference pageRef = Page.PO_Serv_FiberLink_UploadCSV;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', log1.Id);
        PO_Serv_FiberLink_UploadCSV_Ctrl ctrl1 = new PO_Serv_FiberLink_UploadCSV_Ctrl();
        Blob bl = Blob.valueof(blobS);
        ctrl1.ReadContent(bl , 'accId', log1);
        ctrl1.nameFile = 'test';
    }
    
}
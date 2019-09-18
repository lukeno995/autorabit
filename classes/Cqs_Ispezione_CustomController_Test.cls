@isTest
public class Cqs_Ispezione_CustomController_Test{
    public static testMethod void IspezioneMethod(){
        Id RecordTypeIdeven = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();   
        
        OF_CQS_Anagrafica__c ana = new OF_CQS_Anagrafica__c();
        ana.CQS_Check_Affidataria__c = true;
        ana.Name = 'TESTANA';
        insert ana;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.Name = 'Test';
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_LDO__c='Test00001';
		pro.CQS_Pro_LDO_Service__c='Test0002';
        pro.CQS_Pro_LDO_Service2__c='Test0003';
		pro.CQS_Pro_LDO_Service3__c='Test0004';
        pro.CQS_Pro_Comune__c='Test';
        insert pro;
        
       // List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_Accantieramento_conforme__c = 'Sì';
        cqs.CQS_ISP_Progetto__c = pro.Id;
        cqs.OF_CQS_ISP_Comune__c = 'Test';
        cqs.OF_CQS_ISP_Provincia__c = 'Test';
        cqs.CQS_ISP_Nome_Cognome__c = 'Test';
        cqs.Cqs_Isp_Autorizzato__c = 'Sì';
        cqs.CQS_Isp_Nome_Cognome2__c = 'Test';
        cqs.Cqs_Isp_Autorizzato2__c = 'Sì';
        cqs.CQS_ISP_Nome_Cognome3__c = 'Test';
        cqs.Cqs_Isp_Autorizzato3__c = 'Sì';
        cqs.CQS_ISP_Nome_Cognome4__c = 'Test';
        cqs.Cqs_Isp_Autorizzato4__c = 'Sì';
        cqs.CQS_ISP_Nome_Cognome5__c = 'Test';
        cqs.Cqs_Isp_Autorizzato5__c = 'Sì';
        cqs.CQS_ISP_Nome_Cognome6__c = 'Test';
        cqs.Cqs_Isp_Autorizzato6__c = 'Sì';
        insert cqs;
        
        OF_CQS_Evento__c Evento = new OF_CQS_Evento__c();
        Evento.OF_CQS_Impresa_Mandataria__c = ana.Id;
        Evento.OF_CQS_Impresa_Esecutrice_Eventi__c = ana.Id;
        Evento.OF_CQS_Data_Evento__c = system.today();
        Evento.VIA__c = 'ROSSI';
        Evento.OF_CQS_Numero_Civico__c = '3';
        Evento.RecordTypeId = RecordTypeIdeven;
        Evento.OF_CQS_Diffida__c = FALSE;
        Evento.OF_CQS_Richiesta_Danni__c = FALSE;
        Evento.OF_CQS_Inadempienze_Operative__c = FALSE;
        Evento.OF_CQS_ev_Segnalazione_Comune__c= True;
        Evento.OF_CQS_Comune_Text__c  = 'Test';
        evento.CQS_Ev_Progetto__c = pro.Id;
        insert Evento;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=cqs.id;
        insert attach;
        
        Progetto_Utente_junction__c jun = new Progetto_Utente_junction__c();
        jun.CQS_junc_progetto__c = pro.Id;
        insert jun;
        
        OF_ElencoComuniItaliani__c eleno = new OF_ElencoComuniItaliani__c();
        eleno.OF_Provincia__c = 'Test';
        eleno.OF_Comune__c = 'Test';
        eleno.OF_CodiceIstat__c = 'Test';
        insert eleno;
        
        CQS_Prog_An_junc__c prog = new CQS_Prog_An_junc__c();
        prog.CQS_Praj_Progetto__c = pro.Id;
        //prog.CQS_Praju_LDO__c= pro.CQS_Pro_LDO__c;
        prog.CQS_Paj_Email_Affidataria__c='test@test.it';
        prog.CQS_Praj_Ragione_Sociale__c=ana.id;
        insert prog;
        
        
        /*Test.startTest();
        PageReference myVfPage = Page.CQS_Isp_2018_06_Sicurezza;
        //myVfPage.getParameters().put('id',cqs.id);
        myVfPage.getParameters().put('param2','TestContact123');
        Test.setCurrentPage(myVfPage); 
        
        String id = ApexPages.currentPage().getParameters().get('id');
        Test.stopTest();*/
        
        PageReference pageRef = Page.PO_SearchRequest;
        Test.setCurrentPage(pageRef);
        
        ApexPages.CurrentPage().getParameters().put('sez1q','true');
        ApexPages.CurrentPage().getParameters().put('sez2q','true');
        ApexPages.CurrentPage().getParameters().put('sez3q','true');
        ApexPages.CurrentPage().getParameters().put('sez4q','true');
        ApexPages.CurrentPage().getParameters().put('sez5q','true');
        ApexPages.CurrentPage().getParameters().put('sez6q','true');
        ApexPages.CurrentPage().getParameters().put('sez7q','true');
        ApexPages.CurrentPage().getParameters().put('sez8q','true');
        ApexPages.CurrentPage().getParameters().put('sez9q','true');
        ApexPages.CurrentPage().getParameters().put('sez10q','true');
        ApexPages.CurrentPage().getParameters().put('sez11q','true');
        ApexPages.CurrentPage().getParameters().put('sez12q','true');
        ApexPages.CurrentPage().getParameters().put('sez13q','true');
        
        ApexPages.CurrentPage().getParameters().put('ispSicurezza','true');
        ApexPages.currentPage().getParameters().put('optScelta','Ispezione di Qualità');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(cqs);
        Cqs_Ispezione_CustomController isp = new Cqs_Ispezione_CustomController(sc);
        isp.projectName=pro.Name;
     //   isp.ldoMap;
      //  isp.ldoMap.put(pro.id,pro.CQS_Pro_LDO__c);
        
        isp.sez1s = true;
        isp.sez2s = true;
        isp.sez3s = true;
        isp.sez4s = true;
        isp.sez5s = true;
        isp.sez6s = true;
        isp.sez1q = true;
        isp.sez2q = true;
        isp.sez3q = true;
        isp.sez4q = true;
        isp.sez5q = true;
        isp.sez6q = true;
        isp.sez7q = true;
        isp.sez8q = true;
        isp.sez9q = true;
        isp.sez10q = true;
        isp.sez11q = true;
        isp.sez12q = true;
        isp.sez13q = true;
        
        isp.ispList= new List<OF_CQS_Ispezione__c>();
        isp.intList = new List<Integer>();
        isp.emList = new List<String>();
        isp.fieldList = new List<String>();
        isp.iTa='true';
        isp.ispTA='';
        
        //isp.selectedIdComune  = 'Test';
        isp.selectedIdComune=eleno.id;
        isp.projectName = pro.Id;
        isp.searchTerm = 'Test';
        isp.pageName = 'Test';
        isp.parentId = 'Test';
        isp.ispId = 'Test';
        isp.errorMessage='Test';
        isp.iQ = 'Test';
        isp.ispSicurezza = 'Test';
        isp.ispQuality = 'Test';
        isp.jnldo = 'Test';
        isp.Snjun = 'Test';
        isp.scegliTipoIspezione();
        isp.portaVF();
        isp.pagPresel();
        isp.fileUpload();
        isp.salvaIspezione();
        Cqs_Ispezione_CustomController.dateHToString();
        Cqs_Ispezione_CustomController.searchComune('Test');
        isp.optScelta='Ispezione Tema Ambientale';
        isp.pagPresel();
        
       }
       
       public static testMethod void IspezioneMethod1(){
        Id RecordTypeIdeven = [Select id from RecordType where DeveloperName='Ispezione_Sicurezza_2018_06'].id;  
        Id RecordTypeIdeven2 =Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();
           
        OF_CQS_Anagrafica__c ana = new OF_CQS_Anagrafica__c();
        ana.CQS_Check_Affidataria__c = true;
        ana.Name = 'TESTANA';
        insert ana;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.Name = 'Test';
        pro.CQS_Pro_Area__c = 'Test';
        insert pro;
        
       // List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_Accantieramento_conforme__c = 'Sì';
        cqs.CQS_ISP_Progetto__c = pro.Id;
        cqs.OF_CQS_ISP_Comune__c = 'Test';
        cqs.OF_CQS_ISP_Provincia__c = 'Test';
        cqs.RecordTypeId=RecordTypeIdeven;
        insert cqs;
        
        OF_CQS_Evento__c Evento = new OF_CQS_Evento__c();
        Evento.OF_CQS_Impresa_Esecutrice_Eventi__c = ana.Id;
        Evento.OF_CQS_Impresa_Mandataria__c = ana.Id;
        Evento.OF_CQS_Data_Evento__c = system.today();
        Evento.VIA__c = 'ROSSI';
        Evento.OF_CQS_Numero_Civico__c = '3';
        Evento.RecordTypeId = RecordTypeIdeven2;
        Evento.OF_CQS_Diffida__c = FALSE;
        Evento.OF_CQS_Richiesta_Danni__c = FALSE;
        Evento.OF_CQS_Inadempienze_Operative__c = FALSE;
        Evento.OF_CQS_ev_Segnalazione_Comune__c= True;
        Evento.OF_CQS_Comune_Text__c  = 'Test';
        evento.CQS_Ev_Progetto__c = pro.Id;
        insert Evento;
        
        List<Attachment> attachList=new List<Attachment>(); 
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=cqs.id;
        insert attach;
        
        Progetto_Utente_junction__c jun = new Progetto_Utente_junction__c();
        jun.CQS_junc_progetto__c = pro.Id;
        insert jun;
        
        OF_ElencoComuniItaliani__c eleno = new OF_ElencoComuniItaliani__c();
        eleno.OF_Provincia__c = 'Test';
        eleno.OF_Comune__c = 'Test';
        eleno.OF_CodiceIstat__c = 'Test';
        insert eleno;
        
       
        
        PageReference pageRef = Page.CQS_Isp_2018_06_Sicurezza;
        Test.setCurrentPage(pageRef);
        
        ApexPages.CurrentPage().getParameters().put('sez1s','true');
        ApexPages.CurrentPage().getParameters().put('sez2s','true');
        ApexPages.CurrentPage().getParameters().put('sez3s','true');
        ApexPages.CurrentPage().getParameters().put('sez4s','true');
        ApexPages.CurrentPage().getParameters().put('sez5s','true');
        ApexPages.CurrentPage().getParameters().put('sez6s','true');
        ApexPages.CurrentPage().getParameters().put('sez7s','true');
        ApexPages.CurrentPage().getParameters().put('sez8s','true');
        ApexPages.CurrentPage().getParameters().put('sez9s','true');
        ApexPages.CurrentPage().getParameters().put('sez10s','true');
        ApexPages.CurrentPage().getParameters().put('sez11s','true');
        ApexPages.CurrentPage().getParameters().put('sez12s','true');
        ApexPages.CurrentPage().getParameters().put('sez13s','true');
        
        
        
        ApexPages.CurrentPage().getParameters().put('ispQuality','true');
        ApexPages.currentPage().getParameters().put('optScelta','Ispezione di Qualità');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(cqs);
        Cqs_Ispezione_CustomController isp = new Cqs_Ispezione_CustomController(sc);
        
        isp.scegliTipoIspezione();
        isp.portaVF();
        isp.pagPresel();
        
        
       }
    
    
     public static testMethod void IspezioneMethod2(){
        Id RecordTypeIdeven = [Select id from RecordType where DeveloperName='CQS_Isp_Ispezione_Tema_Ambientale'].id; //Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();   
        Id RecordTypeIdeven2 =Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId(); 
         
        OF_CQS_Anagrafica__c ana = new OF_CQS_Anagrafica__c();
        ana.CQS_Check_Affidataria__c = true;
        ana.Name = 'TESTANA';
        insert ana;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.Name = 'Test';
        pro.CQS_Pro_Area__c = 'Test';
        insert pro;
        
       // List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_Accantieramento_conforme__c = 'Sì';
        cqs.CQS_ISP_Progetto__c = pro.Id;
        cqs.OF_CQS_ISP_Comune__c = 'Test';
        cqs.OF_CQS_ISP_Provincia__c = 'Test';
        cqs.RecordtypeId=RecordTypeIdeven;
        insert cqs;
        
        OF_CQS_Evento__c Evento = new OF_CQS_Evento__c();
        Evento.OF_CQS_Impresa_Esecutrice_Eventi__c = ana.Id;
        Evento.OF_CQS_Impresa_Mandataria__c = ana.Id;
        Evento.OF_CQS_Data_Evento__c = system.today();
        Evento.VIA__c = 'ROSSI';
        Evento.OF_CQS_Numero_Civico__c = '3';
        Evento.RecordTypeId = RecordTypeIdeven2;
        Evento.OF_CQS_Diffida__c = FALSE;
        Evento.OF_CQS_Richiesta_Danni__c = FALSE;
        Evento.OF_CQS_Inadempienze_Operative__c = FALSE;
        Evento.OF_CQS_ev_Segnalazione_Comune__c= True;
        Evento.OF_CQS_Comune_Text__c  = 'Test';
        evento.CQS_Ev_Progetto__c = pro.Id;
        insert Evento;
        
        List<Attachment> attachList=new List<Attachment>(); 
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=cqs.id;
        insert attach;
        
        Progetto_Utente_junction__c jun = new Progetto_Utente_junction__c();
        jun.CQS_junc_progetto__c = pro.Id;
        insert jun;
        
        OF_ElencoComuniItaliani__c eleno = new OF_ElencoComuniItaliani__c();
        eleno.OF_Provincia__c = 'Test';
        eleno.OF_Comune__c = 'Test';
        eleno.OF_CodiceIstat__c = 'Test';
        insert eleno;
        
       
        
        PageReference pageRef = Page.CQS_Ispezione_Tema_Ambientale;
        Test.setCurrentPage(pageRef);
        
        ApexPages.CurrentPage().getParameters().put('sez1s','true');
        ApexPages.CurrentPage().getParameters().put('sez2s','true');
        ApexPages.CurrentPage().getParameters().put('sez3s','true');
        ApexPages.CurrentPage().getParameters().put('sez4s','true');
        ApexPages.CurrentPage().getParameters().put('sez5s','true');
        ApexPages.CurrentPage().getParameters().put('sez6s','true');
        ApexPages.CurrentPage().getParameters().put('sez7s','true');
        ApexPages.CurrentPage().getParameters().put('sez8s','true');
        ApexPages.CurrentPage().getParameters().put('sez9s','true');
        ApexPages.CurrentPage().getParameters().put('sez10s','true');
        ApexPages.CurrentPage().getParameters().put('sez11s','true');
        ApexPages.CurrentPage().getParameters().put('sez12s','true');
        ApexPages.CurrentPage().getParameters().put('sez13s','true');
        
        
        
        ApexPages.CurrentPage().getParameters().put('ispTa','true');
        ApexPages.currentPage().getParameters().put('optScelta','Ispezione Tema Ambientale');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(cqs);
        Cqs_Ispezione_CustomController isp = new Cqs_Ispezione_CustomController(sc);
        
        isp.scegliTipoIspezione();
        isp.portaVF();
        isp.pagPresel();
        
        
       }
}
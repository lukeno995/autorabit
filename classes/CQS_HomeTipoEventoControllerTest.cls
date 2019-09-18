@isTest
public class CQS_HomeTipoEventoControllerTest{
    public static testmethod void CQS_HomeTipoEventoControllerMethod(){
     
  /* list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/

    Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();
      
        String selectedIdComune = 'test';
         
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'test';
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.Name = 'test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
       /* OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Provincia__c = 'test';
        ele.OF_Comune__c = selectedIdComune;
        insert ele; */
       
       /* UserRole r = new UserRole();
        r.Name = 'City Manager';
        r.ParentRoleId = r.Id;
        insert r; */
        
        List<UserRole> ur = new List<UserRole>();
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        //UserRole r = [Select id ,ParentRoleId , name from userrole where Name like '%CSE%' LIMIT 1];
       // ur.add(r);
       // insert ur; 
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
       // usr.UserRoleId = r.Id;
        insert usr;
        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        List<OF_CQS_Evento__c> eL = new List<OF_CQS_Evento__c>();
        OF_CQS_Evento__c even = new OF_CQS_Evento__c();
        even.OF_CQS_Impresa_Mandataria__c = anag.Id;
        even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        even.CQS_Ev_Progetto__c = pro.Id;
        even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        even.OF_CQS_Data_Evento__c = System.today();
        even.OF_CQS_Rispetto_Procedura__c = 'Sì';
        even.OF_CQS_Diffida__c  = FALSE;
        even.OF_CQS_Inadempienze_Operative__c = FALSE;
        //even.RecordTypeId = rtId;
        //even.recordtypeid= rtype[0].id;
        even.recordtypeid=RecordTypeIdevent;
        even.OF_CQS_Richiesta_Danni__c  = true;
        even.OF_CQS_Stato_Pratica__c = 'Aperta';
        even.OF_CQS_Comune_Text__c = selectedIdComune ; 
        eL.add(even);
        insert eL;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId = even.id;
        insert attach;
        
        ApexPages.currentPage().getParameters().put('optScelta','Bad Practice');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_Interferenze_a_sottoservizi' ,'test');
        String statoPratica = 'test';
        String searchTerm = 'test';
        Id cmRole = usr.Id;
        
       
        
        ApexPages.StandardController sc = new ApexPages.StandardController(even);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
        
         tevento.file  = attach;
        
        tevento.updateRTEvento(statoPratica);
        tevento.sendToApprove1lv();
        tevento.checkOwnerSameUser();
        tevento.gestioneEvento();
        tevento.getCSE(even);
        tevento.scegliTipoEvento();
        tevento.portaVF();
        tevento.definisciProgettiPl();
        tevento.fileUpload1();
        tevento.fileUpload(attach);
        //tevento.upload();
        tevento.salvaEvento();
        tevento.salvaEventoSuccessivo();
        tevento.ricusaIntegrazione();
        CQS_HomeTipoEvento_cController.searchComune(searchTerm);
       // CQS_HomeTipoEvento_cController.getUserRoleSup(cmRole);
        //tevento.invioMailAperta();
        //tevento.invioMailApertaLieve();
        //tevento.invioMailInserita();
        //tevento.invioMailIntegrata();
        //tevento.invioMailChiusa();
        //tevento.invioMailChiusaLieve();
        tevento.getIndirizziAggiuntivi(eL);
        tevento.getIdAggiuntivi(eL);
    
    }
    
    public static testmethod void CQS_HomeTipoEventoControllerMethod1(){
     
  /* list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/

    //     List<recordType> rtStringList = [select DeveloperName from RecordType where SobjectType = 'OF_CQS_Evento__c' AND Id =: ev.RecordTypeId Limit 1 AND DeveloperName = 'Bad_Practice_Aperta'];
        
    Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();

        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'test';
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        
       /* UserRole r = new UserRole();
        r.Name = 'City Manager';
        r.ParentRoleId = r.Id;
        insert r; */
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        //usr.UserRoleId = r.Id;
        insert usr;
        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        List<OF_CQS_Evento__c> eL = new List<OF_CQS_Evento__c>();
        OF_CQS_Evento__c even = new OF_CQS_Evento__c();
        even.OF_CQS_Impresa_Mandataria__c = anag.Id;
        even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        even.CQS_Ev_Progetto__c = pro.Id;
        even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        even.OF_CQS_Data_Evento__c = System.today();
        even.OF_CQS_Rispetto_Procedura__c = 'Sì';
        even.OF_CQS_Diffida__c  = FALSE;
        even.OF_CQS_Inadempienze_Operative__c = FALSE;
        //even.RecordTypeId = rtId;
        //even.recordtypeid= rtype[0].id;
        even.recordtypeid=RecordTypeIdevent;
        even.OF_CQS_Richiesta_Danni__c  = true;
        even.OF_CQS_Stato_Pratica__c = 'In Lavorazione';
        eL.add(even);
        insert eL;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId = even.id;
        insert attach;
        
        ApexPages.currentPage().getParameters().put('optScelta','Danneggiamento a terzi');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_DanneggiamentoAterzi' ,'test');
        String statoPratica = 'test';
        String searchTerm = 'test';
        
       
        
        ApexPages.StandardController sc = new ApexPages.StandardController(even);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
        
         tevento.file  = attach;
        tevento.ev =eL[0];
        tevento.updateRTEvento(statoPratica);
        tevento.setBooleanStatoPratica();
        tevento.sendToApprove1lv();
        tevento.checkOwnerSameUser();
        tevento.gestioneEvento();
        tevento.getCSE(even);
        tevento.scegliTipoEvento();
        tevento.portaVF();
        tevento.definisciProgettiPl();
        tevento.fileUpload1();
        tevento.fileUpload(attach);
        //tevento.upload();
        tevento.salvaEvento();
        tevento.salvaEventoSuccessivo();
        tevento.ricusaIntegrazione();
        CQS_HomeTipoEvento_cController.searchComune(searchTerm);
        //CQS_HomeTipoEvento_cController.getUserRoleSup(cmRole);
        //tevento.invioMailAperta();
       
       
       // tevento.invioMailApertaLieve();
        //tevento.invioMailInserita();
        //tevento.invioMailIntegrata();
       // tevento.invioMailChiusa();
       // tevento.invioMailChiusaLieve();
        tevento.getIndirizziAggiuntivi(eL);
        tevento.getIdAggiuntivi(eL);
    
    }
    
    public static testmethod void CQS_HomeTipoEventoControllerMethod2(){
     
  /* list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/

    Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();
      
        String selectedIdComune = 'test';
         
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'test';
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
       /* OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Provincia__c = 'test';
        ele.OF_Comune__c = selectedIdComune;
        insert ele; */
       
       /* UserRole r = new UserRole();
        r.Name = 'City Manager';
        r.ParentRoleId = r.Id;
        insert r; */
        
        List<UserRole> ur = new List<UserRole>();
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
      /*  UserRole r = [Select id ,ParentRoleId , name from userrole LIMIT 1];
        ur.add(r);
        insert ur; */
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName=String.valueOf(system.now().gettime())+'@test.org';
        //usr.UserRoleId = r.Id;
        insert usr;
        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        List<OF_CQS_Evento__c> eL = new List<OF_CQS_Evento__c>();
        OF_CQS_Evento__c even = new OF_CQS_Evento__c();
        even.OF_CQS_Impresa_Mandataria__c = anag.Id;
        even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        even.CQS_Ev_Progetto__c = pro.Id;
        even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        even.OF_CQS_Data_Evento__c = System.today();
        even.OF_CQS_Rispetto_Procedura__c = 'Sì';
        even.OF_CQS_Diffida__c  = FALSE;
        even.OF_CQS_Inadempienze_Operative__c = FALSE;
        //even.RecordTypeId = rtId;
        //even.recordtypeid= rtype[0].id;
        even.recordtypeid=RecordTypeIdevent;
        even.OF_CQS_Richiesta_Danni__c  = true;
        even.OF_CQS_Stato_Pratica__c = 'Integrata/In Approvazione';
        even.OF_CQS_Comune_Text__c = selectedIdComune ; 
        eL.add(even);
        insert eL;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId = even.id;
        insert attach;
        
        ApexPages.currentPage().getParameters().put('optScelta','Interferenza a sottoservizi');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_Interferenze_a_sottoservizi' ,'test');
        String statoPratica = 'test';
        String searchTerm = 'test';
        Id cmRole = usr.Id;
        
       
        
        ApexPages.StandardController sc = new ApexPages.StandardController(even);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
        
         tevento.file  = attach;
        
        tevento.updateRTEvento(statoPratica);
        tevento.setBooleanStatoPratica();
        tevento.sendToApprove1lv();
        tevento.checkOwnerSameUser();
        tevento.gestioneEvento();
        tevento.getCSE(even);
        tevento.scegliTipoEvento();
        tevento.portaVF();
        tevento.definisciProgettiPl();
        tevento.fileUpload1();
        tevento.fileUpload(attach);
        //tevento.upload();
        tevento.salvaEvento();
       // tevento.salvaEventoSuccessivo();
        tevento.ricusaIntegrazione();
        CQS_HomeTipoEvento_cController.searchComune(searchTerm);
       // CQS_HomeTipoEvento_cController.getUserRoleSup(cmRole);
        //tevento.invioMailAperta();
        //tevento.invioMailApertaLieve();
        //tevento.invioMailInserita();
        //tevento.invioMailIntegrata();
        //tevento.invioMailChiusa();
        //tevento.invioMailChiusaLieve();
        tevento.getIndirizziAggiuntivi(eL);
        tevento.getIdAggiuntivi(eL);
    
    }
    
    
  public static testmethod void CQS_HomeTipoEventoControllerMethod3(){
     
  /* list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/

    Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();

        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'test';
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        
       /* UserRole r = new UserRole();
        r.Name = 'City Manager';
        r.ParentRoleId = r.Id;
        insert r; */
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName=String.Valueof(system.now()).remove(':').remove('-').remove(' ') +'standarduser5@testorg.com';
        //usr.UserRoleId = r.Id;
        insert usr;
        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        List<OF_CQS_Evento__c> eL = new List<OF_CQS_Evento__c>();
        OF_CQS_Evento__c even = new OF_CQS_Evento__c();
        even.OF_CQS_Impresa_Mandataria__c = anag.Id;
        even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        even.CQS_Ev_Progetto__c = pro.Id;
        even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        even.OF_CQS_Data_Evento__c = System.today();
        even.OF_CQS_Rispetto_Procedura__c = 'Sì';
        even.OF_CQS_Diffida__c  = FALSE;
        even.OF_CQS_Inadempienze_Operative__c = FALSE;
        //even.RecordTypeId = rtId;
        //even.recordtypeid= rtype[0].id;
        even.recordtypeid=RecordTypeIdevent;
        even.OF_CQS_Richiesta_Danni__c  = true;
        even.OF_CQS_Stato_Pratica__c = 'Chiuso';
        eL.add(even);
        insert eL;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId = even.id;
        insert attach;
        
        ApexPages.currentPage().getParameters().put('optScelta','Bad Practice');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_Evento' ,'test');
        String statoPratica = 'test';
        String searchTerm = 'test';
        
       
        
        ApexPages.StandardController sc = new ApexPages.StandardController(even);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
        
         tevento.file  = attach;
        
        tevento.updateRTEvento(statoPratica);
        tevento.setBooleanStatoPratica();
        tevento.sendToApprove1lv();
        tevento.checkOwnerSameUser();
        tevento.gestioneEvento();
        tevento.getCSE(even);
        tevento.scegliTipoEvento();
        tevento.portaVF();
        tevento.definisciProgettiPl();
        tevento.fileUpload1();
        tevento.fileUpload(attach);
        //tevento.upload();
        tevento.salvaEvento();
       // tevento.salvaEventoSuccessivo();
        tevento.ricusaIntegrazione();
        CQS_HomeTipoEvento_cController.searchComune(searchTerm);
        //CQS_HomeTipoEvento_cController.getUserRoleSup(cmRole);
       // tevento.invioMailAperta();
       
       
       // tevento.invioMailApertaLieve();
       // tevento.invioMailInserita();
       // tevento.invioMailIntegrata();
       // tevento.invioMailChiusa();
       // tevento.invioMailChiusaLieve();
        tevento.getIndirizziAggiuntivi(eL);
        tevento.getIdAggiuntivi(eL);
    
    }
    
    public static testmethod void CQS_HomeTipoEventoControllerMethod4(){
     
  /* list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/

    Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Danneggiamento a Terzi').getRecordTypeId();

       UserRole ur4 = new UserRole();
        ur4.Name = 'RE';
        insert ur4;
        UserRole ur3 = new UserRole();
        ur3.Name = 'HSE';
        ur3.ParentRoleId = ur4.Id;
        insert ur3;
        UserRole r2 = new UserRole();
        r2.Name = 'Area Manager';
        r2.ParentRoleId = ur3.Id;
        insert r2;
        UserRole r = new UserRole();
        r.Name = 'City Manager Centro';
        r.ParentRoleId = r2.Id;
        insert r; 
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
       // UserRole r= [select id, ParentRoleId from UserRole where Name='City Manager Centro' LIMIT 1];
        User usr4 = new User();
        usr4.Alias = 'standt';
        usr4.Email='standarduser@testorg.com';
        usr4.EmailEncodingKey='UTF-8';
        usr4.LastName='Testing';
        usr4.LanguageLocaleKey='en_US'; 
        usr4.LocaleSidKey='en_US';
        usr4.ProfileId = profileId.id;
        usr4.TimeZoneSidKey='America/Los_Angeles';
        usr4.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr4.UserRoleId = ur4.id;
        insert usr4;
        User usr3 = new User();
        usr3.Alias = 'standt';
        usr3.Email='standarduser@testorg.com';
        usr3.EmailEncodingKey='UTF-8';
        usr3.LastName='Testing';
        usr3.LanguageLocaleKey='en_US'; 
        usr3.LocaleSidKey='en_US';
        usr3.ProfileId = profileId.id;
        usr3.TimeZoneSidKey='America/Los_Angeles';
        usr3.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr3.UserRoleId = ur3.id;
        insert usr3;
        User usr2 = new User();
        usr2.Alias = 'standt';
        usr2.Email='standarduser@testorg.com';
        usr2.EmailEncodingKey='UTF-8';
        usr2.LastName='Testing';
        usr2.LanguageLocaleKey='en_US'; 
        usr2.LocaleSidKey='en_US';
        usr2.ProfileId = profileId.id;
        usr2.TimeZoneSidKey='America/Los_Angeles';
        usr2.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr2.UserRoleId = r2.id;
        insert usr2;
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr.UserRoleId = r.id;
        insert usr;
        system.runAs(usr){
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.OF_CQS_Indirizzo_Email__c = 'test@gmail.com';
        anag.Name = 'AMTECO';
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        List<OF_CQS_Evento__c> eL = new List<OF_CQS_Evento__c>();
        OF_CQS_Evento__c even = new OF_CQS_Evento__c();
        even.OF_CQS_Impresa_Mandataria__c = anag.Id;
        even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        even.CQS_Ev_Progetto__c = pro.Id;
        even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        even.OF_CQS_Data_Evento__c = System.today();
        even.OF_CQS_Rispetto_Procedura__c = 'Sì';
        even.OF_CQS_Diffida__c  = FALSE;
        even.OF_CQS_Inadempienze_Operative__c = FALSE;
        even.CQS_Indice_Gravita_Taglio_Danneggiamento__c='A - Alta';
        even.OwnerId = usr.id;
        //even.RecordTypeId = rtId;
        //even.recordtypeid= rtype[0].id;
        even.recordtypeid=RecordTypeIdevent;
        even.OF_CQS_Richiesta_Danni__c  = true;
        even.OF_CQS_Stato_Pratica__c = 'Inserita';
        eL.add(even);
        insert eL;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId = even.id;
        insert attach;
        
        CQS_Prog_An_junc__c prog = new CQS_Prog_An_junc__c();
        prog.CQS_Praj_Progetto__c = pro.Id;
        prog.CQS_Praj_Ragione_Sociale__c = anag.Id;
        prog.CQS_Paj_Email_Affidataria__c= 'test@test.it';
        insert prog;
        
        ApexPages.currentPage().getParameters().put('optScelta','Danneggiamento a Terzi');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_DanneggiamentoAterzi' ,'test');
        String statoPratica = 'test';
        String searchTerm = 'test';
        
       
        
        ApexPages.StandardController sc = new ApexPages.StandardController(eL[0]);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
        
         tevento.file  = attach;
         tevento.ev = eL[0];
         tevento.parentId  = 'test';
         tevento.pageName = 'test';
         tevento.jPu = projen;
         tevento.evId = 'test';
         tevento.errorMessage = 'test';
         tevento.nameFile1 = 'test';
         tevento.nameFile2 = 'test';
         tevento.nameFile3 = 'test';
         tevento.nameFile4 = 'test';
         tevento.nameFile5 = 'test';
         //tevento.allegato = 
         tevento.selectedType = 'test';
         tevento.description = 'test';
         tevento.fileBody = attach.body;
         tevento.fileName = 'test';
         List<blob> blList=new List<Blob>();
         blList.add(blob.valueof('sadghsakhdkja'));
         tevento.blobList = blList;
         
        
       /* tevento.updateRTEvento(statoPratica);
        tevento.setBooleanStatoPratica();
        tevento.sendToApprove1lv();
        tevento.checkOwnerSameUser();
       // tevento.changeOwner(statoPratica);
        tevento.gestioneEvento();
        tevento.getCSE(even);
        tevento.scegliTipoEvento();
        tevento.portaVF();
        tevento.definisciProgettiPl();
        tevento.fileUpload1();
        tevento.fileUpload(attach);
        //tevento.upload();
        tevento.salvaEvento();
        tevento.salvaEventoSuccessivo();
        tevento.ricusaIntegrazione();
        CQS_HomeTipoEvento_cController.searchComune(searchTerm);
        //CQS_HomeTipoEvento_cController.getUserRoleSup(cmRole);
        
        */
        tevento.invioMailChiusa();
        //tevento.invioMailChiusaLieve();
        //tevento.invioMailInserita();
        tevento.inviomailInserita('inserita');
        tevento.invioMailAperta();
       //tevento.invioMailApertaLieve();
      // tevento.invioMailApertaLieve('aperta');
        tevento.invioMailIntegrata();
        
       // tevento.getIndirizziAggiuntivi(eL);
       // tevento.getIdAggiuntivi(eL);
    
    }
    }
    
    
     public static testmethod void CQS_HomeTipoEventoControllerMethod5(){
     
  /* list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/

    Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Danneggiamento a Terzi').getRecordTypeId();

       UserRole ur4 = new UserRole();
        ur4.Name = 'RE';
        insert ur4;
        UserRole ur3 = new UserRole();
        ur3.Name = 'HSE';
        ur3.ParentRoleId = ur4.Id;
        insert ur3;
        UserRole r2 = new UserRole();
        r2.Name = 'Area Manager';
        r2.ParentRoleId = ur3.Id;
        insert r2;
        UserRole r = new UserRole();
        r.Name = 'City Manager Centro';
        r.ParentRoleId = r2.Id;
        insert r; 
        UserRole ur5 = new UserRole();
        ur5.Name = 'CSE';
        insert ur5;
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
       // UserRole r= [select id, ParentRoleId from UserRole where Name='City Manager Centro' LIMIT 1];
        User usr5 = new User();
        usr5.Alias = 'standt';
        usr5.Email='standarduser@testorg.com';
        usr5.EmailEncodingKey='UTF-8';
        usr5.LastName='Testing';
        usr5.LanguageLocaleKey='en_US'; 
        usr5.LocaleSidKey='en_US';
        usr5.ProfileId = profileId.id;
        usr5.TimeZoneSidKey='America/Los_Angeles';
        usr5.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr5.UserRoleId = ur5.id;
        insert usr5;
         
        User usr4 = new User();
        usr4.Alias = 'standt';
        usr4.Email='standarduser@testorg.com';
        usr4.EmailEncodingKey='UTF-8';
        usr4.LastName='Testing';
        usr4.LanguageLocaleKey='en_US'; 
        usr4.LocaleSidKey='en_US';
        usr4.ProfileId = profileId.id;
        usr4.TimeZoneSidKey='America/Los_Angeles';
        usr4.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr4.UserRoleId = ur4.id;
        insert usr4;
        User usr3 = new User();
        usr3.Alias = 'standt';
        usr3.Email='standarduser@testorg.com';
        usr3.EmailEncodingKey='UTF-8';
        usr3.LastName='Testing';
        usr3.LanguageLocaleKey='en_US'; 
        usr3.LocaleSidKey='en_US';
        usr3.ProfileId = profileId.id;
        usr3.TimeZoneSidKey='America/Los_Angeles';
        usr3.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr3.UserRoleId = ur3.id;
        insert usr3;
        User usr2 = new User();
        usr2.Alias = 'standt';
        usr2.Email='standarduser@testorg.com';
        usr2.EmailEncodingKey='UTF-8';
        usr2.LastName='Testing';
        usr2.LanguageLocaleKey='en_US'; 
        usr2.LocaleSidKey='en_US';
        usr2.ProfileId = profileId.id;
        usr2.TimeZoneSidKey='America/Los_Angeles';
        usr2.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr2.UserRoleId = r2.id;
        insert usr2;
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr.UserRoleId = r.id;
        insert usr;
        system.runAs(usr){
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.OF_CQS_Indirizzo_Email__c = 'test@gmail.com';
        anag.Name = 'AMTECO';
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        Progetto_Utente_junction__c projen2 = new Progetto_Utente_junction__c();
        projen2.CQS_junc_progetto__c = pro.Id;
        projen2.CQS_junc_user__c = usr5.id;
        insert projen2;

        CQS_Prog_An_junc__c progAn = new CQS_Prog_An_junc__c();
        progAn.CQS_Praj_Progetto__c = pro.Id;
        progAn.CQS_Praj_Ragione_Sociale__c = anag.Id;
        progAn.CQS_Paj_Email_Affidataria__c= 'test@test.it';
        insert progAn;
            
        List<OF_CQS_Evento__c> eL = new List<OF_CQS_Evento__c>();
        OF_CQS_Evento__c even = new OF_CQS_Evento__c();
        even.OF_CQS_Impresa_Mandataria__c = anag.Id;
        even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        even.CQS_Ev_Progetto__c = pro.Id;
        even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        even.OF_CQS_Data_Evento__c = System.today();
        even.OF_CQS_Rispetto_Procedura__c = 'Sì';
        even.OF_CQS_Diffida__c  = FALSE;
        even.OF_CQS_Inadempienze_Operative__c = FALSE;
        even.CQS_Indice_Gravita_Taglio_Danneggiamento__c='L - Lieve';
        even.OwnerId = usr.id;
        //even.RecordTypeId = rtId;
        //even.recordtypeid= rtype[0].id;
        even.recordtypeid=RecordTypeIdevent;
        even.OF_CQS_Richiesta_Danni__c  = true;
        even.OF_CQS_Stato_Pratica__c = 'Inserita';
        eL.add(even);
        insert eL;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId = even.id;
        insert attach;
        
        CQS_Prog_An_junc__c prog = new CQS_Prog_An_junc__c();
        prog.CQS_Praj_Progetto__c = pro.Id;
        prog.CQS_Praj_Ragione_Sociale__c = anag.Id;
        insert prog;
        
        ApexPages.currentPage().getParameters().put('optScelta','Danneggiamento a Terzi');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_DanneggiamentoAterzi' ,'test');
        String statoPratica = 'test';
        String searchTerm = 'test';
        
       
        
        ApexPages.StandardController sc = new ApexPages.StandardController(eL[0]);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
        
         tevento.file  = attach;
         tevento.ev = eL[0];
         tevento.parentId  = 'test';
         tevento.pageName = 'test';
         tevento.jPu = projen;
         tevento.evId = 'test';
         tevento.errorMessage = 'test';
         tevento.nameFile1 = 'test';
         tevento.nameFile2 = 'test';
         tevento.nameFile3 = 'test';
         tevento.nameFile4 = 'test';
         tevento.nameFile5 = 'test';
         //tevento.allegato = 
         tevento.selectedType = 'test';
         tevento.description = 'test';
         tevento.fileBody = attach.body;
         tevento.fileName = 'test';
         List<blob> blList=new List<Blob>();
         blList.add(blob.valueof('sadghsakhdkja'));
         tevento.blobList = blList;
         
        
       /* tevento.updateRTEvento(statoPratica);
        tevento.setBooleanStatoPratica();
        tevento.sendToApprove1lv();
        tevento.checkOwnerSameUser();
       // tevento.changeOwner(statoPratica);
        tevento.gestioneEvento();
        tevento.getCSE(even);
        tevento.scegliTipoEvento();
        tevento.portaVF();
        tevento.definisciProgettiPl();
        tevento.fileUpload1();
        tevento.fileUpload(attach);
        //tevento.upload();
        tevento.salvaEvento();
        tevento.salvaEventoSuccessivo();
        tevento.ricusaIntegrazione();
        CQS_HomeTipoEvento_cController.searchComune(searchTerm);
        //CQS_HomeTipoEvento_cController.getUserRoleSup(cmRole);
        
        */
        //tevento.invioMailChiusa();
        tevento.invioMailChiusaLieve();
      //  tevento.invioMailInserita();
        tevento.inviomailInserita('inserita');
       // tevento.invioMailAperta();
        //tevento.invioMailApertaLieve();
      	tevento.invioMailApertaLieve('aperta');
        tevento.invioMailIntegrata();
        
        tevento.changeOwner('Aperta');
       // tevento.getIndirizziAggiuntivi(eL);
       // tevento.getIdAggiuntivi(eL);
    
    }
    }
    
    public static testmethod void CQS_HomeTipoEventoControllerMethod6(){
        
        Map<String,id> rtMap= new Map<String,Id>();
        for(Recordtype rt: [select id, DeveloperName from recordType]){
            rtMap.put(rt.DeveloperName,rt.id);
        }
         UserRole ur4 = new UserRole();
        ur4.Name = 'RE';
        insert ur4;
        UserRole ur3 = new UserRole();
        ur3.Name = 'HSE';
        ur3.ParentRoleId = ur4.Id;
        insert ur3;
        UserRole r2 = new UserRole();
        r2.Name = 'Area Manager';
        r2.ParentRoleId = ur3.Id;
        insert r2;
        UserRole r = new UserRole();
        r.Name = 'City Manager Centro';
        r.ParentRoleId = r2.Id;
        insert r; 
        UserRole ur5 = new UserRole();
        ur5.Name = 'CSE';
        insert ur5;
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
       // UserRole r= [select id, ParentRoleId from UserRole where Name='City Manager Centro' LIMIT 1];
        User usr5 = new User();
        usr5.Alias = 'standt';
        usr5.Email='standarduser@testorg.com';
        usr5.EmailEncodingKey='UTF-8';
        usr5.LastName='Testing';
        usr5.LanguageLocaleKey='en_US'; 
        usr5.LocaleSidKey='en_US';
        usr5.ProfileId = profileId.id;
        usr5.TimeZoneSidKey='America/Los_Angeles';
        usr5.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr5.UserRoleId = ur5.id;
        insert usr5;
         
        User usr4 = new User();
        usr4.Alias = 'standt';
        usr4.Email='standarduser@testorg.com';
        usr4.EmailEncodingKey='UTF-8';
        usr4.LastName='Testing';
        usr4.LanguageLocaleKey='en_US'; 
        usr4.LocaleSidKey='en_US';
        usr4.ProfileId = profileId.id;
        usr4.TimeZoneSidKey='America/Los_Angeles';
        usr4.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr4.UserRoleId = ur4.id;
        insert usr4;
        User usr3 = new User();
        usr3.Alias = 'standt';
        usr3.Email='standarduser@testorg.com';
        usr3.EmailEncodingKey='UTF-8';
        usr3.LastName='Testing';
        usr3.LanguageLocaleKey='en_US'; 
        usr3.LocaleSidKey='en_US';
        usr3.ProfileId = profileId.id;
        usr3.TimeZoneSidKey='America/Los_Angeles';
        usr3.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr3.UserRoleId = ur3.id;
        insert usr3;
        User usr2 = new User();
        usr2.Alias = 'standt';
        usr2.Email='standarduser@testorg.com';
        usr2.EmailEncodingKey='UTF-8';
        usr2.LastName='Testing';
        usr2.LanguageLocaleKey='en_US'; 
        usr2.LocaleSidKey='en_US';
        usr2.ProfileId = profileId.id;
        usr2.TimeZoneSidKey='America/Los_Angeles';
        usr2.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr2.UserRoleId = r2.id;
        insert usr2;
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
        usr.UserRoleId = r.id;
        insert usr;
        system.runAs(usr){
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.OF_CQS_Indirizzo_Email__c = 'test@gmail.com';
        anag.Name = 'AMTECO';
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.name='Test - Lotto Test';
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        Progetto_Utente_junction__c projen2 = new Progetto_Utente_junction__c();
        projen2.CQS_junc_progetto__c = pro.Id;
        projen2.CQS_junc_user__c = usr5.id;
        insert projen2;

        CQS_Prog_An_junc__c progAn = new CQS_Prog_An_junc__c();
        progAn.CQS_Praj_Progetto__c = pro.Id;
        progAn.CQS_Praj_Ragione_Sociale__c = anag.Id;
        progAn.CQS_Paj_Email_Affidataria__c= 'test@test.it';
        insert progAn;
            
        List<OF_CQS_Evento__c> eL = new List<OF_CQS_Evento__c>();
        OF_CQS_Evento__c even = new OF_CQS_Evento__c();
        even.OF_CQS_Impresa_Mandataria__c = anag.Id;
        even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        even.CQS_Ev_Progetto__c = pro.Id;
        even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        even.OF_CQS_Data_Evento__c = System.today();
        even.OF_CQS_Rispetto_Procedura__c = 'Sì';
        even.OF_CQS_Diffida__c  = FALSE;
        even.OF_CQS_Inadempienze_Operative__c = FALSE;
        even.CQS_Indice_Gravita_Taglio_Danneggiamento__c='L - Lieve';
        even.OwnerId = usr.id;
        even.RecordTypeId =rtMap.get('OF_CQS_Danni_Arrecati');//[select id from recordtype where developerName='OF_CQS_Danni_Arrecati'].id;
        //even.recordtypeid= rtype[0].id;
        //even.recordtypeid=[select id from recordtype where developerName='OF_CQS_Danni_Arrecati'].id;
        even.OF_CQS_Richiesta_Danni__c  = true;
        even.OF_CQS_Stato_Pratica__c = 'Aperta';
        eL.add(even);
        insert eL;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId = even.id;
        insert attach;
        
        CQS_Prog_An_junc__c prog = new CQS_Prog_An_junc__c();
        prog.CQS_Praj_Progetto__c = pro.Id;
        prog.CQS_Praj_Ragione_Sociale__c = anag.Id;
        insert prog;
        
        ApexPages.currentPage().getParameters().put('optScelta','Danneggiamento a Terzi');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_DanneggiamentoAterzi' ,'test');
        String statoPratica = 'test';
        String searchTerm = 'test';
        
       
        
        ApexPages.StandardController sc = new ApexPages.StandardController(eL[0]);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
       
        test.startTest();
        tevento.projectName=pro.Name;   
        tevento.statoPratica='Aperta';
        tevento.intList = new List<Integer>();
        tevento.emList = new List<String>();
        
            
       // tevento.stringaRT='OF_CQS_Danni_Arrecati';
        tevento.updateRTEvento('OF_CQS_Danni_Arrecati');
        tevento.ricusaIntegrazione();
            
        even.RecordTypeId=rtMap.get('Danneggiamento_a_Terzi_Aperta');
        even.OF_CQS_Stato_Pratica__c='In Lavorazione';   
        tevento.updateRTEvento('Danneggiamento_a_Terzi_Aperta');   
        tevento.ricusaIntegrazione();
            
        even.recordtypeid=rtMap.get('OF_CQS_Interferenza_Sottoservizi');
        even.OF_CQS_Stato_Pratica__c='Aperta';   
        tevento.updateRTEvento('OF_CQS_Interferenza_Sottoservizi');
        tevento.ricusaIntegrazione();
            
        even.recordtypeid=rtMap.get('Interferenza_a_Sotto_servizi_Aperta');
        even.OF_CQS_Stato_Pratica__c='In Lavorazione';   
        tevento.updateRTEvento('Interferenza_a_Sotto_servizi_Aperta');
        tevento.ricusaIntegrazione(); 
            
        even.RecordTypeId=rtMap.get('OF_CQS_Bad_Practice');
        even.OF_CQS_Stato_Pratica__c='Aperta';   
        tevento.updateRTEvento('OF_CQS_Bad_Practice');
        tevento.ricusaIntegrazione();
            
        even.recordtypeid=rtMap.get('Bad_Practice_Aperta');
        even.OF_CQS_Stato_Pratica__c='In Lavorazione';   
        tevento.updateRTEvento('Bad_Practice_Aperta');
        tevento.ricusaIntegrazione();
            
        even.recordtypeid=rtMap.get('Bad_Practice_Integrata');
        even.OF_CQS_Stato_Pratica__c='Integrata/In Approvazione';   
        tevento.updateRTEvento('Bad_Practice_Integrata'); 
        tevento.ricusaIntegrazione();
            
        even.recordtypeid=rtMap.get('Bad_Practice_in_Lavorazione');
        even.OF_CQS_Stato_Pratica__c='Integrata/In Approvazione';   
        tevento.updateRTEvento('Bad_Practice_in_Lavorazione');
        tevento.ricusaIntegrazione();    
            //Bad_Practice_Chiusa
          
            //Bad_Practice_in_Lavorazione
        
        tevento.changeOwner('Aperta');
        tevento.changeOwner('In Lavorazione');
        tevento.changeOwner('Integrata/In Approvazione');
		tevento.changeOwner('Chiuso');
            
        tevento.getCM(even);
         
        
        test.stopTest();
    }

    }
}
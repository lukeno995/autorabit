@isTest
public class CQS_Isp2L_AdempimentiCntrlTEST {
       public static testMethod void IspezioneMethod1(){
        Ispezione_II_Livello__c isp2L = new Ispezione_II_Livello__c();
           insert isp2L;
        ApexPages.StandardController sc = new ApexPages.StandardController(isp2L);
        CQS_Isp2L_AdempimentiController ispSC = new CQS_Isp2L_AdempimentiController(sc);
           
        ispSC.isp2Lid=isp2L.id;
        
        
        List<SelectOption> optList = new  List<SelectOption>();
        List<SelectOption> optListaComuni = new  List<SelectOption>();
        List<SelectOption> optListaRegioni = new  List<SelectOption>();
        List<String> tipiIspezione = new  List<String>();
     //   String ispSC.optScelta= 'Verifica Rispetto Adempimenti Contrattuali Societa di Servizio';
        
        String roleNameIsp2LNord='Ispettore_II_Livello_Nord';
        String roleNameIsp2LCS='Ispettore_II_Livello_Centro_Sud';
        String roleNameVuoto='';
           
        User usrAtt=[Select id, UserRoleId, ProfileId, Name, LastName from User where Id=:userinfo.getUserId() LIMIT 1];
        
        OF_ElencoComuniItaliani__c eCi = new OF_ElencoComuniItaliani__c();
        eci.OF_Regione__c= 'Piemonte';
        eci.OF_Provincia__c='Alessandria';
        eci.OF_Comune__c='Alessandria'; 
        eci.OF_CodiceIstat__c='00000001';
        insert eci;
        String optSceltaRegione='Piemonte';
       // optSceltaRegione= String (optListaRegioni[0]);
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'test';
        insert anag;
        String ragSocialeImpresa = anag.Name;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.Name = 'optSceltaComune Lotto 1';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        pro.CQS_Pro_LDO__c='Test';
        pro.CQS_Pro_Comune__c=eci.OF_Comune__c;
        insert pro;
        String ldoStr= pro.CQS_Pro_LDO__c;
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'CQS_Ispettore_II_Livello' LIMIT 1];
        
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
        projen.CQS_junc_progetto__c= pro.id;
        //projen.CQS_junc_progetto__r.Name= pro.Name;
        insert projen;
           
        CQS_Prog_An_junc__c jnt = new CQS_Prog_An_junc__c();
        jnt.CQS_Praj_Progetto__c = pro.id;
        jnt.CQS_Praj_Ragione_Sociale__c = anag.Id ;
        //jnt.CQS_Praj_Progetto__r.CQS_Pro_Comune__c = optSceltaComune; 
        insert jnt;
         
        List<SelectOption> optListaProgetti = new List<SelectOption>();
        optListaProgetti.add(new SelectOption(projen.CQS_junc_progetto__c,pro.Name)); 
        Map<String,String> ldoMap = new Map<String, String>();
        Map<String,String> rsocial = new Map<String, String>();
        Map<String,String> regMap = new Map<String, String>();
         
        ldoMap.put(pro.id,pro.CQS_Pro_LDO__c);
        regMap.put(pro.id,anag.id);   
       // 
       String searchTerm = 'test';
        
        PageReference pageRef = Page.CQS_Isp2L_AdempimentiSS;
        
        Test.setCurrentPage(pageRef);
        
        ApexPages.CurrentPage().getParameters().put('shortOpt','SocServ');
        ApexPages.CurrentPage().getParameters().put('Prov','Alessandria');
        ApexPages.CurrentPage().getParameters().put('roleName',roleNameIsp2LNord);
        ApexPages.CurrentPage().getParameters().put('optSceltaRegione','Piemonte');
        
       
        test.startTest();
        CQS_Isp2L_AdempimentiController.searchComune(searchTerm);
        ispSC.salvaIspezione();
        ispSC.backToSel();
       	ispSC.definisciProgettiPl();
        ispSC.defineLDO();
     //   ispSC.pagPresel();
        test.stopTest();
        
        
    }
    
       public static testMethod void IspezioneMethod2(){
        Ispezione_II_Livello__c isp2L = new Ispezione_II_Livello__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(isp2L);
        CQS_Isp2L_AdempimentiController ispSC = new CQS_Isp2L_AdempimentiController(sc);
          
        List<SelectOption> optList = new  List<SelectOption>();
        List<SelectOption> optListaComuni = new  List<SelectOption>();
        List<SelectOption> optListaRegioni = new  List<SelectOption>();
        List<String> tipiIspezione = new  List<String>();
     //   String ispSC.optScelta= 'Verifica Rispetto Adempimenti Contrattuali Societa di Servizio';
        
        String roleNameIsp2LNord='Ispettore_II_Livello_Nord';
        String roleNameIsp2LCS='Ispettore_II_Livello_Centro_Sud';
        String roleNameVuoto='';
           
        User usrAtt=[Select id, UserRoleId, ProfileId, Name, LastName from User where Id=:userinfo.getUserId() LIMIT 1];
        
        OF_ElencoComuniItaliani__c eCi = new OF_ElencoComuniItaliani__c();
        eci.OF_Regione__c= 'Piemonte';
        eci.OF_Provincia__c='Alessandria';
        eci.OF_Comune__c='Alessandria'; 
        eci.OF_CodiceIstat__c='00000001';
        insert eci;
        String optSceltaRegione='Piemonte';
           
        ispSC.selectedIdComune= eci.id;
       // optSceltaRegione= String (optListaRegioni[0]);
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'test';
        insert anag;
        String ragSocialeImpresa = anag.Name;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.Name = 'optSceltaComune Lotto 1';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        pro.CQS_Pro_LDO__c='Test';
        pro.CQS_Pro_Comune__c=eci.OF_Comune__c;
        insert pro;
        String ldoStr= pro.CQS_Pro_LDO__c;
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'CQS_Ispettore_II_Livello' LIMIT 1];
        
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
        projen.CQS_junc_progetto__c= pro.id;
        //projen.CQS_junc_progetto__r.Name= pro.Name;
        insert projen;
           
        CQS_Prog_An_junc__c jnt = new CQS_Prog_An_junc__c();
        jnt.CQS_Praj_Progetto__c = pro.id;
        jnt.CQS_Praj_Ragione_Sociale__c = anag.Id ;
        //jnt.CQS_Praj_Progetto__r.CQS_Pro_Comune__c = optSceltaComune; 
        insert jnt;
         
        List<SelectOption> optListaProgetti = new List<SelectOption>();
        optListaProgetti.add(new SelectOption(projen.CQS_junc_progetto__c,pro.Name)); 
        Map<String,String> ldoMap = new Map<String, String>();
        Map<String,String> rsocial = new Map<String, String>();
        Map<String,String> regMap = new Map<String, String>();
         
        ldoMap.put(pro.id,pro.CQS_Pro_LDO__c);
        regMap.put(pro.id,anag.id);   
       // 
       String searchTerm = 'test';
        
        PageReference pageRef = Page.CQS_Isp2L_AdempimentiSS;
        
        Test.setCurrentPage(pageRef);
        
        ApexPages.CurrentPage().getParameters().put('shortOpt','SocServ');
        ApexPages.CurrentPage().getParameters().put('Prov','Alessandria');
        ApexPages.CurrentPage().getParameters().put('roleName',roleNameIsp2LNord);
        ApexPages.CurrentPage().getParameters().put('optSceltaRegione','Piemonte');
        
       
        test.startTest();
        CQS_Isp2L_AdempimentiController.searchComune(searchTerm);
        ispSC.salvaIspezione();
        ispSC.backToSel();
       	ispSC.definisciProgettiPl();
        ispSC.defineLDO();
     //   ispSC.pagPresel();
        test.stopTest();
      }
    
       public static testMethod void IspezioneMethod3(){
           
        Ispezione_II_Livello__c isp2L = new Ispezione_II_Livello__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(isp2L);
        CQS_Isp2L_AdempimentiController ispSC = new CQS_Isp2L_AdempimentiController(sc);
           
      	ispSC.nomeProv  = 'Alessandria';
        ispSC.provSet = new Set<String>();
        ispSC.RegioneProvMap = new Map<String,Set<String>>();
        ispSC.tipiIspezione = new List<String>();
        ispSC.roleIdRoleNameMap  = new Map<Id,String>();
        ispSC.yM = '201901';
		ispSC.isLowProfile = true;
        
        List<SelectOption> optList = new  List<SelectOption>();
           ispSC.optList  = new List<SelectOption>();
        List<SelectOption> optListaComuni = new  List<SelectOption>();
           
        List<SelectOption> optListaRegioni = new  List<SelectOption>();
        List<String> tipiIspezione = new  List<String>();
     //   String ispSC.optScelta= 'Verifica Rispetto Adempimenti Contrattuali Societa di Servizio';
        
        String roleNameIsp2LNord='Ispettore_II_Livello_Nord';
        String roleNameIsp2LCS='Ispettore_II_Livello_Centro_Sud';
        String roleNameVuoto='';
           
        User usrAtt=[Select id, UserRoleId, ProfileId, Name, LastName, UserRole.DeveloperName from User where UserRole.DeveloperName='CQS_City_Manager_Nord'/* Id=:userinfo.getUserId()*/ LIMIT 1];
           
       	ispSC.optNomeProgetto  = new List<SelectOption>();
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_City_Manager' LIMIT 1];
        UserRole cmRole = [Select id, DeveloperName from UserRole where DeveloperName='CQS_City_Manager_Nord'];
           
        OF_ElencoComuniItaliani__c eCi = new OF_ElencoComuniItaliani__c();
        eci.OF_Regione__c= 'Piemonte';
        eci.OF_Provincia__c='Alessandria';
        eci.OF_Comune__c='Alessandria'; 
        eci.OF_CodiceIstat__c='00000001';
        insert eci;   
       /* 
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.UserRoleId=cmRole.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
       // usr.UserRoleId = r.Id;
        insert usr;
         */  
       
        String optSceltaRegione='Piemonte';
           
        ispSC.selectedIdComune= eci.id;
       // optSceltaRegione= String (optListaRegioni[0]);
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'test';
        insert anag;
        String ragSocialeImpresa = anag.Name;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.Name = 'optSceltaComune Lotto 1';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        pro.CQS_Pro_LDO__c='Test';
        pro.CQS_Pro_Comune__c=eci.OF_Comune__c;
        insert pro;
        String ldoStr= pro.CQS_Pro_LDO__c;
        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usrAtt.id;
        projen.CQS_junc_progetto__c= pro.id;
        //projen.CQS_junc_progetto__r.Name= pro.Name;
        insert projen;
           
        CQS_Prog_An_junc__c jnt = new CQS_Prog_An_junc__c();
        jnt.CQS_Praj_Progetto__c = pro.id;
        jnt.CQS_Praj_Ragione_Sociale__c = anag.Id ;
        //jnt.CQS_Praj_Progetto__r.CQS_Pro_Comune__c = optSceltaComune; 
        insert jnt;
         
        List<SelectOption> optListaProgetti = new List<SelectOption>();
        optListaProgetti.add(new SelectOption(projen.CQS_junc_progetto__c,pro.Name)); 
        Map<String,String> ldoMap = new Map<String, String>();
        Map<String,String> rsocial = new Map<String, String>();
        Map<String,String> regMap = new Map<String, String>();
         
        ldoMap.put(pro.id,pro.CQS_Pro_LDO__c);
        regMap.put(pro.id,anag.id);   
       // 
       String searchTerm = 'test';
        
        PageReference pageRef = Page.CQS_Isp2L_AdempimentiSS;
        
        Test.setCurrentPage(pageRef);
        
        ApexPages.CurrentPage().getParameters().put('shortOpt','SocServ');
        ApexPages.CurrentPage().getParameters().put('Prov','Alessandria');
        ApexPages.CurrentPage().getParameters().put('roleName',roleNameIsp2LNord);
        ApexPages.CurrentPage().getParameters().put('optSceltaRegione','Piemonte');
           
        ispSC.roleName = usrAtt.UserRole.DeveloperName;
        ispSC.searchTerm = searchTerm;
        
        
       
        test.startTest();
           System.runAs(usrAtt){
        CQS_Isp2L_AdempimentiController.searchComune(searchTerm);
        ispSC.salvaIspezione();
        ispSC.backToSel();
       	ispSC.definisciProgettiPl();
        ispSC.defineLDO();
     //   ispSC.pagPresel();
        }
        test.stopTest();
        
        
    }

}
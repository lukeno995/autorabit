@isTest
public class CQS_RisImp_SelComuneControllerTest {
    
   
    public static testmethod void CQS_RisImp_SelComuneControllerMethod(){
        
        Id RTidRisImpPian = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Mensile').getRecordTypeId();
        Id RTidRisImpCons = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Consuntivo Risorse Giornaliero').getRecordTypeId();
        String optSceltaComune = 'Alessandria';
        
        
        List<SelectOption> optListaProgetti = new List<SelectOption>();
        String optSceltaProgetto  ; 
        Boolean rtiImpresa;
        
        
        String prevRis= 'prevRis';
        
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
        pro.CQS_Pro_Comune__c=optSceltaComune;
        insert pro;
        String ldoStr= pro.CQS_Pro_LDO__c;
        
         //Commented  on 15012019 
         
       /** List<UserRole> ur = new List<UserRole>();
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        //UserRole r = [Select id ,ParentRoleId , name from userrole where Name like '%CSE%' LIMIT 1];
        // ur.add(r);
        // insert ur; 
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; **/
        
         //Added  on 15012019 for providing proper User.
         Map<String,ID> profiles = new Map<String,ID>();
      List<Profile> ps = [select id, name from Profile where name = 
         'Standard User' or name = 'System Administrator'];

      for(Profile p : ps){
         profiles.put(p.name, p.id);
      }

      // Create the users to be used in this test.  
    
      // First make a new user.  
    

      User standard = new User(alias = 'standt', 
      email='standarduser@testorg.com', 
      emailencodingkey='UTF-8', 
      lastname='Testing', languagelocalekey='en_US', 
      localesidkey='en_US', 
      profileid = profiles.get('System Administrator'), 
      timezonesidkey='America/Los_Angeles', 
      username='standarduser1234*@testorg.com');

      insert standard;

        
          
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = standard.id;
        projen.CQS_junc_progetto__c= pro.id;
        //projen.CQS_junc_progetto__r.Name= pro.Name;
        insert projen;
        system.debug('***projen.CQS_junc_user__c : '+projen.CQS_junc_user__c);
        system.debug('***projen.CQS_junc_user__c : '+standard.id);
         
        List<OF_CQS_Risorse_Impiegate__c> risImpListPian = new List<OF_CQS_Risorse_Impiegate__c>();
        OF_CQS_Risorse_Impiegate__c risImpP = new OF_CQS_Risorse_Impiegate__c();
        risImpP.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpP.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpP.CQS_RisImp_Progetto__c = pro.Id;
        risImpP.CQS_RI_LDO__c = 'Test';
        risImpP.CQS_RisImp_Data__c = System.today();
        risImpP.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpP.CQS_RisImp_Somma_FTE__c = '135';
        risImpP.recordtypeid=RTidRisImpPian;
       
         
      //  risImpP.OF_CQS_Comune_Ris_Imp__c = 'Alessandria' ; 
        risImpListPian.add(risImpP);
        insert risImpListPian; 
        
        List<OF_CQS_Risorse_Impiegate__c> risImpListCons = new List<OF_CQS_Risorse_Impiegate__c>();
        OF_CQS_Risorse_Impiegate__c risImpC = new OF_CQS_Risorse_Impiegate__c();
        risImpC.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpC.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpC.CQS_RisImp_Progetto__c = pro.Id;
        risImpC.CQS_RI_LDO__c = 'Test';
        risImpC.CQS_RisImp_Data__c = System.today().addDays(+2);
        risImpC.CQS_RisImp_FTE_altre_attivita__c = '2';
        risImpC.CQS_RisImp_FTE_lavori_civili__c  = '7';
        risImpC.CQS_RisImp_FTE_ldelivery_vertadd__c = '9';
        risImpC.CQS_RisImp_FTE_lavoriOttici_posacavo__c ='20';
        risImpC.CQS_RisImp_FTElavori_ottici_giunzcoll__c ='15';
        risImpC.recordtypeid=RTidRisImpCons;
        risImpC.OF_CQS_Comune_Ris_Imp__c = optSceltaComune; 
         
         OF_CQS_Risorse_Impiegate__c risImpC2 = new OF_CQS_Risorse_Impiegate__c();
        risImpC2.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpC2.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        
        risImpC2.CQS_RisImp_Progetto__c = pro.Id;
        risImpC2.CQS_RI_LDO__c = 'Test';
        risImpC2.CQS_RisImp_Data__c = System.today().addDays(+3);
        risImpC2.CQS_RisImp_FTE_altre_attivita__c = '15';
        risImpC2.CQS_RisImp_FTE_lavori_civili__c  = '17';
        risImpC2.CQS_RisImp_FTE_ldelivery_vertadd__c = '6';
        risImpC2.CQS_RisImp_FTE_lavoriOttici_posacavo__c    ='12';
        risImpC2.CQS_RisImp_FTElavori_ottici_giunzcoll__c ='10';
        risImpC2.recordtypeid=RTidrisImpCons;
        risImpC2.OF_CQS_Comune_Ris_Imp__c = optSceltaComune ; 
        
        risImpListCons.add(risImpC);
        risImpListCons.add(risImpC2);
        insert risImpListCons; 
        
        CQS_Prog_An_junc__c jnt = new CQS_Prog_An_junc__c();
        jnt.CQS_Praj_Progetto__c = pro.id;
        jnt.CQS_Praj_Ragione_Sociale__c = anag.Id ;
        //jnt.CQS_Praj_Progetto__r.CQS_Pro_Comune__c = optSceltaComune; 
        insert jnt;
       
        optListaProgetti.add(new SelectOption(projen.CQS_junc_progetto__c,pro.Name)); 
        optSceltaProgetto=pro.Name;
        Map<String,String> ldoMap = new Map<String, String>();
        Map<String,String> rsocial = new Map<String, String>();
        Map<String,String> regMap = new Map<String, String>();
         
        ldoMap.put(pro.id,pro.CQS_Pro_LDO__c);
        regMap.put(pro.id,anag.id);
        
        
        system.runas(standard){
        ApexPages.StandardController sc = new ApexPages.StandardController(risImpC);
        
        CQS_RisImp_SelComuneController tRisImp = new CQS_RisImp_SelComuneController(sc); 
        test.startTest();
         
        tRisImp.definisciComuniPl();
        tRisImp.goToRealForm();
        tRisImp.scegliTipoForm();
        
        
            test.stopTest();}
    }
    
    public static testmethod void CQS_RisImp_SelComuneControllerMethod2(){
        
        Id RTidRisImpPian = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Mensile').getRecordTypeId();
        Id RTidRisImpCons = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Consuntivo Risorse Giornaliero').getRecordTypeId();
        String optSceltaComune = 'Alessandria';
        String optScelta='Preventivo Risorse Mensile';
        
        
        List<SelectOption> optListaProgetti = new List<SelectOption>();
        String optSceltaProgetto  ; 
        Boolean rtiImpresa;
        
        
        String prevRis= 'prevRis';
        
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'RTI test - test2';
        insert anag;
        String ragSocialeImpresa = anag.Name;
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.Name = 'optSceltaComune Lotto 1';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        pro.CQS_Pro_LDO__c='Test';
        pro.CQS_Pro_Comune__c=optSceltaComune;
        insert pro;
        String ldoStr= pro.CQS_Pro_LDO__c;
      /**  List<UserRole> ur = new List<UserRole>();
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        //UserRole r = [Select id ,ParentRoleId , name from userrole where Name like '%CSE%' LIMIT 1];
        // ur.add(r);
        // insert ur; 
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US';  **/
        
        Map<String,ID> profiles = new Map<String,ID>();
      List<Profile> ps = [select id, name from Profile where name = 
         'Standard User' or name = 'System Administrator'];

      for(Profile p : ps){
         profiles.put(p.name, p.id);
      }

      // Create the users to be used in this test.  
    
      // First make a new user.  
    

      User standard = new User(alias = 'standt', 
      email='standarduser@testorg.com', 
      emailencodingkey='UTF-8', 
      lastname='Testing', languagelocalekey='en_US', 
      localesidkey='en_US', 
      profileid = profiles.get('Standard User'), 
      timezonesidkey='America/Los_Angeles', 
      username='standarduser1234*@testorg.com');

      insert standard;
        
          
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = standard.id;
        projen.LDO__c=pro.CQS_Pro_LDO__c;
      
        
        
        //projen.CQS_junc_progetto__r.Name= pro.Name;
        insert projen;
         
        List<OF_CQS_Risorse_Impiegate__c> risImpListPian = new List<OF_CQS_Risorse_Impiegate__c>();
        OF_CQS_Risorse_Impiegate__c risImpP = new OF_CQS_Risorse_Impiegate__c();
        risImpP.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpP.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpP.CQS_RisImp_Progetto__c = pro.Id;
        risImpP.CQS_RI_LDO__c = 'Test';
        risImpP.CQS_RisImp_Data__c = System.today();
        risImpP.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpP.CQS_RisImp_Somma_FTE__c = '135';
        risImpP.recordtypeid=RTidRisImpPian;
       
         
      //  risImpP.OF_CQS_Comune_Ris_Imp__c = 'Alessandria' ; 
        risImpListPian.add(risImpP);
        insert risImpListPian; 
        
        List<OF_CQS_Risorse_Impiegate__c> risImpListCons = new List<OF_CQS_Risorse_Impiegate__c>();
        OF_CQS_Risorse_Impiegate__c risImpC = new OF_CQS_Risorse_Impiegate__c();
        risImpC.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpC.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpC.CQS_RisImp_Progetto__c = pro.Id;
        risImpC.CQS_RI_LDO__c = 'Test';
        risImpC.CQS_RisImp_Data__c = System.today().addDays(+2);
        risImpC.CQS_RisImp_FTE_altre_attivita__c = '2';
        risImpC.CQS_RisImp_FTE_lavori_civili__c  = '7';
        risImpC.CQS_RisImp_FTE_ldelivery_vertadd__c = '9';
        risImpC.CQS_RisImp_FTE_lavoriOttici_posacavo__c ='20';
        risImpC.CQS_RisImp_FTElavori_ottici_giunzcoll__c ='15';
        risImpC.recordtypeid=RTidRisImpCons;
        risImpC.OF_CQS_Comune_Ris_Imp__c = optSceltaComune; 
         
        OF_CQS_Risorse_Impiegate__c risImpC2 = new OF_CQS_Risorse_Impiegate__c();
        risImpC2.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpC2.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        
        risImpC2.CQS_RisImp_Progetto__c = pro.Id;
        risImpC2.CQS_RI_LDO__c = 'Test';
        risImpC2.CQS_RisImp_Data__c = System.today().addDays(+3);
        risImpC2.CQS_RisImp_FTE_altre_attivita__c = '15';
        risImpC2.CQS_RisImp_FTE_lavori_civili__c  = '17';
        risImpC2.CQS_RisImp_FTE_ldelivery_vertadd__c = '6';
        risImpC2.CQS_RisImp_FTE_lavoriOttici_posacavo__c    ='12';
        risImpC2.CQS_RisImp_FTElavori_ottici_giunzcoll__c ='10';
        risImpC2.recordtypeid=RTidrisImpCons;
        risImpC2.OF_CQS_Comune_Ris_Imp__c = optSceltaComune ; 
        
        risImpListCons.add(risImpC);
        risImpListCons.add(risImpC2);
        insert risImpListCons; 
        
        CQS_Prog_An_junc__c jnt = new CQS_Prog_An_junc__c();
        jnt.CQS_Praj_Progetto__c = pro.id;
        jnt.CQS_Praj_Ragione_Sociale__c = anag.Id ;
        //jnt.CQS_Praj_Progetto__r.CQS_Pro_Comune__c = optSceltaComune; 
        insert jnt;
       
        optListaProgetti.add(new SelectOption(projen.CQS_junc_progetto__c,pro.Name)); 
        optSceltaProgetto=pro.Name;
        Map<String,String> ldoMap = new Map<String, String>();
        Map<String,String> rsocial = new Map<String, String>();
        Map<String,String> regMap = new Map<String, String>();
        Set<String> nomeComuneSet = new Set<String>();
        nomeComuneSet.add(optSceltaComune);
         
        ldoMap.put(pro.id,pro.CQS_Pro_LDO__c);
        regMap.put(pro.id,anag.id);
        
         ApexPages.StandardController sc = new ApexPages.StandardController(risImpP);
        
         CQS_RisImp_SelComuneController tRisImp = new CQS_RisImp_SelComuneController(sc);
        system.runas(standard){
        test.startTest();
        //tRisImp.definisciComuniPl();
        tRisImp.goToRealForm();
        tRisImp.scegliTipoForm();
        //Commented fake method as suggested by Pietro on 15012019 
        //CQS_RisImp_SelComuneController.CodeCoverage(2);        
        
            test.stopTest();}
    }
    
    
}
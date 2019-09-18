@isTest
public class CQS_RisorseImpiegateController_Test {
    
    //Boolean checK = true;
     public static testmethod void CQS_RisorseImpiegateControllerMethod(){
        
         Id RTidRisImpPian = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Mensile').getRecordTypeId();
         Id RTidRisImpCons = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Consuntivo Risorse Giornaliero').getRecordTypeId();
         Id RTidRisImpPianSETT = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Settimanale').getRecordTypeId();
        
         String optSceltaComune = 'Alessandria';
         String ComuneSelezionato = 'Alessandria';
         
     List<SelectOption> optListaComune = new List<SelectOption>();
         optListaComune.add(new SelectOption(optSceltaComune, optSceltaComune));
            
         
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
         
         
        List<UserRole> ur = new List<UserRole>();
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_Direttore_Lavori' LIMIT 1];
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
        projen.CQS_junc_progetto__c= pro.id;
        //projen.CQS_junc_progetto__r.Name= pro.Name;
        insert projen;
        
         Set<Id> risImpIdSet = new Set<Id>();
         
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
         risImpC.CQS_RisImp_TipoRapporto__c='Consuntivo';

        risImpC.recordtypeid=RTidRisImpCons;
        risImpC.OF_CQS_Comune_Ris_Imp__c = optSceltaComune; 
         
         OF_CQS_Risorse_Impiegate__c risImpC2 = new OF_CQS_Risorse_Impiegate__c();
        risImpC2.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpC2.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpC2.CQS_RisImp_TipoRapporto__c='Consuntivo';
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
        risImpIdSet.add(risImpC.id);
        risImpIdSet.add(risImpC.id);
         
        insert risImpListCons; 
      //insert risImpIdSet; 
        
         
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
        
         ApexPages.StandardController sc = new ApexPages.StandardController(risImpC);
        
         CQS_RisorseImpiegateController tRisImp = new CQS_RisorseImpiegateController(sc);
        
        ApexPages.currentPage().getParameters().put('consRis','true'); 
        ApexPages.currentPage().getParameters().put('optSceltaComune',optSceltaComune); 
         
        test.startTest();
        tRisImp.definisciProgettiPl2(optSceltaComune);
        tRisImp.defineLDO();
        tRisImp.definisciProgettiPlsO(optSceltaComune);
        tRisImp.definisciProgettiPl();
      //  tRisImp.passaParComune();
        tRisImp.SalvaConsuntivo();
        tRisImp.tornaSelezioneComune();
         
         //Commented fake method as suggested by Pietro on 15012019
        // CQS_RisorseImpiegateController.codeCoverage(2);
      
         test.stopTest();
     }
     //Added CQS_RisorseImpiegateControllerMethod1()  on 15012019
     public static testmethod void CQS_RisorseImpiegateControllerMethod1(){
        
         Id RTidRisImpPian = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Mensile').getRecordTypeId();
         Id RTidRisImpCons = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Consuntivo Risorse Giornaliero').getRecordTypeId();
         Id RTidRisImpPianSETT = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Settimanale').getRecordTypeId();
        
         String optSceltaComune = 'Alessandria';
         String ComuneSelezionato = 'Alessandria';
         
     List<SelectOption> optListaComune = new List<SelectOption>();
         optListaComune.add(new SelectOption(optSceltaComune, optSceltaComune));
            
         
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
         
       /**  
        List<UserRole> ur = new List<UserRole>();
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_Direttore_Lavori' LIMIT 1];
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
        insert usr; **/
         
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
      username='standarduser1234567*@testorg.com');

      insert standard;

        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = standard.id;
        projen.CQS_junc_progetto__c= pro.id;
        //projen.CQS_junc_progetto__r.Name= pro.Name;
        insert projen;
        
         Set<Id> risImpIdSet = new Set<Id>();
         
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
         risImpC.CQS_RisImp_TipoRapporto__c='Consuntivo';

        risImpC.recordtypeid=RTidRisImpCons;
        risImpC.OF_CQS_Comune_Ris_Imp__c = optSceltaComune; 
         
         OF_CQS_Risorse_Impiegate__c risImpC2 = new OF_CQS_Risorse_Impiegate__c();
        risImpC2.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpC2.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpC2.CQS_RisImp_TipoRapporto__c='Consuntivo';
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
        risImpIdSet.add(risImpC.id);
        risImpIdSet.add(risImpC.id);
         
        insert risImpListCons; 
      //insert risImpIdSet; 
        
         
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
         
         ApexPages.currentPage().getParameters().put('consRis','true'); 
        ApexPages.currentPage().getParameters().put('optSceltaComune',optSceltaComune);
        
         ApexPages.StandardController sc = new ApexPages.StandardController(risImpC);
        
         CQS_RisorseImpiegateController tRisImp = new CQS_RisorseImpiegateController(sc);
        
         
         system.runas(standard){
        test.startTest();
        tRisImp.definisciProgettiPl2(optSceltaComune);
        tRisImp.defineLDO();
        tRisImp.definisciProgettiPlsO(optSceltaComune);
        tRisImp.definisciProgettiPl();
      //  tRisImp.passaParComune();
        tRisImp.SalvaConsuntivo();
        tRisImp.tornaSelezioneComune();
         
         //Commented fake method as suggested by Pietro on 15012019
        // CQS_RisorseImpiegateController.codeCoverage(2);
      
             test.stopTest();}
     }
    
    public static testmethod void CQS_RisorseImpiegateControllerMethod3(){
        
         Id RTidRisImpPian = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Mensile').getRecordTypeId();
         Id RTidRisImpCons = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Consuntivo Risorse Giornaliero').getRecordTypeId();
         Id RTidRisImpPianSETT = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Settimanale').getRecordTypeId();
        
         String optSceltaComune = 'Alessandria';
         String ComuneSelezionato = 'Alessandria';
         
     List<SelectOption> optListaComune = new List<SelectOption>();
         optListaComune.add(new SelectOption(optSceltaComune, optSceltaComune));
        
        OF_CQS_Anagrafica__c anagB = new OF_CQS_Anagrafica__c();
       // anag.OwnerId= usrSystAdm.id;
        anagB.CQS_Check_Affidataria__c = true;
        anagB.Name = 'test';
    //    anaList.add(anag);
        OF_CQS_Anagrafica__c anag1 = new OF_CQS_Anagrafica__c();
        anag1.CQS_Check_Affidataria__c = true;
        anag1.Name = 'TEST';
       // anag1.OwnerId= usrSystAdm.id;
        insert anag1;
     //   anaList.add(anag1);
        OF_CQS_Anagrafica__c anag2 = new OF_CQS_Anagrafica__c();
        anag2.CQS_Check_Affidataria__c = true;
        anag2.Name = 'TEST2';
       // anag2.OwnerId= usrSystAdm.id;
        insert anag2;
    //    anaList.add(anag2);
        OF_CQS_Anagrafica__c anag3 = new OF_CQS_Anagrafica__c();
        anag3.CQS_Check_Affidataria__c = true;
        anag3.Name = 'TEST3';
  //      anag3.OwnerId= usrSystAdm.id;
        insert anag3;
      //  anaList.add(anag3);
        OF_CQS_Anagrafica__c anag4 = new OF_CQS_Anagrafica__c();
        anag4.CQS_Check_Affidataria__c = true;
     //   anag4.OwnerId= usrSystAdm.id;
        anag4.Name = 'TEST4';
        insert anag4;
   //     anaList.add(anag4);
        OF_CQS_Anagrafica__c anag5 = new OF_CQS_Anagrafica__c();
        anag5.CQS_Check_Affidataria__c = true;
        anag5.Name = 'TEST5';
   //     anag5.OwnerId= usrSystAdm.id;
        insert anag5;
//        anaList.add(anag5);
       // insert anaList;
       //  TEST2 TEST3 TEST4 TEST5'
       //  
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        
        anag.Name ='RTI - TEST TEST2 TEST3 TEST4 TEST5';
        anag.RecordTypeId=[Select id from RecordType where SobjectType='OF_CQS_Anagrafica__c' AND DeveloperName='CQS_Imprese_in_raggruppamento'].id;
        anag.CQS_An_ConsorziataCapogruppo__c =anag1.id;
    anag.CQS_An_Consorziata_2__c = anag2.id;
    anag.CQS_An_Consorziata_3__c = anag3.id;
    anag.CQS_An_Consorziata_4__c = anag4.id;
    anag.CQS_An_Consorziata_5__c = anag5.id;
        //anag.OwnerId= usrSystAdm.id;
    insert anag;
        
            
       /*  
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'test';
        insert anag;
        String ragSocialeImpresa = anag.Name;
        */
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.Name = 'optSceltaComune Lotto 1';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        pro.CQS_Pro_LDO__c='Test';
        pro.CQS_Pro_Comune__c=optSceltaComune;
        insert pro;
        String ldoStr= pro.CQS_Pro_LDO__c;
         
         
        List<UserRole> ur = new List<UserRole>();
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_Direttore_Lavori' LIMIT 1];
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
        projen.CQS_junc_progetto__c= pro.id;
        //projen.CQS_junc_progetto__r.Name= pro.Name;
        insert projen;
        
         Set<Id> risImpIdSet = new Set<Id>();
         
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
        
        //Pianificato settimanale 
        
        List<OF_CQS_Risorse_Impiegate__c> risImpListPianSETT1 = new List<OF_CQS_Risorse_Impiegate__c>();
    
        OF_CQS_Risorse_Impiegate__c risImpPS1 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS1.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpPS1.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        risImpPS1.CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale';
        risImpPS1.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS1.CQS_RI_LDO__c = 'Test';
        risImpPS1.CQS_RisImp_Data__c = System.today().addDays(-21);
        risImpPS1.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS1.CQS_RisImp_Somma_FTE_Settimanale__c = '0';
       
    risImpPS1.CQS_RisImp_Pian_Sett_Contrattista1__c = '10';
        risImpPS1.CQS_RisImp_Pian_Sett_Contrattista2__c = '15';
    risImpPS1.CQS_RisImp_Pian_Sett_Contrattista3__c = '11';
    risImpPS1.CQS_RisImp_Pian_Sett_Contrattista4__c = '13';
    risImpPS1.CQS_RisImp_Pian_Sett_Contrattista5__c = '8';

        risImpPS1.recordtypeid=RTidRisImpPianSETT;
    insert risImpPS1;
       
      
    OF_CQS_Risorse_Impiegate__c risImpPS2 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS2.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpPS2.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpPS2.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS2.CQS_RI_LDO__c = 'Test';
        risImpPS2.CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale'; 
        risImpPS2.CQS_RisImp_Data__c = System.today().addDays(-14);
        risImpPS2.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS2.CQS_RisImp_Somma_FTE_Settimanale__c = '0';
    risImpPS2.CQS_RisImp_Pian_Sett_Contrattista1__c = '10';
        risImpPS2.CQS_RisImp_Pian_Sett_Contrattista2__c = '15';
    risImpPS2.CQS_RisImp_Pian_Sett_Contrattista3__c = '11';
    risImpPS2.CQS_RisImp_Pian_Sett_Contrattista4__c = '13';
    risImpPS2.CQS_RisImp_Pian_Sett_Contrattista5__c = '8';
       
        risImpPS2.recordtypeid=RTidRisImpPianSETT;
    insert risImpPS2;
    
     OF_CQS_Risorse_Impiegate__c risImpPS3 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS3.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpPS3.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpPS3.CQS_RisImp_Somma_FTE_Settimanale__c = '0';
        risImpPS3.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS3.CQS_RI_LDO__c = 'Test';
        risImpPS3.CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale'; 
        risImpPS3.CQS_RisImp_Data__c = System.today().addDays(-7);
        risImpPS3.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        
        risImpPS3.CQS_RisImp_Pian_Sett_Contrattista1__c = '10';
        risImpPS3.CQS_RisImp_Pian_Sett_Contrattista2__c = '15';
    risImpPS3.CQS_RisImp_Pian_Sett_Contrattista3__c = '11';
    risImpPS3.CQS_RisImp_Pian_Sett_Contrattista4__c = '13';
    risImpPS3.CQS_RisImp_Pian_Sett_Contrattista5__c = '8';
       
        risImpPS3.recordtypeid=RTidRisImpPianSETT;
       insert risImpPS3;
      
    OF_CQS_Risorse_Impiegate__c risImpPS4 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS4.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpPS4.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpPS4.CQS_RisImp_Somma_FTE_Settimanale__c = '0';
        risImpPS4.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS4.CQS_RI_LDO__c = 'Test';
        risImpPS4.CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale';
        risImpPS4.CQS_RisImp_Data__c = System.today();
        risImpPS4.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS4.CQS_RisImp_Pian_Sett_Contrattista1__c = '10';
        risImpPS4.CQS_RisImp_Pian_Sett_Contrattista2__c = '15';
    risImpPS4.CQS_RisImp_Pian_Sett_Contrattista3__c = '11';
    risImpPS4.CQS_RisImp_Pian_Sett_Contrattista4__c = '13';
    risImpPS4.CQS_RisImp_Pian_Sett_Contrattista5__c = '8';
       
        risImpPS4.recordtypeid=RTidRisImpPianSETT;
        insert risImpPS4;
     
     
        OF_CQS_Risorse_Impiegate__c risImpPS5 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS5.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpPS5.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpPS5.CQS_RisImp_Somma_FTE_Settimanale__c = '0';
        risImpPS5.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS5.CQS_RI_LDO__c = 'Test';
        risImpPS5.CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale';
        risImpPS5.CQS_RisImp_Data__c = System.today().addDays(+7);
        risImpPS5.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS5.CQS_RisImp_Pian_Sett_Contrattista1__c = '10';
        risImpPS5.CQS_RisImp_Pian_Sett_Contrattista2__c = '15';
    risImpPS5.CQS_RisImp_Pian_Sett_Contrattista3__c = '11';
    risImpPS5.CQS_RisImp_Pian_Sett_Contrattista4__c = '13';
    risImpPS5.CQS_RisImp_Pian_Sett_Contrattista5__c = '8';

        risImpPS5.recordtypeid=RTidRisImpPianSETT; 
    insert risImpPS5;
    //End Pianificato Settimanale
       
         
      //  risImpP.OF_CQS_Comune_Ris_Imp__c = 'Alessandria' ; 
        risImpListPian.add(risImpP);
        insert risImpListPian; 
        
        List<OF_CQS_Risorse_Impiegate__c> oldlist = new List<OF_CQS_Risorse_Impiegate__c>();
        
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
         risImpC.CQS_RisImp_TipoRapporto__c='Consuntivo';

        risImpC.recordtypeid=RTidRisImpCons;
        risImpC.OF_CQS_Comune_Ris_Imp__c = optSceltaComune; 
        oldlist.add(risImpC);
         
         OF_CQS_Risorse_Impiegate__c risImpC2 = new OF_CQS_Risorse_Impiegate__c();
        risImpC2.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpC2.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpC2.CQS_RisImp_TipoRapporto__c='Consuntivo';
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
        risImpIdSet.add(risImpC.id);
        risImpIdSet.add(risImpC.id);
         
        insert risImpListCons; 
      //insert risImpIdSet; 
        
         
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
        
         ApexPages.StandardController sc = new ApexPages.StandardController(risImpC);
        
         CQS_RisorseImpiegateController tRisImp = new CQS_RisorseImpiegateController(sc);
        
        ApexPages.currentPage().getParameters().put('consRis','true'); 
        ApexPages.currentPage().getParameters().put('optSceltaComune',optSceltaComune); 
         
        test.startTest();
        tRisImp.definisciProgettiPl2(optSceltaComune);
        tRisImp.defineLDO();
        tRisImp.definisciProgettiPlsO(optSceltaComune);
        tRisImp.definisciProgettiPl();
      //  tRisImp.passaParComune();
        tRisImp.SalvaConsuntivo();
        tRisImp.tornaSelezioneComune();
        
        //Commented fake method as suggested by Pietro on 15012019
        // CQS_RisorseImpiegateController.codeCoverage(2);
      
         test.stopTest();
     }
    
    public static testmethod void CQS_RisorseImpiegateControllerMethod4(){
        
         Id RTidRisImpPian = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Mensile').getRecordTypeId();
         Id RTidRisImpCons = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Consuntivo Risorse Giornaliero').getRecordTypeId();
         Id RTidRisImpPianSETT = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Settimanale').getRecordTypeId();
        
         String optSceltaComune = 'Alessandria';
         String ComuneSelezionato = 'Alessandria';
         
     List<SelectOption> optListaComune = new List<SelectOption>();
         optListaComune.add(new SelectOption(optSceltaComune, optSceltaComune));
        
        OF_CQS_Anagrafica__c anagB = new OF_CQS_Anagrafica__c();
       // anag.OwnerId= usrSystAdm.id;
        anagB.CQS_Check_Affidataria__c = true;
        anagB.Name = 'test';
    //    anaList.add(anag);
        OF_CQS_Anagrafica__c anag1 = new OF_CQS_Anagrafica__c();
        anag1.CQS_Check_Affidataria__c = true;
        anag1.Name = 'TEST';
       // anag1.OwnerId= usrSystAdm.id;
        insert anag1;
     //   anaList.add(anag1);
        OF_CQS_Anagrafica__c anag2 = new OF_CQS_Anagrafica__c();
        anag2.CQS_Check_Affidataria__c = true;
        anag2.Name = 'TEST2';
       // anag2.OwnerId= usrSystAdm.id;
        insert anag2;
    //    anaList.add(anag2);
        OF_CQS_Anagrafica__c anag3 = new OF_CQS_Anagrafica__c();
        anag3.CQS_Check_Affidataria__c = true;
        anag3.Name = 'TEST3';
  //      anag3.OwnerId= usrSystAdm.id;
        insert anag3;
      //  anaList.add(anag3);
        OF_CQS_Anagrafica__c anag4 = new OF_CQS_Anagrafica__c();
        anag4.CQS_Check_Affidataria__c = true;
     //   anag4.OwnerId= usrSystAdm.id;
        anag4.Name = 'TEST4';
        insert anag4;
   //     anaList.add(anag4);
        OF_CQS_Anagrafica__c anag5 = new OF_CQS_Anagrafica__c();
        anag5.CQS_Check_Affidataria__c = true;
        anag5.Name = 'TEST5';
   //     anag5.OwnerId= usrSystAdm.id;
        insert anag5;
//        anaList.add(anag5);
       // insert anaList;
       //  TEST2 TEST3 TEST4 TEST5'
       //  
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        
        anag.Name ='RTI - TEST TEST2 TEST3 TEST4 TEST5';
        anag.RecordTypeId=[Select id from RecordType where SobjectType='OF_CQS_Anagrafica__c' AND DeveloperName='CQS_Imprese_in_raggruppamento'].id;
        anag.CQS_An_ConsorziataCapogruppo__c =anag1.id;
    anag.CQS_An_Consorziata_2__c = anag2.id;
    anag.CQS_An_Consorziata_3__c = anag3.id;
    anag.CQS_An_Consorziata_4__c = anag4.id;
    anag.CQS_An_Consorziata_5__c = anag5.id;
        //anag.OwnerId= usrSystAdm.id;
    insert anag;
        
            
       /*  
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'test';
        insert anag;
        String ragSocialeImpresa = anag.Name;
        */
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.Name = 'optSceltaComune Lotto 1';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        pro.CQS_Pro_LDO__c='Test';
        pro.CQS_Pro_Comune__c=optSceltaComune;
        insert pro;
        String ldoStr= pro.CQS_Pro_LDO__c;
         
         
        List<UserRole> ur = new List<UserRole>();
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_Direttore_Lavori' LIMIT 1];
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
        projen.CQS_junc_progetto__c= pro.id;
        //projen.CQS_junc_progetto__r.Name= pro.Name;
        insert projen;
        
         Set<Id> risImpIdSet = new Set<Id>();
         
        List<OF_CQS_Risorse_Impiegate__c> risImpListPian = new List<OF_CQS_Risorse_Impiegate__c>();
        OF_CQS_Risorse_Impiegate__c risImpP = new OF_CQS_Risorse_Impiegate__c();
        risImpP.CQS_RisImp_Impresa_Mandataria__c = anag1.Id;
        risImpP.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        
        risImpP.CQS_RisImp_Progetto__c = pro.Id;
        risImpP.CQS_RI_LDO__c = 'Test';
         
        risImpP.CQS_RisImp_Data__c = System.today();
        risImpP.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpP.CQS_RisImp_Somma_FTE__c = '135';
       

        risImpP.recordtypeid=RTidRisImpPian;
        
        //Pianificato settimanale 
        
        List<OF_CQS_Risorse_Impiegate__c> risImpListPianSETT1 = new List<OF_CQS_Risorse_Impiegate__c>();
    
        OF_CQS_Risorse_Impiegate__c risImpPS1 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS1.CQS_RisImp_Impresa_Mandataria__c = anag1.Id;
        risImpPS1.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        risImpPS1.CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale';
        risImpPS1.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS1.CQS_RI_LDO__c = 'Test';
        risImpPS1.CQS_RisImp_Data__c = System.today().addDays(-21);
        risImpPS1.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS1.CQS_RisImp_Somma_FTE_Settimanale__c = '0';
       
    risImpPS1.CQS_RisImp_Pian_Sett_Contrattista1__c = '10';
        risImpPS1.CQS_RisImp_Pian_Sett_Contrattista2__c = '0';
    risImpPS1.CQS_RisImp_Pian_Sett_Contrattista3__c = '0';
    risImpPS1.CQS_RisImp_Pian_Sett_Contrattista4__c = '0';
    risImpPS1.CQS_RisImp_Pian_Sett_Contrattista5__c = '0';

        risImpPS1.recordtypeid=RTidRisImpPianSETT;
    insert risImpPS1;
       
      
    OF_CQS_Risorse_Impiegate__c risImpPS2 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS2.CQS_RisImp_Impresa_Mandataria__c = anag1.Id;
        risImpPS2.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        risImpPS2.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS2.CQS_RI_LDO__c = 'Test';
        risImpPS2.CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale'; 
        risImpPS2.CQS_RisImp_Data__c = System.today().addDays(-14);
        risImpPS2.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS2.CQS_RisImp_Somma_FTE_Settimanale__c = '0';
    risImpPS2.CQS_RisImp_Pian_Sett_Contrattista1__c = '10';
        risImpPS2.CQS_RisImp_Pian_Sett_Contrattista2__c = '0';
    risImpPS2.CQS_RisImp_Pian_Sett_Contrattista3__c = '0';
    risImpPS2.CQS_RisImp_Pian_Sett_Contrattista4__c = '0';
    risImpPS2.CQS_RisImp_Pian_Sett_Contrattista5__c = '0';
       
        risImpPS2.recordtypeid=RTidRisImpPianSETT;
    insert risImpPS2;
    
     OF_CQS_Risorse_Impiegate__c risImpPS3 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS3.CQS_RisImp_Impresa_Mandataria__c = anag1.Id;
        risImpPS3.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        risImpPS3.CQS_RisImp_Somma_FTE_Settimanale__c = '0';
        risImpPS3.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS3.CQS_RI_LDO__c = 'Test';
        risImpPS3.CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale'; 
        risImpPS3.CQS_RisImp_Data__c = System.today().addDays(-7);
        risImpPS3.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        
        risImpPS3.CQS_RisImp_Pian_Sett_Contrattista1__c = '10';
        risImpPS3.CQS_RisImp_Pian_Sett_Contrattista2__c = '0';
    risImpPS3.CQS_RisImp_Pian_Sett_Contrattista3__c = '0';
    risImpPS3.CQS_RisImp_Pian_Sett_Contrattista4__c = '0';
    risImpPS3.CQS_RisImp_Pian_Sett_Contrattista5__c = '0';
       
        risImpPS3.recordtypeid=RTidRisImpPianSETT;
       insert risImpPS3;
      
    OF_CQS_Risorse_Impiegate__c risImpPS4 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS4.CQS_RisImp_Impresa_Mandataria__c = anag1.Id;
        risImpPS4.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        risImpPS4.CQS_RisImp_Somma_FTE_Settimanale__c = '0';
        risImpPS4.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS4.CQS_RI_LDO__c = 'Test';
        risImpPS4.CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale';
        risImpPS4.CQS_RisImp_Data__c = System.today();
        risImpPS4.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS4.CQS_RisImp_Pian_Sett_Contrattista1__c = '10';
        risImpPS4.CQS_RisImp_Pian_Sett_Contrattista2__c = '0';
    risImpPS4.CQS_RisImp_Pian_Sett_Contrattista3__c = '0';
    risImpPS4.CQS_RisImp_Pian_Sett_Contrattista4__c = '0';
    risImpPS4.CQS_RisImp_Pian_Sett_Contrattista5__c = '0';
       
        risImpPS4.recordtypeid=RTidRisImpPianSETT;
        insert risImpPS4;
     
     
        OF_CQS_Risorse_Impiegate__c risImpPS5 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS5.CQS_RisImp_Impresa_Mandataria__c = anag1.Id;
        risImpPS5.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        risImpPS5.CQS_RisImp_Somma_FTE_Settimanale__c = '0';
        risImpPS5.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS5.CQS_RI_LDO__c = 'Test';
        risImpPS5.CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale';
        risImpPS5.CQS_RisImp_Data__c = System.today().addDays(+7);
        risImpPS5.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS5.CQS_RisImp_Pian_Sett_Contrattista1__c = '10';
        risImpPS5.CQS_RisImp_Pian_Sett_Contrattista2__c = '0';
    risImpPS5.CQS_RisImp_Pian_Sett_Contrattista3__c = '0';
    risImpPS5.CQS_RisImp_Pian_Sett_Contrattista4__c = '0';
    risImpPS5.CQS_RisImp_Pian_Sett_Contrattista5__c = '0';

        risImpPS5.recordtypeid=RTidRisImpPianSETT; 
    insert risImpPS5;
    //End Pianificato Settimanale
       
         
      //  risImpP.OF_CQS_Comune_Ris_Imp__c = 'Alessandria' ; 
        risImpListPian.add(risImpP);
        insert risImpListPian; 
        
        List<OF_CQS_Risorse_Impiegate__c> oldlist = new List<OF_CQS_Risorse_Impiegate__c>();
        
        List<OF_CQS_Risorse_Impiegate__c> risImpListCons = new List<OF_CQS_Risorse_Impiegate__c>();
        OF_CQS_Risorse_Impiegate__c risImpC = new OF_CQS_Risorse_Impiegate__c();
        risImpC.CQS_RisImp_Impresa_Mandataria__c = anag1.Id;
        risImpC.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        
        risImpC.CQS_RisImp_Progetto__c = pro.Id;
        risImpC.CQS_RI_LDO__c = 'Test';
         
        risImpC.CQS_RisImp_Data__c = System.today().addDays(+2);
         
        risImpC.CQS_RisImp_FTE_altre_attivita__c = '2';
        risImpC.CQS_RisImp_FTE_lavori_civili__c  = '7';
        risImpC.CQS_RisImp_FTE_ldelivery_vertadd__c = '9';
        risImpC.CQS_RisImp_FTE_lavoriOttici_posacavo__c ='20';
        risImpC.CQS_RisImp_FTElavori_ottici_giunzcoll__c ='15';
         risImpC.CQS_RisImp_TipoRapporto__c='Consuntivo';

        risImpC.recordtypeid=RTidRisImpCons;
        risImpC.OF_CQS_Comune_Ris_Imp__c = optSceltaComune; 
        oldlist.add(risImpC);
         
         OF_CQS_Risorse_Impiegate__c risImpC2 = new OF_CQS_Risorse_Impiegate__c();
        risImpC2.CQS_RisImp_Impresa_Mandataria__c = anag1.Id;
        risImpC2.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        risImpC2.CQS_RisImp_TipoRapporto__c='Consuntivo';
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
        risImpIdSet.add(risImpC.id);
        risImpIdSet.add(risImpC.id);
         
        insert risImpListCons; 
      //insert risImpIdSet; 
        
         
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
        regMap.put(pro.id,anag1.id);
        
         ApexPages.StandardController sc = new ApexPages.StandardController(risImpC);
        
         CQS_RisorseImpiegateController tRisImp = new CQS_RisorseImpiegateController(sc);
        
        ApexPages.currentPage().getParameters().put('consRis','true'); 
        ApexPages.currentPage().getParameters().put('optSceltaComune',optSceltaComune); 
         
        
        test.startTest();
        tRisImp.definisciProgettiPl2(optSceltaComune);
        tRisImp.defineLDO();
        tRisImp.definisciProgettiPlsO(optSceltaComune);
        tRisImp.definisciProgettiPl();
      //  tRisImp.passaParComune();
        tRisImp.SalvaConsuntivo();
        tRisImp.tornaSelezioneComune();
        
        //Commented fake method as suggested by Pietro on 15012019
        // CQS_RisorseImpiegateController.codeCoverage(2);
      
         test.stopTest();
     }
    
    
    /*
    public static testmethod void CQS_RisorseImpiegateControllerMethod2(){
        
         Id RTidRisImpPian = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Mensile').getRecordTypeId();
         Id RTidRisImpCons = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Consuntivo Risorse Giornaliero').getRecordTypeId();
         Id RTidRisImpPianSETT = Schema.SObjectType.OF_CQS_Risorse_Impiegate__c.getRecordTypeInfosByName().get('Pianificato Risorse Settimanale').getRecordTypeId();
        
        User usrSystAdm = new User();
        usrSystAdm.Alias = 'syst';
        usrSystAdm.Email='syst@testorg.com';
        usrSystAdm.EmailEncodingKey='UTF-8';
        usrSystAdm.LastName='Testing';
        usrSystAdm.LanguageLocaleKey='en_US'; 
        usrSystAdm.LocaleSidKey='en_US';
        usrSystAdm.ProfileId = [Select id from Profile WHERE Name = 'System Administrator' LIMIT 1].id;
        usrSystAdm.TimeZoneSidKey='America/Los_Angeles';
        usrSystAdm.UserName='syst_' + String.valueOf(system.now().gettime())+'@testorg.com';
        //usrSystAdm.UserRoleId = rCSE.Id;
       // insert usrCSE;
        insert usrSystAdm;
        
       
       
         
        List<UserRole> ur = new List<UserRole>();
        List<User> userToIns = new List<User>();
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        //UserRole r = [Select id ,ParentRoleId , name from userrole where Name like '%CSE%' LIMIT 1];
       // ur.add(r);
       // insert ur; 
       //EC start 2018 - 10 - 23 
        Id profileCSEId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_BO_CSE' LIMIT 1].id;
    Id profileDLId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_Direttore_Lavori' LIMIT 1].id;
    Id profileCMId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_City_Manager' LIMIT 1].id;
        Id profileAMId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_Responsabile Area Territoriale' LIMIT 1].id;
    Id profileHSEId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_HSE_Roma' LIMIT 1].id;
    Id profileREId = [SELECT Id FROM Profile WHERE Name = 'CQS_Relazioni_Esterne' LIMIT 1].id;

        UserRole rCSE = [Select id, ParentRoleId , name from userrole where DeveloperName like '%CSE_Sud%' LIMIT 1];
    UserRole rCM = [Select id ,ParentRoleId , name from userrole where DeveloperName like '%City_Manager_Sud%' LIMIT 1];
    UserRole rDL = [Select id ,ParentRoleId , name from userrole where DeveloperName like '%Direttore_Lavori_Sud%' LIMIT 1];
    UserRole rAM = [Select id ,ParentRoleId , name from userrole where DeveloperName like '%Responsabile_Territoriale_Sud%' LIMIT 1];
    UserRole rRE = [Select id ,ParentRoleId , name from userrole where DeveloperName like '%Relazioni_Esterne%' LIMIT 1];
    UserRole rHSE = [Select id ,ParentRoleId , name from userrole where DeveloperName = 'Open_Fiber_Roma_HSFQ' LIMIT 1];
         ur.add(rCM);
         ur.add(rCSE);
         ur.add(rDL);
         ur.add(rAM);
         ur.add(rRE);
         ur.add(rHSE);
      // insert ur; 
       // EC CSE
        User usrCSE = new User();
        usrCSE.Alias = 'cse';
        usrCSE.Email='cse@testorg.com';
        usrCSE.EmailEncodingKey='UTF-8';
        usrCSE.LastName='Testing';
        usrCSE.LanguageLocaleKey='en_US'; 
        usrCSE.LocaleSidKey='en_US';
        usrCSE.ProfileId = profileCSEId;
        usrCSE.TimeZoneSidKey='America/Los_Angeles';
        usrCSE.UserName='cse_' + String.valueOf(system.now().gettime())+'@testorg.com';
        usrCSE.UserRoleId = rCSE.Id;
       // insert usrCSE;
        insert usrCSE;
        
        //EC DL
        User usrDL = new User();
        usrDL.Alias = 'dl';
        usrDL.Email='dl@testorg.com';
        usrDL.EmailEncodingKey='UTF-8';
        usrDL.LastName='Testing';
        usrDL.LanguageLocaleKey='en_US'; 
        usrDL.LocaleSidKey='en_US';
        usrDL.ProfileId = profileDLId;
        usrDL.TimeZoneSidKey='America/Los_Angeles';
        usrDL.UserName='dl_' + String.valueOf(system.now().gettime())+'@testorg.com';
        usrDL.UserRoleId = rDL.Id;
        insert usrDL;
        
        //EC CM
        User usrCM = new User();
        usrCM.Alias = 'cm';
        usrCM.Email='cm@testorg.com';
        usrCM.EmailEncodingKey='UTF-8';
        usrCM.LastName='Testing';
        usrCM.LanguageLocaleKey='en_US'; 
        usrCM.LocaleSidKey='en_US';
        usrCM.ProfileId = profileCMId;
        usrCM.TimeZoneSidKey='America/Los_Angeles';
        usrCM.UserName='cm_' + String.valueOf(system.now().gettime())+'@testorg.com';
        usrCM.UserRoleId = rCM.Id;
        insert usrCM;
    
        //EC AM
        User usrAM = new User();
        usrAM.Alias = 'am';
        usrAM.Email='am@testorg.com';
        usrAM.EmailEncodingKey='UTF-8';
        usrAM.LastName='Testing';
        usrAM.LanguageLocaleKey='en_US'; 
        usrAM.LocaleSidKey='en_US';
        usrAM.ProfileId = profileAMId;
        usrAM.TimeZoneSidKey='America/Los_Angeles';
        usrAM.UserName='am_' + String.valueOf(system.now().gettime())+'@testorg.com';
        usrAM.UserRoleId = rAM.Id;
        insert usrAM;
    
        //EC RE
        User usrRE = new User();
        usrRE.Alias = 're';
        usrRE.Email='re@testorg.com';
        usrRE.EmailEncodingKey='UTF-8';
        usrRE.LastName='Testing';
        usrRE.LanguageLocaleKey='en_US'; 
        usrRE.LocaleSidKey='en_US';
        usrRE.ProfileId = profileREId;
        usrRE.TimeZoneSidKey='America/Los_Angeles';
        usrRE.UserName='re_' + String.valueOf(system.now().gettime())+'@testorg.com';
        usrRE.UserRoleId = rRE.Id;
        insert usrRE;
        
        //EC HSE
        User usrHSE = new User();
        usrHSE.Alias = 'hse';
        usrHSE.Email='hse@testorg.com';
        usrHSE.EmailEncodingKey='UTF-8';
        usrHSE.LastName='Testing';
        usrHSE.LanguageLocaleKey='en_US'; 
        usrHSE.LocaleSidKey='en_US';
        usrHSE.ProfileId = profileHSEId;
        usrHSE.TimeZoneSidKey='America/Los_Angeles';
        usrHSE.UserName='re_' + String.valueOf(system.now().gettime())+'@testorg.com';
        usrHSE.UserRoleId = rHSE.Id;
        insert usrHSE ;
        
    
       // insert userToIns;
       // 
       
         String optSceltaComune = 'Alessandria';
        
        List<OF_CQS_Anagrafica__c> anaList = new List<OF_CQS_Anagrafica__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.OwnerId= usrSystAdm.id;
        anag.CQS_Check_Affidataria__c = true;
        anag.Name = 'test';
        anaList.add(anag);
        OF_CQS_Anagrafica__c anag1 = new OF_CQS_Anagrafica__c();
        anag1.CQS_Check_Affidataria__c = true;
        anag1.Name = 'TEST';
        anag1.OwnerId= usrSystAdm.id;
        insert anag1;
        anaList.add(anag1);
        OF_CQS_Anagrafica__c anag2 = new OF_CQS_Anagrafica__c();
        anag2.CQS_Check_Affidataria__c = true;
        anag2.Name = 'TEST2';
        anag2.OwnerId= usrSystAdm.id;
        insert anag2;
        anaList.add(anag2);
        OF_CQS_Anagrafica__c anag3 = new OF_CQS_Anagrafica__c();
        anag3.CQS_Check_Affidataria__c = true;
        anag3.Name = 'TEST3';
        anag3.OwnerId= usrSystAdm.id;
        insert anag3;
        anaList.add(anag3);
        OF_CQS_Anagrafica__c anag4 = new OF_CQS_Anagrafica__c();
        anag4.CQS_Check_Affidataria__c = true;
        anag4.OwnerId= usrSystAdm.id;
        anag4.Name = 'TEST4';
        insert anag4;
        anaList.add(anag4);
        OF_CQS_Anagrafica__c anag5 = new OF_CQS_Anagrafica__c();
        anag5.CQS_Check_Affidataria__c = true;
        anag5.Name = 'TEST5';
        anag5.OwnerId= usrSystAdm.id;
        insert anag5;
        anaList.add(anag5);
       // insert anaList;
       //  TEST2 TEST3 TEST4 TEST5'
        OF_CQS_Anagrafica__c anagRTI = new OF_CQS_Anagrafica__c();
        anagRTI.CQS_Check_Affidataria__c = true;
        
        anagRTI.Name ='RTI - TEST TEST2 TEST3 TEST4 TEST5';
        anagRTI.RecordTypeId=[Select id from RecordType where SobjectType='OF_CQS_Anagrafica__c' AND DeveloperName='CQS_Imprese_in_raggruppamento'].id;
        anagRTI.CQS_An_ConsorziataCapogruppo__c =anag1.id;
    anagRTI.CQS_An_Consorziata_2__c = anag2.id;
    anagRTI.CQS_An_Consorziata_3__c = anag3.id;
    anagRTI.CQS_An_Consorziata_4__c = anag4.id;
    anagRTI.CQS_An_Consorziata_5__c = anag5.id;
        anagRTI.OwnerId= usrSystAdm.id;
    insert anagRTI;
            
       
        String ragSocialeImpresa = anagRTI.Name;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.Name = 'optSceltaComune Lotto 1';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        pro.CQS_Pro_LDO__c='Test';
        pro.CQS_Pro_Comune__c=optSceltaComune;
        pro.OwnerId=usrSystAdm.id;
        insert pro;
        String ldoStr= pro.CQS_Pro_LDO__c;
        
        Map<String,String> regMapName = new Map<String, String>();
        regMapName.put(pro.Name,ragSocialeImpresa);
        
        
        List<Progetto_Utente_junction__c> pujList = new List<Progetto_Utente_junction__c>();
        
        //EC Projen DL
        Progetto_Utente_junction__c projenDL = new Progetto_Utente_junction__c();
        projenDL.CQS_junc_progetto__c = pro.Id;
        projenDL.CQS_junc_user__c = usrDL.id;
        projenDl.OwnerId= usrSystAdm.id;
        //projenDL.CQS_junc_progetto__r.Name= pro.Name;
        pujList.add(projenDL);
        
        
        //EC projen CSE
        Progetto_Utente_junction__c projenCSE = new Progetto_Utente_junction__c();
        projenCSE.CQS_junc_progetto__c = pro.Id;
        projenCSE.CQS_junc_user__c = usrCSE.id;
        projenCSE.CQS_junc_progetto__c= pro.id;
        projenCSE.OwnerId =usrSystAdm.id;
        //projen.CQS_junc_progetto__r.Name= pro.Name;
        pujList.add(projenCSE);
        
        //EC projen  CM
        Progetto_Utente_junction__c projenCM = new Progetto_Utente_junction__c();
        projenCM.CQS_junc_progetto__c = pro.Id;
        projenCM.CQS_junc_user__c = usrCM.id;
        projenCM.OwnerId=usrSystAdm.id;
        //projenCM.CQS_junc_progetto__r.Name= pro.Name;
        pujList.add(projenCM);
        
        insert pujList;
    
    CQS_Prog_An_junc__c jnt = new CQS_Prog_An_junc__c();
        jnt.CQS_Praj_Progetto__c = pro.id;
        jnt.CQS_Praj_Ragione_Sociale__c = anag.Id ;
        jnt.ownerId =usrSystAdm.id;
        //jnt.CQS_Praj_Progetto__r.CQS_Pro_Comune__c = optSceltaComune; 
        insert jnt;
         
        List<SelectOption> optListaProgetti = new List<SelectOption>();
        optListaProgetti.add(new SelectOption(projenDL.CQS_junc_progetto__c,pro.Name)); 
        Map<String,String> ldoMap = new Map<String, String>();
        Map<String,String> rsocial = new Map<String, String>();
        Map<String,String> regMap = new Map<String, String>();
         
        ldoMap.put(pro.id,pro.CQS_Pro_LDO__c);
        regMap.put(pro.id,anag.id);
        
        //Risorse Impiegate
         Set<Id> risImpIdSet = new Set<Id>();
         
        List<OF_CQS_Risorse_Impiegate__c> risImpListPian = new List<OF_CQS_Risorse_Impiegate__c>();
        OF_CQS_Risorse_Impiegate__c risImpP = new OF_CQS_Risorse_Impiegate__c();
        risImpP.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpP.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpP.OwnerId=usrDL.id;
        risImpP.CQS_RisImp_Progetto__c = pro.Id;
        risImpP.CQS_RI_LDO__c = 'Test';
        risImpP.OwnerId= usrDL.id; 
        risImpP.CQS_RisImp_Data__c = System.today();
        risImpP.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpP.CQS_RisImp_Somma_FTE__c = '135';
       

        risImpP.recordtypeid=RTidRisImpPian;
       
         
    
        risImpListPian.add(risImpP);
        insert risImpListPian; 
        
        //Pianificato settimanale 
        
        List<OF_CQS_Risorse_Impiegate__c> risImpListPianSETT1 = new List<OF_CQS_Risorse_Impiegate__c>();
        OF_CQS_Risorse_Impiegate__c risImpPS1 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS1.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpPS1.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        
        risImpPS1.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS1.CQS_RI_LDO__c = 'Test';
        risImpPS1.OwnerId= usrDL.id;  
        risImpPS1.CQS_RisImp_Data__c = System.today().addDays(-21);
        risImpPS1.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS1.CQS_RisImp_Somma_FTE__c = '135';
       

        risImpPS1.recordtypeid=RTidRisImpPianSETT;
       
      
    OF_CQS_Risorse_Impiegate__c risImpPS2 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS2.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpPS2.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpPS2.OwnerId= usrDL.id; 
        risImpPS2.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS2.CQS_RI_LDO__c = 'Test';
         
        risImpPS2.CQS_RisImp_Data__c = System.today().addDays(-14);
        risImpPS2.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS2.CQS_RisImp_Somma_FTE__c = '135';
       

        risImpPS2.recordtypeid=RTidRisImpPianSETT;
    
     OF_CQS_Risorse_Impiegate__c risImpPS3 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS3.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpPS3.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpPS3.OwnerId= usrDL.id; 
        risImpPS3.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS3.CQS_RI_LDO__c = 'Test';
         
        risImpPS3.CQS_RisImp_Data__c = System.today().addDays(-7);
        risImpPS3.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS3.CQS_RisImp_Somma_FTE__c = '335';
       

        risImpPS3.recordtypeid=RTidRisImpPianSETT;
       
      
    OF_CQS_Risorse_Impiegate__c risImpPS4 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS4.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpPS4.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpPS4.OwnerId= usrDL.id; 
        risImpPS4.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS4.CQS_RI_LDO__c = 'Test';
         
        risImpPS4.CQS_RisImp_Data__c = System.today();
        risImpPS4.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS4.CQS_RisImp_Somma_FTE__c = '335';
       

        risImpPS4.recordtypeid=RTidRisImpPianSETT;
       
        OF_CQS_Risorse_Impiegate__c risImpPS5 = new OF_CQS_Risorse_Impiegate__c();
        risImpPS5.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpPS5.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpPS5.OwnerId= usrDL.id; 
        risImpPS5.CQS_RisImp_Progetto__c = pro.Id;
        risImpPS5.CQS_RI_LDO__c = 'Test';
         
        risImpPS5.CQS_RisImp_Data__c = System.today().addDays(+7);
        risImpPS5.OF_CQS_Comune_Ris_Imp__c=  optSceltaComune;
        risImpPS5.CQS_RisImp_Somma_FTE__c = '335';
       

        risImpPS5.recordtypeid=RTidRisImpPianSETT; 
     
    
        risImpListPianSETT1.add(risImpPS1);
    risImpListPianSETT1.add(risImpPS2);
    risImpListPianSETT1.add(risImpPS3);
    risImpListPianSETT1.add(risImpPS4);
    risImpListPianSETT1.add(risImpPS5);
        insert risImpListPianSETT1; 
        //End Pianificato Settimanale
        
        List<OF_CQS_Risorse_Impiegate__c> risImpListCons = new List<OF_CQS_Risorse_Impiegate__c>();
        OF_CQS_Risorse_Impiegate__c risImpC = new OF_CQS_Risorse_Impiegate__c();
        risImpC.CQS_RisImp_Impresa_Mandataria__c = anagRTI.Id;
        risImpC.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        risImpC.OF_CQS_Contrattista_Lotto2__c = anag2.Id;
        risImpC.OF_CQS_Contrattista_Lotto3__c = anag3.Id;
        risImpC.OF_CQS_Contrattista_Lotto4__c = anag4.Id;
        risImpC.OF_CQS_Contrattista_Lotto5__c = anag5.Id;
        risImpC.OwnerId= usrDL.id; 
        
        risImpC.CQS_RisImp_Progetto__c = pro.Id;
        risImpC.CQS_RI_LDO__c = 'Test';
         
        risImpC.CQS_RisImp_Data__c = System.today().addDays(+2);
         
        risImpC.CQS_RisImp_FTE_altre_attivita__c = '2';
        risImpC.CQS_RisImp_FTE_lavori_civili__c  = '7';
        risImpC.CQS_RisImp_FTE_ldelivery_vertadd__c = '9';
        risImpC.CQS_RisImp_FTE_lavoriOttici_posacavo__c ='20';
        risImpC.CQS_RisImp_FTElavori_ottici_giunzcoll__c ='15';
        
        risImpC.CQS_RisImp_FTE_altre_attivita2__c = '1';
        risImpC.CQS_RisImp_FTE_lavori_civili2__c  = '4';
        risImpC.CQS_RisImp_FTE_ldelivery_vertadd2__c = '1';
        risImpC.CQS_RisImp_FTE_lavoriOttici_posacavo2__c ='2';
        risImpC.CQS_RisImp_FTElavori_ottici_giunzcoll2__c ='5';
    
    risImpC.CQS_RisImp_FTE_altre_attivita3__c = '2';
        risImpC.CQS_RisImp_FTE_lavori_civili3__c  = '3';
        risImpC.CQS_RisImp_FTE_ldelivery_vertadd3__c = '1';
        risImpC.CQS_RisImp_FTE_lavoriOttici_posacavo3__c ='4';
        risImpC.CQS_RisImp_FTElavori_ottici_giunzcoll3__c ='1';
    
    risImpC.CQS_RisImp_FTE_altre_attivita4__c = '0';
        risImpC.CQS_RisImp_FTE_lavori_civili4__c  = '3';
        risImpC.CQS_RisImp_FTE_ldelivery_vertadd4__c = '2';
        risImpC.CQS_RisImp_FTE_lavoriOttici_posacavo4__c ='0';
        risImpC.CQS_RisImp_FTElavori_ottici_giunzcoll4__c ='1';
    
    risImpC.CQS_RisImp_FTE_altre_attivita5__c = '2';
        risImpC.CQS_RisImp_FTE_lavori_civili5__c  = '7';
        risImpC.CQS_RisImp_FTE_ldelivery_vertadd5__c = '4';
        risImpC.CQS_RisImp_FTE_lavoriOttici_posacavo5__c ='2';
        risImpC.CQS_RisImp_FTElavori_ottici_giunzcoll5__c ='5';
        
         risImpC.CQS_RisImp_TipoRapporto__c='Consuntivo';

        risImpC.recordtypeid=RTidRisImpCons;
        risImpC.OF_CQS_Comune_Ris_Imp__c = optSceltaComune; 
         
        OF_CQS_Risorse_Impiegate__c risImpC2 = new OF_CQS_Risorse_Impiegate__c();
        risImpC2.CQS_RisImp_Impresa_Mandataria__c = anag.Id;
        risImpC2.OF_CQS_Contrattista_Lotto1__c = anag.Id;
        risImpC2.CQS_RisImp_TipoRapporto__c='Consuntivo';
        risImpC2.CQS_RisImp_Progetto__c = pro.Id;
        risImpC2.CQS_RI_LDO__c = 'Test';
        risImpC2.OwnerId= usrDL.id; 
         
        risImpC2.CQS_RisImp_Data__c = System.today().addDays(+3);
         
        risImpC2.CQS_RisImp_FTE_altre_attivita__c = '15';
        risImpC2.CQS_RisImp_FTE_lavori_civili__c  = '17';
        risImpC2.CQS_RisImp_FTE_ldelivery_vertadd__c = '6';
        risImpC2.CQS_RisImp_FTE_lavoriOttici_posacavo__c    ='12';
        risImpC2.CQS_RisImp_FTElavori_ottici_giunzcoll__c ='10';

        risImpC2.recordtypeid=RTidrisImpCons;
       
         
        risImpC2.OF_CQS_Comune_Ris_Imp__c = optSceltaComune ; 
        
        OF_CQS_Risorse_Impiegate__c risImpC3 = new OF_CQS_Risorse_Impiegate__c();
        risImpC3.CQS_RisImp_Impresa_Mandataria__c = anagRTI.Id;
        risImpC3.OF_CQS_Contrattista_Lotto1__c = anag1.Id;
        risImpC3.OF_CQS_Contrattista_Lotto2__c = anag2.Id;
        risImpC3.OF_CQS_Contrattista_Lotto3__c = anag3.Id;
        risImpC3.OF_CQS_Contrattista_Lotto4__c = anag4.Id;
        risImpC3.OF_CQS_Contrattista_Lotto5__c = anag5.Id;
        risImpC3.OwnerId= usrDL.id;
        risImpC3.CQS_RisImp_Progetto__c = pro.Id;
        risImpC3.CQS_RI_LDO__c = 'Test';
         
        risImpC3.CQS_RisImp_Data__c = System.today().addDays(+3);
         
        risImpC3.CQS_RisImp_FTE_altre_attivita__c = '2';
        risImpC3.CQS_RisImp_FTE_lavori_civili__c  = '7';
        risImpC3.CQS_RisImp_FTE_ldelivery_vertadd__c = '9';
        risImpC3.CQS_RisImp_FTE_lavoriOttici_posacavo__c ='20';
        risImpC3.CQS_RisImp_FTElavori_ottici_giunzcoll__c ='15';
        
        risImpC3.CQS_RisImp_FTE_altre_attivita2__c = '1';
        risImpC3.CQS_RisImp_FTE_lavori_civili2__c  = '4';
        risImpC3.CQS_RisImp_FTE_ldelivery_vertadd2__c = '1';
        risImpC3.CQS_RisImp_FTE_lavoriOttici_posacavo2__c ='2';
        risImpC3.CQS_RisImp_FTElavori_ottici_giunzcoll2__c ='5';
    
    risImpC3.CQS_RisImp_FTE_altre_attivita3__c = '2';
        risImpC3.CQS_RisImp_FTE_lavori_civili3__c  = '3';
        risImpC3.CQS_RisImp_FTE_ldelivery_vertadd3__c = '1';
        risImpC3.CQS_RisImp_FTE_lavoriOttici_posacavo3__c ='4';
        risImpC3.CQS_RisImp_FTElavori_ottici_giunzcoll3__c ='1';
    
    risImpC3.CQS_RisImp_FTE_altre_attivita4__c = '0';
        risImpC3.CQS_RisImp_FTE_lavori_civili4__c  = '3';
        risImpC3.CQS_RisImp_FTE_ldelivery_vertadd4__c = '2';
        risImpC3.CQS_RisImp_FTE_lavoriOttici_posacavo4__c ='0';
        risImpC3.CQS_RisImp_FTElavori_ottici_giunzcoll4__c ='1';
    
    risImpC3.CQS_RisImp_FTE_altre_attivita5__c = '2';
        risImpC3.CQS_RisImp_FTE_lavori_civili5__c  = '7';
        risImpC3.CQS_RisImp_FTE_ldelivery_vertadd5__c = '4';
        risImpC3.CQS_RisImp_FTE_lavoriOttici_posacavo5__c ='2';
        risImpC3.CQS_RisImp_FTElavori_ottici_giunzcoll5__c ='5';
        
         risImpC3.CQS_RisImp_TipoRapporto__c='Consuntivo';

        risImpC3.recordtypeid=RTidrisImpCons;
        risImpC3.OF_CQS_Comune_Ris_Imp__c = optSceltaComune; 
         
        
        risImpListCons.add(risImpC);
        risImpListCons.add(risImpC2);
        risImpListCons.add(risImpC3);
        risImpIdSet.add(risImpC.id);
        risImpIdSet.add(risImpC.id);
        risImpIdSet.add(risImpC3.id);
         
        insert risImpListCons; 
      //insert risImpIdSet; 
        
        //end Risorse Impiegate
        
         ApexPages.StandardController sc = new ApexPages.StandardController(risImpC);
        
         CQS_RisorseImpiegateController tRisImp = new CQS_RisorseImpiegateController(sc);
        
        ApexPages.currentPage().getParameters().put('consRis','true'); 
        ApexPages.currentPage().getParameters().put('optSceltaComune',optSceltaComune); 
         
        test.startTest();
        
        String nomeImpresa=regMapName.get(pro.Name);
       // tRisImp.definisciProgettiPl2(ComuneSelezionato);
        tRisImp.definisciProgettiPl2(optSceltaComune);
        tRisImp.defineLDO();
        tRisImp.definisciProgettiPlsO(optSceltaComune);
        tRisImp.definisciProgettiPl();
    //    System.assertEquals(false,tRisImp.defAtiBool(anag1.Name));
       
      //  System.assertEquals(true,tRisImp.defAtiBool(anagRTI.Name));
       
      //  tRisImp.passaParComune();
        tRisImp.SalvaConsuntivo();
        tRisImp.tornaSelezioneComune();
        
         CQS_RisorseImpiegateController.codeCoverage(2);
      
         test.stopTest();
     }
    
    */

}
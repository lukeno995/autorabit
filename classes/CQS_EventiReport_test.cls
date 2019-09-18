@isTest
public class CQS_EventiReport_test{
    
    public static testmethod void  CQS_EventiReportMethod(){
    
       OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name Like '%CQS%' LIMIT 1];
        User usr = new User();
        usr.Alias = 'cqsTest';
        usr.Email='cqsTest@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName='cqsTest@testorg.com';
        insert usr;
        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        OF_CQS_Ispezione__c even = new OF_CQS_Ispezione__c();
        even.OF_CQS_Impresa_Mandataria__c = anag.Id;
        even.OF_CQS_Impresa_Ispezionata__c= anag.id; 
        even.Ora_Inizio_Sopralluogo__c='07:22';
        even.CQS_ISP_Progetto__c =pro.id;
       //insert even;
        List<OF_CQS_Ispezione__c > eventiList=new List<OF_CQS_Ispezione__c >();
        eventiList=[select id from OF_CQS_Ispezione__c];
       system.debug('Testing' + [select id from OF_CQS_Ispezione__c ]);
        system.runas(usr){
        
         CQS_EventiReport billing = new  CQS_EventiReport();
       // billing.Ispezioni = 'Test';
        billing.combotypeout='Ispezioni';
        billing.ispezioniList=eventiList;
        billing.setPaginationI();
        billing.getIspezioniPagina();
        billing.displayMethod();
        boolean hp=billing.hasNext;
        billing.hasPrevious=true;
        billing.first();
        billing.last();
        billing.previous();
        billing.Next();
        billing.downloadasExcel();
        billing.getComboType();
    }
    
    }
    public static testmethod void  CQS_EventiReportMethod1(){
    
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name Like '%CQS%' LIMIT 1];
        User usr = new User();
        usr.Alias = 'cqsTest';
        usr.Email='cqsTest@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName='cqsTest@testorg.com';
        insert usr;
        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        OF_CQS_Evento__c even = new OF_CQS_Evento__c();
        even.OF_CQS_Impresa_Mandataria__c = anag.Id;
        even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        even.OF_CQS_Data_Evento__c = System.today();
        even.OF_CQS_Rispetto_Procedura__c = 'SI';
        even.OF_CQS_Inadempienze_Operative__c=True;
        even.CQS_Ev_Progetto__c =pro.id;
        insert even;
        List<OF_CQS_Evento__c> eventiList=new List<OF_CQS_Evento__c>();
        eventiList=[select id from of_cqs_evento__c];
       system.debug('Testing' + [select id from OF_CQS_Evento__c ]);
        system.runas(usr){
        
         CQS_EventiReport billing = new  CQS_EventiReport();
       // billing.Ispezioni = 'Test';
        billing.combotypeout='Eventi';
        billing.dateFrom=system.today();
        billing.dateto=system.today();
        billing.tipoEvento='Test';
        billing.tipoIspezione='Test';
        billing.nomeProgetto='Test';
        billing.optScelta='Test';
        billing.userID=usr.id;
        billing.ev=even;
        billing.eventiList=eventiList;
        billing.setPagination();
        billing.getEventiPagina();
        billing.displayMethod();
        boolean hp=billing.hasNext;
        boolean hn=billing.hasPrevious;
        billing.intPageNumber=2;
        billing.intNumberofPages=3;
        boolean hp1=billing.hasNext;
        boolean hn1=billing.hasPrevious;
        billing.hasPrevious=true;
        billing.first();
        billing.last();
        billing.previous();
        billing.Next();
        billing.downloadasExcel();
        billing.getComboType();
    }
    }
}
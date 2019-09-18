@isTest
public class CQS_Isp2L_SelezioneTipoIspCntrlTEST {
    
    public static testMethod void IspezioneMethod1(){
        Ispezione_II_Livello__c isp2L = new Ispezione_II_Livello__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(isp2L);
        CQS_Isp2L_SelezioneTipoIspController ispSC = new CQS_Isp2L_SelezioneTipoIspController(sc);
        
        List<SelectOption> optList = new  List<SelectOption>();
        List<String> tipiIspezione = new  List<String>();
        ispSC.optScelta= 'Verifica Rispetto Adempimenti Contrattuali Societa di Servizio';
        ispSC.shortOpt='SocServ';
      
        
        ispSC.optListaComuni = new List<SelectOption>();
       // ispSC.optListaComuni.add(new SelectOption('Alessandria','Alessandria'));
        ispSC.optListaRegioni = new List<SelectOption>();
     //   ispSC.optListaRegioni.add(new SelectOption('Piemonte','Piemonte'));
        Set<String> nomeComuneSet = new Set<String>();
        Map<String,Set<String>> RegioneProvMap = new Map<String,Set<String>>();
        Map<String,String> ProvComuneMap = new Map<String,String>();
        Map<Id,String> roleIdRoleNameMap = new Map<Id,String>();
        String userGeoZone;
        String roleName;
        ispSC.optSceltaRegione='Piemonte';
        ispSC.optSceltaComune ='Alessandria';
        Set<String> setComuniRegioneScelta = new Set<String>();
        Set<String> regioneSet = new Set<String>();
        regioneSet.add('Piemonte');
        Set<String> provSet = new Set<String>();
        String nomeRegione='Piemonte' ; //to substitute with optSceltaRegione
        Boolean isCM;
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
       // 
       // 
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
        
        PageReference pageRef = Page.CQS_Isp2L_AdempimentiSS;
        
        Test.setCurrentPage(pageRef);
        
        ApexPages.CurrentPage().getParameters().put('shortOpt','SocServ');
        ApexPages.CurrentPage().getParameters().put('Prov','Alessandria');
        ApexPages.CurrentPage().getParameters().put('roleName',roleNameIsp2LNord);
        ApexPages.CurrentPage().getParameters().put('optSceltaRegione','Piemonte');
        
       
        test.startTest();
        ispSC.scegliRegioneAndComune(roleNameIsp2LNord);
        ispSC.scegliRegioneAndComune(roleNameIsp2LCS);
        ispSC.scegliRegioneAndComune(roleNameVuoto);
        ispSC.definisciComuniPl(usrAtt.id);
        ispSC.scegliTipoIspezione();
        ispSC.pagPresel();
        pageRef = Page.CQS_Isp2L_AdempimentiRL;
        ispSC.optScelta= 'Verifica Rispetto Adempimenti Contrattuali RL';
        ispSC.shortOpt='RL';
        ApexPages.CurrentPage().getParameters().put('shortOpt','RL');
        ispSC.pagPresel();
        pageRef = Page.CQS_Isp2L_AdempimentiDL;
        ispSC.optScelta= 'Verifica Rispetto Adempimenti Contrattuali DL';
        ispSC.shortOpt='D0L';
        ApexPages.CurrentPage().getParameters().put('shortOpt','DL');
        ispSC.pagPresel();
        pageRef = Page.CQS_Isp2L_AdempimentiCSE;
        ispSC.optScelta= 'Verifica Rispetto Adempimenti Contrattuali CSE';
        ispSC.shortOpt='CSE';
        ApexPages.CurrentPage().getParameters().put('shortOpt','CSE');
        ispSC.pagPresel();
        
        
        test.stopTest();
        
        
    }
    
    
}
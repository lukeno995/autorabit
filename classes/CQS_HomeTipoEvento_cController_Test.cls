@isTest
public class CQS_HomeTipoEvento_cController_Test{
    
    List<User> users = [SELECT Id FROM User WHERE isActive=true and Profile.Name in('OF_CQS_City_Manager','OF_CQS_BO_CSE') Limit 2];
        Id User1Id = users[0].Id;
        Id User2Id = users[1].Id;
    
    
            		
			       
    public static testmethod void CQS_HomeTipoEvento_cControllerMethod(){
     
   list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c'];
//   list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/

  //  Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('OF_CQS_Interferenza_Sottoservizi').getRecordTypeId();

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
        
        OF_CQS_Evento__c ev = new OF_CQS_Evento__c();
        ev.OF_CQS_Impresa_Mandataria__c = anag.Id;
        ev.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        ev.CQS_Ev_Progetto__c=pro.Id;
        ev.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        ev.OF_CQS_Data_Evento__c = System.today();
        ev.OF_CQS_Rispetto_Procedura__c = 'Sì';
        ev.OF_CQS_Diffida__c  = FALSE;
        ev.OF_CQS_Inadempienze_Operative__c = FALSE;
        //ev.RecordTypeId = rtId;
        ev.recordtypeid= rtype[0].id;
        //ev.recordtypeid=RecordTypeIdevent;
        ev.OF_CQS_Richiesta_Danni__c  = true;
        insert ev;
        
      
        Map<Id,Id> mapEvProg = new Map<Id,Id>();
        mapEvProg.put(ev.id,ev.CQS_Ev_Progetto__c);
        
        Set<Id> SetProgetti = new Set<Id>();
        for(CQS_Progetto__c pro2:[select id from CQS_Progetto__c]){
                                SetProgetti.add(pro2.Id);
        }
        Map<Id, list<Id>> pMap = new Map<Id, list<Id>>();     
        for(CQS_Progetto__c pro1: [select Id, (select CQS_junc_user__c, CQS_junc_user__r.IsActive from Progetto_Utente_junctions__r)
                                      from CQS_Progetto__c where ID in:setProgetti]){  
                                          List<Id> newList = new List<Id>();
                                          for(Progetto_Utente_junction__c u : pro.Progetto_Utente_junctions__r){
                                             if(u.CQS_junc_user__r.IsActive==true){ 
                                              newList.add(u.CQS_junc_user__c);
                                             }
                                          }

     					pmap.put(pro1.Id,newList);                                         
                }  
        
        ApexPages.currentPage().getParameters().put('optScelta','Interferenza a sottoservizi');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_Interferenze_a_sottoservizi' ,'test');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ev);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
        tevento.scegliTipoEvento();
        tevento.definisciProgettiPl();
        tevento.portaVF();
        tevento.salvaEvento();
    
    }
    public static testmethod void CQS_HomeTipoEvento_cControllerMethod1(){
     
  /* list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/

   // Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();

    /*Schema.DescribeSObjectResult efrSchema = Schema.SObjectType.OF_CQS_Evento__c; 
        Map<String,Schema.RecordTypeInfo> EventRecordTypeInfo = efrSchema.getRecordTypeInfosByName();
        Id rtId = EventRecordTypeInfo.get('Bad Practice').getRecordTypeId();*/
    list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c'];
        
     OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name Like '%CQS%' LIMIT 1];
        List<User> users = [SELECT Id, Alias, Email, EmailEncodingKey, LastName, LanguageLocaleKey, LocaleSidKey, ProfileId, TimeZoneSidKey, UserName FROM User WHERE isActive=true and Profile.Name in('OF_CQS_City_Manager','OF_CQS_BO_CSE') Limit 2];
        User usr = new User();
        if(users.size()>0){
        
        usr=users[0];
        }
       // usr2=users[1];
        
        else{
      //  User usr = new User();
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
        }
        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        OF_CQS_Evento__c ev = new OF_CQS_Evento__c();
        ev.OwnerId= usr.id;
        ev.OF_CQS_Impresa_Mandataria__c = anag.Id;
        ev.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        ev.CQS_Ev_Progetto__c=pro.Id;
        ev.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        ev.OF_CQS_Data_Evento__c = System.today();
        ev.OF_CQS_Rispetto_Procedura__c = 'Sì';
        ev.OF_CQS_Diffida__c  = FALSE;
        ev.OF_CQS_Inadempienze_Operative__c = FALSE;
        //ev.RecordTypeId = rtId;
        ev.recordtypeid= rtype[0].id;
      //  ev.recordtypeid=RecordTypeIdevent;
        ev.OF_CQS_Richiesta_Danni__c  = true;
        insert ev;
        
        
        Map<Id,Id> mapEvProg = new Map<Id,Id>();
        mapEvProg.put(ev.id,ev.CQS_Ev_Progetto__c);
      
        ApexPages.currentPage().getParameters().put('optScelta','Danneggiamento a terzi');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_DanneggiamentoAterzi' ,'test');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ev);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
        tevento.scegliTipoEvento();
        tevento.definisciProgettiPl();
        tevento.portaVF();
        tevento.salvaEvento();
        
        
    }
    public static testmethod void CQS_HomeTipoEvento_cControllerMethod2(){
     
  /* list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/

  //  Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();

    /*Schema.DescribeSObjectResult efrSchema = Schema.SObjectType.OF_CQS_Evento__c; 
        Map<String,Schema.RecordTypeInfo> EventRecordTypeInfo = efrSchema.getRecordTypeInfosByName();
        Id rtId = EventRecordTypeInfo.get('Bad Practice').getRecordTypeId();*/
        
        list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c'];
          
     OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name Like '%CQS%' LIMIT 1];
      
        List<User> users = [SELECT Id, Alias, Email, EmailEncodingKey, LastName, LanguageLocaleKey, LocaleSidKey, ProfileId, TimeZoneSidKey, UserName FROM User WHERE isActive=true and Profile.Name in('OF_CQS_City_Manager','OF_CQS_BO_CSE') Limit 2];
        User usr = new User();
        if(users.size()>0){
        
        usr=users[0];
        }
       // usr2=users[1];
        
        else{
      //  User usr = new User();
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
        }
        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        OF_CQS_Evento__c ev = new OF_CQS_Evento__c();
        ev.OF_CQS_Impresa_Mandataria__c = anag.Id;
        ev.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        ev.CQS_Ev_Progetto__c=pro.Id;
        ev.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        ev.OF_CQS_Data_Evento__c = System.today();
        ev.OF_CQS_Rispetto_Procedura__c = 'Sì';
        ev.OF_CQS_Diffida__c  = FALSE;
        ev.OF_CQS_Inadempienze_Operative__c = FALSE;
        //ev.RecordTypeId = rtId;
        ev.recordtypeid= rtype[0].id;
       // ev.recordtypeid=RecordTypeIdevent;
        ev.OF_CQS_Richiesta_Danni__c  = true;
        insert ev;
        
        Map<Id,Id> mapEvProg = new Map<Id,Id>();
        mapEvProg.put(ev.id,ev.CQS_Ev_Progetto__c);
       
        ApexPages.currentPage().getParameters().put('optScelta','Bad Practice');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_Evento' ,'test');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ev);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
        tevento.scegliTipoEvento();
        tevento.definisciProgettiPl();
        tevento.portaVF();
        tevento.salvaEvento();
    
    }
    public static testmethod void CQS_HomeTipoEvento_cControllerMethod3(){
     
  /* list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/

  //  Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();

    /*Schema.DescribeSObjectResult efrSchema = Schema.SObjectType.OF_CQS_Evento__c; 
        Map<String,Schema.RecordTypeInfo> EventRecordTypeInfo = efrSchema.getRecordTypeInfosByName();
        Id rtId = EventRecordTypeInfo.get('Bad Practice').getRecordTypeId();*/
        
         list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c'];
       
    
     OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.Name='Test - Test';
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name Like '%CQS%' LIMIT 1];
        
       // User usr = new User();
     //   User usr2 = new User();
        List<User> users = [SELECT Id, Alias, Email, EmailEncodingKey, LastName, LanguageLocaleKey, LocaleSidKey, ProfileId, TimeZoneSidKey, UserName FROM User WHERE isActive=true and Profile.Name in('OF_CQS_City_Manager','OF_CQS_BO_CSE') Limit 2];
        User usr = new User();
        if(users.size()>0){
        
        usr=users[0];
        }
       // usr2=users[1];
        
        else{
      //  User usr = new User();
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
        }

        
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        OF_CQS_Evento__c ev = new OF_CQS_Evento__c();
        ev.OF_CQS_Impresa_Mandataria__c = anag.Id;
        ev.CQS_Ev_Progetto__c=pro.Id;
        ev.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        ev.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        ev.OF_CQS_Data_Evento__c = System.today();
        ev.OF_CQS_Rispetto_Procedura__c = 'Sì';
        ev.OF_CQS_Diffida__c  = FALSE;
        ev.OF_CQS_Inadempienze_Operative__c = FALSE;
        //ev.RecordTypeId = rtId;
        ev.recordtypeid= rtype[0].id;
      //  ev.recordtypeid=RecordTypeIdevent;
        ev.OF_CQS_Richiesta_Danni__c  = true;
        insert ev;
        
        Id User1Id = users[0].Id;
       // Id User2Id = users[1].Id;
        
        Map<Id, list<Id>> pMap = new Map<Id, list<Id>>(); 
        Set<Id> SetProgetti = new Set<Id>();
        for(CQS_Progetto__c pro2:[select id from CQS_Progetto__c]){
                                SetProgetti.add(pro2.Id);
        }        
        for(CQS_Progetto__c pro1: [select Id, (select CQS_junc_user__c, CQS_junc_user__r.IsActive from Progetto_Utente_junctions__r)
                                      from CQS_Progetto__c where ID in:setProgetti]){  
                                          List<Id> newList = new List<Id>();
                                          for(Progetto_Utente_junction__c u : pro.Progetto_Utente_junctions__r){
                                             if(u.CQS_junc_user__r.IsActive==true){ 
                                              newList.add(u.CQS_junc_user__c);
                                             }
                                          }

     					pmap.put(pro1.Id,newList);                                         
                }  
        
        List<OF_CQS_Evento__Share> evShares = new List<OF_CQS_Evento__Share>();
        Map<Id,Id> mapEvProg = new Map<Id,Id>();
        mapEvProg.put(ev.id,ev.CQS_Ev_Progetto__c);
//		id idUser = pmap.get(mapEvProg.get(even.id);
      //  for(id idEv : mapEvProg.keySet()){
       //        for(id idUser : pmap.get(mapEvProg.get(idEv))){
                    OF_CQS_Evento__Share evRecord = new OF_CQS_Evento__Share();
                    evRecord.ParentId = ev.id;
                    evRecord.UserOrGroupId = User1Id;
                    evRecord.AccessLevel = 'read';
                	evRecord.RowCause = Schema.OF_CQS_Evento__Share.RowCause.Progetto_di_competenza__c;
                	//evRecord.RowCause = Schema.OF_CQS_Evento__Share.RowCause.TerritoryRule;
					evShares.add(evRecord);
                    System.debug('Gli user che hanno accesso a questo record sono: ' + evRecord.UserOrGroupId);
            //    }
         //   }  
        
        
        Case cse=new Case();
        insert cse;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId = ev.id;
        //insert attach;
        
        
        ApexPages.currentPage().getParameters().put('optScelta','Interferenza a sottoservizi');
        ApexPages.CurrentPage().getParameters().put('/apex/CQS_Interferenze_a_sottoservizi' ,'test');
       

        ApexPages.StandardController sc = new ApexPages.StandardController(ev);
        CQS_HomeTipoEvento_cController tevento = new CQS_HomeTipoEvento_cController(sc);
        tevento.parentId = 'Test';
        tevento.pageName = 'Test';
        tevento.evId = 'Test';
        tevento.errorMessage = 'Test';
        List<Integer>Listint = new List<Integer>();
        Integer ins = 123;
        Listint.add(ins);
        tevento.intList = Listint;
        
        pageReference p = Page.CQS_Evento;
        tevento.pageRef = p;
        
        List<String> stList = new List<String>();
        String st = 'Testing';
        stList.add(st);
        tevento.file  = attach;
        tevento.emList = stList;
        tevento.jPu = projen;
        tevento.scegliTipoEvento();
        tevento.definisciProgettiPl();
        tevento.portaVF();
        tevento.upload();
        tevento.fileUpload1();
       
        tevento.salvaEvento();
    
    }
}
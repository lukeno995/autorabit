@isTest
public class PO_P2PAttiva_EditLogInfoCntrlELineTEST {
    
    public static testMethod  Map<String,Id> creart(){
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        return mpRT;
    }
    
    public static testMethod void testMeth1(){
        TestDataFactory.CreateTestRecords(null,null, null);
        OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica.OF_ProfiloCommerciale__c = 'P2PATTIVA_10G';
        codifica.OF_ListinoCanoneName__c ='P2PATTIVA_10G';
        codifica.Name = '10G';
        codifica.IsPortalValid__c = true;
        codifica.servizio__c='P2P Attiva';
        codifica.CosType__c='MULTI_COS';
        insert codifica;
        
        
        OF_CodificaProfiloListini__c codifica3 = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica3.OF_ProfiloCommerciale__c = 'P2PATTIVA_5G';
        codifica3.OF_ListinoCanoneName__c ='P2PATTIVA_5G';
        codifica3.Name = '5G';
        codifica3.IsPortalValid__c = true;
        codifica3.servizio__c='P2P Attiva';
        codifica3.CosType__c='MONO_COS';
        
        insert codifica3;
        Map<String,Id> mpRT = creart();
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Id p = [select id from profile where name='Partner Community User'].id;  
        
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId=mpRT.get('OLO');
        acc.EOF_Codice_Operatore__c='TST';
        acc.VATNumber__c='00246465465';
        acc.Status__c='Attivo';
        acc.StartDate__c=DateTime.newInstance(2019, 4, 3, 3, 1, 5);
        
        insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
        
        insert cnt;
        
        list <Contact> cntList = new List<Contact>();
        cntList.add(cnt);
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                             ContactId = cnt.Id,
                             timezonesidkey='America/Los_Angeles', username='standarduse01rtest@testorg.com');
        
        insert user;
        
        /*  User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];

usr.ContactId=cnt.id;
//  update usr;
//  */
        
        Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
        OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
        
        EOF_EAI_Service_Log__c slC= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slC.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        slC.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        slC.PO_Tipo_percorso__c='Singola Via';
        slC.PO_Indirizzo_collegamento__c='via test';
        slC.EOF_Comune__c='Roma';
        slC.EOF_Stato_Richiesta__c='Accettato';
        slC.PO_Offerta__c='P2P Attiva';
        slC.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slC.PO_Tipo_di_collegamento__c='Point-to-Point';
        slC.PO_Prime_Contractor__c='TEST';
        slC.PO_Incluso_nell_offerta__c=true;
        slC.PO_Numero_fibre_richieste__c='2';
        slC.EOF_PROFILO__c='1';
        slC.PO_Sito__c='test';
        slC.PO_Civico__c='12';
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        slList.add(slC);
        insert slList;
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('P2P_Attiva_Request_E_Line');
        slFatt.PO_Tipo_di_collegamento__c ='E-Line' ;
        slFatt.EOF_Tipo_Comunicazione_String__c='Ordine di Attivazione';
        // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        
        
        EOF_EAI_Service_Log__c slM= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slM.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        slM.EOF_Codice_Ordine_OLO__c = 'TestM_9808980';
        slM.PO_Tipo_percorso__c='Singola Via';
        slM.PO_Indirizzo_collegamento__c='via test';
        slM.EOF_Comune__c='Roma';
        slM.EOF_Stato_Richiesta__c='Accettato';
        slM.PO_Offerta__c='P2P Attiva';
        slM.EOF_Codice_Operatore__c='TIS';
        //slM.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slM.PO_Tipo_di_collegamento__c='Point-to-Point';
        slM.Tipologia_Sede__c='Master';
        
        slM.PO_Prime_Contractor__c='TEST';
        slM.PO_Incluso_nell_offerta__c=true;
        slM.PO_Numero_fibre_richieste__c='2';
        //slM.EOF_PROFILO__c='1';
        slM.PO_Sito__c='test';
        slM.PO_Civico__c='12';
        slM.EOF_SL_Riferimento__c=slFatt.id;
        insert slM;
        //slM.ID_Sede__c= slM.Name;
        //update slM;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.Tipologia_Sede__c='Satellite';
        sl.ID_Sede_Master__c = slM.ID_Sede__c;
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        insert sl;
        
        //  slList.add(sl);
        //  
        List<EOF_EAI_Service_Log__c> slCollList = new List<EOF_EAI_Service_Log__c>();
        slCollList.add(sl);
        slCollList.add(slM);
        
        EOF_EAI_Service_Log__c slKit = new EOF_EAI_Service_Log__c();
        slKit.recordtypeId = mpRT.get('PO_Log_P2P_Attiva_KIT');
        slKit.EOF_Stato_Richiesta__c ='NA';
        slKit.Nome_del_KIT__c='KIT_00001';
        slKit.Modello_di_Servizio__c='';
        slKit.EOF_CODICE_OPERATORE__c='TIS';//actualUser.Contact.Account.EOF_Codice_Operatore__c'';
        slKit.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        slKit.EOF_ID_Pop__c ='NA_01';
        slKit.PO_P2PAttiva_Nome_del_KIT__c='Kit_0001';
        slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'Via Test';
        slKit.PO_P2PAttiva_Optical_Rate_Limiting__c = '10 GB';
        slKit.EOF_SL_Riferimento__c = slFatt.id;
        slKit.kit_in_condivisione__c =sl.id;
        slKit.Service_Attribute__c ='EPL';//SERVICE_EPL
        
        insert slKit;
        slList.add(slKit);
        
        EOF_EAI_Service_Log__c sVlan1 = new EOF_EAI_Service_Log__c();
        
        sVlan1.EOF_SL_Riferimento__c=sl.id;
        sVlan1.OF_PP_KIT_Log__c=slkIT.id;
        sVlan1.PO_Nota_sito__c='Nota Sito';
        sVlan1.EOF_STATO_ORDINE__c='Accettato';
        sVlan1.OF_SA_USER_VLAN__C='1111';
        sVlan1.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan1.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan1.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan1.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        sVlan1.RecordTypeId=mpRT.get('OF_SA_Vlan_ELine');
        
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> slVlanList = new List<EOF_EAI_Service_Log__c>();
        slVlanList.add(sVlan1);
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
        parentCase.Status='Completato';
        parentCase.PO_Offerta__c ='P2P Attiva';
        parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
        parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
        parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
        insert parentCase;
        slFatt.Caso__c= parentCase.id;
        update slFatt;
        caseFromPortal.add(parentCase);
        
        Case Childcase = new Case();
        Childcase.Status='Completato';
        Childcase.AccountId=acc.id;
        ChildCase.parentid=parentCase.id;
        Childcase.PO_Richiesta_a_fattibilit__c=parentCase.id;
        Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
        Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
        Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        childcase.PO_Offerta__c = 'P2P Attiva';
        Childcase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
        Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
        insert Childcase; 
        sl.Caso__c=Childcase.id;
        update sl;
        slList.add(sl);
        slList.add(slFatt);
        
        caseFromPortal.add(Childcase);
        List<Attachment>attList = new List<Attachment>();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = sl.id;
        insert attach;
        attList.add(attach);
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = sl.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd;
        
        slord.PO_Offerta_Inoltrata__c = True;
        // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
        
        EOF_EAI_Service_Log__c slOrd2= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd2.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd2.EOF_Stato_Richiesta__c='Accettato';
        slOrd2.PO_Offerta__c='P2P Attiva';
        slOrd2.Caso__c=parentCase.id;
        slOrd2.EOF_STATO_ORDINE__c='Accettato';
        slOrd2.PO_Prime_Contractor__c='TEST';
        slOrd2.EOF_NOTE__c='Note';
        slOrd2.EOF_SL_Riferimento__c = slList[0].id;
        slOrd2.Note_Sospensione_Operatore__c='TEST';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord2.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd2.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd2;
        slord2.PO_Offerta_Inoltrata__c = True;
        //slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //slOrd.Caso__c=Childcase.id;
        update slOrd2;
        slList.add(slOrd2);
        
        
        
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        opp1.PO_Richiesta_fattibilit__c=parentCase.id;
        opp1.PO_Collegamento__c = null;
        insert opp1;
        System.debug('Testing'+opp1);
        
        list<Opportunity> oppLst = new list<Opportunity>();
        Opportunity opp2 = new Opportunity();
        opp2.Name='Opp TEST';
        opp2.StageName='Offerta presentata';
        opp2.CloseDate=System.today().addDays(30);
        opp2.PO_Richiesta_fattibilit__c=parentCase.id;
        opp2.PO_Collegamento__c = Childcase.id;
        opp2.PO_Offerta_totale__c= opp1.id;
        oppLst.add(opp2);
        insert oppLst;
        
        Attachment attach2=new Attachment();     
        attach2.Name='Unit Test Attachment';
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        attach2.body=bodyBlob2;
        attach2.parentId=oppLst[0].id;
        insert attach2;
        attList.add(attach2);
        
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Test';
        ele.OF_Comune__c = 'Test';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
        system.runAs(user){
            Test.startTest();
            Test.setCurrentPageReference(new PageReference('PO_P2PAttiva_EditLogInfoELine'));
            ApexPages.currentPage().getParameters().put('tipoP2Patt','eLine');
            ApexPages.currentPage().getParameters().put('parentId', slFatt.id);
            ApexPages.currentPage().getParameters().put('cLogId',sl.id);
            
            PO_P2PAttiva_EditLogInfoCntrlELine ctrl = new PO_P2PAttiva_EditLogInfoCntrlELine();
            ctrl.insertMode=true;
            ctrl.tipoP2PAttiva=  ApexPages.currentPage().getParameters().get('tipoP2Patt');
            ctrl.usr = user;
            ctrl.profiloName='10G';
            ctrl.selectedIdComune1=ele.id;
            ctrl.selectedIdComune2=ele.id;
            ctrl.OF_ElencoComuniItalianiobj = ele;
            ctrl.OF_ElencoComuniItalianiobj1 = ele;
            ctrl.OF_ElencoComuniItalianiobj2=ele;
            ctrl.NomeProgetto='Test';
            ctrl.fileName= attach.Name;
            ctrl.filebody= attach.body;
            ctrl.attachmentExists=true;
            ctrl.idVLAN=sVlan1.id;
            
            ctrl.urlPage = ApexPages.currentPage().getURL();
            ctrl.recordOfferta='E-Line';
            ctrl.childLog= sl;
            ctrl.sLogMaster= slM;
            ctrl.parentLog= slFatt;
            ctrl.vlanList = slVlanList;
            ctrl.sLogKit = slKit;
            ctrl.logMaster= slCollList;
            ctrl.P2PAttivaLogList = slCollList;
            ctrl.VLanMaxRagg(ctrl.vlanList);
            ctrl.SaveParentChildLogInfo();
            ctrl.insertChildLog();
            ctrl.inserisciNuovoKit();
            //	ctrl.saveCollegamento();
            ctrl.inserisciNuovoKit_OLD();
            ctrl.insertVlan();
            //ctrl.Annulla();
            ctrl.deleteChildAlone();
            // ctrl.modifyProf();
            ctrl.getProfiloVLAN();
            PO_P2PAttiva_EditLogInfoCntrlELine.searchSediMaster(slFatt.id,slM.id);
            //ctrl.getRecordProfili();
            ctrl.searchTerm ='Test';    
            PO_P2PAttiva_EditLogInfoCntrlELine.searchComune(ctrl.searchTerm) ;
            ctrl.searchTerm2 = slM.Name;
            
            ctrl.cnt= cntList;
            ctrl.searchvalue='test';
            ctrl.render1=true;
            ctrl.pirCOS5 = 10;
            ctrl.pirCOS3 = 10;
            ctrl.pirCOS1 = 10;
            ctrl.cirCOS1 = 10;
            ctrl.cirCOS3 =10;
            ctrl.cirCOS5 = 10;
            ctrl.nameSede = 'Test';
            ctrl.serviceAttribute='EPL'; //EVPL
            //ctrl.insertNewVLAN();
            //ctrl.cessaVLAN(); 
            Test.stopTest();
        }
    }
    
    
    
    
    public static testMethod void testMeth1_2(){
        TestDataFactory.CreateTestRecords(null,null, null);
        OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica.OF_ProfiloCommerciale__c = 'P2PATTIVA_10G';
        codifica.OF_ListinoCanoneName__c ='P2PATTIVA_10G';
        codifica.Name = '10G';
        codifica.IsPortalValid__c = true;
        codifica.servizio__c='P2P Attiva';
        codifica.CosType__c='MULTI_COS';
        insert codifica;
        
        
        OF_CodificaProfiloListini__c codifica3 = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica3.OF_ProfiloCommerciale__c = 'P2PATTIVA_5G';
        codifica3.OF_ListinoCanoneName__c ='P2PATTIVA_5G';
        codifica3.Name = '5G';
        codifica3.IsPortalValid__c = true;
        codifica3.servizio__c='P2P Attiva';
        codifica3.CosType__c='MONO_COS';
        
        insert codifica3;
        Map<String,Id> mpRT = creart();
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Id p = [select id from profile where name='Partner Community User'].id;  
        
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId=mpRT.get('OLO');
        acc.EOF_Codice_Operatore__c='TST';
        acc.VATNumber__c='00246465465';
        acc.Status__c='Attivo';
        acc.StartDate__c=DateTime.newInstance(2019, 4, 3, 3, 1, 5);
        
        insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
        
        insert cnt;
        
        list <Contact> cntList = new List<Contact>();
        cntList.add(cnt);
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                             ContactId = cnt.Id,
                             timezonesidkey='America/Los_Angeles', username='standarduse02rtest@testorg.com');
        
        insert user;
        
        /*  User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];

usr.ContactId=cnt.id;
//  update usr;
//  */
        
        Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
        OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
        
        EOF_EAI_Service_Log__c slC= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slC.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        slC.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        slC.PO_Tipo_percorso__c='Singola Via';
        slC.PO_Indirizzo_collegamento__c='via test';
        slC.EOF_Comune__c='Roma';
        slC.EOF_Stato_Richiesta__c='Accettato';
        slC.PO_Offerta__c='P2P Attiva';
        slC.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slC.PO_Tipo_di_collegamento__c='Point-to-Point';
        slC.PO_Prime_Contractor__c='TEST';
        slC.PO_Incluso_nell_offerta__c=true;
        slC.PO_Numero_fibre_richieste__c='2';
        slC.EOF_PROFILO__c='1';
        slC.PO_Sito__c='test';
        slC.PO_Civico__c='12';
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        slList.add(slC);
        insert slList;
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('P2P_Attiva_Request_E_Line');
        slFatt.PO_Tipo_di_collegamento__c ='E-Line' ;
        slFatt.EOF_Tipo_Comunicazione_String__c='Ordine di Attivazione';
        // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        
        
        EOF_EAI_Service_Log__c slM= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slM.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        slM.EOF_Codice_Ordine_OLO__c = 'TestM_9808980';
        slM.PO_Tipo_percorso__c='Singola Via';
        slM.PO_Indirizzo_collegamento__c='via test';
        slM.EOF_Comune__c='Roma';
        slM.EOF_Stato_Richiesta__c='Accettato';
        slM.PO_Offerta__c='P2P Attiva';
        slM.EOF_Codice_Operatore__c='TIS';
        //slM.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slM.PO_Tipo_di_collegamento__c='Point-to-Point';
        slM.Tipologia_Sede__c='Master';
        
        slM.PO_Prime_Contractor__c='TEST';
        slM.PO_Incluso_nell_offerta__c=true;
        slM.PO_Numero_fibre_richieste__c='2';
        //slM.EOF_PROFILO__c='1';
        slM.PO_Sito__c='test';
        slM.PO_Civico__c='12';
        slM.EOF_SL_Riferimento__c=slFatt.id;
        insert slM;
        //slM.ID_Sede__c= slM.Name;
        //update slM;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.Tipologia_Sede__c='Satellite';
        sl.ID_Sede_Master__c = slM.ID_Sede__c;
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        insert sl;
        
        //  slList.add(sl);
        //  
        List<EOF_EAI_Service_Log__c> slCollList = new List<EOF_EAI_Service_Log__c>();
        slCollList.add(sl);
        slCollList.add(slM);
        
        EOF_EAI_Service_Log__c slKit = new EOF_EAI_Service_Log__c();
        slKit.recordtypeId = mpRT.get('PO_Log_P2P_Attiva_KIT');
        slKit.EOF_Stato_Richiesta__c ='NA';
        slKit.Nome_del_KIT__c='KIT_00001';
        slKit.Modello_di_Servizio__c='';
        slKit.EOF_CODICE_OPERATORE__c='TIS';//actualUser.Contact.Account.EOF_Codice_Operatore__c'';
        slKit.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        slKit.EOF_ID_Pop__c ='NA_01';
        slKit.PO_P2PAttiva_Nome_del_KIT__c='Kit_0001';
        slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'Via Test';
        slKit.PO_P2PAttiva_Optical_Rate_Limiting__c = '10 GB';
        slKit.EOF_SL_Riferimento__c = slFatt.id;
        slKit.kit_in_condivisione__c =sl.id;
        slKit.Service_Attribute__c ='EPL';//SERVICE_EPL
        
        insert slKit;
        slList.add(slKit);
        
        EOF_EAI_Service_Log__c sVlan1 = new EOF_EAI_Service_Log__c();
        
        sVlan1.EOF_SL_Riferimento__c=sl.id;
        sVlan1.OF_PP_KIT_Log__c=slkIT.id;
        sVlan1.PO_Nota_sito__c='Nota Sito';
        sVlan1.EOF_STATO_ORDINE__c='Accettato';
        sVlan1.OF_SA_USER_VLAN__C='1111';
        sVlan1.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan1.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan1.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan1.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        sVlan1.RecordTypeId=mpRT.get('OF_SA_Vlan_ELine');
        
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> slVlanList = new List<EOF_EAI_Service_Log__c>();
        slVlanList.add(sVlan1);
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
        parentCase.Status='Completato';
        parentCase.PO_Offerta__c ='P2P Attiva';
        parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
        parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
        parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
        insert parentCase;
        slFatt.Caso__c= parentCase.id;
        update slFatt;
        caseFromPortal.add(parentCase);
        
        Case Childcase = new Case();
        Childcase.Status='Completato';
        Childcase.AccountId=acc.id;
        ChildCase.parentid=parentCase.id;
        Childcase.PO_Richiesta_a_fattibilit__c=parentCase.id;
        Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
        Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
        Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        childcase.PO_Offerta__c = 'P2P Attiva';
        Childcase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
        Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
        insert Childcase; 
        sl.Caso__c=Childcase.id;
        update sl;
        slList.add(sl);
        slList.add(slFatt);
        
        caseFromPortal.add(Childcase);
        List<Attachment>attList = new List<Attachment>();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = sl.id;
        insert attach;
        attList.add(attach);
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = sl.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd;
        
        slord.PO_Offerta_Inoltrata__c = True;
        // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
        
        EOF_EAI_Service_Log__c slOrd2= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd2.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd2.EOF_Stato_Richiesta__c='Accettato';
        slOrd2.PO_Offerta__c='P2P Attiva';
        slOrd2.Caso__c=parentCase.id;
        slOrd2.EOF_STATO_ORDINE__c='Accettato';
        slOrd2.PO_Prime_Contractor__c='TEST';
        slOrd2.EOF_NOTE__c='Note';
        slOrd2.EOF_SL_Riferimento__c = slList[0].id;
        slOrd2.Note_Sospensione_Operatore__c='TEST';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord2.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd2.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd2;
        slord2.PO_Offerta_Inoltrata__c = True;
        //slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //slOrd.Caso__c=Childcase.id;
        update slOrd2;
        slList.add(slOrd2);
        
        
        
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        opp1.PO_Richiesta_fattibilit__c=parentCase.id;
        opp1.PO_Collegamento__c = null;
        insert opp1;
        System.debug('Testing'+opp1);
        
        list<Opportunity> oppLst = new list<Opportunity>();
        Opportunity opp2 = new Opportunity();
        opp2.Name='Opp TEST';
        opp2.StageName='Offerta presentata';
        opp2.CloseDate=System.today().addDays(30);
        opp2.PO_Richiesta_fattibilit__c=parentCase.id;
        opp2.PO_Collegamento__c = Childcase.id;
        opp2.PO_Offerta_totale__c= opp1.id;
        oppLst.add(opp2);
        insert oppLst;
        
        Attachment attach2=new Attachment();     
        attach2.Name='Unit Test Attachment';
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        attach2.body=bodyBlob2;
        attach2.parentId=oppLst[0].id;
        insert attach2;
        attList.add(attach2);
        
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Test';
        ele.OF_Comune__c = 'Test';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
        system.runAs(user){
            Test.startTest();
            Test.setCurrentPageReference(new PageReference('PO_P2PAttiva_EditLogInfoELine'));
            ApexPages.currentPage().getParameters().put('tipoP2Patt','eLine');
            ApexPages.currentPage().getParameters().put('parentId', slFatt.id);
            ApexPages.currentPage().getParameters().put('cLogId',sl.id);
            
            PO_P2PAttiva_EditLogInfoCntrlELine ctrl = new PO_P2PAttiva_EditLogInfoCntrlELine();
            ctrl.insertMode=true;
            ctrl.tipoP2PAttiva=  ApexPages.currentPage().getParameters().get('tipoP2Patt');
            ctrl.usr = user;
            ctrl.profiloName='10G';
            ctrl.selectedIdComune1=ele.id;
            ctrl.selectedIdComune2=ele.id;
            ctrl.OF_ElencoComuniItalianiobj = ele;
            ctrl.OF_ElencoComuniItalianiobj1 = ele;
            ctrl.OF_ElencoComuniItalianiobj2=ele;
            ctrl.NomeProgetto='Test';
            ctrl.fileName= attach.Name;
            ctrl.filebody= attach.body;
            ctrl.attachmentExists=true;
            ctrl.idVLAN=sVlan1.id;
            
            ctrl.urlPage = ApexPages.currentPage().getURL();
            ctrl.recordOfferta='E-Line';
            ctrl.childLog= sl;
            ctrl.sLogMaster= slM;
            ctrl.parentLog= slFatt;
            ctrl.vlanList = slVlanList;
            ctrl.sLogKit = slKit;
            ctrl.logMaster= slCollList;
            ctrl.P2PAttivaLogList = slCollList;
            ctrl.VLanMaxRagg(ctrl.vlanList);
            ctrl.SaveParentChildLogInfo();
            ctrl.insertChildLog();
            ctrl.inserisciNuovoKit();
            //	ctrl.saveCollegamento();
            ctrl.inserisciNuovoKit_OLD();
            ctrl.insertVlan();
            //ctrl.Annulla();
            ctrl.deleteChildAlone();
            // ctrl.modifyProf();
            ctrl.getProfiloVLAN();
            //ctrl.getRecordProfili();
            ctrl.searchTerm2 = slM.Name;
            PO_P2PAttiva_EditLogInfoCntrlELine.searchAction(ctrl.searchTerm2);    
            PO_P2PAttiva_EditLogInfoCntrlELine.searchActionNoModal(ctrl.searchTerm2);
            PO_P2PAttiva_EditLogInfoCntrlELine.isDisabled(slFatt.id); 
            ctrl.cnt= cntList;
            ctrl.searchvalue='test';
            ctrl.render1=true;
            ctrl.pirCOS5 = 10;
            ctrl.pirCOS3 = 10;
            ctrl.pirCOS1 = 10;
            ctrl.cirCOS1 = 10;
            ctrl.cirCOS3 =10;
            ctrl.cirCOS5 = 10;
            ctrl.nameSede = 'Test';
            ctrl.serviceAttribute='EPL'; //EVPL
            //ctrl.insertNewVLAN();
            //ctrl.cessaVLAN(); 
            Test.stopTest();
        }
    }
    public static testMethod void testMeth1b(){
        TestDataFactory.CreateTestRecords(null,null, null);
        
        OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica.OF_ProfiloCommerciale__c = 'P2PATTIVA_10G';
        codifica.OF_ListinoCanoneName__c ='P2PATTIVA_10G';
        codifica.Name = '10G';
        codifica.IsPortalValid__c = true;
        codifica.servizio__c='P2P Attiva';
        codifica.CosType__c='MULTI_COS';
        insert codifica;
        
        
        OF_CodificaProfiloListini__c codifica3 = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica3.OF_ProfiloCommerciale__c = 'P2PATTIVA_5G';
        codifica3.OF_ListinoCanoneName__c ='P2PATTIVA_5G';
        codifica3.Name = '5G';
        codifica3.IsPortalValid__c = true;
        codifica3.servizio__c='P2P Attiva';
        codifica3.CosType__c='MONO_COS';
        
        insert codifica3;
        
        Map<String,Id> mpRT = creart();
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Id p = [select id from profile where name='Partner Community User'].id;  
        
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId=mpRT.get('OLO');
        acc.EOF_Codice_Operatore__c='TST';
        acc.VATNumber__c='00246465465';
        acc.Status__c='Attivo';
        acc.StartDate__c=DateTime.newInstance(2019, 4, 3, 3, 1, 5);
        
        insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
        
        insert cnt;
        
        list <Contact> cntList = new List<Contact>();
        cntList.add(cnt);
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                             ContactId = cnt.Id,
                             timezonesidkey='America/Los_Angeles', username='standarduse03rtest@testorg.com');
        
        insert user;
        
        /*  User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];

usr.ContactId=cnt.id;
//  update usr;
//  */
        
        Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
        OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
        
        EOF_EAI_Service_Log__c slC= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slC.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        slC.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        slC.PO_Tipo_percorso__c='Singola Via';
        slC.PO_Indirizzo_collegamento__c='via test';
        slC.EOF_Comune__c='Roma';
        slC.EOF_Stato_Richiesta__c='Accettato';
        slC.PO_Offerta__c='P2P Attiva';
        slC.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slC.PO_Tipo_di_collegamento__c='Point-to-Point';
        slC.PO_Prime_Contractor__c='TEST';
        slC.PO_Incluso_nell_offerta__c=true;
        slC.PO_Numero_fibre_richieste__c='2';
        slC.EOF_PROFILO__c='1';
        slC.PO_Sito__c='test';
        slC.PO_Civico__c='12';
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        slList.add(slC);
        insert slList;
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('P2P_Attiva_Request_E_Line');
        // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        
        
        EOF_EAI_Service_Log__c slM= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slM.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        slM.EOF_Codice_Ordine_OLO__c = 'TestM_9808980';
        slM.PO_Tipo_percorso__c='Singola Via';
        slM.PO_Indirizzo_collegamento__c='via test';
        slM.EOF_Comune__c='Roma';
        slM.EOF_Stato_Richiesta__c='Accettato';
        slM.PO_Offerta__c='P2P Attiva';
        slM.EOF_Codice_Operatore__c='TIS';
        //slM.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slM.PO_Tipo_di_collegamento__c='Point-to-Point';
        slM.Tipologia_Sede__c='Master';
        
        slM.PO_Prime_Contractor__c='TEST';
        slM.PO_Incluso_nell_offerta__c=true;
        slM.PO_Numero_fibre_richieste__c='2';
        //slM.EOF_PROFILO__c='1';
        slM.PO_Sito__c='test';
        slM.PO_Civico__c='12';
        slM.EOF_SL_Riferimento__c=slFatt.id;
        insert slM;
        //slM.ID_Sede__c= slM.Name;
        //update slM;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.Tipologia_Sede__c='Satellite';
        sl.ID_Sede_Master__c = slM.ID_Sede__c;
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        insert sl;
        
        //  slList.add(sl);
        //  
        List<EOF_EAI_Service_Log__c> slCollList = new List<EOF_EAI_Service_Log__c>();
        slCollList.add(sl);
        slCollList.add(slM);
        
        EOF_EAI_Service_Log__c slKit = new EOF_EAI_Service_Log__c();
        slKit.recordtypeId = mpRT.get('PO_Log_P2P_Attiva_KIT');
        slKit.EOF_Stato_Richiesta__c ='NA';
        slKit.Nome_del_KIT__c='KIT_00001';
        slKit.Modello_di_Servizio__c='';
        slKit.EOF_CODICE_OPERATORE__c='TIS';//actualUser.Contact.Account.EOF_Codice_Operatore__c'';
        slKit.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        slKit.EOF_ID_Pop__c ='NA_01';
        slKit.PO_P2PAttiva_Nome_del_KIT__c='Kit_0001';
        slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'Via Test';
        slKit.PO_P2PAttiva_Optical_Rate_Limiting__c = '10 GB';
        slKit.EOF_SL_Riferimento__c = slFatt.id;
        slKit.kit_in_condivisione__c =sl.id;
        slKit.Service_Attribute__c ='EPL';//SERVICE_EPL
        
        insert slKit;
        slList.add(slKit);
        
        EOF_EAI_Service_Log__c sVlan1 = new EOF_EAI_Service_Log__c();
        
        sVlan1.EOF_SL_Riferimento__c=sl.id;
        sVlan1.OF_PP_KIT_Log__c=slkIT.id;
        sVlan1.PO_Nota_sito__c='Nota Sito';
        sVlan1.EOF_STATO_ORDINE__c='Accettato';
        sVlan1.OF_SA_USER_VLAN__C='1111';
        sVlan1.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan1.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan1.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan1.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        sVlan1.RecordTypeId=mpRT.get('OF_SA_Vlan_ELine');
        
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> slVlanList = new List<EOF_EAI_Service_Log__c>();
        slVlanList.add(sVlan1);
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
        parentCase.Status='Completato';
        parentCase.PO_Offerta__c ='P2P Attiva';
        parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
        parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
        parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
        insert parentCase;
        slFatt.Caso__c= parentCase.id;
        update slFatt;
        caseFromPortal.add(parentCase);
        
        Case Childcase = new Case();
        Childcase.Status='Completato';
        Childcase.AccountId=acc.id;
        ChildCase.parentid=parentCase.id;
        Childcase.PO_Richiesta_a_fattibilit__c=parentCase.id;
        Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
        Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
        Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        childcase.PO_Offerta__c = 'P2P Attiva';
        Childcase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
        Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
        insert Childcase; 
        sl.Caso__c=Childcase.id;
        update sl;
        slList.add(sl);
        slList.add(slFatt);
        
        caseFromPortal.add(Childcase);
        List<Attachment>attList = new List<Attachment>();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = sl.id;
        insert attach;
        attList.add(attach);
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = sl.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd;
        
        slord.PO_Offerta_Inoltrata__c = True;
        // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
        
        EOF_EAI_Service_Log__c slOrd2= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd2.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd2.EOF_Stato_Richiesta__c='Accettato';
        slOrd2.PO_Offerta__c='P2P Attiva';
        slOrd2.Caso__c=parentCase.id;
        slOrd2.EOF_STATO_ORDINE__c='Accettato';
        slOrd2.PO_Prime_Contractor__c='TEST';
        slOrd2.EOF_NOTE__c='Note';
        slOrd2.EOF_SL_Riferimento__c = slList[0].id;
        slOrd2.Note_Sospensione_Operatore__c='TEST';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord2.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd2.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd2;
        slord2.PO_Offerta_Inoltrata__c = True;
        //slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //slOrd.Caso__c=Childcase.id;
        update slOrd2;
        slList.add(slOrd2);
        
        
        
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        opp1.PO_Richiesta_fattibilit__c=parentCase.id;
        opp1.PO_Collegamento__c = null;
        insert opp1;
        System.debug('Testing'+opp1);
        
        list<Opportunity> oppLst = new list<Opportunity>();
        Opportunity opp2 = new Opportunity();
        opp2.Name='Opp TEST';
        opp2.StageName='Offerta presentata';
        opp2.CloseDate=System.today().addDays(30);
        opp2.PO_Richiesta_fattibilit__c=parentCase.id;
        opp2.PO_Collegamento__c = Childcase.id;
        opp2.PO_Offerta_totale__c= opp1.id;
        oppLst.add(opp2);
        insert oppLst;
        
        Attachment attach2=new Attachment();     
        attach2.Name='Unit Test Attachment';
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        attach2.body=bodyBlob2;
        attach2.parentId=oppLst[0].id;
        insert attach2;
        attList.add(attach2);
        
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Test';
        ele.OF_Comune__c = 'Test';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
        system.runAs(user){
            Test.startTest();
            Test.setCurrentPageReference(new PageReference('PO_P2PAttiva_EditLogInfoELine'));
            ApexPages.currentPage().getParameters().put('tipoP2Patt','eLine');
            ApexPages.currentPage().getParameters().put('parentId', slFatt.id);
            ApexPages.currentPage().getParameters().put('cLogId',sl.id);
            
            PO_P2PAttiva_EditLogInfoCntrlELine ctrl = new PO_P2PAttiva_EditLogInfoCntrlELine();
            ctrl.insertMode=false;
            ctrl.usr = user;
            ctrl.tipoP2PAttiva=  ApexPages.currentPage().getParameters().get('tipoP2Patt');
            ctrl.profiloName='10G';
            ctrl.selectedIdComune1=ele.id;
            ctrl.selectedIdComune2=ele.id;
            ctrl.OF_ElencoComuniItalianiobj = ele;
            ctrl.OF_ElencoComuniItalianiobj1 = ele;
            ctrl.OF_ElencoComuniItalianiobj2=ele;
            ctrl.NomeProgetto='Test';
            ctrl.fileName= attach.Name;
            ctrl.filebody= attach.body;
            ctrl.attachmentExists=true;
            ctrl.idVLAN=sVlan1.id;
            
            ctrl.urlPage = ApexPages.currentPage().getURL();
            ctrl.recordOfferta='E-Line';
            ctrl.childLog= sl;
            ctrl.sLogMaster= slM;
            ctrl.parentLog= slFatt;
            ctrl.vlanList = slVlanList;
            ctrl.sLogKit = slKit;
            ctrl.logMaster= slCollList;
            ctrl.P2PAttivaLogList = slCollList;
            ctrl.VLanMaxRagg(ctrl.vlanList);
            ctrl.SaveParentChildLogInfo();
            ctrl.insertChildLog();
            ctrl.inserisciNuovoKit();
            //	ctrl.saveCollegamento();
            ctrl.inserisciNuovoKit_OLD();
            ctrl.insertVlan();
            //ctrl.Annulla();
            ctrl.deleteChildAlone();
            // ctrl.modifyProf();
            ctrl.getProfiloVLAN();
            PO_P2PAttiva_EditLogInfoCntrlELine.searchSediMaster(slFatt.id,slM.id);
            //ctrl.getRecordProfili();
            ctrl.searchTerm ='Test';    
            PO_P2PAttiva_EditLogInfoCntrlELine.searchComune(ctrl.searchTerm) ;
            ctrl.searchTerm2 = slM.Name;
            
            ctrl.cnt= cntList;
            ctrl.searchvalue='test';
            ctrl.render1=true;
            ctrl.pirCOS5 = 10;
            ctrl.pirCOS3 = 10;
            ctrl.pirCOS1 = 10;
            ctrl.cirCOS1 = 10;
            ctrl.cirCOS3 =10;
            ctrl.cirCOS5 = 10;
            ctrl.nameSede = 'Test';
            ctrl.serviceAttribute='EPL'; //EVPL
            //ctrl.insertNewVLAN();
            //ctrl.cessaVLAN(); 
            Test.stopTest();
        }
    }
    public static testMethod void testMeth1b_2(){
        TestDataFactory.CreateTestRecords(null,null, null);
        
        OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica.OF_ProfiloCommerciale__c = 'P2PATTIVA_10G';
        codifica.OF_ListinoCanoneName__c ='P2PATTIVA_10G'; 
        codifica.Name = '10G';
        codifica.IsPortalValid__c = true;
        codifica.servizio__c='P2P Attiva';
        codifica.CosType__c='MULTI_COS';
        insert codifica;
        
        
        OF_CodificaProfiloListini__c codifica3 = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica3.OF_ProfiloCommerciale__c = 'P2PATTIVA_5G';
        codifica3.OF_ListinoCanoneName__c ='P2PATTIVA_5G';
        codifica3.Name = '5G';
        codifica3.IsPortalValid__c = true;
        codifica3.servizio__c='P2P Attiva';
        codifica3.CosType__c='MONO_COS';
        
        insert codifica3;
        
        Map<String,Id> mpRT = creart();
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Id p = [select id from profile where name='Partner Community User'].id;  
        
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId=mpRT.get('OLO');
        acc.EOF_Codice_Operatore__c='TST';
        acc.VATNumber__c='00246465465';
        acc.Status__c='Attivo';
        acc.StartDate__c=DateTime.newInstance(2019, 4, 3, 3, 1, 5);
        
        insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
        
        insert cnt;
        
        list <Contact> cntList = new List<Contact>();
        cntList.add(cnt);
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                             ContactId = cnt.Id,
                             timezonesidkey='America/Los_Angeles', username='standarduse04rtest@testorg.com');
        
        insert user;
        
        /*  User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];

usr.ContactId=cnt.id;
//  update usr;
//  */
        
        Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
        OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
        
        EOF_EAI_Service_Log__c slC= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slC.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        slC.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        slC.PO_Tipo_percorso__c='Singola Via';
        slC.PO_Indirizzo_collegamento__c='via test';
        slC.EOF_Comune__c='Roma';
        slC.EOF_Stato_Richiesta__c='Accettato';
        slC.PO_Offerta__c='P2P Attiva';
        slC.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slC.PO_Tipo_di_collegamento__c='Point-to-Point';
        slC.PO_Prime_Contractor__c='TEST';
        slC.PO_Incluso_nell_offerta__c=true;
        slC.PO_Numero_fibre_richieste__c='2';
        slC.EOF_PROFILO__c='1';
        slC.PO_Sito__c='test';
        slC.PO_Civico__c='12';
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        slList.add(slC);
        insert slList;
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('P2P_Attiva_Request_E_Line');
        // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        
        
        EOF_EAI_Service_Log__c slM= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slM.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        slM.EOF_Codice_Ordine_OLO__c = 'TestM_9808980';
        slM.PO_Tipo_percorso__c='Singola Via';
        slM.PO_Indirizzo_collegamento__c='via test';
        slM.EOF_Comune__c='Roma';
        slM.EOF_Stato_Richiesta__c='Accettato';
        slM.PO_Offerta__c='P2P Attiva';
        slM.EOF_Codice_Operatore__c='TIS';
        //slM.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slM.PO_Tipo_di_collegamento__c='Point-to-Point';
        slM.Tipologia_Sede__c='Master';
        
        slM.PO_Prime_Contractor__c='TEST';
        slM.PO_Incluso_nell_offerta__c=true;
        slM.PO_Numero_fibre_richieste__c='2';
        //slM.EOF_PROFILO__c='1';
        slM.PO_Sito__c='test';
        slM.PO_Civico__c='12';
        slM.EOF_SL_Riferimento__c=slFatt.id;
        insert slM;
        //slM.ID_Sede__c= slM.Name;
        //update slM;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.Tipologia_Sede__c='Satellite';
        sl.ID_Sede_Master__c = slM.ID_Sede__c;
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        insert sl;
        
        //  slList.add(sl);
        //  
        List<EOF_EAI_Service_Log__c> slCollList = new List<EOF_EAI_Service_Log__c>();
        slCollList.add(sl);
        slCollList.add(slM);
        
        EOF_EAI_Service_Log__c slKit = new EOF_EAI_Service_Log__c();
        slKit.recordtypeId = mpRT.get('PO_Log_P2P_Attiva_KIT');
        slKit.EOF_Stato_Richiesta__c ='NA';
        slKit.Nome_del_KIT__c='KIT_00001';
        slKit.Modello_di_Servizio__c='';
        slKit.EOF_CODICE_OPERATORE__c='TIS';//actualUser.Contact.Account.EOF_Codice_Operatore__c'';
        slKit.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        slKit.EOF_ID_Pop__c ='NA_01';
        slKit.PO_P2PAttiva_Nome_del_KIT__c='Kit_0001';
        slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'Via Test';
        slKit.PO_P2PAttiva_Optical_Rate_Limiting__c = '10 GB';
        slKit.EOF_SL_Riferimento__c = slFatt.id;
        slKit.kit_in_condivisione__c =sl.id;
        slKit.Service_Attribute__c ='EPL';//SERVICE_EPL
        
        insert slKit;
        slList.add(slKit);
        
        EOF_EAI_Service_Log__c sVlan1 = new EOF_EAI_Service_Log__c();
        
        sVlan1.EOF_SL_Riferimento__c=sl.id;
        sVlan1.OF_PP_KIT_Log__c=slkIT.id;
        sVlan1.PO_Nota_sito__c='Nota Sito';
        sVlan1.EOF_STATO_ORDINE__c='Accettato';
        sVlan1.OF_SA_USER_VLAN__C='1111';
        sVlan1.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan1.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan1.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan1.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        sVlan1.RecordTypeId=mpRT.get('OF_SA_Vlan_ELine');
        
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> slVlanList = new List<EOF_EAI_Service_Log__c>();
        slVlanList.add(sVlan1);
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
        parentCase.Status='Completato';
        parentCase.PO_Offerta__c ='P2P Attiva';
        parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
        parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
        parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
        insert parentCase;
        slFatt.Caso__c= parentCase.id;
        update slFatt;
        caseFromPortal.add(parentCase);
        
        Case Childcase = new Case();
        Childcase.Status='Completato';
        Childcase.AccountId=acc.id;
        ChildCase.parentid=parentCase.id;
        Childcase.PO_Richiesta_a_fattibilit__c=parentCase.id;
        Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
        Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
        Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        childcase.PO_Offerta__c = 'P2P Attiva';
        Childcase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
        Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
        insert Childcase; 
        sl.Caso__c=Childcase.id;
        update sl;
        slList.add(sl);
        slList.add(slFatt);
        
        caseFromPortal.add(Childcase);
        List<Attachment>attList = new List<Attachment>();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = sl.id;
        insert attach;
        attList.add(attach);
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = sl.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd;
        
        slord.PO_Offerta_Inoltrata__c = True;
        // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
        
        EOF_EAI_Service_Log__c slOrd2= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd2.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd2.EOF_Stato_Richiesta__c='Accettato';
        slOrd2.PO_Offerta__c='P2P Attiva';
        slOrd2.Caso__c=parentCase.id;
        slOrd2.EOF_STATO_ORDINE__c='Accettato';
        slOrd2.PO_Prime_Contractor__c='TEST';
        slOrd2.EOF_NOTE__c='Note';
        slOrd2.EOF_SL_Riferimento__c = slList[0].id;
        slOrd2.Note_Sospensione_Operatore__c='TEST';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord2.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd2.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd2;
        slord2.PO_Offerta_Inoltrata__c = True;
        //slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //slOrd.Caso__c=Childcase.id;
        update slOrd2;
        slList.add(slOrd2);
        
        
        
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        opp1.PO_Richiesta_fattibilit__c=parentCase.id;
        opp1.PO_Collegamento__c = null;
        insert opp1;
        System.debug('Testing'+opp1);
        
        list<Opportunity> oppLst = new list<Opportunity>();
        Opportunity opp2 = new Opportunity();
        opp2.Name='Opp TEST';
        opp2.StageName='Offerta presentata';
        opp2.CloseDate=System.today().addDays(30);
        opp2.PO_Richiesta_fattibilit__c=parentCase.id;
        opp2.PO_Collegamento__c = Childcase.id;
        opp2.PO_Offerta_totale__c= opp1.id;
        oppLst.add(opp2);
        insert oppLst;
        
        Attachment attach2=new Attachment();     
        attach2.Name='Unit Test Attachment';
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        attach2.body=bodyBlob2;
        attach2.parentId=oppLst[0].id;
        insert attach2;
        attList.add(attach2);
        
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Test';
        ele.OF_Comune__c = 'Test';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
        system.runAs(user){
            Test.startTest();
            Test.setCurrentPageReference(new PageReference('PO_P2PAttiva_EditLogInfoELine'));
            ApexPages.currentPage().getParameters().put('tipoP2Patt','eLine');
            ApexPages.currentPage().getParameters().put('parentId', slFatt.id);
            ApexPages.currentPage().getParameters().put('cLogId',sl.id);
            
            PO_P2PAttiva_EditLogInfoCntrlELine ctrl = new PO_P2PAttiva_EditLogInfoCntrlELine();
            ctrl.insertMode=false;
            ctrl.usr = user;
            ctrl.tipoP2PAttiva=  ApexPages.currentPage().getParameters().get('tipoP2Patt');
            ctrl.profiloName='10G';
            ctrl.selectedIdComune1=ele.id;
            ctrl.selectedIdComune2=ele.id;
            ctrl.OF_ElencoComuniItalianiobj = ele;
            ctrl.OF_ElencoComuniItalianiobj1 = ele;
            ctrl.OF_ElencoComuniItalianiobj2=ele;
            ctrl.NomeProgetto='Test';
            ctrl.fileName= attach.Name;
            ctrl.filebody= attach.body;
            ctrl.attachmentExists=true;
            ctrl.idVLAN=sVlan1.id;
            
            ctrl.urlPage = ApexPages.currentPage().getURL();
            ctrl.recordOfferta='E-Line';
            ctrl.childLog= sl;
            ctrl.sLogMaster= slM;
            ctrl.parentLog= slFatt;
            ctrl.vlanList = slVlanList;
            ctrl.sLogKit = slKit;
            ctrl.logMaster= slCollList;
            ctrl.P2PAttivaLogList = slCollList;
            ctrl.VLanMaxRagg(ctrl.vlanList);
            ctrl.SaveParentChildLogInfo();
            ctrl.insertChildLog();
            ctrl.inserisciNuovoKit();
            //	ctrl.saveCollegamento();
            ctrl.inserisciNuovoKit_OLD();
            ctrl.insertVlan();
            //ctrl.Annulla();
            ctrl.deleteChildAlone();
            // ctrl.modifyProf();
            ctrl.getProfiloVLAN();
            //ctrl.getRecordProfili();
            ctrl.searchTerm ='Test';    
            ctrl.searchTerm2 = slM.Name;
            PO_P2PAttiva_EditLogInfoCntrlELine.searchAction(ctrl.searchTerm2);    
            PO_P2PAttiva_EditLogInfoCntrlELine.searchActionNoModal(ctrl.searchTerm2);
            PO_P2PAttiva_EditLogInfoCntrlELine.isDisabled(slFatt.id); 
            ctrl.cnt= cntList;
            ctrl.searchvalue='test';
            ctrl.render1=true;
            ctrl.pirCOS5 = 10;
            ctrl.pirCOS3 = 10;
            ctrl.pirCOS1 = 10;
            ctrl.cirCOS1 = 10;
            ctrl.cirCOS3 =10;
            ctrl.cirCOS5 = 10;
            ctrl.nameSede = 'Test';
            ctrl.serviceAttribute='EPL'; //EVPL
            //ctrl.insertNewVLAN();
            //ctrl.cessaVLAN(); 
            Test.stopTest();
        }
    }
    public static testMethod void testMeth1c(){
        TestDataFactory.CreateTestRecords(null,null, null);
        
        OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica.OF_ProfiloCommerciale__c = 'P2PATTIVA_10G';
        codifica.OF_ListinoCanoneName__c ='P2PATTIVA_10G';
        codifica.Name = '10G';
        codifica.IsPortalValid__c = true;
        codifica.servizio__c='P2P Attiva';
        codifica.CosType__c='MULTI_COS';
        insert codifica;
        
        
        OF_CodificaProfiloListini__c codifica3 = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica3.OF_ProfiloCommerciale__c = 'P2PATTIVA_5G';
        codifica3.OF_ListinoCanoneName__c ='P2PATTIVA_5G';
        codifica3.Name = '5G';
        codifica3.IsPortalValid__c = true;
        codifica3.servizio__c='P2P Attiva';
        codifica3.CosType__c='MONO_COS';
        
        insert codifica3;
        
        Map<String,Id> mpRT = creart();
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Id p = [select id from profile where name='Partner Community User'].id;  
        
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId=mpRT.get('OLO');
        acc.EOF_Codice_Operatore__c='TST';
        acc.VATNumber__c='00246465465';
        acc.Status__c='Attivo';
        acc.StartDate__c=DateTime.newInstance(2019, 4, 3, 3, 1, 5);
        
        insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
        
        insert cnt;
        
        list <Contact> cntList = new List<Contact>();
        cntList.add(cnt);
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                             ContactId = cnt.Id,
                             timezonesidkey='America/Los_Angeles', username='standarduse05rtest@testorg.com');
        
        insert user;
        
        /*  User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];

usr.ContactId=cnt.id;
//  update usr;
//  */
        
        Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Test';
        ele.OF_Comune__c = 'Test';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
        OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
        
        EOF_EAI_Service_Log__c slC= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slC.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        slC.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        slC.PO_Tipo_percorso__c='Singola Via';
        slC.PO_Indirizzo_collegamento__c='via test';
        slC.EOF_Comune__c='Roma';
        slC.EOF_Stato_Richiesta__c='Accettato';
        slC.PO_Offerta__c='P2P Attiva';
        slC.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slC.PO_Tipo_di_collegamento__c='Point-to-Point';
        slC.PO_Prime_Contractor__c='TEST';
        slC.PO_Incluso_nell_offerta__c=true;
        slC.PO_Numero_fibre_richieste__c='2';
        slC.EOF_PROFILO__c='1';
        slC.PO_Sito__c='test';
        slC.PO_Civico__c='12';
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        slList.add(slC);
        insert slList;
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('P2P_Attiva_Request_E_Line');
        // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        
        
        EOF_EAI_Service_Log__c slM= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slM.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        slM.EOF_Codice_Ordine_OLO__c = 'TestM_9808980';
        slM.PO_Tipo_percorso__c='Singola Via';
        slM.PO_Indirizzo_collegamento__c='via test';
        slM.EOF_Comune__c='Roma';
        slM.EOF_Stato_Richiesta__c='Accettato';
        slM.PO_Offerta__c='P2P Attiva';
        slM.EOF_Codice_Operatore__c='TIS';
        //slM.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slM.PO_Tipo_di_collegamento__c='Point-to-Point';
        slM.Tipologia_Sede__c='Master';
        slM.OF_Id_Comune__c=ele.id;
        slM.PO_Prime_Contractor__c='TEST';
        slM.PO_Incluso_nell_offerta__c=true;
        slM.PO_Numero_fibre_richieste__c='2';
        //slM.EOF_PROFILO__c='1';
        slM.PO_Sito__c='test';
        slM.PO_Civico__c='12';
        slM.EOF_SL_Riferimento__c=slFatt.id;
        slM.PO_Offerta__c='E-Line';
        insert slM;
        //slM.ID_Sede__c= slM.Name;
        //update slM;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.Tipologia_Sede__c='Satellite';
        sl.ID_Sede_Master__c = slM.ID_Sede__c;
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.OF_Id_Comune__c=ele.id;
        sl.EOF_SL_Riferimento__c=slFatt.id;
        sl.PO_Offerta__c='E-Line';
        insert sl;
        
        //  slList.add(sl);
        //  
        List<EOF_EAI_Service_Log__c> slCollList = new List<EOF_EAI_Service_Log__c>();
        slCollList.add(sl);
        slCollList.add(slM);
        
        EOF_EAI_Service_Log__c slKit = new EOF_EAI_Service_Log__c();
        slKit.recordtypeId = mpRT.get('PO_Log_P2P_Attiva_KIT');
        slKit.EOF_Stato_Richiesta__c ='NA';
        slKit.Nome_del_KIT__c='KIT_00001';
        slKit.Modello_di_Servizio__c='';
        slKit.EOF_CODICE_OPERATORE__c='TIS';//actualUser.Contact.Account.EOF_Codice_Operatore__c'';
        slKit.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        slKit.EOF_ID_Pop__c ='NA_01';
        slKit.PO_P2PAttiva_Nome_del_KIT__c='Kit_0001';
        slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'Via Test';
        slKit.PO_P2PAttiva_Optical_Rate_Limiting__c = '10 GB';
        slKit.EOF_SL_Riferimento__c = slFatt.id;
        slKit.kit_in_condivisione__c =sl.id;
        slKit.Service_Attribute__c ='EPL';//SERVICE_EPL
        
        insert slKit;
        slList.add(slKit);
        slM.OF_PP_KIT_Log__c=slKit.id;
        update slM;
        sl.OF_PP_KIT_Log__c=slKit.id;  
        update sl;
        
        EOF_EAI_Service_Log__c sVlan1 = new EOF_EAI_Service_Log__c();
        
        sVlan1.EOF_SL_Riferimento__c=sl.id;
        sVlan1.OF_PP_KIT_Log__c=slkIT.id;
        sVlan1.PO_Nota_sito__c='Nota Sito';
        sVlan1.EOF_STATO_ORDINE__c='Accettato';
        sVlan1.OF_SA_USER_VLAN__C='1111';
        sVlan1.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan1.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan1.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan1.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        sVlan1.RecordTypeId=mpRT.get('OF_SA_Vlan_ELine');
        sVlan1.OF_SA_KIT_CONSEGNA_VLAN__c=slKit.id;
        
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> slVlanList = new List<EOF_EAI_Service_Log__c>();
        slVlanList.add(sVlan1);
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
        parentCase.Status='Completato';
        parentCase.PO_Offerta__c ='P2P Attiva';
        parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
        parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
        parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
        insert parentCase;
        slFatt.Caso__c= parentCase.id;
        update slFatt;
        caseFromPortal.add(parentCase);
        
        Case Childcase = new Case();
        Childcase.Status='Completato';
        Childcase.AccountId=acc.id;
        ChildCase.parentid=parentCase.id;
        Childcase.PO_Richiesta_a_fattibilit__c=parentCase.id;
        Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
        Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
        Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        childcase.PO_Offerta__c = 'P2P Attiva';
        Childcase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
        Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
        insert Childcase; 
        sl.Caso__c=Childcase.id;
        update sl;
        slList.add(sl);
        slList.add(slFatt);
        
        caseFromPortal.add(Childcase);
        List<Attachment>attList = new List<Attachment>();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = sl.id;
        insert attach;
        attList.add(attach);
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = sl.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd;
        
        slord.PO_Offerta_Inoltrata__c = True;
        // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
        
        EOF_EAI_Service_Log__c slOrd2= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd2.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd2.EOF_Stato_Richiesta__c='Accettato';
        slOrd2.PO_Offerta__c='P2P Attiva';
        slOrd2.Caso__c=parentCase.id;
        slOrd2.EOF_STATO_ORDINE__c='Accettato';
        slOrd2.PO_Prime_Contractor__c='TEST';
        slOrd2.EOF_NOTE__c='Note';
        slOrd2.EOF_SL_Riferimento__c = slList[0].id;
        slOrd2.Note_Sospensione_Operatore__c='TEST';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord2.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd2.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd2;
        slord2.PO_Offerta_Inoltrata__c = True;
        //slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //slOrd.Caso__c=Childcase.id;
        update slOrd2;
        slList.add(slOrd2);
        
        
        
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        opp1.PO_Richiesta_fattibilit__c=parentCase.id;
        opp1.PO_Collegamento__c = null;
        insert opp1;
        System.debug('Testing'+opp1);
        
        list<Opportunity> oppLst = new list<Opportunity>();
        Opportunity opp2 = new Opportunity();
        opp2.Name='Opp TEST';
        opp2.StageName='Offerta presentata';
        opp2.CloseDate=System.today().addDays(30);
        opp2.PO_Richiesta_fattibilit__c=parentCase.id;
        opp2.PO_Collegamento__c = Childcase.id;
        opp2.PO_Offerta_totale__c= opp1.id;
        oppLst.add(opp2);
        insert oppLst;
        
        Attachment attach2=new Attachment();     
        attach2.Name='Unit Test Attachment';
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        attach2.body=bodyBlob2;
        attach2.parentId=oppLst[0].id;
        insert attach2;
        attList.add(attach2);
        
        system.runAs(user){
            Test.startTest();
            Test.setCurrentPageReference(new PageReference('PO_P2PAttiva_EditLogInfoELine'));
            ApexPages.currentPage().getParameters().put('tipoP2Patt','eLine');
            ApexPages.currentPage().getParameters().put('parentId', slFatt.id);
            ApexPages.currentPage().getParameters().put('cLogId',sl.id);
            
            PO_P2PAttiva_EditLogInfoCntrlELine ctrl = new PO_P2PAttiva_EditLogInfoCntrlELine();
            ctrl.insertMode=false;
            ctrl.usr = user;
            ctrl.tipoP2PAttiva=  ApexPages.currentPage().getParameters().get('tipoP2Patt');
            ctrl.profiloName='10G';
            ctrl.selectedIdComune1=ele.id;
            ctrl.selectedIdComune2=ele.id;
            ctrl.OF_ElencoComuniItalianiobj = ele;
            ctrl.OF_ElencoComuniItalianiobj1 = ele;
            ctrl.OF_ElencoComuniItalianiobj2=ele;
            ctrl.NomeProgetto='Test';
            ctrl.fileName= attach.Name;
            ctrl.filebody= attach.body;
            ctrl.attachmentExists=true;
            ctrl.idVLAN=sVlan1.id;
            ctrl.listNephewVLAN = slVlanList;
            ctrl.urlPage = ApexPages.currentPage().getURL();
            ctrl.recordOfferta='E-Line';
            ctrl.childLog= sl;
            ctrl.sLogMaster= slM;
            ctrl.parentLog= slFatt;
            ctrl.vlanList = slVlanList;
            ctrl.sLogKit = slKit;
            ctrl.logMaster= slCollList;
            ctrl.P2PAttivaLogList = slCollList;
            ctrl.VLanMaxRagg(ctrl.vlanList);
            ctrl.SaveParentChildLogInfo();
            ctrl.insertChildLog();
            ctrl.inserisciNuovoKit();
            //	ctrl.saveCollegamento();
            ctrl.inserisciNuovoKit_OLD();
            ctrl.insertVlan();
            //ctrl.Annulla();
            ctrl.deleteChildAlone();
            // ctrl.modifyProf();
            ctrl.getProfiloVLAN();
            PO_P2PAttiva_EditLogInfoCntrlELine.searchSediMaster(slFatt.id,slM.id);
            //ctrl.getRecordProfili();
            ctrl.searchTerm ='Test';    
            PO_P2PAttiva_EditLogInfoCntrlELine.searchComune(ctrl.searchTerm) ;
            ctrl.searchTerm2 = slM.Name;
            
            ctrl.cnt= cntList;
            ctrl.searchvalue='test';
            ctrl.render1=true;
            ctrl.pirCOS5 = 10;
            ctrl.pirCOS3 = 10;
            ctrl.pirCOS1 = 10;
            ctrl.cirCOS1 = 10;
            ctrl.cirCOS3 =10;
            ctrl.cirCOS5 = 10;
            ctrl.nameSede = 'Test';
            ctrl.serviceAttribute='EPL'; //EVPL
            //ctrl.insertNewVLAN();
            //ctrl.cessaVLAN(); 
            Test.stopTest();
        }
    }
    
    
    public static testMethod void testMeth1c_2(){
        TestDataFactory.CreateTestRecords(null,null, null);
        
        OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica.OF_ProfiloCommerciale__c = 'P2PATTIVA_10G';
        codifica.OF_ListinoCanoneName__c ='P2PATTIVA_10G';
        codifica.Name = '10G';
        codifica.IsPortalValid__c = true;
        codifica.servizio__c='P2P Attiva';
        codifica.CosType__c='MULTI_COS';
        insert codifica;
        
        
        OF_CodificaProfiloListini__c codifica3 = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica3.OF_ProfiloCommerciale__c = 'P2PATTIVA_5G';
        codifica3.OF_ListinoCanoneName__c ='P2PATTIVA_5G';
        codifica3.Name = '5G';
        codifica3.IsPortalValid__c = true;
        codifica3.servizio__c='P2P Attiva';
        codifica3.CosType__c='MONO_COS';
        
        insert codifica3;
        
        Map<String,Id> mpRT = creart();
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Id p = [select id from profile where name='Partner Community User'].id;  
        
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId=mpRT.get('OLO');
        acc.EOF_Codice_Operatore__c='TST';
        acc.VATNumber__c='00246465465';
        acc.Status__c='Attivo';
        acc.StartDate__c=DateTime.newInstance(2019, 4, 3, 3, 1, 5);
        
        insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
        
        insert cnt;
        
        list <Contact> cntList = new List<Contact>();
        cntList.add(cnt);
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                             ContactId = cnt.Id,
                             timezonesidkey='America/Los_Angeles', username='standarduse10rtest@testorg.com');
        
        insert user;
        
        /*  User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];

usr.ContactId=cnt.id;
//  update usr;
//  */
        
        Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Test';
        ele.OF_Comune__c = 'Test';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
        OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
        
        EOF_EAI_Service_Log__c slC= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slC.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        slC.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        slC.PO_Tipo_percorso__c='Singola Via';
        slC.PO_Indirizzo_collegamento__c='via test';
        slC.EOF_Comune__c='Roma';
        slC.EOF_Stato_Richiesta__c='Accettato';
        slC.PO_Offerta__c='P2P Attiva';
        slC.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slC.PO_Tipo_di_collegamento__c='Point-to-Point';
        slC.PO_Prime_Contractor__c='TEST';
        slC.PO_Incluso_nell_offerta__c=true;
        slC.PO_Numero_fibre_richieste__c='2';
        slC.EOF_PROFILO__c='1';
        slC.PO_Sito__c='test';
        slC.PO_Civico__c='12';
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        slList.add(slC);
        insert slList;
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('P2P_Attiva_Request_E_Line');
        // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        
        
        EOF_EAI_Service_Log__c slM= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slM.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        slM.EOF_Codice_Ordine_OLO__c = 'TestM_9808980';
        slM.PO_Tipo_percorso__c='Singola Via';
        slM.PO_Indirizzo_collegamento__c='via test';
        slM.EOF_Comune__c='Roma';
        slM.EOF_Stato_Richiesta__c='Accettato';
        slM.PO_Offerta__c='P2P Attiva';
        slM.EOF_Codice_Operatore__c='TIS';
        //slM.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slM.PO_Tipo_di_collegamento__c='Point-to-Point';
        slM.Tipologia_Sede__c='Master';
        slM.OF_Id_Comune__c=ele.id;
        slM.PO_Prime_Contractor__c='TEST';
        slM.PO_Incluso_nell_offerta__c=true;
        slM.PO_Numero_fibre_richieste__c='2';
        //slM.EOF_PROFILO__c='1';
        slM.PO_Sito__c='test';
        slM.PO_Civico__c='12';
        slM.EOF_SL_Riferimento__c=slFatt.id;
        slM.PO_Offerta__c='E-Line';
        insert slM;
        //slM.ID_Sede__c= slM.Name;
        //update slM;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.Tipologia_Sede__c='Satellite';
        sl.ID_Sede_Master__c = slM.ID_Sede__c;
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.OF_Id_Comune__c=ele.id;
        sl.EOF_SL_Riferimento__c=slFatt.id;
        sl.PO_Offerta__c='E-Line';
        insert sl;
        
        //  slList.add(sl);
        //  
        List<EOF_EAI_Service_Log__c> slCollList = new List<EOF_EAI_Service_Log__c>();
        slCollList.add(sl);
        slCollList.add(slM);
        
        EOF_EAI_Service_Log__c slKit = new EOF_EAI_Service_Log__c();
        slKit.recordtypeId = mpRT.get('PO_Log_P2P_Attiva_KIT');
        slKit.EOF_Stato_Richiesta__c ='NA';
        slKit.Nome_del_KIT__c='KIT_00001';
        slKit.Modello_di_Servizio__c='';
        slKit.EOF_CODICE_OPERATORE__c='TIS';//actualUser.Contact.Account.EOF_Codice_Operatore__c'';
        slKit.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        slKit.EOF_ID_Pop__c ='NA_01';
        slKit.PO_P2PAttiva_Nome_del_KIT__c='Kit_0001';
        slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'Via Test';
        slKit.PO_P2PAttiva_Optical_Rate_Limiting__c = '10 GB';
        slKit.EOF_SL_Riferimento__c = slFatt.id;
        slKit.kit_in_condivisione__c =sl.id;
        slKit.Service_Attribute__c ='EPL';//SERVICE_EPL
        
        insert slKit;
        slList.add(slKit);
        slM.OF_PP_KIT_Log__c=slKit.id;
        update slM;
        sl.OF_PP_KIT_Log__c=slKit.id;  
        update sl;
        
        EOF_EAI_Service_Log__c sVlan1 = new EOF_EAI_Service_Log__c();
        
        sVlan1.EOF_SL_Riferimento__c=sl.id;
        sVlan1.OF_PP_KIT_Log__c=slkIT.id;
        sVlan1.PO_Nota_sito__c='Nota Sito';
        sVlan1.EOF_STATO_ORDINE__c='Accettato';
        sVlan1.OF_SA_USER_VLAN__C='1111';
        sVlan1.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan1.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan1.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan1.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        sVlan1.RecordTypeId=mpRT.get('OF_SA_Vlan_ELine');
        sVlan1.OF_SA_KIT_CONSEGNA_VLAN__c=slKit.id;
        
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> slVlanList = new List<EOF_EAI_Service_Log__c>();
        slVlanList.add(sVlan1);
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
        parentCase.Status='Completato';
        parentCase.PO_Offerta__c ='P2P Attiva';
        parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
        parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
        parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
        insert parentCase;
        slFatt.Caso__c= parentCase.id;
        update slFatt;
        caseFromPortal.add(parentCase);
        
        Case Childcase = new Case();
        Childcase.Status='Completato';
        Childcase.AccountId=acc.id;
        ChildCase.parentid=parentCase.id;
        Childcase.PO_Richiesta_a_fattibilit__c=parentCase.id;
        Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
        Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
        Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        childcase.PO_Offerta__c = 'P2P Attiva';
        Childcase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
        Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
        insert Childcase; 
        sl.Caso__c=Childcase.id;
        update sl;
        slList.add(sl);
        slList.add(slFatt);
        
        caseFromPortal.add(Childcase);
        List<Attachment>attList = new List<Attachment>();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = sl.id;
        insert attach;
        attList.add(attach);
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = sl.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd;
        
        slord.PO_Offerta_Inoltrata__c = True;
        // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
        
        EOF_EAI_Service_Log__c slOrd2= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd2.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd2.EOF_Stato_Richiesta__c='Accettato';
        slOrd2.PO_Offerta__c='P2P Attiva';
        slOrd2.Caso__c=parentCase.id;
        slOrd2.EOF_STATO_ORDINE__c='Accettato';
        slOrd2.PO_Prime_Contractor__c='TEST';
        slOrd2.EOF_NOTE__c='Note';
        slOrd2.EOF_SL_Riferimento__c = slList[0].id;
        slOrd2.Note_Sospensione_Operatore__c='TEST';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord2.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd2.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd2;
        slord2.PO_Offerta_Inoltrata__c = True;
        //slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //slOrd.Caso__c=Childcase.id;
        update slOrd2;
        slList.add(slOrd2);
        
        
        
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        opp1.PO_Richiesta_fattibilit__c=parentCase.id;
        opp1.PO_Collegamento__c = null;
        insert opp1;
        System.debug('Testing'+opp1);
        
        list<Opportunity> oppLst = new list<Opportunity>();
        Opportunity opp2 = new Opportunity();
        opp2.Name='Opp TEST';
        opp2.StageName='Offerta presentata';
        opp2.CloseDate=System.today().addDays(30);
        opp2.PO_Richiesta_fattibilit__c=parentCase.id;
        opp2.PO_Collegamento__c = Childcase.id;
        opp2.PO_Offerta_totale__c= opp1.id;
        oppLst.add(opp2);
        insert oppLst;
        
        Attachment attach2=new Attachment();     
        attach2.Name='Unit Test Attachment';
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        attach2.body=bodyBlob2;
        attach2.parentId=oppLst[0].id;
        insert attach2;
        attList.add(attach2);
        
        system.runAs(user){
            Test.startTest();
            Test.setCurrentPageReference(new PageReference('PO_P2PAttiva_EditLogInfoELine'));
            ApexPages.currentPage().getParameters().put('tipoP2Patt','eLine');
            ApexPages.currentPage().getParameters().put('parentId', slFatt.id);
            ApexPages.currentPage().getParameters().put('cLogId',sl.id);
            
            PO_P2PAttiva_EditLogInfoCntrlELine ctrl = new PO_P2PAttiva_EditLogInfoCntrlELine();
            ctrl.insertMode=false;
            ctrl.usr = user;
            ctrl.tipoP2PAttiva=  ApexPages.currentPage().getParameters().get('tipoP2Patt');
            ctrl.profiloName='10G';
            ctrl.selectedIdComune1=ele.id;
            ctrl.selectedIdComune2=ele.id;
            ctrl.OF_ElencoComuniItalianiobj = ele;
            ctrl.OF_ElencoComuniItalianiobj1 = ele;
            ctrl.OF_ElencoComuniItalianiobj2=ele;
            ctrl.NomeProgetto='Test';
            ctrl.fileName= attach.Name;
            ctrl.filebody= attach.body;
            ctrl.attachmentExists=true;
            ctrl.idVLAN=sVlan1.id;
            ctrl.listNephewVLAN = slVlanList;
            ctrl.urlPage = ApexPages.currentPage().getURL();
            ctrl.recordOfferta='E-Line';
            ctrl.childLog= sl;
            ctrl.sLogMaster= slM;
            ctrl.parentLog= slFatt;
            ctrl.vlanList = slVlanList;
            ctrl.sLogKit = slKit;
            ctrl.logMaster= slCollList;
            ctrl.P2PAttivaLogList = slCollList;
            ctrl.VLanMaxRagg(ctrl.vlanList);
            ctrl.SaveParentChildLogInfo();
            ctrl.insertChildLog();
            ctrl.inserisciNuovoKit();
            //	ctrl.saveCollegamento();
            ctrl.inserisciNuovoKit_OLD();
            ctrl.insertVlan();
            //ctrl.Annulla();
            ctrl.deleteChildAlone();
            // ctrl.modifyProf();
            ctrl.getProfiloVLAN();
            //ctrl.getRecordProfili();
            ctrl.searchTerm ='Test';    
            ctrl.searchTerm2 = slM.Name;
            PO_P2PAttiva_EditLogInfoCntrlELine.searchAction(ctrl.searchTerm2);    
            PO_P2PAttiva_EditLogInfoCntrlELine.searchActionNoModal(ctrl.searchTerm2);
            PO_P2PAttiva_EditLogInfoCntrlELine.isDisabled(slFatt.id); 
            ctrl.cnt= cntList;
            ctrl.searchvalue='test';
            ctrl.render1=true;
            ctrl.pirCOS5 = 10;
            ctrl.pirCOS3 = 10;
            ctrl.pirCOS1 = 10;
            ctrl.cirCOS1 = 10;
            ctrl.cirCOS3 =10;
            ctrl.cirCOS5 = 10;
            ctrl.nameSede = 'Test';
            ctrl.serviceAttribute='EPL'; //EVPL
            //ctrl.insertNewVLAN();
            //ctrl.cessaVLAN(); 
            Test.stopTest();
        }
    }
    public static testMethod void testMeth2(){
        TestDataFactory.CreateTestRecords(null,null, null);
        OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica.OF_ProfiloCommerciale__c = 'P2PATTIVA_10G';
        codifica.OF_ListinoCanoneName__c ='P2PATTIVA_10G';
        codifica.Name = '10G';
        codifica.IsPortalValid__c = true;
        codifica.servizio__c='P2P Attiva';
        codifica.CosType__c='MULTI_COS';
        insert codifica;
        
        
        OF_CodificaProfiloListini__c codifica3 = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica3.OF_ProfiloCommerciale__c = 'P2PATTIVA_5G';
        codifica3.OF_ListinoCanoneName__c ='P2PATTIVA_5G';
        codifica3.Name = '5G';
        codifica3.IsPortalValid__c = true;
        codifica3.servizio__c='P2P Attiva';
        codifica3.CosType__c='MONO_COS';
        
        insert codifica3;
        
        Map<String,Id> mpRT = creart();
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Id p = [select id from profile where name='Partner Community User'].id;  
        
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId=mpRT.get('OLO');
        acc.EOF_Codice_Operatore__c='TST';
        acc.VATNumber__c='00246465465';
        acc.Status__c='Attivo';
        acc.StartDate__c=DateTime.newInstance(2019, 4, 3, 3, 1, 5);
        
        insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
        
        insert cnt;
        
        list <Contact> cntList = new List<Contact>();
        cntList.add(cnt);
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                             ContactId = cnt.Id,
                             timezonesidkey='America/Los_Angeles', username='standarduse14rtest@testorg.com');
        
        insert user;
        
        /*  User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];

usr.ContactId=cnt.id;
//  update usr;
//  */ 
        
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Mondragone';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        //  
        
        
        Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
        
        OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
        
        /*EOF_EAI_Service_Log__c slC= new EOF_EAI_Service_Log__c(); //sl Collegamento
slC.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
slC.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
slC.PO_Tipo_percorso__c='Singola Via';
slC.PO_Indirizzo_collegamento__c='via test';
slC.EOF_Comune__c='Roma';
slC.EOF_Stato_Richiesta__c='Accettato';
slC.PO_Offerta__c='P2P Attiva';
slC.EOF_Codice_Operatore__c='TIS';
//sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
slC.PO_Tipo_di_collegamento__c='Point-to-Point';
slC.PO_Prime_Contractor__c='TEST';
slC.PO_Incluso_nell_offerta__c=true;
slC.PO_Numero_fibre_richieste__c='2';
slC.EOF_PROFILO__c='1';
slC.PO_Sito__c='test';
slC.PO_Civico__c='12';
*/
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        //  slList.add(slC);
        //  insert slList;
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('P2P_Attiva_Request_E_Line');
        slFatt.Tipologia_CPE__c = 'Low-End';
        slFatt.Tipologia_Alimentazione__c='AC';
        slFatt.Interfaccia_CPE__c='Ottica';
        slFatt.Service_Attribute__c ='EPL';
        slFatt.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        
        
        EOF_EAI_Service_Log__c slM= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slM.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        slM.EOF_Codice_Ordine_OLO__c = 'TestM_9808980';
        slM.PO_Tipo_percorso__c='Singola Via';
        slM.PO_Indirizzo_collegamento__c='via test';
        slM.EOF_Comune__c='Mondragone';
        slM.OF_Id_Comune__c=ele.id;
        slM.EOF_Stato_Richiesta__c='Accettato';
        slM.PO_Offerta__c='P2P Attiva';
        slM.EOF_Codice_Operatore__c='TIS';
        //slM.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slM.PO_Tipo_di_collegamento__c='Point-to-Point';
        slM.Tipologia_Sede__c='Master';
        
        slM.PO_Prime_Contractor__c='TEST';
        slM.PO_Incluso_nell_offerta__c=true;
        slM.PO_Numero_fibre_richieste__c='2';
        //slM.EOF_PROFILO__c='1';
        slM.PO_Sito__c='test';
        slM.PO_Civico__c='12';
        slM.EOF_SL_Riferimento__c=slFatt.id;
        slM.Tipologia_CPE__c = 'Low-End';
        slM.Tipologia_Alimentazione__c='AC';
        slM.Interfaccia_CPE__c='Ottica';
        slM.Service_Attribute__c ='EPL';
        slM.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        //insert slM;
        //slM.ID_Sede__c= slM.Name;
        //update slM;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Mondragone';
        sl.OF_Id_Comune__c=ele.id;
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.Tipologia_Sede__c='Satellite';
        sl.ID_Sede_Master__c = slM.ID_Sede__c;
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        sl.Tipologia_CPE__c = 'Low-End';
        sl.Tipologia_Alimentazione__c='AC';
        sl.Interfaccia_CPE__c='Ottica';
        //  insert sl;
        
        //  slList.add(sl);
        //  
        List<EOF_EAI_Service_Log__c> slCollList = new List<EOF_EAI_Service_Log__c>();
        slCollList.add(sl);
        slCollList.add(slM);
        
        EOF_EAI_Service_Log__c slKit = new EOF_EAI_Service_Log__c();
        slKit.recordtypeId = mpRT.get('PO_Log_P2P_Attiva_KIT');
        slKit.EOF_Stato_Richiesta__c ='NA';
        slKit.Nome_del_KIT__c='KIT_00001';
        slKit.Modello_di_Servizio__c='';
        slKit.EOF_CODICE_OPERATORE__c='TIS';//actualUser.Contact.Account.EOF_Codice_Operatore__c'';
        slKit.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        slKit.EOF_ID_Pop__c ='NA_01';
        slKit.PO_P2PAttiva_Nome_del_KIT__c='Kit_0001';
        slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'Via Test';
        slKit.PO_P2PAttiva_Optical_Rate_Limiting__c = '10 GB';
        slKit.EOF_SL_Riferimento__c = slFatt.id;
        slKit.kit_in_condivisione__c =sl.id;
        slKit.Service_Attribute__c ='EPL';//SERVICE_EPL
        slKit.Tipologia_CPE__c = 'Low-End';
        slKit.Tipologia_Alimentazione__c='AC';
        slKit.Interfaccia_CPE__c='Ottica';
        slKit.Service_Attribute__c ='EPL';
        slKit.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        //insert slKit;
        slList.add(slKit);
        
        EOF_EAI_Service_Log__c sVlan1 = new EOF_EAI_Service_Log__c();
        
        sVlan1.EOF_SL_Riferimento__c=sl.id;
        sVlan1.OF_PP_KIT_Log__c=slkIT.id;
        sVlan1.PO_Nota_sito__c='Nota Sito';
        sVlan1.EOF_STATO_ORDINE__c='Accettato';
        sVlan1.OF_SA_USER_VLAN__C='1111';
        sVlan1.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan1.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan1.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan1.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        sVlan1.RecordTypeId=mpRT.get('OF_SA_Vlan_ELine');
        sVlan1.Tipologia_CPE__c = 'Low-End';
        sVlan1.Tipologia_Alimentazione__c='AC';
        sVlan1.Interfaccia_CPE__c='Ottica';
        sVlan1.Service_Attribute__c ='EPL';
        sVlan1.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        
        // insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> slVlanList = new List<EOF_EAI_Service_Log__c>();
        slVlanList.add(sVlan1);
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
        parentCase.Status='Completato';
        parentCase.PO_Offerta__c ='P2P Attiva';
        parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
        parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
        parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
        // insert parentCase;
        //   slFatt.Caso__c= parentCase.id;
        //	 update slFatt;
        caseFromPortal.add(parentCase);
        
        Case Childcase = new Case();
        Childcase.Status='Completato';
        Childcase.AccountId=acc.id;
        ChildCase.parentid=parentCase.id;
        Childcase.PO_Richiesta_a_fattibilit__c=parentCase.id;
        Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
        Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
        Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        childcase.PO_Offerta__c = 'P2P Attiva';
        Childcase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
        Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
        // insert Childcase; 
        // sl.Caso__c=Childcase.id;
        // update sl;
        slList.add(sl);
        slList.add(slFatt);
        
        caseFromPortal.add(Childcase);
        List<Attachment>attList = new List<Attachment>();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = sl.id;
        // insert attach;
        attList.add(attach);
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = sl.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        slOrd.Tipologia_CPE__c = 'Low-End';
        slOrd.Tipologia_Alimentazione__c='AC';
        slOrd.Interfaccia_CPE__c='Ottica';
        slOrd.Service_Attribute__c ='EPL';
        slOrd.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        //insert slOrd;
        
        // slord.PO_Offerta_Inoltrata__c = True;
        // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //update slOrd;  
        slList.add(slOrd);
        
        EOF_EAI_Service_Log__c slOrd2= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd2.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd2.EOF_Stato_Richiesta__c='Accettato';
        slOrd2.PO_Offerta__c='P2P Attiva';
        slOrd2.Caso__c=parentCase.id;
        slOrd2.EOF_STATO_ORDINE__c='Accettato';
        slOrd2.PO_Prime_Contractor__c='TEST';
        slOrd2.EOF_NOTE__c='Note';
        slOrd2.EOF_SL_Riferimento__c = slList[0].id;
        slOrd2.Note_Sospensione_Operatore__c='TEST';
        slOrd2.Tipologia_CPE__c = 'Low-End';
        slOrd2.Tipologia_Alimentazione__c='AC';
        slOrd2.Interfaccia_CPE__c='Ottica';
        slOrd2.Service_Attribute__c ='EPL';
        slOrd2.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord2.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd2.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        //  insert slOrd2;
        // slord2.PO_Offerta_Inoltrata__c = True;
        //slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //slOrd.Caso__c=Childcase.id;
        // update slOrd2;
        slList.add(slOrd2);
        
        
        
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        opp1.PO_Richiesta_fattibilit__c=parentCase.id;
        opp1.PO_Collegamento__c = null;
        //insert opp1;
        System.debug('Testing'+opp1);
        
        list<Opportunity> oppLst = new list<Opportunity>();
        Opportunity opp2 = new Opportunity();
        opp2.Name='Opp TEST';
        opp2.StageName='Offerta presentata';
        opp2.CloseDate=System.today().addDays(30);
        opp2.PO_Richiesta_fattibilit__c=parentCase.id;
        opp2.PO_Collegamento__c = Childcase.id;
        opp2.PO_Offerta_totale__c= opp1.id;
        oppLst.add(opp2);
        //  insert oppLst;
        
        Attachment attach2=new Attachment();     
        attach2.Name='Unit Test Attachment';
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        attach2.body=bodyBlob2;
        attach2.parentId=oppLst[0].id;
        // insert attach2;
        attList.add(attach2);
        
        
        
        system.runAs(user){
            Test.startTest();
            Test.setCurrentPageReference(new PageReference('PO_P2PAttiva_EditLogInfoELine'));
            ApexPages.currentPage().getParameters().put('tipoP2Patt','eLine');
            ApexPages.currentPage().getParameters().put('parentId', slFatt.id);
            ApexPages.currentPage().getParameters().put('cLogId',sl.id);
            
            PO_P2PAttiva_EditLogInfoCntrlELine ctrl = new PO_P2PAttiva_EditLogInfoCntrlELine();
            ctrl.insertMode=true;
            ctrl.tipoP2PAttiva=  ApexPages.currentPage().getParameters().get('tipoP2Patt');
            ctrl.usr = user;
            ctrl.profiloName='10G';
            ctrl.selectedIdComune= ele.id;
            ctrl.selectedIdComune1=ele.id;
            ctrl.selectedIdComune2=ele.id;
            ctrl.OF_ElencoComuniItalianiobj = ele;
            ctrl.OF_ElencoComuniItalianiobj1 = ele;
            ctrl.OF_ElencoComuniItalianiobj2=ele;
            ctrl.NomeProgetto='Test';
            ctrl.fileName= attach.Name;
            ctrl.filebody= attach.body;
            ctrl.attachmentExists=true;
            ctrl.idVLAN=sVlan1.id;
            
            ctrl.urlPage = ApexPages.currentPage().getURL();
            ctrl.recordOfferta='E-Line';
            ctrl.childLog= sl;
            ctrl.sLogMaster= slM;
            ctrl.parentLog= slFatt;
            ctrl.vlanList = slVlanList;
            ctrl.sLogKit = slKit;
            ctrl.logMaster= slCollList;
            ctrl.P2PAttivaLogList = slCollList;
            ctrl.insertChildLog();
            //ctrl.saveCollegamento();
            ctrl.sedeValue= slM.ID_Sede__c;
            try{
                ctrl.getRecordProfili();
            }
            catch(Exception e){}
            ctrl.cnt= cntList;
            ctrl.searchvalue='test';
            ctrl.render1=true;
            ctrl.pirCOS5 = 10;
            ctrl.pirCOS3 = 10;
            ctrl.pirCOS1 = 10;
            ctrl.cirCOS1 = 10;
            ctrl.cirCOS3 =10;
            ctrl.cirCOS5 = 10;
            //ctrl.nameSede = 'Test';
            ctrl.serviceAttribute='EPL'; //EVPL
            try{
                ctrl.modifyProf();
            }
            catch(exception e){}
            ctrl.Annulla();
            ctrl.nameSede = ctrl.sedeValue;
            try{
                ctrl.insertNewVLAN();
            }
            catch(Exception e){}
            try{
                ctrl.modificaVLAN ();
            }
            Catch(Exception e){}
            try{
                if(sl.id==null){
                    insert sl;
                }
                if(slKit.id==null){
                    insert slKit;
                }
                insert sVlan1;
                ctrl.upload();
                ctrl.idVLAN=sVlan1.id;
                ctrl.cessaVLAN(); 
            }
            Catch(Exception e){} 
            ctrl.searchTerm1=ele.Name;
            ctrl.verifyProfilo='Test';
            ctrl.profiloCommerciale='10G';
            PO_P2PAttiva_EditLogInfoCntrlELine.profCommerciale='10G';
            ctrl.profiloName='10G';  
            Test.stopTest();
        }
        
    }
    
    public static testMethod void testMeth2b(){
        TestDataFactory.CreateTestRecords(null,null, null);
        OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica.OF_ProfiloCommerciale__c = 'P2PATTIVA_10G';
        codifica.OF_ListinoCanoneName__c ='P2PATTIVA_10G';
        codifica.Name = '10G';
        codifica.IsPortalValid__c = true;
        codifica.servizio__c='P2P Attiva';
        codifica.CosType__c='MULTI_COS';
        insert codifica;
        
        
        OF_CodificaProfiloListini__c codifica3 = new OF_CodificaProfiloListini__c();
        //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
        codifica3.OF_ProfiloCommerciale__c = 'P2PATTIVA_5G';
        codifica3.OF_ListinoCanoneName__c ='P2PATTIVA_5G';
        codifica3.Name = '5G';
        codifica3.IsPortalValid__c = true;
        codifica3.servizio__c='P2P Attiva';
        codifica3.CosType__c='MONO_COS';
        
        insert codifica3;
        
        Map<String,Id> mpRT = creart();
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Id p = [select id from profile where name='Partner Community User'].id;  
        
        Account acc = new Account();
        acc.name = 'Test';
        acc.RecordTypeId=mpRT.get('OLO');
        acc.EOF_Codice_Operatore__c='TST';
        acc.VATNumber__c='00246465465';
        acc.Status__c='Attivo';
        acc.StartDate__c=DateTime.newInstance(2019, 4, 3, 3, 1, 5);
        
        insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
        
        insert cnt;
        
        list <Contact> cntList = new List<Contact>();
        cntList.add(cnt);
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                             ContactId = cnt.Id,
                             timezonesidkey='America/Los_Angeles', username='standarduse78rtest@testorg.com');
        
        insert user;
        
        /*  User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];

usr.ContactId=cnt.id;
//  update usr;
//  */ 
        
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Mondragone';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        //  
        
        
        Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
        
        OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
        
        /*EOF_EAI_Service_Log__c slC= new EOF_EAI_Service_Log__c(); //sl Collegamento
slC.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
slC.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
slC.PO_Tipo_percorso__c='Singola Via';
slC.PO_Indirizzo_collegamento__c='via test';
slC.EOF_Comune__c='Roma';
slC.EOF_Stato_Richiesta__c='Accettato';
slC.PO_Offerta__c='P2P Attiva';
slC.EOF_Codice_Operatore__c='TIS';
//sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
slC.PO_Tipo_di_collegamento__c='Point-to-Point';
slC.PO_Prime_Contractor__c='TEST';
slC.PO_Incluso_nell_offerta__c=true;
slC.PO_Numero_fibre_richieste__c='2';
slC.EOF_PROFILO__c='1';
slC.PO_Sito__c='test';
slC.PO_Civico__c='12';
*/
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        //  slList.add(slC);
        //  insert slList;
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('P2P_Attiva_Request_E_Line');
        slFatt.Tipologia_CPE__c = 'Low-End';
        slFatt.Tipologia_Alimentazione__c='AC';
        slFatt.Interfaccia_CPE__c='Ottica';
        slFatt.Service_Attribute__c ='EPL';
        slFatt.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        
        
        EOF_EAI_Service_Log__c slM= new EOF_EAI_Service_Log__c(); //sl Collegamento
        slM.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        slM.EOF_Codice_Ordine_OLO__c = 'TestM_9808980';
        slM.PO_Tipo_percorso__c='Singola Via';
        slM.PO_Indirizzo_collegamento__c='via test';
        slM.EOF_Comune__c='Mondragone';
        slM.OF_Id_Comune__c=ele.id;
        slM.EOF_Stato_Richiesta__c='Accettato';
        slM.PO_Offerta__c='P2P Attiva';
        slM.EOF_Codice_Operatore__c='TIS';
        //slM.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slM.PO_Tipo_di_collegamento__c='Point-to-Point';
        slM.Tipologia_Sede__c='Master';
        
        slM.PO_Prime_Contractor__c='TEST';
        slM.PO_Incluso_nell_offerta__c=true;
        slM.PO_Numero_fibre_richieste__c='2';
        //slM.EOF_PROFILO__c='1';
        slM.PO_Sito__c='test';
        slM.PO_Civico__c='12';
        slM.EOF_SL_Riferimento__c=slFatt.id;
        slM.Tipologia_CPE__c = 'Low-End';
        slM.Tipologia_Alimentazione__c='AC';
        slM.Interfaccia_CPE__c='Ottica';
        slM.Service_Attribute__c ='EPL';
        slM.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        //insert slM;
        //slM.ID_Sede__c= slM.Name;
        //update slM;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Mondragone';
        sl.OF_Id_Comune__c=ele.id;
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.Tipologia_Sede__c='Satellite';
        sl.ID_Sede_Master__c = slM.ID_Sede__c;
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        sl.Tipologia_CPE__c = 'Low-End';
        sl.Tipologia_Alimentazione__c='AC';
        sl.Interfaccia_CPE__c='Ottica';
        //  insert sl;
        
        //  slList.add(sl);
        //  
        List<EOF_EAI_Service_Log__c> slCollList = new List<EOF_EAI_Service_Log__c>();
        slCollList.add(sl);
        slCollList.add(slM);
        
        EOF_EAI_Service_Log__c slKit = new EOF_EAI_Service_Log__c();
        slKit.recordtypeId = mpRT.get('PO_Log_P2P_Attiva_KIT');
        slKit.EOF_Stato_Richiesta__c ='NA';
        slKit.Nome_del_KIT__c='KIT_00001';
        slKit.Modello_di_Servizio__c='';
        slKit.EOF_CODICE_OPERATORE__c='TIS';//actualUser.Contact.Account.EOF_Codice_Operatore__c'';
        slKit.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        slKit.EOF_ID_Pop__c ='NA_01';
        slKit.PO_P2PAttiva_Nome_del_KIT__c='Kit_0001';
        slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'Via Test';
        slKit.PO_P2PAttiva_Optical_Rate_Limiting__c = '10 GB';
        slKit.EOF_SL_Riferimento__c = slFatt.id;
        slKit.kit_in_condivisione__c =sl.id;
        slKit.Service_Attribute__c ='EPL';//SERVICE_EPL
        slKit.Tipologia_CPE__c = 'Low-End';
        slKit.Tipologia_Alimentazione__c='AC';
        slKit.Interfaccia_CPE__c='Ottica';
        slKit.Service_Attribute__c ='EPL';
        slKit.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        //insert slKit;
        slList.add(slKit);
        
        EOF_EAI_Service_Log__c sVlan1 = new EOF_EAI_Service_Log__c();
        
        sVlan1.EOF_SL_Riferimento__c=sl.id;
        sVlan1.OF_PP_KIT_Log__c=slkIT.id;
        sVlan1.PO_Nota_sito__c='Nota Sito';
        sVlan1.EOF_STATO_ORDINE__c='Accettato';
        sVlan1.OF_SA_USER_VLAN__C='1111';
        sVlan1.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan1.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan1.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan1.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        sVlan1.RecordTypeId=mpRT.get('OF_SA_Vlan_ELine');
        sVlan1.Tipologia_CPE__c = 'Low-End';
        sVlan1.Tipologia_Alimentazione__c='AC';
        sVlan1.Interfaccia_CPE__c='Ottica';
        sVlan1.Service_Attribute__c ='EPL';
        sVlan1.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        
        // insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> slVlanList = new List<EOF_EAI_Service_Log__c>();
        slVlanList.add(sVlan1);
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
        parentCase.Status='Completato';
        parentCase.PO_Offerta__c ='P2P Attiva';
        parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
        parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
        parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
        // insert parentCase;
        //   slFatt.Caso__c= parentCase.id;
        //	 update slFatt;
        caseFromPortal.add(parentCase);
        
        Case Childcase = new Case();
        Childcase.Status='Completato';
        Childcase.AccountId=acc.id;
        ChildCase.parentid=parentCase.id;
        Childcase.PO_Richiesta_a_fattibilit__c=parentCase.id;
        Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
        Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
        Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        childcase.PO_Offerta__c = 'P2P Attiva';
        Childcase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
        Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
        // insert Childcase; 
        // sl.Caso__c=Childcase.id;
        // update sl;
        slList.add(sl);
        slList.add(slFatt);
        
        caseFromPortal.add(Childcase);
        List<Attachment>attList = new List<Attachment>();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = sl.id;
        // insert attach;
        attList.add(attach);
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = sl.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        slOrd.Tipologia_CPE__c = 'Low-End';
        slOrd.Tipologia_Alimentazione__c='AC';
        slOrd.Interfaccia_CPE__c='Ottica';
        slOrd.Service_Attribute__c ='EPL';
        slOrd.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        //insert slOrd;
        
        // slord.PO_Offerta_Inoltrata__c = True;
        // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //update slOrd;  
        slList.add(slOrd);
        
        EOF_EAI_Service_Log__c slOrd2= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd2.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd2.EOF_Stato_Richiesta__c='Accettato';
        slOrd2.PO_Offerta__c='P2P Attiva';
        slOrd2.Caso__c=parentCase.id;
        slOrd2.EOF_STATO_ORDINE__c='Accettato';
        slOrd2.PO_Prime_Contractor__c='TEST';
        slOrd2.EOF_NOTE__c='Note';
        slOrd2.EOF_SL_Riferimento__c = slList[0].id;
        slOrd2.Note_Sospensione_Operatore__c='TEST';
        slOrd2.Tipologia_CPE__c = 'Low-End';
        slOrd2.Tipologia_Alimentazione__c='AC';
        slOrd2.Interfaccia_CPE__c='Ottica';
        slOrd2.Service_Attribute__c ='EPL';
        slOrd2.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord2.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd2.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        //  insert slOrd2;
        // slord2.PO_Offerta_Inoltrata__c = True;
        //slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //slOrd.Caso__c=Childcase.id;
        // update slOrd2;
        slList.add(slOrd2);
        
        
        
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        opp1.PO_Richiesta_fattibilit__c=parentCase.id;
        opp1.PO_Collegamento__c = null;
        //insert opp1;
        System.debug('Testing'+opp1);
        
        list<Opportunity> oppLst = new list<Opportunity>();
        Opportunity opp2 = new Opportunity();
        opp2.Name='Opp TEST';
        opp2.StageName='Offerta presentata';
        opp2.CloseDate=System.today().addDays(30);
        opp2.PO_Richiesta_fattibilit__c=parentCase.id;
        opp2.PO_Collegamento__c = Childcase.id;
        opp2.PO_Offerta_totale__c= opp1.id;
        oppLst.add(opp2);
        //  insert oppLst;
        
        Attachment attach2=new Attachment();     
        attach2.Name='Unit Test Attachment';
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        attach2.body=bodyBlob2;
        attach2.parentId=oppLst[0].id;
        // insert attach2;
        attList.add(attach2);
        
        
        
        system.runAs(user){
            Test.startTest();
            Test.setCurrentPageReference(new PageReference('PO_P2PAttiva_EditLogInfoELine'));
            ApexPages.currentPage().getParameters().put('tipoP2Patt','eLine');
            ApexPages.currentPage().getParameters().put('parentId', slFatt.id);
            ApexPages.currentPage().getParameters().put('cLogId',sl.id);
            
            PO_P2PAttiva_EditLogInfoCntrlELine ctrl = new PO_P2PAttiva_EditLogInfoCntrlELine();
            ctrl.insertMode=false;
            ctrl.usr = user;
            ctrl.tipoP2PAttiva=  ApexPages.currentPage().getParameters().get('tipoP2Patt');
            ctrl.selectedIdComune= ele.id;
            ctrl.selectedIdComune1=ele.id;
            ctrl.selectedIdComune2=ele.id;
            ctrl.OF_ElencoComuniItalianiobj = ele;
            ctrl.OF_ElencoComuniItalianiobj1 = ele;
            ctrl.OF_ElencoComuniItalianiobj2=ele;
            ctrl.NomeProgetto='Test';
            ctrl.profiloName='10G';
            ctrl.fileName= attach.Name;
            ctrl.filebody= attach.body;
            ctrl.attachmentExists=true;
            ctrl.idVLAN=sVlan1.id;
            
            ctrl.urlPage = ApexPages.currentPage().getURL();
            ctrl.recordOfferta='E-Line';
            ctrl.childLog= sl;
            ctrl.sLogMaster= slM;
            ctrl.parentLog= slFatt;
            ctrl.vlanList = slVlanList;
            ctrl.sLogKit = slKit;
            ctrl.logMaster= slCollList;
            ctrl.P2PAttivaLogList = slCollList;
            try{
                ctrl.tipoP2PAttiva='eLine';
                ctrl.idVLAN = null;
                ctrl.modifyProf();  
            }catch(exception e){}
            try{
                ctrl.tipoP2PAttiva='eAccess';
                ctrl.idVLAN = null;
                ctrl.modifyProf();  
            }catch(exception e){}    
            ctrl.insertChildLog();
            //ctrl.saveCollegamento();
            ctrl.sedeValue= slM.ID_Sede__c;
            try{
                ctrl.getRecordProfili();
            }
            catch(Exception e){}
            ctrl.cnt= cntList;
            ctrl.searchvalue='test';
            ctrl.render1=true;
            ctrl.pirCOS5 = 10;
            ctrl.pirCOS3 = 10;
            ctrl.pirCOS1 = 10;
            ctrl.cirCOS1 = 10;
            ctrl.cirCOS3 =10;
            ctrl.cirCOS5 = 10;
            //ctrl.nameSede = 'Test';
            ctrl.serviceAttribute='EPL'; //EVPL
            ctrl.upload();
            try{
                ctrl.insertMode=false;
                insert ctrl.childLog;
                ctrl.upload();  
            }
            catch(exception e){}
            try{
                String a = '€'.repeat(5999999);// 'a'.repeat(5999999);
                // MEDIUMBLOB b =  ; 
                ctrl.filebody = EncodingUtil.base64Decode(a); //EncodingUtil.base64Encode(a); //MEDIUMBLOB.valueOf(a);  //Blob.valueOf(a);//+Blob.valueOf(a);
                ctrl.upload(); 
            }catch(Exception e){}
            ctrl.filebody= null;
            try{
                ctrl.upload();  
            }catch(Exception e){}
            
            try{
                ctrl.modifyProf();
            }
            catch(exception e){}
            ctrl.Annulla();
            ctrl.nameSede = ctrl.sedeValue;
            try{
                ctrl.insertNewVLAN();
            }
            catch(Exception e){}
            try{
                ctrl.modificaVLAN ();
            }
            Catch(Exception e){}
            try{
                if(sl.id==null){
                    insert sl;
                }
                if(slKit.id==null){
                    insert slKit;
                }
                insert sVlan1;
                ctrl.upload();
                ctrl.idVLAN=sVlan1.id;
                ctrl.cessaVLAN(); 
            }
            Catch(Exception e){}
            ctrl.searchTerm1=ele.id;
            
            Test.stopTest();
            
        }
        
        
        
    }
    
}
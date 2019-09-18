@isTest
public class PO_COMP_P2PAtt_ListaReqInBozELineCtrTEST {
    
    public static testMethod  Map<String,Id> creart(){
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        return mpRT;
    }
    
    public static testmethod void testmeth1(){
        
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
        
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Test';
        ele.OF_Comune__c = 'Test';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
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
                timezonesidkey='America/Los_Angeles', username='standarduse3587rtest@testorg.com');
       
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
        
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('P2P_Attiva_Request_E_Line');
        slFatt.PO_Tipo_di_collegamento__c ='E-Line' ;
        slFatt.EOF_Tipo_Comunicazione_String__c='Ordine di Attivazione';
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
        
        List<Attachment>attList = new List<Attachment>();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = sl.id;
        insert attach;
        attList.add(attach);

       
        
        system.runAs(user){

        Test.setCurrentPageReference(new PageReference('PO_P2PAttiva_EditLogInfoELine'));
        ApexPages.currentPage().getParameters().put('tipoP2Patt','eLine');
        ApexPages.currentPage().getParameters().put('parentId', slFatt.id);
        ApexPages.currentPage().getParameters().put('cLogId',sl.id);
            
        PO_COMP_P2PAtt_ListaReqInBozzaELineCtr ctrl = new PO_COMP_P2PAtt_ListaReqInBozzaELineCtr();    
        
    	ctrl.listBozze =  slList;
    	ctrl.richieste =true;
    	ctrl.IdBozza = slFatt.id;
    	ctrl.tipoRIchiesta='Attivazione';
   		ctrl.totalRecord = 2;
        ctrl.pageActual =1;
        ctrl.totalpage=1;
        ctrl.showPag=true;
    	ctrl.pageRecord=2;
    	ctrl.offset_page=1;
    	ctrl.totpg= 1;
   		ctrl.showRow = true;
    	ctrl.totRec=1;
        ctrl.tipoP2PAttiva='eLine'; //LM 
        ctrl.pageDown();
        ctrl.vediReq();
            ctrl.pageUp();
        ctrl.setPagination(null);
        ctrl.totalpage=5;    
        ctrl.setPagination(true);
		ctrl.setPagination(false);
        ctrl.tipoRIchiesta='Ordine di Cessazione';
        ctrl.vediReq();
    	}
    }

}
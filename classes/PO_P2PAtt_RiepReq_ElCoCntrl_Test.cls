@isTest
public class PO_P2PAtt_RiepReq_ElCoCntrl_Test{
    
    public static testMethod void testInviaRichiesta2() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        
        OF_CatalogoCommerciale__c catalogo = [SELECT Id FROM OF_CatalogoCommerciale__c WHERE Name = 'Catalogo_Test' LIMIT 1];
        OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catalogo, 'Open Stream', '123456');
        OF_CommercialElement__c ce = PO_ServFatt_DataFactory.createCE(serv, 'VLAN', 'CE-OS000001');

        Test.startTest();
        PO_P2PAtt_RiepReq_ElCoCntrl ctrl = new PO_P2PAtt_RiepReq_ElCoCntrl();
        ctrl.accId = data.casePadre.AccountId;
        ctrl.parentLogObj = data.logRichiesta;
        ctrl.P2PAttivaLogList = new List<EOF_EAI_Service_Log__c>{data.logCollegamento};
        ctrl.ListKitToSend = new List<EOF_EAI_Service_Log__c>();
        ctrl.slListToDelete = new List<EOF_EAI_Service_Log__c>();
        
        ctrl.InviaRichiesta_2();
        Test.stopTest();
    }

    public static testMethod void inviaRichiesta_2TestEline() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        
        OF_CatalogoCommerciale__c catalogo = [SELECT Id FROM OF_CatalogoCommerciale__c WHERE Name = 'Catalogo_Test' LIMIT 1];
        OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catalogo, 'Open Stream', '123456');
        OF_CommercialElement__c ce = PO_ServFatt_DataFactory.createCE(serv, 'VLAN', 'CE-OS000001');

        Test.startTest();
        PO_P2PAtt_RiepReq_ElCoCntrl ctrl = new PO_P2PAtt_RiepReq_ElCoCntrl();
        ctrl.accId = data.casePadre.AccountId;
        ctrl.parentLogObj = data.logRichiesta;
        ctrl.tipoP2PAttiva = 'eLine';
        ctrl.P2PAttivaLogList = new List<EOF_EAI_Service_Log__c>{data.logCollegamento};
        ctrl.ListKitToSend = new List<EOF_EAI_Service_Log__c>();
        ctrl.slListToDelete = new List<EOF_EAI_Service_Log__c>();
        
        ctrl.InviaRichiesta_2();
        Test.stopTest();
    }

    @testSetup
    static void createData()
    {
        //Creazione custom setting
        list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
        CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();
        
        OF_Configurazioni__c CustSett1 = new OF_Configurazioni__c();
        CustSett1 = OF_AreaGeograficaUtilityTest.CustomSetting1();    
       
        list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
        CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();
        
        Parametri_Fattibilita__c CustSett3 = new Parametri_Fattibilita__c();
        CustSett3 = OF_AreaGeograficaUtilityTest.CustomSetting3();
        
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom;
        
       /* ServFattib__C cs = new ServFattib__C();
        cs.creaOppParentFase__c = 'Test\test';
        cs.creaOppParentOfferta__c = 'Test\test';
        cs.creaOppParentRecordTypeName__c = 'Test\test';
        cs.creaOppChildFase__c = 'Test\test';
        cs.creaOppChildRecordTypeName__c = 'Test\test';  
        insert cs;*/
    } 
    public static testMethod void ParentDataOrderUpdationMethod(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
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
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
       
        
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
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
       // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        
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
       
        insert sVlan1;
        slList.add(sVlan1);
        
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

       /*
         Case Childcase2 = new Case();
         Childcase2.Status='Completato';
         Childcase2.AccountId=acc.id;
         Childcase2.EOF_Codice_Ordine_OLO__c='Test_980898011';
         Childcase2.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         Childcase2.PO_Nome_E_Cognome_PM__c='TEST';                            
         Childcase2.PO_Numero_Telefonico_PM__c='35464684848468464';
         Childcase2.PO_Offerta__c = 'P2P Attiva';
         Childcase2.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         Childcase2.PO_Nome_Progetto__c='TEST Nome Progetto2';
         insert Childcase2;  */
        
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
        
        Test.StartTest();
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
        riep.parentLogObj = slFatt;
        riep.orderLogs = slList; 
        
        riep.SearchLog();
        riep.runSearchProfilo();
        riep.currentUserParentCases();
        riep.currentUserParentLogs();
        riep.recordOfferta = 'P2P Attiva';
        riep.ChildCase = Childcase;
        riep.childCaseObj= Childcase;
        riep.parentCase = parentcase;
        riep.parentcaseobj = parentcase;
        riep.childLog = sl;
        riep.cLogId=sl.id;
        
        ApexPages.currentPage().getParameters().put('recordOfferta','P2P Attiva');
        riep.getsortingCases();
        ApexPages.currentPage().getParameters().put('parentId',slFatt.id) ;
        riep.parentCaseObj =parentCase;
     //   riep.ParentDataOrderUpdation();
        try{
        riep.OpportunityStageNameUpdate();
        }catch(exception e){}
        try{
            riep.OpportunityStageNameUpdate3a();
        } catch(exception e){}
        try{
        riep.OpportunityStageNameUpdate3(); 
        }
        Catch(exception e){
            
        }
        ApexPages.currentPage().getParameters().put('CaseDetail',parentcase.id);
        riep.DisplayCaseInfo();
        apexpages.currentPage().getparameters().put('parentId',parentcase.id);
        riep.DeleteParentChildCase();
         apexpages.currentPage().getparameters().put('parentId',slFatt.id);
        riep.DeleteParentChildLog();
        //riep.creaCaseKit(slList);
        //riep.InviaRichiesta();
        riep.selectedIdComune = ele.id;
        riep.selectedIdComune1 = ele.id;
        riep.selectedIdComune2 = ele.id;

        try{
        riep.SaveParentChildCaseInfo();
        }catch(exception e){}
        try{
        riep.getsortingLogs();
        }catch(exception e){
            
        }
        riep.textarea1='textArea';
        riep.showEdit=true;
        riep.childcheck=true;
        riep.checkProfilo=true;
        riep.checkCollKit=true;
        //riep.checkProfiloKitCollegamento(slFatt.id);
          riep.checkProfiloKitCollegamento();
        //riep.attToInsert= attList;
        //riep.attToDelete= attList;
        
        //riep.parentLogObj = slord;
        //riep.P2PAttivaLogList = slList; 
        //riep.OpportunityStageNameUpdate2();
        Test.StopTest();
    }
    
    public static testMethod void OrderCreationMethod(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
         User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
         Account acc = new Account();
         acc.name = 'Test';
         insert acc;
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        order o = new order();
        o.recordtypeID = mpRT.get('OF_INORDER');
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = acc.id;
        o.OF_TipologiaDiServizio__c='Attivo';
        o.PO_IsFromOpportunity__c=true;
        o.Name ='test1';
        //o.OF_CaseNome__c=oCase.CaseNumber;
        //o.OF_IDOrdineEOF__c=oCase.Codice_Ordine_EOF__c;
        insert o;        
        
         Case Childcase = new Case();
         Childcase.Status='Accettato';
         Childcase.AccountId=acc.id;
         Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
         Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
         Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         childcase.PO_Offerta__c = 'P2P Base';
         Childcase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
         insert Childcase; 
        
         list<Case> Caselist = new List<Case>();
         Case parentCase = new Case();
         parentCase.AccountId=acc.Id;
         parentCase.Status='Accettato';
         parentCase.parentid=Childcase.id;
         parentCase.PO_Case_Collegamento__c = Childcase.id;
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         parentCase.PO_Tipo_percorso__c = 'Singola Via';
         parentcase.OF_Order__c = o.id;
         parentcase.PO_Tempi_di_attivazione_mesi__c = 1;
         parentcase.PO_Data_Attivazione_Ordine__c = System.today();
         Caselist.add(parentCase);
         insert Caselist;
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        //opp1.PO_Richiesta_fattibilit__c=Caselist[0].id;
        opp1.PO_Collegamento__c = Caselist[0].id;
        insert opp1;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        insert sl;
        
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
        slOrd.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        insert slOrd;
        slord.PO_Offerta_Inoltrata__c = True;
       // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;
        
        
        Test.StartTest();
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
        ApexPages.currentPage().getParameters().put('recordOfferta','P2P Base');
        ApexPages.currentPage().getParameters().put('parentId',slord.id) ;
        riep.parentCaseObj =parentCase;
        riep.ChildCases = Caselist;
        riep.OrderCreation(Caselist);
        riep.getkitLogList();
        riep.getorderCases();
       /* riep.CaseDetail = parentCase.id;
        ApexPages.currentPage().getParameters().put('CaseDetail',parentCase.id);
        riep.EditOrderInfo();
        apexpages.currentPage().getParameters().put('recid',slord.id);
        riep.collegmentaDate();
        parentcase.PO_Tempi_di_attivazione_mesi__c = null;
        update parentcase;
        riep.collegmentaDate();
        apexpages.currentPage().getParameters().put('editid',parentCase.id);
        riep.collegmentaDateEdit();
        riep.childCase();
        riep.parentCase = parentcase;
        riep.childCase();
        riep.parentcaseobj = null;
        riep.parentCase = null;
        riep.testcase = parentcase;
        riep.childCase();
        
        
        
        riep.P2PAttivaLogPadre = slOrd;
        
       ApexPages.currentPage().getParameters().put('kitId',slOrd.id);
        ApexPages.currentPage().getParameters().put('cLogId',slOrd.id);
        riep.inserisciNuovoCollegamento();
        riep.inserisciNuovoKit();
        riep.goToKITpage();
        slOrd.EOF_STATO_ORDINE__c='Bozza Portale';
        update slord;
        riep.goToKITpage();
        riep.kitId = slOrd.id;
        riep.eliminaKit();
        riep.EditLogInfo();
        riep.redirectparentlogdetail();
        riep.redirectchildlogdetail();
        List<EOF_EAI_Service_Log__c> slOList= new List<EOF_EAI_Service_Log__c>();
        slOList.add(slOrd);
        riep.P2PAttivaLogList = slOList;
        riep.deleteLog();
        riep.getparentOppty();
        riep.checkStageName();
        riep.childLogObj  = slOrd;
        riep.DetailPage();
        riep.AddParentAttachment();
        riep.deleteVoidKitLog();
        //riep.Annulla();
        riep.P2PAttivaLogPadre = slord;
        try{
           riep.ParentCaseRecord();
        }
        catch(exception e){
        }
        try{
          riep.createChildLog();
           }
        catch(exception e){
          }*/
        Test.StopTest();
    }
        public static testMethod void OrderCreationMethodC(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
         User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
         Account acc = new Account();
         acc.name = 'Test';
         insert acc;
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        order o = new order();
        o.recordtypeID = mpRT.get('OF_INORDER');
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = acc.id;
        o.OF_TipologiaDiServizio__c='Attivo';
        o.PO_IsFromOpportunity__c=true;
        o.Name ='test1';
        //o.OF_CaseNome__c=oCase.CaseNumber;
        //o.OF_IDOrdineEOF__c=oCase.Codice_Ordine_EOF__c;
        insert o;        
        
         Case Childcase = new Case();
         Childcase.Status='Accettato';
         Childcase.AccountId=acc.id;
         Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
         Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
         Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         childcase.PO_Offerta__c = 'P2P Base';
         Childcase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
         insert Childcase; 
        
         list<Case> Caselist = new List<Case>();
         Case parentCase = new Case();
         parentCase.AccountId=acc.Id;
         parentCase.Status='Accettato';
         parentCase.parentid=Childcase.id;
         parentCase.PO_Case_Collegamento__c = Childcase.id;
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         parentCase.PO_Tipo_percorso__c = 'Singola Via';
         parentcase.OF_Order__c = o.id;
         parentcase.PO_Tempi_di_attivazione_mesi__c = 1;
         parentcase.PO_Data_Attivazione_Ordine__c = System.today();
         Caselist.add(parentCase);
         insert Caselist;
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        //opp1.PO_Richiesta_fattibilit__c=Caselist[0].id;
        opp1.PO_Collegamento__c = Caselist[0].id;
        insert opp1;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        insert sl;
        
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
        slOrd.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        insert slOrd;
        slord.PO_Offerta_Inoltrata__c = True;
       // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;
        
        
        Test.StartTest();
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
       /* ApexPages.currentPage().getParameters().put('recordOfferta','P2P Base');
        ApexPages.currentPage().getParameters().put('parentId',slord.id) ;
        riep.parentCaseObj =parentCase;
        riep.ChildCases = Caselist;
        riep.OrderCreation(Caselist);
        riep.getkitLogList();
        riep.getorderCases();*/
        riep.CaseDetail = parentCase.id;
        ApexPages.currentPage().getParameters().put('CaseDetail',parentCase.id);
        riep.EditOrderInfo();
        apexpages.currentPage().getParameters().put('recid',slord.id);
        riep.collegmentaDate();
        parentcase.PO_Tempi_di_attivazione_mesi__c = null;
        update parentcase;
        riep.collegmentaDate();
        apexpages.currentPage().getParameters().put('editid',parentCase.id);
        apexpages.currentPage().getParameters().put('recid',slord.id);
        riep.collegmentaDateEdit();
            try{
        riep.childCase();
            }catch(exception e){}
        riep.parentCase = parentcase;
        riep.childCase();
        riep.parentcaseobj = null;
        riep.parentCase = null;
        riep.testcase = parentcase;
        riep.childCase();
        
        
        
       /* riep.P2PAttivaLogPadre = slOrd;
        
       ApexPages.currentPage().getParameters().put('kitId',slOrd.id);
        ApexPages.currentPage().getParameters().put('cLogId',slOrd.id);
        riep.inserisciNuovoCollegamento();
        riep.inserisciNuovoKit();
        riep.goToKITpage();
        slOrd.EOF_STATO_ORDINE__c='Bozza Portale';
        update slord;
        riep.goToKITpage();
        riep.kitId = slOrd.id;
        riep.eliminaKit();
        riep.EditLogInfo();
        riep.redirectparentlogdetail();
        riep.redirectchildlogdetail();
        List<EOF_EAI_Service_Log__c> slOList= new List<EOF_EAI_Service_Log__c>();
        slOList.add(slOrd);
        riep.P2PAttivaLogList = slOList;
        riep.deleteLog();
        riep.getparentOppty();
        riep.checkStageName();
        riep.childLogObj  = slOrd;
        riep.DetailPage();
        riep.AddParentAttachment();
        riep.deleteVoidKitLog();
        //riep.Annulla();
        riep.P2PAttivaLogPadre = slord;
        try{
           riep.ParentCaseRecord();
        }
        catch(exception e){
        }
        try{
          riep.createChildLog();
           }
        catch(exception e){
          }*/
        Test.StopTest();
    }
    
    
        public static testMethod void OrderCreationMethodB(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
         User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
         Account acc = new Account();
         acc.name = 'Test';
         insert acc;
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        order o = new order();
        o.recordtypeID = mpRT.get('OF_INORDER');
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = acc.id;
        o.OF_TipologiaDiServizio__c='Attivo';
        o.PO_IsFromOpportunity__c=true;
        o.Name ='test1';
        //o.OF_CaseNome__c=oCase.CaseNumber;
        //o.OF_IDOrdineEOF__c=oCase.Codice_Ordine_EOF__c;
        insert o;        
        
         Case Childcase = new Case();
         Childcase.Status='Accettato';
         Childcase.AccountId=acc.id;
         Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
         Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
         Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         childcase.PO_Offerta__c = 'P2P Base';
         Childcase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
         insert Childcase; 
        
         list<Case> Caselist = new List<Case>();
         Case parentCase = new Case();
         parentCase.AccountId=acc.Id;
         parentCase.Status='Accettato';
         parentCase.parentid=Childcase.id;
         parentCase.PO_Case_Collegamento__c = Childcase.id;
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         parentCase.PO_Tipo_percorso__c = 'Singola Via';
         parentcase.OF_Order__c = o.id;
         parentcase.PO_Tempi_di_attivazione_mesi__c = 1;
         parentcase.PO_Data_Attivazione_Ordine__c = System.today();
         Caselist.add(parentCase);
         insert Caselist;
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        //opp1.PO_Richiesta_fattibilit__c=Caselist[0].id;
        opp1.PO_Collegamento__c = Caselist[0].id;
        insert opp1;
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
        
        
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        insert sl;
          
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
        
        
        Test.StartTest();
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
       /* ApexPages.currentPage().getParameters().put('recordOfferta','P2P Base');
        ApexPages.currentPage().getParameters().put('parentId',slord.id) ;
        riep.parentCaseObj =parentCase;
        riep.ChildCases = Caselist;
        riep.OrderCreation(Caselist);
        riep.getkitLogList();
        riep.getorderCases();
        riep.CaseDetail = parentCase.id;
        ApexPages.currentPage().getParameters().put('CaseDetail',parentCase.id);
        riep.EditOrderInfo();
        apexpages.currentPage().getParameters().put('recid',slord.id);
        riep.collegmentaDate();
        parentcase.PO_Tempi_di_attivazione_mesi__c = null;
        update parentcase;
        riep.collegmentaDate();
        apexpages.currentPage().getParameters().put('editid',parentCase.id);
        riep.collegmentaDateEdit();
        riep.childCase();
        riep.parentCase = parentcase;
        riep.childCase();
        riep.parentcaseobj = null;
        riep.parentCase = null;
        riep.testcase = parentcase;
        riep.childCase();*/
        
        
        
        riep.P2PAttivaLogPadre = slOrd;
        
       	ApexPages.currentPage().getParameters().put('kitId',slKit.id);
        ApexPages.currentPage().getParameters().put('cLogId',sl.id);
        ApexPages.currentPage().getParameters().put('parentId',slFatt.id);
        riep.inserisciNuovoCollegamento();
        riep.inserisciNuovoKit();
        riep.goToKITpage();
        slOrd.EOF_STATO_ORDINE__c='Bozza Portale';
        update slord;
        riep.goToKITpage();
        riep.kitId = slKit.id;
        riep.eliminaKit();
        riep.EditLogInfo();
        riep.redirectparentlogdetail();
        riep.redirectchildlogdetail();
        riep.DeleteParentChildLog();
       /* List<EOF_EAI_Service_Log__c> slOList= new List<EOF_EAI_Service_Log__c>();
        slOList.add(slOrd);
        riep.P2PAttivaLogList = slOList;
        riep.deleteLog();
        riep.getparentOppty();
        riep.checkStageName();
        riep.childLogObj  = slOrd;
        riep.DetailPage();
        riep.AddParentAttachment();
        riep.deleteVoidKitLog();
        //riep.Annulla();
        riep.P2PAttivaLogPadre = slord;
        try{
           riep.ParentCaseRecord();
        }
        catch(exception e){
        }
        try{
          riep.createChildLog();
           }
        catch(exception e){
          }*/
        Test.StopTest();
    }
    
        
    public static testMethod void OrderCreationMethodA(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
         User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
         Account acc = new Account();
         acc.name = 'Test';
         insert acc;
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        order o = new order();
        o.recordtypeID = mpRT.get('OF_INORDER');
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = acc.id;
        o.OF_TipologiaDiServizio__c='Attivo';
        o.PO_IsFromOpportunity__c=true;
        o.Name ='test1';
        //o.OF_CaseNome__c=oCase.CaseNumber;
        //o.OF_IDOrdineEOF__c=oCase.Codice_Ordine_EOF__c;
        insert o;        
        
         Case Childcase = new Case();
         Childcase.Status='Accettato';
         Childcase.AccountId=acc.id;
         Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
         Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
         Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         childcase.PO_Offerta__c = 'P2P Base';
         Childcase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
         insert Childcase; 
        
         list<Case> Caselist = new List<Case>();
         Case parentCase = new Case();
         parentCase.AccountId=acc.Id;
         parentCase.Status='Accettato';
         parentCase.parentid=Childcase.id;
         parentCase.PO_Case_Collegamento__c = Childcase.id;
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         parentCase.PO_Tipo_percorso__c = 'Singola Via';
         parentcase.OF_Order__c = o.id;
         parentcase.PO_Tempi_di_attivazione_mesi__c = 1;
         parentcase.PO_Data_Attivazione_Ordine__c = System.today();
         Caselist.add(parentCase);
         insert Caselist;
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Opp TEST';
        opp1.StageName='Offerta presentata';
        opp1.CloseDate=System.today().addDays(30);
        //opp1.PO_Richiesta_fattibilit__c=Caselist[0].id;
        opp1.PO_Collegamento__c = Caselist[0].id;
        insert opp1;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        insert sl;
        
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
        slOrd.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        insert slOrd;
        slord.PO_Offerta_Inoltrata__c = True;
       // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;
        
        
        Test.StartTest();
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
       /* ApexPages.currentPage().getParameters().put('recordOfferta','P2P Base');
        ApexPages.currentPage().getParameters().put('parentId',slord.id) ;
        riep.parentCaseObj =parentCase;
        riep.ChildCases = Caselist;
        riep.OrderCreation(Caselist);
        riep.getkitLogList();
        riep.getorderCases();
        riep.CaseDetail = parentCase.id;
        ApexPages.currentPage().getParameters().put('CaseDetail',parentCase.id);
        riep.EditOrderInfo();
        apexpages.currentPage().getParameters().put('recid',slord.id);
        riep.collegmentaDate();
        parentcase.PO_Tempi_di_attivazione_mesi__c = null;
        update parentcase;
        riep.collegmentaDate();
        apexpages.currentPage().getParameters().put('editid',parentCase.id);
        riep.collegmentaDateEdit();
        riep.childCase();
        riep.parentCase = parentcase;
        riep.childCase();
        riep.parentcaseobj = null;
        riep.parentCase = null;
        riep.testcase = parentcase;
        riep.childCase();
        
        
        
        riep.P2PAttivaLogPadre = slOrd;
        
       ApexPages.currentPage().getParameters().put('kitId',slOrd.id);
        ApexPages.currentPage().getParameters().put('cLogId',slOrd.id);
        riep.inserisciNuovoCollegamento();
        riep.inserisciNuovoKit();
        riep.goToKITpage();
        slOrd.EOF_STATO_ORDINE__c='Bozza Portale';
        update slord;
        riep.goToKITpage();
        riep.kitId = slOrd.id;
        riep.eliminaKit();
        riep.EditLogInfo();
        riep.redirectparentlogdetail();
        riep.redirectchildlogdetail();*/
        List<EOF_EAI_Service_Log__c> slOList= new List<EOF_EAI_Service_Log__c>();
        slOList.add(slOrd);
        riep.P2PAttivaLogList = slOList;
        riep.deleteLog();
        riep.getparentOppty();
        riep.checkStageName();
        riep.childLogObj  = slOrd;
        riep.DetailPage();
        riep.AddParentAttachment();
        riep.deleteVoidKitLog();
        //riep.Annulla();
        riep.P2PAttivaLogPadre = slord;
        try{
           riep.ParentCaseRecord();
        }
        catch(exception e){
        }
        try{
          riep.createChildLog();
           }
        catch(exception e){
          }
        Test.StopTest();
    }
    
    public static testMethod void creaCaseKitMethod(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
         Account acc = new Account();
         acc.name = 'Test';
         insert acc;
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
       
         Case Childcase = new Case();
         Childcase.Status='Accettato';
         Childcase.AccountId=acc.id;
         Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
         Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
         Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         childcase.PO_Offerta__c = 'P2P Base';
         Childcase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
         insert Childcase; 
        
         list<Case> Caselist = new List<Case>();
         Case parentCase = new Case();
         parentCase.AccountId=acc.Id;
         parentCase.Status='Accettato';
         parentCase.parentid=Childcase.id;
         parentCase.PO_Case_Collegamento__c = Childcase.id;
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Case_P2P_Attiva_KIT');
         parentCase.PO_Tipo_percorso__c = 'Singola Via';
         parentcase.PO_Tempi_di_attivazione_mesi__c = 1;
         parentcase.PO_Data_Attivazione_Ordine__c = System.today();
         parentcase.EOF_Identificativo_del_POP__c = 'Test';
         Caselist.add(parentCase);
         insert Caselist;
        
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Acquisito';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_ID_Pop__c = 'Test';
        sl.Caso__c=parentCase.id;
        //insert sl;
         List<EOF_EAI_Service_Log__c> slOrdList= new List<EOF_EAI_Service_Log__c>();
        slOrdList.add(sl);
        insert slOrdList;
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Acquisito';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = slOrdList[0].id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slord.EOF_ID_Pop__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        insert slOrd;
       
        Test.StartTest();
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
        //riep.P2PAttivaLogList = slOrdList;
        //riep.deleteLog();
        try{
        riep.creaCaseKit(slOrdList);
        }
        Catch(exception e){
        }
        Test.StopTest();
    }
    public static testMethod void OpportunityStageNameUpdate2Method(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
         Account acc = new Account();
         acc.name = 'Test';
         insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
            
        insert cnt;
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
        
         Case Childcase = new Case();
         Childcase.Status='Completato';
         Childcase.AccountId=acc.id;
         Childcase.EOF_Codice_Ordine_OLO__c='Test_980898000';
         Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
         Childcase.PO_Numero_Telefonico_PM__c='35464684848484644';
         childcase.PO_Offerta__c = 'P2P Base';
         Childcase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
         insert Childcase; 
        
         Case parentCase = new Case();
         parentCase.Status='Completato';
         parentCase.parentid=Childcase.id;
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464444';
         parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         insert parentCase;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_01';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        
        insert sl;
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_01';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = sl.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        slList.add(slOrd);
        insert slList;
        
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
        opp2.PO_Collegamento__c = null;
        opp2.PO_Offerta_totale__c= opp1.id;
        oppLst.add(opp2);
        insert oppLst;
        
       
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = slList[0].id;
        insert attach;
        
        OF_CatalogoCommerciale__c ofc = new OF_CatalogoCommerciale__c();
        ofc.OF_Attivo__c = true;
        ofc.OF_DataFineValidita__c = system.today();
        ofc.OF_DataInizioValidita__c = system.today();
        insert ofc;
        
        OF_Servizio__c ofs = new OF_Servizio__c();
        ofs.Name = 'Open Stream';
        ofs.OF_DataFineValidita__c = system.today();
        ofs.OF_DataInizioValidita__c = system.today();
        ofs.OF_CatalogoCommerciale__c = ofc.Id;
        insert ofs;
        
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Servizio__c = ofs .Id;
        com.name = 'VLAN';
        com.OF_DataFineValidita__c = system.today();
        com.OF_DataInizioValidita__c = system.today();
        insert com;
        
        Test.StartTest();
        ApexPages.currentPage().getParameters().put('parentId',slList[0].id);
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
        riep.listVLAN = slList;
         riep.parentLogObj = slList[0];
         riep.P2PAttivaLogList = slList;
         riep.OpportunityStageNameUpdate2();
        riep.searchCaseboolean = true;
        riep.caseObj = parentcase;
        riep.logObj = slList[0];
        riep.kLogObj=slList[0];
        riep.displayCase = parentcase;
        riep.displayLog = slList[0];
        riep.P2PAttivaLog = slList[0];
        riep.searchTerm = 'Test';
        riep.childDate = 'Test';
        riep.logDetail = 'Test';
        riep.orderLoglst = slList;
        riep.orderLogdispayordinedate = 'Test';
        riep.orderLogEdit = slList[0];
        riep.childrecdate = system.today();
        riep.orderline = true;
        riep.testcase = parentcase;
        riep.testlog = slList;
        riep.ParentDate = 'Test';
        riep.childcasedisplayid = slList[0].id;
        riep.childcasedisplayobj = parentcase;
        riep.childlogdisplayobj =slList[0];
        riep.childoppobj = opp1;
        riep.IndirizzoCliente = 'Test';
        List<attachment> attah = new List<attachment>();
        riep.childlogdisplayattlist = attah;
        //riep.attToDelete = attah;
        //riep.attToInsert = attah;
        riep.comune = 'Test';
        riep.orderId = slList[0].id;
        riep.parentOppty = opp1;
        riep.childOppty = opp1;
        riep.childCase();
        //riep.P2PAttivaLogPadre = null;
        try{
        riep.createChildLog();
        }catch(exception e){
            
        }
       try{
        riep.InviaRichiesta_2();
        }catch(exception e){
            
        }
         riep.kitList = slList;
        try{
         riep.InviaRichiesta();
        }Catch(exception e){}
        Test.StopTest();
    }
    
        public static testMethod void createChildLogMethod(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
         Account acc = new Account();
         acc.name = 'Test';
         insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
            
        insert cnt;
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
        
         Case Childcase = new Case();
         Childcase.Status='Completato';
         Childcase.AccountId=acc.id;
         Childcase.EOF_Codice_Ordine_OLO__c='Test_980898000';
         Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
         Childcase.PO_Numero_Telefonico_PM__c='35464684848484644';
         childcase.PO_Offerta__c = 'P2P Base';
         Childcase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
         insert Childcase; 
        
         Case parentCase = new Case();
         parentCase.Status='Completato';
         parentCase.parentid=Childcase.id;
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464444';
         parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         insert parentCase;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_01';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Bozza Portale';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        
        insert sl;
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_01';
        slOrd.EOF_Stato_Richiesta__c='Bozza Portale';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = sl.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        slList.add(slOrd);
        insert slList;
            slOrd.EOF_Stato_Richiesta__c='Bozza Portale';
            update slList;
            
        
        
        Test.StartTest();
        ApexPages.currentPage().getParameters().put('parentId',slList[0].id);
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
         riep.parentLogObj = null;
        riep.testlog = slList;
            try{
        riep.createChildLog();
            }catch(Exception e){}
        
            
        Test.StopTest();
    }
    
    
    public static testMethod void privateMethods(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
         Account acc = new Account();
         acc.name = 'Test';
         insert acc;
        
       contract cont = new contract();
       cont.AccountId = acc.Id;
       cont.Status = 'Attivo';  
       cont.StartDate = system.today();
       //cont.EndDate = system.today()+1;  
            insert cont;
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
       OF_CatalogoCommerciale__c ofc = new OF_CatalogoCommerciale__c();
        ofc.OF_Attivo__c = true;
        ofc.OF_DataFineValidita__c = system.today();
        ofc.OF_DataInizioValidita__c = system.today();
        insert ofc;
        
        OF_Servizio__c ofs = new OF_Servizio__c();
        ofs.Name = 'Open Stream';
        ofs.OF_DataFineValidita__c = system.today();
        ofs.OF_DataInizioValidita__c = system.today();
        ofs.OF_CatalogoCommerciale__c = ofc.Id;
        insert ofs;
        
        OF_ContrattoServizio__c contratto = new OF_ContrattoServizio__c();
        contratto.OF_Servizio__c = ofs.id;
        contratto.OF_Contract__c = cont.id;
            insert contratto;
            
     Test.StartTest();
        
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
        //riep.getContratto(acc.id,ofs.name);
        // riep.checkVendibilitaRichiesta(acc.id,ofs.name);
        Test.StopTest();
    }
    
    public static testMethod void test_annulla()
    {
        test.startTest();
        PO_P2PAtt_RiepReq_ElCoCntrl contr = new PO_P2PAtt_RiepReq_ElCoCntrl();
        contr.annulla();
        test.stopTest();
    }
    
    public static testMethod void privateMethods2(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        contract cont = new contract();
        cont.AccountId = acc.Id;
        cont.Status = 'Attivo';  
        cont.contractTerm = 6;
        cont.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert cont;
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        OF_CatalogoCommerciale__c ofc = new OF_CatalogoCommerciale__c();
        ofc.OF_Attivo__c = true;
        ofc.OF_DataFineValidita__c = system.today();
        ofc.OF_DataInizioValidita__c = system.today();
        insert ofc;
        
        OF_Servizio__c ofs = new OF_Servizio__c();
        ofs.Name = 'Open Stream';
        ofs.OF_DataFineValidita__c = system.today();
        ofs.OF_DataInizioValidita__c = system.today();
        ofs.OF_CatalogoCommerciale__c = ofc.Id;
        insert ofs;
        
        OF_ContrattoServizio__c contratto = new OF_ContrattoServizio__c();
        contratto.OF_Servizio__c = ofs.id;
        contratto.OF_Contract__c = cont.id;
        insert contratto;
            
        Test.StartTest();
        
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
        riep.getContratto(acc.id,ofs.name);
        riep.checkVendibilitaRichiesta(acc.id, ofs.name);
        Test.StopTest();
    }
    
    public static testMethod void InviaRichiesta_2_TEST(){
       
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        User usr = [Select id 
                    from User 
                    where ProfileId =:prfl.Id 
                    and IsActive=true LIMIT 1];
                    
        Map<String,Id> mpRT = new Map<String,Id>();
        
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
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
        
        
        Case Childcase = new Case();
        Childcase.Status = 'Completato';
        Childcase.AccountId = acc.id;
        Childcase.EOF_Codice_Ordine_OLO__c='Test_9808980';
        Childcase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        Childcase.PO_Nome_E_Cognome_PM__c='TEST';                            
        Childcase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        childcase.PO_Offerta__c = 'P2P Attiva';
        Childcase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
        Childcase.PO_Nome_Progetto__c = 'TEST Nome Progetto';
        insert Childcase; 
        
        Case parentCase = new Case();
        parentCase.Status='Completato';
        parentCase.parentid=Childcase.id;
        parentCase.PO_Offerta__c = 'P2P Attiva';
        parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
        parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
        parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
        parentCase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
        insert parentCase;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        slList.add(sl);
        
        insert slList;
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c = 'P2P Attiva';
        slOrd.Caso__c = parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = slList[0].id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        //slOrd.EOF_SL_Riferimento__c = sl.id ;
        slord.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd;
        
        slord.PO_Offerta_Inoltrata__c = True;
        //slord.PO_Accordo_Quadro_Number__c = 'Test1';
        //slOrd.Caso__c=Childcase.id;
        update slOrd;
        
        OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
        
        Test.StartTest();
        
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
        riep.accId = acc.Id;
        riep.parentLogObj = slOrd;
        
        try{
            riep.InviaRichiesta_2();
        }
        catch(exception e){}
        
        Test.StopTest();
    }
    
    static testmethod void method1(){
        
        boolean Ricerca= true;
        boolean searchLogboolean=true;
        String offertaSelected='';
        String OffertaCheck='';
        PageReference pg = page.PO_SearchRequest;
      
        test.setCurrentPage(pg);
        PO_P2PAtt_RiepReq_ElCoCntrl pcc = new PO_P2PAtt_RiepReq_ElCoCntrl();
        pcc.SearchLog();
        // pcc.SalvaC();
    }
    
    static testmethod void method2(){
        TestDataFactory.CreateTestRecords(null,null,null);
        
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
         List<Case> listOrderCases = new List<Case>();
         Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita']; 
         Case oCase = new Case();
         oCase.Status='Accettato';
         oCase.AccountId=TestDataFactory.acc.id;
         oCase.EOF_Codice_Ordine_OLO__c='Test_9808980';
         oCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCase.OwnerId=usr.id;
         oCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         oCase.PO_Nome_Progetto__c='TEST Nome Progetto';
        
         insert oCase; 
        
         Case oCaseColl = new Case();
         oCaseColl.Status='Accettato';
         oCaseColl.parentid=oCase.id;
         oCaseColl.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCaseColl.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCaseColl.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCaseColl.OwnerId=usr.id;
         oCaseColl.PO_Richiesta_a_fattibilit__c=oCase.id;
         oCaseColl.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         insert oCaseColl;
        
        Case oCaseOrd = new Case();
         oCaseOrd.Status='Accettato';
         oCaseOrd.ParentId=oCaseColl.id;
         oCaseOrd.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCaseOrd.PO_Nome_E_Cognome_PM__c='TEST';
         oCaseOrd.PO_Case_Collegamento__c=oCaseColl.id;
         oCaseOrd.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCaseOrd.OwnerId=usr.id;
         oCaseOrd.PO_Richiesta_a_fattibilit__c=oCase.id;
         oCaseOrd.RecordTypeId=mpRT.get('PO_Ordine_P2P_Attiva');
         insert oCaseOrd;
        
        EOF_EAI_Service_Log__c slkIT2= new EOF_EAI_Service_Log__c();
        slkIT2.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT2.EOF_ID_Pop__c='Pop 2';
        slkIT2.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB'; //1 GB
        insert slkIT2;
        
        EOF_EAI_Service_Log__c slkIT= new EOF_EAI_Service_Log__c();
        slkIT.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT.EOF_ID_Pop__c='Pop 1';
        slkIT.PO_P2PAttiva_Optical_Rate_Limiting__c='1 GB'; //10 GB
        insert slkIT;
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_Log_P2P_Attiva_KIT');
        
        
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.Caso__c = oCaseColl.id;
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_SL_Riferimento__c=slFatt.id;
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.OF_PP_KIT_Log__c=slkIT.id;
        sl.PO_Nota_sito__c='Nota Sito';
        sl.EOF_STATO_ORDINE__c='Accettato';
        sl.OF_SA_USER_VLAN__C='1111';
        sl.OF_SA_SERVICE_VLAN__C='sVlan';
        sl.OF_SA_PROFILO_VLAN__c='COS 0';
        sl.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sl.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sl.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        
        insert sl;
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=oCaseOrd.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_SL_Riferimento__c=sl.id;
        slOrd.EOF_NOTE__c='Note';
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.RecordTypeId=mpRT.get('PO_Log_P2P_Attiva_KIT');
 
        insert slOrd;
       
        PageReference pg = page.PO_P2PAtt_RiepReq_ElCo;
        pg.getParameters().put('parentId',slFatt.id);
        
       // String proc = ApexPages.currentPage().getParameters().get('proc');
        String parentId = ApexPages.currentPage().getParameters().get('parentId');
        String testParentIdSave= apexpages.currentpage().getparameters().get('parentid');
      ApexPages.currentPage().getParameters().put('parentId',slOrd.id);
        test.setCurrentPage(pg);
        PO_P2PAtt_RiepReq_ElCoCntrl pcc = new PO_P2PAtt_RiepReq_ElCoCntrl();
        ApexPages.currentPage().getParameters().put('parentId',slOrd.id);
        Set<Id> serId = new Set<Id>();
        serId.add(slOrd.id);
        pcc.setIdCollegamenti = serId;
        pcc.ParentDataOrderUpdation();
        pcc.currentUserParentCases();
        //pcc.currentUserParentLogs();
        //pcc.SaveParentChildCaseInfo();
       // pcc.SalvaC();
    }
     static testmethod void method3(){
        TestDataFactory.CreateTestRecords(null,null,null);
        
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Contact cnt = new Contact();
        cnt.AccountId=TestDataFactory.accOLO.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
            
        insert cnt;
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
        
        
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
         List<Case> listOrderCases = new List<Case>();
         List<EOF_EAI_Service_Log__c> SlogToInsert = new List<EOF_EAI_Service_Log__c>();
         Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita']; 
         Case oCase = new Case();
         oCase.Status='Accettato';
         oCase.EOF_Codice_Operatore_WS__c='TIS';
         oCase.AccountId=TestDataFactory.accOLO.id;
         oCase.EOF_Codice_Ordine_OLO__c='Test_9808980';
         oCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCase.OwnerId=usr.id;
         oCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         oCase.PO_Nome_Progetto__c='TEST Nome Progetto';
        
         insert oCase; 
        
         Case oCaseColl = new Case();
         oCaseColl.Status='Accettato';
         oCaseColl.parentid=oCase.id;
         oCaseColl.EOF_Codice_Operatore_WS__c='TIS';
         oCaseColl.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCaseColl.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCaseColl.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCaseColl.OwnerId=usr.id;
         oCaseColl.PO_Tipo_percorso__c='SINGOLA VIA';
         oCaseColl.PO_Richiesta_a_fattibilit__c=oCase.id;
         oCaseColl.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         insert oCaseColl;
         List <Case> caseToOrder = new List<Case>();
         caseToOrder.add(oCaseColl);
         Case oCaseOrd = new Case();
         oCaseOrd.Status='Accettato';
         oCaseOrd.EOF_Codice_Operatore_WS__c='TIS';
         oCaseOrd.ParentId=oCaseColl.id;
         oCaseOrd.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCaseOrd.PO_Nome_E_Cognome_PM__c='TEST';
         oCaseOrd.PO_Case_Collegamento__c=oCaseColl.id;
         oCaseOrd.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCaseOrd.OwnerId=usr.id;
         oCaseOrd.PO_Richiesta_a_fattibilit__c=oCase.id;
         oCaseOrd.RecordTypeId=mpRT.get('PO_Ordine_P2P_Attiva');
         insert oCaseOrd;
        
        
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
        
        
        insert slFatt;
        EOF_EAI_Service_Log__c slkIT2= new EOF_EAI_Service_Log__c();
        slkIT2.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT2.EOF_ID_Pop__c='Pop 2';
        slkIT2.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB'; //1 GB
        slkIT2.EOF_SL_Riferimento__c=slFatt.id;
        insert slkIT2;
        
        EOF_EAI_Service_Log__c slkIT= new EOF_EAI_Service_Log__c();
        slkIT.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT.EOF_ID_Pop__c='Pop 1';
        slkIT.PO_P2PAttiva_Optical_Rate_Limiting__c='1 GB'; //10 GB
        slkIT.EOF_SL_Riferimento__c=slFatt.id;
        insert slkIT;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.Caso__c = oCaseColl.id;
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_SL_Riferimento__c=slFatt.id;
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
         /*  sl.OF_PP_KIT_Log__c=slkIT.id;
        sl.PO_Nota_sito__c='Nota Sito';
        sl.EOF_STATO_ORDINE__c='Accettato';
        sl.OF_SA_USER_VLAN__C='1111';
        sl.OF_SA_SERVICE_VLAN__C='sVlan';
        sl.OF_SA_PROFILO_VLAN__c='COS 0';
        sl.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sl.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sl.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        */
        
          
        insert sl;
        
        
        EOF_EAI_Service_Log__c sVlan1 = new EOF_EAI_Service_Log__c();
       
        sVlan1.EOF_SL_Riferimento__c=sl.id;
        sVlan1.OF_PP_KIT_Log__c=slkIT.id;
        sVlan1.OF_SA_KIT_CONSEGNA_VLAN__c = slkIT.id;
        sVlan1.PO_Nota_sito__c='Nota Sito';
        sVlan1.EOF_STATO_ORDINE__c='Accettato';
        sVlan1.OF_SA_USER_VLAN__C='1111';
        sVlan1.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan1.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan1.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan1.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        insert sVlan1;
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=oCaseOrd.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_SL_Riferimento__c=sl.id;
        slOrd.EOF_NOTE__c='Note';
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
 
       // insert slOrd;
        SlogToInsert.add(slOrd);
        
       Case oCase1 = new Case();
         oCase1.Status='Accettato';
         oCase1.AccountId=TestDataFactory.accOLO.id;
         oCase1.EOF_Codice_Ordine_OLO__c='Test_9808980a';
         oCase1.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCase1.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCase1.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCase1.OwnerId=usr.id;
         oCase1.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         oCase1.PO_Nome_Progetto__c='TEST Nome Progetto';
         oCase1.EOF_Codice_Operatore_WS__c='TIS';
        
         insert oCase1; 
        
         Case oCase1Coll = new Case();
         oCase1Coll.Status='Accettato';
         oCase1Coll.parentid=oCase1.id;
         oCase1Coll.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCase1Coll.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCase1Coll.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCase1Coll.OwnerId=usr.id;
         oCase1Coll.PO_Richiesta_a_fattibilit__c=oCase1.id;
         oCase1Coll.PO_Tipo_percorso__c='DOPPIA VIA';
         oCase1Coll.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         oCase1Coll.EOF_Codice_Operatore_WS__c='TIS';
         insert oCase1Coll;
        
         caseToOrder.add(oCase1Coll);
         Case oCase1Ord = new Case();
         oCase1Ord.Status='Accettato';
         oCase1Ord.ParentId=oCase1Coll.id;
         oCase1Ord.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCase1Ord.PO_Nome_E_Cognome_PM__c='TEST';
         oCase1Ord.PO_Case_Collegamento__c=oCase1Coll.id;
         oCase1Ord.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCase1Ord.OwnerId=usr.id;
         oCase1Ord.PO_Richiesta_a_fattibilit__c=oCase1.id;
         oCase1Ord.RecordTypeId=mpRT.get('PO_Ordine_P2P_Attiva');
         oCase1Ord.EOF_Codice_Operatore_WS__c='TIS';
         insert oCase1Ord;
        
        
        
        EOF_EAI_Service_Log__c slFatt1= new EOF_EAI_Service_Log__c();
        slFatt1.PO_Nome_Progetto__c=oCase1.PO_Nome_Progetto__c;
        slFatt1.EOF_Codice_Ordine_OLO__c='Test_9808980a';
        slFatt1.EOF_Stato_Richiesta__c='Accettato';
        slFatt1.PO_Offerta__c='P2P Attiva';
        slFatt1.PO_Offerta_Inoltrata__c=false; //true
        slFatt1.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
        slFatt1.Caso__c = oCase1.id;
        
        insert slFatt1;
        EOF_EAI_Service_Log__c slkIT3= new EOF_EAI_Service_Log__c();
        slkIT3.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT3.EOF_ID_Pop__c='Pop 2';
        slkIT3.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB'; //1 GB
        slkIT3.EOF_SL_Riferimento__c=slFatt1.id;
        insert slkIT3;
        
        EOF_EAI_Service_Log__c slkIT4= new EOF_EAI_Service_Log__c();
        slkIT4.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT4.EOF_ID_Pop__c='Pop 1';
        slkIT4.PO_P2PAttiva_Optical_Rate_Limiting__c='1 GB'; //10 GB
        slkIT4.EOF_SL_Riferimento__c=slFatt1.id;
        insert slkIT4;
        
        EOF_EAI_Service_Log__c slkIT5= new EOF_EAI_Service_Log__c();
        slkIT5.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT5.EOF_ID_Pop__c='Pop 1';
        slkIT5.PO_P2PAttiva_Optical_Rate_Limiting__c='1 GB'; //10 GB
        slkIT5.EOF_SL_Riferimento__c=slFatt1.id;
        slkIT5.PO_P2PAttiva_Nome_del_KIT__c=null;
        insert slkIT5;
        
        EOF_EAI_Service_Log__c sl1= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl1.Caso__c = oCase1Coll.id;
        sl1.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl1.EOF_SL_Riferimento__c=slFatt1.id;
        sl1.EOF_Codice_Ordine_OLO__c = 'Test_9808980a';
        sl1.PO_Tipo_percorso__c='Doppia Via';
        sl1.PO_Indirizzo_collegamento__c='via test';
        sl1.EOF_Comune__c='Roma';
        sl1.EOF_Stato_Richiesta__c='Accettato';
        sl1.PO_Offerta__c='P2P Attiva';
        sl1.EOF_Codice_Operatore__c='TIS';
        sl1.PO_Nome_Progetto__c= oCase1.PO_Nome_Progetto__c;
        sl1.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl1.PO_Prime_Contractor__c='TEST';
        sl1.PO_Incluso_nell_offerta__c=true;
        sl1.PO_Numero_fibre_richieste__c='2+2';
        sl1.EOF_PROFILO__c='1';
        sl1.PO_Sito__c='test';
        sl1.PO_Civico__c='12';
               
        insert sl1;
        
        EOF_EAI_Service_Log__c sVlan = new EOF_EAI_Service_Log__c();
       
        sVlan.EOF_SL_Riferimento__c=sl1.id;
        sVlan.OF_PP_KIT_Log__c=slkIT4.id;
        sVlan.PO_Nota_sito__c='Nota Sito';
        sVlan.EOF_STATO_ORDINE__c='Accettato';
        sVlan.OF_SA_USER_VLAN__C='1111';
        sVlan.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        insert sVlan;
        
        EOF_EAI_Service_Log__c slOrd1= new EOF_EAI_Service_Log__c();
        slOrd1.PO_Nome_Progetto__c=oCase1.PO_Nome_Progetto__c;
        slOrd1.EOF_Codice_Ordine_OLO__c='Test_9808980a';
        slOrd1.EOF_Stato_Richiesta__c='Accettato';
        slOrd1.PO_Offerta__c='P2P Attiva';
        slOrd1.Caso__c=oCase1Ord.id;
        slOrd1.EOF_STATO_ORDINE__c='Accettato';
        slOrd1.PO_Prime_Contractor__c='TEST';
        slOrd1.EOF_SL_Riferimento__c=sl1.id;
        slOrd1.EOF_NOTE__c='Note';
        slOrd1.Note_Sospensione_Operatore__c='TEST';
        slOrd1.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        SlogToInsert.add(slOrd1);
        insert SlogToInsert;
        
        OF_CatalogoCommerciale__c cat = new OF_CatalogoCommerciale__c();
        cat.name='Catalogo test';
        cat.OF_Attivo__c=true;
        cat.OF_DataInizioValidita__c=System.today().addDays(-10);
        cat.OF_DataFineValidita__c=System.today().addDays(100);
        insert cat;
        
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.OF_Attivo__c=true;
        serv.OF_DataInizioValidita__c=System.today().addDays(-10);
        serv.OF_DataFineValidita__c=System.today().addDays(100);
        serv.OF_CatalogoCommerciale__c= cat.id;
        insert serv;
        
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
         ce.OF_DataFineValidita__c=System.today().addDays(100);
         ce.OF_DataInizioValidita__c=System.today().addDays(-10);
         ce.OF_Servizio__c=serv.id;
         insert ce;
 
         List<OF_CommercialElementIstanziato__c> VlanToBind = new List<OF_CommercialElementIstanziato__c>();
         
         OF_CommercialElementIstanziato__c Vlan = new OF_CommercialElementIstanziato__c();
         Vlan.recordtypeId= mpRT.get('SVLAN');
         Vlan.OF_KITCONSEGNAVLAN__C='TEST';
         Vlan.OF_USERVLAN__C='TEST';
         Vlan.OF_SERVICEVLAN__C='TEST';
         Vlan.OF_PROFILOVLAN__C='TEST';
         Vlan.OF_CUSTOMERVLAN__C='TEST';
         Vlan.OF_MODELLODISERVIZIOVLAN__C='TEST';
         Vlan.OF_INFORMAZIONIVLAN__C='TEST';
         Vlan.OF_Case__c= oCaseColl.id;
         Vlan.OF_SA_VLAN__c= sVlan1.id;
         Vlan.OF_CommercialElement__c=ce.id;
         
         
                                                                      
         OF_CommercialElementIstanziato__c Vlan2 = new OF_CommercialElementIstanziato__c();
         Vlan2.recordtypeId= mpRT.get('OF_VLAN');
         Vlan2.OF_KITCONSEGNAVLAN__C='TEST';
         Vlan2.OF_USERVLAN__C='TEST';
         Vlan2.OF_SERVICEVLAN__C='TEST';
         Vlan2.OF_PROFILOVLAN__C='TEST';
         Vlan2.OF_CUSTOMERVLAN__C='TEST';
         Vlan2.OF_MODELLODISERVIZIOVLAN__C='TEST';
         Vlan2.OF_INFORMAZIONIVLAN__C='TEST';
         Vlan2.OF_Case__c= oCase1Coll.id;
         Vlan2.OF_SA_VLAN__c= sVlan.id;
         Vlan2.OF_CommercialElement__c=ce.id;
                
         Opportunity opp = new Opportunity();
         opp.Name='Opp TEST';
         opp.StageName='Prospecting';
         opp.CloseDate=System.today().addDays(30);
         opp.PO_Richiesta_fattibilit__c=oCase.id;
         insert opp;
        
        Opportunity opp1 = new Opportunity();
         opp1.Name='Opp TEST';
         opp1.StageName='Prospecting';
         opp1.CloseDate=System.today().addDays(30);
         opp1.PO_Richiesta_fattibilit__c=oCase1.id;
         insert opp1;
         //insert slOrd1;
        
        List<order> ordList = new List<Order>();
        order o = new order();
        o.recordtypeID = mpRT.get('OF_INORDER');
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = TestDataFactory.accOLO.id;//acc.id;
        o.OF_TipologiaDiServizio__c='Attivo';
        o.PO_IsFromOpportunity__c=true;
        o.Name ='test1';
        o.OF_CaseNome__c=oCase.CaseNumber;
        o.OF_IDOrdineEOF__c=oCase.Codice_Ordine_EOF__c;
       // o.OF_CaseNome__c=oCase.id;
       // o.OF_CaseNome__c = caseFormula.get(o.OF_CaseID__c).casenumber;
       //o.OF_IDOrdineEOF__c = caseFormula.get(o.OF_CaseID__c).Codice_Ordine_EOF__c;
        insert o;
        ordList.add(o);
        
        order o2 = new order();
        o2.recordtypeID = mpRT.get('OF_INORDER');
        o2.EffectiveDate = Date.newInstance(2016,1,1);
        o2.Status = 'Aperto';
        o2.AccountId = TestDataFactory.accOLO.id;//acc.id;
        o2.OF_TipologiaDiServizio__c='Passivo';
        o2.PO_IsFromOpportunity__c=true;
        o2.Name ='test2';
        o2.OF_CaseNome__c=oCase1.id;
        insert o2;
        ordList.add(o2);
        
        List<Attachment>attList = new List<Attachment>();
         List<Attachment>attListxls = new List<Attachment>();
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        //attach.parentId=oppLst[0].id;
        attach.parentId = oCase1.id;
        insert attach;
        
        Attachment attach2=new Attachment();     
        attach2.Name='Unit Test Attachment.xlsx';
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body2');
        attach2.body=bodyBlob2;
        //attach.parentId=oppLst[0].id;
        attach2.parentId = oCase1.id;
        insert attach2;
        
        attList.add(attach);
        attList.add(attach2);
        attListxls.add(attach2);
        
        PageReference pg = page.Po_FeasibilityServicesRequest2;
        pg.getParameters().put('parentId',oCase.id);
        
        PageReference pg2 = page.PO_P2PAtt_RiepReq_ElCo;
        pg2.getParameters().put('parentId',slFatt.id);
        
       // String proc = ApexPages.currentPage().getParameters().get('proc');
        String parentId = ApexPages.currentPage().getParameters().get('parentId');
        String testParentIdSave= apexpages.currentpage().getparameters().get('parentid');
        String recordOfferta='P2P Attiva';
        /*
         public list<attachment> newAtt {get; set;}
    public list<attachment> attlst {get; set;}
    public list<attachment> attxlxs {get; set;}
        */
      
        test.setCurrentPage(pg2);
         test.startTest();
        PO_P2PAtt_RiepReq_ElCoCntrl pcc = new PO_P2PAtt_RiepReq_ElCoCntrl();
        pcc.parentLogObj= slFatt1;
        pcc.parentCase = oCase1;
        pcc.newAtt= attList;
        pcc.attlst = attList;
        pcc.attxlxs = attListxls;
        
        
       // pcc.ParentDataOrderUpdation();
       // pcc.currentUserParentCases();
          pcc.currentUserParentLogs();
          pcc.getkitLogList();
          pcc.deleteVoidKitLog();
         test.stopTest();
       
    }
    
    static testmethod void method4(){
       // createData();
         Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
		Group codaIng = [Select Id from Group where DeveloperName='Coda_Ingegneria_P2PAttiva'];
		/*Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;*/
		
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
		 OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Napoli';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
         Account acc = new Account();
         acc.name = 'Test';
         acc.RecordTypeId=mpRT.get('OLO');
       	 acc.EOF_Codice_Operatore__c='TIS';
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
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
       
        
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
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
       // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        
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
       
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> sVlanList = new List<EOF_EAI_Service_Log__c>();
        sVlanList.add(sVlan1);
        
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
         parentCase.Status='In Lavorazione';
		 parentCase.EOF_Fase__c='In lavorazione';
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
         insert parentCase;
         slFatt.Caso__c= parentCase.id;
		 slFatt.Accordo_Operativo__c = parentCase.CaseNumber;
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
		 Childcase.PO_Tipo_di_collegamento__c='Point-to-Point';
		 Childcase.PO_Numero_fibre_richieste__c='2';
		 Childcase.OF_IDContratto__c=contratto.id;
		 Childcase.PO_Prime_Contractor__c='Test';
		 Childcase.PO_Nome_sito__c='Test';
		 Childcase.PO_Comune2__c=ele.id;
		 ChildCase.PO_Tipo_percorso__c='Doppia Via';
		 ChildCase.PO_Sito__c ='Napoli';
		 ChildCase.PO_Nota_sito__c='TEST';
		 ChildCase.PO_Indirizzo_collegamento__c='Via Test';
		 ChildCase.PO_Civico__c='33';
		 ChildCase.Particella_Toponomastica_1__c='Via';
		 ChildCase.Particella_Toponomastica_2__c='Via';
		 ChildCase.Particella_Toponomastica_3__c='via';
         insert Childcase; 
         sl.Caso__c=Childcase.id;
		 
       	 update sl;
        slList.add(sl);
        slList.add(slFatt);
		
		Case tempKitCase = new Case();
          tempKitCase.recordTypeId= mpRT.get('PO_Case_P2P_Attiva_KIT');
          tempKitCase.EOF_Identificativo_del_POP__c=slKit.EOF_ID_Pop__c;
          tempKitCase.PO_Case_Collegamento__c=sl.Caso__c;
        
          tempKitCase.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
          tempKitCase.PO_PP_NomeKit__c=slKit.PO_P2PAttiva_Nome_del_KIT__c;
          tempKitCase.PO_P2PAttiva_KIT_OpticalRateLimiting__c=slKit.PO_P2PAttiva_Optical_Rate_Limiting__c;
		  
          tempKitCase.OwnerId = codaIng.id;
		  
          tempKitCase.ParentId=sl.Caso__c;      //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
          tempKitCase.Status = 'Acquisito';
		  insert tempKitCase;
         
          slKit.Caso__c=tempKitCase.Id;
          slKit.EOF_Stato_Richiesta__c='Acquisito';
          //Dopo aver popolato il childcase, aggiorno anche il kitLog
          slKit.EOF_Stato_Richiesta__c = 'Inserita Portale';
          slKit.EOF_STATO_ORDINE__c = 'Acquisito';

          update slKit;
        
        Childcase.PO_KIT_Consegna_VLAN__c= tempKitCase.id;
        update Childcase;

		
		EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = slFatt.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slOrd.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd;
      
        slord.PO_Offerta_Inoltrata__c = True;
       // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
        
      
		 Case childOrderCase = new Case();
			childOrderCase.status='Accettato';
			childOrderCase.ParentId=parentCase.Id;//Fattibilità
			childOrderCase.EOF_Codice_Operatore_WS__c = acc.EOF_Codice_Operatore__c;
			childOrderCase.EOF_Fase__c='In lavorazione supporto vendite';
			childOrderCase.PO_Case_Collegamento__c=Childcase.Id;
			childOrderCase.PO_Tipo_di_collegamento__c=Childcase.PO_Tipo_di_collegamento__c;
			childOrderCase.PO_Numero_fibre_richieste__c=Childcase.PO_Numero_fibre_richieste__c;
			childOrderCase.AccountId=acc.id;
			childOrderCase.OF_IDContratto__c=contratto.id;// RDG 2019-02-08
			childOrderCase.PO_Prime_Contractor__c= Childcase.PO_Prime_Contractor__c;
			childOrderCase.PO_Nome_sito__c=Childcase.PO_Nome_sito__c;
			childOrderCase.PO_KIT_Consegna_VLAN__c=Childcase.PO_KIT_Consegna_VLAN__c; //Lookup verso caseKit
			childOrderCase.PO_Comune2__c =Childcase.PO_Comune2__c;
			childOrderCase.PO_Tipo_percorso__c=ChildCase.PO_Tipo_percorso__c;
			childOrderCase.PO_Sito__c=ChildCase.PO_Sito__c ;
			childOrderCase.PO_Nota_sito__c=ChildCase.PO_Nota_sito__c;
			childOrderCase.PO_Indirizzo_collegamento__c=ChildCase.PO_Indirizzo_collegamento__c;
			childOrderCase.PO_Civico__c= ChildCase.PO_Civico__c;
			//28/09/2017 CRM Modifica
			childOrderCase.PO_Richiesta_a_fattibilit_ordine__c = ChildCase.PO_Richiesta_a_fattibilit__c;
			//28/09/2017 END CRM
			childOrderCase.recordtypeid = mpRT.get('PO_Ordine_P2P_Attiva');
			//cs.OwnerId=codaSupportoVendite.Id;
			// cs.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Operatore_WS__c + '_' + c.CaseNumber; //FD 2019-02-28 EOF_Codice_Ordine_OLO__c su case ordine
			//Modifica Toponomastica
			childOrderCase.Particella_Toponomastica_1__c = ChildCase.Particella_Toponomastica_1__c;
			childOrderCase.Particella_Toponomastica_2__c = ChildCase.Particella_Toponomastica_2__c;
			childOrderCase.Particella_Toponomastica_3__c = ChildCase.Particella_Toponomastica_3__c;
			
			insert childOrderCase; 
			
			slOrd.Caso__c= childOrderCase.id;
			update slOrd;
		List<EOF_EAI_Service_Log__c> ordLogs = new List<EOF_EAI_Service_Log__c>();
        ordLogs.add(slOrd);
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
        
			 PageReference pg2 = page.PO_P2PAtt_RiepReq_ElCo;
        pg2.getParameters().put('parentId',slFatt.id);
        
       // String proc = ApexPages.currentPage().getParameters().get('proc');
        String parentId = ApexPages.currentPage().getParameters().get('parentId');
        String testParentIdSave= apexpages.currentpage().getparameters().get('parentid');
        String recordOfferta='P2P Attiva';
      
       // test.setCurrentPage(pg2);
         test.startTest();
        PO_P2PAtt_RiepReq_ElCoCntrl pcc = new PO_P2PAtt_RiepReq_ElCoCntrl();
        pcc.sLogVlanList = sVlanList;
        pcc.parentLogObj= slFatt;
        pcc.orderLoglst= ordLogs;
        try{
         pcc.InviaRichiesta_2();
        }
        catch(exception e){}
        try{
       pcc.OrderCreation(caseFromPortal); 
        }
        catch(Exception e){
            
        }
        pcc.ParentDataOrderUpdation();
        pcc.ParentDataOrderUpdation();
        try{
        pcc.OpportunityStageNameUpdate();
        }
        Catch(exception e){
            
        }
            // pcc.currentUserParentCases();
       //   pcc.currentUserParentLogs();
         // pcc.getkitLogList();
        //  pcc.deleteVoidKitLog();
         test.stopTest();       
        
       
        
    }
    
    static testmethod void method2bb(){

        TestDataFactory.CreateTestRecords(null,null,null);
        
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];

		Group codaIng = [Select Id from Group where DeveloperName='Coda_Ingegneria_P2PAttiva'];
	    User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
		
     	OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Napoli';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
         Account acc = new Account();
         acc.name = 'Test';
         acc.RecordTypeId=mpRT.get('OLO');
       	 acc.EOF_Codice_Operatore__c='TIS';
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

         List<Case> listOrderCases = new List<Case>();
         Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita']; 
         
		 //NOW
		 
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
      
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
       // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento

        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';       
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
       
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> sVlanList = new List<EOF_EAI_Service_Log__c>();
        sVlanList.add(sVlan1);
        
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
         parentCase.Status='In Lavorazione';
		 parentCase.EOF_Fase__c='In lavorazione';
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
         insert parentCase;
         slFatt.Caso__c= parentCase.id;
		 slFatt.Accordo_Operativo__c = parentCase.CaseNumber;
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
		 Childcase.PO_Tipo_di_collegamento__c='Point-to-Point';
		 Childcase.PO_Numero_fibre_richieste__c='2';
		 Childcase.OF_IDContratto__c=contratto.id;
		 Childcase.PO_Prime_Contractor__c='Test';
		 Childcase.PO_Nome_sito__c='Test';
		 Childcase.PO_Comune2__c=ele.id;
		 ChildCase.PO_Tipo_percorso__c='Doppia Via';
		 ChildCase.PO_Sito__c ='Napoli';
		 ChildCase.PO_Nota_sito__c='TEST';
		 ChildCase.PO_Indirizzo_collegamento__c='Via Test';
		 ChildCase.PO_Civico__c='33';
		 ChildCase.Particella_Toponomastica_1__c='Via';
		 ChildCase.Particella_Toponomastica_2__c='Via';
		 ChildCase.Particella_Toponomastica_3__c='via';
         insert Childcase; 
         sl.Caso__c=Childcase.id;
		 
       	 update sl;
        slList.add(sl);
        slList.add(slFatt);
		
		Case tempKitCase = new Case();
          tempKitCase.recordTypeId= mpRT.get('PO_Case_P2P_Attiva_KIT');
          tempKitCase.EOF_Identificativo_del_POP__c=slKit.EOF_ID_Pop__c;
          tempKitCase.PO_Case_Collegamento__c=sl.Caso__c;
        
          tempKitCase.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
          tempKitCase.PO_PP_NomeKit__c=slKit.PO_P2PAttiva_Nome_del_KIT__c;
          tempKitCase.PO_P2PAttiva_KIT_OpticalRateLimiting__c=slKit.PO_P2PAttiva_Optical_Rate_Limiting__c;
		  
          tempKitCase.OwnerId = codaIng.id;
		  
          tempKitCase.ParentId=sl.Caso__c;      //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
          tempKitCase.Status = 'Acquisito';
		  insert tempKitCase;
         
          slKit.Caso__c=tempKitCase.Id;
          slKit.EOF_Stato_Richiesta__c='Acquisito';
          //Dopo aver popolato il childcase, aggiorno anche il kitLog
          slKit.EOF_Stato_Richiesta__c = 'Inserita Portale';
          slKit.EOF_STATO_ORDINE__c = 'Acquisito';

          update slKit;

        
        Childcase.PO_KIT_Consegna_VLAN__c= tempKitCase.id;
        update Childcase;

		
		EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';

        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = slFatt.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slOrd.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');

        insert slOrd;
     List<EOF_EAI_Service_Log__c> slOrdList = new List<EOF_EAI_Service_Log__c>();
      slOrdList.add(slOrd);
        slord.PO_Offerta_Inoltrata__c = True;
       // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
         
		 Case childOrderCase = new Case();
			childOrderCase.status='Accettato';
			childOrderCase.ParentId=parentCase.Id;//Fattibilità
			childOrderCase.EOF_Codice_Operatore_WS__c = acc.EOF_Codice_Operatore__c;
			childOrderCase.EOF_Fase__c='In lavorazione supporto vendite';
			childOrderCase.PO_Case_Collegamento__c=Childcase.Id;
			childOrderCase.PO_Tipo_di_collegamento__c=Childcase.PO_Tipo_di_collegamento__c;
			childOrderCase.PO_Numero_fibre_richieste__c=Childcase.PO_Numero_fibre_richieste__c;
			childOrderCase.AccountId=acc.id;
			childOrderCase.OF_IDContratto__c=contratto.id;// RDG 2019-02-08
			childOrderCase.PO_Prime_Contractor__c= Childcase.PO_Prime_Contractor__c;
			childOrderCase.PO_Nome_sito__c=Childcase.PO_Nome_sito__c;
			childOrderCase.PO_KIT_Consegna_VLAN__c=Childcase.PO_KIT_Consegna_VLAN__c; //Lookup verso caseKit
			childOrderCase.PO_Comune2__c =Childcase.PO_Comune2__c;
			childOrderCase.PO_Tipo_percorso__c=ChildCase.PO_Tipo_percorso__c;
			childOrderCase.PO_Sito__c=ChildCase.PO_Sito__c ;
			childOrderCase.PO_Nota_sito__c=ChildCase.PO_Nota_sito__c;
			childOrderCase.PO_Indirizzo_collegamento__c=ChildCase.PO_Indirizzo_collegamento__c;
			childOrderCase.PO_Civico__c= ChildCase.PO_Civico__c;
			//28/09/2017 CRM Modifica
			childOrderCase.PO_Richiesta_a_fattibilit_ordine__c = ChildCase.PO_Richiesta_a_fattibilit__c;
			//28/09/2017 END CRM
			childOrderCase.recordtypeid = mpRT.get('PO_Ordine_P2P_Attiva');
			//cs.OwnerId=codaSupportoVendite.Id;
			// cs.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Operatore_WS__c + '_' + c.CaseNumber; //FD 2019-02-28 EOF_Codice_Ordine_OLO__c su case ordine
			//Modifica Toponomastica
			childOrderCase.Particella_Toponomastica_1__c = ChildCase.Particella_Toponomastica_1__c;
			childOrderCase.Particella_Toponomastica_2__c = ChildCase.Particella_Toponomastica_2__c;
			childOrderCase.Particella_Toponomastica_3__c = ChildCase.Particella_Toponomastica_3__c;
			
			insert childOrderCase; 
			
			slOrd.Caso__c= childOrderCase.id;
			update slOrd;
		List<EOF_EAI_Service_Log__c> ordLogs = new List<EOF_EAI_Service_Log__c>();
        ordLogs.add(slOrd);
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
	   
        PageReference pg = page.PO_P2PAtt_RiepReq_ElCo;
        pg.getParameters().put('parentId',slFatt.id);
        
       // String proc = ApexPages.currentPage().getParameters().get('proc');
        String parentId = ApexPages.currentPage().getParameters().get('parentId');
        String testParentIdSave= apexpages.currentpage().getparameters().get('parentid');


      ApexPages.currentPage().getParameters().put('parentId',slFatt.id);
        test.setCurrentPage(pg);

        PO_P2PAtt_RiepReq_ElCoCntrl pcc = new PO_P2PAtt_RiepReq_ElCoCntrl();

        ApexPages.currentPage().getParameters().put('parentId',slOrd.id);
        Set<Id> serId = new Set<Id>();
        serId.add(sl.id);
        pcc.setIdCollegamenti = serId;
     List<EOF_EAI_Service_Log__c> ordLogList = new List<EOF_EAI_Service_Log__c>();
     ordLogList.add(slOrd);
     pcc.orderLogs=ordLogList;
     try{
     	pcc.ParentDataOrderUpdation();
     }
     catch(Exception e){}
    }
    
 	static testmethod void method2b(){

        TestDataFactory.CreateTestRecords(null,null,null);
        
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];

		Group codaIng = [Select Id from Group where DeveloperName='Coda_Ingegneria_P2PAttiva'];
	    User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
		
     	OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Napoli';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
         Account acc = new Account();
         acc.name = 'Test';
         acc.RecordTypeId=mpRT.get('OLO');
       	 acc.EOF_Codice_Operatore__c='TIS';
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

         List<Case> listOrderCases = new List<Case>();
         Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita']; 
         
		 //NOW
		 
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
      
   
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
      
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento

        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';       
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        insert sl;
          
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
       
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> sVlanList = new List<EOF_EAI_Service_Log__c>();
        sVlanList.add(sVlan1);
        
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
         parentCase.Status='In Lavorazione';
		 parentCase.EOF_Fase__c='In lavorazione';
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
         insert parentCase;
         slFatt.Caso__c= parentCase.id;
		 slFatt.Accordo_Operativo__c = parentCase.CaseNumber;
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
		 Childcase.PO_Tipo_di_collegamento__c='Point-to-Point';
		 Childcase.PO_Numero_fibre_richieste__c='2';
		 Childcase.OF_IDContratto__c=contratto.id;
		 Childcase.PO_Prime_Contractor__c='Test';
		 Childcase.PO_Nome_sito__c='Test';
		 Childcase.PO_Comune2__c=ele.id;
		 ChildCase.PO_Tipo_percorso__c='Doppia Via';
		 ChildCase.PO_Sito__c ='Napoli';
		 ChildCase.PO_Nota_sito__c='TEST';
		 ChildCase.PO_Indirizzo_collegamento__c='Via Test';
		 ChildCase.PO_Civico__c='33';
		 ChildCase.Particella_Toponomastica_1__c='Via';
		 ChildCase.Particella_Toponomastica_2__c='Via';
		 ChildCase.Particella_Toponomastica_3__c='via';
         insert Childcase; 
         sl.Caso__c=Childcase.id;
		 
       	 update sl;
        slList.add(sl);
        slList.add(slFatt);
		
		Case tempKitCase = new Case();
          tempKitCase.recordTypeId= mpRT.get('PO_Case_P2P_Attiva_KIT');
          tempKitCase.EOF_Identificativo_del_POP__c=slKit.EOF_ID_Pop__c;
          tempKitCase.PO_Case_Collegamento__c=sl.Caso__c;
        
          tempKitCase.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
          tempKitCase.PO_PP_NomeKit__c=slKit.PO_P2PAttiva_Nome_del_KIT__c;
          tempKitCase.PO_P2PAttiva_KIT_OpticalRateLimiting__c=slKit.PO_P2PAttiva_Optical_Rate_Limiting__c;
		  
          tempKitCase.OwnerId = codaIng.id;
		  
          tempKitCase.ParentId=sl.Caso__c;      //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
          tempKitCase.Status = 'Acquisito';
		  insert tempKitCase;
         
          slKit.Caso__c=tempKitCase.Id;
          slKit.EOF_Stato_Richiesta__c='Acquisito';
          //Dopo aver popolato il childcase, aggiorno anche il kitLog
          slKit.EOF_Stato_Richiesta__c = 'Inserita Portale';
          slKit.EOF_STATO_ORDINE__c = 'Acquisito';

          update slKit;

        
        Childcase.PO_KIT_Consegna_VLAN__c= tempKitCase.id;
        update Childcase;

		
		EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';

        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = slFatt.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slOrd.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');

        insert slOrd;
     List<EOF_EAI_Service_Log__c> slOrdList = new List<EOF_EAI_Service_Log__c>();
      slOrdList.add(slOrd);
        slord.PO_Offerta_Inoltrata__c = True;
       // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
         
		 Case childOrderCase = new Case();
			childOrderCase.status='Accettato';
			childOrderCase.ParentId=parentCase.Id;//Fattibilità
			childOrderCase.EOF_Codice_Operatore_WS__c = acc.EOF_Codice_Operatore__c;
			childOrderCase.EOF_Fase__c='In lavorazione supporto vendite';
			childOrderCase.PO_Case_Collegamento__c=Childcase.Id;
			childOrderCase.PO_Tipo_di_collegamento__c=Childcase.PO_Tipo_di_collegamento__c;
			childOrderCase.PO_Numero_fibre_richieste__c=Childcase.PO_Numero_fibre_richieste__c;
			childOrderCase.AccountId=acc.id;
			childOrderCase.OF_IDContratto__c=contratto.id;// RDG 2019-02-08
			childOrderCase.PO_Prime_Contractor__c= Childcase.PO_Prime_Contractor__c;
			childOrderCase.PO_Nome_sito__c=Childcase.PO_Nome_sito__c;
			childOrderCase.PO_KIT_Consegna_VLAN__c=Childcase.PO_KIT_Consegna_VLAN__c; //Lookup verso caseKit
			childOrderCase.PO_Comune2__c =Childcase.PO_Comune2__c;
			childOrderCase.PO_Tipo_percorso__c=ChildCase.PO_Tipo_percorso__c;
			childOrderCase.PO_Sito__c=ChildCase.PO_Sito__c ;
			childOrderCase.PO_Nota_sito__c=ChildCase.PO_Nota_sito__c;
			childOrderCase.PO_Indirizzo_collegamento__c=ChildCase.PO_Indirizzo_collegamento__c;
			childOrderCase.PO_Civico__c= ChildCase.PO_Civico__c;
			//28/09/2017 CRM Modifica
			childOrderCase.PO_Richiesta_a_fattibilit_ordine__c = ChildCase.PO_Richiesta_a_fattibilit__c;
			//28/09/2017 END CRM
			childOrderCase.recordtypeid = mpRT.get('PO_Ordine_P2P_Attiva');
			//cs.OwnerId=codaSupportoVendite.Id;
			// cs.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Operatore_WS__c + '_' + c.CaseNumber; //FD 2019-02-28 EOF_Codice_Ordine_OLO__c su case ordine
			//Modifica Toponomastica
			childOrderCase.Particella_Toponomastica_1__c = ChildCase.Particella_Toponomastica_1__c;
			childOrderCase.Particella_Toponomastica_2__c = ChildCase.Particella_Toponomastica_2__c;
			childOrderCase.Particella_Toponomastica_3__c = ChildCase.Particella_Toponomastica_3__c;
			
			insert childOrderCase; 
			
			slOrd.Caso__c= childOrderCase.id;
			update slOrd;
		List<EOF_EAI_Service_Log__c> ordLogs = new List<EOF_EAI_Service_Log__c>();
        ordLogs.add(slOrd);
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
	   
        PageReference pg = page.PO_P2PAtt_RiepReq_ElCo;
        pg.getParameters().put('parentId',slFatt.id);
        
       // String proc = ApexPages.currentPage().getParameters().get('proc');
        String parentId = ApexPages.currentPage().getParameters().get('parentId');
        String testParentIdSave= apexpages.currentpage().getparameters().get('parentid');


      ApexPages.currentPage().getParameters().put('parentId',slFatt.id);
        test.setCurrentPage(pg);

        PO_P2PAtt_RiepReq_ElCoCntrl pcc = new PO_P2PAtt_RiepReq_ElCoCntrl();

        ApexPages.currentPage().getParameters().put('parentId',slOrd.id);
        Set<Id> serId = new Set<Id>();
        serId.add(sl.id);
        pcc.setIdCollegamenti = serId;
     List<EOF_EAI_Service_Log__c> ordLogList = new List<EOF_EAI_Service_Log__c>();
     ordLogList.add(slOrd);
     pcc.orderLogs=ordLogList;
     pcc.currentUserParentCases();
     try{
         delete contratto;
         pcc.checkVendibilitaRichiesta(acc.id,'P2P Attiva');
         //(Id theAccountId, String theOfferta) 
     }
     catch(Exception e){}
    }
  
    public static testMethod void OrderCreationMethodEC(){
     
		Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
		Group codaIng = [Select Id from Group where DeveloperName='Coda_Ingegneria_P2PAttiva'];
		
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
		 OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Napoli';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
         Account acc = new Account();
         acc.name = 'Test';
         acc.RecordTypeId=mpRT.get('OLO');
       	 acc.EOF_Codice_Operatore__c='TIS';
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
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
       
        
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
        slC.PO_Tipo_percorso__c='Doppia Via';
        slC.PO_Indirizzo_collegamento__c='via test';
        slC.EOF_Comune__c='Roma';
        slC.EOF_Stato_Richiesta__c='Accettato';
        slC.PO_Offerta__c='P2P Attiva';
        slC.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slC.PO_Tipo_di_collegamento__c='Point-to-Point';
        slC.PO_Prime_Contractor__c='TEST';
        slC.PO_Incluso_nell_offerta__c=true;
        slC.PO_Numero_fibre_richieste__c='2+2';
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
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
        slFatt.PO_Tipo_di_collegamento__c ='E-Access' ;
       // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento'); //P2P_Attiva_Collegamento//P2P_Attiva_Collegamento /PO_Collegamento_P2P_Attiva
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Doppia Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2+2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        insert sl;
      //  slList.add(sl);
      //  
      	
          
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
       
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> sVlanList = new List<EOF_EAI_Service_Log__c>();
        sVlanList.add(sVlan1);
        
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
         parentCase.Status='In Lavorazione';
		 parentCase.EOF_Fase__c='In lavorazione';
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
         insert parentCase;
         slFatt.Caso__c= parentCase.id;
		 slFatt.Accordo_Operativo__c = parentCase.CaseNumber;
       	 update slFatt;
		 caseFromPortal.add(parentCase);
        
		 list<Case> Caselist = new List<Case>();
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
		 Childcase.PO_Tipo_di_collegamento__c='Point-to-Point';
		 Childcase.PO_Numero_fibre_richieste__c='2+2';
		 Childcase.OF_IDContratto__c=contratto.id;
		 Childcase.PO_Prime_Contractor__c='Test';
		 Childcase.PO_Nome_sito__c='Test';
		 Childcase.PO_Comune2__c=ele.id;
		 ChildCase.PO_Tipo_percorso__c='Doppia Via';
		 ChildCase.PO_Sito__c ='Napoli';
		 ChildCase.PO_Nota_sito__c='TEST';
		 ChildCase.PO_Indirizzo_collegamento__c='Via Test';
		 ChildCase.PO_Civico__c='33';
		 ChildCase.Particella_Toponomastica_1__c='Via';
		 ChildCase.Particella_Toponomastica_2__c='Via';
		 ChildCase.Particella_Toponomastica_3__c='via';
         insert Childcase; 
         sl.Caso__c=Childcase.id;
		 Caselist.add(Childcase);
       	 update sl;
        slList.add(sl);
        slList.add(slFatt);
		
		Case tempKitCase = new Case();
          tempKitCase.recordTypeId= mpRT.get('PO_Case_P2P_Attiva_KIT');
          tempKitCase.EOF_Identificativo_del_POP__c=slKit.EOF_ID_Pop__c;
          tempKitCase.PO_Case_Collegamento__c=sl.Caso__c;
        
          tempKitCase.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
          tempKitCase.PO_PP_NomeKit__c=slKit.PO_P2PAttiva_Nome_del_KIT__c;
          tempKitCase.PO_P2PAttiva_KIT_OpticalRateLimiting__c=slKit.PO_P2PAttiva_Optical_Rate_Limiting__c;
		  
          tempKitCase.OwnerId = codaIng.id;
		  
          tempKitCase.ParentId=sl.Caso__c;      //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
          tempKitCase.Status = 'Acquisito';
		  insert tempKitCase;
         
          slKit.Caso__c=tempKitCase.Id;
          slKit.EOF_Stato_Richiesta__c='Acquisito';
          //Dopo aver popolato il childcase, aggiorno anche il kitLog
          slKit.EOF_Stato_Richiesta__c = 'Inserita Portale';
          slKit.EOF_STATO_ORDINE__c = 'Acquisito';
		
          update slKit;
        
        Childcase.PO_KIT_Consegna_VLAN__c= tempKitCase.id;
        update Childcase;

		sl.OF_PP_KIT_Log__c=slKit.id;
        update sl;
       // slC.OF_PP_KIT_Log__c=slKit.id;
       // update slC;
		EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = slFatt.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slOrd.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd;
      
        slord.PO_Offerta_Inoltrata__c = True;
       // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
        
      
		 Case childOrderCase = new Case();
			childOrderCase.status='Accettato';
			childOrderCase.ParentId=parentCase.Id;//Fattibilità
			childOrderCase.EOF_Codice_Operatore_WS__c = acc.EOF_Codice_Operatore__c;
			childOrderCase.EOF_Fase__c='In lavorazione supporto vendite';
			childOrderCase.PO_Case_Collegamento__c=Childcase.Id;
			childOrderCase.PO_Tipo_di_collegamento__c=Childcase.PO_Tipo_di_collegamento__c;
			childOrderCase.PO_Numero_fibre_richieste__c=Childcase.PO_Numero_fibre_richieste__c;
			childOrderCase.AccountId=acc.id;
			childOrderCase.OF_IDContratto__c=contratto.id;// RDG 2019-02-08
			childOrderCase.PO_Prime_Contractor__c= Childcase.PO_Prime_Contractor__c;
			childOrderCase.PO_Nome_sito__c=Childcase.PO_Nome_sito__c;
			childOrderCase.PO_KIT_Consegna_VLAN__c=Childcase.PO_KIT_Consegna_VLAN__c; //Lookup verso caseKit
			childOrderCase.PO_Comune2__c =Childcase.PO_Comune2__c;
			childOrderCase.PO_Tipo_percorso__c='Doppia Via';
			childOrderCase.PO_Sito__c=ChildCase.PO_Sito__c ;
			childOrderCase.PO_Nota_sito__c=ChildCase.PO_Nota_sito__c;
			childOrderCase.PO_Indirizzo_collegamento__c=ChildCase.PO_Indirizzo_collegamento__c;
			childOrderCase.PO_Civico__c= ChildCase.PO_Civico__c;
         	childOrderCase.PO_Offerta__c='P2P Attiva';
			//28/09/2017 CRM Modifica
			childOrderCase.PO_Richiesta_a_fattibilit_ordine__c = ChildCase.PO_Richiesta_a_fattibilit__c;
			//28/09/2017 END CRM
			childOrderCase.recordtypeid = mpRT.get('PO_Ordine_P2P_Attiva');
			//cs.OwnerId=codaSupportoVendite.Id;
			// cs.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Operatore_WS__c + '_' + c.CaseNumber; //FD 2019-02-28 EOF_Codice_Ordine_OLO__c su case ordine
			//Modifica Toponomastica
			childOrderCase.Particella_Toponomastica_1__c = ChildCase.Particella_Toponomastica_1__c;
			childOrderCase.Particella_Toponomastica_2__c = ChildCase.Particella_Toponomastica_2__c;
			childOrderCase.Particella_Toponomastica_3__c = ChildCase.Particella_Toponomastica_3__c;
			
		//	insert childOrderCase; 
			
		//	slOrd.Caso__c= childOrderCase.id;
		//	update slOrd;
		List<EOF_EAI_Service_Log__c> ordLogs = new List<EOF_EAI_Service_Log__c>();
        ordLogs.add(slOrd);
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
        
         system.runAs(usr){        
        Test.StartTest();
           Test.setCurrentPageReference(new PageReference('PO_P2PAtt_RiepReq_ElCo')); 
        Test.setCurrentPage(new PageReference('PO_P2PAtt_RiepReq_ElCo'));
        
        ApexPages.currentPage().getParameters().put('recordOfferta','P2P Attiva');
		ApexPages.currentPage().getParameters().put('tipoP2Patt','eAccess');
        ApexPages.currentPage().getParameters().put('parentId',slFatt.id) ;
        ApexPages.currentPage().getParameters().put('id',parentCase.id) ;
        ApexPages.currentPage().getParameters().put('cLogId',sl.id) ;     
             
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
       
           
        riep.parentCaseObj =parentCase;
        riep.parentCase= parentCase;
        riep.parentCase.PO_Offerta__c='P2P Attiva';
        riep.testcase=parentCase;
        riep.testcase.PO_Offerta__c='P2P Attiva';
        riep.ChildCases = Caselist;
        riep.OrderCreation(Caselist);
        riep.getkitLogList();
        riep.getorderCases();
      //	riep.checkProfiloKitCollegamento(slFatt.id);
         riep.checkProfiloKitCollegamento();
        riep.childCase();
        riep.createChildLog();
         try{
              riep.InviaRichiesta_2();
        riep.InviaRichiesta();
         }
         catch(Exception e){}
             riep.parentLogObj= slFatt;
             riep.parentLogObj.EOF_Stato_Richiesta__c = 'Bozza Portale';
             riep.cLogId=sl.id;
             riep.kitLogId =slKit.id;
             riep.retUrl = ApexPages.currentPage().getURL();
             riep.goToKITpage();
             
          
             riep.getparentOppty();
             riep.checkStageName();
             riep.setNullToZ('t');
             riep.setNullToZ('');
             riep.attToInsert= attList;
             riep.attToDelete= attList;
             PO_P2PAtt_RiepReq_ElCoCntrl.ServiceLogWrapper slw = new PO_P2PAtt_RiepReq_ElCoCntrl.ServiceLogWrapper();
         //   riep.ServiceLogWrapper slw = new riep.ServiceLogWrapper();
             slw.profilosVlan='profilosVlan';
             slw.nomeKit='nomeKit';
             riep.deleteLog();
        Test.StopTest();
         }
    }
    
    public static testMethod void OrderCreationMethodECDOM(){
     
		Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
		Group codaIng = [Select Id from Group where DeveloperName='Coda_Ingegneria_P2PAttiva'];
		
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
		 OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Napoli';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
         Account acc = new Account();
         acc.name = 'Test';
         acc.RecordTypeId=mpRT.get('OLO');
       	 acc.EOF_Codice_Operatore__c='TIS';
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
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
       
        
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
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
        
       // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento'); //P2P_Attiva_Collegamento//P2P_Attiva_Collegamento /PO_Collegamento_P2P_Attiva
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Doppia Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2+2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        insert sl;
      //  slList.add(sl);
      //  
      	
          
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
       
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> sVlanList = new List<EOF_EAI_Service_Log__c>();
        sVlanList.add(sVlan1);
        
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
         parentCase.Status='In Lavorazione';
		 parentCase.EOF_Fase__c='In lavorazione';
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
		 parentCase.isDOM__c=true;
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
         insert parentCase;
         slFatt.Caso__c= parentCase.id;
		 slFatt.Accordo_Operativo__c = parentCase.CaseNumber;
       	 update slFatt;
		 caseFromPortal.add(parentCase);
        
		 list<Case> Caselist = new List<Case>();
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
		 Childcase.PO_Tipo_di_collegamento__c='Point-to-Point';
		 Childcase.PO_Numero_fibre_richieste__c='2+2';
		 Childcase.OF_IDContratto__c=contratto.id;
		 Childcase.PO_Prime_Contractor__c='Test';
		 Childcase.PO_Nome_sito__c='Test';
		 Childcase.PO_Comune2__c=ele.id;
		 ChildCase.PO_Tipo_percorso__c='Doppia Via';
		 ChildCase.PO_Sito__c ='Napoli';
		 ChildCase.PO_Nota_sito__c='TEST';
		 ChildCase.PO_Indirizzo_collegamento__c='Via Test';
		 ChildCase.PO_Civico__c='33';
		 ChildCase.Particella_Toponomastica_1__c='Via';
		 ChildCase.Particella_Toponomastica_2__c='Via';
		 ChildCase.Particella_Toponomastica_3__c='via';
         insert Childcase; 
         sl.Caso__c=Childcase.id;
		 Caselist.add(Childcase);
       	 update sl;
        slList.add(sl);
        slList.add(slFatt);
		
		Case tempKitCase = new Case();
          tempKitCase.recordTypeId= mpRT.get('PO_Case_P2P_Attiva_KIT');
          tempKitCase.EOF_Identificativo_del_POP__c=slKit.EOF_ID_Pop__c;
          tempKitCase.PO_Case_Collegamento__c=sl.Caso__c;
        
          tempKitCase.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
          tempKitCase.PO_PP_NomeKit__c=slKit.PO_P2PAttiva_Nome_del_KIT__c;
          tempKitCase.PO_P2PAttiva_KIT_OpticalRateLimiting__c=slKit.PO_P2PAttiva_Optical_Rate_Limiting__c;
		  
          tempKitCase.OwnerId = codaIng.id;
		  
          tempKitCase.ParentId=sl.Caso__c;      //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
          tempKitCase.Status = 'Acquisito';
		  insert tempKitCase;
         
          slKit.Caso__c=tempKitCase.Id;
          slKit.EOF_Stato_Richiesta__c='Acquisito';
          //Dopo aver popolato il childcase, aggiorno anche il kitLog
          slKit.EOF_Stato_Richiesta__c = 'Inserita Portale';
          slKit.EOF_STATO_ORDINE__c = 'Acquisito';
		
          update slKit;
        
        Childcase.PO_KIT_Consegna_VLAN__c= tempKitCase.id;
        update Childcase;

		sl.OF_PP_KIT_Log__c=slKit.id;
        update sl;
       // slC.OF_PP_KIT_Log__c=slKit.id;
       // update slC;
		EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = slFatt.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slOrd.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        insert slOrd;
      
        slord.PO_Offerta_Inoltrata__c = True;
       // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
        
      
		 Case childOrderCase = new Case();
			childOrderCase.status='Accettato';
			childOrderCase.ParentId=parentCase.Id;//Fattibilità
			childOrderCase.EOF_Codice_Operatore_WS__c = acc.EOF_Codice_Operatore__c;
			childOrderCase.EOF_Fase__c='In lavorazione supporto vendite';
			childOrderCase.PO_Case_Collegamento__c=Childcase.Id;
			childOrderCase.PO_Tipo_di_collegamento__c=Childcase.PO_Tipo_di_collegamento__c;
			childOrderCase.PO_Numero_fibre_richieste__c=Childcase.PO_Numero_fibre_richieste__c;
			childOrderCase.AccountId=acc.id;
			childOrderCase.OF_IDContratto__c=contratto.id;// RDG 2019-02-08
			childOrderCase.PO_Prime_Contractor__c= Childcase.PO_Prime_Contractor__c;
			childOrderCase.PO_Nome_sito__c=Childcase.PO_Nome_sito__c;
			childOrderCase.PO_KIT_Consegna_VLAN__c=Childcase.PO_KIT_Consegna_VLAN__c; //Lookup verso caseKit
			childOrderCase.PO_Comune2__c =Childcase.PO_Comune2__c;
			childOrderCase.PO_Tipo_percorso__c='Doppia Via';
			childOrderCase.PO_Sito__c=ChildCase.PO_Sito__c ;
			childOrderCase.PO_Nota_sito__c=ChildCase.PO_Nota_sito__c;
			childOrderCase.PO_Indirizzo_collegamento__c=ChildCase.PO_Indirizzo_collegamento__c;
			childOrderCase.PO_Civico__c= ChildCase.PO_Civico__c;
         	childOrderCase.PO_Offerta__c='P2P Attiva';
			//28/09/2017 CRM Modifica
			childOrderCase.PO_Richiesta_a_fattibilit_ordine__c = ChildCase.PO_Richiesta_a_fattibilit__c;
			//28/09/2017 END CRM
			childOrderCase.recordtypeid = mpRT.get('PO_Ordine_P2P_Attiva');
			//cs.OwnerId=codaSupportoVendite.Id;
			// cs.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Operatore_WS__c + '_' + c.CaseNumber; //FD 2019-02-28 EOF_Codice_Ordine_OLO__c su case ordine
			//Modifica Toponomastica
			childOrderCase.Particella_Toponomastica_1__c = ChildCase.Particella_Toponomastica_1__c;
			childOrderCase.Particella_Toponomastica_2__c = ChildCase.Particella_Toponomastica_2__c;
			childOrderCase.Particella_Toponomastica_3__c = ChildCase.Particella_Toponomastica_3__c;
			
		//	insert childOrderCase; 
			
		//	slOrd.Caso__c= childOrderCase.id;
		//	update slOrd;
		List<EOF_EAI_Service_Log__c> ordLogs = new List<EOF_EAI_Service_Log__c>();
        ordLogs.add(slOrd);
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
        
         system.runAs(usr){        
        Test.StartTest();
           Test.setCurrentPageReference(new PageReference('PO_P2PAtt_RiepReq_ElCo')); 
        Test.setCurrentPage(new PageReference('PO_P2PAtt_RiepReq_ElCo'));
        
        ApexPages.currentPage().getParameters().put('recordOfferta','P2P Attiva');
		ApexPages.currentPage().getParameters().put('tipoP2Patt','eAccess');
        ApexPages.currentPage().getParameters().put('parentId',slFatt.id) ;
        ApexPages.currentPage().getParameters().put('id',parentCase.id) ;
        ApexPages.currentPage().getParameters().put('cLogId',sl.id) ;     
             
        PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
       
        riep.parentLogObj=  slFatt;
        riep.parentLogObj.Caso__c = parentCase.id;     
        riep.childLog =sl;
        riep.childLog.Caso__c = ChildCase.id;
        riep.parentCaseObj =parentCase;
        riep.parentCase= parentCase;
        riep.parentCase.PO_Offerta__c='P2P Attiva';
        riep.testcase=parentCase;
        riep.testcase.PO_Offerta__c='P2P Attiva';
        riep.ChildCases = Caselist;
        riep.OrderCreation(Caselist);
        riep.getkitLogList();
        riep.getorderCases();
      //	riep.checkProfiloKitCollegamento(slFatt.id);
         riep.checkProfiloKitCollegamento();
        riep.childCase();
        riep.createChildLog();
         try{
              riep.InviaRichiesta_2();
        riep.InviaRichiesta();
         }
         catch(Exception e){}
             riep.parentLogObj= slFatt;
             riep.parentLogObj.EOF_Stato_Richiesta__c = 'Bozza Portale';
             riep.cLogId=sl.id;
             riep.kitLogId =slKit.id;
             riep.retUrl = ApexPages.currentPage().getURL();
             riep.goToKITpage();
             
          
             riep.getparentOppty();
             riep.checkStageName();
             riep.setNullToZ('t');
             riep.setNullToZ('');
             riep.attToInsert= attList;
             riep.attToDelete= attList;
             PO_P2PAtt_RiepReq_ElCoCntrl.ServiceLogWrapper slw = new PO_P2PAtt_RiepReq_ElCoCntrl.ServiceLogWrapper();
         //   riep.ServiceLogWrapper slw = new riep.ServiceLogWrapper();
             slw.profilosVlan='profilosVlan';
             slw.nomeKit='nomeKit';
             riep.deleteLog();
        Test.StopTest();
         }
    }
    
  public static testMethod void OrderCreationMethodECP2PEline(){
     
		Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
		Group codaIng = [Select Id from Group where DeveloperName='Coda_Ingegneria_P2PAttiva'];
		
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
		 OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Napoli';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
         Account acc = new Account();
         acc.name = 'Test';
         acc.RecordTypeId=mpRT.get('OLO');
       	 acc.EOF_Codice_Operatore__c='TIS';
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
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
       
        
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
        slFatt.RecordTypeId=mpRT.get('P2P_Attiva_Request_E_Line'); //('PO_P2PAttiva_Request');
      	slFatt.PO_Tipo_di_collegamento__c ='E-Line' ;
       	slFatt.EOF_Tipo_Comunicazione_String__c='Ordine di Attivazione';
       // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c);  
        //slList.add(slFatt);
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine'); //P2P_Attiva_Collegamento//P2P_Attiva_Collegamento /PO_Collegamento_P2P_Attiva
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Doppia Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2+2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        insert sl;
      //  slList.add(sl);
      //  
      	List<EOF_EAI_Service_Log__c>sLogKitList = new List<EOF_EAI_Service_Log__c>();
          
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
        sLogKitList.add(slKit);
        
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
       
        insert sVlan1;
        slList.add(sVlan1);
        List<EOF_EAI_Service_Log__c> sVlanList = new List<EOF_EAI_Service_Log__c>();
        sVlanList.add(sVlan1);
        
        List<Case> caseFromPortal = new List<Case>();
        
        Case parentCase = new Case();
         parentCase.Status='In Lavorazione';
		 parentCase.EOF_Fase__c='In lavorazione';
         parentCase.PO_Offerta__c ='P2P Attiva';
         parentCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         parentCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         parentCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
        // parentCase.PO_Richiesta_a_fattibilit__c=Childcase.id;
         parentCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');//
         insert parentCase;
         slFatt.Caso__c= parentCase.id;
		 slFatt.Accordo_Operativo__c = parentCase.CaseNumber;
       	 update slFatt;
		 caseFromPortal.add(parentCase);
        
		 list<Case> Caselist = new List<Case>();
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
         Childcase.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva_ELine');
         Childcase.PO_Nome_Progetto__c='TEST Nome Progetto';
		 Childcase.PO_Tipo_di_collegamento__c='Point-to-Point';
		 Childcase.PO_Numero_fibre_richieste__c='2+2';
		 Childcase.OF_IDContratto__c=contratto.id;
		 Childcase.PO_Prime_Contractor__c='Test';
		 Childcase.PO_Nome_sito__c='Test';
		 Childcase.PO_Comune2__c=ele.id;
		 ChildCase.PO_Tipo_percorso__c='Doppia Via';
		 ChildCase.PO_Sito__c ='Napoli';
		 ChildCase.PO_Nota_sito__c='TEST';
		 ChildCase.PO_Indirizzo_collegamento__c='Via Test';
		 ChildCase.PO_Civico__c='33';
		 ChildCase.Particella_Toponomastica_1__c='Via';
		 ChildCase.Particella_Toponomastica_2__c='Via';
		 ChildCase.Particella_Toponomastica_3__c='via';
         insert Childcase; 
         sl.Caso__c=Childcase.id;
		 Caselist.add(Childcase);
       	 update sl;
        slList.add(sl);
        slList.add(slFatt);
		
		Case tempKitCase = new Case();
          tempKitCase.recordTypeId= mpRT.get('PO_Case_P2P_Attiva_KIT');
          tempKitCase.EOF_Identificativo_del_POP__c=slKit.EOF_ID_Pop__c;
          tempKitCase.PO_Case_Collegamento__c=sl.Caso__c;
        
          tempKitCase.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = slKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
          tempKitCase.PO_PP_NomeKit__c=slKit.PO_P2PAttiva_Nome_del_KIT__c;
          tempKitCase.PO_P2PAttiva_KIT_OpticalRateLimiting__c=slKit.PO_P2PAttiva_Optical_Rate_Limiting__c;
		  
          tempKitCase.OwnerId = codaIng.id;
		  
          tempKitCase.ParentId=sl.Caso__c;      //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
          tempKitCase.Status = 'Acquisito';
		  insert tempKitCase;
         
          slKit.Caso__c=tempKitCase.Id;
          slKit.EOF_Stato_Richiesta__c='Acquisito';
          //Dopo aver popolato il childcase, aggiorno anche il kitLog
          slKit.EOF_Stato_Richiesta__c = 'Inserita Portale';
          slKit.EOF_STATO_ORDINE__c = 'Acquisito';
		
          update slKit;
        
        Childcase.PO_KIT_Consegna_VLAN__c= tempKitCase.id;
        update Childcase;

		sl.OF_PP_KIT_Log__c=slKit.id;
        update sl;
       // slC.OF_PP_KIT_Log__c=slKit.id;
       // update slC;
		EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        //slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_980898011';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=parentCase.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_NOTE__c='Note';
        slOrd.EOF_SL_Riferimento__c = slFatt.id;
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.EOF_SL_Riferimento__c = sl.id ;
        slOrd.PO_Offerta_Inoltrata__c = false;
        //slord.PO_Accordo_Quadro_Number__c = 'Test';
        //slord.Accordo_Operativo__c = 'Test';
        slOrd.RecordTypeId=mpRT.get('P2P_Attiva_Ordine_ELine');
        insert slOrd;
      
        slord.PO_Offerta_Inoltrata__c = True;
       // slord.PO_Accordo_Quadro_Number__c = 'Test1';
        update slOrd;  
        slList.add(slOrd);
        
      
		 Case childOrderCase = new Case();
			childOrderCase.status='Accettato';
			childOrderCase.ParentId=parentCase.Id;//Fattibilità
			childOrderCase.EOF_Codice_Operatore_WS__c = acc.EOF_Codice_Operatore__c;
			childOrderCase.EOF_Fase__c='In lavorazione supporto vendite';
			childOrderCase.PO_Case_Collegamento__c=Childcase.Id;
			childOrderCase.PO_Tipo_di_collegamento__c=Childcase.PO_Tipo_di_collegamento__c;
			childOrderCase.PO_Numero_fibre_richieste__c=Childcase.PO_Numero_fibre_richieste__c;
			childOrderCase.AccountId=acc.id;
			childOrderCase.OF_IDContratto__c=contratto.id;// RDG 2019-02-08
			childOrderCase.PO_Prime_Contractor__c= Childcase.PO_Prime_Contractor__c;
			childOrderCase.PO_Nome_sito__c=Childcase.PO_Nome_sito__c;
			childOrderCase.PO_KIT_Consegna_VLAN__c=Childcase.PO_KIT_Consegna_VLAN__c; //Lookup verso caseKit
			childOrderCase.PO_Comune2__c =Childcase.PO_Comune2__c;
			childOrderCase.PO_Tipo_percorso__c='Doppia Via';
			childOrderCase.PO_Sito__c=ChildCase.PO_Sito__c ;
			childOrderCase.PO_Nota_sito__c=ChildCase.PO_Nota_sito__c;
			childOrderCase.PO_Indirizzo_collegamento__c=ChildCase.PO_Indirizzo_collegamento__c;
			childOrderCase.PO_Civico__c= ChildCase.PO_Civico__c;
         	childOrderCase.PO_Offerta__c='P2P Attiva';
			//28/09/2017 CRM Modifica
			childOrderCase.PO_Richiesta_a_fattibilit_ordine__c = ChildCase.PO_Richiesta_a_fattibilit__c;
			//28/09/2017 END CRM
			childOrderCase.recordtypeid = mpRT.get('P2P_Attiva_COrdine_Eline');
			//cs.OwnerId=codaSupportoVendite.Id;
			// cs.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Operatore_WS__c + '_' + c.CaseNumber; //FD 2019-02-28 EOF_Codice_Ordine_OLO__c su case ordine
			//Modifica Toponomastica
			childOrderCase.Particella_Toponomastica_1__c = ChildCase.Particella_Toponomastica_1__c;
			childOrderCase.Particella_Toponomastica_2__c = ChildCase.Particella_Toponomastica_2__c;
			childOrderCase.Particella_Toponomastica_3__c = ChildCase.Particella_Toponomastica_3__c;
			
		//	insert childOrderCase; 
			
		//	slOrd.Caso__c= childOrderCase.id;
		//	update slOrd;
		List<EOF_EAI_Service_Log__c> ordLogs = new List<EOF_EAI_Service_Log__c>();
        ordLogs.add(slOrd);
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
        
         system.runAs(usr){        
        Test.StartTest();
        Test.setCurrentPageReference(new PageReference('PO_P2PAtt_RiepReq_ElCo')); 
        Test.setCurrentPage(new PageReference('PO_P2PAtt_RiepReq_ElCo'));
        
        ApexPages.currentPage().getParameters().put('recordOfferta','P2P Attiva');
		ApexPages.currentPage().getParameters().put('tipoP2Patt','eLine');
        ApexPages.currentPage().getParameters().put('parentId',slFatt.id) ;
        ApexPages.currentPage().getParameters().put('id',parentCase.id) ;
        ApexPages.currentPage().getParameters().put('cLogId',sl.id) ;     
             
		PO_P2PAtt_RiepReq_ElCoCntrl riep = new PO_P2PAtt_RiepReq_ElCoCntrl();
        
        
        riep.tipoP2PAttiva = 'eLine'; 
        riep.tipoP2PAttiva= ApexPages.currentPage().getParameters().get('tipoP2Patt');
        riep.tipoP2PAttiva = 'eLine'; 
        riep.parentCaseObj =parentCase;
        riep.parentCase= parentCase;
        riep.parentCase.PO_Offerta__c='P2P Attiva';
        riep.testcase=parentCase;
        riep.testcase.PO_Offerta__c='P2P Attiva';
        riep.ChildCases = Caselist;
        riep.OrderCreation(Caselist);
        riep.sLogKitList= sLogKitList;
        riep.sLogVlanList=sVlanList;
        riep.getkitLogList();
        riep.getorderCases();
      //	riep.checkProfiloKitCollegamento(slFatt.id);
         riep.checkProfiloKitCollegamento();
        riep.childCase();
        riep.createChildLog();
         try{
              riep.InviaRichiesta_2();
        riep.InviaRichiesta();
         }
         catch(Exception e){}
             riep.parentLogObj= slFatt;
             riep.parentLogObj.EOF_Stato_Richiesta__c = 'Bozza Portale';
             riep.cLogId=sl.id;
             riep.kitLogId =slKit.id;
             riep.retUrl = ApexPages.currentPage().getURL();
            // riep.goToKITpage();
             
          
             riep.getparentOppty();
             riep.checkStageName();
             riep.setNullToZ('t');
             riep.setNullToZ('');
             riep.attToInsert= attList;
             riep.attToDelete= attList;
             PO_P2PAtt_RiepReq_ElCoCntrl.ServiceLogWrapper slw = new PO_P2PAtt_RiepReq_ElCoCntrl.ServiceLogWrapper();
         //   riep.ServiceLogWrapper slw = new riep.ServiceLogWrapper();
             slw.profilosVlan='profilosVlan';
             slw.nomeKit='nomeKit';
             riep.deleteLog();
             try{
              riep.checkVendibilitaRichiesta(acc.id,null);
                 
             }catch(exception e){}
             try{
              riep.checkVendibilitaRichiesta(acc.id,'Test');
                 
             }catch(exception e){}

             servizio.Name = '777P2P Attiva';  
             update servizio;
             try{
             
             riep.checkVendibilitaRichiesta(acc.id,'P2P Attiva');
                 
             }catch(exception e){}
             
             
        Test.StopTest();
         }
    }

    @isTest
    static void updateSatellitesTest() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        Case master = new Case();
        master.tipologia_sede__c = 'Master';
        master.SF_Ccoll_ID_Sede__c = 'TIS_0001';
        data.caseCollegamento.tipologia_sede__c = 'Satellite';
        data.caseCollegamento.SF_Ccoll_ID_Sede__c = 'TIS_0002';

        EOF_EAI_Service_Log__c logMaster = new EOF_EAI_Service_Log__c();
        logMaster.caso__c = master.Id;
        logMaster.tipologia_sede__c = 'Master';
        insert logMaster;

        List<Case> toUpsert = new List<Case>();
        toUpsert.add(master);
        toUpsert.add(data.caseCollegamento); 
        upsert toUpsert;

        Test.startTest();
        PO_P2PAtt_RiepReq_ElCoCntrl ctrl = new PO_P2PAtt_RiepReq_ElCoCntrl();
        ctrl.accId = data.casePadre.AccountId;
        ctrl.parentLogObj = data.logRichiesta;
        ctrl.P2PAttivaLogList = new List<EOF_EAI_Service_Log__c>{data.logCollegamento};
        ctrl.ListKitToSend = new List<EOF_EAI_Service_Log__c>();
        ctrl.slListToDelete = new List<EOF_EAI_Service_Log__c>();
        
        List<Case> satellite = new List<Case>();
        satellite.add(data.caseCollegamento);
        
        ctrl.updateSatellites(satellite, logMaster.id);
        Test.stopTest();
    }
    
    @isTest
    static void updateKitInCondivisioneTest() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        EOF_EAI_Service_Log__c kitLog = new EOF_EAI_Service_Log__c();
        kitLog.caso__c = data.caseKit.Id;
        insert kitLog;

        Map<EOF_EAI_Service_Log__c, Case> map_logColleg_caseColleg = new Map<EOF_EAI_Service_Log__c, Case>();
        map_logColleg_caseColleg.put(data.logCollegamento, data.caseCollegamento);

        Map<String, Case> map_idLogKit_caseKit = new Map<String, Case>();
        map_idLogKit_caseKit.put(kitLog.Id, data.caseKit);

        Test.startTest();
        PO_P2PAtt_RiepReq_ElCoCntrl ctrl = new PO_P2PAtt_RiepReq_ElCoCntrl();
        ctrl.accId = data.casePadre.AccountId;
        ctrl.parentLogObj = data.logRichiesta;
        ctrl.P2PAttivaLogList = new List<EOF_EAI_Service_Log__c>{data.logCollegamento};
        ctrl.ListKitToSend = new List<EOF_EAI_Service_Log__c>();
        ctrl.slListToDelete = new List<EOF_EAI_Service_Log__c>();
        
        ctrl.updateKitInCondivisione(map_logColleg_caseColleg, map_idLogKit_caseKit);
        Test.stopTest();

    }    
}
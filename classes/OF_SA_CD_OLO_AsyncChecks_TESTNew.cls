@isTest
public class OF_SA_CD_OLO_AsyncChecks_TESTNew {
    
    @testSetup 
    public static void testSetUpData() {
        List<Stato_Building_positivi__c> lstCsPositivi = new List<Stato_Building_positivi__c>();
        
        Stato_Building_positivi__c state102 = new Stato_Building_positivi__c();
        	state102.Name = '102';
        lstCsPositivi.add(state102);
        
        Stato_Building_positivi__c state104 = new Stato_Building_positivi__c();
        	state104.Name = '104';
        lstCsPositivi.add(state104);        
        
        Stato_Building_positivi__c state105 = new Stato_Building_positivi__c();
        	state105.Name = '105';
        lstCsPositivi.add(state105);
        
        Stato_Building_positivi__c state107 = new Stato_Building_positivi__c();
        	state107.Name = '107';
        lstCsPositivi.add(state107);
        
        Stato_Building_positivi__c state109 = new Stato_Building_positivi__c();
        	state109.Name = '109';
        lstCsPositivi.add(state109);
        
        Stato_Building_positivi__c state110 = new Stato_Building_positivi__c();
        	state110.Name = '110';
        lstCsPositivi.add(state110);
        
        insert lstCsPositivi;
        
		List<Stato_Building_negativi__c> lstCsNegativi = new List<Stato_Building_negativi__c>();        
        
        Stato_Building_negativi__c stateN101 = new Stato_Building_negativi__c();
        	stateN101.Name = '101';
        lstCsNegativi.add(stateN101);
        
        Stato_Building_negativi__c stateN103 = new Stato_Building_negativi__c();
        	stateN103.Name = '103';
        lstCsNegativi.add(stateN103);
        
        Stato_Building_negativi__c stateN106 = new Stato_Building_negativi__c();
        	stateN106.Name = '106';
        lstCsNegativi.add(stateN106);
        
        Stato_Building_negativi__c stateN108 = new Stato_Building_negativi__c();
        	stateN108.Name = '108';
        lstCsNegativi.add(stateN108);
        
        insert lstCsNegativi;
            
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    }
    
    public static Account accountCreation()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        return acc;
    }
    
    public static Account accountOFCreation()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'OpenFiber';
        acc.Type = 'OLO';
        acc.EOF_Codice_Operatore__c = 'OF';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        return acc;
    }

    public static Account account_OLO_Creation()
    {
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
        
        return accOLO;
    }
    
    public static Case caseActivationCreation(Account acc, Account accOLO, Asset asset_t,order ord)
    {
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_t.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ord.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        insert c;
        
        return c;
    }
    
    public static Case caseActivationCreation1(Account acc, Account accOLO, Asset asset_t,order ord)
    {
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.EOF_ID_Risorsa__c = 'IDR1234';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_t.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ord.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        insert c;
        
        return c;
    }
     
    public static Case caseActivationCreation2(Account acc, Account accOLO, Asset asset_t,order ord)
    {
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF SP Caso Cessazione CeD').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.EOF_ID_Risorsa__c = 'IDR1234';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_t.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ord.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        insert c;
        
        return c;
    }
    
   
    public static Order orderCreation(Asset asset_t, Account acc)
    {
        Order ordine = new Order();
        //ordine.OF_CaseID__c = c.id;
        ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        return ordine;
    }

    public static Asset assetCreation(Account acc, String contractId){

        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contractId;
        insert asset_1;

        return asset_1;
    }

    public static OF_CatalogoCommerciale__c Catalogo_Creation()
    {
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        return catalogo;
    }
    
    public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
       
        insert servizio;
        return servizio;
    }
    
    public static OF_Servizio__c Servizio_Creation1(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
       
        insert servizio;
        return servizio;
    }
    
    public static Contract createContract(Account acc)
    {
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        //contratto.EndDate = System.today();
        insert contratto;
        return contratto;
    }
    
    public static OF_CommercialElement__c CE_Creation(OF_Servizio__c serv)
    {
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        ce.name = 'SERVIZIO OPEN STREAM BASE';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio;
        ce.OF_DataFineValidita__c = fine;
        ce.OF_Servizio__c = serv.id;
        insert ce;
        return ce;
    }  
    
    public static OF_BillingElement__c createContributoVerticale(OF_CommercialElement__c ce)
    {
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.name = 'Contributo Attivazione';
        be.OF_CommercialElement__c = ce.id;
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        be.OF_Attivo__c = true;
        be.OF_DataInizioValidita__c = inizio;
        be.OF_DataFineValidita__c = fine;
        insert be;
        return be;
    }
    
    public static OF_ContrattoServizio__c createContrattoServizio(Contract contr, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c = contr.Id;
        conServ.OF_Servizio__c = serv.id;
        
        insert conServ;      
        return conServ;
    }
    
    public static OF_BillingElement__c createContributoStornoVerticale(OF_CommercialElement__c ce)
    {
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.name = 'Contributo di disattivazione';
        be.OF_CommercialElement__c = ce.id;
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        be.OF_Attivo__c = true;
        be.OF_DataInizioValidita__c = inizio;
        be.OF_DataFineValidita__c = fine;
        insert be;
        return be;
    }

   public static OF_CommercialElementIstanziato__c  CEI_Creation(Asset assetStd,OF_CommercialElement__c CE)
   {
        OF_CommercialElementIstanziato__c CEI = new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        CEI.OF_Asset__c=assetStd.id;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=CE.id;
        CEI.OF_CPE__c = CEI.Id;
        insert CEI;
        return CEI;
    }
    
   //slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
  
   /*public static testMethod void test_OLO_AsyncActivation1(){
        
        List<RecordType> Casertypes = [Select Name, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.Name,rt.Id);
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        
         String slId = slFiberReq.id;
        slFiberReq.Caso__c = c.id;
        slFiberReq.Id = slId;
        insert slFiberReq;
        
         List<EOF_EAI_Service_Log__c> ListSlOrig = new List<EOF_EAI_Service_Log__c>();
        ListSlOrig.add(slFiberReq);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
       
        Test.startTest();
       
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.caseOriginale = c;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_ID_Building_WS__c = null;
        
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
        
        OF_SA_CD_GE_Utils.cliente = acc;
        
        OF_SA_CD_GE_Utils.refTec = new contact();

        
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
    //  slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - Vlan');
    
     public static testMethod void test_OLO_AsyncActivation2(){
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - Vlan');
        
        insert slFiberReq;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
        
        Test.startTest();
         
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
         
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
    //  slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - Cpe');
    
     public static testMethod void test_OLO_AsyncActivation3(){
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - Cpe');
        
        insert slFiberReq;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        corretto.OF_SA_Stato_Building__c = 107;
        insert corretto;
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        Ele.OF_CodiceIstat__c = 'Test';
        Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
        BusinessHours bh = [SELECT Id 
                                FROM BusinessHours 
                                WHERE IsDefault=true];
        
        //bh.isWithin('businessHoursId', system.now());         
        boolean isWithin = false;
        
        Test.startTest();
         
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c ='TIS_20170403_000000061';
         
        OF_SA_CD_GE_Utils.processo = 'attivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
         
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
    public static testMethod void test_OLO_AsyncActivation4(){
        
        List<RecordType> Casertypes = [Select Name, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.Name,rt.Id);
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        slFiberReq.EOF_NOME_CLIENTE__C = 'Test';
        insert slFiberReq;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        insert corretto;
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        Ele.OF_CodiceIstat__c = 'Test';
        Ele.OF_Comune__c = 'Test';
        insert Ele;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;

        Test.startTest();
       
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        //OF_SA_CD_GE_Utils.caseOriginale.RecordTypeId = OF_SA_CD_GE_Utils.rtMap.get('EOF Caso Attivazione OPENSTREAM CeD');
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'passivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
        
       // List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
      //  EOFList.add(slFiberReq);
        
       // OF_SA_CD_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>();
       // OF_SA_CD_GE_Utils.ListServAgg.add(slFiberReq);
       
        
       List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
        
        OF_SA_CD_GE_Utils.ListServAgg = EOFList;
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
      public static testMethod void test_OLO_AsyncActivation5(){
        
        List<RecordType> Casertypes = [Select Name, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.Name,rt.Id);
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        //String AccountRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF SA Servizi Aggiuntivi').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        slFiberReq.EOF_NOME_CLIENTE__C = 'Test';
        insert slFiberReq;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        corretto.OF_SA_Stato_Building__c = 106;
        insert corretto;
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        Ele.OF_CodiceIstat__c = 'Test';
        Ele.OF_Comune__c = 'Test';
        insert Ele;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation1(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        OF_ContrattoServizio__c conServ = createContrattoServizio(contratto,servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
          
        List<OF_ContrattoServizio__c> listcheckCDContract = new  List<OF_ContrattoServizio__c>();
        listcheckCDContract.add( conServ);

        Test.startTest();
       
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        //OF_SA_CD_GE_Utils.caseOriginale.RecordTypeId = OF_SA_CD_GE_Utils.rtMap.get('EOF Caso Attivazione OPENSTREAM CeD');
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'passivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
        
        //List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
       // EOFList.add(slFiberReq);
        
       // OF_SA_CD_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>();
       // OF_SA_CD_GE_Utils.ListServAgg.add(slFiberReq);
      
          
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
          
         OF_SA_CD_GE_Utils.ListServAgg = EOFList;
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
     public static testMethod void test_OLO_AsyncActivation6(){
        
        List<RecordType> Casertypes = [Select Name, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.Name,rt.Id);
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        slFiberReq.EOF_NOME_CLIENTE__C = 'Test';
        insert slFiberReq;
        
       
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        //Ele.OF_CodiceIstat__c = Ele.Id;
        Ele.OF_Provincia__c = 'Test';
        Ele.OF_CodiceIstat__c = 'Test';
        insert Ele;
         
         OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        corretto.OF_SA_Stato_Building__c = 101;
        insert corretto;
         
        List<OF_ElencoComuniItaliani__c> cList = new List<OF_ElencoComuniItaliani__c>();
        cList.add(Ele);
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation1(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        OF_ContrattoServizio__c conServ = createContrattoServizio(contratto,servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
          
        List<OF_ContrattoServizio__c> listcheckCDContract = new  List<OF_ContrattoServizio__c>();
        listcheckCDContract.add( conServ);
         
         BusinessHours bh = [SELECT Id 
                                FROM BusinessHours 
                                WHERE IsDefault=true];
        
        //bh.isWithin('businessHoursId', system.now());         
        boolean isWithin = false;

        Test.startTest();
       
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        //OF_SA_CD_GE_Utils.caseOriginale.RecordTypeId = OF_SA_CD_GE_Utils.rtMap.get('EOF Caso Attivazione OPENSTREAM CeD');
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'passivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
        
       // List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
       // EOFList.add(slFiberReq);
        
       // OF_SA_CD_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>();
       // OF_SA_CD_GE_Utils.ListServAgg.add(slFiberReq);
         
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
         
        OF_SA_CD_GE_Utils.ListServAgg = EOFList;

        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
     public static testMethod void test_OLO_AsyncActivation7(){
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - Cpe');
        
        insert slFiberReq;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        corretto.OF_SA_Stato_Building__c = 105;
        insert corretto;
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        Ele.OF_CodiceIstat__c = 'Test';
        Ele.OF_Comune__c = 'Test';
        insert Ele;
        
        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
         
         List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
      public static testMethod void test_OLO_AsyncActivation8(){
        
        List<RecordType> Casertypes = [Select Name, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.Name,rt.Id);
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        slFiberReq.EOF_NOME_CLIENTE__C = 'Test';
        insert slFiberReq;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        corretto.OF_SA_Stato_Building__c = 101;
        insert corretto;
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        Ele.OF_CodiceIstat__c = 'Test';
        Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation1(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        OF_ContrattoServizio__c conServ = createContrattoServizio(contratto,servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
          
        List<OF_ContrattoServizio__c> listcheckCDContract = new  List<OF_ContrattoServizio__c>();
        listcheckCDContract.add( conServ);
          
        OF_Generatore_ID_Servizio__c GenServizio = new OF_Generatore_ID_Servizio__c();
        GenServizio.OF_Case_Id__c = c.id;
        insert GenServizio;

        Test.startTest();
       
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        //OF_SA_CD_GE_Utils.caseOriginale.RecordTypeId = OF_SA_CD_GE_Utils.rtMap.get('EOF Caso Attivazione OPENSTREAM CeD');
        
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c = acc.Id;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c = system.today() - 5;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c = system.today() + 5;
        OF_SA_CD_GE_Utils.caseOriginale.Id = c.Id;
          
       OF_SA_CD_GE_Utils.gen = GenServizio;
          
          
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'passivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
        
       // List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
       // EOFList.add(slFiberReq);
        
       // OF_SA_CD_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>();
       // OF_SA_CD_GE_Utils.ListServAgg.add(slFiberReq);
         
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
         
        OF_SA_CD_GE_Utils.ListServAgg = EOFList;

        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } */
    //AA - 13/12/18 - TestMethod OLO_AsyncActivation
    public static testMethod void test_OLO_AsyncActivation(){
        //Recupero tutti i recordType dei case
        List<RecordType> casesLstRType = [SELECT developername, Id 
                                       	  FROM RecordType 
                                          WHERE sObjectType = 'Case' 
                                          AND isActive = true];
        //Popolo una map con tutti i recordType dei case avente come key il developername e come Value l'id
        Map<String,String> casesRType = new Map<String,String>();
        for(RecordType rt : casesLstRType){
            casesRType.put(rt.developername, rt.Id);
        }
        //Recupero tutti i recordType dei serviceLog
        List<RecordType> sLogLstRType = [SELECT developername, Id 
                                         FROM RecordType 
                  					     WHERE sObjectType = 'EOF_EAI_Service_Log__c' 
                                         AND isActive = true];
        //Popolo una map con tutti i recordType dei serviceLog avente come key il developername e come Value l'id
        Map<String,String> sLogRType = new Map<String,String>();
        for(RecordType rt : sLogLstRType){
            sLogRType.put(rt.developername, rt.Id);
        }
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
            Ele.OF_CodiceIstat__c = 'Test';
            Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
		OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
            corretto.OF_SA_Comune__c = 'Test';
            corretto.OF_SA_Stato_Building__c = 101;
        insert corretto;
        //Inserisco il commercialElement del servizio aggiuntivo
        OF_CommercialElement__c ceServAgg = new OF_CommercialElement__c();
        	ceServAgg.OF_Servizio__c = Servizio_Creation(Catalogo_Creation()).Id;
        	ceServAgg.Name = 'Estensione Impianto Cliente';
        	ceServAgg.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
            ceServAgg.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ceServAgg;
        //Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        OLO_ID__c oloId = new OLO_ID__c();
            oloId.OF_Olo_Id__c = accOLO.Id;
            oloId.Name = 'VF';
        insert oloId;
        //Creo il log di attivazione
        EOF_EAI_Service_Log__c sLogOLOSF = new EOF_EAI_Service_Log__c(
            RecordTypeId = sLogRType.get('OF_SA_CeD_FiberRequest'),
            OF_SA_Direzione_Flusso__c = 'OLO-SF',
            OF_SA_Metodo__c = 'OLO_ActivationSetup_OpenStream',
            EOF_Tipo_COmunicazione_String__c = 'OLO->SF - ActivationRequest',
            EOF_CODICE_OPERATORE__C = 'VF',
            EOF_CODICE_ORDINE_OLO__C = 'TEST_Act_'+String.valueOf(system.now()).right(8),
            EOF_DATA_NOTIFICA__C = OF_SA_CD_GE_Utils.StringTODate(String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00'), 
            EOF_ID_NOTIFICA__C = String.valueOf(System.now().getTime()),
            EOF_NOME_REFERENTE_TECNICO_OLO__C = 'Nome',
            EOF_COGNOME_REFERENTE_TECNICO_OLO__C = 'Cognome',
            EOF_TELEFONO_REFERENTE_TECNICO_OLO__C = '1234',
            EOF_EMAIL_REFERENTE_TECNICO_OLO__C = 'aaa@aa.com',
            EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C = '123456',
            EOF_NOME_CLIENTE__C = 'Nome',
            EOF_COGNOME_CLIENTE__C = 'Cognome',
            EOF_RECAPITO_TELEFONICO_CLIENTE_1__C = '12324',
            EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = '312312',
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__C = 'test',
            EOF_ORARIO_APPUNTAMENTO__C = '16:30:00',
            EOF_CODICE_PROGETTO_SPECIALE__c = '12',
            EOF_PROMOZIONE__C = '123',
            EOF_CLUSTER_PROMOZIONE__C = '123',
            EOF_ID_BUILDING__C = '12_058_058005_8000612172_31',
            EOF_SCALA_PALAZZINA__C = '',
            EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C='12323',
            EOF_RECAPITO_TEST_LINEA__C = '123123',
            EOF_ID_Pop__c = 'RMAPA',
            EOF_PROFILO__C = '45',
            EOF_Note__c = 'asdf',
            EOF_DATA_PREVISTA_ATTIVAZIONE__C = OF_SA_CD_GE_Utils.StringTODateNoTime('2018-12-24')
        );
        
        //Creo il case di attivazione
        Case c = new Case(); 
            c.RecordTypeId = casesRType.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c.EOF_Codice_Ordine_Olo__c = sLogOLOSF.EOF_CODICE_ORDINE_OLO__C;
            c.EOF_Codice_Operatore_WS__c = sLogOLOSF.EOF_CODICE_OPERATORE__C;           
            c.EOF_Data_Notifica__c = sLogOLOSF.EOF_DATA_NOTIFICA__C;
            c.EOF_Id_Notifica__c = sLogOLOSF.EOF_ID_NOTIFICA__C;                
            c.EOF_Data_Prevista_Attivazione__c = sLogOLOSF.EOF_DATA_PREVISTA_ATTIVAZIONE__C;
            c.EOF_Identificativo_del_POP__c= sLogOLOSF.EOF_ID_Pop__c;
            c.EOF_ID_Building_WS__c = sLogOLOSF.EOF_ID_BUILDING__C;
            c.subject = 'Richiesta Attivazione';
            c.status = 'Inviato';
            c.EOF_FASE__C = 'NA';
            c.PO_SA_Portale__c = false;
        insert c;
        //Lego il log al case
       	sLogOLOSF.Caso__c = c.Id;
        //Inserisco il log
        insert sLogOLOSF;
        //Inserisco le VLAN, Apparati e Serv.Aggiuntivi
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        Integer n = 1;
        //VLAN
        EOF_EAI_Service_Log__C vlan1 = new EOF_EAI_Service_Log__C();
            vlan1.recordtypeid = sLogRType.get('OF_SA_Vlan');
            vlan1.OF_SA_KIT_CONSEGNA_VLAN__C = 'TIS_MI_1';
            vlan1.OF_SA_USER_VLAN__C = '835';
            vlan1.OF_SA_SERVICE_VLAN__C = '100';
            vlan1.OF_SA_PROFILO_VLAN__C = 'AG11';
            vlan1.OF_SA_INFORMAZIONI_VLAN__C = '';
            vlan1.OF_SA_CUSTOMER_VLAN__C = '156';
            vlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = '1:1';
            vlan1.OF_SA_VLan_Log__c = sLogOLOSF.id;
            vlan1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(vlan1);
        n++;
        //Apparato
        EOF_EAI_Service_Log__C app1 = new EOF_EAI_Service_Log__C();
            app1.recordtypeid = sLogRType.get('OF_SA_Cpe');
            app1.EOF_TIPOLOGIA_APPARATO__C = 'SmartTV';
            app1.OF_SA_PASSWORD_APPARATO__C = '123';
            app1.OF_SA_AZIONE_APPARATO__C = '0';
            app1.OF_SA_Cpe_Log__c = sLogOLOSF.id;
            app1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(app1);
        n++;
        //Servizio Aggiuntivo
        EOF_EAI_Service_Log__C servAgg1 = new EOF_EAI_Service_Log__C();
            servAgg1.recordtypeid = sLogRType.get('OF_SA_Servizi_Aggiuntivi');
            servAgg1.OF_SA_NOME_SERVIZIO__c = 'Estensione Impianto Cliente';
            servAgg1.OF_SA_INFORMAZIONI_SERVIZIO__c = '0';
            servAgg1.OF_SA_servizi_Aggiuntivi_Log__c = sLogOLOSF.id;
            servAgg1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(servAgg1);
        //Inserisco la lista
        insert sLogList;
        //Inserisco l'id_servizio
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
        	g.OF_Case_Id__c=c.Id;
        insert g;
        //Inizia lo scope del test
        Test.startTest();
        //Setto il mock
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id, sLogOLOSF.Id);
        //Finisce lo scope del test
		Test.stopTest();
    }
    //FINE AA - 13/12/18
    public static testMethod void test_OLO_AsyncActivation1(){
        //Recupero tutti i recordType dei case
        List<RecordType> casesLstRType = [SELECT developername, Id 
                                       	  FROM RecordType 
                                          WHERE sObjectType = 'Case' 
                                          AND isActive = true];
        //Popolo una map con tutti i recordType dei case avente come key il developername e come Value l'id
        Map<String,String> casesRType = new Map<String,String>();
        for(RecordType rt : casesLstRType){
            casesRType.put(rt.developername, rt.Id);
        }
        //Recupero tutti i recordType dei serviceLog
        List<RecordType> sLogLstRType = [SELECT developername, Id 
                                         FROM RecordType 
                  					     WHERE sObjectType = 'EOF_EAI_Service_Log__c' 
                                         AND isActive = true];
        //Popolo una map con tutti i recordType dei serviceLog avente come key il developername e come Value l'id
        Map<String,String> sLogRType = new Map<String,String>();
        for(RecordType rt : sLogLstRType){
            sLogRType.put(rt.developername, rt.Id);
        }
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
            Ele.OF_CodiceIstat__c = 'Test';
            Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
		OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
            corretto.OF_SA_Comune__c = 'Test';
            corretto.OF_SA_Stato_Building__c = 101;
            corretto.OF_SA_Pop__c ='test';
        insert corretto;
        //Inserisco il commercialElement del servizio aggiuntivo
        OF_CommercialElement__c ceServAgg = new OF_CommercialElement__c();
        	ceServAgg.OF_Servizio__c = Servizio_Creation(Catalogo_Creation()).Id;
        	ceServAgg.Name = 'Estensione Impianto Cliente';
        	ceServAgg.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
            ceServAgg.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ceServAgg;
        //Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        OLO_ID__c oloId = new OLO_ID__c();
            oloId.OF_Olo_Id__c = accOLO.Id;
            oloId.Name = 'VF';
        insert oloId;
        //Creo il log di attivazione
        EOF_EAI_Service_Log__c sLogOLOSF = new EOF_EAI_Service_Log__c(
            RecordTypeId = sLogRType.get('OF_SA_CeD_FiberRequest'),
            OF_SA_Direzione_Flusso__c = 'OLO-SF',
            OF_SA_Metodo__c = 'OLO_ActivationSetup_OpenStream',
            EOF_Tipo_COmunicazione_String__c = 'OLO->SF - ActivationRequest',
            EOF_CODICE_OPERATORE__C = 'VF',
            EOF_CODICE_ORDINE_OLO__C = 'TEST_Act_'+String.valueOf(system.now()).right(8),
            EOF_DATA_NOTIFICA__C = OF_SA_CD_GE_Utils.StringTODate(String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00'), 
            EOF_ID_NOTIFICA__C = String.valueOf(System.now().getTime()),
            EOF_NOME_REFERENTE_TECNICO_OLO__C = 'Nome',
            EOF_COGNOME_REFERENTE_TECNICO_OLO__C = 'Cognome',
            EOF_TELEFONO_REFERENTE_TECNICO_OLO__C = '1234',
            EOF_EMAIL_REFERENTE_TECNICO_OLO__C = 'aaa@aa.com',
            EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C = '123456',
           // EOF_NOME_CLIENTE__C = 'Nome',
            EOF_COGNOME_CLIENTE__C = 'Cognome',
            EOF_RECAPITO_TELEFONICO_CLIENTE_1__C = '12324',
            EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = '312312',
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__C = 'test',
            EOF_ORARIO_APPUNTAMENTO__C = '16:30:00',
            EOF_CODICE_PROGETTO_SPECIALE__c = '12',
            EOF_PROMOZIONE__C = '123',
            EOF_CLUSTER_PROMOZIONE__C = '123',
            EOF_ID_BUILDING__C = '12_058_058005_8000612172_31',
            EOF_SCALA_PALAZZINA__C = '',
            EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C='12323',
            EOF_RECAPITO_TEST_LINEA__C = '123123',
            EOF_ID_Pop__c = 'RMAPA',
            EOF_PROFILO__C = '45',
            EOF_Note__c = 'asdf',
            EOF_DATA_PREVISTA_ATTIVAZIONE__C = OF_SA_CD_GE_Utils.StringTODateNoTime('2018-12-24')
        );
        
        //Creo il case di attivazione
        Case c = new Case(); 
            c.RecordTypeId = casesRType.get('EOF_SP_Caso_Attivazione_CeD');
            c.EOF_Codice_Ordine_Olo__c = sLogOLOSF.EOF_CODICE_ORDINE_OLO__C;
            c.EOF_Codice_Operatore_WS__c = sLogOLOSF.EOF_CODICE_OPERATORE__C;           
            c.EOF_Data_Notifica__c = sLogOLOSF.EOF_DATA_NOTIFICA__C;
            c.EOF_Id_Notifica__c = sLogOLOSF.EOF_ID_NOTIFICA__C;                
            c.EOF_Data_Prevista_Attivazione__c = sLogOLOSF.EOF_DATA_PREVISTA_ATTIVAZIONE__C;
            c.EOF_Identificativo_del_POP__c= sLogOLOSF.EOF_ID_Pop__c;
            c.EOF_ID_Building_WS__c = sLogOLOSF.EOF_ID_BUILDING__C;
            c.subject = 'Richiesta Attivazione';
            c.status = 'Inviato';
            c.EOF_FASE__C = 'NA';
            c.PO_SA_Portale__c = false;
            c.OF_Bonifica_Locked_Row__c=true;
        insert c;
        //Lego il log al case
       	sLogOLOSF.Caso__c = c.Id;
        //Inserisco il log
        insert sLogOLOSF;
        //Inserisco le VLAN, Apparati e Serv.Aggiuntivi
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        Integer n = 1;
        //VLAN
        EOF_EAI_Service_Log__C vlan1 = new EOF_EAI_Service_Log__C();
            vlan1.recordtypeid = sLogRType.get('OF_SA_Vlan');
            vlan1.OF_SA_KIT_CONSEGNA_VLAN__C = 'TIS_MI_1';
            vlan1.OF_SA_USER_VLAN__C = '835';
            vlan1.OF_SA_SERVICE_VLAN__C = '100';
            vlan1.OF_SA_PROFILO_VLAN__C = 'AG11';
            vlan1.OF_SA_INFORMAZIONI_VLAN__C = '';
            vlan1.OF_SA_CUSTOMER_VLAN__C = '156';
            vlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = '1:1';
            vlan1.OF_SA_VLan_Log__c = sLogOLOSF.id;
            vlan1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(vlan1);
        n++;
        //Apparato
        EOF_EAI_Service_Log__C app1 = new EOF_EAI_Service_Log__C();
            app1.recordtypeid = sLogRType.get('OF_SA_Cpe');
            app1.EOF_TIPOLOGIA_APPARATO__C = 'SmartTV';
            app1.OF_SA_PASSWORD_APPARATO__C = '123';
            app1.OF_SA_AZIONE_APPARATO__C = '0';
            app1.OF_SA_Cpe_Log__c = sLogOLOSF.id;
            app1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(app1);
        n++;
        //Servizio Aggiuntivo
        EOF_EAI_Service_Log__C servAgg1 = new EOF_EAI_Service_Log__C();
            servAgg1.recordtypeid = sLogRType.get('OF_SA_Servizi_Aggiuntivi');
            servAgg1.OF_SA_NOME_SERVIZIO__c = 'Estensione Impianto Cliente';
            servAgg1.OF_SA_INFORMAZIONI_SERVIZIO__c = '0';
            servAgg1.OF_SA_servizi_Aggiuntivi_Log__c = sLogOLOSF.id;
            servAgg1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(servAgg1);
        //Inserisco la lista
        insert sLogList;
        //Inserisco l'id_servizio
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
        	g.OF_Case_Id__c=c.Id;
        insert g;
        //Inizia lo scope del test
        Test.startTest();
        //Setto il mock
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id, sLogOLOSF.Id);
        //Finisce lo scope del test
		Test.stopTest();
    }
    
    public static testMethod void test_OLO_AsyncActivation2(){
        //Recupero tutti i recordType dei case
        List<RecordType> casesLstRType = [SELECT developername, Id 
                                       	  FROM RecordType 
                                          WHERE sObjectType = 'Case' 
                                          AND isActive = true];
        //Popolo una map con tutti i recordType dei case avente come key il developername e come Value l'id
        Map<String,String> casesRType = new Map<String,String>();
        for(RecordType rt : casesLstRType){
            casesRType.put(rt.developername, rt.Id);
        }
        //Recupero tutti i recordType dei serviceLog
        List<RecordType> sLogLstRType = [SELECT developername, Id 
                                         FROM RecordType 
                  					     WHERE sObjectType = 'EOF_EAI_Service_Log__c' 
                                         AND isActive = true];
        //Popolo una map con tutti i recordType dei serviceLog avente come key il developername e come Value l'id
        Map<String,String> sLogRType = new Map<String,String>();
        for(RecordType rt : sLogLstRType){
            sLogRType.put(rt.developername, rt.Id);
        }
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
            Ele.OF_CodiceIstat__c = 'Test';
            Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
		OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
            corretto.OF_SA_Comune__c = 'Test';
            corretto.OF_SA_Stato_Building__c = 101;
            corretto.OF_SA_Pop__c ='test';
        insert corretto;
        //Inserisco il commercialElement del servizio aggiuntivo
        OF_CommercialElement__c ceServAgg = new OF_CommercialElement__c();
        	ceServAgg.OF_Servizio__c = Servizio_Creation(Catalogo_Creation()).Id;
        	ceServAgg.Name = 'Estensione Impianto Cliente';
        	ceServAgg.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
            ceServAgg.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ceServAgg;
        //Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        OLO_ID__c oloId = new OLO_ID__c();
            oloId.OF_Olo_Id__c = accOLO.Id;
            oloId.Name = 'VF';
        insert oloId;
        //Creo il log di attivazione
        EOF_EAI_Service_Log__c sLogOLOSF = new EOF_EAI_Service_Log__c(
            RecordTypeId = sLogRType.get('OF_SA_CeD_FiberRequest'),
            OF_SA_Direzione_Flusso__c = 'OLO-SF',
            OF_SA_Metodo__c = 'OLO_ActivationSetup_OpenStream',
            EOF_Tipo_COmunicazione_String__c = 'OLO->SF - ActivationRequest',
            EOF_CODICE_OPERATORE__C = 'VF',
            EOF_CODICE_ORDINE_OLO__C = 'TEST_Act_'+String.valueOf(system.now()).right(8),
            EOF_DATA_NOTIFICA__C = OF_SA_CD_GE_Utils.StringTODate(String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00'), 
            EOF_ID_NOTIFICA__C = String.valueOf(System.now().getTime()),
            EOF_NOME_REFERENTE_TECNICO_OLO__C = 'Nome',
            EOF_COGNOME_REFERENTE_TECNICO_OLO__C = 'Cognome',
            EOF_TELEFONO_REFERENTE_TECNICO_OLO__C = '1234',
            EOF_EMAIL_REFERENTE_TECNICO_OLO__C = 'aaa@aa.com',
            EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C = '123456',
            EOF_NOME_CLIENTE__C = 'Nome',
            EOF_COGNOME_CLIENTE__C = 'Cognome',
            EOF_RECAPITO_TELEFONICO_CLIENTE_1__C = '12324',
            EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = '312312',
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__C = 'test',
            EOF_ORARIO_APPUNTAMENTO__C = '16:30:00',
            EOF_CODICE_PROGETTO_SPECIALE__c = '12',
            EOF_PROMOZIONE__C = '123',
            EOF_CLUSTER_PROMOZIONE__C = '123',
            EOF_ID_BUILDING__C = '12_058_058005_8000612172_31',
            EOF_SCALA_PALAZZINA__C = '',
            EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C='12323',
            EOF_RECAPITO_TEST_LINEA__C = '123123',
            EOF_ID_Pop__c = 'RMAPA',
            EOF_PROFILO__C = '45',
            EOF_Note__c = 'asdf',
            EOF_DATA_PREVISTA_ATTIVAZIONE__C = OF_SA_CD_GE_Utils.StringTODateNoTime('2018-12-24')
        );
        
        //Creo il case di attivazione
        Case c = new Case(); 
            c.RecordTypeId = casesRType.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c.EOF_Codice_Ordine_Olo__c = sLogOLOSF.EOF_CODICE_ORDINE_OLO__C;
            c.EOF_Codice_Operatore_WS__c = sLogOLOSF.EOF_CODICE_OPERATORE__C;           
            c.EOF_Data_Notifica__c = sLogOLOSF.EOF_DATA_NOTIFICA__C;
            c.EOF_Id_Notifica__c = sLogOLOSF.EOF_ID_NOTIFICA__C;                
            c.EOF_Data_Prevista_Attivazione__c = sLogOLOSF.EOF_DATA_PREVISTA_ATTIVAZIONE__C;
            c.EOF_Identificativo_del_POP__c= sLogOLOSF.EOF_ID_Pop__c;
            c.EOF_ID_Building_WS__c = sLogOLOSF.EOF_ID_BUILDING__C;
            c.subject = 'Richiesta Attivazione';
            c.status = 'Inviato';
            c.EOF_FASE__C = 'NA';
            c.PO_SA_Portale__c = false;
            c.OF_Bonifica_Locked_Row__c=true;
        insert c;
        //Lego il log al case
       	sLogOLOSF.Caso__c = c.Id;
        //Inserisco il log
        insert sLogOLOSF;
        //Inserisco le VLAN, Apparati e Serv.Aggiuntivi
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        Integer n = 1;
        //VLAN
        EOF_EAI_Service_Log__C vlan1 = new EOF_EAI_Service_Log__C();
            vlan1.recordtypeid = sLogRType.get('OF_SA_Vlan');
            vlan1.OF_SA_KIT_CONSEGNA_VLAN__C = 'TIS_MI_1';
            vlan1.OF_SA_USER_VLAN__C = '835';
            vlan1.OF_SA_SERVICE_VLAN__C = '100';
            vlan1.OF_SA_PROFILO_VLAN__C = 'AG11';
            vlan1.OF_SA_INFORMAZIONI_VLAN__C = '';
            vlan1.OF_SA_CUSTOMER_VLAN__C = '156';
            vlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = '1:1';
            vlan1.OF_SA_VLan_Log__c = sLogOLOSF.id;
            vlan1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(vlan1);
        n++;
        //Apparato
        EOF_EAI_Service_Log__C app1 = new EOF_EAI_Service_Log__C();
            app1.recordtypeid = sLogRType.get('OF_SA_Cpe');
            app1.EOF_TIPOLOGIA_APPARATO__C = 'SmartTV';
            app1.OF_SA_PASSWORD_APPARATO__C = '123';
            app1.OF_SA_AZIONE_APPARATO__C = '0';
            app1.OF_SA_Cpe_Log__c = sLogOLOSF.id;
            app1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(app1);
        n++;
        //Servizio Aggiuntivo
        EOF_EAI_Service_Log__C servAgg1 = new EOF_EAI_Service_Log__C();
            servAgg1.recordtypeid = sLogRType.get('OF_SA_Servizi_Aggiuntivi');
            servAgg1.OF_SA_NOME_SERVIZIO__c = 'Estensione Impianto Cliente';
            servAgg1.OF_SA_INFORMAZIONI_SERVIZIO__c = '0';
            servAgg1.OF_SA_servizi_Aggiuntivi_Log__c = sLogOLOSF.id;
            servAgg1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(servAgg1);
        //Inserisco la lista
        insert sLogList;
        //Inserisco l'id_servizio
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
        	g.OF_Case_Id__c=c.Id;
        insert g;
        //Inizia lo scope del test
        Test.startTest();
        //Setto il mock
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id, sLogOLOSF.Id);
        //Finisce lo scope del test
		Test.stopTest();
    }
    
    public static testMethod void test_OLO_AsyncActivation3(){
       //Recupero tutti i recordType dei case
        List<RecordType> casesLstRType = [SELECT developername, Id 
                                       	  FROM RecordType 
                                          WHERE sObjectType = 'Case' 
                                          AND isActive = true];
        //Popolo una map con tutti i recordType dei case avente come key il developername e come Value l'id
        Map<String,String> casesRType = new Map<String,String>();
        for(RecordType rt : casesLstRType){
            casesRType.put(rt.developername, rt.Id);
        }
        //Recupero tutti i recordType dei serviceLog
        List<RecordType> sLogLstRType = [SELECT developername, Id 
                                         FROM RecordType 
                  					     WHERE sObjectType = 'EOF_EAI_Service_Log__c' 
                                         AND isActive = true];
        //Popolo una map con tutti i recordType dei serviceLog avente come key il developername e come Value l'id
        Map<String,String> sLogRType = new Map<String,String>();
        for(RecordType rt : sLogLstRType){
            sLogRType.put(rt.developername, rt.Id);
        }
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
            Ele.OF_CodiceIstat__c = 'Test';
            Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
		OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
            corretto.OF_SA_Comune__c = 'Test';
            corretto.OF_SA_Stato_Building__c = 101;
            corretto.OF_SA_Pop__c ='test';
        insert corretto;
        //Inserisco il commercialElement del servizio aggiuntivo
        OF_CommercialElement__c ceServAgg = new OF_CommercialElement__c();
        	ceServAgg.OF_Servizio__c = Servizio_Creation(Catalogo_Creation()).Id;
        	ceServAgg.Name = 'Estensione Impianto Cliente';
        	ceServAgg.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
            ceServAgg.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ceServAgg;
        //Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        OLO_ID__c oloId = new OLO_ID__c();
            oloId.OF_Olo_Id__c = accOLO.Id;
            oloId.Name = 'VF';
        insert oloId;
        //Creo il log di attivazione
        EOF_EAI_Service_Log__c sLogOLOSF = new EOF_EAI_Service_Log__c(
            RecordTypeId = sLogRType.get('OF_SA_CeD_FiberRequest'),
            OF_SA_Direzione_Flusso__c = 'OLO-SF',
            OF_SA_Metodo__c = 'OLO_ActivationSetup_OpenStream',
            EOF_Tipo_COmunicazione_String__c = 'OLO->SF - ActivationRequest',
            EOF_CODICE_OPERATORE__C = 'VF',
            EOF_CODICE_ORDINE_OLO__C = 'TEST_Act_'+String.valueOf(system.now()).right(8),
            EOF_DATA_NOTIFICA__C = OF_SA_CD_GE_Utils.StringTODate(String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00'), 
            EOF_ID_NOTIFICA__C = String.valueOf(System.now().getTime()),
            EOF_NOME_REFERENTE_TECNICO_OLO__C = 'Nome',
            EOF_COGNOME_REFERENTE_TECNICO_OLO__C = 'Cognome',
            EOF_TELEFONO_REFERENTE_TECNICO_OLO__C = '1234',
            EOF_EMAIL_REFERENTE_TECNICO_OLO__C = 'aaa@aa.com',
            EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C = '123456',
           // EOF_NOME_CLIENTE__C = 'Nome',
            EOF_COGNOME_CLIENTE__C = 'Cognome',
            EOF_RECAPITO_TELEFONICO_CLIENTE_1__C = '12324',
            EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = '312312',
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__C = 'test',
            EOF_ORARIO_APPUNTAMENTO__C = '16:30:00',
            EOF_CODICE_PROGETTO_SPECIALE__c = '12',
            EOF_PROMOZIONE__C = '123',
            EOF_CLUSTER_PROMOZIONE__C = '123',
            EOF_ID_BUILDING__C = '12_058_058005_8000612172_31',
            EOF_SCALA_PALAZZINA__C = '',
            EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C='12323',
            EOF_RECAPITO_TEST_LINEA__C = '123123',
           // EOF_ID_Pop__c = 'test',
            EOF_PROFILO__C = '45',
            EOF_Note__c = 'asdf',
            EOF_DATA_PREVISTA_ATTIVAZIONE__C = OF_SA_CD_GE_Utils.StringTODateNoTime('2018-12-24')
        );
        
        //Creo il case di attivazione
        Case c = new Case(); 
            c.RecordTypeId = casesRType.get('EOF_SP_Caso_Attivazione_CeD');
            c.EOF_Codice_Ordine_Olo__c = sLogOLOSF.EOF_CODICE_ORDINE_OLO__C;
            c.EOF_Codice_Operatore_WS__c = sLogOLOSF.EOF_CODICE_OPERATORE__C;           
            c.EOF_Data_Notifica__c = sLogOLOSF.EOF_DATA_NOTIFICA__C;
            c.EOF_Id_Notifica__c = sLogOLOSF.EOF_ID_NOTIFICA__C;                
            c.EOF_Data_Prevista_Attivazione__c = sLogOLOSF.EOF_DATA_PREVISTA_ATTIVAZIONE__C;
            c.EOF_Identificativo_del_POP__c= sLogOLOSF.EOF_ID_Pop__c;
            c.EOF_ID_Building_WS__c = sLogOLOSF.EOF_ID_BUILDING__C;
            c.subject = 'Richiesta Attivazione';
            c.status = 'Inviato';
            c.EOF_FASE__C = 'NA';
            c.PO_SA_Portale__c = false;
            c.OF_Bonifica_Locked_Row__c=true;
        insert c;
        //Lego il log al case
       	sLogOLOSF.Caso__c = c.Id;
        //Inserisco il log
        insert sLogOLOSF;
        //Inserisco le VLAN, Apparati e Serv.Aggiuntivi
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        Integer n = 1;
        //VLAN
        EOF_EAI_Service_Log__C vlan1 = new EOF_EAI_Service_Log__C();
            vlan1.recordtypeid = sLogRType.get('OF_SA_Vlan');
            vlan1.OF_SA_KIT_CONSEGNA_VLAN__C = 'TIS_MI_1';
            vlan1.OF_SA_USER_VLAN__C = '835';
            vlan1.OF_SA_SERVICE_VLAN__C = '100';
            vlan1.OF_SA_PROFILO_VLAN__C = 'AG11';
            vlan1.OF_SA_INFORMAZIONI_VLAN__C = '';
            vlan1.OF_SA_CUSTOMER_VLAN__C = '156';
            vlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = '1:1';
            vlan1.OF_SA_VLan_Log__c = sLogOLOSF.id;
            vlan1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(vlan1);
        n++;
        //Apparato
        EOF_EAI_Service_Log__C app1 = new EOF_EAI_Service_Log__C();
            app1.recordtypeid = sLogRType.get('OF_SA_Cpe');
            app1.EOF_TIPOLOGIA_APPARATO__C = 'SmartTV';
            app1.OF_SA_PASSWORD_APPARATO__C = '123';
            app1.OF_SA_AZIONE_APPARATO__C = '0';
            app1.OF_SA_Cpe_Log__c = sLogOLOSF.id;
            app1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(app1);
        n++;
        //Servizio Aggiuntivo
       /* EOF_EAI_Service_Log__C servAgg1 = new EOF_EAI_Service_Log__C();
            servAgg1.recordtypeid = sLogRType.get('OF_SA_Servizi_Aggiuntivi');
            servAgg1.OF_SA_NOME_SERVIZIO__c = 'Estensione Impianto Cliente';
            servAgg1.OF_SA_INFORMAZIONI_SERVIZIO__c = '0';
            servAgg1.OF_SA_servizi_Aggiuntivi_Log__c = sLogOLOSF.id;
            servAgg1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(servAgg1);*/
        //Inserisco la lista
        insert sLogList;
        //Inserisco l'id_servizio
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
        	g.OF_Case_Id__c=c.Id;
        insert g;
        //Inizia lo scope del test
        Test.startTest();
        //Setto il mock
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id, sLogOLOSF.Id);
        //Finisce lo scope del test
		Test.stopTest();
    }

    public static testMethod void test_OLO_AsyncStatusUpdateA(){
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        insert slFiberReq;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncStatusUpdate(c,StatReq); 
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncStatusUpdate(c,StatReq);
        Test.stopTest(); 
    }
    
    

     public static testMethod void test_OLO_AsyncRescheduleA(){
        
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest r = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        insert slFiberReq;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        
        Test.startTest();
         Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncReschedule(c,r);
        Test.stopTest(); 
    }
    
    
    
    public static testMethod void test_OLO_AsyncDeactivationA(){
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                                   where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        slFiberReq.EOF_Nome_Cliente__c = 'Test';
        slFiberReq.EOF_COgnome_CLiente__c = 'Test';
        insert slFiberReq;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(accOLO,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation2(acc,accOLO,asset_1,ordine);
        
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
        
        
        
        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C = 'test';

        OF_SA_CD_GE_Utils.cliente = new Account();
        OF_SA_CD_GE_Utils.cliente.name='Marco';
        
        OF_SA_CD_GE_Utils.refTec = new contact();

        OF_SA_CD_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_CD_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncDeactivation(c.id, slFiberReq.id);
        
        Test.stopTest();         
    } 
   
    public static testMethod void test_OLO_AsyncDeactivationB(){
        
       List<RecordType> rtypes = [Select Name, Id From RecordType 
                                   where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        //slFiberReq.EOF_Nome_Cliente__c = 'Test';
        slFiberReq.EOF_COgnome_CLiente__c = 'Test';
        insert slFiberReq;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(accOLO,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation2(acc,accOLO,asset_1,ordine);
        
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
        
        
        
        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
       // OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C = 'test';

        OF_SA_CD_GE_Utils.cliente = new Account();
        OF_SA_CD_GE_Utils.cliente.name='Marco';
        
        OF_SA_CD_GE_Utils.refTec = new contact();

        OF_SA_CD_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_CD_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncDeactivation(c.id, slFiberReq.id);
        
        Test.stopTest();           
    }
    
    public static testMethod void test_OLO_AsyncChangeOrder_Method_1(){
        
         Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
         Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;  
        
        Asset ass = new Asset();
        ass.Status = 'Cessato';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;        
        insert ser;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.RecordtypeId = RecordTypeIdcom;
        istan.OF_Case__c = parentCase.Id;
        insert istan;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.name = 'Catalogo_001';
        catalogo.OF_DataInizioValidita__c = System.today() - 150;
        catalogo.OF_DataFineValidita__c = System.today() + 100;
        catalogo.OF_Attivo__c = true;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.Name = 'Open Stream CD';
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_DataInizioValidita__c = System.today() - 150;
        servizio.OF_DataFineValidita__c = System.today() + 100;
        servizio.OF_Attivo__c = true;
        insert servizio;
        
        contract c = new contract();
        c.accountId=acc.id;
        c.status='Attivo';
        insert c;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=c.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;     
		
        OF_CommercialElement__c istanElem = new OF_CommercialElement__c();
        istanElem.OF_Servizio__c = servizio.id;
        istanElem.Name='VLAN';
        istanElem.OF_DataInizioValidita__c = System.today() - 100;
        istanElem.OF_DataFineValidita__c = System.today();        
        insert istanElem;
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = parentCase.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(parentCase, notify);
        //OF_SA_CD_GE_Utils.slSFOLOResp=ser;
        //OF_SA_CD_GE_Utils.slSFOLO=ser;
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        OF_SA_CD_OLO_AsyncChecks olo1 = new OF_SA_CD_OLO_AsyncChecks();
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id, ser.id);
        
        Test.StopTest();}
    
    public static testMethod void test_OLO_AsyncChangeOrder_Method_2(){
        
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
        // Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;  
        
       
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;        
        insert ser;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.RecordtypeId = RecordTypeIdcom;
        istan.OF_Case__c = parentCase.Id;
        insert istan;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.name = 'Catalogo_001';
        catalogo.OF_DataInizioValidita__c = System.today() - 150;
        catalogo.OF_DataFineValidita__c = System.today() + 100;
        catalogo.OF_Attivo__c = true;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.Name = 'Open Stream CD';
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_DataInizioValidita__c = System.today() - 150;
        servizio.OF_DataFineValidita__c = System.today() + 100;
        servizio.OF_Attivo__c = true;
        insert servizio;
        
        contract c = new contract();
        c.accountId=acc.id;
        c.status='Attivo';
        insert c;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=c.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;     
		
        OF_CommercialElement__c istanElem = new OF_CommercialElement__c();
        istanElem.OF_Servizio__c = servizio.id;
        istanElem.Name='VLAN';
        istanElem.OF_DataInizioValidita__c = System.today() - 100;
        istanElem.OF_DataFineValidita__c = System.today();        
        insert istanElem;
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = parentCase.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(parentCase, notify);
        //OF_SA_CD_GE_Utils.slSFOLOResp=ser;
        //OF_SA_CD_GE_Utils.slSFOLO=ser;
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        OF_SA_CD_OLO_AsyncChecks olo1 = new OF_SA_CD_OLO_AsyncChecks();
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id, ser.id);
        
        Test.StopTest();
    }
    
    public static testMethod void test_OLO_AsyncChangeOrder_Method_3(){
        
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
         Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;  
        
        Asset ass = new Asset();
        ass.Status = 'In Modifica';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id; 
        ser.OF_SA_VLan_Log__c=ser.id;
        insert ser;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.RecordtypeId = RecordTypeIdcom;
        istan.OF_Case__c = parentCase.Id;
        insert istan;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.name = 'Catalogo_001';
        catalogo.OF_DataInizioValidita__c = System.today() - 150;
        catalogo.OF_DataFineValidita__c = System.today() + 100;
        catalogo.OF_Attivo__c = true;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.Name = 'Open Stream CD';
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_DataInizioValidita__c = System.today() - 150;
        servizio.OF_DataFineValidita__c = System.today() + 100;
        servizio.OF_Attivo__c = true;
        insert servizio;
        
        contract c = new contract();
        c.accountId=acc.id;
        c.status='Attivo';
        insert c;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=c.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;     
		
        OF_CommercialElement__c istanElem = new OF_CommercialElement__c();
        istanElem.OF_Servizio__c = servizio.id;
        istanElem.Name='VLAN';
        istanElem.OF_DataInizioValidita__c = System.today() - 100;
        istanElem.OF_DataFineValidita__c = System.today();        
        insert istanElem;
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = parentCase.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(parentCase, notify);
        //OF_SA_CD_GE_Utils.slSFOLOResp=ser;
        //OF_SA_CD_GE_Utils.slSFOLO=ser;
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        OF_SA_CD_OLO_AsyncChecks olo1 = new OF_SA_CD_OLO_AsyncChecks();
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id, ser.id);
        
        Test.StopTest();
    }
    
    public static testMethod void test_OLO_AsyncChangeOrder_Method_4(){
        
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
         Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;  
        
        Asset ass = new Asset();
        ass.Status = 'In Modifica';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id; 
        //ser.OF_SA_VLan_Log__c=ser.id;
        insert ser;
        
        EOF_EAI_Service_Log__c ser2 = new EOF_EAI_Service_Log__c();
        ser2.EOF_PROFILO__c = '17';
        ser2.EOF_ID_Notifica__c = '1529661331590';
        ser2.Caso__c=parentCase.Id; 
        ser2.OF_SA_VLan_Log__c=ser.id;
        insert ser2;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.RecordtypeId = RecordTypeIdcom;
        istan.OF_Case__c = parentCase.Id;
        insert istan;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.name = 'Catalogo_001';
        catalogo.OF_DataInizioValidita__c = System.today() - 150;
        catalogo.OF_DataFineValidita__c = System.today() + 100;
        catalogo.OF_Attivo__c = true;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.Name = 'Open Stream CD';
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_DataInizioValidita__c = System.today() - 150;
        servizio.OF_DataFineValidita__c = System.today() + 100;
        servizio.OF_Attivo__c = true;
        insert servizio;
        
        contract c = new contract();
        c.accountId=acc.id;
        c.status='Attivo';
        insert c;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=c.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;     
		
        OF_CommercialElement__c istanElem = new OF_CommercialElement__c();
        istanElem.OF_Servizio__c = servizio.id;
        istanElem.Name='VLAN';
        istanElem.OF_DataInizioValidita__c = System.today() - 100;
        istanElem.OF_DataFineValidita__c = System.today();        
        insert istanElem;
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = parentCase.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(parentCase, notify);
        //OF_SA_CD_GE_Utils.slSFOLOResp=ser;
        //OF_SA_CD_GE_Utils.slSFOLO=ser;
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        OF_SA_CD_OLO_AsyncChecks olo1 = new OF_SA_CD_OLO_AsyncChecks();
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id, ser.id);
        
        Test.StopTest();
    }
   /*  public static testMethod void test_OLO_AsyncChangeOrder_Method_5(){
        
        //Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
         Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
         
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                                   where sObjectType='Order' and isActive=true];
        
        Map<String,Id> OrderRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        {
            system.debug('listofordertypes:'+rtypes);
            OrderRecordTypes.put(rt.Name,rt.Id);
           // OF_CO_GE_Utils.RtMap.put(rt.Name,rt.Id);
        }
         OF_CO_GE_Utils.RtMap=OrderRecordTypes;
         
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
         List<RecordType> rtypes1 = [Select Name, Id From RecordType 
                                   where sObjectType='Case' and isActive=true];
        
        Map<String,Id> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes1)
        {
            system.debug('listofordertypes:'+rtypes);
            CaseRecordTypes.put(rt.Name,rt.Id);
           // OF_CO_GE_Utils.RtMap.put(rt.Name,rt.Id);
        }
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = 'test1';
        parentCase.RecordtypeId = CaseRecordTypes.get('EOF Caso Cessazione OPENSTREAM CD');
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;  
         
         system.debug('checking case:'+parentCase);
        
        Asset ass = new Asset();
        ass.Status = 'Sospeso';
        ass.name = 'test1';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id; 
        //ser.OF_SA_VLan_Log__c=ser.id;
        insert ser;
        
        EOF_EAI_Service_Log__c ser2 = new EOF_EAI_Service_Log__c();
        ser2.EOF_PROFILO__c = '17';
        ser2.EOF_ID_Notifica__c = '1529661331590';
        ser2.Caso__c=parentCase.Id; 
        ser2.OF_SA_VLan_Log__c=ser.id;
        insert ser2;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.RecordtypeId = RecordTypeIdcom;
        istan.OF_Case__c = parentCase.Id;
        insert istan;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.name = 'Catalogo_001';
        catalogo.OF_DataInizioValidita__c = System.today() - 150;
        catalogo.OF_DataFineValidita__c = System.today() + 100;
        catalogo.OF_Attivo__c = true;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.Name = 'Open Stream CD';
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_DataInizioValidita__c = System.today() - 150;
        servizio.OF_DataFineValidita__c = System.today() + 100;
        servizio.OF_Attivo__c = true;
        insert servizio;
        
        contract c = new contract();
        c.accountId=acc.id;
        c.status='Attivo';
        insert c;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=c.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;     
		
        OF_CommercialElement__c istanElem = new OF_CommercialElement__c();
        istanElem.OF_Servizio__c = servizio.id;
        istanElem.Name='VLAN';
        istanElem.OF_DataInizioValidita__c = System.today() - 100;
        istanElem.OF_DataFineValidita__c = System.today();        
        insert istanElem;
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = parentCase.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(parentCase, notify);
        //OF_SA_CD_GE_Utils.slSFOLOResp=ser;
        //OF_SA_CD_GE_Utils.slSFOLO=ser;
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        OF_SA_CD_OLO_AsyncChecks olo1 = new OF_SA_CD_OLO_AsyncChecks();
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id, ser.id);
        
        Test.StopTest();
    }*/
}
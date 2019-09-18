@isTest
public class OF_GestioneServiziAttiviNEW_TEST {
    @testSetup
    static void createData() {
        /**Creazione Account**/
        List < Account > listAccount = new List < Account > ();
        listAccount = OF_AreaGeograficaUtilityTest.createAccountOLO();
        /**Creazione Servizi**/
        List < OF_Servizio__c > listServizi = new List < OF_Servizio__c > ();
        listServizi = OF_AreaGeograficaUtilityTest.createServizi();
        /****Creazione Contratti****/
        Map < ID, String > mapAcc = new Map < ID, String > ();
        List < Contract > listContract = new List < Contract > ();
        OF_AreaGeograficaUtilityTest.getMappa(listAccount); //getMappa
        listContract = OF_AreaGeograficaUtilityTest.createContract(listAccount);
        /**Creazione Associazione Contratti-Servizi**/
        List < OF_ContrattoServizio__c > listContrServ = new List < OF_ContrattoServizio__c > ();
        listContrServ = OF_AreaGeograficaUtilityTest.createContractService(listContract, listServizi, mapAcc);

        /**Creazione Listini**/
        List < OF_CommercialElement__c > listCommercial = new List < OF_CommercialElement__c > ();
        List < OF_BillingElement__c > listBillingElement = new List < OF_BillingElement__c > ();
        List < OF_ServizioBillingElement__c > listServiziBillingElement = new List < OF_ServizioBillingElement__c > ();

        listCommercial = OF_AreaGeograficaUtilityTest.createCommercialElement(listServizi);
        listBillingElement = createBillingElement(listCommercial);
        listServiziBillingElement = OF_AreaGeograficaUtilityTest.createServiziBillingElement(listBillingElement, listContrServ);
        createListini(listServiziBillingElement);

        //Creazione custom setting configurazione
        OF_Configurazioni__c CustSett = new OF_Configurazioni__c();
        CustSett = OF_AreaGeograficaUtilityTest.CustomSetting1();

        Map < String, Id > mpRT = new Map < String, Id > ();
        for (RecordType rt: [SELECT Id, DeveloperName FROM Recordtype]) {
            mpRT.put(rt.DeveloperName, rt.Id);
        }

        Case oCase = MethodCases(listContract[0], null, null);

        List < order > ordList = new List < Order > ();
        order o = new order();
        o.recordtypeID = mpRT.get('OF_INORDER');
        o.EffectiveDate = Date.newInstance(2016, 1, 1);
        o.Status = 'Aperto';
        o.AccountId = listAccount[0].id; //acc.id;
        o.OF_TipologiaDiServizio__c = 'Attivo';
        o.PO_IsFromOpportunity__c = true;
        o.Name = 'test1';
        o.OF_CaseNome__c = oCase.CaseNumber;
        o.OF_IDOrdineEOF__c = oCase.Codice_Ordine_EOF__c;
        // o.OF_CaseNome__c=oCase.id;
        // o.OF_CaseNome__c = caseFormula.get(o.OF_CaseID__c).casenumber;
        //o.OF_IDOrdineEOF__c = caseFormula.get(o.OF_CaseID__c).Codice_Ordine_EOF__c;
        insert o;

        MethodCE(oCase);


    }

    static testmethod Map < String, String > RecordType() {
        //Record Type
        List < RecordType > rtypes = [Select Name, Id From RecordType where(sObjectType = 'Case'
            OR sObjectType = 'Asset'
            OR sObjectType = 'Order'
            OR sObjectType = 'OF_CommercialElementIstanziato__c') and isActive = true];

        Map < String, String > RecordType = new Map < String, String > {};

        for (RecordType rt: rtypes)
            RecordType.put(rt.Name, rt.Id);

        return RecordType;
    }

    //Tipo di Operazione:Attivazione
    //                   Cessazione
    public static
    case MethodCases(contract contr, String TipoOperazione, ID AssetId) {

        Map < String, String > RecordTypeMap = RecordType();

        case c = new
        case ();
        if (TipoOperazione == 'Attivazione') {
            c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
            c.OF_IDContratto__c = contr.id;
            c.Status = 'Espletato';

        }
        if (TipoOperazione == 'Cessazione') {
            c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
            c.Status = 'Ricevuto';
            c.AssetId = AssetId;
        }
        //c.status = 'Espletato';
        c.EOF_Fase__c = 'NA';
        c.EOF_Account_OLO__c = contr.AccountId;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_ID_Building_WS__c = '123456789';
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020, 1, 1);
        c.OF_Esito_Consegna_Apparato__c = '1';
        c.OF_SA_ID_Servizio__c = 'AAAA';
        insert c;

        return c;

    }

    //Tipo di Operazione:Attivazione
    //                   Cessazione
    public static order MethodOrder(
        case c, String TipoOperazione, String idRisorsa, ID assid) {
        Map < String, String > RecordTypeMap = RecordType();

        Order o = new Order();
        if (TipoOperazione == 'Attivazione') o.RecordTypeId = RecordTypeMap.get('INORDER');
        if (TipoOperazione == 'Cessazione') {
            o.RecordTypeId = RecordTypeMap.get('OUTORDER');
            o.OF_IDRisorsa__c = idRisorsa;
            o.OF_Asset__c = assid;
        }
        o.EffectiveDate = Date.newInstance(2016, 1, 1);
        o.Status = 'Aperto';
        o.AccountId = c.EOF_Account_OLO__c;
        o.Name = 'test1';
        o.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
        o.contractID = c.OF_IDContratto__c;
        o.OF_CaseID__c = c.id;
        o.OF_TipologiaDiServizio__c = 'Attivo';
        o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
        o.OF_IDOrdineEOF__c = c.id;
        o.OF_IDServizio__c = c.OF_SA_ID_Servizio__c;
        o.OF_ClusterPromozione__c = 'test';
        o.OF_Profilo__c = 'Canone';
        o.OF_Promozione__c = 'test';
        o.OF_CodiceProgettoSpeciale__c = 'test';
        o.OF_ClusterPromozione__c = 'test';
        o.OF_TipologiaApparato__c = 'test';
        insert o;

        c.OF_Order__c = o.id;
        update c;

        return o;
    }


    public static void MethodCE(
        case c) {
        Map < String, String > RecordTypeMap = RecordType();

        List < OF_CommercialElement__c > listaCommercialElement = [SELECT Id, Name FROM OF_CommercialElement__c where OF_Servizio__r.Name = 'Open Stream'];
        Map < String, Id > ceNameId = new Map < String, Id > ();
        for (OF_CommercialElement__c ce: listaCommercialElement) {
            ceNameId.put(ce.Name.ToUpperCase(), ce.Id);
        }

        List < OF_CommercialElementIstanziato__c > ceiList = new List < OF_CommercialElementIstanziato__c > ();

        OF_CommercialElementIstanziato__c ceiSA = new OF_CommercialElementIstanziato__c(
            recordtypeid = RecordTypeMap.get('Servizi Aggiuntivi'),
            OF_NOME_SERVIZIO__c = 'RIBALTAMENTO IMPIANTO',
            OF_INFORMAZIONI_SERVIZIO__c = '1',
            OF_Case__c = c.Id,
            OF_CommercialElement__c = ceNameId.get('Ribaltamento Impianto'),
            OF_ESITOSERVIZIO__c = '0'
        );
        ceiList.add(ceiSA);

        OF_CommercialElementIstanziato__c ceiCPE = new OF_CommercialElementIstanziato__c(
            recordtypeid = RecordTypeMap.get('CPE'),
            OF_TIPOLOGIAAPPARATO__C = 'Apparato1',
            OF_PASSWORD_APPARATO__C = 'Password',
            OF_AZIONEAPPARATO__C = '0',
            OF_Case__c = c.Id,
            OF_CommercialElement__c = ceNameId.get('CPE'),
            OF_EsitoConsegnaApparato__c = '1'
        );
        ceiList.add(ceiCPE);

        OF_CommercialElementIstanziato__c ceiCPE1 = new OF_CommercialElementIstanziato__c(
            recordtypeid = RecordTypeMap.get('CPE'),
            OF_TIPOLOGIAAPPARATO__C = 'Apparato1',
            OF_PASSWORD_APPARATO__C = 'Password',
            OF_AZIONEAPPARATO__C = '0',
            OF_Case__c = c.Id,
            OF_CommercialElement__c = ceNameId.get('CPE'),
            OF_EsitoConsegnaApparato__c = '4'
        );
        ceiList.add(ceiCPE1);

        OF_CommercialElementIstanziato__c ceiVLAN = new OF_CommercialElementIstanziato__c(
            recordtypeid = RecordTypeMap.get('VLAN'),
            OF_KITCONSEGNAVLAN__C = 'test',
            OF_USERVLAN__C = 'Test',
            OF_SERVICEVLAN__C = 'Test',
            OF_PROFILOVLAN__C = 'Test',
            OF_INFORMAZIONIVLAN__C = 'Test',
            OF_CUSTOMERVLAN__C = 'Test',
            OF_MODELLODISERVIZIOVLAN__C = 'Test',
            OF_Case__c = c.Id,
            OF_CommercialElement__c = ceNameId.get('VLAN')
        );
        ceiList.add(ceiVLAN);
            
         OF_CommercialElementIstanziato__c ceiPassivi = new OF_CommercialElementIstanziato__c(
            recordtypeid = RecordTypeMap.get('CPE Passivi'),
            OF_KITCONSEGNAVLAN__C = 'test',
            OF_USERVLAN__C = 'Test',
            OF_SERVICEVLAN__C = 'Test',
            OF_PROFILOVLAN__C = 'Test',
            OF_INFORMAZIONIVLAN__C = 'Test',
            OF_CUSTOMERVLAN__C = 'Test',
            OF_MODELLODISERVIZIOVLAN__C = 'Test',
            OF_Case__c = c.Id,
            OF_CommercialElement__c = ceNameId.get('VLAN')
        );
        ceiList.add(ceiPassivi);


        insert ceiList;
    }

    public static void createListini(List < OF_ServizioBillingElement__c > listServizioBilling) {

        String ListRecordTypeAttId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();

        List < OF_Listino__c > listListini = new List < OF_Listino__c > ();

        Integer i = 0;
        for (OF_ServizioBillingElement__c item: listServizioBilling) {
            OF_Listino__c listinoItem = new OF_Listino__c();
            if (item.OF_ServizioNome__c == 'Open Stream') {

                listinoItem.RecordTypeId = ListRecordTypeAttId;
                listinoItem.Name = item.Name;
                listinoItem.OF_Attivo__c = true;
                listinoItem.OF_DataInizioValidita__c = Date.newInstance(1990, 04, 24);
                listinoItem.OF_DataFineValidita__c = Date.newInstance(2020, 04, 24);
                listinoItem.OF_IDContract__c = item.OF_Contract__c;
                listinoItem.OF_ServizioBillingElement__c = item.Id;
                listinoItem.OF_Promozione__c = 'test';
                listinoItem.OF_CodiceProgettoSpeciale__c = 'test';
                listinoItem.OF_ClusterPromozione__c = 'test';
                listinoItem.OF_TipologiaApparato__c = 'test';
                listinoItem.OF_ListinoDefault__c = true;

                listListini.add(listinoItem);
                i++;
                if (i == 10) break;
            }
        }
        if (listListini != null && listListini.size() > 0)
            insert listListini;
    }

    public static List < OF_BillingElement__c > createBillingElement(List < OF_CommercialElement__c > listaCommercial) {

        set < id > idCE = new set < id > ();
        for (OF_CommercialELement__c CE: listaCommercial) {
            idCE.add(CE.id);
        }
        list < OF_CommercialElement__c > CommList = [select id, OF_servizio__r.name from OF_CommercialElement__c where id IN: idCE];

        List < OF_BillingElement__c > listBilling = new List < OF_BillingElement__c > ();
        Integer index = 0;
        for (OF_CommercialElement__c item: CommList) {

            if (item.OF_servizio__r.name == 'Open Stream') {
                OF_BillingElement__c billElem = new OF_BillingElement__c();
                if (index == 0)
                    billElem.Name = 'Canone';
                else if (index == 1)
                    billElem.Name = 'Contributo Consegna';
                else if (index == 2)
                    billElem.Name = 'Contributo istallazione';
                else if (index == 3)
                    billElem.Name = 'Contributo attivazione';
                else if (index == 5)
                    billElem.Name = 'Contributo Disattivazione';
                else if (index == 6)
                    billElem.Name = 'Canone Premium';
                else
                    billElem.Name = 'Contributo Consegna';

                billElem.OF_Attivo__c = true;
                billElem.OF_CommercialElement__c = item.Id;
                billElem.OF_DataInizioValidita__c = Date.newInstance(2016, 1, 1);
                billElem.OF_DataFineValidita__c = Date.newInstance(2099, 12, 31);
                listBilling.add(billElem);
                index++;
            }
        }
        if (listBilling != null && listBilling.size() > 0) insert listBilling;
        return listBilling;
    }

    static testmethod void MyUnitTestTryCatch() {
        test.starttest();
        OF_UtilitiesServiziAttivi obj = new OF_UtilitiesServiziAttivi();
        obj.getCEListini(null, null, null, null, null, null);
        obj.createCEIstOrder(null, null, null, null);
        obj.FilterCEAttivi(null, null);
        obj.CEListini(null, null, null);
        obj.AttivazioneCE(null, null, null);
        obj.CEMap(null);
        obj.getMultipleCEPerListino(null);
        obj.getOrderCatalogoProdottiOLO(null);
        obj.FilterCEAttiviCessazioneCPE(null, null);
        test.stoptest();
    }
   

    @isTest
    static void testCreatePriceBookEntry_ServizioBase() {

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
        Test.startTest();
        Set < Id > contattoSet = new Set < Id > ();

        for (contract testContract: [Select Id From Contract]) { // This will only fetch data created in test method
            contattoSet.add(testContract.Id);
        }

        Map < Id, Order > orderMap = new Map < Id, Order > ((List < Order > ) QueryUtil.query('Select * From Order'));
        Map < Id, Asset > asstMap = new Map < Id, Asset > ((List < Asset > ) QueryUtil.query('Select * From Asset'));

        Map < ID, ID > idOrderIdContract = new Map < Id, Id > ();
        Map < ID, ID > AssetOrderMap = new Map < Id, Id > ();

        OF_GestioneServiziAttiviNEW obj = new OF_GestioneServiziAttiviNEW();
        obj.CreatePriceBookEntry_ServizioBase(orderMap, contattoSet, idOrderIdContract, AssetOrderMap, asstMap, 1);
        Test.stopTest();


    }

    @isTest
    static void testgetOrderCatalogoProdottiOLO() {
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
        Test.startTest();

        Map < Id, Order > orderMap = new Map < Id, Order > ((List < Order > ) QueryUtil.query('Select * From Order'));
        OF_GestioneServiziAttiviNEW obj = new OF_GestioneServiziAttiviNEW();
        obj.getOrderCatalogoProdottiOLO(orderMap);

        Test.stopTest();
    }

    @isTest
    static void testGetOrderSetIdListini() {
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
        test.startTest();
        Map < Id, Order > orderMap = new Map < Id, Order > ((List < Order > ) QueryUtil.query('Select * From Order'));
        List < Id > orderIdList = new List < Id > (orderMap.keySet());
        Map < ID, List < OF_Listino__c >> mpx = new Map < ID, List < OF_Listino__c >> ();

        List < OF_Listino__c > ofList = (List < OF_Listino__c > ) QueryUtil.query('Select * From OF_Listino__c');
        mpx.put(ofList[0].Id, ofList);

        map < id, map < id, list < OF_Listino__c >>> OrderCEListini = new map < id, map < id, list < OF_Listino__c >>> ();
        OrderCEListini.put(orderIdList[0], mpx);

        OF_GestioneServiziAttiviNEW.getOrderSetIdListini(OrderCEListini);
        OF_GestioneServiziAttiviNEW.getOrderSetIdListini(null);

        test.stopTest();


    }

    @isTest
    static void testAssociazioneBEDissativazione_CEIst() {
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
        test.startTest();

        Map < Id, Asset > asstMap = new Map < Id, Asset > ((List < Asset > ) QueryUtil.query('Select * From Asset'));
        OF_GestioneServiziAttiviNEW obj = new OF_GestioneServiziAttiviNEW();
        obj.associazioneBEDissativazione_CEIst(asstMap);
        obj.associazioneBEDissativazione_CEIst(null);

        test.stopTest();


    }


    @isTest
    static void testAssociazioneBEDissativazione_CEIstNull() {
        OF_GestioneServiziAttiviNEW obj = new OF_GestioneServiziAttiviNEW();
        obj.associazioneBEDissativazione_CEIst(null);
    }

    @isTest
    static void testOrdineBECE_Attivi() {
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
        test.startTest();
        Map < ID, Set < Id >> mpx = new Map < ID, Set < Id >> ();
        Map < Id, Order > orderMap = new Map < Id, Order > ((List < Order > ) QueryUtil.query('Select * From Order'));
        List < Id > orderIdList = new List < Id > (orderMap.keySet());

        Map < ID, OF_Listino__c > ofListMap = new Map < ID, OF_Listino__c > ((List < OF_Listino__c > ) QueryUtil.query('Select * From OF_Listino__c'));

        Set < Id > listinoSet = new Set < Id > ();
        for (OF_Listino__c listino: ofListMap.values()) {
            listinoSet.add(listino.ID);
        }

        mpx.put(orderIdList[0], listinoSet);


        Set < Id > totalListIni = new Set < ID > ();
        Map < ID, Set < String >> OrderCE = new MAp < Id, Set < String >> ();
        OF_GestioneServiziAttiviNEW obj = new OF_GestioneServiziAttiviNEW();
        obj.OrdineBECE_Attivi(mpx, listinoSet, ofListMap, OrderCE, OrderCE, orderMap, 1);
        Test.stopTest();
    }

	public static testmethod void testmethod1() {

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
                OF_Servizio__c serv = [select id from OF_Servizio__c where Name = 'Open Stream' limit 1];
        OF_ContrattoServizio__c contServ = [select id,OF_Contract__c,OF_Servizio__c
                                            from OF_ContrattoServizio__c
                                            where OF_Servizio__c = : serv.Id limit 1 ];
        
        List<Contract> contr = [select id,StartDate,AccountId from contract
                                where id =: contServ.OF_Contract__c ];
        
        OF_CatalogoCommerciale__c  cc = new OF_CatalogoCommerciale__c();
        cc.Name= ' test ';
        cc.OF_Attivo__c = true;
        cc.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        cc.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        insert cc;
        
        OF_Servizio__c servizo =  new OF_Servizio__c();
        servizo.Name = 'Open Stream';
        servizo.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        servizo.OF_DataInizioValidita__c=Date.newInstance(2110,1,1);
        servizo.OF_CatalogoCommerciale__c = cc.Id;
        insert servizo;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.OF_Attivo__c = true; 
        ce.OF_DataFineValidita__c	=Date.newInstance(2111,12,31);
        ce.OF_DataInizioValidita__c =Date.newInstance(2110,1,1);
        ce.OF_Servizio__c  = servizo.Id;
        insert ce;
        
        OF_BillingElement__c  be = new OF_BillingElement__c();
        be.Name = 'test';
        be.OF_Attivo__c = true;
        be.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        be.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        be.OF_CommercialElement__c = ce.Id;
        insert be;
        
        OF_ServizioBillingElement__c sbe = new OF_ServizioBillingElement__c();
        sbe.Name = 'Canone';
        sbe.OF_BillingElement__c	= be.Id;
        sbe.OF_Contract__c = contr[0].Id;
        sbe.OF_Servizio__c = servizo.Id;
        insert sbe;
        
        OF_Listino__c listino = new OF_Listino__c();
        listino.Name = 'Listino2';
        //listino.RecordTypeId = RecordTypes.get(sbe.OF_ServizioNome__c);
        listino.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        listino.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        listino.OF_ServizioBillingElement__c = sbe.Id;
        listino.OF_IDContract__c = contr[0].Id;
        listino.OF_ListinoDefault__c = true;
        listino.OF_TipologiaApparato__c = 'test';
        listino.OF_ProgettoSpeciale__c = 'Test';
        listino.OF_Attivo__c=true;
        listino.OF_CodiceProgettoSpeciale__c = 'test';
        listino.OF_ClusterPromozione__c='test';
        listino.OF_Promozione__c = 'test';
        
        insert listino;
        
        PriceBook2 pb = new PriceBook2();
        pb.Name= 'test';
        pb.PO_Commercial_element__c = ce.Id;
        pb.PO_Contratto__c = contr[0].Id;
        pb.OF_Listino__c = listino.Id;
        pb.OF_Master__c = true;
        insert pb;
        
        Account acc = [select id from account where Recordtype.Name = 'OLO' limit 1 ];
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        insert asst2;
        
		Map<ID,PriceBook2>  mapPriceBook = new Map<ID,PriceBook2>();
        mapPriceBook.put(pb.Id, pb);

        test.StartTest();

        Set < Id > contattoSet = new Set < Id > ();

        for (contract testContract: [Select Id From Contract]) { // This will only fetch data created in test method
            contattoSet.add(testContract.Id);
        }
        OF_GestioneServiziAttiviNEW.getContractListini(contattoSet, 'Open Stream');
        OF_GestioneServiziAttiviNEW.getContractListini(contattoSet, null);
        OF_GestioneServiziAttiviNEW.getContractListini(null,null);
        /*OF_GestioneServiziAttiviNEW.getMappaOrder();
        OF_GestioneServiziAttiviNEW.getContractListini();*/

        List < OF_CommercialElementIstanziato__c > commercialElementList = [Select Id, recordtypeId, OF_Asset__c, OF_IDRisorsa__c, OF_VLAN__c, OF_Stato__c, OF_DataAttivazione__c From OF_CommercialElementIstanziato__c];

        Order o = new Order();
        o.accountId=acc.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        o.OF_CodiceProgettoSpeciale__c = 'test';
        o.OF_ClusterPromozione__c = 'test';
        o.OF_TipologiaApparato__c = 'test';
        o.OF_Promozione__c = 'test';
        insert o;
        
        List < Order > ord = [Select Id From Order where Id =: o.Id];

        Map < Id, List < OF_CommercialElementIstanziato__c >> listVal = new Map < Id, List < OF_CommercialElementIstanziato__c >> ();

        listVal.put(ord[0].Id, commercialElementList);

		Map<ID,Map<ID,PriceBook2>> mappa = new Map<ID,Map<ID,PriceBook2>>();
        mappa.put(ord[0].Id, mapPriceBook);
        
        Map<ID,List<OF_CommercialElementIstanziato__c>> mce= new Map<ID,List<OF_CommercialElementIstanziato__c>>();
        mce.put(ce.Id, commercialElementList);
        
        Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> mappaMultipleCE = new Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> ();
        mappaMultipleCE.put(ord[0].Id, mce);

        MAp < Id, Asset > asstMap = new Map < Id, Asset > ([Select Id, Name, EOF_ID_Risorsa__c From Asset]);

        List < Id > assetIdList = new List < Id > (asstMap.keySet());
        Map < Id, Id > OrderAsset = new Map < Id, Id > ();
        OrderAsset.put(ord[0].Id, assetIdList[0]);
        
        Map<ID,ID> idOrderIdContract = new Map<ID,ID>();
        idOrderIdContract.put(ord[0].Id,contr[0].Id);

        Map<ID,Order> orderID = new Map<ID,Order> ();
        orderID.put(ord[0].Id, ord[0]);
        
        Map<ID,ID> AssetOrder = new Map<ID,ID>();
        AssetOrder.put(ord[0].Id,asst2.Id);
        
        Map<ID,Asset> MapAsset = new Map<ID,Asset> ();
        MapAsset.put(asst2.Id,asst2);
        
        set<Id> idlistino= new set<Id>();
        idlistino.add(listino.Id);
        
        Map<Id,Set<ID>> OrderSetidListini = new Map<Id,Set<ID>>();
        OrderSetidListini.put(ord[0].Id,idlistino);
        
        Map<id,OF_Listino__c> mapListini = new Map<id,OF_Listino__c> ();
        mapListini.put(listino.Id, listino);
     
        Map < Id, Order > orderMap = new Map < Id, Order > ((List < Order > ) QueryUtil.query('Select * From Order'));
        List < Id > orderIdList = new List < Id > (orderMap.keySet());
        Map < ID, List < OF_Listino__c >> mpx = new Map < ID, List < OF_Listino__c >> ();

        List < OF_Listino__c > ofList = (List < OF_Listino__c > ) QueryUtil.query('Select * From OF_Listino__c');
        mpx.put(ofList[0].Id, ofList);

        map < id, map < id, list < OF_Listino__c >>> OrderCEListini = new map < id, map < id, list < OF_Listino__c >>> ();
        OrderCEListini.put(orderIdList[0], mpx);

        OF_GestioneServiziAttiviNEW.getOrderSetIdListini(OrderCEListini);
        OF_GestioneServiziAttiviNEW.getOrderSetIdListini(null);
            
        OF_GestioneServiziAttiviNEW obj = new OF_GestioneServiziAttiviNEW();
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,1,'INSERT_OUTORDER');
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,0,'INSERT_OUTORDER');
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,1,'UPDATE_OUTORDER');
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,0,'UPDATE_OUTORDER');
        obj.VLANIstanziazione(listVal, OrderAsset, asstMap);
        obj.CreazionePriceBookEntry_Attivi(mappa,OrderAsset,0,true);
        obj.CreazionePriceBookEntry_Attivi(mappa,OrderAsset,1,true);
        obj.CreazionePriceBookEntry_AttiviCPE(mappa,AssetOrder,0,mappaMultipleCE,true);
        obj.CreazionePriceBookEntry_AttiviCPE(mappa,AssetOrder,1,mappaMultipleCE,false);
        obj.associazioneBEDissativazione_CEIst( MapAsset);
        obj.associazioneBEDissativazione_CEIst( null);
        obj.getMappaPriceBook2Product2_Attivi(OrderSetidListini,orderID,AssetOrder,MapAsset,mapListini , 0);
        obj.getMappaPriceBook2Product2_Attivi(OrderSetidListini,orderID,AssetOrder,MapAsset,mapListini , 1);
        obj.filtroListiniAttivi(OrderSetidListini , orderID);
        OF_GestioneServiziAttiviNEW.getContractListiniAttivi(null , null , null , 1);
        /*OF_GestioneServiziAttiviNEW.CreatePriceBookEntry_ServizioBase();
        OF_GestioneServiziAttiviNEW.getOrderSetIdListini(map<id,map<id,list<OF_Listino__c>>> OrderCEListini );
        OF_GestioneServiziAttiviNEW.getMappaPriceBook2Product2_Attivi();
        OF_GestioneServiziAttiviNEW.getContractListiniAttivi();
        OF_GestioneServiziAttiviNEW.filtroListiniAttivi();
        OF_GestioneServiziAttiviNEW.CreazioneCE_Attivazione();
        OF_GestioneServiziAttiviNEW.associazioneBEDissativazione_CEIst();
        OF_GestioneServiziAttiviNEW.getOrderCatalogoProdottiOLO();
        OF_GestioneServiziAttiviNEW.CreazionePriceBookEntry_AttiviCPE(mappa,AssetOrder,0,mappaMultipleCE,true); */
        test.StopTest();
    }

    public static testmethod void testmethod2() {

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
                OF_Servizio__c serv = [select id from OF_Servizio__c where Name = 'Open Stream' limit 1];
        OF_ContrattoServizio__c contServ = [select id,OF_Contract__c,OF_Servizio__c
                                            from OF_ContrattoServizio__c
                                            where OF_Servizio__c = : serv.Id limit 1 ];
        
        List<Contract> contr = [select id,StartDate,AccountId from contract
                                where id =: contServ.OF_Contract__c ];
        
        OF_CatalogoCommerciale__c  cc = new OF_CatalogoCommerciale__c();
        cc.Name= ' test ';
        cc.OF_Attivo__c = true;
        cc.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        cc.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        insert cc;
        
        OF_Servizio__c servizo =  new OF_Servizio__c();
        servizo.Name = 'Open Stream';
        servizo.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        servizo.OF_DataInizioValidita__c=Date.newInstance(2110,1,1);
        servizo.OF_CatalogoCommerciale__c = cc.Id;
        insert servizo;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.OF_Attivo__c = true; 
        ce.OF_DataFineValidita__c	=Date.newInstance(2111,12,31);
        ce.OF_DataInizioValidita__c =Date.newInstance(2110,1,1);
        ce.OF_Servizio__c  = servizo.Id;
        insert ce;
        
        OF_BillingElement__c  be = new OF_BillingElement__c();
        be.Name = 'test';
        be.OF_Attivo__c = true;
        be.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        be.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        be.OF_CommercialElement__c = ce.Id;
        insert be;
        
        OF_ServizioBillingElement__c sbe = new OF_ServizioBillingElement__c();
        sbe.Name = 'Canone';
        sbe.OF_BillingElement__c	= be.Id;
        sbe.OF_Contract__c = contr[0].Id;
        sbe.OF_Servizio__c = servizo.Id;
        insert sbe;
        
        OF_Listino__c listino = new OF_Listino__c();
        listino.Name = 'Listino2';
        //listino.RecordTypeId = RecordTypes.get(sbe.OF_ServizioNome__c);
        listino.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        listino.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        listino.OF_ServizioBillingElement__c = sbe.Id;
        listino.OF_IDContract__c = contr[0].Id;
        listino.OF_ListinoDefault__c = true;
        listino.OF_TipologiaApparato__c = 'test';
        listino.OF_ProgettoSpeciale__c = 'Test';
        listino.OF_Attivo__c=true;
        listino.OF_CodiceProgettoSpeciale__c = 'test';
        listino.OF_ClusterPromozione__c='test';
        listino.OF_Promozione__c = 'test';
        
        insert listino;
        
        PriceBook2 pb = new PriceBook2();
        pb.Name= 'test';
        pb.PO_Commercial_element__c = ce.Id;
        pb.PO_Contratto__c = contr[0].Id;
        pb.OF_Listino__c = listino.Id;
        pb.OF_Master__c = true;
        insert pb;
        
        Account acc = [select id from account where Recordtype.Name = 'OLO' limit 1 ];
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        insert asst2;
        
		Map<ID,PriceBook2>  mapPriceBook = new Map<ID,PriceBook2>();
        mapPriceBook.put(pb.Id, pb);

        test.StartTest();

        Set < Id > contattoSet = new Set < Id > ();

        for (contract testContract: [Select Id From Contract]) { // This will only fetch data created in test method
            contattoSet.add(testContract.Id);
        }
        OF_GestioneServiziAttiviNEW.getContractListini(contattoSet, 'Open Stream');
        OF_GestioneServiziAttiviNEW.getContractListini(contattoSet, null);
        OF_GestioneServiziAttiviNEW.getContractListini(null,null);
        /*OF_GestioneServiziAttiviNEW.getMappaOrder();
        OF_GestioneServiziAttiviNEW.getContractListini();*/

        List < OF_CommercialElementIstanziato__c > commercialElementList = [Select Id, recordtypeId, OF_Asset__c, OF_IDRisorsa__c, OF_VLAN__c, OF_Stato__c, OF_DataAttivazione__c From OF_CommercialElementIstanziato__c];

        Order o = new Order();
        o.accountId=acc.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        o.OF_CodiceProgettoSpeciale__c = 'test';
        o.OF_ClusterPromozione__c = 'test';
        o.OF_TipologiaApparato__c = 'test';
        o.OF_Promozione__c = 'test';
        insert o;
        
        List < Order > ord = [Select Id From Order where Id =: o.Id];

        Map < Id, List < OF_CommercialElementIstanziato__c >> listVal = new Map < Id, List < OF_CommercialElementIstanziato__c >> ();

        listVal.put(ord[0].Id, commercialElementList);

		Map<ID,Map<ID,PriceBook2>> mappa = new Map<ID,Map<ID,PriceBook2>>();
        mappa.put(ord[0].Id, mapPriceBook);
        
        Map<ID,List<OF_CommercialElementIstanziato__c>> mce= new Map<ID,List<OF_CommercialElementIstanziato__c>>();
        mce.put(ce.Id, commercialElementList);
        
        Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> mappaMultipleCE = new Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> ();
        mappaMultipleCE.put(ord[0].Id, mce);

        MAp < Id, Asset > asstMap = new Map < Id, Asset > ([Select Id, Name, EOF_ID_Risorsa__c From Asset]);

        List < Id > assetIdList = new List < Id > (asstMap.keySet());
        Map < Id, Id > OrderAsset = new Map < Id, Id > ();
        OrderAsset.put(ord[0].Id, assetIdList[0]);
        
        Map<ID,ID> idOrderIdContract = new Map<ID,ID>();
        idOrderIdContract.put(ord[0].Id,contr[0].Id);

        Map<ID,Order> orderID = new Map<ID,Order> ();
        orderID.put(ord[0].Id, ord[0]);
        
        Map<ID,ID> AssetOrder = new Map<ID,ID>();
        AssetOrder.put(ord[0].Id,asst2.Id);
        
        Map<ID,Asset> MapAsset = new Map<ID,Asset> ();
        MapAsset.put(asst2.Id,asst2);
        
        set<Id> idlistino= new set<Id>();
        idlistino.add(listino.Id);
        
        Map<Id,Set<ID>> OrderSetidListini = new Map<Id,Set<ID>>();
        OrderSetidListini.put(ord[0].Id,idlistino);
        
        Map<id,OF_Listino__c> mapListini = new Map<id,OF_Listino__c> ();
        mapListini.put(listino.Id, listino);
     
        Map < Id, Order > orderMap = new Map < Id, Order > ((List < Order > ) QueryUtil.query('Select * From Order'));
        List < Id > orderIdList = new List < Id > (orderMap.keySet());
        Map < ID, List < OF_Listino__c >> mpx = new Map < ID, List < OF_Listino__c >> ();

        List < OF_Listino__c > ofList = (List < OF_Listino__c > ) QueryUtil.query('Select * From OF_Listino__c');
        mpx.put(ofList[0].Id, ofList);

        map < id, map < id, list < OF_Listino__c >>> OrderCEListini = new map < id, map < id, list < OF_Listino__c >>> ();
        OrderCEListini.put(orderIdList[0], mpx);

        OF_GestioneServiziAttiviNEW obj = new OF_GestioneServiziAttiviNEW();
       
       Map<ID,Set<String>> idOrder =  new Map<ID,Set<String>>();
       
       idOrder.put(ord[0].Id,new Set<String>{'VLAN','CPE','Servizi Aggiuntivi'});
        
        obj.CreazioneCE_Attivazione(AssetOrder,idOrder,MapAsset,1);
        obj.associazioneBEDissativazione_CEIst(MapAsset);
        obj.associazioneBEDissativazione_CEIst(null);
        
        test.StopTest();
    }
    


	public static testmethod void testmethod3() {

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
                OF_Servizio__c serv = [select id from OF_Servizio__c where Name = 'Open Stream' limit 1];
        OF_ContrattoServizio__c contServ = [select id,OF_Contract__c,OF_Servizio__c
                                            from OF_ContrattoServizio__c
                                            where OF_Servizio__c = : serv.Id limit 1 ];
        
        List<Contract> contr = [select id,StartDate,AccountId from contract
                                where id =: contServ.OF_Contract__c ];
        
        OF_CatalogoCommerciale__c  cc = new OF_CatalogoCommerciale__c();
        cc.Name= ' test ';
        cc.OF_Attivo__c = true;
        cc.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        cc.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        insert cc;
        
        OF_Servizio__c servizo =  new OF_Servizio__c();
        servizo.Name = 'Open Stream';
        servizo.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        servizo.OF_DataInizioValidita__c=Date.newInstance(2110,1,1);
        servizo.OF_CatalogoCommerciale__c = cc.Id;
        insert servizo;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.OF_Attivo__c = true; 
        ce.OF_DataFineValidita__c	=Date.newInstance(2111,12,31);
        ce.OF_DataInizioValidita__c =Date.newInstance(2110,1,1);
        ce.OF_Servizio__c  = servizo.Id;
        insert ce;
        
        OF_BillingElement__c  be = new OF_BillingElement__c();
        be.Name = 'test';
        be.OF_Attivo__c = true;
        be.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        be.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        be.OF_CommercialElement__c = ce.Id;
        insert be;
        
        OF_ServizioBillingElement__c sbe = new OF_ServizioBillingElement__c();
        sbe.Name = 'Canone Premium';
        sbe.OF_BillingElement__c	= be.Id;
        sbe.OF_Contract__c = contr[0].Id;
        sbe.OF_Servizio__c = servizo.Id;
        insert sbe;
        
        OF_Listino__c listino = new OF_Listino__c();
        listino.Name = 'Listino2';
        //listino.RecordTypeId = RecordTypes.get(sbe.OF_ServizioNome__c);
        listino.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        listino.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        listino.OF_ServizioBillingElement__c = sbe.Id;
        listino.OF_IDContract__c = contr[0].Id;
        listino.OF_ListinoDefault__c = true;
        listino.OF_TipologiaApparato__c = 'test';
        listino.OF_ProgettoSpeciale__c = 'Test';
        listino.OF_Attivo__c=true;
        listino.OF_CodiceProgettoSpeciale__c = 'test';
        listino.OF_ClusterPromozione__c='test';
        listino.OF_Promozione__c = 'test';
        
        insert listino;
        
        PriceBook2 pb = new PriceBook2();
        pb.Name= 'test';
        pb.PO_Commercial_element__c = ce.Id;
        pb.PO_Contratto__c = contr[0].Id;
        pb.OF_Listino__c = listino.Id;
        pb.OF_Master__c = true;
        insert pb;
        
        Account acc = [select id from account where Recordtype.Name = 'OLO' limit 1 ];
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        insert asst2;
        
		Map<ID,PriceBook2>  mapPriceBook = new Map<ID,PriceBook2>();
        mapPriceBook.put(pb.Id, pb);

        test.StartTest();

        Set < Id > contattoSet = new Set < Id > ();

        for (contract testContract: [Select Id From Contract]) { // This will only fetch data created in test method
            contattoSet.add(testContract.Id);
        }
        OF_GestioneServiziAttiviNEW.getContractListini(contattoSet, 'Open Stream');
        OF_GestioneServiziAttiviNEW.getContractListini(contattoSet, null);
        OF_GestioneServiziAttiviNEW.getContractListini(null,null);
        /*OF_GestioneServiziAttiviNEW.getMappaOrder();
        OF_GestioneServiziAttiviNEW.getContractListini();*/

        List < OF_CommercialElementIstanziato__c > commercialElementList = [Select Id, recordtypeId, OF_Asset__c, OF_IDRisorsa__c, OF_VLAN__c, OF_Stato__c, OF_DataAttivazione__c From OF_CommercialElementIstanziato__c];

        Order o = new Order();
        o.accountId=acc.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        o.OF_CodiceProgettoSpeciale__c = 'test';
        o.OF_ClusterPromozione__c = 'test';
        o.OF_TipologiaApparato__c = 'test';
        o.OF_Promozione__c = 'test';
        insert o;
        
        List < Order > ord = [Select Id From Order where Id =: o.Id];

        Map < Id, List < OF_CommercialElementIstanziato__c >> listVal = new Map < Id, List < OF_CommercialElementIstanziato__c >> ();

        listVal.put(ord[0].Id, commercialElementList);

		Map<ID,Map<ID,PriceBook2>> mappa = new Map<ID,Map<ID,PriceBook2>>();
        mappa.put(ord[0].Id, mapPriceBook);
        
        Map<ID,List<OF_CommercialElementIstanziato__c>> mce= new Map<ID,List<OF_CommercialElementIstanziato__c>>();
        mce.put(ce.Id, commercialElementList);
        
        Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> mappaMultipleCE = new Map<ID,Map<ID,List<OF_CommercialElementIstanziato__c>>> ();
        mappaMultipleCE.put(ord[0].Id, mce);

        MAp < Id, Asset > asstMap = new Map < Id, Asset > ([Select Id, Name, EOF_ID_Risorsa__c From Asset]);

        List < Id > assetIdList = new List < Id > (asstMap.keySet());
        Map < Id, Id > OrderAsset = new Map < Id, Id > ();
        OrderAsset.put(ord[0].Id, assetIdList[0]);
        
        Map<ID,ID> idOrderIdContract = new Map<ID,ID>();
        idOrderIdContract.put(ord[0].Id,contr[0].Id);

        Map<ID,Order> orderID = new Map<ID,Order> ();
        orderID.put(ord[0].Id, ord[0]);
        
        Map<ID,ID> AssetOrder = new Map<ID,ID>();
        AssetOrder.put(ord[0].Id,asst2.Id);
        
        Map<ID,Asset> MapAsset = new Map<ID,Asset> ();
        MapAsset.put(asst2.Id,asst2);
        
        set<Id> idlistino= new set<Id>();
        idlistino.add(listino.Id);
        
        Map<Id,Set<ID>> OrderSetidListini = new Map<Id,Set<ID>>();
        OrderSetidListini.put(ord[0].Id,idlistino);
        
        Map<id,OF_Listino__c> mapListini = new Map<id,OF_Listino__c> ();
        mapListini.put(listino.Id, listino);
     
        Map < Id, Order > orderMap = new Map < Id, Order > ((List < Order > ) QueryUtil.query('Select * From Order'));
        List < Id > orderIdList = new List < Id > (orderMap.keySet());
        Map < ID, List < OF_Listino__c >> mpx = new Map < ID, List < OF_Listino__c >> ();

        List < OF_Listino__c > ofList = (List < OF_Listino__c > ) QueryUtil.query('Select * From OF_Listino__c');
        mpx.put(ofList[0].Id, ofList);

        map < id, map < id, list < OF_Listino__c >>> OrderCEListini = new map < id, map < id, list < OF_Listino__c >>> ();
        OrderCEListini.put(orderIdList[0], mpx);

        OF_GestioneServiziAttiviNEW.getOrderSetIdListini(OrderCEListini);
        OF_GestioneServiziAttiviNEW.getOrderSetIdListini(null);
            
        OF_GestioneServiziAttiviNEW obj = new OF_GestioneServiziAttiviNEW();
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,1,'INSERT_OUTORDER');
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,0,'INSERT_OUTORDER');
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,1,'UPDATE_OUTORDER');
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,0,'UPDATE_OUTORDER');
        obj.VLANIstanziazione(listVal, OrderAsset, asstMap);
        obj.CreazionePriceBookEntry_Attivi(mappa,OrderAsset,0,true);
        obj.CreazionePriceBookEntry_Attivi(mappa,OrderAsset,1,true);
        obj.CreazionePriceBookEntry_AttiviCPE(mappa,AssetOrder,0,mappaMultipleCE,true);
        obj.CreazionePriceBookEntry_AttiviCPE(mappa,AssetOrder,1,mappaMultipleCE,false);
        obj.associazioneBEDissativazione_CEIst( MapAsset);
        obj.associazioneBEDissativazione_CEIst( null);
        obj.getMappaPriceBook2Product2_Attivi(OrderSetidListini,orderID,AssetOrder,MapAsset,mapListini , 0);
        obj.getMappaPriceBook2Product2_Attivi(OrderSetidListini,orderID,AssetOrder,MapAsset,mapListini , 1);
        obj.filtroListiniAttivi(OrderSetidListini , orderID);
        OF_GestioneServiziAttiviNEW.getContractListiniAttivi(null , null , null , 1);
        /*OF_GestioneServiziAttiviNEW.CreatePriceBookEntry_ServizioBase();
        OF_GestioneServiziAttiviNEW.getOrderSetIdListini(map<id,map<id,list<OF_Listino__c>>> OrderCEListini );
        OF_GestioneServiziAttiviNEW.getMappaPriceBook2Product2_Attivi();
        OF_GestioneServiziAttiviNEW.getContractListiniAttivi();
        OF_GestioneServiziAttiviNEW.filtroListiniAttivi();
        OF_GestioneServiziAttiviNEW.CreazioneCE_Attivazione();
        OF_GestioneServiziAttiviNEW.associazioneBEDissativazione_CEIst();
        OF_GestioneServiziAttiviNEW.getOrderCatalogoProdottiOLO();
        OF_GestioneServiziAttiviNEW.CreazionePriceBookEntry_AttiviCPE(mappa,AssetOrder,0,mappaMultipleCE,true); */
        test.StopTest();
    }
    
    /* public static testMethod void CodeCoverage(){
         test.startTest();
         OF_GestioneServiziAttiviNEW.CodeCoverage(2);
         test.stopTest();
     }*/
}
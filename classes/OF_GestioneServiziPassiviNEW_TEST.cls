@isTest
public with sharing class OF_GestioneServiziPassiviNEW_TEST {
    
    @testSetup
    static void CreateDataTest()
    {
        /**Creazione Account**/
        List<Account> listAccount = OF_AreaGeograficaUtilityTest.createAccountOLO();
        Map<ID,String> mappaAccount = OF_AreaGeograficaUtilityTest.getMappa( listAccount );
        /**Creazione Contratti**/
        List<Contract> listaContratti = OF_AreaGeograficaUtilityTest.createContract( listAccount );
        /**Creazione Servizi**/
        List<OF_Servizio__c> listaServizi = OF_AreaGeograficaUtilityTest.createServizi();
        /**Creazione Contratti-Servizi**/
        List<OF_ContrattoServizio__c> ContractServiceList = OF_AreaGeograficaUtilityTest.createContractService(listaContratti,listaServizi,mappaAccount);
        
        /**CREAZIONE LISTINI**/
        List<OF_CommercialElement__c> listCE = OF_AreaGeograficaUtilityTest.createCommercialElement(listaServizi);
        
        List<OF_BillingElement__c>  listBE = OF_AreaGeograficaUtilityTest.createBillingElement( listCE );
        List<OF_ServizioBillingElement__c> listServBE = OF_AreaGeograficaUtilityTest.createServiziBillingElement( listBE , ContractServiceList );
        
        OF_AreaGeograficaUtilityTest.createListini(listServBE);
        
    }
    
    /**************************Metodi Helper*************************************************/  
    public static case MethodCases(contract contr, integer num)
    {
        
        Map<String,String> RecordTypeMap = RecordType();
        
        case c = new case();
        
        if(num ==0){
            
            c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
            c.status = 'Espletato';
            c.EOF_Fase__c = 'NA';
            c.EOF_Account_OLO__c = contr.AccountId;
            c.EOF_Codice_Ordine_OLO__c = 'OLO0001x';
            c.EOF_Tipologia_Servizio__c = '1';
            c.EOF_Order_Manager__c = true;
            c.EOF_ID_Building_WS__c = '123456789';
            c.EOF_Identificativo_del_POP__c = 'PG_01';
            c.OF_IDContratto__c = contr.id;
            c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
            c.OF_Esito_Consegna_Apparato__c = '1';
            c.OF_SA_ID_Servizio__c = 'AAAA';
            insert c;
        }
        if(num ==1){
            
            c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
            c.status = 'Espletato';
            c.EOF_Fase__c = 'NA';
            c.EOF_Account_OLO__c = contr.AccountId;
            c.EOF_Codice_Ordine_OLO__c = 'OLO0001y';
            c.EOF_Tipologia_Servizio__c = '1';
            c.EOF_Order_Manager__c = true;
            c.EOF_ID_Building_WS__c = '123456789';
            c.EOF_Identificativo_del_POP__c = 'PG_01';
            c.OF_IDContratto__c = contr.id;
            c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
            c.OF_Esito_Consegna_Apparato__c = '1';
            c.OF_SA_ID_Servizio__c = 'AAAA';
            insert c;          
        }
        return c;
        
    }
    
    public static case MethodCases1(contract contr, integer num)
    {
        
        Map<String,String> RecordTypeMap = RecordType();
        
        case c = new case();
        
        if(num == 0){                  
            c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
            c.status = 'Espletato';
            c.EOF_Fase__c = 'NA';
            c.EOF_Account_OLO__c = contr.AccountId;
            c.EOF_Codice_Ordine_OLO__c = 'OLO0001y';
            c.EOF_Tipologia_Servizio__c = '1';
            c.EOF_Order_Manager__c = true;
            c.EOF_ID_Building_WS__c = '123456789';
            c.EOF_Identificativo_del_POP__c = 'PG_01';
            c.OF_IDContratto__c = contr.id;
            c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
            c.OF_Esito_Consegna_Apparato__c = '2';
            c.OF_SA_ID_Servizio__c = 'AAAA';
            insert c;
        }
        if(num ==1){
            c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
            c.status = 'Espletato';
            c.EOF_Fase__c = 'NA';
            c.EOF_Account_OLO__c = contr.AccountId;
            c.EOF_Codice_Ordine_OLO__c = 'OLO0001x';
            c.EOF_Tipologia_Servizio__c = '1';
            c.EOF_Order_Manager__c = true;
            c.EOF_ID_Building_WS__c = '123456789';
            c.EOF_Identificativo_del_POP__c = 'PG_01';
            c.OF_IDContratto__c = contr.id;
            c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
            c.OF_Esito_Consegna_Apparato__c = '2';
            c.OF_SA_ID_Servizio__c = 'AAAA';
            insert c;          
        }
        
        return c;
        
    }
    
    public static order MethodOrder(case c , String tipologiaApparato , String RecordTypeName ,String IDRisorsa)
    {
        Map<String,String> RecordTypeMap = OF_GestioneServiziPassiviNEW_TEST.RecordType();
        
        Order o = new Order();
        o.recordtypeID = RecordTypeMap.get( RecordTypeName );
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = c.EOF_Account_OLO__c;
        o.Name ='test1';
        o.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c; 
        o.contractID = c.OF_IDContratto__c;
        o.OF_TipologiaDiServizio__c = 'Passivo';
        o.OF_CaseID__c = c.id;
        // o.OF_TipologiaDiServizio__c = 'Passivo';
        o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
        o.OF_IDOrdineEOF__c = c.id;
        o.OF_IDServizio__c = c.OF_SA_ID_Servizio__c;
        o.OF_TipologiaApparato__c = tipologiaApparato;
        
        if( RecordTypeName == 'OUTORDER') o.OF_IDRisorsa__c = IDRisorsa;
        insert o;
        return o;
    }
    
    static Map<String,String> RecordType()
    { 
        //Record Type
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Asset' OR sObjectType='Order' OR sObjectType = 'OF_CommercialElementIstanziato__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
            
            for(RecordType rt: rtypes) RecordType.put(rt.Name,rt.Id);
        
        return RecordType;
    }
    
    static void createCatalogoApparatiOLO( Account acc )
    {
        OF_CatalogoApparati__c ApparatiOLO = new OF_CatalogoApparati__c();
        ApparatiOLO.OF_OLO__c = acc.Id;
        ApparatiOLO.OF_TipologiaApparato__c='apparato3';
        insert ApparatiOLO;
    }
    
    
    
    public static testMethod void Method2()
    {
        OF_CatalogoCommerciale__c  cc = new OF_CatalogoCommerciale__c();
        cc.Name= ' test ';
        cc.OF_Attivo__c = true;
        cc.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        cc.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        insert cc;
        
        OF_Servizio__c servizo =  new OF_Servizio__c();
        servizo.Name = 'GPON Passiva';
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
        
        //Creating OF_ServizioBillingElement__c
        OF_Servizio__c serv = [select id from OF_Servizio__c where Name = 'GPON Passiva' limit 1];
        OF_ContrattoServizio__c contServ = [select id,OF_Contract__c,OF_Servizio__c
                                            from OF_ContrattoServizio__c
                                            where OF_Servizio__c = : serv.Id limit 1 ];
        
        List<Contract> contr = [select id,StartDate,AccountId from contract
                                where id =: contServ.OF_Contract__c ];
        
        OF_ServizioBillingElement__c sbe = new OF_ServizioBillingElement__c();
        sbe.Name = 'test';
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
        listino.OF_TipologiaApparato__c = 'Appa1';
        listino.OF_ProgettoSpeciale__c = 'Test';
        listino.OF_Attivo__c=true;
        insert listino;
        
        //Creating order 
        Case c1 = OF_GestioneServiziPassiviNEW_TEST.MethodCases( contr[0],1 );
        Order ordine2 = OF_GestioneServiziPassiviNEW_TEST.MethodOrder( c1 ,'apparato3','INORDER','null');
        // OF_Configurazioni__c CustSett = new OF_Configurazioni__c();
        // CustSett = OF_AreaGeograficaUtilityTest.CustomSetting1();
        
        ordine2.Status = 'Chiuso';
        ordine2.OF_Esito__c = 'OK';
        ordine2.OF_IDRisorsa__c = 'Test1234';
        ordine2.OF_TipologiaDiServizio__c = 'Passivo';
        ordine2.OF_TipologiaApparato__c = 'UPPERCASE';
        ordine2.OF_ProgettoSpeciale__c = 'Test';
        update ordine2;
        
        //Creating asset
        //Case c = OF_GestioneServiziPassiviNEW_TEST.MethodCases( contr[0] );
        Account acc = [select id from account limit 1 ];
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        insert asst2;
        
        Map<ID,ID> idOrderIdContract = new Map<Id,Id>();
        idOrderIdContract.put(ordine2.Id,contr[0].Id); 
        
        Map<ID,Order> orderID = new Map<ID,Order>();
        orderID.put(ordine2.Id,ordine2);
        
        Map<ID,ID> AssetOrder = new Map<ID,ID>();
        AssetOrder.put(asst2.Id,ordine2.Id);
        
        Map<ID,Asset> MapAsset= new Map<ID,Asset>();
        MapAsset.put(asst2.Id, asst2); 
        
        PriceBook2 pb = new PriceBook2();
        pb.Name= 'test';
        pb.PO_Commercial_element__c = ce.Id;
        pb.PO_Contratto__c = contr[0].Id;
        pb.OF_Listino__c = listino.Id;
        pb.OF_Master__c = true;
        insert pb;
        
        Map<ID,PriceBook2> mpPb2= new Map<ID,PriceBook2>();
        mpPb2.put(pb.Id, pb);
        Map<ID,Map<ID,PriceBook2>> mappa = new Map<ID,Map<ID,PriceBook2>> ();        
        mappa.put(asst2.Id, mpPb2);
        Map<ID,ID> OrderAsset = new Map<ID,ID>();
        OrderAsset.put(ordine2.Id,asst2.Id);
        
        set<string> setforidOrder = new set<string>();
        setforidOrder.add('CPE_Passivi');
        setforidOrder.add('OF_VLAN');
        Map<ID,Set<String>> idOrder = new Map<ID,Set<String>>();
        idOrder.put(ordine2.Id, setforidOrder);
        
        test.startTest();
        OF_GestioneServiziPassiviNEW obj = new OF_GestioneServiziPassiviNEW();
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,0);
        obj.associazioneBEDissativazione_CEIst(MapAsset);
        obj.CreazionePriceBookEntry (mappa, OrderAsset,1);
        obj.CreazioneCE_Attivazione(OrderAsset,idOrder,MapAsset,0);
        test.stopTest();
    }
    
    public static testMethod void Method3()
    {
        OF_CatalogoCommerciale__c  cc = new OF_CatalogoCommerciale__c();
        cc.Name= ' test ';
        cc.OF_Attivo__c = true;
        cc.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        cc.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        insert cc;
        
        OF_Servizio__c servizo =  new OF_Servizio__c();
        servizo.Name = 'GPON Passiva';
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
        
        //Creating OF_ServizioBillingElement__c
        OF_Servizio__c serv = [select id from OF_Servizio__c where Name = 'GPON Passiva' limit 1];
        OF_ContrattoServizio__c contServ = [select id,OF_Contract__c,OF_Servizio__c
                                            from OF_ContrattoServizio__c
                                            where OF_Servizio__c = : serv.Id limit 1 ];
        
        List<Contract> contr = [select id,StartDate,AccountId from contract
                                where id =: contServ.OF_Contract__c ];
        
        OF_ServizioBillingElement__c sbe = new OF_ServizioBillingElement__c();
        sbe.Name = 'test';
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
        listino.OF_TipologiaApparato__c = 'Appa1';
        listino.OF_ProgettoSpeciale__c = 'Test';
        listino.OF_Attivo__c=true;
        insert listino;
        
        //Creating order 
        Case c1 = OF_GestioneServiziPassiviNEW_TEST.MethodCases( contr[0],1 );
        Order ordine2 = OF_GestioneServiziPassiviNEW_TEST.MethodOrder( c1 ,'apparato3','INORDER','null');
        // OF_Configurazioni__c CustSett = new OF_Configurazioni__c();
        // CustSett = OF_AreaGeograficaUtilityTest.CustomSetting1();
        
        ordine2.Status = 'Chiuso';
        ordine2.OF_Esito__c = 'OK';
        ordine2.OF_IDRisorsa__c = 'Test1234';
        ordine2.OF_TipologiaDiServizio__c = 'Passivo';
        ordine2.OF_TipologiaApparato__c = 'lowercase';
        ordine2.OF_ProgettoSpeciale__c = 'Test';
        update ordine2;
        
        //Creating asset
        //Case c = OF_GestioneServiziPassiviNEW_TEST.MethodCases( contr[0] );
        Account acc = [select id from account limit 1 ];
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst2.OF_OrdineID__c = ordine2.Id;
        asst2.EOF_ID_Risorsa__c='Test';
        insert asst2;
        
        Map<ID,ID> idOrderIdContract = new Map<Id,Id>();
        idOrderIdContract.put(ordine2.Id,contr[0].Id); 
        
        Map<ID,Order> orderID = new Map<ID,Order>();
        orderID.put(ordine2.Id,ordine2);
        
        Map<ID,ID> AssetOrder = new Map<ID,ID>();
        AssetOrder.put(asst2.Id,ordine2.Id);
        
        Map<ID,Asset> MapAsset= new Map<ID,Asset>();
        MapAsset.put(asst2.Id, asst2);
        
        PriceBook2 pb = new PriceBook2();
        pb.Name= 'test';
        pb.PO_Commercial_element__c = ce.Id;
        pb.PO_Contratto__c = contr[0].Id;
        pb.OF_Listino__c = listino.Id;
        pb.OF_Master__c = true;
        insert pb;
        
        Map<ID,PriceBook2> mpPb2= new Map<ID,PriceBook2>();
        mpPb2.put(pb.Id, pb);
        Map<ID,Map<ID,PriceBook2>> mappa = new Map<ID,Map<ID,PriceBook2>> ();        
        mappa.put(asst2.Id, mpPb2);
        Map<ID,ID> OrderAsset = new Map<ID,ID>();
        OrderAsset.put(ordine2.Id,asst2.Id);
        
        Map<Id,Map<Id,PriceBook2>> OrdinePriceProductFilter = new Map<Id,Map<Id,PriceBook2>>();
        OrdinePriceProductFilter.put(ordine2.Id,mpPb2);
        set<string> setforidOrder = new set<string>();
        setforidOrder.add('CPE_Passivi');
        setforidOrder.add('OF_VLAN');
        Map<ID,Set<String>> idOrder = new Map<ID,Set<String>>();
        idOrder.put(ordine2.Id, setforidOrder);
        
        test.startTest();
        OF_GestioneServiziPassiviNEW obj = new OF_GestioneServiziPassiviNEW();
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,1);
        obj.associazioneBEDissativazione_CEIst(MapAsset);
        obj.CreazionePriceBookEntry (mappa, OrderAsset,0);
        obj.CreazioneCE_Attivazione(OrderAsset,idOrder,MapAsset,0);
        test.stopTest();
    }
    
    
       public static testMethod void Method4()
    {
        OF_CatalogoCommerciale__c  cc = new OF_CatalogoCommerciale__c();
        cc.Name= ' test ';
        cc.OF_Attivo__c = true;
        cc.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
        cc.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
        insert cc;
        
        OF_Servizio__c servizo =  new OF_Servizio__c();
        servizo.Name = 'GPON Passiva';
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
        
        //Creating OF_ServizioBillingElement__c
        OF_Servizio__c serv = [select id from OF_Servizio__c where Name = 'GPON Passiva' limit 1];
        OF_ContrattoServizio__c contServ = [select id,OF_Contract__c,OF_Servizio__c
                                            from OF_ContrattoServizio__c
                                            where OF_Servizio__c = : serv.Id limit 1 ];
        
        List<Contract> contr = [select id,StartDate,AccountId from contract
                                where id =: contServ.OF_Contract__c ];
        
        OF_ServizioBillingElement__c sbe = new OF_ServizioBillingElement__c();
        sbe.Name = 'test';
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
        listino.OF_TipologiaApparato__c = 'Appa1';
        listino.OF_ProgettoSpeciale__c = 'Test';
        listino.OF_Attivo__c=true;
        insert listino;
        
        //Creating order 
        Case c1 = OF_GestioneServiziPassiviNEW_TEST.MethodCases( contr[0],1 );
        Order ordine2 = OF_GestioneServiziPassiviNEW_TEST.MethodOrder( c1 ,'apparato3','INORDER','null');
        // OF_Configurazioni__c CustSett = new OF_Configurazioni__c();
        // CustSett = OF_AreaGeograficaUtilityTest.CustomSetting1();
        
        ordine2.Status = 'Chiuso';
        ordine2.OF_Esito__c = 'OK';
        ordine2.OF_IDRisorsa__c = 'Test1234';
        ordine2.OF_TipologiaDiServizio__c = 'Passivo';
        ordine2.OF_TipologiaApparato__c = 'lowercase';
        ordine2.OF_ProgettoSpeciale__c = 'Test';
        update ordine2;
        
        //Creating asset
        //Case c = OF_GestioneServiziPassiviNEW_TEST.MethodCases( contr[0] );
        Account acc = [select id from account limit 1 ];
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst2.OF_OrdineID__c = ordine2.Id;
        asst2.EOF_ID_Risorsa__c='Test';
        insert asst2;
        
        Map<ID,ID> idOrderIdContract = new Map<Id,Id>();
        idOrderIdContract.put(ordine2.Id,contr[0].Id); 
        
        Map<ID,Order> orderID = new Map<ID,Order>();
        orderID.put(ordine2.Id,ordine2);
        
        Map<ID,ID> AssetOrder = new Map<ID,ID>();
        AssetOrder.put(asst2.Id,ordine2.Id);
        
        Map<ID,Asset> MapAsset= new Map<ID,Asset>();
        MapAsset.put(asst2.Id, asst2);
        
        PriceBook2 pb = new PriceBook2();
        pb.Name= 'test';
        pb.PO_Commercial_element__c = ce.Id;
        pb.PO_Contratto__c = contr[0].Id;
        pb.OF_Listino__c = listino.Id;
        pb.OF_Master__c = true;
        insert pb;
        
        Map<ID,PriceBook2> mpPb2= new Map<ID,PriceBook2>();
        mpPb2.put(pb.Id, pb);
        Map<ID,Map<ID,PriceBook2>> mappa = new Map<ID,Map<ID,PriceBook2>> ();        
        mappa.put(asst2.Id, mpPb2);
        Map<ID,ID> OrderAsset = new Map<ID,ID>();
        OrderAsset.put(ordine2.Id,asst2.Id);
        
        Map<Id,Map<Id,PriceBook2>> OrdinePriceProductFilter = new Map<Id,Map<Id,PriceBook2>>();
        OrdinePriceProductFilter.put(ordine2.Id,mpPb2);
        set<string> setforidOrder = new set<string>();
        setforidOrder.add('CPE_Passivi');
        setforidOrder.add('OF_VLAN');
        Map<ID,Set<String>> idOrder = new Map<ID,Set<String>>();
        idOrder.put(ordine2.Id, setforidOrder);
        
        test.startTest();
        OF_GestioneServiziPassiviNEW obj = new OF_GestioneServiziPassiviNEW();
        obj.getMappaOrder(idOrderIdContract,orderID,AssetOrder,MapAsset,5);
        obj.associazioneBEDissativazione_CEIst(MapAsset);
        obj.CreazionePriceBookEntry (mappa, OrderAsset,3);
        obj.CreazioneCE_Attivazione(OrderAsset,idOrder,MapAsset,3);
        test.stopTest();
    }
    
    /*public static testMethod void CodeCoverage(){
test.starttest();
OF_GestioneServiziPassiviNEW.CodeCoverage(2);
test.stoptest();
}*/
}
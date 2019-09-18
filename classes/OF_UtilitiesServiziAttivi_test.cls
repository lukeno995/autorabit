@isTest
public class OF_UtilitiesServiziAttivi_test {
    
    public static testmethod void method1(){
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account testPrsnAcc = new Account();
        testPrsnAcc.FirstName = 'Test';
        testPrsnAcc.LastName = 'Account';
        testPrsnAcc.Phone = '0000';
        testPrsnAcc.EOF_Phone_2__c = '0000';
        testPrsnAcc.EOF_Provincia__c = 'Milano';
        testPrsnAcc.EOF_Comune__c = 'Milano';
        testPrsnAcc.EOF_Indirizzo__c = 'Piazzale Gorini';
        testPrsnAcc.RecordTYpeId = AccountRecordTypeId ;
        testPrsnAcc.EOF_Particella_Toponomastica__c = '123';
        testPrsnAcc.EOF_Numero_Civico__c = '7';
        insert testPrsnAcc;
        
        Contract testContratto = new Contract();
        testContratto.OF_IdContratto__c = 'TEST_TIS_001';
        testContratto.AccountId = testPrsnAcc.id;
        insert testContratto;
        
        Asset testAsset = new Asset();
        testAsset.Name = 'IDR1234';
        testAsset.Status = 'Attivo';
        testAsset.EOF_ID_Risorsa__c = 'IDR1234';
        testAsset.accountId = testPrsnAcc.id;
        testAsset.OF_Contract__c = testContratto.Id;
        //testAsset.OF_IDCaseAttivazione__c = c.id ;
        insert testAsset;
        
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        Order testOrder = new Order();
        testOrder.AccountId = testPrsnAcc.Id;
        testOrder.RecordTypeId = OrderRecordTypeId;
        testOrder.EffectiveDate = System.today();
        testOrder.OF_Asset__c = testAsset.Id;
        testOrder.Status = 'Chiuso';
        testOrder.OF_Esito__c = 'OK';
        testOrder.OF_IDOrdineOLO__c = ' VF_81899';
        
        testOrder.ContractId = testContratto.id;
        testOrder.Description = 'DWDM1';
        //testOrder.OF_CaseID__c = c.id;
        testOrder.OF_IDRisorsa__c = 'test';
        testOrder.OF_TipologiaDiServizio__c = 'Attivo';
        testOrder.isFiberLease__c = true;
        
        insert testOrder;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = testPrsnAcc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';

        c.OF_Order__c = testOrder.id;
        insert c;
        
        testAsset.OF_IDCaseAttivazione__c = c.id ;
        update testAsset;
        
        testOrder.OF_CaseID__c = c.id;
        update testOrder;
        
        /*
        Asset testAsset = new Asset();
        testAsset.Name = 'IDR1234';
        testAsset.Status = 'Attivo';
        testAsset.EOF_ID_Risorsa__c = 'IDR1234';
        testAsset.accountId = testPrsnAcc.id;
        testAsset.OF_Contract__c = testContratto.Id;
        testAsset.OF_IDCaseAttivazione__c = c.id ;
        insert testAsset;
        
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        Order testOrder = new Order();
        testOrder.AccountId = testPrsnAcc.Id;
        testOrder.RecordTypeId = OrderRecordTypeId;
        testOrder.EffectiveDate = System.today();
        testOrder.OF_Asset__c = testAsset.Id;
        testOrder.Status = 'Chiuso';
        testOrder.OF_Esito__c = 'OK';
        testOrder.OF_IDOrdineOLO__c = ' VF_81899';
        
        testOrder.ContractId = testContratto.id;
        testOrder.Description = 'DWDM1';
        //testOrder.OF_CaseID__c = c.id;
        testOrder.OF_IDRisorsa__c = 'test';
        testOrder.OF_TipologiaDiServizio__c = 'Attivo';
        testOrder.isFiberLease__c = true;
        
        insert testOrder;
        */
        
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        
        OF_Servizio__c p2pBase = new OF_Servizio__c();
        p2pBase.Name = 'Fiber Lease'; //'P2P Base';
        p2pBase.OF_Attivo__c = true;
        p2pBase.OF_CatalogoCommerciale__c = catalogo.Id;
        p2pBase.OF_DataInizioValidita__c = myDate;
        p2pBase.OF_DataFineValidita__c = newDate;
        insert p2pBase;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name ='Fiber Lease';
        ce.OF_Servizio__c = p2pBase.id;
        ce.OF_Attivo__c=true;
        ce.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
        ce.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ce;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        CEI.OF_Asset__c=testAsset.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=c.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        CEI.OF_CommercialElement__c=ce.id;
        insert CEI;
        
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.OF_CommercialElement__c = ce.id;
        Date ini113 = Date.newInstance(2099,1,31);
        Date fin113= Date.newInstance(2099,1,3);
        be.OF_DataFineValidita__c=ini113;
        be.OF_DataInizioValidita__c=fin113;
        insert be;
        
        OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
        sb1.OF_Servizio__c=p2pBase.id;
        sb1.OF_BillingElement__c = be.id;
        sb1.OF_Contract__c = testContratto.Id;
        insert sb1;
        
        OF_Listino__c lr1=new OF_Listino__c();
        String ComRecordTypeId3 = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Fattibilità').getRecordTypeId();
        Date ini11 = Date.newInstance(2099,1,31);
        Date fin11= Date.newInstance(2099,1,3);
        lr1.OF_DataFineValidita__c=ini11;
        lr1.OF_DataInizioValidita__c=fin11;
        lr1.OF_ServizioBillingElement__c=sb1.Id;
        lr1.OF_Attivo__c = true;
        lr1.RecordTypeId = ComRecordTypeId3;
        lr1.OF_ListinoDefault__c = true;
        lr1.OF_IDContract__c = testContratto.Id;
        insert lr1;
        
        OF_UtilitiesServiziAttivi obj = new OF_UtilitiesServiziAttivi();
        Set<ID> testOrderIdsSet = new Set<ID>();
        Map<ID, Set<ID>> IDOrderListini = new Map<ID, Set<ID>>();
        Map<ID, Order> mapOrders = new Map<ID, Order>();
        Map<ID, Asset> mpAsset = new Map<ID, Asset>();
        Map<ID, ID> assetOrder = new Map<ID, ID>();
        
        testOrderIdsSet.add(testOrder.Id);
        IDOrderListini.put(testOrder.Id, testOrderIdsSet);
        mapOrders.put(testOrder.Id, testOrder);
        mpAsset.put(testAsset.Id, testAsset);
        assetOrder.put(testOrder.Id, testAsset.Id);
        
        obj.getCEListini(IDOrderListini, mapOrders, 'Fiber Lease', 0, mpAsset, assetOrder);
    }
    
    public static testmethod void method2(){
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account testPrsnAcc = new Account();
        testPrsnAcc.FirstName = 'Test';
        testPrsnAcc.LastName = 'Account';
        testPrsnAcc.Phone = '0000';
        testPrsnAcc.EOF_Phone_2__c = '0000';
        testPrsnAcc.EOF_Provincia__c = 'Milano';
        testPrsnAcc.EOF_Comune__c = 'Milano';
        testPrsnAcc.EOF_Indirizzo__c = 'Piazzale Gorini';
        testPrsnAcc.RecordTYpeId = AccountRecordTypeId ;
        testPrsnAcc.EOF_Particella_Toponomastica__c = '123';
        testPrsnAcc.EOF_Numero_Civico__c = '7';
        insert testPrsnAcc;
        
        Contract testContratto = new Contract();
        testContratto.OF_IdContratto__c = 'TEST_TIS_001';
        testContratto.AccountId = testPrsnAcc.id;
        insert testContratto;
        
        Asset testAsset = new Asset();
        testAsset.Name = 'IDR1234';
        testAsset.Status = 'Attivo';
        testAsset.EOF_ID_Risorsa__c = 'IDR1234';
        testAsset.accountId = testPrsnAcc.id;
        testAsset.OF_Contract__c = testContratto.Id;
        //testAsset.OF_IDCaseAttivazione__c = c.id ;
        insert testAsset;
        
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        Order testOrder = new Order();
        testOrder.AccountId = testPrsnAcc.Id;
        testOrder.RecordTypeId = OrderRecordTypeId;
        testOrder.EffectiveDate = System.today();
        testOrder.OF_Asset__c = testAsset.Id;
        testOrder.Status = 'Chiuso';
        testOrder.OF_Esito__c = 'OK';
        testOrder.OF_IDOrdineOLO__c = ' VF_81899';
        
        testOrder.ContractId = testContratto.id;
        testOrder.Description = 'DWDM1';
        //testOrder.OF_CaseID__c = c.id;
        testOrder.OF_IDRisorsa__c = 'test';
        testOrder.OF_TipologiaDiServizio__c = 'Attivo';
        testOrder.isFiberLease__c = true;
        
        insert testOrder;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = testPrsnAcc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';

        c.OF_Order__c = testOrder.id;
        insert c;
        
        testAsset.OF_IDCaseAttivazione__c = c.id ;
        update testAsset;
        
        testOrder.OF_CaseID__c = c.id;
        update testOrder;
        
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        
        OF_Servizio__c p2pBase = new OF_Servizio__c();
        p2pBase.Name = 'Fiber Lease'; //'P2P Base';
        p2pBase.OF_Attivo__c = true;
        p2pBase.OF_CatalogoCommerciale__c = catalogo.Id;
        p2pBase.OF_DataInizioValidita__c = myDate;
        p2pBase.OF_DataFineValidita__c = newDate;
        insert p2pBase;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name ='Fiber Lease';
        ce.OF_Servizio__c = p2pBase.id;
        ce.OF_Attivo__c=true;
        ce.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
        ce.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ce;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        CEI.OF_Asset__c=testAsset.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=c.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        CEI.OF_CommercialElement__c=ce.id;
        CEI.OF_EsitoRitiroApparato__c = '0';
        insert CEI;
        
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.OF_CommercialElement__c = ce.id;
        Date ini113 = Date.newInstance(2099,1,31);
        Date fin113= Date.newInstance(2099,1,3);
        be.OF_DataFineValidita__c=ini113;
        be.OF_DataInizioValidita__c=fin113;
        insert be;
        
        OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
        sb1.OF_Servizio__c=p2pBase.id;
        sb1.OF_BillingElement__c = be.id;
        sb1.OF_Contract__c = testContratto.Id;
        insert sb1;
        
        OF_Listino__c lr1=new OF_Listino__c();
        String ComRecordTypeId3 = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Fattibilità').getRecordTypeId();
        Date ini11 = Date.newInstance(2099,1,31);
        Date fin11= Date.newInstance(2099,1,3);
        lr1.OF_DataFineValidita__c=ini11;
        lr1.OF_DataInizioValidita__c=fin11;
        lr1.OF_ServizioBillingElement__c=sb1.Id;
        lr1.OF_Attivo__c = true;
        lr1.RecordTypeId = ComRecordTypeId3;
        lr1.OF_ListinoDefault__c = true;
        lr1.OF_IDContract__c = testContratto.Id;
        insert lr1;
        
        OF_UtilitiesServiziAttivi obj = new OF_UtilitiesServiziAttivi();
        Set<ID> testOrderIdsSet = new Set<ID>();
        Map<ID, Set<ID>> IDOrderListini = new Map<ID, Set<ID>>();
        Map<ID, Order> mapOrders = new Map<ID, Order>();
        Map<ID, Asset> mpAsset = new Map<ID, Asset>();
        Map<ID, ID> assetOrder = new Map<ID, ID>();
        
        testOrderIdsSet.add(testOrder.Id);
        IDOrderListini.put(testOrder.Id, testOrderIdsSet);
        mapOrders.put(testOrder.Id, testOrder);
        mpAsset.put(testAsset.Id, testAsset);
        assetOrder.put(testOrder.Id, testAsset.Id);
        
        obj.getCEListini(IDOrderListini, mapOrders, lr1.OF_Servizio__c, 1, mpAsset, assetOrder);
    }
    
    public static testmethod void method3(){
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account testPrsnAcc = new Account();
        testPrsnAcc.FirstName = 'Test';
        testPrsnAcc.LastName = 'Account';
        testPrsnAcc.Phone = '0000';
        testPrsnAcc.EOF_Phone_2__c = '0000';
        testPrsnAcc.EOF_Provincia__c = 'Milano';
        testPrsnAcc.EOF_Comune__c = 'Milano';
        testPrsnAcc.EOF_Indirizzo__c = 'Piazzale Gorini';
        testPrsnAcc.RecordTYpeId = AccountRecordTypeId ;
        testPrsnAcc.EOF_Particella_Toponomastica__c = '123';
        testPrsnAcc.EOF_Numero_Civico__c = '7';
        insert testPrsnAcc;
        
        Contract testContratto = new Contract();
        testContratto.OF_IdContratto__c = 'TEST_TIS_001';
        testContratto.AccountId = testPrsnAcc.id;
        insert testContratto;
        
        Asset testAsset = new Asset();
        testAsset.Name = 'IDR1234';
        testAsset.Status = 'Attivo';
        testAsset.EOF_ID_Risorsa__c = 'IDR1234';
        testAsset.accountId = testPrsnAcc.id;
        testAsset.OF_Contract__c = testContratto.Id;
        //testAsset.OF_IDCaseAttivazione__c = c.id ;
        insert testAsset;
        
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        Order testOrder = new Order();
        testOrder.AccountId = testPrsnAcc.Id;
        testOrder.RecordTypeId = OrderRecordTypeId;
        testOrder.EffectiveDate = System.today();
        testOrder.OF_Asset__c = testAsset.Id;
        testOrder.Status = 'Chiuso';
        testOrder.OF_Esito__c = 'OK';
        testOrder.OF_IDOrdineOLO__c = ' VF_81899';
        
        testOrder.ContractId = testContratto.id;
        testOrder.Description = 'DWDM1';
        //testOrder.OF_CaseID__c = c.id;
        testOrder.OF_IDRisorsa__c = 'test';
        testOrder.OF_TipologiaDiServizio__c = 'Attivo';
        testOrder.isFiberLease__c = true;
        
        insert testOrder;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = testPrsnAcc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';

        c.OF_Order__c = testOrder.id;
        insert c;
        
        testAsset.OF_IDCaseAttivazione__c = c.id ;
        update testAsset;
        
        testOrder.OF_CaseID__c = c.id;
        
        update testOrder;
        
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        
        OF_Servizio__c p2pBase = new OF_Servizio__c();
        p2pBase.Name = 'Fiber Lease'; //'P2P Base';
        p2pBase.OF_Attivo__c = true;
        p2pBase.OF_CatalogoCommerciale__c = catalogo.Id;
        p2pBase.OF_DataInizioValidita__c = myDate;
        p2pBase.OF_DataFineValidita__c = newDate;
        insert p2pBase;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name ='Fiber Lease';
        ce.OF_Servizio__c = p2pBase.id;
        ce.OF_Attivo__c=true;
        ce.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
        ce.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ce;
        
        String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
        String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        
        List<OF_CommercialElementIstanziato__c> testCeiList =new List<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c CEI1 = new OF_CommercialElementIstanziato__c();
        CEI1 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'Servizi Aggiuntivi', 'RIBALTAMENTO IMPIANTO', 'Attivo', c.id, ce.id);
        CEI1.OF_EsitoConsegnaApparato__c = '2';
        CEI1.OF_EsitoRitiroApparato__c = '0';
        CEI1.OF_ESITOSERVIZIO__c = '0';
        testCeiList.add(CEI1);
        
        OF_CommercialElementIstanziato__c CEI2 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'Servizi Aggiuntivi', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI2.OF_EsitoConsegnaApparato__c = '2';
        CEI2.OF_EsitoRitiroApparato__c = '0';
        CEI2.OF_ESITOSERVIZIO__c = '0';
        testCeiList.add(CEI2);
        
        OF_CommercialElementIstanziato__c CEI3 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'CPE', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI3.OF_EsitoConsegnaApparato__c = '1';
        CEI3.OF_EsitoRitiroApparato__c = '0';
        testCeiList.add(CEI3);
        
        OF_CommercialElementIstanziato__c CEI4 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'CPE', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI4.OF_EsitoConsegnaApparato__c = '2';
        CEI4.OF_EsitoRitiroApparato__c = '0';
        testCeiList.add(CEI4);
        
        OF_CommercialElementIstanziato__c CEI5 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'CPE', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI5.OF_EsitoConsegnaApparato__c = '4';
        CEI5.OF_EsitoRitiroApparato__c = '0';
        testCeiList.add(CEI5);
        
        insert testCeiList;
        
        Date ini113 = Date.newInstance(2099,1,31);
        Date fin113= Date.newInstance(2099,1,3);
        
        OF_BillingElement__c be = generateOFBillingElementRecs(ce.id, 'Fiber Lease', ini113, fin113);
        insert be;
        
        OF_BillingElement__c be1 = generateOFBillingElementRecs(ce.id, 'Contributo Consegna', ini113, fin113);
        insert be1;
        
        OF_BillingElement__c be2 = generateOFBillingElementRecs(ce.id, 'Contributo Consegna e Istallazione', ini113, fin113);
        insert be2;
        
        OF_BillingElement__c be3 = generateOFBillingElementRecs(ce.id, 'Contributo istallazione', ini113, fin113);
        insert be3;
        
        OF_BillingElement__c be4 = generateOFBillingElementRecs(ce.id, 'Contributo ritiro', ini113, fin113);
        insert be4;
        
        OF_ServizioBillingElement__c sb1 = generateOFServizioBillingElementRecs(p2pBase.id, be.id, testContratto.Id);
        insert sb1;
        
        OF_ServizioBillingElement__c sb2 = generateOFServizioBillingElementRecs(p2pBase.id, be1.id, testContratto.Id);
        insert sb2;
        
        OF_ServizioBillingElement__c sb3 = generateOFServizioBillingElementRecs(p2pBase.id, be2.id, testContratto.Id);
        insert sb3;
        
        OF_ServizioBillingElement__c sb4 = generateOFServizioBillingElementRecs(p2pBase.id, be3.id, testContratto.Id);
        insert sb4;
        
        OF_ServizioBillingElement__c sb5 = generateOFServizioBillingElementRecs(p2pBase.id, be4.id, testContratto.Id);
        insert sb5;
        
        list<OF_Listino__c> testLRList = new list<OF_Listino__c>();
        //OF_Listino__c lr1 = new OF_Listino__c();
        OF_Listino__c lnr1 = generateOFListinoRecords(sb1.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr1);
        insert lnr1;
        
        OF_Listino__c lnr2 = generateOFListinoRecords(sb2.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr2);
        insert lnr2;
        
        OF_Listino__c lnr3 = generateOFListinoRecords(sb3.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr3);
        insert lnr3;
        
        OF_Listino__c lnr4 = generateOFListinoRecords(sb4.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr4);
        insert lnr4;
        
        OF_Listino__c lnr5 = generateOFListinoRecords(sb5.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr5);
        insert lnr5;
        
        //insert testLRList;
        
        OF_Listino__c lr1 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr1.id];
                            
        OF_Listino__c lr2 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr2.id];
                            
        OF_Listino__c lr3 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr3.id];
                            
        OF_Listino__c lr4 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr4.id];

        OF_Listino__c lr5 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr5.id];
                            
        OF_UtilitiesServiziAttivi obj = new OF_UtilitiesServiziAttivi();
        
        List<OF_CommercialElementIstanziato__c> testCEIListNew = [Select id, name, OF_Asset__c, OF_Stato__c, RecordTypeId, OF_Case__c,
                                                               OF_EsitoConsegnaApparato__c, OF_CommercialElement__c, OF_EsitoRitiroApparato__c,
                                                               OF_Nome_Servizio__c, OF_ESITOSERVIZIO__c, recordtype.name
                                                               from OF_CommercialElementIstanziato__c];
        //testCEIList.add(CEI);
        
        Map<ID, List<OF_CommercialElementIstanziato__c>> testCEIMap= new Map<ID, List<OF_CommercialElementIstanziato__c>>();
        testCEIMap.put(lr1.ID, testCEIListNew);
        testCEIMap.put(lr2.ID, testCEIListNew);
        testCEIMap.put(lr3.ID, testCEIListNew);
        testCEIMap.put(lr4.ID, testCEIListNew);
        testCEIMap.put(lr5.ID, testCEIListNew);
        
        Map<ID, Map<ID, List<OF_CommercialElementIstanziato__c>>> TheMap = new Map<ID, Map<ID,List<OF_CommercialElementIstanziato__c>>>();
        TheMap.put(testOrder.Id, testCEIMap);
        
        map<id, OF_listino__c> listOFListino = new map<id, OF_listino__c>();
        listOFListino.put(lr1.Id, lr1);
        listOFListino.put(lr2.Id, lr2);
        listOFListino.put(lr3.Id, lr3);
        listOFListino.put(lr4.Id, lr4);
        listOFListino.put(lr5.Id, lr5);
        
        obj.FilterCEAttivi(TheMap, listOFListino);
        obj.FilterCEAttiviCessazioneCPE(TheMap, listOFListino);
    }
    
    public static testmethod void method4(){
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account testAccOLO = new Account();
        testAccOLO.Name = 'Vodafone';
        testAccOLO.EOF_Codice_Operatore__c = 'VF';
        testAccOLO.Type = 'OLO';
        testAccOLO.Industry = 'Telecommunications';
        testAccOLO.RecordTypeId = oloAccountRecordTypeId;
        insert testAccOLO;
        
        //Creazione apparato sotto l'OLO
        OF_CatalogoApparati__c objCatalogoApparati = new OF_CatalogoApparati__c();
        objCatalogoApparati.OF_TipologiaApparato__c = 'test';
        objCatalogoApparati.OF_OLO__c = testAccOLO.Id;
        insert objCatalogoApparati;
      
        Contract testContratto = new Contract();
        testContratto.OF_IdContratto__c = 'TEST_TIS_001';
        testContratto.AccountId = testAccOLO.id;
        insert testContratto;
        
        Asset testAsset = new Asset();
        testAsset.Name = 'IDR1234';
        testAsset.Status = 'Attivo';
        testAsset.EOF_ID_Risorsa__c = 'IDR1234';
        testAsset.accountId = testAccOLO.id;
        testAsset.OF_Contract__c = testContratto.Id;
        insert testAsset;
        
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        Order testOrder = new Order();
        testOrder.AccountId = testAccOLO.Id;
        testOrder.RecordTypeId = OrderRecordTypeId;
        testOrder.EffectiveDate = System.today();
        testOrder.OF_Asset__c = testAsset.Id;
        testOrder.Status = 'Chiuso';
        testOrder.OF_Esito__c = 'OK';
        testOrder.OF_IDOrdineOLO__c = ' VF_81899';
        
        testOrder.ContractId = testContratto.id;
        testOrder.Description = 'DWDM1';
        testOrder.OF_IDRisorsa__c = 'test';
        testOrder.OF_TipologiaDiServizio__c = 'Attivo';
        testOrder.isFiberLease__c = true;
        
        insert testOrder;
        
        OF_UtilitiesServiziAttivi obj = new OF_UtilitiesServiziAttivi();
        Map<ID, Order> mapOrders = new Map<ID, Order>();
        mapOrders.put(testOrder.Id, testOrder);
        
        obj.getOrderCatalogoProdottiOLO(mapOrders);
    }
    
    public static testmethod void method5(){
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account testPrsnAcc = new Account();
        testPrsnAcc.Name = 'Test Account';
        testPrsnAcc.Phone = '0000';
        testPrsnAcc.EOF_Phone_2__c = '0000';
        testPrsnAcc.EOF_Provincia__c = 'Milano';
        testPrsnAcc.EOF_Comune__c = 'Milano';
        testPrsnAcc.EOF_Indirizzo__c = 'Piazzale Gorini';
        testPrsnAcc.RecordTYpeId = AccountRecordTypeId ;
        testPrsnAcc.EOF_Particella_Toponomastica__c = '123';
        testPrsnAcc.EOF_Numero_Civico__c = '7';
        testPrsnAcc.EOF_Codice_Operatore__c = 'VF';
        testPrsnAcc.Type = 'OLO';
        testPrsnAcc.Industry = 'Telecommunications';
        insert testPrsnAcc;
        
        Contract testContratto = new Contract();
        testContratto.OF_IdContratto__c = 'TEST_TIS_001';
        testContratto.AccountId = testPrsnAcc.id;
        insert testContratto;
        
        Asset testAsset = new Asset();
        testAsset.Name = 'IDR1234';
        testAsset.Status = 'Attivo';
        testAsset.EOF_ID_Risorsa__c = 'IDR1234';
        testAsset.accountId = testPrsnAcc.id;
        testAsset.OF_Contract__c = testContratto.Id;
        //testAsset.OF_IDCaseAttivazione__c = c.id ;
        insert testAsset;
        
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        Order testOrder = new Order();
        testOrder.AccountId = testPrsnAcc.Id;
        testOrder.RecordTypeId = OrderRecordTypeId;
        testOrder.EffectiveDate = System.today();
        testOrder.OF_Asset__c = testAsset.Id;
        testOrder.Status = 'Chiuso';
        testOrder.OF_Esito__c = 'OK';
        testOrder.OF_IDOrdineOLO__c = ' VF_81899';
        
        testOrder.ContractId = testContratto.id;
        testOrder.Description = 'DWDM1';
        //testOrder.OF_CaseID__c = c.id;
        testOrder.OF_IDRisorsa__c = 'test';
        testOrder.OF_TipologiaDiServizio__c = 'Attivo';
        testOrder.isFiberLease__c = true;
        
        insert testOrder;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = testPrsnAcc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';

        c.OF_Order__c = testOrder.id;
        insert c;
        
        testAsset.OF_IDCaseAttivazione__c = c.id ;
        update testAsset;
        
        testOrder.OF_CaseID__c = c.id;
        
        update testOrder;
        
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        
        OF_Servizio__c p2pBase = new OF_Servizio__c();
        p2pBase.Name = 'Fiber Lease'; //'P2P Base';
        p2pBase.OF_Attivo__c = true;
        p2pBase.OF_CatalogoCommerciale__c = catalogo.Id;
        p2pBase.OF_DataInizioValidita__c = myDate;
        p2pBase.OF_DataFineValidita__c = newDate;
        insert p2pBase;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name ='Fiber Lease';
        ce.OF_Servizio__c = p2pBase.id;
        ce.OF_Attivo__c=true;
        ce.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
        ce.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ce;
        
        String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
        String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        
        List<OF_CommercialElementIstanziato__c> testCeiList =new List<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c CEI1 = new OF_CommercialElementIstanziato__c();
        CEI1 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'Servizi Aggiuntivi', 'RIBALTAMENTO IMPIANTO', 'Attivo', c.id, ce.id);
        CEI1.OF_EsitoConsegnaApparato__c = '2';
        CEI1.OF_EsitoRitiroApparato__c = '0';
        CEI1.OF_ESITOSERVIZIO__c = '0';
        testCeiList.add(CEI1);
        
        OF_CommercialElementIstanziato__c CEI2 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'Servizi Aggiuntivi', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI2.OF_EsitoConsegnaApparato__c = '2';
        CEI2.OF_EsitoRitiroApparato__c = '0';
        CEI2.OF_ESITOSERVIZIO__c = '0';
        testCeiList.add(CEI2);
        
        OF_CommercialElementIstanziato__c CEI3 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'CPE', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI3.OF_EsitoConsegnaApparato__c = '1';
        CEI3.OF_EsitoRitiroApparato__c = '0';
        testCeiList.add(CEI3);
        
        OF_CommercialElementIstanziato__c CEI4 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'CPE', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI4.OF_EsitoConsegnaApparato__c = '2';
        CEI4.OF_EsitoRitiroApparato__c = '0';
        testCeiList.add(CEI4);
        
        OF_CommercialElementIstanziato__c CEI5 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'CPE', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI5.OF_EsitoConsegnaApparato__c = '4';
        CEI5.OF_EsitoRitiroApparato__c = '0';
        testCeiList.add(CEI5);
        
        insert testCeiList;
        
        Date ini113 = Date.newInstance(2099,1,31);
        Date fin113= Date.newInstance(2099,1,3);
        
        OF_BillingElement__c be = generateOFBillingElementRecs(ce.id, 'Fiber Lease', ini113, fin113);
        insert be;
        
        OF_BillingElement__c be1 = generateOFBillingElementRecs(ce.id, 'Contributo Consegna', ini113, fin113);
        insert be1;
        
        OF_BillingElement__c be2 = generateOFBillingElementRecs(ce.id, 'Contributo Consegna e Istallazione', ini113, fin113);
        insert be2;
        
        OF_BillingElement__c be3 = generateOFBillingElementRecs(ce.id, 'Contributo istallazione', ini113, fin113);
        insert be3;
        
        OF_BillingElement__c be4 = generateOFBillingElementRecs(ce.id, 'Contributo ritiro', ini113, fin113);
        insert be4;
        
        OF_ServizioBillingElement__c sb1 = generateOFServizioBillingElementRecs(p2pBase.id, be.id, testContratto.Id);
        insert sb1;
        
        OF_ServizioBillingElement__c sb2 = generateOFServizioBillingElementRecs(p2pBase.id, be1.id, testContratto.Id);
        insert sb2;
        
        OF_ServizioBillingElement__c sb3 = generateOFServizioBillingElementRecs(p2pBase.id, be2.id, testContratto.Id);
        insert sb3;
        
        OF_ServizioBillingElement__c sb4 = generateOFServizioBillingElementRecs(p2pBase.id, be3.id, testContratto.Id);
        insert sb4;
        
        OF_ServizioBillingElement__c sb5 = generateOFServizioBillingElementRecs(p2pBase.id, be4.id, testContratto.Id);
        insert sb5;
        
        list<OF_Listino__c> testLRList = new list<OF_Listino__c>();
        //OF_Listino__c lr1 = new OF_Listino__c();
        OF_Listino__c lnr1 = generateOFListinoRecords(sb1.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr1);
        insert lnr1;
        
        OF_Listino__c lnr2 = generateOFListinoRecords(sb2.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr2);
        insert lnr2;
        
        OF_Listino__c lnr3 = generateOFListinoRecords(sb3.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr3);
        insert lnr3;
        
        OF_Listino__c lnr4 = generateOFListinoRecords(sb4.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr4);
        insert lnr4;
        
        OF_Listino__c lnr5 = generateOFListinoRecords(sb5.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr5);
        insert lnr5;
        
        //insert testLRList;
        
        OF_Listino__c lr1 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr1.id];
                            
        OF_Listino__c lr2 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr2.id];
                            
        OF_Listino__c lr3 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr3.id];
                            
        OF_Listino__c lr4 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr4.id];

        OF_Listino__c lr5 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr5.id];
                            
        OF_UtilitiesServiziAttivi obj = new OF_UtilitiesServiziAttivi();
        
        List<OF_Listino__c> testOFListinoListNew = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                                                    OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                                                    FROM OF_Listino__c];
        
        Map<ID, List<OF_Listino__c>> testOFLRMap= new Map<ID, List<OF_Listino__c>>();
        testOFLRMap.put(lr1.ID, testOFListinoListNew);
        testOFLRMap.put(lr2.ID, testOFListinoListNew);
        testOFLRMap.put(lr3.ID, testOFListinoListNew);
        testOFLRMap.put(lr4.ID, testOFListinoListNew);
        testOFLRMap.put(lr5.ID, testOFListinoListNew);
        
        Map<ID, Map<ID, List<OF_Listino__c>>> idOrderIdCEListiniMap = new Map<ID, Map<ID,List<OF_Listino__c>>>();
        idOrderIdCEListiniMap.put(testOrder.Id, testOFLRMap);
                
        obj.getMultipleCEPerListino(idOrderIdCEListiniMap);
        
        List<OF_CommercialElementIstanziato__c> testCEIListNew = [Select id, name, OF_Asset__c, OF_Stato__c, RecordTypeId, OF_Case__c,
                                                               OF_EsitoConsegnaApparato__c, OF_CommercialElement__c, OF_EsitoRitiroApparato__c,
                                                               OF_Nome_Servizio__c, OF_ESITOSERVIZIO__c, recordtype.name
                                                               from OF_CommercialElementIstanziato__c];
        
        Map<ID, List<OF_Listino__c>> testCELRMap= new Map<ID, List<OF_Listino__c>>();
        testCELRMap.put(testCEIListNew.get(0).ID, testOFListinoListNew);
        testCELRMap.put(testCEIListNew.get(1).ID, testOFListinoListNew);
        testCELRMap.put(testCEIListNew.get(2).ID, testOFListinoListNew);
        testCELRMap.put(testCEIListNew.get(3).ID, testOFListinoListNew);
        testCELRMap.put(testCEIListNew.get(4).ID, testOFListinoListNew);
        
        Map<ID, Map<ID, List<OF_Listino__c>>> OrderCEListiniMap = new Map<ID, Map<ID,List<OF_Listino__c>>>();
        OrderCEListiniMap.put(testOrder.Id, testCELRMap);
        
        Map<ID, Asset> mpAsset = new Map<ID, Asset>();
        Map<ID, ID> orderAsset = new Map<ID, ID>();
        
        orderAsset.put(testOrder.Id, testAsset.Id);
        mpAsset.put(testAsset.Id, testAsset);
        
        obj.AttivazioneCE(OrderCEListiniMap, orderAsset, mpAsset);
    }
    
    public static testmethod void method6(){
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account testPrsnAcc = new Account();
        testPrsnAcc.FirstName = 'Test';
        testPrsnAcc.LastName = 'Account';
        testPrsnAcc.Phone = '0000';
        testPrsnAcc.EOF_Phone_2__c = '0000';
        testPrsnAcc.EOF_Provincia__c = 'Milano';
        testPrsnAcc.EOF_Comune__c = 'Milano';
        testPrsnAcc.EOF_Indirizzo__c = 'Piazzale Gorini';
        testPrsnAcc.RecordTYpeId = AccountRecordTypeId ;
        testPrsnAcc.EOF_Particella_Toponomastica__c = '123';
        testPrsnAcc.EOF_Numero_Civico__c = '7';
        insert testPrsnAcc;
        
        Contract testContratto = new Contract();
        testContratto.OF_IdContratto__c = 'TEST_TIS_001';
        testContratto.AccountId = testPrsnAcc.id;
        insert testContratto;
        
        Asset testAsset = new Asset();
        testAsset.Name = 'IDR1234';
        testAsset.Status = 'Attivo';
        testAsset.EOF_ID_Risorsa__c = 'IDR1234';
        testAsset.accountId = testPrsnAcc.id;
        testAsset.OF_Contract__c = testContratto.Id;
        //testAsset.OF_IDCaseAttivazione__c = c.id ;
        insert testAsset;
        
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        Order testOrder = new Order();
        testOrder.AccountId = testPrsnAcc.Id;
        testOrder.RecordTypeId = OrderRecordTypeId;
        testOrder.EffectiveDate = System.today();
        testOrder.OF_Asset__c = testAsset.Id;
        testOrder.Status = 'Chiuso';
        testOrder.OF_Esito__c = 'OK';
        testOrder.OF_IDOrdineOLO__c = ' VF_81899';
        
        testOrder.ContractId = testContratto.id;
        testOrder.Description = 'DWDM1';
        //testOrder.OF_CaseID__c = c.id;
        testOrder.OF_IDRisorsa__c = 'test';
        testOrder.OF_TipologiaDiServizio__c = 'Attivo';
        testOrder.isFiberLease__c = true;
        
        insert testOrder;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = testPrsnAcc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';

        c.OF_Order__c = testOrder.id;
        insert c;
        
        testAsset.OF_IDCaseAttivazione__c = c.id ;
        update testAsset;
        
        testOrder.OF_CaseID__c = c.id;
        
        update testOrder;
        
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        
        OF_Servizio__c p2pBase = new OF_Servizio__c();
        p2pBase.Name = 'Fiber Lease'; //'P2P Base';
        p2pBase.OF_Attivo__c = true;
        p2pBase.OF_CatalogoCommerciale__c = catalogo.Id;
        p2pBase.OF_DataInizioValidita__c = myDate;
        p2pBase.OF_DataFineValidita__c = newDate;
        insert p2pBase;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name ='Fiber Lease';
        ce.OF_Servizio__c = p2pBase.id;
        ce.OF_Attivo__c=true;
        ce.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
        ce.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ce;
        
        String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
        String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        
        List<OF_CommercialElementIstanziato__c> testCeiList =new List<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c CEI1 = new OF_CommercialElementIstanziato__c();
        CEI1 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'Servizi Aggiuntivi', 'RIBALTAMENTO IMPIANTO', 'Attivo', c.id, ce.id);
        CEI1.OF_EsitoConsegnaApparato__c = '2';
        CEI1.OF_EsitoRitiroApparato__c = '0';
        CEI1.OF_ESITOSERVIZIO__c = '0';
        testCeiList.add(CEI1);
        
        OF_CommercialElementIstanziato__c CEI2 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'Servizi Aggiuntivi', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI2.OF_EsitoConsegnaApparato__c = '2';
        CEI2.OF_EsitoRitiroApparato__c = '0';
        CEI2.OF_ESITOSERVIZIO__c = '0';
        testCeiList.add(CEI2);
        
        OF_CommercialElementIstanziato__c CEI3 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'CPE', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI3.OF_EsitoConsegnaApparato__c = '1';
        CEI3.OF_EsitoRitiroApparato__c = '0';
        testCeiList.add(CEI3);
        
        OF_CommercialElementIstanziato__c CEI4 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'CPE', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI4.OF_EsitoConsegnaApparato__c = '2';
        CEI4.OF_EsitoRitiroApparato__c = '0';
        testCeiList.add(CEI4);
        
        OF_CommercialElementIstanziato__c CEI5 = generateOFCommercialElementIstanziatoRecs(testAsset.id, 'CPE', 'ESTENSIONE IMPIANTO CLIENTE', 'Attivo', c.id, ce.id);
        CEI5.OF_EsitoConsegnaApparato__c = '4';
        CEI5.OF_EsitoRitiroApparato__c = '0';
        testCeiList.add(CEI5);
        
        insert testCeiList;
        
        Date ini113 = Date.newInstance(2099,1,31);
        Date fin113= Date.newInstance(2099,1,3);
        
        OF_BillingElement__c be = generateOFBillingElementRecs(ce.id, 'Fiber Lease', ini113, fin113);
        insert be;
        
        OF_BillingElement__c be1 = generateOFBillingElementRecs(ce.id, 'Contributo Consegna', ini113, fin113);
        insert be1;
        
        OF_BillingElement__c be2 = generateOFBillingElementRecs(ce.id, 'Contributo Consegna e Istallazione', ini113, fin113);
        insert be2;
        
        OF_BillingElement__c be3 = generateOFBillingElementRecs(ce.id, 'Contributo istallazione', ini113, fin113);
        insert be3;
        
        OF_BillingElement__c be4 = generateOFBillingElementRecs(ce.id, 'Contributo ritiro', ini113, fin113);
        insert be4;
        
        OF_ServizioBillingElement__c sb1 = generateOFServizioBillingElementRecs(p2pBase.id, be.id, testContratto.Id);
        insert sb1;
        
        OF_ServizioBillingElement__c sb2 = generateOFServizioBillingElementRecs(p2pBase.id, be1.id, testContratto.Id);
        insert sb2;
        
        OF_ServizioBillingElement__c sb3 = generateOFServizioBillingElementRecs(p2pBase.id, be2.id, testContratto.Id);
        insert sb3;
        
        OF_ServizioBillingElement__c sb4 = generateOFServizioBillingElementRecs(p2pBase.id, be3.id, testContratto.Id);
        insert sb4;
        
        OF_ServizioBillingElement__c sb5 = generateOFServizioBillingElementRecs(p2pBase.id, be4.id, testContratto.Id);
        insert sb5;
        
        list<OF_Listino__c> testLRList = new list<OF_Listino__c>();
        //OF_Listino__c lr1 = new OF_Listino__c();
        OF_Listino__c lnr1 = generateOFListinoRecords(sb1.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr1);
        insert lnr1;
        
        OF_Listino__c lnr2 = generateOFListinoRecords(sb2.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr2);
        insert lnr2;
        
        OF_Listino__c lnr3 = generateOFListinoRecords(sb3.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr3);
        insert lnr3;
        
        OF_Listino__c lnr4 = generateOFListinoRecords(sb4.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr4);
        insert lnr4;
        
        OF_Listino__c lnr5 = generateOFListinoRecords(sb5.Id, 'Fattibilità', testContratto.Id);
        testLRList.add(lnr5);
        insert lnr5;
        
        //insert testLRList;
        
        OF_Listino__c lr1 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr1.id];
                            
        OF_Listino__c lr2 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr2.id];
                            
        OF_Listino__c lr3 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr3.id];
                            
        OF_Listino__c lr4 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr4.id];

        OF_Listino__c lr5 = [Select id, name, OF_CommercialElement__c, OF_DataFineValidita__c, OF_ServizioBillingElement__c, OF_DataInizioValidita__c,
                            OF_ListinoDefault__c, RecordTypeId, OF_Attivo__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name
                            FROM OF_Listino__c WHERE id = :lnr5.id];
                            
        OF_UtilitiesServiziAttivi obj = new OF_UtilitiesServiziAttivi();
        
        List<OF_CommercialElementIstanziato__c> testCEIListNew = [Select id, name, OF_Asset__c, OF_Stato__c, RecordTypeId, OF_Case__c,
                                                               OF_EsitoConsegnaApparato__c, OF_CommercialElement__c, OF_EsitoRitiroApparato__c,
                                                               OF_Nome_Servizio__c, OF_ESITOSERVIZIO__c, recordtype.name
                                                               from OF_CommercialElementIstanziato__c];
        //testCEIList.add(CEI);
        
        Map<ID, List<OF_CommercialElementIstanziato__c>> testCEIMap= new Map<ID, List<OF_CommercialElementIstanziato__c>>();
        testCEIMap.put(lr1.ID, testCEIListNew);
        testCEIMap.put(lr2.ID, testCEIListNew);
        testCEIMap.put(lr3.ID, testCEIListNew);
        testCEIMap.put(lr4.ID, testCEIListNew);
        testCEIMap.put(lr5.ID, testCEIListNew);
        
        Map<ID, Map<ID, List<OF_CommercialElementIstanziato__c>>> TheMap = new Map<ID, Map<ID,List<OF_CommercialElementIstanziato__c>>>();
        TheMap.put(testOrder.Id, testCEIMap);
        
        map<id, OF_listino__c> listOFListino = new map<id, OF_listino__c>();
        listOFListino.put(lr1.Id, lr1);
        listOFListino.put(lr2.Id, lr2);
        listOFListino.put(lr3.Id, lr3);
        listOFListino.put(lr4.Id, lr4);
        listOFListino.put(lr5.Id, lr5);
        
        
        Map<ID, Order> orderID = new Map<ID, Order>();
        orderID.put(testOrder.Id, testOrder);
        
        obj.CEListini(TheMap, listOFListino, orderID);
    }
    
    public static testmethod void myUnit1()
    {
        OF_UtilitiesServiziAttivi obj = new OF_UtilitiesServiziAttivi();
        obj.getCEListini(null,null,null,0,null,null);
        obj.FilterCEAttivi (null,null);
        obj.CEListini(null,null,null);
        obj.AttivazioneCE(null, null, null);
        obj.getMultipleCEPerListino(null);
        obj.getOrderCatalogoProdottiOLO(null);
        obj.FilterCEAttivi(null, null);
        obj.FilterCEAttiviCessazioneCPE(null, null);
    }
    
    public static OF_CommercialElementIstanziato__c generateOFCommercialElementIstanziatoRecs(Id testAssetId, String ComRecordTypeName, String OFNomeServizio, String stateName, Id caseId, Id ceId)
    {
        String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get(ComRecordTypeName).getRecordTypeId();
        
        OF_CommercialElementIstanziato__c CEI = new OF_CommercialElementIstanziato__c();
        CEI.OF_Asset__c = testAssetId;
        CEI.OF_Stato__c = stateName;
        CEI.OF_Nome_Servizio__c = OFNomeServizio;
        CEI.RecordTypeId = ComRecordTypeId;
        CEI.OF_Case__c = caseId;
        CEI.OF_CommercialElement__c = ceId;
        
        return CEI;
    }
    
    public static OF_Listino__c generateOFListinoRecords(Id sbeId, String ComRecordTypeName, Id testContrattoId)
    {
        Date ini11 = Date.newInstance(2099,1,31);
        Date fin11= Date.newInstance(2099,1,3);
        String ComRecordTypeId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get(ComRecordTypeName).getRecordTypeId();
        
        OF_Listino__c lr1 = new OF_Listino__c();
        lr1.OF_DataFineValidita__c = ini11;
        lr1.OF_DataInizioValidita__c = fin11;
        lr1.OF_ServizioBillingElement__c = sbeId;
        lr1.OF_Attivo__c = true;
        lr1.RecordTypeId = ComRecordTypeId;
        lr1.OF_ListinoDefault__c = true;
        
        lr1.OF_IDContract__c = testContrattoId;
        return lr1;
    }
    
    public static OF_ServizioBillingElement__c generateOFServizioBillingElementRecs(Id p2pBaseId, Id beId, Id testContrattoId)
    {
        OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
        sb1.OF_Servizio__c = p2pBaseId;
        sb1.OF_BillingElement__c = beId;
        sb1.OF_Contract__c = testContrattoId;
        return sb1;
    }
    
    public static OF_BillingElement__c generateOFBillingElementRecs(Id ceId, String recName, Date ini113, Date fin113)
    {
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.OF_CommercialElement__c = ceId;
        be.OF_DataFineValidita__c = ini113;
        be.OF_DataInizioValidita__c = fin113;
        be.name = recName;
        return be;
    }
    
    
    
}


/*

    @testSetup
    static void testDataSetup(){
        ServFattib__c servFattib = new ServFattib__c();
        servFattib.creaOppChildFase__c = 'Completato';
        servFattib.creaOppChildRecordTypeName__c = '\''+'PO Collegamento P2P'+'\','+'PO'+'\'';
        servFattib.creaOppParentFase__c = 'Offerta Creata';
        servFattib.creaOppParentOfferta__c = '\''+'P2P Base'+'\','+'IRU'+'\','+ 'Fiber Link' +'\','+ 'Fiber Lease' +'\','+ 'Evento Temporaneo' +'\'';
        servFattib.creaOppParentRecordTypeName__c = 'PO Richiesta a servizio a fattibilità';
        servFattib.oppChildDevNames__c = 'PO_Oppty_Evento_Temporaneo,PO_Oppty_Fiber_Lease,PO_Oppty_Fiber_Link,PO_Oppty_IRU,PO_Oppty_Misto_Lease_Link_per_FW,PO_Oppty_collegamenti';
        servFattib.oppChildDurationDays__c = 150;
        servFattib.oppChildEvtTempDevName__c = 'PO_Oppty_Evento_Temporaneo';
        servFattib.oppChildFiberLeaseDevName__c = 'PO_Oppty_Fiber_Lease';
        servFattib.oppChildFiberLeaseMistoDevName__c = 'PO_Oppty_Misto_Lease_Link_per_FW';
        servFattib.oppChildFiberLinkDevName__c = 'PO_Oppty_Fiber_Link';
        servFattib.oppChildIRUDevName__c = 'PO_Oppty_IRU';
        servFattib.oppChildName__c = 'Offerta Collegamento';
        servFattib.oppChildP2PBaseDevName__c = 'PO_Oppty_collegamenti';
        servFattib.oppChildStageName__c = 'Prospecting';
        servFattib.oppParentDevNames__c = 'PO_Oppty_Richiesta_fattibilit,PO_Oppty_Richiesta_fattibilit_Evento_Temporaneo,PO_Oppty_Richiesta_fattibilit_Fiber_Lease,PO_Oppty_Richiesta_fattibilit_Fiber_Link,PO_Oppty_Richiesta_fattibilit_IRU,PO_Oppty_Richiesta_fattibilit_Misto_Lease_Link_per_FW';
        servFattib.oppParentDurationDays__c = 150;
        servFattib.oppParentEvtTempDevName__c = 'PO_Oppty_Richiesta_fattibilit_Evento_Temporaneo';
        servFattib.oppParentFiberLeaseDevName__c = 'PO_Oppty_Richiesta_fattibilit_Fiber_Lease';
        servFattib.oppParentFiberLeaseMistoDevName__c = 'PO_Oppty_Richiesta_fattibilit_Misto_Lease_Link_per_FW';
        servFattib.oppParentFiberLinkDevName__c = 'PO_Oppty_Richiesta_fattibilit_Fiber_Link';
        servFattib.oppParentIRUDevName__c = 'PO_Oppty_Richiesta_fattibilit_IRU';
        servFattib.oppParentName__c = 'Offerta Totale';
        servFattib.oppParentP2PBaseDevName__c = 'PO_Oppty_Richiesta_fattibilit';
        servFattib.oppParentStageName__c = 'Prospecting';
        
        insert servFattib;
    }
*/
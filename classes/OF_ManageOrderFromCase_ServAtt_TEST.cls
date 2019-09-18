@IsTest
public class OF_ManageOrderFromCase_ServAtt_TEST {


    public static testmethod void method1 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        contract con = new contract();
        con.Accountid = TestDataFactory.AccOLO.id;
        con.Name = 'test';
        con.status ='attivo';
                
        insert con;
        system.debug('Il contract ha id:' +con.id);
        
        order o = new order();
		o.OF_TipologiaDiServizio__c ='Attivo';
        o.EffectiveDate =system.today();
        o.Status ='Aperto';
        o.OF_DataEsito__c=system.today();
        o.OF_CodiceKO__c ='';
        o.OF_DescrizioneKO__c ='';
        o.OF_Esito__c ='';
        o.OF_IDOrdineOLO__c ='';
        o.OF_IDOrdineEOF__c ='';
        o.OF_IDRisorsa__c ='';
        o.AccountId = TestDataFactory.AccOLO.id;
        o.OF_IDBuilding__c = 'Test';
        o.OF_Asset__c =TestDataFactory.ast[1].id;
        o.OF_SlaPremiumAssurance__c ='';
        o.OF_Apparato__c ='';
        o.OF_EsitoConsegnaApparato__c ='';
        o.OF_ProgettoSpeciale__c ='';
        o.OF_TipologiaApparato__c ='';
        o.OF_PasswordApparato__c ='';
        o.ContractId = con.id;
        o.OF_CaseID__c =''; // ???????????????
        o.OF_CaseNome__c ='';
        o.OF_IDServizio__c ='';
        o.OF_Profilo__c ='';
        o.OF_ProfiloOpenStream__c ='';
        o.OF_Promozione__c ='';
        o.OF_CodiceProgettoSpeciale__c ='';
        o.OF_ClusterPromozione__c ='';
        o.OF_IdentificativoDelPOP__c ='';
        o.OF_GPONAttestazione__c ='';
        o.OF_Comune__c ='';
        o.OF_Provincia__c ='';
        o.PO_IsFromOpportunity__c = false;
		o.OF_ParticellaToponomastica__c ='';
		o.OF_Indirizzo__c='';
		o.OF_Civico__c ='';
		o.OF_ScalaPalazzina__c ='';
		o.OF_IDSplitterSecondario__c ='';
		o.OF_PosizioneSplitterSecondario__c ='';       
        o.RecordTypeId =OF_SA_GE_Utils.rtMap.get('OF_INORDER');
                
        insert o;
		system.debug('Il recortype id è:'+o.RecordTypeId);
        system.debug('Il OF_Type__c è:'+o.OF_Type__c);
        
        order ord = [select Id,RecordType.name,Recordtype.DeveloperName,OF_Type__c,OF_TipologiaDiServizio__c,EffectiveDate,OF_SlaPremiumAssurance__c,Status,OF_Asset__c,OF_IDBuilding__c,OF_DataEsito__c,OF_CodiceKO__c,OF_DescrizioneKO__c,AccountId,OF_Esito__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IDRisorsa__c,OF_Apparato__c,OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                     OF_PasswordApparato__c,OF_IDCaso__c,OF_PosizioneSplitterSecondario__c,OF_IDSplitterSecondario__c,OF_ScalaPalazzina__c,OF_Indirizzo__c,OF_Civico__c,OF_ParticellaToponomastica__c,ContractId,OF_CaseID__c,OF_CaseNome__c,OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,PO_IsFromOpportunity__c from Order where id=:o.id];

        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c1);
        msa.TipoServ(TestDataFactory.c1);
        msa.CreateClienteRetail(TestDataFactory.c1.id,TestDataFactory.ast[1].id);
        
        TestDataFactory.c1.status='Acquisito';
        TestDataFactory.c1.OF_Order__c= ord.id;
        update testDataFactory.c1;
        
        msa.creazioneOrdine(TestDataFactory.c1,'OF_INORDER');
        msa.AggiornoOrdine(TestDataFactory.c1);
        msa.GestioneServiziAttiviAttivazione(TestDataFactory.c1,ord);
        
        test.stopTest();
    }

    public static testmethod void method1_1 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        contract con = new contract();
        con.Accountid = TestDataFactory.AccOLO.id;
        con.Name = 'test';
        con.status ='attivo';
                
        insert con;
        system.debug('Il contract ha id:' +con.id);
        
        order o = new order();
		o.OF_TipologiaDiServizio__c ='Attivo';
        o.EffectiveDate =system.today();
        o.Status ='Aperto';
        o.OF_DataEsito__c=system.today();
        o.OF_CodiceKO__c ='';
        o.OF_DescrizioneKO__c ='';
        o.OF_Esito__c ='';
        o.OF_IDOrdineOLO__c ='';
        o.OF_IDOrdineEOF__c ='';
        o.OF_IDRisorsa__c ='';
        o.AccountId = TestDataFactory.AccOLO.id;
        o.OF_IDBuilding__c = 'Test';
        o.OF_Asset__c =TestDataFactory.ast[1].id;
        o.OF_SlaPremiumAssurance__c ='';
        o.OF_Apparato__c ='';
        o.OF_EsitoConsegnaApparato__c ='';
        o.OF_ProgettoSpeciale__c ='';
        o.OF_TipologiaApparato__c ='';
        o.OF_PasswordApparato__c ='';
        o.ContractId = con.id;
        o.OF_CaseID__c =''; // ???????????????
        o.OF_CaseNome__c ='';
        o.OF_IDServizio__c ='';
        o.OF_Profilo__c ='';
        o.OF_ProfiloOpenStream__c ='';
        o.OF_Promozione__c ='';
        o.OF_CodiceProgettoSpeciale__c ='';
        o.OF_ClusterPromozione__c ='';
        o.OF_IdentificativoDelPOP__c ='';
        o.OF_GPONAttestazione__c ='';
        o.OF_Comune__c ='';
        o.OF_Provincia__c ='';
        o.PO_IsFromOpportunity__c = false;
		o.OF_ParticellaToponomastica__c ='';
		o.OF_Indirizzo__c='';
		o.OF_Civico__c ='';
		o.OF_ScalaPalazzina__c ='';
		o.OF_IDSplitterSecondario__c ='';
		o.OF_PosizioneSplitterSecondario__c ='';       
        o.RecordTypeId =OF_SA_GE_Utils.rtMap.get('OF_INORDER');
                
        insert o;
		system.debug('Il recortype id è:'+o.RecordTypeId);
        system.debug('Il OF_Type__c è:'+o.OF_Type__c);
        
        order ord = [select Id,RecordType.name,Recordtype.DeveloperName,OF_Type__c,OF_TipologiaDiServizio__c,EffectiveDate,OF_SlaPremiumAssurance__c,Status,OF_Asset__c,OF_IDBuilding__c,OF_DataEsito__c,OF_CodiceKO__c,OF_DescrizioneKO__c,AccountId,OF_Esito__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IDRisorsa__c,OF_Apparato__c,OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                     OF_PasswordApparato__c,OF_IDCaso__c,OF_PosizioneSplitterSecondario__c,OF_IDSplitterSecondario__c,OF_ScalaPalazzina__c,OF_Indirizzo__c,OF_Civico__c,OF_ParticellaToponomastica__c,ContractId,OF_CaseID__c,OF_CaseNome__c,OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,PO_IsFromOpportunity__c from Order where id=:o.id];

        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c1);
        msa.TipoServ(TestDataFactory.c1);
        msa.CreateClienteRetail(TestDataFactory.c1.id,TestDataFactory.ast[1].id);
        
        TestDataFactory.c1.status='Espletato KO';
        TestDataFactory.c1.OF_Order__c= ord.id;
        update testDataFactory.c1;
        
        msa.creazioneOrdine(TestDataFactory.c1,'OF_INORDER');
        msa.AggiornoOrdine(TestDataFactory.c1);
        //msa.GestioneServiziAttiviAttivazione(TestDataFactory.c1,ord);
        
        test.stopTest();
    }
    
    public static testmethod void method2 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Cessazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        contract con = new contract();
        con.Accountid = TestDataFactory.AccOLO.id;
        con.Name = 'test';
        con.status ='attivo';
                
        insert con;
        system.debug('Il contract ha id:' +con.id);
        
        order o = new order();
		o.OF_TipologiaDiServizio__c ='Attivo';
        o.EffectiveDate =system.today();
        o.Status ='Aperto';
        o.OF_DataEsito__c=system.today();
        o.OF_CodiceKO__c ='';
        o.OF_DescrizioneKO__c ='';
        o.OF_Esito__c ='';
        o.OF_IDOrdineOLO__c ='';
        o.OF_IDOrdineEOF__c ='';
        o.OF_IDRisorsa__c ='';
        o.AccountId = TestDataFactory.AccOLO.id;
        o.OF_IDBuilding__c = 'Test';
        o.OF_Asset__c =TestDataFactory.ast[1].id;
        o.OF_SlaPremiumAssurance__c ='';
        o.OF_Apparato__c ='';
        o.OF_EsitoConsegnaApparato__c ='';
        o.OF_ProgettoSpeciale__c ='';
        o.OF_TipologiaApparato__c ='';
        o.OF_PasswordApparato__c ='';
        o.ContractId = con.id;
        o.OF_CaseID__c =''; // ???????????????
        o.OF_CaseNome__c ='';
        o.OF_IDServizio__c ='';
        o.OF_Profilo__c ='';
        o.OF_ProfiloOpenStream__c ='';
        o.OF_Promozione__c ='';
        o.OF_CodiceProgettoSpeciale__c ='';
        o.OF_ClusterPromozione__c ='';
        o.OF_IdentificativoDelPOP__c ='';
        o.OF_GPONAttestazione__c ='';
        o.OF_Comune__c ='';
        o.OF_Provincia__c ='';
        o.PO_IsFromOpportunity__c = false;
		o.OF_ParticellaToponomastica__c ='';
		o.OF_Indirizzo__c='';
		o.OF_Civico__c ='';
		o.OF_ScalaPalazzina__c ='';
		o.OF_IDSplitterSecondario__c ='';
		o.OF_PosizioneSplitterSecondario__c ='';             
        o.RecordTypeId =OF_SA_GE_Utils.rtMap.get('OF_OUTORDER');
                
        insert o;
		system.debug('Il recortype id è:'+o.RecordTypeId);
        system.debug('Il OF_Type__c è:'+o.OF_Type__c);
        
        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c2);
        
        TestDataFactory.c2.status='Cessato KO';
        update testDataFactory.c2;
        
        order ord = [select Id,RecordType.name,Recordtype.DeveloperName,OF_Type__c,OF_TipologiaDiServizio__c,EffectiveDate,OF_SlaPremiumAssurance__c,Status,OF_Asset__c,OF_IDBuilding__c,OF_DataEsito__c,OF_CodiceKO__c,OF_DescrizioneKO__c,AccountId,OF_Esito__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IDRisorsa__c,OF_Apparato__c,OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                     OF_PasswordApparato__c,OF_IDCaso__c,OF_PosizioneSplitterSecondario__c,OF_IDSplitterSecondario__c,OF_ScalaPalazzina__c,OF_Indirizzo__c,OF_Civico__c,OF_ParticellaToponomastica__c,ContractId,OF_CaseID__c,OF_CaseNome__c,OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,PO_IsFromOpportunity__c from Order where id=:o.id];
        

        msa.creazioneOrdine(TestDataFactory.c2,'OF_OUTORDER');
        msa.GestioneServiziAttiviCessazione(TestDataFactory.c2,o,1);
        
        test.stopTest();
    }

    public static testmethod void method3 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c1);
        
        TestDataFactory.c1.status='Acquisito KO';
        update testDataFactory.c1;
        
        msa.creazioneOrdine(TestDataFactory.c1,'OF_INORDER');
        
        test.stopTest();
    }

    public static testmethod void method4 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Cessazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        contract con = new contract();
        con.Accountid = TestDataFactory.AccOLO.id;
        con.Name = 'test';
        con.status ='attivo';
                
        insert con;
        system.debug('Il contract ha id:' +con.id);
        
        order o = new order();
		o.OF_TipologiaDiServizio__c ='Attivo';
        o.EffectiveDate =system.today();
        o.Status ='Aperto';
        o.OF_DataEsito__c=system.today();
        o.OF_CodiceKO__c ='';
        o.OF_DescrizioneKO__c ='';
        o.OF_Esito__c ='';
        o.OF_IDOrdineOLO__c ='';
        o.OF_IDOrdineEOF__c ='';
        o.OF_IDRisorsa__c ='';
        o.AccountId = TestDataFactory.AccOLO.id;
        o.OF_IDBuilding__c = 'Test';
        o.OF_Asset__c =TestDataFactory.ast[1].id;
        o.OF_SlaPremiumAssurance__c ='';
        o.OF_Apparato__c ='';
        o.OF_EsitoConsegnaApparato__c ='';
        o.OF_ProgettoSpeciale__c ='';
        o.OF_TipologiaApparato__c ='';
        o.OF_PasswordApparato__c ='';
        o.ContractId = con.id;
        o.OF_CaseID__c =''; // ???????????????
        o.OF_CaseNome__c ='';
        o.OF_IDServizio__c ='';
        o.OF_Profilo__c ='';
        o.OF_ProfiloOpenStream__c ='';
        o.OF_Promozione__c ='';
        o.OF_CodiceProgettoSpeciale__c ='';
        o.OF_ClusterPromozione__c ='';
        o.OF_IdentificativoDelPOP__c ='';
        o.OF_GPONAttestazione__c ='';
        o.OF_Comune__c ='';
        o.OF_Provincia__c ='';
        o.PO_IsFromOpportunity__c = false;
		o.OF_ParticellaToponomastica__c ='';
		o.OF_Indirizzo__c='';
		o.OF_Civico__c ='';
		o.OF_ScalaPalazzina__c ='';
		o.OF_IDSplitterSecondario__c ='';
		o.OF_PosizioneSplitterSecondario__c ='';       
        o.RecordTypeId =OF_SA_GE_Utils.rtMap.get('OF_OUTORDER');
                
        insert o;
        
        order ord = [select Id,RecordType.name,Recordtype.DeveloperName,OF_Type__c,OF_TipologiaDiServizio__c,EffectiveDate,OF_SlaPremiumAssurance__c,Status,OF_Asset__c,OF_IDBuilding__c,OF_DataEsito__c,OF_CodiceKO__c,OF_DescrizioneKO__c,AccountId,OF_Esito__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IDRisorsa__c,OF_Apparato__c,OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                     OF_PasswordApparato__c,OF_IDCaso__c,OF_PosizioneSplitterSecondario__c,OF_IDSplitterSecondario__c,OF_ScalaPalazzina__c,OF_Indirizzo__c,OF_Civico__c,OF_ParticellaToponomastica__c,ContractId,OF_CaseID__c,OF_CaseNome__c,OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,PO_IsFromOpportunity__c from Order where id=:o.id];
        
		system.debug('Il recortype id è:'+o.RecordTypeId);
        system.debug('Il OF_Type__c è:'+o.OF_Type__c);
        system.debug('Il contract id per ordine è:'+o.ContractId);
        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c2);
        
        TestDataFactory.c2.status='Cessato KO';
        update testDataFactory.c2;

        msa.creazioneOrdine(TestDataFactory.c2,'OF_OUTORDER');
        
        ord.status ='Chiuso';
        ord.OF_Esito__c ='OK';
        update ord;
        
        msa.GestioneServiziAttiviCessazione(TestDataFactory.c2,ord,0);
        
        test.stopTest();
    }

    public static testmethod void method5 (){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c);
        
        TestDataFactory.c.status='Acquisito KO';
        update testDataFactory.c;
        
        msa.creazioneOrdine(TestDataFactory.c,'OF_INORDER');
        
        test.stopTest();
    }

    public static testmethod void method6 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        
        contract con = new contract();
        con.Accountid = TestDataFactory.AccOLO.id;
        con.Name = 'test';
        con.status ='attivo';
                
        insert con;

        
        order o = new order();
		o.OF_TipologiaDiServizio__c ='Attivo';
        o.EffectiveDate =system.today();
        o.Status ='Aperto';
        o.OF_DataEsito__c=system.today();
        o.OF_CodiceKO__c ='';
        o.OF_DescrizioneKO__c ='';
        o.OF_Esito__c ='';
        o.OF_IDOrdineOLO__c ='';
        o.OF_IDOrdineEOF__c ='';
        o.OF_IDRisorsa__c ='';
        o.AccountId = TestDataFactory.AccOLO.id;
        o.OF_IDBuilding__c = 'Test';
        o.OF_Asset__c =TestDataFactory.ast[1].id;
        o.OF_SlaPremiumAssurance__c ='';
        o.OF_Apparato__c ='';
        o.OF_EsitoConsegnaApparato__c ='';
        o.OF_ProgettoSpeciale__c ='';
        o.OF_TipologiaApparato__c ='';
        o.OF_PasswordApparato__c ='';
        o.ContractId = con.id;
        o.OF_CaseID__c =''; // ???????????????
        o.OF_CaseNome__c ='';
        o.OF_IDServizio__c ='';
        o.OF_Profilo__c ='';
        o.OF_ProfiloOpenStream__c ='';
        o.OF_Promozione__c ='';
        o.OF_CodiceProgettoSpeciale__c ='';
        o.OF_ClusterPromozione__c ='';
        o.OF_IdentificativoDelPOP__c ='';
        o.OF_GPONAttestazione__c ='';
        o.OF_Comune__c ='';
        o.OF_Provincia__c ='';
        o.PO_IsFromOpportunity__c = false;
		o.OF_ParticellaToponomastica__c ='';
		o.OF_Indirizzo__c='';
		o.OF_Civico__c ='';
		o.OF_ScalaPalazzina__c ='';
		o.OF_IDSplitterSecondario__c ='';
		o.OF_PosizioneSplitterSecondario__c ='';       
        o.RecordTypeId =OF_SA_GE_Utils.rtMap.get('OF_INORDER');
                
        insert o;        

        order ord = [select Id,RecordType.name,Recordtype.DeveloperName,OF_Type__c,OF_TipologiaDiServizio__c,EffectiveDate,OF_SlaPremiumAssurance__c,Status,OF_Asset__c,OF_IDBuilding__c,OF_DataEsito__c,OF_CodiceKO__c,OF_DescrizioneKO__c,AccountId,OF_Esito__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IDRisorsa__c,OF_Apparato__c,OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                     OF_PasswordApparato__c,OF_IDCaso__c,OF_PosizioneSplitterSecondario__c,OF_IDSplitterSecondario__c,OF_ScalaPalazzina__c,OF_Indirizzo__c,OF_Civico__c,OF_ParticellaToponomastica__c,ContractId,OF_CaseID__c,OF_CaseNome__c,OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,PO_IsFromOpportunity__c from Order where id=:o.id];

        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c1);
        
        TestDataFactory.c1.status='Espletato';
        TestDataFactory.c1.OF_Order__c= ord.id;        
        update testDataFactory.c1;
        
        msa.AggiornoOrdine(TestDataFactory.c1);
        
        test.stopTest();
    }

    public static testmethod void method7 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        
        contract con = new contract();
        con.Accountid = TestDataFactory.AccOLO.id;
        con.Name = 'test';
        con.status ='attivo';
                
        insert con;

        
        order o = new order();
		o.OF_TipologiaDiServizio__c ='Attivo';
        o.EffectiveDate =system.today();
        o.Status ='Aperto';
        o.OF_DataEsito__c=system.today();
        o.OF_CodiceKO__c ='';
        o.OF_DescrizioneKO__c ='';
        o.OF_Esito__c ='';
        o.OF_IDOrdineOLO__c ='';
        o.OF_IDOrdineEOF__c ='';
        o.OF_IDRisorsa__c ='';
        o.AccountId = TestDataFactory.AccOLO.id;
        o.OF_IDBuilding__c = 'Test';
        o.OF_Asset__c =TestDataFactory.ast[1].id;
        o.OF_SlaPremiumAssurance__c ='';
        o.OF_Apparato__c ='';
        o.OF_EsitoConsegnaApparato__c ='';
        o.OF_ProgettoSpeciale__c ='';
        o.OF_TipologiaApparato__c ='';
        o.OF_PasswordApparato__c ='';
        o.ContractId = con.id;
        o.OF_CaseID__c =''; // ???????????????
        o.OF_CaseNome__c ='';
        o.OF_IDServizio__c ='';
        o.OF_Profilo__c ='';
        o.OF_ProfiloOpenStream__c ='';
        o.OF_Promozione__c ='';
        o.OF_CodiceProgettoSpeciale__c ='';
        o.OF_ClusterPromozione__c ='';
        o.OF_IdentificativoDelPOP__c ='';
        o.OF_GPONAttestazione__c ='';
        o.OF_Comune__c ='';
        o.OF_Provincia__c ='';
        o.PO_IsFromOpportunity__c = false;
		o.OF_ParticellaToponomastica__c ='';
		o.OF_Indirizzo__c='';
		o.OF_Civico__c ='';
		o.OF_ScalaPalazzina__c ='';
		o.OF_IDSplitterSecondario__c ='';
		o.OF_PosizioneSplitterSecondario__c ='';       
        o.RecordTypeId =OF_SA_GE_Utils.rtMap.get('OF_INORDER');
                
        insert o;        

        order ord = [select Id,RecordType.name,Recordtype.DeveloperName,OF_Type__c,OF_TipologiaDiServizio__c,EffectiveDate,OF_SlaPremiumAssurance__c,Status,OF_Asset__c,OF_IDBuilding__c,OF_DataEsito__c,OF_CodiceKO__c,OF_DescrizioneKO__c,AccountId,OF_Esito__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IDRisorsa__c,OF_Apparato__c,OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                     OF_PasswordApparato__c,OF_IDCaso__c,OF_PosizioneSplitterSecondario__c,OF_IDSplitterSecondario__c,OF_ScalaPalazzina__c,OF_Indirizzo__c,OF_Civico__c,OF_ParticellaToponomastica__c,ContractId,OF_CaseID__c,OF_CaseNome__c,OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,PO_IsFromOpportunity__c from Order where id=:o.id];

        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c1);
        
        TestDataFactory.c1.status='Espletato KO';
        TestDataFactory.c1.OF_Order__c= ord.id;        
        update testDataFactory.c1;
        
        msa.AggiornoOrdine(TestDataFactory.c1);
        
        test.stopTest();
    }

    public static testmethod void method8 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        
        contract con = new contract();
        con.Accountid = TestDataFactory.AccOLO.id;
        con.Name = 'test';
        con.status ='attivo';
                
        insert con;

        
        order o = new order();
		o.OF_TipologiaDiServizio__c ='Attivo';
        o.EffectiveDate =system.today();
        o.Status ='Aperto';
        o.OF_DataEsito__c=system.today();
        o.OF_CodiceKO__c ='';
        o.OF_DescrizioneKO__c ='';
        o.OF_Esito__c ='';
        o.OF_IDOrdineOLO__c ='';
        o.OF_IDOrdineEOF__c ='';
        o.OF_IDRisorsa__c ='';
        o.AccountId = TestDataFactory.AccOLO.id;
        o.OF_IDBuilding__c = 'Test';
        o.OF_Asset__c =TestDataFactory.ast[1].id;
        o.OF_SlaPremiumAssurance__c ='';
        o.OF_Apparato__c ='';
        o.OF_EsitoConsegnaApparato__c ='';
        o.OF_ProgettoSpeciale__c ='';
        o.OF_TipologiaApparato__c ='';
        o.OF_PasswordApparato__c ='';
        o.ContractId = con.id;
        o.OF_CaseID__c =''; // ???????????????
        o.OF_CaseNome__c ='';
        o.OF_IDServizio__c ='';
        o.OF_Profilo__c ='';
        o.OF_ProfiloOpenStream__c ='';
        o.OF_Promozione__c ='';
        o.OF_CodiceProgettoSpeciale__c ='';
        o.OF_ClusterPromozione__c ='';
        o.OF_IdentificativoDelPOP__c ='';
        o.OF_GPONAttestazione__c ='';
        o.OF_Comune__c ='';
        o.OF_Provincia__c ='';
        o.PO_IsFromOpportunity__c = false;
		o.OF_ParticellaToponomastica__c ='';
		o.OF_Indirizzo__c='';
		o.OF_Civico__c ='';
		o.OF_ScalaPalazzina__c ='';
		o.OF_IDSplitterSecondario__c ='';
		o.OF_PosizioneSplitterSecondario__c ='';       
        o.RecordTypeId =OF_SA_GE_Utils.rtMap.get('OF_INORDER');
                
        insert o;        

        order ord = [select Id,RecordType.name,Recordtype.DeveloperName,OF_Type__c,OF_TipologiaDiServizio__c,EffectiveDate,OF_SlaPremiumAssurance__c,Status,OF_Asset__c,OF_IDBuilding__c,OF_DataEsito__c,OF_CodiceKO__c,OF_DescrizioneKO__c,AccountId,OF_Esito__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IDRisorsa__c,OF_Apparato__c,OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                     OF_PasswordApparato__c,OF_IDCaso__c,OF_PosizioneSplitterSecondario__c,OF_IDSplitterSecondario__c,OF_ScalaPalazzina__c,OF_Indirizzo__c,OF_Civico__c,OF_ParticellaToponomastica__c,ContractId,OF_CaseID__c,OF_CaseNome__c,OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,PO_IsFromOpportunity__c from Order where id=:o.id];

        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c1);
        
        TestDataFactory.c1.status='Annullato';
        TestDataFactory.c1.OF_Order__c= ord.id;        
        update testDataFactory.c1;
        
        msa.AggiornoOrdine(TestDataFactory.c1);
        
        test.stopTest();
    }

    public static testmethod void method9 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        
        contract con = new contract();
        con.Accountid = TestDataFactory.AccOLO.id;
        con.Name = 'test';
        con.status ='attivo';
                
        insert con;

        
        order o = new order();
		o.OF_TipologiaDiServizio__c ='Attivo';
        o.EffectiveDate =system.today();
        o.Status ='Aperto';
        o.OF_DataEsito__c=system.today();
        o.OF_CodiceKO__c ='';
        o.OF_DescrizioneKO__c ='';
        o.OF_Esito__c ='';
        o.OF_IDOrdineOLO__c ='';
        o.OF_IDOrdineEOF__c ='';
        o.OF_IDRisorsa__c ='';
        o.AccountId = TestDataFactory.AccOLO.id;
        o.OF_IDBuilding__c = 'Test';
        o.OF_Asset__c =TestDataFactory.ast[1].id;
        o.OF_SlaPremiumAssurance__c ='';
        o.OF_Apparato__c ='';
        o.OF_EsitoConsegnaApparato__c ='';
        o.OF_ProgettoSpeciale__c ='';
        o.OF_TipologiaApparato__c ='';
        o.OF_PasswordApparato__c ='';
        o.ContractId = con.id;
        o.OF_CaseID__c =''; // ???????????????
        o.OF_CaseNome__c ='';
        o.OF_IDServizio__c ='';
        o.OF_Profilo__c ='';
        o.OF_ProfiloOpenStream__c ='';
        o.OF_Promozione__c ='';
        o.OF_CodiceProgettoSpeciale__c ='';
        o.OF_ClusterPromozione__c ='';
        o.OF_IdentificativoDelPOP__c ='';
        o.OF_GPONAttestazione__c ='';
        o.OF_Comune__c ='';
        o.OF_Provincia__c ='';
        o.PO_IsFromOpportunity__c = false;
		o.OF_ParticellaToponomastica__c ='';
		o.OF_Indirizzo__c='';
		o.OF_Civico__c ='';
		o.OF_ScalaPalazzina__c ='';
		o.OF_IDSplitterSecondario__c ='';
		o.OF_PosizioneSplitterSecondario__c ='';       
        o.RecordTypeId =OF_SA_GE_Utils.rtMap.get('OF_INORDER');
                
        insert o;        

        order ord = [select Id,RecordType.name,Recordtype.DeveloperName,OF_Type__c,OF_TipologiaDiServizio__c,EffectiveDate,OF_SlaPremiumAssurance__c,Status,OF_Asset__c,OF_IDBuilding__c,OF_DataEsito__c,OF_CodiceKO__c,OF_DescrizioneKO__c,AccountId,OF_Esito__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IDRisorsa__c,OF_Apparato__c,OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                     OF_PasswordApparato__c,OF_IDCaso__c,OF_PosizioneSplitterSecondario__c,OF_IDSplitterSecondario__c,OF_ScalaPalazzina__c,OF_Indirizzo__c,OF_Civico__c,OF_ParticellaToponomastica__c,ContractId,OF_CaseID__c,OF_CaseNome__c,OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,PO_IsFromOpportunity__c from Order where id=:o.id];

        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c1);
        
        TestDataFactory.c1.status='Accettato KO';
        TestDataFactory.c1.OF_Order__c= ord.id;        
        update testDataFactory.c1;
        
        msa.AggiornoOrdine(TestDataFactory.c1);
        
        test.stopTest();
    }

    public static testmethod void method10 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        
        contract con = new contract();
        con.Accountid = TestDataFactory.AccOLO.id;
        con.Name = 'test';
        con.status ='attivo';
                
        insert con;

        
        order o = new order();
		o.OF_TipologiaDiServizio__c ='Attivo';
        o.EffectiveDate =system.today();
        o.Status ='Aperto';
        o.OF_DataEsito__c=system.today();
        o.OF_CodiceKO__c ='';
        o.OF_DescrizioneKO__c ='';
        o.OF_Esito__c ='';
        o.OF_IDOrdineOLO__c ='';
        o.OF_IDOrdineEOF__c ='';
        o.OF_IDRisorsa__c ='';
        o.AccountId = TestDataFactory.AccOLO.id;
        o.OF_IDBuilding__c = 'Test';
        o.OF_Asset__c =TestDataFactory.ast[1].id;
        o.OF_SlaPremiumAssurance__c ='';
        o.OF_Apparato__c ='';
        o.OF_EsitoConsegnaApparato__c ='';
        o.OF_ProgettoSpeciale__c ='';
        o.OF_TipologiaApparato__c ='';
        o.OF_PasswordApparato__c ='';
        o.ContractId = con.id;
        o.OF_CaseID__c =''; // ???????????????
        o.OF_CaseNome__c ='';
        o.OF_IDServizio__c ='';
        o.OF_Profilo__c ='';
        o.OF_ProfiloOpenStream__c ='';
        o.OF_Promozione__c ='';
        o.OF_CodiceProgettoSpeciale__c ='';
        o.OF_ClusterPromozione__c ='';
        o.OF_IdentificativoDelPOP__c ='';
        o.OF_GPONAttestazione__c ='';
        o.OF_Comune__c ='';
        o.OF_Provincia__c ='';
        o.PO_IsFromOpportunity__c = false;
		o.OF_ParticellaToponomastica__c ='';
		o.OF_Indirizzo__c='';
		o.OF_Civico__c ='';
		o.OF_ScalaPalazzina__c ='';
		o.OF_IDSplitterSecondario__c ='';
		o.OF_PosizioneSplitterSecondario__c ='';       
        o.RecordTypeId =OF_SA_GE_Utils.rtMap.get('OF_INORDER');
                
        insert o;        

        order ord = [select Id,RecordType.name,Recordtype.DeveloperName,OF_Type__c,OF_TipologiaDiServizio__c,EffectiveDate,OF_SlaPremiumAssurance__c,Status,OF_Asset__c,OF_IDBuilding__c,OF_DataEsito__c,OF_CodiceKO__c,OF_DescrizioneKO__c,AccountId,OF_Esito__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IDRisorsa__c,OF_Apparato__c,OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                     OF_PasswordApparato__c,OF_IDCaso__c,OF_PosizioneSplitterSecondario__c,OF_IDSplitterSecondario__c,OF_ScalaPalazzina__c,OF_Indirizzo__c,OF_Civico__c,OF_ParticellaToponomastica__c,ContractId,OF_CaseID__c,OF_CaseNome__c,OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,PO_IsFromOpportunity__c from Order where id=:o.id];

        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c1);
        
        TestDataFactory.c1.status='Cessato';
        TestDataFactory.c1.OF_Order__c= ord.id;        
        update testDataFactory.c1;
        
        msa.AggiornoOrdine(TestDataFactory.c1);
        
        test.stopTest();
    }

    public static testmethod void method11 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();

        
        contract con = new contract();
        con.Accountid = TestDataFactory.AccOLO.id;
        con.Name = 'test';
        con.status ='attivo';
                
        insert con;

        
        order o = new order();
		o.OF_TipologiaDiServizio__c ='Attivo';
        o.EffectiveDate =system.today();
        o.Status ='Aperto';
        o.OF_DataEsito__c=system.today();
        o.OF_CodiceKO__c ='';
        o.OF_DescrizioneKO__c ='';
        o.OF_Esito__c ='';
        o.OF_IDOrdineOLO__c ='';
        o.OF_IDOrdineEOF__c ='';
        o.OF_IDRisorsa__c ='';
        o.AccountId = TestDataFactory.AccOLO.id;
        o.OF_IDBuilding__c = 'Test';
        o.OF_Asset__c =TestDataFactory.ast[1].id;
        o.OF_SlaPremiumAssurance__c ='';
        o.OF_Apparato__c ='';
        o.OF_EsitoConsegnaApparato__c ='';
        o.OF_ProgettoSpeciale__c ='';
        o.OF_TipologiaApparato__c ='';
        o.OF_PasswordApparato__c ='';
        o.ContractId = con.id;
        o.OF_CaseID__c =''; // ???????????????
        o.OF_CaseNome__c ='';
        o.OF_IDServizio__c ='';
        o.OF_Profilo__c ='';
        o.OF_ProfiloOpenStream__c ='';
        o.OF_Promozione__c ='';
        o.OF_CodiceProgettoSpeciale__c ='';
        o.OF_ClusterPromozione__c ='';
        o.OF_IdentificativoDelPOP__c ='';
        o.OF_GPONAttestazione__c ='';
        o.OF_Comune__c ='';
        o.OF_Provincia__c ='';
        o.PO_IsFromOpportunity__c = false;
		o.OF_ParticellaToponomastica__c ='';
		o.OF_Indirizzo__c='';
		o.OF_Civico__c ='';
		o.OF_ScalaPalazzina__c ='';
		o.OF_IDSplitterSecondario__c ='';
		o.OF_PosizioneSplitterSecondario__c ='';       
        o.RecordTypeId =OF_SA_GE_Utils.rtMap.get('OF_INORDER');
                
        insert o;      
        

        order ord = [select Id,RecordType.name,Recordtype.DeveloperName,OF_Type__c,OF_TipologiaDiServizio__c,EffectiveDate,OF_SlaPremiumAssurance__c,Status,OF_Asset__c,OF_IDBuilding__c,OF_DataEsito__c,OF_CodiceKO__c,OF_DescrizioneKO__c,AccountId,OF_Esito__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IDRisorsa__c,OF_Apparato__c,OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                     OF_PasswordApparato__c,OF_IDCaso__c,OF_PosizioneSplitterSecondario__c,OF_IDSplitterSecondario__c,OF_ScalaPalazzina__c,OF_Indirizzo__c,OF_Civico__c,OF_ParticellaToponomastica__c,ContractId,OF_CaseID__c,OF_CaseNome__c,OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,PO_IsFromOpportunity__c from Order where id=:o.id];

        
        test.startTest();
        OF_ManageOrderFromCase_ServiziAttivi msa = new OF_ManageOrderFromCase_ServiziAttivi();
        msa.ManageOrder(TestDataFactory.c1);
        
        TestDataFactory.c1.status='Cessato OK';
        TestDataFactory.c1.OF_Order__c= ord.id;        
        update testDataFactory.c1;
        
        msa.AggiornoOrdine(TestDataFactory.c1);
        
        test.stopTest();
    }

    
}
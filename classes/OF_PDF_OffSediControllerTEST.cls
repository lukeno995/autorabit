@isTest
public class OF_PDF_OffSediControllerTEST {
    
    @testSetup
    static void createData()
    {
        list<OF_FiberLeaseListinoPrezzoAnnuo__c> CustSett1 = new list<OF_FiberLeaseListinoPrezzoAnnuo__c>();
        CustSett1 = OF_AreaGeograficaUtilityTest.CustomSettingFibLease();
        
        list<OF_FiberLeasePrezzoMedioAnnuo__c> CustSett2 = new list<OF_FiberLeasePrezzoMedioAnnuo__c>();
        CustSett2 = OF_AreaGeograficaUtilityTest.CustomSettingFibLease1();
        
        insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;        
    }
    
    static testmethod void MetodoIRU()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità IRU').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty IRU').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
        contr.savePDF();
        contr.savePDF_FiberLink();
    }
    
    static testmethod void MetodoP2P()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty collegamenti').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
        //getNsRif(boolean isP2P, boolean isFiberLink, boolean isBackhauling, boolean isBTS, boolean isDarkFiber,boolean isP2PAttiva, boolean isP2PAttivaEline)
        contr.getNsRif(true,false,false,false,false,false,true);
    }
    
    //Durata affitto = 1
    static testmethod void MetodoFiberLink1()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Fiber Link').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Fiber Link').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Durata_affitto__c = 1,
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
        //getNsRif(boolean isP2P, boolean isFiberLink, boolean isBackhauling, boolean isBTS, boolean isDarkFiber,boolean isP2PAttiva, boolean isP2PAttivaEline)
        contr.getNsRif(false,true,false,false,false,false,false);
    }
    
    //Durata affitto = 2
    static testmethod void MetodoFiberLink2()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Fiber Link').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Fiber Link').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Durata_affitto__c = 2,
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    //Durata affitto = 3
    static testmethod void MetodoFiberLink3()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Fiber Link').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Fiber Link').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Durata_affitto__c = 3,
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    //Durata affitto > 3
    static testmethod void MetodoFiberLink4()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Fiber Link').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Fiber Link').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Durata_affitto__c = 4,
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Numero_Anni__c = 4,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    static testmethod void MetodoEventoTempo()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Evento Temporaneo').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Evento Temporaneo').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'            
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    static testmethod void MetodoEventoTempo1()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Evento Temporaneo').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Evento Temporaneo').getRecordTypeId();
        
        case cas1 = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Durata_mesi__c = 1
            );
        insert cas1;
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            name = 'Offerta totale',
            PO_Richiesta_fattibilit__c = cas1.id
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    static testmethod void MetodoFiberLease()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Fiber Lease').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Fiber Lease').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            PO_CostiCollegamento__c = 100,
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    static testmethod void MetodoFiberLeaseMisto()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Misto Lease-Link per FW').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Misto Lease-Link per FW').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            PO_CostiCollegamento__c = 100,
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
        
    }
    
    static testmethod void MetodoP2PAttiva(){
        string RTParentOppId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità P2P Attiva').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Oppty collegamenti P2P Attiva').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentOppId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
        contr.savePDF();
        contr.getNsRif(false,false,false,false,false,true,false);
    //    contr.savePDF_FiberLink();
    
    }
    
    static testmethod void MetodoP2PAttivaELINE(){
        string RTParentOppId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità P2P Attiva E-Line').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Oppty collegamenti P2P Attiva E-Line').getRecordTypeId();
        List<Case> ColP2PAttELine = new List<Case>();
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        ColP2PAttELine.add(cas);
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentOppId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
        contr.savePDF();
        contr.ColP2PAttELine=ColP2PAttELine;
 //getNsRif(boolean isP2P, boolean isFiberLink, boolean isBackhauling, boolean isBTS, boolean isDarkFiber,boolean isP2PAttiva, boolean isP2PAttivaEline)
        contr.getNsRif(false,false,false,false,false,false,true);
    //    contr.savePDF_FiberLink();
    
    }
    
    static testmethod void MetodoGen(){
        
        
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
        
        list<Case> CaseKit = new list<Case> ();
        CaseKit.add(tempKitCase);
    	list<EOF_EAI_Service_Log__c> CollLog = new list<EOF_EAI_Service_Log__c>();
        CollLog.add(sl);
    	list<EOF_EAI_Service_Log__c> VlanLogs = new list<EOF_EAI_Service_Log__c>();
        VlanLogs.add(sVlan1);
        string RTParentOppId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità P2P Attiva').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Oppty collegamenti P2P Attiva').getRecordTypeId();
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentOppId,
            PO_Richiesta_fattibilit__c = parentCase.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = ChildCase.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
     	Test.setCurrentPage(new PageReference('OF_PDF_OffSedi'));
        ApexPages.currentPage().getParameters().put('id',q.id);
        
        OF_PDF_OffSediController contr = new OF_PDF_OffSediController();
        List<Case> colCaseList = new List<Case>{ChildCase};
        test.startTest();
        contr.CollLog = CollLog;
       	contr.CaseKit = CaseKit;
       	contr.VlanLogs = VlanLogs;
        contr.RichiestaFattibil=parentCase.Id;
        contr.ColP2PAtt = colCaseList;
        contr.getOpportunity();
        contr.FindOppo(opp);
        contr.savePDF();
        //getNsRif(boolean isP2P, boolean isFiberLink, boolean isBackhauling, boolean isBTS, boolean isDarkFiber,boolean isP2PAttiva, boolean isP2PAttivaEline)
        contr.getNsRif(false,false,true,false,false,false,false);
        //getNsRif(boolean isP2P, boolean isFiberLink, boolean isBackhauling, boolean isBTS, boolean isDarkFiber,boolean isP2PAttiva, boolean isP2PAttivaEline)
        contr.getNsRif(false,false,false,true,false,false,false);
        //getNsRif(boolean isP2P, boolean isFiberLink, boolean isBackhauling, boolean isBTS, boolean isDarkFiber,boolean isP2PAttiva, boolean isP2PAttivaEline)
        contr.getNsRif(false,false,false,false,true,false,false);
        test.stopTest();
    }
}
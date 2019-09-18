@isTest
public class OF_GPONP_WS_IN_FTTH_IN_ORDER_Test {
    
    
    @testSetup static void setupMethod(){
        
        Transcodifica_OLO_Remedy__c tc = new Transcodifica_OLO_Remedy__c();
        tc.CustomerId__c = '2';
        tc.Nome_Remedy__c = 'Tiscali';
        tc.Name = 'Tiscali';
        tc.Ragione_Sociale__c = 'WIND TRE SPA'; 
        tc.Codice_Cliente_SAP__c = 'CI00000039';
        tc.Codice_Fiscale__c = '13378520152';
        tc.Partita_IVA__c = '13378520152';
        tc.Partita_IVA_CEE__c = 'IT13378520152';
        
        insert tc;

        Verticali__c cs2 = new Verticali__c();
		cs2.createNotifyBatchLimit__c = 10000;
		cs2.callWsBillingBatchSize__c = 4;
	
		cs2.RecordTypesAssets__c ='\'OF_Open_Stream\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'';
		
		insert cs2;
        
        Transcodifica_OLO_Remedy__c tc1 = new Transcodifica_OLO_Remedy__c();
        tc1.CustomerId__c = '3';
        tc1.Nome_Remedy__c = 'test';
        tc1.Name = 'test';
        tc1.Ragione_Sociale__c = 'test';
        tc1.Codice_Cliente_SAP__c = 'CI00000039';
        tc1.Codice_Fiscale__c = '13378520152';
        tc1.Partita_IVA__c = '13378520152';
        tc1.Partita_IVA_CEE__c = 'IT13378520152';
        
        insert tc1;
        
        Account acc = new Account();
        acc.Name = 'Tiscali';
        acc.type='OLO';
        insert acc;
                
        Account acc1 = new Account();
        acc1.Name = 'test';
        acc1.type='OLO';
        insert acc1;
        
        OF_CatalogoCommerciale__c comm = new OF_CatalogoCommerciale__c();
        comm.OF_Attivo__c = True;
        comm.Name = '0000';
        comm.OF_DataInizioValidita__c = Date.newInstance(2000, 1, 1);
        comm.OF_DataFineValidita__c = Date.newInstance(2099, 2, 17);
        
        insert comm;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        
        insert contratto;

        Contract contratto1 = new Contract();
        contratto1.OF_IdContratto__c = 'TEST_01';
        contratto1.AccountId = acc1.id;
        contratto1.Status = 'Attivo';
        contratto1.StartDate = System.today();
        
        insert contratto1;
        
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'GPON Passiva';
        serv.OF_Servizio_Code__c='123';
        serv.OF_CatalogoCommerciale__c = comm.Id;
        serv.OF_DataInizioValidita__c = Date.newInstance(2000, 2, 17);
        serv.OF_DataFineValidita__c = Date.newInstance(2099, 2, 17);
        insert serv;
        /*
        OF_Servizio__c serv1 = new OF_Servizio__c();
        serv1.Name = 'Open Stream';
        serv1.OF_Servizio_Code__c='456';
        serv1.OF_CatalogoCommerciale__c = comm.Id;
        serv1.OF_DataInizioValidita__c = Date.newInstance(2000, 2, 17); 
        serv1.OF_DataFineValidita__c = Date.newInstance(2099, 2, 17);
        insert serv1;
        */
        OF_ContrattoServizio__c conServ= new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=contratto1.id;
        conServ.OF_Servizio__c=serv.id;
        insert conServ;
        
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Servizio__c = serv.Id;
        cs.OF_Contract__c = contratto.Id;
        
        insert cs;
        
        OF_AreaGeograficaJunction__c arJun = new OF_AreaGeograficaJunction__c();
        arJun.OF_Contratto__c = contratto.Id;
        insert arJun;
       
        OF_AreaGeograficaJunction__c arJun1 = new OF_AreaGeograficaJunction__c();
        arJun.OF_Contratto__c = contratto1.Id;
        insert arJun1;
        
        String assetRecordTypeId1 = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'F1000006883';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = '02112016_37';
        asset_1.recordTypeId = assetRecordTypeId1;
        asset_1.accountId = acc.id;
        //asset_1.OF_DataAttivazione2__c= 2017-10-12T17:29:11+02:00;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;

       String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
        Asset asset_2 = new Asset();
        asset_2.Name = 'F183';
        asset_2.Status = 'Attivo';
        asset_2.EOF_ID_Risorsa__c = '0211201637';
        asset_2.recordTypeId = assetRecordTypeId;
        asset_2.accountId = acc1.id;
        asset_2.OF_Contract__c = contratto1.Id;
        insert asset_2;
        
        
        Order ordine1 = new Order();
        ordine1.OF_Asset__c = asset_2.id;
        ordine1.AccountId = acc1.id;
        ordine1.ContractId=contratto1.id;
        ordine1.EffectiveDate = date.today();
        ordine1.status = 'Aperto';
        ordine1.name='0211201637';
        insert ordine1;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione Remedy').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Account = acc;
        c.OF_IDContratto__c=contratto.id;
        c.AssetId = asset_1.id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
       // c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Order_Manager__c = true;
        insert c;
        
                String CaseRecordTypeIda = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione Remedy').getRecordTypeId();
        Case ca = new Case();
        ca.EOF_Account_OLO__c = acc.Id;
        ca.Subject = 'Richiesta di risoluzione guasto';
        ca.EOF_Data_Prevista_Attivazione__c = system.today();
        ca.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        ca.Account = acc;
        ca.OF_IDContratto__c=contratto.id;
        ca.AssetId = asset_1.id;
        ca.RecordTypeId = CaseRecordTypeIda;
        ca.EOF_Id_Notifica__c = 'test_01';
        ca.Origin = 'Web';
        ca.Priority = 'Medium';
        ca.EOF_GPON_Vincolante__c = 'Y';
       // c.OF_Order__c=ordine.id;
        ca.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ca.EOF_Codice_Operatore_WS__c = 'VF';
        ca.EOF_Codice_Ordine_OLO__c = '037';
        ca.EOF_Order_Manager__c = true;
        insert ca;
        
     
        
        Order ordine = new Order();
        ordine.OF_IDServizio__c =serv.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.OF_IDOrdineOLO__c='02112016_37';
        ordine.ContractId=contratto.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.OF_CaseID__c=c.id;
        ordine.name='02112016_37';
        insert ordine;
        
        
        String CaseRecordTypeId2 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Cessazione Remedy').getRecordTypeId();
        Case c2 = new Case();
        c2.EOF_Account_OLO__c = acc.Id;
        c2.Subject = 'Richiesta di Cessazione';
        c2.EOF_Data_Prevista_Attivazione__c = system.today();
        c2.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c2.Account = acc;
        c2.OF_IDContratto__c=contratto.id;
        c2.AssetId = asset_1.id;
        c2.RecordTypeId = CaseRecordTypeId2;
        c2.EOF_Id_Notifica__c = 'test_01';
        c2.Origin = 'Web';
        c2.Priority = 'Medium';
        c2.EOF_GPON_Vincolante__c = 'Y';
        c2.OF_Order__c=ordine.id;
        c2.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c2.EOF_Codice_Operatore_WS__c = 'VF';
        c2.EOF_Codice_Ordine_OLO__c = '0211201637';
        c2.EOF_Order_Manager__c = true;
        insert c2;
        
        String CaseRecordTypeId1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione Remedy').getRecordTypeId();
        Case c1 = new Case();
        c1.EOF_Account_OLO__c = acc1.Id;
        c1.Subject = 'Richiesta di attivazione';
        c1.EOF_Data_Prevista_Attivazione__c = system.today();
        c1.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c1.Account = acc1;
        c1.Status = 'ACQUISITO KO';
        c1.AssetId = asset_1.id;
        c1.RecordTypeId = CaseRecordTypeId1;
        c1.EOF_Id_Notifica__c = 'test_01';
        c1.Priority = 'Medium';
        c1.OF_Order__c=ordine1.id;
        c1.OF_IDContratto__c=contratto1.id;
        c1.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
        c1.EOF_Codice_Ordine_OLO__c = 'WN_9499';
        c1.EOF_Order_Manager__c = true;
		c1.OF_SA_Motivazione__c='Ordine non gestito perché non su GPON Passiva. Valore ProductProvisioningCode diverso da 4';
        insert c1;   
      
        Ce_CeiRecordType__c cRT= new Ce_CeiRecordType__c();
        cRT.Name='SERVIZIO FIBRA BASE';
        cRT.ceName__c= 'SERVIZIO FIBRA BASE';
        cRT.ceiDevName__c='OF_Standard';
        
        insert cRT; 
        
        Case_AssetRecordType__c cART= new Case_AssetRecordType__c (); 
        cART.caseDevName__c='EOF_Caso_Attivazione_Remedy';
        cART.name='GPONP_Remedy_ASSURANCE';
		cART.beCessazioneList__c='';
        cART.assetDevName__c='OF_GPONPassiva';
        insert cART;
                
        Case_AssetRecordType__c cART1= new Case_AssetRecordType__c (); 
        cART1.caseDevName__c='EOF_Caso_ASSURANCE_Remedy';
        cART1.name='GPONP_Remedy_Attivazione';
		cART1.beAttivazioneList__c='Non Risolvibile: Causa Impianto Cliente,Non Risolvibile: Causa CPE Cliente,Non riscontrato: Con Uscita';
        cART1.beCessazioneList__c='Contributo Disattivazione';
        cART1.assetDevName__c='OF_GPONPassiva';
        insert cART1;
    
      /*
        Ce_CeiRecordType__c cRT1= new Ce_CeiRecordType__c();
        cRT1.Name='SERVIZIO FIBRA BASE';
        cRT1.ceName__c= 'SERVIZIO FIBRA BASE';
        cRT1.ceiDevName__c='OF_Standard';
        insert cRT1; 
        */
        
        Case_AssetRecordType__c cART2= new Case_AssetRecordType__c (); 
        cART2.caseDevName__c='EOF_Caso_Cessazione_Remedy';
        cART2.name='GPONP_Remedy_Cessazione';
		cART2.beCessazioneList__c='Contributo Disattivazione';    
        cART2.assetDevName__c='OF_GPONPassiva';
        insert cART2;
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Attivo__c = True;
        com.OF_DataFineValidita__c = System.today();
        com.OF_DataInizioValidita__c = System.today();
        com.OF_Servizio__c = serv.Id;
        com.name = 'SERVIZIO FIBRA BASE'; 
        insert com;
        
            OF_CommercialElement__c com1 = new OF_CommercialElement__c();
        com1.OF_Attivo__c = True;
        com1.OF_DataFineValidita__c = System.today();
        com1.OF_DataInizioValidita__c = System.today();
        com1.OF_Servizio__c = serv.Id;
        com1.name = 'SERVIZI AGGIUNTIVI'; 
        insert com1;

		        OF_CommercialElement__c com2 = new OF_CommercialElement__c();
        com2.OF_Attivo__c = True;
        com2.OF_DataFineValidita__c = System.today();
        com2.OF_DataInizioValidita__c = System.today();
        com2.OF_Servizio__c = serv.Id;
        com2.name = 'CPE'; 
        insert com2;
        
        
		        OF_CommercialElement__c com3 = new OF_CommercialElement__c();
        com3.OF_Attivo__c = True;
        com3.OF_DataFineValidita__c = System.today();
        com3.OF_DataInizioValidita__c = System.today();
        com3.OF_Servizio__c = serv.Id;
        com3.name = 'Interventi di manutenzione'; 
        insert com3;
        
        
		        OF_CommercialElement__c com4 = new OF_CommercialElement__c();
        com4.OF_Attivo__c = True;
        com4.OF_DataFineValidita__c = System.today();
        com4.OF_DataInizioValidita__c = System.today();
        com4.OF_Servizio__c = serv.Id;
        com4.name = 'Intervento a vuoto'; 
        insert com4;

                 OF_CommercialElementIstanziato__c CEIM=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeIdM = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Standard').getRecordTypeId();        //CEI.Name='Test';
        CEIM.OF_Asset__c=asset_1.id;
        CEIM.OF_Stato__c='Attivo'; 
        CEIM.RecordTypeId=ComRecordTypeIdM;
        CEIM.OF_Case__c=c.id;
        CEIM.OF_CommercialElement__c=com3.id;
        insert CEIM;
        
                 OF_CommercialElementIstanziato__c CEII=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeIdI = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Standard').getRecordTypeId();        //CEI.Name='Test';
        CEII.OF_Asset__c=asset_1.id;
        CEII.OF_Stato__c='Attivo'; 
        CEII.RecordTypeId=ComRecordTypeIdI;
        CEII.OF_Case__c=c.id;
        CEII.OF_CommercialElement__c=com4.id;
        insert CEII;
        
         OF_CommercialElementIstanziato__c CEI2=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Standard').getRecordTypeId();        //CEI.Name='Test';
        CEI2.OF_Asset__c=asset_1.id;
        CEI2.OF_Stato__c='Attivo'; 
        CEI2.RecordTypeId=ComRecordTypeId1;
        CEI2.OF_Case__c=c.id;
        CEI2.OF_CommercialElement__c=com.id;
        insert CEI2;
        
		         OF_CommercialElementIstanziato__c CEI1=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeId3 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();        //CEI.Name='Test';
        CEI1.OF_Asset__c=asset_1.id;
        CEI1.OF_Stato__c='Attivo'; 
        CEI1.RecordTypeId=ComRecordTypeId3;
        CEI1.OF_Case__c=c.id;
        CEI1.OF_CommercialElement__c=com.id;
        insert CEI1;
        
		         OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo'; 
        CEI.RecordTypeId=ComRecordTypeId2;
        CEI.OF_Case__c=c.id;
        CEI.OF_CommercialElement__c=com3.id;
        insert CEI;
        
		
	   OF_BillingElement__c bill3 = new OF_BillingElement__c ();
        bill3.Name = 'Contributo Installazione CPE';
        bill3.OF_CommercialElement__c = com2.Id;
        bill3.OF_DataInizioValidita__c = System.today();
        bill3.OF_DataFineValidita__c = System.today();
        insert bill3;      
        
		        OF_BillingElement__c bill4 = new OF_BillingElement__c ();
        bill4.Name = 'Contributo Ribaltamento impianto';
        bill4.OF_CommercialElement__c = com1.Id;
        bill4.OF_DataInizioValidita__c = System.today();
        bill4.OF_DataFineValidita__c = System.today();
        insert bill4;      
        
		        OF_BillingElement__c bill5 = new OF_BillingElement__c ();
        bill5.Name = 'Contributo Installazione ONT';
        bill5.OF_CommercialElement__c = com2.Id;
        bill5.OF_DataInizioValidita__c = System.today();
        bill5.OF_DataFineValidita__c = System.today();
        insert bill5;      
        
		        OF_BillingElement__c bill6 = new OF_BillingElement__c ();
        bill6.Name = 'Tipo 1 Prolungamento fino a 5 m';
        bill6.OF_CommercialElement__c = com1.Id;
        bill6.OF_DataInizioValidita__c = System.today();
        bill6.OF_DataFineValidita__c = System.today();
        insert bill6;      
        
		        OF_BillingElement__c bill7 = new OF_BillingElement__c ();
        bill7.Name = 'Tipo 2 Prolungamento fino a 5 m con canalina nuova';
        bill7.OF_CommercialElement__c = com1.Id;
        bill7.OF_DataInizioValidita__c = System.today();
        bill7.OF_DataFineValidita__c = System.today();
        insert bill7;      
        
		        OF_BillingElement__c bill8 = new OF_BillingElement__c ();
        bill8.Name = 'Tipo 3 Prolungamento tra 5-15 m';
        bill8.OF_CommercialElement__c = com1.Id;
        bill8.OF_DataInizioValidita__c = System.today();
        bill8.OF_DataFineValidita__c = System.today();
        insert bill8;      
        
		        OF_BillingElement__c bill9 = new OF_BillingElement__c ();
        bill9.Name = 'Tipo 4 Prolungamento tra 5-15 m con canalina nuova';
        bill9.OF_CommercialElement__c = com1.Id;
        bill9.OF_DataInizioValidita__c = System.today();
        bill9.OF_DataFineValidita__c = System.today();
        insert bill9;      
        
		        OF_BillingElement__c bill20= new OF_BillingElement__c ();
        bill20.Name = 'Tipo 5 Supplemento prolungamento oltre 15m';
        bill20.OF_CommercialElement__c = com1.Id;
        bill20.OF_DataInizioValidita__c = System.today();
        bill20.OF_DataFineValidita__c = System.today();
        insert bill20;      

		        OF_BillingElement__c bill11 = new OF_BillingElement__c ();
        bill11.Name = 'Compenso per intervento non contestuale';
        bill11.OF_CommercialElement__c = com1.Id;
        bill11.OF_DataInizioValidita__c = System.today();
        bill11.OF_DataFineValidita__c = System.today();
        insert bill11;
		        OF_BillingElement__c bill12 = new OF_BillingElement__c ();
        bill12.Name = 'Contributo Installazione CPE Base';
        bill12.OF_CommercialElement__c = com2.Id;
        bill12.OF_DataInizioValidita__c = System.today();
        bill12.OF_DataFineValidita__c = System.today();
        insert bill12;
		        OF_BillingElement__c bill13 = new OF_BillingElement__c ();
        bill13.Name = 'Contributo Installazione CPE Plus';
        bill13.OF_CommercialElement__c = com2.Id;
        bill13.OF_DataInizioValidita__c = System.today();
        bill13.OF_DataFineValidita__c = System.today();
        insert bill13;        
				        OF_BillingElement__c bill14 = new OF_BillingElement__c ();
        bill14.Name = 'Contributo Installazione CPE Premium';
        bill14.OF_CommercialElement__c = com2.Id;
        bill14.OF_DataInizioValidita__c = System.today();
        bill14.OF_DataFineValidita__c = System.today();
        insert bill14;
        
        OF_BillingElement__c bill = new OF_BillingElement__c ();
        bill.Name = 'Contributo Disattivazione';
        bill.OF_CommercialElement__c = com.Id;
        //bill.OF_Servizio__c=serv.id;
        bill.OF_Attivo__c=true;
        bill.OF_DataInizioValidita__c = System.today();
        bill.OF_DataFineValidita__c = System.today();
        insert bill;
        
        OF_BillingElement__c bill1 = new OF_BillingElement__c ();
        bill1.Name = 'Contributo Attivazione';
        bill1.OF_CommercialElement__c = com.Id;
        bill1.OF_DataInizioValidita__c = System.today();
        bill1.OF_DataFineValidita__c = System.today();
        insert bill1;
        
        OF_BillingElement__c bill2 = new OF_BillingElement__c ();
        bill2.Name = 'Canone';
        bill2.OF_CommercialElement__c = com.Id;
        bill2.OF_DataInizioValidita__c = System.today();
        bill2.OF_DataFineValidita__c = System.today();
        insert bill2;    
        
                OF_BillingElement__c bill31 = new OF_BillingElement__c ();
        bill31.Name = 'Non Risolvibile: Causa CPE Cliente';
        bill31.OF_CommercialElement__c = com.Id;
        bill31.OF_DataInizioValidita__c = System.today();
        bill31.OF_DataFineValidita__c = System.today();
        insert bill31;    
        
                
                OF_BillingElement__c bill32 = new OF_BillingElement__c ();
        bill32.Name = 'Non Risolvibile: Causa Impianto Cliente';
        bill32.OF_CommercialElement__c = com.Id;
        bill32.OF_DataInizioValidita__c = System.today();
        bill32.OF_DataFineValidita__c = System.today();
        insert bill32;    
        
                
                OF_BillingElement__c bill33 = new OF_BillingElement__c ();
        bill33.Name = 'Non riscontrato: Senza Uscita';
        bill33.OF_CommercialElement__c = com.Id;
        bill33.OF_DataInizioValidita__c = System.today();
        bill33.OF_DataFineValidita__c = System.today();
        insert bill33;    
        
                        OF_BillingElement__c bill34 = new OF_BillingElement__c ();
        bill34.Name = 'Non riscontrato: Con Uscita';
        bill34.OF_CommercialElement__c = com.Id;
        bill34.OF_DataInizioValidita__c = System.today();
        bill34.OF_DataFineValidita__c = System.today();
        insert bill34;    
        
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
            
        );        
        update standardPricebook;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_CEStandard__c =asset_1.Id;
        istan.OF_Asset__c  = asset_1.id;
        istan.OF_CommercialElement__c = com.Id;
        //istan.RecordTypeId = RecordTypeIdcom;
        insert istan;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        
        insert abilitaTrig;
    }

        static testMethod void testMethodActivation1(){
                   Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest Req = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest ();
        
        Req.actionDate='2019-10-12T17:29:11+02:00';
        Req.createdBy='devoteam_fabio.bello';
        Req.customerDivision='';
        Req.customerId='2';
        Req.customerOrder='WN_9437';
        Req.internalOrder='NGN1100011122';
        Req.networkIdResource='F1000006878'; 
        Req.packageProvisioningCode='2';
        Req.pop='P7';
        Req.pricePlanProvisioningCode='2';
        Req.productProvisionigCodes='4';
        Req.promoCode='';
        Req.verticalOperator='MB';

        
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(Req);
        Test.stopTest(); 
    }

    @isTest
    static void FTTH_IN_ORDER_ValidRequest_Test(){
        
        Test.startTest();
        //Caso di request valida
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
        request.customerDivision='';
        request.customerId='2';
        request.customerOrder='WN_9437';
        request.internalOrder='NGN1100011122';
        request.networkIdResource='F1000006878'; 
        request.packageProvisioningCode='2';
        request.pop='P7';
        request.pricePlanProvisioningCode='2';
        request.productProvisionigCodes='4';
        request.promoCode='';
        request.verticalOperator='MB';
        
        validResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
       System.assertEquals('0', validResponse.statusCode);
        
        Test.stopTest();
    }

    @isTest         //caso con data non presente
    static void FTTH_IN_ORDER_ActionDate_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_9499';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';

        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
        @isTest        //caso con data non presente
    static void FTTH_IN_ORDER_ActionDate2Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_9499';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';

        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
   
    @isTest        //caso con customerId non presente
    static void FTTH_IN_ORDER_CustomerId_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017-10';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '';
                request.customerOrder = 'WN_090';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
   
    
        @isTest    //caso con customerId non conforme
    static void FTTH_IN_ORDER_CustomerId2_test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017-10';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '777';
                request.customerOrder = 'WN_7777777M';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';

        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

    
    @isTest        //caso con customOrder non presente
    static void FTTH_IN_ORDER_CustomOrder_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2019-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = '';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    /*
    @isTest        //caso con customOrder non presente
    static void FTTH_IN_ORDER_CustomOrder_Test2(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_9499';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
  
    */
    @isTest        //caso con internalOrder non presente
    static void FTTH_IN_ORDER_InternalOrder_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2019-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_123';
                request.internalOrder = '';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

    @isTest        //caso con networkIdResource non presente
    static void FTTH_IN_ORDER_NetworkIdResource_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_456';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = '';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    /*
    @isTest        //caso con packageProvisioningCode non presente
    static void FTTH_IN_ORDER_PackageProvisioningCode_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_777';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';

        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    */
    @isTest       //caso con packageProvisioningCode non conforme
    static void FTTH_IN_ORDER_PackageProvisioningCode2_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2019-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_888';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '4';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '8';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);        
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

    @isTest       //caso con pop non presente
    static void FTTH_IN_ORDER_Pop_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2019-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_999';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';

        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
     @isTest        //caso con pricePlanProvisioningCode non presente
    static void FTTH_IN_ORDER_PricePlanProvisioningCode_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_771';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
     @isTest        //caso con pricePlanProvisioningCode non presente
    static void FTTH_IN_ORDER_ProductProvisionigCodes_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_117';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
    @isTest        //caso con pricePlanProvisioningCode non conforme
    static void FTTH_IN_ORDER_ProductProvisionigCodes2_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_551';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '3';
                request.promoCode = 'NULL';
                request.verticalOperator = 'MB';

        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
    @isTest        //caso con pricePlanProvisioningCode non presente
    static void FTTH_IN_ORDER_VerticalOperator_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '2';
                request.customerOrder = 'WN_939';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = '';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
        @isTest        //caso con pricePlanProvisioningCode non presente
    static void FTTH_IN_ORDER_Contract_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest request;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerDivision = 'NULL';
                request.CustomerId = '3';
                request.customerOrder = '02';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F183';
                request.packageProvisioningCode = '2';
                request.pop = '1';
                request.pricePlanProvisioningCode = '2';
                request.productProvisionigCodes = '4';
                request.promoCode = 'NULL';
                request.verticalOperator = '9';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_IN_ORDER.FTTH_IN_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

      @isTest
    static void FTTH_OUT_ORDER_ValidRequest_Test(){
        
        Test.startTest();
        //Caso di request valida
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest request;
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
        request.customerOrder='021120167';
        request.internalOrder='F1003';
        request.networkIdResource='F1000006883'; 
        request.productProvisioningCode='6';

        
        validResponse = OF_GPONP_WS_IN_FTTH_OUT_ORDER.FTTH_OUT_ORDER(request);
       System.assertEquals('0', validResponse.statusCode);
        
        Test.stopTest();
    }

    @isTest         //caso con data non presente
    static void FTTH_OUT_ORDER_ActionDate_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest request;
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest();
                request.actionDate = '';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerOrder = 'WN_9499';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCode = '6';


        invalidResponse = OF_GPONP_WS_IN_FTTH_OUT_ORDER.FTTH_OUT_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

        @isTest        //caso con data non presente
    static void FTTH_OUT_ORDER_ActionDate2Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest request;
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest();
                request.actionDate = '2017';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerOrder = 'WN_9499';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCode = '6';

        invalidResponse = OF_GPONP_WS_IN_FTTH_OUT_ORDER.FTTH_OUT_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
    @isTest        //caso con customOrder non presente
    static void FTTH_OUT_ORDER_CustomOrder_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest request;
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerOrder = '';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCode = '6';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_OUT_ORDER.FTTH_OUT_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
    @isTest        //caso con customOrder non presente
    static void FTTH_OUT_ORDER_CustomOrder_Test2(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest request;
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerOrder = '';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCode = '6';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_OUT_ORDER.FTTH_OUT_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
  
    
    @isTest        //caso con internalOrder non presente
    static void FTTH_OUT_ORDER_InternalOrder_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest request;
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerOrder = 'WN_123';
                request.internalOrder = '';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCode = '6';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_OUT_ORDER.FTTH_OUT_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

    @isTest        //caso con networkIdResource non presente
    static void FTTH_OUT_ORDER_NetworkIdResource_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest request;
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerOrder = 'WN_456';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = '';
                request.productProvisioningCode = '6';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_OUT_ORDER.FTTH_OUT_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
        
     @isTest        //caso con pricePlanProvisioningCode non presente
    static void FTTH_OUT_ORDER_productProvisioningCode_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest request;
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerOrder = 'WN_117';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCode = '';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_OUT_ORDER.FTTH_OUT_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
    @isTest        //caso con pricePlanProvisioningCode non conforme
    static void FTTH_OUT_ORDER_productProvisioningCode2_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest request;
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerOrder = 'WN_551';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCode = '3';

        invalidResponse = OF_GPONP_WS_IN_FTTH_OUT_ORDER.FTTH_OUT_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
        @isTest        //caso con pricePlanProvisioningCode non presente
    static void FTTH_OUT_ORDER_Contract_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest request;
        OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.customerOrder = '02';
                request.internalOrder = 'NGN1100011185';
                request.networkIdResource = 'F183';
                request.productProvisioningCode = '6';
        
        invalidResponse = OF_GPONP_WS_IN_FTTH_OUT_ORDER.FTTH_OUT_ORDER(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

       @isTest
    static void CPE_ADD_ValidRequest_Test(){
        
        Test.startTest();
        //Caso di request valida
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
        request.networkIdResource='F1000006883'; 
        request.productProvisioningCodes='9';
		request.quantity='NGN1100011122';
		request.serialNumber='999';

        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
       System.assertEquals('0', validResponse.statusCode);
        
        Test.stopTest();
    }

    @isTest         //caso con data non presente
    static void CPE_ADD_ActionDate_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '9';
				request.quantity='NGN1100011122';
				request.serialNumber='999';

        invalidResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
        @isTest        //caso con data non presente
    static void CPE_ADD_ActionDate2Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '9';
				request.quantity='NGN1100011122';
				request.serialNumber='999';

        invalidResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

    @isTest     
    static void CPE_ADD_NetworkIdResource_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = '';
                request.productProvisioningCodes = '9';
				request.quantity='NGN1100011122';
				request.serialNumber='999';
        
        invalidResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

    
     @isTest       
    static void CPE_ADD_productProvisioningCodes_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '';
				request.quantity='';
				request.serialNumber='999';
        
        invalidResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

     @isTest       
    static void CPE_ADD_productProvisioningCodes2_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '3';
				request.quantity='';
				request.serialNumber='999';
        
        invalidResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
         @isTest       
    static void CPE_ADD_productProvisioningCodes9_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '9';
				request.quantity='';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
    
             @isTest       
    static void CPE_ADD_productProvisioningCodes10_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '10';
				request.quantity='';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }

         @isTest       
    static void CPE_ADD_productProvisioningCodes23_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '23';
				request.quantity='';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
    
             @isTest       
    static void CPE_ADD_productProvisioningCodes44_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '44';
				request.quantity='';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
               @isTest       
    static void CPE_ADD_productProvisioningCodes45_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '45';
				request.quantity='';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }  


               @isTest       
    static void CPE_ADD_productProvisioningCodes46_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '46';
				request.quantity='';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }     

                   @isTest       
    static void CPE_ADD_productProvisioningCodes48_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '48';
				request.quantity='';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
    
                   @isTest       
    static void CPE_ADD_productProvisioningCodes70_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '70';
				request.quantity='';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
                   @isTest       
    static void CPE_ADD_productProvisioningCodes71_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '71';
				request.quantity='';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
    
        @isTest       
    static void CPE_ADD_productProvisioningCodes72_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '72';
				request.quantity='';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
    
            @isTest       
    static void CPE_ADD_productProvisioningCodes47_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F1000006883';
                request.productProvisioningCodes = '47';
				request.quantity='25';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
    
    @isTest       
    static void CPE_ADD_productProvisioningCodes3_Test(){
 
        Test.startTest();
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest request;
        OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest();
                request.actionDate = '2017-10-12T17:29:11+02:00';
                request.createdBy = 'devoteam_luca.morandin';
                request.networkIdResource = 'F183';
                request.productProvisioningCodes = '40';
				request.quantity='NGN1100011122';
				request.serialNumber='999';
        
        validResponse = OF_GPONP_WS_IN_CPE_ADD.CPE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }


           @isTest
    static void ASSURANCE_ADD_ValidRequest_Test(){
        
        Test.startTest();
        //Caso di request valida
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='WN_ASS_TT_M0678241401';
        request.productProvisionigCodes='15';
		request.ttNumber='999';

		
        validResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
       System.assertEquals('0', validResponse.statusCode);
        
        Test.stopTest();
    }
    @isTest         //caso con data non presente
    static void ASSURANCE_ADD_ActionDate_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse invalidResponse;
        request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='WN_ASS_TT_M0678241401';
        request.productProvisionigCodes='9';
		request.ttNumber='999';

        invalidResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
        @isTest        //caso con data non presente
    static void ASSURANCE_ADD_ActionDate2Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='WN_ASS_TT_M0678241401';
        request.productProvisionigCodes='9';
		request.ttNumber='999';

        invalidResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

    @isTest     
    static void ASSURANCE_ADD_NetworkIdResource_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='';	
		request.oloCommCode='WN_ASS_TT_M0678241401';
        request.productProvisionigCodes='9';
		request.ttNumber='999';
        
        invalidResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

    
     @isTest       
    static void ASSURANCE_ADD_oloCommCode_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='';
        request.productProvisionigCodes='16';
		request.ttNumber='999';
        
        invalidResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
         @isTest       
    static void ASSURANCE_ADD_faultCause_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='000';
        request.productProvisionigCodes='16';
		request.ttNumber='999';
        
        invalidResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
         @isTest       
    static void ASSURANCE_ADD_ttNumber_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='000';
        request.productProvisionigCodes='16';
		request.ttNumber='';
        
        invalidResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

     @isTest       
    static void ASSURANCE_ADD_productProvisioningCod_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='6788888888888888';
        request.productProvisionigCodes='';
		request.ttNumber='999';
        
        invalidResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
         @isTest       
    static void ASSURANCE_ADD_productProvisioningCodesA15_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();        
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='0000';
        request.productProvisionigCodes='15';
		request.ttNumber='999';
        
        validResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
    
             @isTest       
    static void ASSURANCE_ADD_productProvisioningCodesA16_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse validResponse;
                request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='0000';
        request.productProvisionigCodes='16';
		request.ttNumber='999';
        
        validResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }


         @isTest       
    static void ASSURANCE_ADD_productProvisioningCodesA17_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='0000';
        request.productProvisionigCodes='17';
		request.ttNumber='999';
        
        validResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
    

    @isTest       
    static void ASSURANCE_ADD_productProvisioningCodesA18_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='WN_ASS_TT_M0678241401';
        request.productProvisionigCodes='18';
		request.ttNumber='999';
        
        validResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        Test.stopTest();
    }
    
           @isTest
    static void PROVISIONING_ADD_ValidRequest_Test(){
        
        Test.startTest();
        //Caso di request valida
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest request;
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderResponse validResponse;
        request = new OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.customerId='2';
        request.customerOrder='02112016_37';
        request.oloMessage='mmm';	
		request.oloMessageCode='mmm';
        request.productProvisionigCodes='16';
		
        validResponse = OF_GPONP_WS_IN_PROVISIONING_ADD.PROVISIONING_ADD(request);
        System.assertEquals('0', validResponse.statusCode);
        
        Test.stopTest();
    }

    @isTest         //caso con data non presente
    static void PROVISIONING_ADD_ActionDate_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest request;
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest();
		request.actionDate='';
        request.createdBy='devoteam_fabio.bello';
		request.customerId='2';
        request.customerOrder='0211201637';
        request.oloMessage='mmm';	
		request.oloMessageCode='mmm';
        request.productProvisionigCodes='';

        invalidResponse = OF_GPONP_WS_IN_PROVISIONING_ADD.PROVISIONING_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
        @isTest        //caso con data non presente
    static void PROVISIONING_ADD_ActionDate2Test(){

        Test.startTest();
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest request;
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest();
		request.actionDate='2019';
        request.createdBy='devoteam_fabio.bello';
		request.customerId='2';
        request.customerOrder='0211201637';
        request.oloMessage='mmm';	
		request.oloMessageCode='mmm';
        request.productProvisionigCodes='16';

        invalidResponse = OF_GPONP_WS_IN_PROVISIONING_ADD.PROVISIONING_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

    @isTest     
    static void PROVISIONING_ADD_CustomerOrder_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest request;
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest();
		request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.customerId='2';
        request.customerOrder='';
        request.oloMessage='mmm';	
		request.oloMessageCode='mmm';
        request.productProvisionigCodes='16';
        
        invalidResponse = OF_GPONP_WS_IN_PROVISIONING_ADD.PROVISIONING_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

    
     @isTest       
    static void PROVISIONING_ADD_customerId_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest request;
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest();
		request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.customerId='';
        request.customerOrder='0211201637';
        request.oloMessage='mmm';	
		request.oloMessageCode='mmm';
        request.productProvisionigCodes='16';
        
        invalidResponse = OF_GPONP_WS_IN_PROVISIONING_ADD.PROVISIONING_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }

      @isTest       
    static void PROVISIONING_ADD_productProvisioningCod_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest request;
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderResponse invalidResponse;
                request = new OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest();
		request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.customerId='2';
        request.customerOrder='02117';
        request.oloMessage='mmm';	
		request.oloMessageCode='mmm';
        request.productProvisionigCodes='';
        
        invalidResponse = OF_GPONP_WS_IN_PROVISIONING_ADD.PROVISIONING_ADD(request);
        System.assertEquals('1', invalidResponse.statusCode);
        Test.stopTest();
    }
    
          @isTest       
    static void createOrderFromReq_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest request;
                request = new OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest();
		request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.customerId='2';
        request.customerOrder='02117';
        request.oloMessage='mmm';	
		request.oloMessageCode='mmm';
        request.productProvisionigCodes='16';
        Account act=[Select Id FROM Account limit 1];
        OF_GPONP_FTTH_Utils.createOrderFromReq(request, act);
        Test.stopTest();
    }
            @isTest       
    static void creazioneCasoFromOrder_TEST(){

        Test.startTest();
        Account act=[Select Id, EOF_Codice_Operatore__c FROM Account limit 1];
        Order o=[Select id, OF_IDOrdineOLO__c , OF_Asset__c, OF_IDRisorsa__c, OF_IDServizio__c,AccountId,ContractId  From Order limit 1];

        OF_GPONP_FTTH_Utils.creazioneCasoFromOrder(o, act);
        Test.stopTest();
    }
             @isTest       
    static void NETWORK_CREATION_ADD_netProvCod_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderRequest request;
        OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderResponse validResponse;
                request = new OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderRequest();

		 request.actionDate='2019-10-12T17:29:11+02:00';
         request.createdBy='devoteam_fabio.bello';
         request.buildingNumber='poi';
         request.customerId='2';
         request.elementaryArea='num';
         request.idBuilding='nji';
         request.macroArea='nhy';
         request.pop='okm';
         request.productProvisionigCodes='iuo';
         request.promoCode='000';
         request.streetName='poi';
         request.toponymyUnit='tyu';
         request.town='000';
        
        validResponse = OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NETWORK_CREATION_ADD(request);
        Test.stopTest();
    }
                 @isTest       
    static OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse ASSURANCE_ADD1_Test(){

        Test.startTest();
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest request;
        OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse validResponse;
                request = new OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest();
        request.actionDate='2019-10-12T17:29:11+02:00';
        request.createdBy='devoteam_fabio.bello';
		request.faultCause='Non Risolvibile: Causa CPE Cliente';
        request.faultResolution='Risolto presa telefonica cliente in disservizio';
        request.networkIdResource='02112016_37';	
		request.oloCommCode='0000';
        request.productProvisionigCodes='16';
		request.ttNumber='999';
        
        validResponse = OF_GPONP_WS_IN_ASSURANCE_ADD.ASSURANCE_ADD(request);
        Test.stopTest();
        return validResponse;
    }
}
@isTest
private class Batch_CaseNoAsset_Test {

public static void createProductAppoggio() {
		Id pbsId = Test.getStandardPricebookId();
		List<PricebookEntry> pbeToInsert = new List<PricebookEntry>();
		Product2 pApp = new Product2(
			Name = 'SERV_FATT_APPOGGIO',
			IsActive = true
		);
		insert pApp;

		PricebookEntry pbeApp = new PricebookEntry(
			Pricebook2Id = pbsId,
			Product2Id = pApp.Id,
			UnitPrice = 1,
			IsActive = true
		);
		pbeToInsert.add(pbeApp);

		Pricebook2 pbApp = new Pricebook2 (
			IsActive = true,
			Name = 'SERV_FATT_APPOGGIO',
			Unit_Price__c = 1
		);
		insert pbApp;

		PricebookEntry pbeApp2 = new PricebookEntry(
			Pricebook2Id = pbApp.Id,
			Product2Id = pApp.Id,
			UnitPrice = 1,
			IsActive = true
		);
		pbeToInsert.add(pbeApp2);
		insert pbeToInsert;
	}

public static void createCustomSettings() {
        List<Ce_CeiRecordType__c> csList = new List<Ce_CeiRecordType__c>();

        Ce_CeiRecordType__c csCEI = new Ce_CeiRecordType__c();
        csCEI.Name = 'CPE';
        csCEI.ceName__c = 'CPE';
        csCEI.ceiDevName__c = 'OF_CPE';
        csList.add(csCEI);

        csCEI = new Ce_CeiRecordType__c();
        csCEI.Name = 'SERVIZIO FIBRA BASE';
        csCEI.ceName__c = 'SERVIZIO FIBRA BASE';
        csCEI.ceiDevName__c = 'OF_Standard';
        csList.add(csCEI);

        csCEI = new Ce_CeiRecordType__c();
        csCEI.Name = 'SERVIZIO OPEN STREAM BASE';
        csCEI.ceName__c = 'SERVIZIO OPEN STREAM BASE';
        csCEI.ceiDevName__c = 'OF_Standard';
        csList.add(csCEI);

        csCEI = new Ce_CeiRecordType__c();
        csCEI.Name = 'SLA PREMIUM ASSURANCE';
        csCEI.ceName__c = 'SLA PREMIUM ASSURANCE';
        csCEI.ceiDevName__c = 'OF_ServiziAggiuntivi';
        csList.add(csCEI);

        csCEI = new Ce_CeiRecordType__c();
        csCEI.Name = 'RIBALTAMENTO IMPIANTO';
        csCEI.ceName__c = 'RIBALTAMENTO IMPIANTO';
        csCEI.ceiDevName__c = 'OF_ServiziAggiuntivi';
        csList.add(csCEI);

        csCEI = new Ce_CeiRecordType__c();
        csCEI.Name = 'ESTENSIONE IMPIANTO CLIENTE';
        csCEI.ceName__c = 'ESTENSIONE IMPIANTO CLIENTE';
        csCEI.ceiDevName__c = 'OF_ServiziAggiuntivi';
        csList.add(csCEI);

        csCEI = new Ce_CeiRecordType__c();
        csCEI.Name = 'VLAN';
        csCEI.ceName__c = 'VLAN';
        csCEI.ceiDevName__c = 'OF_VLAN';
        csList.add(csCEI);

        csCEI = new Ce_CeiRecordType__c();
        csCEI.Name = 'SERVIZI AGGIUNTIVI';
        csCEI.ceName__c = 'SERVIZI AGGIUNTIVI';
        csCEI.ceiDevName__c = 'OF_ServiziAggiuntivi';
        csList.add(csCEI);

        csCEI = new Ce_CeiRecordType__c();
        csCEI.Name = 'Intervento a vuoto';
        csCEI.ceName__c = 'Intervento a vuoto';
        csCEI.ceiDevName__c = 'Intervento_a_vuoto';
        csList.add(csCEI);

        csCEI = new Ce_CeiRecordType__c();
        csCEI.Name = 'Interventi di manutenzione';
        csCEI.ceName__c = 'Interventi di manutenzione';
        csCEI.ceiDevName__c = 'OF_INTERVENTO_DI_MANUTENZIONE';
        csList.add(csCEI);

        insert csList;

        List<Case_AssetRecordType__c> caList = new List<Case_AssetRecordType__c>();

        Case_AssetRecordType__c ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_Attivazione';
        ca.caseDevName__c = 'EOF_Caso_Attivazione';
        ca.assetDevName__c = 'OF_GPONPassiva';
        ca.beAttivazioneList__c = 'Contributo Attivazione,Canone,Canone premium,Contributo Consegna,Contributo Istallazione,Contributo Consegna e istallazione,Contributo Estensione impianto,Contributo Ribaltamento impianto';
        ca.serviceName__c = 'GPON Passiva';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_Cessazione';
        ca.caseDevName__c = 'EOF_Caso_Cessazione';
        ca.beCessazioneList__c = 'Contributo Disattivazione,Contributo Ritiro';
        ca.serviceName__c = 'GPON Passiva';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_CeD_Attivazione';
        ca.caseDevName__c = 'EOF_SP_Caso_Attivazione_CeD';
        ca.assetDevName__c = 'OF_CD_Asset_GPON_Passiva';
        ca.beAttivazioneList__c = 'Contributo Attivazione,Canone,Canone premium,Contributo Consegna,Contributo Istallazione,Contributo Consegna e istallazione,Contributo Estensione impianto,Contributo Ribaltamento impianto';
        ca.serviceName__c = 'GPON Passiva CD';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_CeD_Cessazione';
        ca.caseDevName__c = 'EOF_SP_Caso_Cessazione_CeD';
        ca.beCessazioneList__c = 'Contributo Disattivazione,Contributo Ritiro';
        ca.serviceName__c = 'GPON Passiva CD';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_Remedy_Attivazione';
        ca.caseDevName__c = 'EOF_Caso_Attivazione_Remedy';
        ca.assetDevName__c = 'OF_GPONPassiva';
        ca.serviceName__c = 'GPON Passiva';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_Remedy_Cessazione';
        ca.caseDevName__c = 'EOF_Caso_Cessazione_Remedy';
        ca.beCessazioneList__c = 'Contributo Disattivazione';
        ca.serviceName__c = 'GPON Passiva';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'OpenStream_Attivazione';
        ca.caseDevName__c = 'OF_SA_Attivazione';
        ca.assetDevName__c = 'OF_OpenStream';
        ca.serviceName__c = 'Open Stream';
        ca.beAttivazioneList__c = 'Contributo Attivazione,Canone,Canone premium,Contributo Consegna,Contributo Istallazione,Contributo Consegna e istallazione,Contributo Estensione impianto,Contributo Ribaltamento impianto';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'OpenStream_Cessazione';
        ca.caseDevName__c = 'OF_SA_Cessazione';
        ca.serviceName__c = 'Open Stream';
        ca.beCessazioneList__c = 'Contributo Disattivazione,Contributo Ritiro';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'OPENSTREAM_CeD_Attivazione';
        ca.caseDevName__c = 'EOF_Caso_Attivazione_OPENSTREAM_CeD';
        ca.assetDevName__c = 'OF_CD_Asset_OpenStream';
        ca.serviceName__c = 'Open Stream CD';
        ca.beAttivazioneList__c = 'Contributo Attivazione,Canone,Canone premium,Contributo Consegna,Contributo Istallazione,Contributo Consegna e istallazione,Contributo Estensione impianto,Contributo Ribaltamento impianto';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'OPENSTREAM_CeD__Cessazione';
        ca.serviceName__c = 'Open Stream CD';
        ca.caseDevName__c = 'EOF_Caso_Cessazione_OPENSTREAM_CD';
        ca.beCessazioneList__c = 'Contributo Disattivazione,Contributo Ritiro';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_Remedy_ASSURANCE';
        ca.serviceName__c = 'GPON Passiva';
        ca.caseDevName__c = 'EOF_Caso_ASSURANCE_Remedy';
        ca.assetDevName__c = 'OF_GPONPassiva';
        ca.beCessazioneList__c = 'Contributo Disattivazione';
        ca.beAttivazioneList__c = 'Non Risolvibile: Causa Impianto Cliente,Non Risolvibile: Causa CPE Cliente,Non riscontrato: Con Uscita';
        caList.add(ca);

        insert caList;
        
        
        
   
		      
        BatchBonifiche__c csbb = new BatchBonifiche__c();
		csbb.name ='Prova';
		csbb.SizeBatch__c = 1;
		csbb.PassoSchedulazione__c = 1;
		insert csbb;
    } 


 public static testMethod void test1() {
     Test.startTest();
     
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
     createCustomSettings();
         List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = accList[0].id;
		insert contratto;

       order o = new order();
        o.recordtypeID = mpRT.get('OF_INORDER');
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = accList[0].id;
        o.OF_AccountTemporaneo__c=null;
        o.OF_TipologiaDiServizio__c='Attivo';
        o.PO_IsFromOpportunity__c=true;
        o.ContractId=contratto.id;
        o.Name ='test1';
        insert o;
        
        case c = new case();
        c.RecordTypeId = mpRT.get('EOF_Caso_Attivazione');
        c.Status = 'Espletato';
        c.AccountId = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
        c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
        c.OF_Order__c=o.id;
        c.eof_id_risorsa__c='xxx';
        c.assetid=null;
        insert c; 

        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c();
        //sl.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        sl.caso__c=c.id;
        sl.EOF_Codice_Ordine_OLO__c='Test_9808980';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.PO_Offerta_Inoltrata__c=false; //true
        sl.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
        sl.EOF_Tipo_Comunicazione_String__c = 'SF->OLO - ACK - CompletionOrder';
        
        insert sl;
        
        EOF_EAI_Service_Log__c slrif= new EOF_EAI_Service_Log__c();
        slrif.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slrif.EOF_ID_Pop__c='Pop 2';
        slrif.caso__c=c.id;
        slrif.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB'; //1 GB
        slrif.EOF_SL_Riferimento__c=sl.id;
        slrif.EOF_Tipo_Comunicazione_String__c = 'SF->OLO - ACK - CompletionOrder';
        
        insert slrif;
        
        Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
		cer.name='testcer1';
		cer.ceName__c='VLAN1';
		cer.ceiDevName__c='CPE_Passivi';

		insert cer;

    	OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;

		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'GPON Passiva';
		Date inizio2 = Date.newInstance(2016,1,1);
		Date fine2 = Date.newInstance(2099,12,31);
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio2;
		servizio.OF_DataFineValidita__c = fine2;
		servizio.OF_CatalogoCommerciale__c = catalogo.id;
		servizio.OF_Servizio_Code__c='123';

		insert servizio;

		OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
		contrattoServizio.OF_Contract__c=o.ContractId;
		contrattoServizio.OF_Servizio__c=servizio.id;

		insert contrattoServizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();

		Date inizio1 = Date.newInstance(2016,1,1);
		Date fine1 = Date.newInstance(2099,12,31);
		ce.name = 'VLAN';
		ce.OF_Attivo__c = true;
		ce.OF_DataInizioValidita__c = inizio1;
		ce.OF_DataFineValidita__c = fine1;
		ce.OF_Servizio__c = servizio.id;

		insert ce;
      		OF_BillingElement__c bec=new OF_BillingElement__c();
		bec.Name='Contributo Attivazione';
		Date ini12 = Date.newInstance(2099,1,31);
		Date fin12= Date.newInstance(2099,1,3);
		bec.OF_DataFineValidita__c=ini12;
		bec.OF_DataInizioValidita__c=fin12;
		bec.OF_CommercialElement__c=ce.id;
		bec.OF_Attivo__c=true;
		bec.OF_Billing_Element_Code__c = 'abcd-009';

		insert bec;

		OF_BillingElement__c bec1=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];

		bec=bec1;

		update bec;
		
		OF_BillingElement__c bec6=new OF_BillingElement__c();
		bec6.Name='Canone';
		Date ini12345 = Date.newInstance(2099,1,31);
		Date fin12345= Date.newInstance(2099,1,3);
		bec6.OF_DataFineValidita__c=ini12345;
		bec6.OF_DataInizioValidita__c=fin12345;
		bec6.OF_CommercialElement__c=ce.id;
		bec6.OF_Attivo__c=true;
		bec6.OF_Billing_Element_Code__c = 'abcd-005';

		insert bec6;

		OF_BillingElement__c bec7=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone'];

		bec6=bec7;

		update bec6;
		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true

		);
		update standardPricebook;

		// Re-Query for the Pricebook2 record, for debugging
		standardPricebook = [SELECT IsStandard
							 FROM Pricebook2
							 WHERE Id = : standardPricebook.Id];

		// Create the Product
		Product2 testProduct = new Product2(
			Name = 'Contributo Verticale',
			IsActive = true
		);
		insert testProduct;
    
            DataBase.executeBatch(new Batch_CaseNoAsset());
            Test.stopTest();
 }    
  
  public static testMethod void test2() {
     Test.startTest();
     
     
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
     createCustomSettings();
         List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = accList[0].id;
		insert contratto;

       order o = new order();
        o.recordtypeID = mpRT.get('OF_INORDER');
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = accList[0].id;
        o.OF_AccountTemporaneo__c=null;
        o.OF_TipologiaDiServizio__c='Attivo';
        o.PO_IsFromOpportunity__c=true;
        o.ContractId=contratto.id;
        o.Name ='test1';
        insert o;
        
        
        case c = new case();
        c.RecordTypeId = mpRT.get('OF_SA_Attivazione');
        c.Status = 'Espletato';
        c.AccountId = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
        c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
        c.OF_Order__c=o.id;
        c.eof_id_risorsa__c='xxx';
        c.assetid=null;
        insert c; 
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c();
        sl.caso__c=c.id;
        sl.EOF_Codice_Ordine_OLO__c='Test_9808980';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.PO_Offerta_Inoltrata__c=false; //true
        sl.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
        sl.EOF_Tipo_Comunicazione_String__c = 'SF->OLO - ACK - CompletionOrder';
        
        insert sl;
        
        EOF_EAI_Service_Log__c slrif= new EOF_EAI_Service_Log__c();
        slrif.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slrif.EOF_ID_Pop__c='Pop 2';
        slrif.caso__c=c.id;
        slrif.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB'; //1 GB
        slrif.EOF_SL_Riferimento__c=sl.id;
        slrif.EOF_Tipo_Comunicazione_String__c = 'SF->OLO - ACK - CompletionOrder';
        
        insert slrif;
        
        Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
		cer.name='testcer1';
		cer.ceName__c='VLAN1';
		cer.ceiDevName__c='CPE_Passivi';

		insert cer;

		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;


		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'Open Stream';
		Date inizio2 = Date.newInstance(2016,1,1);
		Date fine2 = Date.newInstance(2099,12,31);
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio2;
		servizio.OF_DataFineValidita__c = fine2;
		servizio.OF_CatalogoCommerciale__c = catalogo.id;
		servizio.OF_Servizio_Code__c='123';

		insert servizio;

		OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
		contrattoServizio.OF_Contract__c=o.ContractId;
		contrattoServizio.OF_Servizio__c=servizio.id;

		insert contrattoServizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();

		Date inizio1 = Date.newInstance(2016,1,1);
		Date fine1 = Date.newInstance(2099,12,31);
		ce.name = 'VLAN';
		ce.OF_Attivo__c = true;
		ce.OF_DataInizioValidita__c = inizio1;
		ce.OF_DataFineValidita__c = fine1;
		ce.OF_Servizio__c = servizio.id;

		insert ce;
      	
      	OF_BillingElement__c bec=new OF_BillingElement__c();
		bec.Name='Contributo Attivazione';
		Date ini12 = Date.newInstance(2099,1,31);
		Date fin12= Date.newInstance(2099,1,3);
		bec.OF_DataFineValidita__c=ini12;
		bec.OF_DataInizioValidita__c=fin12;
		bec.OF_CommercialElement__c=ce.id;
		bec.OF_Attivo__c=true;
		bec.OF_Billing_Element_Code__c = 'abcd-009';

		insert bec;

		OF_BillingElement__c bec1=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];

		bec=bec1;

		update bec;
		
		OF_BillingElement__c bec6=new OF_BillingElement__c();
		bec6.Name='Canone';
		Date ini12345 = Date.newInstance(2099,1,31);
		Date fin12345= Date.newInstance(2099,1,3);
		bec6.OF_DataFineValidita__c=ini12345;
		bec6.OF_DataInizioValidita__c=fin12345;
		bec6.OF_CommercialElement__c=ce.id;
		bec6.OF_Attivo__c=true;
		bec6.OF_Billing_Element_Code__c = 'abcd-005';

		insert bec6;

		OF_BillingElement__c bec7=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone'];

		bec6=bec7;

		update bec6;
		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true

		);
		update standardPricebook;

		// Re-Query for the Pricebook2 record, for debugging
		standardPricebook = [SELECT IsStandard
							 FROM Pricebook2
							 WHERE Id = : standardPricebook.Id];

		// Create the Product
		Product2 testProduct = new Product2(
			Name = 'Contributo Verticale',
			IsActive = true
		);
		insert testProduct;
    
            DataBase.executeBatch(new Batch_CaseNoAsset());
            Test.stopTest();
 } 
 
 
  public static testMethod void Bonifica_schedTestMethod() {
        
       
		      
        BatchBonifiche__c csbb = new BatchBonifiche__c();
		csbb.name ='BonificaCaseNoAsset';
		csbb.SizeBatch__c = 1;
		csbb.PassoSchedulazione__c = 1;
		insert csbb;
        DateTime jobAlgoritmo = System.now().addMinutes(1);
        String hour = String.valueOf(jobAlgoritmo.hour());
        String min = String.valueOf(jobAlgoritmo.minute()); 
        String ss = String.valueOf(jobAlgoritmo.second());

        //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
        Test.startTest();
        Batch_CaseNoAsset_Sched t2 = new Batch_CaseNoAsset_Sched();
        system.schedule('test 02', nextFireTime, t2);
        Test.stopTest();
        
    }
     
}
@isTest 
private class OM_GW_Utils_TEST {
     @testSetup static void datasetupcustomsetting() {
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
        
    }
    
    
    public static  void createCustomSettings() {
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
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_Cessazione';
        ca.caseDevName__c = 'EOF_Caso_Cessazione';
        ca.beCessazioneList__c = 'Contributo Disattivazione,Contributo Ritiro';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_CeD_Attivazione';
        ca.caseDevName__c = 'EOF_SP_Caso_Attivazione_CeD';
        ca.assetDevName__c = 'OF_CD_Asset_GPON_Passiva';
        ca.beAttivazioneList__c = 'Contributo Attivazione,Canone,Canone premium,Contributo Consegna,Contributo Istallazione,Contributo Consegna e istallazione,Contributo Estensione impianto,Contributo Ribaltamento impianto';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_CeD_Cessazione';
        ca.caseDevName__c = 'EOF_SP_Caso_Cessazione_CeD';
        ca.beCessazioneList__c = 'Contributo Disattivazione,Contributo Ritiro';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_Remedy_Attivazione';
        ca.caseDevName__c = 'EOF_Caso_Attivazione_Remedy';
        ca.assetDevName__c = 'OF_GPONPassiva';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_Remedy_Cessazione';
        ca.caseDevName__c = 'EOF_Caso_Cessazione_Remedy';
        ca.beCessazioneList__c = 'Contributo Disattivazione';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'OpenStream_Attivazione';
        ca.caseDevName__c = 'OF_SA_Attivazione';
        ca.assetDevName__c = 'OF_OpenStream';
        ca.beAttivazioneList__c = 'Contributo Attivazione,Canone,Canone premium,Contributo Consegna,Contributo Istallazione,Contributo Consegna e istallazione,Contributo Estensione impianto,Contributo Ribaltamento impianto';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'OpenStream_Cessazione';
        ca.caseDevName__c = 'OF_SA_Cessazione';
        ca.beCessazioneList__c = 'Contributo Disattivazione,Contributo Ritiro';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'OPENSTREAM_CeD_Attivazione';
        ca.caseDevName__c = 'EOF_Caso_Attivazione_OPENSTREAM_CeD';
        ca.assetDevName__c = 'OF_CD_Asset_OpenStream';
        ca.beAttivazioneList__c = 'Contributo Attivazione,Canone,Canone premium,Contributo Consegna,Contributo Istallazione,Contributo Consegna e istallazione,Contributo Estensione impianto,Contributo Ribaltamento impianto';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'OPENSTREAM_CeD__Cessazione';
        ca.caseDevName__c = 'EOF_Caso_Cessazione_OPENSTREAM_CD';
        ca.beCessazioneList__c = 'Contributo Disattivazione,Contributo Ritiro';
        caList.add(ca);

        ca = new Case_AssetRecordType__c();
        ca.Name = 'GPONP_Remedy_ASSURANCE';
        ca.caseDevName__c = 'EOF_Caso_ASSURANCE_Remedy';
        ca.assetDevName__c = 'OF_GPONPassiva';
        ca.beCessazioneList__c = 'Contributo Disattivazione';
        ca.beAttivazioneList__c = 'Non Risolvibile: Causa Impianto Cliente,Non Risolvibile: Causa CPE Cliente,Non riscontrato: Con Uscita';
        caList.add(ca);

        insert caList;
    } 
    
    
    //acquisizione
    static testMethod void OM_GW_Utils_TESTMETHOD_1() {

		TestDataFactory.CreateTestRecords(null,null,null);        

        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = 'Y';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
        OM_GW_GE_Utils.tpl.TL_codice_ordine_olo__c ='';
        OM_GW_GE_Utils.tpl.Tipo_Comunicazione__c =OM_GW_GE_Utils.slOrig.EOF_TIpo_comunicazione__c;
            
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_GE_Utils.refTec = new contact();
        
        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }
    
    
    
    
    //cessazione
   /* static testMethod void OM_GW_Utils_TESTMETHOD_2() {

		TestDataFactory.CreateTestRecords(null,null,null);       

        Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
		ccus.Name='test1';
		ccus.caseDevName__c='EOF_Caso_Attivazione_OPENSTREAM_CeD';
		ccus.assetDevName__c='P2P';
		ccus.beAttivazioneList__c='Contributo Attivazione ,Canone';
		insert ccus;


		Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
		cer.name='testcer1';
		cer.ceName__c='VLAN1';
		cer.ceiDevName__c='CPE_Passivi';
		insert cer;

        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = 'Y';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.CreateTemplogOLO(frequest);

        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }*/
    
    //cessazione KO
    static testMethod void OM_GW_Utils_TESTMETHOD_3() {

		TestDataFactory.CreateTestRecords(null,null,null);              
		
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
        
        frequest.ID_RISORSA = 'risorsa1';         
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
        OM_GW_GE_Utils.tpl.TL_codice_ordine_olo__c =frequest.CODICE_ORDINE_OLO;
        OM_GW_GE_Utils.tpl.Tipo_Comunicazione__c =OM_GW_GE_Utils.slOrig.EOF_TIpo_comunicazione__c;
        
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }
    
    //Rimodulazione DAC
    static testMethod void OM_GW_Utils_TESTMETHOD_4() {

		TestDataFactory.CreateTestRecords('EOF Caso - Attivazione',null,null);       

        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
      
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
        
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }
    
    //Desospensione
    static testMethod void OM_GW_Utils_TESTMETHOD_5() {

		TestDataFactory.CreateTestRecords('EOF Caso - Attivazione',null,null);       

        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'D_A1';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Annullamento su richiesta olo';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
      
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        OM_GW_GE_Utils.caseOriginale.status = 'Sospeso';

        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
        
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }
    
    //Annullamento
    static testMethod void OM_GW_Utils_TESTMETHOD_6() {

		TestDataFactory.CreateTestRecords('EOF Caso - Attivazione',null,null);       

       
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Annullamento su richiesta olo';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'D_A1'; 
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
      
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
		 
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }
    
    //-------------------------- NACK
    
    //acquisizione
    static testMethod void OM_GW_Utils_TESTMETHOD_7() {

		TestDataFactory.CreateTestRecords(null,null,null);        

        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
        OM_GW_GE_Utils.tpl.TL_codice_ordine_olo__c =frequest.CODICE_ORDINE_OLO;
        OM_GW_GE_Utils.tpl.Tipo_Comunicazione__c =OM_GW_GE_Utils.slOrig.EOF_TIpo_comunicazione__c;
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        

        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }
    /*
    //cessazione
    static testMethod void OM_GW_Utils_TESTMETHOD_8() {

		TestDataFactory.CreateTestRecords(null,null,null);       

        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
        OM_GW_GE_Utils.tpl.TL_codice_ordine_olo__c =frequest.CODICE_ORDINE_OLO;
        OM_GW_GE_Utils.tpl.Tipo_Comunicazione__c =OM_GW_GE_Utils.slOrig.EOF_TIpo_comunicazione__c;
		 
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        

        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }
*/    
    //cessazione KO
    static testMethod void OM_GW_Utils_TESTMETHOD_9() {

		TestDataFactory.CreateTestRecords(null,null,null);       
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = 'Y';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
        
        frequest.ID_RISORSA = 'risorsa1';         
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
        OM_GW_GE_Utils.tpl.TL_codice_ordine_olo__c =frequest.CODICE_ORDINE_OLO;
        OM_GW_GE_Utils.tpl.Tipo_Comunicazione__c =OM_GW_GE_Utils.slOrig.EOF_TIpo_comunicazione__c;
		 
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        
        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }
    
    //Rimodulazione DAC
    static testMethod void OM_GW_Utils_TESTMETHOD_10() {

		TestDataFactory.CreateTestRecords('EOF Caso - Attivazione',null,null);       
		
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
      
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
		 
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        
        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }
    
    //Desospensione
    static testMethod void OM_GW_Utils_TESTMETHOD_11() {

		TestDataFactory.CreateTestRecords('EOF Caso - Attivazione',null,null);       
		
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'D_A1';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Annullamento su richiesta olo';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
      
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        OM_GW_GE_Utils.caseOriginale.status = 'Sospeso';
        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
		 
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        
        OM_GW_Utils.checkSync(frequest); 
        test.stopTest();     
    }
    
    //Annullamento
    static testMethod void OM_GW_Utils_TESTMETHOD_12() {

		TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);       
		
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Annullamento su richiesta olo';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'D_A1'; 
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
      
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.tpl.Name= frequest.CODICE_ORDINE_OLO +' - '+ OM_GW_GE_Utils.retCodOp(frequest) +' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
    	OM_GW_GE_Utils.tpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
    	OM_GW_GE_Utils.tpl.desc__c='TEMPLOG relativo alla FiberRequest del case:'+ frequest.codice_ordine_olo;
        OM_GW_GE_Utils.tpl.Type__c ='T';        
		 
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        
        OM_GW_Utils.checkSync(frequest);
		OM_GW_Utils.create_map(TestDataFactory.ESlog[0],'Create','1');
        test.stopTest();     
    }

    static testMethod void myTestMethod(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test_01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'XYZ';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_GE_Utils.checkCaseOriginale = true;
            OM_GW_GE_Utils.caseOriginale = new Case();
            OM_GW_GE_Utils.caseOriginale.EOF_Id_Notifica__c = 'test_01';

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //Codice ordine olo is blank
    static testMethod void myTestMethod2(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test_01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'XYZ';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //CODICE_ORDINE_OLO.length() > 18
    static testMethod void myTestMethod3(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_3702112016_3702112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test_01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'XYZ';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //Codice operatore blank
    static testMethod void myTestMethod4(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = '';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test_01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'XYZ';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //id notifica blank
    static testMethod void myTestMethod5(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = '';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'XYZ';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //ID_NOTIFICA.contains('�')
    static testMethod void myTestMethod6(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = '�';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'XYZ';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //DATA_NOTIFICA blank
    static testMethod void myTestMethod7(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = '';//EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'XYZ';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //DATA_NOTIFICA blank
    static testMethod void myTestMethod8(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = '12';//EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'XYZ';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //DATA_NOTIFICA blank
    static testMethod void myTestMethod9(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF1';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'XYZ';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //NOME_CLIENTE.contains('�')
    static testMethod void myTestMethod10(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = '�';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //recapito telefonico .contains('�')
    static testMethod void myTestMethod11(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '�';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //NOTE.contains('�')
    static testMethod void myTestMethod12(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '1';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = '�';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }

    //TIPO COMUNICAZIONE = 2
    //Recordtype != EOF_CASO_Attt
    static testMethod void myTestMethod13(){
        Test.startTest();
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'OF_SA_Attivazione' LIMIT 1].Id;


            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //Recordtype stato = espletato
    static testMethod void myTestMethod14(){
        Test.startTest();
            OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'XYZ';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
                    
                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Espletato';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Espletato' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //cognome_cliente is blank
    static testMethod void myTestMethod15(){
        Test.startTest();
            OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = '';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //COGNOME_CLIENTE.contains('�')
    static testMethod void myTestMethod16(){
        Test.startTest();
            OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = '�';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //NOME_REFERENTE_TECNICO_OLO.contains('�'
    static testMethod void myTestMethod17(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = '�';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //NOME_REFERENTE_TECNICO_OLO.contains('�'
    static testMethod void myTestMethod18(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = '�';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //COGNOME_REFERENTE_TECNICO_OLO.contains('�'
    static testMethod void myTestMethod19(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = '�';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //TELEFONO_REFERENTE_TECNICO_OLO.contains('�'
    static testMethod void myTestMethod20(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '�';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //EMAIL_REFERENTE_TECNICO_OLO check email
    static testMethod void myTestMethod21(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Giannitest.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //RECAPITO_TEST_LINEA contains('�'
    static testMethod void myTestMethod22(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
                frequest.RECAPITO_TEST_LINEA = '�';

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //NUMERO_TELEFONICO_PRINCIPALE_LINEA contains('�'
    static testMethod void myTestMethod23(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='�';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //OPZIONE_SYSTEM_UNICO contains('�'
    static testMethod void myTestMethod24(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 
                frequest.OPZIONE_SYSTEM_UNICO = 'S';

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //DATA_PREVISTA_ATTIVAZIONE is null
    static testMethod void myTestMethod25(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = null;// EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //DATA_PREVISTA_ATTIVAZIONE not date
    static testMethod void myTestMethod26(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = '12';// EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //RECAPITO_TELEFONICO_CLIENTE_1 isblank
    static testMethod void myTestMethod27(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //RECAPITO_TELEFONICO_CLIENTE_1 contains('�')
    static testMethod void myTestMethod28(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '�';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:34:56'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //ORARIO_APPUNTAMENTO not time
    static testMethod void myTestMethod29(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '2';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:22'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //TIPO COMUNICAZIONE = 3
    //Stato != sospeso
    static testMethod void myTestMethod30(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '3';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:22:33'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //RECAPITO_TELEFONICO_CLIENTE_1 is blank
    static testMethod void myTestMethod31(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '3';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:22:33'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Sospeso';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Sospeso' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //RECAPITO_TELEFONICO_CLIENTE_1 .contains('�'
    static testMethod void myTestMethod32(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '3';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '�';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:22:33'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Sospeso';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Sospeso' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //DATA_PREVISTA_ATTIVAZIONE not date
    static testMethod void myTestMethod33(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '3';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = '12';//EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:22:33'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Sospeso';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Sospeso' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //ORARIO_APPUNTAMENTO not time
    static testMethod void myTestMethod34(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '3';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Sospeso';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Sospeso' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    //TIPO COMUNICAZIONE = 4
    static testMethod void myTestMethod35(){
        Test.startTest();
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
            tibco.Name = 'Tibco UserID';
            tibco.OF_Tibco_ID__c = '00558000001f743AAA';
            insert tibco;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
            IpCustom.Name = 'Status';
            IpCustom.OF_Enable_Trigger__c = false;
            insert IpCustom; 
            EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
                frequest.TIPO_COMUNICAZIONE = '4';
                frequest.CODICE_OPERATORE = 'VF';
                frequest.CODICE_ORDINE_OLO = '02112016_37';
                frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
                frequest.ID_NOTIFICA = 'test01';
                frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
                frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
                frequest.GPON_VINCOLANTE = 'N';
                frequest.ID_RISORSA = 'risorsa';
                frequest.NOME_CLIENTE = 'as';
                frequest.COGNOME_CLIENTE = 'xs';
                frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123';
                frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
                frequest.PROVINCIA = 'Milano';
                frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='123';
                frequest.COMUNE = 'Milano';
                frequest.PARTICELLA_TOPONOMASTICA = '123';
                frequest.INDIRIZZO = 'Piazzale Gorini';
                frequest.NUMERO_CIVICO = '6';
                frequest.ID_BUILDING = '10_054_054039_8000064301_40';
                frequest.SCALA_PALAZZINA = '';
                frequest.NOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xs';
                frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
                frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
                frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
                frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
                frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
                frequest.APPARATO = 'Y';
                frequest.TIPOLOGIA_APPARATO = 'test';
                frequest.NOTE = 'xyz';
                frequest.TIPOLOGIA_SERVIZIO = '1';
                frequest.SLA_PREMIUM_ASSURANCE = 'Y';
                frequest.ORARIO_APPUNTAMENTO = '12:22:22'; 

                OM_GW_GE_Utils.caseOriginale = new Case();
                OM_GW_GE_Utils.caseOriginale.RecordTypeId = [Select Id FROM RecordType WHERE DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1].Id;
                OM_GW_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                insert OM_GW_GE_Utils.caseOriginale;
        		OM_GW_GE_Utils.caseOriginale = [SELECT Id, RecordTypeID, RecordType.DeveloperName, Status FROM Case WHERE Status = 'Acquisito KO' AND RecordType.DeveloperName = 'EOF_Caso_Attivazione' LIMIT 1];

            OM_GW_Utils.checkSync(frequest);
        Test.stopTest();
    } 
}
@isTest
 
public class EOF_GW_WS_Request_TEST{
    
    public static testMethod void WSRequestTest(){
                
		TestDataFactory.CreateTestRecords('EOF Caso - Attivazione',null,null);        
        
        //---------Fiber request Variables----------------------
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = String.valueOf(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        EOF_GW_WS_Request.FiberRequest(frequest);
        
        frequest.TIPO_COMUNICAZIONE = '';
        EOF_GW_WS_Request.FiberRequest(frequest);
        
        frequest.TIPO_COMUNICAZIONE ='11';
    }


    public static testMethod void WSRequestTestBlankTipo(){
        
		TestDataFactory.CreateTestRecords('EOF Caso - Attivazione',null,null);
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = String.valueOf(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        EOF_GW_WS_Request.FiberRequest(frequest);
        
        frequest.CODICE_ORDINE_OLO = '';
        EOF_GW_WS_Request.FiberRequest(frequest);
    }


    public static testMethod void WSRequestTest2(){
                
		TestDataFactory.CreateTestRecords('EOF Caso - Attivazione',null,null);
        
        //---------Fiber request Variables----------------------
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '5';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = String.valueOf(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        Test.startTest();
        EOF_GW_WS_Request.FiberRequest(frequest);
        Test.stopTest();
    }


    public static testMethod void WSRequestTest3(){
                
		TestDataFactory.CreateTestRecords('EOF Caso - Attivazione',null,null);
        
        //---------Fiber request Variables----------------------
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2018-02-13T17:25:15+01:00';
        frequest.ID_NOTIFICA = 'test_08';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '3056279623';
        frequest.DATA_PREVISTA_ATTIVAZIONE = '2018-06-29';
        frequest.NOTE = '';
        frequest.ORARIO_APPUNTAMENTO = '14:30:00';
	    
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        EOF_GW_WS_Request.FiberRequest(frequest);
        Test.stopTest();
    }    

    public static testMethod void WSRequestTest4(){

        map<String,String> rtMap = new map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            rtMap.put(rt.developername,rt.id);
        }
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = rtMap.get('OLO');
        
        insert accOLO;

        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = false);
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
        //---------Fiber request Variables----------------------
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = 'TEST_OP_CS_v010xc';
        frequest.DATA_NOTIFICA = '2017-12-12T16:25:00+02:00';
        frequest.ID_NOTIFICA = 'Test_cessaz_01';
        frequest.ID_RISORSA = 'PASS_2018-01-11_17:22:59';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '3056279623';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '3052936451';
        frequest.NOTE = 'cessazione da olo';
        frequest.APPARATO='Y';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        EOF_GW_WS_Request.FiberRequest(frequest);
        Test.stopTest();
    }    

    public static testMethod void WSRequestTest5(){
                
        map<String,String> rtMap = new map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            rtMap.put(rt.developername,rt.id);
        }
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = rtMap.get('OLO');
        
        insert accOLO;

        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = false);
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
                
        //---------Fiber request Variables----------------------
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = String.valueOf(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        EOF_GW_WS_Request.FiberRequest(frequest);
        Test.stopTest();

    }
    
}
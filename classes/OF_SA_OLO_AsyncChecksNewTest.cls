@isTest
global class OF_SA_OLO_AsyncChecksNewTest {
    global static testMethod void Method(){
        Test.startTest();
        List<RecordType> rtypes = [SELECT developerName, Id 
                                   FROM RecordType 
                                   WHERE (sObjectType = 'Case' OR sObjectType = 'Account' OR sObjectType = 'Contact' OR sObjectType = 'EOF_EAI_Service_Log__c')  
                                   AND isActive = true];
        
        map<String,Id> RTMap = new Map<String,Id>();
        
        for(RecordType rt : rtypes){
            RTMap.put(rt.DeveloperName, rt.Id);    
        }
        
        Account accOloSKY = new Account();       
        accOloSKY.Name = 'SKY';
        accOloSKY.EOF_Codice_Operatore__c = 'SKY';
        accOloSKY.Type = 'OLO';
        accOloSKY.Industry = 'Telecommunications';
        accOloSKY.RecordTypeId = RTMap.get('OLO');
        
        insert accOloSKY;
        /**Catalogo commerciale**/
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        /**END Catalogo commerciale**/
        
        /**Sevizio**/
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'Open Stream';
        serv.OF_Attivo__c = true;
        serv.OF_CatalogoCommerciale__c = catalogo.Id;
        serv.OF_DataInizioValidita__c = myDate;
        serv.OF_DataFineValidita__c = newDate;
        insert serv;
        /**END Servizio**/
        
        /**Commercial Element**/
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.name = 'Test'; 
        ce.OF_Servizio__c = serv.Id;
        ce.OF_DataInizioValidita__c = myDate;
        ce.OF_DataFineValidita__c = newDate;
        ce.OF_Alias__c = '1243;235;';
        insert ce;
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.Name = 'SKY';
        oloId.OF_Olo_Id__c = accOloSKY.Id;
        insert oloId; 
        //SECONDO CASE
         OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest Req2 = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ();
        
        Req2.CODICE_OPERATORE='SKY';
        Req2.CODICE_ORDINE_OLO='TEST_180119_002';
        Req2.DATA_NOTIFICA= String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        Req2.ID_NOTIFICA = String.valueOf(System.now().getTime());
        Req2.NOME_REFERENTE_TECNICO_OLO='Gianluca';
        Req2.COGNOME_REFERENTE_TECNICO_OLO='Galeazzi';
        Req2.TELEFONO_REFERENTE_TECNICO_OLO='876764';
        Req2.EMAIL_REFERENTE_TECNICO_OLO='gianluca.galeazzi@tistest.it';
        Req2.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH='01234567';
        Req2.NOME_CLIENTE='Carolina';
        Req2.COGNOME_CLIENTE='Giuppi';
        Req2.RECAPITO_TELEFONICO_CLIENTE_1='4352223';
        Req2.RECAPITO_TELEFONICO_CLIENTE_2='1234454';
        Req2.INFORMAZIONI_LOGISTICA_APPARATI='test';
        Req2.DATA_PREVISTA_ATTIVAZIONE='2019-02-05';
        Req2.ORARIO_APPUNTAMENTO='16:30:00';
        Req2.CODICE_PROGETTO_SPECIALE='';
        Req2.PROMOZIONE='020103';
        Req2.CLUSTER_PROMOZIONE='020103';
        Req2.NOTE='';
        Req2.ID_BUILDING='03_015_015146_8000050786_42';
        Req2.SCALA_PALAZZINA='';
        Req2.NUMERO_TELEFONICO_PRINCIPALE_LINEA='06432324';
        Req2.RECAPITO_TEST_LINEA='';
        Req2.IDENTIFICATIVO_DEL_POP='MI/FCO/9';
        Req2.PROFILO='45';
        Req2.IDENTIFICATIVO_PRENOTAZIONE = '1234';
        
        Req2.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO>();
        
        for(Integer i=0; i<1; i++){
            OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO serv1 = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
            serv1.NOME_SERVIZIO='Ribaltamento Impianto';
            serv1.INFORMAZIONI_SERVIZIO='0';
            Req2.SERVIZIO_AGGIUNTIVO.add(serv1);    
        }
        
        for(Integer i=0; i<1; i++){
            OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO servx = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
            servx.NOME_SERVIZIO='Estensione Impianto Cliente';
            servx.INFORMAZIONI_SERVIZIO='0';
            Req2.SERVIZIO_AGGIUNTIVO.add(servx);    
        }
        
        Req2.APPARATO = new List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO> ();
        for(Integer k=0; k<1; k++){
            OF_SA_WS_IN_OLO_ActivationNew.APPARATO serv2 = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO ();
            serv2.TIPOLOGIA_APPARATO='Modem';
            serv2.PASSWORD_APPARATO='123';
            serv2.AZIONE_APPARATO='1';
            serv2.CAUSALE ='NOLEGGIO';
            Req2.APPARATO.add(serv2);
        }
        
        for(Integer k=0; k<1; k++){
            OF_SA_WS_IN_OLO_ActivationNew.APPARATO servy = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO ();
            servy.TIPOLOGIA_APPARATO='SmartTV';
            servy.PASSWORD_APPARATO='123';
            servy.AZIONE_APPARATO='0';
            servy.CAUSALE='COMODATO';
            Req2.APPARATO.add(servy);
        }
        
        
        Req2.VLAN = new List<OF_SA_WS_IN_OLO_ActivationNew.VLAN> ();
        for(integer h=0;h<1;h++){
            OF_SA_WS_IN_OLO_ActivationNew.VLAN serv3 = new OF_SA_WS_IN_OLO_ActivationNew.VLAN ();
            serv3.KIT_CONSEGNA_VLAN='TIS_MI_1';
            serv3.USER_VLAN='835';
            serv3.SERVICE_VLAN='100';
            serv3.PROFILO_VLAN='AG11';
            serv3.INFORMAZIONI_VLAN='';
            serv3.CUSTOMER_VLAN='156';
            serv3.MODELLO_DI_SERVIZIO_VLAN='1:1';
            Req2.VLAN.add(serv3);
        }    
        for(integer h=0;h<1;h++){
            OF_SA_WS_IN_OLO_ActivationNew.VLAN serv4 = new OF_SA_WS_IN_OLO_ActivationNew.VLAN ();
            serv4.KIT_CONSEGNA_VLAN='TIS_MI_2';
            serv4.USER_VLAN='937';
            serv4.SERVICE_VLAN='200';
            serv4.PROFILO_VLAN='AG36';
            serv4.INFORMAZIONI_VLAN='';
            serv4.CUSTOMER_VLAN='156';
            serv4.MODELLO_DI_SERVIZIO_VLAN='1:1';
            Req2.VLAN.add(serv4);
            
        }               
        OF_SA_GE_UtilsNew.create_Eai_Log(Req2);
        
        Case c2 = new Case(); 
        //AA - Aggiunto check nuovo/vecchio flusso OM! 
        c2.OF_OM_Nuovo_Flusso__c = true;
        c2.RecordTypeId=OF_SA_GE_UtilsNew.rtMap.get('OF_SA_Attivazione');
        c2.EOF_Codice_Ordine_Olo__c=Req2.CODICE_ORDINE_OLO;
        c2.EOF_Codice_Operatore_WS__c = Req2.CODICE_OPERATORE;            
        c2.EOF_Codice_Ordine_OLO__c = Req2.CODICE_ORDINE_OLO;
        c2.EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.StringToDate(Req2.DATA_NOTIFICA);
        c2.EOF_Id_Notifica__c = Req2.ID_NOTIFICA;                 
        c2.EOF_Data_Prevista_Attivazione__c = OF_SA_GE_UtilsNew.StringToDateNoTime(Req2.DATA_PREVISTA_ATTIVAZIONE);
        c2.EOF_Identificativo_del_POP__c= Req2.IDENTIFICATIVO_DEL_POP;
        c2.EOF_ID_Building_WS__c = Req2.ID_BUILDING;
        //c.OF_SA_ID_Building__c = req.ID_BUILDING;
        c2.subject='Richiesta Attivazione';
        c2.status='Inviato';
        c2.EOF_FASE__C='NA';
        c2.PO_SA_Portale__c=OF_SA_GE_UtilsNew.PORTAL;
        c2.OF_SH_Token_id__c = '1234';
        //aa aggiunto campo 29/11/2018 
        c2.TRACCIATO_TRASCODIFICATO__c=Req2.TRACCIATO_TRASCODIFICATO;
        insert c2;
        //creo il record di generatore ID Servizio che poi mi andrò a querare in asincrono
        OF_Generatore_ID_Servizio__c g2 = new OF_Generatore_ID_Servizio__c();
        g2.OF_Case_Id__c=c2.Id;
        insert g2;
        EOF_EAI_Service_Log__c sl2 = [select id from EOF_EAI_Service_Log__c where OF_SA_Metodo__c ='OLO_ActivationSetup_OpenStream' AND EOF_CODICE_ORDINE_OLO__C ='TEST_180119_002'];
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(c2.Id, sl2.Id);
        Test.stopTest();
    }
    global static testMethod void Method1(){
        if(!OF_SA_GE_UtilsNew.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_SA_GE_UtilsNew.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_SA_GE_UtilsNew.RTMap.put(rt.developername,rt.id);
            }
            OF_SA_GE_UtilsNew.checkRTMap=true;
        }       
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        insert slFiberReq;
        
        system.debug('il service log ha id:' +slFiberReq.id);
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.EOF_Codice_Operatore__c ='VF';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();
        OF_SA_GE_UtilsNew.refTec.recordtypeId = OF_SA_GE_UtilsNew.rtMap.get('Referente_Tecnico_OLO');
        
        System.debug('Il Contact id è:' + OF_SA_GE_UtilsNew.refTec.id);
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('################# il case id è:'+ TestDataFactory.c1.id);
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        
        Test.stopTest(); 
        
        
    }
    
    //Network Inventory con stato building != 104 e 110
    global static testMethod void Method2(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 100;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    
    global static testMethod void Method2A(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 100;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
      
        
        OF_ElencoComuniItaliani__c ec = new OF_ElencoComuniItaliani__c();
        ec.OF_Comune__c = 'Test456';
        ec.OF_Provincia__c = 'Test123';
        ec.OF_CodiceIstat__c = ni.OF_SA_Comune__c;
        insert ec;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    
    //Network Inventory con pop sbagliato
    global static testMethod void Method3(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        


        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
       
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'TestTest';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    
    //Network Inventory con data non RFA/RFC
    global static testMethod void Method4(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = string.valueof(system.today());
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();        

        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    
    //Network Inventory ok
    global static testMethod void Method5(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        OF_SA_WS_IN_OLO_ActivationNew.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'Test';
        OLO_VAN.USER_VLAN = 'Test';
        OLO_VAN.SERVICE_VLAN = 'Test';
        OLO_VAN.PROFILO_VLAN = 'Test';
        OLO_VAN.INFORMAZIONI_VLAN = 'Test';
        OLO_VAN.CUSTOMER_VLAN = 'Test';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'Test';
        List<OF_SA_WS_IN_OLO_ActivationNew.VLAN> OLO_VLANList = new List<OF_SA_WS_IN_OLO_ActivationNew.VLAN>();
        OLO_VLANList.add(OLO_VAN);
        
        OF_SA_WS_IN_OLO_ActivationNew.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'Test';
        OLO_APPARATO.PASSWORD_APPARATO = 'Test';
        OLO_APPARATO.AZIONE_APPARATO = 'Test';
        List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO> OLO_APPARATOList = new List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO>();
        OLO_APPARATOList.add(OLO_APPARATO);
        
        OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'Test'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'Test';
        List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO> OLO_SERAGGList = new List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO>();
        OLO_SERAGGList.add(OLO_SERAGG);
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        /**End Network Inventory**/
        
        /**Elenco comuni italiani**/
        OF_ElencoComuniItaliani__c EC = new OF_ElencoComuniItaliani__c();
        EC.OF_CodiceIstat__c = ni.OF_SA_Comune__c;
        EC.OF_Comune__c = 'Test';
        EC.OF_Provincia__c = 'Test';
        insert EC;
        /**End Elenco comuni italiani**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    //Network Inventory ok
    global static testMethod void Method5bis(){
        if(!OF_SA_GE_UtilsNew.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_SA_GE_UtilsNew.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_SA_GE_UtilsNew.RTMap.put(rt.developername,rt.id);
            }
            OF_SA_GE_UtilsNew.checkRTMap=true;
        }
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        
    /**Catalogo commerciale**/
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        /**END Catalogo commerciale**/
        
        /**Sevizio**/
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'Open Stream';
        serv.OF_Attivo__c = true;
        serv.OF_CatalogoCommerciale__c = catalogo.Id;
        serv.OF_DataInizioValidita__c = myDate;
        serv.OF_DataFineValidita__c = newDate;
        insert serv;
        /**END Servizio**/
        
        /**Commercial Element**/
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.name = 'Test'; 
        ce.OF_Servizio__c = serv.Id;
        ce.OF_DataInizioValidita__c = myDate;
        ce.OF_DataFineValidita__c = newDate;
        ce.OF_Alias__c = '1243;235;';
        ce.OF_Attivo__c = true;
        insert ce;
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        OF_SA_WS_IN_OLO_ActivationNew.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'Test';
        OLO_VAN.USER_VLAN = 'Test';
        OLO_VAN.SERVICE_VLAN = 'Test';
        OLO_VAN.PROFILO_VLAN = 'Test';
        OLO_VAN.INFORMAZIONI_VLAN = 'Test';
        OLO_VAN.CUSTOMER_VLAN = 'Test';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'Test';
        List<OF_SA_WS_IN_OLO_ActivationNew.VLAN> OLO_VLANList = new List<OF_SA_WS_IN_OLO_ActivationNew.VLAN>();
        OLO_VLANList.add(OLO_VAN);
        
        OF_SA_WS_IN_OLO_ActivationNew.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'Test';
        OLO_APPARATO.PASSWORD_APPARATO = 'Test';
        OLO_APPARATO.AZIONE_APPARATO = 'Test';
        List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO> OLO_APPARATOList = new List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO>();
        OLO_APPARATOList.add(OLO_APPARATO);
        
        OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'Test'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'Test';
        List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO> OLO_SERAGGList = new List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO>();
        OLO_SERAGGList.add(OLO_SERAGG);
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2019-02-10';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        Account accOLO = new Account();
            accOLO.Name = 'Vodafone';
            accOLO.EOF_Codice_Operatore__c = 'VF';
            accOLO.Type = 'OLO';
            accOLO.Industry = 'Telecommunications';
            accOLO.RecordTYpeId = OF_SA_GE_UtilsNew.RTMap.get('OLO');
        insert accOLO;
        
        case c12 = new case();
            c12.EOF_Codice_Ordine_OLO__c = 'Test_1231241241241';
            c12.EOF_Codice_Operatore_WS__c ='VF';
            c12.EOF_Contact__c = null;
            c12.status = 'Accettato';
            c12.EOF_FASE__C = 'NA';
            c12.EOF_ID_Building_WS__c ='Test';
            c12.RecordTypeId = OF_SA_GE_UtilsNew.RTMap.get('OF_SA_Attivazione');
            c12.EOF_DATA_NOTIFICA__c=system.now();
            c12.EOF_Data_Prevista_Attivazione__c=Date.newInstance(2019, 02, 10);
        insert c12;
        Id RecordTypeIdser2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();         
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        EOF_EAI_Service_Log__c ser2 = new EOF_EAI_Service_Log__c();
        ser2.EOF_PROFILO__c = '17';
        ser2.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser2.EOF_ID_Notifica__c = '1529661331590';
        ser2.Caso__c=c12.id;  
        ser2.OF_SA_NOME_SERVIZIO__c = '1243';
        ser2.RecordtypeId = RecordTypeIdser2;
        ser2.EOF_Codice_Ordine_Olo__c = 'abc';
        ser2.OF_SA_servizi_Aggiuntivi_Log__c = slFiberReq.Id;
        insert ser2;
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
        System.debug('AAAA ' + bh_dac);
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        /**End Network Inventory**/
        
        /**Elenco comuni italiani**/
        OF_ElencoComuniItaliani__c EC = new OF_ElencoComuniItaliani__c();
        EC.OF_CodiceIstat__c = ni.OF_SA_Comune__c;
        EC.OF_Comune__c = 'Test';
        EC.OF_Provincia__c = 'Test';
        insert EC;
        /**End Elenco comuni italiani**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(c12.id,slFiberReq.id);
        Test.stopTest();         
    }
    //Nome cliente e OF_SA_ID_Servizio__c e contatti vuoti - NI OK
    global static testMethod void Method6(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        OF_SA_WS_IN_OLO_ActivationNew.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'Test';
        OLO_VAN.USER_VLAN = 'Test';
        OLO_VAN.SERVICE_VLAN = 'Test';
        OLO_VAN.PROFILO_VLAN = 'Test';
        OLO_VAN.INFORMAZIONI_VLAN = 'Test';
        OLO_VAN.CUSTOMER_VLAN = 'Test';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'Test';
        
        OF_SA_WS_IN_OLO_ActivationNew.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'Test';
        OLO_APPARATO.PASSWORD_APPARATO = 'Test';
        OLO_APPARATO.AZIONE_APPARATO = 'Test';
        
        OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'Test'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'Test';
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = '';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_ActivationNew.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        /**End Network Inventory**/
        
        /**Elenco comuni italiani**/
        OF_ElencoComuniItaliani__c EC = new OF_ElencoComuniItaliani__c();
        EC.OF_CodiceIstat__c = ni.OF_SA_Comune__c;
        EC.OF_Comune__c = 'Test';
        EC.OF_Provincia__c = 'Test';
        insert EC;
        /**End Elenco comuni italiani**/
        
        
        /**Catalogo commerciale**/
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        /**END Catalogo commerciale**/
        
        /**Sevizio**/
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'Open Stream';
        serv.OF_Attivo__c = true;
        serv.OF_CatalogoCommerciale__c = catalogo.Id;
        serv.OF_DataInizioValidita__c = myDate;
        serv.OF_DataFineValidita__c = newDate;
        insert serv;
        /**END Servizio**/
        
        /**Commercial Element**/
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.name = OLO_SERAGG.NOME_SERVIZIO; 
        ce.OF_Servizio__c = serv.Id;
        ce.OF_DataInizioValidita__c = myDate;
        ce.OF_DataFineValidita__c = newDate;
        ce.OF_Alias__c = 'Test1';
        insert ce;
        /**END Commercial Element Istanziato**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
                
    }
    
    
    //Testa il metodo OLO_AsyncStatusUpdate
    global static testMethod void Method7(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        
        
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        StatReq.CODICE_OPERATORE = 'TIS';
        StatReq.CODICE_ORDINE_OLO = 'Test';
        StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        StatReq.ID_NOTIFICA = 'Test';
        StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'M';
        StatReq.MOTIVAZIONE = 'M';
        StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        StatReq.ORARIO_APPUNTAMENTO = 'Test';
        StatReq.NOME_CLIENTE = 'Test';
        StatReq.COGNOME_CLIENTE = 'Test';
        StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        StatReq.NOTE = 'Test';
        

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        insert OF_SA_GE_UtilsNew.slOLOSF;
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncStatusUpdateNew(TestDataFactory.c1.Id, OF_SA_GE_UtilsNew.slOLOSF.Id);
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OLO_Response.Esito_element respTemp= stub.NotifyAggiornaStato(eoflst);
        Test.stopTest(); 
        

    }
    
   
    //Testa il metodo OLO_AsyncReschedule
    global static testMethod void Method8(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        
        
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        RR.CODICE_ORDINE_OF = 'Test';
        RR.CODICE_OPERATORE = 'TIS';
        RR.CODICE_ORDINE_OLO = 'Test';
        RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        RR.ID_NOTIFICA = 'Test';
        RR.NOME_CLIENTE = 'Test';
        RR.COGNOME_CLIENTE = 'Test';
        RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        RR.ORARIO_APPUNTAMENTO = 'Test';
        RR.NOTE = 'Test';
        RR.CODICE_MOTIVAZIONE = 'M';
        RR.MOTIVAZIONE = 'M';
        
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        insert OF_SA_GE_UtilsNew.slSFOLO;
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncRescheduleNew(TestDataFactory.c1.Id, OF_SA_GE_UtilsNew.slSFOLO.Id);
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OLO_Response.Esito_element respTemp= stub.NotifyAggiornaStato(eoflst);
        Test.stopTest(); 
        
    }
    
    
    //Testa il metodo OLO_AsyncDeactivation - non esiste l'asset
    global static testMethod void Method9(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - FiberRequest', null);        

       
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest DR = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        DR.CODICE_OPERATORE = 'TIS';
        DR.CODICE_ORDINE_OLO = 'Test';
        DR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        DR.ID_NOTIFICA = 'Test';
        DR.ID_RISORSA = 'Test';
        DR.NOME_CLIENTE = 'Test';
        DR.COGNOME_CLIENTE = 'Test';
        DR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        DR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        DR.CODICE_MOTIVAZIONE = 'M';
        DR.MOTIVAZIONE = 'M';
        DR.NOTE = 'Test';
        
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.cliente.name='Marco';
        
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        
        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();

        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncDeactivationNew(TestDataFactory.c1.id, TestDataFactory.ESlog[0].id);
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OLO_Response.Esito_element respTemp= stub.NotifyAggiornaStato(eoflst);
        Test.stopTest(); 
        
    }
    global static testMethod void Method9bis(){
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        List<RecordType> rtypes = [SELECT developerName, Id 
                                   FROM RecordType 
                                   WHERE (sObjectType = 'Case' OR sObjectType = 'Account' OR sObjectType = 'Contact' OR sObjectType = 'EOF_EAI_Service_Log__c')  
                                   AND isActive = true];
        
        map<String,Id> RTMap = new Map<String,Id>();
        
        for(RecordType rt : rtypes){
            RTMap.put(rt.DeveloperName, rt.Id);    
        }
        
        Account accOloSKY = new Account();       
        accOloSKY.Name = 'SKY';
        accOloSKY.EOF_Codice_Operatore__c = 'SKY';
        accOloSKY.Type = 'OLO';
        accOloSKY.Industry = 'Telecommunications';
        accOloSKY.RecordTypeId = RTMap.get('OLO');
        
        insert accOloSKY;
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.Name = 'SKY';
        oloId.OF_Olo_Id__c = accOloSKY.Id;
        insert oloId;               
       
        OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest DR = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest();
        DR.CODICE_OPERATORE = 'SKY';
        DR.CODICE_ORDINE_OLO='TEST_CESS_'+String.valueOf(system.now()).right(8);
        DR.DATA_NOTIFICA= String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        DR.ID_NOTIFICA = String.valueOf(System.now().getTime());
        DR.ID_RISORSA = 'ATT_2018-12-12_09:47:43';
        DR.NOME_CLIENTE = 'NOME';
        DR.COGNOME_CLIENTE = 'COGNOME';
        DR.RECAPITO_TELEFONICO_CLIENTE_1 = '88888888';
        DR.RECAPITO_TELEFONICO_CLIENTE_2 = '88888888';
        DR.NOTE = 'test';
        
                
        Case c = new Case();
        c.OF_OM_Nuovo_Flusso__c = true;
        c.subject='Richiesta Cessazione';
        c.recordtypeId=rtMap.get('OF_SA_Cessazione');
        c.Status='Inviato';
        c.EOF_Id_Risorsa__c=DR.ID_Risorsa;
        c.EOF_Codice_Ordine_Olo__c=DR.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = DR.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = DR.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.StringToDate(DR.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = DR.ID_NOTIFICA;
        c.PO_SA_Portale__c=OF_SA_GE_UtilsNew.PORTAL;
        //aa aggiunto campo 29/11/2018
        c.TRACCIATO_TRASCODIFICATO__c= DR.TRACCIATO_TRASCODIFICATO;
        insert c; 
        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(dr);
        upsert OF_SA_GE_UtilsNew.slOLOSF;
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncDeactivationNew(c.id, OF_SA_GE_UtilsNew.slOLOSF.id);
        
        Test.stopTest(); 
        
    }
    global static testMethod void Method9bis2(){
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        List<RecordType> rtypes = [SELECT developerName, Id 
                                   FROM RecordType 
                                   WHERE (sObjectType = 'Case' OR sObjectType = 'Account' OR sObjectType = 'Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'Asset')  
                                   AND isActive = true];
        
        map<String,Id> RTMap = new Map<String,Id>();
        
        for(RecordType rt : rtypes){
            RTMap.put(rt.DeveloperName, rt.Id);    
        }
        
        Account accOloSKY = new Account();       
        accOloSKY.Name = 'SKY';
        accOloSKY.EOF_Codice_Operatore__c = 'SKY';
        accOloSKY.Type = 'OLO';
        accOloSKY.Industry = 'Telecommunications';
        accOloSKY.RecordTypeId = RTMap.get('OLO');
        
        insert accOloSKY;
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.Name = 'SKY';
        oloId.OF_Olo_Id__c = accOloSKY.Id;
        insert oloId;               
       
        OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest DR = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest();
        DR.CODICE_OPERATORE = 'SKY';
        DR.CODICE_ORDINE_OLO='TEST_CESS_'+String.valueOf(system.now()).right(8);
        DR.DATA_NOTIFICA= String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        DR.ID_NOTIFICA = String.valueOf(System.now().getTime());
        DR.ID_RISORSA = 'ATT_2018-12-12_09:47:43';
        DR.NOME_CLIENTE = 'NOME';
        DR.COGNOME_CLIENTE = 'COGNOME';
        DR.RECAPITO_TELEFONICO_CLIENTE_1 = '88888888';
        DR.RECAPITO_TELEFONICO_CLIENTE_2 = '88888888';
        DR.NOTE = 'test';
        
                
        Case c = new Case();
        c.OF_OM_Nuovo_Flusso__c = true;
        c.subject='Richiesta Cessazione';
        c.recordtypeId=rtMap.get('OF_SA_Cessazione');
        c.Status='Inviato';
        c.EOF_Id_Risorsa__c='Test_asset_AA';
        c.EOF_Codice_Ordine_Olo__c=DR.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = DR.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = DR.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.StringToDate(DR.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = DR.ID_NOTIFICA;
        c.PO_SA_Portale__c=OF_SA_GE_UtilsNew.PORTAL;
        //aa aggiunto campo 29/11/2018
        c.TRACCIATO_TRASCODIFICATO__c= DR.TRACCIATO_TRASCODIFICATO;
        insert c; 
        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(dr);
        upsert OF_SA_GE_UtilsNew.slOLOSF;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Test_asset_AA';
        a.EOF_Id_Risorsa__c = 'Test_asset_AA';
        a.RecordTypeId = RTMap.get('OF_OpenStream');
        a.AccountId = accOloSKY.Id;
        insert a;
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncDeactivationNew(c.id, OF_SA_GE_UtilsNew.slOLOSF.id);
        
        Test.stopTest(); 
        
    }

     global static testMethod void Method9bis3(){
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        List<RecordType> rtypes = [SELECT developerName, Id 
                                   FROM RecordType 
                                   WHERE (sObjectType = 'Case' OR sObjectType = 'Account' OR sObjectType = 'Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'Asset')  
                                   AND isActive = true];
        
        map<String,Id> RTMap = new Map<String,Id>();
        
        for(RecordType rt : rtypes){
            RTMap.put(rt.DeveloperName, rt.Id);    
        }
        
        Account accOloSKY = new Account();       
        accOloSKY.Name = 'SKY';
        accOloSKY.EOF_Codice_Operatore__c = 'SKY';
        accOloSKY.Type = 'OLO';
        accOloSKY.Industry = 'Telecommunications';
        accOloSKY.RecordTypeId = RTMap.get('OLO');
        
        insert accOloSKY;
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.Name = 'SKY';
        oloId.OF_Olo_Id__c = accOloSKY.Id;
        insert oloId;               
       
        OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest DR = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest();
        DR.CODICE_OPERATORE = 'SKY';
        DR.CODICE_ORDINE_OLO='TEST_CESS_'+String.valueOf(system.now()).right(8);
        DR.DATA_NOTIFICA= String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        DR.ID_NOTIFICA = String.valueOf(System.now().getTime());
        DR.ID_RISORSA = 'ATT_2018-12-12_09:47:43';
        DR.NOME_CLIENTE = 'NOME';
        DR.COGNOME_CLIENTE = 'COGNOME';
        DR.RECAPITO_TELEFONICO_CLIENTE_1 = '88888888';
        DR.RECAPITO_TELEFONICO_CLIENTE_2 = '88888888';
        DR.NOTE = 'test';
        
                
        Case c = new Case();
        c.OF_OM_Nuovo_Flusso__c = true;
        c.subject='Richiesta Cessazione';
        c.recordtypeId=rtMap.get('OF_SA_Cessazione');
        c.Status='Inviato';
        c.EOF_Id_Risorsa__c='Test_asset_AA';
        c.EOF_Codice_Ordine_Olo__c=DR.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = DR.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = DR.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.StringToDate(DR.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = DR.ID_NOTIFICA;
        c.PO_SA_Portale__c=OF_SA_GE_UtilsNew.PORTAL;
        //aa aggiunto campo 29/11/2018
        c.TRACCIATO_TRASCODIFICATO__c= DR.TRACCIATO_TRASCODIFICATO;
        insert c; 
        OF_SA_GE_UtilsNew.slOLOSF = OF_SA_GE_UtilsNew.create_EAI_Log(dr);
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__C='';
        upsert OF_SA_GE_UtilsNew.slOLOSF;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Test_asset_AA';
        a.EOF_Id_Risorsa__c = 'Test_asset_AA';
        a.RecordTypeId = RTMap.get('OF_OpenStream');
        a.AccountId = accOloSKY.Id;
        insert a;
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncDeactivationNew(c.id, OF_SA_GE_UtilsNew.slOLOSF.id);
        
        Test.stopTest(); 
        
    }
    global static testMethod void Method11(){
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - Vlan', null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,TestDataFactory.ESlog[0].id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();

        Test.stopTest(); 
        
        
    }

    global static testMethod void Method12(){
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - Cpe', null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        
        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();

        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,TestDataFactory.ESlog[0].id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();

        Test.stopTest(); 
        
        
    }

    global static testMethod void Method13(){
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - Servizi Aggiuntivi', null);        


        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,TestDataFactory.sa.id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();

        Test.stopTest(); 
        
        
    }

    global static testMethod void Method14(){
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - Servizi Aggiuntivi', null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,TestDataFactory.sa.id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();

        Test.stopTest(); 
        
        
    }
    
    global static testMethod void Method14A(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_SH_Token_id__c = 'Token';
        insert c;
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - Servizi Aggiuntivi', null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'Test'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'Test';

        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
                /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.OF_SA_NOME_SERVIZIO__c = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.OF_SA_NOME_SERVIZIO__c = 'Test1';
        insert slFiberReq1;
        /**End Service log**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        /**End Network Inventory**/
        
        /**Elenco comuni italiani**/
        OF_ElencoComuniItaliani__c EC = new OF_ElencoComuniItaliani__c();
        EC.OF_CodiceIstat__c = ni.OF_SA_Comune__c;
        EC.OF_Comune__c = 'Test';
        EC.OF_Provincia__c = 'Test';
        insert EC;
        /**End Elenco comuni italiani**/
        
        
        /**Catalogo commerciale**/
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        /**END Catalogo commerciale**/
        
        /**Sevizio**/
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'Open Stream';
        serv.OF_Attivo__c = true;
        serv.OF_CatalogoCommerciale__c = catalogo.Id;
        serv.OF_DataInizioValidita__c = myDate;
        serv.OF_DataFineValidita__c = newDate;
        insert serv;
        /**END Servizio**/
        
        /**Commercial Element**/
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.name = OLO_SERAGG.NOME_SERVIZIO; 
        ce.OF_Servizio__c = serv.Id;
        ce.OF_DataInizioValidita__c = myDate;
        ce.OF_DataFineValidita__c = newDate;
        ce.OF_Alias__c = 'Test1';
        insert ce;
        /**END Commercial Element Istanziato**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.OF_SA_NOME_SERVIZIO__c = 'Test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.OF_SA_NOME_SERVIZIO__c = 'Test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_GE_UtilsNew.caseOriginale = c;
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,TestDataFactory.sa.id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();

        Test.stopTest(); 
        
        
    }

    global static testMethod void Method15(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = TestDataFactory.c1.EOF_ID_Building_WS__c;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }

    global static testMethod void Method16(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = TestDataFactory.c1.EOF_ID_Building_WS__c;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 101;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }

    global static testMethod void Method17(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = TestDataFactory.c1.EOF_ID_Building_WS__c;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c ='TIS_20170403_000000001';
        
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('la data precedente è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
               
        TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c = Date.valueof('2024-11-16');
        system.debug('la data nuova è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }

    global static testMethod void Method18(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);       

        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = TestDataFactory.c1.EOF_ID_Building_WS__c;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c ='TIS_20170403_000000001';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_ID_POP__c = ni.OF_SA_Pop__c;
        
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';


        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('la data precedente è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
               
        TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c = Date.valueof('2024-11-16');
        
        OF_Generatore_ID_Servizio__c g= new OF_Generatore_ID_Servizio__c();
        g.OF_Case_Id__c=TestDataFactory.c1.id;
        insert g;         
        
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    
    //metodo per testare la NotifyServiceMockupNACK
    global static testMethod void Method19(){
        
        if(!OF_SA_GE_UtilsNew.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_SA_GE_UtilsNew.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_SA_GE_UtilsNew.RTMap.put(rt.developername,rt.id);
            }
            OF_SA_GE_UtilsNew.checkRTMap=true;
        }
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);        

        
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        insert slFiberReq;
        
        system.debug('il service log ha id:' +slFiberReq.id);
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.EOF_Codice_Operatore__c ='VF';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());
        
        OF_SA_GE_UtilsNew.cliente = new Account();
        OF_SA_GE_UtilsNew.refTec = new contact();
        OF_SA_GE_UtilsNew.refTec.recordtypeId = OF_SA_GE_UtilsNew.rtMap.get('Referente_Tecnico_OLO');
        
        
        OF_SA_GE_UtilsNew.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            

        OF_SA_GE_UtilsNew.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_UtilsNew.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        OF_SA_GE_UtilsNew.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_UtilsNew.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('################# il case id è:'+ TestDataFactory.c1.id);
        OF_SA_OLO_AsyncChecksNew.OLO_AsyncActivationNew(TestDataFactory.c1.id,slFiberReq.id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        
        Test.stopTest(); 
        
        
    }
}
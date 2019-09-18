@isTest
public class OF_TTM_Utils_Test1 {
    
    public static testmethod void Method1(){
        
        OF_TTM_Utils util = new OF_TTM_Utils();
                
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        tt.NOTE = 'Test';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        map<string,string> mps = new map<string,string>();
		mps.put('Type','TT_ACK');
        
        map<string,string> mps2 = new map<string,string>();
		mps2.put('Type','TT_NACK');
        
        map<string,string> mps3 = new map<string,string>();
		mps3.put('Type','Trouble Ticket - Richiesta Scartata');
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = tt.CODICE_COMUNICAZIONE_OLO;
        insert c;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'In Inserimento';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Codice_Comunicazione_OLO__c='Test';
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        nGPON.EOF_Codice_Comunicazione_OLO__c=nGPON.EOF_Codice_Comunicazione_OLO__c;
        insert nGPON;
        
        OF_TTM_Utils.setNotify(nGPON);
        OF_TTM_Utils.getNotify();

        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - TT - TroubleTicketRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c = 'In Inserimento';
        insert eaiLog;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        List<Asset> astList = new List<Asset>();
        Asset ast = new Asset();
        ast.Name= eaiLog1.EOF_Id_Risorsa__c;
        ast.Status = 'Attivo';
        ast.EOF_ID_Risorsa__c = 'Test';
        ast.AccountId = accOLO.Id;  
        insert ast;
        astList.add(ast);
        
        OF_TTM_Utils.create_EAI_Log(tt);
        eaiLog1.EOF_NOTE__c = '';
        OF_TTM_Utils.create_EAI_Log(tt);
        OF_TTM_Utils.create_EAI_Log(mps);
        OF_TTM_Utils.create_EAI_Log(mps2);
        OF_TTM_Utils.create_EAI_Log(mps3);
        
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE name='DAC'];
        boolean b = BusinessHours.isWithin(bh.id, OF_TTM_Utils.now());
        boolean premium = True;
        OF_TTM_Utils.calcoloSLA(premium);
        
        OF_TTM_Utils.copy_TT_request(tt);
        
        OF_TTM_Utils.dateToString(System.today());
        
        OF_TTM_Utils.stringToDate('2018-07-19T13:00:00+01:00');
        
        OF_TTM_Utils.stringToDateNoTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.stringToDateNoTime('');
        String S = '2018-07-19';
        OF_TTM_Utils.checkDate(s);
        
        String S1 = '';
        OF_TTM_Utils.checkDate(s1);
        
        String S2 = 'Test';
        OF_TTM_Utils.checkDate(s2);
        
        OF_TTM_Utils.checkTime('11:11:11');
        OF_TTM_Utils.checkTime(' ');
        OF_TTM_Utils.checkTime(null);
        OF_TTM_Utils.checkTime('11:11:oo');
        
        OF_TTM_Utils.checkDateTime('');
        OF_TTM_Utils.checkDateTime(null);
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:000');
        
        OF_TTM_Utils.now();
        
        String a = '';
        OF_TTM_Utils.getStringTipoComunicazione(a);
        
        String a1 = '1';
        OF_TTM_Utils.getStringTipoComunicazione(a1);
        
        String a2 = '2';
        OF_TTM_Utils.getStringTipoComunicazione(a2);
        
        String a3 = '3';
        OF_TTM_Utils.getStringTipoComunicazione(a3);
        
        String a4 = '4';
        OF_TTM_Utils.getStringTipoComunicazione(a4);
        
        String a5 = '5';
        OF_TTM_Utils.getStringTipoComunicazione(a5);
        
        String a6 = '6';
        OF_TTM_Utils.getStringTipoComunicazione(a6);
        
        String a7 = '7';
        OF_TTM_Utils.getStringTipoComunicazione(a7);
        
        String a8 = '8';
        OF_TTM_Utils.getStringTipoComunicazione(a8);
        
        String a9 = '9';
        OF_TTM_Utils.getStringTipoComunicazione(a9);
        
        String a10 = '10';
        OF_TTM_Utils.getStringTipoComunicazione(a10);
        
        String a11 = '11';
        OF_TTM_Utils.getStringTipoComunicazione(a11);
        
        String a12 = '12';
        OF_TTM_Utils.getStringTipoComunicazione(a12);
        
        String a13 = '13';
        OF_TTM_Utils.getStringTipoComunicazione(a13);
        
        String a20 = '20';
        OF_TTM_Utils.getStringTipoComunicazione(a20);
        
        String a21 = '21';
        OF_TTM_Utils.getStringTipoComunicazione(a21);
        
        String a99 = '99';
        OF_TTM_Utils.getStringTipoComunicazione(a99);
        
        String b1 = '';
        OF_TTM_Utils.getValueTipoComunicazione(b1);
        
        String b2 = 'Notifica Scarto';
        OF_TTM_Utils.getValueTipoComunicazione(b2);
        
        String b5 = 'Notifica Richiesta Chiusura';
        OF_TTM_Utils.getValueTipoComunicazione(b5);
        
        String b3 = 'Notifica Presa in Carico';
        OF_TTM_Utils.getValueTipoComunicazione(b3);
        
        String b4 = 'Notifica Sospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b4);
        
        String b7 = 'Notifica Desospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b7);
        
        String b10 = 'Notifica Annullamento';
        OF_TTM_Utils.getValueTipoComunicazione(b10);
        
        String b13 = 'Notifica Timeout OK';
        OF_TTM_Utils.getValueTipoComunicazione(b13);
        
        String b21 = 'Notifica Aggiornamento Dati';
        OF_TTM_Utils.getValueTipoComunicazione(b21);
        
        OF_TTM_Utils.getStringCategoriaGuasto(s1);
        String a0 = '0';
        OF_TTM_Utils.getStringCategoriaGuasto(a0);
        OF_TTM_Utils.getStringCategoriaGuasto(a1);
        OF_TTM_Utils.getStringCategoriaGuasto(a2);
        
        OF_TTM_Utils.getStringCausaleDesospensione(s1);
        OF_TTM_Utils.getStringCausaleDesospensione(a2);
        OF_TTM_Utils.getStringCausaleDesospensione(a3);
        
        OF_TTM_Utils.getStringCausaleApertura(s1);
        OF_TTM_Utils.getStringCausaleApertura(a1);
        OF_TTM_Utils.getStringCausaleApertura(a2);
        OF_TTM_Utils.getStringCausaleApertura(a3);
        OF_TTM_Utils.getStringCausaleApertura(a4);
        
        OF_TTM_Utils.getValueStatoTicket(s1);
        
        String c1 = 'Scartato';
        OF_TTM_Utils.getValueStatoTicket(c1);
        
        String c2 = 'In Lavorazione';
        OF_TTM_Utils.getValueStatoTicket(c2);
        
        String c3 = 'Sospeso';
        OF_TTM_Utils.getValueStatoTicket(c3);
        
        String c4 = 'Chiuso';
        OF_TTM_Utils.getValueStatoTicket(c4);
        
        String c5 = 'Annullato';
        OF_TTM_Utils.getValueStatoTicket(c5);
        
        String c6 = 'Richiesta Chiusura';
        OF_TTM_Utils.getValueStatoTicket(c6);
        
        OF_TTM_Utils.getValueCausaleScarto(s1);
        
        String d1 = 'Formato dati errato o incompleto';
        OF_TTM_Utils.getValueCausaleScarto(d1);
        
        String d2 = 'Ticket aperto per stesso ID risorsa';
        OF_TTM_Utils.getValueCausaleScarto(d2);
        
        String d3 = 'ID Risorsa Inesistente';
        OF_TTM_Utils.getValueCausaleScarto(d3);
        
        String d4 = 'Codice Comunicazione OLO già presente';
        OF_TTM_Utils.getValueCausaleScarto(d4);
        
        String d5 = 'Guasto Aperto come Post-Provisioning oltre i termini previsti';
        OF_TTM_Utils.getValueCausaleScarto(d5);
        
        OF_TTM_Utils.getCausaleSospensione(s1);
        OF_TTM_Utils.getCausaleSospensione(a1);
        OF_TTM_Utils.getCausaleSospensione(a2);
        OF_TTM_Utils.getCausaleSospensione(a3);
        
        OF_TTM_Utils.getValueCausaleSospensione(s1);
        
        String e1 = 'SEDE OLO/CLIENTE FINALE INACCESSIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e1);
        
        String e2 = 'CLIENTE IRREPERIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e2);
        
        String e3 = 'CLIENTE INDISPONIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e3);
        
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(s1);
        
        String f1 = 'RISOLTO: TRATTA VERTICALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f1);
        
        String f2 = 'RISOLTO TRATTA ORIZZONTALE: CENTRALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f2);
        
        String f3 = 'RISOLTO TRATTA ORIZZONTALE: RETE PRIMARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f3);
        
        String f4 = 'RISOLTO TRATTA ORIZZONTALE: RETE SECONDARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f4);
        
        String f5 = 'NON RISCONTRATO: SENZA USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f5);
        
        String f6 = 'NON RISCONTRATO: CON USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f6);
        
        String f7 = 'RISOLTO: SBRACCIO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f7);
        
        String f8 = 'RISOLTO: BORCHIA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f8);
        
        String f9 = 'NON RISOLVIBILE: CAUSA IMPIANTO CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f9);
        
        String f10 = 'NON RISOLVIBILE: CAUSA CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f10);
        
        String f11 = 'RISOLTO OLO/CLIENTE: CONFIGURAZIONE CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f11);
        
        String f12 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f12);
        
        String f13 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f13);
        
        String f14 = 'RISOLTO OLO/CLIENTE: RESET CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f14);
        
        String f15 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE BRETELLA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f15);
        
        String f16 = 'RIBALTAMENTO EFFETTUATO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f16);
        
        String f17 = 'Non Risolvibile: Problemi Di Rete OLO (Es. Problema di Scheda In Centrale OLO, Problema Di Configurazione OLO)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f17);
        
        String f18 = 'Non Risolvibile: Problemi Di Rete Cliente (Es. Wi-Fi Poco Performante Causa Disposizione Casa Cliente, Configurazione PC)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f18);
        
        String f19 = 'RISOLTO MEDIANTE INTERVENTO CONGIUNTO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f19);
        
        String f20 = 'CHIUSO PER TIMEOUT_OK';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f20);
        
        OF_TTM_Utils.updateSlPortale(eaiLog1,c);
        
        OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom('CODICE_COMUNICAZIONE_OLO');
        
        String sla_assurance = 'Y';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance);
        String sla_assurance1 = 'X';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance1);
        
        String rtDevName = 'OF_GPONPassiva';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName);
        String rtDevName1 = 'OF_OpenStream';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName1);
        String rtDevName2 = 'Test';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName2);
        
        OF_TTM_Utils.copy_TT_TTMRequest(eaiLog1);
        
        OF_TTM_Utils.checkAsset = true;
        OF_TTM_Utils.createTTRequestLogSFTTM(eaiLog1,astList,c,'tipo_comunicazione');
        
        OF_TTM_Utils.copy_TT_OLONotify(eaiLog1,'tipo_comunicazione');
        
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        eaiLog1.EOF_Note__c = 'Test';
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog2.EOF_Codice_Operatore__c = 'TIS';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog2.EOF_PROFILO__c = 'AG_11_36';
        eaiLog2.EOF_PROMOZIONE__c = '020103';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog2.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog2.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog2.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog2.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog2.Causale_Scarto__c = 'Test';
        eaiLog2.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog2.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog2.EOF_Referente_desospensione__c = 'Test';
        eaiLog2.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog2.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog2.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog2.EOF_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog2;

       Test.startTest();
       insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
       Test.setMock(WebServiceMock.class, new OF_TTM_Utils_Mock());
       OF_TTM_Utils.createAckNackNotify_TTeTTM_ServiceLog(nGPON.id);
              
    }
    
     public static testmethod void Method2(){
        
        OF_TTM_Utils util = new OF_TTM_Utils();
                
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        tt.NOTE = 'Test';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        map<string,string> mps = new map<string,string>();
		mps.put('Type','TT_ACK');
        
        map<string,string> mps2 = new map<string,string>();
		mps2.put('Type','TT_NACK');
        
        map<string,string> mps3 = new map<string,string>();
		mps3.put('Type','Trouble Ticket - Richiesta Scartata');
         
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = tt.CODICE_COMUNICAZIONE_OLO;
        insert c;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'In Inserimento';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Codice_Comunicazione_OLO__c='Test';
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        nGPON.EOF_Codice_Comunicazione_OLO__c=nGPON.EOF_Codice_Comunicazione_OLO__c;
        insert nGPON;
        
        OF_TTM_Utils.setNotify(nGPON);
        OF_TTM_Utils.getNotify();

        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - TT - TroubleTicketRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c = 'In Inserimento';
        insert eaiLog;
         
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        List<Asset> astList = new List<Asset>();
        Asset ast = new Asset();
        ast.Name= eaiLog1.EOF_Id_Risorsa__c;
        ast.Status = 'Attivo';
        ast.EOF_ID_Risorsa__c = 'Test';
        ast.AccountId = accOLO.Id;  
        insert ast;
        astList.add(ast);
        
        OF_TTM_Utils.create_EAI_Log(tt);
        eaiLog1.EOF_NOTE__c = '';
        OF_TTM_Utils.create_EAI_Log(tt);
        OF_TTM_Utils.create_EAI_Log(mps);
        OF_TTM_Utils.create_EAI_Log(mps2);
        OF_TTM_Utils.create_EAI_Log(mps3);
        
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE name='DAC'];
        boolean b = BusinessHours.isWithin(bh.id, OF_TTM_Utils.now());
        boolean premium = True;
        OF_TTM_Utils.calcoloSLA(premium);
        
        OF_TTM_Utils.copy_TT_request(tt);
        
        OF_TTM_Utils.dateToString(System.today());
        
        OF_TTM_Utils.stringToDate('2018-07-19T13:00:00+01:00');
        
        OF_TTM_Utils.stringToDateNoTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.stringToDateNoTime('');
        String S = '2018-07-19';
        OF_TTM_Utils.checkDate(s);
        
        String S1 = '';
        OF_TTM_Utils.checkDate(s1);
        
        String S2 = 'Test';
        OF_TTM_Utils.checkDate(s2);
        
        OF_TTM_Utils.checkTime('11:11:11');
        OF_TTM_Utils.checkTime(' ');
        OF_TTM_Utils.checkTime(null);
        OF_TTM_Utils.checkTime('11:11:oo');
        
        OF_TTM_Utils.checkDateTime('');
        OF_TTM_Utils.checkDateTime(null);
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:000');
        
        OF_TTM_Utils.now();
        
        String a = '';
        OF_TTM_Utils.getStringTipoComunicazione(a);
        
        String a1 = '1';
        OF_TTM_Utils.getStringTipoComunicazione(a1);
        
        String a2 = '2';
        OF_TTM_Utils.getStringTipoComunicazione(a2);
        
        String a3 = '3';
        OF_TTM_Utils.getStringTipoComunicazione(a3);
        
        String a4 = '4';
        OF_TTM_Utils.getStringTipoComunicazione(a4);
        
        String a5 = '5';
        OF_TTM_Utils.getStringTipoComunicazione(a5);
        
        String a6 = '6';
        OF_TTM_Utils.getStringTipoComunicazione(a6);
        
        String a7 = '7';
        OF_TTM_Utils.getStringTipoComunicazione(a7);
        
        String a8 = '8';
        OF_TTM_Utils.getStringTipoComunicazione(a8);
        
        String a9 = '9';
        OF_TTM_Utils.getStringTipoComunicazione(a9);
        
        String a10 = '10';
        OF_TTM_Utils.getStringTipoComunicazione(a10);
        
        String a11 = '11';
        OF_TTM_Utils.getStringTipoComunicazione(a11);
        
        String a12 = '12';
        OF_TTM_Utils.getStringTipoComunicazione(a12);
        
        String a13 = '13';
        OF_TTM_Utils.getStringTipoComunicazione(a13);
        
        String a20 = '20';
        OF_TTM_Utils.getStringTipoComunicazione(a20);
        
        String a21 = '21';
        OF_TTM_Utils.getStringTipoComunicazione(a21);
        
        String a99 = '99';
        OF_TTM_Utils.getStringTipoComunicazione(a99);
        
        String b1 = '';
        OF_TTM_Utils.getValueTipoComunicazione(b1);
        
        String b2 = 'Notifica Scarto';
        OF_TTM_Utils.getValueTipoComunicazione(b2);
        
        String b5 = 'Notifica Richiesta Chiusura';
        OF_TTM_Utils.getValueTipoComunicazione(b5);
        
        String b3 = 'Notifica Presa in Carico';
        OF_TTM_Utils.getValueTipoComunicazione(b3);
        
        String b4 = 'Notifica Sospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b4);
        
        String b7 = 'Notifica Desospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b7);
        
        String b10 = 'Notifica Annullamento';
        OF_TTM_Utils.getValueTipoComunicazione(b10);
        
        String b13 = 'Notifica Timeout OK';
        OF_TTM_Utils.getValueTipoComunicazione(b13);
        
        String b21 = 'Notifica Aggiornamento Dati';
        OF_TTM_Utils.getValueTipoComunicazione(b21);
        
        OF_TTM_Utils.getStringCategoriaGuasto(s1);
        String a0 = '0';
        OF_TTM_Utils.getStringCategoriaGuasto(a0);
        OF_TTM_Utils.getStringCategoriaGuasto(a1);
        OF_TTM_Utils.getStringCategoriaGuasto(a2);
        
        OF_TTM_Utils.getStringCausaleDesospensione(s1);
        OF_TTM_Utils.getStringCausaleDesospensione(a2);
        OF_TTM_Utils.getStringCausaleDesospensione(a3);
        
        OF_TTM_Utils.getStringCausaleApertura(s1);
        OF_TTM_Utils.getStringCausaleApertura(a1);
        OF_TTM_Utils.getStringCausaleApertura(a2);
        OF_TTM_Utils.getStringCausaleApertura(a3);
        OF_TTM_Utils.getStringCausaleApertura(a4);
        
        OF_TTM_Utils.getValueStatoTicket(s1);
        
        String c1 = 'Scartato';
        OF_TTM_Utils.getValueStatoTicket(c1);
        
        String c2 = 'In Lavorazione';
        OF_TTM_Utils.getValueStatoTicket(c2);
        
        String c3 = 'Sospeso';
        OF_TTM_Utils.getValueStatoTicket(c3);
        
        String c4 = 'Chiuso';
        OF_TTM_Utils.getValueStatoTicket(c4);
        
        String c5 = 'Annullato';
        OF_TTM_Utils.getValueStatoTicket(c5);
        
        String c6 = 'Richiesta Chiusura';
        OF_TTM_Utils.getValueStatoTicket(c6);
        
        OF_TTM_Utils.getValueCausaleScarto(s1);
        
        String d1 = 'Formato dati errato o incompleto';
        OF_TTM_Utils.getValueCausaleScarto(d1);
        
        String d2 = 'Ticket aperto per stesso ID risorsa';
        OF_TTM_Utils.getValueCausaleScarto(d2);
        
        String d3 = 'ID Risorsa Inesistente';
        OF_TTM_Utils.getValueCausaleScarto(d3);
        
        String d4 = 'Codice Comunicazione OLO già presente';
        OF_TTM_Utils.getValueCausaleScarto(d4);
        
        String d5 = 'Guasto Aperto come Post-Provisioning oltre i termini previsti';
        OF_TTM_Utils.getValueCausaleScarto(d5);
        
        OF_TTM_Utils.getCausaleSospensione(s1);
        OF_TTM_Utils.getCausaleSospensione(a1);
        OF_TTM_Utils.getCausaleSospensione(a2);
        OF_TTM_Utils.getCausaleSospensione(a3);
        
        OF_TTM_Utils.getValueCausaleSospensione(s1);
        
        String e1 = 'SEDE OLO/CLIENTE FINALE INACCESSIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e1);
        
        String e2 = 'CLIENTE IRREPERIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e2);
        
        String e3 = 'CLIENTE INDISPONIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e3);
        
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(s1);
        
        String f1 = 'RISOLTO: TRATTA VERTICALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f1);
        
        String f2 = 'RISOLTO TRATTA ORIZZONTALE: CENTRALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f2);
        
        String f3 = 'RISOLTO TRATTA ORIZZONTALE: RETE PRIMARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f3);
        
        String f4 = 'RISOLTO TRATTA ORIZZONTALE: RETE SECONDARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f4);
        
        String f5 = 'NON RISCONTRATO: SENZA USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f5);
        
        String f6 = 'NON RISCONTRATO: CON USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f6);
        
        String f7 = 'RISOLTO: SBRACCIO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f7);
        
        String f8 = 'RISOLTO: BORCHIA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f8);
        
        String f9 = 'NON RISOLVIBILE: CAUSA IMPIANTO CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f9);
        
        String f10 = 'NON RISOLVIBILE: CAUSA CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f10);
        
        String f11 = 'RISOLTO OLO/CLIENTE: CONFIGURAZIONE CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f11);
        
        String f12 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f12);
        
        String f13 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f13);
        
        String f14 = 'RISOLTO OLO/CLIENTE: RESET CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f14);
        
        String f15 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE BRETELLA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f15);
        
        String f16 = 'RIBALTAMENTO EFFETTUATO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f16);
        
        String f17 = 'Non Risolvibile: Problemi Di Rete OLO (Es. Problema di Scheda In Centrale OLO, Problema Di Configurazione OLO)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f17);
        
        String f18 = 'Non Risolvibile: Problemi Di Rete Cliente (Es. Wi-Fi Poco Performante Causa Disposizione Casa Cliente, Configurazione PC)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f18);
        
        String f19 = 'RISOLTO MEDIANTE INTERVENTO CONGIUNTO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f19);
        
        String f20 = 'CHIUSO PER TIMEOUT_OK';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f20);
        
        OF_TTM_Utils.updateSlPortale(eaiLog1,c);
        
        OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom('CODICE_COMUNICAZIONE_OLO');
        
        String sla_assurance = 'Y';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance);
        String sla_assurance1 = 'X';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance1);
        
        String rtDevName = 'OF_GPONPassiva';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName);
        String rtDevName1 = 'OF_OpenStream';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName1);
        String rtDevName2 = 'Test';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName2);
        
        OF_TTM_Utils.copy_TT_TTMRequest(eaiLog1);
        
        OF_TTM_Utils.checkAsset = true;
        OF_TTM_Utils.createTTRequestLogSFTTM(eaiLog1,astList,c,'tipo_comunicazione');
        
        OF_TTM_Utils.copy_TT_OLONotify(eaiLog1,'tipo_comunicazione');
        
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        eaiLog1.EOF_Note__c = 'Test';
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog2.EOF_Codice_Operatore__c = 'TIS';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog2.EOF_PROFILO__c = 'AG_11_36';
        eaiLog2.EOF_PROMOZIONE__c = '020103';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog2.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog2.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog2.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog2.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog2.Causale_Scarto__c = 'Test';
        eaiLog2.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog2.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog2.EOF_Referente_desospensione__c = 'Test';
        eaiLog2.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog2.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog2.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog2.EOF_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog2;
       
       Test.startTest();
       insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
       Test.setMock(WebServiceMock.class, new OF_TTM_Utils_Mock1());
       OF_TTM_Utils.createAckNackNotify_TTeTTM_ServiceLog(nGPON.id);
       Test.stopTest();
    }
    
   public static testmethod void Method3() {
        
        OF_TTM_Utils util = new OF_TTM_Utils();
                
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        tt.NOTE = 'Test';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        map<string,string> mps = new map<string,string>();
		mps.put('Type','TT_ACK');
        
        map<string,string> mps2 = new map<string,string>();
		mps2.put('Type','TT_NACK');
        
        map<string,string> mps3 = new map<string,string>();
		mps3.put('Type','Trouble Ticket - Richiesta Scartata');
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = tt.CODICE_COMUNICAZIONE_OLO;
        insert c;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'In Inserimento';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Codice_Comunicazione_OLO__c='Test';
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        nGPON.EOF_Codice_Comunicazione_OLO__c=nGPON.EOF_Codice_Comunicazione_OLO__c;
        insert nGPON;
        
        OF_TTM_Utils.setNotify(nGPON);
        OF_TTM_Utils.getNotify();

        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - TT - TroubleTicketRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c = 'In Inserimento';
        insert eaiLog;
       
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        List<Asset> astList = new List<Asset>();
        Asset ast = new Asset();
        ast.Name= eaiLog1.EOF_Id_Risorsa__c;
        ast.Status = 'Attivo';
        ast.EOF_ID_Risorsa__c = 'Test';
        ast.AccountId = accOLO.Id;  
        insert ast;
        astList.add(ast);
        
        OF_TTM_Utils.create_EAI_Log(tt);
        eaiLog1.EOF_NOTE__c = '';
        OF_TTM_Utils.create_EAI_Log(tt);
        OF_TTM_Utils.create_EAI_Log(mps);
        OF_TTM_Utils.create_EAI_Log(mps2);
        OF_TTM_Utils.create_EAI_Log(mps3);
        
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE name='DAC'];
        boolean b = BusinessHours.isWithin(bh.id, OF_TTM_Utils.now());
        boolean premium = True;
        OF_TTM_Utils.calcoloSLA(premium);
        
        OF_TTM_Utils.copy_TT_request(tt);
        
        OF_TTM_Utils.dateToString(System.today());
        
        OF_TTM_Utils.stringToDate('2018-07-19T13:00:00+01:00');
        
        OF_TTM_Utils.stringToDateNoTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.stringToDateNoTime('');
        String S = '2018-07-19';
        OF_TTM_Utils.checkDate(s);
        
        String S1 = '';
        OF_TTM_Utils.checkDate(s1);
        
        String S2 = 'Test';
        OF_TTM_Utils.checkDate(s2);
        
        OF_TTM_Utils.checkTime('11:11:11');
        OF_TTM_Utils.checkTime(' ');
        OF_TTM_Utils.checkTime(null);
        OF_TTM_Utils.checkTime('11:11:oo');
        
        OF_TTM_Utils.checkDateTime('');
        OF_TTM_Utils.checkDateTime(null);
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:000');
        
        OF_TTM_Utils.now();
        
        String a = '';
        OF_TTM_Utils.getStringTipoComunicazione(a);
        
        String a1 = '1';
        OF_TTM_Utils.getStringTipoComunicazione(a1);
        
        String a2 = '2';
        OF_TTM_Utils.getStringTipoComunicazione(a2);
        
        String a3 = '3';
        OF_TTM_Utils.getStringTipoComunicazione(a3);
        
        String a4 = '4';
        OF_TTM_Utils.getStringTipoComunicazione(a4);
        
        String a5 = '5';
        OF_TTM_Utils.getStringTipoComunicazione(a5);
        
        String a6 = '6';
        OF_TTM_Utils.getStringTipoComunicazione(a6);
        
        String a7 = '7';
        OF_TTM_Utils.getStringTipoComunicazione(a7);
        
        String a8 = '8';
        OF_TTM_Utils.getStringTipoComunicazione(a8);
        
        String a9 = '9';
        OF_TTM_Utils.getStringTipoComunicazione(a9);
        
        String a10 = '10';
        OF_TTM_Utils.getStringTipoComunicazione(a10);
        
        String a11 = '11';
        OF_TTM_Utils.getStringTipoComunicazione(a11);
        
        String a12 = '12';
        OF_TTM_Utils.getStringTipoComunicazione(a12);
        
        String a13 = '13';
        OF_TTM_Utils.getStringTipoComunicazione(a13);
        
        String a20 = '20';
        OF_TTM_Utils.getStringTipoComunicazione(a20);
        
        String a21 = '21';
        OF_TTM_Utils.getStringTipoComunicazione(a21);
        
        String a99 = '99';
        OF_TTM_Utils.getStringTipoComunicazione(a99);
        
        String b1 = '';
        OF_TTM_Utils.getValueTipoComunicazione(b1);
        
        String b2 = 'Notifica Scarto';
        OF_TTM_Utils.getValueTipoComunicazione(b2);
        
        String b5 = 'Notifica Richiesta Chiusura';
        OF_TTM_Utils.getValueTipoComunicazione(b5);
        
        String b3 = 'Notifica Presa in Carico';
        OF_TTM_Utils.getValueTipoComunicazione(b3);
        
        String b4 = 'Notifica Sospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b4);
        
        String b7 = 'Notifica Desospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b7);
        
        String b10 = 'Notifica Annullamento';
        OF_TTM_Utils.getValueTipoComunicazione(b10);
        
        String b13 = 'Notifica Timeout OK';
        OF_TTM_Utils.getValueTipoComunicazione(b13);
        
        String b21 = 'Notifica Aggiornamento Dati';
        OF_TTM_Utils.getValueTipoComunicazione(b21);
        
        OF_TTM_Utils.getStringCategoriaGuasto(s1);
        String a0 = '0';
        OF_TTM_Utils.getStringCategoriaGuasto(a0);
        OF_TTM_Utils.getStringCategoriaGuasto(a1);
        OF_TTM_Utils.getStringCategoriaGuasto(a2);
        
        OF_TTM_Utils.getStringCausaleDesospensione(s1);
        OF_TTM_Utils.getStringCausaleDesospensione(a2);
        OF_TTM_Utils.getStringCausaleDesospensione(a3);
        
        OF_TTM_Utils.getStringCausaleApertura(s1);
        OF_TTM_Utils.getStringCausaleApertura(a1);
        OF_TTM_Utils.getStringCausaleApertura(a2);
        OF_TTM_Utils.getStringCausaleApertura(a3);
        OF_TTM_Utils.getStringCausaleApertura(a4);
        
        OF_TTM_Utils.getValueStatoTicket(s1);
        
        String c1 = 'Scartato';
        OF_TTM_Utils.getValueStatoTicket(c1);
        
        String c2 = 'In Lavorazione';
        OF_TTM_Utils.getValueStatoTicket(c2);
        
        String c3 = 'Sospeso';
        OF_TTM_Utils.getValueStatoTicket(c3);
        
        String c4 = 'Chiuso';
        OF_TTM_Utils.getValueStatoTicket(c4);
        
        String c5 = 'Annullato';
        OF_TTM_Utils.getValueStatoTicket(c5);
        
        String c6 = 'Richiesta Chiusura';
        OF_TTM_Utils.getValueStatoTicket(c6);
        
        OF_TTM_Utils.getValueCausaleScarto(s1);
        
        String d1 = 'Formato dati errato o incompleto';
        OF_TTM_Utils.getValueCausaleScarto(d1);
        
        String d2 = 'Ticket aperto per stesso ID risorsa';
        OF_TTM_Utils.getValueCausaleScarto(d2);
        
        String d3 = 'ID Risorsa Inesistente';
        OF_TTM_Utils.getValueCausaleScarto(d3);
        
        String d4 = 'Codice Comunicazione OLO già presente';
        OF_TTM_Utils.getValueCausaleScarto(d4);
        
        String d5 = 'Guasto Aperto come Post-Provisioning oltre i termini previsti';
        OF_TTM_Utils.getValueCausaleScarto(d5);
        
        OF_TTM_Utils.getCausaleSospensione(s1);
        OF_TTM_Utils.getCausaleSospensione(a1);
        OF_TTM_Utils.getCausaleSospensione(a2);
        OF_TTM_Utils.getCausaleSospensione(a3);
        
        OF_TTM_Utils.getValueCausaleSospensione(s1);
        
        String e1 = 'SEDE OLO/CLIENTE FINALE INACCESSIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e1);
        
        String e2 = 'CLIENTE IRREPERIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e2);
        
        String e3 = 'CLIENTE INDISPONIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e3);
        
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(s1);
        
        String f1 = 'RISOLTO: TRATTA VERTICALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f1);
        
        String f2 = 'RISOLTO TRATTA ORIZZONTALE: CENTRALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f2);
        
        String f3 = 'RISOLTO TRATTA ORIZZONTALE: RETE PRIMARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f3);
        
        String f4 = 'RISOLTO TRATTA ORIZZONTALE: RETE SECONDARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f4);
        
        String f5 = 'NON RISCONTRATO: SENZA USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f5);
        
        String f6 = 'NON RISCONTRATO: CON USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f6);
        
        String f7 = 'RISOLTO: SBRACCIO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f7);
        
        String f8 = 'RISOLTO: BORCHIA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f8);
        
        String f9 = 'NON RISOLVIBILE: CAUSA IMPIANTO CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f9);
        
        String f10 = 'NON RISOLVIBILE: CAUSA CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f10);
        
        String f11 = 'RISOLTO OLO/CLIENTE: CONFIGURAZIONE CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f11);
        
        String f12 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f12);
        
        String f13 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f13);
        
        String f14 = 'RISOLTO OLO/CLIENTE: RESET CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f14);
        
        String f15 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE BRETELLA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f15);
        
        String f16 = 'RIBALTAMENTO EFFETTUATO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f16);
        
        String f17 = 'Non Risolvibile: Problemi Di Rete OLO (Es. Problema di Scheda In Centrale OLO, Problema Di Configurazione OLO)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f17);
        
        String f18 = 'Non Risolvibile: Problemi Di Rete Cliente (Es. Wi-Fi Poco Performante Causa Disposizione Casa Cliente, Configurazione PC)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f18);
        
        String f19 = 'RISOLTO MEDIANTE INTERVENTO CONGIUNTO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f19);
        
        String f20 = 'CHIUSO PER TIMEOUT_OK';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f20);
        
        OF_TTM_Utils.updateSlPortale(eaiLog1,c);
        
        OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom('CODICE_COMUNICAZIONE_OLO');
        
        String sla_assurance = 'Y';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance);
        String sla_assurance1 = 'X';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance1);
        
        String rtDevName = 'OF_GPONPassiva';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName);
        String rtDevName1 = 'OF_OpenStream';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName1);
        String rtDevName2 = 'Test';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName2);
        
        OF_TTM_Utils.copy_TT_TTMRequest(eaiLog1);
        
        OF_TTM_Utils.checkAsset = true;
        OF_TTM_Utils.createTTRequestLogSFTTM(eaiLog1,astList,c,'tipo_comunicazione');
        
        OF_TTM_Utils.copy_TT_OLONotify(eaiLog1,'tipo_comunicazione');
        
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        eaiLog1.EOF_Note__c = 'Test';
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '123456';
        
        eaiLog2.EOF_Codice_Operatore__c = 'TIS';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog2.EOF_PROFILO__c = 'AG_11_36';
        eaiLog2.EOF_PROMOZIONE__c = '020103';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog2.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog2.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog2.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog2.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog2.Causale_Scarto__c = 'Test';
        eaiLog2.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog2.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog2.EOF_Referente_desospensione__c = 'Test';
        eaiLog2.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog2.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog2.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog2.EOF_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog2.EOF_Codice_Comunicazione_OLO__c = 'Test';
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog2;
       
        c.id = eaiLog2.Caso__c;
        String responseDaTTM = 'NACK TECNICO';
        c.OF_Response_da_TTM__c = responseDaTTM;
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
       
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;
       
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;
       
        Test.startTest();
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        OF_TTM_Utils.createAsyncTTRequestCalloutToTTM( eaiLog2.Id,'tipo_comunicazione');
        Test.setMock(WebServiceMock.class, new OF_TTM_Utils_Mock2());
        Test.stopTest();
        
    }  
    
     public static testmethod void Method4() {
        
        OF_TTM_Utils util = new OF_TTM_Utils();
                
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        tt.NOTE = 'Test';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        map<string,string> mps = new map<string,string>();
		mps.put('Type','TT_ACK');
        
        map<string,string> mps2 = new map<string,string>();
		mps2.put('Type','TT_NACK');
        
        map<string,string> mps3 = new map<string,string>();
		mps3.put('Type','Trouble Ticket - Richiesta Scartata');
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = tt.CODICE_COMUNICAZIONE_OLO;
        insert c;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'In Inserimento';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Codice_Comunicazione_OLO__c='Test';
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        nGPON.EOF_Codice_Comunicazione_OLO__c=nGPON.EOF_Codice_Comunicazione_OLO__c;
        insert nGPON;
        
        OF_TTM_Utils.setNotify(nGPON);
        OF_TTM_Utils.getNotify();

        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - TT - TroubleTicketRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c = 'In Inserimento';
        insert eaiLog;
         
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        List<Asset> astList = new List<Asset>();
        Asset ast = new Asset();
        ast.Name= eaiLog1.EOF_Id_Risorsa__c;
        ast.Status = 'Attivo';
        ast.EOF_ID_Risorsa__c = 'Test';
        ast.AccountId = accOLO.Id;  
        insert ast;
        astList.add(ast);
        
        OF_TTM_Utils.create_EAI_Log(tt);
        eaiLog1.EOF_NOTE__c = '';
        OF_TTM_Utils.create_EAI_Log(tt);
        OF_TTM_Utils.create_EAI_Log(mps);
        OF_TTM_Utils.create_EAI_Log(mps2);
        OF_TTM_Utils.create_EAI_Log(mps3);
        
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE name='DAC'];
        boolean b = BusinessHours.isWithin(bh.id, OF_TTM_Utils.now());
        boolean premium = True;
        OF_TTM_Utils.calcoloSLA(premium);
        
        OF_TTM_Utils.copy_TT_request(tt);
        
        OF_TTM_Utils.dateToString(System.today());
        
        OF_TTM_Utils.stringToDate('2018-07-19T13:00:00+01:00');
        
        OF_TTM_Utils.stringToDateNoTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.stringToDateNoTime('');
        String S = '2018-07-19';
        OF_TTM_Utils.checkDate(s);
        
        String S1 = '';
        OF_TTM_Utils.checkDate(s1);
        
        String S2 = 'Test';
        OF_TTM_Utils.checkDate(s2);
        
        OF_TTM_Utils.checkTime('11:11:11');
        OF_TTM_Utils.checkTime(' ');
        OF_TTM_Utils.checkTime(null);
        OF_TTM_Utils.checkTime('11:11:oo');
        
        OF_TTM_Utils.checkDateTime('');
        OF_TTM_Utils.checkDateTime(null);
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:000');
        
        OF_TTM_Utils.now();
        
        String a = '';
        OF_TTM_Utils.getStringTipoComunicazione(a);
        
        String a1 = '1';
        OF_TTM_Utils.getStringTipoComunicazione(a1);
        
        String a2 = '2';
        OF_TTM_Utils.getStringTipoComunicazione(a2);
        
        String a3 = '3';
        OF_TTM_Utils.getStringTipoComunicazione(a3);
        
        String a4 = '4';
        OF_TTM_Utils.getStringTipoComunicazione(a4);
        
        String a5 = '5';
        OF_TTM_Utils.getStringTipoComunicazione(a5);
        
        String a6 = '6';
        OF_TTM_Utils.getStringTipoComunicazione(a6);
        
        String a7 = '7';
        OF_TTM_Utils.getStringTipoComunicazione(a7);
        
        String a8 = '8';
        OF_TTM_Utils.getStringTipoComunicazione(a8);
        
        String a9 = '9';
        OF_TTM_Utils.getStringTipoComunicazione(a9);
        
        String a10 = '10';
        OF_TTM_Utils.getStringTipoComunicazione(a10);
        
        String a11 = '11';
        OF_TTM_Utils.getStringTipoComunicazione(a11);
        
        String a12 = '12';
        OF_TTM_Utils.getStringTipoComunicazione(a12);
        
        String a13 = '13';
        OF_TTM_Utils.getStringTipoComunicazione(a13);
        
        String a20 = '20';
        OF_TTM_Utils.getStringTipoComunicazione(a20);
        
        String a21 = '21';
        OF_TTM_Utils.getStringTipoComunicazione(a21);
        
        String a99 = '99';
        OF_TTM_Utils.getStringTipoComunicazione(a99);
        
        String b1 = '';
        OF_TTM_Utils.getValueTipoComunicazione(b1);
        
        String b2 = 'Notifica Scarto';
        OF_TTM_Utils.getValueTipoComunicazione(b2);
        
        String b5 = 'Notifica Richiesta Chiusura';
        OF_TTM_Utils.getValueTipoComunicazione(b5);
        
        String b3 = 'Notifica Presa in Carico';
        OF_TTM_Utils.getValueTipoComunicazione(b3);
        
        String b4 = 'Notifica Sospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b4);
        
        String b7 = 'Notifica Desospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b7);
        
        String b10 = 'Notifica Annullamento';
        OF_TTM_Utils.getValueTipoComunicazione(b10);
        
        String b13 = 'Notifica Timeout OK';
        OF_TTM_Utils.getValueTipoComunicazione(b13);
        
        String b21 = 'Notifica Aggiornamento Dati';
        OF_TTM_Utils.getValueTipoComunicazione(b21);
        
        OF_TTM_Utils.getStringCategoriaGuasto(s1);
        String a0 = '0';
        OF_TTM_Utils.getStringCategoriaGuasto(a0);
        OF_TTM_Utils.getStringCategoriaGuasto(a1);
        OF_TTM_Utils.getStringCategoriaGuasto(a2);
        
        OF_TTM_Utils.getStringCausaleDesospensione(s1);
        OF_TTM_Utils.getStringCausaleDesospensione(a2);
        OF_TTM_Utils.getStringCausaleDesospensione(a3);
        
        OF_TTM_Utils.getStringCausaleApertura(s1);
        OF_TTM_Utils.getStringCausaleApertura(a1);
        OF_TTM_Utils.getStringCausaleApertura(a2);
        OF_TTM_Utils.getStringCausaleApertura(a3);
        OF_TTM_Utils.getStringCausaleApertura(a4);
        
        OF_TTM_Utils.getValueStatoTicket(s1);
        
        String c1 = 'Scartato';
        OF_TTM_Utils.getValueStatoTicket(c1);
        
        String c2 = 'In Lavorazione';
        OF_TTM_Utils.getValueStatoTicket(c2);
        
        String c3 = 'Sospeso';
        OF_TTM_Utils.getValueStatoTicket(c3);
        
        String c4 = 'Chiuso';
        OF_TTM_Utils.getValueStatoTicket(c4);
        
        String c5 = 'Annullato';
        OF_TTM_Utils.getValueStatoTicket(c5);
        
        String c6 = 'Richiesta Chiusura';
        OF_TTM_Utils.getValueStatoTicket(c6);
        
        OF_TTM_Utils.getValueCausaleScarto(s1);
        
        String d1 = 'Formato dati errato o incompleto';
        OF_TTM_Utils.getValueCausaleScarto(d1);
        
        String d2 = 'Ticket aperto per stesso ID risorsa';
        OF_TTM_Utils.getValueCausaleScarto(d2);
        
        String d3 = 'ID Risorsa Inesistente';
        OF_TTM_Utils.getValueCausaleScarto(d3);
        
        String d4 = 'Codice Comunicazione OLO già presente';
        OF_TTM_Utils.getValueCausaleScarto(d4);
        
        String d5 = 'Guasto Aperto come Post-Provisioning oltre i termini previsti';
        OF_TTM_Utils.getValueCausaleScarto(d5);
        
        OF_TTM_Utils.getCausaleSospensione(s1);
        OF_TTM_Utils.getCausaleSospensione(a1);
        OF_TTM_Utils.getCausaleSospensione(a2);
        OF_TTM_Utils.getCausaleSospensione(a3);
        
        OF_TTM_Utils.getValueCausaleSospensione(s1);
        
        String e1 = 'SEDE OLO/CLIENTE FINALE INACCESSIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e1);
        
        String e2 = 'CLIENTE IRREPERIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e2);
        
        String e3 = 'CLIENTE INDISPONIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e3);
        
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(s1);
        
        String f1 = 'RISOLTO: TRATTA VERTICALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f1);
        
        String f2 = 'RISOLTO TRATTA ORIZZONTALE: CENTRALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f2);
        
        String f3 = 'RISOLTO TRATTA ORIZZONTALE: RETE PRIMARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f3);
        
        String f4 = 'RISOLTO TRATTA ORIZZONTALE: RETE SECONDARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f4);
        
        String f5 = 'NON RISCONTRATO: SENZA USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f5);
        
        String f6 = 'NON RISCONTRATO: CON USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f6);
        
        String f7 = 'RISOLTO: SBRACCIO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f7);
        
        String f8 = 'RISOLTO: BORCHIA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f8);
        
        String f9 = 'NON RISOLVIBILE: CAUSA IMPIANTO CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f9);
        
        String f10 = 'NON RISOLVIBILE: CAUSA CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f10);
        
        String f11 = 'RISOLTO OLO/CLIENTE: CONFIGURAZIONE CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f11);
        
        String f12 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f12);
        
        String f13 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f13);
        
        String f14 = 'RISOLTO OLO/CLIENTE: RESET CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f14);
        
        String f15 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE BRETELLA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f15);
        
        String f16 = 'RIBALTAMENTO EFFETTUATO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f16);
        
        String f17 = 'Non Risolvibile: Problemi Di Rete OLO (Es. Problema di Scheda In Centrale OLO, Problema Di Configurazione OLO)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f17);
        
        String f18 = 'Non Risolvibile: Problemi Di Rete Cliente (Es. Wi-Fi Poco Performante Causa Disposizione Casa Cliente, Configurazione PC)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f18);
        
        String f19 = 'RISOLTO MEDIANTE INTERVENTO CONGIUNTO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f19);
        
        String f20 = 'CHIUSO PER TIMEOUT_OK';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f20);
        
        OF_TTM_Utils.updateSlPortale(eaiLog1,c);
        
        OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom('CODICE_COMUNICAZIONE_OLO');
        
        String sla_assurance = 'Y';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance);
        String sla_assurance1 = 'X';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance1);
        
        String rtDevName = 'OF_GPONPassiva';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName);
        String rtDevName1 = 'OF_OpenStream';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName1);
        String rtDevName2 = 'Test';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName2);
        
        OF_TTM_Utils.copy_TT_TTMRequest(eaiLog1);
        
        OF_TTM_Utils.checkAsset = true;
        OF_TTM_Utils.createTTRequestLogSFTTM(eaiLog1,astList,c,'tipo_comunicazione');
        
        OF_TTM_Utils.copy_TT_OLONotify(eaiLog1,'tipo_comunicazione');
        
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        eaiLog1.EOF_Note__c = 'Test';
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog2.EOF_Codice_Operatore__c = 'TIS';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog2.EOF_PROFILO__c = 'AG_11_36';
        eaiLog2.EOF_PROMOZIONE__c = '020103';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog2.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog2.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog2.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog2.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog2.Causale_Scarto__c = 'Test';
        eaiLog2.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog2.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog2.EOF_Referente_desospensione__c = 'Test';
        eaiLog2.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog2.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog2.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog2.EOF_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog2.EOF_Codice_Comunicazione_OLO__c = 'Test';
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog2;
       
        c.id = eaiLog2.Caso__c;
        String responseDaTTM = 'NACK TECNICO';
        c.OF_Response_da_TTM__c = responseDaTTM;
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
       
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;
       
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;
       
        Test.startTest();
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        OF_TTM_Utils.createAsyncTTRequestCalloutToTTM( eaiLog2.Id,'tipo_comunicazione');
        Test.setMock(WebServiceMock.class, new OF_TTM_Utils_Mock3());
        Test.stopTest();
        
    } 
    
    public static testmethod void Method5(){
        
        OF_TTM_Utils util = new OF_TTM_Utils();
                
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        tt.NOTE = 'Test';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        map<string,string> mps = new map<string,string>();
		mps.put('Type','TT_ACK');
        
        map<string,string> mps2 = new map<string,string>();
		mps2.put('Type','TT_NACK');
        
        map<string,string> mps3 = new map<string,string>();
		mps3.put('Type','Trouble Ticket - Richiesta Scartata');
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = tt.CODICE_COMUNICAZIONE_OLO;
        insert c;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'In Inserimento';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Codice_Comunicazione_OLO__c='Test';
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        nGPON.EOF_Codice_Comunicazione_OLO__c=nGPON.EOF_Codice_Comunicazione_OLO__c;
        insert nGPON;
        
        OF_TTM_Utils.setNotify(nGPON);
        OF_TTM_Utils.getNotify();

        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - TT - TroubleTicketRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c = 'In Inserimento';
        insert eaiLog;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        List<Asset> astList = new List<Asset>();
        Asset ast = new Asset();
        ast.Name= eaiLog1.EOF_Id_Risorsa__c;
        ast.Status = 'Attivo';
        ast.EOF_ID_Risorsa__c = 'Test';
        ast.AccountId = accOLO.Id;  
        insert ast;
        astList.add(ast);
        
        OF_TTM_Utils.create_EAI_Log(tt);
        eaiLog1.EOF_NOTE__c = '';
        OF_TTM_Utils.create_EAI_Log(tt);
        OF_TTM_Utils.create_EAI_Log(mps);
        OF_TTM_Utils.create_EAI_Log(mps2);
        OF_TTM_Utils.create_EAI_Log(mps3);
        
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE name='DAC'];
        boolean b = BusinessHours.isWithin(bh.id, OF_TTM_Utils.now());
        boolean premium = True;
        OF_TTM_Utils.calcoloSLA(premium);
        
        OF_TTM_Utils.copy_TT_request(tt);
        
        OF_TTM_Utils.dateToString(System.today());
        
        OF_TTM_Utils.stringToDate('2018-07-19T13:00:00+01:00');
        
        OF_TTM_Utils.stringToDateNoTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.stringToDateNoTime('');
        String S = '2018-07-19';
        OF_TTM_Utils.checkDate(s);
        
        String S1 = '';
        OF_TTM_Utils.checkDate(s1);
        
        String S2 = 'Test';
        OF_TTM_Utils.checkDate(s2);
        
        OF_TTM_Utils.checkTime('11:11:11');
        OF_TTM_Utils.checkTime(' ');
        OF_TTM_Utils.checkTime(null);
        OF_TTM_Utils.checkTime('11:11:oo');
        
        OF_TTM_Utils.checkDateTime('');
        OF_TTM_Utils.checkDateTime(null);
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:000');
        
        OF_TTM_Utils.now();
        
        String a = '';
        OF_TTM_Utils.getStringTipoComunicazione(a);
        
        String a1 = '1';
        OF_TTM_Utils.getStringTipoComunicazione(a1);
        
        String a2 = '2';
        OF_TTM_Utils.getStringTipoComunicazione(a2);
        
        String a3 = '3';
        OF_TTM_Utils.getStringTipoComunicazione(a3);
        
        String a4 = '4';
        OF_TTM_Utils.getStringTipoComunicazione(a4);
        
        String a5 = '5';
        OF_TTM_Utils.getStringTipoComunicazione(a5);
        
        String a6 = '6';
        OF_TTM_Utils.getStringTipoComunicazione(a6);
        
        String a7 = '7';
        OF_TTM_Utils.getStringTipoComunicazione(a7);
        
        String a8 = '8';
        OF_TTM_Utils.getStringTipoComunicazione(a8);
        
        String a9 = '9';
        OF_TTM_Utils.getStringTipoComunicazione(a9);
        
        String a10 = '10';
        OF_TTM_Utils.getStringTipoComunicazione(a10);
        
        String a11 = '11';
        OF_TTM_Utils.getStringTipoComunicazione(a11);
        
        String a12 = '12';
        OF_TTM_Utils.getStringTipoComunicazione(a12);
        
        String a13 = '13';
        OF_TTM_Utils.getStringTipoComunicazione(a13);
        
        String a20 = '20';
        OF_TTM_Utils.getStringTipoComunicazione(a20);
        
        String a21 = '21';
        OF_TTM_Utils.getStringTipoComunicazione(a21);
        
        String a99 = '99';
        OF_TTM_Utils.getStringTipoComunicazione(a99);
        
        String b1 = '';
        OF_TTM_Utils.getValueTipoComunicazione(b1);
        
        String b2 = 'Notifica Scarto';
        OF_TTM_Utils.getValueTipoComunicazione(b2);
        
        String b5 = 'Notifica Richiesta Chiusura';
        OF_TTM_Utils.getValueTipoComunicazione(b5);
        
        String b3 = 'Notifica Presa in Carico';
        OF_TTM_Utils.getValueTipoComunicazione(b3);
        
        String b4 = 'Notifica Sospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b4);
        
        String b7 = 'Notifica Desospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b7);
        
        String b10 = 'Notifica Annullamento';
        OF_TTM_Utils.getValueTipoComunicazione(b10);
        
        String b13 = 'Notifica Timeout OK';
        OF_TTM_Utils.getValueTipoComunicazione(b13);
        
        String b21 = 'Notifica Aggiornamento Dati';
        OF_TTM_Utils.getValueTipoComunicazione(b21);
        
        OF_TTM_Utils.getStringCategoriaGuasto(s1);
        String a0 = '0';
        OF_TTM_Utils.getStringCategoriaGuasto(a0);
        OF_TTM_Utils.getStringCategoriaGuasto(a1);
        OF_TTM_Utils.getStringCategoriaGuasto(a2);
        
        OF_TTM_Utils.getStringCausaleDesospensione(s1);
        OF_TTM_Utils.getStringCausaleDesospensione(a2);
        OF_TTM_Utils.getStringCausaleDesospensione(a3);
        
        OF_TTM_Utils.getStringCausaleApertura(s1);
        OF_TTM_Utils.getStringCausaleApertura(a1);
        OF_TTM_Utils.getStringCausaleApertura(a2);
        OF_TTM_Utils.getStringCausaleApertura(a3);
        OF_TTM_Utils.getStringCausaleApertura(a4);
        
        OF_TTM_Utils.getValueStatoTicket(s1);
        
        String c1 = 'Scartato';
        OF_TTM_Utils.getValueStatoTicket(c1);
        
        String c2 = 'In Lavorazione';
        OF_TTM_Utils.getValueStatoTicket(c2);
        
        String c3 = 'Sospeso';
        OF_TTM_Utils.getValueStatoTicket(c3);
        
        String c4 = 'Chiuso';
        OF_TTM_Utils.getValueStatoTicket(c4);
        
        String c5 = 'Annullato';
        OF_TTM_Utils.getValueStatoTicket(c5);
        
        String c6 = 'Richiesta Chiusura';
        OF_TTM_Utils.getValueStatoTicket(c6);
        
        OF_TTM_Utils.getValueCausaleScarto(s1);
        
        String d1 = 'Formato dati errato o incompleto';
        OF_TTM_Utils.getValueCausaleScarto(d1);
        
        String d2 = 'Ticket aperto per stesso ID risorsa';
        OF_TTM_Utils.getValueCausaleScarto(d2);
        
        String d3 = 'ID Risorsa Inesistente';
        OF_TTM_Utils.getValueCausaleScarto(d3);
        
        String d4 = 'Codice Comunicazione OLO già presente';
        OF_TTM_Utils.getValueCausaleScarto(d4);
        
        String d5 = 'Guasto Aperto come Post-Provisioning oltre i termini previsti';
        OF_TTM_Utils.getValueCausaleScarto(d5);
        
        OF_TTM_Utils.getCausaleSospensione(s1);
        OF_TTM_Utils.getCausaleSospensione(a1);
        OF_TTM_Utils.getCausaleSospensione(a2);
        OF_TTM_Utils.getCausaleSospensione(a3);
        
        OF_TTM_Utils.getValueCausaleSospensione(s1);
        
        String e1 = 'SEDE OLO/CLIENTE FINALE INACCESSIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e1);
        
        String e2 = 'CLIENTE IRREPERIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e2);
        
        String e3 = 'CLIENTE INDISPONIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e3);
        
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(s1);
        
        String f1 = 'RISOLTO: TRATTA VERTICALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f1);
        
        String f2 = 'RISOLTO TRATTA ORIZZONTALE: CENTRALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f2);
        
        String f3 = 'RISOLTO TRATTA ORIZZONTALE: RETE PRIMARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f3);
        
        String f4 = 'RISOLTO TRATTA ORIZZONTALE: RETE SECONDARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f4);
        
        String f5 = 'NON RISCONTRATO: SENZA USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f5);
        
        String f6 = 'NON RISCONTRATO: CON USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f6);
        
        String f7 = 'RISOLTO: SBRACCIO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f7);
        
        String f8 = 'RISOLTO: BORCHIA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f8);
        
        String f9 = 'NON RISOLVIBILE: CAUSA IMPIANTO CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f9);
        
        String f10 = 'NON RISOLVIBILE: CAUSA CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f10);
        
        String f11 = 'RISOLTO OLO/CLIENTE: CONFIGURAZIONE CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f11);
        
        String f12 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f12);
        
        String f13 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f13);
        
        String f14 = 'RISOLTO OLO/CLIENTE: RESET CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f14);
        
        String f15 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE BRETELLA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f15);
        
        String f16 = 'RIBALTAMENTO EFFETTUATO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f16);
        
        String f17 = 'Non Risolvibile: Problemi Di Rete OLO (Es. Problema di Scheda In Centrale OLO, Problema Di Configurazione OLO)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f17);
        
        String f18 = 'Non Risolvibile: Problemi Di Rete Cliente (Es. Wi-Fi Poco Performante Causa Disposizione Casa Cliente, Configurazione PC)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f18);
        
        String f19 = 'RISOLTO MEDIANTE INTERVENTO CONGIUNTO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f19);
        
        String f20 = 'CHIUSO PER TIMEOUT_OK';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f20);
        
        OF_TTM_Utils.updateSlPortale(eaiLog1,c);
        
        OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom('CODICE_COMUNICAZIONE_OLO');
        
        String sla_assurance = 'Y';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance);
        String sla_assurance1 = 'X';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance1);
        
        String rtDevName = 'OF_GPONPassiva';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName);
        String rtDevName1 = 'OF_OpenStream';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName1);
        String rtDevName2 = 'Test';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName2);
        
        OF_TTM_Utils.copy_TT_TTMRequest(eaiLog1);
        
        OF_TTM_Utils.checkAsset = true;
        OF_TTM_Utils.createTTRequestLogSFTTM(eaiLog1,astList,c,'tipo_comunicazione');
        
        OF_TTM_Utils.copy_TT_OLONotify(eaiLog1,'tipo_comunicazione');
        
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        eaiLog1.EOF_Note__c = 'Test';
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog2.EOF_Codice_Operatore__c = 'TIS';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog2.EOF_PROFILO__c = 'AG_11_36';
        eaiLog2.EOF_PROMOZIONE__c = '020103';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog2.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog2.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog2.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog2.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog2.Causale_Scarto__c = 'Test';
        eaiLog2.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog2.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog2.EOF_Referente_desospensione__c = 'Test';
        eaiLog2.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog2.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog2.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog2.EOF_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog2;
        
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');

        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        OF_TTM_Utils.createNotifyCalloutToOLO(eaiLog1,'tipo_comunicazione');
        Test.stopTest();
        
    }
    
    public static testmethod void Method6(){
        
        OF_TTM_Utils util = new OF_TTM_Utils();
                
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        tt.NOTE = 'Test';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        map<string,string> mps = new map<string,string>();
		mps.put('Type','TT_ACK');
        
        map<string,string> mps2 = new map<string,string>();
		mps2.put('Type','TT_NACK');
        
        map<string,string> mps3 = new map<string,string>();
		mps3.put('Type','Trouble Ticket - Richiesta Scartata');
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = tt.CODICE_COMUNICAZIONE_OLO;
        insert c;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'In Inserimento';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Codice_Comunicazione_OLO__c='Test';
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        nGPON.EOF_Codice_Comunicazione_OLO__c=nGPON.EOF_Codice_Comunicazione_OLO__c;
        insert nGPON;
        
        OF_TTM_Utils.setNotify(nGPON);
        OF_TTM_Utils.getNotify();

        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - TT - TroubleTicketRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c = 'In Inserimento';
        insert eaiLog;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        List<Asset> astList = new List<Asset>();
        Asset ast = new Asset();
        ast.Name= eaiLog1.EOF_Id_Risorsa__c;
        ast.Status = 'Attivo';
        ast.EOF_ID_Risorsa__c = 'Test';
        ast.AccountId = accOLO.Id;  
        insert ast;
        astList.add(ast);
        
        OF_TTM_Utils.create_EAI_Log(tt);
        eaiLog1.EOF_NOTE__c = '';
        OF_TTM_Utils.create_EAI_Log(tt);
        OF_TTM_Utils.create_EAI_Log(mps);
        OF_TTM_Utils.create_EAI_Log(mps2);
        OF_TTM_Utils.create_EAI_Log(mps3);
        
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE name='DAC'];
        boolean b = BusinessHours.isWithin(bh.id, OF_TTM_Utils.now());
        boolean premium = True;
        OF_TTM_Utils.calcoloSLA(premium);
        
        OF_TTM_Utils.copy_TT_request(tt);
        
        OF_TTM_Utils.dateToString(System.today());
        
        OF_TTM_Utils.stringToDate('2018-07-19T13:00:00+01:00');
        
        OF_TTM_Utils.stringToDateNoTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.stringToDateNoTime('');
        String S = '2018-07-19';
        OF_TTM_Utils.checkDate(s);
        
        String S1 = '';
        OF_TTM_Utils.checkDate(s1);
        
        String S2 = 'Test';
        OF_TTM_Utils.checkDate(s2);
        
        OF_TTM_Utils.checkTime('11:11:11');
        OF_TTM_Utils.checkTime(' ');
        OF_TTM_Utils.checkTime(null);
        OF_TTM_Utils.checkTime('11:11:oo');
        
        OF_TTM_Utils.checkDateTime('');
        OF_TTM_Utils.checkDateTime(null);
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:00');
        OF_TTM_Utils.checkDateTime('2018-07-19T13:00:00+01:000');
        
        OF_TTM_Utils.now();
        
        String a = '';
        OF_TTM_Utils.getStringTipoComunicazione(a);
        
        String a1 = '1';
        OF_TTM_Utils.getStringTipoComunicazione(a1);
        
        String a2 = '2';
        OF_TTM_Utils.getStringTipoComunicazione(a2);
        
        String a3 = '3';
        OF_TTM_Utils.getStringTipoComunicazione(a3);
        
        String a4 = '4';
        OF_TTM_Utils.getStringTipoComunicazione(a4);
        
        String a5 = '5';
        OF_TTM_Utils.getStringTipoComunicazione(a5);
        
        String a6 = '6';
        OF_TTM_Utils.getStringTipoComunicazione(a6);
        
        String a7 = '7';
        OF_TTM_Utils.getStringTipoComunicazione(a7);
        
        String a8 = '8';
        OF_TTM_Utils.getStringTipoComunicazione(a8);
        
        String a9 = '9';
        OF_TTM_Utils.getStringTipoComunicazione(a9);
        
        String a10 = '10';
        OF_TTM_Utils.getStringTipoComunicazione(a10);
        
        String a11 = '11';
        OF_TTM_Utils.getStringTipoComunicazione(a11);
        
        String a12 = '12';
        OF_TTM_Utils.getStringTipoComunicazione(a12);
        
        String a13 = '13';
        OF_TTM_Utils.getStringTipoComunicazione(a13);
        
        String a20 = '20';
        OF_TTM_Utils.getStringTipoComunicazione(a20);
        
        String a21 = '21';
        OF_TTM_Utils.getStringTipoComunicazione(a21);
        
        String a99 = '99';
        OF_TTM_Utils.getStringTipoComunicazione(a99);
        
        String b1 = '';
        OF_TTM_Utils.getValueTipoComunicazione(b1);
        
        String b2 = 'Notifica Scarto';
        OF_TTM_Utils.getValueTipoComunicazione(b2);
        
        String b5 = 'Notifica Richiesta Chiusura';
        OF_TTM_Utils.getValueTipoComunicazione(b5);
        
        String b3 = 'Notifica Presa in Carico';
        OF_TTM_Utils.getValueTipoComunicazione(b3);
        
        String b4 = 'Notifica Sospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b4);
        
        String b7 = 'Notifica Desospensione';
        OF_TTM_Utils.getValueTipoComunicazione(b7);
        
        String b10 = 'Notifica Annullamento';
        OF_TTM_Utils.getValueTipoComunicazione(b10);
        
        String b13 = 'Notifica Timeout OK';
        OF_TTM_Utils.getValueTipoComunicazione(b13);
        
        String b21 = 'Notifica Aggiornamento Dati';
        OF_TTM_Utils.getValueTipoComunicazione(b21);
        
        OF_TTM_Utils.getStringCategoriaGuasto(s1);
        String a0 = '0';
        OF_TTM_Utils.getStringCategoriaGuasto(a0);
        OF_TTM_Utils.getStringCategoriaGuasto(a1);
        OF_TTM_Utils.getStringCategoriaGuasto(a2);
        
        OF_TTM_Utils.getStringCausaleDesospensione(s1);
        OF_TTM_Utils.getStringCausaleDesospensione(a2);
        OF_TTM_Utils.getStringCausaleDesospensione(a3);
        
        OF_TTM_Utils.getStringCausaleApertura(s1);
        OF_TTM_Utils.getStringCausaleApertura(a1);
        OF_TTM_Utils.getStringCausaleApertura(a2);
        OF_TTM_Utils.getStringCausaleApertura(a3);
        OF_TTM_Utils.getStringCausaleApertura(a4);
        
        OF_TTM_Utils.getValueStatoTicket(s1);
        
        String c1 = 'Scartato';
        OF_TTM_Utils.getValueStatoTicket(c1);
        
        String c2 = 'In Lavorazione';
        OF_TTM_Utils.getValueStatoTicket(c2);
        
        String c3 = 'Sospeso';
        OF_TTM_Utils.getValueStatoTicket(c3);
        
        String c4 = 'Chiuso';
        OF_TTM_Utils.getValueStatoTicket(c4);
        
        String c5 = 'Annullato';
        OF_TTM_Utils.getValueStatoTicket(c5);
        
        String c6 = 'Richiesta Chiusura';
        OF_TTM_Utils.getValueStatoTicket(c6);
        
        OF_TTM_Utils.getValueCausaleScarto(s1);
        
        String d1 = 'Formato dati errato o incompleto';
        OF_TTM_Utils.getValueCausaleScarto(d1);
        
        String d2 = 'Ticket aperto per stesso ID risorsa';
        OF_TTM_Utils.getValueCausaleScarto(d2);
        
        String d3 = 'ID Risorsa Inesistente';
        OF_TTM_Utils.getValueCausaleScarto(d3);
        
        String d4 = 'Codice Comunicazione OLO già presente';
        OF_TTM_Utils.getValueCausaleScarto(d4);
        
        String d5 = 'Guasto Aperto come Post-Provisioning oltre i termini previsti';
        OF_TTM_Utils.getValueCausaleScarto(d5);
        
        OF_TTM_Utils.getCausaleSospensione(s1);
        OF_TTM_Utils.getCausaleSospensione(a1);
        OF_TTM_Utils.getCausaleSospensione(a2);
        OF_TTM_Utils.getCausaleSospensione(a3);
        
        OF_TTM_Utils.getValueCausaleSospensione(s1);
        
        String e1 = 'SEDE OLO/CLIENTE FINALE INACCESSIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e1);
        
        String e2 = 'CLIENTE IRREPERIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e2);
        
        String e3 = 'CLIENTE INDISPONIBILE';
        OF_TTM_Utils.getValueCausaleSospensione(e3);
        
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(s1);
        
        String f1 = 'RISOLTO: TRATTA VERTICALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f1);
        
        String f2 = 'RISOLTO TRATTA ORIZZONTALE: CENTRALE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f2);
        
        String f3 = 'RISOLTO TRATTA ORIZZONTALE: RETE PRIMARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f3);
        
        String f4 = 'RISOLTO TRATTA ORIZZONTALE: RETE SECONDARIA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f4);
        
        String f5 = 'NON RISCONTRATO: SENZA USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f5);
        
        String f6 = 'NON RISCONTRATO: CON USCITA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f6);
        
        String f7 = 'RISOLTO: SBRACCIO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f7);
        
        String f8 = 'RISOLTO: BORCHIA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f8);
        
        String f9 = 'NON RISOLVIBILE: CAUSA IMPIANTO CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f9);
        
        String f10 = 'NON RISOLVIBILE: CAUSA CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f10);
        
        String f11 = 'RISOLTO OLO/CLIENTE: CONFIGURAZIONE CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f11);
        
        String f12 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE CPE CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f12);
        
        String f13 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f13);
        
        String f14 = 'RISOLTO OLO/CLIENTE: RESET CPE/ONT CLIENTE';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f14);
        
        String f15 = 'RISOLTO OLO/CLIENTE: SOSTITUZIONE BRETELLA OTTICA';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f15);
        
        String f16 = 'RIBALTAMENTO EFFETTUATO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f16);
        
        String f17 = 'Non Risolvibile: Problemi Di Rete OLO (Es. Problema di Scheda In Centrale OLO, Problema Di Configurazione OLO)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f17);
        
        String f18 = 'Non Risolvibile: Problemi Di Rete Cliente (Es. Wi-Fi Poco Performante Causa Disposizione Casa Cliente, Configurazione PC)';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f18);
        
        String f19 = 'RISOLTO MEDIANTE INTERVENTO CONGIUNTO';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f19);
        
        String f20 = 'CHIUSO PER TIMEOUT_OK';
        OF_TTM_Utils.getValueDescrizioneInterventoRisoluzione(f20);
        
        OF_TTM_Utils.updateSlPortale(eaiLog1,c);
        
        OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom('CODICE_COMUNICAZIONE_OLO');
        
        String sla_assurance = 'Y';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance);
        String sla_assurance1 = 'X';
        OF_TTM_Utils.getSLATypeFromEOF_SLA_Premium_Assurance(sla_assurance1);
        
        String rtDevName = 'OF_GPONPassiva';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName);
        String rtDevName1 = 'OF_OpenStream';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName1);
        String rtDevName2 = 'Test';
        OF_TTM_Utils.getServiceTypeFromRTDevName(rtDevName2);
        
        OF_TTM_Utils.copy_TT_TTMRequest(eaiLog1);
        
        OF_TTM_Utils.checkAsset = true;
        OF_TTM_Utils.createTTRequestLogSFTTM(eaiLog1,astList,c,'tipo_comunicazione');
        
        OF_TTM_Utils.copy_TT_OLONotify(eaiLog1,'tipo_comunicazione');
        
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        eaiLog1.EOF_Note__c = 'Test';
        OF_TTM_Utils.createRequestNotifyLogSFOLO(eaiLog1,'tipo_comunicazione');
        
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '123456';
        
        eaiLog2.EOF_Codice_Operatore__c = 'TIS';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog2.EOF_PROFILO__c = 'AG_11_36';
        eaiLog2.EOF_PROMOZIONE__c = '020103';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog2.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog2.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog2.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog2.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog2.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog2.Causale_Scarto__c = 'Test';
        eaiLog2.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog2.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog2.EOF_Referente_desospensione__c = 'Test';
        eaiLog2.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog2.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog2.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog2.EOF_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog2.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog2;

        OF_TTM_Utils.sLogOLOSF = eaiLog1;
        OF_TTM_Utils.syncError(tt,'A_K9','fieldName');
        OF_TTM_Utils.syncError(tt,'A_K10','fieldName');
        OF_TTM_Utils.syncError(tt,'A_K11','fieldName');
        OF_TTM_Utils.syncError(tt,'A_K8','fieldName');
        
    }
 
}
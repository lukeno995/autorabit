@istest
public class OF_SA_WS_OM_Activation_Test {
    static testmethod void testMethod1()
    {
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - FiberRequest', null);
        
        
        String endpoint_x = 'https://ofs-svil-ws.enel.com:44300/OrderManagement/RequestServiziAttivi/GW_ActivationOpenStream';
        
        String[] ns_map_type_info = new String[]{'http://xmlns.enel.it/OLO_Gatway/wsdl/concrete/OrderManagement/ServiziAttivi/AttivazioneGpona', 'OF_SA_WS_OM_Activation', 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon', 'OF_SA_WS_OM_Classi', 'http://enel.it/schemas/class/ServiziAttivi/Esito', 'OF_SA_WS_OM_Response'};
            list<EOF_EAI_Service_Log__c> eoflst = new list<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        
        eof.EOF_CODICE_OPERATORE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_CODICE_ORDINE_OLO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_CODICE_ORDINE_EOF__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        string str = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_Tipo_Comunicazione_String__C = 'SF->OLO - StatusUpdate';
        eof.EOF_CODICE_MOTIVAZIONE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_MOTIVAZIONE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_GPON_Attestazione__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato';
        eof.EOF_NOME_CLIENTE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_COGNOME_CLIENTE__c='http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_NOTE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_ID_RISORSA__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_TIPO_COMUNICAZIONE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_SORGENTE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_SLA_DATE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine'; 
        eof.EOF_GPON_VINCOLANTE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_OPZIONE_SYSTEM_UNICO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_COLLEGAMENTO_P2P__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_TRACCIATO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_ID_SERVIZIO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_PROFILO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_Provincia__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_Comune__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_Indirizzo__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione'; 
        eof.EOF_Numero_Civico__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eoflst.add(eof);
        insert eoflst;
        OF_SA_WS_OM_Classi.Disattivazione_element request_x = new OF_SA_WS_OM_Classi.Disattivazione_element();
        
        request_x.CODICE_OPERATORE=eoflst[0].EOF_CODICE_OPERATORE__c;
        request_x.CODICE_ORDINE_OLO=eoflst[0].EOF_CODICE_ORDINE_OLO__c;
        request_x.CODICE_ORDINE_OF=eoflst[0].EOF_CODICE_ORDINE_EOF__c;
        request_x.DATA_NOTIFICA=OF_SA_GE_Utils.DateToString(eoflst[0].EOF_DATA_NOTIFICA__c);
        request_x.ID_NOTIFICA=eoflst[0].EOF_ID_NOTIFICA__c;
        request_x.CODICE_MOTIVAZIONE=eoflst[0].EOF_CODICE_MOTIVAZIONE__c;
        request_x.MOTIVAZIONE=eoflst[0].EOF_MOTIVAZIONE__c;
        request_x.GPON_ATTESTAZIONE=eoflst[0].EOF_GPON_Attestazione__c;
        request_x.NOME_CLIENTE=eoflst[0].EOF_NOME_CLIENTE__c;
        request_x.COGNOME_CLIENTE=eoflst[0].EOF_COGNOME_CLIENTE__c;
        request_x.RECAPITO_TELEFONICO_CLIENTE_1=eoflst[0].EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
        request_x.RECAPITO_TELEFONICO_CLIENTE_2=eoflst[0].EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
        request_x.NOTE=eoflst[0].EOF_NOTE__c;
        request_x.ID_RISORSA=eoflst[0].EOF_ID_RISORSA__c ;
        request_x.TIPO_COMUNICAZIONE=eoflst[0].EOF_TIPO_COMUNICAZIONE__c ;
        request_x.SORGENTE=eoflst[0].EOF_SORGENTE__c ;
        request_x.SLA_DATE=eoflst[0].EOF_SLA_DATE__c ; 
        request_x.GPON_Vincolante=eoflst[0].EOF_GPON_VINCOLANTE__c ;
        request_x.Opzione_System_Unico=eoflst[0].EOF_OPZIONE_SYSTEM_UNICO__c ;
        request_x.Collegamento_P2P=eoflst[0].EOF_COLLEGAMENTO_P2P__c ;
        request_x.TRACCIATO=eoflst[0].EOF_TRACCIATO__c ;
        request_x.ID_SERVIZIO=eoflst[0].EOF_ID_SERVIZIO__c ;
        request_x.PROFILO=eoflst[0].EOF_PROFILO__c ;
        request_x.Provincia=eoflst[0].EOF_Provincia__c ;
        request_x.Comune=eoflst[0].EOF_Comune__c;
        //request_x.Particella_Toponomastica=sl.EOF_Particella_Toponomastica__c ;
        request_x.Indirizzo=eoflst[0].EOF_Indirizzo__c ; 
        request_x.Numero_Civico=eoflst[0].EOF_Numero_Civico__c ; 
        
        OF_SA_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());	
        OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint agp = new OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint();
        agp.ActivationOpenStreamOM(TestDataFactory.ESlog);
        
        test.stopTest();
        
    }
    
    static testmethod void testmethod2()
    {

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - FiberRequest', null);

        String endpoint_x = 'https://ofs-svil-ws.enel.com:44300/OrderManagement/RequestServiziAttivi/GW_ActivationOpenStream';
        
        String[] ns_map_type_info = new String[]{'http://xmlns.enel.it/OLO_Gatway/wsdl/concrete/OrderManagement/ServiziAttivi/AttivazioneGpona', 'OF_SA_WS_OM_Activation', 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon', 'OF_SA_WS_OM_Classi', 'http://enel.it/schemas/class/ServiziAttivi/Esito', 'OF_SA_WS_OM_Response'};
            list<EOF_EAI_Service_Log__c> eoflst = new list<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        id rt = [select id from recordtype where sobjecttype='EOF_EAI_Service_Log__c' and developername='OF_SA_Cpe'].id;
        eof.RecordTypeId = rt;
        eof.EOF_CODICE_OPERATORE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_CODICE_ORDINE_OLO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_CODICE_ORDINE_EOF__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        string str = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_Tipo_Comunicazione_String__C = 'SF->OLO - StatusUpdate';
        eof.EOF_CODICE_MOTIVAZIONE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_MOTIVAZIONE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_GPON_Attestazione__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato';
        eof.EOF_NOME_CLIENTE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_COGNOME_CLIENTE__c='http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_NOTE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_ID_RISORSA__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_TIPO_COMUNICAZIONE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_SORGENTE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_SLA_DATE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine'; 
        eof.EOF_GPON_VINCOLANTE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_OPZIONE_SYSTEM_UNICO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_COLLEGAMENTO_P2P__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_TRACCIATO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_ID_SERVIZIO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_PROFILO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_Provincia__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_Comune__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_Indirizzo__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione'; 
        eof.EOF_Numero_Civico__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        insert eof;
        
        
        OF_SA_WS_OM_Classi.Disattivazione_element request_x = new OF_SA_WS_OM_Classi.Disattivazione_element();
        
        request_x.CODICE_OPERATORE=eof.EOF_CODICE_OPERATORE__c;
        request_x.CODICE_ORDINE_OLO=eof.EOF_CODICE_ORDINE_OLO__c;
        request_x.CODICE_ORDINE_OF=eof.EOF_CODICE_ORDINE_EOF__c;
        request_x.DATA_NOTIFICA=OF_SA_GE_Utils.DateToString(eof.EOF_DATA_NOTIFICA__c);
        request_x.ID_NOTIFICA=eof.EOF_ID_NOTIFICA__c;
        request_x.CODICE_MOTIVAZIONE=eof.EOF_CODICE_MOTIVAZIONE__c;
        request_x.MOTIVAZIONE=eof.EOF_MOTIVAZIONE__c;
        request_x.GPON_ATTESTAZIONE=eof.EOF_GPON_Attestazione__c;
        request_x.NOME_CLIENTE=eof.EOF_NOME_CLIENTE__c;
        request_x.COGNOME_CLIENTE=eof.EOF_COGNOME_CLIENTE__c;
        request_x.RECAPITO_TELEFONICO_CLIENTE_1=eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
        request_x.RECAPITO_TELEFONICO_CLIENTE_2=eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
        request_x.NOTE=eof.EOF_NOTE__c;
        request_x.ID_RISORSA=eof.EOF_ID_RISORSA__c ;
        request_x.TIPO_COMUNICAZIONE=eof.EOF_TIPO_COMUNICAZIONE__c ;
        request_x.SORGENTE=eof.EOF_SORGENTE__c ;
        request_x.SLA_DATE=eof.EOF_SLA_DATE__c ; 
        request_x.GPON_Vincolante=eof.EOF_GPON_VINCOLANTE__c ;
        request_x.Opzione_System_Unico=eof.EOF_OPZIONE_SYSTEM_UNICO__c ;
        request_x.Collegamento_P2P=eof.EOF_COLLEGAMENTO_P2P__c ;
        request_x.TRACCIATO=eof.EOF_TRACCIATO__c ;
        request_x.ID_SERVIZIO=eof.EOF_ID_SERVIZIO__c ;
        request_x.PROFILO=eof.EOF_PROFILO__c ;
        request_x.Provincia=eof.EOF_Provincia__c ;
        request_x.Comune=eof.EOF_Comune__c;
        //request_x.Particella_Toponomastica=sl.EOF_Particella_Toponomastica__c ;
        request_x.Indirizzo=eof.EOF_Indirizzo__c ; 
        request_x.Numero_Civico=eof.EOF_Numero_Civico__c ; 
        EOF_EAI_Service_Log__c eof1 = new EOF_EAI_Service_Log__c();
        id rt1 = [select id from recordtype where sobjecttype='EOF_EAI_Service_Log__c' and developername='OF_SA_Servizi_Aggiuntivi'].id;
        eof1.RecordTypeId = rt1;
        eof1.OF_SA_VLan_Log__c = eof.id;
        eof1.OF_SA_Servizi_Aggiuntivi_Log__c = eof.id;
        eof1.OF_SA_Cpe_Log__c = eof.id;
        eoflst.add(eof1);
        
        EOF_EAI_Service_Log__c eof2 = new EOF_EAI_Service_Log__c();
        id rt2 = [select id from recordtype where sobjecttype='EOF_EAI_Service_Log__c' and developername='OF_SA_Vlan'].id;
        eof2.RecordTypeId = rt2;
        eof2.OF_SA_VLan_Log__c = eof.id;
        eof2.OF_SA_Servizi_Aggiuntivi_Log__c = eof.id;
        eof2.OF_SA_Cpe_Log__c = eof.id;
        eoflst.add(eof2);
        insert eoflst;
        list<EOF_EAI_Service_Log__c> vlst = [select Id,recordtype.name,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_TIPOLOGIA_APPARATO__C,
                                             OF_SA_PASSWORD_APPARATO__C,OF_SA_AZIONE_APPARATO__C,OF_SA_KIT_CONSEGNA_VLAN__C, OF_SA_USER_VLAN__C,OF_SA_SERVICE_VLAN__C,
                                             OF_SA_PROFILO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__C,OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C from EOF_EAI_Service_Log__C
                                             where OF_SA_VLan_Log__c=:eof.Id OR OF_SA_Servizi_Aggiuntivi_Log__c=:eof.Id OR OF_SA_Cpe_Log__c=:eof.Id];
        system.debug('eoflst------>'+eoflst);
        system.debug('vlst------>'+vlst);
        
        OF_SA_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint agp = new OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint();
        agp.ActivationOpenStreamOM(eoflst);
        
        test.stopTest();    }
    
    static testmethod void testmethod3()
    {

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - FiberRequest', null);

        String endpoint_x = 'https://ofs-svil-ws.enel.com:44300/NotifyServiziAttivi/OF_StatusUpdate';
        String[] ns_map_type_info = new String[]{'http://enel.it/schemas/class/ServiziAttivi/Esito', 'OF_SA_WS_OLO_Response', 'http://enel.it/schemas/class/ServiziAttivi/NotificaAggiornamentoStato', 'OF_SA_WS_OLO_Classi', 'http://xmlns.enel.it/OLO_Gatway/wsdl/concrete/ServiziAttivi/NotifyAggiornaStato', 'OF_SA_WS_OLO_StatusUpdate'};
            list<EOF_EAI_Service_Log__c> eoflst = new list<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        id rt = [select id from recordtype where sobjecttype='EOF_EAI_Service_Log__c' and developername='OF_SA_Servizi_Aggiuntivi'].id;
        eof.RecordTypeId = rt;
        eof.EOF_CODICE_OPERATORE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_CODICE_ORDINE_OLO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_CODICE_ORDINE_EOF__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        string str = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_Tipo_Comunicazione_String__C = 'SF->OLO - StatusUpdate';
        eof.EOF_CODICE_MOTIVAZIONE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_MOTIVAZIONE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_GPON_Attestazione__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato';
        eof.EOF_NOME_CLIENTE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_COGNOME_CLIENTE__c='http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_NOTE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_ID_RISORSA__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_TIPO_COMUNICAZIONE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_SORGENTE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_SLA_DATE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine'; 
        eof.EOF_GPON_VINCOLANTE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_OPZIONE_SYSTEM_UNICO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_COLLEGAMENTO_P2P__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_TRACCIATO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_ID_SERVIZIO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_PROFILO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_Provincia__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_Comune__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof.EOF_Indirizzo__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione'; 
        eof.EOF_Numero_Civico__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        insert eof;
        
        EOF_EAI_Service_Log__c eof1 = new EOF_EAI_Service_Log__c();
        id rt1 = [select id from recordtype where sobjecttype='EOF_EAI_Service_Log__c' and developername='OF_SA_Vlan'].id;
        eof1.RecordTypeId = rt1;
        eof1.EOF_CODICE_OPERATORE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_CODICE_ORDINE_OLO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof1.EOF_CODICE_ORDINE_EOF__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        //string str = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof1.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof1.EOF_Tipo_Comunicazione_String__C = 'CPE';
        eof1.EOF_CODICE_MOTIVAZIONE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof1.EOF_MOTIVAZIONE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof1.EOF_GPON_Attestazione__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato';
        eof1.EOF_NOME_CLIENTE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof1.EOF_COGNOME_CLIENTE__c='http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_NOTE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_ID_RISORSA__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_TIPO_COMUNICAZIONE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_SORGENTE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_SLA_DATE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine'; 
        eof1.EOF_GPON_VINCOLANTE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_OPZIONE_SYSTEM_UNICO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_COLLEGAMENTO_P2P__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_TRACCIATO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_ID_SERVIZIO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof1.EOF_PROFILO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof1.EOF_Provincia__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof1.EOF_Comune__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof1.EOF_Indirizzo__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione'; 
        eof1.EOF_Numero_Civico__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof1.OF_SA_VLan_Log__c = eof.id;
        eof1.OF_SA_Servizi_Aggiuntivi_Log__c = eof.id;
        eof1.OF_SA_Cpe_Log__c = eof.id;
        eoflst.add(eof1);
        
        EOF_EAI_Service_Log__c eof2 = new EOF_EAI_Service_Log__c();
        id rt2 = [select id from recordtype where sobjecttype='EOF_EAI_Service_Log__c' and developername='OF_SA_Cpe'].id;
        eof2.RecordTypeId = rt2;
        eof2.EOF_CODICE_OPERATORE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_CODICE_ORDINE_OLO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof2.EOF_CODICE_ORDINE_EOF__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        //string str = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof2.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof2.EOF_Tipo_Comunicazione_String__C = 'VLAN';
        eof2.EOF_CODICE_MOTIVAZIONE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof2.EOF_MOTIVAZIONE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof2.EOF_GPON_Attestazione__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato';
        eof2.EOF_NOME_CLIENTE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof2.EOF_COGNOME_CLIENTE__c='http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_NOTE__c= 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_ID_RISORSA__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_TIPO_COMUNICAZIONE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_SORGENTE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_SLA_DATE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine'; 
        eof2.EOF_GPON_VINCOLANTE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_OPZIONE_SYSTEM_UNICO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_COLLEGAMENTO_P2P__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_TRACCIATO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_ID_SERVIZIO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof2.EOF_PROFILO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof2.EOF_Provincia__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof2.EOF_Comune__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof2.EOF_Indirizzo__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione'; 
        eof2.EOF_Numero_Civico__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione';
        eof2.OF_SA_VLan_Log__c = eof.id;
        eof2.OF_SA_Servizi_Aggiuntivi_Log__c = eof.id;
        eof2.OF_SA_Cpe_Log__c = eof.id;
        eoflst.add(eof2);
        insert eoflst;
        
        OF_SA_WS_OM_Classi.Disattivazione_element request_x = new OF_SA_WS_OM_Classi.Disattivazione_element();
        
        request_x.CODICE_OPERATORE=eoflst[0].EOF_CODICE_OPERATORE__c;
        request_x.CODICE_ORDINE_OLO=eoflst[0].EOF_CODICE_ORDINE_OLO__c;
        request_x.CODICE_ORDINE_OF=eoflst[0].EOF_CODICE_ORDINE_EOF__c;
        request_x.DATA_NOTIFICA=OF_SA_GE_Utils.DateToString(eoflst[0].EOF_DATA_NOTIFICA__c);
        request_x.ID_NOTIFICA=eoflst[0].EOF_ID_NOTIFICA__c;
        request_x.CODICE_MOTIVAZIONE=eoflst[0].EOF_CODICE_MOTIVAZIONE__c;
        request_x.MOTIVAZIONE=eoflst[0].EOF_MOTIVAZIONE__c;
        request_x.GPON_ATTESTAZIONE=eoflst[0].EOF_GPON_Attestazione__c;
        request_x.NOME_CLIENTE=eoflst[0].EOF_NOME_CLIENTE__c;
        request_x.COGNOME_CLIENTE=eoflst[0].EOF_COGNOME_CLIENTE__c;
        request_x.RECAPITO_TELEFONICO_CLIENTE_1=eoflst[0].EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
        request_x.RECAPITO_TELEFONICO_CLIENTE_2=eoflst[0].EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
        request_x.NOTE=eoflst[0].EOF_NOTE__c;
        request_x.ID_RISORSA=eoflst[0].EOF_ID_RISORSA__c ;
        request_x.TIPO_COMUNICAZIONE=eoflst[0].EOF_TIPO_COMUNICAZIONE__c ;
        request_x.SORGENTE=eoflst[0].EOF_SORGENTE__c ;
        request_x.SLA_DATE=eoflst[0].EOF_SLA_DATE__c ; 
        request_x.GPON_Vincolante=eoflst[0].EOF_GPON_VINCOLANTE__c ;
        request_x.Opzione_System_Unico=eoflst[0].EOF_OPZIONE_SYSTEM_UNICO__c ;
        request_x.Collegamento_P2P=eoflst[0].EOF_COLLEGAMENTO_P2P__c ;
        request_x.TRACCIATO=eoflst[0].EOF_TRACCIATO__c ;
        request_x.ID_SERVIZIO=eoflst[0].EOF_ID_SERVIZIO__c ;
        request_x.PROFILO=eoflst[0].EOF_PROFILO__c ;
        request_x.Provincia=eoflst[0].EOF_Provincia__c ;
        request_x.Comune=eoflst[0].EOF_Comune__c;
        //request_x.Particella_Toponomastica=sl.EOF_Particella_Toponomastica__c ;
        request_x.Indirizzo=eoflst[0].EOF_Indirizzo__c ; 
        request_x.Numero_Civico=eoflst[0].EOF_Numero_Civico__c ;
        
        OF_SA_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c(); 
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint agp = new OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint();
        agp.ActivationOpenStreamOM(eoflst);
        
        test.stopTest();    }
}
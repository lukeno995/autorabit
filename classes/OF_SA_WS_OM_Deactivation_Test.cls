@isTest
public class OF_SA_WS_OM_Deactivation_Test {
    
    public static testmethod void method1()
    {
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest',null);
        
        String endpoint_x = 'https://ofs-svil-ws.enel.com:44300/OrderManagement/RequestServiziAttivi/GW_DeactivationOrder';
        String[] ns_map_type_info = new String[]{'http://xmlns.enel.it/OLO_Gatway/wsdl/concrete/OrderManagement/ServiziAttivi/DisattivazioneOrdine', 'OF_SA_WS_OM_Deactivation', 'http://enel.it/schemas/class/ServiziAttivi/Esito', 'OF_SA_WS_OM_Response', 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine', 'OF_SA_WS_OM_Classi'};
        list<EOF_EAI_Service_Log__c> eoflst = new list<EOF_EAI_Service_Log__c>();
        
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.EOF_CODICE_OPERATORE__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine';
        eof.EOF_CODICE_ORDINE_OLO__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_CODICE_ORDINE_EOF__c = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        string str = 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon';
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_Tipo_Comunicazione_String__C = 'SF->OM - Deactivation';
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
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c ();
        OF_SA_GE_Utils.slSFOM.EOF_CODICE_ORDINE_OLO__c = 'NACKCESS';
        OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint method1 = new  OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint();
        method1.DeactivationOrderOM(TestDataFactory.ESlog);
        Test.stopTest(); 
        
    }
    
}
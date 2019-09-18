@isTest
public class OF_SA_WS_OM_StatusUpdate_Test {
    static testmethod void testMethod1()
    {

		TestDataFactory.CreateTestRecords(null, null, null);
        
        String endpoint_x = 'https://ofs-svil-ws.enel.com:44300/OrderManagement/RequestServiziAttivi/GW_Reschedule';
        String[] ns_map_type_info = new String[]{'http://xmlns.enel.it/OLO_Gatway/wsdl/concrete/OrderManagement/ServiziAttivi/Rischedulazione', 'OF_SA_WS_OM_Reschedule', 'http://enel.it/schemas/class/ServiziAttivi/Esito', 'OF_SA_WS_OM_Response', 'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione', 'OF_SA_WS_OM_Classi'};
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
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint Rischedulazione = new  OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        Rischedulazione.StatusUpdateOM(eof);
        test.stoptest();
    }  
}
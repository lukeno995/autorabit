@istest
global class AsyncOF_SA_WS_OM_RescheduleTest {
     global static testMethod void TestAsyncOF_SA_WS_OM_Deactivation(){
        AsyncOF_SA_WS_OM_Reschedule aObj = new AsyncOF_SA_WS_OM_Reschedule();
        AsyncOF_SA_WS_OM_Reschedule.AsyncRischedulazionePortTypeEndpoint bObj = new AsyncOF_SA_WS_OM_Reschedule.AsyncRischedulazionePortTypeEndpoint();
        
        Test.setMock(WebServiceMock.class, new AsyncOF_SA_WS_OM_Reschedule_Mockcls());
        
        Continuation cont = new Continuation(120);
        
         bObj.beginReschedule(cont,'String CODICE_OPERATORE','String CODICE_ORDINE_OLO',
                              'String DATA_NOTIFICA','String ID_NOTIFICA',
                              'String NOME_CLIENTE',
                              'String COGNOME_CLIENTE','String RECAPITO_TELEFONICO_CLIENTE_1',
                              'String RECAPITO_TELEFONICO_CLIENTE_2',
                              'String DATA_PREVISTA_ATTIVAZIONE','String ORARIO_APPUNTAMENTO',
                              'String NOTE',
                              'String CODICE_MOTIVAZIONE','String MOTIVAZIONE',
                              'String TIPO_COMUNICAZIONE','String SORGENTE',
                              'String CODICE_ORDINE_OF','String SLA_DATE',
                              'String GPON_ATTESTAZIONE','String GPON_VINCOLANTE',
                              'String ID_RISORSA','String OPZIONE_SYSTEM_UNICO',
                              'String COLLEGAMENTO_P2P','String TRACCIATO',
                              'String ID_SERVIZIO','String PROFILO',
                              'String PROVINCIA','String COMUNE',
                              'String INDIRIZZO','String NUMERO_CIVICO');
    }
    

}
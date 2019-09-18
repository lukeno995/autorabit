@isTest
global class AsyncOF_SA_WS_OM_StatusUpdate_Test{
    
    global static testMethod void AsyncOF_SA_WS_OM_StatusUpdateTest(){
        AsyncOF_SA_WS_OM_StatusUpdate aObj = new AsyncOF_SA_WS_OM_StatusUpdate();
        AsyncOF_SA_WS_OM_StatusUpdate.AsyncAggiornaStatoPortTypeEndpoint bObj = new AsyncOF_SA_WS_OM_StatusUpdate.AsyncAggiornaStatoPortTypeEndpoint();
        
        Test.setMock(WebServiceMock.class, new AsyncOF_SA_WS_OM_StatusUpdateMockCls());
        
        Continuation cont = new Continuation(120);
        
         bObj.beginStatusUpdateOM(cont,'String CODICE_OPERATORE','String CODICE_ORDINE_OLO','String DATA_NOTIFICA','String ID_NOTIFICA','String AZIONE','String CODICE_MOTIVAZIONE','String MOTIVAZIONE','String DATA_PREVISTA_ATTIVAZIONE','String ORARIO_APPUNTAMENTO','String NOME_CLIENTE','String COGNOME_CLIENTE','String RECAPITO_TELEFONICO_CLIENTE_1','String RECAPITO_TELEFONICO_CLIENTE_2','String NOTE','String TIPO_COMUNICAZIONE','String SORGENTE','String CODICE_ORDINE_OF','String SLA_DATE','String GPON_ATTESTAZIONE','String GPON_VINCOLANTE','String ID_RISORSA','String OPZIONE_SYSTEM_UNICO','String COLLEGAMENTO_P2P','String TRACCIATO','String ID_SERVIZIO','String PROFILO','String PROVINCIA','String COMUNE','String INDIRIZZO','String NUMERO_CIVICO') ;
           
         
    }
    
}
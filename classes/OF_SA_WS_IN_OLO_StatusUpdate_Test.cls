@isTest
public class OF_SA_WS_IN_OLO_StatusUpdate_Test {
    
    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
		
		for(RecordType rt: rtypes)
    		RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
    
   static testMethod void testOF_SA_WS_IN_OLO_StatusUpdate(){
			
			Map<String,String> RecordTypeMap = RecordType();
	           
            /**Account**/
            Account accOloWIND = new Account();       
            accOloWIND.Name = 'Wind';
            accOloWIND.EOF_Codice_Operatore__c = 'WN';
            accOloWIND.Type = 'OLO';
            accOloWIND.Industry = 'Telecommunications';
            accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
            insert accOloWIND;
            /**End Account**/
           
            /**Case**/
            Case c = new Case();
            c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
            c.EOF_Account_OLO__c = accOloWIND.id;
            c.EOF_Codice_Ordine_OLO__c = 'Test';
            c.status = 'Ricevuto';
            c.EOF_FASE__C = 'NA';
            insert c;
            /**End Case**/
       
            
       
            OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest RescheduleRequest = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
           
           
            RescheduleRequest.CODICE_ORDINE_OF = 'Test';
            RescheduleRequest.CODICE_OPERATORE = 'WN';
            RescheduleRequest.CODICE_ORDINE_OLO = 'Test';
            RescheduleRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            RescheduleRequest.ID_NOTIFICA = 'Test';
            RescheduleRequest.NOME_CLIENTE = 'Test';
            RescheduleRequest.COGNOME_CLIENTE = 'Test';
            RescheduleRequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
            RescheduleRequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
            RescheduleRequest.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
            RescheduleRequest.ORARIO_APPUNTAMENTO = 'Test';
            RescheduleRequest.NOTE = 'Test';
            RescheduleRequest.CODICE_MOTIVAZIONE = 'T'; 
            RescheduleRequest.MOTIVAZIONE = 'T';
            RescheduleRequest.AZIONE = '1';
       
           OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateResponse respnce =  new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateResponse();
           respnce.ID_NOTIFICA = 'test';
           respnce.ESITO = 'test';
           respnce.CODICE_MOTIVAZIONE = 'test'; 
           respnce.MOTIVAZIONE = 'test';
           
           Test.startTest();
           Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
           OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdate(RescheduleRequest);
           //OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(RescheduleRequest);
           Test.stopTest(); 
           
    }
    
    static testMethod void testOF_SA_WS_IN_OLO_StatusUpdate1(){
			
			OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest RescheduleRequest = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
           
           
            RescheduleRequest.CODICE_ORDINE_OF = 'Test';
            RescheduleRequest.CODICE_OPERATORE = 'WN';
            RescheduleRequest.CODICE_ORDINE_OLO = 'Test';
            RescheduleRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            RescheduleRequest.ID_NOTIFICA = 'Test';
            RescheduleRequest.NOME_CLIENTE = 'Test';
            RescheduleRequest.COGNOME_CLIENTE = 'Test';
            RescheduleRequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
            RescheduleRequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
            RescheduleRequest.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
            RescheduleRequest.ORARIO_APPUNTAMENTO = 'Test';
            RescheduleRequest.NOTE = 'Test';
            RescheduleRequest.CODICE_MOTIVAZIONE = 'T'; 
            RescheduleRequest.MOTIVAZIONE = 'T';
            RescheduleRequest.AZIONE = '1';
       
           OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateResponse respnce =  new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateResponse();
           respnce.ID_NOTIFICA = 'test';
           respnce.ESITO = 'test';
           respnce.CODICE_MOTIVAZIONE = 'test'; 
           respnce.MOTIVAZIONE = 'test';
           
           Test.startTest();
           Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
           OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdate(RescheduleRequest);
           //OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(RescheduleRequest);
           Test.stopTest(); 
           
    }

}
@isTest
public class OF_SA_WS_IN_OLO_Reschedule_Test 
{
    
    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
		
		for(RecordType rt: rtypes)
    		RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
    
    static testmethod void OF_SA_WS_IN_OLO_RescheduleTest()
    {
        
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
        
        
            OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RescheduleRequest = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
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
            RescheduleRequest.ORARIO_APPUNTAMENTO = '12345678';
            RescheduleRequest.NOTE = 'Test';
            RescheduleRequest.CODICE_MOTIVAZIONE = 'T'; 
            RescheduleRequest.MOTIVAZIONE = 'T';
            
            OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleResponse RescheduleResponse = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleResponse(); 
            RescheduleResponse.ID_NOTIFICA = 'T';
            RescheduleResponse.ESITO = '1';
            RescheduleResponse.CODICE_MOTIVAZIONE = 'T';
            RescheduleResponse.MOTIVAZIONE = 'T';
                       
            Test.startTest();
        	OF_CRMWorkAround.Esito = 0;
            Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
            OF_SA_WS_IN_OLO_Reschedule.OLO_Reschedule(RescheduleRequest);
            Test.stopTest();       
            
            
        }

}